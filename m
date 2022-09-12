Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175585B5FEA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiILSIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiILSIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:08:48 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351892FFF6;
        Mon, 12 Sep 2022 11:08:46 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1oXnrO-00GaLM-3p; Mon, 12 Sep 2022 18:08:42 +0000
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
Subject: [PATCH v2 5/5] arm64: dts: imx8mp-venice-gw74xx: add WiFi/BT module support
Date:   Mon, 12 Sep 2022 11:08:36 -0700
Message-Id: <20220912180836.773729-5-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912180836.773729-1-tharvey@gateworks.com>
References: <20220912180836.773729-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GW74xx supports an on-board Laird Connectivity Sterling LWB5+ module
which uses a Cypress CYW4373W chip to provide 1x1 802.11 a/b/g/n/ac +
Bluetooth 5.2.

Add the proper device-tree nodes for it.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2: no changes
---
 .../dts/freescale/imx8mp-venice-gw74xx.dts    | 62 ++++++++++++++++++-
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
index 066a4afaf8a1..a2b32275bbf9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts
@@ -134,10 +134,10 @@ reg_wifi_en: regulator-wifi-en {
 		compatible = "regulator-fixed";
 		regulator-name = "wl";
 		gpio = <&gpio3 9 GPIO_ACTIVE_HIGH>;
-		startup-delay-us = <100>;
+		startup-delay-us = <70000>;
 		enable-active-high;
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 	};
 };
 
@@ -576,6 +576,21 @@ &uart2 {
 	status = "okay";
 };
 
+/* bluetooth HCI */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>, <&pinctrl_uart3_gpio>;
+	cts-gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;
+	rts-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4330-bt";
+		shutdown-gpios = <&gpio3 8 GPIO_ACTIVE_HIGH>;
+	};
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4>;
@@ -616,6 +631,25 @@ &usb_dwc3_1 {
 	status = "okay";
 };
 
+/* SDIO WiFi */
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	bus-width = <4>;
+	non-removable;
+	vmmc-supply = <&reg_wifi_en>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	wifi@0 {
+		compatible = "cypress,cyw4373-fmac";
+		reg = <0>;
+	};
+};
+
 /* eMMC */
 &usdhc3 {
 	assigned-clocks = <&clk IMX8MP_CLK_USDHC3>;
@@ -860,6 +894,28 @@ MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d0
 		>;
 	};
 
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x194
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d4
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d4
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d4
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d4
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d4
+		>;
+	};
+
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SD1_CLK__USDHC1_CLK	0x196
+			MX8MP_IOMUXC_SD1_CMD__USDHC1_CMD	0x1d6
+			MX8MP_IOMUXC_SD1_DATA0__USDHC1_DATA0	0x1d6
+			MX8MP_IOMUXC_SD1_DATA1__USDHC1_DATA1	0x1d6
+			MX8MP_IOMUXC_SD1_DATA2__USDHC1_DATA2	0x1d6
+			MX8MP_IOMUXC_SD1_DATA3__USDHC1_DATA3	0x1d6
+		>;
+	};
+
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX8MP_IOMUXC_NAND_WE_B__USDHC3_CLK	0x190
-- 
2.25.1

