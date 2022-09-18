Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E9E5BBFAB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 21:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiIRTya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 15:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiIRTyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 15:54:15 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261D52EF
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 12:54:14 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id g4so20513916qvo.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 12:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=lOXjsiEmngT43M1lyro/xLi2Qow0vt5RnvkI5Uizgxk=;
        b=YxNNYCnYJ18J3/PuB6z1JGbffOkmrEJPQcN7U1FgWcT6rk29t06Tj2kzOYqTbyua0Q
         iKnHHN0VQG48+OZcgxRdijh5OAcsgR/hn/4wWnapvuj8fDIe4ZcW8Y3c3aQCGaGFolAW
         /LRyXVo13QOyVOWqU8gyC9doFdjfqjp6ID38X0RhS9jz3bHFnD7dc9CvSAO66ar4Pn9b
         yBBdenlKnGQts7iiyj2JVKmBim1RB806Zzb3XmRJZmEqJrQLGU+ZkXKH5kR+p09vQzyc
         6LZ7KRFTnJI5Nt358qFr9BL0u/xOtB9RgJ0AXTIrhhOt2a0an9Nx4rIlDRguDyZpUa3Z
         ZWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=lOXjsiEmngT43M1lyro/xLi2Qow0vt5RnvkI5Uizgxk=;
        b=RZ+s04C6tCnoKWkhQQ7WYMy9pQcr5LpYeIk1E6qPbMr7YgIiYAgWMvfTpHqaXWtQnE
         B1B7aZSSr3Mx4iRVPLRthggxa3tHtuk6Iic48C98I0rWAFRBWOF3Z2jsktGvH9YNZ2Ea
         XE4BNF/zStM1TGlEsxzMEJ2EbyXLDLYdf39Y3rGzK8Yt3NkZCuYdVTkGT4gSBrDqOKGy
         MtpVFy5apxIpHaehZKNR6iFcaBIQnqGoxSkxakAhH328lXNRVroV+4uyiZm2FTwhR64/
         e6nXJRI6om/5DNsAfL9hALtBDGVqgr9uOrwW/X4y44XrFKP8Sv4O5+4TUlghUMSts6Do
         Geqw==
X-Gm-Message-State: ACrzQf2gTQc2GIsrYmEcfD3rcQOTsYUIOHAVboE6iAZ4LM1C4qIJBY2R
        01ISBkoFhldOdgiiRelKJxdZRA==
X-Google-Smtp-Source: AMsMyM5VAmXF9KHvSJRMEj8oKnrwvxEqhQZp+aqALHtmWNyKE0PmTxVTeMijuiHbX074TwZiqoGKIQ==
X-Received: by 2002:a05:6214:528e:b0:4ac:d1bf:59b4 with SMTP id kj14-20020a056214528e00b004acd1bf59b4mr12272150qvb.3.1663530853206;
        Sun, 18 Sep 2022 12:54:13 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i67-20020a37b846000000b006ce7d9dea7asm10753310qkf.13.2022.09.18.12.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 12:54:12 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     brgl@bgdev.pl, linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 3/3] gpio: pci-idio-16: Utilize the idio-16 GPIO library
Date:   Sun, 18 Sep 2022 12:50:45 -0400
Message-Id: <7fbd42200acd2bc6559f224a35cf4dc9dc6052ce.1663519546.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <cover.1663519546.git.william.gray@linaro.org>
References: <cover.1663519546.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACCES PCI-IDIO-16 device is part of the ACCES IDIO-16 family, so the
idio-16 GPIO library module is selected and utilized to consolidate
code.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig            |   1 +
 drivers/gpio/gpio-pci-idio-16.c | 119 ++++----------------------------
 2 files changed, 14 insertions(+), 106 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 48846ee476e2..8b90bff7b198 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1585,6 +1585,7 @@ config GPIO_PCH
 config GPIO_PCI_IDIO_16
 	tristate "ACCES PCI-IDIO-16 GPIO support"
 	select GPIOLIB_IRQCHIP
