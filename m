Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3002161147D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiJ1OZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiJ1OYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:24:39 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07246F4A;
        Fri, 28 Oct 2022 07:24:33 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOPQP112739;
        Fri, 28 Oct 2022 09:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666967065;
        bh=2LMWQyP+bgjUmm7WcOjgs5fr29QpsF7kVkLDaI7K+YQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cih8tGxTRFthtrNp5VVFRR2hECktZ6RmLsO5s0vFW4GC9K50V2PqTWJrRPwDwovSv
         aIriggGBknPQ5hQz2z0b3QQknDqmSrv4DhT53EV5smIbkeOKbAdeqzAeZD+Z6k/MDB
         aMlS/wCvJ7+4T8hErIBuvBiXbdeyJT8Rj9E6eceQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SEOP2d045505
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 09:24:25 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 09:24:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 09:24:25 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOHfZ039275;
        Fri, 28 Oct 2022 09:24:24 -0500
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
Subject: [PATCH 10/11] arm64: dts: ti: k3-am65: Enable Mailbox nodes at the board level
Date:   Fri, 28 Oct 2022 09:24:16 -0500
Message-ID: <20221028142417.10642-11-afd@ti.com>
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

Mailbox nodes defined in the top-level AM65x SoC dtsi files are incomplete
and may not be functional unless they are extended with a chosen interrupt
and connection to a remote processor.

As the remote processors depend on memory nodes which are only known at
the board integration level, these nodes should only be enabled when
provided with the above information.

Disable the Mailbox nodes in the dtsi files and only enable the ones that
are actually used on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 42 +------------------
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 12 ++++++
 .../arm64/boot/dts/ti/k3-am654-base-board.dts | 42 +------------------
 3 files changed, 16 insertions(+), 80 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index dd7c6aee8c613..c6c79dde79c52 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -644,6 +644,7 @@ &pcie1_rc {
 };
 
 &mailbox0_cluster0 {
+	status = "okay";
 	interrupts = <436>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
@@ -653,6 +654,7 @@ mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
 };
 
 &mailbox0_cluster1 {
+	status = "okay";
 	interrupts = <432>;
 
 	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
@@ -661,46 +663,6 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
 	};
 };
 
-&mailbox0_cluster2 {
-	status = "disabled";
-};
-
-&mailbox0_cluster3 {
-	status = "disabled";
-};
-
-&mailbox0_cluster4 {
-	status = "disabled";
-};
-
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
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index 9081c791a3123..3dc624a379c5f 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -514,6 +514,7 @@ mailbox0_cluster0: mailbox@31f80000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster1: mailbox@31f81000 {
@@ -523,6 +524,7 @@ mailbox0_cluster1: mailbox@31f81000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster2: mailbox@31f82000 {
@@ -532,6 +534,7 @@ mailbox0_cluster2: mailbox@31f82000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster3: mailbox@31f83000 {
@@ -541,6 +544,7 @@ mailbox0_cluster3: mailbox@31f83000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster4: mailbox@31f84000 {
@@ -550,6 +554,7 @@ mailbox0_cluster4: mailbox@31f84000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster5: mailbox@31f85000 {
@@ -559,6 +564,7 @@ mailbox0_cluster5: mailbox@31f85000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster6: mailbox@31f86000 {
@@ -568,6 +574,7 @@ mailbox0_cluster6: mailbox@31f86000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster7: mailbox@31f87000 {
@@ -577,6 +584,7 @@ mailbox0_cluster7: mailbox@31f87000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster8: mailbox@31f88000 {
@@ -586,6 +594,7 @@ mailbox0_cluster8: mailbox@31f88000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster9: mailbox@31f89000 {
@@ -595,6 +604,7 @@ mailbox0_cluster9: mailbox@31f89000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster10: mailbox@31f8a000 {
@@ -604,6 +614,7 @@ mailbox0_cluster10: mailbox@31f8a000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster11: mailbox@31f8b000 {
@@ -613,6 +624,7 @@ mailbox0_cluster11: mailbox@31f8b000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&intr_main_navss>;
+			status = "disabled";
 		};
 
 		ringacc: ringacc@3c000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index a61060c6bc198..d1c8047d96726 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -416,6 +416,7 @@ &serdes1 {
 };
 
 &mailbox0_cluster0 {
+	status = "okay";
 	interrupts = <436>;
 
 	mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
@@ -425,6 +426,7 @@ mbox_mcu_r5fss0_core0: mbox-mcu-r5fss0-core0 {
 };
 
 &mailbox0_cluster1 {
+	status = "okay";
 	interrupts = <432>;
 
 	mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
@@ -433,46 +435,6 @@ mbox_mcu_r5fss0_core1: mbox-mcu-r5fss0-core1 {
 	};
 };
 
-&mailbox0_cluster2 {
-	status = "disabled";
-};
-
-&mailbox0_cluster3 {
-	status = "disabled";
-};
-
-&mailbox0_cluster4 {
-	status = "disabled";
-};
-
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
 	memory-region = <&mcu_r5fss0_core0_dma_memory_region>,
 			<&mcu_r5fss0_core0_memory_region>;
-- 
2.37.3

