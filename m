Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814FE618EBB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbiKDDRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKDDQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:16:59 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E02025E80;
        Thu,  3 Nov 2022 20:16:58 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so3596204pji.0;
        Thu, 03 Nov 2022 20:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mrkRiLGHBiE1WHjFsF1gLPe7uFBZgJGqIAjNRZoVoo=;
        b=HkmrYXxWTyDe3g96JnmaUm43+QWhwNHxqNuW1/I53yJBWjfdFg6tvChe11ViISD+th
         f1KD1mHiHtzeyY0SGYHVkgByA9Qu1wk55aU7XIWLX997wlvb8NBYn/SZfPA5x64+uAVK
         TJ6JYA+U6KssA4iXGyYmMqurbDZ6xxe3LMFsk4Bd6DvCihdgHjz6EnTGR/RvHpvHAYhj
         tm3vYT3jGj7/Klj85cVy6nxUHh+KkIFNz/52yLVZQz88FmX8Fj/8nSarRF6Hyw9GmPe/
         UBtmgLM+/K2ONJDypvCkOcGSZlaXwytal9/UdjA/sdmPrpHgju/Zs5MhvBDchAbrqZ2t
         63+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mrkRiLGHBiE1WHjFsF1gLPe7uFBZgJGqIAjNRZoVoo=;
        b=pdLzrPaWOylAthwj1BVgEFxNoxEO8Zr5O7S6mpXavfvPJx25ISumcifbus4a9z2+62
         rUjx1g4pVyxHSixAvBVF9Lx94Y7snVTVpKo1M5rKn9t7/sxJ3c7AaG/UUBw0EXTM2WWk
         7FfnNZ3MNGZ47PJlKT2VA1DWRxQNCH6KAJXjAEtC+rW8K0KLIPJah1bQSPtIjousMFtY
         7SQy3pXBKkhWwi218U3f1anxTxSjME0sjhuQGZcgfvR1U1oqFN6+MAE7ZwbYeMlR2Pha
         ktf1utV4WUSZDh0CRneksiN/zTemGRWRDT4+ekAYyHZItBy2mIaaiV8a05KTRYQ+w+OD
         ALyQ==
X-Gm-Message-State: ACrzQf3Hh3JFjj3/v1+2aXdDVCuGEpGfroc7+TtoFtaGqk8TDkG2fjkx
        5VFibTcbFM2H6C62U5McL0fkoG2QATs=
X-Google-Smtp-Source: AMsMyM4n8mGr5V6pgTAUmvZgtgumGTiK5TrIBLSBz3rNrwlVjJVeDMKcZ7Lsb7T8Nmu6uvOpV2jXDQ==
X-Received: by 2002:a17:90b:1982:b0:212:fe7f:4a49 with SMTP id mv2-20020a17090b198200b00212fe7f4a49mr52155514pjb.156.1667531817811;
        Thu, 03 Nov 2022 20:16:57 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id s3-20020a63ff43000000b004702eca61fcsm1078655pgk.36.2022.11.03.20.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:16:57 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH RESEND 06/13] omapfb: panel-tpo-td043mtea1: switch to using gpiod API
Date:   Thu,  3 Nov 2022 20:16:35 -0700
Message-Id: <20221103-omapfb-gpiod-v1-6-cba1fae5a77c@gmail.com>
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

Switch the driver from legacy gpio API that is deprecated to the newer
gpiod API that respects line polarities described in ACPI/DT.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   | 59 ++++++----------------
 1 file changed, 16 insertions(+), 43 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
index c0e4e0315b6b..1eaa35c27835 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
@@ -10,10 +10,9 @@
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/consumer.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/err.h>
 #include <linux/slab.h>
-#include <linux/of_gpio.h>
 
 #include <video/omapfb_dss.h>
 
