Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC566A1D06
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjBXNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjBXNbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:31:39 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9FD52DC4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:31:35 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so2168914wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1677245493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ijOtHUPERBPPWuAmpk8gADuY1h1/51fjdHIzcrWuFM=;
        b=PoaswVVEJcfhnGpQ6ZcVbI4mzs3Y2JR/Lu0S89Bq5JfNRnkLetrmfEj39vi4LqBVme
         m5jUU+z3MstdbDuPH7DpJ2FeQD6YE7dVQLhKPYUMMFJQCuAvMCHYYVF8AMfxs8iweqiK
         cF8Ar+XIPt5JYzZlS23UbFY1lVZ1Ez+LRGJLBWAu5ICHs2Lj0TJysjhiQSYHN1higHNl
         THUx6+4f+BNFvqV4BWv5y1BRSJLsLrYiZPO0FLzYVnA5dM9NOME58z75UDsHZlQh7J86
         ySOkHqjEP1wqxrdbpwNEK4R0hkrpPk5c0LZuLqkYdbyWO1ccnnZ+cCKX9W/OsZ7aXBDK
         l6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677245493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ijOtHUPERBPPWuAmpk8gADuY1h1/51fjdHIzcrWuFM=;
        b=Y6yph8GcnI7VP38WTPysAq+on8+gpa3fQUvvAzuo5aNLNnxCZO+lg6gGI+2SZ0Jn/G
         HUyUP9yXgNvV0kRPeyo1qLLzE+hu4WfLWI3HwePdrJn5BM0z9mmxTIe3SnBoHLWwr/Ms
         Y68GEkK0PR/ElySKZN5f597LAsKWDZ3y37jAXZ5e6G6mUG1TP+peBx98W6s4VBaBV5SP
         94IDdgFPxqayI7rsDNXWEmR/le6iFhCRWJbNjDXWU2PwUHLqNebu0XMT9ixff3uB3a2Z
         GaRgvR6pmSMhkb9A86xviATDiANSezWVt1AQLDKyIRzWbl2ysRWQxJ2IsgqWROCGsusR
         IDFA==
X-Gm-Message-State: AO0yUKUL3Qh+u4zJDSzQJaupncI30UbSksH1dYOM8XZ7e2i+LWJDsSiX
        J7IEypRqG0t/8OsLWPJYezT/pw==
X-Google-Smtp-Source: AK7set8hyD0+WmIZswfyVJ+6sQG1lHIjPQwRmeQ7PD601Ueic6NnXSUzIba5FjXEgTj1XUFJb71dNg==
X-Received: by 2002:a05:600c:16c5:b0:3e2:1532:bb57 with SMTP id l5-20020a05600c16c500b003e21532bb57mr9762867wmn.29.1677245493603;
        Fri, 24 Feb 2023 05:31:33 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:28d:66d0:5e4:476:5145:2ad1])
        by smtp.gmail.com with ESMTPSA id o25-20020a05600c511900b003dfe549da4fsm3308735wms.18.2023.02.24.05.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 05:31:33 -0800 (PST)
From:   Esteban Blanc <eblanc@baylibre.com>
To:     linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, jpanis@baylibre.com,
        jneanne@baylibre.com
Subject: [PATCH INTERNAL v1 3/3] regulator: tps6594-regulator: Add driver for TI TPS6594 regulators
Date:   Fri, 24 Feb 2023 14:31:29 +0100
Message-Id: <20230224133129.887203-4-eblanc@baylibre.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230224133129.887203-1-eblanc@baylibre.com>
References: <20230224133129.887203-1-eblanc@baylibre.com>
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

From: Jerome Neanne <jneanne@baylibre.com>

This patch adds support for TPS6594 regulators (bucks and LDOs).
The output voltages are configurable and are meant to supply power
to the main processor and other components.
Bucks can be used in single or multiphase mode, depending on PMIC
part number.

Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
---
 drivers/regulator/Kconfig             |  12 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/tps6594-regulator.c | 559 ++++++++++++++++++++++++++
 3 files changed, 572 insertions(+)
 create mode 100644 drivers/regulator/tps6594-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 820c9a0788e5..921540af6958 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1432,6 +1432,18 @@ config REGULATOR_TPS65219
 	  voltage regulators. It supports software based voltage control
 	  for different voltage domains.
 
