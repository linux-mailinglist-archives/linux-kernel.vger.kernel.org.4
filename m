Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E50F656BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiL0Odn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiL0Oc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:32:58 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F148BCB5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:32:52 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id n8so5773970oih.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 06:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIOIvFeXi/+DuXzCtwKMgaypAC1l5I+Malp46WLaEVA=;
        b=CsVgnU2DVIEIntrf7AY2Np2X9Pj0NAFY1uGKUimSuwTRNnzMTPxEbwphmZaPc4DRQw
         14YpcWPGiVkB3fGb33TEuU71CsQr1Q38CJYp8hkcEvYvZ41BEa+auDeq8x6BvQ+qHtYb
         FiwrRjgTxrMR1SAwmwgxhFsXao1tnxCVA5yhzegUFCvOEvpz5LnuGbr8wsD3tiSr3Rlo
         8c16L5dnAzFNRTgj0C3NrM66XIjPYO4Ui7re2CbWN6m5oTFw+A4n7v7UmYiH0+sE2rmh
         XYSdWZYLWbRd+lkkg2VDSrvsJ3UcsEb6ffSSreLV3+jTgQaQw51e6/uuCMJk4jTqnMvi
         +6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIOIvFeXi/+DuXzCtwKMgaypAC1l5I+Malp46WLaEVA=;
        b=iybsIPGtcbpeP20vlaXno0tMTaAmEnDbBHUGcNcvrQ0pmCaQpp/VMvPD7dispKT7Uu
         /B+l1KPd6NpU5sSpy2vCyvLVcFsKo6Kxu7UukCX866rXVfr71vL+QlwoP7vnl3ABd+9W
         CxkK3OyBjcQ5aFmJw/NIvii+NTr6fDhvNFIQJqxTB4uK9/RqHj8P1fCaYbgaqcZwXzWQ
         x6NjF68hT0Li9DOWVCV8yKRkBebI296whLOiJnuGpcrW1zlM/L1U4rRVGCK/0RfKzJb6
         UDSIpklBxZIIxmCCO6gQCHb4FLzTlkd9iFsCzHJ6nGrYh9FIlsLoYLrgYhfIkQWVxVru
         Aupg==
X-Gm-Message-State: AFqh2kppHDRl+Xsxb8pE36yZPQv0GVcNBEF0mrZ1OCLzIILhl2wiJbnu
        N8ey0hFUVl+GxA6p0Xs839xmgg==
X-Google-Smtp-Source: AMrXdXtFuj/FYrA/V3WZhmWnjQlmCRIjJXgbqBGIYAy07uKw++DL8vJqE4a1RRY0tCs5wP8WgigwNg==
X-Received: by 2002:a05:6808:2019:b0:35b:ba66:276a with SMTP id q25-20020a056808201900b0035bba66276amr13865335oiw.47.1672151571646;
        Tue, 27 Dec 2022 06:32:51 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q205-20020acac0d6000000b0035bce2a39c7sm5864969oif.21.2022.12.27.06.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 06:32:51 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 8/8] gpio: i8255: Remove unused legacy interface
Date:   Tue, 27 Dec 2022 09:09:46 -0500
Message-Id: <fa3bc8768eb35a27c97afe90cccb0fdc6bf3370e.1672149007.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1672149007.git.william.gray@linaro.org>
References: <cover.1672149007.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All i8255 library consumers have migrated to the new interface
leveraging the gpio-regmap API. Legacy interface functions and code are
removed as no longer needed.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-i8255.c | 243 +-------------------------------------
 drivers/gpio/gpio-i8255.h |  40 -------
 2 files changed, 1 insertion(+), 282 deletions(-)

diff --git a/drivers/gpio/gpio-i8255.c b/drivers/gpio/gpio-i8255.c
index 9ecb2e9b97f9..64ab80fc4a1e 100644
--- a/drivers/gpio/gpio-i8255.c
+++ b/drivers/gpio/gpio-i8255.c
@@ -3,16 +3,13 @@
  * Intel 8255 Programmable Peripheral Interface
  * Copyright (C) 2022 William Breathitt Gray
  */
