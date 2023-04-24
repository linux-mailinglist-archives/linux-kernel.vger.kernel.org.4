Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719FF6D656C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235557AbjDDOdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235372AbjDDOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:32:58 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AACA30E2
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:32:56 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-544787916d9so616457367b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 07:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680618776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JoWgSxdK9TvgCOElQMk3FXTKXbLElsf5UgEbG+HsjQ=;
        b=hR4L2AVhwaHyWKxXo9bJfBc/kxNuRlgX+Yi002BsQpags0nWOuDNZHX8KxMjgQpjWN
         f2SvtdSXfURITpCaqznnUKlxqxEbltn8wIlJc5eJ317cBrEneyza2a+oZW5gw6Jl5QGD
         RIDYA0OM1mp2QCQCkdLsDSdZu/HJDg4Goc07lOLVJgbqYUw3cva7UczIJJjehV4gf3Zo
         ekXLwtDnXI3efi24yX2aCbOcR0rQez6TXvj+KvzmpX0/man33DIYT93nDH1ZPth66bFb
         wDztvud88hD9/ip2moTvWvKd+6D7lm4N6Mm72vlq2cnvgFeJycV4aCEGTR1rd2wj6nU5
         53Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JoWgSxdK9TvgCOElQMk3FXTKXbLElsf5UgEbG+HsjQ=;
        b=JuUO4AjfyJ8ZPiozgn03xDt8N5QpVnBbtDUNgnI+qhENoG+bZsMkiCNukqgNBchCjl
         L44Um3+pj9VtYKk72COILS8zz+vjKgBcSg5SvLwaUp6Ix03kgi8RjfgOnTUtgq6ygPZL
         A3RIEe8nRRh8gFxnVZ4Cxt79zwkg8fOsPwVRREffAP6jiGOvfidoS5dyT3A8t/51X0KC
         8aeK7UkED6z3/Kei3co4pVlpJxGE3lu91I5NceHwCdkqMsrsnV5c7lnH7mvznSsDa8lN
         PTobK6yfb82NtiRJpCvyU6EjmTsauvEvNPzpv4SjgbS57AB5cOvxOyWf838KwisfsxVg
         iuCQ==
X-Gm-Message-State: AAQBX9d2GmfSLJhHIh+dvx2hEZVprgaa3tIdrFlmJk9kGh5D98+xdLNk
        SvRJpdAacOFW2GccNZvZ6D6uuw==
X-Google-Smtp-Source: AKy350YD6UoXl9m5hmuvmbHNZb/YAX7IDEpZb6KR5pl3fNSsdhxyoiFV/fHjWNzAfJuPsRqaG7CMNw==
X-Received: by 2002:a81:1383:0:b0:541:61b1:4a59 with SMTP id 125-20020a811383000000b0054161b14a59mr19521892ywt.3.1680618775756;
        Tue, 04 Apr 2023 07:32:55 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id p76-20020a81984f000000b00545a0818489sm3234439ywg.25.2023.04.04.07.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:32:55 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 1/4] gpio: idio-16: Migrate to the regmap API
Date:   Tue,  4 Apr 2023 10:32:45 -0400
Message-Id: <b45081958ab53dfa697f4a8b15f1bfba46718068.1680618405.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680618405.git.william.gray@linaro.org>
References: <cover.1680618405.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
Changes in v5: none

 drivers/gpio/Kconfig        |   3 +
 drivers/gpio/gpio-idio-16.c | 155 ++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-idio-16.h |  26 ++++++
 3 files changed, 184 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 68f58b0ba79f..415b86cfd1a9 100644
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
index 13315242d220..f9349e8d7fdc 100644
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
 
@@ -14,6 +18,157 @@
 
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
+struct idio_16_data {
+	struct regmap *map;
+	unsigned int irq_mask;
+};
+
+static int idio_16_handle_mask_sync(const int index, const unsigned int mask_buf_def,
+				    const unsigned int mask_buf, void *const irq_drv_data)
+{
+	struct idio_16_data *const data = irq_drv_data;
+	const unsigned int prev_mask = data->irq_mask;
+	int err;
+	unsigned int val;
+
+	/* exit early if no change since the previous mask */
+	if (mask_buf == prev_mask)
+		return 0;
+
+	/* remember the current mask for the next mask sync */
+	data->irq_mask = mask_buf;
+
+	/* if all previously masked, enable interrupts when unmasking */
+	if (prev_mask == mask_buf_def) {
+		err = regmap_write(data->map, IDIO_16_CLEAR_INTERRUPT, 0x00);
+		if (err)
+			return err;
+		return regmap_read(data->map, IDIO_16_ENABLE_IRQ, &val);
+	}
+
+	/* if all are currently masked, disable interrupts */
+	if (mask_buf == mask_buf_def)
+		return regmap_write(data->map, IDIO_16_DISABLE_IRQ, 0x00);
+
+	return 0;
+}
+
+static int idio_16_reg_mask_xlate(struct gpio_regmap *const gpio, const unsigned int base,
+				  const unsigned int offset, unsigned int *const reg,
+				  unsigned int *const mask)
+{
+	unsigned int stride;
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
+ * Registers an IDIO-16 GPIO device. Returns 0 on success and negative error number on failure.
+ */
+int devm_idio_16_regmap_register(struct device *const dev,
+				 const struct idio_16_regmap_config *const config)
+{
+	struct gpio_regmap_config gpio_config = {};
+	int err;
+	struct idio_16_data *data;
+	struct regmap_irq_chip *chip;
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
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	data->map = config->map;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
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
+	chip->irq_drv_data = data;
+
+	/* Disable IRQ to prevent spurious interrupts before we're ready */
+	err = regmap_write(data->map, IDIO_16_DISABLE_IRQ, 0x00);
+	if (err)
+		return err;
+
+	err = devm_regmap_add_irq_chip(dev, data->map, config->irq, 0, 0, chip, &chip_data);
+	if (err)
+		return dev_err_probe(dev, err, "IRQ registration failed\n");
+
+	if (config->filters) {
+		/* Deactivate input filters */
+		err = regmap_write(data->map, IDIO_16_DEACTIVATE_INPUT_FILTERS, 0x00);
+		if (err)
+			return err;
+	}
+
+	gpio_config.parent = config->parent;
+	gpio_config.regmap = data->map;
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
index 928f8251a2bd..255bd8504ed7 100644
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
@@ -68,4 +92,6 @@ void idio_16_set_multiple(struct idio_16 __iomem *reg,
 			  const unsigned long *mask, const unsigned long *bits);
 void idio_16_state_init(struct idio_16_state *state);
 
+int devm_idio_16_regmap_register(struct device *dev, const struct idio_16_regmap_config *config);
+
 #endif /* _IDIO_16_H_ */
-- 
2.39.2

