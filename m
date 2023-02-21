Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448D869D8F0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 03:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjBUCrq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Feb 2023 21:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjBUCrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 21:47:15 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6039C23D83;
        Mon, 20 Feb 2023 18:47:05 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 22B3A24E205;
        Tue, 21 Feb 2023 10:47:04 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 10:47:04 +0800
Received: from localhost.localdomain (183.27.98.67) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 10:47:02 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
CC:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 13/19] reset: starfive: Add StarFive JH7110 reset driver
Date:   Tue, 21 Feb 2023 10:46:39 +0800
Message-ID: <20230221024645.127922-14-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230221024645.127922-1-hal.feng@starfivetech.com>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.98.67]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add auxiliary driver to support StarFive JH7110 system
and always-on resets.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/reset/starfive/Kconfig                |  8 +++
 drivers/reset/starfive/Makefile               |  1 +
 .../reset/starfive/reset-starfive-jh7110.c    | 64 +++++++++++++++++++
 .../reset/starfive/reset-starfive-jh71x0.h    |  6 ++
 4 files changed, 79 insertions(+)
 create mode 100644 drivers/reset/starfive/reset-starfive-jh7110.c

diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
index 9d15c4110e40..fab1a081af17 100644
--- a/drivers/reset/starfive/Kconfig
+++ b/drivers/reset/starfive/Kconfig
@@ -10,3 +10,11 @@ config RESET_STARFIVE_JH7100
 	default SOC_STARFIVE
 	help
 	  This enables the reset controller driver for the StarFive JH7100 SoC.
+
+config RESET_STARFIVE_JH7110
+	bool "StarFive JH7110 Reset Driver"
+	depends on AUXILIARY_BUS && CLK_STARFIVE_JH7110_SYS
+	select RESET_STARFIVE_JH71X0
+	default CLK_STARFIVE_JH7110_SYS
+	help
+	  This enables the reset controller driver for the StarFive JH7110 SoC.
diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Makefile
index f6aa12466fad..7a44b66fb9d5 100644
--- a/drivers/reset/starfive/Makefile
+++ b/drivers/reset/starfive/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_RESET_STARFIVE_JH71X0)		+= reset-starfive-jh71x0.o
 
 obj-$(CONFIG_RESET_STARFIVE_JH7100)		+= reset-starfive-jh7100.o
+obj-$(CONFIG_RESET_STARFIVE_JH7110)		+= reset-starfive-jh7110.o
diff --git a/drivers/reset/starfive/reset-starfive-jh7110.c b/drivers/reset/starfive/reset-starfive-jh7110.c
new file mode 100644
index 000000000000..83577d1b7fc6
--- /dev/null
+++ b/drivers/reset/starfive/reset-starfive-jh7110.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Reset driver for the StarFive JH7110 SoC
+ *
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/auxiliary_bus.h>
+
+#include "reset-starfive-jh71x0.h"
+
+#include <dt-bindings/reset/starfive,jh7110-crg.h>
+
+static int jh7110_reset_probe(struct auxiliary_device *adev,
+			      const struct auxiliary_device_id *id)
+{
+	struct reset_info *info = (struct reset_info *)(id->driver_data);
+	void __iomem **base = (void __iomem **)dev_get_drvdata(adev->dev.parent);
+
+	if (!info || !base)
+		return -ENODEV;
+
+	return reset_starfive_jh71x0_register(&adev->dev, adev->dev.parent->of_node,
+					      *base + info->assert_offset,
+					      *base + info->status_offset,
+					      NULL,
+					      info->nr_resets,
+					      NULL);
+}
+
+static const struct reset_info jh7110_sys_info = {
+	.nr_resets = JH7110_SYSRST_END,
+	.assert_offset = 0x2F8,
+	.status_offset = 0x308,
+};
+
+static const struct reset_info jh7110_aon_info = {
+	.nr_resets = JH7110_AONRST_END,
+	.assert_offset = 0x38,
+	.status_offset = 0x3C,
+};
+
+static const struct auxiliary_device_id jh7110_reset_ids[] = {
+	{
+		.name = "clk_starfive_jh71x0.reset-sys",
+		.driver_data = (kernel_ulong_t)&jh7110_sys_info,
+	},
+	{
+		.name = "clk_starfive_jh71x0.reset-aon",
+		.driver_data = (kernel_ulong_t)&jh7110_aon_info,
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(auxiliary, jh7110_reset_ids);
+
+static struct auxiliary_driver jh7110_reset_driver = {
+	.probe		= jh7110_reset_probe,
+	.id_table	= jh7110_reset_ids,
+};
+module_auxiliary_driver(jh7110_reset_driver);
+
+MODULE_AUTHOR("Hal Feng <hal.feng@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JH7110 reset driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.h b/drivers/reset/starfive/reset-starfive-jh71x0.h
index db7d39a87f87..e485472e1adc 100644
--- a/drivers/reset/starfive/reset-starfive-jh71x0.h
+++ b/drivers/reset/starfive/reset-starfive-jh71x0.h
@@ -6,6 +6,12 @@
 #ifndef __RESET_STARFIVE_JH71X0_H
 #define __RESET_STARFIVE_JH71X0_H
 
+struct reset_info {
+	unsigned int nr_resets;
+	unsigned int assert_offset;
+	unsigned int status_offset;
+};
+
 int reset_starfive_jh71x0_register(struct device *dev, struct device_node *of_node,
 				   void __iomem *assert, void __iomem *status,
 				   const u32 *asserted, unsigned int nr_resets,
-- 
2.38.1

