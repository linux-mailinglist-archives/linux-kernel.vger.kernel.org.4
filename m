Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8765BBFAE
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 21:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiIRTyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 15:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIRTyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 15:54:13 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AC5B17
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 12:54:12 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 3so18884184qka.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 12:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Py4zn7sdwk5jubVJZEfe77i+avZPnSu9jEYvHHFiqGY=;
        b=nkrViGhQIivOzinqic8l3ZW0aqYEWccaOGR+fLhTAYw6LhIUmOfD2wOpNw+UwD8P2I
         4SBfd2RK+XpLZcg5SKIeaIYJrsoif9dqfoeZ7LagJDbt4nnSZTQGuw4wgzmIW2eQOdRR
         6bjIg005t8BQSYjhEy+HZ4Qo3bYe+Gb4Rh2Ikd8RTSZSKbI2boAs6pGaHuE57NisRUXE
         I28teoO5E7cCr7qTNutBZvUUOJAq2SwO2bAQjrrGTOezH2ZYcfYbY/J7RiidftogB6dQ
         ojrYtndqEtNcCfmloD16dyL83yJmpGO5ZsOFzIprM/v0X3J0XlJK0QHzdHxIO1JiykjY
         Zf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Py4zn7sdwk5jubVJZEfe77i+avZPnSu9jEYvHHFiqGY=;
        b=4yPu7agcA7r0ogIwpSXiux3EG9AlJtOeS0QLdE2yAPqMLBmIYOyv2FB2Ze/vEwuVq8
         CWzkPJhh7fJgJOLDLGF6+3VzIOasqTF9Hzxr1pMbx5vJNmM5thMyQlHCyEH8pDC2j62O
         Nw8xbYAIwCQz45aEOSCFFV2aiMj8Q0kpN8glC5p7QIWkisnz7JGTUZSraH/2uo5ElmCZ
         z75vRrjBAJSvyZTl010ujbyGp1kDkeA00ynyzgqYHc2lww5Vkwx8nG8Pmyq4Y5/HulAC
         GlUadvRrDWsuKZjvaeXdlDPYEwKwbpiXrui7WJTnOX5SSsnhfYUTfQ+QrIGwxV8ofz3p
         K13w==
X-Gm-Message-State: ACrzQf0v5BST1U+5Pw0cBqCy/MWe5o94Cs1GvfPMeJFMutdZINgQnbFs
        mQer5P+BW62gLCJOm1f9KXdnwDwJChH08w==
X-Google-Smtp-Source: AMsMyM4TeKmCnpKlTHebQzKtKe/e25oYYgvs9jqA8W8tVe/s8GgrCfrrVjTzHetJLy6oWMIO95ZVJg==
X-Received: by 2002:a05:620a:f82:b0:6bb:fe29:b43f with SMTP id b2-20020a05620a0f8200b006bbfe29b43fmr11049628qkn.723.1663530851332;
        Sun, 18 Sep 2022 12:54:11 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id i67-20020a37b846000000b006ce7d9dea7asm10753310qkf.13.2022.09.18.12.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 12:54:11 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     brgl@bgdev.pl, linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com,
        linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v2 1/3] gpio: idio-16: Introduce the ACCES IDIO-16 GPIO library module
Date:   Sun, 18 Sep 2022 12:50:43 -0400
Message-Id: <80c7fa6ca523b8a62f70aae8758fdf89771b742e.1663519546.git.william.gray@linaro.org>
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

Exposes consumer library functions to facilitate communication with
devices within the ACCES IDIO-16 family such as the 104-IDIO-16 and
the PCI-IDIO-16.

A CONFIG_GPIO_IDIO_16 Kconfig option is introduced by this patch.
Modules wanting access to these idio-16 library functions should select
this Kconfig option and import the GPIO_IDIO_16 symbol namespace.

Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 MAINTAINERS                 |   7 ++
 drivers/gpio/Kconfig        |   9 +++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-idio-16.c | 146 ++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-idio-16.h |  71 ++++++++++++++++++
 5 files changed, 234 insertions(+)
 create mode 100644 drivers/gpio/gpio-idio-16.c
 create mode 100644 drivers/gpio/gpio-idio-16.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..93938b0bdb91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -312,6 +312,13 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/counter/104-quad-8.c
 
+ACCES IDIO-16 GPIO LIBRARY
+M:	William Breathitt Gray <william.gray@linaro.org>
+L:	linux-gpio@vger.kernel.org
+S:	Maintained
+F:	drivers/gpio/gpio-idio-16.c
+F:	drivers/gpio/gpio-idio-16.h
+
 ACCES PCI-IDIO-16 GPIO DRIVER
 M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-gpio@vger.kernel.org
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ed9e71d6713e..551351e11365 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -109,6 +109,15 @@ config GPIO_REGMAP
 config GPIO_MAX730X
 	tristate
 
