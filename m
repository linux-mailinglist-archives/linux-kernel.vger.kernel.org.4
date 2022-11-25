Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3FF638C93
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiKYOnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiKYOmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:42:36 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9CF3D927
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:42:00 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id a29so7206274lfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zabSr0/YmLiKSdF4euJUohtXVYwZ0//v0a+GYil+G4c=;
        b=JjRQvWqc8I3wKkuCWgvuU5VtG5nZOKyN4IWZ2BimA2L6Pv50YYGA3i1lumJ181ukuA
         /QzL7C7pV+N1y8vYFqMp6zDl+V5twMAdHXZ76FdChkM7ddipBEvFtJA8TTze/I3QeA8H
         ZmUN9xIhfZDytuuhnWNE4LSME01LdoM0mLBihHiGdLDJEQ0i8lzV7r+9werHxlrdsWOG
         FY93pBA6mHFh2/cDjugYQizmZQUjScNFUCkFfmoGk5wo/CEHkhHQwOj3auIhAG0O6XCp
         c8wo/7FvHCcv7DPuMViyb0ndC8ku8UDs7eeJzRvyOQkwM+imcKPhUXdrDoIcmanBFm4n
         60Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zabSr0/YmLiKSdF4euJUohtXVYwZ0//v0a+GYil+G4c=;
        b=mRU/gsdEfa6HusK2/ccC6Hk8G1jCDO4FrIGc/YOFgrKmTLcPldefRAsCHZBMT2llKC
         56LUnzGCeW9HChQ0MkSbmLCmTGG2TWH/hzHJT5Q3aUQTQh3DTSBTvQAIDG60fu/ZGWwz
         +L7Npl5cSDYSIivLZeRbMG/Nd2mPzNhDSLT0SAwk1r1GrRw8vg0mKc80/DDROZEd8yPn
         zXQJBc8di0HnNUZEpqcqew31s8BIJODTXeb5gtxvX53gyEmyA5KPiv1HNDTEM0Hlg6jT
         h2/Gfpled5ihhV1WotvxXRlbgcJOQWgwDD2xbxBHsWWqN6Nv1mbwzXMay93dYA6OiIhW
         ei1g==
X-Gm-Message-State: ANoB5pkfQFaJ6bcIhZqKcqnsNX+0g1J9DGsFs/+J3yOOmKeOmk/8SOQh
        AckxUg9lExz9agK6n6wEAzNlHA==
X-Google-Smtp-Source: AA0mqf6Yb3bp3raVz179va7MHZmmX8h/qpWc8lhoCdT1b+fxWevZf9lEBzWPZi+6fwRIJLCMwUpQeA==
X-Received: by 2002:a19:384c:0:b0:494:7055:b085 with SMTP id d12-20020a19384c000000b004947055b085mr9217329lfj.109.1669387317115;
        Fri, 25 Nov 2022 06:41:57 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s10-20020a056512214a00b00492f1b2ac0bsm550368lfr.101.2022.11.25.06.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:41:56 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: omap: align LED node names with dtschema
