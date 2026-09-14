`timescale 1ns/1ps
module tb_mux_4x1;
  reg [3:0] i; reg [1:0] s; wire z; mux_4x1 dut(i,s,z);
  integer n,checked=0;
  reg [0:0] expected;
  initial begin
    $dumpfile("wave.vcd"); $dumpvars(0,tb_mux_4x1);

    for(n=0;n<64;n=n+1) begin
      {i,s}=n;
      expected=((n/4) >> (3-(n%4))) & 1;
      #10;
      if (z !== expected)
        $fatal(1,"FAIL mux_4x1 vector=%0d expected=%h actual=%h",n,expected,z);
      checked=checked+1;
    end
    if(checked!=64) $fatal(1,"Incomplete test");
    $display("LAB1_PASS mux_4x1 cases=%0d",checked);
    $finish;
  end
  initial begin #100000; $fatal(1,"Watchdog"); end
endmodule
