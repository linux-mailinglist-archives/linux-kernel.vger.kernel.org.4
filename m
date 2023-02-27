Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81236A475D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 17:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbjB0Qyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 11:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjB0Qyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 11:54:32 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7184A166EA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:54:29 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id m4so4870126qvq.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 08:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vj0QltnoAi1JZdrYL3H9FoWyRXqBusk5qG251LO3M8I=;
        b=MFrzT2MAbznI/qnpkq7O0J7HRVDYgeLtTBPsnBUDvpf05eLY9coaStlbgIsQ3BCFpK
         HY2MhikGnT7kqGdEpxRH1Z8rgUQdcop0A0OFMqdi1P7DWysGBlNhUQg/mz5vDrbXlp6U
         7twpoUZXKq/KSxRNomG7r8NHVInFEVT4Y6M3YzaMVpKD0ZsQkjnQ7/27jEl5T5nsnRNP
         eTkmYPzRnMUNzGChbNBC1ogrQDB3X1oLGZAyKzg3x4J60hv9VjiVVhJDBNqUs09qczuW
         It0VY6RvlupZ0F4RN5aZsI6K3/vjAA8OTlvz9glHDKJ6KzypzIs1xeWxIqF8bvUvhNFS
         1/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vj0QltnoAi1JZdrYL3H9FoWyRXqBusk5qG251LO3M8I=;
        b=eK6DGDR8fCPlM9/eFWFQw5sq1QPj892JxG2rWi/5dxDuO3X4IGzmhwSEGgyMgNqOov
         VBJS+kocatlT7iWycKcDjU4GUMSGBT8N1HOEbk1rnv27+x+u/ybTFia+ujBUIdSAslf+
         kJwzNzUyYWZ6vCpgjUA+F6cRwGcMXGq12IC3k4ZOYcs4EiRot6h7bAWXSCoj4v5zB598
         CMfsjUv0DiQmwgABnigqGzAS7nF7wQu8BoKFtiejQCwyzn0Lhbxr/kNA8VnDyusood/0
         Z69rcfl3m8gWVrTT7yXVH1tSbEPAtWt8bOx3YJo3R13jy8bMTcJNnKKzLHdTGO4UldL8
         pYOA==
X-Gm-Message-State: AO0yUKU/bKogkDhiapjNj9mG2zj0fwHSoMu8BfKKKKwkIYb94zacfPkT
        WT6XcZG/oZKVL1AJdzFjAu+4lg==
X-Google-Smtp-Source: AK7set9TkBixM17aDQ9ILlZT8Nzjj8nGnwMZPsn7/T7gp/2A50CFXErkVraD2boi3N2++cPI59Jg8Q==
X-Received: by 2002:a05:6214:27cf:b0:570:bf43:48c with SMTP id ge15-20020a05621427cf00b00570bf43048cmr179679qvb.17.1677516869044;
        Mon, 27 Feb 2023 08:54:29 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id x15-20020a05620a098f00b0073b929d0371sm5238714qkx.4.2023.02.27.08.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 08:54:28 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     broonie@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 6/6] gpio: idio-16: Remove unused legacy interface
Date:   Mon, 27 Feb 2023 11:45:27 -0500
Message-Id: <9720c5c1e4c75d989ee60a6e172de373f7653273.1677515341.git.william.gray@linaro.org>
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

All idio-16 library consumers have migrated to the new interface
leveraging the gpio-regmap API. Legacy interface functions and code are
removed as no longer needed.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/gpio/gpio-idio-16.c | 131 +-----------------------------------
 drivers/gpio/gpio-idio-16.h |  66 ------------------
 2 files changed, 1 insertion(+), 196 deletions(-)

diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
index 13e35d1ef658..26a39aa38426 100644
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
@@ -172,133 +170,6 @@ int devm_idio_16_regmap_register(struct device *const dev,
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
index 22bb591b4ec0..7a4694dae8f5 100644
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
@@ -30,69 +27,6 @@ struct idio_16_regmap_config {
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
- * @irq_mask:	IRQ mask state
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
 int devm_idio_16_regmap_register(struct device *dev,
 				 const struct idio_16_regmap_config *config);
 
-- 
2.39.2

