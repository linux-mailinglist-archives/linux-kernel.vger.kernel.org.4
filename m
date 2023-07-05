Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB2674874B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbjGEPBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjGEPBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:01:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDB31988
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:01:09 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fba74870abso8059655e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569262; x=1691161262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bi/qhL/amVn9cSk1RJ3+DaMnxwYcLBtEtjGGLlZJPEY=;
        b=mi6VKoRVSfTBWw1WGUne+VgG3biUy/cKs124VyeP6UUihGikb7jpKi+3yckMidxGjD
         Iy+fBQ0c3ToMOgQJqpQgGaFhCd6bJIOCW4vH5IeTE4yH8n+duBVwKzNmofxRVogQZ0p8
         JrOaUOfQrW4aJaFz7uVR7PM294y0uvjBU3ncN3xvjFprEsxSNKlamlMUuKBFoCRTfhuS
         TMWkEWlSonGhrZSoiwS0u34FQyY4bPEgzPL6tsJXJpWbivBHWMM1YaJdOJAJb1IeQVDT
         8hdnyRoI0sxtDT/sDFm7ZlmIxANUhpqM7ezpRDEtoHvjYLL0xtslo3N83DoibUxxyf1Z
         ILeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569262; x=1691161262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bi/qhL/amVn9cSk1RJ3+DaMnxwYcLBtEtjGGLlZJPEY=;
        b=lRJnSVdPHiHe1QyXLkGXbMidbefcRrZovnKVc0mgHSgPcinKDiy6oFdy6fET0MOkqt
         t/H4tcGOZ1Mq8X8qBnsZd3Raq8c/ldTP4JfxmbYMRBKNgCAsWd/uho7oBLBVZM30NX+/
         51cdGIfxa1iOPN0iWB/NnvA5evwcBESYTJdoxQvmSX1X8YFUSqtxHD4AeHdDnTtfJZOV
         cjSzasOg9d8yXB+0uUYNmiwReBLPSXNvYYsZJhNLsDNN6h85VUc9AIHwsoY10Ry+Sbxz
         vfNgHPUt2yyRhC5EqiXTUOOO2EFVAnkDc0d4/Qkn1ncdmfT9wXSqPGVNE79uuwl9dmY6
         Og2g==
X-Gm-Message-State: ABy/qLbj5TiuS12gFfZbz1T774LFFLFhSSe9IDpqOfBNEGHZdKFtOToc
        PMOg/UZ7Zu0Fng+QHCzK4iHXnA==
