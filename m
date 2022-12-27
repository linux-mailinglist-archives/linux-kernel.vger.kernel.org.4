Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13315656BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiL0Oda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiL0Oc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:32:58 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E25BCA7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:32:49 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id r11so12517036oie.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uRuu1UfJFMdmi1/wTADm7WY/0yQto4LnL2JRG710R4=;
        b=cifHAwixb58gkXHwFfWuc1fTdCr0qVcsv+K99JJmM7DaaYITTVIrJXa2KzjZT5yV93
         lK4f/qbIpbNMOp3iDQHs5YHko2I4ztYesatH6MALukxDUnvweX5NGYrnMJGDtbxPqlrx
         ErdKDLLt0shuVSLXc8TeVbnZJis3GfRA7tGAu3/mXwzJ+YvKLbqZNtbjEsTJq5LzRvgb
         vlF7wsgl+Y1JYDW+cIwUzBox/rCbVeO5xHlZnVo9ZY8raSbdUtlbe8lvuu/sHDpW8Ixh
         V0xsUI1ifN++4I48DstIr1vZrlOJyaHerMxuoiavzSVncLcL1ovckK1NjMrCL2OgVQfH
         r/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uRuu1UfJFMdmi1/wTADm7WY/0yQto4LnL2JRG710R4=;
        b=0Me2qQZ5KUGFeUkPBB/Pe1obkGuEMLW/Nxjb3SigXNxxelK0rb0SRW8dqa4W9rJmz9
         H3m7uzaqo1cxTZlvhZEkN4jyLqeP+lpG/oQGGSn82xlYlzdRD+dDfNJDagb7YT4yf58l
         1GG3NB77eSQzuRemxStBR8CM63J6qx4AxDUvrqEF0EccU1AxoZewB2PJWGUyLjrPRJVB
         o0ZjekUB+lr+b8ZGKy7nHoyBA50H1Vo6AMOOMYMpSDXCqMcNz3rAE+3QmBNhIlDFaUY0
         KMfl3WAwGKXMxd83CVGnpNV+gmGkyp2Orwn5pqVnlbwKiHKdfqQ6b0dioWxhd5FhLEaG
         qDxw==
X-Gm-Message-State: AFqh2krIOdAI349sonlIeshPkNHLvbgpiUKMg9HNdTeWTohrvlNaFpDa
        7148zTOA4rcDUP99R9D+0ECNbQ==
X-Google-Smtp-Source: AMrXdXscoPinLee4A+PsS9cfO9HtMkGd5TmIFMAxtu37W9tXUC1R0GLA9MZ3FjkLFxlNQTIVV4kpFg==
X-Received: by 2002:aca:d841:0:b0:35c:29d0:fda5 with SMTP id p62-20020acad841000000b0035c29d0fda5mr9711902oig.59.1672151568438;
        Tue, 27 Dec 2022 06:32:48 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q205-20020acac0d6000000b0035bce2a39c7sm5864969oif.21.2022.12.27.06.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:32:48 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 5/8] gpio: i8255: Migrate to gpio-regmap API
Date:   Tue, 27 Dec 2022 09:09:43 -0500
Message-Id: <85d221804aad710ee0eae96ef442c7a33865274f.1672149007.git.william.gray@linaro.org>
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
directly in the driver.

By leveraging the gpio-regmap API, the i8255 library is reduced to
simply a devm_i8255_regmap_register() function, a configuration
structure struct i8255_regmap_config, and a helper macro
i8255_volatile_regmap_range() provided to simplify volatile PPI register
hinting for the regmap.

Legacy functions and code will be removed once all consumers have
migrated to the new i8255 library interface.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig      |   1 +
 drivers/gpio/gpio-i8255.c | 119 ++++++++++++++++++++++++++++++++++----
 drivers/gpio/gpio-i8255.h |  28 +++++++++
 3 files changed, 136 insertions(+), 12 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 84316924574f..63acb9cb4c58 100644
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
index d9084aae9446..3daa0b145890 100644
--- a/drivers/gpio/gpio-i8255.h
+++ b/drivers/gpio/gpio-i8255.h
@@ -26,6 +26,34 @@ struct i8255_state {
 	u8 control_state;
 };
 
+struct device;
+struct irq_domain;
+struct regmap;
+
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

