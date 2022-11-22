Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE576361B2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbiKWO05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237973AbiKWO0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:26:14 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CD272087
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:25:24 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id z6so11277877qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQbvMPk8zcZSEOxdFXkFt3owsSruEO/4JBbOOuz28e0=;
        b=MXzdQYdor0GEDZ/e8FA2JhV8+0CPHMyA3LXaHi3GJsi7QjkhbaKiJMkevmOqxczJiN
         ST34sssvgh+nYXeGWOAFDjuxyCpj1jopvKMr6zslLqIXvB/thv7OzRv2VE7NqNaKQDsM
         mkW0kTm+ZDRnLqu/NxB2viN7eN8CxQU5FOOYLnyNlbBTLe32wHd+LsTCH9ELjh9MyBvG
         9mTKpmowmtWWBnfJzza9mAslb7v9T3sVDNZ1I9uydvdBME4kuEnVVSMjJ/y9zUMKN9ZY
         h3rvQH5Rv+24MYBDt2dlWFTrlhZ6z5MZURprsBAkoWgxlnSqooEV1slBVJuwURpDL4qh
         Qyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQbvMPk8zcZSEOxdFXkFt3owsSruEO/4JBbOOuz28e0=;
        b=WpCWbTmBhOsLyWOboh/VWNXR5H4cqIEO6VBxRAAKMAMCDcuCOrONLB43uvdF4hXIU6
         ltRahVfIU+roRj8b/Sg4F4dff9uvn5YD3461dKPEc91X6mEYuMqiIxmEUWH9MBgI2H7D
         I3UWNZdaRnuL5rf4cVj8Kx/WX9hwSpNnvBSioJAt7szbuXoogD7a4BSyeYAZbMvmCETM
         ppGKmBPJYc3sxYGxr9phh1YkGLHTlJwjYZ+N5cxjta1BqoznIAMpdmLUiGgN/JK+77xA
         NysJDVm9nt5pWDBfHvf+noT4nMNP9XvTDn8dY3MtDz5+sFng84oKF6+t0VQmo3DMx+iM
         47rA==
X-Gm-Message-State: ANoB5pkA1cn+4US8SyDlC5kqcufdsLfj97HUzw5jBFqxmSZOVVXR1G4U
        8QF6J9DawtRAaw8eRAZaNFVMQw==
X-Google-Smtp-Source: AA0mqf4SpUIeNrZGUeTPbB8UzNK89C+ZXvnrJRvhjHoIAC/zADKOj/6xAVvbXnLMeBRcgfW+Gazg/g==
X-Received: by 2002:a05:622a:a0a:b0:3a5:1ea9:711e with SMTP id bv10-20020a05622a0a0a00b003a51ea9711emr25881868qtb.280.1669213523403;
        Wed, 23 Nov 2022 06:25:23 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b28-20020a05620a127c00b006f9c2be0b4bsm11718802qkl.135.2022.11.23.06.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 06:25:22 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v3 6/9] gpio: i8255: Migrate to gpio-regmap API
Date:   Tue, 22 Nov 2022 02:11:03 -0500
Message-Id: <283c5af8825596d55b943b593eab561c912a088f.1669100542.git.william.gray@linaro.org>
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
directly in the driver.

By leveraging the gpio-regmap API, the i8255 library is reduced to
simply a devm_i8255_regmap_register() function, a configuration
structure struct i8255_regmap_config, and a helper macro
i8255_volatile_regmap_range() provided to simplify volatile PPI register
hinting for the regmap.

Legacy functions and code will be removed once all consumers have
migrated to the new i8255 library interface.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig      |   1 +
 drivers/gpio/gpio-i8255.c | 119 ++++++++++++++++++++++++++++++++++----
 drivers/gpio/gpio-i8255.h |  27 +++++++++
 3 files changed, 135 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index dd34039fc31b..88dfdc62992f 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -831,6 +831,7 @@ menu "Port-mapped I/O GPIO drivers"
 
 config GPIO_I8255
 	tristate
+	select GPIO_REGMAP
 	help
 	  Enables support for the i8255 interface library functions. The i8255
 	  interface library provides functions to facilitate communication with
diff --git a/drivers/gpio/gpio-i8255.c b/drivers/gpio/gpio-i8255.c
index 9b97db418df1..9ecb2e9b97f9 100644
--- a/drivers/gpio/gpio-i8255.c
+++ b/drivers/gpio/gpio-i8255.c
@@ -4,23 +4,31 @@
  * Copyright (C) 2022 William Breathitt Gray
  */
 #include <linux/bitmap.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
+#include <linux/gpio/regmap.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include "gpio-i8255.h"
 
