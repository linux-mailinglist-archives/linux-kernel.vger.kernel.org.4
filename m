Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA736F9AF2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 20:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjEGSef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 14:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjEGSe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 14:34:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104D912EAC;
        Sun,  7 May 2023 11:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96DF261C83;
        Sun,  7 May 2023 18:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71598C433A4;
        Sun,  7 May 2023 18:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683484462;
        bh=hMtC0Fu67Ii4QODNt4TY01t+H41Ind3v5j5PxzFdpSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ovLIV0PTmRvfxI7HsIK6QLdI/x4ljE/SK0Jg2V0ARdAGfrlS3CZilmQM/32IFMq+A
         WlVlZuEoJVqZXmqU32H/VXoJ7IgSCGhYaSPmBQ4G6to7lu1jUbM48S5Jq94ZUnHdYN
         Aom5m73N8SoJsLXA/Oacb9/iFWLLbrk1xoraF54lwTpU1Slo4FzdZF26p/Uc5TciBW
         YTVil1CUM66u7JlO854mFzcvOPMr7hJ63kK50wdlaP4HsDu0zXZeBFp8YV/CPaWAeB
         afmtA297pcCMApjOu2XVYeuJ9e0ILPeS8I+kpIM2V2DKlaTjJb3uFBHawQEdHztZ+O
         X2txNSRdBNT7A==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@kernel.org>
Subject: [PATCH 3/5] riscv: dts: add initial T-HEAD light SoC device tree
Date:   Mon,  8 May 2023 02:23:02 +0800
Message-Id: <20230507182304.2934-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230507182304.2934-1-jszhang@kernel.org>
References: <20230507182304.2934-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree for the light(a.k.a TH1520) RISC-V SoC by
T-HEAD.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/boot/dts/thead/light.dtsi | 454 +++++++++++++++++++++++++++
 1 file changed, 454 insertions(+)
 create mode 100644 arch/riscv/boot/dts/thead/light.dtsi

