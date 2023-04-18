Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF5E6E566D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 03:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjDRB1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 21:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjDRB1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 21:27:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7E9EC;
        Mon, 17 Apr 2023 18:27:28 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33I1RIQg033013;
        Mon, 17 Apr 2023 20:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681781238;
        bh=0cXyxlSxl99ILuMw8BlZnOJ6rb9gZyPUnD9DgLOWFbg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KXuHDv2c/rsbp4nd1tXRlVXkUA5Qn9i71aq9TUtCva8Nryx3YWzCHS7xR63VIckID
         dmBkFG6b35t/urQfqzqcuf2c144yHOgxycCz07JerRvNJXF5DrefPkaJML1LVCVzZc
         uStUcrBYTNNeugMdITP5qUKhy4XOqByrD7k8/qlA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33I1RIsY107380
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Apr 2023 20:27:18 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 17
 Apr 2023 20:27:18 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 17 Apr 2023 20:27:18 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33I1RINi001924;
        Mon, 17 Apr 2023 20:27:18 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, Nishanth Menon <nm@ti.com>,
        Bryan Brattlof <bb@ti.com>
Subject: [PATCH 1/3] arm64: dts: ti: k3-am62a: Add general purpose timers
Date:   Mon, 17 Apr 2023 20:27:15 -0500
Message-ID: <20230418012717.1230882-2-nm@ti.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418012717.1230882-1-nm@ti.com>
References: <20230418012717.1230882-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to commit 3308a31c507c ("arm64: dts: ti: k3-am62: Add general
purpose timers for am62"), there are 12 general purpose timers on am62a7
split between 8 in main and 4 in mcu domains. The 4 in mcu domain do not
have interrupts that are routable to a53.

We configure the timers with the 25 MHz input clock by default as the
32.768 kHz clock may not be wired on the device. We leave the MCU domain
timers clock mux unconfigured, and mark the MCU domain timers reserved.
The MCU domain timers are likely reserved by the software for the ESM
module.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 96 +++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi  | 45 +++++++++++
 2 files changed, 141 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 393a1a40b68b..59d1199e43c9 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -177,6 +177,102 @@ main_pmx0: pinctrl@f4000 {
 		pinctrl-single,function-mask = <0xffffffff>;
 	};
 
+	main_timer0: timer@2400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2400000 0x00 0x400>;
+		interrupts = <GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 36 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 36 2>;
+		assigned-clock-parents = <&k3_clks 36 3>;
+		power-domains = <&k3_pds 36 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer1: timer@2410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2410000 0x00 0x400>;
+		interrupts = <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 37 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 37 2>;
+		assigned-clock-parents = <&k3_clks 37 3>;
+		power-domains = <&k3_pds 37 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer2: timer@2420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2420000 0x00 0x400>;
+		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 38 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 38 2>;
+		assigned-clock-parents = <&k3_clks 38 3>;
+		power-domains = <&k3_pds 38 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer3: timer@2430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2430000 0x00 0x400>;
+		interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 39 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 39 2>;
+		assigned-clock-parents = <&k3_clks 39 3>;
+		power-domains = <&k3_pds 39 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer4: timer@2440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2440000 0x00 0x400>;
+		interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 40 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 40 2>;
+		assigned-clock-parents = <&k3_clks 40 3>;
+		power-domains = <&k3_pds 40 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer5: timer@2450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2450000 0x00 0x400>;
+		interrupts = <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 41 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 41 2>;
+		assigned-clock-parents = <&k3_clks 41 3>;
+		power-domains = <&k3_pds 41 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer6: timer@2460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2460000 0x00 0x400>;
+		interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 42 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 42 2>;
+		assigned-clock-parents = <&k3_clks 42 3>;
+		power-domains = <&k3_pds 42 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer7: timer@2470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2470000 0x00 0x400>;
+		interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 43 2>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 43 2>;
+		assigned-clock-parents = <&k3_clks 43 3>;
+		power-domains = <&k3_pds 43 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
 	main_uart0: serial@2800000 {
 		compatible = "ti,am64-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
index 2bb813e784a2..50c94a55fe85 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi
@@ -15,6 +15,51 @@ mcu_pmx0: pinctrl@4084000 {
 		status = "disabled";
 	};
 
+	/*
+	 * The MCU domain timer interrupts are routed only to the ESM module,
+	 * and not currently available for Linux. The MCU domain timers are
+	 * of limited use without interrupts, and likely reserved by the ESM.
+	 */
+	mcu_timer0: timer@4800000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x4800000 0x00 0x400>;
+		clocks = <&k3_clks 35 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		status = "reserved";
+	};
+
+	mcu_timer1: timer@4810000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x4810000 0x00 0x400>;
+		clocks = <&k3_clks 48 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 48 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		status = "reserved";
+	};
+
+	mcu_timer2: timer@4820000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x4820000 0x00 0x400>;
+		clocks = <&k3_clks 49 2>;
+		clock-names = "fck";
+		power-domains = <&k3_pds 49 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+		status = "reserved";
+	};
+
+	mcu_timer3: timer@4830000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x4830000 0x00 0x400>;
+		clocks = <&k3_clks 50 2>;
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

