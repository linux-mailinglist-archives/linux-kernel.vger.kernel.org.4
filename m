Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D4D606557
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiJTQEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiJTQDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:03:36 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EC01C6BDC;
        Thu, 20 Oct 2022 09:03:32 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29KG3C21119651;
        Thu, 20 Oct 2022 11:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666281792;
        bh=kcY5uYbWeg/QqYGPXmbAHavgMgGV7xsQi3FmuAXMSYo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WViZQmyVJ+sMvpR+V3i3BwiRv/DUwB70z2S8Ov8DbELQEtsHWmgc9mcLJoqZWhRIb
         DsyvFKXzVs39/g+paq/O/HSkvK0c5dDDMhDrg6XBI92nRgjztARk0TcxqEoOQ4LSvn
         qkNuecv1BoFLBxAQr2ay9yUfcLmoEZwn8/5/63Pk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29KG3Cwh018031
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Oct 2022 11:03:12 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 20
 Oct 2022 11:03:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 20 Oct 2022 11:03:12 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29KG363G059665;
        Thu, 20 Oct 2022 11:03:11 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 08/12] arm64: dts: ti: k3-j721e: Enable Mailbox nodes at the board level
Date:   Thu, 20 Oct 2022 11:03:01 -0500
Message-ID: <20221020160305.18711-9-afd@ti.com>
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

Mailbox nodes defined in the top-level J721e SoC dtsi files are incomplete
and may not be functional unless they are extended with a chosen interrupt
and connection to a remote processor.

As the remote processors depend on memory nodes which are only known at
the board integration level, these nodes should only be enabled when
provided with the above information.

Disable the Mailbox nodes in the dtsi files and only enable the ones that
are actually used on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi   | 12 ++++++++
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts      | 33 ++++-----------------
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi | 33 ++++-----------------
 3 files changed, 22 insertions(+), 56 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 646885dd9f533..5c4a0e28cde56 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -176,6 +176,7 @@ mailbox0_cluster0: mailbox@31f80000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster1: mailbox@31f81000 {
@@ -185,6 +186,7 @@ mailbox0_cluster1: mailbox@31f81000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster2: mailbox@31f82000 {
@@ -194,6 +196,7 @@ mailbox0_cluster2: mailbox@31f82000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster3: mailbox@31f83000 {
@@ -203,6 +206,7 @@ mailbox0_cluster3: mailbox@31f83000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster4: mailbox@31f84000 {
@@ -212,6 +216,7 @@ mailbox0_cluster4: mailbox@31f84000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster5: mailbox@31f85000 {
@@ -221,6 +226,7 @@ mailbox0_cluster5: mailbox@31f85000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster6: mailbox@31f86000 {
@@ -230,6 +236,7 @@ mailbox0_cluster6: mailbox@31f86000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster7: mailbox@31f87000 {
@@ -239,6 +246,7 @@ mailbox0_cluster7: mailbox@31f87000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster8: mailbox@31f88000 {
@@ -248,6 +256,7 @@ mailbox0_cluster8: mailbox@31f88000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster9: mailbox@31f89000 {
@@ -257,6 +266,7 @@ mailbox0_cluster9: mailbox@31f89000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster10: mailbox@31f8a000 {
@@ -266,6 +276,7 @@ mailbox0_cluster10: mailbox@31f8a000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster11: mailbox@31f8b000 {
@@ -275,6 +286,7 @@ mailbox0_cluster11: mailbox@31f8b000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		main_ringacc: ringacc@3c000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index b7cb34007fb68..78aa4aa4de570 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -883,6 +883,7 @@ &ufs_wrapper {
 };
 
 &mailbox0_cluster0 {
+	status = "okay";
 	interrupts = <436>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
@@ -897,6 +898,7 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
 };
 
 &mailbox0_cluster1 {
+	status = "okay";
 	interrupts = <432>;
 
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
@@ -911,6 +913,7 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
 };
 
 &mailbox0_cluster2 {
+	status = "okay";
 	interrupts = <428>;
 
 	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
@@ -925,6 +928,7 @@ mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
 };
 
 &mailbox0_cluster3 {
+	status = "okay";
 	interrupts = <424>;
 
 	mbox_c66_0: mbox-c66-0 {
@@ -939,6 +943,7 @@ mbox_c66_1: mbox-c66-1 {
 };
 
 &mailbox0_cluster4 {
+	status = "okay";
 	interrupts = <420>;
 
 	mbox_c71_0: mbox-c71-0 {
@@ -947,34 +952,6 @@ mbox_c71_0: mbox-c71-0 {
 	};
 };
 
-&mailbox0_cluster5 {
-	status = "disabled";
-};
-
-&mailbox0_cluster6 {
-	status = "disabled";
-};
-
-&mailbox0_cluster7 {
-	status = "disabled";
-};
-
-&mailbox0_cluster8 {
-	status = "disabled";
-};
-
-&mailbox0_cluster9 {
-	status = "disabled";
-};
-
-&mailbox0_cluster10 {
-	status = "disabled";
-};
-
-&mailbox0_cluster11 {
-	status = "disabled";
-};
-
 &mcu_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
index e36335232cf8c..e289d5b443568 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
@@ -186,6 +186,7 @@ flash@0 {
 };
 
 &mailbox0_cluster0 {
+	status = "okay";
 	interrupts = <436>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
@@ -200,6 +201,7 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
 };
 
 &mailbox0_cluster1 {
+	status = "okay";
 	interrupts = <432>;
 
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
@@ -214,6 +216,7 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
 };
 
 &mailbox0_cluster2 {
+	status = "okay";
 	interrupts = <428>;
 
 	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
@@ -228,6 +231,7 @@ mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
 };
 
 &mailbox0_cluster3 {
+	status = "okay";
 	interrupts = <424>;
 
 	mbox_c66_0: mbox-c66-0 {
@@ -242,6 +246,7 @@ mbox_c66_1: mbox-c66-1 {
 };
 
 &mailbox0_cluster4 {
+	status = "okay";
 	interrupts = <420>;
 
 	mbox_c71_0: mbox-c71-0 {
@@ -250,34 +255,6 @@ mbox_c71_0: mbox-c71-0 {
 	};
 };
 
-&mailbox0_cluster5 {
-	status = "disabled";
-};
-
-&mailbox0_cluster6 {
-	status = "disabled";
-};
-
-&mailbox0_cluster7 {
-	status = "disabled";
-};
-
-&mailbox0_cluster8 {
-	status = "disabled";
-};
-
-&mailbox0_cluster9 {
-	status = "disabled";
-};
-
-&mailbox0_cluster10 {
-	status = "disabled";
-};
-
-&mailbox0_cluster11 {
-	status = "disabled";
-};
-
 &mcu_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster0 &mbox_mcu_r5fss0_core0>;
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
-- 
2.37.3

