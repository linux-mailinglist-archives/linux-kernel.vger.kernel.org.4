Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1F2638C9F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKYOnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiKYOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:43:18 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3764710E2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:42:29 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id j16so7176299lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JH+yS3MuLAHTcnMH2dzaXK+3d4KBaTzPNvaLTtajm/0=;
        b=JWbgVnfO7perPjDgtKl/pGceeoSTR0HSxlcjtUWAyX0BAOYJdSla/UyxgsDWgXtL8t
         8rCnqsJxwgknpsnsJpCizo1d465Pogmiq/xMS8ce7lOMrDeeMi9x7lYP3G4oBEFGhOa4
         DqmVvcLuR6vSiO63aaf3vIcwHNnF74X43GVhskNQWZqiCLhH+QKrQCZ1zXUMxLe2LuAS
         8vPg7zsXnAe3QOQPZXmCrvx0QZEk7OkJFVG1TWuT97us5QFqy75u/5znOCfOO1i7c58S
         27b8WaZ4T4YqKGpX7bjGVAKlCSsDjb2EMXeFVQieIT1an2h4w7yyl8KxQPQybYWlzfU5
         vGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JH+yS3MuLAHTcnMH2dzaXK+3d4KBaTzPNvaLTtajm/0=;
        b=o/v21+8PILjpfC7n4baldIkkqiVNIFsWBMoR/BL85eJhTXLzDDYZwsJphPNGMbSelT
         N1/9ySeDwM0lgo3ttdu7CnZWt2llyEf7iPj3U+rcAjBWupI/uaWAOFDoBmFpvPOK1ngh
         vdtt1EhhhCLv1Ixy1TRYH+qyfVADwS54ine1v1u+FLNp41zIw5fcGQVagicNadFlpKwt
         Sj1laFtY43ZJ4D+VEoyDnDvh9aSq0mYgWf4GoWC9ClmDapVDaEdS+57egRdUYWYMKaoT
         pZ+xaVUHQCgOnrZlKPgaU6xXg6NG939Yl8107Yf75DVCII5PgTgjsN7V8p0CQ1to2A0c
         S5Yw==
X-Gm-Message-State: ANoB5pm88+agHS8y4H2WfuCzZ4v+GEg/AtnrgnIqC7XFhOJRG1S4V2PT
        7brj0VdWphShxpWtfx4omJ0pXg==
X-Google-Smtp-Source: AA0mqf7MLKTQuCIxLlMLuNAaY/J1mGwxWXHCU2U/VVp0EgWhkMavbhPB2e0o6ee+uE9bW3jHks5rtw==
X-Received: by 2002:ac2:5a09:0:b0:4ab:b2c:75ae with SMTP id q9-20020ac25a09000000b004ab0b2c75aemr7993526lfn.40.1669387347017;
        Fri, 25 Nov 2022 06:42:27 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c3-20020a056512074300b004aa0870b5e5sm548322lfs.147.2022.11.25.06.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:42:26 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] ARM: dts: imx: align LED node names with dtschema
Date:   Fri, 25 Nov 2022 15:42:22 +0100
Message-Id: <20221125144223.477376-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125144223.477376-1-krzysztof.kozlowski@linaro.org>
References: <20221125144223.477376-1-krzysztof.kozlowski@linaro.org>
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

  imx50-kobo-aura.dtb: gpio-leds: 'on' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
  imx6dl-yapp4-draco.dtb: led-controller@30: 'chan@0', 'chan@1', 'chan@2' do not match any of the regexes: '^led@[0-8]$', '^multi-led@[0-8]$', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/imx50-kobo-aura.dts            |  2 +-
 arch/arm/boot/dts/imx53-cx9020.dts               | 10 +++++-----
 arch/arm/boot/dts/imx53-m53evk.dts               |  4 ++--
 arch/arm/boot/dts/imx53-m53menlo.dts             |  6 +++---
 arch/arm/boot/dts/imx53-tx53.dtsi                |  2 +-
 arch/arm/boot/dts/imx53-usbarmory.dts            |  2 +-
 arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6dl-riotboard.dts           |  4 ++--
 arch/arm/boot/dts/imx6dl-yapp4-common.dtsi       |  6 +++---
 arch/arm/boot/dts/imx6q-gw5400-a.dts             |  6 +++---
 arch/arm/boot/dts/imx6q-h100.dts                 |  6 +++---
 arch/arm/boot/dts/imx6q-kp.dtsi                  |  4 ++--
 arch/arm/boot/dts/imx6q-marsboard.dts            |  4 ++--
 arch/arm/boot/dts/imx6q-tbs2910.dts              |  2 +-
 arch/arm/boot/dts/imx6qdl-emcon.dtsi             |  4 ++--
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi            |  4 ++--
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi            |  2 +-
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi            |  4 ++--
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi            |  2 +-
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw5907.dtsi            |  4 ++--
 arch/arm/boot/dts/imx6qdl-gw5910.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw5912.dtsi            |  6 +++---
 arch/arm/boot/dts/imx6qdl-gw5913.dtsi            |  4 ++--
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi         | 10 +++++-----
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi     |  4 ++--
 arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi       |  6 +++---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi     |  4 ++--
 arch/arm/boot/dts/imx6qdl-rex.dtsi               |  2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi         |  2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi           |  2 +-
 arch/arm/boot/dts/imx6qdl-ts7970.dtsi            |  4 ++--
 arch/arm/boot/dts/imx6qdl-tx6.dtsi               |  2 +-
 arch/arm/boot/dts/imx6sl-evk.dts                 |  2 +-
 arch/arm/boot/dts/imx6sll-evk.dts                |  2 +-
 arch/arm/boot/dts/imx6sx-sabreauto.dts           |  2 +-
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi           |  4 ++--
 arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi |  2 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi              |  2 +-
 44 files changed, 93 insertions(+), 93 deletions(-)

