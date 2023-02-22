Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34D469FA24
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjBVR0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBVR0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:26:38 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BF541B56;
        Wed, 22 Feb 2023 09:26:02 -0800 (PST)
Received: from booty.fritz.box (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 9323A4000B;
        Wed, 22 Feb 2023 17:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677086759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=liyc04uOfojNPzcXlOkF1rgtORQMcNRHYaWkiDbA6a0=;
        b=mvjWs1Z5miVuBFhQ2lrmffWQEUftHKgpfdmtOtiNOKutAM7No18k/KwnwSTsSxOXe2aUms
        XNs3u/bdFz07d8XJFz4Mf1mNL8e+7xXuH+D7aWyN/p4UdW9i9FIEB+Fe34Zd9g1y3d5ES7
        0tyava2uy+oe6FI+3Id5/4DEcCgSvbj8R4DnJQjD1Ur6KNaVw0kbNZ6xiG+eoHhg9Xz0ap
        JE18X0lYrp9C5qHwspz3T3h1JfBl8A9pM1tDRiP6MIr2/qVdKh3TTeQhtozxzs1SidYIAJ
        J2PVlp6SBl7i8ex/TODZ2wV1tzELjcC/S+f/Ha/y+g6UMaDKy42WH8csXWp65A==
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Martyn Welch <martyn.welch@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH] arm64: dts: imx8mp-msc-sm2s: Add sound card
Date:   Wed, 22 Feb 2023 18:25:52 +0100
Message-Id: <20230222172552.1545519-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222182252.2ad6d82b@booty>
References: <20230222182252.2ad6d82b@booty>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSC SM2-MB-EP1 carrier board for the SM2S-IMX8PLUS SMARC module has an
NXPP SGTL5000 audio codec connected to I2S-0 (sai2).

This requires to:

 * add the power supplies (always on)
 * enable sai2 with pinmuxes
 * reparent the CLKOUT1 clock that feeds the codec SYS_MCLK to
   IMX8MP_CLK_24M in order it to generate an accurate 24 MHz rate

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
index 470ff8e31e32..894d9809f76d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
@@ -14,6 +14,57 @@ / {
 	compatible = "avnet,sm2s-imx8mp-14N0600E-ep1",
 		     "avnet,sm2s-imx8mp-14N0600E", "avnet,sm2s-imx8mp",
 		     "fsl,imx8mp";
+
+	reg_vcc_3v3_audio: 3v3_audio_regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3_AUD";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_vcc_1v8_audio: 1v8_audio_regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8_AUD";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	sgtl5000-sound {
+		compatible = "fsl,imx-audio-sgtl5000";
+		model = "imx-sgtl5000";
+		audio-cpu = <&sai2>;
+		audio-codec = <&sgtl5000_codec>;
+	};
+};
+
+&i2c1 {
+	sgtl5000_codec: sgtl5000@a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+
+		assigned-clocks = <&clk IMX8MP_CLK_CLKOUT1_SEL>;
+		assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
+		assigned-clock-rates = <24000000>;
+		clocks = <&clk IMX8MP_CLK_CLKOUT1>;
+		clock-names = "mclk";
+
+		VDDA-supply  = <&reg_vcc_3v3_audio>;
+		VDDD-supply  = <&reg_vcc_1v8_audio>;
+		VDDIO-supply = <&reg_vcc_1v8_audio>;
+	};
+};
+
+/* I2S-0 = sai2 */
+&sai2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+
+	assigned-clocks = <&clk IMX8MP_CLK_SAI2>;
+	assigned-clock-parents = <&clk IMX8MP_AUDIO_PLL1_OUT>;
+	assigned-clock-rates = <12288000>;
+
+	fsl,sai-mclk-direction-output;
+	status = "okay";
 };
 
 &flexcan1 {
@@ -49,4 +100,13 @@ pinctrl_smarc_gpio: smarcgpiosgrp {
 			<MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19	0x19>, /* GPIO12 */
 			<MX8MP_IOMUXC_SAI1_RXFS__GPIO4_IO00	0x19>; /* GPIO13 */
 	};
+
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC   0xd6
+			MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK    0xd6
+			MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_SAI2_RX_DATA00 0xd6
+			MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00 0xd6
+		>;
+	};
 };
-- 
2.34.1