X-Google-Smtp-Source: APBJJlENmmJx+kdCcxE661JUH6JxmKZGINFJz7pEGFThSXWfdDoHZb5Cu1BPzOAMhoFYrOd9BojPrA==
X-Received: by 2002:a05:6512:10c9:b0:4f8:6bca:50d7 with SMTP id k9-20020a05651210c900b004f86bca50d7mr13373059lfg.13.1688569261732;
        Wed, 05 Jul 2023 08:01:01 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id bc23-20020a056402205700b0051d9dbf5edfsm11265427edb.55.2023.07.05.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:01:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: microchip: add missing space before {
Date:   Wed,  5 Jul 2023 17:00:58 +0200
Message-Id: <20230705150058.293942-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing whitespace between node name/label and opening {.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/microchip/at91sam9260.dtsi       | 2 +-
 arch/arm/boot/dts/microchip/at91sam9261.dtsi       | 2 +-
 arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts | 2 +-
 arch/arm/boot/dts/microchip/at91sam9g45.dtsi       | 2 +-
 arch/arm/boot/dts/microchip/at91sam9m10g45ek.dts   | 2 +-
 arch/arm/boot/dts/microchip/at91sam9rl.dtsi        | 2 +-
 arch/arm/boot/dts/microchip/at91sam9x5.dtsi        | 2 +-
 arch/arm/boot/dts/microchip/sama5d3.dtsi           | 2 +-
 arch/arm/boot/dts/microchip/sama5d4.dtsi           | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/microchip/at91sam9260.dtsi b/arch/arm/boot/dts/microchip/at91sam9260.dtsi
index 35a007365b6a..27b4a21f13c1 100644
--- a/arch/arm/boot/dts/microchip/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9260.dtsi
@@ -65,7 +65,7 @@ main_xtal: main_xtal {
 			clock-frequency = <0>;
 		};
 
-		adc_op_clk: adc_op_clk{
+		adc_op_clk: adc_op_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <5000000>;
diff --git a/arch/arm/boot/dts/microchip/at91sam9261.dtsi b/arch/arm/boot/dts/microchip/at91sam9261.dtsi
index 528ffc6f6f96..307b60658014 100644
--- a/arch/arm/boot/dts/microchip/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9261.dtsi
@@ -205,7 +205,7 @@ usart1: serial@fffb4000 {
 				status = "disabled";
 			};
 
-			usart2: serial@fffb8000{
+			usart2: serial@fffb8000 {
 				compatible = "atmel,at91sam9260-usart";
 				reg = <0xfffb8000 0x200>;
 				atmel,usart-mode = <AT91_USART_MODE_SERIAL>;
diff --git a/arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts b/arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts
index 2db95e8ffc64..172af6ff4b18 100644
--- a/arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9g20ek_2mmc.dts
@@ -12,7 +12,7 @@ / {
 	compatible = "atmel,at91sam9g20ek_2mmc", "atmel,at91sam9g20", "atmel,at91sam9";
 
 	ahb {
-		apb{
+		apb {
 			mmc0: mmc@fffa8000 {
 				/* clk already mux wuth slot0 */
 				pinctrl-0 = <
diff --git a/arch/arm/boot/dts/microchip/at91sam9g45.dtsi b/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
index 7cccc606e36c..325c63a53118 100644
--- a/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9g45.dtsi
@@ -70,7 +70,7 @@ main_xtal: main_xtal {
 			clock-frequency = <0>;
 		};
 
-		adc_op_clk: adc_op_clk{
+		adc_op_clk: adc_op_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <300000>;
diff --git a/arch/arm/boot/dts/microchip/at91sam9m10g45ek.dts b/arch/arm/boot/dts/microchip/at91sam9m10g45ek.dts
index 7f45e81ca165..071db4f16313 100644
--- a/arch/arm/boot/dts/microchip/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/microchip/at91sam9m10g45ek.dts
@@ -164,7 +164,7 @@ pinctrl_pwm_leds: pwm-led {
 				};
 			};
 
-			spi0: spi@fffa4000{
+			spi0: spi@fffa4000 {
 				status = "okay";
 				cs-gpios = <&pioB 3 0>, <0>, <0>, <0>;
 				flash@0 {
diff --git a/arch/arm/boot/dts/microchip/at91sam9rl.dtsi b/arch/arm/boot/dts/microchip/at91sam9rl.dtsi
index 3d089ffbe162..7436b5c862b1 100644
--- a/arch/arm/boot/dts/microchip/at91sam9rl.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9rl.dtsi
@@ -67,7 +67,7 @@ main_xtal: main_xtal {
 			clock-frequency = <0>;
 		};
 
-		adc_op_clk: adc_op_clk{
+		adc_op_clk: adc_op_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <1000000>;
diff --git a/arch/arm/boot/dts/microchip/at91sam9x5.dtsi b/arch/arm/boot/dts/microchip/at91sam9x5.dtsi
index a1fed912f2ee..a7456c2191fa 100644
--- a/arch/arm/boot/dts/microchip/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/microchip/at91sam9x5.dtsi
@@ -68,7 +68,7 @@ main_xtal: main_xtal {
 			clock-frequency = <0>;
 		};
 
-		adc_op_clk: adc_op_clk{
+		adc_op_clk: adc_op_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <1000000>;
diff --git a/arch/arm/boot/dts/microchip/sama5d3.dtsi b/arch/arm/boot/dts/microchip/sama5d3.dtsi
index d9e66700d1c2..d4fc0c1dfc10 100644
--- a/arch/arm/boot/dts/microchip/sama5d3.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d3.dtsi
@@ -74,7 +74,7 @@ main_xtal: main_xtal {
 			clock-frequency = <0>;
 		};
 
-		adc_op_clk: adc_op_clk{
+		adc_op_clk: adc_op_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <1000000>;
diff --git a/arch/arm/boot/dts/microchip/sama5d4.dtsi b/arch/arm/boot/dts/microchip/sama5d4.dtsi
index 41284e013f53..50650e2f4267 100644
--- a/arch/arm/boot/dts/microchip/sama5d4.dtsi
+++ b/arch/arm/boot/dts/microchip/sama5d4.dtsi
@@ -72,7 +72,7 @@ main_xtal: main_xtal {
 			clock-frequency = <0>;
 		};
 
-		adc_op_clk: adc_op_clk{
+		adc_op_clk: adc_op_clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <1000000>;
-- 
2.34.1

