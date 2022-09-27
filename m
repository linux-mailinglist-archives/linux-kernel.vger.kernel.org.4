Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6F05ED04E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 00:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiI0Wcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 18:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiI0Wck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 18:32:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E921EAD44
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 15:32:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id u92so1483546pjh.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 15:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=OD3lRvHWHynetpK03lKY+/32dF/WZQ/VUdDZ7v9K1aU=;
        b=qHLAts6EtKsbT1NsEoXQ+C6PXpkur/IifdB2C1dP2lvlMXrdmTJvj+9BfrMmfuz2X/
         JP+PUUsNNL5DWrBiqsYOEL2Ti/JQQR4qjYD0WleD/sCWgswPigU5aWdOBXS/miMdU3GP
         +APoP5q5fFdSP+aEYBLQaQVwauYWDB+I5p5BIpJemozBvyZVYtDRgiAJ0m2nrgI6XoeF
         rnxC4MP6hZoevbHVASu3X4+S9z6rS8IBPff16fY08Wi2+ZJVpQg3mbvlE6S8LUdaAX2D
         RfpHJVVZXZhOuxKT38m3MtHfgrzbZMk32LPqjSLn1IvqKOtAJPRYP1ofI8l9wEaz7TeC
         Tegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OD3lRvHWHynetpK03lKY+/32dF/WZQ/VUdDZ7v9K1aU=;
        b=BrgDt5fFGFtwJiERvRJt7EbXbwJB3RUWVfCKfdj0Y26NHEX/5o1apcFJf27NHFNqXR
         OUhtibdRz5kNNY8wYVShIavQ/2yewBTpLSou5FYYH5JmKM3bLxN/4NL9s7R8T8lgYsGS
         soh/JuTORS4C3FdNm7crQt8m3PsOYngVV0IBfly5hc85Qle17Zkjn+TG80B2kDmzvRrU
         RitIOWBSk+XpfipwiurXTx+s4nsGAGE5k8v75rAmmf9lbmy4wXhZpp1XRPV4EclHjs9g
         OGQN4TYpcbw/4EQFGpyWZ/ocISXiHrVz0CQ7/dEt5TpIi7xTqpZ4gITx8bAdy9PmzvnE
         xcwA==
X-Gm-Message-State: ACrzQf3dtKeTvvQs+0cSOrKe6yVK/IxNMtBeqF+J3zKv9lQbZIqmkCY+
        l2/nw1/M+4WU56eV4wDGZrU=
X-Google-Smtp-Source: AMsMyM5uGsQ8+A2UIJ1XijHFjRn43rd3Ae+Rg1wRk+/9JNpz6h4yl9fgE3o29ceHx+6KMiTaNPHtpw==
X-Received: by 2002:a17:90b:1b4c:b0:202:c05f:6e7b with SMTP id nv12-20020a17090b1b4c00b00202c05f6e7bmr6807078pjb.200.1664317958845;
        Tue, 27 Sep 2022 15:32:38 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902d2d100b00176a47e5840sm2090195plc.298.2022.09.27.15.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 15:32:38 -0700 (PDT)
Date:   Tue, 27 Sep 2022 15:32:35 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [RFC/PATCH] backlight: hx8357: prepare to conversion to gpiod API
Message-ID: <YzN6A9Y20Ea1LdEz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properties describing GPIOs should be named as "<property>-gpios" or
"<property>-gpio", and that is what gpiod API expects, however the
driver uses non-standard "gpios-reset" name. Let's adjust this, and also
note that the reset line is active low as that is also important to
gpiod API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Another option is to add another quirk into gpiolib-of.c, but we
may end up with a ton of them once we convert everything away from
of_get_named_gpio() to gpiod API, so I'd prefer not doing that.

 arch/arm/boot/dts/imx28-cfa10049.dts | 7 +++++--
 arch/arm/boot/dts/imx28-cfa10055.dts | 3 ++-
 arch/arm/boot/dts/imx28-cfa10056.dts | 3 ++-
 drivers/video/backlight/hx8357.c     | 2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index 9ef0d567ea48..ae51a2aa2028 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -3,6 +3,7 @@
  * Copyright 2012 Free Electrons
  */
 
+#include <dt-bindings/gpio/gpio.h>
 /*
  * The CFA-10049 is an expansion board for the CFA-10036 module, thus we
  * need to include the CFA-10036 DTS.
@@ -346,8 +347,10 @@ hx8357: hx8357@0 {
 			spi-max-frequency = <100000>;
 			spi-cpol;
 			spi-cpha;
-			gpios-reset = <&gpio3 30 0>;
-			im-gpios = <&gpio5 4 0 &gpio5 5 0 &gpio5 6 0>;
+			reset-gpios = <&gpio3 30 GPIO_ACTIVE_LOW>;
+			im-gpios = <&gpio5 4 GPIO_ACTIVE_HIGH
+				    &gpio5 5 GPIO_ACTIVE_HIGH
+				    &gpio5 6 GPIO_ACTIVE_HIGH>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx28-cfa10055.dts b/arch/arm/boot/dts/imx28-cfa10055.dts
index fac5bbda7a93..70e4dc67f7d2 100644
--- a/arch/arm/boot/dts/imx28-cfa10055.dts
+++ b/arch/arm/boot/dts/imx28-cfa10055.dts
@@ -4,6 +4,7 @@
  * 				  Free Electrons
  */
 
+#include <dt-bindings/gpio/gpio.h>
 /*
  * The CFA-10055 is an expansion board for the CFA-10036 module and
  * CFA-10037, thus we need to include the CFA-10037 DTS.
@@ -148,7 +149,7 @@ hx8357: hx8357@0 {
 			spi-max-frequency = <100000>;
 			spi-cpol;
 			spi-cpha;
-			gpios-reset = <&gpio3 30 0>;
+			reset-gpios = <&gpio3 30 GPIO_ACTIVE_LOW>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx28-cfa10056.dts b/arch/arm/boot/dts/imx28-cfa10056.dts
index c5f3337e8b39..687eaa555a15 100644
--- a/arch/arm/boot/dts/imx28-cfa10056.dts
+++ b/arch/arm/boot/dts/imx28-cfa10056.dts
@@ -3,6 +3,7 @@
  * Copyright 2013 Free Electrons
  */
 
+#include <dt-bindings/gpio/gpio.h>
 /*
  * The CFA-10055 is an expansion board for the CFA-10036 module and
  * CFA-10037, thus we need to include the CFA-10037 DTS.
@@ -107,7 +108,7 @@ hx8369: hx8369@0 {
 			spi-max-frequency = <100000>;
 			spi-cpol;
 			spi-cpha;
-			gpios-reset = <&gpio3 30 0>;
+			reset-gpios = <&gpio3 30 GPIO_ACTIVE_LOW>;
 		};
 	};
 };
diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index 9b50bc96e00f..41332f48b2df 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -601,7 +601,7 @@ static int hx8357_probe(struct spi_device *spi)
 	if (!match || !match->data)
 		return -EINVAL;
 
-	lcd->reset = of_get_named_gpio(spi->dev.of_node, "gpios-reset", 0);
+	lcd->reset = of_get_named_gpio(spi->dev.of_node, "reset-gpios", 0);
 	if (!gpio_is_valid(lcd->reset)) {
 		dev_err(&spi->dev, "Missing dt property: gpios-reset\n");
 		return -EINVAL;
-- 
2.38.0.rc1.362.ged0d419d3c-goog


-- 
Dmitry
