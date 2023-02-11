Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCF369301E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjBKKuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBKKuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:50:12 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FFA1D938;
        Sat, 11 Feb 2023 02:50:11 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id dr8so21487543ejc.12;
        Sat, 11 Feb 2023 02:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XOIDNWrvLuzXO/s8AOThCUhkQmtWjdE1KvUgoN/WDQU=;
        b=ZAS1zc1RtMcqfpooZhzkwkU/m608/vSGtEQhWwvr4lDHM/QuQhcAPD5NFRvmG9Id6r
         gGkbCxINd9cFwGsHSqrNw7Po2Vb8QuOJ4EHlJnf5qQxJoQ9KzRAb7tgjmSqBytqLeqzf
         WGO2qQmQjgudaIwaQ3d7FfwudvNgj4dncaeMjhilAYY6t4jHd8bUcUzJwO0GpkG2/zhj
         g6gAld8rStNeax0TTYSWItQWISYpol+d4StFl2ncDumt4LcUW3qR8m7WVPx+uYoL9lxT
         0GwZTjJjcET87CvPc12n3yEhv3uQ9kIFU3G9yoNms/JlWLeRFO1xM3/pRMDwrRRCkJwp
         n2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOIDNWrvLuzXO/s8AOThCUhkQmtWjdE1KvUgoN/WDQU=;
        b=fo39R7PrQp8/qrtemQOOkXNNrDfYmo+0mGhnTRPHtImO7tgObYREK3dYwSghajwGAt
         Khfk+atvJlBlbj1+TOLIObFZSAJCsGNTs4wXHGBwrKd2F9n5tAkPczQN9RMlUvtWmUVr
         oobbg/lO32vUyRbl/2TUqXzqVPky0/ipWDVwghrRR0xAcgKS1IwYyq7zGbpqJh0I+JRt
         1YvJ/BEcVcCGj9u/dGeY/BFaV/9VVkq6BUAa7gXRR+QeudXByJJJhXtvhPw1fr5kCNmH
         Kjcq1tcLzuOlC1yL+JQFbKFlwv1Xlz6lQ1HOxr9m7ZVJiMFrtmxwobYcGwygInJm8yne
         HEmw==
X-Gm-Message-State: AO0yUKVGlevAETkJKUx7cnSNqTWkms1BKeLvkknedT1tvyD+AKdfGQqj
        16E3E4K12Nb8qrNJwzZvN6I=
X-Google-Smtp-Source: AK7set/6Uv4EZ38y8b1ogJQDw5brhIFv3zO5QJAKoNcZhB2A9/JK1h+P7pkxX1u6hbiTdIx6tlJXeg==
X-Received: by 2002:a17:906:49c6:b0:844:d342:3566 with SMTP id w6-20020a17090649c600b00844d3423566mr17952957ejv.22.1676112609434;
        Sat, 11 Feb 2023 02:50:09 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id cb10-20020a0564020b6a00b004ac54d4da22sm1597911edb.71.2023.02.11.02.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 02:50:09 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, erkin.bozoglu@xeront.com
Subject: [PATCH 1/2] mips: dts: align LED node names with dtschema
Date:   Sat, 11 Feb 2023 13:49:14 +0300
Message-Id: <20230211104915.116253-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The node names should be generic and DT schema expects certain pattern:

  mt7621-gnubee-gb-pc1.dtb: gpio-leds: 'power', 'system' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 .../dts/cavium-octeon/dlink_dsr-1000n.dts     | 10 ++++-----
 .../boot/dts/cavium-octeon/dlink_dsr-500n.dts |  6 ++---
 arch/mips/boot/dts/ingenic/ci20.dts           |  8 +++----
 arch/mips/boot/dts/pic32/pic32mzda_sk.dts     |  6 ++---
 .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  8 +++----
 .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  8 +++----
 arch/mips/boot/dts/qca/ar9331_omega.dts       |  2 +-
 arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  8 +++----
 .../ralink/gardena_smart_gateway_mt7688.dts   | 22 +++++++++----------
 .../boot/dts/ralink/mt7621-gnubee-gb-pc1.dts  |  4 ++--
 .../boot/dts/ralink/mt7621-gnubee-gb-pc2.dts  | 12 +++++-----
 11 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts
index 2fdb4baad19c..cb460eaf8835 100644
--- a/arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts
+++ b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts
@@ -20,27 +20,27 @@ uart0: serial@1180000000800 {
 	leds {
 		compatible = "gpio-leds";
 
-		usb1 {
+		led-usb1 {
 			label = "usb1";
 			gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
 		};
 
-		usb2 {
+		led-usb2 {
 			label = "usb2";
 			gpios = <&gpio 10 GPIO_ACTIVE_LOW>;
 		};
 
-		wps {
+		led-wps {
 			label = "wps";
 			gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
 		};
 
-		wireless1 {
+		led-wireless1 {
 			label = "5g";
 			gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
 		};
 
-		wireless2 {
+		led-wireless2 {
 			label = "2.4g";
 			gpios = <&gpio 18 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts
index e04237281b41..c55845fd84ca 100644
--- a/arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts
+++ b/arch/mips/boot/dts/cavium-octeon/dlink_dsr-500n.dts
@@ -21,15 +21,15 @@ uart0: serial@1180000000800 {
 	leds {
 		compatible = "gpio-leds";
 
-		usb {
+		led-usb {
 			gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
 		};
 
-		wps {
+		led-wps {
 			gpios = <&gpio 11 GPIO_ACTIVE_LOW>;
 		};
 
-		wireless {
+		led-wireless {
 			label = "2.4g";
 			gpios = <&gpio 18 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/mips/boot/dts/ingenic/ci20.dts b/arch/mips/boot/dts/ingenic/ci20.dts
index f38c39572a9e..3483ae0c05f5 100644
--- a/arch/mips/boot/dts/ingenic/ci20.dts
+++ b/arch/mips/boot/dts/ingenic/ci20.dts
@@ -42,25 +42,25 @@ switch {
 	leds {
 		compatible = "gpio-leds";
 
-		led0 {
+		led-0 {
 			label = "ci20:red:led0";
 			gpios = <&gpc 3 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "none";
 		};
 
-		led1 {
+		led-1 {
 			label = "ci20:red:led1";
 			gpios = <&gpc 2 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "nand-disk";
 		};
 
-		led2 {
+		led-2 {
 			label = "ci20:red:led2";
 			gpios = <&gpc 1 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "cpu1";
 		};
 
-		led3 {
+		led-3 {
 			label = "ci20:red:led3";
 			gpios = <&gpc 0 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "cpu0";
diff --git a/arch/mips/boot/dts/pic32/pic32mzda_sk.dts b/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
index ab70637bbec5..b1c5ffdb33fc 100644
--- a/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
+++ b/arch/mips/boot/dts/pic32/pic32mzda_sk.dts
@@ -28,19 +28,19 @@ leds0 {
 		pinctrl-names = "default";
 		pinctrl-0 = <&user_leds_s0>;
 
-		led@1 {
+		led-1 {
 			label = "pic32mzda_sk:red:led1";
 			gpios = <&gpio7 0 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		led@2 {
+		led-2 {
 			label = "pic32mzda_sk:yellow:led2";
 			gpios = <&gpio7 1 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "mmc0";
 		};
 
-		led@3 {
+		led-3 {
 			label = "pic32mzda_sk:green:led3";
 			gpios = <&gpio7 2 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index f3dff4009ab5..f894fe17816b 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -41,23 +41,23 @@ button-1 {
 
 	leds {
 		compatible = "gpio-leds";
-		led@0 {
+		led-0 {
 			label = "tp-link:green:usb";
 			gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
 		};
 
-		led@1 {
+		led-1 {
 			label = "tp-link:green:system";
 			gpios = <&gpio 2 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		led@2 {
+		led-2 {
 			label = "tp-link:green:qss";
 			gpios = <&gpio 5 GPIO_ACTIVE_HIGH>;
 		};
 
-		led@3 {
+		led-3 {
 			label = "tp-link:green:wlan";
 			gpios = <&gpio 9 GPIO_ACTIVE_LOW>;
 		};
diff --git a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
index 40e4c5da0e65..7affa58d4fa6 100644
--- a/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
+++ b/arch/mips/boot/dts/qca/ar9331_dragino_ms14.dts
@@ -22,25 +22,25 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		wlan {
+		led-wlan {
 			label = "dragino2:red:wlan";
 			gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		lan {
+		led-lan {
 			label = "dragino2:red:lan";
 			gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		wan {
+		led-wan {
 			label = "dragino2:red:wan";
 			gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		system {
+		led-system {
 			label = "dragino2:red:system";
 			gpios = <&gpio 28 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
diff --git a/arch/mips/boot/dts/qca/ar9331_omega.dts b/arch/mips/boot/dts/qca/ar9331_omega.dts
index ed184d861d5f..8904aa917a6e 100644
--- a/arch/mips/boot/dts/qca/ar9331_omega.dts
+++ b/arch/mips/boot/dts/qca/ar9331_omega.dts
@@ -22,7 +22,7 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		system {
+		led-system {
 			label = "onion:amber:system";
 			gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
 			default-state = "off";
diff --git a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
index 5f424c2cd781..10b9759228b7 100644
--- a/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
+++ b/arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts
@@ -22,25 +22,25 @@ memory@0 {
 	leds {
 		compatible = "gpio-leds";
 
-		wlan {
+		led-wlan {
 			label = "tp-link:green:wlan";
 			gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		lan {
+		led-lan {
 			label = "tp-link:green:lan";
 			gpios = <&gpio 17 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		wps {
+		led-wps {
 			label = "tp-link:green:wps";
 			gpios = <&gpio 26 GPIO_ACTIVE_LOW>;
 			default-state = "off";
 		};
 
-		led3g {
+		led-led3g {
 			label = "tp-link:green:3g";
 			gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
 			default-state = "off";
diff --git a/arch/mips/boot/dts/ralink/gardena_smart_gateway_mt7688.dts b/arch/mips/boot/dts/ralink/gardena_smart_gateway_mt7688.dts
index 179558161f85..18107ca0a06b 100644
--- a/arch/mips/boot/dts/ralink/gardena_smart_gateway_mt7688.dts
+++ b/arch/mips/boot/dts/ralink/gardena_smart_gateway_mt7688.dts
@@ -47,67 +47,67 @@ leds {
 		 * (see below). So we can't include it in this LED node.
 		 */
 
-		power_blue {
+		led-power-blue {
 			label = "smartgw:power:blue";
 			gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		power_green {
+		led-power-green {
 			label = "smartgw:power:green";
 			gpios = <&gpio 19 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		power_red {
+		led-power-red {
 			label = "smartgw:power:red";
 			gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		radio_blue {
+		led-radio-blue {
 			label = "smartgw:radio:blue";
 			gpios = <&gpio 23 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		radio_green {
+		led-radio-green {
 			label = "smartgw:radio:green";
 			gpios = <&gpio 24 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		radio_red {
+		led-radio-red {
 			label = "smartgw:radio:red";
 			gpios = <&gpio 25 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		internet_blue {
+		led-internet-blue {
 			label = "smartgw:internet:blue";
 			gpios = <&gpio 26 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		internet_green {
+		led-internet-green {
 			label = "smartgw:internet:green";
 			gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		internet_red {
+		led-internet-red {
 			label = "smartgw:internet:red";
 			gpios = <&gpio 28 GPIO_ACTIVE_HIGH>;
 			default-state = "off";
 		};
 
-		ethernet_link {
+		led-ethernet-link {
 			label = "smartgw:eth:link";
 			gpios = <&gpio 3 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "netdev";
 		};
 
-		ethernet_activity {
+		led-ethernet-activity {
 			label = "smartgw:eth:act";
 			gpios = <&gpio 43 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "netdev";
diff --git a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
index 0128bd8fa7ed..4314aee97e18 100644
--- a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
+++ b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc1.dts
@@ -33,13 +33,13 @@ key-reset {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		power {
+		led-power {
 			label = "green:power";
 			gpios = <&gpio 6 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		system {
+		led-system {
 			label = "green:system";
 			gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "disk-activity";
diff --git a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
index e31417569e09..3ebbf933f644 100644
--- a/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
+++ b/arch/mips/boot/dts/ralink/mt7621-gnubee-gb-pc2.dts
@@ -33,33 +33,33 @@ key-reset {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		ethblack-green {
+		led-ethblack-green {
 			label = "green:ethblack";
 			gpios = <&gpio 3 GPIO_ACTIVE_LOW>;
 		};
 
-		ethblue-green {
+		led-ethblue-green {
 			label = "green:ethblue";
 			gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
 		};
 
-		ethyellow-green {
+		led-ethyellow-green {
 			label = "green:ethyellow";
 			gpios = <&gpio 15 GPIO_ACTIVE_LOW>;
 		};
 
-		ethyellow-orange {
+		led-ethyellow-orange {
 			label = "orange:ethyellow";
 			gpios = <&gpio 13 GPIO_ACTIVE_LOW>;
 		};
 
-		power {
+		led-power {
 			label = "green:power";
 			gpios = <&gpio 6 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "default-on";
 		};
 
-		system {
+		led-system {
 			label = "green:system";
 			gpios = <&gpio 8 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "disk-activity";
-- 
2.37.2

