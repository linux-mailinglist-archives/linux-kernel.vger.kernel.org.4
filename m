Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9D26D3015
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 13:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjDALUz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 1 Apr 2023 07:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDALUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 07:20:15 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344CF24AF5;
        Sat,  1 Apr 2023 04:19:57 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id CEE1E24E195;
        Sat,  1 Apr 2023 19:19:55 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 1 Apr
 2023 19:19:55 +0800
Received: from ubuntu.localdomain (113.72.144.76) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 1 Apr
 2023 19:19:54 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 19/22] riscv: dts: starfive: Add initial StarFive JH7110 device tree
Date:   Sat, 1 Apr 2023 19:19:31 +0800
Message-ID: <20230401111934.130844-20-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230401111934.130844-1-hal.feng@starfivetech.com>
References: <20230401111934.130844-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.76]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

Add initial device tree for the JH7110 RISC-V SoC by StarFive
Technology Ltd.

Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Co-developed-by: Jianlong Huang <jianlong.huang@starfivetech.com>
Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
Co-developed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110.dtsi | 509 +++++++++++++++++++++++
 1 file changed, 509 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110.dtsi

diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
new file mode 100644
index 000000000000..d484ecdf93f7
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -0,0 +1,509 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ * Copyright (C) 2022 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+/dts-v1/;
+#include <dt-bindings/clock/starfive,jh7110-crg.h>
+#include <dt-bindings/reset/starfive,jh7110-crg.h>
+
+/ {
+	compatible = "starfive,jh7110";
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		S7_0: cpu@0 {
+			compatible = "sifive,s7", "riscv";
+			reg = <0>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <8192>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <40>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <16384>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <40>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&ccache>;
+			riscv,isa = "rv64imac_zba_zbb";
+			tlb-split;
+			status = "disabled";
+
+			cpu0_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		U74_1: cpu@1 {
+			compatible = "sifive,u74-mc", "riscv";
+			reg = <1>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <40>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <40>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&ccache>;
+			riscv,isa = "rv64imafdc_zba_zbb";
+			tlb-split;
+
+			cpu1_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		U74_2: cpu@2 {
+			compatible = "sifive,u74-mc", "riscv";
+			reg = <2>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <40>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <40>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&ccache>;
+			riscv,isa = "rv64imafdc_zba_zbb";
+			tlb-split;
+
+			cpu2_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		U74_3: cpu@3 {
+			compatible = "sifive,u74-mc", "riscv";
+			reg = <3>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <40>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <40>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&ccache>;
+			riscv,isa = "rv64imafdc_zba_zbb";
+			tlb-split;
+
+			cpu3_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		U74_4: cpu@4 {
+			compatible = "sifive,u74-mc", "riscv";
+			reg = <4>;
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <40>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <40>;
+			mmu-type = "riscv,sv39";
+			next-level-cache = <&ccache>;
+			riscv,isa = "rv64imafdc_zba_zbb";
+			tlb-split;
+
+			cpu4_intc: interrupt-controller {
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&S7_0>;
+				};
+
+				core1 {
+					cpu = <&U74_1>;
+				};
+
+				core2 {
+					cpu = <&U74_2>;
+				};
+
+				core3 {
+					cpu = <&U74_3>;
+				};
+
+				core4 {
+					cpu = <&U74_4>;
+				};
+			};
+		};
+	};
+
+	gmac0_rgmii_rxin: gmac0-rgmii-rxin-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "gmac0_rgmii_rxin";
+		#clock-cells = <0>;
+	};
+
+	gmac0_rmii_refin: gmac0-rmii-refin-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "gmac0_rmii_refin";
+		#clock-cells = <0>;
+	};
+
+	gmac1_rgmii_rxin: gmac1-rgmii-rxin-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "gmac1_rgmii_rxin";
+		#clock-cells = <0>;
+	};
+
+	gmac1_rmii_refin: gmac1-rmii-refin-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "gmac1_rmii_refin";
+		#clock-cells = <0>;
+	};
+
+	i2srx_bclk_ext: i2srx-bclk-ext-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "i2srx_bclk_ext";
+		#clock-cells = <0>;
+	};
+
+	i2srx_lrck_ext: i2srx-lrck-ext-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "i2srx_lrck_ext";
+		#clock-cells = <0>;
+	};
+
+	i2stx_bclk_ext: i2stx-bclk-ext-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "i2stx_bclk_ext";
+		#clock-cells = <0>;
+	};
+
+	i2stx_lrck_ext: i2stx-lrck-ext-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "i2stx_lrck_ext";
+		#clock-cells = <0>;
+	};
+
+	mclk_ext: mclk-ext-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "mclk_ext";
+		#clock-cells = <0>;
+	};
+
+	osc: oscillator {
+		compatible = "fixed-clock";
+		clock-output-names = "osc";
+		#clock-cells = <0>;
+	};
+
+	rtc_osc: rtc-oscillator {
+		compatible = "fixed-clock";
+		clock-output-names = "rtc_osc";
+		#clock-cells = <0>;
+	};
+
+	tdm_ext: tdm-ext-clock {
+		compatible = "fixed-clock";
+		clock-output-names = "tdm_ext";
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
+		clint: timer@2000000 {
+			compatible = "starfive,jh7110-clint", "sifive,clint0";
+			reg = <0x0 0x2000000 0x0 0x10000>;
+			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
+					      <&cpu1_intc 3>, <&cpu1_intc 7>,
+					      <&cpu2_intc 3>, <&cpu2_intc 7>,
+					      <&cpu3_intc 3>, <&cpu3_intc 7>,
+					      <&cpu4_intc 3>, <&cpu4_intc 7>;
+		};
+
+		ccache: cache-controller@2010000 {
+			compatible = "starfive,jh7110-ccache", "sifive,ccache0", "cache";
+			reg = <0x0 0x2010000 0x0 0x4000>;
+			interrupts = <1>, <3>, <4>, <2>;
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <2048>;
+			cache-size = <2097152>;
+			cache-unified;
+		};
+
+		plic: interrupt-controller@c000000 {
+			compatible = "starfive,jh7110-plic", "sifive,plic-1.0.0";
+			reg = <0x0 0xc000000 0x0 0x4000000>;
+			interrupts-extended = <&cpu0_intc 11>,
+					      <&cpu1_intc 11>, <&cpu1_intc 9>,
+					      <&cpu2_intc 11>, <&cpu2_intc 9>,
+					      <&cpu3_intc 11>, <&cpu3_intc 9>,
+					      <&cpu4_intc 11>, <&cpu4_intc 9>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+			#address-cells = <0>;
+			riscv,ndev = <136>;
+		};
+
+		uart0: serial@10000000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x10000000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_UART0_CORE>,
+				 <&syscrg JH7110_SYSCLK_UART0_APB>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&syscrg JH7110_SYSRST_UART0_APB>;
+			interrupts = <32>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart1: serial@10010000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x10010000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_UART1_CORE>,
+				 <&syscrg JH7110_SYSCLK_UART1_APB>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&syscrg JH7110_SYSRST_UART1_APB>;
+			interrupts = <33>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart2: serial@10020000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x10020000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_UART2_CORE>,
+				 <&syscrg JH7110_SYSCLK_UART2_APB>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&syscrg JH7110_SYSRST_UART2_APB>;
+			interrupts = <34>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		i2c0: i2c@10030000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0x10030000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_I2C0_APB>;
+			clock-names = "ref";
+			resets = <&syscrg JH7110_SYSRST_I2C0_APB>;
+			interrupts = <35>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c1: i2c@10040000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0x10040000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_I2C1_APB>;
+			clock-names = "ref";
+			resets = <&syscrg JH7110_SYSRST_I2C1_APB>;
+			interrupts = <36>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c2: i2c@10050000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0x10050000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_I2C2_APB>;
+			clock-names = "ref";
+			resets = <&syscrg JH7110_SYSRST_I2C2_APB>;
+			interrupts = <37>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		uart3: serial@12000000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x12000000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_UART3_CORE>,
+				 <&syscrg JH7110_SYSCLK_UART3_APB>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&syscrg JH7110_SYSRST_UART3_APB>;
+			interrupts = <45>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart4: serial@12010000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x12010000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_UART4_CORE>,
+				 <&syscrg JH7110_SYSCLK_UART4_APB>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&syscrg JH7110_SYSRST_UART4_APB>;
+			interrupts = <46>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		uart5: serial@12020000 {
+			compatible = "snps,dw-apb-uart";
+			reg = <0x0 0x12020000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_UART5_CORE>,
+				 <&syscrg JH7110_SYSCLK_UART5_APB>;
+			clock-names = "baudclk", "apb_pclk";
+			resets = <&syscrg JH7110_SYSRST_UART5_APB>;
+			interrupts = <47>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			status = "disabled";
+		};
+
+		i2c3: i2c@12030000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0x12030000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_I2C3_APB>;
+			clock-names = "ref";
+			resets = <&syscrg JH7110_SYSRST_I2C3_APB>;
+			interrupts = <48>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c4: i2c@12040000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0x12040000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_I2C4_APB>;
+			clock-names = "ref";
+			resets = <&syscrg JH7110_SYSRST_I2C4_APB>;
+			interrupts = <49>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c5: i2c@12050000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0x12050000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_I2C5_APB>;
+			clock-names = "ref";
+			resets = <&syscrg JH7110_SYSRST_I2C5_APB>;
+			interrupts = <50>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		i2c6: i2c@12060000 {
+			compatible = "snps,designware-i2c";
+			reg = <0x0 0x12060000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_I2C6_APB>;
+			clock-names = "ref";
+			resets = <&syscrg JH7110_SYSRST_I2C6_APB>;
+			interrupts = <51>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		syscrg: clock-controller@13020000 {
+			compatible = "starfive,jh7110-syscrg";
+			reg = <0x0 0x13020000 0x0 0x10000>;
+			clocks = <&osc>, <&gmac1_rmii_refin>,
+				 <&gmac1_rgmii_rxin>,
+				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
+				 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
+				 <&tdm_ext>, <&mclk_ext>;
+			clock-names = "osc", "gmac1_rmii_refin",
+				      "gmac1_rgmii_rxin",
+				      "i2stx_bclk_ext", "i2stx_lrck_ext",
+				      "i2srx_bclk_ext", "i2srx_lrck_ext",
+				      "tdm_ext", "mclk_ext";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		sysgpio: pinctrl@13040000 {
+			compatible = "starfive,jh7110-sys-pinctrl";
+			reg = <0x0 0x13040000 0x0 0x10000>;
+			clocks = <&syscrg JH7110_SYSCLK_IOMUX_APB>;
+			resets = <&syscrg JH7110_SYSRST_IOMUX_APB>;
+			interrupts = <86>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		aoncrg: clock-controller@17000000 {
+			compatible = "starfive,jh7110-aoncrg";
+			reg = <0x0 0x17000000 0x0 0x10000>;
+			clocks = <&osc>, <&gmac0_rmii_refin>,
+				 <&gmac0_rgmii_rxin>,
+				 <&syscrg JH7110_SYSCLK_STG_AXIAHB>,
+				 <&syscrg JH7110_SYSCLK_APB_BUS>,
+				 <&syscrg JH7110_SYSCLK_GMAC0_GTXCLK>,
+				 <&rtc_osc>;
+			clock-names = "osc", "gmac0_rmii_refin",
+				      "gmac0_rgmii_rxin", "stg_axiahb",
+				      "apb_bus", "gmac0_gtxclk",
+				      "rtc_osc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
+
+		aongpio: pinctrl@17020000 {
+			compatible = "starfive,jh7110-aon-pinctrl";
+			reg = <0x0 0x17020000 0x0 0x10000>;
+			resets = <&aoncrg JH7110_AONRST_IOMUX>;
+			interrupts = <85>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
+};
-- 
2.38.1

