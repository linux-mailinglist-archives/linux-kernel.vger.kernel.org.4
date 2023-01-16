Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F02766BE1D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjAPMqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjAPMqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:46:36 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 717138698;
        Mon, 16 Jan 2023 04:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673873195; x=1705409195;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cV2t2J41BPlMwIKrRYG/9Xa0hABR7bL6sMDaCR/ixl0=;
  b=L6rZGFZMWqLZpbJoBX59s1VCVfW55CjZNh/5zHu091TKy2JRRJR1vpyn
   AKpGOwnZJ3I7nLkh6UCi9ueZ5HbD7j8R5y+Ay9npUxDlRjQ4Jp3VKezBT
   jz9vizkqHxlvqtuUOZ4qnIZgRfZZyHV6F7UVIn2C1X/H1FttaGdPt2St9
   88IwJ+wP8+NgmKfxkSGuNXhtXxDZvMDqBwezv8R0OoAYBNam5EH34N8HK
   6zrO8TtsG6eiaiMf47FmA2Lx29wBe31Cn8qN5da/2RBBHm+ZZu9Hg0lBQ
   6SLzOQ+WjU2Runjh/GsiLIwrGRZJ9juHy3cgSHJLmUih2g+AbHGKdhVtb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="308009850"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="308009850"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 04:46:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="782895856"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="782895856"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 16 Jan 2023 04:46:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AC4061A3; Mon, 16 Jan 2023 14:47:06 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH v1 1/3] gpio: pcf857x: Get rid of legacy platform data
Date:   Mon, 16 Jan 2023 14:47:02 +0200
Message-Id: <20230116124704.30470-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform data is a legacy interface to supply device properties
to the driver. In this case we don't have in-kernel users for it.
Moreover it uses plain GPIO numbers which is no-no for a new code.

Just remove it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/gpio/gpio-pcf857x.c           | 34 ++------------------
 include/linux/platform_data/pcf857x.h | 45 ---------------------------
 2 files changed, 2 insertions(+), 77 deletions(-)
 delete mode 100644 include/linux/platform_data/pcf857x.h

diff --git a/drivers/gpio/gpio-pcf857x.c b/drivers/gpio/gpio-pcf857x.c
index d9db878802b7..dfa15444a24a 100644
--- a/drivers/gpio/gpio-pcf857x.c
+++ b/drivers/gpio/gpio-pcf857x.c
@@ -7,7 +7,6 @@
 
 #include <linux/gpio/driver.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/pcf857x.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
@@ -18,7 +17,6 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 
-
 static const struct i2c_device_id pcf857x_id[] = {
 	{ "pcf8574", 8 },
 	{ "pcf8574a", 8 },
@@ -277,18 +275,12 @@ static const struct irq_chip pcf857x_irq_chip = {
 static int pcf857x_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
-	struct pcf857x_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct device_node *np = client->dev.of_node;
 	struct pcf857x *gpio;
 	unsigned int n_latch = 0;
 	int status;
 
-	if (IS_ENABLED(CONFIG_OF) && np)
-		of_property_read_u32(np, "lines-initial-states", &n_latch);
-	else if (pdata)
-		n_latch = pdata->n_latch;
-	else
-		dev_dbg(&client->dev, "no platform data\n");
+	of_property_read_u32(np, "lines-initial-states", &n_latch);
 
 	/* Allocate, initialize, and register this gpio_chip. */
 	gpio = devm_kzalloc(&client->dev, sizeof(*gpio), GFP_KERNEL);
@@ -297,7 +289,7 @@ static int pcf857x_probe(struct i2c_client *client)
 
 	mutex_init(&gpio->lock);
 
-	gpio->chip.base			= pdata ? pdata->gpio_base : -1;
+	gpio->chip.base			= -1;
 	gpio->chip.can_sleep		= true;
 	gpio->chip.parent		= &client->dev;
 	gpio->chip.owner		= THIS_MODULE;
@@ -406,17 +398,6 @@ static int pcf857x_probe(struct i2c_client *client)
 	if (status < 0)
 		goto fail;
 
-	/* Let platform code set up the GPIOs and their users.
-	 * Now is the first time anyone could use them.
-	 */
-	if (pdata && pdata->setup) {
-		status = pdata->setup(client,
-				gpio->chip.base, gpio->chip.ngpio,
-				pdata->context);
-		if (status < 0)
-			dev_warn(&client->dev, "setup --> %d\n", status);
-	}
-
 	dev_info(&client->dev, "probed\n");
 
 	return 0;
@@ -428,16 +409,6 @@ static int pcf857x_probe(struct i2c_client *client)
 	return status;
 }
 
-static void pcf857x_remove(struct i2c_client *client)
-{
-	struct pcf857x_platform_data *pdata = dev_get_platdata(&client->dev);
-	struct pcf857x *gpio = i2c_get_clientdata(client);
-
-	if (pdata && pdata->teardown)
-		pdata->teardown(client, gpio->chip.base, gpio->chip.ngpio,
-				pdata->context);
-}
-
 static void pcf857x_shutdown(struct i2c_client *client)
 {
 	struct pcf857x *gpio = i2c_get_clientdata(client);
@@ -452,7 +423,6 @@ static struct i2c_driver pcf857x_driver = {
 		.of_match_table = of_match_ptr(pcf857x_of_table),
 	},
 	.probe_new = pcf857x_probe,
-	.remove	= pcf857x_remove,
 	.shutdown = pcf857x_shutdown,
 	.id_table = pcf857x_id,
 };
diff --git a/include/linux/platform_data/pcf857x.h b/include/linux/platform_data/pcf857x.h
deleted file mode 100644
index 01d0a3ea3aef..000000000000
--- a/include/linux/platform_data/pcf857x.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_PCF857X_H
-#define __LINUX_PCF857X_H
-
-/**
- * struct pcf857x_platform_data - data to set up pcf857x driver
- * @gpio_base: number of the chip's first GPIO
- * @n_latch: optional bit-inverse of initial register value; if
- *	you leave this initialized to zero the driver will act
- *	like the chip was just reset
- * @setup: optional callback issued once the GPIOs are valid
- * @teardown: optional callback issued before the GPIOs are invalidated
- * @context: optional parameter passed to setup() and teardown()
- *
- * In addition to the I2C_BOARD_INFO() state appropriate to each chip,
- * the i2c_board_info used with the pcf875x driver must provide its
- * platform_data (pointer to one of these structures) with at least
- * the gpio_base value initialized.
- *
- * The @setup callback may be used with the kind of board-specific glue
- * which hands the (now-valid) GPIOs to other drivers, or which puts
- * devices in their initial states using these GPIOs.
- *
- * These GPIO chips are only "quasi-bidirectional"; read the chip specs
- * to understand the behavior.  They don't have separate registers to
- * record which pins are used for input or output, record which output
- * values are driven, or provide access to input values.  That must be
- * inferred by reading the chip's value and knowing the last value written
- * to it.  If you leave n_latch initialized to zero, that last written
- * value is presumed to be all ones (as if the chip were just reset).
- */
-struct pcf857x_platform_data {
-	unsigned	gpio_base;
-	unsigned	n_latch;
-
-	int		(*setup)(struct i2c_client *client,
-					int gpio, unsigned ngpio,
-					void *context);
-	void		(*teardown)(struct i2c_client *client,
-					int gpio, unsigned ngpio,
-					void *context);
-	void		*context;
-};
-
-#endif /* __LINUX_PCF857X_H */
-- 
2.39.0

