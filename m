Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F504611476
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiJ1OZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiJ1OYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:24:38 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE9FE41;
        Fri, 28 Oct 2022 07:24:31 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOLcl023819;
        Fri, 28 Oct 2022 09:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666967061;
        bh=Co7awRy3Xz2XTZgEsm+7R4njsey9lJWTDZmbVB0K4DA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Hq39yu6FLWt48WmQL03y3it86mUiIZ5oyuizWMGPk10c4R3AHKWD9pycONUCF+5rt
         sYJsnBuVOeLI7pRkQHpUC6wfFei4SxSMXIgJlbD2g3GXFT0415j+0oSEEyS5/3klz+
         ffYib+QAO80fnYa51zqlewEsHc3bWolCn2zgDrZ4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SEOK6v062524
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 09:24:20 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 09:24:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 09:24:20 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOHfS039275;
        Fri, 28 Oct 2022 09:24:20 -0500
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
Subject: [PATCH 03/11] arm64: dts: ti: k3-am65: Enable SPI nodes at the board level
Date:   Fri, 28 Oct 2022 09:24:09 -0500
Message-ID: <20221028142417.10642-4-afd@ti.com>
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

SPI nodes defined in the top-level AM65x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the SPI nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 1 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           | 5 +++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            | 3 +++
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 1 +
 4 files changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 945a8a70332e9..fa4b6eb02fa57 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -574,6 +574,7 @@ &usb1 {
 };
 
 &mcu_spi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_spi0_pins_default>;
 
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index feef5fdb46886..74fd807d47396 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -217,6 +217,7 @@ main_spi0: spi@2100000 {
 		#size-cells = <0>;
 		dmas = <&main_udmap 0xc500>, <&main_udmap 0x4500>;
 		dma-names = "tx0", "rx0";
+		status = "disabled";
 	};
 
 	main_spi1: spi@2110000 {
@@ -229,6 +230,7 @@ main_spi1: spi@2110000 {
 		#size-cells = <0>;
 		assigned-clocks = <&k3_clks 137 1>;
 		assigned-clock-rates = <48000000>;
+		status = "disabled";
 	};
 
 	main_spi2: spi@2120000 {
@@ -239,6 +241,7 @@ main_spi2: spi@2120000 {
 		power-domains = <&k3_pds 139 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 	};
 
 	main_spi3: spi@2130000 {
@@ -249,6 +252,7 @@ main_spi3: spi@2130000 {
 		power-domains = <&k3_pds 140 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 	};
 
 	main_spi4: spi@2140000 {
@@ -259,6 +263,7 @@ main_spi4: spi@2140000 {
 		power-domains = <&k3_pds 141 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 	};
 
 	sdhci0: mmc@4f80000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index dc0f439d2dacb..7a11501bad0bc 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -58,6 +58,7 @@ mcu_spi0: spi@40300000 {
 		power-domains = <&k3_pds 142 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 	};
 
 	mcu_spi1: spi@40310000 {
@@ -68,6 +69,7 @@ mcu_spi1: spi@40310000 {
 		power-domains = <&k3_pds 143 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 	};
 
 	mcu_spi2: spi@40320000 {
@@ -78,6 +80,7 @@ mcu_spi2: spi@40320000 {
 		power-domains = <&k3_pds 144 TI_SCI_PD_EXCLUSIVE>;
 		#address-cells = <1>;
 		#size-cells = <0>;
+		status = "disabled";
 	};
 
 	tscadc0: tscadc@40200000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 991a8559b4c3b..3f5a5ebfc8f3c 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -342,6 +342,7 @@ &ecap0 {
 };
 
 &main_spi0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_spi0_pins_default>;
 	#address-cells = <1>;
-- 
2.37.3

