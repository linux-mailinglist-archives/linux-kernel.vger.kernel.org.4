Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3733F6E3AAC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDPRhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDPRhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:37:17 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D9992
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:37:14 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id q33-20020a056830442100b006a419d3fd20so6739973otv.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681666634; x=1684258634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgquomgyP0WZyeGCpXObZcjAgp90Y+i6L1TXkVWXpcs=;
        b=QPqANpsm3jroLq3O4KhPOVS9egch92T+Q7A6k9KkBqnQZVDcoRLxLiRd8XWWrRHMJ4
         FeF9VpbuV7OIkBqkxlYXG0bMmF1tsY6teF6NBR+dfByQsz50EeQQyWx/AmaW5Uou1WF5
         JhTjE9M/SRkw1Cu+hoVpaUG52ohXbJn/CQVRAgWCqNC1IZK37Y2dyMn+Jd9MUT94W/KH
         3wQKJG0Z1s/i0vfYXfvlxQ8qNOT2Q5TYu3r1qCrhVZ4Ur++j8v3zkzQjqd9aBNjV+SP0
         CzfsYSvCX6dKJgRKGeo7uhPQ30Q61X3PQqVXjY4P6ictFiu/rRfIbIk4UsZRQAEj/pj1
         ZC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681666634; x=1684258634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgquomgyP0WZyeGCpXObZcjAgp90Y+i6L1TXkVWXpcs=;
        b=FCxUtSWnjKPUqS6bNIzNo1y6JVgyAfi7hgzPv8hmIhWiGM6ujy3UM5YSPvz703YRll
         3e0byBW1GUzDsy2ThRNY5a5ctu8tT2cgBgoSVXd6Bri50TOXvEUH8bEfsKoRNIXBbWXf
         +dHxOoT6Q8GUaKk6RHgSxbH9SPKffhJZajem8ROU0idmoMD3MTVsFUxe6XRroFhMDNXY
         rDAYCRXuJ4eUrINRgp7KkZO9LwiQeEgoaF71+FVYfBtk7HIwXALpaQZrrmHTDV3EL3g9
         E+YSWeI5uiRYbB7lhVLS9Gt5uJmrnNKoJcfWaVWmnSU2S+Suw0FT7aYef6TaMH3FaGDl
         0svw==
X-Gm-Message-State: AAQBX9cYIalL1UPbQezLiFnlG+R3nbwxGHumejyTINiS92DgnQbaQALh
        Z/0Efcb48tFb/ci1mfEYm/DQm48VeXeZJ9CEufl/AA==
X-Google-Smtp-Source: AKy350Zqw4AfNPKxXRpBIKW7ovLSAiQsfhmJvZ6on/UwMoiVcy500AHeH6TZsk1x+M7SeKE6+sUHLw==
X-Received: by 2002:a9d:65d7:0:b0:6a5:ea63:b9f4 with SMTP id z23-20020a9d65d7000000b006a5ea63b9f4mr225369oth.15.1681666633646;
        Sun, 16 Apr 2023 10:37:13 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v16-20020a05683011d000b0069457b86060sm3771038otq.47.2023.04.16.10.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 10:37:13 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 1/3] counter: i8254: Introduce the Intel 8254 interface library module
Date:   Sun, 16 Apr 2023 13:36:53 -0400
Message-Id: <f6fe32c2db9525d816ab1a01f45abad56c081652.1681665189.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681665189.git.william.gray@linaro.org>
References: <cover.1681665189.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exposes consumer library functions providing support for interfaces
compatible with the venerable Intel 8254 Programmable Interval Timer
(PIT).

The Intel 8254 PIT first appeared in the early 1980s and was used
initially in IBM PC compatibles. The popularity of the original Intel
825x family of chips led to many subsequent variants and clones of the
interface in various chips and integrated circuits. Although still
popular, interfaces compatible with the Intel 8254 PIT are nowdays
typically found embedded in larger VLSI processing chips and FPGA
components rather than as discrete ICs.