+config GPIO_IDIO_16
+	tristate
+	help
+	  Enables support for the idio-16 library functions. The idio-16 library
+	  provides functions to facilitate communication with devices within the
+	  ACCES IDIO-16 family such as the 104-IDIO-16 and the PCI-IDIO-16.
+
+	  If built as a module its name will be gpio-idio-16.
+
 menu "Memory mapped GPIO drivers"
 	depends on HAS_IOMEM
 
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index b67e29d348cf..15abf88c167b 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_GPIO_HLWD)			+= gpio-hlwd.o
 obj-$(CONFIG_HTC_EGPIO)			+= gpio-htc-egpio.o
 obj-$(CONFIG_GPIO_I8255)		+= gpio-i8255.o
 obj-$(CONFIG_GPIO_ICH)			+= gpio-ich.o
+obj-$(CONFIG_GPIO_IDIO_16)		+= gpio-idio-16.o
 obj-$(CONFIG_GPIO_IDT3243X)		+= gpio-idt3243x.o
 obj-$(CONFIG_GPIO_IMX_SCU)		+= gpio-imx-scu.o
 obj-$(CONFIG_GPIO_IOP)			+= gpio-iop.o
diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
new file mode 100644
index 000000000000..13315242d220
--- /dev/null
+++ b/drivers/gpio/gpio-idio-16.c
@@ -0,0 +1,146 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPIO library for the ACCES IDIO-16 family
+ * Copyright (C) 2022 William Breathitt Gray
+ */
+#include <linux/bitmap.h>
+#include <linux/export.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include "gpio-idio-16.h"
+
+#define DEFAULT_SYMBOL_NAMESPACE GPIO_IDIO_16
+
+/**
+ * idio_16_get - get signal value at signal offset
+ * @reg:	ACCES IDIO-16 device registers
+ * @state:	ACCES IDIO-16 device state
+ * @offset:	offset of signal to get
+ *
+ * Returns the signal value (0=low, 1=high) for the signal at @offset.
+ */
+int idio_16_get(struct idio_16 __iomem *const reg,
+		struct idio_16_state *const state, const unsigned long offset)
+{
+	const unsigned long mask = BIT(offset);
+
+	if (offset < IDIO_16_NOUT)
+		return test_bit(offset, state->out_state);
+
+	if (offset < 24)
+		return !!(ioread8(&reg->in0_7) & (mask >> IDIO_16_NOUT));
+
+	if (offset < 32)
+		return !!(ioread8(&reg->in8_15) & (mask >> 24));
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL_GPL(idio_16_get);
+
+/**
+ * idio_16_get_multiple - get multiple signal values at multiple signal offsets
+ * @reg:	ACCES IDIO-16 device registers
+ * @state:	ACCES IDIO-16 device state
+ * @mask:	mask of signals to get
+ * @bits:	bitmap to store signal values
+ *
+ * Stores in @bits the values (0=low, 1=high) for the signals defined by @mask.
+ */
+void idio_16_get_multiple(struct idio_16 __iomem *const reg,
+			  struct idio_16_state *const state,
+			  const unsigned long *const mask,
+			  unsigned long *const bits)
+{
+	unsigned long flags;
+	const unsigned long out_mask = GENMASK(IDIO_16_NOUT - 1, 0);
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	bitmap_replace(bits, bits, state->out_state, &out_mask, IDIO_16_NOUT);
+	if (*mask & GENMASK(23, 16))
+		bitmap_set_value8(bits, ioread8(&reg->in0_7), 16);
+	if (*mask & GENMASK(31, 24))
+		bitmap_set_value8(bits, ioread8(&reg->in8_15), 24);
+
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+EXPORT_SYMBOL_GPL(idio_16_get_multiple);
+
+/**
+ * idio_16_set - set signal value at signal offset
+ * @reg:	ACCES IDIO-16 device registers
+ * @state:	ACCES IDIO-16 device state
+ * @offset:	offset of signal to set
+ * @value:	value of signal to set
+ *
+ * Assigns output @value for the signal at @offset.
+ */
+void idio_16_set(struct idio_16 __iomem *const reg,
+		 struct idio_16_state *const state, const unsigned long offset,
+		 const unsigned long value)
+{
+	unsigned long flags;
+
+	if (offset >= IDIO_16_NOUT)
+		return;
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	__assign_bit(offset, state->out_state, value);
+	if (offset < 8)
+		iowrite8(bitmap_get_value8(state->out_state, 0), &reg->out0_7);
+	else
+		iowrite8(bitmap_get_value8(state->out_state, 8), &reg->out8_15);
+
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+EXPORT_SYMBOL_GPL(idio_16_set);
+
+/**
+ * idio_16_set_multiple - set signal values at multiple signal offsets
+ * @reg:	ACCES IDIO-16 device registers
+ * @state:	ACCES IDIO-16 device state
+ * @mask:	mask of signals to set
+ * @bits:	bitmap of signal output values
+ *
+ * Assigns output values defined by @bits for the signals defined by @mask.
+ */
+void idio_16_set_multiple(struct idio_16 __iomem *const reg,
+			  struct idio_16_state *const state,
+			  const unsigned long *const mask,
+			  const unsigned long *const bits)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	bitmap_replace(state->out_state, state->out_state, bits, mask,
+		       IDIO_16_NOUT);
+	if (*mask & GENMASK(7, 0))
+		iowrite8(bitmap_get_value8(state->out_state, 0), &reg->out0_7);
+	if (*mask & GENMASK(15, 8))
+		iowrite8(bitmap_get_value8(state->out_state, 8), &reg->out8_15);
+
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+EXPORT_SYMBOL_GPL(idio_16_set_multiple);
+
+/**
+ * idio_16_state_init - initialize idio_16_state structure
+ * @state:	ACCES IDIO-16 device state
+ *
+ * Initializes the ACCES IDIO-16 device @state for use in idio-16 library
+ * functions.
+ */
+void idio_16_state_init(struct idio_16_state *const state)
+{
+	spin_lock_init(&state->lock);
+}
+EXPORT_SYMBOL_GPL(idio_16_state_init);
+
+MODULE_AUTHOR("William Breathitt Gray");
+MODULE_DESCRIPTION("ACCES IDIO-16 GPIO Library");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/gpio-idio-16.h b/drivers/gpio/gpio-idio-16.h
new file mode 100644
index 000000000000..928f8251a2bd
--- /dev/null
+++ b/drivers/gpio/gpio-idio-16.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright 2022 William Breathitt Gray */
+#ifndef _IDIO_16_H_
+#define _IDIO_16_H_
+
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+/**
+ * struct idio_16 - IDIO-16 registers structure
+ * @out0_7:	Read: FET Drive Outputs 0-7
+ *		Write: FET Drive Outputs 0-7
+ * @in0_7:	Read: Isolated Inputs 0-7
+ *		Write: Clear Interrupt
+ * @irq_ctl:	Read: Enable IRQ
+ *		Write: Disable IRQ
+ * @filter_ctl:	Read: Activate Input Filters 0-15
+ *		Write: Deactivate Input Filters 0-15
+ * @out8_15:	Read: FET Drive Outputs 8-15
+ *		Write: FET Drive Outputs 8-15
+ * @in8_15:	Read: Isolated Inputs 8-15
+ *		Write: Unused
+ * @irq_status:	Read: Interrupt status
+ *		Write: Unused
+ */
+struct idio_16 {
+	u8 out0_7;
+	u8 in0_7;
+	u8 irq_ctl;
+	u8 filter_ctl;
+	u8 out8_15;
+	u8 in8_15;
+	u8 irq_status;
+};
+
+#define IDIO_16_NOUT 16
+
+/**
+ * struct idio_16_state - IDIO-16 state structure
+ * @lock:	synchronization lock for accessing device state
+ * @out_state:	output signals state
+ */
+struct idio_16_state {
+	spinlock_t lock;
+	DECLARE_BITMAP(out_state, IDIO_16_NOUT);
+};
+
+/**
+ * idio_16_get_direction - get the I/O direction for a signal offset
+ * @offset:	offset of signal to get direction
+ *
+ * Returns the signal direction (0=output, 1=input) for the signal at @offset.
+ */
+static inline int idio_16_get_direction(const unsigned long offset)
+{
+	return (offset >= IDIO_16_NOUT) ? 1 : 0;
+}
+
+int idio_16_get(struct idio_16 __iomem *reg, struct idio_16_state *state,
+		unsigned long offset);
+void idio_16_get_multiple(struct idio_16 __iomem *reg,
+			  struct idio_16_state *state,
+			  const unsigned long *mask, unsigned long *bits);
+void idio_16_set(struct idio_16 __iomem *reg, struct idio_16_state *state,
+		 unsigned long offset, unsigned long value);
+void idio_16_set_multiple(struct idio_16 __iomem *reg,
+			  struct idio_16_state *state,
+			  const unsigned long *mask, const unsigned long *bits);
+void idio_16_state_init(struct idio_16_state *state);
+
+#endif /* _IDIO_16_H_ */
-- 
2.37.3

