Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F89640AC4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiLBQ2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiLBQ1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:27:34 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FACEE00
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:27:31 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id p12so3730935qvu.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 08:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIOIvFeXi/+DuXzCtwKMgaypAC1l5I+Malp46WLaEVA=;
        b=f7P+RRAIpgdnMYRSr6RJfXTc54UNimWbhbfZZp68jCV8Ub2eY8cxXFsCsYz2Vk8tlg
         0VOD+TjWBUaKJD5GrbdmJ20dgpt6H8UkbbO6ivxvy0bxVzUa6vC0bu7E/lVvUG4jz7II
         9XMdxqDOkth4n+Np6KuLXXNwKjIKY9UfqNJR8y1P20JBwEQRoGiLBaJDnlGH/GO5Ly5w
         wD2fdZ2/CQTnP/ZR0Dw5dvPiMDjVUShZNwRfdadJQzczAdX5W0OnIgzoDvs/FFTepW2Q
         +OrJSqk2Tj5nlweaRqXfTK9ccz7xwNf+SegVa3qY095JKA/mCL3mImy2j5BENCicGye5
         dF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIOIvFeXi/+DuXzCtwKMgaypAC1l5I+Malp46WLaEVA=;
        b=MoVS+lokytieLACaA3DxV1StZSPTRaZQEbBQiKAfAp8pgl2vt+l7+mjDZXTSbkVsmE
         mSoQOJwgnQdpwSjb3XYQkqSOyDP5Jg2L1D/0Z4uZQfBYuY/hvZ4XOLYqyJqcthcZuDcK
         MG+f4iszFFmZMiBvIUTdOwpivFJ8E4Yvy7Y9n3pQYOgINofIB8JQHWgbRoBNLE1Iz3zu
         UfIPhrHd/geRKnrLWF41TgToDEyKotX8kg7KFz+Gb2QsdTmMVruOhw6Bt9r1Hq2Op7Dt
         XVxktVjMRlMHcwhuT/fGe2FlTn1AkDQWJ1RHY2oxgJfVvDgKe/FWWzoaXcq7VuVtSbcM
         Xkug==
X-Gm-Message-State: ANoB5pmELNVt2P9BE8xJL3bEzRdclGjlpRN0BX+FqdGkhvtPKpjpLfXx
        jdtamHQlMwIA9jMpIEe0auXBcw==
X-Google-Smtp-Source: AA0mqf6j7nkmY48uGhxKtNMIjHc56ZciJ6RbnPH4GaxjMbK2bnkp4Cmv3t5zmhKoWz2xyJ/OMa4hIA==
X-Received: by 2002:ad4:43c5:0:b0:4c6:a5c3:3a7c with SMTP id o5-20020ad443c5000000b004c6a5c33a7cmr49163227qvs.63.1669998450685;
        Fri, 02 Dec 2022 08:27:30 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id fp38-20020a05622a50a600b00343057845f7sm4391887qtb.20.2022.12.02.08.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 08:27:30 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     andriy.shevchenko@linux.intel.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael@walle.cc, broonie@kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v4 9/9] gpio: i8255: Remove unused legacy interface
Date:   Fri,  2 Dec 2022 11:27:15 -0500
Message-Id: <783e505384fe9953eda2dfe8f08544bc090ca284.1669996867.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669996866.git.william.gray@linaro.org>
References: <cover.1669996866.git.william.gray@linaro.org>
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

