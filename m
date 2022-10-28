Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88216611472
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbiJ1OYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiJ1OYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:24:38 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E346BBEC;
        Fri, 28 Oct 2022 07:24:28 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOJJH023806;
        Fri, 28 Oct 2022 09:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666967059;
        bh=6va/ClzjFNdP49/d45zL3g3+uNUzFUxFLB8Krcul1fc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vg9UKRm7mTVclNDLCroD9LohrXT/fWJDA9/6mrqKpSuGj7Wr5/pJXQWd3krFzjka/
         dKrCq0WmPmytRsJZUAp8I96IZYlPpJMfRB/rT2wN78C9uhQo7sIa66oR45UpvWh9Qx
         AH8qMZ5vGZKSDh8g0Quyy/eWkQ0pg2qN69wGWuVQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SEOJE8030639
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 09:24:19 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 09:24:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 09:24:19 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOHfQ039275;
        Fri, 28 Oct 2022 09:24:18 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>, Le Jin <le.jin@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 01/11] arm64: dts: ti: k3-am65: Enable UART nodes at the board level
Date:   Fri, 28 Oct 2022 09:24:07 -0500
Message-ID: <20221028142417.10642-2-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028142417.10642-1-afd@ti.com>
References: <20221028142417.10642-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UART nodes defined in the top-level AM65x SoC dtsi files are incomplete
and may not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the UART nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi    |  6 ++----
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi              |  3 +++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi               | 11 ++++++-----
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi            |  1 +
 .../boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi   |  1 +
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts        |  6 ++++++
 .../dts/ti/k3-am6548-iot2050-advanced-common.dtsi     |  4 ----
 7 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 32b7972375811..7b3087c19141c 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -360,15 +360,13 @@ &wkup_uart0 {
 };
 
 &main_uart1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart1_pins_default>;
 };
 
-&main_uart2 {
-	status = "disabled";
-};
-
 &mcu_uart0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&arduino_uart_pins_default>;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 4005a73cfea99..ae414f5d83822 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -91,6 +91,7 @@ main_uart0: serial@2800000 {
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart1: serial@2810000 {
@@ -99,6 +100,7 @@ main_uart1: serial@2810000 {
 		interrupts = <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		power-domains = <&k3_pds 147 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart2: serial@2820000 {
@@ -107,6 +109,7 @@ main_uart2: serial@2820000 {
 		interrupts = <GIC_SPI 194 IRQ_TYPE_LEVEL_HIGH>;
 		clock-frequency = <48000000>;
 		power-domains = <&k3_pds 148 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	crypto: crypto@4e00000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 8d592bf41d6f1..bb70097693802 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -22,11 +22,12 @@ phy_gmii_sel: phy@4040 {
 
 	mcu_uart0: serial@40a00000 {
 		compatible = "ti,am654-uart";
-			reg = <0x00 0x40a00000 0x00 0x100>;
-			interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
-			clock-frequency = <96000000>;
-			current-speed = <115200>;
-			power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
+		reg = <0x00 0x40a00000 0x00 0x100>;
+		interrupts = <GIC_SPI 565 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <96000000>;
+		current-speed = <115200>;
+		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcu_ram: sram@41c00000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index fa11d7142006a..bbe31532f984b 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -54,6 +54,7 @@ wkup_uart0: serial@42300000 {
 		clock-frequency = <48000000>;
 		current-speed = <115200>;
 		power-domains = <&k3_pds 150 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	wkup_i2c0: i2c@42120000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
index 4a9bf7d7c07dc..cd43fd11a5c2c 100644
--- a/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6528-iot2050-basic-common.dtsi
@@ -50,6 +50,7 @@ AM65X_IOPAD(0x0194, PIN_INPUT,  1)  /* (E24) UART0_RIN */
 };
 
 &main_uart0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 5850582dd4edf..956e9bc946b5f 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -271,7 +271,13 @@ &wkup_uart0 {
 	status = "reserved";
 };
 
+&mcu_uart0 {
+	status = "okay";
+	/* Default pinmux */
+};
+
 &main_uart0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
 	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
diff --git a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
index d25e8b26187f9..0f67e1ec0fb86 100644
--- a/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am6548-iot2050-advanced-common.dtsi
@@ -50,7 +50,3 @@ &sdhci0 {
 	ti,driver-strength-ohm = <50>;
 	disable-wp;
 };
-
-&main_uart0 {
-	status = "disabled";
-};
-- 
2.37.3

