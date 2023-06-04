Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE5C7214C1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 06:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjFDE4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 00:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjFDEz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 00:55:56 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328F5D3;
        Sat,  3 Jun 2023 21:55:54 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3544td5T057336;
        Sat, 3 Jun 2023 23:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685854539;
        bh=h3PdSyqSDpxSmvPFWLWZ6ObQIDZ1OIFUgqBWLd29Q2E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=L1vL/qh0H0ARHF1usgyX7oXwB3T2m6R7utXvJJWmu3iQ/vLO56OEVL/t2ml/I8OMg
         ckspPlbJSfYZ74NaPp9RuWuMX6UVm0XOSvklPk7UJYuJrHSsQSoo+JF2V+ezu/3GmO
         il/k+xq2ZzNhDv7j+EciiCV28NRPDHng6V0S58Gw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3544tc31030009
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 3 Jun 2023 23:55:39 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 3
 Jun 2023 23:55:38 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 3 Jun 2023 23:55:38 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3544tVqZ052201;
        Sat, 3 Jun 2023 23:55:35 -0500
From:   Udit Kumar <u-kumar1@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <conor+dt@kernel.org>, <m-chawdhry@ti.com>, <n-francis@ti.com>
CC:     Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v3 1/5] arm64: dts: ti: k3-j7200: Add general purpose timers
Date:   Sun, 4 Jun 2023 10:25:21 +0530
Message-ID: <20230604045525.1889083-2-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230604045525.1889083-1-u-kumar1@ti.com>
References: <20230604045525.1889083-1-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 20 general purpose timers on j721e that can be used for
things like PWM using pwm-omap-dmtimer driver. There are also
additional ten timers in the MCU domain which are meant for MCU
firmware usage and hence marked reserved by default.

The odd numbered timers have the option of being cascaded to even
timers to create a 64 bit non-atomic counter which is racy in simple
usage, hence the clock muxes are explicitly setup to individual 32 bit
counters driven off system crystal (HFOSC) as default.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 240 ++++++++++++++++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 130 ++++++++++
 2 files changed, 370 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index ef352e32f19d..c6b15aceea82 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -971,6 +971,246 @@ watchdog1: watchdog@2210000 {
 		assigned-clock-parents = <&k3_clks 253 5>;
 	};
 
