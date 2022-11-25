Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F95638C80
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKYOmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:42:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiKYOln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:41:43 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6733E3FBAE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:32 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id z4so5408019ljq.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yL8SqBcAY3bdP+w/XO3YXrwrfGQvUYlXEg9DB6D/HXs=;
        b=sohclLSOTg6G0jUGPy8GTImFyAV5g1LmYfQGxWaKsD8XgWaDHT81FN1cpHN44cufSO
         FO45jn4P9JYcSvBMx0EoupnzFdNhYeagfg4uUKLTQY+1ElzeC55ORi+gvaBLk5e43gMS
         iVWXGFAoy7jSfix8O/YxAuCaw9B2ux+3Hv9+9hk0Muvguf0aIy3Q1IJK4shLK6UeYPJr
         TGo8vuxQFrXGHdCY4r9p0/fgCidDnnU0AL8Ewjcl4/IZ/tSKy5wf+Y9KYxqVIOvpq3Nu
         caudPm5aKsqPoEWVkxIN8P4b3ZyzENyKopiDy8mM6XHQEa7ho9fvGcXlqGIyq6nfI1pq
         Unsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yL8SqBcAY3bdP+w/XO3YXrwrfGQvUYlXEg9DB6D/HXs=;
        b=ZqghcRPeo9fi7TyeigBJYagFksuhxs6/XI6czpzgmLz7Aw5vNg7c3KOsLyVuKMp1ed
         0CH2hlfYIb6TEAO8KqfGKKWczI1P4I17+CBstMeBM9omWiIHXTe2CQEn2uAWVKITUV3x
         7tOKvVOn068YxrPnbcw0Dlr6FOQGefHCJvPrlM06yJyZqoJrwV7QgUUsmSJ+WI/Wv2oz
         q94dZBa1Ch4c6QjF/uGpvoZWZpUXPP5sOtFE3NNHBDOWzD4QLMW2udMfpHhK30c+9eeA
         xvdtyVrIW9opKYloDKKfDgSjo2+yZd7tuyuIm6NQpzveT0W9vRyBjaR8DjhkFtkpWlXz
         NjYA==
X-Gm-Message-State: ANoB5pnvobZhucJrnCgK7ThhbpQc8/htCFboc9xL71CHuiTH6tfXvF/W
        3DEY0xNKrLPWFERERsiOwopFew==
X-Google-Smtp-Source: AA0mqf4cLAB4T9h+CEcnqXaFmhYHBArXBLrj5CKNRgjzHxlYmWIzFmf4TUca/6f8c42NnWUfPXsz3w==
X-Received: by 2002:a2e:a4b7:0:b0:279:d52:5bc3 with SMTP id g23-20020a2ea4b7000000b002790d525bc3mr13710220ljm.231.1669387290425;
        Fri, 25 Nov 2022 06:41:30 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o29-20020ac25b9d000000b004b491fe071fsm547273lfn.36.2022.11.25.06.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:41:29 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: broadcom: align LED node names with dtschema
Date:   Fri, 25 Nov 2022 15:41:27 +0100
Message-Id: <20221125144128.477059-1-krzysztof.kozlowski@linaro.org>
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

  bcm4708-asus-rt-ac68u.dtb: leds: 'logo', 'power', 'usb2', 'usb3' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts   | 15 +++++-----
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts   |  8 +++---
 .../bcm4708-buffalo-wzr-1166dhp-common.dtsi   | 16 +++++------
 .../boot/dts/bcm4708-buffalo-wzr-1750dhp.dts  | 16 +++++------
 arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts  |  6 ++--
 arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts  |  2 +-
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts   | 10 +++----
 .../arm/boot/dts/bcm4708-netgear-r6300-v2.dts | 10 +++----
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts | 22 +++++++--------
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts   | 10 +++----
 .../boot/dts/bcm47081-buffalo-wzr-600dhp2.dts | 14 +++++-----
 .../boot/dts/bcm47081-buffalo-wzr-900dhp.dts  | 16 +++++------
 arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts |  6 ++--
 arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts | 20 ++++++-------
 .../boot/dts/bcm47081-tplink-archer-c5-v2.dts | 18 ++++++------
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts   |  6 ++--
 .../boot/dts/bcm4709-buffalo-wxr-1900dhp.dts  | 18 ++++++------
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts   | 16 +++++------
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts   | 22 +++++++--------
 .../boot/dts/bcm4709-tplink-archer-c9-v1.dts  | 18 ++++++------
 arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts  | 12 ++++----
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts | 14 +++++-----
 arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts | 16 +++++------
 .../boot/dts/bcm47094-linksys-panamera.dts    | 28 +++++++++----------
 arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts |  4 +--
 arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts |  6 ++--
 arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts |  4 +--
 arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts |  2 +-
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts | 20 ++++++-------
 .../boot/dts/bcm47094-luxul-xwr-3150-v1.dts   | 10 +++----
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts  | 14 +++++-----
 arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts |  4 +--
 arch/arm/boot/dts/bcm47189-luxul-xap-810.dts  | 10 +++----
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts      | 14 +++++-----
 .../boot/dts/bcm53016-dlink-dwl-8610ap.dts    |  8 +++---
 arch/arm/boot/dts/bcm53016-meraki-mr32.dts    |  6 ++--
 arch/arm/boot/dts/bcm947189acdbmr.dts         |  6 ++--
 37 files changed, 223 insertions(+), 224 deletions(-)

diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
index 09ee3e46c0cc..c80ac16ad949 100644
--- a/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
+++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts
@@ -28,40 +28,39 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		usb3 {
+		led-usb3 {
 			label = "bcm53xx:blue:usb3";
 			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
 		};
 
-		wan {
+		led-wan {
 			label = "bcm53xx:blue:wan";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
 		};
 
-		lan {
+		led-lan {
 			label = "bcm53xx:blue:lan";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
 		};
 
-		power {
+		led-power {
 			label = "bcm53xx:blue:power";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		all {
+		led-all {
 			label = "bcm53xx:blue:all";
 			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:blue:2ghz";
 			gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
 		};
 
-
-		usb2 {
+		led-usb2 {
 			label = "bcm53xx:blue:usb2";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
index 32619c6045d3..3fe17bd7b86d 100644
--- a/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
+++ b/arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts
@@ -28,24 +28,24 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		usb2 {
+		led-usb2 {
 			label = "bcm53xx:blue:usb2";
 			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
 		};
 
-		power {
+		led-power {
 			label = "bcm53xx:blue:power";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		logo {
+		led-logo {
 			label = "bcm53xx:white:logo";
 			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		usb3 {
+		led-usb3 {
 			label = "bcm53xx:blue:usb3";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp-common.dtsi b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp-common.dtsi
index a658b9b7bcec..e583b9cbf07c 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp-common.dtsi
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1166dhp-common.dtsi
@@ -37,7 +37,7 @@ hc595: gpio_spi@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		usb {
+		led-usb {
 			/* label = "bcm53xx:blue:usb"; */
 			function = LED_FUNCTION_USB;
 			color = <LED_COLOR_ID_BLUE>;
@@ -48,14 +48,14 @@ usb {
 			linux,default-trigger = "usbport";
 		};
 
-		power0 {
+		led-power0 {
 			/* label = "bcm53xx:red:power"; */
 			function = LED_FUNCTION_FAULT;
 			color = <LED_COLOR_ID_RED>;
 			gpios = <&hc595 1 GPIO_ACTIVE_HIGH>;
 		};
 
-		power1 {
+		led-power1 {
 			/* label = "bcm53xx:white:power"; */
 			function = LED_FUNCTION_POWER;
 			color = <LED_COLOR_ID_WHITE>;
@@ -63,7 +63,7 @@ power1 {
 			linux,default-trigger = "default-on";
 		};
 
-		router0 {
+		led-router0 {
 			/*  label = "bcm53xx:blue:router"; */
 			function = LED_FUNCTION_STATUS;
 			color = <LED_COLOR_ID_BLUE>;
@@ -71,14 +71,14 @@ router0 {
 			linux,default-trigger = "default-on";
 		};
 
-		router1 {
+		led-router1 {
 			/* label = "bcm53xx:amber:router"; */
 			function = LED_FUNCTION_STATUS;
 			color = <LED_COLOR_ID_AMBER>;
 			gpios = <&hc595 4 GPIO_ACTIVE_HIGH>;
 		};
 
-		wan {
+		led-wan {
 			/* label = "bcm53xx:blue:wan"; */
 			function = LED_FUNCTION_WAN;
 			color = <LED_COLOR_ID_BLUE>;
@@ -86,14 +86,14 @@ wan {
 			linux,default-trigger = "default-on";
 		};
 
-		wireless0 {
+		led-wireless0 {
 			/* label = "bcm53xx:blue:wireless"; */
 			function = LED_FUNCTION_WLAN;
 			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&hc595 6 GPIO_ACTIVE_HIGH>;
 		};
 
-		wireless1 {
+		led-wireless1 {
 			/* label = "bcm53xx:amber:wireless"; */
 			function = LED_FUNCTION_WLAN;
 			color = <LED_COLOR_ID_AMBER>;
diff --git a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
index f8f53457dd43..43c698a0a7c3 100644
--- a/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
+++ b/arch/arm/boot/dts/bcm4708-buffalo-wzr-1750dhp.dts
@@ -49,7 +49,7 @@ hc595: gpio_spi@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		usb {
+		led-usb {
 			label = "bcm53xx:blue:usb";
 			gpios = <&hc595 0 GPIO_ACTIVE_HIGH>;
 			trigger-sources = <&ohci_port1>, <&ehci_port1>,
@@ -58,40 +58,40 @@ usb {
 			linux,default-trigger = "usbport";
 		};
 
-		power0 {
+		led-power0 {
 			label = "bcm53xx:red:power";
 			gpios = <&hc595 1 GPIO_ACTIVE_HIGH>;
 		};
 
-		power1 {
+		led-power1 {
 			label = "bcm53xx:white:power";
 			gpios = <&hc595 2 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 
-		router0 {
+		led-router0 {
 			label = "bcm53xx:blue:router";
 			gpios = <&hc595 3 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 
-		router1 {
+		led-router1 {
 			label = "bcm53xx:amber:router";
 			gpios = <&hc595 4 GPIO_ACTIVE_HIGH>;
 		};
 
-		wan {
+		led-wan {
 			label = "bcm53xx:blue:wan";
 			gpios = <&hc595 5 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 
-		wireless0 {
+		led-wireless0 {
 			label = "bcm53xx:blue:wireless";
 			gpios = <&hc595 6 GPIO_ACTIVE_HIGH>;
 		};
 
-		wireless1 {
+		led-wireless1 {
 			label = "bcm53xx:amber:wireless";
 			gpios = <&hc595 7 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
index 14ee410183af..6de7fe204b0c 100644
--- a/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
+++ b/arch/arm/boot/dts/bcm4708-luxul-xap-1510.dts
@@ -23,19 +23,19 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		5ghz {
+		led-5ghz {
 			label = "bcm53xx:blue:5ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:blue:2ghz";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
-		status {
+		led-status {
 			label = "bcm53xx:green:status";
 			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "timer";
diff --git a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
index 600ab087f5e5..f5b75ba93512 100644
--- a/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
+++ b/arch/arm/boot/dts/bcm4708-luxul-xwc-1000.dts
@@ -42,7 +42,7 @@ partition@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		status {
+		led-status {
 			label = "bcm53xx:green:status";
 			gpios = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "timer";
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
index fd6d8d2a4456..89155caf50be 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6250.dts
@@ -29,24 +29,24 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		logo {
+		led-logo {
 			label = "bcm53xx:white:logo";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 
-		power0 {
+		led-power0 {
 			label = "bcm53xx:green:power";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		power1 {
+		led-power1 {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 		};
 
-		usb {
+		led-usb {
 			label = "bcm53xx:blue:usb";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
 			trigger-sources = <&ohci_port1>, <&ehci_port1>,
@@ -54,7 +54,7 @@ usb {
 			linux,default-trigger = "usbport";
 		};
 
-		wireless {
+		led-wireless {
 			label = "bcm53xx:blue:wireless";
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
index 76fc1099d47d..57d00a0b4765 100644
--- a/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
+++ b/arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts
@@ -28,29 +28,29 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		logo {
+		led-logo {
 			label = "bcm53xx:white:logo";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 
-		power0 {
+		led-power0 {
 			label = "bcm53xx:green:power";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
 		};
 
-		power1 {
+		led-power1 {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		usb {
+		led-usb {
 			label = "bcm53xx:blue:usb";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
 		};
 
-		wireless {
+		led-wireless {
 			label = "bcm53xx:blue:wireless";
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
index 6bcdfb73cb9e..26cdeb5cc337 100644
--- a/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
+++ b/arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts
@@ -28,64 +28,64 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		power-white {
+		led-power-white {
 			label = "bcm53xx:white:power";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 
-		power-amber {
+		led-power-amber {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_HIGH>;
 		};
 
-		usb2 {
+		led-usb2 {
 			label = "bcm53xx:white:usb2";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_HIGH>;
 			trigger-sources = <&ohci_port2>, <&ehci_port2>;
 			linux,default-trigger = "usbport";
 		};
 
-		usb3-white {
+		led-usb3-white {
 			label = "bcm53xx:white:usb3";
 			gpios = <&chipcommon 4 GPIO_ACTIVE_HIGH>;
 			trigger-sources = <&xhci_port1>;
 			linux,default-trigger = "usbport";
 		};
 
-		usb3-green {
+		led-usb3-green {
 			label = "bcm53xx:green:usb3";
 			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
 			trigger-sources = <&ohci_port1>, <&ehci_port1>;
 			linux,default-trigger = "usbport";
 		};
 
-		wps {
+		led-wps {
 			label = "bcm53xx:white:wps";
 			gpios = <&chipcommon 6 GPIO_ACTIVE_HIGH>;
 		};
 
-		status-red {
+		led-status-red {
 			label = "bcm53xx:red:status";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_HIGH>;
 		};
 
-		status-green {
+		led-status-green {
 			label = "bcm53xx:green:status";
 			gpios = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
 		};
 
-		status-blue {
+		led-status-blue {
 			label = "bcm53xx:blue:status";
 			gpios = <&chipcommon 10 GPIO_ACTIVE_HIGH>;
 		};
 
-		wan-white {
+		led-wan-white {
 			label = "bcm53xx:white:wan";
 			gpios = <&chipcommon 12 GPIO_ACTIVE_HIGH>;
 		};
 
-		wan-red {
+		led-wan-red {
 			label = "bcm53xx:red:wan";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
index ca47cc4f2ba1..3854db0118a9 100644
--- a/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
+++ b/arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts
@@ -28,30 +28,30 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		power {
+		led-power {
 			label = "bcm53xx:blue:power";
 			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		usb2 {
+		led-usb2 {
 			label = "bcm53xx:blue:usb2";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 		};
 
-		wan {
+		led-wan {
 			label = "bcm53xx:blue:wan";
 			gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		lan {
+		led-lan {
 			label = "bcm53xx:blue:lan";
 			gpios = <&chipcommon 9 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		usb3 {
+		led-usb3 {
 			label = "bcm53xx:blue:usb3";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
index 0edc2543e568..407319cb5c0d 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-600dhp2.dts
@@ -49,40 +49,40 @@ hc595: gpio_spi@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		power0 {
+		led-power0 {
 			label = "bcm53xx:green:power";
 			gpios = <&hc595 1 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 
-		power1 {
+		led-power1 {
 			label = "bcm53xx:red:power";
 			gpios = <&hc595 2 GPIO_ACTIVE_HIGH>;
 		};
 
-		router0 {
+		led-router0 {
 			label = "bcm53xx:green:router";
 			gpios = <&hc595 3 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 
-		router1 {
+		led-router1 {
 			label = "bcm53xx:amber:router";
 			gpios = <&hc595 4 GPIO_ACTIVE_HIGH>;
 		};
 
-		wan {
+		led-wan {
 			label = "bcm53xx:green:wan";
 			gpios = <&hc595 5 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 
-		wireless0 {
+		led-wireless0 {
 			label = "bcm53xx:green:wireless";
 			gpios = <&hc595 6 GPIO_ACTIVE_HIGH>;
 		};
 
-		wireless1 {
+		led-wireless1 {
 			label = "bcm53xx:amber:wireless";
 			gpios = <&hc595 7 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
index 1f0998f34afd..f8622ecce6a2 100644
--- a/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
+++ b/arch/arm/boot/dts/bcm47081-buffalo-wzr-900dhp.dts
@@ -49,45 +49,45 @@ hc595: gpio_spi@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		usb {
+		led-usb {
 			label = "bcm53xx:green:usb";
 			gpios = <&hc595 0 GPIO_ACTIVE_HIGH>;
 		};
 
-		power0 {
+		led-power0 {
 			label = "bcm53xx:green:power";
 			gpios = <&hc595 1 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 
-		power1 {
+		led-power1 {
 			label = "bcm53xx:red:power";
 			gpios = <&hc595 2 GPIO_ACTIVE_HIGH>;
 		};
 
-		router0 {
+		led-router0 {
 			label = "bcm53xx:green:router";
 			gpios = <&hc595 3 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 
-		router1 {
+		led-router1 {
 			label = "bcm53xx:amber:router";
 			gpios = <&hc595 4 GPIO_ACTIVE_HIGH>;
 		};
 
-		wan {
+		led-wan {
 			label = "bcm53xx:green:wan";
 			gpios = <&hc595 5 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 
-		wireless0 {
+		led-wireless0 {
 			label = "bcm53xx:green:wireless";
 			gpios = <&hc595 6 GPIO_ACTIVE_HIGH>;
 		};
 
-		wireless1 {
+		led-wireless1 {
 			label = "bcm53xx:amber:wireless";
 			gpios = <&hc595 7 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts b/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
index c8c02377543b..76c9b30b868d 100644
--- a/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
+++ b/arch/arm/boot/dts/bcm47081-luxul-xap-1410.dts
@@ -23,19 +23,19 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		5ghz {
+		led-5ghz {
 			label = "bcm53xx:blue:5ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:blue:2ghz";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
-		status {
+		led-status {
 			label = "bcm53xx:green:status";
 			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "timer";
diff --git a/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts b/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
index 3b35a7af4b1c..6ef0c0788e62 100644
--- a/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
+++ b/arch/arm/boot/dts/bcm47081-luxul-xwr-1200.dts
@@ -29,62 +29,62 @@ nvram@1eff0000 {
 	leds {
 		compatible = "gpio-leds";
 
-		power {
+		led-power {
 			label = "bcm53xx:green:power";
 			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		lan3 {
+		led-lan3 {
 			label = "bcm53xx:green:lan3";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
-		lan4 {
+		led-lan4 {
 			label = "bcm53xx:green:lan4";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
-		wan {
+		led-wan {
 			label = "bcm53xx:green:wan";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
-		lan2 {
+		led-lan2 {
 			label = "bcm53xx:green:lan2";
 			gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
-		usb {
+		led-usb {
 			label = "bcm53xx:green:usb";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
 			trigger-sources = <&ohci_port2>, <&ehci_port2>;
 			linux,default-trigger = "usbport";
 		};
 
-		status {
+		led-status {
 			label = "bcm53xx:green:status";
 			gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "timer";
 		};
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:green:2ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
-		5ghz {
+		led-5ghz {
 			label = "bcm53xx:green:5ghz";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
 		};
 
-		lan1 {
+		led-lan1 {
 			label = "bcm53xx:green:lan1";
 			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "none";
diff --git a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
index db9a37d70ef3..b6a5886698b2 100644
--- a/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
+++ b/arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
@@ -23,50 +23,50 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:green:2ghz";
 			gpios = <&chipcommon 0 GPIO_ACTIVE_HIGH>;
 		};
 
-		lan {
+		led-lan {
 			label = "bcm53xx:green:lan";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_HIGH>;
 		};
 
-		usb2-port1 {
+		led-usb2-port1 {
 			label = "bcm53xx:green:usb2-port1";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_HIGH>;
 			trigger-sources = <&ohci_port1>, <&ehci_port1>;
 			linux,default-trigger = "usbport";
 		};
 
-		power {
+		led-power {
 			label = "bcm53xx:green:power";
 			gpios = <&chipcommon 4 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 
-		wan-green {
+		led-wan-green {
 			label = "bcm53xx:green:wan";
 			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
 		};
 
-		wps {
+		led-wps {
 			label = "bcm53xx:green:wps";
 			gpios = <&chipcommon 6 GPIO_ACTIVE_HIGH>;
 		};
 
-		wan-amber {
+		led-wan-amber {
 			label = "bcm53xx:amber:wan";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_HIGH>;
 		};
 
-		5ghz {
+		led-5ghz {
 			label = "bcm53xx:green:5ghz";
 			gpios = <&chipcommon 12 GPIO_ACTIVE_HIGH>;
 		};
 
-		usb2-port2 {
+		led-usb2-port2 {
 			label = "bcm53xx:green:usb2-port2";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_HIGH>;
 			trigger-sources = <&ohci_port2>, <&ehci_port2>;
diff --git a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
index f52a75c4ca09..4f44cb4df704 100644
--- a/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
+++ b/arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts
@@ -28,18 +28,18 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		wps {
+		led-wps {
 			label = "bcm53xx:blue:wps";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
 		};
 
-		power {
+		led-power {
 			label = "bcm53xx:blue:power";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		wan {
+		led-wan {
 			label = "bcm53xx:red:wan";
 			gpios = <&chipcommon 5 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
index 5ff6c588e16e..b7cd2faa30ce 100644
--- a/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
+++ b/arch/arm/boot/dts/bcm4709-buffalo-wxr-1900dhp.dts
@@ -28,48 +28,48 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		usb {
+		led-usb {
 			label = "bcm53xx:green:usb";
 			gpios = <&chipcommon 4 GPIO_ACTIVE_HIGH>;
 		};
 
-		power-amber {
+		led-power-amber {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
 		};
 
-		power-white {
+		led-power-white {
 			label = "bcm53xx:white:power";
 			gpios = <&chipcommon 6 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 
-		router-amber {
+		led-router-amber {
 			label = "bcm53xx:amber:router";
 			gpios = <&chipcommon 7 GPIO_ACTIVE_HIGH>;
 		};
 
-		router-white {
+		led-router-white {
 			label = "bcm53xx:white:router";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_HIGH>;
 		};
 
-		wan-amber {
+		led-wan-amber {
 			label = "bcm53xx:amber:wan";
 			gpios = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
 		};
 
-		wan-white {
+		led-wan-white {
 			label = "bcm53xx:white:wan";
 			gpios = <&chipcommon 10 GPIO_ACTIVE_HIGH>;
 		};
 
-		wireless-amber {
+		led-wireless-amber {
 			label = "bcm53xx:amber:wireless";
 			gpios = <&chipcommon 11 GPIO_ACTIVE_HIGH>;
 		};
 
-		wireless-white {
+		led-wireless-white {
 			label = "bcm53xx:white:wireless";
 			gpios = <&chipcommon 12 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
index de961fbb6200..24ba8f8f9bf3 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r7000.dts
@@ -28,43 +28,43 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		power-white {
+		led-power-white {
 			label = "bcm53xx:white:power";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		power-amber {
+		led-power-amber {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 		};
 
-		5ghz {
+		led-5ghz {
 			label = "bcm53xx:white:5ghz";
 			gpios = <&chipcommon 12 GPIO_ACTIVE_LOW>;
 		};
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:white:2ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
 		};
 
-		wps {
+		led-wps {
 			label = "bcm53xx:white:wps";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_HIGH>;
 		};
 
-		wireless {
+		led-wireless {
 			label = "bcm53xx:white:wireless";
 			gpios = <&chipcommon 15 GPIO_ACTIVE_HIGH>;
 		};
 
-		usb3 {
+		led-usb3 {
 			label = "bcm53xx:white:usb3";
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
 		};
 
-		usb2 {
+		led-usb2 {
 			label = "bcm53xx:white:usb2";
 			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
index 087f7f60de18..14303ab521ea 100644
--- a/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
+++ b/arch/arm/boot/dts/bcm4709-netgear-r8000.dts
@@ -39,59 +39,59 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		power-white {
+		led-power-white {
 			label = "bcm53xx:white:power";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		power-amber {
+		led-power-amber {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 		};
 
-		wan-white {
+		led-wan-white {
 			label = "bcm53xx:white:wan";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		wan-amber {
+		led-wan-amber {
 			label = "bcm53xx:amber:wan";
 			gpios = <&chipcommon 9 GPIO_ACTIVE_HIGH>;
 		};
 
-		5ghz-1 {
+		led-5ghz-1 {
 			label = "bcm53xx:white:5ghz-1";
 			gpios = <&chipcommon 12 GPIO_ACTIVE_LOW>;
 		};
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:white:2ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
 		};
 
-		wireless {
+		led-wireless {
 			label = "bcm53xx:white:wireless";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_HIGH>;
 		};
 
-		wps {
+		led-wps {
 			label = "bcm53xx:white:wps";
 			gpios = <&chipcommon 15 GPIO_ACTIVE_HIGH>;
 		};
 
-		5ghz-2 {
+		led-5ghz-2 {
 			label = "bcm53xx:white:5ghz-2";
 			gpios = <&chipcommon 16 GPIO_ACTIVE_LOW>;
 		};
 
-		usb3 {
+		led-usb3 {
 			label = "bcm53xx:white:usb3";
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
 		};
 
-		usb2 {
+		led-usb2 {
 			label = "bcm53xx:white:usb2";
 			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
index 2cfb105f631a..5a8b2b1567e6 100644
--- a/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
+++ b/arch/arm/boot/dts/bcm4709-tplink-archer-c9-v1.dts
@@ -23,27 +23,27 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		lan {
+		led-lan {
 			label = "bcm53xx:blue:lan";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_HIGH>;
 		};
 
-		wps {
+		led-wps {
 			label = "bcm53xx:blue:wps";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_HIGH>;
 		};
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:blue:2ghz";
 			gpios = <&chipcommon 4 GPIO_ACTIVE_HIGH>;
 		};
 
-		5ghz {
+		led-5ghz {
 			label = "bcm53xx:blue:5ghz";
 			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
 		};
 
-		usb3 {
+		led-usb3 {
 			label = "bcm53xx:blue:usb3";
 			gpios = <&chipcommon 6 GPIO_ACTIVE_HIGH>;
 			trigger-sources = <&ohci_port1>, <&ehci_port1>,
@@ -51,24 +51,24 @@ usb3 {
 			linux,default-trigger = "usbport";
 		};
 
-		usb2 {
+		led-usb2 {
 			label = "bcm53xx:blue:usb2";
 			gpios = <&chipcommon 7 GPIO_ACTIVE_HIGH>;
 			trigger-sources = <&ohci_port2>, <&ehci_port2>;
 			linux,default-trigger = "usbport";
 		};
 
-		wan-blue {
+		led-wan-blue {
 			label = "bcm53xx:blue:wan";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_HIGH>;
 		};
 
-		wan-amber {
+		led-wan-amber {
 			label = "bcm53xx:amber:wan";
 			gpios = <&chipcommon 15 GPIO_ACTIVE_HIGH>;
 		};
 
-		power {
+		led-power {
 			label = "bcm53xx:blue:power";
 			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
diff --git a/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts b/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts
index a5fec56d11c0..a50ff686b557 100644
--- a/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts
+++ b/arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts
@@ -33,37 +33,37 @@ et1macaddr: et1macaddr {
 	leds {
 		compatible = "gpio-leds";
 
-		power {
+		led-power {
 			label = "white:power";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		wan-red {
+		led-wan-red {
 			label = "red:wan";
 			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
 		};
 
-		lan {
+		led-lan {
 			label = "white:lan";
 			gpios = <&chipcommon 21 GPIO_ACTIVE_LOW>;
 		};
 
-		usb2 {
+		led-usb2 {
 			label = "white:usb2";
 			gpios = <&chipcommon 16 GPIO_ACTIVE_LOW>;
 			trigger-sources = <&ehci_port2>;
 			linux,default-trigger = "usbport";
 		};
 
-		usb3 {
+		led-usb3 {
 			label = "white:usb3";
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
 			trigger-sources = <&ehci_port1>, <&xhci_port1>;
 			linux,default-trigger = "usbport";
 		};
 
-		wps {
+		led-wps {
 			label = "white:wps";
 			gpios = <&chipcommon 19 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 2c38b642a8b8..555fbe41dd8f 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -43,28 +43,28 @@ partition@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		power-white {
+		led-power-white {
 			label = "bcm53xx:white:power";
 			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		wan-white {
+		led-wan-white {
 			label = "bcm53xx:white:wan";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
 		};
 
-		power-amber {
+		led-power-amber {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
 		};
 
-		wan-amber {
+		led-wan-amber {
 			label = "bcm53xx:amber:wan";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 		};
 
-		usb3-white {
+		led-usb3-white {
 			label = "bcm53xx:white:usb3";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
 			trigger-sources = <&ohci_port1>, <&ehci_port1>,
@@ -72,12 +72,12 @@ usb3-white {
 			linux,default-trigger = "usbport";
 		};
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:white:2ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
 		};
 
-		5ghz {
+		led-5ghz {
 			label = "bcm53xx:white:5ghz";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
index c9f8acccf9a6..d945a20b06e0 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
@@ -41,47 +41,47 @@ leds {
 		 */
 		compatible = "gpio-leds";
 
-		power-white {
+		led-power-white {
 			label = "bcm53xx:white:power";
 			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		wan-white {
+		led-wan-white {
 			label = "bcm53xx:white:wan";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
 		};
 
-		power-amber {
+		led-power-amber {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
 		};
 
-		wan-amber {
+		led-wan-amber {
 			label = "bcm53xx:amber:wan";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 		};
 
-		usb3-white {
+		led-usb3-white {
 			label = "bcm53xx:white:usb3";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
 			trigger-sources = <&xhci_port1>;
 			linux,default-trigger = "usbport";
 		};
 
-		usb2-white {
+		led-usb2-white {
 			label = "bcm53xx:white:usb2";
 			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
 			trigger-sources = <&ohci_port1>, <&ehci_port1>;
 			linux,default-trigger = "usbport";
 		};
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:white:2ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
 		};
 
-		5ghz {
+		led-5ghz {
 			label = "bcm53xx:white:5ghz";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index 86c7cc0fa70e..d9a16a820e7f 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -52,19 +52,19 @@ button-reset {
 	leds {
 		compatible = "gpio-leds";
 
-		wps {
+		led-wps {
 			label = "bcm53xx:white:wps";
 			gpios = <&chipcommon 22 GPIO_ACTIVE_LOW>;
 		};
 
-		usb2 {
+		led-usb2 {
 			label = "bcm53xx:green:usb2";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
 			trigger-sources = <&ohci_port2>, <&ehci_port2>;
 			linux,default-trigger = "usbport";
 		};
 
-		usb3 {
+		led-usb3 {
 			label = "bcm53xx:green:usb3";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
 			trigger-sources = <&ohci_port1>, <&ehci_port1>,
@@ -72,58 +72,58 @@ usb3 {
 			linux,default-trigger = "usbport";
 		};
 
-		power {
+		led-power {
 			label = "bcm53xx:white:power";
 			gpios = <&chipcommon 4 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-on";
 		};
 
-		wifi-disabled {
+		led-wifi-disabled {
 			label = "bcm53xx:amber:wifi-disabled";
 			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
 		};
 
-		wifi-enabled {
+		led-wifi-enabled {
 			label = "bcm53xx:white:wifi-enabled";
 			gpios = <&chipcommon 5 GPIO_ACTIVE_HIGH>;
 		};
 
-		bluebar1 {
+		led-bluebar1 {
 			label = "bcm53xx:white:bluebar1";
 			gpios = <&chipcommon 11 GPIO_ACTIVE_HIGH>;
 		};
 
-		bluebar2 {
+		led-bluebar2 {
 			label = "bcm53xx:white:bluebar2";
 			gpios = <&chipcommon 12 GPIO_ACTIVE_HIGH>;
 		};
 
-		bluebar3 {
+		led-bluebar3 {
 			label = "bcm53xx:white:bluebar3";
 			gpios = <&chipcommon 15 GPIO_ACTIVE_LOW>;
 		};
 
-		bluebar4 {
+		led-bluebar4 {
 			label = "bcm53xx:white:bluebar4";
 			gpios = <&chipcommon 18 GPIO_ACTIVE_HIGH>;
 		};
 
-		bluebar5 {
+		led-bluebar5 {
 			label = "bcm53xx:white:bluebar5";
 			gpios = <&chipcommon 19 GPIO_ACTIVE_HIGH>;
 		};
 
-		bluebar6 {
+		led-bluebar6 {
 			label = "bcm53xx:white:bluebar6";
 			gpios = <&chipcommon 20 GPIO_ACTIVE_HIGH>;
 		};
 
-		bluebar7 {
+		led-bluebar7 {
 			label = "bcm53xx:white:bluebar7";
 			gpios = <&chipcommon 21 GPIO_ACTIVE_HIGH>;
 		};
 
-		bluebar8 {
+		led-bluebar8 {
 			label = "bcm53xx:white:bluebar8";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts b/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
index 9ad15bcae1ca..41a0722fa64a 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-abr-4500.dts
@@ -30,13 +30,13 @@ nvram@1eff0000 {
 	leds {
 		compatible = "gpio-leds";
 
-		status {
+		led-status {
 			label = "bcm53xx:green:status";
 			gpios = <&chipcommon 20 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "timer";
 		};
 
-		usb3 {
+		led-usb3 {
 			label = "bcm53xx:green:usb3";
 			gpios = <&chipcommon 19 GPIO_ACTIVE_LOW>;
 			trigger-sources = <&ohci_port1>, <&ehci_port1>,
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts b/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts
index ee24d3768536..c56c7e366848 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xap-1610.dts
@@ -23,18 +23,18 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		status	{
+		led-status {
 			label = "bcm53xx:green:status";
 			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "timer";
 		};
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:blue:2ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
 		};
 
-		5ghz {
+		led-5ghz {
 			label = "bcm53xx:blue:5ghz";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts b/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
index 6549d07b9887..1b5c91a524ac 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xbr-4500.dts
@@ -30,13 +30,13 @@ nvram@1eff0000 {
 	leds {
 		compatible = "gpio-leds";
 
-		status {
+		led-status {
 			label = "bcm53xx:green:status";
 			gpios = <&chipcommon 20 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "timer";
 		};
 
-		usb3 {
+		led-usb3 {
 			label = "bcm53xx:green:usb3";
 			gpios = <&chipcommon 19 GPIO_ACTIVE_HIGH>;
 			trigger-sources = <&ohci_port1>, <&ehci_port1>,
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts b/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts
index 654fcce9fded..739063b77b1f 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwc-2000.dts
@@ -25,7 +25,7 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		status	{
+		led-status {
 			label = "bcm53xx:green:status";
 			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "timer";
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
index bf053a2fcc7c..7afc68d5d2c2 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts
@@ -30,38 +30,38 @@ nvram@1eff0000 {
 	leds {
 		compatible = "gpio-leds";
 
-		power	{
+		led-power {
 			label = "bcm53xx:green:power";
 			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		lan3	{
+		led-lan3 {
 			label = "bcm53xx:green:lan3";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_LOW>;
 		};
 
-		lan4	{
+		led-lan4 {
 			label = "bcm53xx:green:lan4";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
 		};
 
-		wan	{
+		led-wan {
 			label = "bcm53xx:green:wan";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 		};
 
-		lan1	{
+		led-lan1 {
 			label = "bcm53xx:green:lan1";
 			gpios = <&chipcommon 4 GPIO_ACTIVE_LOW>;
 		};
 
-		lan2	{
+		led-lan2 {
 			label = "bcm53xx:green:lan2";
 			gpios = <&chipcommon 6 GPIO_ACTIVE_LOW>;
 		};
 
-		usb3	{
+		led-usb3 {
 			label = "bcm53xx:green:usb3";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
 			trigger-sources = <&ohci_port1>, <&ehci_port1>,
@@ -69,18 +69,18 @@ usb3	{
 			linux,default-trigger = "usbport";
 		};
 
-		status	{
+		led-status {
 			label = "bcm53xx:green:status";
 			gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "timer";
 		};
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:green:2ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
 		};
 
-		5ghz {
+		led-5ghz {
 			label = "bcm53xx:green:5ghz";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts b/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
index 78a90dd57a4e..60a2c441d5bd 100644
--- a/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
+++ b/arch/arm/boot/dts/bcm47094-luxul-xwr-3150-v1.dts
@@ -33,13 +33,13 @@ et0macaddr: et0macaddr {
 	leds {
 		compatible = "gpio-leds";
 
-		power	{
+		led-power {
 			label = "bcm53xx:green:power";
 			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		usb3	{
+		led-usb3 {
 			label = "bcm53xx:green:usb3";
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
 			trigger-sources = <&ohci_port1>, <&ehci_port1>,
@@ -47,18 +47,18 @@ usb3	{
 			linux,default-trigger = "usbport";
 		};
 
-		status	{
+		led-status {
 			label = "bcm53xx:green:status";
 			gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "timer";
 		};
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:green:2ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
 		};
 
-		5ghz {
+		led-5ghz {
 			label = "bcm53xx:green:5ghz";
 			gpios = <&chipcommon 14 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
index f850dce37b20..76d562610654 100644
--- a/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
+++ b/arch/arm/boot/dts/bcm47094-netgear-r8500.dts
@@ -25,38 +25,38 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		power0 {
+		led-power0 {
 			label = "bcm53xx:white:power";
 			gpios = <&chipcommon 2 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		power1 {
+		led-power1 {
 			label = "bcm53xx:amber:power";
 			gpios = <&chipcommon 3 GPIO_ACTIVE_LOW>;
 		};
 
-		5ghz-1 {
+		led-5ghz-1 {
 			label = "bcm53xx:white:5ghz-1";
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
 		};
 
-		5ghz-2 {
+		led-5ghz-2 {
 			label = "bcm53xx:white:5ghz-2";
 			gpios = <&chipcommon 12 GPIO_ACTIVE_LOW>;
 		};
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:white:2ghz";
 			gpios = <&chipcommon 13 GPIO_ACTIVE_LOW>;
 		};
 
-		usb2 {
+		led-usb2 {
 			label = "bcm53xx:white:usb2";
 			gpios = <&chipcommon 17 GPIO_ACTIVE_LOW>;
 		};
 
-		usb3 {
+		led-usb3 {
 			label = "bcm53xx:white:usb3";
 			gpios = <&chipcommon 18 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
index e20b6d2eb274..0734aa249b8e 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-1440.dts
@@ -23,13 +23,13 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		wlan {
+		led-wlan {
 			label = "bcm53xx:blue:wlan";
 			gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-off";
 		};
 
-		system {
+		led-system {
 			label = "bcm53xx:green:system";
 			gpios = <&chipcommon 11 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "timer";
diff --git a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
index 9d863570fcf3..e6fb6cbe6963 100644
--- a/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
+++ b/arch/arm/boot/dts/bcm47189-luxul-xap-810.dts
@@ -20,26 +20,26 @@ memory@0 {
 		reg = <0x00000000 0x08000000>;
 	};
 
-	leds {
+	leds-0 {
 		compatible = "gpio-leds";
 
-		5ghz {
+		led-5ghz {
 			label = "bcm53xx:blue:5ghz";
 			gpios = <&chipcommon 11 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-off";
 		};
 
-		system {
+		led-system {
 			label = "bcm53xx:green:system";
 			gpios = <&chipcommon 15 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "timer";
 		};
 	};
 
-	pcie0_leds {
+	leds-1 {
 		compatible = "gpio-leds";
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:blue:2ghz";
 			gpios = <&pcie0_chipcommon 3 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "default-off";
diff --git a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
index 55b92645b0f1..dab2e5f63a72 100644
--- a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
+++ b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
@@ -20,37 +20,37 @@ memory@0 {
 		reg = <0x00000000 0x08000000>;
 	};
 
-	leds {
+	leds-0 {
 		compatible = "gpio-leds";
 
-		usb {
+		led-usb {
 			label = "bcm53xx:blue:usb";
 			gpios = <&chipcommon 1 GPIO_ACTIVE_HIGH>;
 			trigger-sources = <&ohci_port1>, <&ehci_port1>;
 			linux,default-trigger = "usbport";
 		};
 
-		wps {
+		led-wps {
 			label = "bcm53xx:blue:wps";
 			gpios = <&chipcommon 10 GPIO_ACTIVE_HIGH>;
 		};
 
-		5ghz {
+		led-5ghz {
 			label = "bcm53xx:blue:5ghz";
 			gpios = <&chipcommon 11 GPIO_ACTIVE_HIGH>;
 		};
 
-		system {
+		led-system {
 			label = "bcm53xx:blue:system";
 			gpios = <&chipcommon 15 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "timer";
 		};
 	};
 
-	pcie0_leds {
+	leds-1 {
 		compatible = "gpio-leds";
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:blue:2ghz";
 			gpios = <&pcie0_chipcommon 3 GPIO_ACTIVE_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/bcm53016-dlink-dwl-8610ap.dts b/arch/arm/boot/dts/bcm53016-dlink-dwl-8610ap.dts
index b44a24448386..c1f54391746f 100644
--- a/arch/arm/boot/dts/bcm53016-dlink-dwl-8610ap.dts
+++ b/arch/arm/boot/dts/bcm53016-dlink-dwl-8610ap.dts
@@ -20,14 +20,14 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		power {
+		led-power {
 			function = LED_FUNCTION_POWER;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&chipcommon 0 GPIO_ACTIVE_LOW>;
 			default-state = "on";
 		};
 
-		diag {
+		led-diag {
 			/* Actually "diag" unclear what this means */
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_RED>;
@@ -36,13 +36,13 @@ diag {
 			linux,default-trigger = "heartbeat";
 		};
 
-		wlan-2g {
+		led-wlan-2g {
 			function = LED_FUNCTION_WLAN;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&chipcommon 5 GPIO_ACTIVE_LOW>;
 		};
 
-		wlan-5g {
+		led-wlan-5g {
 			function = LED_FUNCTION_WLAN;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&chipcommon 8 GPIO_ACTIVE_LOW>;
diff --git a/arch/arm/boot/dts/bcm53016-meraki-mr32.dts b/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
index e678bc03d816..46c2c93b01d8 100644
--- a/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
+++ b/arch/arm/boot/dts/bcm53016-meraki-mr32.dts
@@ -58,7 +58,7 @@ button-restart {
 	pwm-leds {
 		compatible = "pwm-leds";
 
-		red {
+		led-0 {
 			/* SYS-LED 1 - Tricolor */
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_RED>;
@@ -66,7 +66,7 @@ red {
 			max-brightness = <255>;
 		};
 
-		green {
+		led-1 {
 			/* SYS-LED 1 - Tricolor */
 			function = LED_FUNCTION_POWER;
 			color = <LED_COLOR_ID_GREEN>;
@@ -74,7 +74,7 @@ green {
 			max-brightness = <255>;
 		};
 
-		blue {
+		led-2 {
 			/* SYS-LED 1 - Tricolor */
 			function = LED_FUNCTION_INDICATOR;
 			color = <LED_COLOR_ID_BLUE>;
diff --git a/arch/arm/boot/dts/bcm947189acdbmr.dts b/arch/arm/boot/dts/bcm947189acdbmr.dts
index 16e70a264faf..3709baa2376f 100644
--- a/arch/arm/boot/dts/bcm947189acdbmr.dts
+++ b/arch/arm/boot/dts/bcm947189acdbmr.dts
@@ -25,17 +25,17 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		wps {
+		led-wps {
 			label = "bcm53xx:blue:wps";
 			gpios = <&chipcommon 10 GPIO_ACTIVE_HIGH>;
 		};
 
-		5ghz {
+		led-5ghz {
 			label = "bcm53xx:blue:5ghz";
 			gpios = <&chipcommon 11 GPIO_ACTIVE_HIGH>;
 		};
 
-		2ghz {
+		led-2ghz {
 			label = "bcm53xx:blue:2ghz";
 			gpios = <&chipcommon 12 GPIO_ACTIVE_HIGH>;
 		};
-- 
2.34.1

