Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59C16D656F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjDDOdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235646AbjDDOdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:33:01 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D9AAA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 07:32:59 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-54601d90118so461652357b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680618779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Lr4SvpsC9d6vmGEnStr/K2Fbf6hTJB+9QJjxCoRHrU=;
        b=sFyccZhR4XSilLn4g6FAxLo9eFuDSgor7ptJX3e6RMQNz60OskwIz8KfiYslmD5OQO
         1yTERbMUk13m3txmsBTFEujfBmDfOH0ThB8V/Sb7UnUHSFu0P6JSICmPR1cvWwbPq6Dg
         eFftzecxyMB0Nj2/7WHs1A0I11yO+4+Y5881BF+iLoX0/SqQ0wcXHCeFqBGrcs5BBgkT
         SW+t1UGmYAbNYmnUypaKOxKb7X/lq3pQejVcnR4gt41vR9jc4svzzh0o49tIi5qYST8d
         9DRFqH0DGKvt7KWxBtQG585qKTIvOfLecIeoIAHxT2YiP59QBU+v0QGg3aJZ68heqlad
         CBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Lr4SvpsC9d6vmGEnStr/K2Fbf6hTJB+9QJjxCoRHrU=;
        b=dEZCpOfnjRfH5cW77zjLJmFExIhRg8WzBATEzqGEwk5q4VsL8hGOVjrE53tDPRXgG0
         f0VCescGjUekHszrEl/p+NYfQxkVR/pglWygaXcJI9qwqmQi0OIq5zLg8dpUkgsIWSzr
         kPIyQRvodSB0/67EiYsE02tH5miGKvWS7sBCKGaGiiJP8gBtiPNSdT4/Qsr+S5pmA1Bm
         GjgjtODtr0bvTNjKImF3HhhhSPLi0x/YPPzei8vI7dsBoWhtDw98OnccVdwdY6PdrK/N
         eh9B+nj5h0Vq4UKJmBd+LEnqUIubVfgaDf2UHD/HxNJdgjhg2qdUaw8i0IkS+mPLbOjq
         e6Wg==
X-Gm-Message-State: AAQBX9cVo9dA+mOTHo4I91ZQ29GlADazOzYNO5Kyh5NNZW0UKo1a6d0Z
        rUvE+rwMDmE/9wb7gpVxycGvlg==
X-Google-Smtp-Source: AKy350bRRglBc6PPuGxAS+rXRqDDftRJsRChFvl1gpkI4WbSSSvDzXd3PWrW+KVp4iRrB7ILQzkPgw==
X-Received: by 2002:a0d:d405:0:b0:536:350d:4967 with SMTP id w5-20020a0dd405000000b00536350d4967mr2659158ywd.4.1680618778893;
        Tue, 04 Apr 2023 07:32:58 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id p76-20020a81984f000000b00545a0818489sm3234439ywg.25.2023.04.04.07.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:32:58 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 4/4] gpio: idio-16: Remove unused legacy interface
Date:   Tue,  4 Apr 2023 10:32:48 -0400
Message-Id: <651cff1cc3eb57b455a8048121cf6a4d4367f018.1680618405.git.william.gray@linaro.org>
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

All idio-16 library consumers have migrated to the new interface
leveraging the gpio-regmap API. Legacy interface functions and code are
removed as no longer needed.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v5: none

 drivers/gpio/gpio-idio-16.c | 131 +-----------------------------------
 drivers/gpio/gpio-idio-16.h |  65 ------------------
 2 files changed, 1 insertion(+), 195 deletions(-)

diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
index f9349e8d7fdc..53b1eb876a12 100644
--- a/drivers/gpio/gpio-idio-16.c
+++ b/drivers/gpio/gpio-idio-16.c
@@ -3,15 +3,13 @@
  * GPIO library for the ACCES IDIO-16 family
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
 #include <linux/types.h>
 
 #include "gpio-idio-16.h"
@@ -169,133 +167,6 @@ int devm_idio_16_regmap_register(struct device *const dev,
 }
 EXPORT_SYMBOL_GPL(devm_idio_16_regmap_register);
 
