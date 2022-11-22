Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9496361B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbiKWO1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbiKWO0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:26:17 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7681E2E69C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:25:28 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d7so12483275qkk.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=birQUGg9QWXN0aePteHiAYkZnp+VjTQ5j5vWqQ7GHnU=;
        b=DNbNCdNDnu5unW5EFQHQ8KM5JqtzxntLQAZOfSn2jVK19k+uJ/WFw8rj9KwvnFK7JD
         hmuVkTRpfIrydwjgxK1J8HpGlVZOL+7UurKpj4+/ZGdgil68vev2AniFKdGlYzvlGiox
         O7IooOhocH1PYtA2+IeKB6t2RejFKrKYpezV62WV0KRlA+jr243LrARCtRCmyFsYj8/c
         Q/aBvN4kwH1KQMN8Hle4gNhtDbk20rPMWMEcC2tMadws6BFiAAczZrtgG5B4Ate4I7Qy
         u99mj7vp3CJ0Sea/w4s0nH68FY3Lr+bJjGSOLaq7BxIsPCz6lJVcFYmDQLn0tiR7BAA9
         MMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=birQUGg9QWXN0aePteHiAYkZnp+VjTQ5j5vWqQ7GHnU=;
        b=Fs+Pbc6Xt0FvRbL4aI/s9v99Nj7FweOfVEOVdju6gdISGwTpqE51g+Z/bV3o/lYhZ/
         GA71jHyvpbILC+CYwhDwc7YYqTo3Jq1ka5rVqK95Dt7RK0jLG0Rcyje7PMxOyov64mgN
         94BxbmuuGKs2dWlLuVraYQFYl+cjEs+4mPLolqLkz8nWWl5dmC4TaxC8tBixC0KU4rxu
         q3Hn0MDgpYLJUPp1a7thUkRJCZtAIawnhlRW9eZMzNNQBVGwOEtoFm5W2JYt1ShMbNKm
         i8+bphRz8YzlY78Oc5DCLJTcYIRSuhTKxV2L+VBKOIRKNFwBxFWuKPLwLn9odo81Mvbw
         cXRQ==
X-Gm-Message-State: ANoB5pmxTB/zGZ1KTq5/f3ShLZj6fBizCbgM5HIn27f0wGeV5RTreZ3D
        J73+sJJXSxgBgUFJmjHBgdB/7g==
X-Google-Smtp-Source: AA0mqf4GSujuHyXVHrqI/fzkr0DMxhHqkNa0zQ1a+/lMYE7EJJZWRAECdsq3cT3hjpbduDdw6p+QRg==
X-Received: by 2002:a05:620a:51ca:b0:6ec:fa04:d97c with SMTP id cx10-20020a05620a51ca00b006ecfa04d97cmr9001010qkb.764.1669213527332;
        Wed, 23 Nov 2022 06:25:27 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b28-20020a05620a127c00b006f9c2be0b4bsm11718802qkl.135.2022.11.23.06.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:25:26 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 8/9] gpio: gpio-mm: Migrate to regmap API
Date:   Tue, 22 Nov 2022 02:11:05 -0500
Message-Id: <4c7d582e4078e265d7a8d39d3aa746e573233a4e.1669100542.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669100542.git.william.gray@linaro.org>
References: <cover.1669100542.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-gpio-mm.c | 153 +++++++-----------------------------
 1 file changed, 29 insertions(+), 124 deletions(-)

diff --git a/drivers/gpio/gpio-gpio-mm.c b/drivers/gpio/gpio-gpio-mm.c
index 2689671b6b01..ba8847485660 100644
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
+	struct i8255_regmap_config config = {0};
+	void __iomem *regs;
 
 	if (!devm_request_region(dev, base[id], GPIOMM_EXTENT, name)) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
@@ -151,34 +71,19 @@ static int gpiomm_probe(struct device *dev, unsigned int id)
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
+		return PTR_ERR(config.map);
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

