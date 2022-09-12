Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762835B631D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 23:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiILVyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 17:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiILVyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 17:54:01 -0400
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9654DB25;
        Mon, 12 Sep 2022 14:53:59 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1oXrNM-00GaZ8-6v; Mon, 12 Sep 2022 21:53:56 +0000
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
Subject: [PATCH] ARM: dts: imx6qdl-gw54xx: add CAN regulator
Date:   Mon, 12 Sep 2022 14:53:54 -0700
Message-Id: <20220912215354.964858-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
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

The GW54xx has a tranceiver with a STBY pin connected to an IMX6 GPIO.
Configure this as a regulator to drive it low when CAN is in use.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index cda48bf2f168..2a520b1661b9 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -137,6 +137,16 @@ reg_3p3v: regulator@1 {
 			regulator-always-on;
 		};
 
+		reg_can1_stby: regulator-can1-stby {
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_reg_can1>;
+			compatible = "regulator-fixed";
+			regulator-name = "can1_stby";
+			gpio = <&gpio1 2 GPIO_ACTIVE_LOW>;
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
 		reg_usb_h1_vbus: regulator@2 {
 			compatible = "regulator-fixed";
 			reg = <2>;
@@ -200,6 +210,7 @@ IMX_AUDMUX_V2_PTCR_SYN
 &can1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_flexcan1>;
+	xceiver-supply = <&reg_can1_stby>;
 	status = "okay";
 };
 
@@ -687,7 +698,6 @@ pinctrl_flexcan1: flexcan1grp {
 		fsl,pins = <
 			MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX	0x1b0b1
 			MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX	0x1b0b1
-			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x4001b0b0 /* CAN_STBY */
 		>;
 	};
 
@@ -786,6 +796,12 @@ MX6QDL_PAD_SD4_DAT2__PWM4_OUT		0x1b0b1
 		>;
 	};
 
+	pinctrl_reg_can1: regcan1grp {
+		fsl,pins = <
+			MX6QDL_PAD_GPIO_2__GPIO1_IO02		0x4001b0b0 /* CAN_STBY */
+		>;
+	};
+
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
 			MX6QDL_PAD_SD3_DAT7__UART1_TX_DATA	0x1b0b1
-- 
2.25.1

