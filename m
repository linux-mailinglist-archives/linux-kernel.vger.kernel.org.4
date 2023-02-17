Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111AF69B4C1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjBQV1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBQV1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:27:01 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DFB5BD8B;
        Fri, 17 Feb 2023 13:27:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGoxpVJUgVC6dgFNsT+wVGw8x+EvRGLdr51zrJqOM3dbyss2+pyGuH2ZvfQyAKhXsX/9NAZPEB5YlV7jqskEItybCuOGwWZoz3ZQp0zrVH4gXOmJqOaKwNIwPe09C9W7VYKpRih35qy6Ev3yw+xH52Vm4pF2L4rNIr8dRTNHPxoMrY28ikHOM3YRVBEnrW5CNYlQkwqS5X/sAoWZKH3WruR7mZsfj9Fa3UmhonsQY0sVGlMiVXZpYgRAuqQorrFCcqFCzrCmmJG4UTILLfTqHYfq5ipKrjJ0YGZaxdGUyfUdkrVEIqfLt96cjA2quQyvw16EdNYkXV5hNx+R7j2+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y8jmPLxoASWvpITD03Bk9a6gqoWc5V0f3A2QgRe1kyo=;
 b=NvKeZKCIQ6SJyr7/tfW+2Ybs+jO+dwNYjIqfZ+fuGeds8mEiQUc/wuTvSkMkzOfp/SYC7KzUZ3RxFF77gc9VMgjKU6xy3ZqJAEXAOK0qsAok5wNKeT3iZO525CpoZiVPrAy3h7QQBanhenhCNodPjonCPwiCg18bJL4VxhN0xjtV34327uRVbZlopzGGCFgf/96y8ke4X6D8dskT75yD9Vezxh5agfnRpzh846wEYoneHZSE6q2qDRtuld9rfi36UawXPzwi9DzWv9XFi6O1xgjZixRQc2w0b+a9XPJIY7MuoYhXqJRj3TIvnos0ZViNX/TyTcisrC8xvBI7+ZoUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y8jmPLxoASWvpITD03Bk9a6gqoWc5V0f3A2QgRe1kyo=;
 b=FuX/y+FK3Qihdawdms7vUP5cUnJC1WDZ4NoIzpULaKNsTfLKfgg/pO3T/QGvNQXM+uH70HD13ajmSFxvkRvCSJAyHbmtFSS46QF+tfROZxShWXg/qLx/cqh6QpEonCmSjQGYklWEHW5tR9Spsno2jSS3FU42rKKGRUkn+yRuEyU2xYARhUrNoZRU9/me9/r0MVQuR6kXip/cToIJQg+ZhrGcHPo0L3J0zcgG/zSXjCAOLq3l/ks6n4nl7ztq0PWDMRdxN91ti8PEeUvFsBcfoc6X7KZZYxdypwZVCZQSVy8B2qEXKFzSrSSuPYzxNvM+2LAmq0iDduCoRV4ucyBN3Q==
