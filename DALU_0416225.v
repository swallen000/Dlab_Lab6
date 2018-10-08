`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:57:24 11/17/2016 
// Design Name: 
// Module Name:    DLAU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DALU(
    // Input signals
	clk,
	rst,
	in_valid,
	instruction,
  // Output signals
  out_valid,
  out,a,b,c,d,e,count
    );
	 
input clk;
input rst;
input in_valid;
input [18:0]instruction;

output reg out_valid;
output reg signed [15:0]out;

output reg [2:0]a;
output reg signed [5:0]b;
output reg signed [5:0]c;
output reg signed [3:0]d;
output reg signed [9:0]e;
output reg count;


always@(posedge clk) begin
	if(rst)
		a<=0;
	else if(in_valid)
		a<=instruction[18:16];
	else
		a<=a;
end

always@(posedge clk) begin
	if(rst)
		b<=0;
	else begin
		if(in_valid)
			b<=instruction[15:10];
		else
			b<=b;
	end
end

always@(posedge clk) begin
	if(rst)
		c<=0;
	else begin
		if(in_valid)
			c<=instruction[9:4];
		else
			c<=c;
	end
end

always@(posedge clk) begin
	if(rst)
		d<=0;
	else begin
		if(in_valid)
			d<=instruction[3:0];
		else d<=d;
	end
end

always@(posedge clk) begin
	if(rst)
		e<=0;
	else begin
		if(in_valid) begin
				e<=instruction[9:0];
		end
		else
			e<=e;
	end
end

always@(posedge clk) begin
	if(rst)
		count<=0;
	else begin
		if(in_valid)
			count<=1;
		else 
			count<=0;
	end
end


always@(posedge clk) begin
	if(rst)
		out<=0;
	else begin
		if(count==1) begin
			if(a==0&&d==0)
				out<=b&c;
			else if(a==0&&d==1)
				out<=b|c;
			else if(a==0&&d==2)
				out<=b^c;
			else if(a==0&&d==3)
				out<=b+c;
			else if(a==0&&d==4)
				out<=b-c;
			else if(a==1)
				out<=b*c*d;
			else if(a==2)
				out<=(b+c+d)*(b+c+d);
			else if(a==3)
				out<=b+e;
			else if(a==4)
				out<=b-e;
			else
				out<=out;
		end
		else
			out<=out;
	end
end

always@(posedge clk) begin
	if(rst)
		out_valid<=0;
	else begin
		if(count==1)
			out_valid<=1;
		else
			out_valid<=0;
	end	
end	 
endmodule
