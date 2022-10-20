Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C66606554
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbiJTQE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbiJTQDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:03:33 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690531BA1F3;
        Thu, 20 Oct 2022 09:03:31 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29KG3CuW119646;
        Thu, 20 Oct 2022 11:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666281792;
        bh=vvotJEDDFvsiN95CQPG9C11IjnclUspgYS+jLdLpazc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mIqayLjwjRCMHD9/5htQWV7bkExjhcSmdKWov2Zt2oHZ4SzeW6re407LmyRrD6oXX
         2sgg1hocxhWmZ/Uyev4kuict7i766ML5d53ZJMyLbB4Hd+uPMmMbvxe30z0XDD2ZsA
         tAgryIJRUqNMuTvKCyyur6efcaFkPzKvT+hzWBAw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29KG3Cfa052184
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Oct 2022 11:03:12 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 20
 Oct 2022 11:03:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 20 Oct 2022 11:03:11 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29KG363F059665;
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
Subject: [PATCH 07/12] arm64: dts: ti: k3-j721s2: Enable UART nodes at the board level
Date:   Thu, 20 Oct 2022 11:03:00 -0500
Message-ID: <20221020160305.18711-8-afd@ti.com>
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

UART nodes defined in the top-level J721s2 SoC dtsi files are incomplete
and may not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the UART nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 .../dts/ti/k3-j721s2-common-proc-board.dts    | 38 ++-----------------
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    | 10 +++++
 .../boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi     |  2 +
 3 files changed, 16 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
index b210cc07c5395..9f1a0ca4dc372 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-common-proc-board.dts
@@ -219,49 +219,19 @@ &wkup_uart0 {
 	status = "reserved";
 };
 
-&main_uart0 {
-	status = "disabled";
-};
-
-&main_uart1 {
-	status = "disabled";
-};
-
-&main_uart2 {
-	status = "disabled";
-};
-
-&main_uart3 {
-	status = "disabled";
-};
-
-&main_uart4 {
-	status = "disabled";
-};
-
-&main_uart5 {
-	status = "disabled";
-};
-
-&main_uart6 {
-	status = "disabled";
-};
-
-&main_uart7 {
-	status = "disabled";
+&mcu_uart0 {
+	status = "okay";
+	/* Default pinmux */
 };
 
 &main_uart8 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart8_pins_default>;
 	/* Shared with TFA on this platform */
 	power-domains = <&k3_pds 357 TI_SCI_PD_SHARED>;
 };
 
-&main_uart9 {
-	status = "disabled";
-};
-
 &main_i2c0 {
 	clock-frequency = <400000>;
 
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 34e7d577ae13b..7267a7b665ce8 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -80,6 +80,7 @@ main_uart0: serial@2800000 {
 		clocks = <&k3_clks 146 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart1: serial@2810000 {
@@ -90,6 +91,7 @@ main_uart1: serial@2810000 {
 		clocks = <&k3_clks 350 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 350 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart2: serial@2820000 {
@@ -100,6 +102,7 @@ main_uart2: serial@2820000 {
 		clocks = <&k3_clks 351 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 351 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart3: serial@2830000 {
@@ -110,6 +113,7 @@ main_uart3: serial@2830000 {
 		clocks = <&k3_clks 352 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 352 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart4: serial@2840000 {
@@ -120,6 +124,7 @@ main_uart4: serial@2840000 {
 		clocks = <&k3_clks 353 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 353 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart5: serial@2850000 {
@@ -130,6 +135,7 @@ main_uart5: serial@2850000 {
 		clocks = <&k3_clks 354 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 354 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart6: serial@2860000 {
@@ -140,6 +146,7 @@ main_uart6: serial@2860000 {
 		clocks = <&k3_clks 355 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 355 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart7: serial@2870000 {
@@ -150,6 +157,7 @@ main_uart7: serial@2870000 {
 		clocks = <&k3_clks 356 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 356 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart8: serial@2880000 {
@@ -160,6 +168,7 @@ main_uart8: serial@2880000 {
 		clocks = <&k3_clks 357 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 357 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_uart9: serial@2890000 {
@@ -170,6 +179,7 @@ main_uart9: serial@2890000 {
 		clocks = <&k3_clks 358 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 358 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_gpio0: gpio@600000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
index 4d1bfabd1313a..3de4218e8e125 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi
@@ -91,6 +91,7 @@ wkup_uart0: serial@42300000 {
 		clocks = <&k3_clks 359 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 359 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcu_uart0: serial@40a00000 {
@@ -101,6 +102,7 @@ mcu_uart0: serial@40a00000 {
 		clocks = <&k3_clks 149 3>;
 		clock-names = "fclk";
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	wkup_gpio0: gpio@42110000 {
-- 
2.37.3

