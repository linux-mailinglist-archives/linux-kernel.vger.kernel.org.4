Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561105EE950
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 00:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbiI1WWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 18:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiI1WWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 18:22:17 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C29F1857;
        Wed, 28 Sep 2022 15:22:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id v186so13695475pfv.11;
        Wed, 28 Sep 2022 15:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=h9q5EucT92dTMgZ65QlxwzC3EbF26KJeQy8ojKaTJsQ=;
        b=ccZ7o3C4g7EKdkAFC7A6RSoIRSNWR/jTucS539ALbO/BDFLa1W0dvDXSv2dOlEIaHX
         39lLdgahKAxfKYP/iPFwpr3UuCzrUMyGUO5SP4NxR7GZDuzlQ0rwDuSeWvS8gAMY86bX
         c7yKZREt1ye52R9db9WMsS0E+Zq7g7NfYckuIarz3Ri3J4ec6XCO63HHQJtiTDB/j6cR
         Kvhc2NGQnEraQwCEGiHQaL1NrB+Ow8e2rtHFBBeUtp5nYfdZfJ7+tzsj3M0CwvJf9TO0
         G0KwCE3CoKoxi0z61EfWng6PCuHlF5HjKBIbiIt3ZouLC6cukYwA4aWn9rFZr4CU61Jb
         0fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=h9q5EucT92dTMgZ65QlxwzC3EbF26KJeQy8ojKaTJsQ=;
        b=ME+i0bwYHCb5RYP4dAL60D0NcWyujgN19AEokcKfNowWXEcQbOt1MT1Tafgp4m2tKi
         RMAS92YN8X938c7lFlvNVYmw8sL3gBD4ZqTI09rYvkUA1JrTON1vPEMUV9pnbjIS5Nwb
         tAUz5ibY1HzQAMDgRBoHdOBl7cVsQqO/dpUR04/MoxyijWcKBtUptdK6TRZzMIZ9jdiC
         9Ybt+ttshKSFBh++aV15mZVyXlFO1ZMU6BTUun8vGjdujc16KsNdzBQUlBwHevspi5mE
         af3XoVG20xDt5wYVZzNUrElxaoiAz7/LXDAz3wDjlmEmD0U17+x6hyrDGQANMA2+HKOL
         V33A==
X-Gm-Message-State: ACrzQf3OYe7/xtNZftn3VY8N01nfjCESCZhMQ4DE0q0ReUobt+MrtmG/
        tha4NzaIDPTt3k05syOnyjw=
X-Google-Smtp-Source: AMsMyM47/rVC6avgrBDqVXzsmRxaZF4fFTnlT3jhL2Jzg4kOeJ380zTeWYQVXYsbUTrE8jDhbGlTOw==
X-Received: by 2002:a05:6a00:1410:b0:528:5a5a:d846 with SMTP id l16-20020a056a00141000b005285a5ad846mr93329pfu.9.1664403735320;
        Wed, 28 Sep 2022 15:22:15 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:1a91:59b8:faf:7b4f])
        by smtp.gmail.com with ESMTPSA id ru21-20020a17090b2bd500b002008a85bac1sm2023694pjb.49.2022.09.28.15.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 15:22:14 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] wireless: wl1251: switch to using gpiod API
Date:   Wed, 28 Sep 2022 15:22:10 -0700
Message-Id: <20220928222210.1922758-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220928222210.1922758-1-dmitry.torokhov@gmail.com>
References: <20220928222210.1922758-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
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

This switches the driver from legacy gpio API to a newer gpiod API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/net/wireless/ti/wl1251/spi.c    | 63 +++++++++++++------------
 drivers/net/wireless/ti/wl1251/wl1251.h |  1 -
 2 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/spi.c b/drivers/net/wireless/ti/wl1251/spi.c
index 08d9814b49c1..0ef590a6db53 100644
--- a/drivers/net/wireless/ti/wl1251/spi.c
+++ b/drivers/net/wireless/ti/wl1251/spi.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2008 Nokia Corporation
  */
 
