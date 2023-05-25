Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B527710A46
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbjEYKsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbjEYKsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:48:05 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2914810B;
        Thu, 25 May 2023 03:48:02 -0700 (PDT)
X-GND-Sasl: luca.ceresoli@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685011681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PvtD5KaOGb3+YhvFCawf7mSeDahxw55HHqCVBb0xeg8=;
        b=hWYTOtl5/ZGgCo6I4YdQarf9V+/kxk7u9NVFRlDLaQZH3Xd/FrPoQU/Blo3atY9jj9ixFW
        nFgiYbOm76R/Iq8QXnrFGWFFFRCfitAVU8lUe+G57tkrpLmT5JRw7+CFXCxwbPV+KM4SHW
        QW8MacuHZCYRlhIq6EH9S61aG0VNJQRDS6u6PvPMXI7+fMIx+rIVo+mvI9YtxF5147A7Qc
        4TKJpN8VFuCo7XMZvgWB9Vhe9bdJ2ffbC06NJvnQnRxjIWO+CSzQCBwXQW7KSimszyViT2
        J9nl0/Li+33m/rNToQEMiYxGfBjzDJi9K/mJwSMNtlsDjXy28LlKDsFOuE6P6Q==
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
X-GND-Sasl: luca.ceresoli@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id 2C57424000B;
        Thu, 25 May 2023 10:47:57 +0000 (UTC)
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     devicetree@vger.kernel.org
Cc:     Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: imx8mp-msc-sm2s: Add sound card
Date:   Thu, 25 May 2023 12:47:55 +0200
Message-Id: <20230525104755.286282-1-luca.ceresoli@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSC SM2-MB-EP1 carrier board for the SM2S-IMX8PLUS SMARC module has an
NXP SGTL5000 audio codec connected to I2S-0 (sai2).

This requires to:

 * add the power supplies (always on)
 * enable sai2 with pinmuxes
 * reparent the CLKOUT1 clock that feeds the codec SYS_MCLK to
   IMX8MP_CLK_24M in order it to generate an accurate 24 MHz rate

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changed in v2:

 - switch to simple-audio-card
 - fix typo in commit message
 - no underscores in node names
 - rename "sgtl5000-sound" node to "sound"
---
 .../dts/freescale/imx8mp-msc-sm2s-ep1.dts     | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
index 470ff8e31e32..cd651e1e3262 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-msc-sm2s-ep1.dts
@@ -14,6 +14,67 @@ / {
 	compatible = "avnet,sm2s-imx8mp-14N0600E-ep1",
 		     "avnet,sm2s-imx8mp-14N0600E", "avnet,sm2s-imx8mp",
 		     "fsl,imx8mp";
+
+	reg_vcc_3v3_audio: 3v3-audio-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_3V3_AUD";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	reg_vcc_1v8_audio: 1v8-audio-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VCC_1V8_AUD";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sgtl5000-audio";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,frame-master = <&codec_dai>;
+		simple-audio-card,bitclock-master = <&codec_dai>;
+
+		simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+
+		codec_dai: simple-audio-card,codec {
+			sound-dai = <&sgtl5000>;
+		};
+	};
+};
+
+&i2c1 {
+	sgtl5000: sgtl5000@a {
+		compatible = "fsl,sgtl5000";
+		reg = <0x0a>;
+
+		assigned-clocks = <&clk IMX8MP_CLK_CLKOUT1_SEL>;
+		assigned-clock-parents = <&clk IMX8MP_CLK_24M>;
+		assigned-clock-rates = <24000000>;
+		clocks = <&clk IMX8MP_CLK_CLKOUT1>;
+		clock-names = "mclk";
+		#sound-dai-cells = <0>;
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
@@ -32,6 +93,15 @@ &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_smarc_gpio>;
 
+	pinctrl_sai2: sai2grp {
+		fsl,pins = <
+			MX8MP_IOMUXC_SAI2_TXFS__AUDIOMIX_SAI2_TX_SYNC   0xd6
+			MX8MP_IOMUXC_SAI2_TXC__AUDIOMIX_SAI2_TX_BCLK    0xd6
+			MX8MP_IOMUXC_SAI2_RXD0__AUDIOMIX_SAI2_RX_DATA00 0xd6
+			MX8MP_IOMUXC_SAI2_TXD0__AUDIOMIX_SAI2_TX_DATA00 0xd6
+		>;
+	};
+
 	pinctrl_smarc_gpio: smarcgpiosgrp {
 		fsl,pins =
 			<MX8MP_IOMUXC_GPIO1_IO11__GPIO1_IO11	0x19>, /* GPIO0 */

base-commit: efdde75fee54667153a5fa236907b55452fddbfa
-- 
2.34.1