-#include <linux/bitmap.h>
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/gpio/regmap.h>
-#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
-#include <linux/spinlock.h>
-#include <linux/types.h>
 
 #include "gpio-i8255.h"
 
@@ -30,15 +27,6 @@
 #define I8255_REG_DAT_BASE I8255_PORTA
 #define I8255_REG_DIR_IN_BASE I8255_CONTROL
 
-static int i8255_get_port(struct i8255 __iomem *const ppi,
-			  const unsigned long io_port, const unsigned long mask)
-{
-	const unsigned long bank = io_port / 3;
-	const unsigned long ppi_port = io_port % 3;
-
-	return ioread8(&ppi[bank].port[ppi_port]) & mask;
-}
-
 static int i8255_direction_mask(const unsigned int offset)
 {
 	const unsigned int stride = offset / I8255_NGPIO_PER_REG;
@@ -103,235 +91,6 @@ static int i8255_reg_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
 	}
 }
 
-static void i8255_set_port(struct i8255 __iomem *const ppi,
-			   struct i8255_state *const state,
-			   const unsigned long io_port,
-			   const unsigned long mask, const unsigned long bits)
-{
-	const unsigned long bank = io_port / 3;
-	const unsigned long ppi_port = io_port % 3;
-	unsigned long flags;
-	unsigned long out_state;
-
-	spin_lock_irqsave(&state[bank].lock, flags);
-
-	out_state = ioread8(&ppi[bank].port[ppi_port]);
-	out_state = (out_state & ~mask) | (bits & mask);
-	iowrite8(out_state, &ppi[bank].port[ppi_port]);
-
-	spin_unlock_irqrestore(&state[bank].lock, flags);
-}
-
-/**
- * i8255_direction_input - configure signal offset as input
- * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @state:	devices states of the respective PPI banks
- * @offset:	signal offset to configure as input
- *
- * Configures a signal @offset as input for the respective Intel 8255
- * Programmable Peripheral Interface (@ppi) banks. The @state control_state
- * values are updated to reflect the new configuration.
- */
-void i8255_direction_input(struct i8255 __iomem *const ppi,
-			   struct i8255_state *const state,
-			   const unsigned long offset)
-{
-	const unsigned long io_port = offset / 8;
-	const unsigned long bank = io_port / 3;
-	unsigned long flags;
-
-	spin_lock_irqsave(&state[bank].lock, flags);
-
-	state[bank].control_state |= I8255_CONTROL_MODE_SET;
-	state[bank].control_state |= i8255_direction_mask(offset % 24);
-
-	iowrite8(state[bank].control_state, &ppi[bank].control);
-
-	spin_unlock_irqrestore(&state[bank].lock, flags);
-}
-EXPORT_SYMBOL_NS_GPL(i8255_direction_input, I8255);
-
-/**
- * i8255_direction_output - configure signal offset as output
- * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @state:	devices states of the respective PPI banks
- * @offset:	signal offset to configure as output
- * @value:	signal value to output
- *
- * Configures a signal @offset as output for the respective Intel 8255
- * Programmable Peripheral Interface (@ppi) banks and sets the respective signal
- * output to the desired @value. The @state control_state values are updated to
- * reflect the new configuration.
- */
-void i8255_direction_output(struct i8255 __iomem *const ppi,
-			    struct i8255_state *const state,
-			    const unsigned long offset,
-			    const unsigned long value)
-{
-	const unsigned long io_port = offset / 8;
-	const unsigned long bank = io_port / 3;
-	unsigned long flags;
-
-	spin_lock_irqsave(&state[bank].lock, flags);
-
-	state[bank].control_state |= I8255_CONTROL_MODE_SET;
-	state[bank].control_state &= ~i8255_direction_mask(offset % 24);
-
-	iowrite8(state[bank].control_state, &ppi[bank].control);
-
-	spin_unlock_irqrestore(&state[bank].lock, flags);
-
-	i8255_set(ppi, state, offset, value);
-}
-EXPORT_SYMBOL_NS_GPL(i8255_direction_output, I8255);
-
-/**
- * i8255_get - get signal value at signal offset
- * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @offset:	offset of signal to get
- *
- * Returns the signal value (0=low, 1=high) for the signal at @offset for the
- * respective Intel 8255 Programmable Peripheral Interface (@ppi) banks.
- */
-int i8255_get(struct i8255 __iomem *const ppi, const unsigned long offset)
-{
-	const unsigned long io_port = offset / 8;
-	const unsigned long offset_mask = BIT(offset % 8);
-
-	return !!i8255_get_port(ppi, io_port, offset_mask);
-}
-EXPORT_SYMBOL_NS_GPL(i8255_get, I8255);
-
-/**
- * i8255_get_direction - get the I/O direction for a signal offset
- * @state:	devices states of the respective PPI banks
- * @offset:	offset of signal to get direction
- *
- * Returns the signal direction (0=output, 1=input) for the signal at @offset.
- */
-int i8255_get_direction(const struct i8255_state *const state,
-			const unsigned long offset)
-{
-	const unsigned long io_port = offset / 8;
-	const unsigned long bank = io_port / 3;
-
-	return !!(state[bank].control_state & i8255_direction_mask(offset % 24));
-}
-EXPORT_SYMBOL_NS_GPL(i8255_get_direction, I8255);
-
-/**
- * i8255_get_multiple - get multiple signal values at multiple signal offsets
- * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @mask:	mask of signals to get
- * @bits:	bitmap to store signal values
- * @ngpio:	number of GPIO signals of the respective PPI banks
- *
- * Stores in @bits the values (0=low, 1=high) for the signals defined by @mask
- * for the respective Intel 8255 Programmable Peripheral Interface (@ppi) banks.
- */
-void i8255_get_multiple(struct i8255 __iomem *const ppi,
-			const unsigned long *const mask,
-			unsigned long *const bits, const unsigned long ngpio)
-{
-	unsigned long offset;
-	unsigned long port_mask;
-	unsigned long io_port;
-	unsigned long port_state;
-
-	bitmap_zero(bits, ngpio);
-
-	for_each_set_clump8(offset, port_mask, mask, ngpio) {
-		io_port = offset / 8;
-		port_state = i8255_get_port(ppi, io_port, port_mask);
-
-		bitmap_set_value8(bits, port_state, offset);
-	}
-}
-EXPORT_SYMBOL_NS_GPL(i8255_get_multiple, I8255);
-
-/**
- * i8255_mode0_output - configure all PPI ports to MODE 0 output mode
- * @ppi:	Intel 8255 Programmable Peripheral Interface bank
- *
- * Configures all Intel 8255 Programmable Peripheral Interface (@ppi) ports to
- * MODE 0 (Basic Input/Output) output mode.
- */
-void i8255_mode0_output(struct i8255 __iomem *const ppi)
-{
-	iowrite8(I8255_CONTROL_MODE_SET, &ppi->control);
-}
-EXPORT_SYMBOL_NS_GPL(i8255_mode0_output, I8255);
-
-/**
- * i8255_set - set signal value at signal offset
- * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @state:	devices states of the respective PPI banks
- * @offset:	offset of signal to set
- * @value:	value of signal to set
- *
- * Assigns output @value for the signal at @offset for the respective Intel 8255
- * Programmable Peripheral Interface (@ppi) banks.
- */
-void i8255_set(struct i8255 __iomem *const ppi, struct i8255_state *const state,
-	       const unsigned long offset, const unsigned long value)
-{
-	const unsigned long io_port = offset / 8;
-	const unsigned long port_offset = offset % 8;
-	const unsigned long mask = BIT(port_offset);
-	const unsigned long bits = value << port_offset;
-
-	i8255_set_port(ppi, state, io_port, mask, bits);
-}
-EXPORT_SYMBOL_NS_GPL(i8255_set, I8255);
-
-/**
- * i8255_set_multiple - set signal values at multiple signal offsets
- * @ppi:	Intel 8255 Programmable Peripheral Interface banks
- * @state:	devices states of the respective PPI banks
- * @mask:	mask of signals to set
- * @bits:	bitmap of signal output values
- * @ngpio:	number of GPIO signals of the respective PPI banks
- *
- * Assigns output values defined by @bits for the signals defined by @mask for
- * the respective Intel 8255 Programmable Peripheral Interface (@ppi) banks.
- */
-void i8255_set_multiple(struct i8255 __iomem *const ppi,
-			struct i8255_state *const state,
-			const unsigned long *const mask,
-			const unsigned long *const bits,
-			const unsigned long ngpio)
-{
-	unsigned long offset;
-	unsigned long port_mask;
-	unsigned long io_port;
-	unsigned long value;
-
-	for_each_set_clump8(offset, port_mask, mask, ngpio) {
-		io_port = offset / 8;
-		value = bitmap_get_value8(bits, offset);
-		i8255_set_port(ppi, state, io_port, port_mask, value);
-	}
-}
-EXPORT_SYMBOL_NS_GPL(i8255_set_multiple, I8255);
-
-/**
- * i8255_state_init - initialize i8255_state structure
- * @state:	devices states of the respective PPI banks
- * @nbanks:	number of Intel 8255 Programmable Peripheral Interface banks
- *
- * Initializes the @state of each Intel 8255 Programmable Peripheral Interface
- * bank for use in i8255 library functions.
- */
-void i8255_state_init(struct i8255_state *const state,
-		      const unsigned long nbanks)
-{
-	unsigned long bank;
-
-	for (bank = 0; bank < nbanks; bank++)
-		spin_lock_init(&state[bank].lock);
-}
-EXPORT_SYMBOL_NS_GPL(i8255_state_init, I8255);
-
 /**
  * devm_i8255_regmap_register - Register an i8255 GPIO controller
  * @dev:	device that is registering this i8255 GPIO device
diff --git a/drivers/gpio/gpio-i8255.h b/drivers/gpio/gpio-i8255.h
index 3daa0b145890..9dcf639b94df 100644
--- a/drivers/gpio/gpio-i8255.h
+++ b/drivers/gpio/gpio-i8255.h
@@ -3,29 +3,6 @@
 #ifndef _I8255_H_
 #define _I8255_H_
 
-#include <linux/spinlock.h>
-#include <linux/types.h>
-
-/**
- * struct i8255 - Intel 8255 register structure
- * @port:	Port A, B, and C
- * @control:	Control register
- */
-struct i8255 {
-	u8 port[3];
-	u8 control;
-};
-
-/**
- * struct i8255_state - Intel 8255 state structure
- * @lock:		synchronization lock for accessing device state
- * @control_state:	Control register state
- */
-struct i8255_state {
-	spinlock_t lock;
-	u8 control_state;
-};
-
 struct device;
 struct irq_domain;
 struct regmap;
