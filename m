Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BCB656BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiL0Odj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiL0Oc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:32:58 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540C0BC37
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:32:51 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id s187so12529981oie.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJEY+4UPfziWTYrg1f/jmeyTc6jk/LjJf8U+AI6c1hc=;
        b=Y1cteymX6YacSALc2NOBsWmRC7ReJsFzgkk1qj6wRmkgv1LhaWdWHFr95nRISrTMYU
         XEqkdCC9VS5jM+8KK5d/Lsgo0+9Nngb5dpWqr3hZ9BjAyiaky+xdVropnfPjrb+evDl+
         DLNqOW6Lvg7y1jWdu+HVgoe1qwjQL/Mm7JpE6KgQMTmhOntCuQMlDIdqNJWba8rxXG4Z
         wERhSil1CDyCoHuTw1Ukxg2pvTx1sVGtSM678yADPKTIOVA+3Ip6tz7GmXOsCy+Ztm3O
         7glF5ElMSk/kz68jfCHbB5yJ7ZDsBbEwHvAoplO3jHzw6zFrsRPtmcgTivNYKKBDMH6Q
         6/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FJEY+4UPfziWTYrg1f/jmeyTc6jk/LjJf8U+AI6c1hc=;
        b=UGWnOw6JI/j/aLoEPvbzxgR932NNRMU/8zJtcekFrGBhItSYFZyk9DmbyTKbwTmRuY
         D+xPyZfvWUd8vzDdbF7wgO6yjwm4/lj1WDP0l+AHX5qZYL6/5p+sO8nnjoLPh+2R6yry
         1u4gMR4tWWCqd+tnP49WnJ3hZrbwohz2wPVIE6HGwDJtyGb3eCjy5h803gihizltc5Gn
         DTl3LnDS9E9zjWAedm9lYFgy7Nk5GsxchA4ShVAtsyL+iu8m3WcDJXL9rU6kOCUFFsNk
         9mmV4VQ9QObtdM04urcijqfQaUbiYCN90zj5Ea5dLKkygmUeqdhXWrhcSmZhJQjkBstP
         fTjQ==
X-Gm-Message-State: AFqh2kpeNw2qlHBfBChNK/u6hA/kBAuWcpw2PS4KtD05vQfk1KFPEsHg
        kOk0m53PwOKBX0bFrAlz44UTEiq8NiiEn94C
X-Google-Smtp-Source: AMrXdXvB/aj7ocN3PAWOBjT0ugN+C39cQ4jAlQs9XPN9fegqWe1qziobxJqtuoybYKWKepdRqzJoqg==
X-Received: by 2002:a05:6808:238e:b0:35e:aa28:a433 with SMTP id bp14-20020a056808238e00b0035eaa28a433mr12990340oib.25.1672151570422;
        Tue, 27 Dec 2022 06:32:50 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q205-20020acac0d6000000b0035bce2a39c7sm5864969oif.21.2022.12.27.06.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:32:50 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 7/8] gpio: gpio-mm: Migrate to regmap API
Date:   Tue, 27 Dec 2022 09:09:45 -0500
Message-Id: <c8c7a8b1f8d49473ac219cfb40800b44dbc019ac.1672149007.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1672149007.git.william.gray@linaro.org>
References: <cover.1672149007.git.william.gray@linaro.org>
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
 drivers/gpio/Kconfig        |   1 +
 drivers/gpio/gpio-gpio-mm.c | 154 +++++++-----------------------------
 2 files changed, 31 insertions(+), 124 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 63acb9cb4c58..525b911b4ac7 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -898,6 +898,7 @@ config GPIO_GPIO_MM
 	tristate "Diamond Systems GPIO-MM GPIO support"
 	depends on PC104
 	select ISA_BUS_API
+	select REGMAP_MMIO
 	select GPIO_I8255
 	help
 	  Enables GPIO support for the Diamond Systems GPIO-MM and GPIO-MM-12.
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

