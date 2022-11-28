Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9503E63A906
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiK1NKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbiK1NK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:10:27 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC131B78B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:10:25 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p8so17235102lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:10:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2VDk9WSgKE7gnZ+IZTtTJGUT3TjLU23nEk753LNAQ0=;
        b=DwqcsW908YXc8KDEdo/A2J4EN4ppOywI9129X6ZcT9BYy9znVcrr9i0J7/Yw3bwBX8
         n4h1JKhB1vzupvlKfFERiMOr9vQz+i6zsWLDPBJhVu/Tq42EiEiJJxRLZK0BSbS8vbAZ
         sHr82f3JtMEjl1dI3/2Ds3ICf/BhIlFYTmr7u3CdHC9gbF+qXUQ0NE5ToA0p2GU5gwy+
         aMi8W+fNPFIGPkpUiIjF2SXKS6kEUgBYbFbriHvVaO8/lmz3Uj1+/QnLExY6YsvMBVVX
         COZGpEfpOASXghSD8WHitpsqU/YIBxxCUF8MAJdoOMqQGePUiGAUNdjZpji6k1XlFW3S
         FNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x2VDk9WSgKE7gnZ+IZTtTJGUT3TjLU23nEk753LNAQ0=;
        b=ROhVSJAp6rqsloApWf7LoZkl9gN/R9bYU7RolO5c39nBqeV5Gh3P0jUyeurPVT6rwL
         qQ7/NJMl7JMwrHOzqfCqS+5vfFfRKTmTCZM+HHwvxwl9A5dJ4wNuCj291wMrm05qTDN9
         5f6Oha1QKXQ2jVsT81kR9udoMknR7JFL5jZkFogElvlli5IGFcOcIEEF+F766vT1M05/
         LiSY7ANHL4MDDgLGsO2ryydYbjY2ReTDQtRRfT67hoPw/Bygqlefq3x7j42WQBacIddO
         o35yoLI7IhoafHghi/e1as2s0qvY3NnPLZt+UG93FVluJ7UA8BIXU9mLFOXCd6B3E8/t
         HCdQ==
X-Gm-Message-State: ANoB5pkuwJ7uGGvK1qRsCPtLlc8CWn8JG2+p+sbdRqx8ixWLylMyJkHV
        W8oNvroC/Pt2CHeBJfM7J5GrLQ==
X-Google-Smtp-Source: AA0mqf6s1nctV4i4RXW1mj8ytVh7NNkyTWpvyXFfwC/ihIV5eP4Uj5nZGDp1RDwa1k9rgh1Rpyt6gg==
X-Received: by 2002:ac2:5f49:0:b0:4a4:7db1:b853 with SMTP id 9-20020ac25f49000000b004a47db1b853mr16285157lfz.562.1669641022383;
        Mon, 28 Nov 2022 05:10:22 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id j12-20020a056512028c00b004b40c1f1c70sm1725340lfp.212.2022.11.28.05.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 05:10:22 -0800 (PST)
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
Subject: [PATCH v5 3/3] arm64: dts: qcom: sm8450-hdk: add sound support
Date:   Mon, 28 Nov 2022 14:10:16 +0100
Message-Id: <20221128131016.127860-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128131016.127860-1-krzysztof.kozlowski@linaro.org>
References: <20221128131016.127860-1-krzysztof.kozlowski@linaro.org>
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

Changes since v3:
1. None.

Changes since v2:
1. Use ACTIVE_LOW for qcom,wcd9380-codec reset-gpios.
   https://lore.kernel.org/all/20221116053817.2929810-11-dmitry.torokhov@gmail.com/

Changes since v1:
1. Sort.
2. Correct include - do not use deprecated one and drop q6asm.h (not
   used).
---
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts | 160 ++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-hdk.dts b/arch/arm64/boot/dts/qcom/sm8450-hdk.dts
index 4d75f9db08c2..1e1393e732ca 100644
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
+		reset-gpios = <&tlmm 43 GPIO_ACTIVE_LOW>;
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

