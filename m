Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B216A4759
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjB0Qyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjB0Qy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:54:28 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8220AF76E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:54:26 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id r5so7385011qtp.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wqZbck9k7lqa+7lxepbNe41g6KFQ2hdxPmRTuBbTpdU=;
        b=lEh61KKJK1xYRrtDRyxw2eXbiU3wDGZUIAhYWbgBaNrMz+g5o67m0EtWZr/qT8M1iB
         sLCL7F8zbx1T7sj9+UKtHw88B9+9kIzl1dB46lZVTBX9+RN5UhJ6CloJK7HHTTDr/2bJ
         9FlWsiIlkvywzby7wzstQcIfZT6vn5sm49bz8GOFSuU9wr8ByubQthRdCINrAvxdqbHq
         NwfVGgHo7Zj1DX1MmwzOpUfuUyCE9bOQ0td3ZenNY4ZaPhGGI5fWQBVzE5A8GXL3DN0J
         jTlFiv7ysGOcBphAxdV9UosvuE0K3d5FOcS/4r7CeqGhNx9GRGsng2ZUZdglh9NVHaN3
         QiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wqZbck9k7lqa+7lxepbNe41g6KFQ2hdxPmRTuBbTpdU=;
        b=SpVLNQ9Vn1Md0TDViEo3AL7b8iTd8RmMddCubluzh+q+gzTWSFWlJqmtFM2Ea3WwEF
         lb/JhSQ1GcD9vPtFldBmwfTnqB0GvySI51+jV5C5Lc2vl7+VOShd1jPMUI+YS1EQf4Gr
         W08ZI96Pvef/Ldphpbl8GW4slSDjv7Z1KyJ9jNSGJ9HJdM+2IB6Qxc3nvDqIKoVDqUo6
         sgWgXBahDl4GyU9S74mRHl+q23b+++k5VT3zkBiZtuo+G7qqK87SHHIUIUrikfKy9INz
         7Sk7aOUEh3N4w0Ioekg9NfQnd/13KbeUhu31t2UuV1dOyxCSMKSWMmyDG0r2fEh98sny
         MB7g==
X-Gm-Message-State: AO0yUKUqEZ5VyVJAuA7hmV7cyGy8c8KS2QPGCf7Qn4vhabRQWISrfga9
        /R5afuqQ4EyN5nzQ1mQmp9YRhQ==
X-Google-Smtp-Source: AK7set+2MAGqnyjzk/Qd4y1RKr3YPZQnEXJu6ICcEeayx25KNgc4QzVSIDRA0gpLZS1t/Ib9BvOSZA==
X-Received: by 2002:ac8:4e4d:0:b0:3bd:1728:8881 with SMTP id e13-20020ac84e4d000000b003bd17288881mr34812279qtw.19.1677516865562;
        Mon, 27 Feb 2023 08:54:25 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id x15-20020a05620a098f00b0073b929d0371sm5238714qkx.4.2023.02.27.08.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:54:25 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     broonie@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 3/6] gpio: idio-16: Migrate to the regmap API
Date:   Mon, 27 Feb 2023 11:45:24 -0500
Message-Id: <fc06bfbd408ee86060ebecb3b4611bbe26ada723.1677515341.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1677515341.git.william.gray@linaro.org>
References: <cover.1677515341.git.william.gray@linaro.org>
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v2:
 - Add comma to end of idio_16_names initialization list

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
index 13315242d220..13e35d1ef658 100644
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
+	"IIN8", "IIN9", "IIN10", "IIN11", "IIN12", "IIN13", "IIN14", "IIN15",
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
2.39.2