+#include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/module.h>
@@ -12,15 +13,19 @@
 #include <linux/swab.h>
 #include <linux/crc7.h>
 #include <linux/spi/spi.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/regulator/consumer.h>
 
 #include "wl1251.h"
 #include "reg.h"
 #include "spi.h"
 
+struct wl1251_spi {
+	struct spi_device *spi;
+	struct gpio_desc *power_gpio;
+};
+
 static irqreturn_t wl1251_irq(int irq, void *cookie)
 {
 	struct wl1251 *wl;
@@ -34,13 +39,9 @@ static irqreturn_t wl1251_irq(int irq, void *cookie)
 	return IRQ_HANDLED;
 }
 
-static struct spi_device *wl_to_spi(struct wl1251 *wl)
-{
-	return wl->if_priv;
-}
-
 static void wl1251_spi_reset(struct wl1251 *wl)
 {
+	struct wl1251_spi *wl_spi = wl->if_priv;
 	u8 *cmd;
 	struct spi_transfer t;
 	struct spi_message m;
@@ -60,7 +61,7 @@ static void wl1251_spi_reset(struct wl1251 *wl)
 	t.len = WSPI_INIT_CMD_LEN;
 	spi_message_add_tail(&t, &m);
 
-	spi_sync(wl_to_spi(wl), &m);
+	spi_sync(wl_spi->spi, &m);
 
 	wl1251_dump(DEBUG_SPI, "spi reset -> ", cmd, WSPI_INIT_CMD_LEN);
 
@@ -69,6 +70,7 @@ static void wl1251_spi_reset(struct wl1251 *wl)
 
 static void wl1251_spi_wake(struct wl1251 *wl)
 {
+	struct wl1251_spi *wl_spi = wl->if_priv;
 	struct spi_transfer t;
 	struct spi_message m;
 	u8 *cmd = kzalloc(WSPI_INIT_CMD_LEN, GFP_KERNEL);
@@ -112,7 +114,7 @@ static void wl1251_spi_wake(struct wl1251 *wl)
 	t.len = WSPI_INIT_CMD_LEN;
 	spi_message_add_tail(&t, &m);
 
-	spi_sync(wl_to_spi(wl), &m);
+	spi_sync(wl_spi->spi, &m);
 
 	wl1251_dump(DEBUG_SPI, "spi init -> ", cmd, WSPI_INIT_CMD_LEN);
 
@@ -128,6 +130,7 @@ static void wl1251_spi_reset_wake(struct wl1251 *wl)
 static void wl1251_spi_read(struct wl1251 *wl, int addr, void *buf,
 			    size_t len)
 {
+	struct wl1251_spi *wl_spi = wl->if_priv;
 	struct spi_transfer t[3];
 	struct spi_message m;
 	u8 *busy_buf;
@@ -157,7 +160,7 @@ static void wl1251_spi_read(struct wl1251 *wl, int addr, void *buf,
 	t[2].len = len;
 	spi_message_add_tail(&t[2], &m);
 
-	spi_sync(wl_to_spi(wl), &m);
+	spi_sync(wl_spi->spi, &m);
 
 	/* FIXME: check busy words */
 
@@ -168,6 +171,7 @@ static void wl1251_spi_read(struct wl1251 *wl, int addr, void *buf,
 static void wl1251_spi_write(struct wl1251 *wl, int addr, void *buf,
 			     size_t len)
 {
+	struct wl1251_spi *wl_spi = wl->if_priv;
 	struct spi_transfer t[2];
 	struct spi_message m;
 	u32 *cmd;
@@ -190,7 +194,7 @@ static void wl1251_spi_write(struct wl1251 *wl, int addr, void *buf,
 	t[1].len = len;
 	spi_message_add_tail(&t[1], &m);
 
-	spi_sync(wl_to_spi(wl), &m);
+	spi_sync(wl_spi->spi, &m);
 
 	wl1251_dump(DEBUG_SPI, "spi_write cmd -> ", cmd, sizeof(*cmd));
 	wl1251_dump(DEBUG_SPI, "spi_write buf -> ", buf, len);
@@ -208,8 +212,10 @@ static void wl1251_spi_disable_irq(struct wl1251 *wl)
 
 static int wl1251_spi_set_power(struct wl1251 *wl, bool enable)
 {
-	if (gpio_is_valid(wl->power_gpio))
-		gpio_set_value(wl->power_gpio, enable);
+	struct wl1251_spi *wl_spi = wl->if_priv;
+
+	if (wl_spi->power_gpio)
+		gpiod_set_value_cansleep(wl_spi->power_gpio, enable);
 
 	return 0;
 }
@@ -227,12 +233,19 @@ static int wl1251_spi_probe(struct spi_device *spi)
 {
 	struct device_node *np = spi->dev.of_node;
 	struct ieee80211_hw *hw;
+	struct wl1251_spi *wl_spi;
 	struct wl1251 *wl;
 	int ret;
 
 	if (!np)
 		return -ENODEV;
 
+	wl_spi = devm_kzalloc(&spi->dev, sizeof(*wl_spi), GFP_KERNEL);
+	if (!wl_spi)
+		return -ENOMEM;
+
+	wl_spi->spi = spi;
+
 	hw = wl1251_alloc_hw();
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
@@ -241,7 +254,7 @@ static int wl1251_spi_probe(struct spi_device *spi)
 
 	SET_IEEE80211_DEV(hw, &spi->dev);
 	spi_set_drvdata(spi, wl);
-	wl->if_priv = spi;
+	wl->if_priv = wl_spi;
 	wl->if_ops = &wl1251_spi_ops;
 
 	/* This is the only SPI value that we need to set here, the rest
@@ -257,25 +270,17 @@ static int wl1251_spi_probe(struct spi_device *spi)
 
 	wl->use_eeprom = of_property_read_bool(np, "ti,wl1251-has-eeprom");
 
-	wl->power_gpio = of_get_named_gpio(np, "ti,power-gpio", 0);
-	if (wl->power_gpio == -EPROBE_DEFER) {
-		ret = -EPROBE_DEFER;
-		goto out_free;
-	}
-
-	if (gpio_is_valid(wl->power_gpio)) {
-		ret = devm_gpio_request_one(&spi->dev, wl->power_gpio,
-					GPIOF_OUT_INIT_LOW, "wl1251 power");
-		if (ret) {
+	wl_spi->power_gpio = devm_gpiod_get(&spi->dev, "ti,power",
+					    GPIOD_OUT_LOW);
+	ret = PTR_ERR_OR_ZERO(wl_spi->power_gpio);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
 			wl1251_error("Failed to request gpio: %d\n", ret);
-			goto out_free;
-		}
-	} else {
-		wl1251_error("set power gpio missing in platform data");
-		ret = -ENODEV;
 		goto out_free;
 	}
 
+	gpiod_set_consumer_name(wl_spi->power_gpio, "wl1251 power");
+
 	wl->irq = spi->irq;
 	if (wl->irq < 0) {
 		wl1251_error("irq missing in platform data");
diff --git a/drivers/net/wireless/ti/wl1251/wl1251.h b/drivers/net/wireless/ti/wl1251/wl1251.h
index 23ae07dd4c2e..83adbc3c25dc 100644
--- a/drivers/net/wireless/ti/wl1251/wl1251.h
+++ b/drivers/net/wireless/ti/wl1251/wl1251.h
@@ -262,7 +262,6 @@ struct wl1251 {
 	void *if_priv;
 	const struct wl1251_if_operations *if_ops;
 
-	int power_gpio;
 	int irq;
 	bool use_eeprom;
 
-- 
2.38.0.rc1.362.ged0d419d3c-goog