+	select GPIO_IDIO_16
 	help
 	  Enables GPIO support for the ACCES PCI-IDIO-16. An interrupt is
 	  generated when any of the inputs change state (low to high or high to
diff --git a/drivers/gpio/gpio-pci-idio-16.c b/drivers/gpio/gpio-pci-idio-16.c
index 71a13a394050..a86ce748384b 100644
--- a/drivers/gpio/gpio-pci-idio-16.c
+++ b/drivers/gpio/gpio-pci-idio-16.c
@@ -3,8 +3,7 @@
  * GPIO driver for the ACCES PCI-IDIO-16
  * Copyright (C) 2017 William Breathitt Gray
  */
-#include <linux/bitmap.h>
-#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
@@ -16,51 +15,28 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
-/**
- * struct idio_16_gpio_reg - GPIO device registers structure
- * @out0_7:	Read: FET Drive Outputs 0-7
- *		Write: FET Drive Outputs 0-7
- * @in0_7:	Read: Isolated Inputs 0-7
- *		Write: Clear Interrupt
- * @irq_ctl:	Read: Enable IRQ
- *		Write: Disable IRQ
- * @filter_ctl:	Read: Activate Input Filters 0-15
- *		Write: Deactivate Input Filters 0-15
- * @out8_15:	Read: FET Drive Outputs 8-15
- *		Write: FET Drive Outputs 8-15
- * @in8_15:	Read: Isolated Inputs 8-15
- *		Write: Unused
- * @irq_status:	Read: Interrupt status
- *		Write: Unused
- */
-struct idio_16_gpio_reg {
-	u8 out0_7;
-	u8 in0_7;
-	u8 irq_ctl;
-	u8 filter_ctl;
-	u8 out8_15;
-	u8 in8_15;
-	u8 irq_status;
-};
+#include "gpio-idio-16.h"
 
 /**
  * struct idio_16_gpio - GPIO device private data structure
  * @chip:	instance of the gpio_chip
  * @lock:	synchronization lock to prevent I/O race conditions
  * @reg:	I/O address offset for the GPIO device registers
+ * @state:	ACCES IDIO-16 device state
  * @irq_mask:	I/O bits affected by interrupts
  */
 struct idio_16_gpio {
 	struct gpio_chip chip;
 	raw_spinlock_t lock;
-	struct idio_16_gpio_reg __iomem *reg;
+	struct idio_16 __iomem *reg;
+	struct idio_16_state state;
 	unsigned long irq_mask;
 };
 
 static int idio_16_gpio_get_direction(struct gpio_chip *chip,
 	unsigned int offset)
 {
-	if (offset > 15)
+	if (idio_16_get_direction(offset))
 		return GPIO_LINE_DIRECTION_IN;
 
 	return GPIO_LINE_DIRECTION_OUT;
@@ -82,43 +58,16 @@ static int idio_16_gpio_direction_output(struct gpio_chip *chip,
 static int idio_16_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	unsigned long mask = BIT(offset);
-
-	if (offset < 8)
-		return !!(ioread8(&idio16gpio->reg->out0_7) & mask);
-
-	if (offset < 16)
-		return !!(ioread8(&idio16gpio->reg->out8_15) & (mask >> 8));
-
-	if (offset < 24)
-		return !!(ioread8(&idio16gpio->reg->in0_7) & (mask >> 16));
 
-	return !!(ioread8(&idio16gpio->reg->in8_15) & (mask >> 24));
+	return idio_16_get(idio16gpio->reg, &idio16gpio->state, offset);
 }
 
 static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	unsigned long offset;
-	unsigned long gpio_mask;
-	void __iomem *ports[] = {
-		&idio16gpio->reg->out0_7, &idio16gpio->reg->out8_15,
-		&idio16gpio->reg->in0_7, &idio16gpio->reg->in8_15,
-	};
-	void __iomem *port_addr;
-	unsigned long port_state;
-
-	/* clear bits array to a clean slate */
-	bitmap_zero(bits, chip->ngpio);
-
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		port_addr = ports[offset / 8];
-		port_state = ioread8(port_addr) & gpio_mask;
-
-		bitmap_set_value8(bits, port_state, offset);
-	}
 
+	idio_16_get_multiple(idio16gpio->reg, &idio16gpio->state, mask, bits);
 	return 0;
 }
 
@@ -126,61 +75,16 @@ static void idio_16_gpio_set(struct gpio_chip *chip, unsigned int offset,
 	int value)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	unsigned int mask = BIT(offset);
-	void __iomem *base;
-	unsigned long flags;
-	unsigned int out_state;
-
-	if (offset > 15)
-		return;
-
-	if (offset > 7) {
-		mask >>= 8;
-		base = &idio16gpio->reg->out8_15;
-	} else
-		base = &idio16gpio->reg->out0_7;
-
-	raw_spin_lock_irqsave(&idio16gpio->lock, flags);
 
-	if (value)
-		out_state = ioread8(base) | mask;
-	else
-		out_state = ioread8(base) & ~mask;
-
-	iowrite8(out_state, base);
-
-	raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
+	idio_16_set(idio16gpio->reg, &idio16gpio->state, offset, value);
 }
 
 static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	unsigned long offset;
-	unsigned long gpio_mask;
-	void __iomem *ports[] = {
-		&idio16gpio->reg->out0_7, &idio16gpio->reg->out8_15,
-	};
-	size_t index;
-	void __iomem *port_addr;
-	unsigned long bitmask;
-	unsigned long flags;
-	unsigned long out_state;
 
-	for_each_set_clump8(offset, gpio_mask, mask, ARRAY_SIZE(ports) * 8) {
-		index = offset / 8;
-		port_addr = ports[index];
-
-		bitmask = bitmap_get_value8(bits, offset) & gpio_mask;
-
-		raw_spin_lock_irqsave(&idio16gpio->lock, flags);
-
-		out_state = ioread8(port_addr) & ~gpio_mask;
-		out_state |= bitmask;
-		iowrite8(out_state, port_addr);
-
-		raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
-	}
+	idio_16_set_multiple(idio16gpio->reg, &idio16gpio->state, mask, bits);
 }
 
 static void idio_16_irq_ack(struct irq_data *data)
@@ -335,6 +239,8 @@ static int idio_16_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	idio16gpio->chip.set = idio_16_gpio_set;
 	idio16gpio->chip.set_multiple = idio_16_gpio_set_multiple;
 
+	idio_16_state_init(&idio16gpio->state);
+
 	girq = &idio16gpio->chip.irq;
 	girq->chip = &idio_16_irqchip;
 	/* This will let us handle the parent IRQ in the driver */
@@ -379,3 +285,4 @@ module_pci_driver(idio_16_driver);
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("ACCES PCI-IDIO-16 GPIO driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(GPIO_IDIO_16);
-- 
2.37.3

