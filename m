Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138456296A9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:02:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbiKOLCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbiKOLBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:01:20 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2002E8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:01:00 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id c1so23839646lfi.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ss1bNCsoUGuyRrJegUv7IlLBgJSjYxPesURJk8oYV6k=;
        b=El9l/L5l5zSSN3F4jyG1k5Ht6mgg4LS1RkwY7MaZkMJ+VjQ6wHehhBAccdXR+e8MZA
         fpV68Go+R1/YzgR91hgtWtutjC1Km+JedCZnv9okQ1S7MchT9qNI/I3c3RmDXRFn/2Tl
         dH/5LBIG71oL1OZpuBrFfh6lcyhSJECBdtGcgmMkavuj4+2MrRN4/ddiDo6rWL+RAv3L
         vf9/oFerFL4yLpoAAJ/uky7pFASPwUj+HgCp3wF/BC247wwsqYJhohK1Dapwn/OSyVfp
         Si/mcW0xn4qFuW7Eh/+oJ3NDMg1jTe85cy8ioA42s3EJFDVJLUEGjR6Di7p01jZIKN2L
         SqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ss1bNCsoUGuyRrJegUv7IlLBgJSjYxPesURJk8oYV6k=;
        b=2jEfWNOGmIIfc95y5IlXdrggNyhrbyRgyjgmKHJ998AjYCI7rlPzxS4gUi3NFucOVn
         npH225KkCE9Q63iFPUhdvkbqxw6EAVRKw17GEy1U8XqujGVlyqpIwUC/lt6REovuBhrR
         /zV2ChJG/ZiF6Y2dM76UGwVIuH/LZ7yxhsJa3asvtVbDLOdmCswVpQguxrorimbhxr00
         rngBbKlNm4pKfhWGTTmws51aJEWwNGXU/y69T7BAHhryixC583awZUD24iCVioE9Gtw3
         c2+M9fA5L+09fQpoeZcyz5lqGKqbV7LMtBbYr2cEbBkRK/Of92SO33D3ZsSwMNdhxO3a
         Cz2g==
X-Gm-Message-State: ANoB5plGvYbB6Qt/0AtdRiJ62cpdQiijMGs+yS84qAK4Jj1aQmKJNf51
        bQRsyx9BiMM11KjYIA1FfnA8Pg==
X-Google-Smtp-Source: AA0mqf5Sml6gAb2A2iiD4SLc3s7MeTaYv4GrLt9q4wDR67eYiEvOofY/lULhi3CJcIi9GlAnpC61Hg==
X-Received: by 2002:a05:6512:3885:b0:4a2:2d86:ad85 with SMTP id n5-20020a056512388500b004a22d86ad85mr5672911lft.277.1668510059169;
        Tue, 15 Nov 2022 03:00:59 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bf16-20020a056512259000b004b1b0f12cb4sm2152786lfb.201.2022.11.15.03.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 03:00:58 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: sm8450-hdk: add sound support
Date:   Tue, 15 Nov 2022 12:00:53 +0100
Message-Id: <20221115110053.110319-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115110053.110319-1-krzysztof.kozlowski@linaro.org>
References: <20221115110053.110319-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Add sound support to SM8450 HDK board.  Tested setup so far is only two
speakers (working) and head-phones (only one channel working).

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Co-developed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Sort.
2. Correct include - do not use deprecated one and drop q6asm.h (not
   used).
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 160 ++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 4d75f9db08c2..baff71c0c680 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
@@ -6,6 +6,7 @@
 /dts-v1/;
 
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
 #include "sm8450.dtsi"
 
 / {
@@ -406,6 +407,147 @@ &sdhc_2 {
 	status = "okay";
 };
 
+&soc {
+	wcd938x: codec {
+		compatible = "qcom,wcd9380-codec";
+
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+
+		reset-gpios = <&tlmm 43 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <1>;
+
+		vdd-buck-supply = <&vreg_s10b_1p8>;
+		vdd-rxtx-supply = <&vreg_s10b_1p8>;
+		vdd-io-supply = <&vreg_s10b_1p8>;
+		vdd-mic-bias-supply = <&vreg_bob>;
+	};
+};
+
+&sound {
+	compatible = "qcom,sm8450-sndcard";
+	model = "SM8450-HDK";
+	audio-routing = "SpkrLeft IN", "WSA_SPK1 OUT",
+			"SpkrRight IN", "WSA_SPK2 OUT",
+			"IN1_HPHL", "HPHL_OUT",
+			"IN2_HPHR", "HPHR_OUT",
+			"AMIC1", "MIC BIAS1",
+			"AMIC2", "MIC BIAS2",
+			"AMIC3", "MIC BIAS3",
+			"AMIC4", "MIC BIAS3",
+			"AMIC5", "MIC BIAS4";
+
+	wcd-playback-dai-link {
+		link-name = "WCD Playback";
+		cpu {
+			sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
+		};
+
+		codec {
+			sound-dai = <&wcd938x 0>, <&swr1 0>, <&rxmacro 0>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+
+	wcd-playback-dai-link {
+		link-name = "WCD Playback";
+		cpu {
+			sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
+		};
+
+		codec {
+			sound-dai = <&wcd938x 0>, <&swr1 0>, <&rxmacro 0>;
+		};
+
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
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+
+	va-dai-link {
+		link-name = "VA Capture";
+		cpu {
+			sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+};
+
+&swr0 {
+	right_spkr: speaker@0,1{
+		compatible = "sdw10217020200";
+		reg = <0 1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spkr_1_sd_n_active>;
+		powerdown-gpios = <&tlmm 1 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrRight";
+		#thermal-sensor-cells = <0>;
+		vdd-supply = <&vreg_s10b_1p8>;
+	};
+
+	left_spkr: speaker@0,2{
+		compatible = "sdw10217020200";
+		reg = <0 2>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&spkr_2_sd_n_active>;
+		powerdown-gpios = <&tlmm 89 GPIO_ACTIVE_LOW>;
+		#sound-dai-cells = <0>;
+		sound-name-prefix = "SpkrLeft";
+		#thermal-sensor-cells = <0>;
+		vdd-supply = <&vreg_s10b_1p8>;
+	};
+};
+
+&swr1 {
+	status = "okay";
+
+	wcd_rx: codec@0,4 {
+		compatible = "sdw20217010d00";
+		reg = <0 4>;
+		qcom,rx-port-mapping = <1 2 3 4 5>;
+	};
+};
+
+&swr2 {
+	status = "okay";
+
+	wcd_tx: codec@0,3 {
+		compatible = "sdw20217010d00";
+		reg = <0 3>;
+		/* ports: adc1_2, adc3_4, dmic0_3_mbhc, dmic4_7 */
+		qcom,tx-port-mapping = <1 1 2 3>;
+	};
+};
+
 &tlmm {
 	gpio-reserved-ranges = <28 4>, <36 4>;
 
@@ -461,3 +603,21 @@ &usb_1_qmpphy {
 	vdda-phy-supply = <&vreg_l6b_1p2>;
 	vdda-pll-supply = <&vreg_l1b_0p91>;
 };
+
+&tlmm {
+	spkr_1_sd_n_active: spkr-1-sd-n-active-state {
+		pins = "gpio1";
+		function = "gpio";
+		drive-strength = <4>;
+		bias-disable;
+		output-low;
+	};
+
+	spkr_2_sd_n_active: spkr-2-sd-n-active-state {
+		pins = "gpio89";
+		function = "gpio";
+		drive-strength = <4>;
+		bias-disable;
+		output-low;
+	};
+};
-- 
2.34.1

