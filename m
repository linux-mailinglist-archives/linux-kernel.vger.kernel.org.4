Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9015BFBFE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 12:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiIUKGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 06:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiIUKGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 06:06:38 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCADC78584
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:06:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lh5so12392654ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 03:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Palnjrbjrrxk2bRkkd1VBmNyudCK01Dtb8ARpsFuhZ0=;
        b=5OAgQBGfpH5RQLqcIvH1MkT0uc5ehXqkDxXLzTsA0sIKoDrzV/o3tCxMqS0P8saSkw
         kasarbPS5v6EIj7GwIcayaTjXGVxY7cUHmeZT2yGAH++TxU8YZmXcgk4ygHwms3XQry1
         tz0sUPpqPSkHlrj5BSKr6oYQXm4zphIUPOV1DGUuKazPWSveBiIb/508WzRqS9bie+HZ
         0Pe1Oreu7q3JhC6WofFvtaAOv9Yyp1COEM4CB60XY3dsnHQiOSzFfMx7/bifFX18+8hy
         efyTDNbdrvKOUORNtgGMfE62QijKj2rQrwVQjD6KBjNUF78PIndEPqJoRC+ve3j6zpaZ
         O28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Palnjrbjrrxk2bRkkd1VBmNyudCK01Dtb8ARpsFuhZ0=;
        b=2XqYyA/AbcZirBFHahlIX7zO8SJ+plopcNKa6aLpVi8o1en9HUSeODAfQ0hoQy4X6R
         c/VATE86WcjjLE6whs8BiAGOhuvWuSY8K4KF7T8GIPnHRcV6+P6IhttwOfVHnQ4s8Jey
         zTWd4pNZ1YksSGvWaUtKLBjrUIN08dw/gdQ4G+b9rNm6LLjRwEzaZdSW+y+/Um8gByza
         UFTaECEdxc9BIFcO6+US4EHxCEWyr9s07qO8XiwdlEXiOEybHvxffeXJzxey5WRO9MSu
         j3UQSO1ZNxNqSOPPxBtpy7dnBcxCTLRU0KR4XSRaqIckNfet7WDMtG00Wp16hIL9PZYJ
         TGSg==
X-Gm-Message-State: ACrzQf11P3oCLfsRO3TUnCFRfHqFUsmlS1v1NMsZWYcn/jOJry4jsFsD
        qAv2wSGW58vhPLKIV89cdhoQOg==
X-Google-Smtp-Source: AMsMyM7YIPtagMM/aLPrxeXbvN+LUkqWfGlEodrMCxTjiy6NqzfdnLd63hkVQUlLWi/HfkIb62CzGg==
X-Received: by 2002:a17:907:7f05:b0:781:e579:46b5 with SMTP id qf5-20020a1709077f0500b00781e57946b5mr4115561ejc.102.1663754794097;
        Wed, 21 Sep 2022 03:06:34 -0700 (PDT)
