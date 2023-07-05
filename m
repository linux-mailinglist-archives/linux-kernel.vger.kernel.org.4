Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0942F748736
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjGEPBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 11:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjGEPAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 11:00:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F8E1719
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 08:00:27 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992ca792065so730228566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688569222; x=1691161222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qLtfucv22uqltjIPvG7Jab1xSofKooGcMmzDiHdmMX4=;
        b=AtrZLHsK8Ww5rAhH0mjJBLeZgjUrCEq0Lw9gG2K5yF11KIXK1tvUog+Ou0vSZ5oWF5
         zDEL9OfxN92tzzUi5clL98+M/i2O2D/LzfW/qjkW+hXOw7mBTtCQSgVc/o8V4khyaEnv
         VyK10otyqR4fs24Xb4Q4qGLsDGFkhksOp2/ivz+n8dGs4gp9IQ3wEVPyBgU3JJue7Q2r
         OpVDZRL6l5u2Nzc3InyLqPBy00hRpza4GBgTWbdrMFO5ZuKWIHo9w1pbtE8zD0bUK0FH
         acr3wMZYbAPTVRxYc+7VUsLMzI53zRAz41HjIfGeluzIsUnGP7+SWI4zgWkq+oTs9ogY
         g+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688569222; x=1691161222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLtfucv22uqltjIPvG7Jab1xSofKooGcMmzDiHdmMX4=;
        b=MgsJ35gE5OkIvZZgGumsWK4Jho0lJIQnNqORAkGprwlfkdDtZRfKFDDOtMAcDLYiYs
         i4ziWeQ0G6JgmD65imcvB/uguvZNVj7dXYobQJykZN5apr2LCYLxxwDoxQUN2kfvXQ5s
         ARHn3Pl4+oarGz5ThxRcmIpCojb7awjjsHT7C2BGSQbVFxg927EGJnIuMJB6BTY5t3xx
         9zPG2hIPRhiItm1NO2t5Yg4LlXd8qhG4uCg93m18gF+FZ0mCGxkFPLJV0xyVeBrgJBRd
         p7pPDk8mJY5GaLqGOYnGxf//okPml43E2RGem7QnFT92ij3lyltw04reZc/hD30rSqgi
         FlzQ==
X-Gm-Message-State: ABy/qLYS5Xe3CJtyrkdIEvuMHZCZ7ek2VFL23hy+ucM7FicttIyvqXB5
        BndETvZyppZ8jHslxbWOUEwURg==
X-Google-Smtp-Source: APBJJlEtcnCQq0TcO5XRCKUV7/WDTeEyhBvf0Vh+YegxS+J/0d7lvzuQW90iYbcx5Tvl+YlISnlQ4Q==
X-Received: by 2002:a17:906:cd14:b0:97d:ee91:df83 with SMTP id oz20-20020a170906cd1400b0097dee91df83mr12919836ejb.61.1688569222644;
        Wed, 05 Jul 2023 08:00:22 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906528f00b00982a352f078sm14515897ejm.124.2023.07.05.08.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 08:00:22 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: marvell: add missing space before {
Date:   Wed,  5 Jul 2023 17:00:17 +0200
Message-Id: <20230705150018.293752-1-krzysztof.kozlowski@linaro.org>
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
 arch/arm/boot/dts/marvell/armada-382-rd-ac3x-48g4x2xl.dts | 6 +++---
 arch/arm/boot/dts/marvell/kirkwood-l-50.dts               | 4 ++--
 arch/arm/boot/dts/marvell/pxa168.dtsi                     | 2 +-
 arch/arm/boot/dts/marvell/pxa910.dtsi                     | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/marvell/armada-382-rd-ac3x-48g4x2xl.dts b/arch/arm/boot/dts/marvell/armada-382-rd-ac3x-48g4x2xl.dts
index 584f0d0398a5..6ab65d21861a 100644
--- a/arch/arm/boot/dts/marvell/armada-382-rd-ac3x-48g4x2xl.dts
+++ b/arch/arm/boot/dts/marvell/armada-382-rd-ac3x-48g4x2xl.dts
@@ -40,7 +40,7 @@ &i2c0 {
 	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
 
-	eeprom@53{
+	eeprom@53 {
 		compatible = "atmel,24c64";
 		reg = <0x53>;
 	};
@@ -95,11 +95,11 @@ partition@0 {
 				reg = <0x00000000 0x00500000>;
 				label = "u-boot";
 			};
-			partition@500000{
+			partition@500000 {
 				reg = <0x00500000 0x00400000>;
 				label = "u-boot env";
 			};
-			partition@900000{
+			partition@900000 {
 				reg = <0x00900000 0x3F700000>;
 				label = "user";
 			};
diff --git a/arch/arm/boot/dts/marvell/kirkwood-l-50.dts b/arch/arm/boot/dts/marvell/kirkwood-l-50.dts
index 9fd3581bb24b..dffb9f84e67c 100644
--- a/arch/arm/boot/dts/marvell/kirkwood-l-50.dts
+++ b/arch/arm/boot/dts/marvell/kirkwood-l-50.dts
@@ -62,7 +62,7 @@ i2c@11000 {
 			status = "okay";
 			clock-frequency = <400000>;
 
-			gpio2: gpio-expander@20{
+			gpio2: gpio-expander@20 {
 				#gpio-cells = <2>;
 				#interrupt-cells = <2>;
 				compatible = "semtech,sx1505q";
@@ -76,7 +76,7 @@ gpio2: gpio-expander@20{
 			 * 5: mPCIE reset (active low)
 			 * 6: Express card reset (active low)
 			 */
-			gpio3: gpio-expander@21{
+			gpio3: gpio-expander@21 {
 				#gpio-cells = <2>;
 				#interrupt-cells = <2>;
 				compatible = "semtech,sx1505q";
diff --git a/arch/arm/boot/dts/marvell/pxa168.dtsi b/arch/arm/boot/dts/marvell/pxa168.dtsi
index 16212b912b94..22ed10cb5619 100644
--- a/arch/arm/boot/dts/marvell/pxa168.dtsi
+++ b/arch/arm/boot/dts/marvell/pxa168.dtsi
@@ -153,7 +153,7 @@ rtc: rtc@d4010000 {
 			};
 		};
 
-		soc_clocks: clocks{
+		soc_clocks: clocks {
 			compatible = "marvell,pxa168-clock";
 			reg = <0xd4050000 0x1000>,
 			      <0xd4282800 0x400>,
diff --git a/arch/arm/boot/dts/marvell/pxa910.dtsi b/arch/arm/boot/dts/marvell/pxa910.dtsi
index 352a39357810..bd64ac1ec66f 100644
--- a/arch/arm/boot/dts/marvell/pxa910.dtsi
+++ b/arch/arm/boot/dts/marvell/pxa910.dtsi
@@ -163,7 +163,7 @@ rtc: rtc@d4010000 {
 			};
 		};
 
-		soc_clocks: clocks{
+		soc_clocks: clocks {
 			compatible = "marvell,pxa910-clock";
 			reg = <0xd4050000 0x1000>,
 			      <0xd4282800 0x400>,
-- 
2.34.1

