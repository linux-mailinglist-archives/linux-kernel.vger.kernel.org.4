Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43176618EC3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 04:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiKDDRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 23:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiKDDRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 23:17:01 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392B725E91;
        Thu,  3 Nov 2022 20:17:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id i3so3376327pfc.11;
        Thu, 03 Nov 2022 20:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nekMKek88OrPUkYJ4VB8OmAAcdm9+OSYr1boF1eblE0=;
        b=oPYniO1MtADtJtuw4q4+C20hdzvodf6jSrPaX3J9tWE9wbkPGVDQeExemFb+FhE0/x
         h86dPAwa3MqkgKsCjfvra8knhjsbtHsa1EVMrFS+egrOi/ZYv0A/Zeorm40BXXHsfgyo
         MFifWX4YicxVyj6KbftzPWM9+gwEpnLd++s1w5jKCSVvQSIXC0dMAnl7P/xDanNHcJon
         Lhfwx1syQS+XZY1CBvg4E9HkddvJvXPO4f9aoZF4RB2PY/lV+eiQaO9k1hnWiA2ldYhQ
         g102yHZvQ5Ff8Ptv7Xwb0pZdS8hBWUrX4TuSMDQ4dcEOEIfrqkWCWRF2hd365tHI7Kte
         CSqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nekMKek88OrPUkYJ4VB8OmAAcdm9+OSYr1boF1eblE0=;
        b=l7OUjsEZPhsuq9FMWrVKLPle6GfAx1wWWDvwFXqPbGp1ZA3HIoKSKok+7xvzXGfu7z
         JXWwVj7hDAROaIFu8lySiIvKPJzBCYNHUANAS2FWo3HpJBHIe0UkXgc1skVtd+spiLBt
         T6Fe2bzQIhB7preRhps+cwjd0wgJeY40c9BoszSd8INZuoMDm06LN30l7sW1v3ZzOMQ9
         FXCspZxKaxXNDY4Hok1hgkEqSgUXEyO1T3NlSiprCodm1Sk91fHQ3eGbmVSva8fMaxnL
         t+L+OKRVvmucRqUv8v2q5qIKfthPo7kONinzOhVW7wG6mZEY2/IaBzUh9bM9TZHq/STc
         nsgQ==
X-Gm-Message-State: ACrzQf0WXC+oHvQGeIYCv9Toxaw5gwX7K/uh08rOK5o4sfjzVts78sh2
        v7ytAcWf14qraC8Rksa8Btw=
X-Google-Smtp-Source: AMsMyM4tjxDH3I9/SGWnHbcfvNSs5puflv1f7cQrHpZ3l9cFk2LAz69U4h06qmIKaA9OS3B/R5EUpg==
X-Received: by 2002:aa7:9624:0:b0:56c:8c13:27bf with SMTP id r4-20020aa79624000000b0056c8c1327bfmr33745147pfg.20.1667531819540;
        Thu, 03 Nov 2022 20:16:59 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id s3-20020a63ff43000000b004702eca61fcsm1078655pgk.36.2022.11.03.20.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 20:16:58 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Helge Deller <deller@gmx.de>, Tony Lindgren <tony@atomide.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH RESEND 07/13] omapfb: panel-nec-nl8048hl11: switch to using gpiod API
Date:   Thu,  3 Nov 2022 20:16:36 -0700
Message-Id: <20221103-omapfb-gpiod-v1-7-cba1fae5a77c@gmail.com>
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
b4 0.11.0-dev-28747
