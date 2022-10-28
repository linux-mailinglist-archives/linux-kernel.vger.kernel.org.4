Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFF2611478
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiJ1OZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJ1OYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:24:38 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A7BDC1;
        Fri, 28 Oct 2022 07:24:30 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOKkj023811;
        Fri, 28 Oct 2022 09:24:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666967060;
        bh=w1yNXTvE43ZaEzGgh6+AWiVcnaERDNW2R/5yEFN79QI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=psHutzQQnE/p+rqh8G8UEvS/zjXpcZTYxEvCOIKCWwhRlcTgS9hv4PfzS3JZAYZS1
         m276CPepwGsf1vsdUSG8NenRPMlL1J2mAuiFgVRBR8xU6SEdYl2ZSQJabOJRRwJmqT
         Sdn5UYZS+oAeeM3U9C/azV4UwUuuV6yA2D2glrSw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29SEOK9m030642
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Oct 2022 09:24:20 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 28
 Oct 2022 09:24:20 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 28 Oct 2022 09:24:20 -0500
Received: from ula0226330.dal.design.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29SEOHfR039275;
        Fri, 28 Oct 2022 09:24:19 -0500
From:   Andrew Davis <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>, Le Jin <le.jin@siemens.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 02/11] arm64: dts: ti: k3-am65: Enable I2C nodes at the board level
Date:   Fri, 28 Oct 2022 09:24:08 -0500
Message-ID: <20221028142417.10642-3-afd@ti.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221028142417.10642-1-afd@ti.com>
References: <20221028142417.10642-1-afd@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C nodes defined in the top-level AM65x SoC dtsi files are incomplete
and will not be functional unless they are extended with pinmux
information.

As the pinmux is only known at the board integration level, these
nodes should only be enabled when provided with this information.

Disable the I2C nodes in the dtsi files and only enable the ones that
are actually pinned out on a given board.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 6 ++++++
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           | 4 ++++
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            | 1 +
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         | 1 +
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     | 9 +++++++++
 5 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 7b3087c19141c..945a8a70332e9 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -411,12 +411,14 @@ &db9_com_mode_pins_default
 };
 
 &wkup_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_i2c0_pins_default>;
 	clock-frequency = <400000>;
 };
 
 &mcu_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mcu_i2c0_pins_default>;
 	clock-frequency = <400000>;
@@ -476,6 +478,7 @@ pcal9535_3: gpio@25 {
 };
 
 &main_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
@@ -493,18 +496,21 @@ eeprom: eeprom@54 {
 };
 
 &main_i2c1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
 };
 
 &main_i2c2 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c2_pins_default>;
 	clock-frequency = <400000>;
 };
 
 &main_i2c3 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c3_pins_default>;
 	clock-frequency = <400000>;
diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
index ae414f5d83822..feef5fdb46886 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -159,6 +159,7 @@ main_i2c0: i2c@2000000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 110 1>;
 		power-domains = <&k3_pds 110 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c1: i2c@2010000 {
@@ -170,6 +171,7 @@ main_i2c1: i2c@2010000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 111 1>;
 		power-domains = <&k3_pds 111 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c2: i2c@2020000 {
@@ -181,6 +183,7 @@ main_i2c2: i2c@2020000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 112 1>;
 		power-domains = <&k3_pds 112 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	main_i2c3: i2c@2030000 {
@@ -192,6 +195,7 @@ main_i2c3: i2c@2030000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 113 1>;
 		power-domains = <&k3_pds 113 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	ecap0: pwm@3100000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
index bb70097693802..dc0f439d2dacb 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
@@ -47,6 +47,7 @@ mcu_i2c0: i2c@40b00000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 114 1>;
 		power-domains = <&k3_pds 114 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	mcu_spi0: spi@40300000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
index bbe31532f984b..fd2b998ebddc4 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi
@@ -66,6 +66,7 @@ wkup_i2c0: i2c@42120000 {
 		clock-names = "fck";
 		clocks = <&k3_clks 115 1>;
 		power-domains = <&k3_pds 115 TI_SCI_PD_EXCLUSIVE>;
+		status = "disabled";
 	};
 
 	intr_wkup_gpio: interrupt-controller@42200000 {
diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
index 956e9bc946b5f..991a8559b4c3b 100644
--- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
@@ -284,6 +284,7 @@ &main_uart0 {
 };
 
 &wkup_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&wkup_i2c0_pins_default>;
 	clock-frequency = <400000>;
@@ -302,7 +303,13 @@ pca9554: gpio@39 {
 	};
 };
 
+&mcu_i2c0 {
+	status = "okay";
+	/* Default pinmux */
+};
+
 &main_i2c0 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c0_pins_default>;
 	clock-frequency = <400000>;
@@ -316,12 +323,14 @@ pca9555: gpio@21 {
 };
 
 &main_i2c1 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
 	clock-frequency = <400000>;
 };
 
 &main_i2c2 {
+	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c2_pins_default>;
 	clock-frequency = <400000>;
-- 
2.37.3

