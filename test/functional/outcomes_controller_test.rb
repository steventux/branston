require 'test_helper'

class OutcomesControllerTest < ActionController::TestCase

  context "The OutcomesController" do
    context "when the user is not logged in" do
      [:index, :new, :edit].each do |action|
        context "on GET to #{action.to_s}" do
          setup do
            get action
          end

          should "redirect to login" do
            assert_redirected_to new_session_path
          end
        end
      end

      context "on PUT to :update" do
        setup do
          put :update
        end
        should "redirect to login" do
          assert_redirected_to new_session_path
        end
      end

      context "on POST to :create" do
        setup do
          post :create
        end
        should "redirect to login" do
          assert_redirected_to new_session_path
        end
      end
    end

    context "when the user is logged in" do
      setup do
        login_as(User.make)
        @scenario = Scenario.make
        @outcome = Outcome.make
      end

      should "show a list of all the outcomes" do
        get :index, :scenario_id => @scenario.id
        assert_response :success
        assert_not_nil assigns(:outcomes)
      end

      should "show a form to add stories" do
        get :new, :scenario_id => @scenario.id
        assert_response :success
      end

      context "creating an outcome" do
        context "with valid params" do
          setup do
            assert_difference('Outcome.count') do
              post :create, :outcome => { :description => "Foo" }, :scenario_id => @scenario.id
            end
          end

          should "redirect after creation" do
            assert_redirected_to outcome_path(assigns(:outcome))
          end

        end

        context "with invalid params" do
          setup do
            assert_no_difference('Outcome.count') do
              post :create, :outcome => { }, :scenario_id => @scenario.id
            end
          end

          should "redisplay" do
            assert_response :success
          end
        end
      end

      context "updating an outcome" do
        context "with valid params" do
          setup do
            put :update, :id => @outcome.to_param, :outcome => {:description =>  "bar" }, :scenario_id => @scenario.id
          end

          should "redirect after update" do
            assert_redirected_to outcome_path(assigns(:outcome))
          end
        end

        context "with invalid params" do
          setup do
            put :update, :id => @outcome.to_param, :outcome => {:description => "" }, :scenario_id => @scenario.id
          end

          should "redisplay" do
            assert_response :success
          end
        end
      end

      should "update outcome" do
        put :update, :id => @outcome.to_param, :outcome => { }, :scenario_id => @scenario.id
        assert_redirected_to outcome_path(assigns(:outcome))
      end

      should "show outcome" do
        get :show, :id => @outcome.to_param, :scenario_id => @scenario.id
        assert_response :success
      end

      should "get edit" do
        get :edit, :id => @outcome.to_param, :scenario_id => @scenario.id
        assert_response :success
      end


      should "destroy outcome" do
        assert_difference('Outcome.count', -1) do
          delete :destroy, :id => @outcome.to_param
        end

        assert_redirected_to outcomes_path
      end
    end
  end
end

