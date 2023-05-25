Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CDE710953
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbjEYJ4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbjEYJ4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:56:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8FD1A8
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 02:56:34 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q27hv-000883-9M; Thu, 25 May 2023 11:56:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q27ht-002h38-Ud; Thu, 25 May 2023 11:56:29 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q27ht-007oDK-Cl; Thu, 25 May 2023 11:56:29 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Philipp Marek <philipp@marek.priv.at>
Subject: [PATCH 1/3] w1: gpio: Don't use platform data for driver data
Date:   Thu, 25 May 2023 11:56:22 +0200
Message-Id: <20230525095624.615350-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5440; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Jr4jdd4Vt9tRKMjOFoYlMijWrtsLO2vVIlPaYdkD+R0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkbzDFc/Nj9ZzPpm5eilXnslC+/f1q4jaQBR/up uPTvCurhC2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZG8wxQAKCRCPgPtYfRL+ TqJ/B/9dVbYK5JxkcaW3vYtvn3QzSxxKTL3tWtV1yUQxGu21tRypwnhsil9xJpgASJkFt9GkmnD MBJg+tHqB0NNnWxbSKDD6exSeNn4HRuRd1ehOVeJ/ZimFUFVZis06cE86oUyGYT/euAMUEL/4SP KrLkRgpnSGo+O9yTUjwKXoXbZohExbMPBfasjTPtweyv2nTNelA9GRYlpn0/Fl74ankM9/u/bP5 kBMHqwRrSK4seqQef5gwjk2ZafLQsyYYGHQuqpFjkcq5IHs4YER52TrwnSDj4HOXJkpmxdbubQ/ +xFEIn45wrQzSFOdmW2uOrv4hX9/UBPLUs1r/XkLvU/jPSdm
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct device's .platform_data isn't for drivers to write to. For
driver-specific data there is .driver_data instead.

As there is no in-tree platform that provides w1_gpio_platform_data,
drop the include file and replace it by a local struct w1_gpio_ddata.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/w1/masters/w1-gpio.c | 56 +++++++++++++++++-------------------
 include/linux/w1-gpio.h      | 22 --------------
 2 files changed, 27 insertions(+), 51 deletions(-)
 delete mode 100644 include/linux/w1-gpio.h

diff --git a/drivers/w1/masters/w1-gpio.c b/drivers/w1/masters/w1-gpio.c
index e45acb6d916e..8d65db65178c 100644
--- a/drivers/w1/masters/w1-gpio.c
+++ b/drivers/w1/masters/w1-gpio.c
@@ -9,7 +9,6 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/w1-gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of_platform.h>
 #include <linux/err.h>
@@ -18,9 +17,16 @@
 
 #include <linux/w1.h>
 
