Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C925640AC2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234182AbiLBQ2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbiLBQ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:27:34 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDECDEE4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:27:30 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id o12so3744656qvn.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mrsAlc2c8LXGp7WQkoKW27oUacFsP+5WvZ7Q3a50qLY=;
        b=InlSDr9iWrec+0Nv5Bkx+gAGnOJWGHWuV1OvjAV/RbNYsalnb0hMJCayLSkAVxwbiH
         FhsAiTA9aWtQALoofevhmY3pkCxPre09rqTHiEJawvU8kjq69k3BLWvU8IwmqEmwIWzb
         rBwIH7gPWXBjF0zU3aqY9m+XOkhjsenEGnNoituXM5rBMTJ09hO2delHbaB3wKQUR/AK
         U5sKrjxBolB7nVhsYs6jaRYtSiWSlPB7lt12DHn+kDPJS6KZhakW2af+VEfxOHa3rI4b
         8I3bNC1qCKlY7/njqOH8m3MMzfU637IYS6gGHymr5hg5n8PgjplWRekoX1N+7IuYK6Vp
         bRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mrsAlc2c8LXGp7WQkoKW27oUacFsP+5WvZ7Q3a50qLY=;
        b=TAG0Ivf28d1lMYqFfb0Y4vzbApN20h6SpJVChxE0yfZOvyXzFlCnMdrzF3XhT6gsjm
         blb9hqS8nfafalCAGK/wy/saTVyQfTfSvFSLp+lo8/uUXB0nQdrBhTIcp9HefWBConl5
         8l73vgbVr/Gn13iun9Y27DmmhVJmdmHdkz0txmAkNJYoEC+OcMHXWkWYRSLMh0bYVzZl
         TOnqv5mZkvwR3+fvs2piwZn34ufPlCsqDX1CZctAgSi0yDLDoCCd4WT9+b6UwFZ24ZvP
         v1EMexm6vGzhwjk6MGFxJwA9D3u+ml6Tnm9LBoP8pM+iRPxERZLNyaMiZAUa5souvP+8
         FsGw==
X-Gm-Message-State: ANoB5pkf6GxCmkewSTMc36qDw2xqj4QYK7Wi1G+VXbLR+mhr70QigUVk
        T7tAeclXcZdUFCMoa/wwOXS1zw==
X-Google-Smtp-Source: AA0mqf5uU3PmQe9GzMiXN9bPa5FAR55Vv4Nhou7L6Wj9asjL6YTyg8XAh+5VdPCfoXjlVXgUggvFTg==
X-Received: by 2002:a0c:c3cc:0:b0:4c6:a05d:f67e with SMTP id p12-20020a0cc3cc000000b004c6a05df67emr48148268qvi.4.1669998449691;
        Fri, 02 Dec 2022 08:27:29 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id fp38-20020a05622a50a600b00343057845f7sm4391887qtb.20.2022.12.02.08.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:27:29 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 8/9] gpio: gpio-mm: Migrate to regmap API
Date:   Fri,  2 Dec 2022 11:27:14 -0500
Message-Id: <02e772baa38e25b5e7d3fe439d172afc8623485e.1669996867.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669996866.git.william.gray@linaro.org>
References: <cover.1669996866.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver. The gpio-mm module is migrated to the new i8255
library interface leveraging the gpio-regmap API.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-gpio-mm.c | 154 +++++++-----------------------------
 1 file changed, 30 insertions(+), 124 deletions(-)

diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index 2689671b6b01..43d823a56e59 100644
--- a/drivers/gpio/gpio-gpio-mm.c
+++ b/drivers/gpio/gpio-gpio-mm.c
@@ -8,13 +8,13 @@
  */
 #include <linux/device.h>
 #include <linux/errno.h>
-#include <linux/gpio/driver.h>
-#include <linux/io.h>
 #include <linux/ioport.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/regmap.h>
+#include <linux/types.h>
 
 #include "gpio-i8255.h"
 
@@ -30,83 +30,22 @@ MODULE_PARM_DESC(base, "Diamond Systems GPIO-MM base addresses");
 
 #define GPIOMM_NUM_PPI 2
 