+config REGULATOR_TPS6594
+	tristate "TI TPS6594 Power regulators"
+	depends on MFD_TPS6594 && OF
+	help
+	  This driver supports TPS6594 voltage regulator chips.
+	  TPS6594 series of PMICs have 5 BUCKs and 4 LDOs
+	  voltage regulators.
+	  BUCKs 1,2,3,4 can be used in single phase or multiphase mode.
+	  Part number defines which single or multiphase mode is i used.
+	  It supports software based voltage control
+	  for different voltage domains.
+
 config REGULATOR_TPS6524X
 	tristate "TI TPS6524X Power regulators"
 	depends on SPI
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index b9f5eb35bf5f..948b53f6156b 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -171,6 +171,7 @@ obj-$(CONFIG_REGULATOR_TPS6524X) += tps6524x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS6586X) += tps6586x-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65910) += tps65910-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65912) += tps65912-regulator.o
+obj-$(CONFIG_REGULATOR_TPS6594) += tps6594-regulator.o
 obj-$(CONFIG_REGULATOR_TPS65132) += tps65132-regulator.o
 obj-$(CONFIG_REGULATOR_TPS68470) += tps68470-regulator.o
 obj-$(CONFIG_REGULATOR_TWL4030) += twl-regulator.o twl6030-regulator.o
diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
new file mode 100644
index 000000000000..c099711fd460
--- /dev/null
+++ b/drivers/regulator/tps6594-regulator.c
@@ -0,0 +1,559 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Regulator driver for tps6594 PMIC
+ *
+ * Copyright (C) 2022 BayLibre Incorporated - https://www.baylibre.com/
+ *
+ * This implementation derived from tps65218 authored by "J Keerthy <j-keerthy@ti.com>"
+ */
+
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+
+#include <linux/mfd/tps6594.h>
+
+#define BUCK_NB		5
+#define LDO_NB		4
+#define MULTI_PHASE_NB	4
+
+enum tps6594_regulator_id {
+	/* DCDC's */
+	TPS6594_BUCK_1,
+	TPS6594_BUCK_2,
+	TPS6594_BUCK_3,
+	TPS6594_BUCK_4,
+	TPS6594_BUCK_5,
+
+	/* LDOs */
+	TPS6594_LDO_1,
+	TPS6594_LDO_2,
+	TPS6594_LDO_3,
+	TPS6594_LDO_4,
+};
+
+enum tps6594_multi_regulator_id {
+	/* Multi-phase DCDC's */
+	TPS6594_BUCK_12,
+	TPS6594_BUCK_34,
+	TPS6594_BUCK_123,
+	TPS6594_BUCK_1234,
+};
+
+struct tps6594_regulator_irq_type {
+	const char *irq_name;
+	const char *regulator_name;
+	const char *event_name;
+	unsigned long event;
+};
+
+static struct tps6594_regulator_irq_type tps6594_regulator_irq_types[] = {
+	{ TPS6594_IRQ_NAME_BUCK1_OV, "BUCK1", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ TPS6594_IRQ_NAME_BUCK1_UV, "BUCK1", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ TPS6594_IRQ_NAME_BUCK1_SC, "BUCK1", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
+	{ TPS6594_IRQ_NAME_BUCK1_ILIM, "BUCK1", "reach ilim, overcurrent",
+	  REGULATOR_EVENT_OVER_CURRENT },
+	{ TPS6594_IRQ_NAME_BUCK2_OV, "BUCK2", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ TPS6594_IRQ_NAME_BUCK2_UV, "BUCK2", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ TPS6594_IRQ_NAME_BUCK2_SC, "BUCK2", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
+	{ TPS6594_IRQ_NAME_BUCK2_ILIM, "BUCK2", "reach ilim, overcurrent",
+	  REGULATOR_EVENT_OVER_CURRENT },
+	{ TPS6594_IRQ_NAME_BUCK3_OV, "BUCK3", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ TPS6594_IRQ_NAME_BUCK3_UV, "BUCK3", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ TPS6594_IRQ_NAME_BUCK3_SC, "BUCK3", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
+	{ TPS6594_IRQ_NAME_BUCK3_ILIM, "BUCK3", "reach ilim, overcurrent",
+	  REGULATOR_EVENT_OVER_CURRENT },
+	{ TPS6594_IRQ_NAME_BUCK4_OV, "BUCK4", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ TPS6594_IRQ_NAME_BUCK4_UV, "BUCK4", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ TPS6594_IRQ_NAME_BUCK4_SC, "BUCK4", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
+	{ TPS6594_IRQ_NAME_BUCK4_ILIM, "BUCK4", "reach ilim, overcurrent",
+	  REGULATOR_EVENT_OVER_CURRENT },
+	{ TPS6594_IRQ_NAME_BUCK5_OV, "BUCK5", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ TPS6594_IRQ_NAME_BUCK5_UV, "BUCK5", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ TPS6594_IRQ_NAME_BUCK5_SC, "BUCK5", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
+	{ TPS6594_IRQ_NAME_BUCK5_ILIM, "BUCK5", "reach ilim, overcurrent",
+	  REGULATOR_EVENT_OVER_CURRENT },
+	{ TPS6594_IRQ_NAME_LDO1_OV, "LDO1", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ TPS6594_IRQ_NAME_LDO1_UV, "LDO1", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ TPS6594_IRQ_NAME_LDO1_SC, "LDO1", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
+	{ TPS6594_IRQ_NAME_LDO1_ILIM, "LDO1", "reach ilim, overcurrent",
+	  REGULATOR_EVENT_OVER_CURRENT },
+	{ TPS6594_IRQ_NAME_LDO2_OV, "LDO2", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ TPS6594_IRQ_NAME_LDO2_UV, "LDO2", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ TPS6594_IRQ_NAME_LDO2_SC, "LDO2", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
+	{ TPS6594_IRQ_NAME_LDO2_ILIM, "LDO2", "reach ilim, overcurrent",
+	  REGULATOR_EVENT_OVER_CURRENT },
+	{ TPS6594_IRQ_NAME_LDO3_OV, "LDO3", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ TPS6594_IRQ_NAME_LDO3_UV, "LDO3", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ TPS6594_IRQ_NAME_LDO3_SC, "LDO3", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
+	{ TPS6594_IRQ_NAME_LDO3_ILIM, "LDO3", "reach ilim, overcurrent",
+	  REGULATOR_EVENT_OVER_CURRENT },
+	{ TPS6594_IRQ_NAME_LDO4_OV, "LDO4", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ TPS6594_IRQ_NAME_LDO4_UV, "LDO4", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ TPS6594_IRQ_NAME_LDO4_SC, "LDO4", "short circuit", REGULATOR_EVENT_REGULATION_OUT },
+	{ TPS6594_IRQ_NAME_LDO4_ILIM, "LDO4", "reach ilim, overcurrent",
+	  REGULATOR_EVENT_OVER_CURRENT },
+};
+
+static struct tps6594_regulator_irq_type tps6594_ext_regulator_irq_types[] = {
+	{ TPS6594_IRQ_NAME_VCCA_OV, "VCCA", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ TPS6594_IRQ_NAME_VCCA_UV, "VCCA", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ TPS6594_IRQ_NAME_VMON1_OV, "VMON1", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ TPS6594_IRQ_NAME_VMON1_UV, "VMON1", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ TPS6594_IRQ_NAME_VMON1_RV, "VMON1", "residual voltage",
+	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ TPS6594_IRQ_NAME_VMON2_OV, "VMON2", "overvoltage", REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+	{ TPS6594_IRQ_NAME_VMON2_UV, "VMON2", "undervoltage", REGULATOR_EVENT_UNDER_VOLTAGE },
+	{ TPS6594_IRQ_NAME_VMON2_RV, "VMON2", "residual voltage",
+	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
+};
+
+struct tps6594_regulator_irq_data {
+	struct device *dev;
+	struct tps6594_regulator_irq_type *type;
+	struct regulator_dev *rdev;
+};
+
+struct tps6594_ext_regulator_irq_data {
+	struct device *dev;
+	struct tps6594_regulator_irq_type *type;
+};
+
+#define TPS6594_REGULATOR(_name, _of, _id, _type, _ops, _n, _vr, _vm, _er, \
+			   _em, _cr, _cm, _lr, _nlr, _delay, _fuv, \
+			   _ct, _ncl, _bpm) \
+	{								\
+		.name			= _name,			\
+		.of_match		= _of,				\
+		.regulators_node	= of_match_ptr("regulators"),	\
+		.supply_name		= _of,				\
+		.id			= _id,				\
+		.ops			= &(_ops),			\
+		.n_voltages		= _n,				\
+		.type			= _type,			\
+		.owner			= THIS_MODULE,			\
+		.vsel_reg		= _vr,				\
+		.vsel_mask		= _vm,				\
+		.csel_reg		= _cr,				\
+		.csel_mask		= _cm,				\
+		.curr_table		= _ct,				\
+		.n_current_limits	= _ncl,				\
+		.enable_reg		= _er,				\
+		.enable_mask		= _em,				\
+		.volt_table		= NULL,				\
+		.linear_ranges		= _lr,				\
+		.n_linear_ranges	= _nlr,				\
+		.ramp_delay		= _delay,			\
+		.fixed_uV		= _fuv,				\
+		.bypass_reg		= _vr,				\
+		.bypass_mask		= _bpm,				\
+	}								\
+
+static const struct linear_range bucks_ranges[] = {
+	REGULATOR_LINEAR_RANGE(300000, 0x0, 0xe, 20000),
+	REGULATOR_LINEAR_RANGE(600000, 0xf, 0x72, 5000),
+	REGULATOR_LINEAR_RANGE(1100000, 0x73, 0xaa, 10000),
+	REGULATOR_LINEAR_RANGE(1660000, 0xab, 0xff, 20000),
+};
+
+static const struct linear_range ldos_1_2_3_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0x4, 0x3a, 50000),
+};
+
+static const struct linear_range ldos_4_ranges[] = {
+	REGULATOR_LINEAR_RANGE(1200000, 0x20, 0x74, 25000),
+};
+
+static unsigned int tps6594_get_mode(struct regulator_dev *dev)
+{
+	return REGULATOR_MODE_NORMAL;
+}
+
+/* Operations permitted on BUCK1/2/3/4/5 */
+static const struct regulator_ops tps6594_bucks_ops = {
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.get_mode		= tps6594_get_mode,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
+
+};
+
+/* Operations permitted on LDO1/2/3 */
+static const struct regulator_ops tps6594_ldos_1_2_3_ops = {
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.get_mode		= tps6594_get_mode,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+	.set_bypass		= regulator_set_bypass_regmap,
+	.get_bypass		= regulator_get_bypass_regmap,
+};
+
+/* Operations permitted on LDO4 */
+static const struct regulator_ops tps6594_ldos_4_ops = {
+	.is_enabled		= regulator_is_enabled_regmap,
+	.enable			= regulator_enable_regmap,
+	.disable		= regulator_disable_regmap,
+	.get_mode		= tps6594_get_mode,
+	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
+	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
+	.list_voltage		= regulator_list_voltage_linear_range,
+	.map_voltage		= regulator_map_voltage_linear_range,
+};
+
+static const struct regulator_desc buck_regs[] = {
+	TPS6594_REGULATOR("BUCK1", "buck1", TPS6594_BUCK_1,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(0),
+			  TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_CTRL(0),
+			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
+			  4, 0, 0, NULL, 0, 0),
+	TPS6594_REGULATOR("BUCK2", "buck2", TPS6594_BUCK_2,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(1),
+			  TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_CTRL(1),
+			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
+			  4, 0, 0, NULL, 0, 0),
+	TPS6594_REGULATOR("BUCK3", "buck3", TPS6594_BUCK_3,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(2),
+			  TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_CTRL(2),
+			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
+			  4, 0, 0, NULL, 0, 0),
+	TPS6594_REGULATOR("BUCK4", "buck4", TPS6594_BUCK_4,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(3),
+			  TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_CTRL(3),
+			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
+			  4, 0, 0, NULL, 0, 0),
+	TPS6594_REGULATOR("BUCK5", "buck5", TPS6594_BUCK_5,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(4),
+			  TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_CTRL(4),
+			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
+			  4, 0, 0, NULL, 0, 0),
+};
+
+static const struct regulator_desc multi_regs[] = {
+	TPS6594_REGULATOR("BUCK12", "buck12", TPS6594_BUCK_1,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(1),
+			  TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_CTRL(1),
+			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
+			  4, 4000, 0, NULL, 0, 0),
+	TPS6594_REGULATOR("BUCK34", "buck34", TPS6594_BUCK_3,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(3),
+			  TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_CTRL(3),
+			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
+			  4, 0, 0, NULL, 0, 0),
+	TPS6594_REGULATOR("BUCK123", "buck123", TPS6594_BUCK_1,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(1),
+			  TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_CTRL(1),
+			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
+			  4, 4000, 0, NULL, 0, 0),
+	TPS6594_REGULATOR("BUCK1234", "buck1234", TPS6594_BUCK_1,
+			  REGULATOR_VOLTAGE, tps6594_bucks_ops, TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_VOUT_1(1),
+			  TPS6594_MASK_BUCKS_VSET,
+			  TPS6594_REG_BUCKX_CTRL(1),
+			  TPS6594_BIT_BUCK_EN, 0, 0, bucks_ranges,
+			  4, 4000, 0, NULL, 0, 0),
+};
+
+static const struct regulator_desc ldo_regs[] = {
+	TPS6594_REGULATOR("LDO1", "ldo1", TPS6594_LDO_1,
+			  REGULATOR_VOLTAGE, tps6594_ldos_1_2_3_ops, TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_VOUT(0),
+			  TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_CTRL(0),
+			  TPS6594_BIT_LDO_EN, 0, 0, ldos_1_2_3_ranges,
+			  1, 0, 0, NULL, 0, TPS6594_BIT_LDO_BYPASS),
+	TPS6594_REGULATOR("LDO2", "ldo2", TPS6594_LDO_2,
+			  REGULATOR_VOLTAGE, tps6594_ldos_1_2_3_ops, TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_VOUT(1),
+			  TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_CTRL(1),
+			  TPS6594_BIT_LDO_EN, 0, 0, ldos_1_2_3_ranges,
+			  1, 0, 0, NULL, 0, TPS6594_BIT_LDO_BYPASS),
+	TPS6594_REGULATOR("LDO3", "ldo3", TPS6594_LDO_3,
+			  REGULATOR_VOLTAGE, tps6594_ldos_1_2_3_ops, TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_VOUT(2),
+			  TPS6594_MASK_LDO123_VSET,
+			  TPS6594_REG_LDOX_CTRL(2),
+			  TPS6594_BIT_LDO_EN, 0, 0, ldos_1_2_3_ranges,
+			  1, 0, 0, NULL, 0, TPS6594_BIT_LDO_BYPASS),
+	TPS6594_REGULATOR("LDO4", "ldo4", TPS6594_LDO_4,
+			  REGULATOR_VOLTAGE, tps6594_ldos_4_ops, TPS6594_MASK_LDO4_VSET >> 1,
+			  TPS6594_REG_LDOX_VOUT(3),
+			  TPS6594_MASK_LDO4_VSET,
+			  TPS6594_REG_LDOX_CTRL(3),
+			  TPS6594_BIT_LDO_EN, 0, 0, ldos_4_ranges,
+			  1, 0, 0, NULL, 0, 0),
+};
+
+static irqreturn_t tps6594_regulator_irq_handler(int irq, void *data)
+{
+	struct tps6594_regulator_irq_data *irq_data = data;
+
+	if (irq_data->type->event_name[0] == '\0') {
+		/* This is the timeout interrupt no specific regulator */
+		dev_err(irq_data->dev,
+			"System was put in shutdown due to timeout during an active or standby transition.\n");
+		return IRQ_HANDLED;
+	}
+
+	regulator_notifier_call_chain(irq_data->rdev,
+				      irq_data->type->event, NULL);
+
+	dev_err(irq_data->dev, "Error IRQ trap %s for %s\n",
+		irq_data->type->event_name, irq_data->type->regulator_name);
+	return IRQ_HANDLED;
+}
+
+static int tps6594_get_rdev_by_name(const char *regulator_name,
+				    struct regulator_dev *rdevbucktbl[BUCK_NB],
+				    struct regulator_dev *rdevldotbl[LDO_NB],
+				    struct regulator_dev *dev)
+{
+	int i;
+
+	for (i = 0; i <= BUCK_NB; i++) {
+		if (strcmp(regulator_name, buck_regs[i].name) == 0) {
+			dev = rdevbucktbl[i];
+			return 0;
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(ldo_regs); i++) {
+		if (strcmp(regulator_name, ldo_regs[i].name) == 0) {
+			dev = rdevldotbl[i];
+			return 0;
+		}
+	}
+	return -EINVAL;
+}
+
+static int tps6594_regulator_probe(struct platform_device *pdev)
+{
+	struct tps6594 *tps = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_dev *rdev;
+	struct regulator_config config = {};
+	u8 buck_configured[BUCK_NB] = { 0 };
+	u8 buck_multi[MULTI_PHASE_NB] = { 0 };
+	int i;
+	int error;
+	int irq;
+	int ext_reg_irq_nb = 2;
+	struct tps6594_regulator_irq_data *irq_data;
+	struct tps6594_ext_regulator_irq_data *irq_ext_reg_data;
+	struct tps6594_regulator_irq_type *irq_type;
+	struct regulator_dev *rdevbucktbl[BUCK_NB];
+	struct regulator_dev *rdevmultitbl[MULTI_PHASE_NB];
+	struct regulator_dev *rdevldotbl[LDO_NB];
+
+	int multi_phase_id;
+	int multi_phase_case = 0xFFFF;
+
+	config.dev = tps->dev;
+	config.driver_data = tps;
+	config.regmap = tps->regmap;
+
+	/*
+	 * Switch case defines different possible multi phase config
+	 * This is based on dts custom property: multi-phase-id
+	 * Using compatible or device rev is a too complex alternative
+	 * Default case is no Multiphase buck.
+	 * In case of Multiphase configuration, value should be defined for
+	 * buck_configured to avoid creating bucks for every buck in multiphase
+	 */
+
+	if (device_property_present(tps->dev, "ti,multi-phase-id")) {
+		device_property_read_u32(tps->dev, "ti,multi-phase-id", &multi_phase_id);
+		switch (multi_phase_id) {
+		case 12:
+			buck_multi[0] = 1;
+			buck_configured[0] = 1;
+			buck_configured[1] = 1;
+			multi_phase_case = TPS6594_BUCK_12;
+			break;
+		case 34:
+			buck_multi[1] = 1;
+			buck_configured[2] = 1;
+			buck_configured[3] = 1;
+			multi_phase_case = TPS6594_BUCK_34;
+			break;
+		case 123:
+			buck_multi[2] = 1;
+			buck_configured[0] = 1;
+			buck_configured[1] = 1;
+			buck_configured[2] = 1;
+			multi_phase_case = TPS6594_BUCK_123;
+			break;
+		case 1234:
+			buck_multi[3] = 1;
+			buck_configured[0] = 1;
+			buck_configured[1] = 1;
+			buck_configured[2] = 1;
+			buck_configured[3] = 1;
+			multi_phase_case = TPS6594_BUCK_1234;
+			break;
+		}
+	}
+
+	for (i = 0; i < MULTI_PHASE_NB; i++) {
+		if (buck_multi[i] == 0)
+			continue;
+
+		rdev = devm_regulator_register(&pdev->dev, &multi_regs[i], &config);
+		if (IS_ERR(rdev)) {
+			dev_err(tps->dev, "failed to register %s regulator\n",
+				pdev->name);
+			return PTR_ERR(rdev);
+		}
+		rdevmultitbl[i] = rdev;
+	}
+
+	if (tps->chip_id == LP8764X)
+		/* There is only 4 buck on LP8764X */
+		buck_configured[4] = 1;
+
+	for (i = 0; i < BUCK_NB; i++) {
+		if (buck_configured[i] == 1)
+			continue;
+
+		rdev = devm_regulator_register(&pdev->dev, &buck_regs[i], &config);
+		if (IS_ERR(rdev)) {
+			dev_err(tps->dev, "failed to register %s regulator\n",
+				pdev->name);
+			return PTR_ERR(rdev);
+		}
+		rdevbucktbl[i] = rdev;
+	}
+
+	/* LP8764X dosen't have LDO */
+	if (tps->chip_id != LP8764X) {
+		for (i = 0; i < ARRAY_SIZE(ldo_regs); i++) {
+			rdev = devm_regulator_register(&pdev->dev, &ldo_regs[i], &config);
+			if (IS_ERR(rdev)) {
+				dev_err(tps->dev,
+					"failed to register %s regulator\n",
+					pdev->name);
+				return PTR_ERR(rdev);
+			}
+			rdevldotbl[i] = rdev;
+		}
+	}
+
+	irq_data = devm_kmalloc(tps->dev,
+				ARRAY_SIZE(tps6594_regulator_irq_types) *
+				sizeof(struct tps6594_regulator_irq_data),
+				GFP_KERNEL);
+	if (!irq_data)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(tps6594_regulator_irq_types); ++i) {
+		irq_type = &tps6594_regulator_irq_types[i];
+
+		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
+		if (irq < 0)
+			return -EINVAL;
+
+		irq_data[i].dev = tps->dev;
+		irq_data[i].type = irq_type;
+
+		tps6594_get_rdev_by_name(irq_type->regulator_name, rdevbucktbl,
+					 rdevldotbl, rdev);
+
+		if (rdev < 0) {
+			dev_err(tps->dev, "Failed to get rdev for %s\n",
+				irq_type->regulator_name);
+			return -EINVAL;
+		}
+		irq_data[i].rdev = rdev;
+
+		error = devm_request_threaded_irq(tps->dev, irq, NULL,
+						  tps6594_regulator_irq_handler,
+						  IRQF_ONESHOT,
+						  irq_type->irq_name,
+						  &irq_data[i]);
+		if (error) {
+			dev_err(tps->dev, "failed to request %s IRQ %d: %d\n",
+				irq_type->irq_name, irq, error);
+			return error;
+		}
+	}
+
+	if (tps->chip_id == LP8764X)
+		ext_reg_irq_nb = ARRAY_SIZE(tps6594_ext_regulator_irq_types);
+
+	irq_ext_reg_data = devm_kmalloc(tps->dev,
+					ext_reg_irq_nb *
+					sizeof(struct tps6594_ext_regulator_irq_data),
+					GFP_KERNEL);
+	if (!irq_ext_reg_data)
+		return -ENOMEM;
+
+	for (i = 0; i < ext_reg_irq_nb; ++i) {
+		irq_type = &tps6594_ext_regulator_irq_types[i];
+
+		irq = platform_get_irq_byname(pdev, irq_type->irq_name);
+		if (irq < 0)
+			return -EINVAL;
+
+		irq_ext_reg_data[i].dev = tps->dev;
+		irq_ext_reg_data[i].type = irq_type;
+
+		error = devm_request_threaded_irq(tps->dev, irq, NULL,
+						  tps6594_regulator_irq_handler,
+						  IRQF_ONESHOT,
+						  irq_type->irq_name,
+						  &irq_ext_reg_data[i]);
+		if (error) {
+			dev_err(tps->dev, "failed to request %s IRQ %d: %d\n",
+				irq_type->irq_name, irq, error);
+			return error;
+		}
+	}
+
+	return 0;
+}
+
+static struct platform_driver tps6594_regulator_driver = {
+	.driver = {
+		.name = "tps6594-regulator",
+	},
+	.probe = tps6594_regulator_probe,
+};
+
+module_platform_driver(tps6594_regulator_driver);
+
+MODULE_ALIAS("platform:tps6594-regulator");
+MODULE_AUTHOR("Jerome Neanne <jneanne@baylibre.com>");
+MODULE_DESCRIPTION("TPS6594 voltage regulator driver");
+MODULE_LICENSE("GPL");
-- 
2.38.1

