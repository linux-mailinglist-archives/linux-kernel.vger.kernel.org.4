Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC9360179D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiJQT1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiJQT0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:26:14 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B47118B15;
        Mon, 17 Oct 2022 12:26:09 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPYHK120479;
        Mon, 17 Oct 2022 14:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666034734;
        bh=qi8jNZy19wy0UJ7OBPtfyJD0AkaUVTJ6Gn8Okiq5Slc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=fv2dFir2t47H+utCwgmSy23NSPB+XIxU0WVbNHsBm9s8WwToEY8z0aWp0bMIC7OGK
         K6nu+gJGYKIYYinEpGBojLl2DdWd5RVs3VdCrNMmlZU2bj9k2JqzrolrStzVAcD66n
         TxnW26FZSl5WUjB2iw2tFAJRQL2FnujgpU/t3wbY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29HJPYgv083452
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Oct 2022 14:25:34 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 17
 Oct 2022 14:25:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 17 Oct 2022 14:25:34 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29HJPWXJ026106;
        Mon, 17 Oct 2022 14:25:33 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Andrew Davis <afd@ti.com>
Subject: [PATCH 02/10] arm64: dts: ti: k3-am64: Enable I2C nodes at the board level
Date:   Mon, 17 Oct 2022 14:25:24 -0500
Message-ID: <20221017192532.23825-3-afd@ti.com>
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

I2C nodes defined in the top-level AM64x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the I2C nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi |  4 ++++
 arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi  |  2 ++
 arch/arm64/boot/dts/ti/k3-am642-evm.dts  |  9 +--------
 arch/arm64/boot/dts/ti/k3-am642-sk.dts   | 13 +------------
 4 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index a115c668d001..fdcacf78f4a6 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -321,6 +321,7 @@ main_i2c0: i2c@20000000 {
 		power-domains = <&k3_pds 102 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 102 2>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	main_i2c1: i2c@20010000 {
@@ -332,6 +333,7 @@ main_i2c1: i2c@20010000 {
 		power-domains = <&k3_pds 103 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 103 2>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	main_i2c2: i2c@20020000 {
@@ -343,6 +345,7 @@ main_i2c2: i2c@20020000 {
 		power-domains = <&k3_pds 104 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 104 2>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	main_i2c3: i2c@20030000 {
@@ -354,6 +357,7 @@ main_i2c3: i2c@20030000 {
 		power-domains = <&k3_pds 105 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 105 2>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	main_spi0: spi@20100000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
index 1181ad017626..5ce8ceb3779d 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-mcu.dtsi
@@ -37,6 +37,7 @@ mcu_i2c0: i2c@4900000 {
 		power-domains = <&k3_pds 106 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 106 2>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	mcu_i2c1: i2c@4910000 {
@@ -48,6 +49,7 @@ mcu_i2c1: i2c@4910000 {
 		power-domains = <&k3_pds 107 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 107 2>;
 		clock-names = "fck";
+		status = "disabled";
 	};
 
 	mcu_spi0: spi@4b00000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm.dts b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
index 78f246077ca9..3903e907244e 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm.dts
@@ -336,6 +336,7 @@ &main_uart1 {
 };
 
 &main_i2c1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
@@ -378,14 +379,6 @@ &mcu_gpio0 {
 	status = "reserved";
 };
 
-&mcu_i2c0 {
-	status = "disabled";
-};
-
-&mcu_i2c1 {
-	status = "disabled";
-};
-
 &mcu_spi0 {
 	status = "disabled";
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am642-sk.dts b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
index 8423295150fc..56763d839e05 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-sk.dts
@@ -349,15 +349,8 @@ &main_uart1 {
 	status = "reserved";
 };
 
-&mcu_i2c0 {
-	status = "disabled";
-};
-
-&mcu_i2c1 {
-	status = "disabled";
-};
-
 &main_i2c1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
@@ -382,10 +375,6 @@ exp2: gpio@60 {
 	};
 };
 
-&main_i2c3 {
-	status = "disabled";
-};
-
 &mcu_spi0 {
 	status = "disabled";
 };
-- 
2.37.3

