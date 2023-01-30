Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D066A680E92
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbjA3NKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbjA3NKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:10:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED29E35AF;
        Mon, 30 Jan 2023 05:10:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 741CFB810BC;
        Mon, 30 Jan 2023 13:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2FCC433D2;
        Mon, 30 Jan 2023 13:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675084228;
        bh=xdPT6u7z72VUkN+u7Fl/ijfgw0xiO7Ouzrg9nJ5fKgY=;
        h=From:To:Cc:Subject:Date:From;
        b=jhycMSudBNl+EATBAaAfeSIKby9dK2iIZFGaSBWzJKU0B6LQ+FD9hulTzENKmqWle
         DIR4N5GqyGj7LxDeKeCMKKRh+055UIl83v2jJI4HrlD7jrJF62FjFcdFd/0n8P+UpL
         Wtamkg/aiiYWI+FrQsjmPE6+hLz0s0qLdCmq/QOmXVi/6OjKjXe9iPaHqRZbSZBvLd
         no5tK8MESmUnkoz0MRSv3YwaYRVaErLnTMBmUDTs75+0jJxFcyAGCNmEHMb4bI2bwH
         Z/rDk7p9Q0rn8qpsv/6e+pxpA/5yVloV/qwIfLQfCohRPrlz1QLXn3swynAj4u+A00
         q7JlXmdUK8+uQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: moxart: convert to gpio descriptors
Date:   Mon, 30 Jan 2023 14:10:20 +0100
Message-Id: <20230130131024.695212-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The conversion is fairly simple as the driver only has DT based
probing, and all the gpio calls have a direct replacement.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/rtc/rtc-moxart.c | 100 +++++++++++++++------------------------
 1 file changed, 38 insertions(+), 62 deletions(-)

diff --git a/drivers/rtc/rtc-moxart.c b/drivers/rtc/rtc-moxart.c
index 6b24ac9e1cfa..6537351c5dad 100644
--- a/drivers/rtc/rtc-moxart.c
+++ b/drivers/rtc/rtc-moxart.c
@@ -16,8 +16,8 @@
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 #include <linux/module.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
+#include <linux/of.h>
 
 #define GPIO_RTC_RESERVED			0x0C
 #define GPIO_RTC_DATA_SET			0x10
@@ -55,7 +55,7 @@
 struct moxart_rtc {
 	struct rtc_device *rtc;
 	spinlock_t rtc_lock;
-	int gpio_data, gpio_sclk, gpio_reset;
+	struct gpio_desc *gpio_data, *gpio_sclk, *gpio_reset;
 };
 
 static int day_of_year[12] =	{ 0, 31, 59, 90, 120, 151, 181,
@@ -67,10 +67,10 @@ static void moxart_rtc_write_byte(struct device *dev, u8 data)
 	int i;
 
 	for (i = 0; i < 8; i++, data >>= 1) {
-		gpio_set_value(moxart_rtc->gpio_sclk, 0);
-		gpio_set_value(moxart_rtc->gpio_data, ((data & 1) == 1));
+		gpiod_set_value(moxart_rtc->gpio_sclk, 0);
+		gpiod_set_value(moxart_rtc->gpio_data, ((data & 1) == 1));
 		udelay(GPIO_RTC_DELAY_TIME);
-		gpio_set_value(moxart_rtc->gpio_sclk, 1);
+		gpiod_set_value(moxart_rtc->gpio_sclk, 1);
 		udelay(GPIO_RTC_DELAY_TIME);
 	}
 }
@@ -82,11 +82,11 @@ static u8 moxart_rtc_read_byte(struct device *dev)
 	u8 data = 0;
 
 	for (i = 0; i < 8; i++) {
-		gpio_set_value(moxart_rtc->gpio_sclk, 0);
+		gpiod_set_value(moxart_rtc->gpio_sclk, 0);
 		udelay(GPIO_RTC_DELAY_TIME);
-		gpio_set_value(moxart_rtc->gpio_sclk, 1);
+		gpiod_set_value(moxart_rtc->gpio_sclk, 1);
 		udelay(GPIO_RTC_DELAY_TIME);
-		if (gpio_get_value(moxart_rtc->gpio_data))
+		if (gpiod_get_value(moxart_rtc->gpio_data))
 			data |= (1 << i);
 		udelay(GPIO_RTC_DELAY_TIME);
 	}
@@ -101,15 +101,15 @@ static u8 moxart_rtc_read_register(struct device *dev, u8 cmd)
 
 	local_irq_save(flags);
 
-	gpio_direction_output(moxart_rtc->gpio_data, 0);
-	gpio_set_value(moxart_rtc->gpio_reset, 1);
+	gpiod_direction_output(moxart_rtc->gpio_data, 0);
+	gpiod_set_value(moxart_rtc->gpio_reset, 1);
 	udelay(GPIO_RTC_DELAY_TIME);
 	moxart_rtc_write_byte(dev, cmd);
-	gpio_direction_input(moxart_rtc->gpio_data);
+	gpiod_direction_input(moxart_rtc->gpio_data);
 	udelay(GPIO_RTC_DELAY_TIME);
 	data = moxart_rtc_read_byte(dev);
