Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68D76BA251
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 23:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjCNWTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 18:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjCNWS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 18:18:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43DB23DB5;
        Tue, 14 Mar 2023 15:17:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lb4mF/XTA2j+SShGzqv2/1F2Q9LVMjyB5DMqJtHZjdILDWFS4fgbuPbfF+pXrIlpM6fITO9SUjzo9wSRs2H8KBgiKfCwRAjsd5t890cO6qH6AFXAfSXbOT7FokfexdhEUFZM7nYfceb99v4TUcjOndPGesRcnIWsixBBDso0D2aFnaUpH+Ntnnsi7uOsQXb94LqfhR0sj6lE1jRv8mMVLC1y85jDTBARclO9LopaNnCzQGNsrnTbEkDr6A01k/ZeVp/jtE6k+JoknJv2VlHpC9GE7Crmf27J8GAveJ5Y4UVChZcDQO7jcoyWvI+hy/EigcwMB656ALuryehZ6eomnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DAtyzIHOQsytxJ49OKsC4/9zDeWwA4jDtVanoY7truc=;
 b=FN9gS42n4rhWtPgA0fCBZDO1l9hZEbKJIIbK6wkvWaqABpzWQ+wY2bjshHtndFPeftq/9Y6YRhdHCWh7Nk2Wvpo6CYXgPxm8mTMJV8V6qQHuZ+z3OMbP75pAbp6G+hHhM4HOz3TafEGEXxViMmpjpFtR09vnFTKcKBYwUxptUPDRJL69B+5xVwqQ5gV+PlfEsq86TCQN0kv5WV0Y2xWD02iZVy3xooq8wSsi1wZbXWKqK4Mg9iF9EURkEALkSmlgK3dravw9eQyMtHhmvvIvXixHmh6XBr0avNG6MjJcQx0QhIZpBM0qSv3O2j1OvfGiWFF/ZGqOvM7okmv5gyRQcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DAtyzIHOQsytxJ49OKsC4/9zDeWwA4jDtVanoY7truc=;
 b=Aobk+q+scpZql4oFHNjea6c/jnTkV6wQotIKr6TGQxft0kwNAimvKQSj55/M8dD2ifbG6rX/5sroEEIUV8rPcsFnw/K97QR2vkz6Pk5i9Qdv4bJvGaLZbz/FwTKs7AVQyUQHoli6Ruola2vdYCroaYLVZUYBCnOa90ndhfunGkO0riRqrummqyYXrHu9RarbMFJ2VdgDoFl/gfRbcD7Z/omLbpYbuzxWQX1nfg76Lq4SBXND74Fg/3SPms+AhfPAnvj9ZnPoHr5LaRDUJYXz4zpNQsUK8pSOCbpj1fMafQ44M+vElWIpMny4OLmOg3Bf1LL4htL19gFdF0ZrXR9UfQ==
Received: from DS7PR03CA0099.namprd03.prod.outlook.com (2603:10b6:5:3b7::14)
 by BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Tue, 14 Mar
 2023 22:16:23 +0000