+	main_timer0: timer@2400000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2400000 0x00 0x400>;
+		interrupts = <GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 49 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 49 1>;
+		assigned-clock-parents = <&k3_clks 49 2>;
+		power-domains = <&k3_pds 49 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer1: timer@2410000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2410000 0x00 0x400>;
+		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 50 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 50 1>, <&k3_clks 313 0>;
+		assigned-clock-parents = <&k3_clks 50 2>, <&k3_clks 313 1>;
+		power-domains = <&k3_pds 50 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer2: timer@2420000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2420000 0x00 0x400>;
+		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 51 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 51 1>;
+		assigned-clock-parents = <&k3_clks 51 2>;
+		power-domains = <&k3_pds 49 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer3: timer@2430000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2430000 0x00 0x400>;
+		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 52 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 52 1>, <&k3_clks 314 0>;
+		assigned-clock-parents = <&k3_clks 52 2>, <&k3_clks 314 1>;
+		power-domains = <&k3_pds 52 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer4: timer@2440000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2440000 0x00 0x400>;
+		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 53 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 53 1>;
+		assigned-clock-parents = <&k3_clks 53 2>;
+		power-domains = <&k3_pds 53 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer5: timer@2450000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2450000 0x00 0x400>;
+		interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 54 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 54 1>, <&k3_clks 315 0>;
+		assigned-clock-parents = <&k3_clks 54 2>, <&k3_clks 315 1>;
+		power-domains = <&k3_pds 54 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer6: timer@2460000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2460000 0x00 0x400>;
+		interrupts = <GIC_SPI 230 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 55 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 55 1>;
+		assigned-clock-parents = <&k3_clks 55 2>;
+		power-domains = <&k3_pds 55 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer7: timer@2470000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2470000 0x00 0x400>;
+		interrupts = <GIC_SPI 231 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 57 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 57 1>, <&k3_clks 316 0>;
+		assigned-clock-parents = <&k3_clks 57 2>, <&k3_clks 316 1>;
+		power-domains = <&k3_pds 57 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer8: timer@2480000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2480000 0x00 0x400>;
+		interrupts = <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 58 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 58 1>;
+		assigned-clock-parents = <&k3_clks 58 2>;
+		power-domains = <&k3_pds 58 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer9: timer@2490000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2490000 0x00 0x400>;
+		interrupts = <GIC_SPI 233 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 59 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 59 1>, <&k3_clks 317 0>;
+		assigned-clock-parents = <&k3_clks 59 2>, <&k3_clks 317 1>;
+		power-domains = <&k3_pds 59 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer10: timer@24a0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24a0000 0x00 0x400>;
+		interrupts = <GIC_SPI 234 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 60 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 60 1>;
+		assigned-clock-parents = <&k3_clks 60 2>;
+		power-domains = <&k3_pds 60 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer11: timer@24b0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24b0000 0x00 0x400>;
+		interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 62 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 62 1>, <&k3_clks 318 0>;
+		assigned-clock-parents = <&k3_clks 62 2>, <&k3_clks 318 1>;
+		power-domains = <&k3_pds 62 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer12: timer@24c0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24c0000 0x00 0x400>;
+		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 63 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 63 1>;
+		assigned-clock-parents = <&k3_clks 63 2>;
+		power-domains = <&k3_pds 63 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer13: timer@24d0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24d0000 0x00 0x400>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 64 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 64 1>, <&k3_clks 319 0>;
+		assigned-clock-parents = <&k3_clks 64 2>, <&k3_clks 319 1>;
+		power-domains = <&k3_pds 64 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer14: timer@24e0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24e0000 0x00 0x400>;
+		interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 65 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 65 1>;
+		assigned-clock-parents = <&k3_clks 65 2>;
+		power-domains = <&k3_pds 65 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer15: timer@24f0000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x24f0000 0x00 0x400>;
+		interrupts = <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 66 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 66 1>, <&k3_clks 320 0>;
+		assigned-clock-parents = <&k3_clks 66 2>, <&k3_clks 320 1>;
+		power-domains = <&k3_pds 66 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer16: timer@2500000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2500000 0x00 0x400>;
+		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 67 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 67 1>;
+		assigned-clock-parents = <&k3_clks 67 2>;
+		power-domains = <&k3_pds 67 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer17: timer@2510000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2510000 0x00 0x400>;
+		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 68 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 68 1>, <&k3_clks 321 0>;
+		assigned-clock-parents = <&k3_clks 68 2>, <&k3_clks 321 1>;
+		power-domains = <&k3_pds 68 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer18: timer@2520000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2520000 0x00 0x400>;
+		interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 69 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 69 1>;
+		assigned-clock-parents = <&k3_clks 69 2>;
+		power-domains = <&k3_pds 69 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	main_timer19: timer@2530000 {
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x2530000 0x00 0x400>;
+		interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 70 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 70 1>, <&k3_clks 322 0>;
+		assigned-clock-parents = <&k3_clks 70 2>, <&k3_clks 322 1>;
+		power-domains = <&k3_pds 70 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
 	main_r5fss0: r5fss@5c00000 {
 		compatible = "ti,j7200-r5fss";
 		ti,cluster-mode = <1>;
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index 674e695ef844..dcb6696cff17 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -34,6 +34,136 @@ k3_reset: reset-controller {
 		};
 	};
 
+	mcu_timer0: timer@40400000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40400000 0x00 0x400>;
+		interrupts = <GIC_SPI 816 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 35 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 35 1>;
+		assigned-clock-parents = <&k3_clks 35 2>;
+		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer1: timer@40410000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40410000 0x00 0x400>;
+		interrupts = <GIC_SPI 817 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 71 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 71 1>, <&k3_clks 308 0>;
+		assigned-clock-parents = <&k3_clks 71 2>, <&k3_clks 308 1>;
+		power-domains = <&k3_pds 71 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer2: timer@40420000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40420000 0x00 0x400>;
+		interrupts = <GIC_SPI 818 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 72 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 72 1>;
+		assigned-clock-parents = <&k3_clks 72 2>;
+		power-domains = <&k3_pds 72 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer3: timer@40430000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40430000 0x00 0x400>;
+		interrupts = <GIC_SPI 819 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 73 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 73 1>, <&k3_clks 309 0>;
+		assigned-clock-parents = <&k3_clks 73 2>, <&k3_clks 309 1>;
+		power-domains = <&k3_pds 73 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer4: timer@40440000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40440000 0x00 0x400>;
+		interrupts = <GIC_SPI 820 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 74 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 74 1>;
+		assigned-clock-parents = <&k3_clks 74 2>;
+		power-domains = <&k3_pds 74 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer5: timer@40450000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40450000 0x00 0x400>;
+		interrupts = <GIC_SPI 821 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 75 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 75 1>, <&k3_clks 310 0>;
+		assigned-clock-parents = <&k3_clks 75 2>, <&k3_clks 310 1>;
+		power-domains = <&k3_pds 75 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer6: timer@40460000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40460000 0x00 0x400>;
+		interrupts = <GIC_SPI 822 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 76 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 76 1>;
+		assigned-clock-parents = <&k3_clks 76 2>;
+		power-domains = <&k3_pds 35 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer7: timer@40470000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40470000 0x00 0x400>;
+		interrupts = <GIC_SPI 823 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 77 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 77 1>, <&k3_clks 311 0>;
+		assigned-clock-parents = <&k3_clks 77 2>, <&k3_clks 311 1>;
+		power-domains = <&k3_pds 77 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer8: timer@40480000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40480000 0x00 0x400>;
+		interrupts = <GIC_SPI 824 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 78 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 78 1>;
+		assigned-clock-parents = <&k3_clks 78 2>;
+		power-domains = <&k3_pds 78 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
+	mcu_timer9: timer@40490000 {
+		status = "reserved";
+		compatible = "ti,am654-timer";
+		reg = <0x00 0x40490000 0x00 0x400>;
+		interrupts = <GIC_SPI 825 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&k3_clks 79 1>;
+		clock-names = "fck";
+		assigned-clocks = <&k3_clks 79 1>, <&k3_clks 312 0>;
+		assigned-clock-parents = <&k3_clks 79 2>, <&k3_clks 312 1>;
+		power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
+		ti,timer-pwm;
+	};
+
 	mcu_conf: syscon@40f00000 {
 		compatible = "syscon", "simple-mfd";
 		reg = <0x00 0x40f00000 0x00 0x20000>;
-- 
2.34.1

