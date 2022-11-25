Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32355638C82
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiKYOmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiKYOl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:41:57 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB9A419BB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:36 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id c1so7199576lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gi7iPHWP5YBH4QxBEX90m/DoNDKvTilLw4rc5kzkZNY=;
        b=zIbaZRgWy9PeA3Imq6ZLR+RW3QGJWATWPiKgXll/ZGMTiaNuan4HZa2/Iyd4R7Ut4e
         wFWJYIiUfQGs8CDB9ZpqhSRPKrDTKHgTNzkKKF+54U+jIDaTwKpFmoa+qozAY5CmC5YZ
         1IAClWFBcFTTGRP8wup0HgaHvC2Labj530VsfxfvH/JEZbrjrYeBflAgZsYEPF5CsSIu
         3TDfcpL4rclIfqz5nM4Ki75QTcms9yDKG/12Wy0gYu3SSnni1bMgehTo9Yc68XKZxaX4
         AaB/9YsQcyqVmcxBAyjvJfl1eiI+/ANz+w3VZsE2BLaI2S06MGWwFiMK530Ib16Cdtru
         H/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gi7iPHWP5YBH4QxBEX90m/DoNDKvTilLw4rc5kzkZNY=;
        b=Ror9UM00SnPiMo3mYOodZRkqjciYpYeDEvSIBmilDLcqHkHPQq9ymHS2IIxtBiq5+S
         t+NTCNYs42h6vhXgBqp847BastO27tXfhm6nJ/x0aYBKpSdzCw/yQlFo1fKjXzWTKke2
         PwrTPb3BPQh5El6YAgKtyFNna7xzPQAYO9JBg23z19OBeOQigWXBbk3vikbeBO1thYHI
         6wO4OFGc4p7qN6Luc4nmt6bvJhxmcH2qQeoEvE0J74uS9I21T5BcABlRlAx4fTks3eGk
         Pe62KLoccFNLL7YHzXq+byz5aNRCfBe7A3Fkv6bhs1FIIntQEpqwJ+FkcZlJf3UdihiU
         3GRA==
X-Gm-Message-State: ANoB5pnVK1csNvY3K1Gou/mrQG17JBioi84XliSnXV5KFuqKwsHSn9Tc
        lP7hTT47rnXpiEdbMCXCHZWd4g==
X-Google-Smtp-Source: AA0mqf5VO68wXdxPgtzR92oPV5fwyMsNVH1M2qsk1KqfGEgpKknPGvLejpaAejvpc3l6fSW+sXb72A==
X-Received: by 2002:a19:5f56:0:b0:4b4:107f:40c with SMTP id a22-20020a195f56000000b004b4107f040cmr14599623lfj.396.1669387294772;
        Fri, 25 Nov 2022 06:41:34 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y30-20020a0565123f1e00b004a2386b8cf9sm551359lfa.206.2022.11.25.06.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:41:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: armada: align LED node names with dtschema
Date:   Fri, 25 Nov 2022 15:41:32 +0100
Message-Id: <20221125144133.477116-1-krzysztof.kozlowski@linaro.org>
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

  armada-370-seagate-personal-cloud.dtb: gpio-leds: 'red-sata0' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/armada-370-dlink-dns327l.dts           | 6 +++---
 arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts        | 4 ++--
 arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi       | 8 ++++----
 arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi | 2 +-
 arch/arm/boot/dts/armada-385-linksys-caiman.dts          | 4 ++--
 arch/arm/boot/dts/armada-385-linksys-cobra.dts           | 4 ++--
 arch/arm/boot/dts/armada-385-linksys-rango.dts           | 8 ++++----
 arch/arm/boot/dts/armada-385-linksys-shelby.dts          | 4 ++--
 arch/arm/boot/dts/armada-385-linksys.dtsi                | 4 ++--
 arch/arm/boot/dts/armada-385-synology-ds116.dts          | 2 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts            | 2 +-
 11 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
index 2008c6eaaa52..561195b749eb 100644
--- a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
+++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
@@ -86,19 +86,19 @@ &sata_l_white_pin
 
 		pinctrl-names = "default";
 
