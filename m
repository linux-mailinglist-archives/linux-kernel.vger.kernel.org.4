Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9A55B516A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 00:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIKWD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 18:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIKWDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 18:03:54 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79607240AE
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:03:53 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-12803ac8113so18773157fac.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hq0WbgIhctdBQePsjEqoAhrjihUpU9iUrZan/SCO+6s=;
        b=yu1HW1vfcPMtfGz5qVNKtjCNYUypwAlWbSX9QY5slQAbrZjqhHrOV4U4nCseBFE1ax
         is6RFKVQYSDtIukP6zsZwCuPuYzvTZV67X7mkG6VFVdDpGhAegS7xcoX5hKbsTVPIbFV
         q3FxcAknwBP0uRQrwXDRh9Py9Se35GY6G/N7yjexudPNxn67Pf08bTFoNbm/VSr/Ll4m
         VtcjCjwatwVLFQuJxozjv6wKXzc12qoglhS5kq68PRxjPLJdkIqSoZ7ax3zmLSuS1UQ/
         nBmfkmsiNW9WfYPKABr6/u7IOb8XnkNatMXGUtPOYQjy5YPiA/diww0cIH/HRN6d0d1X
         B8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hq0WbgIhctdBQePsjEqoAhrjihUpU9iUrZan/SCO+6s=;
        b=TE39CI8in4DL7qqKaf1SGESzu+oiZGlE60F3jzVHvwO/K++EKn796zm73utP1khpTI
         frn7jFYv7NDtemET2MD4YgUUMFzat5vDi+pgCkStrr8E7KlwGQGS8XWMLbpBsl3o3hoS
         NXIjuXbiQxno0IY1/fvEy5+cFXhVblYFjFvtSRJswBsPihc0dMgpPIeKd8/5tOP3OsNo
         TKjb/8zImuSzqaAuepJDNX0v6RmfLQj7PXjIpQy4AgvbT4Jg/q8tFRnJ1ctvRkWMtgnU
         A0fWTUvG30tVAqF6yBjWltNM6kzaO2sZ8r+209bHcbrTMBd0UZo2wNgHbPF1UyVq0L7U
         MOog==
X-Gm-Message-State: ACgBeo1ZM4N5rTX1HopKaAbk6s17Q87QnHq4NY8LJuakUaH0/Buk5j0E
        w2X3yK+EjH43zGa0QifV8jSs/A==
X-Google-Smtp-Source: AA6agR7IZXVU8989QnQKDfzkc8MLUNSjWJDLdFuwZTd7NJW2SVHeJeFwTXqGtWcmhditiE2HVcD+Fg==
X-Received: by 2002:a05:6808:1c04:b0:34f:733d:6c57 with SMTP id ch4-20020a0568081c0400b0034f733d6c57mr3166081oib.130.1662933832831;
        Sun, 11 Sep 2022 15:03:52 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id r19-20020a056870439300b00127d2005ea1sm4664249oah.18.2022.09.11.15.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 15:03:52 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     brgl@bgdev.pl, linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 2/3] gpio: 104-idio-16: Utilize the idio-16 GPIO library
Date:   Sun, 11 Sep 2022 16:34:39 -0400
Message-Id: <6f8b7d379a83e1509ec790bbaf0a9e15fdf26180.1662927941.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1662927941.git.william.gray@linaro.org>
References: <cover.1662927941.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACCES 104-IDIO-16 device is part of the ACCES IDIO-16 family, so the
idio-16 GPIO library module is selected and utilized to consolidate
code.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig            |  1 +
 drivers/gpio/gpio-104-idio-16.c | 91 ++++++++-------------------------
 2 files changed, 22 insertions(+), 70 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 551351e11365..48846ee476e2 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -866,6 +866,7 @@ config GPIO_104_IDIO_16
 	depends on PC104
 	select ISA_BUS_API
 	select GPIOLIB_IRQCHIP
+	select GPIO_IDIO_16
 	help
 	  Enables GPIO support for the ACCES 104-IDIO-16 family (104-IDIO-16,
 	  104-IDIO-16E, 104-IDO-16, 104-IDIO-8, 104-IDIO-8E, 104-IDO-8). The
diff --git a/drivers/gpio/gpio-104-idio-16.c b/drivers/gpio/gpio-104-idio-16.c
index 65a5f581d981..75b5f019676f 100644
--- a/drivers/gpio/gpio-104-idio-16.c
+++ b/drivers/gpio/gpio-104-idio-16.c
@@ -6,7 +6,7 @@
  * This driver supports the following ACCES devices: 104-IDIO-16,
  * 104-IDIO-16E, 104-IDO-16, 104-IDIO-8, 104-IDIO-8E, and 104-IDO-8.
  */
-#include <linux/bits.h>
+#include <linux/bitmap.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/gpio/driver.h>
@@ -21,6 +21,8 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 
+#include "gpio-idio-16.h"
+
 #define IDIO_16_EXTENT 8
 #define MAX_NUM_IDIO_16 max_num_isa_dev(IDIO_16_EXTENT)
 
@@ -33,49 +35,26 @@ static unsigned int irq[MAX_NUM_IDIO_16];
 module_param_hw_array(irq, uint, irq, NULL, 0);
 MODULE_PARM_DESC(irq, "ACCES 104-IDIO-16 interrupt line numbers");
 
