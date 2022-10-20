Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27C060654F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiJTQEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiJTQDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:03:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53671BA1E4;
        Thu, 20 Oct 2022 09:03:28 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29KG3A5l111496;
        Thu, 20 Oct 2022 11:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666281790;
        bh=O6ADqTPdD5Tic9neBcR7WD65f0JXwn/ENRFI9McDgro=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fUxbW6Qt/770NcNRjmpwHtrf+YBgjhCR0zv5romyQNDRIWsdILK53Qd2mTFEsuij2
         kCm8oz27snzr1gN5CdNKuJIMwZH8PkTbpUXxxmCCu+7PuSMeSdmhLshvvIMvL++7Ch
         B4Aqy47F7ObMvTwq4s5THSpO9UBYXl9cOWW2N8+U=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29KG3AZn014820
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Oct 2022 11:03:10 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 20
 Oct 2022 11:03:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 20 Oct 2022 11:03:10 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29KG363D059665;
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
Subject: [PATCH 05/12] arm64: dts: ti: k3-j7200: Enable UART nodes at the board level
Date:   Thu, 20 Oct 2022 11:02:58 -0500
Message-ID: <20221020160305.18711-6-afd@ti.com>
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

UART nodes defined in the top-level J7200 SoC dtsi files are incomplete
and may not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the UART nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../dts/ti/k3-j7200-common-proc-board.dts     | 46 +++++--------------
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 10 ++++
 .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  2 +
 3 files changed, 23 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
index 7e8552fd2b6ae..bc3d1831f5cda 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
@@ -154,51 +154,27 @@ &wkup_uart0 {
 	status = "reserved";
 };
 
+&mcu_uart0 {
+	status = "okay";
+	/* Default pinmux */
+};
+
 &main_uart0 {
+	status = "okay";
 	/* Shared with ATF on this platform */
 	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
 };
 
+&main_uart1 {
+	status = "okay";
+	/* Default pinmux */
+};
+
 &main_uart2 {
 	/* MAIN UART 2 is used by R5F firmware */
 	status = "reserved";
 };
 
-&main_uart3 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
-&main_uart4 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
-&main_uart5 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
-&main_uart6 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
-&main_uart7 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
-&main_uart8 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
-&main_uart9 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
 &main_gpio2 {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
index 80a57916bcb3e..f9aefd3dbdcaf 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
@@ -319,6 +319,7 @@ main_uart0: serial@2800000 {
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 146 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart1: serial@2810000 {
@@ -330,6 +331,7 @@ main_uart1: serial@2810000 {
 		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 278 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart2: serial@2820000 {
@@ -341,6 +343,7 @@ main_uart2: serial@2820000 {
 		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 279 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart3: serial@2830000 {
@@ -352,6 +355,7 @@ main_uart3: serial@2830000 {
 		power-domains = <&k3_pds 280 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 280 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart4: serial@2840000 {
@@ -363,6 +367,7 @@ main_uart4: serial@2840000 {
 		power-domains = <&k3_pds 281 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 281 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart5: serial@2850000 {
@@ -374,6 +379,7 @@ main_uart5: serial@2850000 {
 		power-domains = <&k3_pds 282 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 282 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart6: serial@2860000 {
@@ -385,6 +391,7 @@ main_uart6: serial@2860000 {
 		power-domains = <&k3_pds 283 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 283 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart7: serial@2870000 {
@@ -396,6 +403,7 @@ main_uart7: serial@2870000 {
 		power-domains = <&k3_pds 284 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 284 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart8: serial@2880000 {
@@ -407,6 +415,7 @@ main_uart8: serial@2880000 {
 		power-domains = <&k3_pds 285 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 285 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart9: serial@2890000 {
@@ -418,6 +427,7 @@ main_uart9: serial@2890000 {
 		power-domains = <&k3_pds 286 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 286 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_i2c0: i2c@2000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
index e5be78a58682d..7c205b347f813 100644
--- a/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
@@ -79,6 +79,7 @@ wkup_uart0: serial@42300000 {
 		power-domains = <&k3_pds 287 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 287 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	mcu_uart0: serial@40a00000 {
@@ -90,6 +91,7 @@ mcu_uart0: serial@40a00000 {
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 149 2>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	wkup_gpio_intr: interrupt-controller@42200000 {
-- 
2.37.3