diff --git a/arch/arm/boot/dts/imx50-kobo-aura.dts b/arch/arm/boot/dts/imx50-kobo-aura.dts
index 51bf6117fb12..467db6b4ed7f 100644
--- a/arch/arm/boot/dts/imx50-kobo-aura.dts
+++ b/arch/arm/boot/dts/imx50-kobo-aura.dts
@@ -26,7 +26,7 @@ gpio-leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_leds>;
 
-		on {
+		led-on {
 			label = "kobo_aura:orange:on";
 			gpios = <&gpio6 24 GPIO_ACTIVE_LOW>;
 			panic-indicator;
diff --git a/arch/arm/boot/dts/imx53-cx9020.dts b/arch/arm/boot/dts/imx53-cx9020.dts
index cfb18849a92b..055d23a9aee7 100644
--- a/arch/arm/boot/dts/imx53-cx9020.dts
+++ b/arch/arm/boot/dts/imx53-cx9020.dts
@@ -86,27 +86,27 @@ tfp410_out: endpoint {
 	leds {
 		compatible = "gpio-leds";
 
-		pwr-r {
+		led-pwr-r {
 			gpios = <&gpio3 22 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		pwr-g {
+		led-pwr-g {
 			gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 
-		pwr-b {
+		led-pwr-b {
 			gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		sd1-b {
+		led-sd1-b {
 			linux,default-trigger = "mmc0";
 			gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
 		};
 
-		sd2-b {
+		led-sd2-b {
 			linux,default-trigger = "mmc1";
 			gpios = <&gpio3 17 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/imx53-m53evk.dts b/arch/arm/boot/dts/imx53-m53evk.dts
index a1a6228d1aa6..2bd2432d317f 100644
--- a/arch/arm/boot/dts/imx53-m53evk.dts
+++ b/arch/arm/boot/dts/imx53-m53evk.dts
@@ -52,13 +52,13 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&led_pin_gpio>;
 
-		user1 {
+		led-user1 {
 			label = "user1";
 			gpios = <&gpio2 8 0>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		user2 {
+		led-user2 {
 			label = "user2";
 			gpios = <&gpio2 9 0>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx53-m53menlo.dts b/arch/arm/boot/dts/imx53-m53menlo.dts
index d5c68d1ea707..4d77b6077fc1 100644
--- a/arch/arm/boot/dts/imx53-m53menlo.dts
+++ b/arch/arm/boot/dts/imx53-m53menlo.dts
@@ -34,19 +34,19 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		user1 {
+		led-user1 {
 			label = "TestLed601";
 			gpios = <&gpio6 1 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
 		};
 
-		user2 {
+		led-user2 {
 			label = "TestLed602";
 			gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		eth {
+		led-eth {
 			label = "EthLedYe";
 			gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "netdev";
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index 892dd1a4bac3..a439a47fb65a 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -94,7 +94,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_stk5led>;
 
-		user {
+		led-user {
 			label = "Heartbeat";
 			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx53-usbarmory.dts b/arch/arm/boot/dts/imx53-usbarmory.dts
index f34993a490ee..acc44010d510 100644
--- a/arch/arm/boot/dts/imx53-usbarmory.dts
+++ b/arch/arm/boot/dts/imx53-usbarmory.dts
@@ -67,7 +67,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		user {
+		led-user {
 			label = "LED";
 			gpios = <&gpio4 27 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi b/arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi
index 337db29b0010..37697fac9dea 100644
--- a/arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi
+++ b/arch/arm/boot/dts/imx6dl-b1x5pv2.dtsi
@@ -211,17 +211,17 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_q7_gpio1 &pinctrl_q7_gpio3 &pinctrl_q7_gpio5>;
 
-		alarm1 {
+		led-alarm1 {
 			label = "alarm:red";
 			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 		};
 
-		alarm2 {
+		led-alarm2 {
 			label = "alarm:yellow";
 			gpios = <&gpio4 27 GPIO_ACTIVE_HIGH>;
 		};
 
-		alarm3 {
+		led-alarm3 {
 			label = "alarm:blue";
 			gpios = <&gpio4 15 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index e7be05f205d3..24c7f535f63b 100644
--- a/arch/arm/boot/dts/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
@@ -25,14 +25,14 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio3 28 GPIO_ACTIVE_LOW>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
index 52162e8c7274..aacbf317feea 100644
--- a/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
+++ b/arch/arm/boot/dts/imx6dl-yapp4-common.dtsi
@@ -274,7 +274,7 @@ leds: led-controller@30 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		chan@0 {
+		led@0 {
 			chan-name = "R";
 			led-cur = /bits/ 8 <0x20>;
 			max-cur = /bits/ 8 <0x60>;
@@ -282,7 +282,7 @@ chan@0 {
 			color = <LED_COLOR_ID_RED>;
 		};
 
-		chan@1 {
+		led@1 {
 			chan-name = "G";
 			led-cur = /bits/ 8 <0x20>;
 			max-cur = /bits/ 8 <0x60>;
@@ -290,7 +290,7 @@ chan@1 {
 			color = <LED_COLOR_ID_GREEN>;
 		};
 
-		chan@2 {
+		led@2 {
 			chan-name = "B";
 			led-cur = /bits/ 8 <0x20>;
 			max-cur = /bits/ 8 <0x60>;
diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
index e894faba571f..522a51042965 100644
--- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
+++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
@@ -34,20 +34,20 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* 102 -> MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>; /* 106 -> MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* 111 -> MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6q-h100.dts b/arch/arm/boot/dts/imx6q-h100.dts
index b8feadbff967..6406ade14f57 100644
--- a/arch/arm/boot/dts/imx6q-h100.dts
+++ b/arch/arm/boot/dts/imx6q-h100.dts
@@ -76,19 +76,19 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_h100_leds>;
 
-		led0: power {
+		led0: led-power {
 			label = "power";
 			gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 
-		led1: stream {
+		led1: led-stream {
 			label = "stream";
 			gpios = <&gpio2 29 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		led2: rec {
+		led2: led-rec {
 			label = "rec";
 			gpios = <&gpio2 28 GPIO_ACTIVE_LOW>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6q-kp.dtsi b/arch/arm/boot/dts/imx6q-kp.dtsi
index 1ade0bff681d..5e0ed5560040 100644
--- a/arch/arm/boot/dts/imx6q-kp.dtsi
+++ b/arch/arm/boot/dts/imx6q-kp.dtsi
@@ -66,14 +66,14 @@ lcd_panel_in: endpoint {
 	leds {
 		compatible = "gpio-leds";
 
-		green {
+		led-green {
 			label = "led1";
 			gpios = <&gpio3 16 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "gpio";
 			default-state = "off";
 		};
 
-		red {
+		led-red {
 			label = "led0";
 			gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "gpio";
diff --git a/arch/arm/boot/dts/imx6q-marsboard.dts b/arch/arm/boot/dts/imx6q-marsboard.dts
index cc1801002394..2c9961333b0a 100644
--- a/arch/arm/boot/dts/imx6q-marsboard.dts
+++ b/arch/arm/boot/dts/imx6q-marsboard.dts
@@ -73,14 +73,14 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		user1 {
+		led-user1 {
 			label = "imx6:green:user1";
 			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 			linux,default-trigger = "heartbeat";
 		};
 
-		user2 {
+		led-user2 {
 			label = "imx6:green:user2";
 			gpios = <&gpio3 28 GPIO_ACTIVE_LOW>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index 8daef65d5bb3..2f576e2ce73f 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -49,7 +49,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		blue {
+		led-blue {
 			label = "blue_status_led";
 			gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
 			default-state = "keep";
diff --git a/arch/arm/boot/dts/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
index 7228b894a763..ee2dd75cead6 100644
--- a/arch/arm/boot/dts/imx6qdl-emcon.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
@@ -46,14 +46,14 @@ som_leds: leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_som_leds>;
 
-		green {
+		led-green {
 			label = "som:green";
 			gpios = <&gpio3 0 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			default-state = "on";
 		};
 
-		red {
+		led-red {
 			label = "som:red";
 			gpios = <&gpio3 1 GPIO_ACTIVE_LOW>;
 			default-state = "keep";
diff --git a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
index 069c27fab432..e75e1a5364b8 100644
--- a/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw51xx.dtsi
@@ -71,14 +71,14 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index 728810b9d677..47d9a8d08197 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -80,20 +80,20 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 6c0c109046d8..fb1d29abe099 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -80,20 +80,20 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index a9b04f9f1c2b..4e20cb97058e 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -81,20 +81,20 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
index 435dec6338fe..0fa4b8eeddee 100644
--- a/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw551x.dtsi
@@ -115,7 +115,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 7 GPIO_ACTIVE_LOW>;
 			default-state = "on";
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index 2e61102ae694..77ae611b817a 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -72,20 +72,20 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
index 4662408b225a..7f16c602cc07 100644
--- a/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw553x.dtsi
@@ -113,14 +113,14 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 10 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 11 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
index 4bc4371e6bae..0c31a39d60be 100644
--- a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
@@ -139,20 +139,20 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
index 1fdb7ba630f1..a74cde050158 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5903.dtsi
@@ -123,7 +123,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio6 14 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
index 612b6e068e28..9fc79af2bc9a 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5904.dtsi
@@ -120,20 +120,20 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw5907.dtsi b/arch/arm/boot/dts/imx6qdl-gw5907.dtsi
index fcd3bdfd6182..955a51226eda 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5907.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5907.dtsi
@@ -71,14 +71,14 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
index 6bb4855d13ce..218d6e667ed2 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5910.dtsi
@@ -74,20 +74,20 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw5912.dtsi b/arch/arm/boot/dts/imx6qdl-gw5912.dtsi
index 0415bcb41640..40e235e315cc 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5912.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5912.dtsi
@@ -72,20 +72,20 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
 		};
 
-		led2: user3 {
+		led2: led-user3 {
 			label = "user3";
 			gpios = <&gpio4 15 GPIO_ACTIVE_LOW>; /* MX6_LOCLED# */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-gw5913.dtsi b/arch/arm/boot/dts/imx6qdl-gw5913.dtsi
index 696427b487f0..82f47c295b08 100644
--- a/arch/arm/boot/dts/imx6qdl-gw5913.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw5913.dtsi
@@ -71,14 +71,14 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		led0: user1 {
+		led0: led-user1 {
 			label = "user1";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDG */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		led1: user2 {
+		led1: led-user2 {
 			label = "user2";
 			gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>; /* MX6_PANLEDR */
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
index a53a5d0766a5..6d4eab1942b9 100644
--- a/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi
@@ -85,31 +85,31 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_leds>;
 
-		j14-pin1 {
+		led-j14-pin1 {
 			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
 			retain-state-suspended;
 			default-state = "off";
 		};
 
-		j14-pin3 {
+		led-j14-pin3 {
 			gpios = <&gpio1 3 GPIO_ACTIVE_LOW>;
 			retain-state-suspended;
 			default-state = "off";
 		};
 
-		j14-pins8-9 {
+		led-j14-pins8-9 {
 			gpios = <&gpio3 29 GPIO_ACTIVE_LOW>;
 			retain-state-suspended;
 			default-state = "off";
 		};
 
-		j46-pin2 {
+		led-j46-pin2 {
 			gpios = <&gpio1 7 GPIO_ACTIVE_LOW>;
 			retain-state-suspended;
 			default-state = "off";
 		};
 
-		j46-pin3 {
+		led-j46-pin3 {
 			gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 			retain-state-suspended;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index 57c21a01f126..81a9a302aec1 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -181,13 +181,13 @@ i2c3mux@1 {
 	leds {
 		compatible = "gpio-leds";
 
-		speaker-enable {
+		led-speaker-enable {
 			gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
 			retain-state-suspended;
 			default-state = "off";
 		};
 
-		ttymxc4-rs232 {
+		led-ttymxc4-rs232 {
 			gpios = <&gpio6 10 GPIO_ACTIVE_HIGH>;
 			retain-state-suspended;
 			default-state = "on";
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
index 120d6e997a4c..1a599c294ab8 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-mira.dtsi
@@ -25,17 +25,17 @@ gpio_leds: leds {
 		pinctrl-0 = <&pinctrl_gpioleds>;
 		status = "disabled";
 
-		red {
+		led-red {
 			label = "phyboard-mira:red";
 			gpios = <&gpio5 22 GPIO_ACTIVE_HIGH>;
 		};
 
-		green {
+		led-green {
 			label = "phyboard-mira:green";
 			gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>;
 		};
 
-		blue {
+		led-blue {
 			label = "phyboard-mira:blue";
 			gpios = <&gpio5 24 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 768bc0e3a2b3..80adb2a02cc9 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -47,12 +47,12 @@ gpio_leds: leds {
 		pinctrl-0 = <&pinctrl_leds>;
 		compatible = "gpio-leds";
 
-		led_green: green {
+		led_green: led-green {
 			label = "phyflex:green";
 			gpios = <&gpio1 30 0>;
 		};
 
-		led_red: red {
+		led_red: led-red {
 			label = "phyflex:red";
 			gpios = <&gpio2 31 0>;
 		};
diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi b/arch/arm/boot/dts/imx6qdl-rex.dtsi
index de514eb5aa99..f804ff95a6ad 100644
--- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
@@ -55,7 +55,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		led0: usr {
+		led0: led-usr {
 			label = "usr";
 			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index eebcfe12142e..f79caa36f3d2 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -21,7 +21,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		user {
+		led-user {
 			label = "debug";
 			gpios = <&gpio5 15 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 09f4c2fa3ad6..53b080c97f2d 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -130,7 +130,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
-		red {
+		led-red {
 			gpios = <&gpio1 2 0>;
 			default-state = "on";
 		};
diff --git a/arch/arm/boot/dts/imx6qdl-ts7970.dtsi b/arch/arm/boot/dts/imx6qdl-ts7970.dtsi
index c096d25a6f5b..1e0a041e9f60 100644
--- a/arch/arm/boot/dts/imx6qdl-ts7970.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-ts7970.dtsi
@@ -73,13 +73,13 @@ blue-led {
 			default-state = "off";
 		};
 
-		en-usb-5v {
+		en-usb-5v-led {
 			label = "en-usb-5v";
 			gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 
-		sel_dc_usb {
+		sel-dc-usb-led {
 			label = "sel_dc_usb";
 			gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index f41f86a76ea9..a197bac95cba 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -92,7 +92,7 @@ power {
 	leds {
 		compatible = "gpio-leds";
 
-		user_led: user {
+		user_led: led-user {
 			label = "Heartbeat";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_user_led>;
diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index f16c830f1e91..dc5d596c18db 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -33,7 +33,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		user {
+		led-user {
 			label = "debug";
 			gpios = <&gpio3 20 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 32b3d82fec53..269092ac881c 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -37,7 +37,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		user {
+		led-user {
 			label = "debug";
 			gpios = <&gpio2 4 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 83ee97252ff1..b0c27b9b0244 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -20,7 +20,7 @@ leds {
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_led>;
 
-		user {
+		led-user {
 			label = "debug";
 			gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
index c84ea1fac5e9..725d0b5cb55f 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
@@ -15,14 +15,14 @@ chosen {
 	leds {
 		compatible = "gpio-leds";
 
-		red {
+		led-red {
 			label = "udoo-neo:red:mmc";
 			gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 			linux,default-trigger = "mmc0";
 		};
 
-		orange {
+		led-orange {
 			label = "udoo-neo:orange:user";
 			gpios = <&gpio4 6 GPIO_ACTIVE_HIGH>;
 			default-state = "keep";
diff --git a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
index 5168ed0ffec3..a3ea1b208462 100644
--- a/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
+++ b/arch/arm/boot/dts/imx6ul-phytec-phycore-som.dtsi
@@ -30,7 +30,7 @@ gpio_leds_som: leds {
 		pinctrl-0 = <&pinctrl_gpioleds_som>;
 		compatible = "gpio-leds";
 
-		phycore-green {
+		led-phycore-green {
 			gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
diff --git a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
index 15ee0275feaf..70cef5e817bd 100644
--- a/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul-tx6ul.dtsi
@@ -131,7 +131,7 @@ ds1339: rtc@68 {
 	leds {
 		compatible = "gpio-leds";
 
-		user_led: user {
+		user_led: led-user {
 			label = "Heartbeat";
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_led>;
-- 
2.34.1