-/**
- * struct idio_16_reg - device registers structure
- * @out0_7:	Read: N/A
- *		Write: FET Drive Outputs 0-7
- * @in0_7:	Read: Isolated Inputs 0-7
- *		Write: Clear Interrupt
- * @irq_ctl:	Read: Enable IRQ
- *		Write: Disable IRQ
- * @unused:	N/A
- * @out8_15:	Read: N/A
- *		Write: FET Drive Outputs 8-15
- * @in8_15:	Read: Isolated Inputs 8-15
- *		Write: N/A
- */
-struct idio_16_reg {
-	u8 out0_7;
-	u8 in0_7;
-	u8 irq_ctl;
-	u8 unused;
-	u8 out8_15;
-	u8 in8_15;
-};
-
 /**
  * struct idio_16_gpio - GPIO device private data structure
  * @chip:	instance of the gpio_chip
  * @lock:	synchronization lock to prevent I/O race conditions
  * @irq_mask:	I/O bits affected by interrupts
  * @reg:	I/O address offset for the device registers
- * @out_state:	output bits state
+ * @state:	ACCES IDIO-16 device state
  */
 struct idio_16_gpio {
 	struct gpio_chip chip;
 	raw_spinlock_t lock;
 	unsigned long irq_mask;
-	struct idio_16_reg __iomem *reg;
-	unsigned int out_state;
+	struct idio_16 __iomem *reg;
+	struct idio_16_state state;
 };
 
 static int idio_16_gpio_get_direction(struct gpio_chip *chip,
 				      unsigned int offset)
 {
-	if (offset > 15)
+	if (idio_16_get_direction(offset))
 		return GPIO_LINE_DIRECTION_IN;
 
 	return GPIO_LINE_DIRECTION_OUT;
@@ -97,15 +76,12 @@ static int idio_16_gpio_direction_output(struct gpio_chip *chip,
 static int idio_16_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	const unsigned int mask = BIT(offset-16);
 
-	if (offset < 16)
+	/* Reading output signals is not supported */
+	if (offset < IDIO_16_NOUT)
 		return -EINVAL;
 
-	if (offset < 24)
-		return !!(ioread8(&idio16gpio->reg->in0_7) & mask);
-
-	return !!(ioread8(&idio16gpio->reg->in8_15) & (mask>>8));
+	return idio_16_get(idio16gpio->reg, offset);
 }
 
 static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
@@ -113,12 +89,11 @@ static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
 
-	*bits = 0;
-	if (*mask & GENMASK(23, 16))
-		*bits |= (unsigned long)ioread8(&idio16gpio->reg->in0_7) << 16;
-	if (*mask & GENMASK(31, 24))
-		*bits |= (unsigned long)ioread8(&idio16gpio->reg->in8_15) << 24;
+	/* Reading output signals is not supported */
+	if (*mask & GENMASK(IDIO_16_NOUT - 1, 0))
+		return -EINVAL;
 
+	idio_16_get_multiple(idio16gpio->reg, &idio16gpio->state, mask, bits);
 	return 0;
 }
 
@@ -126,44 +101,16 @@ static void idio_16_gpio_set(struct gpio_chip *chip, unsigned int offset,
 			     int value)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	const unsigned int mask = BIT(offset);
-	unsigned long flags;
-
-	if (offset > 15)
-		return;
 
-	raw_spin_lock_irqsave(&idio16gpio->lock, flags);
-
-	if (value)
-		idio16gpio->out_state |= mask;
-	else
-		idio16gpio->out_state &= ~mask;
-
-	if (offset > 7)
-		iowrite8(idio16gpio->out_state >> 8, &idio16gpio->reg->out8_15);
-	else
-		iowrite8(idio16gpio->out_state, &idio16gpio->reg->out0_7);
-
-	raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
+	idio_16_set(idio16gpio->reg, &idio16gpio->state, offset, value);
 }
 
 static void idio_16_gpio_set_multiple(struct gpio_chip *chip,
 	unsigned long *mask, unsigned long *bits)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&idio16gpio->lock, flags);
-
-	idio16gpio->out_state &= ~*mask;
-	idio16gpio->out_state |= *mask & *bits;
-
-	if (*mask & 0xFF)
-		iowrite8(idio16gpio->out_state, &idio16gpio->reg->out0_7);
-	if ((*mask >> 8) & 0xFF)
-		iowrite8(idio16gpio->out_state >> 8, &idio16gpio->reg->out8_15);
-
-	raw_spin_unlock_irqrestore(&idio16gpio->lock, flags);
+	idio_16_set_multiple(idio16gpio->reg, &idio16gpio->state, mask, bits);
 }
 
 static void idio_16_irq_ack(struct irq_data *data)
@@ -296,7 +243,10 @@ static int idio_16_probe(struct device *dev, unsigned int id)
 	idio16gpio->chip.get_multiple = idio_16_gpio_get_multiple;
 	idio16gpio->chip.set = idio_16_gpio_set;
 	idio16gpio->chip.set_multiple = idio_16_gpio_set_multiple;
-	idio16gpio->out_state = 0xFFFF;
+
+	/* FET off states are represented by bit values of "1" */
+	bitmap_fill(idio16gpio->state.out_state, IDIO_16_NOUT);
+	idio_16_state_init(&idio16gpio->state);
 
 	girq = &idio16gpio->chip.irq;
 	girq->chip = &idio_16_irqchip;
@@ -338,3 +288,4 @@ module_isa_driver(idio_16_driver, num_idio_16);
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("ACCES 104-IDIO-16 GPIO driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(IDIO_16);
-- 
2.37.2

