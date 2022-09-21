Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F925C04AB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiIUQvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiIUQua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:50:30 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B15326113;
        Wed, 21 Sep 2022 09:46:26 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1ob2re-00Gscu-U3; Wed, 21 Sep 2022 16:46:23 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] arm64: dts: imx8m*-venice: add I2C GPIO bus recovery support
Date:   Wed, 21 Sep 2022 09:46:20 -0700
Message-Id: <20220921164620.3298914-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add I2C GPIO bus recovery support by adding scl-gpios and sda-gpios for the
various I2C busses on Gateworks Venice boards.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 .../dts/freescale/imx8mm-venice-gw700x.dtsi   | 24 +++++++++-
 .../dts/freescale/imx8mm-venice-gw7901.dts    | 48 +++++++++++++++++--
 .../dts/freescale/imx8mm-venice-gw7902.dts    | 48 +++++++++++++++++--
 .../dts/freescale/imx8mm-venice-gw7903.dts    | 36 ++++++++++++--
 .../dts/freescale/imx8mm-venice-gw7904.dts    | 48 +++++++++++++++++--
 .../dts/freescale/imx8mn-venice-gw7902.dts    | 48 +++++++++++++++++--
 .../dts/freescale/imx8mp-venice-gw74xx.dts    | 48 +++++++++++++++++--
 7 files changed, 275 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
