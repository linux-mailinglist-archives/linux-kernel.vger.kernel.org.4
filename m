Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C060178D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJQT0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiJQT0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:16 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437F47437B;
        Mon, 17 Oct 2022 12:26:03 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPZE0121476;
        Mon, 17 Oct 2022 14:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666034735;
        bh=yWwa9flCSHI0XJGO/aILCKXmb9ns8dPHZT2Xl3FDT+s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=h7eQdVKYUFlkymsnGVm1gmg4sdtkrGOoAtgx8fOa3EaIVcayhx0k0DOtZiDVzuzjz
         42UY9kyMFBx9wMrF754fWMSm+z271IvW/snuqOCoxzG/BTYMrkxbDaja2UluumWT1W
         h8YkJgno9hNXDrAHaInQbhLok5Fl8HnzeMjY27x4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29HJPZdG086709
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Oct 2022 14:25:35 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 17
 Oct 2022 14:25:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 17 Oct 2022 14:25:35 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPWXL026106;
        Mon, 17 Oct 2022 14:25:34 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 04/10] arm64: dts: ti: k3-am64: Enable EPWM nodes at the board level
Date:   Mon, 17 Oct 2022 14:25:26 -0500
Message-ID: <20221017192532.23825-5-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221017192532.23825-1-afd@ti.com>
References: <20221017192532.23825-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EPWM nodes defined in the top-level AM64x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the EPWM nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi |  9 +++++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 36 -------------------
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 44 ------------------------
 3 files changed, 9 insertions(+), 80 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index 375078ca4fdd..672575f44529 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -898,6 +898,7 @@ epwm0: pwm@23000000 {
 		power-domains = <&k3_pds 86 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&epwm_tbclk 0>, <&k3_clks 86 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	epwm1: pwm@23010000 {
@@ -907,6 +908,7 @@ epwm1: pwm@23010000 {
 		power-domains = <&k3_pds 87 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&epwm_tbclk 1>, <&k3_clks 87 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	epwm2: pwm@23020000 {
@@ -916,6 +918,7 @@ epwm2: pwm@23020000 {
 		power-domains = <&k3_pds 88 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&epwm_tbclk 2>, <&k3_clks 88 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	epwm3: pwm@23030000 {
@@ -925,6 +928,7 @@ epwm3: pwm@23030000 {
 		power-domains = <&k3_pds 89 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&epwm_tbclk 3>, <&k3_clks 89 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	epwm4: pwm@23040000 {
@@ -934,6 +938,7 @@ epwm4: pwm@23040000 {
 		power-domains = <&k3_pds 90 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&epwm_tbclk 4>, <&k3_clks 90 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	epwm5: pwm@23050000 {
@@ -943,6 +948,7 @@ epwm5: pwm@23050000 {
 		power-domains = <&k3_pds 91 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&epwm_tbclk 5>, <&k3_clks 91 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	epwm6: pwm@23060000 {
@@ -952,6 +958,7 @@ epwm6: pwm@23060000 {
 		power-domains = <&k3_pds 92 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&epwm_tbclk 6>, <&k3_clks 92 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	epwm7: pwm@23070000 {
@@ -961,6 +968,7 @@ epwm7: pwm@23070000 {
 		power-domains = <&k3_pds 93 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&epwm_tbclk 7>, <&k3_clks 93 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	epwm8: pwm@23080000 {
@@ -970,6 +978,7 @@ epwm8: pwm@23080000 {
 		power-domains = <&k3_pds 94 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&epwm_tbclk 8>, <&k3_clks 94 0>;
 		clock-names = "tbclk", "fck";
+		status = "disabled";
 	};
 
 	ecap0: pwm@23100000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 12d971c3bc3a..cef3afa10c39 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -580,42 +580,6 @@ &ecap2 {
 	status = "disabled";
 };
 
-&epwm0 {
-	status = "disabled";
-};
-
-&epwm1 {
-	status = "disabled";
-};
-
-&epwm2 {
-	status = "disabled";
-};
-
-&epwm3 {
-	status = "disabled";
-};
-
-&epwm4 {
-	status = "disabled";
-};
-
-&epwm5 {
-	status = "disabled";
-};
-
-&epwm6 {
-	status = "disabled";
-};
-
-&epwm7 {
-	status = "disabled";
-};
-
-&epwm8 {
-	status = "disabled";
-};
-
 &icssg0_mdio {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 1a116593a771..51f4ae165c13 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -579,50 +579,6 @@ &ecap2 {
 	status = "disabled";
 };
 
-&epwm0 {
-	status = "disabled";
-};
-
-&epwm1 {
-	status = "disabled";
-};
-
-&epwm2 {
-	status = "disabled";
-};
-
-&epwm3 {
-	status = "disabled";
-};
-
-&epwm4 {
-	/*
-	 * EPWM4_A, EPWM4_B is available on Pin 32 and 33 on J4 (RPi hat)
-	 * But RPi Hat will be used for other use cases, so marking epwm4 as disabled.
-	 */
-	status = "disabled";
-};
-
-&epwm5 {
-	/*
-	 * EPWM5_A, EPWM5_B is available on Pin 29 and 31 on J4 (RPi hat)
-	 * But RPi Hat will be used for other use cases, so marking epwm5 as disabled.
-	 */
-	status = "disabled";
-};
-
-&epwm6 {
-	status = "disabled";
-};
-
-&epwm7 {
-	status = "disabled";
-};
-
-&epwm8 {
-	status = "disabled";
-};
-
 &icssg0_mdio {
 	status = "disabled";
 };
-- 
2.37.3

