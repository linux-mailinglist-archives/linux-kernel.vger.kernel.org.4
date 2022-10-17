Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C61660178A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiJQT0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbiJQT0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:09 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EE71A825;
        Mon, 17 Oct 2022 12:26:03 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPbJv120494;
        Mon, 17 Oct 2022 14:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666034737;
        bh=KtFEujHPwKAgrsBapVOwK35q3T/eNr1mHH14Ul63X7I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=rBu/kx22v89TbVE8xZoP5aC7ZywZCTZP2Dwk40R5eXDKpAvAly4QYzHVR6eG8sgx7
         IgE+jFDbztn+xYfl8mW/KttXdv64Tf3gDEUooXQcOZg5QavwLbNwyI3df3bBAhVudM
         B303k/yLJxgA0lZTBKCLNuyig3tm7xMjB22ueHUs=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29HJPbE0083466
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Oct 2022 14:25:37 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 17
 Oct 2022 14:25:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 17 Oct 2022 14:25:37 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPWXP026106;
        Mon, 17 Oct 2022 14:25:36 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 08/10] arm64: dts: ti: k3-am64: Enable MDIO nodes at the board level
Date:   Mon, 17 Oct 2022 14:25:30 -0500
Message-ID: <20221017192532.23825-9-afd@ti.com>
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

MDIO nodes defined in the top-level AM64x SoC dtsi files are incomplete
and will not be functional unless they are extended with a pinmux.

As the attached PHY is only known about at the board integration level,
these nodes should only be enabled when provided with this information.

Disable the MDIO nodes (in both CPSW and ICSSG) in the dtsi files and
only enable the ones that are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 3 +++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  | 9 +--------
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 9 +--------
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index b193f88a7a0f..7ea07f7fe5a2 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -552,6 +552,7 @@ cpsw3g_mdio: mdio@f00 {
 			clocks = <&k3_clks 13 0>;
 			clock-names = "fck";
 			bus_freq = <1000000>;
+			status = "disabled";
 		};
 
 		cpts@3d000 {
@@ -1168,6 +1169,7 @@ icssg0_mdio: mdio@32400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			bus_freq = <1000000>;
+			status = "disabled";
 		};
 	};
 
@@ -1308,6 +1310,7 @@ icssg1_mdio: mdio@32400 {
 			clocks = <&k3_clks 82 0>;
 			clock-names = "fck";
 			bus_freq = <1000000>;
+			status = "disabled";
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 2319ba4f5ae3..9a3bf852810c 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -440,6 +440,7 @@ &cpsw_port2 {
 };
 
 &cpsw3g_mdio {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mdio1_pins_default>;
 
@@ -575,14 +576,6 @@ &ecap0 {
 	pinctrl-0 = <&main_ecap0_pins_default>;
 };
 
-&icssg0_mdio {
-	status = "disabled";
-};
-
-&icssg1_mdio {
-	status = "disabled";
-};
-
 &main_mcan0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_mcan0_pins_default>;
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index c1d634647027..451e1483f3e4 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -454,6 +454,7 @@ &cpsw_port2 {
 };
 
 &cpsw3g_mdio {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mdio1_pins_default>;
 
@@ -566,14 +567,6 @@ &ecap0 {
 	pinctrl-0 = <&main_ecap0_pins_default>;
 };
 
-&icssg0_mdio {
-	status = "disabled";
-};
-
-&icssg1_mdio {
-	status = "disabled";
-};
-
 &main_mcan0 {
 	status = "disabled";
 };
-- 
2.37.3

