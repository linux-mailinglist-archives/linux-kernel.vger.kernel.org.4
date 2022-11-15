Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00BB6629FE5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiKORDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKORDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:03:11 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9692F660
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:03:03 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so10755933wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoD9BdEjJzTDsHhj5zz1P6YN6LPcI0+uERdYyYITJrk=;
        b=zc3U4gbXN+qQe9UhxIKb+ZoaEzXtpZjjrDEsmM2K2DVO6CwVcxJdH4Pwzx42ysH91p
         dogdUesMkWtWVUjWwvlVQJmJaaZC739y5pKBfpPDviUwauLcb6OQLOv9ILCYvcltZH1u
         hIWwFUfLdAKfVmZ2b0zlZnl0Zs4YMoF9m+ptKKZYk9UfCL4YirIyZ0oPn2JVr35JU74f
         DbAEFur4k++emM8d8UxtBuPs3jXu8WXnIEec6vTrB8qrI+qKY7Wmt9PXUMnJNTx/pxzX
         UVvaHIRk9Nx9WcHa9vb4VKsk6GClFRftgGYgowivbVkKPtNW84haK8r3JxuhmfputYuM
         3RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoD9BdEjJzTDsHhj5zz1P6YN6LPcI0+uERdYyYITJrk=;
        b=0MXmLWTa3Bw7+GpnajgN6Pwa0+0TTjv8saR00RYV0tnM+DAM/IhI3dUhTuZQRt21MR
         AbPk/vSZwgoAYAKS/awBNjsa7DP2BWT6GqyTJ6SLP7ZBFHw5WzG9sSCoZeoIB6DSqLgo
         aQ/BfoMiBqbMtUKSsEM2ZEMZU8nCn/HF14bIMWQv1I+aVxkeqscb9rSeBlXad1dmHgyw
         +fQpJdb61bSXfYXreekZfWR8boIgC5aHSQBjsE4/aVixxaib8FS68NcONCy4YH7QFHRZ
         B3kvO9ODhVABpuHgNzkY2apJR6X06g/UVT6o5OzO1N5AH7Je0KBQC53hzLFYWsHemlAJ
         W9jA==
X-Gm-Message-State: ANoB5plvhBKfZQu9+CYjvfy5Uy8ESk9jx0wO8sneIir5nICc9El0AU5D
        tSrWB4eqcxVY3R1DI2a2QjRhqOAR6aIt/Q==
X-Google-Smtp-Source: AA0mqf5sSLN8NnKfa1VTnmcRS4GraB2X5+Wq44gR3qvRAtfdF/f1scYwE1uGJIwU9j50/AQ9qQFYwA==
X-Received: by 2002:a05:600c:4998:b0:3cf:b102:c0e8 with SMTP id h24-20020a05600c499800b003cfb102c0e8mr1035786wmp.169.1668531782242;
        Tue, 15 Nov 2022 09:03:02 -0800 (PST)
