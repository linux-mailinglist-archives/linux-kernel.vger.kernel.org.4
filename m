Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA16C7037BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243912AbjEORXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244080AbjEORXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:23:24 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1788C86AE;
        Mon, 15 May 2023 10:21:50 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34FHLf4c066040;
        Mon, 15 May 2023 12:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1684171301;
        bh=guP5zIgnhtmLQmDly2D/lcCTX0nDXiP1uwheXUoQFWA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ymKXY3iJeZ/7S92AdtzJ7TeOEMvs0Xhlog6FwS4ybEZ+uBAQYNJ5ePLEjR+6qYOFn
         Ip6xyJilUx2C2G4knNdur81yAyIGcJWJ0M7q3b6qpdR8mgg0HFXZiDo+M9K3uEWd02
         yaYDyxHTf8Y2th8E8kfFYzfNifqQSjIVgLYc3rOE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34FHLfAl010864
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 15 May 2023 12:21:41 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 15
 May 2023 12:21:40 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 15 May 2023 12:21:40 -0500
Received: from lelv0327.itg.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34FHLcpX002823;
        Mon, 15 May 2023 12:21:40 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Nelson <robertcnelson@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 4/5] arm64: dts: ti: k3-am64: Enable Mailbox nodes at the board level
Date:   Mon, 15 May 2023 12:21:36 -0500
Message-ID: <20230515172137.474626-4-afd@ti.com>
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

Mailbox nodes defined in the top-level AM64x SoC dtsi files are incomplete
and may not be functional unless they are extended with a chosen interrupt
and connection to a remote processor.

As the remote processors depend on memory nodes which are only known at
the board integration level, these nodes should only be enabled when
provided with the above information.

Disable the Mailbox nodes in the dtsi files and only enable the ones that
are actually used on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi      |  6 +++++
 .../boot/dts/ti/k3-am64-phycore-som.dtsi      | 24 -------------------
 arch/arm64/boot/dts/ti/k3-am642-evm.dts       | 18 +++++---------
 arch/arm64/boot/dts/ti/k3-am642-sk.dts        | 18 +++++---------
 4 files changed, 18 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 5e8036f32d79..a474232fba0e 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -676,6 +676,7 @@ mailbox0_cluster2: mailbox@29020000 {
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster3: mailbox@29030000 {
@@ -686,6 +687,7 @@ mailbox0_cluster3: mailbox@29030000 {
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster4: mailbox@29040000 {
@@ -696,6 +698,7 @@ mailbox0_cluster4: mailbox@29040000 {
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster5: mailbox@29050000 {
@@ -706,6 +709,7 @@ mailbox0_cluster5: mailbox@29050000 {
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster6: mailbox@29060000 {
@@ -715,6 +719,7 @@ mailbox0_cluster6: mailbox@29060000 {
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	mailbox0_cluster7: mailbox@29070000 {
@@ -724,6 +729,7 @@ mailbox0_cluster7: mailbox@29070000 {
 		#mbox-cells = <1>;
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
+		status = "disabled";
 	};
 
 	main_r5fss0: r5fss@78000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
index 8dfb6301b17d..7c2e26ef726c 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
@@ -160,30 +160,6 @@ &cpsw_port2 {
 	status = "disabled";
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
 &main_i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 39feea78a084..a8f5be51de8f 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -475,6 +475,8 @@ flash@0 {
 };
 
 &mailbox0_cluster2 {
+	status = "okay";
+
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
 		ti,mbox-rx = <0 0 2>;
 		ti,mbox-tx = <1 0 2>;
@@ -486,11 +488,9 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
 	};
 };
 
-&mailbox0_cluster3 {
-	status = "disabled";
-};
-
 &mailbox0_cluster4 {
+	status = "okay";
+
 	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
 		ti,mbox-rx = <0 0 2>;
 		ti,mbox-tx = <1 0 2>;
@@ -502,21 +502,15 @@ mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
 	};
 };
 
-&mailbox0_cluster5 {
-	status = "disabled";
-};
-
 &mailbox0_cluster6 {
+	status = "okay";
+
 	mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 2>;
 		ti,mbox-tx = <1 0 2>;
 	};
 };
 
-&mailbox0_cluster7 {
-	status = "disabled";
-};
-
 &main_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 2e2d40da360a..97414898c5c0 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -494,6 +494,8 @@ flash@0 {
 };
 
 &mailbox0_cluster2 {
+	status = "okay";
+
 	mbox_main_r5fss0_core0: mbox-main-r5fss0-core0 {
 		ti,mbox-rx = <0 0 2>;
 		ti,mbox-tx = <1 0 2>;
@@ -505,11 +507,9 @@ mbox_main_r5fss0_core1: mbox-main-r5fss0-core1 {
 	};
 };
 
-&mailbox0_cluster3 {
-	status = "disabled";
-};
-
 &mailbox0_cluster4 {
+	status = "okay";
+
 	mbox_main_r5fss1_core0: mbox-main-r5fss1-core0 {
 		ti,mbox-rx = <0 0 2>;
 		ti,mbox-tx = <1 0 2>;
@@ -521,21 +521,15 @@ mbox_main_r5fss1_core1: mbox-main-r5fss1-core1 {
 	};
 };
 
-&mailbox0_cluster5 {
-	status = "disabled";
-};
-
 &mailbox0_cluster6 {
+	status = "okay";
+
 	mbox_m4_0: mbox-m4-0 {
 		ti,mbox-rx = <0 0 2>;
 		ti,mbox-tx = <1 0 2>;
 	};
 };
 
-&mailbox0_cluster7 {
-	status = "disabled";
-};
-
 &main_r5fss0_core0 {
 	mboxes = <&mailbox0_cluster2 &mbox_main_r5fss0_core0>;
 	memory-region = <&main_r5fss0_core0_dma_memory_region>,
-- 
2.39.2