diff --git a/arch/riscv/boot/dts/thead/light.dtsi b/arch/riscv/boot/dts/thead/light.dtsi
new file mode 100644
index 000000000000..cdf6d8b04d22
--- /dev/null
+++ b/arch/riscv/boot/dts/thead/light.dtsi
@@ -0,0 +1,454 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2021 Alibaba Group Holding Limited.
+ * Copyright (C) 2023 Jisheng Zhang <jszhang@kernel.org>
+ */
+
+/ {
+	compatible = "thead,light";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus: cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		timebase-frequency = <3000000>;
+
+		c910_0: cpu@0 {
+			compatible = "thead,c910", "riscv";
+			device_type = "cpu";
+			riscv,isa = "rv64imafdc";
+			reg = <0>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <512>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <512>;
+			next-level-cache = <&l2_cache>;
+			mmu-type = "riscv,sv39";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		c910_1: cpu@1 {
+			compatible = "thead,c910", "riscv";
+			device_type = "cpu";
+			riscv,isa = "rv64imafdc";
+			reg = <1>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <512>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <512>;
+			next-level-cache = <&l2_cache>;
+			mmu-type = "riscv,sv39";
+
+			cpu1_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		c910_2: cpu@2 {
+			compatible = "thead,c910", "riscv";
+			device_type = "cpu";
+			riscv,isa = "rv64imafdc";
+			reg = <2>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <512>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <512>;
+			next-level-cache = <&l2_cache>;
+			mmu-type = "riscv,sv39";
+
+			cpu2_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		c910_3: cpu@3 {
+			compatible = "thead,c910", "riscv";
+			device_type = "cpu";
+			riscv,isa = "rv64imafdc";
+			reg = <3>;
+			i-cache-block-size = <64>;
+			i-cache-size = <65536>;
+			i-cache-sets = <512>;
+			d-cache-block-size = <64>;
+			d-cache-size = <65536>;
+			d-cache-sets = <512>;
+			next-level-cache = <&l2_cache>;
+			mmu-type = "riscv,sv39";
+
+			cpu3_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&c910_0>;
+				};
+
+				core1 {
+					cpu = <&c910_1>;
+				};
+
+				core2 {
+					cpu = <&c910_2>;
+				};
+
+				core3 {
+					cpu = <&c910_3>;
+				};
+			};
+		};
+
+		l2_cache: l2-cache {
+			compatible = "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-size = <1048576>;
+			cache-sets = <1024>;
+			cache-unified;
+		};
+	};
+
+	osc: oscillator {
+		compatible = "fixed-clock";
+		clock-output-names = "osc_24m";
+		#clock-cells = <0>;
+	};
+
+	osc_32k: 32k-oscillator {
+		compatible = "fixed-clock";
+		clock-output-names = "osc_32k";
+		#clock-cells = <0>;
+	};
+
+	apb_clk: apb-clk-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "apb_clk";
+		#clock-cells = <0>;
+	};
+
+	uart_sclk: uart-sclk-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "uart_sclk";
+		#clock-cells = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		interrupt-parent = <&plic>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		reset: reset-sample {
+			compatible = "thead,reset-sample";
+			entry-reg = <0xff 0xff019050>;
+			entry-cnt = <4>;
+			control-reg = <0xff 0xff015004>;
+			control-val = <0x1c>;
+			csr-copy = <0x7f3 0x7c0 0x7c1 0x7c2 0x7c3 0x7c5 0x7cc>;
+		};
+
+		plic: interrupt-controller@ffd8000000 {
+			compatible = "thead,c910-plic";
+			reg = <0xff 0xd8000000 0x0 0x01000000>;
+			interrupts-extended = <&cpu0_intc 11>, <&cpu0_intc 9>,
+					      <&cpu1_intc 11>, <&cpu1_intc 9>,
+					      <&cpu2_intc 11>, <&cpu2_intc 9>,
+					      <&cpu3_intc 11>, <&cpu3_intc 9>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			riscv,ndev = <240>;
+		};
+
+		clint: timer@ffdc000000 {
+			compatible = "thead,c900-clint";
+			reg = <0xff 0xdc000000 0x0 0x00010000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
+					      <&cpu1_intc 3>, <&cpu1_intc 7>,
+					      <&cpu2_intc 3>, <&cpu2_intc 7>,
+					      <&cpu3_intc 3>, <&cpu3_intc 7>;
+		};
+
+		uart0: serial@ffe7014000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xff 0xe7014000 0x0 0x4000>;
+			interrupts = <36>;
+			clocks = <&uart_sclk>;
+			clock-names = "baudclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart1: serial@ffe7f00000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xff 0xe7f00000 0x0 0x4000>;
+			interrupts = <37>;
+			clocks = <&uart_sclk>;
+			clock-names = "baudclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart3: serial@ffe7f04000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xff 0xe7f04000 0x0 0x4000>;
+			interrupts = <39>;
+			clocks = <&uart_sclk>;
+			clock-names = "baudclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		gpio2: gpio@ffe7f34000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xff 0xe7f34000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portc: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <58>;
+			};
+		};
+
+		gpio3: gpio@ffe7f38000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xff 0xe7f38000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portd: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <59>;
+			};
+		};
+
+		gpio0: gpio@ffec005000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xff 0xec005000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			porta: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <56>;
+			};
+		};
+
+		gpio1: gpio@ffec006000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xff 0xec006000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portb: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <57>;
+			};
+		};
+
+		uart2: serial@ffec010000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xff 0xec010000 0x0 0x4000>;
+			interrupts = <38>;
+			clocks = <&uart_sclk>;
+			clock-names = "baudclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		dmac0: dmac@ffefc00000 {
+			compatible = "snps,axi-dma-1.01a";
+			reg = <0xff 0xefc00000 0x0 0x1000>;
+			interrupts = <27>;
+			clocks = <&apb_clk>, <&apb_clk>;
+			clock-names = "core-clk", "cfgr-clk";
+			#dma-cells = <1>;
+			dma-channels = <4>;
+			snps,block-size = <65536 65536 65536 65536>;
+			snps,priority = <0 1 2 3>;
+			snps,dma-masters = <1>;
+			snps,data-width = <4>;
+			snps,axi-max-burst-len = <16>;
+			status = "disabled";
+		};
+
+		timer0: timer@ffefc32000 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xefc32000 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <16>;
+			status = "disabled";
+		};
+
+		timer1: timer@ffefc32014 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xefc32014 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <17>;
+			status = "disabled";
+		};
+
+		timer2: timer@ffefc32028 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xefc32028 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <18>;
+			status = "disabled";
+		};
+
+		timer3: timer@ffefc3203c {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xefc3203c 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <19>;
+			status = "disabled";
+		};
+
+		uart4: serial@fff7f08000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xff 0xf7f08000 0x0 0x4000>;
+			interrupts = <40>;
+			clocks = <&uart_sclk>;
+			clock-names = "baudclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		uart5: serial@fff7f0c000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0xff 0xf7f0c000 0x0 0x4000>;
+			interrupts = <41>;
+			clocks = <&uart_sclk>;
+			clock-names = "baudclk";
+			reg-shift = <2>;
+			reg-io-width = <4>;
+			status = "disabled";
+		};
+
+		timer4: timer@ffffc33000 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xffc33000 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <20>;
+			status = "disabled";
+		};
+
+		timer5: timer@ffffc33014 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xffc33014 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <21>;
+			status = "disabled";
+		};
+
+		timer6: timer@ffffc33028 {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xffc33028 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <22>;
+			status = "disabled";
+		};
+
+		timer7: timer@ffffc3303c {
+			compatible = "snps,dw-apb-timer";
+			reg = <0xff 0xffc3303c 0x0 0x14>;
+			clocks = <&apb_clk>;
+			clock-names = "timer";
+			interrupts = <23>;
+			status = "disabled";
+		};
+
+		ao_gpio0: gpio@fffff41000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xff 0xfff41000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			porte: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <76>;
+			};
+		};
+
+		ao_gpio1: gpio@fffff52000 {
+			compatible = "snps,dw-apb-gpio";
+			reg = <0xff 0xfff52000 0x0 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			portf: gpio-controller@0 {
+				compatible = "snps,dw-apb-gpio-port";
+				gpio-controller;
+				#gpio-cells = <2>;
+				ngpios = <32>;
+				reg = <0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <55>;
+			};
+		};
+	};
+};
-- 
2.40.0

