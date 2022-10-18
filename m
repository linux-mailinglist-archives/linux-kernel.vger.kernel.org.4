Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454AB6034BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiJRVQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiJRVPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:15:50 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCF497EDD;
        Tue, 18 Oct 2022 14:15:49 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29ILFZIn108197;
        Tue, 18 Oct 2022 16:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666127735;
        bh=939GvM1Q8ml1Y6Lep+yqEBlfwO/6A1y41YOp9qKUxvI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ps416gHBsaunURBpndZl03XNld+NRrLrl/4o0hT19w+4figvxRPyzmHu04XCcdEfJ
         z+MupnPWHfvACIiIyjg05PEiKfcJDQiHgL5XGCT5FCDQl9DjRXW6N6GmT2txRtFxCR
         cfTkAXaU0FLxs2qsAn6+I/tiBMozK4O4rZFvdpcc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29ILFZxY014127
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Oct 2022 16:15:35 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 18
 Oct 2022 16:15:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 18 Oct 2022 16:15:34 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29ILFXoB014456;
        Tue, 18 Oct 2022 16:15:34 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 01/10] arm64: dts: ti: k3-am62: Enable UART nodes at the board level
Date:   Tue, 18 Oct 2022 16:15:24 -0500
Message-ID: <20221018211533.21335-2-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221018211533.21335-1-afd@ti.com>
References: <20221018211533.21335-1-afd@ti.com>
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

UART nodes defined in the top-level AM62x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the UART nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi   |  7 ++++++
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    |  1 +
 arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi |  1 +
 arch/arm64/boot/dts/ti/k3-am625-sk.dts     | 25 +---------------------
 4 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 03660476364f..f6f8ccdb5f55 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -199,6 +199,7 @@ main_uart0: serial@2800000 {
 		power-domains = <&k3_pds 146 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 146 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart1: serial@2810000 {
@@ -208,6 +209,7 @@ main_uart1: serial@2810000 {
 		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 152 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart2: serial@2820000 {
@@ -217,6 +219,7 @@ main_uart2: serial@2820000 {
 		power-domains = <&k3_pds 153 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 153 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart3: serial@2830000 {
@@ -226,6 +229,7 @@ main_uart3: serial@2830000 {
 		power-domains = <&k3_pds 154 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 154 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart4: serial@2840000 {
@@ -235,6 +239,7 @@ main_uart4: serial@2840000 {
 		power-domains = <&k3_pds 155 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 155 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart5: serial@2850000 {
@@ -244,6 +249,7 @@ main_uart5: serial@2850000 {
 		power-domains = <&k3_pds 156 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 156 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_uart6: serial@2860000 {
@@ -253,6 +259,7 @@ main_uart6: serial@2860000 {
 		power-domains = <&k3_pds 158 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 158 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	main_i2c0: i2c@20000000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index f56c803560f2..8dff39723628 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -21,6 +21,7 @@ mcu_uart0: serial@4a00000 {
 		power-domains = <&k3_pds 149 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 149 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	mcu_i2c0: i2c@4900000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
index 4090134676cf..94cfc549f644 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi
@@ -26,6 +26,7 @@ wkup_uart0: serial@2b300000 {
 		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 114 0>;
 		clock-names = "fclk";
+		status = "disabled";
 	};
 
 	wkup_i2c0: i2c@2b200000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 93a5f0817efc..0c7b25213e97 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -282,11 +282,8 @@ &wkup_uart0 {
 	status = "reserved";
 };
 
-&mcu_uart0 {
-	status = "disabled";
-};
-
 &main_uart0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_uart0_pins_default>;
 };
@@ -296,26 +293,6 @@ &main_uart1 {
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

