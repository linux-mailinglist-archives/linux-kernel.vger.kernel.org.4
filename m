Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DC161147A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiJ1OYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJ1OYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:24:38 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5BEE53;
        Fri, 28 Oct 2022 07:24:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SEONXi023833;
        Fri, 28 Oct 2022 09:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666967063;
        bh=gZqEQtkesmyNbNaasIHOgX/OyIna1jM9BnRdk48NLkE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iM8FPHNlrsr4Uum7VI1OqsWsWZs8JWb86RfZUucZ8UbTssKjUG6SpQsMNfkd+7yt4
         yLUsPRDJeIn7kJcbskXmMXz4zzU0V7zwKhAWOlms3ZKcytDgK4mxvMsbIM0I+68tDd
         pVYCMAiSh4IlvG+sTBLDgypcdcG7PJrTNsivWwUk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SEON2x072896
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 09:24:23 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 09:24:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 09:24:23 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOHfW039275;
        Fri, 28 Oct 2022 09:24:22 -0500
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
Subject: [PATCH 07/11] arm64: dts: ti: k3-am65: Enable MDIO nodes at the board level
Date:   Fri, 28 Oct 2022 09:24:13 -0500
Message-ID: <20221028142417.10642-8-afd@ti.com>
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

MDIO nodes defined in the top-level AM65x SoC dtsi files are incomplete
and will not be functional unless they are extended with a pinmux.

As the attached PHY is only known about at the board integration level,
these nodes should only be enabled when provided with this information.

Disable the MDIO nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 12 ------------
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |  3 +++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |  1 +
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 13 +------------
 4 files changed, 5 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 56562081a8e52..35af8798f208e 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -732,18 +732,6 @@ &mcu_r5fss0_core1 {
 	mboxes = <&mailbox0_cluster1 &mbox_mcu_r5fss0_core1>;
 };
 
-&icssg0_mdio {
-	status = "disabled";
-};
-
-&icssg1_mdio {
-	status = "disabled";
-};
-
-&icssg2_mdio {
-	status = "disabled";
-};
-
 &mcasp0 {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index fbb631c7664d2..9cdde6e25e7de 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -1078,6 +1078,7 @@ icssg0_mdio: mdio@32400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			bus_freq = <1000000>;
+			status = "disabled";
 		};
 	};
 
@@ -1219,6 +1220,7 @@ icssg1_mdio: mdio@32400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			bus_freq = <1000000>;
+			status = "disabled";
 		};
 	};
 
@@ -1360,6 +1362,7 @@ icssg2_mdio: mdio@32400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			bus_freq = <1000000>;
+			status = "disabled";
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index 7a11501bad0bc..22f30174621e2 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -278,6 +278,7 @@ davinci_mdio: mdio@f00 {
 			clocks = <&k3_clks 5 10>;
 			clock-names = "fck";
 			bus_freq = <1000000>;
+			status = "disabled";
 		};
 
 		cpts@3d000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 0c63c24941061..beac2c563e831 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -533,6 +533,7 @@ &mcu_cpsw {
 };
 
 &davinci_mdio {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_mdio_pins_default>;
 
@@ -563,15 +564,3 @@ &mcasp2 {
 &dss {
 	status = "disabled";
 };
-
-&icssg0_mdio {
-	status = "disabled";
-};
-
-&icssg1_mdio {
-	status = "disabled";
-};
-
-&icssg2_mdio {
-	status = "disabled";
-};
-- 
2.37.3