@@ -54,21 +31,4 @@ struct i8255_regmap_config {
 int devm_i8255_regmap_register(struct device *dev,
 			       const struct i8255_regmap_config *config);
 
-void i8255_direction_input(struct i8255 __iomem *ppi, struct i8255_state *state,
-			   unsigned long offset);
-void i8255_direction_output(struct i8255 __iomem *ppi,
-			    struct i8255_state *state, unsigned long offset,
-			    unsigned long value);
-int i8255_get(struct i8255 __iomem *ppi, unsigned long offset);
-int i8255_get_direction(const struct i8255_state *state, unsigned long offset);
-void i8255_get_multiple(struct i8255 __iomem *ppi, const unsigned long *mask,
-			unsigned long *bits, unsigned long ngpio);
-void i8255_mode0_output(struct i8255 __iomem *const ppi);
-void i8255_set(struct i8255 __iomem *ppi, struct i8255_state *state,
-	       unsigned long offset, unsigned long value);
-void i8255_set_multiple(struct i8255 __iomem *ppi, struct i8255_state *state,
-			const unsigned long *mask, const unsigned long *bits,
-			unsigned long ngpio);
-void i8255_state_init(struct i8255_state *const state, unsigned long nbanks);
-
 #endif /* _I8255_H_ */
-- 
2.38.1

