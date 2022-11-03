Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6FF618BF3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiKCWsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiKCWrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:47:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8E86572;
        Thu,  3 Nov 2022 15:47:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id 4so3348228pli.0;
        Thu, 03 Nov 2022 15:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aztYLEZ2Ar+xCBwvpIo1FkOJs0pWaPxddbEF+G4P4bY=;
        b=OHHfZ1gqCkW70fTqI7HRH2PKv+wu+5+kqGndytCXq65svH6oCfTodtEOu3YX8S4StZ
         aK9L89hkOctjlg+KWZycTSiONd3ZCyVebcg5jfwS/058fPsu6tu9tGVyuir+4spbNla+
         eB1YTMyDV1FmT2PR9cDufooow7ZdaII4why2HKU13EZN5IP0zRbYS04kHNns/aeLVWlD
         Ei3VY0V5w1XkWz4r3sGxf4cNVGJ79KjsX7CPu72kF9hFjdX927wP557mlVpaIty17Bep
         AUAE9kDuinsm6FvxjqHeSpdGpQFNczr5qsTZrNdJ/1fHwuNLrC+mrZzkWQIVBEWPEKzY
         lXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aztYLEZ2Ar+xCBwvpIo1FkOJs0pWaPxddbEF+G4P4bY=;
        b=b1fC6t5MdDFEe9NQ5OdJbLtLPEN10iDI3C0L+LEc2Ecn30Vv8Yq68DGXMIKvUl8Mgh
         y2UpflBQfl6a+JA6mFz61JUrVoi2Dw03dJcxcAmFyKHvN8s3R/Rdz/c6RnLxjP3/f52x
         V+5XIA05pWKBZLqfu9AIfNTgK2l3gcRknb6gjgqEiUGBlbKohnl/XgiBCELOGogLrklZ
         FSJh3AJvJ2s6ynw67u11TAWwCHiNO3xw/JUh18qSJPdx3UjVjuGp4vL3guxc4pv9l1Ae
         yFIyKKyfX+9L8Lg7/9AuVJUavyZNTnwlcjZCnIR4V61doXv6dIHBU13XCdTE7l2VYQa2
         YUFQ==
X-Gm-Message-State: ACrzQf3iMzy/ZAuexj+ZeVeGH4c28fPfMZxRVBfuBbxgNqQVwBNQOspw
        xxpTNflDIbDwFuRtPBXpMzQ=
X-Google-Smtp-Source: AMsMyM6y7+39z4Ua1xvM3p2AOaYkmsDJ8g18Kn5uYYWgNHsOqRea+ABqsz2UaHFuDlWwgEa4ld3ojg==
X-Received: by 2002:a17:903:22c7:b0:187:190d:da89 with SMTP id y7-20020a17090322c700b00187190dda89mr26176716plg.68.1667515650865;
        Thu, 03 Nov 2022 15:47:30 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id g13-20020aa796ad000000b0056be1d7d4a3sm1280421pfk.73.2022.11.03.15.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:47:29 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 07/13] omapfb: panel-nec-nl8048hl11: switch to using gpiod API
Date:   Thu,  3 Nov 2022 15:46:49 -0700
Message-Id: <20221103-omapfb-gpiod-v1-7-c3d53ca7988f@gmail.com>
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

Note that because existing DTSes specify incorrect polarity of reset
lines (active high) and GPU drivers have adopted to this, we follow
the suit and use inverted values when controlling reset lines.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../omap2/omapfb/displays/panel-nec-nl8048hl11.c   | 72 ++++++----------------
 1 file changed, 20 insertions(+), 52 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c
index b407173e27b1..33563953b2ff 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c
@@ -7,12 +7,12 @@
  * Converted to new DSS device model: Tomi Valkeinen <tomi.valkeinen@ti.com>
  */
 
-#include <linux/module.h>
 #include <linux/delay.h>
-#include <linux/spi/spi.h>
+#include <linux/err.h>
 #include <linux/fb.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
 
 #include <video/omapfb_dss.h>
 
@@ -24,8 +24,7 @@ struct panel_drv_data {
 
 	int data_lines;
 
-	int res_gpio;
-	int qvga_gpio;
+	struct gpio_desc *res_gpio;
 
 	struct spi_device *spi;
 };
@@ -155,8 +154,8 @@ static int nec_8048_enable(struct omap_dss_device *dssdev)
 	if (r)
 		return r;
 
-	if (gpio_is_valid(ddata->res_gpio))
-		gpio_set_value_cansleep(ddata->res_gpio, 1);
+	/* Apparently existing DTSes use incorrect polarity (active high) */
+	gpiod_set_value_cansleep(ddata->res_gpio, 1);
 
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
@@ -171,8 +170,8 @@ static void nec_8048_disable(struct omap_dss_device *dssdev)
 	if (!omapdss_device_is_enabled(dssdev))
 		return;
 
-	if (gpio_is_valid(ddata->res_gpio))
-		gpio_set_value_cansleep(ddata->res_gpio, 0);
+	/* Apparently existing DTSes use incorrect polarity (active high) */
+	gpiod_set_value_cansleep(ddata->res_gpio, 0);
 
 	in->ops.dpi->disable(in);
 
@@ -222,35 +221,6 @@ static struct omap_dss_driver nec_8048_ops = {
 	.get_resolution	= omapdss_default_get_resolution,
 };
 
-
-static int nec_8048_probe_of(struct spi_device *spi)
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
-	ddata->res_gpio = gpio;
-
-	/* XXX the panel spec doesn't mention any QVGA pin?? */
-	ddata->qvga_gpio = -ENOENT;
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
 static int nec_8048_probe(struct spi_device *spi)
 {
 	struct panel_drv_data *ddata;
@@ -281,24 +251,22 @@ static int nec_8048_probe(struct spi_device *spi)
 
 	ddata->spi = spi;
 
-	r = nec_8048_probe_of(spi);
-	if (r)
+	ddata->in = omapdss_of_find_source_for_first_ep(spi->dev.of_node);
+	r = PTR_ERR_OR_ZERO(ddata->in);
+	if (r) {
+		dev_err(&spi->dev, "failed to find video source: %d\n", r);
 		return r;
-
-	if (gpio_is_valid(ddata->qvga_gpio)) {
-		r = devm_gpio_request_one(&spi->dev, ddata->qvga_gpio,
-				GPIOF_OUT_INIT_HIGH, "lcd QVGA");
-		if (r)
-			goto err_gpio;
 	}
 
-	if (gpio_is_valid(ddata->res_gpio)) {
-		r = devm_gpio_request_one(&spi->dev, ddata->res_gpio,
-				GPIOF_OUT_INIT_LOW, "lcd RES");
-		if (r)
-			goto err_gpio;
+	ddata->res_gpio = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_LOW);
+	r = PTR_ERR_OR_ZERO(ddata->res_gpio);
+	if (r) {
+		dev_err(&spi->dev, "failed to request reset gpio: %d\n", r);
+		goto err_gpio;
 	}
 
+	gpiod_set_consumer_name(ddata->res_gpio, "lcd RES");
+
 	ddata->videomode = nec_8048_panel_timings;
 
 	dssdev = &ddata->dssdev;

-- 
b4 0.11.0-dev-5166b
