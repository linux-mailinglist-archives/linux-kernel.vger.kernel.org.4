Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6708709EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbjESSJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjESSJ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:09:28 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63C5139;
        Fri, 19 May 2023 11:09:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-510d92184faso5472452a12.1;
        Fri, 19 May 2023 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684519766; x=1687111766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+d7PbSuYoLaRDWMlMC+jLFLlA199/veHtp6NNGsVDoc=;
        b=gcQTbnmDPp2/Gb2su0qH27Cgs0F2g1Thm8mh9FNIKJm0oVuWfADVDmYW4S0L/BK8+o
         a3kVhiDBd4o54uoRD7sp0IrRDfs3pfeg/SNyFKjAdblu6Ht4gb3IPvd2GMeO02U3gysx
         B7ZE8QxzdS0Mec6P1B8zNcr+Fh8yiAoPQMJ1yYGqpUy19Wptg2PvOGX2y5mQt8Mll+aR
         XBvSXRbCkp/SVV6ti/QWRr4WHfxvz+fdSWMLN02t2+823/rE6XWCLu1ag1HeoW4jVgbG
         K7Ko9Ct/ypYjQZOP7mkZyEVgV59MYRy59bdLdpyRUEOObSce6eGRgyKDjmZ4RQQPTpu7
         qUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684519766; x=1687111766;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+d7PbSuYoLaRDWMlMC+jLFLlA199/veHtp6NNGsVDoc=;
        b=eeoqfylw8CzuKL1DH1bAeMkn+B26pZs0ir+Xa67awYwE+5jZjx8ScDyR6aLQIIyZB1
         omcDliZjQHw5ZTa/xQpSqJYFvnLRGgGl54SJ0/WnTzeQO0aoebI/TIvSz/nIG//dfA3N
         Z4ZC3SsVAIUYwwGPqJKL4ldWlS/arWWA7S3PyO9uqdM0jAp7/jwkUqU+AwNIwZdW2GXY
         odrwLB7G2xLPnxhS38fe8iI2Qco6e47ZIJkUEcB5dsHRrm5LpSAM7eLuENtDIGJcKrjG
         dwMSAUMg662e6n6ECyNU/CdJvLAkAU0IJ8/63HVvLw08/7aKJXp9c5/vKHSYYMzxkXl7
         qepQ==
X-Gm-Message-State: AC+VfDzb16rr3wHpFVtbkwiYShZS8q+PxvqA2IQM+dUCpWBMmMGB5eeO
        oj9id/grdh644x6XV9VXaOY=
X-Google-Smtp-Source: ACHHUZ7rLnbizAEqYNWScE2PGJGpJKPdJtBcR0QqvyY0pfJthrs/TixsUA/eAKRegeklwChoSIzfNw==
X-Received: by 2002:aa7:d8d8:0:b0:50d:bb87:247c with SMTP id k24-20020aa7d8d8000000b0050dbb87247cmr2359065eds.1.1684519765877;
        Fri, 19 May 2023 11:09:25 -0700 (PDT)
Received: from localhost.my.domain (83.11.222.198.ipv4.supernova.orange.pl. [83.11.222.198])
        by smtp.gmail.com with ESMTPSA id g26-20020aa7c85a000000b0050690bc07a3sm19824edt.18.2023.05.19.11.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 11:09:25 -0700 (PDT)
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
        <u.kleine-koenig@pengutronix.de>, Luca Weiss <luca@z3ntu.xyz>,
        Artur Weber <aweber.kernel@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-pwm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 3/4] ARM: dts: adapt to LP855X bindings changes
Date:   Fri, 19 May 2023 20:07:27 +0200
Message-Id: <20230519180728.2281-4-aweber.kernel@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519180728.2281-1-aweber.kernel@gmail.com>
References: <20230519180728.2281-1-aweber.kernel@gmail.com>
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
Reviewed-by: Luca Weiss <luca@z3ntu.xyz>
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

