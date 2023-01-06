Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D296601B8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 15:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjAFOAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 09:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbjAFOAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 09:00:36 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1F077D14;
        Fri,  6 Jan 2023 06:00:35 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id ay2-20020a05600c1e0200b003d22e3e796dso1150750wmb.0;
        Fri, 06 Jan 2023 06:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PHp3o8QZ5KAEd3hXTm1YpH7fNbaNuTNn7S/5NjOZfjk=;
        b=HaugyF/ljCd+ZT+a7oplMrAc62W8m50iIxp+l8izfUUt7QcNLgTW7MafQqFcUGZahB
         rRYb21q81znIh67Bgfq81onyJ1jxtv82qK0qYn7V6KYaJMJ+vFlZBpEEeQEg2c5KALpU
         IF71udZv5xF8nuCHxeY5y8lisodBRTFY/glGr++N6m7JTB3VYSQ9OkhJU8fUOde6gC38
         Zk46WFBC49QyGx29A73QNfuNNk1clVtYOv1+9on6/S/v6QNHul4mm8GA0VAWl98wmBjw
         aO4DjqjT9rVxcBSl02je5/b129U2Hn9G0ZKhZgX32gDW3+9cIzx3rG5PGI9v94IOdvLa
         1/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PHp3o8QZ5KAEd3hXTm1YpH7fNbaNuTNn7S/5NjOZfjk=;
        b=depYc8tYM3NlXADbvcUV+TtYY1aAxENQxNXr1HmW+bEA7v6ItTEhIDZ/98lUPc15F4
         R0ORjYWxgedtjWEhnHrx1LM47uEpPPiWxHXueT2cVw/A1y1uQiN2wcZ2Dxq/qz7uWNRx
         dz5ARDuLVcNAoPS9lcmOQfIGPeEUoKnt81TSDCzWDDxqceGhMHBrer8QUAi4k4ytxhBk
         bHBaPXkgkIh6NqOJBFOuGCsVGwDY2vvgMio7YS9I+H15ZbUvRw6ILuI5jffR4hI3BNE/
         sH3cbre55fx6zZzAnlwBwzV8QjswTpGMLXS/ovQUaYg1yUBCIJV7+oYvEpZfRbA1eJxV
         yYGg==
X-Gm-Message-State: AFqh2kqaoyuM6bW+4b8FTIhbQ62+uSYvORUVzvXnx7umx0PMgypLv7ga
        Dhygw1D8AmBR9QGNT2gqnaY=
X-Google-Smtp-Source: AMrXdXtjG0BF2QnxbW/2QgclQNDmc7MjgEEz+VUROqGHCkOrB2l8GsnRy7csSk36p2sMuzeKifDJJg==
X-Received: by 2002:a05:600c:19c7:b0:3d9:7096:262a with SMTP id u7-20020a05600c19c700b003d97096262amr33455819wmq.27.1673013633927;
        Fri, 06 Jan 2023 06:00:33 -0800 (PST)
Received: from localhost ([212.253.112.114])
        by smtp.gmail.com with UTF8SMTPSA id n23-20020a05600c3b9700b003cf71b1f66csm2149876wms.0.2023.01.06.06.00.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 06:00:33 -0800 (PST)
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
To:     u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     marcan@marcan.st, sven@svenpeter.dev, alyssa@rosenzweig.io,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Subject: [PATCH v6 4/5] arm64: dts: apple: t600x: Add PWM controller
Date:   Fri,  6 Jan 2023 16:58:43 +0300
Message-Id: <20230106135839.18676-5-fnkl.kernel@gmail.com>
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

Adds PWM controller and keyboard backlight bindings for M1 Pro/Max MacBook Pros

Signed-off-by: Sasha Finkelstein <fnkl.kernel@gmail.com>
---
 arch/arm64/boot/dts/apple/t600x-die0.dtsi      |  9 +++++++++
 arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi | 18 ++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t600x-die0.dtsi b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
index 1c41954e3899..7065045dc43a 100644
--- a/arch/arm64/boot/dts/apple/t600x-die0.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-die0.dtsi
@@ -154,6 +154,15 @@ i2c5: i2c@39b054000 {
 		status = "disabled";
 	};
 
+	fpwm0: pwm@39b030000 {
+		compatible = "apple,t6000-fpwm", "apple,s5l-fpwm";
+		reg = <0x3 0x9b030000 0x0 0x4000>;
+		power-domains = <&ps_fpwm0>;
+		clocks = <&clkref>;
+		#pwm-cells = <2>;
+		status = "disabled";
+	};
+
 	serial0: serial@39b200000 {
 		compatible = "apple,s5l-uart";
 		reg = <0x3 0x9b200000 0x0 0x1000>;
diff --git a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
index 34906d522f0a..96de7165df6d 100644
--- a/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
+++ b/arch/arm64/boot/dts/apple/t600x-j314-j316.dtsi
@@ -9,6 +9,8 @@
  * Copyright The Asahi Linux Contributors
  */
 
+#include <dt-bindings/leds/common.h>
+
 / {
 	aliases {
 		serial0 = &serial0;
@@ -34,6 +36,18 @@ memory@10000000000 {
 		device_type = "memory";
 		reg = <0x100 0 0x2 0>; /* To be filled by loader */
 	};
+
+	led-controller {
+		compatible = "pwm-leds";
+		led-0 {
+			pwms = <&fpwm0 0 40000>;
+			label = "kbd_backlight";
+			function = LED_FUNCTION_KBD_BACKLIGHT;
+			color = <LED_COLOR_ID_WHITE>;
+			max-brightness = <255>;
+			default-state = "keep";
+		};
+	};
 };
 
 &serial0 {
@@ -110,5 +124,9 @@ &pcie0_dart_3 {
 	status = "disabled";
 };
 
+&fpwm0 {
+	status = "okay";
+};
+
 /delete-node/ &port02;
 /delete-node/ &port03;
-- 
2.37.1 (Apple Git-137.1)