Received: from localhost.localdomain ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c215500b003c6c3fb3cf6sm15747090wml.18.2022.11.15.09.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 09:03:01 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sc8280xp: Add soundcard support
Date:   Tue, 15 Nov 2022 17:02:42 +0000
Message-Id: <20221115170242.150246-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221115170242.150246-1-srinivas.kandagatla@linaro.org>
References: <20221115170242.150246-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SoundCard on X13s. This patch adds support for Headset
Playback, record and 2 DMICs on the Panel along with the regulators
required for powering up the LPASS codecs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 213 ++++++++++++++++++
 1 file changed, 213 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index b2b744bb8a53..99c3021e8149 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -58,6 +58,16 @@ vreg_misc_3p3: regulator-misc-3p3 {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "VPH_VCC3R9";
+		regulator-min-microvolt = <3900000>;
+		regulator-max-microvolt = <3900000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
 };
 
 &apps_rsc {
@@ -67,6 +77,13 @@ pmc8280-1-rpmh-regulators {
 
 		vdd-l3-l5-supply = <&vreg_s11b>;
 
+		vreg_s10b: smps10 {
+			regulator-name = "vreg_s10b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_s11b: smps11 {
 			regulator-name = "vreg_s11b";
 			regulator-min-microvolt = <1272000>;
@@ -74,6 +91,13 @@ vreg_s11b: smps11 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_s12b: smps12 {
+			regulator-name = "vreg_s12b";
+			regulator-min-microvolt = <984000>;
+			regulator-max-microvolt = <984000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l3b: ldo3 {
 			regulator-name = "vreg_l3b";
 			regulator-min-microvolt = <1200000>;
@@ -102,6 +126,7 @@ vreg_l6b: ldo6 {
 	pmc8280c-rpmh-regulators {
 		compatible = "qcom,pm8350c-rpmh-regulators";
 		qcom,pmic-id = "c";
+		vdd-bob-supply = <&vph_pwr>;
 
 		vreg_l1c: ldo1 {
 			regulator-name = "vreg_l1c";
@@ -123,6 +148,13 @@ vreg_l13c: ldo13 {
 			regulator-max-microvolt = <3072000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
+
+		vreg_bob: bob {
+			regulator-name = "vreg_bob";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+		};
 	};
 
 	pmc8280-2-rpmh-regulators {
@@ -268,6 +300,80 @@ &remoteproc_nsp0 {
 	status = "okay";
 };
 
+&sound {
+	compatible = "qcom,sc8280xp-sndcard";
+	model = "SC8280XP-LENOVO-X13S";
+	audio-routing =
+		"SpkrLeft IN", "WSA_SPK1 OUT",
+		"SpkrRight IN", "WSA_SPK2 OUT",
+		"IN1_HPHL", "HPHL_OUT",
+		"IN2_HPHR", "HPHR_OUT",
+		"AMIC2", "MIC BIAS2",
+		"VA DMIC0", "MIC BIAS1",
+		"VA DMIC1", "MIC BIAS1",
+		"VA DMIC2", "MIC BIAS3",
+		"TX DMIC0", "MIC BIAS1",
+		"TX DMIC1", "MIC BIAS2",
+		"TX DMIC2", "MIC BIAS3",
+		"TX SWR_ADC1", "ADC2_OUTPUT";
+
+	wcd-playback-dai-link {
+		link-name = "WCD Playback";
+		cpu {
+			sound-dai = <&q6apmbedai  RX_CODEC_DMA_RX_0>;
+		};
+		codec {
+			sound-dai = <&wcd938x 0>, <&swr1 0>, <&rxmacro 0>;
+		};
+		platform {
+			sound-dai = <&q6apm>;
+		};
+		};
+
+	wcd-capture-dai-link {
+		link-name = "WCD Capture";
+		cpu {
+			sound-dai = <&q6apmbedai  TX_CODEC_DMA_TX_3>;
+		};
+
+		codec {
+			sound-dai = <&wcd938x 1>, <&swr2 0>, <&txmacro 0>;
+		};
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+
+	wsa-dai-link {
+		link-name = "WSA Playback";
+		cpu {
+			sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
+		};
+
+		codec {
+			sound-dai = <&left_spkr>, <&right_spkr>, <&swr0 0>, <&wsamacro 0>;
+		};
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+
+	va-dai-link {
+		link-name = "VA Capture";
+		cpu {
+			sound-dai = <&q6apmbedai  TX_CODEC_DMA_TX_3>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+
+		codec {
+			sound-dai = <&vamacro 0>;
+		};
+	};
+};
+
 &usb_0 {
 	status = "okay";
 };
@@ -346,9 +452,96 @@ edp_bl_pwm: edp-bl-pwm-state {
 	};
 };
 
+&soc {
+	wcd938x: codec {
+		compatible = "qcom,wcd9380-codec";
+		#sound-dai-cells = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&wcd_default>;
+		reset-gpios = <&tlmm 106 0>;
+
+		vdd-buck-supply = <&vreg_s10b>;
+		vdd-rxtx-supply = <&vreg_s10b>;
+		vdd-io-supply = <&vreg_s10b>;
+		vdd-mic-bias-supply = <&vreg_bob>;
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+	};
+};
+
+&swr0 {
+	left_spkr: wsa8830-left@0,1 {
+		compatible = "sdw10217020200";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spkr_1_sd_n_active>;
+		powerdown-gpios = <&tlmm 178 GPIO_ACTIVE_HIGH>;
+		reg = <0 1>;
+		#thermal-sensor-cells = <0>;
+		sound-name-prefix = "SpkrLeft";
+		#sound-dai-cells = <0>;
+		vdd-supply = <&vreg_s10b>;
+	};
+
+	right_spkr: wsa8830-right@0,2{
+		pinctrl-names = "default";
+		pinctrl-0 = <&spkr_2_sd_n_active>;
+		powerdown-gpios = <&tlmm 179 GPIO_ACTIVE_HIGH>;
+		compatible = "sdw10217020200";
+		reg = <0 2>;
+		#thermal-sensor-cells = <0>;
+		sound-name-prefix = "SpkrRight";
+		#sound-dai-cells = <0>;
+		vdd-supply = <&vreg_s10b>;
+	};
+};
+
+
+&swr1 {
+	status = "okay";
+
+	wcd_rx: wcd9380-rx@0,4 {
+		compatible = "sdw20217010d00";
+		reg = <0 4>;
+		qcom,rx-port-mapping = <1 2 3 4 5 6>;
+
+	};
+};
+
+&swr2 {
+	status = "okay";
+
+	wcd_tx: wcd9380-tx@0,3 {
+		compatible = "sdw20217010d00";
+		reg = <0 3>;
+		qcom,tx-port-mapping = <1 1 2 3>;
+	};
+};
+
+&vamacro {
+	pinctrl-0 = <&dmic01_active>, <&dmic02_active>;
+	pinctrl-names = "default";
+	vdd-micb-supply = <&vreg_s10b>;
+	qcom,dmic-sample-rate = <600000>;
+};
+
 &tlmm {
 	gpio-reserved-ranges = <70 2>, <74 6>, <83 4>, <125 2>, <128 2>, <154 7>;
 
+	wcd_default: wcd-default-state {
+		reset {
+			pins = "gpio106";
+			function = "gpio";
+			bias-disable;
+		};
+	};
+
 	kybd_default: kybd-default-state {
 		disable {
 			pins = "gpio102";
@@ -383,6 +576,26 @@ qup2_i2c5_default: qup2-i2c5-default-state {
 		drive-strength = <16>;
 	};
 
+	spkr_1_sd_n_active: spkr_1_sd_n_active {
+		perst-n {
+			pins = "gpio178";
+			function = "gpio";
+			drive-strength = <16>;
+			bias-disable;
+			output-high;
+		};
+	};
+
+	spkr_2_sd_n_active: spkr_2_sd_n_active {
+		perst-n {
+			pins = "gpio179";
+			function = "gpio";
+			drive-strength = <16>;
+			bias-disable;
+			output-high;
+		};
+	};
+
 	tpad_default: tpad-default-state {
 		int-n {
 			pins = "gpio182";
-- 
2.25.1

