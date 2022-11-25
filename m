Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882ED638C83
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiKYOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbiKYOlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:41:45 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8448B3FBA5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:34 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so7223688lfv.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6GKokZfCi4W0a9HqqBgM4rU9D1bjHY8xKeZ9lwra/hg=;
        b=EDnd1UWEbxTkEDVY+efqSnEvE1BBHdI9gtg5eafvaUh8qOHwxCR+qFFjq8+d0PogRx
         XdBfhxyoRV7akUqocpumreSCxREt/eOjgYhMNLtZLXEvOzPI/3qKo9Ln1f91lRbg2D1D
         CYEwk7ljrLVhgTiOgdgjL93bXEtgwDQ9mNblSm5DRh98SZcFXb/mUaVPviBupff/1Hq0
         gM8O0LtZZGt3Kx9rW80X0xO+y78H57mVCVtSJ4i8pMQGjcVNXbc2vR2aeESIEh77alXg
         YZGI3UNMjAKqxFTyX7FWnlpuSsg6TqiDv+6gokn1vJkpkm53rSH0fx6HURQOkrseM8pF
         QBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GKokZfCi4W0a9HqqBgM4rU9D1bjHY8xKeZ9lwra/hg=;
        b=WX9nVVX+PlKg65ohJqtWqTYZFFVS6Lj52ShV41t6LN3K5Md125nTgWPHxn8TrNxdUF
         B/AKHADa5n/9DrWND1JLcnTrQsIHU1s4Dw2o0jGTOjJ76+B8EEpaYXilXcMMoe5+5Efn
         rhLHVV3ra6O8BkrEDDuJHGyByOQYKx0cUmHy5kZNUCQeHeTNr06UJEzU/oh+GnQneVMB
         zvvaVMsi/yzisvgNTWFcLQMCKZx6fE6j+FCl6WoZqdrUZnSER1Lo5dkbdug6LpwfpwCy
         TE/ByXrEUz0QaT6rMNi/QTkwovRD+/0QtoBbO/MtTVowwLK2c7JsWCS50rwS7L4iharh
         8NaA==
X-Gm-Message-State: ANoB5pm0taC5yMq+7K40XJhVj38khWNspb1qWQNSbM1eu9mKl0HU+01x
        e605eSLxgUKjjQFtGilpmX5OfQ==
X-Google-Smtp-Source: AA0mqf4PoaC+kopLNH7fDL5DDYii9w0TSNkeWYtvTidiKBk0KpjMyduNfKhP1o8uzIHlWX9Wj2AVYA==
X-Received: by 2002:a05:6512:2203:b0:4aa:83e6:53e8 with SMTP id h3-20020a056512220300b004aa83e653e8mr4130801lfu.606.1669387292691;
        Fri, 25 Nov 2022 06:41:32 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b20-20020a2eb914000000b00278e5d12be3sm386281ljb.127.2022.11.25.06.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:41:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Peter Rosin <peda@axentia.se>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: at91: align LED node names with dtschema
Date:   Fri, 25 Nov 2022 15:41:30 +0100
Message-Id: <20221125144131.477089-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and DT schema expects certain pattern:

  at91-sama5d2_ptc_ek.dtb: leds: 'blue', 'green', 'red' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/at91-gatwick.dts            | 12 ++++++------
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts   |  6 +++---
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts |  6 +++---
 arch/arm/boot/dts/at91-sama5d2_icp.dts        |  6 +++---
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts     |  6 +++---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts   |  6 +++---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts   |  4 ++--
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts   |  6 +++---
 arch/arm/boot/dts/at91-sama5d4_xplained.dts   |  4 ++--
 arch/arm/boot/dts/at91-sama5d4ek.dts          |  6 +++---
 arch/arm/boot/dts/at91-tse850-3.dts           | 16 ++++++++--------
 arch/arm/boot/dts/sama5d31ek.dts              |  2 +-
 arch/arm/boot/dts/sama5d34ek.dts              |  2 +-
 arch/arm/boot/dts/sama5d3xcm.dtsi             |  2 +-
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi         |  2 +-
 15 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/arm/boot/dts/at91-gatwick.dts b/arch/arm/boot/dts/at91-gatwick.dts
