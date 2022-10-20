Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0C1606556
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiJTQEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiJTQDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:03:33 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790001BA1F5;
        Thu, 20 Oct 2022 09:03:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29KG3Elu014356;
        Thu, 20 Oct 2022 11:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666281794;
        bh=UXIa3cdmMjraRNHMJ3nb7qdvOQakDFGnfnJ8k7bjd1U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Y0PwDC8g4v27Nt7bQ+5sk8tfu9a5xhBcdTPVxD7dvj+EdYzyeQVTzRUrrREu7pzE6
         JU/v7SmfTBzr7P61f+kg3ngg80j97BWPt0vuw2cb+9Z7m6SA7V67Q2W2K6tIBsTiM6
         lqQkyygS0rAApQPXCKV3b9Y4Qg4J0eGY4kDWfKJA=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29KG3Ehx052198
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Oct 2022 11:03:14 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 20
 Oct 2022 11:03:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 20 Oct 2022 11:03:14 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29KG363J059665;
        Thu, 20 Oct 2022 11:03:13 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 11/12] arm64: dts: ti: k3-j721s2: Enable MCAN nodes at the board level
Date:   Thu, 20 Oct 2022 11:03:04 -0500
Message-ID: <20221020160305.18711-12-afd@ti.com>
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

MCAN nodes defined in the top-level J721s2 SoC dtsi files are incomplete
and may not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the MCAN nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 70 +------------------
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 18 +++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  2 +
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi  |  1 +
 4 files changed, 23 insertions(+), 68 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index 9f1a0ca4dc372..3f4106f76893b 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -321,81 +321,15 @@ &cpsw_port1 {
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
-
-&main_mcan0 {
-	status = "disabled";
-};
-
-&main_mcan1 {
-	status = "disabled";
-};
-
-&main_mcan2 {
-	status = "disabled";
-};
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
-
-&main_mcan14 {
-	status = "disabled";
-};
-
-&main_mcan15 {
-	status = "disabled";
-};
-
-&main_mcan17 {
-	status = "disabled";
-};
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index ddc54921d34f6..1c18d6df6361a 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -732,6 +732,7 @@ main_mcan0: can@2701000 {
 			     <GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan1: can@2711000 {
@@ -746,6 +747,7 @@ main_mcan1: can@2711000 {
 			     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan2: can@2721000 {
@@ -760,6 +762,7 @@ main_mcan2: can@2721000 {
 			     <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan3: can@2731000 {
@@ -774,6 +777,7 @@ main_mcan3: can@2731000 {
 			     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan4: can@2741000 {
@@ -788,6 +792,7 @@ main_mcan4: can@2741000 {
 			     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan5: can@2751000 {
@@ -802,6 +807,7 @@ main_mcan5: can@2751000 {
 			     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan6: can@2761000 {
@@ -816,6 +822,7 @@ main_mcan6: can@2761000 {
 			     <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan7: can@2771000 {
@@ -830,6 +837,7 @@ main_mcan7: can@2771000 {
 			     <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan8: can@2781000 {
@@ -844,6 +852,7 @@ main_mcan8: can@2781000 {
 			     <GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan9: can@2791000 {
@@ -858,6 +867,7 @@ main_mcan9: can@2791000 {
 			     <GIC_SPI 580 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan10: can@27a1000 {
@@ -872,6 +882,7 @@ main_mcan10: can@27a1000 {
 			     <GIC_SPI 583 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan11: can@27b1000 {
@@ -886,6 +897,7 @@ main_mcan11: can@27b1000 {
 			     <GIC_SPI 586 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan12: can@27c1000 {
@@ -900,6 +912,7 @@ main_mcan12: can@27c1000 {
 			     <GIC_SPI 589 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan13: can@27d1000 {
@@ -914,6 +927,7 @@ main_mcan13: can@27d1000 {
 			     <GIC_SPI 592 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan14: can@2681000 {
@@ -928,6 +942,7 @@ main_mcan14: can@2681000 {
 			     <GIC_SPI 595 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan15: can@2691000 {
@@ -942,6 +957,7 @@ main_mcan15: can@2691000 {
 			     <GIC_SPI 598 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan16: can@26a1000 {
@@ -956,6 +972,7 @@ main_mcan16: can@26a1000 {
 			     <GIC_SPI 785 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	main_mcan17: can@26b1000 {
@@ -970,5 +987,6 @@ main_mcan17: can@26b1000 {
 			     <GIC_SPI 788 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 3de4218e8e125..d1dd40a6e42a4 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -182,6 +182,7 @@ mcu_mcan0: can@40528000 {
 			     <GIC_SPI 833 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	mcu_mcan1: can@40568000 {
@@ -196,6 +197,7 @@ mcu_mcan1: can@40568000 {
 			     <GIC_SPI 836 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "int0", "int1";
 		bosch,mram-cfg = <0x0 128 64 64 64 64 32 32>;
+		status = "disabled";
 	};
 
 	mcu_navss: bus@28380000{
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
index d25f38d896c01..a2cb0916e4a2f 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -73,6 +73,7 @@ exp_som: gpio@21 {
 };
 
 &main_mcan16 {
+	status = "okay";
 	pinctrl-0 = <&main_mcan16_pins_default>;
 	pinctrl-names = "default";
 	phys = <&transceiver0>;
-- 
2.37.3