Received: from DM6PR08CA0018.namprd08.prod.outlook.com (2603:10b6:5:80::31) by
 CH2PR12MB4924.namprd12.prod.outlook.com (2603:10b6:610:6b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.15; Fri, 17 Feb 2023 21:26:58 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::6c) by DM6PR08CA0018.outlook.office365.com
 (2603:10b6:5:80::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.15 via Frontend
 Transport; Fri, 17 Feb 2023 21:26:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.22 via Frontend Transport; Fri, 17 Feb 2023 21:26:57 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 17 Feb
 2023 13:26:57 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 17 Feb 2023 13:26:56 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 17 Feb 2023 13:26:56 -0800
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v4 1/2] gpio: gpio-mlxbf3: Add gpio driver support
Date:   Fri, 17 Feb 2023 16:26:50 -0500
Message-ID: <28f0d670407c127614b64d9c382b11c795f5077d.1676668853.git.asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1676668853.git.asmaa@nvidia.com>
References: <cover.1676042188.git.asmaa@nvidia.com> <cover.1676668853.git.asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT044:EE_|CH2PR12MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb1f5f2-c2ac-478e-14f7-08db112db31b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4kAfgZ8UTeCAX/8Ol9bYXrkb+ShECD3/6G3PgAYmmO2GPx5G57KrtA38zJ28jLNj8sgpE4sYB2D/9nNnnoJ54Gu/4pbMbql4ytIT/BNvPrrc+xA6r2HMArdTluXl3z+Ve+z/uMYZS9Qi90KWyumo6pjA4rjMa+0SwTeekvpFLhtoaGn/+NMRcNaQ99SX9lYzpudRBZO0o2/eLNmsUcaiwMBv6g4PYqJhjwUd3wbUgQ8Yr93itQoDozBZQtdDpn1cqOJTGIUohV7UT6XRhtbLPT8XqoxEXPjXa6BjFgagJH+61RUbmNqkGeM4Unkd7bjh7FshmDCOkhNdrUKcfrTa39wC7Fzbj0IPjjCyui60pnw81zGIYCRn6quWVUR1vOq90cGztcwlzbW4i0wpTKs2VfXY8HXILOxK8oPpfghCO1xJs/0uJzzsAEczgQkMN4gCHpGGYWNyU4cfUKQIxtQl1j4MkB7jhp85kSAMTF1q8wOC3VwK4cO6jz9F7JC4cz3tKSWqwPByEuwutNQHlRNtSfrETi/hnDdqtEXmhbxsCcVBs5CB+eTg+B5qLo8MTpdNbkLoC8dtY0w2y9CEtjf1ueWhSAymKb5oHSJybkurTMZ321x1KuCmzSws1r+0wErfuEcBoYAsLQ4phT58+Lk2kKBKUukFEYBN75SuXa6WqWUuRREZsYvio148hwkfnFUByRJ7NvCoQZEkiNcylq6zxQ==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(7636003)(47076005)(2616005)(83380400001)(4326008)(86362001)(426003)(5660300002)(336012)(41300700001)(36860700001)(8676002)(40480700001)(7696005)(36756003)(70206006)(70586007)(82310400005)(110136005)(316002)(40460700003)(478600001)(8936002)(107886003)(2906002)(26005)(186003)(356005)(82740400003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 21:26:57.7904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb1f5f2-c2ac-478e-14f7-08db112db31b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4924
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the BlueField-3 SoC GPIO driver.
This driver configures and handles GPIO interrupts. It also enables a user
to manipulate certain GPIO pins via libgpiod tools or other kernel drivers.
The usables pins are defined via the gpio-reserved-ranges property.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/gpio/Kconfig       |  12 ++
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-mlxbf3.c | 230 +++++++++++++++++++++++++++++++++++++
 3 files changed, 243 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf3.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ec7cfd4f52b1..5cddcb56353d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1534,6 +1534,18 @@ config GPIO_MLXBF2
 	help
 	  Say Y here if you want GPIO support on Mellanox BlueField 2 SoC.
 
+config GPIO_MLXBF3
+	tristate "Mellanox BlueField 3 SoC GPIO"
+	depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || (64BIT && COMPILE_TEST)
+	select GPIO_GENERIC
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
index 000000000000..cdc93c8e77ff
--- /dev/null
+++ b/drivers/gpio/gpio-mlxbf3.c
@@ -0,0 +1,230 @@
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
+#include <linux/version.h>
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
+#define MLXBF_GPIO_FW_OUTPUT_ENABLE_SET	  0x04
+#define MLXBF_GPIO_FW_DATA_OUT_SET        0x08
+#define MLXBF_GPIO_FW_OUTPUT_ENABLE_CLEAR 0x18
+#define MLXBF_GPIO_FW_DATA_OUT_CLEAR      0x1c
+#define MLXBF_GPIO_CAUSE_RISE_EN          0x28
+#define MLXBF_GPIO_CAUSE_FALL_EN          0x2c
+#define MLXBF_GPIO_READ_DATA_IN           0x30
+
+#define MLXBF_GPIO_CAUSE_OR_CAUSE_EVTEN0  0x00
+#define MLXBF_GPIO_CAUSE_OR_EVTEN0        0x14
+#define MLXBF_GPIO_CAUSE_OR_CLRCAUSE      0x18
+
+struct mlxbf3_gpio_context {
+	struct gpio_chip gc;
+
+	/* YU GPIO block address */
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
+	int offset = irqd_to_hwirq(irqd);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
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
+	int offset = irqd_to_hwirq(irqd);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+	val = readl(gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
+	val &= ~BIT(offset);
+	writel(val, gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
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
+	int offset = irqd_to_hwirq(irqd);
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
+		return -EINVAL;
+	}
+
+	raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+
+	irq_set_handler_locked(irqd, handle_simple_irq);
+
+	return 0;
+}
+
+static const struct irq_chip gpio_mlxbf3_irqchip = {
+	.name = "MLNXBF33",
+	.irq_set_type = mlxbf3_gpio_irq_set_type,
+	.irq_enable = mlxbf3_gpio_irq_enable,
+	.irq_disable = mlxbf3_gpio_irq_disable,
+};
+
+static int
+mlxbf3_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mlxbf3_gpio_context *gs;
+	struct gpio_irq_chip *girq;
+	struct gpio_chip *gc;
+	unsigned int npins;
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
+	npins = MLXBF3_GPIO_MAX_PINS_PER_BLOCK;
+	device_property_read_u32(dev, "npins", &npins);
+
+	gc = &gs->gc;
+
+	ret = bgpio_init(gc, dev, 4,
+			gs->gpio_io + MLXBF_GPIO_READ_DATA_IN,
+			gs->gpio_io + MLXBF_GPIO_FW_DATA_OUT_SET,
+			gs->gpio_io + MLXBF_GPIO_FW_DATA_OUT_CLEAR,
+			gs->gpio_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_SET,
+			gs->gpio_io + MLXBF_GPIO_FW_OUTPUT_ENABLE_CLEAR, 0);
+
+	gc->request = gpiochip_generic_request;
+	gc->free = gpiochip_generic_free;
+
+	gc->ngpio = npins;
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

