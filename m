Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABEA616D6B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 20:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiKBTGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 15:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiKBTGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 15:06:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AE1C4D;
        Wed,  2 Nov 2022 12:06:28 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 385B66602925;
        Wed,  2 Nov 2022 19:06:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667415987;
        bh=JbceIHQ4cbd/hM7hvtkZ242gzHvZFAdS9o8A6QVpvLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lXhLqga2q1eMBpIWij9vfppHslbMQ+wjjsZJLv6zkl2VZtdngFR3PFMZdSGWUe0Xy
         Ohx5OYv0kwdJ/ZYBQjh3+GifliqABHnGdt05/6SyxV/2hswDnwdJzw7xWMlpW22RW0
         ZtiaShhcq3A/6hBQEcI8xcznZU1QWXeSBJrQgrj5gJrb+MpQpyNKRemeGNchewSdSB
         2dUzBvnd8XbnSgCjmpmTyNUVQjcQtxZHw4SiupGqza1Sir87NK5B8NYi5TVm8tKiTI
         F6MlaiPQTfnbTKb6NgI94woJQCgbiQRjpC33dZGRcX1JI44bJGlo5y0USRELQVDSJc
         wb5OcUc0W9jDQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 4/5] arm64: dts: mediatek: asurada: Enable audio support
Date:   Wed,  2 Nov 2022 15:06:10 -0400
Message-Id: <20221102190611.283546-5-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102190611.283546-1-nfraprado@collabora.com>
References: <20221102190611.283546-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable audio support for the Asurada platform. This consists of the
machine sound card, the rt1015p codec for the speakers, the rt5682 codec
for the headset, and the dmic codec for the internal microphone.

Newer revisions of spherion and hayato use the rt5682s codec for the
headset instead, so the codecs and card compatible are added through
separate dtsi files to prepare for that.

HDMI audio support is left out for now since the DisplayPort chip
required isn't enabled yet.

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v3:
- Moved rt5682, rt1015p and sound card compatible to separate dtsi files
  to prepare for future revisions using different codecs
- Made node names generic for rt5682, rt1015p and sound card
- Set sound-dai-cells to 1 for rt5682
- Added DBVDD and LDO1-IN supplies for rt5682

Changes in v2:
- Added this commit

 .../mt8192-asurada-audio-rt1015p-rt5682.dtsi  |  19 ++
 .../mt8192-asurada-audio-rt1015p.dtsi         |  26 ++
 .../mediatek/mt8192-asurada-audio-rt5682.dtsi |  21 ++
 .../dts/mediatek/mt8192-asurada-hayato-r1.dts |   1 +
 .../mediatek/mt8192-asurada-spherion-r0.dts   |   1 +
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 245 ++++++++++++++++++
 6 files changed, 313 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p-rt5682.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt5682.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p-rt5682.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p-rt5682.dtsi
