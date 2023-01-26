Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64D967CC23
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbjAZN2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236877AbjAZN2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:28:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA19A7EC5;
        Thu, 26 Jan 2023 05:28:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 479AE617DA;
        Thu, 26 Jan 2023 13:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27FDC4339B;
        Thu, 26 Jan 2023 13:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674739697;
        bh=yam+jLkV2aIotM+LcFhs3VFxetZhu0iwa3c53kK12Jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nxb42sJq248/EkqVNmMy+cif6Q4Gc6oIGMFIS55ig/oyRuIPgiKJeKE+pRsud452+
         FikPBlZ5y+hbCtO1wdhKst7RZxXqvUqihaxLESc/4WnSzRGZ13U6J2wGZ4a+CZJbbO
         OdbDoItl0q45ubTUZnjXwWB5q11LAA/f5bl4b8uJH+X+f4AbyI5pjopNgjONF4FUMB
         dtk5bbeUBzzl+42GvvfCpMTx+nj5aCtYMoW7d2yVOgaxJIOPWFGZpyxmJ2bFbQn+OK
         q1shCykGkYitaqaqwVVEbBlCy68ZBK5qGDx8hlTBASR9rq4OTA/D76Dj2458aUzOza
         V/D+h2dvWPplw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-gpio@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] gpiolib: remove gpio_set_debounce
Date:   Thu, 26 Jan 2023 14:27:57 +0100
Message-Id: <20230126132801.2042371-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230126132801.2042371-1-arnd@kernel.org>
References: <20230126132801.2042371-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gpio_set_debounce() only has a single user, which is trivially
converted to gpiod_set_debounce().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/driver-api/gpio/legacy.rst |  2 --
 drivers/input/touchscreen/ads7846.c      | 24 +++++++++++++-----------
 include/linux/gpio.h                     | 22 ----------------------
 3 files changed, 13 insertions(+), 35 deletions(-)

diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/driver-api/gpio/legacy.rst
index a0559d93efd1..e0306e78e34b 100644
--- a/Documentation/driver-api/gpio/legacy.rst
+++ b/Documentation/driver-api/gpio/legacy.rst
@@ -238,8 +238,6 @@ setup or driver probe/teardown code, so this is an easy constraint.)::
         ## 	gpio_free_array()
 
                 gpio_free()
-                gpio_set_debounce()
-
 
 
 Claiming and Releasing GPIOs
diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 4c3dd01902d0..354da71ff037 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -27,6 +27,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/of_device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/gpio.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
@@ -139,7 +140,7 @@ struct ads7846 {
 	int			(*filter)(void *data, int data_idx, int *val);
 	void			*filter_data;
 	int			(*get_pendown_state)(void);
-	int			gpio_pendown;
+	struct gpio_desc	*gpio_pendown;
 
 	void			(*wait_for_sync)(void);
 };
@@ -222,7 +223,7 @@ static int get_pendown_state(struct ads7846 *ts)
 	if (ts->get_pendown_state)
 		return ts->get_pendown_state();
 
-	return !gpio_get_value(ts->gpio_pendown);
+	return !gpiod_get_value(ts->gpio_pendown);
 }
 
 static void ads7846_report_pen_up(struct ads7846 *ts)
@@ -1005,7 +1006,6 @@ static int ads7846_setup_pendown(struct spi_device *spi,
 	if (pdata->get_pendown_state) {
 		ts->get_pendown_state = pdata->get_pendown_state;
 	} else if (gpio_is_valid(pdata->gpio_pendown)) {
-
 		err = devm_gpio_request_one(&spi->dev, pdata->gpio_pendown,
 					    GPIOF_IN, "ads7846_pendown");
 		if (err) {
@@ -1015,15 +1015,17 @@ static int ads7846_setup_pendown(struct spi_device *spi,
 			return err;
 		}
 
-		ts->gpio_pendown = pdata->gpio_pendown;
-
-		if (pdata->gpio_pendown_debounce)
-			gpio_set_debounce(pdata->gpio_pendown,
-					  pdata->gpio_pendown_debounce);
+		ts->gpio_pendown = gpio_to_desc(pdata->gpio_pendown);
 	} else {
-		dev_err(&spi->dev, "no get_pendown_state nor gpio_pendown?\n");
-		return -EINVAL;
+		ts->gpio_pendown = gpiod_get(&spi->dev, "pendown-gpio", GPIOD_IN);
+		if (IS_ERR(ts->gpio_pendown)) {
+			dev_err(&spi->dev, "no get_pendown_state nor gpio_pendown?\n");
+			return PTR_ERR(ts->gpio_pendown);
+		}
 	}
+	if (pdata->gpio_pendown_debounce)
+		gpiod_set_debounce(ts->gpio_pendown,
+				   pdata->gpio_pendown_debounce);
 
 	return 0;
 }
@@ -1192,7 +1194,7 @@ static const struct ads7846_platform_data *ads7846_probe_dt(struct device *dev)
 	pdata->wakeup = of_property_read_bool(node, "wakeup-source") ||
 			of_property_read_bool(node, "linux,wakeup");
 
-	pdata->gpio_pendown = of_get_named_gpio(dev->of_node, "pendown-gpio", 0);
+	pdata->gpio_pendown = -1;
 
 	return pdata;
 }
diff --git a/include/linux/gpio.h b/include/linux/gpio.h
index e273a3287d8e..da7a5ae68e47 100644
--- a/include/linux/gpio.h
+++ b/include/linux/gpio.h
@@ -100,11 +100,6 @@ static inline int gpio_direction_output(unsigned gpio, int value)
 	return gpiod_direction_output_raw(gpio_to_desc(gpio), value);
 }
 
-static inline int gpio_set_debounce(unsigned gpio, unsigned debounce)
-{
-	return gpiod_set_debounce(gpio_to_desc(gpio), debounce);
-}
-
 static inline int gpio_get_value_cansleep(unsigned gpio)
 {
 	return gpiod_get_raw_value_cansleep(gpio_to_desc(gpio));
@@ -123,11 +118,6 @@ static inline void gpio_set_value(unsigned gpio, int value)
 	return gpiod_set_raw_value(gpio_to_desc(gpio), value);
 }
 
-static inline int gpio_cansleep(unsigned gpio)
-{
-	return gpiod_cansleep(gpio_to_desc(gpio));
-}
-
 static inline int gpio_to_irq(unsigned gpio)
 {
 	return gpiod_to_irq(gpio_to_desc(gpio));
@@ -215,11 +205,6 @@ static inline int gpio_direction_output(unsigned gpio, int value)
 	return -ENOSYS;
 }
 
-static inline int gpio_set_debounce(unsigned gpio, unsigned debounce)
-{
-	return -ENOSYS;
-}
-
 static inline int gpio_get_value(unsigned gpio)
 {
 	/* GPIO can never have been requested or set as {in,out}put */
@@ -233,13 +218,6 @@ static inline void gpio_set_value(unsigned gpio, int value)
 	WARN_ON(1);
 }
 
-static inline int gpio_cansleep(unsigned gpio)
-{
-	/* GPIO can never have been requested or set as {in,out}put */
-	WARN_ON(1);
-	return 0;
-}
-
 static inline int gpio_get_value_cansleep(unsigned gpio)
 {
 	/* GPIO can never have been requested or set as {in,out}put */
-- 
2.39.0