index 66a0d103c90f..c305e325d007 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
@@ -119,8 +119,11 @@ ethphy0: ethernet-phy@0 {
 
 &i2c1 {
 	clock-frequency = <100000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	gsc: gsc@20 {
@@ -365,8 +368,11 @@ ldo4 {
 
 &i2c2 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	eeprom@52 {
@@ -435,6 +441,13 @@ MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14	0x400001c3
+			MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
@@ -442,6 +455,13 @@ MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16	0x400001c3
+			MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17	0x400001c3
+		>;
+	};
+
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
index d3ee6fc4baab..826627bd4503 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7901.dts
@@ -326,8 +326,11 @@ &gpu_3d {
 
 &i2c1 {
 	clock-frequency = <100000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	gsc: gsc@20 {
@@ -477,8 +480,11 @@ rtc@68 {
 
 &i2c2 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	pmic@4b {
@@ -600,8 +606,11 @@ LDO6 {
 
 &i2c3 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	leds_gpio: gpio@20 {
@@ -673,8 +682,11 @@ crypto@60 {
 
 &i2c4 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 };
 
@@ -852,6 +864,13 @@ MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14	0x400001c3
+			MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
@@ -859,6 +878,13 @@ MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16	0x400001c3
+			MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
@@ -866,6 +892,13 @@ MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18	0x400001c3
+			MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
@@ -873,6 +906,13 @@ MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c4_gpio: i2c4gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SCL_GPIO5_IO20	0x400001c3
+			MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21	0x400001c3
+		>;
+	};
+
 	pinctrl_ksz: kszgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI1_TXD6_GPIO4_IO18	0x41
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
index 203f1cb75f27..df5fa3975ba1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7902.dts
@@ -298,8 +298,11 @@ &gpio5 {
 
 &i2c1 {
 	clock-frequency = <100000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	gsc: gsc@20 {
@@ -566,8 +569,11 @@ rtc@68 {
 
 &i2c2 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	accelerometer@19 {
@@ -585,16 +591,22 @@ accelerometer@19 {
 /* off-board header */
 &i2c3 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 };
 
 /* off-board header */
 &i2c4 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 };
 
@@ -800,6 +812,13 @@ MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14	0x400001c3
+			MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
@@ -807,6 +826,13 @@ MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16	0x400001c3
+			MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
@@ -814,6 +840,13 @@ MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18	0x400001c3
+			MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
@@ -821,6 +854,13 @@ MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c4_gpio: i2c4gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SCL_GPIO5_IO20	0x400001c3
+			MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21	0x400001c3
+		>;
+	};
+
 	pinctrl_gpio_leds: gpioledgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SAI5_RXD0_GPIO3_IO21	0x19
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
index 19f6d2943d26..1ec91c5c6a49 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7903.dts
@@ -265,8 +265,11 @@ &gpio5 {
 
 &i2c1 {
 	clock-frequency = <100000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	gsc: gsc@20 {
@@ -397,8 +400,11 @@ rtc@68 {
 
 &i2c2 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	pmic@4b {
@@ -520,8 +526,11 @@ LDO6 {
 
 &i2c3 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	accelerometer@19 {
@@ -681,6 +690,13 @@ MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14	0x400001c3
+			MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
@@ -688,6 +704,13 @@ MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16	0x400001c3
+			MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
@@ -695,6 +718,13 @@ MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18	0x400001c3
+			MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19	0x400001c3
+		>;
+	};
+
 	pinctrl_gpio_leds: gpioledgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_SPDIF_EXT_CLK_GPIO5_IO5	0x19
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
index a67771d02146..93c9651c315d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw7904.dts
@@ -315,8 +315,11 @@ &gpio5 {
 
 &i2c1 {
 	clock-frequency = <100000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	gsc: gsc@20 {
@@ -441,8 +444,11 @@ rtc@68 {
 
 &i2c2 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	pmic@4b {
@@ -564,8 +570,11 @@ LDO6 {
 
 &i2c3 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	accelerometer@19 {
@@ -582,8 +591,11 @@ accelerometer@19 {
 
 &i2c4 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	gpioled: gpio@27 {
@@ -738,6 +750,13 @@ MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C1_SCL_GPIO5_IO14	0x400001c3
+			MX8MM_IOMUXC_I2C1_SDA_GPIO5_IO15	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
@@ -745,6 +764,13 @@ MX8MM_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C2_SCL_GPIO5_IO16	0x400001c3
+			MX8MM_IOMUXC_I2C2_SDA_GPIO5_IO17	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
@@ -752,6 +778,13 @@ MX8MM_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C3_SCL_GPIO5_IO18	0x400001c3
+			MX8MM_IOMUXC_I2C3_SDA_GPIO5_IO19	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
@@ -759,6 +792,13 @@ MX8MM_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c4_gpio: i2c4gpiogrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_I2C4_SCL_GPIO5_IO20	0x400001c3
+			MX8MM_IOMUXC_I2C4_SDA_GPIO5_IO21	0x400001c3
+		>;
+	};
+
 	pinctrl_pcie0: pciegrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_ECSPI2_MOSI_GPIO5_IO11	0x41
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
index dd4302ac1de4..187e0410b87d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-venice-gw7902.dts
@@ -297,8 +297,11 @@ &gpu {
 
 &i2c1 {
 	clock-frequency = <100000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	gsc: gsc@20 {
@@ -565,8 +568,11 @@ rtc@68 {
 
 &i2c2 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	accelerometer@19 {
@@ -584,16 +590,22 @@ accelerometer@19 {
 /* off-board header */
 &i2c3 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 };
 
 /* off-board header */
 &i2c4 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 };
 
@@ -744,6 +756,13 @@ MX8MN_IOMUXC_I2C1_SDA_I2C1_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C1_SCL_GPIO5_IO14	0x400001c3
+			MX8MN_IOMUXC_I2C1_SDA_GPIO5_IO15	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX8MN_IOMUXC_I2C2_SCL_I2C2_SCL		0x400001c3
@@ -751,6 +770,13 @@ MX8MN_IOMUXC_I2C2_SDA_I2C2_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C2_SCL_GPIO5_IO16	0x400001c3
+			MX8MN_IOMUXC_I2C2_SDA_GPIO5_IO17	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX8MN_IOMUXC_I2C3_SCL_I2C3_SCL		0x400001c3
@@ -758,6 +784,13 @@ MX8MN_IOMUXC_I2C3_SDA_I2C3_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C3_SCL_GPIO5_IO18	0x400001c3
+			MX8MN_IOMUXC_I2C3_SDA_GPIO5_IO19	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX8MN_IOMUXC_I2C4_SCL_I2C4_SCL		0x400001c3
@@ -765,6 +798,13 @@ MX8MN_IOMUXC_I2C4_SDA_I2C4_SDA		0x400001c3
 		>;
 	};
 
+	pinctrl_i2c4_gpio: i2c4gpiogrp {
+		fsl,pins = <
+			MX8MN_IOMUXC_I2C4_SCL_GPIO5_IO20	0x400001c3
+			MX8MN_IOMUXC_I2C4_SDA_GPIO5_IO21	0x400001c3
+		>;
+	};
+
 	pinctrl_gpio_leds: gpioledgrp {
 		fsl,pins = <
 			MX8MN_IOMUXC_SAI5_RXD0_GPIO3_IO21	0x19
diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index 06b4c93c5876..ceeca4966fc5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -253,8 +253,11 @@ &gpio5 {
 
 &i2c1 {
 	clock-frequency = <100000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c1>;
+	pinctrl-1 = <&pinctrl_i2c1_gpio>;
+	scl-gpios = <&gpio5 14 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 15 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	gsc: gsc@20 {
@@ -477,8 +480,11 @@ rtc@68 {
 
 &i2c2 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c2>;
+	pinctrl-1 = <&pinctrl_i2c2_gpio>;
+	scl-gpios = <&gpio5 16 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 17 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 
 	accelerometer@19 {
@@ -556,16 +562,22 @@ fixed-link {
 /* off-board header */
 &i2c3 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c3>;
+	pinctrl-1 = <&pinctrl_i2c3_gpio>;
+	scl-gpios = <&gpio5 18 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 19 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 };
 
 /* off-board header */
 &i2c4 {
 	clock-frequency = <400000>;
-	pinctrl-names = "default";
+	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c4>;
+	pinctrl-1 = <&pinctrl_i2c4_gpio>;
+	scl-gpios = <&gpio5 20 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
+	sda-gpios = <&gpio5 21 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	status = "okay";
 };
 
@@ -800,6 +812,13 @@ MX8MP_IOMUXC_I2C1_SDA__I2C1_SDA		0x400001c2
 		>;
 	};
 
+	pinctrl_i2c1_gpio: i2c1gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C1_SCL__GPIO5_IO14	0x400001c2
+			MX8MP_IOMUXC_I2C1_SDA__GPIO5_IO15	0x400001c2
+		>;
+	};
+
 	pinctrl_i2c2: i2c2grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C2_SCL__I2C2_SCL		0x400001c2
@@ -807,6 +826,13 @@ MX8MP_IOMUXC_I2C2_SDA__I2C2_SDA		0x400001c2
 		>;
 	};
 
+	pinctrl_i2c2_gpio: i2c2gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C2_SCL__GPIO5_IO16	0x400001c3
+			MX8MP_IOMUXC_I2C2_SDA__GPIO5_IO17	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c3: i2c3grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C3_SCL__I2C3_SCL		0x400001c2
@@ -814,6 +840,13 @@ MX8MP_IOMUXC_I2C3_SDA__I2C3_SDA		0x400001c2
 		>;
 	};
 
+	pinctrl_i2c3_gpio: i2c3gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C3_SCL__GPIO5_IO18	0x400001c3
+			MX8MP_IOMUXC_I2C3_SDA__GPIO5_IO19	0x400001c3
+		>;
+	};
+
 	pinctrl_i2c4: i2c4grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_I2C4_SCL__I2C4_SCL		0x400001c2
@@ -821,6 +854,13 @@ MX8MP_IOMUXC_I2C4_SDA__I2C4_SDA		0x400001c2
 		>;
 	};
 
+	pinctrl_i2c4_gpio: i2c4gpiogrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_I2C4_SCL__GPIO5_IO20	0x400001c3
+			MX8MP_IOMUXC_I2C4_SDA__GPIO5_IO21	0x400001c3
+		>;
+	};
+
 	pinctrl_ksz: kszgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_SAI3_RXC__GPIO4_IO29	0x150 /* IRQ# */
-- 
2.25.1

