Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F1D6839C6
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 23:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjAaW50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 17:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjAaW5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 17:57:15 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4093C30;
        Tue, 31 Jan 2023 14:57:13 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n20-20020a17090aab9400b00229ca6a4636so212608pjq.0;
        Tue, 31 Jan 2023 14:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kpHHAw+i1ZP/EdJYy8iLuB5fyNZHOMf4w2HHkl2VS3k=;
        b=aK7X6+aPOLty1cU5iJDPudo7Et/cOC8RejVJ0Z7h4CPmE3GCVqCrqoWmSWmjefY5fq
         ToGJYbRfEFCB7CtQTbEPIczBYoRKPvnrooecqPfLMMo8/aBTcBvIdu+DFlf7vNKaV+ZO
         ogA34MLPbXMnvLbh5EItV4TKxPGo/Fd93CCGjm+9tRKqJMRBYVAZx7k32GER2hkvsYRY
         bXGDHOe39IOugodjLDAlYfvWg00kafQgtYdeCPO8TLw4DG2SnuRP55YJOYabyIpJDmyM
         xc7oo+Tq/N0Q2WkNmURx0pIsIAemFzBnBDhVuyHW5ro4Aa1Z30iGidKMdtgtTZAaxaJ1
         rNJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kpHHAw+i1ZP/EdJYy8iLuB5fyNZHOMf4w2HHkl2VS3k=;
        b=YZaBqUAfVFTjdEm2we7w+MW/aUVlebj1NXAHHn2edVToPjWV0g/vRUczpGw6LsnZrP
         Q3CyJv33bnGKkgzNFs8u0pCgQW8RGd68vFIXPRBh8qvyenkaGJWFGVfwrKPD9gqEpDvt
         9voLA2v8Da/huRJxUTDLTqvcNVniCnR3428OJnUNqieL315FOVPnZ14mmDAEQaHrYW+A
         RR921e6PPbUHosuOkUWHCQ037GhuSv2JlH3+CVNHF+8i6OynsqxMuygRLAKxalk6E2FD
         EsqHUGMWfsYg6J+iBiSgT4zuG/l5g494qlB2Nm+NuG6LxkR5cQXRFErr0YSoon23X0ep
         QCEg==
X-Gm-Message-State: AO0yUKWG72XBU12St/hDtj948P5pmOQeYvXELD2Sh6knqicf1aAWTDIu
        JayxC6phC/3dHh+nqUY6vbY=
X-Google-Smtp-Source: AK7set+Ji9OBJYURmyAYP9SXKiCgfigEX/0ltPB+8ioE1R+p9GdDWYdYRNMDhDIUCGcMkMbFfgWA2w==
X-Received: by 2002:a17:902:dac5:b0:195:e577:231c with SMTP id q5-20020a170902dac500b00195e577231cmr759984plx.31.1675205832830;
        Tue, 31 Jan 2023 14:57:12 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:effb:a74f:225a:28ef])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902b20300b001963bc7bdb8sm10229945plr.274.2023.01.31.14.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:57:12 -0800 (PST)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>
Cc:     Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] backlight: hx8357: switch to using gpiod API
Date:   Tue, 31 Jan 2023 14:57:06 -0800
Message-Id: <20230131225707.3599889-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
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

Switch the driver from legacy gpio API that is deprecated to the newer
gpiod API that respects line polarities described in ACPI/DT.

This makes driver use standard property name for the reset gpio
("reset-gpios" vs "gpios-reset"), however there is a quirk in gpiolib
to also recognize the legacy name and keep compatibility with older
DTSes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

All preparation gpiolib work to handle legacy names and polarity quirks
has landed in mainline...

 drivers/video/backlight/hx8357.c | 82 ++++++++++++++------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/drivers/video/backlight/hx8357.c b/drivers/video/backlight/hx8357.c
index 9b50bc96e00f..a93e14adb846 100644
--- a/drivers/video/backlight/hx8357.c
+++ b/drivers/video/backlight/hx8357.c
@@ -6,11 +6,12 @@
  */
 
 #include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/lcd.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/spi/spi.h>
 
 #define HX8357_NUM_IM_PINS	3