-		sata-r-amber-pin {
+		led-sata-r-amber {
 			label = "dns327l:amber:sata-r";
 			gpios = <&gpio1 20 GPIO_ACTIVE_HIGH>;
 			default-state = "keep";
 		};
 
-		sata-l-amber-pin {
+		led-sata-l-amber {
 			label = "dns327l:amber:sata-l";
 			gpios = <&gpio1 21 GPIO_ACTIVE_HIGH>;
 			default-state = "keep";
 		};
 
-		backup-led-pin {
+		led-backup {
 			label = "dns327l:white:usb";
 			gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
 			default-state = "keep";
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
index 3cf70c72c5ca..9cb69999b1db 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-4bay.dts
@@ -72,11 +72,11 @@ regulator@4 {
 	};
 
 	gpio-leds {
-		red-sata2 {
+		led-red-sata2 {
 			label = "dart:red:sata2";
 			gpios = <&pca9554 0 GPIO_ACTIVE_LOW>;
 		};
-		red-sata3 {
+		led-red-sata3 {
 			label = "dart:red:sata3";
 			gpios = <&pca9554 3 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
index 866b8630d407..822f10734946 100644
--- a/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-nas-xbay.dtsi
@@ -132,21 +132,21 @@ button-reset {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		white-power {
+		led-white-power {
 			label = "dart:white:power";
 			gpios = <&gpio1 28 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "timer";
 
 		};
-		red-power {
+		led-red-power {
 			label = "dart:red:power";
 			gpios = <&gpio1 31 GPIO_ACTIVE_HIGH>;
 		};
-		red-sata0 {
+		led-red-sata0 {
 			label = "dart:red:sata0";
 			gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
 		};
-		red-sata1 {
+		led-red-sata1 {
 			label = "dart:red:sata1";
 			gpios = <&gpio1 21 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
index 702a85af2078..124a8ba279e3 100644
--- a/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
+++ b/arch/arm/boot/dts/armada-370-seagate-personal-cloud.dtsi
@@ -107,7 +107,7 @@ button-usb {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		red-sata0 {
+		led-red-sata0 {
 			label = "cumulus:red:sata0";
 			gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
diff --git a/arch/arm/boot/dts/armada-385-linksys-caiman.dts b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
index a03050c97084..88b2921fed55 100644
--- a/arch/arm/boot/dts/armada-385-linksys-caiman.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-caiman.dts
@@ -62,11 +62,11 @@ wps_amber@9 {
 };
 
 &gpio_leds {
-	power {
+	led-power {
 		label = "caiman:white:power";
 	};
 
-	sata {
+	led-sata {
 		label = "caiman:white:sata";
 	};
 };
diff --git a/arch/arm/boot/dts/armada-385-linksys-cobra.dts b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
index e3e4877a6f49..88200f930d0d 100644
--- a/arch/arm/boot/dts/armada-385-linksys-cobra.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-cobra.dts
@@ -62,11 +62,11 @@ wps_amber@9 {
 };
 
 &gpio_leds {
-	power {
+	led-power {
 		label = "cobra:white:power";
 	};
 
-	sata {
+	led-sata {
 		label = "cobra:white:sata";
 	};
 };
diff --git a/arch/arm/boot/dts/armada-385-linksys-rango.dts b/arch/arm/boot/dts/armada-385-linksys-rango.dts
index 3c4af57ec2b9..4ab45f294de2 100644
--- a/arch/arm/boot/dts/armada-385-linksys-rango.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-rango.dts
@@ -54,22 +54,22 @@ wps_amber@9 {
 };
 
 &gpio_leds {
-	power {
+	led-power {
 		gpios = <&gpio1 24 GPIO_ACTIVE_HIGH>;
 		label = "rango:white:power";
 	};
 
-	sata {
+	led-sata {
 		gpios = <&gpio0 21 GPIO_ACTIVE_LOW>;
 		label = "rango:white:sata";
 	};
 
-	wlan_2g {
+	led-wlan_2g {
 		gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
 		label = "rango:white:wlan_2g";
 	};
 
-	wlan_5g {
+	led-wlan_5g {
 		gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
 		label = "rango:white:wlan_5g";
 	};
diff --git a/arch/arm/boot/dts/armada-385-linksys-shelby.dts b/arch/arm/boot/dts/armada-385-linksys-shelby.dts
index 3451cd3e5dff..f1b1f22413f1 100644
--- a/arch/arm/boot/dts/armada-385-linksys-shelby.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-shelby.dts
@@ -62,11 +62,11 @@ wps_amber@9 {
 };
 
 &gpio_leds {
-	power {
+	led-power {
 		label = "shelby:white:power";
 	};
 
-	sata {
+	led-sata {
 		label = "shelby:white:sata";
 	};
 };
diff --git a/arch/arm/boot/dts/armada-385-linksys.dtsi b/arch/arm/boot/dts/armada-385-linksys.dtsi
index 116aca5e688f..85e8d966f6c1 100644
--- a/arch/arm/boot/dts/armada-385-linksys.dtsi
+++ b/arch/arm/boot/dts/armada-385-linksys.dtsi
@@ -71,12 +71,12 @@ gpio_leds: gpio-leds {
 		pinctrl-0 = <&gpio_leds_pins>;
 		pinctrl-names = "default";
 
-		power {
+		led-power {
 			gpios = <&gpio1 23 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 		};
 
-		sata {
+		led-sata {
 			gpios = <&gpio1 22 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 			linux,default-trigger = "disk-activity";
diff --git a/arch/arm/boot/dts/armada-385-synology-ds116.dts b/arch/arm/boot/dts/armada-385-synology-ds116.dts
index 2622af73c9da..ea91ff964d94 100644
--- a/arch/arm/boot/dts/armada-385-synology-ds116.dts
+++ b/arch/arm/boot/dts/armada-385-synology-ds116.dts
@@ -149,7 +149,7 @@ gpio-leds {
 			 * sata0, and accesses to SATA disk 0 make it blink so it
 			 * doesn't need to be declared here.
 			 */
-			orange {
+			led-orange {
 				gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>;
 				label = "ds116:orange:disk";
 				default-state = "off";
diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 622ac40dd164..dbe8dfe236fb 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -195,7 +195,7 @@ gpio-leds {
 		pinctrl-0 = <&power_led_pin>;
 		pinctrl-names = "default";
 
-		power {
+		led-power {
 			label = "mamba:white:power";
 			gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
-- 
2.34.1

