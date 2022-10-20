Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F7F606553
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiJTQEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiJTQDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:03:33 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6929C1BA1F4;
        Thu, 20 Oct 2022 09:03:31 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29KG3Ar2111492;
        Thu, 20 Oct 2022 11:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666281790;
        bh=A61VeksPO2JTKOvbJOmrdchpKtmR7vhrw1X7uNcZM7c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=scMaJMrYlC4wCcYofXDhAZlUnU/66FR1R7mQs2Un1YoZ/uxUAAPm/tP/v1z/HBYWk
         StpGJhlRYmuRzBj0W44MJonPUGLsxcr1fGFfHJ4+2gukCsWy6BMEpswYdgyqiAzT83
         MrxN2Mi7LBU9p5M1qADdbFcBv+KYiPfd+DyeaHAg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29KG3Aj3014817
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Oct 2022 11:03:10 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 20
 Oct 2022 11:03:09 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 20 Oct 2022 11:03:09 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29KG363C059665;
        Thu, 20 Oct 2022 11:03:09 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 04/12] arm64: dts: ti: k3-j721e: Enable MCAN nodes at the board level
Date:   Thu, 20 Oct 2022 11:02:57 -0500
Message-ID: <20221020160305.18711-5-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221020160305.18711-1-afd@ti.com>
References: <20221020160305.18711-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MCAN nodes defined in the top-level J721e SoC dtsi files are incomplete
and may not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the MCAN nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 52 ++-----------------
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 14 +++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  2 +
 3 files changed, 20 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 6cee708e0d170..1861598f3bb40 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -878,73 +878,29 @@ &icssg1_mdio {
 };
 
 &mcu_mcan0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_mcan0_pins_default>;
 	phys = <&transceiver1>;
 };
 
 &mcu_mcan1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_mcan1_pins_default>;
 	phys = <&transceiver2>;
 };
 
 &main_mcan0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mcan0_pins_default>;
 	phys = <&transceiver3>;
 };
 
-&main_mcan1 {
-	status = "disabled";
-};
-
 &main_mcan2 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mcan2_pins_default>;
 	phys = <&transceiver4>;
 };
-
-&main_mcan3 {
-	status = "disabled";
-};
-
-&main_mcan4 {
-	status = "disabled";
-};
-
-&main_mcan5 {
-	status = "disabled";
-};
-
-&main_mcan6 {
-	status = "disabled";
-};
-
-&main_mcan7 {
-	status = "disabled";
-};
-
-&main_mcan8 {
-	status = "disabled";
-};
-
-&main_mcan9 {
-	status = "disabled";
-};
-
-&main_mcan10 {
-	status = "disabled";
-};
-
-&main_mcan11 {
-	status = "disabled";
-};
-
-&main_mcan12 {
-	status = "disabled";
-};
-
-&main_mcan13 {
-	status = "disabled";
-};
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 3706b319c46c6..646885dd9f533 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -2056,6 +2056,7 @@ main_mcan0: can@2701000 {
 			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan1: can@2711000 {
@@ -2070,6 +2071,7 @@ main_mcan1: can@2711000 {
 			     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan2: can@2721000 {
@@ -2084,6 +2086,7 @@ main_mcan2: can@2721000 {
 			     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan3: can@2731000 {
@@ -2098,6 +2101,7 @@ main_mcan3: can@2731000 {
 			     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan4: can@2741000 {
@@ -2112,6 +2116,7 @@ main_mcan4: can@2741000 {
 			     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan5: can@2751000 {
@@ -2126,6 +2131,7 @@ main_mcan5: can@2751000 {
 			     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan6: can@2761000 {
@@ -2140,6 +2146,7 @@ main_mcan6: can@2761000 {
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan7: can@2771000 {
@@ -2154,6 +2161,7 @@ main_mcan7: can@2771000 {
 			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan8: can@2781000 {
@@ -2168,6 +2176,7 @@ main_mcan8: can@2781000 {
 			     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan9: can@2791000 {
@@ -2182,6 +2191,7 @@ main_mcan9: can@2791000 {
 			     <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan10: can@27a1000 {
@@ -2196,6 +2206,7 @@ main_mcan10: can@27a1000 {
 			     <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan11: can@27b1000 {
@@ -2210,6 +2221,7 @@ main_mcan11: can@27b1000 {
 			     <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan12: can@27c1000 {
@@ -2224,6 +2236,7 @@ main_mcan12: can@27c1000 {
 			     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan13: can@27d1000 {
@@ -2238,5 +2251,6 @@ main_mcan13: can@27d1000 {
 			     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index 7bb6613796eab..f79e8100a7ac0 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -408,6 +408,7 @@ mcu_mcan0: can@40528000 {
 			     <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	mcu_mcan1: can@40568000 {
@@ -422,5 +423,6 @@ mcu_mcan1: can@40568000 {
 			     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 };
-- 
2.37.3

