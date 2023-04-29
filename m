Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A256F244A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 12:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjD2KqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 06:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjD2KqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 06:46:02 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B941FCD;
        Sat, 29 Apr 2023 03:46:00 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-506b8c6bbdbso931609a12.1;
        Sat, 29 Apr 2023 03:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682765159; x=1685357159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8i7rGQnK06oWrox/+/zsH6gyQIWGdw1cmoWrKvTJu0=;
        b=ECTA/9/pB1Aymto+vgPPXAGx2Mz0xzcGbhYKDM/Gj4N5GH35j+EKmQ8cCYBB1SNBVd
         18dQAyC2YsDgi6+QKqbkaRKmbSblqWh5Al5G8D/u/avdbAT3sNcuEMdFmDlM31xUNICY
         E3FWlj6q6uOLAGoRxrMoPhAIgbPtHD5eZAEdMjprP7RCioYDXy21t5m+I8hQ8WDOG+G+
         FG8M58072bKX0imFso5nTX2CJSx4fRE0DSZpDybJwN04wikukos70njeZhL1AzT3vg2A
         3Tg59bfjkpu/qjBOjiYo7B6oYwp9HjGSyhPgLH4Iz0MEdgGrfO+b2P2QYjbtVpRBj1iP
         1qFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682765159; x=1685357159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8i7rGQnK06oWrox/+/zsH6gyQIWGdw1cmoWrKvTJu0=;
        b=HmIa5487L2ZYBUvG28PReN9JNaMVPwoX58ua+QeYKmrJALwcxrqJJkQVkzdSPFvFQF
         //ubrsiJiGhvNMqWkfScoecSIwQLCGcWSsEX9s4rYkU5078h1utjQ5cEKzTVb0TuM0Hp
         M4P/Pz50PbllJZNLrsEjHZofIUH6xBvXIGtE3imR1AYfKPx70GernMkCCezbgYnQQYAs
         LvvFZu1OrWc+7Q3PlxMCTFTac+QI+N1sgQlrmnppGD9Emzf+k2XdSsEGDuhd5n7gkGhb
         FS060nsFE2+dCaRUrqU476XMc1+/vNqDUPBC82u8kAXzidn+24lhVrL4MVQkEvXvq/Po
         u6aw==
X-Gm-Message-State: AC+VfDwcu2c5bkT5Cw8HDgUAcR6qf3GN2EiAf2ps+M7i55UvzSlF9/O/
        LfuIh70vkRUoTBgx+l6/SmQ=
X-Google-Smtp-Source: ACHHUZ7QTqQ3HOeexrhn9fW09EilRSCgystsEJS6enNJ6B7Rh0+1wWmP0iMty5BrTXpQ46zowvgyGg==
X-Received: by 2002:a50:ef1a:0:b0:502:233e:af49 with SMTP id m26-20020a50ef1a000000b00502233eaf49mr1253772eds.4.1682765159016;
        Sat, 29 Apr 2023 03:45:59 -0700 (PDT)
Received: from localhost.my.domain (83.8.115.30.ipv4.supernova.orange.pl. [83.8.115.30])
        by smtp.gmail.com with ESMTPSA id b11-20020a056402138b00b004bd6e3ed196sm9952522edv.86.2023.04.29.03.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Apr 2023 03:45:58 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Helge Deller <deller@gmx.de>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Artur Weber <aweber.kernel@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 3/4] ARM: dts: adapt to LP855X bindings changes
Date:   Sat, 29 Apr 2023 12:45:33 +0200
Message-Id: <20230429104534.28943-4-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230429104534.28943-1-aweber.kernel@gmail.com>
References: <20230429104534.28943-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change underscores in ROM node names to dashes, and remove deprecated
pwm-period property.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts |  1 -
 ...-msm8974pro-sony-xperia-shinano-castor.dts | 23 ++++++++++---------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
index 91b860e24681..884d99297d4c 100644
--- a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
@@ -99,7 +99,6 @@ backlight@2c {
 
 			dev-ctrl = /bits/ 8 <0x80>;
 			init-brt = /bits/ 8 <0x3f>;
-			pwm-period = <100000>;
 
 			pwms = <&backlight_pwm 0 100000>;
 			pwm-names = "lp8556";
diff --git a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
index 04bc58d87abf..2396253f953a 100644
--- a/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
+++ b/arch/arm/boot/dts/qcom-msm8974pro-sony-xperia-shinano-castor.dts
@@ -150,47 +150,48 @@ lp8566_wled: backlight@2c {
 		bl-name = "backlight";
 		dev-ctrl = /bits/ 8 <0x05>;
 		init-brt = /bits/ 8 <0x3f>;
-		rom_a0h {
+
+		rom-a0h {
 			rom-addr = /bits/ 8 <0xa0>;
 			rom-val = /bits/ 8 <0xff>;
 		};
-		rom_a1h {
+		rom-a1h {
 			rom-addr = /bits/ 8 <0xa1>;
 			rom-val = /bits/ 8 <0x3f>;
 		};
-		rom_a2h {
+		rom-a2h {
 			rom-addr = /bits/ 8 <0xa2>;
 			rom-val = /bits/ 8 <0x20>;
 		};
-		rom_a3h {
+		rom-a3h {
 			rom-addr = /bits/ 8 <0xa3>;
 			rom-val = /bits/ 8 <0x5e>;
 		};
-		rom_a4h {
+		rom-a4h {
 			rom-addr = /bits/ 8 <0xa4>;
 			rom-val = /bits/ 8 <0x02>;
 		};
-		rom_a5h {
+		rom-a5h {
 			rom-addr = /bits/ 8 <0xa5>;
 			rom-val = /bits/ 8 <0x04>;
 		};
-		rom_a6h {
+		rom-a6h {
 			rom-addr = /bits/ 8 <0xa6>;
 			rom-val = /bits/ 8 <0x80>;
 		};
-		rom_a7h {
+		rom-a7h {
 			rom-addr = /bits/ 8 <0xa7>;
 			rom-val = /bits/ 8 <0xf7>;
 		};
-		rom_a9h {
+		rom-a9h {
 			rom-addr = /bits/ 8 <0xa9>;
 			rom-val = /bits/ 8 <0x80>;
 		};
-		rom_aah {
+		rom-aah {
 			rom-addr = /bits/ 8 <0xaa>;
 			rom-val = /bits/ 8 <0x0f>;
 		};
-		rom_aeh {
+		rom-aeh {
 			rom-addr = /bits/ 8 <0xae>;
 			rom-val = /bits/ 8 <0x0f>;
 		};
-- 
2.40.1

