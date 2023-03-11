Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2788C6B59C6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 10:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCKJIw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 11 Mar 2023 04:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjCKJIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 04:08:02 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7F9134AF6;
        Sat, 11 Mar 2023 01:07:43 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id E6D0424E17F;
        Sat, 11 Mar 2023 17:07:41 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 11 Mar
 2023 17:07:42 +0800
Received: from ubuntu.localdomain (183.27.96.115) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Sat, 11 Mar
 2023 17:07:40 +0800
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
Subject: [PATCH v5 07/21] reset: starfive: Factor out common JH71X0 reset code
Date:   Sat, 11 Mar 2023 17:07:19 +0800
Message-ID: <20230311090733.56918-8-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230311090733.56918-1-hal.feng@starfivetech.com>
References: <20230311090733.56918-1-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [183.27.96.115]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emil Renner Berthing <kernel@esmil.dk>

The StarFive JH7100 SoC has additional reset controllers for audio and
video, but the registers follow the same structure. On the JH7110 the
reset registers don't get their own memory range, but instead follow the
clock control registers. The registers still follow the same structure
though, so let's factor out the common code to handle all these cases.

Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 MAINTAINERS                                   |   4 +-
 drivers/reset/starfive/Kconfig                |   4 +
 drivers/reset/starfive/Makefile               |   2 +
 .../reset/starfive/reset-starfive-jh7100.c    | 150 +---------------
 .../reset/starfive/reset-starfive-jh71x0.c    | 162 ++++++++++++++++++
 .../reset/starfive/reset-starfive-jh71x0.h    |  11 ++
 6 files changed, 182 insertions(+), 151 deletions(-)
 create mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.c
 create mode 100644 drivers/reset/starfive/reset-starfive-jh71x0.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 87f210e357ca..0fb7158835b0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19936,11 +19936,11 @@ F:	drivers/pinctrl/starfive/pinctrl-starfive-jh71*
 F:	include/dt-bindings/pinctrl/pinctrl-starfive-jh7100.h
 F:	include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
 
-STARFIVE JH7100 RESET CONTROLLER DRIVER
+STARFIVE JH71X0 RESET CONTROLLER DRIVERS
 M:	Emil Renner Berthing <kernel@esmil.dk>
 S:	Maintained
 F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
-F:	drivers/reset/starfive/reset-starfive-jh7100.c
+F:	drivers/reset/starfive/reset-starfive-jh71*
 F:	include/dt-bindings/reset/starfive-jh7100.h
 
 STARFIVE JH71XX PMU CONTROLLER DRIVER
diff --git a/drivers/reset/starfive/Kconfig b/drivers/reset/starfive/Kconfig
index abbf0c52d03e..1927a5a3b53a 100644
--- a/drivers/reset/starfive/Kconfig
+++ b/drivers/reset/starfive/Kconfig
@@ -1,8 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+config RESET_STARFIVE_JH71X0
+	bool
+
 config RESET_STARFIVE_JH7100
 	bool "StarFive JH7100 Reset Driver"
 	depends on ARCH_STARFIVE || COMPILE_TEST
+	select RESET_STARFIVE_JH71X0
 	default ARCH_STARFIVE
 	help
 	  This enables the reset controller driver for the StarFive JH7100 SoC.
diff --git a/drivers/reset/starfive/Makefile b/drivers/reset/starfive/Makefile
index 670d049423f5..f6aa12466fad 100644
--- a/drivers/reset/starfive/Makefile
+++ b/drivers/reset/starfive/Makefile
@@ -1,2 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_RESET_STARFIVE_JH71X0)		+= reset-starfive-jh71x0.o
+
 obj-$(CONFIG_RESET_STARFIVE_JH7100)		+= reset-starfive-jh7100.o
diff --git a/drivers/reset/starfive/reset-starfive-jh7100.c b/drivers/reset/starfive/reset-starfive-jh7100.c
index fc44b2fb3e03..5a68327c1f6a 100644
--- a/drivers/reset/starfive/reset-starfive-jh7100.c
+++ b/drivers/reset/starfive/reset-starfive-jh7100.c
@@ -5,158 +5,10 @@
  * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
  */
 
