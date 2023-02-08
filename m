Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF68E69B15E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 17:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjBQQuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 11:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBQQto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 11:49:44 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE04474C0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:49:42 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id c11so231278qth.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 08:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uddyD28dGw/tMmm3DWMacZ8HbFXM6YlSIn/qGyElDA=;
        b=stuS0hHGnRzhwBQ0H8BPYtRBF9IocsGL9oZky1J8uNC9cXF/PlSbOSo3u0TI6yZA3R
         lN9O01RMGaz+aD4GV1gOqJNNiNo3p6+SNMvXYo+vXL6cy72VxNDbNdAlBh7ZdMMVwuD4
         RlQbK4Ajwy8q6IFw7FflWhJcWpkeUzcmxkNUYm/i77FlIn+Gl94HJq6d4iVl16ZAZE1T
         itkjlCbytbxNwuQisFnzg3bMyno2MNZg8BP9TMQbIlmt3jmmJBQP2nNz9F+pTQFwdERg
         Njj5ZSOuo3M+pGnKuC8V1VgGz63SbhwfA1h1i48L7DITjsBgSO+oRf2d5pn45m+TqyGI
         VaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uddyD28dGw/tMmm3DWMacZ8HbFXM6YlSIn/qGyElDA=;
        b=ykw9SXHxKyYNt2aYP7InSBa2DiWvBrjzYFlzgNBlFkDgr2mw0QaM1myVT/QIWwdqxj
         4/e/wsSFBXVoh1o9xCytTtRM9c+tFqBcM/jGEKzhLQnAAx7JGtQ2BtYRb0IGTGZ3HRAy
         Uul1gU4o5y+xFh1mqfxEN+pEtTGEkLDMcN9AMdYu+YHWf4wXOLRii4dHkhvUHRbzQENa
         bxoHr+FOPrkUo+a8jKeFNhLVFn009/jXHMhAyk6wgk29VCmPhD2WVNkPeiS57yTZ43hg
         075VgWDadgcuzHA/taKpRYuUtLz9MhGAbC+lpQNr+6N19TdMk1TNXMfXhtO7N1k/AUMI
         URNg==
X-Gm-Message-State: AO0yUKXtm9bSho7ZQI58Np3C330UJ7vQGT9btPqxBFxgXP1GpssJovOu
        l4E34V7+661P0Wy37uGL2Z6owg==
X-Google-Smtp-Source: AK7set9Ap9Wx/pERqA/DGxGbI25kfCnrJ5UEX603dwZ5XTBhja1HXBE5dr6zfj5Gzxnj1TE4rshx+g==
X-Received: by 2002:ac8:5954:0:b0:3b8:58d0:b4e4 with SMTP id 20-20020ac85954000000b003b858d0b4e4mr2562759qtz.33.1676652581609;
        Fri, 17 Feb 2023 08:49:41 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id b68-20020a37b247000000b0073980414888sm3569161qkf.42.2023.02.17.08.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 08:49:41 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     broonie@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 3/6] gpio: idio-16: Migrate to the regmap API
Date:   Wed,  8 Feb 2023 12:18:18 -0500
Message-Id: <b5e7cadadfb2234a594a6a749837e2402f22e57d.1675876659.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675876659.git.william.gray@linaro.org>
References: <cover.1675876659.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_96_XX,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver.

By leveraging the regmap API, the idio-16 library is reduced to simply a
devm_idio_16_regmap_register() function and a configuration structure
struct idio_16_regmap_config.

Legacy functions and code will be removed once all consumers have
migrated to the new idio-16 library interface.

For IDIO-16 devices we have the following IRQ registers:

    Base Address +1 (Write): Clear Interrupt
    Base Address +2 (Read): Enable Interrupt
    Base Address +2 (Write): Disable Interrupt

An interrupt is asserted whenever a change-of-state is detected on any
of the inputs. Any write to 0x2 will disable interrupts, while any read
will enable interrupts. Interrupts are cleared by a write to 0x1.

For 104-IDIO-16 devices, there is no IRQ status register, so software
has to assume that if an interrupt is raised then it was for the
104-IDIO-16 device.

For PCI-IDIO-16 devices, there is an additional IRQ register:

    Base Address +6 (Read): Interrupt Status

Interrupt status can be read from 0x6 where bit 2 set indicates that an
IRQ has been generated.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig        |   3 +
 drivers/gpio/gpio-idio-16.c | 158 ++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-idio-16.h |  28 +++++++
 3 files changed, 189 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 406e8bda487f..b4de83a3616d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -111,6 +111,9 @@ config GPIO_MAX730X
 
 config GPIO_IDIO_16
 	tristate