+struct w1_gpio_ddata {
+	struct gpio_desc *gpiod;
+	struct gpio_desc *pullup_gpiod;
+	void (*enable_external_pullup)(int enable);
+	unsigned int pullup_duration;
+};
+
 static u8 w1_gpio_set_pullup(void *data, int delay)
 {
-	struct w1_gpio_platform_data *pdata = data;
+	struct w1_gpio_ddata *pdata = data;
 
 	if (delay) {
 		pdata->pullup_duration = delay;
@@ -46,14 +52,14 @@ static u8 w1_gpio_set_pullup(void *data, int delay)
 
 static void w1_gpio_write_bit(void *data, u8 bit)
 {
-	struct w1_gpio_platform_data *pdata = data;
+	struct w1_gpio_ddata *pdata = data;
 
 	gpiod_set_value(pdata->gpiod, bit);
 }
 
 static u8 w1_gpio_read_bit(void *data)
 {
-	struct w1_gpio_platform_data *pdata = data;
+	struct w1_gpio_ddata *pdata = data;
 
 	return gpiod_get_value(pdata->gpiod) ? 1 : 0;
 }
@@ -69,35 +75,25 @@ MODULE_DEVICE_TABLE(of, w1_gpio_dt_ids);
 static int w1_gpio_probe(struct platform_device *pdev)
 {
 	struct w1_bus_master *master;
-	struct w1_gpio_platform_data *pdata;
+	struct w1_gpio_ddata *pdata;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	/* Enforce open drain mode by default */
 	enum gpiod_flags gflags = GPIOD_OUT_LOW_OPEN_DRAIN;
 	int err;
 
-	if (of_have_populated_dt()) {
-		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
-		if (!pdata)
-			return -ENOMEM;
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
 
-		/*
-		 * This parameter means that something else than the gpiolib has
-		 * already set the line into open drain mode, so we should just
-		 * driver it high/low like we are in full control of the line and
-		 * open drain will happen transparently.
-		 */
-		if (of_property_present(np, "linux,open-drain"))
-			gflags = GPIOD_OUT_LOW;
-
-		pdev->dev.platform_data = pdata;
-	}
-	pdata = dev_get_platdata(dev);
-
-	if (!pdata) {
-		dev_err(dev, "No configuration data\n");
-		return -ENXIO;
-	}
+	/*
+	 * This parameter means that something else than the gpiolib has
+	 * already set the line into open drain mode, so we should just
+	 * driver it high/low like we are in full control of the line and
+	 * open drain will happen transparently.
+	 */
+	if (of_property_present(np, "linux,open-drain"))
+		gflags = GPIOD_OUT_LOW;
 
 	master = devm_kzalloc(dev, sizeof(struct w1_bus_master),
 			GFP_KERNEL);
@@ -152,7 +148,7 @@ static int w1_gpio_probe(struct platform_device *pdev)
 static int w1_gpio_remove(struct platform_device *pdev)
 {
 	struct w1_bus_master *master = platform_get_drvdata(pdev);
-	struct w1_gpio_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct w1_gpio_ddata *pdata = master->data;
 
 	if (pdata->enable_external_pullup)
 		pdata->enable_external_pullup(0);
@@ -167,7 +163,8 @@ static int w1_gpio_remove(struct platform_device *pdev)
 
 static int __maybe_unused w1_gpio_suspend(struct device *dev)
 {
-	struct w1_gpio_platform_data *pdata = dev_get_platdata(dev);
+	struct w1_bus_master *master = dev_get_drvdata(dev);
+	struct w1_gpio_ddata *pdata = master->data;
 
 	if (pdata->enable_external_pullup)
 		pdata->enable_external_pullup(0);
@@ -177,7 +174,8 @@ static int __maybe_unused w1_gpio_suspend(struct device *dev)
 
 static int __maybe_unused w1_gpio_resume(struct device *dev)
 {
-	struct w1_gpio_platform_data *pdata = dev_get_platdata(dev);
+	struct w1_bus_master *master = dev_get_drvdata(dev);
+	struct w1_gpio_ddata *pdata = master->data;
 
 	if (pdata->enable_external_pullup)
 		pdata->enable_external_pullup(1);
diff --git a/include/linux/w1-gpio.h b/include/linux/w1-gpio.h
deleted file mode 100644
index 3495fd0dc790..000000000000
--- a/include/linux/w1-gpio.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * w1-gpio interface to platform code
- *
- * Copyright (C) 2007 Ville Syrjala <syrjala@sci.fi>
- */
-#ifndef _LINUX_W1_GPIO_H
-#define _LINUX_W1_GPIO_H
-
-struct gpio_desc;
-
-/**
- * struct w1_gpio_platform_data - Platform-dependent data for w1-gpio
- */
-struct w1_gpio_platform_data {
-	struct gpio_desc *gpiod;
-	struct gpio_desc *pullup_gpiod;
-	void (*enable_external_pullup)(int enable);
-	unsigned int pullup_duration;
-};
-
-#endif /* _LINUX_W1_GPIO_H */

base-commit: ac9a78681b921877518763ba0e89202254349d1b
-- 
2.39.2