-	gpio_set_value(moxart_rtc->gpio_sclk, 0);
-	gpio_set_value(moxart_rtc->gpio_reset, 0);
+	gpiod_set_value(moxart_rtc->gpio_sclk, 0);
+	gpiod_set_value(moxart_rtc->gpio_reset, 0);
 	udelay(GPIO_RTC_DELAY_TIME);
 
 	local_irq_restore(flags);
@@ -124,13 +124,13 @@ static void moxart_rtc_write_register(struct device *dev, u8 cmd, u8 data)
 
 	local_irq_save(flags);
 
-	gpio_direction_output(moxart_rtc->gpio_data, 0);
-	gpio_set_value(moxart_rtc->gpio_reset, 1);
+	gpiod_direction_output(moxart_rtc->gpio_data, 0);
+	gpiod_set_value(moxart_rtc->gpio_reset, 1);
 	udelay(GPIO_RTC_DELAY_TIME);
 	moxart_rtc_write_byte(dev, cmd);
 	moxart_rtc_write_byte(dev, data);
-	gpio_set_value(moxart_rtc->gpio_sclk, 0);
-	gpio_set_value(moxart_rtc->gpio_reset, 0);
+	gpiod_set_value(moxart_rtc->gpio_sclk, 0);
+	gpiod_set_value(moxart_rtc->gpio_reset, 0);
 	udelay(GPIO_RTC_DELAY_TIME);
 
 	local_irq_restore(flags);
@@ -241,59 +241,35 @@ static const struct rtc_class_ops moxart_rtc_ops = {
 static int moxart_rtc_probe(struct platform_device *pdev)
 {
 	struct moxart_rtc *moxart_rtc;
-	int ret = 0;
 
 	moxart_rtc = devm_kzalloc(&pdev->dev, sizeof(*moxart_rtc), GFP_KERNEL);
 	if (!moxart_rtc)
 		return -ENOMEM;
 
-	moxart_rtc->gpio_data = of_get_named_gpio(pdev->dev.of_node,
-						  "gpio-rtc-data", 0);
-	if (!gpio_is_valid(moxart_rtc->gpio_data)) {
-		dev_err(&pdev->dev, "invalid gpio (data): %d\n",
-			moxart_rtc->gpio_data);
-		return moxart_rtc->gpio_data;
-	}
-
-	moxart_rtc->gpio_sclk = of_get_named_gpio(pdev->dev.of_node,
-						  "gpio-rtc-sclk", 0);
-	if (!gpio_is_valid(moxart_rtc->gpio_sclk)) {
-		dev_err(&pdev->dev, "invalid gpio (sclk): %d\n",
-			moxart_rtc->gpio_sclk);
-		return moxart_rtc->gpio_sclk;
-	}
-
-	moxart_rtc->gpio_reset = of_get_named_gpio(pdev->dev.of_node,
-						   "gpio-rtc-reset", 0);
-	if (!gpio_is_valid(moxart_rtc->gpio_reset)) {
-		dev_err(&pdev->dev, "invalid gpio (reset): %d\n",
-			moxart_rtc->gpio_reset);
-		return moxart_rtc->gpio_reset;
-	}
+	moxart_rtc->gpio_data = devm_gpiod_get(&pdev->dev, "gpio-rtc-data",
+					       GPIOD_IN);
+	if (IS_ERR(moxart_rtc->gpio_data))
+		return dev_err_probe(&pdev->dev,
+				     PTR_ERR(moxart_rtc->gpio_data),
+				     "invalid gpio (data)");
+
+	moxart_rtc->gpio_sclk = devm_gpiod_get(&pdev->dev, "gpio-rtc-sclk",
+						GPIOD_OUT_LOW);
+	if (IS_ERR(moxart_rtc->gpio_sclk))
+		return dev_err_probe(&pdev->dev,
+				     PTR_ERR(moxart_rtc->gpio_sclk),
+				    "invalid gpio (sclk)");
+
+	moxart_rtc->gpio_reset = devm_gpiod_get(&pdev->dev, "gpio-rtc-reset",
+						GPIOD_OUT_LOW);
+	if (IS_ERR(moxart_rtc->gpio_reset))
+		return dev_err_probe(&pdev->dev,
+				     PTR_ERR(moxart_rtc->gpio_reset),
+				     "invalid gpio (reset)\n");
 
 	spin_lock_init(&moxart_rtc->rtc_lock);
 	platform_set_drvdata(pdev, moxart_rtc);
 
-	ret = devm_gpio_request(&pdev->dev, moxart_rtc->gpio_data, "rtc_data");
-	if (ret) {
-		dev_err(&pdev->dev, "can't get rtc_data gpio\n");
-		return ret;
-	}
-
-	ret = devm_gpio_request_one(&pdev->dev, moxart_rtc->gpio_sclk,
-				    GPIOF_DIR_OUT, "rtc_sclk");
-	if (ret) {
-		dev_err(&pdev->dev, "can't get rtc_sclk gpio\n");
-		return ret;
-	}
-
-	ret = devm_gpio_request_one(&pdev->dev, moxart_rtc->gpio_reset,
-				    GPIOF_DIR_OUT, "rtc_reset");
-	if (ret) {
-		dev_err(&pdev->dev, "can't get rtc_reset gpio\n");
-		return ret;
-	}
-
 	moxart_rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
 						   &moxart_rtc_ops,
 						   THIS_MODULE);
-- 
2.39.0