new file mode 100644
index 000000000000..f521f50d448f
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p-rt5682.dtsi
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2020 Google LLC
+ */
+
+#include "mt8192-asurada-audio-rt5682.dtsi"
+#include "mt8192-asurada-audio-rt1015p.dtsi"
+
+&sound {
+	compatible = "mediatek,mt8192_mt6359_rt1015p_rt5682";
+
+	speaker-codecs {
+		sound-dai = <&rt1015p>;
+	};
+
+	headset-codec {
+		sound-dai = <&rt5682 0>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p.dtsi
new file mode 100644
index 000000000000..e5743789934e
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt1015p.dtsi
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/mt8192-pinfunc.h>
+
+/ {
+	rt1015p: audio-codec {
+		compatible = "realtek,rt1015p";
+		pinctrl-names = "default";
+		pinctrl-0 = <&rt1015p_pins>;
+		sdb-gpios = <&pio 147 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <0>;
+	};
+};
+
+&pio {
+	rt1015p_pins: rt1015p-default-pins {
+		pins {
+			pinmux = <PINMUX_GPIO147__FUNC_GPIO147>;
+			output-low;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt5682.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt5682.dtsi
new file mode 100644
index 000000000000..05e48b870a92
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-audio-rt5682.dtsi
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+&i2c1 {
+	rt5682: audio-codec@1a {
+		compatible = "realtek,rt5682i";
+		reg = <0x1a>;
+		interrupts-extended = <&pio 18 IRQ_TYPE_LEVEL_LOW>;
+		realtek,jd-src = <1>;
+		realtek,btndet-delay = <16>;
+		#sound-dai-cells = <1>;
+
+		AVDD-supply = <&mt6359_vio18_ldo_reg>;
+		DBVDD-supply = <&mt6359_vio18_ldo_reg>;
+		LDO1-IN-supply = <&mt6359_vio18_ldo_reg>;
+		MICVDD-supply = <&pp3300_g>;
+		VBAT-supply = <&pp3300_ldo_z>;
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
index 1e91491945f6..43a823990a92 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
@@ -4,6 +4,7 @@
  */
 /dts-v1/;
 #include "mt8192-asurada.dtsi"
+#include "mt8192-asurada-audio-rt1015p-rt5682.dtsi"
 
 / {
 	model = "Google Hayato rev1";
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
index fa3d9573f37a..c6ad10cec95e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
@@ -4,6 +4,7 @@
  */
 /dts-v1/;
 #include "mt8192-asurada.dtsi"
+#include "mt8192-asurada-audio-rt1015p-rt5682.dtsi"
 #include <dt-bindings/leds/common.h>
 
 / {
diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index ace44827de17..ce9e43475f9e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -33,6 +33,12 @@ backlight_lcd0: backlight-lcd0 {
 		default-brightness-level = <576>;
 	};
 
+	dmic_codec: dmic-codec {
+		compatible = "dmic-codec";
+		num-channels = <2>;
+		wakeup-delay-ms = <50>;
+	};
+
 	pp1000_dpbrdg: regulator-1v0-dpbrdg {
 		compatible = "regulator-fixed";
 		regulator-name = "pp1000_dpbrdg";
@@ -196,6 +202,62 @@ wifi_restricted_dma_region: wifi@c0000000 {
 			reg = <0 0xc0000000 0 0x4000000>;
 		};
 	};
+
+	sound: sound {
+		mediatek,platform = <&afe>;
+		pinctrl-names = "aud_clk_mosi_off",
+				"aud_clk_mosi_on",
+				"aud_dat_mosi_off",
+				"aud_dat_mosi_on",
+				"aud_dat_miso_off",
+				"aud_dat_miso_on",
+				"vow_dat_miso_off",
+				"vow_dat_miso_on",
+				"vow_clk_miso_off",
+				"vow_clk_miso_on",
+				"aud_nle_mosi_off",
+				"aud_nle_mosi_on",
+				"aud_dat_miso2_off",
+				"aud_dat_miso2_on",
+				"aud_gpio_i2s3_off",
+				"aud_gpio_i2s3_on",
+				"aud_gpio_i2s8_off",
+				"aud_gpio_i2s8_on",
+				"aud_gpio_i2s9_off",
+				"aud_gpio_i2s9_on",
+				"aud_dat_mosi_ch34_off",
+				"aud_dat_mosi_ch34_on",
+				"aud_dat_miso_ch34_off",
+				"aud_dat_miso_ch34_on",
+				"aud_gpio_tdm_off",
+				"aud_gpio_tdm_on";
+		pinctrl-0 = <&aud_clk_mosi_off_pins>;
+		pinctrl-1 = <&aud_clk_mosi_on_pins>;
+		pinctrl-2 = <&aud_dat_mosi_off_pins>;
+		pinctrl-3 = <&aud_dat_mosi_on_pins>;
+		pinctrl-4 = <&aud_dat_miso_off_pins>;
+		pinctrl-5 = <&aud_dat_miso_on_pins>;
+		pinctrl-6 = <&vow_dat_miso_off_pins>;
+		pinctrl-7 = <&vow_dat_miso_on_pins>;
+		pinctrl-8 = <&vow_clk_miso_off_pins>;
+		pinctrl-9 = <&vow_clk_miso_on_pins>;
+		pinctrl-10 = <&aud_nle_mosi_off_pins>;
+		pinctrl-11 = <&aud_nle_mosi_on_pins>;
+		pinctrl-12 = <&aud_dat_miso2_off_pins>;
+		pinctrl-13 = <&aud_dat_miso2_on_pins>;
+		pinctrl-14 = <&aud_gpio_i2s3_off_pins>;
+		pinctrl-15 = <&aud_gpio_i2s3_on_pins>;
+		pinctrl-16 = <&aud_gpio_i2s8_off_pins>;
+		pinctrl-17 = <&aud_gpio_i2s8_on_pins>;
+		pinctrl-18 = <&aud_gpio_i2s9_off_pins>;
+		pinctrl-19 = <&aud_gpio_i2s9_on_pins>;
+		pinctrl-20 = <&aud_dat_mosi_ch34_off_pins>;
+		pinctrl-21 = <&aud_dat_mosi_ch34_on_pins>;
+		pinctrl-22 = <&aud_dat_miso_ch34_off_pins>;
+		pinctrl-23 = <&aud_dat_miso_ch34_on_pins>;
+		pinctrl-24 = <&aud_gpio_tdm_off_pins>;
+		pinctrl-25 = <&aud_gpio_tdm_on_pins>;
+	};
 };
 
 &dsi0 {
@@ -660,6 +722,165 @@ pins-in {
 		};
 	};
 
+	aud_clk_mosi_off_pins: aud-clk-mosi-off-pins {
+		pins-mosi-off {
+			pinmux = <PINMUX_GPIO214__FUNC_GPIO214>,
+				 <PINMUX_GPIO215__FUNC_GPIO215>;
+		};
+	};
+
+	aud_clk_mosi_on_pins: aud-clk-mosi-on-pins {
+		pins-mosi-on {
+			pinmux = <PINMUX_GPIO214__FUNC_AUD_CLK_MOSI>,
+				 <PINMUX_GPIO215__FUNC_AUD_SYNC_MOSI>;
+			drive-strength = <10>;
+		};
+	};
+
+	aud_dat_miso_ch34_off_pins: aud-dat-miso-ch34-off-pins {
+		pins-miso-off {
+			pinmux = <PINMUX_GPIO199__FUNC_GPIO199>;
+		};
+	};
+
+	aud_dat_miso_ch34_on_pins: aud-dat-miso-ch34-on-pins {
+		pins-miso-on {
+			pinmux = <PINMUX_GPIO199__FUNC_AUD_DAT_MISO2>;
+		};
+	};
+
+	aud_dat_miso_off_pins: aud-dat-miso-off-pins {
+		pins-miso-off {
+			pinmux = <PINMUX_GPIO218__FUNC_GPIO218>,
+				 <PINMUX_GPIO219__FUNC_GPIO219>;
+		};
+	};
+
+	aud_dat_miso_on_pins: aud-dat-miso-on-pins {
+		pins-miso-on {
+			pinmux = <PINMUX_GPIO218__FUNC_AUD_DAT_MISO0>,
+				 <PINMUX_GPIO219__FUNC_AUD_DAT_MISO1>;
+			drive-strength = <10>;
+		};
+	};
+
+	aud_dat_miso2_off_pins: aud-dat-miso2-off-pins {
+		pins-miso-off {
+			pinmux = <PINMUX_GPIO199__FUNC_GPIO199>;
+		};
+	};
+
+	aud_dat_miso2_on_pins: aud-dat-miso2-on-pins {
+		pins-miso-on {
+			pinmux = <PINMUX_GPIO199__FUNC_AUD_DAT_MISO2>;
+		};
+	};
+
+	aud_dat_mosi_ch34_off_pins: aud-dat-mosi-ch34-off-pins {
+		pins-mosi-off {
+			pinmux = <PINMUX_GPIO196__FUNC_GPIO196>;
+		};
+	};
+
+	aud_dat_mosi_ch34_on_pins: aud-dat-mosi-ch34-on-pins {
+		pins-mosi-on {
+			pinmux = <PINMUX_GPIO196__FUNC_AUD_DAT_MOSI2>;
+		};
+	};
+
+	aud_dat_mosi_off_pins: aud-dat-mosi-off-pins {
+		pins-mosi-off {
+			pinmux = <PINMUX_GPIO216__FUNC_GPIO216>,
+				 <PINMUX_GPIO217__FUNC_GPIO217>;
+		};
+	};
+
+	aud_dat_mosi_on_pins: aud-dat-mosi-on-pins {
+		pins-mosi-on {
+			pinmux = <PINMUX_GPIO216__FUNC_AUD_DAT_MOSI0>,
+				 <PINMUX_GPIO217__FUNC_AUD_DAT_MOSI1>;
+			drive-strength = <10>;
+		};
+	};
+
+	aud_gpio_i2s3_off_pins: aud-gpio-i2s3-off-pins {
+		pins-i2s3-off {
+			pinmux = <PINMUX_GPIO32__FUNC_GPIO32>,
+				 <PINMUX_GPIO33__FUNC_GPIO33>,
+				 <PINMUX_GPIO35__FUNC_GPIO35>;
+		};
+	};
+
+	aud_gpio_i2s3_on_pins: aud-gpio-i2s3-on-pins {
+		pins-i2s3-on {
+			pinmux = <PINMUX_GPIO32__FUNC_I2S3_BCK>,
+				 <PINMUX_GPIO33__FUNC_I2S3_LRCK>,
+				 <PINMUX_GPIO35__FUNC_I2S3_DO>;
+		};
+	};
+
+	aud_gpio_i2s8_off_pins: aud-gpio-i2s8-off-pins {
+		pins-i2s8-off {
+			pinmux = <PINMUX_GPIO10__FUNC_GPIO10>,
+				 <PINMUX_GPIO11__FUNC_GPIO11>,
+				 <PINMUX_GPIO12__FUNC_GPIO12>,
+				 <PINMUX_GPIO13__FUNC_GPIO13>;
+		};
+	};
+
+	aud_gpio_i2s8_on_pins: aud-gpio-i2s8-on-pins {
+		pins-i2s8-on {
+			pinmux = <PINMUX_GPIO10__FUNC_I2S8_MCK>,
+				 <PINMUX_GPIO11__FUNC_I2S8_BCK>,
+				 <PINMUX_GPIO12__FUNC_I2S8_LRCK>,
+				 <PINMUX_GPIO13__FUNC_I2S8_DI>;
+		};
+	};
+
+	aud_gpio_i2s9_off_pins: aud-gpio-i2s9-off-pins {
+		pins-i2s9-off {
+			pinmux = <PINMUX_GPIO29__FUNC_GPIO29>;
+		};
+	};
+
+	aud_gpio_i2s9_on_pins: aud-gpio-i2s9-on-pins {
+		pins-i2s9-on {
+			pinmux = <PINMUX_GPIO29__FUNC_I2S9_DO>;
+		};
+	};
+
+	aud_gpio_tdm_off_pins: aud-gpio-tdm-off-pins {
+		pins-tdm-off {
+			pinmux = <PINMUX_GPIO0__FUNC_GPIO0>,
+				 <PINMUX_GPIO1__FUNC_GPIO1>,
+				 <PINMUX_GPIO2__FUNC_GPIO2>,
+				 <PINMUX_GPIO3__FUNC_GPIO3>;
+		};
+	};
+
+	aud_gpio_tdm_on_pins: aud-gpio-tdm-on-pins {
+		pins-tdm-on {
+			pinmux = <PINMUX_GPIO0__FUNC_TDM_LRCK>,
+				 <PINMUX_GPIO1__FUNC_TDM_BCK>,
+				 <PINMUX_GPIO2__FUNC_TDM_MCK>,
+				 <PINMUX_GPIO3__FUNC_TDM_DATA0>;
+		};
+	};
+
+	aud_nle_mosi_off_pins: aud-nle-mosi-off-pins {
+		pins-nle-mosi-off {
+			pinmux = <PINMUX_GPIO197__FUNC_GPIO197>,
+				 <PINMUX_GPIO198__FUNC_GPIO198>;
+		};
+	};
+
+	aud_nle_mosi_on_pins: aud-nle-mosi-on-pins {
+		pins-nle-mosi-on {
+			pinmux = <PINMUX_GPIO197__FUNC_AUD_NLE_MOSI1>,
+				 <PINMUX_GPIO198__FUNC_AUD_NLE_MOSI0>;
+		};
+	};
+
 	cr50_int: cr50-irq-default-pins {
 		pins-gsc-ap-int-odl {
 			pinmux = <PINMUX_GPIO171__FUNC_GPIO171>;
@@ -987,6 +1208,30 @@ pins-report-sw {
 			output-low;
 		};
 	};
+
+	vow_clk_miso_off_pins: vow-clk-miso-off-pins {
+		pins-miso-off {
+			pinmux = <PINMUX_GPIO219__FUNC_GPIO219>;
+		};
+	};
+
+	vow_clk_miso_on_pins: vow-clk-miso-on-pins {
+		pins-miso-on {
+			pinmux = <PINMUX_GPIO219__FUNC_VOW_CLK_MISO>;
+		};
+	};
+
+	vow_dat_miso_off_pins: vow-dat-miso-off-pins {
+		pins-miso-off {
+			pinmux = <PINMUX_GPIO218__FUNC_GPIO218>;
+		};
+	};
+
+	vow_dat_miso_on_pins: vow-dat-miso-on-pins {
+		pins-miso-on {
+			pinmux = <PINMUX_GPIO218__FUNC_VOW_DAT_MISO>;
+		};
+	};
 };
 
 &pmic {
-- 
2.38.1

