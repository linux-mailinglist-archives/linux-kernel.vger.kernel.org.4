Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA1C7037C1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244183AbjEORX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244117AbjEORXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:23:24 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D287283D9;
        Mon, 15 May 2023 10:21:49 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FHLecv021830;
        Mon, 15 May 2023 12:21:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684171300;
        bh=UkMgU8qkn5zY4QqBdrumpMqK3iCsdBKO/ihSRtD5WSA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=k1TWFnyVTzF0pTPf6Q4qOjDdwx9rJwVjs/f2OBZEnFWa0kVfExr+HuKnP1yFuvDgD
         kaScYTrMiAnzhGzhtfGe4O1aSvp87TrvBtDZB3uNLMpJZeKUExP1JSQAYsRqguMePe
         kZ26cghbXMMw6LBz+3+tcyuTDvvGmZFZdwJmEVP4=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FHLeeo084152
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 12:21:40 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 12:21:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 12:21:40 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FHLcpW002823;
        Mon, 15 May 2023 12:21:39 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Nelson <robertcnelson@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 3/5] arm64: dts: ti: k3-j721e: Enable PCIe nodes at the board level
Date:   Mon, 15 May 2023 12:21:35 -0500
Message-ID: <20230515172137.474626-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230515172137.474626-1-afd@ti.com>
References: <20230515172137.474626-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCIe nodes defined in the top-level J721e SoC dtsi files are incomplete
and will not be functional unless they are extended with a SerDes PHY.
And usually only one of the two modes can be used at a time as they
share a SerDes link.

As the PHY and mode is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the PCIe nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../boot/dts/ti/k3-j721e-beagleboneai64.dts      | 16 +---------------
 .../boot/dts/ti/k3-j721e-common-proc-board.dts   |  7 +++----
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi        |  4 ++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts           | 12 ++----------
 4 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
index d77eeff0d81d..be0c5431119e 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts
@@ -872,12 +872,8 @@ serdes1_pcie_link: phy@0 {
 	};
 };
 
-&pcie0_rc {
-	/* Unused */
-	status = "disabled";
-};
-
 &pcie1_rc {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie1_rst_pins_default>;
 	phys = <&serdes1_pcie_link>;
@@ -887,16 +883,6 @@ &pcie1_rc {
 	reset-gpios = <&main_gpio0 22 GPIO_ACTIVE_HIGH>;
 };
 
-&pcie2_rc {
-	/* Unused */
-	status = "disabled";
-};
-
-&pcie3_rc {
-	/* Unused */
-	status = "disabled";
-};
-
 &icssg0_mdio {
 	/* Unused */
 	status = "disabled";
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 87b7263f6547..975a5161eb96 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -820,6 +820,7 @@ &mhdp {
 };
 
 &pcie0_rc {
+	status = "okay";
 	reset-gpios = <&exp1 6 GPIO_ACTIVE_HIGH>;
 	phys = <&serdes0_pcie_link>;
 	phy-names = "pcie-phy";
@@ -827,6 +828,7 @@ &pcie0_rc {
 };
 
 &pcie1_rc {
+	status = "okay";
 	reset-gpios = <&exp1 2 GPIO_ACTIVE_HIGH>;
 	phys = <&serdes1_pcie_link>;
 	phy-names = "pcie-phy";
@@ -834,16 +836,13 @@ &pcie1_rc {
 };
 
 &pcie2_rc {
+	status = "okay";
 	reset-gpios = <&exp2 20 GPIO_ACTIVE_HIGH>;
 	phys = <&serdes2_pcie_link>;
 	phy-names = "pcie-phy";
 	num-lanes = <2>;
 };
 
-&pcie3_rc {
-	status = "disabled";
-};
-
 &icssg0_mdio {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index e39f6d1e8d40..18f4661d37bf 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -814,6 +814,7 @@ pcie0_rc: pcie@2900000 {
 		ranges = <0x01000000 0x0 0x10001000 0x0 0x10001000 0x0 0x0010000>,
 			 <0x02000000 0x0 0x10011000 0x0 0x10011000 0x0 0x7fef000>;
 		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		status = "disabled";
 	};
 
 	pcie1_rc: pcie@2910000 {
@@ -842,6 +843,7 @@ pcie1_rc: pcie@2910000 {
 		ranges = <0x01000000 0x0 0x18001000 0x0 0x18001000 0x0 0x0010000>,
 			 <0x02000000 0x0 0x18011000 0x0 0x18011000 0x0 0x7fef000>;
 		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		status = "disabled";
 	};
 
 	pcie2_rc: pcie@2920000 {
@@ -870,6 +872,7 @@ pcie2_rc: pcie@2920000 {
 		ranges = <0x01000000 0x0 0x00001000 0x44 0x00001000 0x0 0x0010000>,
 			 <0x02000000 0x0 0x00011000 0x44 0x00011000 0x0 0x7fef000>;
 		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		status = "disabled";
 	};
 
 	pcie3_rc: pcie@2930000 {
@@ -898,6 +901,7 @@ pcie3_rc: pcie@2930000 {
 		ranges = <0x01000000 0x0 0x00001000 0x44 0x10001000 0x0 0x0010000>,
 			 <0x02000000 0x0 0x00011000 0x44 0x10011000 0x0 0x7fef000>;
 		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+		status = "disabled";
 	};
 
 	serdes_wiz4: wiz@5050000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 07d3282a583b..66a8559b3755 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -872,6 +872,7 @@ serdes1_pcie_link: phy@0 {
 };
 
 &pcie0_rc {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&ekey_reset_pins_default>;
 	reset-gpios = <&main_gpio0 72 GPIO_ACTIVE_HIGH>;
@@ -882,6 +883,7 @@ &pcie0_rc {
 };
 
 &pcie1_rc {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mkey_reset_pins_default>;
 	reset-gpios = <&wkup_gpio0 11 GPIO_ACTIVE_HIGH>;
@@ -891,16 +893,6 @@ &pcie1_rc {
 	num-lanes = <2>;
 };
 
-&pcie2_rc {
-	/* Unused */
-	status = "disabled";
-};
-
-&pcie3_rc {
-	/* Unused */
-	status = "disabled";
-};
-
 &icssg0_mdio {
 	status = "disabled";
 };
-- 
2.39.2