+#define I8255_NGPIO 24
+#define I8255_NGPIO_PER_REG 8
 #define I8255_CONTROL_PORTC_LOWER_DIRECTION BIT(0)
 #define I8255_CONTROL_PORTB_DIRECTION BIT(1)
 #define I8255_CONTROL_PORTC_UPPER_DIRECTION BIT(3)
 #define I8255_CONTROL_PORTA_DIRECTION BIT(4)
 #define I8255_CONTROL_MODE_SET BIT(7)
-#define I8255_PORTA 0
-#define I8255_PORTB 1
-#define I8255_PORTC 2
+#define I8255_PORTA 0x0
+#define I8255_PORTB 0x1
+#define I8255_PORTC 0x2
+#define I8255_CONTROL 0x3
+#define I8255_REG_DAT_BASE I8255_PORTA
+#define I8255_REG_DIR_IN_BASE I8255_CONTROL
 
 static int i8255_get_port(struct i8255 __iomem *const ppi,
 			  const unsigned long io_port, const unsigned long mask)
@@ -31,20 +39,19 @@ static int i8255_get_port(struct i8255 __iomem *const ppi,
 	return ioread8(&ppi[bank].port[ppi_port]) & mask;
 }
 
-static u8 i8255_direction_mask(const unsigned long offset)
+static int i8255_direction_mask(const unsigned int offset)
 {
-	const unsigned long port_offset = offset % 8;
-	const unsigned long io_port = offset / 8;
-	const unsigned long ppi_port = io_port % 3;
+	const unsigned int stride = offset / I8255_NGPIO_PER_REG;
+	const unsigned int line = offset % I8255_NGPIO_PER_REG;
 
-	switch (ppi_port) {
+	switch (stride) {
 	case I8255_PORTA:
 		return I8255_CONTROL_PORTA_DIRECTION;
 	case I8255_PORTB:
 		return I8255_CONTROL_PORTB_DIRECTION;
 	case I8255_PORTC:
 		/* Port C can be configured by nibble */
-		if (port_offset >= 4)
+		if (line >= 4)
 			return I8255_CONTROL_PORTC_UPPER_DIRECTION;
 		return I8255_CONTROL_PORTC_LOWER_DIRECTION;
 	default:
@@ -53,6 +60,49 @@ static u8 i8255_direction_mask(const unsigned long offset)
 	}
 }
 
+static int i8255_ppi_init(struct regmap *const map, const unsigned int base)
+{
+	int err;
+
+	/* Configure all ports to MODE 0 output mode */
+	err = regmap_write(map, base + I8255_CONTROL, I8255_CONTROL_MODE_SET);
+	if (err)
+		return err;
+
+	/* Initialize all GPIO to output 0 */
+	err = regmap_write(map, base + I8255_PORTA, 0x00);
+	if (err)
+		return err;
+	err = regmap_write(map, base + I8255_PORTB, 0x00);
+	if (err)
+		return err;
+	return regmap_write(map, base + I8255_PORTC, 0x00);
+}
+
+static int i8255_reg_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
+				unsigned int offset, unsigned int *reg,
+				unsigned int *mask)
+{
+	const unsigned int ppi = offset / I8255_NGPIO;
+	const unsigned int ppi_offset = offset % I8255_NGPIO;
+	const unsigned int stride = ppi_offset / I8255_NGPIO_PER_REG;
+	const unsigned int line = ppi_offset % I8255_NGPIO_PER_REG;
+
+	switch (base) {
+	case I8255_REG_DAT_BASE:
+		*reg = base + stride + ppi * 4;
+		*mask = BIT(line);
+		return 0;
+	case I8255_REG_DIR_IN_BASE:
+		*reg = base + ppi * 4;
+		*mask = i8255_direction_mask(ppi_offset);
+		return 0;
+	default:
+		/* Should never reach this path */
+		return -EINVAL;
+	}
+}
+
 static void i8255_set_port(struct i8255 __iomem *const ppi,
 			   struct i8255_state *const state,
 			   const unsigned long io_port,
@@ -93,7 +143,7 @@ void i8255_direction_input(struct i8255 __iomem *const ppi,
 	spin_lock_irqsave(&state[bank].lock, flags);
 
 	state[bank].control_state |= I8255_CONTROL_MODE_SET;
-	state[bank].control_state |= i8255_direction_mask(offset);
+	state[bank].control_state |= i8255_direction_mask(offset % 24);
 
 	iowrite8(state[bank].control_state, &ppi[bank].control);
 
@@ -125,7 +175,7 @@ void i8255_direction_output(struct i8255 __iomem *const ppi,
 	spin_lock_irqsave(&state[bank].lock, flags);
 
 	state[bank].control_state |= I8255_CONTROL_MODE_SET;
-	state[bank].control_state &= ~i8255_direction_mask(offset);
+	state[bank].control_state &= ~i8255_direction_mask(offset % 24);
 
 	iowrite8(state[bank].control_state, &ppi[bank].control);
 
@@ -165,7 +215,7 @@ int i8255_get_direction(const struct i8255_state *const state,
 	const unsigned long io_port = offset / 8;
 	const unsigned long bank = io_port / 3;
 
-	return !!(state[bank].control_state & i8255_direction_mask(offset));
+	return !!(state[bank].control_state & i8255_direction_mask(offset % 24));
 }
 EXPORT_SYMBOL_NS_GPL(i8255_get_direction, I8255);
 
@@ -282,6 +332,51 @@ void i8255_state_init(struct i8255_state *const state,
 }
 EXPORT_SYMBOL_NS_GPL(i8255_state_init, I8255);
 
+/**
+ * devm_i8255_regmap_register - Register an i8255 GPIO controller
+ * @dev:	device that is registering this i8255 GPIO device
+ * @config:	configuration for i8255_regmap_config
+ *
+ * Registers an Intel 8255 Programmable Peripheral Interface GPIO controller.
+ * Returns 0 on success and negative error number on failure.
+ */
+int devm_i8255_regmap_register(struct device *const dev,
+			       const struct i8255_regmap_config *const config)
+{
+	struct gpio_regmap_config gpio_config = {0};
+	unsigned long i;
+	int err;
+
+	if (!config->parent)
+		return -EINVAL;
+
+	if (!config->map)
+		return -EINVAL;
+
+	if (!config->num_ppi)
+		return -EINVAL;
+
+	for (i = 0; i < config->num_ppi; i++) {
+		err = i8255_ppi_init(config->map, i * 4);
+		if (err)
+			return err;
+	}
+
+	gpio_config.parent = config->parent;
+	gpio_config.regmap = config->map;
+	gpio_config.ngpio = I8255_NGPIO * config->num_ppi;
+	gpio_config.names = config->names;
+	gpio_config.reg_dat_base = GPIO_REGMAP_ADDR(I8255_REG_DAT_BASE);
+	gpio_config.reg_set_base = GPIO_REGMAP_ADDR(I8255_REG_DAT_BASE);
+	gpio_config.reg_dir_in_base = GPIO_REGMAP_ADDR(I8255_REG_DIR_IN_BASE);
+	gpio_config.ngpio_per_reg = I8255_NGPIO_PER_REG;
+	gpio_config.irq_domain = config->domain;
+	gpio_config.reg_mask_xlate = i8255_reg_mask_xlate;
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
+}
+EXPORT_SYMBOL_NS_GPL(devm_i8255_regmap_register, I8255);
+
 MODULE_AUTHOR("William Breathitt Gray");
 MODULE_DESCRIPTION("Intel 8255 Programmable Peripheral Interface");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/gpio-i8255.h b/drivers/gpio/gpio-i8255.h
index d9084aae9446..6ec987835c14 100644
--- a/drivers/gpio/gpio-i8255.h
+++ b/drivers/gpio/gpio-i8255.h
@@ -3,6 +3,9 @@
 #ifndef _I8255_H_
 #define _I8255_H_
 
+#include <linux/device.h>
+#include <linux/irqdomain.h>
+#include <linux/regmap.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
@@ -26,6 +29,30 @@ struct i8255_state {
 	u8 control_state;
 };
 
+#define i8255_volatile_regmap_range(_base) regmap_reg_range(_base, _base + 0x2)
+
+/**
+ * struct i8255_regmap_config - Configuration for the register map of an i8255
+ * @parent:	parent device
+ * @map:	regmap for the i8255
+ * @num_ppi:	number of i8255 Programmable Peripheral Interface
+ * @names:	(optional) array of names for gpios
+ * @domain:	(optional) IRQ domain if the controller is interrupt-capable
+ *
+ * Note: The regmap is expected to have cache enabled and i8255 control
+ * registers not marked as volatile.
+ */
+struct i8255_regmap_config {
+	struct device *parent;
+	struct regmap *map;
+	int num_ppi;
+	const char *const *names;
+	struct irq_domain *domain;
+};
+
+int devm_i8255_regmap_register(struct device *dev,
+			       const struct i8255_regmap_config *config);
+
 void i8255_direction_input(struct i8255 __iomem *ppi, struct i8255_state *state,
 			   unsigned long offset);
 void i8255_direction_output(struct i8255 __iomem *ppi,
-- 
2.38.1

