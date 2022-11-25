Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D229638C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 15:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiKYOmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 09:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiKYOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 09:42:02 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF8D43863
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:42 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id r12so7239714lfp.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 06:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aimSpiXAt7qp5pBDLT0ccAR43wWFD78MSxKZ7Y0fkB0=;
        b=tcfWk21iwF6XOl8EXXa9PE1PjYL0I90Y+Ovn4jvgrBka6CZB4bMM1fnl9MPvygyrUl
         y6bMu44LxoLGFjS3s4rS/CRWk8Tk9Y39RwmkMhUAzTHb422gaGtaf6PlUXeprSd6GaTk
         BKmAgvUtM/riYEeHQ9aBl642hzCrWa8UmoboBhmTwdfDOkHDQfnDyvb47eWpgVmumt+6
         hGF/emPHx65wzyWwy4mqBOyY25X4YpYhOvedWgTlDEdBiWdQD5Hx7NM639IGXKAHyEvx
         KiMli/o7Cidz3jIwJMfa6Rl/QeUSl3+NQapM2Rak8Ja5QSqdcyrq4N21RCr6tGjEA4t3
         sz3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aimSpiXAt7qp5pBDLT0ccAR43wWFD78MSxKZ7Y0fkB0=;
        b=ZsGXYSLeBy6WiZ+LwnefCuwWd3ynFtXgefNQw5eIxcu/giqmILB7WGSH6XpvvqDsIw
         d4jN8jiCPP9EF1liCM8e/MHDN22Iq8iuRH4LNKpsNuzMQc000B6E4RvRonxqSjzsXEcV
         5968+oAdJ4E77vQpgQ5ikWGJFUbhnHWE67EajVrIGTlUpN7teX94znF4++Owrjv/L6sv
         epnXng2J0i4N6g/CjZpriaPoO3l4ACA5nUDEJSpLB+/JgqcaS7V0t7Jw0J7qbtqCRpBm
         Y1+PpIq9dGuYoUqsTyVL8eIgrhvjc3F2Jfaq+E2hGUiqCleNYl5fzxSavjSsB5EBdxft
         uRTQ==
X-Gm-Message-State: ANoB5pm+YmNaiSlCj5j77AXvyJQN/zAYDwo6EW9lVECbISAbHSfGvq3N
        TKhrVXfze++xqn4sNwEuSUTx2A==
X-Google-Smtp-Source: AA0mqf5KPek5lILPxzyYIAXDKSzmTuvhJUWFccFjdWnasvm7FHfiWA7JLVS6IgsbFmDTfUaaYxl9Lw==
X-Received: by 2002:a05:6512:281d:b0:4ab:a159:3478 with SMTP id cf29-20020a056512281d00b004aba1593478mr6432063lfb.655.1669387301577;
        Fri, 25 Nov 2022 06:41:41 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u21-20020a196a15000000b00498f570aef2sm552421lfu.209.2022.11.25.06.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 06:41:41 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: hisilicon: align LED node names with dtschema
Date:   Fri, 25 Nov 2022 15:41:39 +0100
Message-Id: <20221125144140.477225-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

  hisilicon/hi3660-hikey960.dtb: leds: wlan_active_led: Unevaluated properties are not allowed ('linux,default-trigger' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 12 ++++++------
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts    | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
index 0192a01bf852..3f13a960f34e 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
@@ -85,28 +85,28 @@ key-power {
 	leds {
 		compatible = "gpio-leds";
 
-		user_led1 {
+		led-user-1 {
 			label = "green:user1";
 			/* gpio_150_user_led1 */
 			gpios = <&gpio18 6 0>;
 			linux,default-trigger = "heartbeat";
 		};
 
-		user_led2 {
+		led-user-2 {
 			label = "green:user2";
 			/* gpio_151_user_led2 */
 			gpios = <&gpio18 7 0>;
 			linux,default-trigger = "none";
 		};
 
-		user_led3 {
+		led-user-3 {
 			label = "green:user3";
 			/* gpio_189_user_led3 */
 			gpios = <&gpio23 5 0>;
 			linux,default-trigger = "mmc0";
 		};
 
-		user_led4 {
+		led-user-4 {
 			label = "green:user4";
 			/* gpio_190_user_led4 */
 			gpios = <&gpio23 6 0>;
@@ -114,7 +114,7 @@ user_led4 {
 			linux,default-trigger = "none";
 		};
 
-		wlan_active_led {
+		led-wlan {
 			label = "yellow:wlan";
 			/* gpio_205_wifi_active */
 			gpios = <&gpio25 5 0>;
@@ -122,7 +122,7 @@ wlan_active_led {
 			default-state = "off";
 		};
 
-		bt_active_led {
+		led-bt {
 			label = "blue:bt";
 			gpios = <&gpio25 7 0>;
 			/* gpio_207_user_led1 */
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 629e604aa281..f0672ec65b26 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -125,39 +125,39 @@ wl1835_pwrseq: wl1835-pwrseq {
 	leds {
 		compatible = "gpio-leds";
 
-		user_led1 {
+		led-user-1 {
 			label = "green:user1";
 			gpios = <&gpio4 0 0>; /* <&gpio_user_led_1>; */
 			linux,default-trigger = "heartbeat";
 		};
 
-		user_led2 {
+		led-user-2 {
 			label = "green:user2";
 			gpios = <&gpio4 1 0>; /* <&gpio_user_led_2>; */
 			linux,default-trigger = "mmc0";
 		};
 
-		user_led3 {
+		led-user-3 {
 			label = "green:user3";
 			gpios = <&gpio4 2 0>; /* <&gpio_user_led_3>; */
 			linux,default-trigger = "mmc1";
 		};
 
-		user_led4 {
+		led-user-4 {
 			label = "green:user4";
 			gpios = <&gpio4 3 0>; /* <&gpio_user_led_4>; */
 			panic-indicator;
 			linux,default-trigger = "none";
 		};
 
-		wlan_active_led {
+		led-wlan {
 			label = "yellow:wlan";
 			gpios = <&gpio3 5 0>; /* <&gpio_wlan_active_led>; */
 			linux,default-trigger = "phy0tx";
 			default-state = "off";
 		};
 
-		bt_active_led {
+		led-bt {
 			label = "blue:bt";
 			gpios = <&gpio4 7 0>; /* <&gpio_bt_active_led>; */
 			linux,default-trigger = "hci0-power";
-- 
2.34.1