Date:   Fri, 25 Nov 2022 15:41:49 +0100
Message-Id: <20221125144150.477290-1-krzysztof.kozlowski@linaro.org>
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

  omap3-beagle-ab4.dtb: leds: 'heartbeat', 'mmc', 'pmu_stat' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/omap3-beagle.dts                   | 6 +++---
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi       | 8 ++++----
 arch/arm/boot/dts/omap3-n900.dts                     | 2 +-
 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi     | 8 ++++----
 arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi | 4 ++--
 arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi   | 4 ++--
 arch/arm/boot/dts/omap3-overo-palo35-common.dtsi     | 4 ++--
 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi     | 4 ++--
 arch/arm/boot/dts/omap3-overo-summit-common.dtsi     | 2 +-
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi       | 2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi            | 4 ++--
 arch/arm/boot/dts/omap4-panda-es.dts                 | 4 ++--
 12 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 0548b391334f..47ff1ffddfc5 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -28,18 +28,18 @@ aliases {
 
 	leds {
 		compatible = "gpio-leds";
-		pmu_stat {
+		led-pmu-stat {
 			label = "beagleboard::pmu_stat";
 			gpios = <&twl_gpio 19 GPIO_ACTIVE_HIGH>; /* LEDB */
 		};
 
-		heartbeat {
+		led-heartbeat {
 			label = "beagleboard::usr0";
 			gpios = <&gpio5 22 GPIO_ACTIVE_HIGH>; /* 150 -> D6 LED */
 			linux,default-trigger = "heartbeat";
 		};
 
-		mmc {
+		led-mmc {
 			label = "beagleboard::usr1";
 			gpios = <&gpio5 21 GPIO_ACTIVE_HIGH>; /* 149 -> D7 LED */
 			linux,default-trigger = "mmc0";
diff --git a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
index 54cd37336be7..38aa1febc33f 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
@@ -15,28 +15,28 @@ memory@80000000 {
 	leds {
 		compatible = "gpio-leds";
 
-		heartbeat {
+		led-heartbeat {
 			label = "devkit8000::led1";
 			gpios = <&gpio6 26 GPIO_ACTIVE_HIGH>;	/* 186 -> LED1 */
 			default-state = "on";
 			linux,default-trigger = "heartbeat";
 		};
 
-		mmc {
+		led-mmc {
 			label = "devkit8000::led2";
 			gpios = <&gpio6 3 GPIO_ACTIVE_HIGH>;	/* 163 -> LED2 */
 			default-state = "on";
 			linux,default-trigger = "none";
 		};
 
-		usr {
+		led-usr {
 			label = "devkit8000::led3";
 			gpios = <&gpio6 4 GPIO_ACTIVE_HIGH>;	/* 164 -> LED3 */
 			default-state = "on";
 			linux,default-trigger = "usr";
 		};
 
-		pmu_stat {
+		led-pmu-stat {
 			label = "devkit8000::pmu_stat";
 			gpios = <&twl_gpio 19 GPIO_ACTIVE_HIGH>; /* LEDB */
 		};
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 98a67581bdd2..ba35cff5b01e 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -49,7 +49,7 @@ cpu@0 {
 
 	leds {
 		compatible = "gpio-leds";
-		heartbeat {
+		led-heartbeat {
 			label = "debug::sleep";
 			gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;  /* 162 */
 			linux,default-trigger = "default-on";
diff --git a/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi b/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
index bb932913c9e3..a6dbbba799b2 100644
--- a/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
@@ -17,19 +17,19 @@ leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
 		pinctrl-0 = <&led_pins>;
-		gpio148 {
+		led-gpio148 {
 			label = "overo:red:gpio148";
 			gpios = <&gpio5 20 GPIO_ACTIVE_HIGH>;		/* gpio 148 */
 		};
-		gpio150 {
+		led-gpio150 {
 			label = "overo:yellow:gpio150";
 			gpios = <&gpio5 22 GPIO_ACTIVE_HIGH>;		/* gpio 150 */
 		};
-		gpio151 {
+		led-gpio151 {
 			label = "overo:blue:gpio151";
 			gpios = <&gpio5 23 GPIO_ACTIVE_HIGH>;		/* gpio 151 */
 		};
-		gpio170 {
+		led-gpio170 {
 			label = "overo:green:gpio170";
 			gpios = <&gpio6 10 GPIO_ACTIVE_HIGH>;		/* gpio 170 */
 		};
diff --git a/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi b/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
index 2d2c61d7aa86..0d0e62c00916 100644
--- a/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
@@ -17,12 +17,12 @@ leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
 		pinctrl-0 = <&led_pins>;
-		heartbeat {
+		led-heartbeat {
 			label = "overo:red:gpio21";
 			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;		/* gpio_21 */
 			linux,default-trigger = "heartbeat";
 		};
-		gpio22 {
+		led-gpio22 {
 			label = "overo:blue:gpio22";
 			gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;		/* gpio_22 */
 		};
diff --git a/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi b/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi
index 155aec121400..5f6721326f86 100644
--- a/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi
@@ -17,12 +17,12 @@ leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
 		pinctrl-0 = <&led_pins>;
-		heartbeat {
+		led-heartbeat {
 			label = "overo:red:gpio21";
 			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;		/* gpio_21 */
 			linux,default-trigger = "heartbeat";
 		};
-		gpio22 {
+		led-gpio22 {
 			label = "overo:blue:gpio22";
 			gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;		/* gpio_22 */
 		};
diff --git a/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi b/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi
index 82a04466747a..4b66f622ac13 100644
--- a/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi
@@ -17,12 +17,12 @@ leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
 		pinctrl-0 = <&led_pins>;
-		heartbeat {
+		led-heartbeat {
 			label = "overo:red:gpio21";
 			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;		/* gpio_21 */
 			linux,default-trigger = "heartbeat";
 		};
-		gpio22 {
+		led-gpio22 {
 			label = "overo:blue:gpio22";
 			gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;		/* gpio_22 */
 		};
diff --git a/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi b/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
index 453a55324fa1..a8f163a899f0 100644
--- a/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
@@ -17,12 +17,12 @@ leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
 		pinctrl-0 = <&led_pins>;
-		heartbeat {
+		led-heartbeat {
 			label = "overo:red:gpio21";
 			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;		/* gpio_21 */
 			linux,default-trigger = "heartbeat";
 		};
-		gpio22 {
+		led-gpio22 {
 			label = "overo:blue:gpio22";
 			gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;		/* gpio_22 */
 		};
diff --git a/arch/arm/boot/dts/omap3-overo-summit-common.dtsi b/arch/arm/boot/dts/omap3-overo-summit-common.dtsi
index df7450f17ffd..ec03ca17e98b 100644
--- a/arch/arm/boot/dts/omap3-overo-summit-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-summit-common.dtsi
@@ -15,7 +15,7 @@ leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
 		pinctrl-0 = <&led_pins>;
-		heartbeat {
+		led-heartbeat {
 			label = "overo:red:gpio21";
 			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;		/* gpio_21 */
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
index 9bf4b88a4b50..5432e4e16ab5 100644
--- a/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-tobi-common.dtsi
@@ -13,7 +13,7 @@
 / {
 	leds {
 		compatible = "gpio-leds";
-		heartbeat {
+		led-heartbeat {
 			label = "overo:red:gpio21";
 			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
index 518652a599bd..0269424350aa 100644
--- a/arch/arm/boot/dts/omap4-panda-common.dtsi
+++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
@@ -49,13 +49,13 @@ leds: leds {
 			&led_wkgpio_pins
 		>;
 
-		heartbeat {
+		led-heartbeat {
 			label = "pandaboard::status1";
 			gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		mmc {
+		led-mmc {
 			label = "pandaboard::status2";
 			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts/omap4-panda-es.dts
index 7c6886cd738f..7631029e4d7a 100644
--- a/arch/arm/boot/dts/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/omap4-panda-es.dts
@@ -79,10 +79,10 @@ &led_gpio_pins
 		&led_wkgpio_pins
 	>;
 
-	heartbeat {
+	led-heartbeat {
 		gpios = <&gpio4 14 GPIO_ACTIVE_HIGH>;
 	};
-	mmc {
+	led-mmc {
 		gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 	};
 };
-- 
2.34.1