-#include <linux/bitmap.h>
-#include <linux/io.h>
-#include <linux/io-64-nonatomic-lo-hi.h>
-#include <linux/iopoll.h>
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
-#include <linux/reset-controller.h>
-#include <linux/spinlock.h>
 
-#include <dt-bindings/reset/starfive-jh7100.h>
-
-/* register offsets */
-#define JH7100_RESET_ASSERT0	0x00
-#define JH7100_RESET_ASSERT1	0x04
-#define JH7100_RESET_ASSERT2	0x08
-#define JH7100_RESET_ASSERT3	0x0c
-#define JH7100_RESET_STATUS0	0x10
-#define JH7100_RESET_STATUS1	0x14
-#define JH7100_RESET_STATUS2	0x18
-#define JH7100_RESET_STATUS3	0x1c
-
-/*
- * Writing a 1 to the n'th bit of the m'th ASSERT register asserts
- * line 32m + n, and writing a 0 deasserts the same line.
- * Most reset lines have their status inverted so a 0 bit in the STATUS
- * register means the line is asserted and a 1 means it's deasserted. A few
- * lines don't though, so store the expected value of the status registers when
- * all lines are asserted.
- */
-static const u64 jh7100_reset_asserted[2] = {
-	/* STATUS0 */
-	BIT_ULL_MASK(JH7100_RST_U74) |
-	BIT_ULL_MASK(JH7100_RST_VP6_DRESET) |
-	BIT_ULL_MASK(JH7100_RST_VP6_BRESET) |
-	/* STATUS1 */
-	BIT_ULL_MASK(JH7100_RST_HIFI4_DRESET) |
-	BIT_ULL_MASK(JH7100_RST_HIFI4_BRESET),
-	/* STATUS2 */
-	BIT_ULL_MASK(JH7100_RST_E24) |
-	/* STATUS3 */
-	0,
-};
-
-struct jh7100_reset {
-	struct reset_controller_dev rcdev;
-	/* protect registers against concurrent read-modify-write */
-	spinlock_t lock;
-	void __iomem *base;
-};
-
-static inline struct jh7100_reset *
-jh7100_reset_from(struct reset_controller_dev *rcdev)
-{
-	return container_of(rcdev, struct jh7100_reset, rcdev);
-}
-
-static int jh7100_reset_update(struct reset_controller_dev *rcdev,
-			       unsigned long id, bool assert)
-{
-	struct jh7100_reset *data = jh7100_reset_from(rcdev);
-	unsigned long offset = BIT_ULL_WORD(id);
-	u64 mask = BIT_ULL_MASK(id);
-	void __iomem *reg_assert = data->base + JH7100_RESET_ASSERT0 + offset * sizeof(u64);
-	void __iomem *reg_status = data->base + JH7100_RESET_STATUS0 + offset * sizeof(u64);
-	u64 done = jh7100_reset_asserted[offset] & mask;
-	u64 value;
-	unsigned long flags;
-	int ret;
-
-	if (!assert)
-		done ^= mask;
-
-	spin_lock_irqsave(&data->lock, flags);
-
-	value = readq(reg_assert);
-	if (assert)
-		value |= mask;
-	else
-		value &= ~mask;
-	writeq(value, reg_assert);
-
-	/* if the associated clock is gated, deasserting might otherwise hang forever */
-	ret = readq_poll_timeout_atomic(reg_status, value, (value & mask) == done, 0, 1000);
-
-	spin_unlock_irqrestore(&data->lock, flags);
-	return ret;
-}
-
-static int jh7100_reset_assert(struct reset_controller_dev *rcdev,
-			       unsigned long id)
-{
-	return jh7100_reset_update(rcdev, id, true);
-}
-
-static int jh7100_reset_deassert(struct reset_controller_dev *rcdev,
-				 unsigned long id)
-{
-	return jh7100_reset_update(rcdev, id, false);
-}
-
-static int jh7100_reset_reset(struct reset_controller_dev *rcdev,
-			      unsigned long id)
-{
-	int ret;
-
-	ret = jh7100_reset_assert(rcdev, id);
-	if (ret)
-		return ret;
-
-	return jh7100_reset_deassert(rcdev, id);
-}
-
-static int jh7100_reset_status(struct reset_controller_dev *rcdev,
-			       unsigned long id)
-{
-	struct jh7100_reset *data = jh7100_reset_from(rcdev);
-	unsigned long offset = BIT_ULL_WORD(id);
-	u64 mask = BIT_ULL_MASK(id);
-	void __iomem *reg_status = data->base + JH7100_RESET_STATUS0 + offset * sizeof(u64);
-	u64 value = readq(reg_status);
-
-	return !((value ^ jh7100_reset_asserted[offset]) & mask);
-}
-
-static const struct reset_control_ops jh7100_reset_ops = {
-	.assert		= jh7100_reset_assert,
-	.deassert	= jh7100_reset_deassert,
-	.reset		= jh7100_reset_reset,
-	.status		= jh7100_reset_status,
-};
-
-static int __init jh7100_reset_probe(struct platform_device *pdev)
-{
-	struct jh7100_reset *data;
-
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	data->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(data->base))
-		return PTR_ERR(data->base);
-
-	data->rcdev.ops = &jh7100_reset_ops;
-	data->rcdev.owner = THIS_MODULE;
-	data->rcdev.nr_resets = JH7100_RSTN_END;
-	data->rcdev.dev = &pdev->dev;
-	data->rcdev.of_node = pdev->dev.of_node;
-	spin_lock_init(&data->lock);
-
-	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
-}
+#include "reset-starfive-jh71x0.h"
 
 static const struct of_device_id jh7100_reset_dt_ids[] = {
 	{ .compatible = "starfive,jh7100-reset" },
diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.c b/drivers/reset/starfive/reset-starfive-jh71x0.c
new file mode 100644
index 000000000000..114a13c4b8a6
--- /dev/null
+++ b/drivers/reset/starfive/reset-starfive-jh71x0.c
@@ -0,0 +1,162 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Reset driver for the StarFive JH7100 SoC
+ *
+ * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+#include <linux/bitmap.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/iopoll.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/spinlock.h>
+
+#include "reset-starfive-jh71x0.h"
+
+#include <dt-bindings/reset/starfive-jh7100.h>
+
+/* register offsets */
+#define JH7100_RESET_ASSERT0	0x00
+#define JH7100_RESET_ASSERT1	0x04
+#define JH7100_RESET_ASSERT2	0x08
+#define JH7100_RESET_ASSERT3	0x0c
+#define JH7100_RESET_STATUS0	0x10
+#define JH7100_RESET_STATUS1	0x14
+#define JH7100_RESET_STATUS2	0x18
+#define JH7100_RESET_STATUS3	0x1c
+
+/*
+ * Writing a 1 to the n'th bit of the m'th ASSERT register asserts
+ * line 32m + n, and writing a 0 deasserts the same line.
+ * Most reset lines have their status inverted so a 0 bit in the STATUS
+ * register means the line is asserted and a 1 means it's deasserted. A few
+ * lines don't though, so store the expected value of the status registers when
+ * all lines are asserted.
+ */
+static const u64 jh7100_reset_asserted[2] = {
+	/* STATUS0 */
+	BIT_ULL_MASK(JH7100_RST_U74) |
+	BIT_ULL_MASK(JH7100_RST_VP6_DRESET) |
+	BIT_ULL_MASK(JH7100_RST_VP6_BRESET) |
+	/* STATUS1 */
+	BIT_ULL_MASK(JH7100_RST_HIFI4_DRESET) |
+	BIT_ULL_MASK(JH7100_RST_HIFI4_BRESET),
+	/* STATUS2 */
+	BIT_ULL_MASK(JH7100_RST_E24) |
+	/* STATUS3 */
+	0,
+};
+
+struct jh7100_reset {
+	struct reset_controller_dev rcdev;
+	/* protect registers against concurrent read-modify-write */
+	spinlock_t lock;
+	void __iomem *base;
+};
+
+static inline struct jh7100_reset *
+jh7100_reset_from(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct jh7100_reset, rcdev);
+}
+
+static int jh7100_reset_update(struct reset_controller_dev *rcdev,
+			       unsigned long id, bool assert)
+{
+	struct jh7100_reset *data = jh7100_reset_from(rcdev);
+	unsigned long offset = BIT_ULL_WORD(id);
+	u64 mask = BIT_ULL_MASK(id);
+	void __iomem *reg_assert = data->base + JH7100_RESET_ASSERT0 + offset * sizeof(u64);
+	void __iomem *reg_status = data->base + JH7100_RESET_STATUS0 + offset * sizeof(u64);
+	u64 done = jh7100_reset_asserted[offset] & mask;
+	u64 value;
+	unsigned long flags;
+	int ret;
+
+	if (!assert)
+		done ^= mask;
+
+	spin_lock_irqsave(&data->lock, flags);
+
+	value = readq(reg_assert);
+	if (assert)
+		value |= mask;
+	else
+		value &= ~mask;
+	writeq(value, reg_assert);
+
+	/* if the associated clock is gated, deasserting might otherwise hang forever */
+	ret = readq_poll_timeout_atomic(reg_status, value, (value & mask) == done, 0, 1000);
+
+	spin_unlock_irqrestore(&data->lock, flags);
+	return ret;
+}
+
+static int jh7100_reset_assert(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	return jh7100_reset_update(rcdev, id, true);
+}
+
+static int jh7100_reset_deassert(struct reset_controller_dev *rcdev,
+				 unsigned long id)
+{
+	return jh7100_reset_update(rcdev, id, false);
+}
+
+static int jh7100_reset_reset(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	int ret;
+
+	ret = jh7100_reset_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	return jh7100_reset_deassert(rcdev, id);
+}
+
+static int jh7100_reset_status(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	struct jh7100_reset *data = jh7100_reset_from(rcdev);
+	unsigned long offset = BIT_ULL_WORD(id);
+	u64 mask = BIT_ULL_MASK(id);
+	void __iomem *reg_status = data->base + JH7100_RESET_STATUS0 + offset * sizeof(u64);
+	u64 value = readq(reg_status);
+
+	return !((value ^ jh7100_reset_asserted[offset]) & mask);
+}
+
+static const struct reset_control_ops jh7100_reset_ops = {
+	.assert		= jh7100_reset_assert,
+	.deassert	= jh7100_reset_deassert,
+	.reset		= jh7100_reset_reset,
+	.status		= jh7100_reset_status,
+};
+
+int jh7100_reset_probe(struct platform_device *pdev)
+{
+	struct jh7100_reset *data;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(data->base))
+		return PTR_ERR(data->base);
+
+	data->rcdev.ops = &jh7100_reset_ops;
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = JH7100_RSTN_END;
+	data->rcdev.dev = &pdev->dev;
+	data->rcdev.of_node = pdev->dev.of_node;
+	spin_lock_init(&data->lock);
+
+	return devm_reset_controller_register(&pdev->dev, &data->rcdev);
+}
+EXPORT_SYMBOL_GPL(jh7100_reset_probe);
diff --git a/drivers/reset/starfive/reset-starfive-jh71x0.h b/drivers/reset/starfive/reset-starfive-jh71x0.h
new file mode 100644
index 000000000000..318d7a0e096a
--- /dev/null
+++ b/drivers/reset/starfive/reset-starfive-jh71x0.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2021 Emil Renner Berthing <kernel@esmil.dk>
+ */
+
+#ifndef __RESET_STARFIVE_JH71X0_H
+#define __RESET_STARFIVE_JH71X0_H
+
+int jh7100_reset_probe(struct platform_device *pdev);
+
+#endif /* __RESET_STARFIVE_JH71X0_H */
-- 
2.38.1