Received: from DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::6f) by DS7PR03CA0099.outlook.office365.com
 (2603:10b6:5:3b7::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26 via Frontend
 Transport; Tue, 14 Mar 2023 22:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT083.mail.protection.outlook.com (10.13.173.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6199.11 via Frontend Transport; Tue, 14 Mar 2023 22:16:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 14 Mar 2023
 15:16:18 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 14 Mar
 2023 15:16:17 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.5 via Frontend Transport; Tue, 14 Mar
 2023 15:16:16 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v5 1/2] gpio: gpio-mlxbf3: Add gpio driver support
Date:   Tue, 14 Mar 2023 18:16:08 -0400
Message-ID: <20230314221609.22433-2-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230314221609.22433-1-asmaa@nvidia.com>
References: <20230314221609.22433-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT083:EE_|BL1PR12MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: a6bcaa34-0073-43e0-c7ab-08db24d9beba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GPA9aZTQPOHCLSqHit74pt236Dq6Fl1IlLPonBxxZ/KwXT/rOu4IFrOUWRRoP3bU8KovQZ5lHsgtSZo4GScmJc2Ir4rowX6ECLNe5bm9ONiciK0zn1/lVUR4MBZrew5KFTF6JynJQBs0M1qa9H7U8odrGkfF+PgYvFic1Z4eWGddETUfQhWEOKtbO8EhbzjQP0iVLMVXHLct9A9nuTv8/LbdHCaVGJ/BvZEYf5FeBDHLy3VU2r+b859MRuZ9MHmA/wfL7f/3ggmMgCjLlhlo8FwTOIybb815a+z4Jf6gT4/zPXF/cwqmzTfZvfoVCKumTv6bjx2iLKWHJlhYOUAUuyLDEFaQ1p5mkGlGyWVVGiqdl+HOiVqG7IJuYhXYRbWYTkBe+zS997IY1BykQ7xjRu9SJZJpwtmbPTczVGNKSJO0HoncwycBd1VnBtiuhEhrHbD/XJq3aHi69gUjQ4vXOnOf2BWn/+B3rrCtelKnpG3GnR9cC/LYvN4kN6fTQBjU/wm3W9p9Zbbc0cjRXg/u8ad4OUIB/A6AM0o9uDoP0pLj2/bTJRNdwXlvQV5gn7jgeyhT93amsl40hpEoDL5QIWL7s4kRJgo0iM2/8pcDAb6su09i9lpMuz/nMMW3MMFi2PtWUjNokX6RJCjok4WeOQFOuEmCJ0HWq5roYZtzaFSgaKs+DudtPohoNN5N76Mw5AnQ5SEPFYzsic/Iijk9q+6mhnhhJz46EPsXCdF//XY/aISIbHagT9H4R6RoRTt8
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(5660300002)(478600001)(2616005)(7696005)(40460700003)(2906002)(336012)(40480700001)(26005)(1076003)(107886003)(6666004)(36756003)(186003)(47076005)(86362001)(426003)(41300700001)(70586007)(36860700001)(82310400005)(82740400003)(7636003)(4326008)(8676002)(70206006)(8936002)(356005)(316002)(83380400001)(110136005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2023 22:16:22.8066
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6bcaa34-0073-43e0-c7ab-08db24d9beba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the BlueField-3 SoC GPIO driver.
This driver configures and handles GPIO interrupts. It also enables a user
to manipulate certain GPIO pins via libgpiod tools or other kernel drivers.
The usables pins are defined via the "gpio-reserved-ranges" property.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/gpio/Kconfig       |  13 ++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-mlxbf3.c | 245 +++++++++++++++++++++++++++++++++++++
 3 files changed, 259 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf3.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ec7cfd4f52b1..3b67e1591519 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1534,6 +1534,19 @@ config GPIO_MLXBF2
 	help
 	  Say Y here if you want GPIO support on Mellanox BlueField 2 SoC.
 
+config GPIO_MLXBF3
+	tristate "Mellanox BlueField 3 SoC GPIO"
+	depends on (MELLANOX_PLATFORM && ARM64) || COMPILE_TEST
+	select GPIO_GENERIC
+	select GPIOLIB_IRQCHIP
+	help
+	  Say Y if you want GPIO support on Mellanox BlueField 3 SoC.
+	  This GPIO controller supports interrupt handling and enables the
+	  manipulation of certain GPIO pins.
+	  This controller should be used in parallel with pinctrl-mlxbf to
+	  control the desired gpios.
+	  This driver can also be built as a module called mlxbf3-gpio.
+
 config GPIO_ML_IOH
 	tristate "OKI SEMICONDUCTOR ML7213 IOH GPIO support"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 010587025fc8..76545ca31457 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_GPIO_MERRIFIELD)		+= gpio-merrifield.o
 obj-$(CONFIG_GPIO_ML_IOH)		+= gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MLXBF)		+= gpio-mlxbf.o
 obj-$(CONFIG_GPIO_MLXBF2)		+= gpio-mlxbf2.o
