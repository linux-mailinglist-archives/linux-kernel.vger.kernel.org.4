Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4455B516F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 00:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiIKWEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 18:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiIKWD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 18:03:56 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F0F240B4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:03:52 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1280590722dso18856116fac.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 15:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=P4WTp8NVqi31X8+vRfSraa/ruIQslcFBKnXqDpaAuZ0=;
        b=jJjHWQz74YQmAHtmtAi0h2gmtW7dpMs4TblognAj2871YXQ1YLzKCqIdKAAVTRm0r4
         PQY5YAQ5FY/2uCrfuBmQxBWvyvhe5YzVxzdoy6ycGyUeSJ2OvULUDi7wB9o9RofcZgTn
         InORMCBMLr1Xa+0ADhAIqVaxfKasvd9u05Dig8fEPJSwnKJqu7MtXFDmbu1lM2Tx6bqM
         4y6AbJb2wkJWtmP3uHkmABja1+Ri4EKaGvVAaIah/ky8HlhrrkcqOD+rTKfagxNWWd2H
         bQNk9a+7Ev5uq/yg4dlUxQAbZm0EVjEuXFB/tf7uWsIB2EM1rq0dLynoKzC0RFIPt4ea
         Bulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=P4WTp8NVqi31X8+vRfSraa/ruIQslcFBKnXqDpaAuZ0=;
        b=AMnh/0TzySuJpZS0gK+5l6nrwYT7/OphzL0dcH8YT2ZlS6WE6VXSFxkkeGsOG0Lut9
         li4g+kCL0b/C+Jn98XQn9X8CDGJMNXe0gVdi1+PGec3KGm0Hvz0mMW7+LBnZ1sR8Irm0
         9aE6/xq15DhCAe5TkPKz7KWLXrNh5txVBjoUnNDqONIhcP45lYN9NCk/bA7uudq3RJtL
         1j1+KvETPSKmaaj84u/xG2RVra5c09KEpSvZV0YStnX0SLej264M/NZhTfclg/Kd2l+y
         5MS63X16FOWM1PvxtrwnqVKxLb4gVFfRktLuQvnIuvAegcTCE0fJICmpBWGtAXXYjs6h
         Olsw==
X-Gm-Message-State: ACgBeo1B8046CcDp8hOOlK7kk2BWuk8t0KdtV/fo1oAr2VrIlgqDUQlU
        6dvt0aV55R0fVdEv3t6e8g4nn4RXmfZnNg==
X-Google-Smtp-Source: AA6agR44SwAF8qwWU+K/AVZ+QQ5MNiBZHBteu6cWe1sC71KaXOQAFYS4ruVdZJowEKhsVCPaacuAow==
X-Received: by 2002:aca:4554:0:b0:343:3998:aff3 with SMTP id s81-20020aca4554000000b003433998aff3mr7789771oia.119.1662933831955;
        Sun, 11 Sep 2022 15:03:51 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id r19-20020a056870439300b00127d2005ea1sm4664249oah.18.2022.09.11.15.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 15:03:51 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     brgl@bgdev.pl, linus.walleij@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 1/3] gpio: idio-16: Introduce the ACCES IDIO-16 GPIO library module
Date:   Sun, 11 Sep 2022 16:34:38 -0400
Message-Id: <6b28fb497c35def57c1920362c82402bed4bd23f.1662927941.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1662927941.git.william.gray@linaro.org>
References: <cover.1662927941.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
this Kconfig option and import the IDIO_16 symbol namespace.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 MAINTAINERS                 |   6 ++
 drivers/gpio/Kconfig        |   9 ++
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-idio-16.c | 159 ++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpio-idio-16.h |  70 ++++++++++++++++
 5 files changed, 245 insertions(+)
 create mode 100644 drivers/gpio/gpio-idio-16.c
 create mode 100644 drivers/gpio/gpio-idio-16.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5012ba6ff9..a143d4bc8547 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -312,6 +312,12 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/counter/104-quad-8.c
 
