Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814CA6598D8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 14:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiL3NkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 08:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbiL3NkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 08:40:14 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54761AA10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:40:11 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id cf42so31782621lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 05:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbE+K1V33STlNIobmJkEvdLotZGVugVBlVND6uKni5w=;
        b=vH5UVIJMR1DDuxJ6REt01BhKgVgGs/UrJTPtWsDKwK7zJnnK2doG9d/83ieKraoJBL
         I6MvHVRILRGUM4rSXg3MDi2919cQuFRc5MC+UZbkhQKzJmWNPNn9mx2JtLHbZ06NDr3D
         IDvnmY/76Ma4MCRHZz5JNHtgY6FXEuat7dRa7m6Ne20iBfOOZt0qnkG79nzLumpJu9DQ
         tQc3Qz+z6j+p3rKOEPZpCgJx/6rJDIN6+iIvLa4+oD3CYRt9ViQ2fRcFzFd+Tlqnuej1
         g1UmUjK6ChSfnDi3pKYdQyD1xMKas3aLHK4NjVU/YMlIRyI6m+CcuUpSxoExqm6tjIra
         uprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BbE+K1V33STlNIobmJkEvdLotZGVugVBlVND6uKni5w=;
        b=swxMdD4cmLMVOvgkSrZik5D7jEUv4++/P5UMLlRRKHa7FiBBOJGi3dISYbiE8cqjJF
         NYUVQcMJokFUz/3K5DSE3STlEu1tT+Uia17t70rSWA1X/PD9AXwPWJP5tAS2cvQVKirH
         KMD1JcNxx0r/zP4H5wbXJ2D4JJBMqF0IY2qCyiZMgFQW3d5aTOF0mC13MMn7q9BbVAZE
         XDM7DL/WcDcGlwFkv1WuYoKo8nLHtT0P5YGbNSsBU0CZmGIH1t/AaPtrLOt3I4tjZYNP
         ESKmKlxMrwr1Zp5932UsHvx20Sxl1hHk8HMc7FrbFgtSinCFHi3kpaYxs3OnDiv6LYwy
         YNYQ==
X-Gm-Message-State: AFqh2kr+GVRMo4j3w2xvr93vo3VY3QvpE2/cqO6YHm/FuYozqwI6hcGu
        uRtBNn3MyGB6VxoYs7HNgYTJ17GSl61XfaaG
