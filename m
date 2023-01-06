Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587DC6601B2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234785AbjAFOAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:00:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjAFOAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:00:17 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0897877D12;
        Fri,  6 Jan 2023 06:00:16 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so3603949wma.1;
        Fri, 06 Jan 2023 06:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3DSO2nFSdxMzrHJBYG74NM4oJgLnjp9dkanZv0gHOQ=;
        b=JIOlZ/Nx0g107umrYRbaqvobCR6S11fvHIgf4M1VeCTHgVTR5BO7ilFAatFWxVZAcH
         AbfDbThGcBs/JVtVcKOGYeZuOh5nljp+QtqvfAxbT1b53cmFqHw0FZXCUrj7ZXMd3pkj
         +OtHqOwPbIqn41qMeyKRHz6OUHhg1SMMsJDT93cFrvJ9k0XyNdWAai2ggqn8w64DFdLF
         oyIC4CKtrgH6PGhuZdXIZ2BaznuO0YtNTK0U6jU7IamLf50aNUWaVD5Zn9To2h/qhr9t
         1eN44rEm+GOh24KU9enUB2P+oz+iv8mDFGt8Mf1O8X6V2SKvv4hpazG0olnZGbEmG9Ap
         NJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K3DSO2nFSdxMzrHJBYG74NM4oJgLnjp9dkanZv0gHOQ=;
        b=MfDB7LzqV1rTn8Rw3l3S0WwDS+rF4YRGvRcXdc2/pbAn7ADv5hMZ15I9T3eWnpjqHQ
         GdaLFk+ync2vyBVJyJyMDYrvrQtB306r72U8LUDlWO2XMYQsTqCDxKCA7m6I/9U4nE7M
         h18umfNc4Umb6HodAjvL+4HBQ9jAdJirs/AKJdK/JcJWc3454fk9oouqs8pgXkbb8I+u
         LvUDBuEUopBVXU6MvheUGJI3CPN+WM7ea5gaL6d9cyo1SO0DZu5wNv2TVVGMZID86TDx
         ziewc+UeYXnJPsC2r66OREvEorK7fTQ3PHIN32KSStoaKG7S+ZfPdCmIm+uM/cOdCIPG
         dYYw==
X-Gm-Message-State: AFqh2kokeHCgoYFoHGdrzvCSVxJMfzfpE8h8qWuyfZsAbMZEhS2FnnGD
        rDqScczH7OXs/loFXIESi94=
X-Google-Smtp-Source: AMrXdXsYq4D+WnUsWLyK0xKopnwsG6pFgkxKUMrZEJ6/pn3r8RHOzSWaRJYnqCuDU7F1PH/2JWFV3w==
X-Received: by 2002:a05:600c:3b0a:b0:3d9:91cb:bbff with SMTP id m10-20020a05600c3b0a00b003d991cbbbffmr24761921wms.26.1673013614525;
        Fri, 06 Jan 2023 06:00:14 -0800 (PST)
Received: from localhost ([212.253.112.114])
        by smtp.gmail.com with UTF8SMTPSA id r5-20020a05600c35c500b003d98f92692fsm2102274wmq.17.2023.01.06.06.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 06:00:14 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v6 3/5] arm64: dts: apple: t8103: Add PWM controller
Date:   Fri,  6 Jan 2023 16:58:41 +0300
Message-Id: <20230106135839.18676-4-fnkl.kernel@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230106135839.18676-1-fnkl.kernel@gmail.com>
References: <20230106135839.18676-1-fnkl.kernel@gmail.com>
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
 arch/arm64/boot/dts/apple/t8103-j293.dts | 17 +++++++++++++++++
 arch/arm64/boot/dts/apple/t8103-j313.dts | 17 +++++++++++++++++
 arch/arm64/boot/dts/apple/t8103.dtsi     |  9 +++++++++
 3 files changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103-j293.dts b/arch/arm64/boot/dts/apple/t8103-j293.dts
index 151074109a11..7381dccc1613 100644
--- a/arch/arm64/boot/dts/apple/t8103-j293.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j293.dts
@@ -11,10 +11,23 @@
 
 #include "t8103.dtsi"
 #include "t8103-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
 
 / {
 	compatible = "apple,j293", "apple,t8103", "apple,arm-platform";
 	model = "Apple MacBook Pro (13-inch, M1, 2020)";
+
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
 };
 
 &bluetooth0 {
@@ -47,3 +60,7 @@ &i2c2 {
 &i2c4 {
 	status = "okay";
 };
+
+&fpwm1 {
+	status = "okay";
+};
\ No newline at end of file
diff --git a/arch/arm64/boot/dts/apple/t8103-j313.dts b/arch/arm64/boot/dts/apple/t8103-j313.dts
index bc1f865aa790..1e26aa1ef525 100644
--- a/arch/arm64/boot/dts/apple/t8103-j313.dts
+++ b/arch/arm64/boot/dts/apple/t8103-j313.dts
@@ -11,10 +11,23 @@
 
 #include "t8103.dtsi"
 #include "t8103-jxxx.dtsi"
+#include <dt-bindings/leds/common.h>
 
 / {
 	compatible = "apple,j313", "apple,t8103", "apple,arm-platform";
 	model = "Apple MacBook Air (M1, 2020)";
+
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
 };
 
 &bluetooth0 {
@@ -39,3 +52,7 @@ &pcie0_dart_2 {
 
 /delete-node/ &port01;
 /delete-node/ &port02;
+
+&fpwm1 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 9859219699f4..5300fd115561 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -432,6 +432,15 @@ i2c4: i2c@235020000 {
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