+obj-$(CONFIG_GPIO_MLXBF3)		+= gpio-mlxbf3.o
 obj-$(CONFIG_GPIO_MM_LANTIQ)		+= gpio-mm-lantiq.o
 obj-$(CONFIG_GPIO_MOCKUP)		+= gpio-mockup.o
 obj-$(CONFIG_GPIO_MOXTET)		+= gpio-moxtet.o
diff --git a/drivers/gpio/gpio-mlxbf3.c b/drivers/gpio/gpio-mlxbf3.c
new file mode 100644
index 000000000000..4225f6d38db3
--- /dev/null
+++ b/drivers/gpio/gpio-mlxbf3.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
+/* Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/resource.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+/*
+ * There are 2 YU GPIO blocks:
+ * gpio[0]: HOST_GPIO0->HOST_GPIO31
+ * gpio[1]: HOST_GPIO32->HOST_GPIO55
+ */
+#define MLXBF3_GPIO_MAX_PINS_PER_BLOCK 32
+
+/*
+ * fw_gpio[x] block registers and their offset
+ */
+#define MLXBF_GPIO_FW_OUTPUT_ENABLE_SET	  0x00
+#define MLXBF_GPIO_FW_DATA_OUT_SET        0x04
+
+#define MLXBF_GPIO_FW_OUTPUT_ENABLE_CLEAR 0x00
+#define MLXBF_GPIO_FW_DATA_OUT_CLEAR      0x04
+
+#define MLXBF_GPIO_CAUSE_RISE_EN          0x00
+#define MLXBF_GPIO_CAUSE_FALL_EN          0x04
+#define MLXBF_GPIO_READ_DATA_IN           0x08
+
+#define MLXBF_GPIO_CAUSE_OR_CAUSE_EVTEN0  0x00
+#define MLXBF_GPIO_CAUSE_OR_EVTEN0        0x14
+#define MLXBF_GPIO_CAUSE_OR_CLRCAUSE      0x18
+
+struct mlxbf3_gpio_context {
+	struct gpio_chip gc;
+
+	/* YU GPIO block address */
+	void __iomem *gpio_set_io;
+	void __iomem *gpio_clr_io;
+	void __iomem *gpio_io;
+
+	/* YU GPIO cause block address */
+	void __iomem *gpio_cause_io;
+};
+
+static void mlxbf3_gpio_irq_enable(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct mlxbf3_gpio_context *gs = gpiochip_get_data(gc);
+	irq_hw_number_t offset = irqd_to_hwirq(irqd);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+	gpiochip_enable_irq(gc, offset);
+	writel(BIT(offset), gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_CLRCAUSE);
+
+	val = readl(gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
+	val |= BIT(offset);
+	writel(val, gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
+	raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+}
+
+static void mlxbf3_gpio_irq_disable(struct irq_data *irqd)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct mlxbf3_gpio_context *gs = gpiochip_get_data(gc);
+	irq_hw_number_t offset = irqd_to_hwirq(irqd);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+	val = readl(gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
+	val &= ~BIT(offset);
+	writel(val, gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
+	gpiochip_disable_irq(gc, offset);
+	raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+}
+
+static irqreturn_t mlxbf3_gpio_irq_handler(int irq, void *ptr)
+{
+	struct mlxbf3_gpio_context *gs = ptr;
+	struct gpio_chip *gc = &gs->gc;
+	unsigned long pending;
+	u32 level;
+
+	pending = readl(gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_CAUSE_EVTEN0);
+	writel(pending, gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_CLRCAUSE);
+
+	for_each_set_bit(level, &pending, gc->ngpio)
+		generic_handle_domain_irq(gc->irq.domain, level);
+
+	return IRQ_RETVAL(pending);
+}
+
+static int
+mlxbf3_gpio_irq_set_type(struct irq_data *irqd, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(irqd);
+	struct mlxbf3_gpio_context *gs = gpiochip_get_data(gc);
+	irq_hw_number_t offset = irqd_to_hwirq(irqd);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_BOTH:
+		val = readl(gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
+		val |= BIT(offset);
+		writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
+		val = readl(gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
+		val |= BIT(offset);
+		writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		val = readl(gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
+		val |= BIT(offset);
+		writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		val = readl(gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
+		val |= BIT(offset);
+		writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
+		break;
+	default:
+		raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+		return -EINVAL;
+	}
+
+	raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+
+	irq_set_handler_locked(irqd, handle_edge_irq);
+
+	return 0;
+}
+
+/* This function needs to be defined for handle_edge_irq */
+static void mlxbf3_gpio_irq_ack(struct irq_data *data)
+{
+}
+
+static const struct irq_chip gpio_mlxbf3_irqchip = {
+	.name = "MLNXBF33",
+	.irq_ack = mlxbf3_gpio_irq_ack,
+	.irq_set_type = mlxbf3_gpio_irq_set_type,
+	.irq_enable = mlxbf3_gpio_irq_enable,
+	.irq_disable = mlxbf3_gpio_irq_disable,
+	.flags = IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
+static int mlxbf3_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mlxbf3_gpio_context *gs;
+	struct gpio_irq_chip *girq;
+	struct gpio_chip *gc;
+	int ret, irq;
+
+	gs = devm_kzalloc(dev, sizeof(*gs), GFP_KERNEL);
+	if (!gs)
+		return -ENOMEM;
+
+	gs->gpio_io = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(gs->gpio_io))
+		return PTR_ERR(gs->gpio_io);
+
+	gs->gpio_cause_io = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(gs->gpio_cause_io))
+		return PTR_ERR(gs->gpio_cause_io);
+
+	gs->gpio_set_io = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(gs->gpio_set_io))
+		return PTR_ERR(gs->gpio_set_io);
+
+	gs->gpio_clr_io = devm_platform_ioremap_resource(pdev, 3);
+	if (IS_ERR(gs->gpio_clr_io))
+		return PTR_ERR(gs->gpio_clr_io);
+	gc = &gs->gc;
+
+	ret = bgpio_init(gc, dev, 4,
+			gs->gpio_io + MLXBF_GPIO_READ_DATA_IN,
+			gs->gpio_set_io + MLXBF_GPIO_FW_DATA_OUT_SET,
+			gs->gpio_clr_io + MLXBF_GPIO_FW_DATA_OUT_CLEAR,
+			gs->gpio_set_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_SET,
+			gs->gpio_clr_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_CLEAR, 0);
+
+	gc->request = gpiochip_generic_request;
+	gc->free = gpiochip_generic_free;
+	gc->owner = THIS_MODULE;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq >= 0) {
+		girq = &gs->gc.irq;
+		gpio_irq_chip_set_chip(girq, &gpio_mlxbf3_irqchip);
+		girq->default_type = IRQ_TYPE_NONE;
+		/* This will let us handle the parent IRQ in the driver */
+		girq->num_parents = 0;
+		girq->parents = NULL;
+		girq->parent_handler = NULL;
+		girq->handler = handle_bad_irq;
+
+		/*
+		 * Directly request the irq here instead of passing
+		 * a flow-handler because the irq is shared.
+		 */
+		ret = devm_request_irq(dev, irq, mlxbf3_gpio_irq_handler,
+				       IRQF_SHARED, dev_name(dev), gs);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to request IRQ");
+	}
+
+	platform_set_drvdata(pdev, gs);
+
+	ret = devm_gpiochip_add_data(dev, &gs->gc, gs);
+	if (ret)
+		dev_err_probe(dev, ret, "Failed adding memory mapped gpiochip\n");
+
+	return 0;
+}
+
+static const struct acpi_device_id __maybe_unused mlxbf3_gpio_acpi_match[] = {
+	{ "MLNXBF33", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, mlxbf3_gpio_acpi_match);
+
+static struct platform_driver mlxbf3_gpio_driver = {
+	.driver = {
+		.name = "mlxbf3_gpio",
+		.acpi_match_table = mlxbf3_gpio_acpi_match,
+	},
+	.probe    = mlxbf3_gpio_probe,
+};
+module_platform_driver(mlxbf3_gpio_driver);
+
+MODULE_DESCRIPTION("NVIDIA BlueField-3 GPIO Driver");
+MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.1

