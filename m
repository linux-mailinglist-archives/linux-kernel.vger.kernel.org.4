Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0993618ED1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiKDDS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiKDDRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:17:34 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327C22610C;
        Thu,  3 Nov 2022 20:17:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u6so3717140plq.12;
        Thu, 03 Nov 2022 20:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BM/ZgUkpWv+s7vwzn/eT6S3wXaI2KYDcFcJls+ba05w=;
        b=HsxPuUdQwSnFQ64iRXaUt75qhUeJUOAmxgZvyMl3cSVcnxcHQPOh4HffyPqWb8e5n9
         7xil5xom0quAf5cGKdYEDu1NxOHsppOF4OtKd9AkfJKAI+XTs3vAt9mEooP1dZJiz1EF
         QwNspeCRYO4R86HE44lD4ny/BGwZD2Yim4jffZ1JIQe0L33LaV4b/a4F5lqcPkqN82AH
         3WQvRgiNhXMmaasIawBbU2JmGhhGh26ct44UwZHlVAT2YGn/nCBYVz/tjKzMEj7K+T0e
         AKFsPIG7jB7vT2gBjhmEyu/xOhePc/jJmprnoRbsoiRoBNBrHCKunpkkKAg5BVMq3/hE
         mbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BM/ZgUkpWv+s7vwzn/eT6S3wXaI2KYDcFcJls+ba05w=;
        b=jhI1KPRu9YO+bSw+lXsLZlHYj6+znbkXKmX8Luq6num/o/SyS12ykz6iFbUAJgh3ag
         bAucdoGuLunSbBTtw6pE8xIaOuSqQzu+ICFXOxDNHwTiUS+owG2C7nMHD+s2Rfy5hIGc
         zT292pCQ0F3GrikHvEyb6jUCqveZ9WVSBmbX0aMHjX7uzU0ddLlXcbZnTq0FV8gaJihy
         rGXEY8TcbcKGfvf3oHEuMCzIeRZJPV/F7rdHjyOhwcGzrTM3fqYD/9Dq8DliQm13NKbG
         BlhjmVEZxuZ7MkA0X3AMu5UizN/IxBYX+kYURnAWhMg5CwMRgS46VRuh20c3KfmKNltl
         J+sg==
X-Gm-Message-State: ACrzQf1ffMtqtkTo2lVtsz4BGMzuToTjpzbNRA0cC3eFQrMRIK2vWoG4
        72UMg+k8MV7iCnOSR98ALzs=
X-Google-Smtp-Source: AMsMyM6VLQ54CW2tu0iKULrkzQCWmsEnj5G7SB7ozCUYWTrPKrSsyNNhp3eu/M0HRnEgAa85rKqfCg==
X-Received: by 2002:a17:902:c14d:b0:187:337b:ad9c with SMTP id 13-20020a170902c14d00b00187337bad9cmr18884743plj.35.1667531826511;
        Thu, 03 Nov 2022 20:17:06 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id s3-20020a63ff43000000b004702eca61fcsm1078655pgk.36.2022.11.03.20.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:17:05 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH RESEND 11/13] omapfb: panel-lgphilips-lb035q02: remove backlight GPIO handling
Date:   Thu,  3 Nov 2022 20:16:40 -0700
Message-Id: <20221103-omapfb-gpiod-v1-11-cba1fae5a77c@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103-omapfb-gpiod-v1-0-cba1fae5a77c@gmail.com>
References: <20221103-omapfb-gpiod-v1-0-cba1fae5a77c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-28747
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

With f048e8c1d169 ("omapfb: panel-lgphilips-lb035q02: Remove legacy boot
support") it is no longer possible to specify GPIO to control the
backlight. Remove code trying to request and toggle it.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../omapfb/displays/panel-lgphilips-lb035q02.c      | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c
index 3ce1f9d2e7c4..e69856cb62d5 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c
@@ -11,7 +11,7 @@
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/mutex.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 
 #include <video/omapfb_dss.h>
 
@@ -46,9 +46,6 @@ struct panel_drv_data {
 
 	struct omap_video_timings videomode;
 
-	/* used for non-DT boot, to be removed */
-	int backlight_gpio;
-
 	struct gpio_desc *enable_gpio;
 };
 
@@ -166,9 +163,6 @@ static int lb035q02_enable(struct omap_dss_device *dssdev)
 	if (ddata->enable_gpio)
 		gpiod_set_value_cansleep(ddata->enable_gpio, 1);
 
-	if (gpio_is_valid(ddata->backlight_gpio))
-		gpio_set_value_cansleep(ddata->backlight_gpio, 1);
-
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
 	return 0;
@@ -185,9 +179,6 @@ static void lb035q02_disable(struct omap_dss_device *dssdev)
 	if (ddata->enable_gpio)
 		gpiod_set_value_cansleep(ddata->enable_gpio, 0);
 
-	if (gpio_is_valid(ddata->backlight_gpio))
-		gpio_set_value_cansleep(ddata->backlight_gpio, 0);
-
 	in->ops.dpi->disable(in);
 
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
@@ -250,8 +241,6 @@ static int lb035q02_probe_of(struct spi_device *spi)
 
 	ddata->enable_gpio = gpio;
 
-	ddata->backlight_gpio = -ENOENT;
-
 	in = omapdss_of_find_source_for_first_ep(node);
 	if (IS_ERR(in)) {
 		dev_err(&spi->dev, "failed to find video source\n");
@@ -284,13 +273,6 @@ static int lb035q02_panel_spi_probe(struct spi_device *spi)
 	if (r)
 		return r;
 
-	if (gpio_is_valid(ddata->backlight_gpio)) {
-		r = devm_gpio_request_one(&spi->dev, ddata->backlight_gpio,
-				GPIOF_OUT_INIT_LOW, "panel backlight");
-		if (r)
-			goto err_gpio;
-	}
-
 	ddata->videomode = lb035q02_timings;
 
 	dssdev = &ddata->dssdev;
@@ -310,7 +292,6 @@ static int lb035q02_panel_spi_probe(struct spi_device *spi)
 	return 0;
 
 err_reg:
-err_gpio:
 	omap_dss_put_device(ddata->in);
 	return r;
 }

-- 
b4 0.11.0-dev-28747
