Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D088962290F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiKIKwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiKIKvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:51:47 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E6CB853
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:51:46 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id b9so25152259ljr.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 02:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6uVPj3vvpgv0V2NAsSRZpNveHe0tqmLDbuaSRvPgUU=;
        b=FP5EWfFteZpuhMJvfGNinhvRW83DSBeZZgr9dQc9/NSjRG3OID7Dg+3GXfdEMejFRr
         PG6m6ru1YmOrlIYCswH7qoRxMi1ThS/57EN558sbsVYfxws3NsI/e3xWE/8LUKBn+Sx/
         5svFyKyipMJI/fXAVHan3Uqvs3uTVGxNQeTkTMXq8BE7gZqAqdrmrIweYAmhS2/I4tyQ
         SjIk+1NB/rW8nVaqZdNG08tdRcG+8ZuIbKLo0crRV4yKR6subbVynkEaJH8ULuGkuRAy
         pFVAZJHEHWsb2epZr4n3r+osROspTKV2n+b6geEqAqbK6TMigP7p+XfEWhaoHbjHf/GY
         fc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z6uVPj3vvpgv0V2NAsSRZpNveHe0tqmLDbuaSRvPgUU=;
        b=MLCGR3lJ7QnJxo+gkCHOFLV3KGYUjP0E04bS4XQ2RA4ldTRA7HuHinGabfswaCMzcD
         tnRLn6DjotH7kjcvuZGsNPv1GmXxo7QxJ9UefZsHUf+zQNgmHgYGYIv/FAgxTJg8Qbsn
         zh1TR/AFAVf1qlOKg7ziwC7JB9eZr4cgtvf+pdLa3oZS1EKhr+wZ9DVEbpEJmdEvsJ5q
         57QwQ6ekWUWk0QFXARhjBSF0g1nW1LscbO6ijEe/rm7TPkDimHeM49nYIA3AOVCiwnTG
         p7tOM55G3ALlCOWPxypgZAmJBjRpIJzrNrKnEBTQtdPFebD72TFCnVc2uA+wPpAmuNTX
         Er9w==
X-Gm-Message-State: ANoB5pl+SbPxtkMNvMnFxpA5SfaUAIt3D+ovqAN43VyrM5M/F04tF+12
        i880nhbadOpHq2rRtcaViaKvUxLGfnB0Ow==
X-Google-Smtp-Source: AA0mqf7wq32ciNH6dOWu0k5DfdCsRRPrGumc7vQd0jxx4Z3fV6yhErHn7eYpqJRuqWmT+7ru5pge4g==
X-Received: by 2002:a2e:2e12:0:b0:278:acaa:acda with SMTP id u18-20020a2e2e12000000b00278acaaacdamr3510236lju.305.1667991104667;
        Wed, 09 Nov 2022 02:51:44 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id l10-20020a056512110a00b004b005150e92sm2167508lfg.127.2022.11.09.02.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 02:51:43 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v2 2/3] ARM: dts: qcom-msm8960: use define for interrupt constants
Date:   Wed,  9 Nov 2022 11:51:39 +0100
Message-Id: <20221109105140.48196-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221109105140.48196-1-krzysztof.kozlowski@linaro.org>
References: <20221109105140.48196-1-krzysztof.kozlowski@linaro.org>
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

Replace GIC_PPI, GIC_SPI and interrupt type numbers with appropriate
defines.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

---

Changes since v1:
1. Add Rb tag
---
 arch/arm/boot/dts/qcom-msm8960-cdp.dts |  2 +-
 arch/arm/boot/dts/qcom-msm8960.dtsi    | 22 ++++++++++++----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
index cb0f612e6c90..3a484ac53917 100644
--- a/arch/arm/boot/dts/qcom-msm8960-cdp.dts
+++ b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
@@ -42,7 +42,7 @@ ethernet@0 {
 		compatible = "micrel,ks8851";
 		reg = <0>;
 		interrupt-parent = <&msmgpio>;
-		interrupts = <90 8>;
+		interrupts = <90 IRQ_TYPE_LEVEL_LOW>;
 		spi-max-frequency = <5400000>;
 		vdd-supply = <&ext_l2>;
 		vdd-io-supply = <&pm8921_lvs6>;
diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index 30abf53b062d..2f32e734f18d 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -17,7 +17,7 @@ / {
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		interrupts = <1 14 0x304>;
+		interrupts = <GIC_PPI 14 0x304>;
 
 		cpu@0 {
 			compatible = "qcom,krait";
@@ -52,7 +52,7 @@ memory {
 
 	cpu-pmu {
 		compatible = "qcom,krait-pmu";
-		interrupts = <1 10 0x304>;
+		interrupts = <GIC_PPI 10 0x304>;
 		qcom,no-pc-write;
 	};
 
@@ -105,9 +105,9 @@ intc: interrupt-controller@2000000 {
 		timer@200a000 {
 			compatible = "qcom,kpss-timer",
 				     "qcom,kpss-wdt-msm8960", "qcom,msm-timer";
-			interrupts = <1 1 0x301>,
-				     <1 2 0x301>,
-				     <1 3 0x301>;
+			interrupts = <GIC_PPI 1 0x301>,
+				     <GIC_PPI 2 0x301>,
+				     <GIC_PPI 3 0x301>;
 			reg = <0x0200a000 0x100>;
 			clock-frequency = <27000000>,
 					  <32768>;
@@ -119,7 +119,7 @@ msmgpio: pinctrl@800000 {
 			gpio-controller;
 			gpio-ranges = <&msmgpio 0 0 152>;
 			#gpio-cells = <2>;
-			interrupts = <0 16 0x4>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg = <0x800000 0x4000>;
@@ -255,7 +255,7 @@ ssbi@500000 {
 			pmicintc: pmic {
 				compatible = "qcom,pm8921";
 				interrupt-parent = <&msmgpio>;
-				interrupts = <104 8>;
+				interrupts = <104 IRQ_TYPE_LEVEL_LOW>;
 				#interrupt-cells = <2>;
 				interrupt-controller;
 				#address-cells = <1>;
@@ -265,7 +265,8 @@ pwrkey@1c {
 					compatible = "qcom,pm8921-pwrkey";
 					reg = <0x1c>;
 					interrupt-parent = <&pmicintc>;
-					interrupts = <50 1>, <51 1>;
+					interrupts = <50 IRQ_TYPE_EDGE_RISING>,
+						     <51 IRQ_TYPE_EDGE_RISING>;
 					debounce = <15625>;
 					pull-up;
 				};
@@ -274,7 +275,8 @@ keypad@148 {
 					compatible = "qcom,pm8921-keypad";
 					reg = <0x148>;
 					interrupt-parent = <&pmicintc>;
-					interrupts = <74 1>, <75 1>;
+					interrupts = <74 IRQ_TYPE_EDGE_RISING>,
+						     <75 IRQ_TYPE_EDGE_RISING>;
 					debounce = <15>;
 					scan-delay = <32>;
 					row-hold = <91500>;
@@ -283,7 +285,7 @@ keypad@148 {
 				rtc@11d {
 					compatible = "qcom,pm8921-rtc";
 					interrupt-parent = <&pmicintc>;
-					interrupts = <39 1>;
+					interrupts = <39 IRQ_TYPE_EDGE_RISING>;
 					reg = <0x11d>;
 					allow-set-time;
 				};
-- 
2.34.1