@@ -83,8 +84,8 @@
 #define HX8369_SET_GAMMA_CURVE_RELATED		0xe0
 
 struct hx8357_data {
-	unsigned		im_pins[HX8357_NUM_IM_PINS];
-	unsigned		reset;
+	struct gpio_desc	*im_pins[HX8357_NUM_IM_PINS];
+	struct gpio_desc	*reset;
 	struct spi_device	*spi;
 	int			state;
 	bool			use_im_pins;
@@ -321,11 +322,11 @@ static void hx8357_lcd_reset(struct lcd_device *lcdev)
 	struct hx8357_data *lcd = lcd_get_data(lcdev);
 
 	/* Reset the screen */
-	gpio_set_value(lcd->reset, 1);
+	gpiod_set_value_cansleep(lcd->reset, 0);
 	usleep_range(10000, 12000);
-	gpio_set_value(lcd->reset, 0);
+	gpiod_set_value_cansleep(lcd->reset, 1);
 	usleep_range(10000, 12000);
-	gpio_set_value(lcd->reset, 1);
+	gpiod_set_value_cansleep(lcd->reset, 0);
 
 	/* The controller needs 120ms to recover from reset */
 	msleep(120);
@@ -341,9 +342,9 @@ static int hx8357_lcd_init(struct lcd_device *lcdev)
 	 * wires
 	 */
 	if (lcd->use_im_pins) {
-		gpio_set_value_cansleep(lcd->im_pins[0], 1);
-		gpio_set_value_cansleep(lcd->im_pins[1], 0);
-		gpio_set_value_cansleep(lcd->im_pins[2], 1);
+		gpiod_set_value_cansleep(lcd->im_pins[0], 1);
+		gpiod_set_value_cansleep(lcd->im_pins[1], 0);
+		gpiod_set_value_cansleep(lcd->im_pins[2], 1);
 	}
 
 	ret = hx8357_spi_write_array(lcdev, hx8357_seq_power,
@@ -601,48 +602,39 @@ static int hx8357_probe(struct spi_device *spi)
 	if (!match || !match->data)
 		return -EINVAL;
 
-	lcd->reset = of_get_named_gpio(spi->dev.of_node, "gpios-reset", 0);
-	if (!gpio_is_valid(lcd->reset)) {
-		dev_err(&spi->dev, "Missing dt property: gpios-reset\n");
-		return -EINVAL;
-	}
-
-	ret = devm_gpio_request_one(&spi->dev, lcd->reset,
-				    GPIOF_OUT_INIT_HIGH,
-				    "hx8357-reset");
+	lcd->reset = devm_gpiod_get(&spi->dev, "reset", GPIOD_OUT_LOW);
+	ret = PTR_ERR_OR_ZERO(lcd->reset);
 	if (ret) {
-		dev_err(&spi->dev,
-			"failed to request gpio %d: %d\n",
-			lcd->reset, ret);
-		return -EINVAL;
+		dev_err(&spi->dev, "failed to request reset gpio: %d\n", ret);
+		return ret;
 	}
 
-	if (of_find_property(spi->dev.of_node, "im-gpios", NULL)) {
-		lcd->use_im_pins = 1;
-
-		for (i = 0; i < HX8357_NUM_IM_PINS; i++) {
-			lcd->im_pins[i] = of_get_named_gpio(spi->dev.of_node,
-							    "im-gpios", i);
-			if (lcd->im_pins[i] == -EPROBE_DEFER) {
-				dev_info(&spi->dev, "GPIO requested is not here yet, deferring the probe\n");
-				return -EPROBE_DEFER;
-			}
-			if (!gpio_is_valid(lcd->im_pins[i])) {
-				dev_err(&spi->dev, "Missing dt property: im-gpios\n");
-				return -EINVAL;
+	gpiod_set_consumer_name(lcd->reset, "hx8357-reset");
+
+	for (i = 0; i < HX8357_NUM_IM_PINS; i++) {
+		lcd->im_pins[i] = devm_gpiod_get_index(&spi->dev,
+						       "im", i, GPIOD_OUT_LOW);
+		ret = PTR_ERR_OR_ZERO(lcd->im_pins[i]);
+		if (ret) {
+			if (ret == -ENOENT) {
+				if (i == 0)
+					break;
+				dev_err(&spi->dev, "Missing im gpios[%d]\n", i);
+				ret = -EINVAL;
+			} if (ret == -EPROBE_DEFER) {
+				dev_info(&spi->dev, "im gpio[%d] is not here yet, deferring the probe\n",
+					 i);
+			} else {
+				dev_err(&spi->dev, "failed to request im gpio[%d]: %d\n",
+					i, ret);
 			}
 
-			ret = devm_gpio_request_one(&spi->dev, lcd->im_pins[i],
-						    GPIOF_OUT_INIT_LOW,
-						    "im_pins");
-			if (ret) {
-				dev_err(&spi->dev, "failed to request gpio %d: %d\n",
-					lcd->im_pins[i], ret);
-				return -EINVAL;
-			}
+			return ret;
 		}
-	} else {
-		lcd->use_im_pins = 0;
+
+		gpiod_set_consumer_name(lcd->im_pins[i], "im_pins");
+
+		lcd->use_im_pins = true;
 	}
 
 	lcdev = devm_lcd_device_register(&spi->dev, "mxsfb", &spi->dev, lcd,
-- 
2.39.1.456.gfc5497dd1b-goog

