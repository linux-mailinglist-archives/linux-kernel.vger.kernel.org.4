Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E805BBFAC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 21:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiIRTyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 15:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIRTyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 15:54:14 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420C41BE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 12:54:13 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id j10so16593961qtv.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 12:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vB+4J4Oa+jef1Wd0P3mBtYreQ9A095sLBBrjdC59zCk=;
        b=zcoax0GewR2f0fmvcLAY/qWgWxxnG42gYWNPKLqN2NMtS3PA5kBUgelUUAcUJnoC/8
         ycXmij6MSmCWfM4OArvgj6LiPAtQMW2dcq2oSVKMoyP4ZLCSq6iFx3quVlG4uEKbgY+E
         mvV0fmnxtPLC2Em2/NvXTYMnlCj2pSKvFppUsNdKPbpU7eczSbPO4Yvchoh0S2EL+vhQ
         DyvoRiIJdeLWKofK3E3+jeE1z1jWvB+rukJHgt5UsX/6+/Ou3DP5nlkmvspKybF+u3tH
         /vGgdNOj73CbiKS8H/8r1bCK/DSfOu8QU2nkC2ONkn4lTiLeL/aLuifKwj9AJLJIhokC
         lBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vB+4J4Oa+jef1Wd0P3mBtYreQ9A095sLBBrjdC59zCk=;
        b=TWVZdLxBLN1F3ejAAbebz0DxHN0s874LuOnYxO54J56wXnVsggQm2RZXzoNw/dYG41
         EriiDZdOiSFO1D0jdRM5ae0q2ttvu5gI6XndOFtpv7neztoi5Z1//qgkgUBjlzBwP7Ks
         KvsEj6E42Im3RtirQRo13tGQpUVz9hj6xcB3Cypp6pyF73WEZOz9aPhnz+VcCFVCmpDT
         mSji5dUYIBiG6m8GUuaXzhxjm01IlZclK/vSWNt8ozqDEsn7v7t2XLk8ijllo3/NKX4t
         FtXChITRZzQpZKk15/3rUeRge9PY3SKBAxVphecfV4H0y1x4AkEnXyEYln0PdomSa/2J
         HikA==
X-Gm-Message-State: ACrzQf0+f33u91Qa8tkbcQu8aaQKaTABRijApyFgsmmY/2Nxbrf263Iy
        6gPbf/YsdzcpWT349bGLSFU2FmQm/5wasQ==
X-Google-Smtp-Source: AMsMyM4LjrS+hN5xE/UHHC9oNBf/ZTpD4/NQh12PbuV6y/vYMc+01BwpTsyWnMmQCwEMMCqMsg/r5g==
X-Received: by 2002:a05:622a:14d3:b0:35c:ccc3:eb2c with SMTP id u19-20020a05622a14d300b0035cccc3eb2cmr12325339qtx.77.1663530852320;
        Sun, 18 Sep 2022 12:54:12 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i67-20020a37b846000000b006ce7d9dea7asm10753310qkf.13.2022.09.18.12.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 12:54:11 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     brgl@bgdev.pl, linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 2/3] gpio: 104-idio-16: Utilize the idio-16 GPIO library
Date:   Sun, 18 Sep 2022 12:50:44 -0400
Message-Id: <0245ebf5143cc431af1ac0795c582504c4c6a045.1663519546.git.william.gray@linaro.org>
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

The ACCES 104-IDIO-16 device is part of the ACCES IDIO-16 family, so the
idio-16 GPIO library module is selected and utilized to consolidate
code.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/Kconfig            |  1 +
 drivers/gpio/gpio-104-idio-16.c | 88 ++++++---------------------------
 2 files changed, 17 insertions(+), 72 deletions(-)

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
index 73d95b55a8c5..0f4d36c09aa4 100644
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
 
@@ -34,49 +36,26 @@ static unsigned int num_irq;
 module_param_hw_array(irq, uint, irq, &num_irq, 0);
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
@@ -98,15 +77,8 @@ static int idio_16_gpio_direction_output(struct gpio_chip *chip,
 static int idio_16_gpio_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	const unsigned int mask = BIT(offset-16);
 
-	if (offset < 16)
-		return -EINVAL;
-
-	if (offset < 24)
-		return !!(ioread8(&idio16gpio->reg->in0_7) & mask);
-
-	return !!(ioread8(&idio16gpio->reg->in8_15) & (mask>>8));
+	return idio_16_get(idio16gpio->reg, &idio16gpio->state, offset);
 }
 
 static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
@@ -114,11 +86,7 @@ static int idio_16_gpio_get_multiple(struct gpio_chip *chip,
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
 
-	*bits = 0;
-	if (*mask & GENMASK(23, 16))
-		*bits |= (unsigned long)ioread8(&idio16gpio->reg->in0_7) << 16;
-	if (*mask & GENMASK(31, 24))
-		*bits |= (unsigned long)ioread8(&idio16gpio->reg->in8_15) << 24;
+	idio_16_get_multiple(idio16gpio->reg, &idio16gpio->state, mask, bits);
 
 	return 0;
 }
@@ -127,44 +95,16 @@ static void idio_16_gpio_set(struct gpio_chip *chip, unsigned int offset,
 			     int value)
 {
 	struct idio_16_gpio *const idio16gpio = gpiochip_get_data(chip);
-	const unsigned int mask = BIT(offset);
-	unsigned long flags;
 
-	if (offset > 15)
-		return;
-
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
@@ -297,7 +237,10 @@ static int idio_16_probe(struct device *dev, unsigned int id)
 	idio16gpio->chip.get_multiple = idio_16_gpio_get_multiple;
 	idio16gpio->chip.set = idio_16_gpio_set;
 	idio16gpio->chip.set_multiple = idio_16_gpio_set_multiple;
-	idio16gpio->out_state = 0xFFFF;
+
+	idio_16_state_init(&idio16gpio->state);
+	/* FET off states are represented by bit values of "1" */
+	bitmap_fill(idio16gpio->state.out_state, IDIO_16_NOUT);
 
 	girq = &idio16gpio->chip.irq;
 	girq->chip = &idio_16_irqchip;
@@ -339,3 +282,4 @@ module_isa_driver_with_irq(idio_16_driver, num_idio_16, num_irq);
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("ACCES 104-IDIO-16 GPIO driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(GPIO_IDIO_16);
-- 
2.37.3

