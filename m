Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2636537FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiLUVHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiLUVHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:07:20 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75FE2657F;
        Wed, 21 Dec 2022 13:07:10 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so1380279wms.4;
        Wed, 21 Dec 2022 13:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nrHW2nZPS02ZWv3aQJK/QCBWF5IiEBszwRBGZwror8=;
        b=gnICfvvqTzoxFV9J6OhD0dfy1GMLDNmK/+HGPTgNy7dKVlH4BJtcjnaMWCj0kUHjSb
         PuUR6Pw/5E0+NzyemYIlh07NYT/DIYBozIoFTNM05Nh5VemjtWNf5stVx/bLlH5yNyQB
         IjFEW8elV7s6xC9lVWDg8fdLI7MrHrzvdqhxpdjlA7hpSrcn+Q+4JWL35hroS0mR3ZfB
         b7i4ashBFei/Wf4nHej2MssKZof6oEi/VbgD0AUQUDigRaq5AJoisgNqzDYp3OzbiPuc
         48v2tGY8toKeT68Cbg2DGBjecM50txuHjcj3/tkcLvYZTeN73lHQVV4uBAZRK48LKiCr
         ADXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nrHW2nZPS02ZWv3aQJK/QCBWF5IiEBszwRBGZwror8=;
        b=ZX2mJLLHJ/ZqPaNJqJ1qT9aq1PqwI0MhdV14qGTN84CCfF+ybyXSoa42c3DW2ifmZ3
         kRXKMx71gav1iMHg3HI7oh4l0PaA3rb2CX0FqnYDXtZKLB46wlG1kPQdgIhHOA6mz3pB
         kO/fYXazE4WuefdVLr+g4C/72sVxPHCox24w6ApskWwhkdm9sRvQRfkT+xdbQkKalE51
         p4wRH9mwfey9+QLPYVTZn5Rqpmu9XOsTeNa8vw8JM647lJ6KSKg5eKjUAE8FbYPXoPzH
         k+LAtHDxBqq6E2zCTD2NJm9mHDhtIf31vk6cyi1eYkyEKc9ahN+PfIBoKE2BvLzENhxs
         TgDg==
X-Gm-Message-State: AFqh2ko/htOadaYjO47q3GEXKrPetFDW1XGROr1zpdqy3dwRp2u0mY3Y
        A3ZknuH7z3FJbjAU/mW8NNg=
X-Google-Smtp-Source: AMrXdXsWqORR30ZKUUcvgUiVkQFjXes2NPsOYf28UCYRbqgLunfHxhURs5+D2N0hCE/rzH4p3p7CTA==
X-Received: by 2002:a05:600c:3b9d:b0:3d2:3e75:7bb9 with SMTP id n29-20020a05600c3b9d00b003d23e757bb9mr2358068wms.34.1671656829455;
        Wed, 21 Dec 2022 13:07:09 -0800 (PST)
Received: from localhost ([176.234.10.188])
        by smtp.gmail.com with UTF8SMTPSA id a1-20020a05600c348100b003b47b80cec3sm3412423wmq.42.2022.12.21.13.07.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 13:07:09 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v5 3/4] arm64: dts: apple: t8103: Add PWM controller
Date:   Thu, 22 Dec 2022 00:06:47 +0300
Message-Id: <20221221210648.2735-4-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20221221210648.2735-1-fnkl.kernel@gmail.com>
References: <20221221210648.2735-1-fnkl.kernel@gmail.com>
MIME-Version: 1.0
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

Adds PWM controller and keyboard backlight bindings for M1 MacBooks

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
Acked-by: Sven Peter <sven@svenpeter.dev>
---
 arch/arm64/boot/dts/apple/t8103-j293.dts | 19 +++++++++++++++++++
 arch/arm64/boot/dts/apple/t8103-j313.dts | 19 +++++++++++++++++++
 arch/arm64/boot/dts/apple/t8103.dtsi     |  9 +++++++++
 3 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103-j293.dts b/arch/arm64/boot/dts/apple/t8103-j293.dts
index ecb10d237a05..43f79570b458 100644
--- a/arch/arm64/boot/dts/apple/t8103-j293.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j293.dts
@@ -11,6 +11,7 @@
 
 #include "t8103.dtsi"
 #include "t8103-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
 
 / {
 	compatible = "apple,j293", "apple,t8103", "apple,arm-platform";
@@ -43,3 +44,21 @@ &i2c2 {
 &i2c4 {
 	status = "okay";
 };
+
+/ {
+	led-controller {
+		compatible = "pwm-leds";
+		led-0 {
+			pwms = <&fpwm1 0 40000>;
+			label = "kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			max-brightness = <255>;
+			default-state = "keep";
+		};
+	};
+};
+
+&fpwm1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8103-j313.dts b/arch/arm64/boot/dts/apple/t8103-j313.dts
index df741737b8e6..57e75e6ddf63 100644
--- a/arch/arm64/boot/dts/apple/t8103-j313.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j313.dts
@@ -11,6 +11,7 @@
 
 #include "t8103.dtsi"
 #include "t8103-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
 
 / {
 	compatible = "apple,j313", "apple,t8103", "apple,arm-platform";
@@ -35,3 +36,21 @@ &pcie0_dart_2 {
 
 /delete-node/ &port01;
 /delete-node/ &port02;
+
+/ {
+	led-controller {
+		compatible = "pwm-leds";
+		led-0 {
+			pwms = <&fpwm1 0 40000>;
+			label = "kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			max-brightness = <255>;
+			default-state = "keep";
+		};
+	};
+};
+
+&fpwm1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 51a63b29d404..ccdb26ef6b22 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -191,6 +191,15 @@ i2c4: i2c@235020000 {
 			status = "disabled"; /* only used in J293 */
 		};
 
+		fpwm1: pwm@235044000 {
+			compatible = "apple,t8103-fpwm", "apple,s5l-fpwm";
+			reg = <0x2 0x35044000 0x0 0x4000>;
+			power-domains = <&ps_fpwm1>;
+			clocks = <&clkref>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		serial0: serial@235200000 {
 			compatible = "apple,s5l-uart";
 			reg = <0x2 0x35200000 0x0 0x1000>;
-- 
2.37.1 (Apple Git-137.1)

