Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D18618BE8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiKCWr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiKCWre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:47:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4635822BE8;
        Thu,  3 Nov 2022 15:47:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d59-20020a17090a6f4100b00213202d77e1so6652513pjk.2;
        Thu, 03 Nov 2022 15:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3X26rknx/0lmJfmFIFsGeakVjwS4PgAaf3ahk4arl/w=;
        b=ilB526eKd/8ilrwsSPLckfywAou4hodKS50T45woYDzwYbHHxHLDfVcpcf+cpFnUmU
         KI18gsRBZPVocj1QAyOt7zGP+TX6dD61vLTVVv+Ke6Mn3nxeYlpKCL6yqxAcaTgwaaYL
         T5NoSU2vMGWlu3QPxPmrbDYZzmXw2cJ2tdn2VGadOy0LQVjZVW2wpxRYsofemPIrZE3X
         J627uMC4StcVgXpdeY0/TZz1CGsh2wl3zR10pnZ5ekAxHFKy9DYBq/70vKpdKPAASjVl
         o5ihnTIGo2yqoAOdizkiVs1MJFx2Uwly9txneCdEysBNjNdBaNW56b7ZRrQSdhoBk4NE
         vvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3X26rknx/0lmJfmFIFsGeakVjwS4PgAaf3ahk4arl/w=;
        b=MagYH+HgtE5IGMr5ZCq0gTuXakJJZWVdafDiewI3EUXPpdqUeZXzmloAPBdqKaNZ9h
         beFZX77FSzO+bsP4iM+dGEp5yhKEEpiXl11ZiuPVGqtXKHGNM9a190Z+Z7/u+l4XsGut
         ZlNyGd6F+F17dTN+9e0yYrV++u8MiKuPY8ePJEsR/i3kcxoDAQd87/1ZfBdcXDcl6+76
         83fdiURNy4ZQMs2rY+q5RxX7Vzd3uALUhQXe6670fCJB5jmjqq4M4AXCQzmMRQmXUXRx
         MCF05P815U/MSa3oNyVIyAso2SagXn2dFaXc3Y8qznTb6jxh6o0ytXzzJ0133LshJgIj
         Eb5w==
X-Gm-Message-State: ACrzQf1JQTl/SHV5vUCp6mBM38kjJVAU3mltSHPoQVP/WEBnpFX768T+
        5MJe2wWLjuJCqMc7uc8sdGs=
X-Google-Smtp-Source: AMsMyM4IK3WWfZjxdVGCdvLQJUqFVt5Ge+7F+td9f7w7jnXE/NGyg/cSHud+HpRmlrEzKuoWVdrfOw==
X-Received: by 2002:a17:90a:eb0c:b0:213:8ff3:a46a with SMTP id j12-20020a17090aeb0c00b002138ff3a46amr38528966pjz.158.1667515645445;
        Thu, 03 Nov 2022 15:47:25 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id g13-20020aa796ad000000b0056be1d7d4a3sm1280421pfk.73.2022.11.03.15.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:47:24 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 06/13] omapfb: panel-tpo-td043mtea1: switch to using gpiod API
Date:   Thu,  3 Nov 2022 15:46:47 -0700
Message-Id: <20221103-omapfb-gpiod-v1-6-c3d53ca7988f@gmail.com>
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
b4 0.11.0-dev-5166b
