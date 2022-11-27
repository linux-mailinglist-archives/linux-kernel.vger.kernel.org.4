Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5AB639CD7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 21:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiK0Ucv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 15:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiK0Ucr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 15:32:47 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54D9B1EE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:32:45 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p8so14510408lfu.11
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 12:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0gDo/HIJ5ncVUDYrkarKtCKmDOnSIZfAfAl1w/MHgI=;
        b=KYpkDM4QzkKiN1zXSO8kX6iIO1yF3HwGSWAOnjTkOOs7DunEAYL2hUO1p1MAC51Ty2
         iy4cweeM6mt9wlfpeESmyPB7rve4LOA0lt4GAxU5K/BxZ9syKVkVOspRQBoEyk/m/O8+
         UBwj9Vf68KfLBolMlgBSL7MwSBpxnlsq8I7lOz+aQwAMHMl7/jL5GGRB75hQqFZoXpMO
         rvsIL5VDWimXfKDca2KzuUORI4ff4Cwv943SLpab+b3sJ36ZETbB7XrLforQIDktc9Ve
         5qE7MjYXI80kDzUcjLj0MZDqywrpkLvuzSd2gyWaVNgbRUzYOcIoJnHZyR8cC76/r/jO
         X3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0gDo/HIJ5ncVUDYrkarKtCKmDOnSIZfAfAl1w/MHgI=;
        b=oHuA+tKSEyNQ+LvirUs2RJDu5tE/D9doks77kOzGlINSRkJQS7+JJABRBD1BYEJWnO
         7OJkDkGeTlQAugfy2o02ps5Gez11B1xMQtH3XAHl1+n9lNGb+xVCM+nU6CaXsCvgcSaB
         d2CdYTjNn+po9mewlOG13ftFUw6XChlzlgRfrwCYnZ1w5IcrFypXVxZwIgD2b458r+9s
         rHFy665wu2bV01HZAjt+xZAesfdW9wxPssTFEdKum6kko/+F/fmvowiWsoqc1Qq96RRd
         S3FzxnBIgWM1nH0wniOWFMTy0NxG+Iv1ZWwpCvjxZW5fdbn1QZzclGaASOkUPrvZb9UB
         /9bw==
X-Gm-Message-State: ANoB5pnyxQM6ZVRTrStMiVRE526HNFJ2uKtHjhs3HdDsqTeEyMvbAbTc
        vzJx3ag7JJd6+LdCkBA3baDR3A==
X-Google-Smtp-Source: AA0mqf6G7WiprC2mAXpjFSSad+86JRfluwDleJ+qfFmMoRoTHd5z8N4wUqhqvAQt+kDlBKtjrWEsPQ==
X-Received: by 2002:a05:6512:1681:b0:4a2:683d:3ba4 with SMTP id bu1-20020a056512168100b004a2683d3ba4mr18735394lfb.238.1669581164261;
        Sun, 27 Nov 2022 12:32:44 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w10-20020a05651234ca00b00494942bec60sm1412827lfr.17.2022.11.27.12.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 12:32:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/3] arm64: dts: qcom: align LED node names with dtschema
Date:   Sun, 27 Nov 2022 21:32:39 +0100
Message-Id: <20221127203240.54955-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221127203240.54955-1-krzysztof.kozlowski@linaro.org>
References: <20221127203240.54955-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and DT schema expects certain pattern:

  qcom/msm8998-oneplus-cheeseburger.dtb: leds: 'button-backlight' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
  qcom/sc7180-trogdor-coachz-r1.dtb: pwmleds: 'keyboard-backlight' does not match any of the regexes: '^led(-[0-9a-f]+)?$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Add Rb
---
 arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts | 2 +-
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi              | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
index b951f98d1b7b..9fb1fb9b8529 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dts
@@ -22,7 +22,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&button_backlight_default>;
 
-		button-backlight {
+		led-keypad-backlight {
 			gpios = <&pmi8998_gpio 5 GPIO_ACTIVE_HIGH>;
 			color = <LED_COLOR_ID_WHITE>;
 			function = LED_FUNCTION_KBD_BACKLIGHT;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 65601bea0797..74a90948db6b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -354,7 +354,7 @@ max98360a: audio-codec-0 {
 
 	pwmleds {
 		compatible = "pwm-leds";
-		keyboard_backlight: keyboard-backlight {
+		keyboard_backlight: led-0 {
 			status = "disabled";
 			label = "cros_ec::kbd_backlight";
 			function = LED_FUNCTION_KBD_BACKLIGHT;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
index 448da9794722..27f479ff9d80 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
@@ -307,7 +307,7 @@ max98360a: audio-codec-0 {
 	pwmleds: pwmleds {
 		compatible = "pwm-leds";
 		status = "disabled";
-		keyboard_backlight: keyboard-backlight {
+		keyboard_backlight: led-0 {
 			label = "cros_ec::kbd_backlight";
 			function = LED_FUNCTION_KBD_BACKLIGHT;
 			pwms = <&cros_ec_pwm 0>;
-- 
2.34.1

