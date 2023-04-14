Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BAB6E1D40
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjDNHeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjDNHdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:33:54 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A6A4ECE;
        Fri, 14 Apr 2023 00:33:52 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XYo3109385;
        Fri, 14 Apr 2023 02:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681457614;
        bh=PRVKUkOO/KsQYzOx4Cr9T7afGzfEI+sYc+MKC478uBc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fHCHMr9hf4SLMR9mgQqb+dTkfrWQ/3Lm9Emx9/dEqLuy4bXf7ZJj3eSz8wmlyz6FG
         PoJuXadU4lZ5oEbTtkVGvNlQd5hqpGS/RIbrSWGQ8w6VdlyVmkCl/V+nT5UnSklkIP
         wEPsrGAVTZStdr1RtTSudZza3Bd0dUOCYmyinBEw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33E7XYMX091059
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 02:33:34 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 14
 Apr 2023 02:33:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 14 Apr 2023 02:33:34 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33E7XYA8003016;
        Fri, 14 Apr 2023 02:33:34 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Neha Malcom Francis <n-francis@ti.com>,
        Nikhil M Jain <n-jain1@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/10] arm64: dts: ti: k3-am64: Add general purpose timers
Date:   Fri, 14 Apr 2023 02:33:19 -0500
Message-ID: <20230414073328.381336-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230414073328.381336-1-nm@ti.com>
References: <20230414073328.381336-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 11 general purpose timers on am64 that can be used for things
like PWM using pwm-omap-dmtimer driver. There are also additional four
timers in the MCU domain that do not have interrupts routable for Linux.

We configure the timers with the 25 MHz input clock by default as the
32.768 kHz clock may not be wired on the device. We leave the MCU domain
timers clock mux unconfigured, and mark the MCU domain timers reserved.
The MCU domain timers are likely reserved by the software for the ESM
module.

Compared to am65, the timers on am64 do not have a dedicated IO mux for
the timers. On am62, the timers have different interrupts, clocks and
power domains compared to am65, and the MCU timers are at a different
IO address. Compared to AM62, the AM64 times have different clocks and
count in main domain are different as well.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 144 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  |  45 +++++++
 2 files changed, 189 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 5e8036f32d79..f5e25d6c3c28 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -228,6 +228,150 @@ epwm_tbclk: clock@4140 {
 		};
 	};
 
+	main_timer0: timer@2400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2400000 0x00 0x400>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 36 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 36 1>;
+		assigned-clock-parents = <&k3_clks 36 2>;
+		power-domains = <&k3_pds 36 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer1: timer@2410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2410000 0x00 0x400>;
+		interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 37 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 37 1>;
+		assigned-clock-parents = <&k3_clks 37 2>;
+		power-domains = <&k3_pds 37 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer2: timer@2420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2420000 0x00 0x400>;
+		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 38 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 38 1>;
+		assigned-clock-parents = <&k3_clks 38 2>;
+		power-domains = <&k3_pds 38 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer3: timer@2430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2430000 0x00 0x400>;
+		interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 39 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 39 1>;
+		assigned-clock-parents = <&k3_clks 39 2>;
+		power-domains = <&k3_pds 39 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer4: timer@2440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2440000 0x00 0x400>;
+		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 40 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 40 1>;
+		assigned-clock-parents = <&k3_clks 40 2>;
+		power-domains = <&k3_pds 40 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer5: timer@2450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2450000 0x00 0x400>;
+		interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 41 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 41 1>;
+		assigned-clock-parents = <&k3_clks 41 2>;
+		power-domains = <&k3_pds 41 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer6: timer@2460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2460000 0x00 0x400>;
+		interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 42 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 42 1>;
+		assigned-clock-parents = <&k3_clks 42 2>;
+		power-domains = <&k3_pds 42 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer7: timer@2470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2470000 0x00 0x400>;
+		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 43 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 43 1>;
+		assigned-clock-parents = <&k3_clks 43 2>;
+		power-domains = <&k3_pds 43 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer8: timer@2480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2480000 0x00 0x400>;
+		interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 44 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 44 1>;
+		assigned-clock-parents = <&k3_clks 44 2>;
+		power-domains = <&k3_pds 44 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer9: timer@2490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2490000 0x00 0x400>;
+		interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 45 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 45 1>;
+		assigned-clock-parents = <&k3_clks 45 2>;
+		power-domains = <&k3_pds 45 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer10: timer@24a0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24a0000 0x00 0x400>;
+		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 46 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 46 1>;
+		assigned-clock-parents = <&k3_clks 46 2>;
+		power-domains = <&k3_pds 46 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer11: timer@24b0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24b0000 0x00 0x400>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 47 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 47 1>;
+		assigned-clock-parents = <&k3_clks 47 2>;
+		power-domains = <&k3_pds 47 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
 	main_uart0: serial@2800000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index 38ddf0b3b8a0..31336b0e290e 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -6,6 +6,51 @@
  */
 
 &cbass_mcu {
+	/*
+	 * The MCU domain timer interrupts are routed only to the ESM module,
+	 * and not currently available for Linux. The MCU domain timers are
+	 * of limited use without interrupts, and likely reserved by the ESM.
+	 */
+	mcu_timer0: timer@4800000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x4800000 0x00 0x400>;
+		clocks = <&k3_clks 35 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		status = "reserved";
+	};
+
+	mcu_timer1: timer@4810000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x4810000 0x00 0x400>;
+		clocks = <&k3_clks 48 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 48 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		status = "reserved";
+	};
+
+	mcu_timer2: timer@4820000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x4820000 0x00 0x400>;
+		clocks = <&k3_clks 49 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 49 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		status = "reserved";
+	};
+
+	mcu_timer3: timer@4830000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x4830000 0x00 0x400>;
+		clocks = <&k3_clks 50 1>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 50 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		status = "reserved";
+	};
+
 	mcu_uart0: serial@4a00000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x04a00000 0x00 0x100>;
-- 
2.40.0

