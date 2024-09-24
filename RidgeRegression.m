%% Ridge Regression
% 20240922 
clear all;clc;clear all;close all;

%% Data Sets
DataX = [0 : pi/5: 2*pi];
DataY_Orig = sin(DataX);
% DataY = DataY_Orig + randi([-10 10], 1, length(DataX))/40;
DataY = [ 0.2250    0.3878    1.0761    1.2011    0.6378    0.1250  -0.6878   -0.9761   -1.1761   -0.6378   -0.0750 ];

% plot(DataX, DataY, 'o-')
% hold on
% plot(DataX, DataY_Orig, 'o-')
%% Test for Loop
Cnt = 1;
coeff = zeros(11,6);
TestOrder = 11;
TestLambda = 0;
% for TestOrder = 1:2:11
% for TestOrder = 9:2:15
for TestLambda = 0:0.004:0.02

%% Polynomial Fitting
% y =c1*x + c2*x^2 + c3*x^3 +c4*x^4 + .....
PolyOrder = TestOrder;
lambda = TestLambda;
A_Col = DataX.';
b_Col = DataY.';
A = A_Col;
for order = 2:1:PolyOrder
    A = [A A_Col.^order];
end

%coeff = A\b_Col;
coeff(1:PolyOrder,Cnt) = inv(A'*A + lambda*eye(PolyOrder))*(A'*b_Col)

%% Predict
Input = [0 : pi/50: 2*pi].';
PredictA = Input;
for order = 2:1:PolyOrder
    PredictA = [PredictA Input.^order];
end
PredictedY = PredictA*coeff(1:PolyOrder,Cnt);
residue(Cnt) = sum(abs(PredictedY - sin(Input)))
residue2(Cnt) = sum(abs(A*coeff(1:PolyOrder,Cnt) - DataY.'))

subplot(3,2,Cnt)
plot(Input, PredictedY, '.-', 'LineWidth', 2)
hold on
plot(Input, sin(Input), '--', 'LineWidth', 1, 'Color', 'black')
hold on
plot(DataX, DataY, '.', 'LineWidth', 1, 'MarkerSize',18, 'MarkerEdgeColor','red')
grid on

%% Test for Loop
Cnt =  Cnt + 1;
end

%% Plot Residule
figure
subplot(3,1,1)
plot([0:0.004:0.02], residue,  '.-', 'LineWidth', 2, 'MarkerSize',25, 'MarkerEdgeColor','blue')
grid on

subplot(3,1,2)
plot([0:0.004:0.02], residue2,  '.-', 'LineWidth', 2, 'MarkerSize',25, 'MarkerEdgeColor','blue')
grid on


%% Plot Coefficient Abs (sweep lambda)
subplot(3,1,3)
for cnt = 1:1:5
    plot([0:0.004:0.02], abs(coeff(cnt, :)),  '.-', 'LineWidth', 2, 'MarkerSize',15, 'MarkerEdgeColor','black')
    hold on
end
grid on

%% Plot Coefficient Abs (sweep order)
% subplot(3,1,3)
% plot([1:2:11], abs(coeff(1, :)),  '.-', 'LineWidth', 2, 'MarkerSize',15, 'MarkerEdgeColor','black')
% grid on

