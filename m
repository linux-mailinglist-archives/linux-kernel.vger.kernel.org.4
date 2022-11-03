Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32197618BD2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiKCWrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiKCWrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:47:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541BBDF67;
        Thu,  3 Nov 2022 15:47:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so3155697pjk.1;
        Thu, 03 Nov 2022 15:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzyVxrhxEbz+OkOBW/vELHwjREnaJbPjpbkyciCOuGU=;
        b=CBNO6vMlSLpNtQN82BjV4VPELjbrs2snmwzEcl47oYPc2n+hYfAIcKkdB0l6nBgtjh
         Go9XzIiBLTs2l0HOdHuKZaOfToC4MFF1m0PSw0c6j3hSwtmo1zOvBRX0PfxGpBjOyr8L
         rU3KKM5dj9bX8AKtdL20Oi9dB5slGk+dGny8ei0kc1/sXKr576pYpU2Dpp4BIqcDktVJ
         x+suUidssIdLmv+Qb4nndRE8SEGarjfdJ3lup7ZAiTwsQ30tq+aQEaVHba8nH2rmYVlE
         YKon1yYBdSu9l3j0AZ1LOUlluqpZotOksbyhNOEooRtb1CklASwPyrHTV9bGo5hqcHp9
         4ovQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzyVxrhxEbz+OkOBW/vELHwjREnaJbPjpbkyciCOuGU=;
        b=Mdtl64w9YiIKVZNIHZwME8EdTAbz1htjRU69mueQdylLrExLopfPU1yxpXaEKPGlNO
         wPk2V+bHNLaHaaEC+8yH/tNyJw1YPDo/lIEW59zJrfu2VlDW1yyLGaYjkP+GMjLz9GMV
         Vl/hWiJi0WgOcUQP2+yXU5rp+f/BVqv08BTXYgzwd028IrEMo6W0DoiRuDB/eQZrSnV+
         HJv/ipA3Wwch4PKvQ7KQnL4yogXp8wkrzEDyFuoNmFuttsgEfc6Jma5rJIllteszpkSB
         VyA1DzWdfUQ6PWcP7IZ4GfOXypNzHIjzmd/87jnuuDdaBo9+WLB7qM4V9wzMXwvHwyTr
         jYLg==
X-Gm-Message-State: ACrzQf0bvlWHvFZqP4CHG1iavvZc7gnEFQYGM/QzR4b0x35fStMdzwSB
        4ZeQSaOGBXQOdw21dB0VLUpjro+rLkM=
X-Google-Smtp-Source: AMsMyM6PUokmz2Qi/MEYK1qf/09vcpEWhd8ty8i8xUH+DMkr/eV8/XQjqtWgtesX6MEiaYM3XrbMZQ==
X-Received: by 2002:a17:90a:4d08:b0:20b:25f6:3e30 with SMTP id c8-20020a17090a4d0800b0020b25f63e30mr206608pjg.227.1667515625646;
        Thu, 03 Nov 2022 15:47:05 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id g13-20020aa796ad000000b0056be1d7d4a3sm1280421pfk.73.2022.11.03.15.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 15:47:05 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-omap@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 01/13] omapfb: connector-hdmi: switch to using gpiod API
Date:   Thu,  3 Nov 2022 15:46:37 -0700
Message-Id: <20221103-omapfb-gpiod-v1-1-c3d53ca7988f@gmail.com>
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
 .../fbdev/omap2/omapfb/displays/connector-hdmi.c   | 49 +++++++---------------
 1 file changed, 14 insertions(+), 35 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c b/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c
index 670b9c6eb5a9..8f9ff9fb4ca4 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c
@@ -6,11 +6,12 @@
  * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
  */
 
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 
 #include <drm/drm_edid.h>
 
@@ -41,7 +42,7 @@ struct panel_drv_data {
 
 	struct omap_video_timings timings;
 
-	int hpd_gpio;
+	struct gpio_desc *hpd_gpio;
 };
 
 #define to_panel_data(x) container_of(x, struct panel_drv_data, dssdev)
@@ -155,8 +156,8 @@ static bool hdmic_detect(struct omap_dss_device *dssdev)
 	struct panel_drv_data *ddata = to_panel_data(dssdev);
 	struct omap_dss_device *in = ddata->in;
 
-	if (gpio_is_valid(ddata->hpd_gpio))
-		return gpio_get_value_cansleep(ddata->hpd_gpio);
+	if (ddata->hpd_gpio)
+		return gpiod_get_value_cansleep(ddata->hpd_gpio);
 	else
 		return in->ops.hdmi->detect(in);
 }
@@ -197,31 +198,6 @@ static struct omap_dss_driver hdmic_driver = {
 	.set_hdmi_infoframe	= hdmic_set_infoframe,
 };
 
-static int hdmic_probe_of(struct platform_device *pdev)
-{
-	struct panel_drv_data *ddata = platform_get_drvdata(pdev);
-	struct device_node *node = pdev->dev.of_node;
-	struct omap_dss_device *in;
-	int gpio;
-
-	/* HPD GPIO */
-	gpio = of_get_named_gpio(node, "hpd-gpios", 0);
-	if (gpio_is_valid(gpio))
-		ddata->hpd_gpio = gpio;
-	else
-		ddata->hpd_gpio = -ENODEV;
-
-	in = omapdss_of_find_source_for_first_ep(node);
-	if (IS_ERR(in)) {
-		dev_err(&pdev->dev, "failed to find video source\n");
-		return PTR_ERR(in);
-	}
-
-	ddata->in = in;
-
-	return 0;
-}
-
 static int hdmic_probe(struct platform_device *pdev)
 {
 	struct panel_drv_data *ddata;
@@ -238,15 +214,18 @@ static int hdmic_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ddata);
 	ddata->dev = &pdev->dev;
 
-	r = hdmic_probe_of(pdev);
+	ddata->hpd_gpio = devm_gpiod_get_optional(&pdev->dev, "hpd", GPIOD_IN);
+	r = PTR_ERR_OR_ZERO(ddata->hpd_gpio);
 	if (r)
 		return r;
 
-	if (gpio_is_valid(ddata->hpd_gpio)) {
-		r = devm_gpio_request_one(&pdev->dev, ddata->hpd_gpio,
-				GPIOF_DIR_IN, "hdmi_hpd");
-		if (r)
-			goto err_reg;
+	gpiod_set_consumer_name(ddata->hpd_gpio, "hdmi_hpd");
+
+	ddata->in = omapdss_of_find_source_for_first_ep(pdev->dev.of_node);
+	r = PTR_ERR_OR_ZERO(ddata->in);
+	if (r) {
+		dev_err(&pdev->dev, "failed to find video source\n");
+		return r;
 	}
 
 	ddata->timings = hdmic_default_timings;

-- 
b4 0.11.0-dev-5166b
