Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D070F638C98
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiKYOnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiKYOnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:43:00 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337DC45EC7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:42:16 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g12so7226854lfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a1xSVUhkUfrXUhf8CMusEDuKEs4N/AtKVgIpTqaWjgU=;
        b=rV7OXzdx6QVyI+A/2k8RpReSXMFb0Dnhi5C6GaVYBIDNoVggmmoQh/xQohAiGKVMf2
         WdkeIGQUuIURvOnmj+VWZlDV4+zhUnPeWMpcQI2EEk+xpdBN0DtqgnXVx389EqvzMFGG
         zXgBXx2MWglY8+Bv9MzWCSORTnp2NZAcNwPGuHeMrFHF6A+oNH78ZT0OtSkwfYs33HkE
         HWKBH3Lp8gW0SkUpUzlFRQa+5RG0gL4QQjn0oGceBduqcjS1WzqPvZQEFOgjyBb3WbEt
         gzwVTGwfwLNWgNKTg8qJwFkHN39aP7KWydVuOpsDGWgtwkK0SzTApE9MwEapc7OgjA+R
         0b1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a1xSVUhkUfrXUhf8CMusEDuKEs4N/AtKVgIpTqaWjgU=;
        b=QWUHuQMokbGLT1fb75/OQLKnMWYLy89UV6Xy89KGbmAm6GJwuCz+6EK4jmZVLSY1Qk
         Lwcs50Bmpae7njzqcfbOuQFsbmA0HupU9mEAh4w+BNwV9nVZrRLQFu8vGjuXrx4Gt5pj
         K6o7iI/OwPiOEqFDIEikH1piCT0Z1Wjtxu/y/pBoQqLx0PsWd/a5T9JFfM/F7Mwy66VN
         ovJNth2ilXXi1/SbrE+OyPGRiS/aLfMc30JRl+a2P43B8ffQMhJIRbdR/rj5psFoE7g9
         wJaRJaW24oXEDf9ybliBooEqiPa5KHBnUgplF0PuUcvy22JQSkX2ARKmzdEvTbrDcdvO
         vORg==
X-Gm-Message-State: ANoB5pnyF5UCThqvZ0n/6TNVR7ZliyN9I924VhY8PnG/ZTu2790asZeF
        7SV8HT/DkXbwrsbnDCDOnlSctw==
X-Google-Smtp-Source: AA0mqf62WPBt2G+cougPd3AQ5x/TOUIZAgyUfpsCm/dfHDCoT2+gYaVYZO2DA+CR98ghz03PzC6GbA==
X-Received: by 2002:a19:2d0c:0:b0:4ad:5fbb:a5b9 with SMTP id k12-20020a192d0c000000b004ad5fbba5b9mr12365525lfj.98.1669387334578;
        Fri, 25 Nov 2022 06:42:14 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c13-20020a056512238d00b0049ebc44994fsm553711lfv.128.2022.11.25.06.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:42:14 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] ARM: dts: qcom: align LED node names with dtschema
Date:   Fri, 25 Nov 2022 15:42:09 +0100
Message-Id: <20221125144209.477328-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125144209.477328-1-krzysztof.kozlowski@linaro.org>
References: <20221125144209.477328-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and DT schema expects certain pattern:

  qcom-ipq4018-ap120c-ac.dtb: leds: 'wlan2g', 'wlan5g' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts | 6 +++---
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts     | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
index cf7da1ab177c..1b27edce9d4f 100644
--- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
+++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
@@ -9,7 +9,7 @@ / {
 	leds {
 		compatible = "gpio-leds";
 
-		power {
+		led-power {
 			label = "ap120c-ac:green:power";
 			function = LED_FUNCTION_POWER;
 			color = <LED_COLOR_ID_GREEN>;
@@ -17,14 +17,14 @@ power {
 			default-state = "on";
 		};
 
-		wlan {
+		led-wlan {
 			label = "ap120c-ac:green:wlan";
 			function = LED_FUNCTION_WLAN;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
 		};
 
-		support {
+		led-support {
 			label = "ap120c-ac:green:support";
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&tlmm 2 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
index c4f89b712fd9..a707057c887d 100644
--- a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
+++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
@@ -7,7 +7,7 @@ / {
 	leds {
 		compatible = "gpio-leds";
 
-		status: status {
+		status: led-status {
 			label = "ap120c-ac:blue:status";
 			function = LED_FUNCTION_STATUS;
 			color = <LED_COLOR_ID_BLUE>;
@@ -15,7 +15,7 @@ status: status {
 			default-state = "keep";
 		};
 
-		wlan2g {
+		led-wlan2g {
 			label = "ap120c-ac:green:wlan2g";
 			function = LED_FUNCTION_WLAN;
 			color = <LED_COLOR_ID_GREEN>;
@@ -23,7 +23,7 @@ wlan2g {
 			linux,default-trigger = "phy0tpt";
 		};
 
-		wlan5g {
+		led-wlan5g {
 			label = "ap120c-ac:red:wlan5g";
 			function = LED_FUNCTION_WLAN;
 			color = <LED_COLOR_ID_RED>;
-- 
2.34.1