@@ -58,7 +57,7 @@ struct panel_drv_data {
 
 	struct spi_device *spi;
 	struct regulator *vcc_reg;
-	int nreset_gpio;
+	struct gpio_desc *reset_gpio;
 	u16 gamma[12];
 	u32 mode;
 	u32 hmirror:1;
@@ -296,8 +295,7 @@ static int tpo_td043_power_on(struct panel_drv_data *ddata)
 	/* wait for panel to stabilize */
 	msleep(160);
 
-	if (gpio_is_valid(ddata->nreset_gpio))
-		gpio_set_value(ddata->nreset_gpio, 1);
+	gpiod_set_value_cansleep(ddata->reset_gpio, 0);
 
 	tpo_td043_write(ddata->spi, 2,
 			TPO_R02_MODE(ddata->mode) | TPO_R02_NCLK_RISING);
@@ -320,8 +318,7 @@ static void tpo_td043_power_off(struct panel_drv_data *ddata)
 	tpo_td043_write(ddata->spi, 3,
 			TPO_R03_VAL_STANDBY | TPO_R03_EN_PWM);
 
-	if (gpio_is_valid(ddata->nreset_gpio))
-		gpio_set_value(ddata->nreset_gpio, 0);
+	gpiod_set_value_cansleep(ddata->reset_gpio, 1);
 
 	/* wait for at least 2 vsyncs before cutting off power */
 	msleep(50);
@@ -454,32 +451,6 @@ static struct omap_dss_driver tpo_td043_ops = {
 	.get_resolution	= omapdss_default_get_resolution,
 };
 
-
-static int tpo_td043_probe_of(struct spi_device *spi)
-{
-	struct device_node *node = spi->dev.of_node;
-	struct panel_drv_data *ddata = dev_get_drvdata(&spi->dev);
-	struct omap_dss_device *in;
-	int gpio;
-
-	gpio = of_get_named_gpio(node, "reset-gpios", 0);
-	if (!gpio_is_valid(gpio)) {
-		dev_err(&spi->dev, "failed to parse enable gpio\n");
-		return gpio;
-	}
-	ddata->nreset_gpio = gpio;
-
-	in = omapdss_of_find_source_for_first_ep(node);
-	if (IS_ERR(in)) {
-		dev_err(&spi->dev, "failed to find video source\n");
-		return PTR_ERR(in);
-	}
-
-	ddata->in = in;
-
-	return 0;
-}
-
 static int tpo_td043_probe(struct spi_device *spi)
 {
 	struct panel_drv_data *ddata;
@@ -508,9 +479,12 @@ static int tpo_td043_probe(struct spi_device *spi)
 
 	ddata->spi = spi;
 
-	r = tpo_td043_probe_of(spi);
-	if (r)
+	ddata->in = omapdss_of_find_source_for_first_ep(spi->dev.of_node);
+	r = PTR_ERR_OR_ZERO(ddata->in);
+	if (r) {
+		dev_err(&spi->dev, "failed to find video source: %d\n", r);
 		return r;
+	}
 
 	ddata->mode = TPO_R02_MODE_800x480;
 	memcpy(ddata->gamma, tpo_td043_def_gamma, sizeof(ddata->gamma));
@@ -521,16 +495,15 @@ static int tpo_td043_probe(struct spi_device *spi)
 		goto err_regulator;
 	}
 
-	if (gpio_is_valid(ddata->nreset_gpio)) {
-		r = devm_gpio_request_one(&spi->dev,
-				ddata->nreset_gpio, GPIOF_OUT_INIT_LOW,
-				"lcd reset");
-		if (r < 0) {
-			dev_err(&spi->dev, "couldn't request reset GPIO\n");
-			goto err_gpio_req;
-		}
+	ddata->reset_gpio = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_HIGH);
+	r = PTR_ERR_OR_ZERO(ddata->reset_gpio);
+	if (r) {
+		dev_err(&spi->dev, "couldn't request reset GPIO\n");
+		goto err_gpio_req;
 	}
 
+	gpiod_set_consumer_name(ddata->reset_gpio, "lcd reset");
+
 	r = sysfs_create_group(&spi->dev.kobj, &tpo_td043_attr_group);
 	if (r) {
 		dev_err(&spi->dev, "failed to create sysfs files\n");

-- 
b4 0.11.0-dev-28747
