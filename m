Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CE96236BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 23:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbiKIWnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 17:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiKIWnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 17:43:00 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332E51D652;
        Wed,  9 Nov 2022 14:42:59 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k7so45404pll.6;
        Wed, 09 Nov 2022 14:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0G2DVVUMf7cHKHLQzDr07aNL++y343oa2P66Ro/wtY=;
        b=Yg7m1C87ehGWJ0w9aL96YvWkzYmmCr+af4ui+VJ5BMmxIV2ip9zdJ7eHn6Hxamxhl7
         Y9YSTagO8x/N4V2I6ds6OyC94yanCRqY7fO75z4KTnmzHMpzRKip1zXjjAdrIisA1o0D
         Ah70biHSSNT6Z5VIHPDYFxnAKjoVlYPkZJLN148s+Hk1lx4J71Hc13q6d+/bQ0Vj5Br+
         U2/5FsW7jxyXdkDHvolMddQZiq6502jUHvY1Q45TJC1zvQnx3mICJmC3JUgyV3eam+kY
         B/y48BY6yHPcDWzM3nPIxEUWlM+ACoslnTDnXXbzmjcgCOM0delXajF/RWMTZiZIVgpb
         OsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0G2DVVUMf7cHKHLQzDr07aNL++y343oa2P66Ro/wtY=;
        b=oCFh/8/2l5HtuaERJOjUiEt1tDzalRJeUpUbY4ndYPaYV0RK/sVZXLJTxFB95D0f0C
         qJJQXSbXKfuxDUMsqXb0CEfNAQ5TYt0BDcUIXBP4+VZsnakXS88zon/FRFWVH3iNEhvf
         DU5QhZ8NJg8joMJWo/rhpCQSJIKx9qHUJ+Kld2qJH3h/Rz5V+cxiv67VFsfebfRDziUo
         h/Qa/Q9BnIt+MKVNsKt5EgHDeD6622/L32cw/TtV1tsaO+mNr32iTVEB9xJNCffdi/OE
         2lALmN4kldWxqVwr/mAy2muA6nmv7kJ7L4rzh3S+lYJD8kDQx61W5mk0vmf7dOJa84JP
         TMtg==
X-Gm-Message-State: ACrzQf2Kq10Jpsb2pHn4hDVkS+6/Tqv63DQYXxodDOsntqsZGvUpkF9t
        AYwBynRNJjRhvCSF6xKAWLA=
X-Google-Smtp-Source: AMsMyM61KxZswexhsZBY5bwcQnS4oyux6d1zp+O1TPaSPkgFxuH4rRDgEfogMkt4J4r6K4IxX7xC7Q==
X-Received: by 2002:a17:90a:74cb:b0:213:9b4c:ecc2 with SMTP id p11-20020a17090a74cb00b002139b4cecc2mr65576018pjl.154.1668033778453;
        Wed, 09 Nov 2022 14:42:58 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:6af4:9e55:5482:c0de])
        by smtp.gmail.com with ESMTPSA id k17-20020a63ff11000000b0046f9f4a2de6sm7995042pgi.74.2022.11.09.14.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:42:57 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH v2 3/3] wifi: wl1251: switch to using gpiod API
Date:   Wed,  9 Nov 2022 14:42:50 -0800
Message-Id: <20221109224250.2885119-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
In-Reply-To: <20221109224250.2885119-1-dmitry.torokhov@gmail.com>
References: <20221109224250.2885119-1-dmitry.torokhov@gmail.com>
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

Switch the driver from legacy gpio API to the newer gpiod API.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/net/wireless/ti/wl1251/spi.c    | 63 +++++++++++++------------
 drivers/net/wireless/ti/wl1251/wl1251.h |  1 -
 2 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/ti/wl1251/spi.c b/drivers/net/wireless/ti/wl1251/spi.c
index 08d9814b49c1..29292f06bd3d 100644
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
+	wl_spi->power_gpio = devm_gpiod_get_optional(&spi->dev, "ti,power",
+						     GPIOD_OUT_LOW);
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
2.38.1.431.g37b22c650d-goog