A CONFIG_I8254 Kconfig option is introduced by this patch. Modules
wanting access to these i8254 library functions should select this
Kconfig option, and import the I8254 symbol namespace.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 Documentation/ABI/testing/sysfs-bus-counter |  54 +++
 MAINTAINERS                                 |   7 +
 drivers/counter/Kconfig                     |  15 +
 drivers/counter/Makefile                    |   1 +
 drivers/counter/counter-sysfs.c             |   8 +-
 drivers/counter/i8254.c                     | 447 ++++++++++++++++++++
 include/linux/i8254.h                       |  21 +
 include/uapi/linux/counter.h                |   6 +
 8 files changed, 558 insertions(+), 1 deletion(-)
 create mode 100644 drivers/counter/i8254.c
 create mode 100644 include/linux/i8254.h

diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
index ff83320b4255..6e0946e826d8 100644
--- a/Documentation/ABI/testing/sysfs-bus-counter
+++ b/Documentation/ABI/testing/sysfs-bus-counter
@@ -60,6 +60,60 @@ Description:
 			counter does not freeze at the boundary points, but
 			counts continuously throughout.
 
+		interrupt on terminal count:
+			The output signal is initially low, and will remain low
+			until the counter reaches zero. The output signal then
+			goes high and remains high until a new preset value is
+			set.
+
+		hardware retriggerable one-shot:
+			The output signal is initially high. The output signal
+			will go low by a trigger input signal, and will remain
+			low until the counter reaches zero. The output will then
+			go high and remain high until the next trigger. A
+			trigger results in loading the counter to the preset
+			value and setting the output signal low, thus starting
+			the one-shot pulse.
+
+		rate generator:
+			The output signal is initially high. When the counter
+			has decremented to 1, the output signal goes low for one
+			clock pulse. The output signal then goes high again, the
+			counter is reloaded to the preset value, and the process
+			repeats in a periodic manner as such.
+
+		square wave mode:
+			The output signal is initially high.
+
+			If the initial count is even, the counter is decremented
+			by two on succeeding clock pulses. When the count
+			expires, the output signal changes value and the
+			counter is reloaded to the preset value. The process
+			repeats in periodic manner as such.
+
+			If the initial count is odd, the initial count minus one
+			(an even number) is loaded and then is decremented by
+			two on succeeding clock pulses. One clock pulse after
+			the count expires, the output signal goes low and the
+			counter is reloaded to the preset value minus one.
+			Succeeding clock pulses decrement the count by two. When
+			the count expires, the output goes high again and the
+			counter is reloaded to the preset value minus one. The
+			process repeats in a periodic manner as such.
+
+		software triggered strobe:
+			The output signal is initially high. When the count
+			expires, the output will go low for one clock pulse and
+			then go high again. The counting sequence is "triggered"
+			by setting the preset value.
+
+		hardware triggered strobe:
+			The output signal is initially high. Counting is started
+			by a trigger input signal. When the count expires, the
+			output signal will go low for one clock pulse and then
+			go high again. A trigger results in loading the counter
+			to the preset value.
+
 What:		/sys/bus/counter/devices/counterX/countY/count_mode_available
 What:		/sys/bus/counter/devices/counterX/countY/error_noise_available
 What:		/sys/bus/counter/devices/counterX/countY/function_available
diff --git a/MAINTAINERS b/MAINTAINERS
index 90abe83c02f3..ac170417e1c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10170,6 +10170,13 @@ L:	linux-fbdev@vger.kernel.org
 S:	Maintained
 F:	drivers/video/fbdev/i810/
 
+INTEL 8254 COUNTER DRIVER
+M:	William Breathitt Gray <william.gray@linaro.org>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	drivers/counter/i8254.c
+F:	include/linux/i8254.h
+
 INTEL 8255 GPIO DRIVER
 M:	William Breathitt Gray <william.gray@linaro.org>
 L:	linux-gpio@vger.kernel.org
diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index b5ba8fb02cf7..5a711811819b 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -10,6 +10,21 @@ menuconfig COUNTER
 	  interface. You only need to enable this, if you also want to enable
 	  one or more of the counter device drivers below.
 
+config I8254
+	tristate
+	select COUNTER
+	select REGMAP
+	help
+	  Enables support for the i8254 interface library functions. The i8254
+	  interface library provides functions to facilitate communication with
+	  interfaces compatible with the venerable Intel 8254 Programmable
+	  Interval Timer (PIT). The Intel 825x family of chips was first
+	  released in the early 1980s but compatible interfaces are nowadays
+	  typically found embedded in larger VLSI processing chips and FPGA
+	  components.
+
+	  If built as a module its name will be i8254.
+
 if COUNTER
 
 config 104_QUAD_8
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index b9a369e0d4fc..395c17ddc37a 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -6,6 +6,7 @@
 obj-$(CONFIG_COUNTER) += counter.o
 counter-y := counter-core.o counter-sysfs.o counter-chrdev.o
 