-/**
- * struct gpiomm_gpio - GPIO device private data structure
- * @chip:		instance of the gpio_chip
- * @ppi_state:		Programmable Peripheral Interface group states
- * @ppi:		Programmable Peripheral Interface groups
- */
-struct gpiomm_gpio {
-	struct gpio_chip chip;
-	struct i8255_state ppi_state[GPIOMM_NUM_PPI];
-	struct i8255 __iomem *ppi;
+static const struct regmap_range gpiomm_volatile_ranges[] = {
+	i8255_volatile_regmap_range(0x0), i8255_volatile_regmap_range(0x4),
+};
+static const struct regmap_access_table gpiomm_volatile_table = {
+	.yes_ranges = gpiomm_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(gpiomm_volatile_ranges),
+};
+static const struct regmap_config gpiomm_regmap_config = {
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.val_bits = 8,
+	.io_port = true,
+	.max_register = 0x7,
+	.volatile_table = &gpiomm_volatile_table,
+	.cache_type = REGCACHE_FLAT,
 };
-
-static int gpiomm_gpio_get_direction(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-
-	if (i8255_get_direction(gpiommgpio->ppi_state, offset))
-		return GPIO_LINE_DIRECTION_IN;
-
-	return GPIO_LINE_DIRECTION_OUT;
-}
-
-static int gpiomm_gpio_direction_input(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-
-	i8255_direction_input(gpiommgpio->ppi, gpiommgpio->ppi_state, offset);
-
-	return 0;
-}
-
-static int gpiomm_gpio_direction_output(struct gpio_chip *chip,
-	unsigned int offset, int value)
-{
-	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-
-	i8255_direction_output(gpiommgpio->ppi, gpiommgpio->ppi_state, offset,
-			       value);
-
-	return 0;
-}
-
-static int gpiomm_gpio_get(struct gpio_chip *chip, unsigned int offset)
-{
-	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-
-	return i8255_get(gpiommgpio->ppi, offset);
-}
-
-static int gpiomm_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
-	unsigned long *bits)
-{
-	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-
-	i8255_get_multiple(gpiommgpio->ppi, mask, bits, chip->ngpio);
-
-	return 0;
-}
-
-static void gpiomm_gpio_set(struct gpio_chip *chip, unsigned int offset,
-	int value)
-{
-	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-
-	i8255_set(gpiommgpio->ppi, gpiommgpio->ppi_state, offset, value);
-}
-
-static void gpiomm_gpio_set_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
-{
-	struct gpiomm_gpio *const gpiommgpio = gpiochip_get_data(chip);
-
-	i8255_set_multiple(gpiommgpio->ppi, gpiommgpio->ppi_state, mask, bits,
-			   chip->ngpio);
-}
 
 #define GPIOMM_NGPIO 48
 static const char *gpiomm_names[GPIOMM_NGPIO] = {
@@ -120,30 +59,11 @@ static const char *gpiomm_names[GPIOMM_NGPIO] = {
 	"Port 2C2", "Port 2C3", "Port 2C4", "Port 2C5", "Port 2C6", "Port 2C7",
 };
 
-static void gpiomm_init_dio(struct i8255 __iomem *const ppi,
-			    struct i8255_state *const ppi_state)
-{
-	const unsigned long ngpio = 24;
-	const unsigned long mask = GENMASK(ngpio - 1, 0);
-	const unsigned long bits = 0;
-	unsigned long i;
-
-	/* Initialize all GPIO to output 0 */
-	for (i = 0; i < GPIOMM_NUM_PPI; i++) {
-		i8255_mode0_output(&ppi[i]);
-		i8255_set_multiple(&ppi[i], &ppi_state[i], &mask, &bits, ngpio);
-	}
-}
-
 static int gpiomm_probe(struct device *dev, unsigned int id)
 {
-	struct gpiomm_gpio *gpiommgpio;
 	const char *const name = dev_name(dev);
-	int err;
-
-	gpiommgpio = devm_kzalloc(dev, sizeof(*gpiommgpio), GFP_KERNEL);
-	if (!gpiommgpio)
-		return -ENOMEM;
+	struct i8255_regmap_config config = {};
+	void __iomem *regs;
 
 	if (!devm_request_region(dev, base[id], GPIOMM_EXTENT, name)) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
@@ -151,34 +71,20 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	gpiommgpio->ppi = devm_ioport_map(dev, base[id], GPIOMM_EXTENT);
-	if (!gpiommgpio->ppi)
+	regs = devm_ioport_map(dev, base[id], GPIOMM_EXTENT);
+	if (!regs)
 		return -ENOMEM;
 
-	gpiommgpio->chip.label = name;
-	gpiommgpio->chip.parent = dev;
-	gpiommgpio->chip.owner = THIS_MODULE;
-	gpiommgpio->chip.base = -1;
-	gpiommgpio->chip.ngpio = GPIOMM_NGPIO;
-	gpiommgpio->chip.names = gpiomm_names;
-	gpiommgpio->chip.get_direction = gpiomm_gpio_get_direction;
-	gpiommgpio->chip.direction_input = gpiomm_gpio_direction_input;
-	gpiommgpio->chip.direction_output = gpiomm_gpio_direction_output;
-	gpiommgpio->chip.get = gpiomm_gpio_get;
-	gpiommgpio->chip.get_multiple = gpiomm_gpio_get_multiple;
-	gpiommgpio->chip.set = gpiomm_gpio_set;
-	gpiommgpio->chip.set_multiple = gpiomm_gpio_set_multiple;
-
-	i8255_state_init(gpiommgpio->ppi_state, GPIOMM_NUM_PPI);
-	gpiomm_init_dio(gpiommgpio->ppi, gpiommgpio->ppi_state);
-
-	err = devm_gpiochip_add_data(dev, &gpiommgpio->chip, gpiommgpio);
-	if (err) {
-		dev_err(dev, "GPIO registering failed (%d)\n", err);
-		return err;
-	}
+	config.map = devm_regmap_init_mmio(dev, regs, &gpiomm_regmap_config);
+	if (IS_ERR(config.map))
+		return dev_err_probe(dev, PTR_ERR(config.map),
+				     "Unable to initialize register map\n");
+
+	config.parent = dev;
+	config.num_ppi = GPIOMM_NUM_PPI;
+	config.names = gpiomm_names;
 
-	return 0;
+	return devm_i8255_regmap_register(dev, &config);
 }
 
 static struct isa_driver gpiomm_driver = {
-- 
2.38.1