Received: from baylibre-ThinkPad-T14s-Gen-2i.. (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id v1-20020a170906292100b0074134543f82sm1087710ejd.90.2022.09.21.03.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 03:06:33 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     william.gray@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: [PATCH v7 3/4] counter: ti-ecap-capture: capture driver support for ECAP
Date:   Wed, 21 Sep 2022 12:06:26 +0200
Message-Id: <20220921100627.124085-4-jpanis@baylibre.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220921100627.124085-1-jpanis@baylibre.com>
References: <20220921100627.124085-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ECAP hardware on TI AM62x SoC supports capture feature. It can be used
to timestamp events (falling/rising edges) detected on input signal.

This commit adds capture driver support for ECAP hardware on AM62x SoC.

In the ECAP hardware, capture pin can also be configured to be in
PWM mode. Current implementation only supports capture operating mode.
Hardware also supports timebase sync between multiple instances, but
this driver supports simple independent capture functionality.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 drivers/counter/Kconfig           |  15 +
 drivers/counter/Makefile          |   1 +
 drivers/counter/ti-ecap-capture.c | 614 ++++++++++++++++++++++++++++++
 3 files changed, 630 insertions(+)
 create mode 100644 drivers/counter/ti-ecap-capture.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index 5edd155f1911..d388bf26f4dc 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -101,4 +101,19 @@ config INTEL_QEP
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-qep.
 
+config TI_ECAP_CAPTURE
+	tristate "TI eCAP capture driver"
+	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
+	depends on HAS_IOMEM
+	select REGMAP_MMIO
+	help
+	  Select this option to enable the Texas Instruments Enhanced Capture
+	  (eCAP) driver in input mode.
+
+	  It can be used to timestamp events (falling/rising edges) detected
+	  on ECAP input signal.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ti-ecap-capture.
+
 endif # COUNTER
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index 8fde6c100ebc..b9a369e0d4fc 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
 obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
 obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+= microchip-tcb-capture.o
 obj-$(CONFIG_INTEL_QEP)		+= intel-qep.o
+obj-$(CONFIG_TI_ECAP_CAPTURE)	+= ti-ecap-capture.o
diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
new file mode 100644
index 000000000000..1c0eeb6302dd
--- /dev/null
+++ b/drivers/counter/ti-ecap-capture.c
@@ -0,0 +1,614 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * ECAP Capture driver
+ *
+ * Copyright (C) 2022 Julien Panis <jpanis@baylibre.com>
+ */
+
+#include <linux/atomic.h>
+#include <linux/clk.h>
+#include <linux/counter.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#define ECAP_DRV_NAME "ecap"
+
+/* ECAP event IDs */
+#define ECAP_CEVT1		0
+#define ECAP_CEVT2		1
+#define ECAP_CEVT3		2
+#define ECAP_CEVT4		3
+#define ECAP_CNTOVF		4
+
+#define ECAP_CEVT_LAST		ECAP_CEVT4
+#define ECAP_NB_CEVT		(ECAP_CEVT_LAST + 1)
+
+#define ECAP_EVT_LAST		ECAP_CNTOVF
+#define ECAP_NB_EVT		(ECAP_EVT_LAST + 1)
+
+/* Registers */
+#define ECAP_TSCNT_REG			0x00
+
+#define ECAP_CAP_REG(i)		(((i) << 2) + 0x08)
+
+#define ECAP_ECCTL_REG			0x28
+#define ECAP_CAPPOL_BIT(i)		BIT((i) << 1)
+#define ECAP_EV_MODE_MASK		GENMASK(7, 0)
+#define ECAP_CAPLDEN_BIT		BIT(8)
+#define ECAP_CONT_ONESHT_BIT		BIT(16)
+#define ECAP_STOPVALUE_MASK		GENMASK(18, 17)
+#define ECAP_TSCNTSTP_BIT		BIT(20)
+#define ECAP_SYNCO_DIS_MASK		GENMASK(23, 22)
+#define ECAP_CAP_APWM_BIT		BIT(25)
+#define ECAP_ECCTL_EN_MASK		(ECAP_CAPLDEN_BIT | ECAP_TSCNTSTP_BIT)
+#define ECAP_ECCTL_CFG_MASK		(ECAP_SYNCO_DIS_MASK | ECAP_STOPVALUE_MASK	\
+					| ECAP_ECCTL_EN_MASK | ECAP_CAP_APWM_BIT	\
+					| ECAP_CONT_ONESHT_BIT)
+
+#define ECAP_ECINT_EN_FLG_REG		0x2c
+#define ECAP_EVT_EN_MASK		GENMASK(ECAP_NB_EVT, ECAP_NB_CEVT)
+#define ECAP_EVT_FLG_BIT(i)		BIT((i) + 17)
+
+#define ECAP_ECINT_CLR_FRC_REG	0x30
+#define ECAP_INT_CLR_BIT		BIT(0)
+#define ECAP_EVT_CLR_BIT(i)		BIT((i) + 1)
+#define ECAP_EVT_CLR_MASK		GENMASK(ECAP_NB_EVT, 0)
+
+#define ECAP_PID_REG			0x5c
+
+/*
+ * Event modes
+ * One bit for each CAPx register : 1 = falling edge / 0 = rising edge
+ * e.g. mode = 13 = 0xd = 0b1101
+ * -> falling edge for CAP1-3-4 / rising edge for CAP2
+ */
+#define ECAP_EV_MODE_BIT(i)		BIT(i)
+
+/* ECAP signals */
+#define ECAP_CLOCK_SIG 0
+#define ECAP_INPUT_SIG 1
+
+static const struct regmap_config ecap_cnt_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = ECAP_PID_REG,
+};
+
+/**
+ * struct ecap_cnt_dev - device private data structure
+ * @enabled:  device state
+ * @clk:      device clock
+ * @regmap:   device register map
+ * @nb_ovf:   number of overflows since capture start
+ * @pm_ctx:   device context for PM operations
+ */
+struct ecap_cnt_dev {
+	bool enabled;
+	struct clk *clk;
+	struct regmap *regmap;
+	atomic_t nb_ovf;
+	struct {
+		u8 ev_mode;
+		u64 time_cntr;
+	} pm_ctx;
+};
+
+static u8 ecap_cnt_capture_get_evmode(struct counter_device *counter)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+	u8 ev_mode = 0;
+	unsigned int regval;
+	int i;
+
+	pm_runtime_get_sync(counter->parent);
+	regmap_read(ecap_dev->regmap, ECAP_ECCTL_REG, &regval);
+	pm_runtime_put_sync(counter->parent);
+
+	for (i = 0 ; i < ECAP_NB_CEVT ; i++) {
+		if (regval & ECAP_CAPPOL_BIT(i))
+			ev_mode |= ECAP_EV_MODE_BIT(i);
+	}
+
+	return ev_mode;
+}
+
+static void ecap_cnt_capture_set_evmode(struct counter_device *counter, u8 ev_mode)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+	unsigned int regval = 0;
+	int i;
+
+	for (i = 0 ; i < ECAP_NB_CEVT ; i++) {
+		if (ev_mode & ECAP_EV_MODE_BIT(i))
+			regval |= ECAP_CAPPOL_BIT(i);
+	}
+
+	pm_runtime_get_sync(counter->parent);
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_EV_MODE_MASK, regval);
+	pm_runtime_put_sync(counter->parent);
+}
+
+static void ecap_cnt_capture_enable(struct counter_device *counter)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	pm_runtime_get_sync(counter->parent);
+
+	/* Enable interrupts on events */
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG,
+			   ECAP_EVT_EN_MASK, ECAP_EVT_EN_MASK);
+
+	/* Run counter */
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_CFG_MASK,
+			   ECAP_SYNCO_DIS_MASK | ECAP_STOPVALUE_MASK | ECAP_ECCTL_EN_MASK);
+}
+
+static void ecap_cnt_capture_disable(struct counter_device *counter)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	/* Disable interrupts on events */
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, ECAP_EVT_EN_MASK, 0);
+
+	/* Stop counter */
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_ECCTL_EN_MASK, 0);
+
+	pm_runtime_put_sync(counter->parent);
+}
+
+static int ecap_cnt_count_get_val(struct counter_device *counter, unsigned int reg, u64 *val)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+	unsigned int regval;
+
+	pm_runtime_get_sync(counter->parent);
+	regmap_read(ecap_dev->regmap, reg, &regval);
+	pm_runtime_put_sync(counter->parent);
+
+	*val = regval;
+
+	return 0;
+}
+
+static int ecap_cnt_count_set_val(struct counter_device *counter, unsigned int reg, u64 val)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	pm_runtime_get_sync(counter->parent);
+	regmap_write(ecap_dev->regmap, reg, val);
+	pm_runtime_put_sync(counter->parent);
+
+	return 0;
+}
+
+static inline int ecap_cnt_count_read(struct counter_device *counter,
+				      struct counter_count *count, u64 *val)
+{
+	return ecap_cnt_count_get_val(counter, ECAP_TSCNT_REG, val);
+}
+
+static int ecap_cnt_count_write(struct counter_device *counter,
+				struct counter_count *count, u64 val)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	if (ecap_dev->enabled)
+		return -EBUSY;
+	if (val > 0)
+		return -EINVAL;
+
+	return ecap_cnt_count_set_val(counter, ECAP_TSCNT_REG, val);
+}
+
+static int ecap_cnt_function_read(struct counter_device *counter,
+				  struct counter_count *count,
+				  enum counter_function *function)
+{
+	*function = COUNTER_FUNCTION_INCREASE;
+
+	return 0;
+}
+
+static int ecap_cnt_action_read(struct counter_device *counter,
+				struct counter_count *count,
+				struct counter_synapse *synapse,
+				enum counter_synapse_action *action)
+{
+	*action = (synapse->signal->id == ECAP_CLOCK_SIG) ?
+		   COUNTER_SYNAPSE_ACTION_RISING_EDGE :
+		   COUNTER_SYNAPSE_ACTION_NONE;
+
+	return 0;
+}
+
+static int ecap_cnt_watch_validate(struct counter_device *counter,
+				   const struct counter_watch *watch)
+{
+	if ((watch->channel <= ECAP_CEVT_LAST && watch->event == COUNTER_EVENT_CAPTURE) ||
+	    (watch->channel == ECAP_CNTOVF && watch->event == COUNTER_EVENT_OVERFLOW))
+		return 0;
+
+	return -EINVAL;
+}
+
+static int ecap_cnt_clk_get_freq(struct counter_device *counter,
+				 struct counter_signal *signal, u64 *freq)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	*freq = clk_get_rate(ecap_dev->clk);
+
+	return 0;
+}
+
+static int ecap_cnt_pol_read(struct counter_device *counter,
+			     struct counter_signal *signal,
+			     size_t idx, enum counter_signal_polarity *pol)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	pm_runtime_get_sync(counter->parent);
+	*pol = regmap_test_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx)) ?
+	       COUNTER_SIGNAL_POLARITY_NEGATIVE :
+	       COUNTER_SIGNAL_POLARITY_POSITIVE;
+	pm_runtime_put_sync(counter->parent);
+
+	return 0;
+}
+
+static int ecap_cnt_pol_write(struct counter_device *counter,
+			      struct counter_signal *signal,
+			      size_t idx, enum counter_signal_polarity pol)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	if (ecap_dev->enabled)
+		return -EBUSY;
+
+	pm_runtime_get_sync(counter->parent);
+	if (pol == COUNTER_SIGNAL_POLARITY_NEGATIVE)
+		regmap_set_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx));
+	else
+		regmap_clear_bits(ecap_dev->regmap, ECAP_ECCTL_REG, ECAP_CAPPOL_BIT(idx));
+	pm_runtime_put_sync(counter->parent);
+
+	return 0;
+}
+
+static inline int ecap_cnt_cap_read(struct counter_device *counter,
+				    struct counter_count *count,
+				    size_t idx, u64 *cap)
+{
+	return ecap_cnt_count_get_val(counter, ECAP_CAP_REG(idx), cap);
+}
+
+static int ecap_cnt_nb_ovf_read(struct counter_device *counter,
+				struct counter_count *count, u64 *val)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	*val = atomic_read(&ecap_dev->nb_ovf);
+
+	return 0;
+}
+
+static int ecap_cnt_nb_ovf_write(struct counter_device *counter,
+				 struct counter_count *count, u64 val)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	if (ecap_dev->enabled)
+		return -EBUSY;
+	if (val > 0)
+		return -EINVAL;
+
+	atomic_set(&ecap_dev->nb_ovf, val);
+
+	return 0;
+}
+
+static int ecap_cnt_ceiling_read(struct counter_device *counter,
+				 struct counter_count *count, u64 *val)
+{
+	*val = U32_MAX;
+
+	return 0;
+}
+
+static int ecap_cnt_enable_read(struct counter_device *counter,
+				struct counter_count *count, u8 *enable)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	*enable = ecap_dev->enabled;
+
+	return 0;
+}
+
+static int ecap_cnt_enable_write(struct counter_device *counter,
+				 struct counter_count *count, u8 enable)
+{
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
+
+	if (enable == ecap_dev->enabled)
+		return 0;
+	if (enable)
+		ecap_cnt_capture_enable(counter);
+	else
+		ecap_cnt_capture_disable(counter);
+	ecap_dev->enabled = enable;
+
+	return 0;
+}
+
+static const struct counter_ops ecap_cnt_ops = {
+	.count_read = ecap_cnt_count_read,
+	.count_write = ecap_cnt_count_write,
+	.function_read = ecap_cnt_function_read,
+	.action_read = ecap_cnt_action_read,
+	.watch_validate = ecap_cnt_watch_validate,
+};
+
+static const enum counter_function ecap_cnt_functions[] = {
+	COUNTER_FUNCTION_INCREASE,
+};
+
+static const enum counter_synapse_action ecap_cnt_clock_actions[] = {
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+};
+
+static const enum counter_synapse_action ecap_cnt_input_actions[] = {
+	COUNTER_SYNAPSE_ACTION_NONE,
+};
+
+static struct counter_comp ecap_cnt_clock_ext[] = {
+	COUNTER_COMP_SIGNAL_U64("frequency", ecap_cnt_clk_get_freq, NULL),
+};
+
+static const enum counter_signal_polarity ecap_cnt_pol_avail[] = {
+	COUNTER_SIGNAL_POLARITY_POSITIVE,
+	COUNTER_SIGNAL_POLARITY_NEGATIVE,
+};
+
+static DEFINE_COUNTER_ARRAY_POLARITY(ecap_cnt_pol_array, ecap_cnt_pol_avail, ECAP_NB_CEVT);
+
+static struct counter_comp ecap_cnt_signal_ext[] = {
+	COUNTER_COMP_ARRAY_POLARITY(ecap_cnt_pol_read, ecap_cnt_pol_write, ecap_cnt_pol_array),
+};
+
+static struct counter_signal ecap_cnt_signals[] = {
+	{
+		.id = ECAP_CLOCK_SIG,
+		.name = "Clock Signal",
+		.ext = ecap_cnt_clock_ext,
+		.num_ext = ARRAY_SIZE(ecap_cnt_clock_ext),
+	},
+	{
+		.id = ECAP_INPUT_SIG,
+		.name = "Input Signal",
+		.ext = ecap_cnt_signal_ext,
+		.num_ext = ARRAY_SIZE(ecap_cnt_signal_ext),
+	},
+};
+
+static struct counter_synapse ecap_cnt_synapses[] = {
+	{
+		.actions_list = ecap_cnt_clock_actions,
+		.num_actions = ARRAY_SIZE(ecap_cnt_clock_actions),
+		.signal = &ecap_cnt_signals[ECAP_CLOCK_SIG],
+	},
+	{
+		.actions_list = ecap_cnt_input_actions,
+		.num_actions = ARRAY_SIZE(ecap_cnt_input_actions),
+		.signal = &ecap_cnt_signals[ECAP_INPUT_SIG],
+	},
+};
+
+static DEFINE_COUNTER_ARRAY_U64(ecap_cnt_cap_array, ECAP_NB_CEVT);
+
+static struct counter_comp ecap_cnt_count_ext[] = {
+	COUNTER_COMP_COUNT_ARRAY_U64("capture", ecap_cnt_cap_read, NULL, ecap_cnt_cap_array),
+	COUNTER_COMP_COUNT_U64("num_overflows", ecap_cnt_nb_ovf_read, ecap_cnt_nb_ovf_write),
+	COUNTER_COMP_CEILING(ecap_cnt_ceiling_read, NULL),
+	COUNTER_COMP_ENABLE(ecap_cnt_enable_read, ecap_cnt_enable_write),
+};
+
+static struct counter_count ecap_cnt_counts[] = {
+	{
+		.id = 0,
+		.name = "Timestamp Counter",
+		.functions_list = ecap_cnt_functions,
+		.num_functions = ARRAY_SIZE(ecap_cnt_functions),
+		.synapses = ecap_cnt_synapses,
+		.num_synapses = ARRAY_SIZE(ecap_cnt_synapses),
+		.ext = ecap_cnt_count_ext,
+		.num_ext = ARRAY_SIZE(ecap_cnt_count_ext),
+	},
+};
+
+static irqreturn_t ecap_cnt_isr(int irq, void *dev_id)
+{
+	struct counter_device *counter_dev = dev_id;
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
+	unsigned int clr = 0;
+	unsigned int flg;
+	int i;
+
+	regmap_read(ecap_dev->regmap, ECAP_ECINT_EN_FLG_REG, &flg);
+
+	/* Check capture events */
+	for (i = 0 ; i < ECAP_NB_CEVT ; i++) {
+		if (flg & ECAP_EVT_FLG_BIT(i)) {
+			counter_push_event(counter_dev, COUNTER_EVENT_CAPTURE, i);
+			clr |= ECAP_EVT_CLR_BIT(i);
+		}
+	}
+
+	/* Check counter overflow */
+	if (flg & ECAP_EVT_FLG_BIT(ECAP_CNTOVF)) {
+		atomic_inc(&ecap_dev->nb_ovf);
+		counter_push_event(counter_dev, COUNTER_EVENT_OVERFLOW, ECAP_CNTOVF);
+		clr |= ECAP_EVT_CLR_BIT(ECAP_CNTOVF);
+	}
+
+	clr |= ECAP_INT_CLR_BIT;
+	regmap_update_bits(ecap_dev->regmap, ECAP_ECINT_CLR_FRC_REG, ECAP_EVT_CLR_MASK, clr);
+
+	return IRQ_HANDLED;
+}
+
+static void ecap_cnt_pm_disable(void *dev)
+{
+	pm_runtime_disable(dev);
+}
+
+static int ecap_cnt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct ecap_cnt_dev *ecap_dev;
+	struct counter_device *counter_dev;
+	void __iomem *mmio_base;
+	unsigned long clk_rate;
+	int ret;
+
+	counter_dev = devm_counter_alloc(dev, sizeof(*ecap_dev));
+	if (IS_ERR(counter_dev))
+		return PTR_ERR(counter_dev);
+
+	counter_dev->name = ECAP_DRV_NAME;
+	counter_dev->parent = dev;
+	counter_dev->ops = &ecap_cnt_ops;
+	counter_dev->signals = ecap_cnt_signals;
+	counter_dev->num_signals = ARRAY_SIZE(ecap_cnt_signals);
+	counter_dev->counts = ecap_cnt_counts;
+	counter_dev->num_counts = ARRAY_SIZE(ecap_cnt_counts);
+
+	ecap_dev = counter_priv(counter_dev);
+
+	ecap_dev->clk = devm_clk_get_enabled(dev, "fck");
+	if (IS_ERR(ecap_dev->clk))
+		return dev_err_probe(dev, PTR_ERR(ecap_dev->clk), "failed to get clock\n");
+
+	clk_rate = clk_get_rate(ecap_dev->clk);
+	if (!clk_rate) {
+		dev_err(dev, "failed to get clock rate\n");
+		return -EINVAL;
+	}
+
+	mmio_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mmio_base))
+		return PTR_ERR(mmio_base);
+
+	ecap_dev->regmap = devm_regmap_init_mmio(dev, mmio_base, &ecap_cnt_regmap_config);
+	if (IS_ERR(ecap_dev->regmap))
+		return dev_err_probe(dev, PTR_ERR(ecap_dev->regmap), "failed to init regmap\n");
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get irq\n");
+
+	ret = devm_request_irq(dev, ret, ecap_cnt_isr, 0, pdev->name, counter_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request irq\n");
+
+	platform_set_drvdata(pdev, counter_dev);
+
+	pm_runtime_enable(dev);
+
+	/* Register a cleanup callback to care for disabling PM */
+	ret = devm_add_action_or_reset(dev, ecap_cnt_pm_disable, dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add pm disable action\n");
+
+	ecap_cnt_capture_set_evmode(counter_dev, 0);
+
+	ret = devm_counter_add(dev, counter_dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add counter\n");
+
+	return 0;
+}
+
+static int ecap_cnt_remove(struct platform_device *pdev)
+{
+	struct counter_device *counter_dev = platform_get_drvdata(pdev);
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
+
+	if (ecap_dev->enabled)
+		ecap_cnt_capture_disable(counter_dev);
+
+	return 0;
+}
+
+static int ecap_cnt_suspend(struct device *dev)
+{
+	struct counter_device *counter_dev = dev_get_drvdata(dev);
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
+
+	/* If eCAP is running, stop capture then save timestamp counter */
+	if (ecap_dev->enabled) {
+		/*
+		 * Disabling capture has the following effects:
+		 * - interrupts are disabled
+		 * - loading of capture registers is disabled
+		 * - timebase counter is stopped
+		 */
+		ecap_cnt_capture_disable(counter_dev);
+		ecap_cnt_count_get_val(counter_dev, ECAP_TSCNT_REG, &ecap_dev->pm_ctx.time_cntr);
+	}
+
+	ecap_dev->pm_ctx.ev_mode = ecap_cnt_capture_get_evmode(counter_dev);
+
+	clk_disable(ecap_dev->clk);
+
+	return 0;
+}
+
+static int ecap_cnt_resume(struct device *dev)
+{
+	struct counter_device *counter_dev = dev_get_drvdata(dev);
+	struct ecap_cnt_dev *ecap_dev = counter_priv(counter_dev);
+
+	clk_enable(ecap_dev->clk);
+
+	ecap_cnt_capture_set_evmode(counter_dev, ecap_dev->pm_ctx.ev_mode);
+
+	/* If eCAP was running, restore timestamp counter then run capture */
+	if (ecap_dev->enabled) {
+		ecap_cnt_count_set_val(counter_dev, ECAP_TSCNT_REG, ecap_dev->pm_ctx.time_cntr);
+		ecap_cnt_capture_enable(counter_dev);
+	}
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ecap_cnt_pm_ops, ecap_cnt_suspend, ecap_cnt_resume);
+
+static const struct of_device_id ecap_cnt_of_match[] = {
+	{ .compatible	= "ti,am62-ecap-capture" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ecap_cnt_of_match);
+
+static struct platform_driver ecap_cnt_driver = {
+	.probe = ecap_cnt_probe,
+	.remove = ecap_cnt_remove,
+	.driver = {
+		.name = "ecap-capture",
+		.of_match_table = ecap_cnt_of_match,
+		.pm = pm_sleep_ptr(&ecap_cnt_pm_ops),
+	},
+};
+module_platform_driver(ecap_cnt_driver);
+
+MODULE_DESCRIPTION("ECAP Capture driver");
+MODULE_AUTHOR("Julien Panis <jpanis@baylibre.com>");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(COUNTER);
-- 
2.37.3

