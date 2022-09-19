Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39BE5BD240
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiISQdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiISQdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:33:38 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A1931366
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:33:37 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id a10so1688460ljq.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=defqrUNEvG4bqkKB1gVSiJ34xF9WDZALwjbZ1clCYn8=;
        b=gwgb7Ee3X2GnNkAKQt20mMDAAvkQhhW+K5/IkDLGRwbuHHgLs7LalQJoy0lUubxVDM
         jUW7jUFlVYVrZ1ZyaRsKdfEhZ6fetjTremEoxiuLLMeqeqpn/OjqMEFvoVgOXfvJf3mi
         J+ec9gkM30ZOnFX1ivKXe1i7LMQntCxmbhJ17soRsMnuWVyESLd784mRxRdw4Mb5LjjB
         7ShaofOahIs3ELU+L7jg2PVN860zUJitRcLNRByrmN2V+syKbCAMwv8Nu69cBsZuj3nz
         yLqbua6r8Yw8RDTnJ1CpQyty1B/ii7oixRwMWTrjAiTDeFTsvLmgXh/NS8qhVoERh795
         1j5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=defqrUNEvG4bqkKB1gVSiJ34xF9WDZALwjbZ1clCYn8=;
        b=oQDu0JwiGjSrwqmdVAvtf2it0q24AHVC8dXH/UfwsEZ/HSBJzSlSKw9jTT3bbJIsiw
         bp+2Y0QcBA6T3sUqwzmaAVoSz04bYTobGU6JF1SMIWb64acI6ODfMtWVVMnwWITO/P36
         A2KFPl9ughw680sV2PVRw3WXN7hFNNpVfW/fMLSPuBnUCwnhng91jp62EwRxbdRbEVLK
         ektRD0DQNE7CdObws++dxQJq/2C4odXwt7eUxtFXRPLYaUJc2e7BJ6yxhpelA2QXLwQ3
         1AlRYw4LNGiUxeoBNo3Z8cQHzLgoyEO9WvW5FwTfeCdGUhuimPVUpNz3NGqTPEqZK7Fg
         MZCg==
X-Gm-Message-State: ACrzQf3VDGZ7Yl8tDm4do3Z1lMd3f9bWKZUs93hNxhXtMrCTRLWEHrbj
        Gfk7XLeOcvxzgnf3ZzcNyhlQ0A==