+obj-$(CONFIG_I8254)		+= i8254.o
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_INTERRUPT_CNT)		+= interrupt-cnt.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index b9efe66f9f8d..42c523343d32 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -88,7 +88,13 @@ static const char *const counter_count_mode_str[] = {
 	[COUNTER_COUNT_MODE_NORMAL] = "normal",
 	[COUNTER_COUNT_MODE_RANGE_LIMIT] = "range limit",
 	[COUNTER_COUNT_MODE_NON_RECYCLE] = "non-recycle",
-	[COUNTER_COUNT_MODE_MODULO_N] = "modulo-n"
+	[COUNTER_COUNT_MODE_MODULO_N] = "modulo-n",
+	[COUNTER_COUNT_MODE_INTERRUPT_ON_TERMINAL_COUNT] = "interrupt on terminal count",
+	[COUNTER_COUNT_MODE_HARDWARE_RETRIGGERABLE_ONESHOT] = "hardware retriggerable one-shot",
+	[COUNTER_COUNT_MODE_RATE_GENERATOR] = "rate generator",
+	[COUNTER_COUNT_MODE_SQUARE_WAVE_MODE] = "square wave mode",
+	[COUNTER_COUNT_MODE_SOFTWARE_TRIGGERED_STROBE] = "software triggered strobe",
+	[COUNTER_COUNT_MODE_HARDWARE_TRIGGERED_STROBE] = "hardware triggered strobe",
 };
 
 static const char *const counter_signal_polarity_str[] = {
diff --git a/drivers/counter/i8254.c b/drivers/counter/i8254.c
new file mode 100644
index 000000000000..c41e4fdc9601
--- /dev/null
+++ b/drivers/counter/i8254.c
@@ -0,0 +1,447 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel 8254 Programmable Interval Timer
+ * Copyright (C) William Breathitt Gray
+ */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/counter.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/i8254.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+
+#include <asm/unaligned.h>
+
+#define I8254_COUNTER_REG(_counter) (_counter)
+#define I8254_CONTROL_REG 0x3
+
+#define I8254_SC GENMASK(7, 6)
+#define I8254_RW GENMASK(5, 4)
+#define I8254_M GENMASK(3, 1)
+#define I8254_CONTROL(_sc, _rw, _m) \
+	(u8_encode_bits(_sc, I8254_SC) | u8_encode_bits(_rw, I8254_RW) | \
+	 u8_encode_bits(_m, I8254_M))
+
+#define I8254_RW_TWO_BYTE 0x3
+#define I8254_MODE_INTERRUPT_ON_TERMINAL_COUNT 0
+#define I8254_MODE_HARDWARE_RETRIGGERABLE_ONESHOT 1
+#define I8254_MODE_RATE_GENERATOR 2
+#define I8254_MODE_SQUARE_WAVE_MODE 3
+#define I8254_MODE_SOFTWARE_TRIGGERED_STROBE 4
+#define I8254_MODE_HARDWARE_TRIGGERED_STROBE 5
+
+#define I8254_COUNTER_LATCH(_counter) I8254_CONTROL(_counter, 0x0, 0x0)
+#define I8254_PROGRAM_COUNTER(_counter, _mode) I8254_CONTROL(_counter, I8254_RW_TWO_BYTE, _mode)
+
+#define I8254_NUM_COUNTERS 3
+
+/**
+ * struct i8254 - I8254 device private data structure
+ * @lock:	synchronization lock to prevent I/O race conditions
+ * @preset:	array of Counter Register states
+ * @out_mode:	array of mode configuration states
+ * @map:	Regmap for the device
+ */
+struct i8254 {
+	struct mutex lock;
+	u16 preset[I8254_NUM_COUNTERS];
+	u8 out_mode[I8254_NUM_COUNTERS];
+	struct regmap *map;
+};
+
+static int i8254_count_read(struct counter_device *const counter, struct counter_count *const count,
+			    u64 *const val)
+{
+	struct i8254 *const priv = counter_priv(counter);
+	int ret;
+	u8 value[2];
+
+	mutex_lock(&priv->lock);
+
+	ret = regmap_write(priv->map, I8254_CONTROL_REG, I8254_COUNTER_LATCH(count->id));
+	if (ret) {
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
+	ret = regmap_noinc_read(priv->map, I8254_COUNTER_REG(count->id), value, sizeof(value));
+	if (ret) {
+		mutex_unlock(&priv->lock);
+		return ret;
+	}
+
+	mutex_unlock(&priv->lock);
+
+	*val = get_unaligned_le16(value);
+
+	return ret;
+}
+
+static int i8254_function_read(struct counter_device *const counter,
+			       struct counter_count *const count,
+			       enum counter_function *const function)
+{
+	*function = COUNTER_FUNCTION_DECREASE;
+	return 0;
+}
+
+#define I8254_SYNAPSES_PER_COUNT 2
+#define I8254_SIGNAL_ID_CLK 0
+#define I8254_SIGNAL_ID_GATE 1
+
+static int i8254_action_read(struct counter_device *const counter,
+			     struct counter_count *const count,
+			     struct counter_synapse *const synapse,
+			     enum counter_synapse_action *const action)
+{
+	struct i8254 *const priv = counter_priv(counter);
+
+	switch (synapse->signal->id % I8254_SYNAPSES_PER_COUNT) {
+	case I8254_SIGNAL_ID_CLK:
+		*action = COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
+		return 0;
+	case I8254_SIGNAL_ID_GATE:
+		switch (priv->out_mode[count->id]) {
+		case I8254_MODE_HARDWARE_RETRIGGERABLE_ONESHOT:
+		case I8254_MODE_RATE_GENERATOR:
+		case I8254_MODE_SQUARE_WAVE_MODE:
+		case I8254_MODE_HARDWARE_TRIGGERED_STROBE:
+			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
+			return 0;
+		default:
+			*action = COUNTER_SYNAPSE_ACTION_NONE;
+			return 0;
+		}
+	default:
+		/* should never reach this path */
+		return -EINVAL;
+	}
+}
+
+static int i8254_count_ceiling_read(struct counter_device *const counter,
+				    struct counter_count *const count, u64 *const ceiling)
+{
+	struct i8254 *const priv = counter_priv(counter);
+
+	mutex_lock(&priv->lock);
+
+	switch (priv->out_mode[count->id]) {
+	case I8254_MODE_RATE_GENERATOR:
+		/* Rate Generator decrements 0 by one and the counter "wraps around" */
+		*ceiling = (priv->preset[count->id] == 0) ? U16_MAX : priv->preset[count->id];
+		break;
+	case I8254_MODE_SQUARE_WAVE_MODE:
+		if (priv->preset[count->id] % 2)
+			*ceiling = priv->preset[count->id] - 1;
+		else if (priv->preset[count->id] == 0)
+			/* Square Wave Mode decrements 0 by two and the counter "wraps around" */
+			*ceiling = U16_MAX - 1;
+		else
+			*ceiling = priv->preset[count->id];
+		break;
+	default:
+		*ceiling = U16_MAX;
+		break;
+	}
+
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int i8254_count_mode_read(struct counter_device *const counter,
+				 struct counter_count *const count,
+				 enum counter_count_mode *const count_mode)
+{
+	const struct i8254 *const priv = counter_priv(counter);
+
+	switch (priv->out_mode[count->id]) {
+	case I8254_MODE_INTERRUPT_ON_TERMINAL_COUNT:
+		*count_mode = COUNTER_COUNT_MODE_INTERRUPT_ON_TERMINAL_COUNT;
+		return 0;
+	case I8254_MODE_HARDWARE_RETRIGGERABLE_ONESHOT:
+		*count_mode = COUNTER_COUNT_MODE_HARDWARE_RETRIGGERABLE_ONESHOT;
+		return 0;
+	case I8254_MODE_RATE_GENERATOR:
+		*count_mode = COUNTER_COUNT_MODE_RATE_GENERATOR;
+		return 0;
+	case I8254_MODE_SQUARE_WAVE_MODE:
+		*count_mode = COUNTER_COUNT_MODE_SQUARE_WAVE_MODE;
+		return 0;
+	case I8254_MODE_SOFTWARE_TRIGGERED_STROBE:
+		*count_mode = COUNTER_COUNT_MODE_SOFTWARE_TRIGGERED_STROBE;
+		return 0;
+	case I8254_MODE_HARDWARE_TRIGGERED_STROBE:
+		*count_mode = COUNTER_COUNT_MODE_HARDWARE_TRIGGERED_STROBE;
+		return 0;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
+	}
+}
+
+static int i8254_count_mode_write(struct counter_device *const counter,
+				  struct counter_count *const count,
+				  const enum counter_count_mode count_mode)
+{
+	struct i8254 *const priv = counter_priv(counter);
+	u8 out_mode;
+	int ret;
+
+	switch (count_mode) {
+	case COUNTER_COUNT_MODE_INTERRUPT_ON_TERMINAL_COUNT:
+		out_mode = I8254_MODE_INTERRUPT_ON_TERMINAL_COUNT;
+		break;
+	case COUNTER_COUNT_MODE_HARDWARE_RETRIGGERABLE_ONESHOT:
+		out_mode = I8254_MODE_HARDWARE_RETRIGGERABLE_ONESHOT;
+		break;
+	case COUNTER_COUNT_MODE_RATE_GENERATOR:
+		out_mode = I8254_MODE_RATE_GENERATOR;
+		break;
+	case COUNTER_COUNT_MODE_SQUARE_WAVE_MODE:
+		out_mode = I8254_MODE_SQUARE_WAVE_MODE;
+		break;
+	case COUNTER_COUNT_MODE_SOFTWARE_TRIGGERED_STROBE:
+		out_mode = I8254_MODE_SOFTWARE_TRIGGERED_STROBE;
+		break;
+	case COUNTER_COUNT_MODE_HARDWARE_TRIGGERED_STROBE:
+		out_mode = I8254_MODE_HARDWARE_TRIGGERED_STROBE;
+		break;
+	default:
+		/* should never reach this path */
+		return -EINVAL;
+	}
+
+	mutex_lock(&priv->lock);
+
+	/* Counter Register is cleared when the counter is programmed */
+	priv->preset[count->id] = 0;
+	priv->out_mode[count->id] = out_mode;
+	ret = regmap_write(priv->map, I8254_CONTROL_REG,
+			   I8254_PROGRAM_COUNTER(count->id, out_mode));
+
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int i8254_count_floor_read(struct counter_device *const counter,
+				  struct counter_count *const count, u64 *const floor)
+{
+	struct i8254 *const priv = counter_priv(counter);
+
+	mutex_lock(&priv->lock);
+
+	switch (priv->out_mode[count->id]) {
+	case I8254_MODE_RATE_GENERATOR:
+		/* counter is always reloaded after 1, but 0 is a possible reload value */
+		*floor = (priv->preset[count->id] == 0) ? 0 : 1;
+		break;
+	case I8254_MODE_SQUARE_WAVE_MODE:
+		/* counter is always reloaded after 2 for even preset values */
+		*floor = (priv->preset[count->id] % 2 || priv->preset[count->id] == 0) ? 0 : 2;
+		break;
+	default:
+		*floor = 0;
+		break;
+	}
+
+	mutex_unlock(&priv->lock);
+
+	return 0;
+}
+
+static int i8254_count_preset_read(struct counter_device *const counter,
+				   struct counter_count *const count, u64 *const preset)
+{
+	const struct i8254 *const priv = counter_priv(counter);
+
+	*preset = priv->preset[count->id];
+
+	return 0;
+}
+
+static int i8254_count_preset_write(struct counter_device *const counter,
+				    struct counter_count *const count, const u64 preset)
+{
+	struct i8254 *const priv = counter_priv(counter);
+	int ret;
+	u8 value[2];
+
+	if (preset > U16_MAX)
+		return -ERANGE;
+
+	mutex_lock(&priv->lock);
+
+	if (priv->out_mode[count->id] == I8254_MODE_RATE_GENERATOR ||
+	    priv->out_mode[count->id] == I8254_MODE_SQUARE_WAVE_MODE) {
+		if (preset == 1) {
+			mutex_unlock(&priv->lock);
+			return -EINVAL;
+		}
+	}
+
+	priv->preset[count->id] = preset;
+
+	put_unaligned_le16(preset, value);
+	ret = regmap_noinc_write(priv->map, I8254_COUNTER_REG(count->id), value, 2);
+
+	mutex_unlock(&priv->lock);
+
+	return ret;
+}
+
+static int i8254_init_hw(struct regmap *const map)
+{
+	unsigned long i;
+	int ret;
+
+	for (i = 0; i < I8254_NUM_COUNTERS; i++) {
+		/* Initialize each counter to Mode 0 */
+		ret = regmap_write(map, I8254_CONTROL_REG,
+				   I8254_PROGRAM_COUNTER(i, I8254_MODE_INTERRUPT_ON_TERMINAL_COUNT));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct counter_ops i8254_ops = {
+	.count_read = i8254_count_read,
+	.function_read = i8254_function_read,
+	.action_read = i8254_action_read,
+};
+
+#define I8254_SIGNAL(_id, _name) {		\
+	.id = (_id),				\
+	.name = (_name),			\
+}
+
+static struct counter_signal i8254_signals[] = {
+	I8254_SIGNAL(0, "CLK 0"), I8254_SIGNAL(1, "GATE 0"),
+	I8254_SIGNAL(2, "CLK 1"), I8254_SIGNAL(3, "GATE 1"),
+	I8254_SIGNAL(4, "CLK 2"), I8254_SIGNAL(5, "GATE 2"),
+};
+
+static const enum counter_synapse_action i8254_clk_actions[] = {
+	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
+};
+static const enum counter_synapse_action i8254_gate_actions[] = {
+	COUNTER_SYNAPSE_ACTION_NONE,
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+};
+
+#define I8254_SYNAPSES_BASE(_id) ((_id) * I8254_SYNAPSES_PER_COUNT)
+#define I8254_SYNAPSE_CLK(_id) {					\
+	.actions_list	= i8254_clk_actions,				\
+	.num_actions	= ARRAY_SIZE(i8254_clk_actions),		\
+	.signal		= &i8254_signals[I8254_SYNAPSES_BASE(_id) + 0],	\
+}
+#define I8254_SYNAPSE_GATE(_id) {					\
+	.actions_list	= i8254_gate_actions,				\
+	.num_actions	= ARRAY_SIZE(i8254_gate_actions),		\
+	.signal		= &i8254_signals[I8254_SYNAPSES_BASE(_id) + 1],	\
+}
+
+static struct counter_synapse i8254_synapses[] = {
+	I8254_SYNAPSE_CLK(0), I8254_SYNAPSE_GATE(0),
+	I8254_SYNAPSE_CLK(1), I8254_SYNAPSE_GATE(1),
+	I8254_SYNAPSE_CLK(2), I8254_SYNAPSE_GATE(2),
+};
+
+static const enum counter_function i8254_functions_list[] = {
+	COUNTER_FUNCTION_DECREASE,
+};
+
+static const enum counter_count_mode i8254_count_modes[] = {
+	COUNTER_COUNT_MODE_INTERRUPT_ON_TERMINAL_COUNT,
+	COUNTER_COUNT_MODE_HARDWARE_RETRIGGERABLE_ONESHOT,
+	COUNTER_COUNT_MODE_RATE_GENERATOR,
+	COUNTER_COUNT_MODE_SQUARE_WAVE_MODE,
+	COUNTER_COUNT_MODE_SOFTWARE_TRIGGERED_STROBE,
+	COUNTER_COUNT_MODE_HARDWARE_TRIGGERED_STROBE,
+};
+
+static DEFINE_COUNTER_AVAILABLE(i8254_count_modes_available, i8254_count_modes);
+
+static struct counter_comp i8254_count_ext[] = {
+	COUNTER_COMP_CEILING(i8254_count_ceiling_read, NULL),
+	COUNTER_COMP_COUNT_MODE(i8254_count_mode_read, i8254_count_mode_write,
+				i8254_count_modes_available),
+	COUNTER_COMP_FLOOR(i8254_count_floor_read, NULL),
+	COUNTER_COMP_PRESET(i8254_count_preset_read, i8254_count_preset_write),
+};
+
+#define I8254_COUNT(_id, _name) {				\
+	.id = (_id),						\
+	.name = (_name),					\
+	.functions_list = i8254_functions_list,			\
+	.num_functions = ARRAY_SIZE(i8254_functions_list),	\
+	.synapses = &i8254_synapses[I8254_SYNAPSES_BASE(_id)],	\
+	.num_synapses =	I8254_SYNAPSES_PER_COUNT,		\
+	.ext = i8254_count_ext,					\
+	.num_ext = ARRAY_SIZE(i8254_count_ext)			\
+}
+
+static struct counter_count i8254_counts[I8254_NUM_COUNTERS] = {
+	I8254_COUNT(0, "Counter 0"), I8254_COUNT(1, "Counter 1"), I8254_COUNT(2, "Counter 2"),
+};
+
+/**
+ * devm_i8254_regmap_register - Register an i8254 Counter device
+ * @dev: device that is registering this i8254 Counter device
+ * @config: configuration for i8254_regmap_config
+ *
+ * Registers an Intel 8254 Programmable Interval Timer Counter device. Returns 0 on success and
+ * negative error number on failure.
+ */
+int devm_i8254_regmap_register(struct device *const dev,
+			       const struct i8254_regmap_config *const config)
+{
+	struct counter_device *counter;
+	struct i8254 *priv;
+	int err;
+
+	if (!config->parent)
+		return -EINVAL;
+
+	if (!config->map)
+		return -EINVAL;
+
+	counter = devm_counter_alloc(dev, sizeof(*priv));
+	if (!counter)
+		return -ENOMEM;
+	priv = counter_priv(counter);
+	priv->map = config->map;
+
+	counter->name = dev_name(config->parent);
+	counter->parent = config->parent;
+	counter->ops = &i8254_ops;
+	counter->counts = i8254_counts;
+	counter->num_counts = ARRAY_SIZE(i8254_counts);
+	counter->signals = i8254_signals;
+	counter->num_signals = ARRAY_SIZE(i8254_signals);
+
+	mutex_init(&priv->lock);
+
+	err = i8254_init_hw(priv->map);
+	if (err)
+		return err;
+
+	err = devm_counter_add(dev, counter);
+	if (err < 0)
+		return dev_err_probe(dev, err, "Failed to add counter\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(devm_i8254_regmap_register, I8254);
+
+MODULE_AUTHOR("William Breathitt Gray");
+MODULE_DESCRIPTION("Intel 8254 Programmable Interval Timer");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(COUNTER);
diff --git a/include/linux/i8254.h b/include/linux/i8254.h
new file mode 100644
index 000000000000..a675c309232b
--- /dev/null
+++ b/include/linux/i8254.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (C) William Breathitt Gray */
+#ifndef _I8254_H_
+#define _I8254_H_
+
+struct device;
+struct regmap;
+
+/**
+ * struct i8254_regmap_config - Configuration for the register map of an i8254
+ * @parent:	parent device
+ * @map:	regmap for the i8254
+ */
+struct i8254_regmap_config {
+	struct device *parent;
+	struct regmap *map;
+};
+
+int devm_i8254_regmap_register(struct device *dev, const struct i8254_regmap_config *config);
+
+#endif /* _I8254_H_ */
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
index 8ab12d731e3b..fc248ef00e86 100644
--- a/include/uapi/linux/counter.h
+++ b/include/uapi/linux/counter.h
@@ -127,6 +127,12 @@ enum counter_count_mode {
 	COUNTER_COUNT_MODE_RANGE_LIMIT,
 	COUNTER_COUNT_MODE_NON_RECYCLE,
 	COUNTER_COUNT_MODE_MODULO_N,
+	COUNTER_COUNT_MODE_INTERRUPT_ON_TERMINAL_COUNT,
+	COUNTER_COUNT_MODE_HARDWARE_RETRIGGERABLE_ONESHOT,
+	COUNTER_COUNT_MODE_RATE_GENERATOR,
+	COUNTER_COUNT_MODE_SQUARE_WAVE_MODE,
+	COUNTER_COUNT_MODE_SOFTWARE_TRIGGERED_STROBE,
+	COUNTER_COUNT_MODE_HARDWARE_TRIGGERED_STROBE,
 };
 
 /* Count function values */
-- 
2.39.2

