Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DDA618BD4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbiKCWrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiKCWrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:47:12 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131C320BED;
        Thu,  3 Nov 2022 15:47:10 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o7so3022074pjj.1;
        Thu, 03 Nov 2022 15:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3H968a3kOAexewQRFDUs1wm0MYnfXOPTZ0bRBglYYY=;
        b=FQA5EeiFlAqWxAct5Uxsj1qH07RB6GGA2Q7rr8QNJIeHli213BXWMKcy+fxU0y0pJ7
         wpQOp7TEXMk9euGyBKI8vdPTkeyWLX+O2NbYtaKOjMP/bZt0I9yAkeKMp3/pghJVeTuX
         J1VhyRW/SmYfeg+4aNznKck6Vv9ntl2OxBPikjfpPg2WfyqW6kk7hbrpVuKft8hsMdjy
         CBw52dcyNoQyo/+cziEsxgm8c9FvAr4YBnSuBumatxFGvkmRXVu68taCy7eYUQ6nMvC8
         p/dIKD1CEsWFR12HOyEKD51fmWtCvfxKzCqitufb+vRo5MQsInXfv4HDaSoyp1AsDfby
         Fbyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3H968a3kOAexewQRFDUs1wm0MYnfXOPTZ0bRBglYYY=;
        b=yxIncCb/VzvCw/6bcmh3DgBw7gnRIIjxUYsQiNJ0dmZw04uD8pFzLv+/14Mt+naB+W
         JkZkCKkXGJcVjg0O9vMh+TbdpxXdfBA5y3nKpxP9hVljN3veefEj+hiMOn0B5XYpyXY3
         KaNX3FhmFNUyY6JhD4MnDO0BdOsgEOsu6YS++8Sf7acX0ucY8vLmPdszpURJ6jt+0uMC
         M6ARyOu97gzjUTfhBslU5GUDTvxHg5QMmXkEawMdQJU+neh3dY/BPD9aj9XpmxR+lh5m
         JfOAWwE9ouM5bV/ACyGbusMZlAbxzr33ZxQVNouZjifk+sJjgykqKRYEOeljRKFl+PF/
         ILIw==
X-Gm-Message-State: ACrzQf0NXS5Mhu7V93vgqnxR4lZmBVX5VZjHg6hTO7rOYkTcgqQvs0g9
        cvTRurdk4ns24Prh1XXdlpc=
X-Google-Smtp-Source: AMsMyM5JjUsssrOSbv9S1ENHH+o31vR3x/luN6lPjE6ImL2y15T2xSjR878+yLJwYqM4PgRRK/BqAQ==
X-Received: by 2002:a17:902:8a90:b0:186:b145:f5ec with SMTP id p16-20020a1709028a9000b00186b145f5ecmr32881653plo.103.1667515629418;
        Thu, 03 Nov 2022 15:47:09 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id g13-20020aa796ad000000b0056be1d7d4a3sm1280421pfk.73.2022.11.03.15.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:47:08 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 02/13] omapfb: panel-sony-acx565akm: remove support for platform data
Date:   Thu,  3 Nov 2022 15:46:39 -0700
Message-Id: <20221103-omapfb-gpiod-v1-2-c3d53ca7988f@gmail.com>
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

There are no users of panel_acx565akm_platform_data in the mainline
kernel so support for it can be removed from the panel driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../omap2/omapfb/displays/panel-sony-acx565akm.c   | 45 +++-------------------
 include/video/omap-panel-data.h                    | 16 --------
 2 files changed, 6 insertions(+), 55 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
index c0965bee12c5..0c81d3ff4197 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
@@ -23,7 +23,6 @@
 #include <linux/of_gpio.h>
 
 #include <video/omapfb_dss.h>
-#include <video/omap-panel-data.h>
 
 #define MIPID_CMD_READ_DISP_ID		0x04
 #define MIPID_CMD_READ_RED		0x06
@@ -688,32 +687,6 @@ static struct omap_dss_driver acx565akm_ops = {
 	.get_resolution	= omapdss_default_get_resolution,
 };
 
-static int acx565akm_probe_pdata(struct spi_device *spi)
-{
-	const struct panel_acx565akm_platform_data *pdata;
-	struct panel_drv_data *ddata = dev_get_drvdata(&spi->dev);
-	struct omap_dss_device *dssdev, *in;
-
-	pdata = dev_get_platdata(&spi->dev);
-
-	ddata->reset_gpio = pdata->reset_gpio;
-
-	in = omap_dss_find_output(pdata->source);
-	if (in == NULL) {
-		dev_err(&spi->dev, "failed to find video source '%s'\n",
-				pdata->source);
-		return -EPROBE_DEFER;
-	}
-	ddata->in = in;
-
-	ddata->datapairs = pdata->datapairs;
-
-	dssdev = &ddata->dssdev;
-	dssdev->name = pdata->name;
-
-	return 0;
-}
-
 static int acx565akm_probe_of(struct spi_device *spi)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&spi->dev);
@@ -741,6 +714,9 @@ static int acx565akm_probe(struct spi_device *spi)
 
 	dev_dbg(&spi->dev, "%s\n", __func__);
 
+	if (!spi->dev.of_node)
+		return -ENODEV;
+
 	spi->mode = SPI_MODE_3;
 
 	ddata = devm_kzalloc(&spi->dev, sizeof(*ddata), GFP_KERNEL);
@@ -753,18 +729,9 @@ static int acx565akm_probe(struct spi_device *spi)
 
 	mutex_init(&ddata->mutex);
 
-	if (dev_get_platdata(&spi->dev)) {
-		r = acx565akm_probe_pdata(spi);
-		if (r)
-			return r;
-	} else if (spi->dev.of_node) {
-		r = acx565akm_probe_of(spi);
-		if (r)
-			return r;
-	} else {
-		dev_err(&spi->dev, "platform data missing!\n");
-		return -ENODEV;
-	}
+	r = acx565akm_probe_of(spi);
+	if (r)
+		return r;
 
 	if (gpio_is_valid(ddata->reset_gpio)) {
 		r = devm_gpio_request_one(&spi->dev, ddata->reset_gpio,
diff --git a/include/video/omap-panel-data.h b/include/video/omap-panel-data.h
index 42b77249ee14..b7733150b55c 100644
--- a/include/video/omap-panel-data.h
+++ b/include/video/omap-panel-data.h
@@ -52,20 +52,4 @@ struct panel_dpi_platform_data {
 	int enable_gpio;
 };
 
-/**
- * panel_acx565akm platform data
- * @name: name for this display entity
- * @source: name of the display entity used as a video source
- * @reset_gpio: gpio to reset the panel (or -1)
- * @datapairs: number of SDI datapairs
- */
-struct panel_acx565akm_platform_data {
-	const char *name;
-	const char *source;
-
-	int reset_gpio;
-
-	int datapairs;
-};
-
 #endif /* __OMAP_PANEL_DATA_H */

-- 
b4 0.11.0-dev-5166b
