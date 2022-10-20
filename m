Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9C8606551
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiJTQEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJTQDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:03:32 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB271BA1F2;
        Thu, 20 Oct 2022 09:03:30 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29KG37Bq005188;
        Thu, 20 Oct 2022 11:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666281787;
        bh=DyQWcVMVSf1fdWTs1YaebqdYIHq4T1NiKjgf/LlvdyU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mT5t/0OtkhrHoAiHt+UCJvQxeOG8aGaCMhNgEGcFITZUV2UCJBzwafm3HpJDsGLrF
         zLgvpmNvBN47C1EXt5zfpBPAHLrv+GTrtMMXcAm5zjUkODW/c1xZ80nLh1Rcmu0ywi
         fwkzbgRPCNLUaGAZfWfx7yJZVDsiEuUBDGXyCTBQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29KG37e1014806
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Oct 2022 11:03:07 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 20
 Oct 2022 11:03:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 20 Oct 2022 11:03:07 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29KG3639059665;
        Thu, 20 Oct 2022 11:03:06 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 01/12] arm64: dts: ti: k3-j721e: Enable UART nodes at the board level
Date:   Thu, 20 Oct 2022 11:02:54 -0500
Message-ID: <20221020160305.18711-2-afd@ti.com>
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

UART nodes defined in the top-level J721e SoC dtsi files are incomplete
and may not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the UART nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 40 +++++++-----------
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 10 +++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  2 +
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 42 ++++---------------
 4 files changed, 37 insertions(+), 57 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index b1691ac3442dc..01afacfe6faaa 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -370,38 +370,30 @@ &wkup_uart0 {
 	status = "reserved";
 };
 
-&main_uart0 {
-	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
-};
-
-&main_uart3 {
-	/* UART not brought out */
-	status = "disabled";
-};
-
-&main_uart5 {
-	/* UART not brought out */
-	status = "disabled";
+&mcu_uart0 {
+	status = "okay";
+	/* Default pinmux */
 };
 
-&main_uart6 {
-	/* UART not brought out */
-	status = "disabled";
+&main_uart0 {
+	status = "okay";
+	/* Shared with ATF on this platform */
+	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
 };
 
-&main_uart7 {
-	/* UART not brought out */
-	status = "disabled";
+&main_uart1 {
+	status = "okay";
+	/* Default pinmux */
 };
 
-&main_uart8 {
-	/* UART not brought out */
-	status = "disabled";
+&main_uart2 {
+	status = "okay";
+	/* Default pinmux */
 };
 
-&main_uart9 {
-	/* UART not brought out */
-	status = "disabled";
+&main_uart4 {
+	status = "okay";
+	/* Default pinmux */
 };
 
 &main_gpio2 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 917c9dc99efaa..5f85d1cc8b277 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -840,6 +840,7 @@ main_uart0: serial@2800000 {
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 146 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart1: serial@2810000 {
@@ -851,6 +852,7 @@ main_uart1: serial@2810000 {
 		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 278 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart2: serial@2820000 {
@@ -862,6 +864,7 @@ main_uart2: serial@2820000 {
 		power-domains = <&k3_pds 279 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 279 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart3: serial@2830000 {
@@ -873,6 +876,7 @@ main_uart3: serial@2830000 {
 		power-domains = <&k3_pds 280 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 280 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart4: serial@2840000 {
@@ -884,6 +888,7 @@ main_uart4: serial@2840000 {
 		power-domains = <&k3_pds 281 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 281 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart5: serial@2850000 {
@@ -895,6 +900,7 @@ main_uart5: serial@2850000 {
 		power-domains = <&k3_pds 282 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 282 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart6: serial@2860000 {
@@ -906,6 +912,7 @@ main_uart6: serial@2860000 {
 		power-domains = <&k3_pds 283 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 283 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart7: serial@2870000 {
@@ -917,6 +924,7 @@ main_uart7: serial@2870000 {
 		power-domains = <&k3_pds 284 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 284 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart8: serial@2880000 {
@@ -928,6 +936,7 @@ main_uart8: serial@2880000 {
 		power-domains = <&k3_pds 285 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 285 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart9: serial@2890000 {
@@ -939,6 +948,7 @@ main_uart9: serial@2890000 {
 		power-domains = <&k3_pds 286 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 286 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_gpio0: gpio@600000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
index df08724bbf1c5..fce88ed23596d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
@@ -79,6 +79,7 @@ wkup_uart0: serial@42300000 {
 		power-domains = <&k3_pds 287 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 287 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	mcu_uart0: serial@40a00000 {
@@ -90,6 +91,7 @@ mcu_uart0: serial@40a00000 {
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 149 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	wkup_gpio_intr: interrupt-controller@42200000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 80358cba6954c..23538c5f43575 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -475,46 +475,22 @@ &wkup_uart0 {
 	status = "reserved";
 };
 
+&mcu_uart0 {
+	status = "okay";
+	/* Default pinmux */
+};
+
 &main_uart0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
 	/* Shared with ATF on this platform */
 	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
 };
 
-&main_uart2 {
-	/* Brought out on RPi header */
-	status = "disabled";
-};
-
-&main_uart3 {
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
-	/* Brought out on M.2 E Key */
-	status = "disabled";
+&main_uart1 {
+	status = "okay";
+	/* Default pinmux */
 };
 
 &main_sdhci0 {
-- 
2.37.3