+	select REGMAP_IRQ
+	select GPIOLIB_IRQCHIP
+	select GPIO_REGMAP
 	help
 	  Enables support for the idio-16 library functions. The idio-16 library
 	  provides functions to facilitate communication with devices within the
diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
index 13315242d220..907b0f15fdb3 100644
--- a/drivers/gpio/gpio-idio-16.c
+++ b/drivers/gpio/gpio-idio-16.c
@@ -4,9 +4,13 @@
  * Copyright (C) 2022 William Breathitt Gray
  */
 #include <linux/bitmap.h>
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/export.h>
+#include <linux/gpio/regmap.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
@@ -14,6 +18,160 @@
 
 #define DEFAULT_SYMBOL_NAMESPACE GPIO_IDIO_16
 
+#define IDIO_16_DAT_BASE 0x0
+#define IDIO_16_OUT_BASE IDIO_16_DAT_BASE
+#define IDIO_16_IN_BASE (IDIO_16_DAT_BASE + 1)
+#define IDIO_16_CLEAR_INTERRUPT 0x1
+#define IDIO_16_ENABLE_IRQ 0x2
+#define IDIO_16_DEACTIVATE_INPUT_FILTERS 0x3
+#define IDIO_16_DISABLE_IRQ IDIO_16_ENABLE_IRQ
+#define IDIO_16_INTERRUPT_STATUS 0x6
+
+#define IDIO_16_NGPIO 32
+#define IDIO_16_NGPIO_PER_REG 8
+#define IDIO_16_REG_STRIDE 4
+
+static int idio_16_handle_mask_sync(struct regmap *const map, const int index,
+				   const unsigned int mask_buf_def,
+				   const unsigned int mask_buf,
+				   void *const irq_drv_data)
+{
+	unsigned int *const irq_mask = irq_drv_data;
+	const unsigned int prev_mask = *irq_mask;
+	int err;
+	unsigned int val;
+
+	/* exit early if no change since the previous mask */
+	if (mask_buf == prev_mask)
+		return 0;
+
+	/* remember the current mask for the next mask sync */
+	*irq_mask = mask_buf;
+
+	/* if all previously masked, enable interrupts when unmasking */
+	if (prev_mask == mask_buf_def) {
+		err = regmap_write(map, IDIO_16_CLEAR_INTERRUPT, 0x00);
+		if (err)
+			return err;
+		return regmap_read(map, IDIO_16_ENABLE_IRQ, &val);
+	}
+
+	/* if all are currently masked, disable interrupts */
+	if (mask_buf == mask_buf_def)
+		return regmap_write(map, IDIO_16_DISABLE_IRQ, 0x00);
+
+	return 0;
+}
+
+static int idio_16_reg_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
+				  unsigned int offset, unsigned int *reg,
+				  unsigned int *mask)
+{
+	unsigned int stride;
+
+	if (base != IDIO_16_DAT_BASE) {
+		/* Should never reach this path */
+		return -EINVAL;
+	}
+
+	/* Input lines start at GPIO 16 */
+	if (offset < 16) {
+		stride = offset / IDIO_16_NGPIO_PER_REG;
+		*reg = IDIO_16_OUT_BASE + stride * IDIO_16_REG_STRIDE;
+	} else {
+		stride = (offset - 16) / IDIO_16_NGPIO_PER_REG;
+		*reg = IDIO_16_IN_BASE + stride * IDIO_16_REG_STRIDE;
+	}
+
+	*mask = BIT(offset % IDIO_16_NGPIO_PER_REG);
+
+	return 0;
+}
+
+static const char *idio_16_names[IDIO_16_NGPIO] = {
+	"OUT0", "OUT1", "OUT2", "OUT3", "OUT4", "OUT5", "OUT6", "OUT7",
+	"OUT8", "OUT9", "OUT10", "OUT11", "OUT12", "OUT13", "OUT14", "OUT15",
+	"IIN0", "IIN1", "IIN2", "IIN3", "IIN4", "IIN5", "IIN6", "IIN7",
+	"IIN8", "IIN9", "IIN10", "IIN11", "IIN12", "IIN13", "IIN14", "IIN15"
+};
+
+/**
+ * devm_idio_16_regmap_register - Register an IDIO-16 GPIO device
+ * @dev:	device that is registering this IDIO-16 GPIO device
+ * @config:	configuration for idio_16_regmap_config
+ *
+ * Registers an IDIO-16 GPIO device. Returns 0 on success and negative error
+ * number on failure.
+ */
+int devm_idio_16_regmap_register(struct device *const dev,
+				 const struct idio_16_regmap_config *const config)
+{
+	struct gpio_regmap_config gpio_config = {};
+	int err;
+	struct regmap_irq_chip *chip;
+	unsigned int irq_mask;
+	struct regmap_irq_chip_data *chip_data;
+
+	if (!config->parent)
+		return -EINVAL;
+
+	if (!config->map)
+		return -EINVAL;
+
+	if (!config->regmap_irqs)
+		return -EINVAL;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->irq_drv_data = devm_kzalloc(dev, sizeof(irq_mask), GFP_KERNEL);
+	if (!chip->irq_drv_data)
+		return -ENOMEM;
+
+	chip->name = dev_name(dev);
+	chip->status_base = IDIO_16_INTERRUPT_STATUS;
+	chip->mask_base = IDIO_16_ENABLE_IRQ;
+	chip->ack_base = IDIO_16_CLEAR_INTERRUPT;
+	chip->no_status = config->no_status;
+	chip->num_regs = 1;
+	chip->irqs = config->regmap_irqs;
+	chip->num_irqs = config->num_regmap_irqs;
+	chip->handle_mask_sync = idio_16_handle_mask_sync;
+
+	/* Disable IRQ to prevent spurious interrupts before we're ready */
+	err = regmap_write(config->map, IDIO_16_DISABLE_IRQ, 0x00);
+	if (err)
+		return err;
+
+	err = devm_regmap_add_irq_chip(dev, config->map, config->irq, 0, 0,
+				       chip, &chip_data);
+	if (err)
+		return dev_err_probe(dev, err, "IRQ registration failed\n");
+
+	if (config->filters) {
+		/* Deactivate input filters */
+		err = regmap_write(config->map,
+				   IDIO_16_DEACTIVATE_INPUT_FILTERS, 0x00);
+		if (err)
+			return err;
+	}
+
+	gpio_config.parent = config->parent;
+	gpio_config.regmap = config->map;
+	gpio_config.ngpio = IDIO_16_NGPIO;
+	gpio_config.names = idio_16_names;
+	gpio_config.reg_dat_base = GPIO_REGMAP_ADDR(IDIO_16_DAT_BASE);
+	gpio_config.reg_set_base = GPIO_REGMAP_ADDR(IDIO_16_DAT_BASE);
+	gpio_config.ngpio_per_reg = IDIO_16_NGPIO_PER_REG;
+	gpio_config.reg_stride = IDIO_16_REG_STRIDE;
+	gpio_config.irq_domain = regmap_irq_get_domain(chip_data);
+	gpio_config.reg_mask_xlate = idio_16_reg_mask_xlate;
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
+}
+EXPORT_SYMBOL_GPL(devm_idio_16_regmap_register);
+
 /**
  * idio_16_get - get signal value at signal offset
  * @reg:	ACCES IDIO-16 device registers
diff --git a/drivers/gpio/gpio-idio-16.h b/drivers/gpio/gpio-idio-16.h
index 928f8251a2bd..22bb591b4ec0 100644
--- a/drivers/gpio/gpio-idio-16.h
+++ b/drivers/gpio/gpio-idio-16.h
@@ -6,6 +6,30 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
+struct device;
+struct regmap;
+struct regmap_irq;
+
+/**
+ * struct idio_16_regmap_config - Configuration for the IDIO-16 register map
+ * @parent:		parent device
+ * @map:		regmap for the IDIO-16 device
+ * @regmap_irqs:	descriptors for individual IRQs
+ * @num_regmap_irqs:	number of IRQ descriptors
+ * @irq:		IRQ number for the IDIO-16 device
+ * @no_status:		device has no status register
+ * @filters:		device has input filters
+ */
+struct idio_16_regmap_config {
+	struct device *parent;
+	struct regmap *map;
+	const struct regmap_irq *regmap_irqs;
+	int num_regmap_irqs;
+	unsigned int irq;
+	bool no_status;
+	bool filters;
+};
+
 /**
  * struct idio_16 - IDIO-16 registers structure
  * @out0_7:	Read: FET Drive Outputs 0-7
@@ -39,6 +63,7 @@ struct idio_16 {
  * struct idio_16_state - IDIO-16 state structure
  * @lock:	synchronization lock for accessing device state
  * @out_state:	output signals state
+ * @irq_mask:	IRQ mask state
  */
 struct idio_16_state {
 	spinlock_t lock;
@@ -68,4 +93,7 @@ void idio_16_set_multiple(struct idio_16 __iomem *reg,
 			  const unsigned long *mask, const unsigned long *bits);
 void idio_16_state_init(struct idio_16_state *state);
 
+int devm_idio_16_regmap_register(struct device *dev,
+				 const struct idio_16_regmap_config *config);
+
 #endif /* _IDIO_16_H_ */
-- 
2.39.1