X-Google-Smtp-Source: AMrXdXuqpVIHdRMw3rp9QuX0bse0xaVC8Y1cfDPH0WluvPwdrcOmNba60vEubQGMOBi7xatifIvZRw==
X-Received: by 2002:a05:6512:1687:b0:4cb:bf8:cf0e with SMTP id bu7-20020a056512168700b004cb0bf8cf0emr5038575lfb.19.1672407610244;
        Fri, 30 Dec 2022 05:40:10 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q30-20020a19431e000000b004b373f61a60sm3462359lfa.96.2022.12.30.05.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 05:40:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: add missing space before {
Date:   Fri, 30 Dec 2022 14:40:06 +0100
Message-Id: <20221230134006.48111-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221230134006.48111-1-krzysztof.kozlowski@linaro.org>
References: <20221230134006.48111-1-krzysztof.kozlowski@linaro.org>
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

Add missingh whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi                        | 2 +-
 arch/arm64/boot/dts/qcom/sc7180.dtsi                         | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi        | 2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts   | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts         | 2 +-
 arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts             | 2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi                         | 2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi                         | 2 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi                         | 2 +-
 arch/arm64/boot/dts/qcom/sm8450.dtsi                         | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index d2b3fdf2df13..cbdf7c1f31b9 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -3292,7 +3292,7 @@ blsp2_i2c6: i2c@75ba000 {
 			status = "disabled";
 		};
 
-		blsp2_spi6: spi@75ba000{
+		blsp2_spi6: spi@75ba000 {
 			compatible = "qcom,spi-qup-v2.2.1";
 			reg = <0x075ba000 0x600>;
 			interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index c20e48da44f8..031320baec3d 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -3419,7 +3419,7 @@ watchdog@17c10000 {
 			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		timer@17c20000{
+		timer@17c20000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 0 0 0x20000000>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
index 7fc0b6bfc0d6..552646c073e2 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-zombie.dtsi
@@ -70,7 +70,7 @@ &pcie1_phy {
 	status = "okay";
 };
 
-&pm8350c_pwm_backlight{
+&pm8350c_pwm_backlight {
 	/* Set the PWM period to 200 microseconds (5kHz duty cycle) */
 	pwms = <&pm8350c_pwm 3 200000>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 0201c6776746..1a5a5764e6a1 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -743,7 +743,7 @@ left_spkr: wsa8830-left@0,1 {
 		vdd-supply = <&vreg_s10b>;
 	};
 
-	right_spkr: wsa8830-right@0,2{
+	right_spkr: wsa8830-right@0,2 {
 		compatible = "sdw10217020200";
 		reg = <0 2>;
 		pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
index c3453f291286..64de4ed9b0c8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium-common.dtsi
@@ -541,7 +541,7 @@ &venus {
 	firmware-name = "qcom/sdm845/beryllium/venus.mbn";
 };
 
-&wcd9340{
+&wcd9340 {
 	pinctrl-0 = <&wcd_intr_default>;
 	pinctrl-names = "default";
 	clock-names = "extclk";
diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 501232bdf9cf..d9581f4440b3 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -745,7 +745,7 @@ &venus {
 	status = "okay";
 };
 
-&wcd9340{
+&wcd9340 {
 	pinctrl-0 = <&wcd_intr_default>;
 	pinctrl-names = "default";
 	clock-names = "extclk";
diff --git a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
index 9215066146ff..6730804f4e3e 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dts
@@ -654,7 +654,7 @@ &venus {
 	firmware-name = "qcom/sdm850/samsung/w737/qcvss850.mbn";
 };
 
-&wcd9340{
+&wcd9340 {
 	pinctrl-0 = <&wcd_intr_default>;
 	pinctrl-names = "default";
 	clock-names = "extclk";
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 90dec84055c3..5886710b3c65 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -4124,7 +4124,7 @@ timer@17c20000 {
 			reg = <0x0 0x17c20000 0x0 0x1000>;
 			clock-frequency = <19200000>;
 
-			frame@17c21000{
+			frame@17c21000 {
 				frame-number = <0>;
 				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index ab5a2851a314..6c7adce6c9b8 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2397,7 +2397,7 @@ aoncc: clock-controller@3380000 {
 			clock-names = "core", "audio", "bus";
 		};
 
-		lpass_tlmm: pinctrl@33c0000{
+		lpass_tlmm: pinctrl@33c0000 {
 			compatible = "qcom,sm8250-lpass-lpi-pinctrl";
 			reg = <0 0x033c0000 0x0 0x20000>,
 			      <0 0x03550000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 1d5b52b13cc2..a7da48b7e788 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1598,7 +1598,7 @@ lpass_ag_noc: interconnect@3c40000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
-		compute_noc: interconnect@a0c0000{
+		compute_noc: interconnect@a0c0000 {
 			compatible = "qcom,sm8350-compute-noc";
 			reg = <0 0x0a0c0000 0 0xa180>;
 			#interconnect-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 73df5494d49c..33db6b6c4123 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3519,7 +3519,7 @@ qup_uart20_default: qup-uart20-default-state {
 
 		};
 
-		lpass_tlmm: pinctrl@3440000{
+		lpass_tlmm: pinctrl@3440000 {
 			compatible = "qcom,sm8450-lpass-lpi-pinctrl";
 			reg = <0 0x3440000 0x0 0x20000>,
 			      <0 0x34d0000 0x0 0x10000>;
-- 
2.34.1

