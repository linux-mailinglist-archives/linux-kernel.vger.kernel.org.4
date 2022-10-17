Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937096017A0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiJQT1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiJQT01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:27 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8639B7756B;
        Mon, 17 Oct 2022 12:26:05 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPYxn007817;
        Mon, 17 Oct 2022 14:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666034734;
        bh=yIqqHgndFLShNCLNh4uSv4KXNiiYiiM5GTjwUcf0SAo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=L1n3ESu//NKM0yKhZ+TSayU30+LK8GSFjaBWROUQCyGEj1MhSZC7+am56mnmvQYXg
         39re+ojNd7oawLAJ3tDveXEkn/MZu7UGDSqnt4DuFhHySEr/sdE2+vxJ6IndNCsX/j
         x6OTvGBMh94+/PWHuILIcPQp6vwWfP7jV+0Rx0BM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29HJPYOm026073
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Oct 2022 14:25:34 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 17
 Oct 2022 14:25:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 17 Oct 2022 14:25:33 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPWXI026106;
        Mon, 17 Oct 2022 14:25:33 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 01/10] arm64: dts: ti: k3-am64: Enable UART nodes at the board level
Date:   Mon, 17 Oct 2022 14:25:23 -0500
Message-ID: <20221017192532.23825-2-afd@ti.com>
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

UART nodes defined in the top-level AM64x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the UART nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi |  7 ++++++
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  |  2 ++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 29 +-----------------------
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 29 +-----------------------
 4 files changed, 11 insertions(+), 56 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index d6aa23681bbe..a115c668d001 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -237,6 +237,7 @@ main_uart0: serial@2800000 {
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 146 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart1: serial@2810000 {
@@ -248,6 +249,7 @@ main_uart1: serial@2810000 {
 		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 152 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart2: serial@2820000 {
@@ -259,6 +261,7 @@ main_uart2: serial@2820000 {
 		power-domains = <&k3_pds 153 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 153 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart3: serial@2830000 {
@@ -270,6 +273,7 @@ main_uart3: serial@2830000 {
 		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 154 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart4: serial@2840000 {
@@ -281,6 +285,7 @@ main_uart4: serial@2840000 {
 		power-domains = <&k3_pds 155 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 155 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart5: serial@2850000 {
@@ -292,6 +297,7 @@ main_uart5: serial@2850000 {
 		power-domains = <&k3_pds 156 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 156 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart6: serial@2860000 {
@@ -303,6 +309,7 @@ main_uart6: serial@2860000 {
 		power-domains = <&k3_pds 158 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 158 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_i2c0: i2c@20000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index 02d4285acbb8..1181ad017626 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -14,6 +14,7 @@ mcu_uart0: serial@4a00000 {
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 149 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	mcu_uart1: serial@4a10000 {
@@ -24,6 +25,7 @@ mcu_uart1: serial@4a10000 {
 		power-domains = <&k3_pds 160 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 160 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	mcu_i2c0: i2c@4900000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 5cf913860f80..78f246077ca9 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -325,6 +325,7 @@ AM64X_IOPAD(0x0258, PIN_OUTPUT, 0) /* (C17) MCAN1_TX */
 };
 
 &main_uart0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
 };
@@ -334,34 +335,6 @@ &main_uart1 {
 	status = "reserved";
 };
 
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
-&mcu_uart0 {
-	status = "disabled";
-};
-
-&mcu_uart1 {
-	status = "disabled";
-};
-
 &main_i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 738d0cf6c40a..8423295150fc 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -338,15 +338,8 @@ AM64X_IOPAD(0x00bc, PIN_INPUT, 7) /* (U8) GPIO0_46 */
 	};
 };
 
-&mcu_uart0 {
-	status = "disabled";
-};
-
-&mcu_uart1 {
-	status = "disabled";
-};
-
 &main_uart0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
 };
@@ -356,26 +349,6 @@ &main_uart1 {
 	status = "reserved";
 };
 
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
 &mcu_i2c0 {
 	status = "disabled";
 };
-- 
2.37.3