X-Google-Smtp-Source: AMsMyM7rr3C1nw8vqmYa1ZnQn8ctVmWSYwb7aWn+DMjJkWd7yEP/GJ89KLP+cOjdOg3CaMqr0UWK+A==
X-Received: by 2002:a2e:bc11:0:b0:26c:565:12f6 with SMTP id b17-20020a2ebc11000000b0026c056512f6mr5259650ljf.91.1663605215900;
        Mon, 19 Sep 2022 09:33:35 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c128b00b0026c35c4720esm1883010ljc.24.2022.09.19.09.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 09:33:35 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: correct white-space before {
Date:   Mon, 19 Sep 2022 18:33:33 +0200
Message-Id: <20220919163333.129989-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Add missing space or remove redundant one before opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi                 | 2 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi                 | 8 ++++----
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts              | 4 ++--
 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi          | 8 ++++----
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi            | 6 +++---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts            | 8 ++++----
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts  | 4 ++--
 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts      | 6 +++---
 10 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 1e6b70582866..6a0420c079f5 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -1498,7 +1498,7 @@ blsp2_i2c3_sleep: blsp2-i2c3-sleep {
 				bias-disable;
 			};
 
-			wcd_intr_default: wcd-intr-default{
+			wcd_intr_default: wcd-intr-default {
 				pins = "gpio54";
 				function = "gpio";
 				drive-strength = <2>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index d463a66715ea..7e2a8b168d91 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -1903,7 +1903,7 @@ etm5: etm@7c40000 {
 
 			cpu = <&CPU4>;
 
-			port{
+			port {
 				etm4_out: endpoint {
 					remote-endpoint = <&apss_funnel_in4>;
 				};
@@ -1920,7 +1920,7 @@ etm6: etm@7d40000 {
 
 			cpu = <&CPU5>;
 
-			port{
+			port {
 				etm5_out: endpoint {
 					remote-endpoint = <&apss_funnel_in5>;
 				};
@@ -1937,7 +1937,7 @@ etm7: etm@7e40000 {
 
 			cpu = <&CPU6>;
 
-			port{
+			port {
 				etm6_out: endpoint {
 					remote-endpoint = <&apss_funnel_in6>;
 				};
@@ -1954,7 +1954,7 @@ etm8: etm@7f40000 {
 
 			cpu = <&CPU7>;
 
-			port{
+			port {
 				etm7_out: endpoint {
 					remote-endpoint = <&apss_funnel_in7>;
 				};
diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index bf8077a1cf9a..3d1bd8e3fc73 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -1007,7 +1007,7 @@ can@0 {
 };
 
 &swr0 {
-	left_spkr: wsa8810-left{
+	left_spkr: wsa8810-left {
 		compatible = "sdw10217211000";
 		reg = <0 3>;
 		powerdown-gpios = <&tlmm 130 GPIO_ACTIVE_HIGH>;
@@ -1016,7 +1016,7 @@ left_spkr: wsa8810-left{
 		#sound-dai-cells = <0>;
 	};
 
-	right_spkr: wsa8810-right{
+	right_spkr: wsa8810-right {
 		compatible = "sdw10217211000";
 		reg = <0 4>;
 		powerdown-gpios = <&tlmm 130 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index 7ee407f7b6bb..1ce73187a562 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -181,7 +181,7 @@ &sound_multimedia0_codec {
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
 &en_pp3300_dx_edp {
-	pinmux  {
+	pinmux {
 		pins = "gpio67";
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index 1bd6c7dcd9e9..7fcff4eddd3a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -189,7 +189,7 @@ pinconf {
 	};
 };
 
-&sec_mi2s_active{
+&sec_mi2s_active {
 	pinmux {
 		pins = "gpio49", "gpio50", "gpio51", "gpio52";
 		function = "mi2s_1";
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index b5f534db135a..6ea62ce138ce 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -1220,7 +1220,7 @@ pinconf {
 	};
 
 	ap_suspend_l_neuter: ap-suspend-l-neuter {
-		pinmux  {
+		pinmux {
 			pins = "gpio27";
 			function = "gpio";
 		};
@@ -1365,7 +1365,7 @@ pinconf {
 	};
 
 	pen_rst_odl: pen-rst-odl {
-		pinmux  {
+		pinmux {
 			pins = "gpio18";
 			function = "gpio";
 		};
@@ -1489,7 +1489,7 @@ pinconf {
 	};
 
 	ts_int_l: ts-int-l {
-		pinmux  {
+		pinmux {
 			pins = "gpio9";
 			function = "gpio";
 		};
@@ -1501,7 +1501,7 @@ pinconf {
 	};
 
 	ts_reset_l: ts-reset-l {
-		pinmux  {
+		pinmux {
 			pins = "gpio8";
 			function = "gpio";
 		};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index b5eb8f7eca1d..d46a6d2a7912 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -1341,7 +1341,7 @@ pinconf {
 	};
 
 	pen_rst_l: pen-rst-l {
-		pinmux  {
+		pinmux {
 			pins = "gpio23";
 			function = "gpio";
 		};
@@ -1408,7 +1408,7 @@ pinconf {
 	};
 
 	ts_int_l: ts-int-l {
-		pinmux  {
+		pinmux {
 			pins = "gpio125";
 			function = "gpio";
 		};
@@ -1420,7 +1420,7 @@ pinconf {
 	};
 
 	ts_reset_l: ts-reset-l {
-		pinmux  {
+		pinmux {
 			pins = "gpio118";
 			function = "gpio";
 		};
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 132417e2d11e..feb1396fadb6 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -1076,7 +1076,7 @@ &venus {
 	status = "okay";
 };
 
-&wcd9340{
+&wcd9340 {
 	pinctrl-0 = <&wcd_intr_default>;
 	pinctrl-names = "default";
 	clock-names = "extclk";
@@ -1089,7 +1089,7 @@ &wcd9340{
 	vdd-io-supply = <&vreg_s4a_1p8>;
 
 	swm: swm@c85 {
-		left_spkr: wsa8810-left{
+		left_spkr: wsa8810-left {
 			compatible = "sdw10217201000";
 			reg = <0 1>;
 			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
@@ -1098,7 +1098,7 @@ left_spkr: wsa8810-left{
 			#sound-dai-cells = <0>;
 		};
 
-		right_spkr: wsa8810-right{
+		right_spkr: wsa8810-right {
 			compatible = "sdw10217201000";
 			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
 			reg = <0 2>;
@@ -1126,7 +1126,7 @@ &qup_spi2_default {
 	drive-strength = <16>;
 };
 
-&qup_uart3_default{
+&qup_uart3_default {
 	pinmux {
 		pins = "gpio41", "gpio42", "gpio43", "gpio44";
 		function = "qup3";
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index be59a8ba9c1f..761927535778 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -783,7 +783,7 @@ &wcd9340{
 	qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
 
 	swm: swm@c85 {
-		left_spkr: wsa8810-left{
+		left_spkr: wsa8810-left {
 			compatible = "sdw10217211000";
 			reg = <0 3>;
 			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
@@ -792,7 +792,7 @@ left_spkr: wsa8810-left{
 			#sound-dai-cells = <0>;
 		};
 
-		right_spkr: wsa8810-right{
+		right_spkr: wsa8810-right {
 			compatible = "sdw10217211000";
 			powerdown-gpios = <&wcdgpio 2 GPIO_ACTIVE_HIGH>;
 			reg = <0 4>;
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index f954fe5cb61a..7e92438034e8 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -574,7 +574,7 @@ pinconf {
 	};
 
 	pen_rst_l: pen-rst-l {
-		pinmux  {
+		pinmux {
 			pins = "gpio21";
 			function = "gpio";
 		};
@@ -715,7 +715,7 @@ &wcd9340{
 	qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
 
 	swm: swm@c85 {
-		left_spkr: wsa8810-left{
+		left_spkr: wsa8810-left {
 			compatible = "sdw10217211000";
 			reg = <0 3>;
 			powerdown-gpios = <&wcdgpio 1 GPIO_ACTIVE_HIGH>;
@@ -724,7 +724,7 @@ left_spkr: wsa8810-left{
 			#sound-dai-cells = <0>;
 		};
 
-		right_spkr: wsa8810-right{
+		right_spkr: wsa8810-right {
 			compatible = "sdw10217211000";
 			powerdown-gpios = <&wcdgpio 2 GPIO_ACTIVE_HIGH>;
 			reg = <0 4>;
-- 
2.34.1