+ACCES IDIO-16 GPIO LIBRARY
+M:	William Breathitt Gray <william.gray@linaro.org>
+L:	linux-gpio@vger.kernel.org
+S:	Maintained
+F:	drivers/gpio/gpio-idio-16.c
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
index 000000000000..e244032bac35
--- /dev/null
+++ b/drivers/gpio/gpio-idio-16.c
@@ -0,0 +1,159 @@
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
+/**
+ * idio_16_get - get signal value at signal offset
+ * @reg:	ACCES IDIO-16 device registers
+ * @offset:	offset of signal to get
+ *
+ * Returns the signal value (0=low, 1=high) for the signal at @offset.
+ */
+int idio_16_get(struct idio_16 __iomem *const reg, const unsigned long offset)
+{
+	const unsigned long mask = BIT(offset);
+
+	if (offset < 8)
+		return !!(ioread8(&reg->out0_7) & mask);
+
+	if (offset < 16)
+		return !!(ioread8(&reg->out8_15) & (mask >> 8));
+
+	if (offset < 24)
+		return !!(ioread8(&reg->in0_7) & (mask >> 16));
+
+	return !!(ioread8(&reg->in8_15) & (mask >> 24));
+}
+EXPORT_SYMBOL_NS_GPL(idio_16_get, IDIO_16);
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
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	if (*mask & GENMASK(7, 0))
+		bitmap_set_value8(bits, ioread8(&reg->out0_7), 0);
+	if (*mask & GENMASK(15, 8))
+		bitmap_set_value8(bits, ioread8(&reg->out8_15), 8);
+	if (*mask & GENMASK(23, 16))
+		bitmap_set_value8(bits, ioread8(&reg->in0_7), 16);
+	if (*mask & GENMASK(31, 24))
+		bitmap_set_value8(bits, ioread8(&reg->in8_15), 24);
+
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+EXPORT_SYMBOL_NS_GPL(idio_16_get_multiple, IDIO_16);
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
+	/* offsets greater than 15 are input-only signals */
+	if (offset > 15)
+		return;
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	if (value)
+		set_bit(offset, state->out_state);
+	else
+		clear_bit(offset, state->out_state);
+
+	if (offset < 8)
+		iowrite8(bitmap_get_value8(state->out_state, 0), &reg->out0_7);
+	else
+		iowrite8(bitmap_get_value8(state->out_state, 8), &reg->out8_15);
+
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+EXPORT_SYMBOL_NS_GPL(idio_16_set, IDIO_16);
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
+	unsigned long offset;
+	unsigned long port_mask;
+	unsigned long value;
+	unsigned long out_state;
+
+	spin_lock_irqsave(&state->lock, flags);
+
+	for_each_set_clump8(offset, port_mask, mask, IDIO_16_NOUT) {
+		value = bitmap_get_value8(bits, offset);
+		out_state = bitmap_get_value8(state->out_state, offset);
+
+		out_state = (out_state & ~port_mask) | (value & port_mask);
+		bitmap_set_value8(state->out_state, out_state, offset);
+
+		if (offset < 8)
+			iowrite8(out_state, &reg->out0_7);
+		else
+			iowrite8(out_state, &reg->out8_15);
+	}
+
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+EXPORT_SYMBOL_NS_GPL(idio_16_set_multiple, IDIO_16);
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
+EXPORT_SYMBOL_NS_GPL(idio_16_state_init, IDIO_16);
+
+MODULE_AUTHOR("William Breathitt Gray");
+MODULE_DESCRIPTION("ACCES IDIO-16 GPIO Library");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpio/gpio-idio-16.h b/drivers/gpio/gpio-idio-16.h
new file mode 100644
index 000000000000..ce1fa0639243
--- /dev/null
+++ b/drivers/gpio/gpio-idio-16.h
@@ -0,0 +1,70 @@
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
+	return (offset < IDIO_16_NOUT) ? 0 : 1;
+}
+
+int idio_16_get(struct idio_16 __iomem *reg, unsigned long offset);
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
2.37.2

