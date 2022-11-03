Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CD9618C00
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiKCWse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiKCWrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:47:48 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA9D22B36;
        Thu,  3 Nov 2022 15:47:41 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y203so2973882pfb.4;
        Thu, 03 Nov 2022 15:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHI/xFFeRzT7bXVgR68Vv5jAb3+4xiWk2TAa6nZk8uQ=;
        b=eppigY3FRRZ3Lly4WKWIBCFVErzxsv3x8EkO0KDL4qt2E/diahaGWERtT7didkD+CG
         TZPc/ziS9I2b7iH5Pvu4BJkNrPwWIF7dXG/86rw1brIaCYPghtLih1ntPRL4hhHTNuYW
         3Y6//YHbytiqnYWXT/ohneN3zEFFfuiwUW+3XdihDsNDvdjuOwC9/oZFIwSGMa1WM58y
         NDmtx0uPUijW6FtZIs8O91CmT3lAGeVw35tl5IeMd7dCKxIJ8drcZyYimIB5Ck9euXch
         dLI11KvAo3anSm6mfYPmY+h2HnHM0SjpXmOwErxwI3gOl+II0lzcC5J7RExenogIY13x
         ujbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHI/xFFeRzT7bXVgR68Vv5jAb3+4xiWk2TAa6nZk8uQ=;
        b=itEYAyPuR7NhD9eg0y2z6LSuMOy5v7YYmssMjzLfwS04tGLKX/xGLLbv91/9Sw+7mL
         l0R4VuTRwq9t/3IsEq0COLqBa5ZWfVCOy0YjZjnh+/tU1Y30cnIy4aQTfyHvrr0ZcQJ4
         1riKFtGi7K5j2mg6GbeTKKpnT41qoNG63WnJ8ES+0skLHWIg3nlr7ztxxtgt4vf6sLB2
         UYV5gUAMUhu/aBehMcSy1KJytYNBlyFUmVduLzec8h5DZt3uLcsASoe+nyIfh1GKAP0f
         ZqCQEqocTSaLWPpOgxxoMj7LztjyjztuCDUh1FOfpuINHktixwsIScMYB/aE+prh3/za
         5ppg==
X-Gm-Message-State: ACrzQf22btObhz2OreNsqFzVNnocZSUM7b3+Ks3IFyCaYhzRB14qZQrI
        J6fLuznpDAdZPJ2o9dDMdcg=
X-Google-Smtp-Source: AMsMyM42Q0EmJ+IW4zT5DYgA9bNOc0NIWiT20qXiQOIV2th7Vm2X69HmpGZhb42qJt/yJUB5gpSlaw==
X-Received: by 2002:a63:d202:0:b0:46f:930:ea56 with SMTP id a2-20020a63d202000000b0046f0930ea56mr28743512pgg.275.1667515660559;
        Thu, 03 Nov 2022 15:47:40 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id g13-20020aa796ad000000b0056be1d7d4a3sm1280421pfk.73.2022.11.03.15.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:47:39 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 11/13] omapfb: panel-lgphilips-lb035q02: remove backlight GPIO handling
Date:   Thu,  3 Nov 2022 15:46:54 -0700
Message-Id: <20221103-omapfb-gpiod-v1-11-c3d53ca7988f@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221103-omapfb-gpiod-v1-0-c3d53ca7988f@gmail.com>
References: <20221103-omapfb-gpiod-v1-0-c3d53ca7988f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.11.0-dev-5166b
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
b4 0.11.0-dev-5166b
