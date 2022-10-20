Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D38606542
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiJTQDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiJTQD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:03:27 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E50C1B233B;
        Thu, 20 Oct 2022 09:03:26 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29KG3EZD111507;
        Thu, 20 Oct 2022 11:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666281794;
        bh=n/zWGIdbPP2eH7h5ptYjxE8fUE1q9XeW8ObJv/whozQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=etsQm3VE4kqeSTQXVSg9BqrR67ed4keLznhpP2l6wiMS5AbULzZFF8VAEndCj5w+B
         GgsADCL/fGQ5y9TwJtb0mk+aRuJ+MNXy7aG8gL8ubPNuQaStICOLO2HwK1tDrFmFqo
         6QXqOhpq5byg1xt2g42B6Nq0mCE6sHiMY8EjpY58=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29KG3ERA014834
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Oct 2022 11:03:14 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 20
 Oct 2022 11:03:13 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 20 Oct 2022 11:03:13 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29KG363I059665;
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
Subject: [PATCH 10/12] arm64: dts: ti: k3-j721s2: Enable Mailbox nodes at the board level
Date:   Thu, 20 Oct 2022 11:03:03 -0500
Message-ID: <20221020160305.18711-11-afd@ti.com>
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

Mailbox nodes defined in the top-level J721s2 SoC dtsi files are incomplete
and may not be functional unless they are extended with a chosen interrupt
and connection to a remote processor.

As the remote processors depend on memory nodes which are only known at
the board integration level, these nodes should only be enabled when
provided with the above information.

Disable the Mailbox nodes in the dtsi files and only enable the ones that
are actually used on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi   | 24 +++++
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi | 96 --------------------
 2 files changed, 24 insertions(+), 96 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 7267a7b665ce8..ddc54921d34f6 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -438,6 +438,7 @@ mailbox0_cluster0: mailbox@31f80000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster1: mailbox@31f81000 {
@@ -447,6 +448,7 @@ mailbox0_cluster1: mailbox@31f81000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster2: mailbox@31f82000 {
@@ -456,6 +458,7 @@ mailbox0_cluster2: mailbox@31f82000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster3: mailbox@31f83000 {
@@ -465,6 +468,7 @@ mailbox0_cluster3: mailbox@31f83000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster4: mailbox@31f84000 {
@@ -474,6 +478,7 @@ mailbox0_cluster4: mailbox@31f84000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster5: mailbox@31f85000 {
@@ -483,6 +488,7 @@ mailbox0_cluster5: mailbox@31f85000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster6: mailbox@31f86000 {
@@ -492,6 +498,7 @@ mailbox0_cluster6: mailbox@31f86000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster7: mailbox@31f87000 {
@@ -501,6 +508,7 @@ mailbox0_cluster7: mailbox@31f87000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster8: mailbox@31f88000 {
@@ -510,6 +518,7 @@ mailbox0_cluster8: mailbox@31f88000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster9: mailbox@31f89000 {
@@ -519,6 +528,7 @@ mailbox0_cluster9: mailbox@31f89000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster10: mailbox@31f8a000 {
@@ -528,6 +538,7 @@ mailbox0_cluster10: mailbox@31f8a000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox0_cluster11: mailbox@31f8b000 {
@@ -537,6 +548,7 @@ mailbox0_cluster11: mailbox@31f8b000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster0: mailbox@31f90000 {
@@ -546,6 +558,7 @@ mailbox1_cluster0: mailbox@31f90000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster1: mailbox@31f91000 {
@@ -555,6 +568,7 @@ mailbox1_cluster1: mailbox@31f91000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster2: mailbox@31f92000 {
@@ -564,6 +578,7 @@ mailbox1_cluster2: mailbox@31f92000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster3: mailbox@31f93000 {
@@ -573,6 +588,7 @@ mailbox1_cluster3: mailbox@31f93000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster4: mailbox@31f94000 {
@@ -582,6 +598,7 @@ mailbox1_cluster4: mailbox@31f94000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster5: mailbox@31f95000 {
@@ -591,6 +608,7 @@ mailbox1_cluster5: mailbox@31f95000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster6: mailbox@31f96000 {
@@ -600,6 +618,7 @@ mailbox1_cluster6: mailbox@31f96000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster7: mailbox@31f97000 {
@@ -609,6 +628,7 @@ mailbox1_cluster7: mailbox@31f97000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster8: mailbox@31f98000 {
@@ -618,6 +638,7 @@ mailbox1_cluster8: mailbox@31f98000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster9: mailbox@31f99000 {
@@ -627,6 +648,7 @@ mailbox1_cluster9: mailbox@31f99000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster10: mailbox@31f9a000 {
@@ -636,6 +658,7 @@ mailbox1_cluster10: mailbox@31f9a000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		mailbox1_cluster11: mailbox@31f9b000 {
@@ -645,6 +668,7 @@ mailbox1_cluster11: mailbox@31f9b000 {
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <16>;
 			interrupt-parent = <&main_navss_intr>;
+			status = "disabled";
 		};
 
 		main_ringacc: ringacc@3c000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
index 76f0ceacb6d46..d25f38d896c01 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi
@@ -77,99 +77,3 @@ &main_mcan16 {
 	pinctrl-names = "default";
 	phys = <&transceiver0>;
 };
-
-&mailbox0_cluster0 {
-	status = "disabled";
-};
-
-&mailbox0_cluster1 {
-	status = "disabled";
-};
-
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
-&mailbox1_cluster0 {
-	status = "disabled";
-};
-
-&mailbox1_cluster1 {
-	status = "disabled";
-};
-
-&mailbox1_cluster2 {
-	status = "disabled";
-};
-
-&mailbox1_cluster3 {
-	status = "disabled";
-};
-
-&mailbox1_cluster4 {
-	status = "disabled";
-};
-
-&mailbox1_cluster5 {
-	status = "disabled";
-};
-
-&mailbox1_cluster6 {
-	status = "disabled";
-};
-
-&mailbox1_cluster7 {
-	status = "disabled";
-};
-
-&mailbox1_cluster8 {
-	status = "disabled";
-};
-
-&mailbox1_cluster9 {
-	status = "disabled";
-};
-
-&mailbox1_cluster10 {
-	status = "disabled";
-};
-
-&mailbox1_cluster11 {
-	status = "disabled";
-};
-- 
2.37.3