index 2c718cf84d7b..551300fd7746 100644
--- a/arch/arm/boot/dts/at91-gatwick.dts
+++ b/arch/arm/boot/dts/at91-gatwick.dts
@@ -31,37 +31,37 @@ reset-button {
 	leds {
 		compatible = "gpio-leds";
 
-		ethernet {
+		led-ethernet {
 			label = "gatwick:yellow:ethernet";
 			gpios = <&pioA 10 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		wifi {
+		led-wifi {
 			label = "gatwick:green:wifi";
 			gpios = <&pioA 28 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		ble {
+		led-ble {
 			label = "gatwick:blue:ble";
 			gpios = <&pioA 22 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		lora {
+		led-lora {
 			label = "gatwick:orange:lora";
 			gpios = <&pioA 26 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		blank {
+		led-blank {
 			label = "gatwick:green:blank";
 			gpios = <&pioA 24 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		user {
+		led-user {
 			label = "gatwick:yellow:user";
 			gpios = <&pioA 12 GPIO_ACTIVE_LOW>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index 0dc6ca377b0c..52ddd0571f1c 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -498,17 +498,17 @@ leds {
 		pinctrl-0 = <&pinctrl_led_gpio_default>;
 		status = "okay"; /* Conflict with pwm0. */
 
-		red {
+		led-red {
 			label = "red";
 			gpios = <&pioA PIN_PA10 GPIO_ACTIVE_HIGH>;
 		};
 
-		green {
+		led-green {
 			label = "green";
 			gpios = <&pioA PIN_PB1 GPIO_ACTIVE_HIGH>;
 		};
 
-		blue {
+		led-blue {
 			label = "blue";
 			gpios = <&pioA PIN_PA31 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
index b665ddc6b0de..e055b9e2fe34 100644
--- a/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts
@@ -46,17 +46,17 @@ leds {
 		pinctrl-0 = <&pinctrl_led_gpio_default>;
 		status = "okay";
 
-		red {
+		led-red {
 			label = "red";
 			gpios = <&pioA PIN_PA6 GPIO_ACTIVE_HIGH>;
 		};
 
-		green {
+		led-green {
 			label = "green";
 			gpios = <&pioA PIN_PA7 GPIO_ACTIVE_HIGH>;
 		};
 
-		blue {
+		led-blue {
 			label = "blue";
 			gpios = <&pioA PIN_PA8 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/at91-sama5d2_icp.dts b/arch/arm/boot/dts/at91-sama5d2_icp.dts
index dd1dec9d4e07..1346b8f2b259 100644
--- a/arch/arm/boot/dts/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_icp.dts
@@ -62,17 +62,17 @@ leds {
 		pinctrl-0 = <&pinctrl_led_gpio_default>;
 		status = "okay"; /* conflict with pwm0 */
 
-		red {
+		led-red {
 			label = "red";
 			gpios = <&pioA PIN_PB0 GPIO_ACTIVE_HIGH>;
 		};
 
-		green {
+		led-green {
 			label = "green";
 			gpios = <&pioA PIN_PB1 GPIO_ACTIVE_HIGH>;
 		};
 
-		blue {
+		led-blue {
 			label = "blue";
 			gpios = <&pioA PIN_PA31 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
index 76a711b167b0..bf1c9ca72a9f 100644
--- a/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts
@@ -416,17 +416,17 @@ leds {
 		pinctrl-0 = <&pinctrl_led_gpio_default>;
 		status = "okay";
 
-		red {
+		led-red {
 			label = "red";
 			gpios = <&pioA PIN_PB10 GPIO_ACTIVE_HIGH>;
 		};
 
-		green {
+		led-green {
 			label = "green";
 			gpios = <&pioA PIN_PB8 GPIO_ACTIVE_HIGH>;
 		};
 
-		blue {
+		led-blue {
 			label = "blue";
 			gpios = <&pioA PIN_PB6 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 85949c24b687..2d53c47d7cc8 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -725,18 +725,18 @@ leds {
 		pinctrl-0 = <&pinctrl_led_gpio_default>;
 		status = "okay"; /* conflict with pwm0 */
 
-		red {
+		led-red {
 			label = "red";
 			gpios = <&pioA PIN_PB6 GPIO_ACTIVE_LOW>;
 		};
 
 
-		green {
+		led-green {
 			label = "green";
 			gpios = <&pioA PIN_PB5 GPIO_ACTIVE_LOW>;
 		};
 
-		blue {
+		led-blue {
 			label = "blue";
 			gpios = <&pioA PIN_PB0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index 1f42a6a981bf..820033727088 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -392,13 +392,13 @@ leds {
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 		status = "okay";
 
-		d2 {
+		led-d2 {
 			label = "d2";
 			gpios = <&pioE 23 GPIO_ACTIVE_LOW>;	/* PE23, conflicts with A23, CTS2 */
 			linux,default-trigger = "heartbeat";
 		};
 
-		d3 {
+		led-d3 {
 			label = "d3"; /* Conflict with EBI CS0, USART2 CTS. */
 			gpios = <&pioE 24 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts b/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
index 4d7cee569ff2..8adf567f2f0f 100644
--- a/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
@@ -115,19 +115,19 @@ leds {
 		compatible = "gpio-leds";
 		status = "okay";
 
-		user1 {
+		led-user1 {
 			label = "user1";
 			gpios = <&pioD 28 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		user2 {
+		led-user2 {
 			label = "user2";
 			gpios = <&pioD 29 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		user3 {
+		led-user3 {
 			label = "user3";
 			gpios = <&pioD 30 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
index f122f302f8e0..95d701d13fef 100644
--- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
@@ -262,13 +262,13 @@ leds {
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 		status = "okay";
 
-		d8 {
+		led-d8 {
 			label = "d8";
 			gpios = <&pioD 30 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 
-		d10 {
+		led-d10 {
 			label = "d10";
 			gpios = <&pioE 15 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
index fce4e93c6bee..20ac775059ca 100644
--- a/arch/arm/boot/dts/at91-sama5d4ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
@@ -287,18 +287,18 @@ leds {
 		compatible = "gpio-leds";
 		status = "okay";
 
-		d8 {
+		led-d8 {
 			label = "d8";
 			/* PE28, conflicts with usart4 rts pin */
 			gpios = <&pioE 28 GPIO_ACTIVE_LOW>;
 		};
 
-		d9 {
+		led-d9 {
 			label = "d9";
 			gpios = <&pioE 9 GPIO_ACTIVE_HIGH>;
 		};
 
-		d10 {
+		led-d10 {
 			label = "d10";
 			gpios = <&pioE 8 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/at91-tse850-3.dts b/arch/arm/boot/dts/at91-tse850-3.dts
index 7e5c598e7e68..b99a4fb44a36 100644
--- a/arch/arm/boot/dts/at91-tse850-3.dts
+++ b/arch/arm/boot/dts/at91-tse850-3.dts
@@ -106,35 +106,35 @@ envelope-detector-mux {
 	leds {
 		compatible = "gpio-leds";
 
-		ch1-red {
+		led-ch1-red {
 			label = "ch-1:red";
 			gpios = <&pioA 23 GPIO_ACTIVE_LOW>;
 		};
-		ch1-green {
+		led-ch1-green {
 			label = "ch-1:green";
 			gpios = <&pioA 22 GPIO_ACTIVE_LOW>;
 		};
-		ch2-red {
+		led-ch2-red {
 			label = "ch-2:red";
 			gpios = <&pioA 21 GPIO_ACTIVE_LOW>;
 		};
-		ch2-green {
+		led-ch2-green {
 			label = "ch-2:green";
 			gpios = <&pioA 20 GPIO_ACTIVE_LOW>;
 		};
-		data-red {
+		led-data-red {
 			label = "data:red";
 			gpios = <&pioA 19 GPIO_ACTIVE_LOW>;
 		};
-		data-green {
+		led-data-green {
 			label = "data:green";
 			gpios = <&pioA 18 GPIO_ACTIVE_LOW>;
 		};
-		alarm-red {
+		led-alarm-red {
 			label = "alarm:red";
 			gpios = <&pioA 17 GPIO_ACTIVE_LOW>;
 		};
-		alarm-green {
+		led-alarm-green {
 			label = "alarm:green";
 			gpios = <&pioA 16 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/sama5d31ek.dts b/arch/arm/boot/dts/sama5d31ek.dts
index 10fc80d6d30d..1f2dfb3127ab 100644
--- a/arch/arm/boot/dts/sama5d31ek.dts
+++ b/arch/arm/boot/dts/sama5d31ek.dts
@@ -40,7 +40,7 @@ macb1: ethernet@f802c000 {
 	};
 
 	leds {
-		d3 {
+		led-d3 {
 			label = "d3";
 			gpios = <&pioE 24 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/sama5d34ek.dts b/arch/arm/boot/dts/sama5d34ek.dts
index 2335bf906f69..bffd61397cb5 100644
--- a/arch/arm/boot/dts/sama5d34ek.dts
+++ b/arch/arm/boot/dts/sama5d34ek.dts
@@ -50,7 +50,7 @@ macb0: ethernet@f0028000 {
 	};
 
 	leds {
-		d3 {
+		led-d3 {
 			label = "d3";
 			gpios = <&pioE 24 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index 384335635792..7d1d7859edb4 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -130,7 +130,7 @@ rootfs@800000 {
 	leds {
 		compatible = "gpio-leds";
 
-		d2 {
+		led-d2 {
 			label = "d2";
 			gpios = <&pioE 25 GPIO_ACTIVE_LOW>;	/* PE25, conflicts with A25, RXD2 */
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi b/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
index 5579c955f141..830a0954ba1b 100644
--- a/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
@@ -184,7 +184,7 @@ rootfs@800000 {
 	leds {
 		compatible = "gpio-leds";
 
-		d2 {
+		led-d2 {
 			label = "d2";
 			gpios = <&pioE 25 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
-- 
2.34.1