-/**
- * idio_16_get - get signal value at signal offset
- * @reg:	ACCES IDIO-16 device registers
- * @state:	ACCES IDIO-16 device state
- * @offset:	offset of signal to get
- *
- * Returns the signal value (0=low, 1=high) for the signal at @offset.
- */
-int idio_16_get(struct idio_16 __iomem *const reg,
-		struct idio_16_state *const state, const unsigned long offset)
-{
-	const unsigned long mask = BIT(offset);
-
-	if (offset < IDIO_16_NOUT)
-		return test_bit(offset, state->out_state);
-
-	if (offset < 24)
-		return !!(ioread8(&reg->in0_7) & (mask >> IDIO_16_NOUT));
-
-	if (offset < 32)
-		return !!(ioread8(&reg->in8_15) & (mask >> 24));
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(idio_16_get);
-
-/**
- * idio_16_get_multiple - get multiple signal values at multiple signal offsets
- * @reg:	ACCES IDIO-16 device registers
- * @state:	ACCES IDIO-16 device state
- * @mask:	mask of signals to get
- * @bits:	bitmap to store signal values
- *
- * Stores in @bits the values (0=low, 1=high) for the signals defined by @mask.
- */
-void idio_16_get_multiple(struct idio_16 __iomem *const reg,
-			  struct idio_16_state *const state,
-			  const unsigned long *const mask,
-			  unsigned long *const bits)
-{
-	unsigned long flags;
-	const unsigned long out_mask = GENMASK(IDIO_16_NOUT - 1, 0);
-
-	spin_lock_irqsave(&state->lock, flags);
-
-	bitmap_replace(bits, bits, state->out_state, &out_mask, IDIO_16_NOUT);
-	if (*mask & GENMASK(23, 16))
-		bitmap_set_value8(bits, ioread8(&reg->in0_7), 16);
-	if (*mask & GENMASK(31, 24))
-		bitmap_set_value8(bits, ioread8(&reg->in8_15), 24);
-
-	spin_unlock_irqrestore(&state->lock, flags);
-}
-EXPORT_SYMBOL_GPL(idio_16_get_multiple);
-
-/**
- * idio_16_set - set signal value at signal offset
- * @reg:	ACCES IDIO-16 device registers
- * @state:	ACCES IDIO-16 device state
- * @offset:	offset of signal to set
- * @value:	value of signal to set
- *
- * Assigns output @value for the signal at @offset.
- */
-void idio_16_set(struct idio_16 __iomem *const reg,
-		 struct idio_16_state *const state, const unsigned long offset,
-		 const unsigned long value)
-{
-	unsigned long flags;
-
-	if (offset >= IDIO_16_NOUT)
-		return;
-
-	spin_lock_irqsave(&state->lock, flags);
-
-	__assign_bit(offset, state->out_state, value);
-	if (offset < 8)
-		iowrite8(bitmap_get_value8(state->out_state, 0), &reg->out0_7);
-	else
-		iowrite8(bitmap_get_value8(state->out_state, 8), &reg->out8_15);
-
-	spin_unlock_irqrestore(&state->lock, flags);
-}
-EXPORT_SYMBOL_GPL(idio_16_set);
-
-/**
- * idio_16_set_multiple - set signal values at multiple signal offsets
- * @reg:	ACCES IDIO-16 device registers
- * @state:	ACCES IDIO-16 device state
- * @mask:	mask of signals to set
- * @bits:	bitmap of signal output values
- *
- * Assigns output values defined by @bits for the signals defined by @mask.
- */
-void idio_16_set_multiple(struct idio_16 __iomem *const reg,
-			  struct idio_16_state *const state,
-			  const unsigned long *const mask,
-			  const unsigned long *const bits)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&state->lock, flags);
-
-	bitmap_replace(state->out_state, state->out_state, bits, mask,
-		       IDIO_16_NOUT);
-	if (*mask & GENMASK(7, 0))
-		iowrite8(bitmap_get_value8(state->out_state, 0), &reg->out0_7);
-	if (*mask & GENMASK(15, 8))
-		iowrite8(bitmap_get_value8(state->out_state, 8), &reg->out8_15);
-
-	spin_unlock_irqrestore(&state->lock, flags);
-}
-EXPORT_SYMBOL_GPL(idio_16_set_multiple);
-
-/**
- * idio_16_state_init - initialize idio_16_state structure
- * @state:	ACCES IDIO-16 device state
- *
- * Initializes the ACCES IDIO-16 device @state for use in idio-16 library
- * functions.
- */
-void idio_16_state_init(struct idio_16_state *const state)
-{
-	spin_lock_init(&state->lock);
-}
-EXPORT_SYMBOL_GPL(idio_16_state_init);
-
 MODULE_AUTHOR("William Breathitt Gray");
 MODULE_DESCRIPTION("ACCES IDIO-16 GPIO Library");
 MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/gpio-idio-16.h b/drivers/gpio/gpio-idio-16.h
index 255bd8504ed7..93b08ad73065 100644
--- a/drivers/gpio/gpio-idio-16.h
+++ b/drivers/gpio/gpio-idio-16.h
@@ -3,9 +3,6 @@
 #ifndef _IDIO_16_H_
 #define _IDIO_16_H_
 
-#include <linux/spinlock.h>
-#include <linux/types.h>
-
 struct device;
 struct regmap;
 struct regmap_irq;
@@ -30,68 +27,6 @@ struct idio_16_regmap_config {
 	bool filters;
 };
 
-/**
- * struct idio_16 - IDIO-16 registers structure
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
-struct idio_16 {
-	u8 out0_7;
-	u8 in0_7;
-	u8 irq_ctl;
-	u8 filter_ctl;
-	u8 out8_15;
-	u8 in8_15;
-	u8 irq_status;
-};
-
-#define IDIO_16_NOUT 16
-
-/**
- * struct idio_16_state - IDIO-16 state structure
- * @lock:	synchronization lock for accessing device state
- * @out_state:	output signals state
- */
-struct idio_16_state {
-	spinlock_t lock;
-	DECLARE_BITMAP(out_state, IDIO_16_NOUT);
-};
-
-/**
- * idio_16_get_direction - get the I/O direction for a signal offset
- * @offset:	offset of signal to get direction
- *
- * Returns the signal direction (0=output, 1=input) for the signal at @offset.
- */
-static inline int idio_16_get_direction(const unsigned long offset)
-{
-	return (offset >= IDIO_16_NOUT) ? 1 : 0;
-}
-
-int idio_16_get(struct idio_16 __iomem *reg, struct idio_16_state *state,
-		unsigned long offset);
-void idio_16_get_multiple(struct idio_16 __iomem *reg,
-			  struct idio_16_state *state,
-			  const unsigned long *mask, unsigned long *bits);
-void idio_16_set(struct idio_16 __iomem *reg, struct idio_16_state *state,
-		 unsigned long offset, unsigned long value);
-void idio_16_set_multiple(struct idio_16 __iomem *reg,
-			  struct idio_16_state *state,
-			  const unsigned long *mask, const unsigned long *bits);
-void idio_16_state_init(struct idio_16_state *state);
-
 int devm_idio_16_regmap_register(struct device *dev, const struct idio_16_regmap_config *config);
 
 #endif /* _IDIO_16_H_ */
-- 
2.39.2

