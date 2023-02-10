Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D85B69226F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjBJPkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbjBJPj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:39:58 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C35275344;
        Fri, 10 Feb 2023 07:39:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWwFTccGWxd2L/Tn6SF7LS1LELdT9/AWekXpw4ud3FW88vzB0rBnbVUBB82zpzjHrpjrgWriiqAEyH8pSssNwQbkGR3fE+HmNErzDyUpfHDnx6MSNx8nbYPm9IX9iTVybRiwefymXt8PSgR4J8xMr0ZYkKWBhIDavvhsRQpu28ytxIZEMcUJBeYsUH9+fPwwiSev7jM1a1GsecaB448Z6BJ9eL6tahtuSHso8b/GNsdxrcN1a3kJfSezuys484G9U9nH9PTUOLV0MkFTdq5EoEii9SWjchLK0pRu7UjJw+mEzuSpqxSKEabmuDkFmdBx5Ud09Q2GdY1coYV/XWCqrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6V5yB28WCO92iVyGQCuMmROTALUbpWAxH3HH576hyU=;
 b=fmCPSiYx3U1q0Os2P6mwoQVD/p8hdP2jnz2Nic8hyUTy5gZSw+gYIpX5pazum5R3++Lhr4DpFoRS26mBZhr6Vh+EIVcIkwgGWegYBOh1LKghrJ6vMSfc85Bw6SkFHQjKAlMXnO3+Yybzx+Ptk4ZptzcxNrrWKFo5j7olbdvuHC0uZ+tzobu9BhXAn04PSHbCctxDrLecracu1WKWE66iaENs2iDHUZCPb7pTR33RXo6kDKosSRci7KkRkhmqJSupEEk2tiIN8D7T9VCp3bb5q4OEDht2akwRzLQKkSob5ydTIHk4xDxLOXHJLeid/yKX0rSwgv280dU2zkMPPiVwSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6V5yB28WCO92iVyGQCuMmROTALUbpWAxH3HH576hyU=;
 b=lODt2sJO7Ieg8o8okrhULs0FYzKzfDl3xTgaBLfQfnbAPk1NdfrNsuC3+JqSUZtWaJs1xqz8PlUe5p9E5JVHMeTcQS7xKXaG7A4QC3h5YCUI+eHgWwzbElJJMuzWIXjgPUNgVh4NGy25xGk39giuvAAIUOEmD5BEsUllp0vK+NsCVV6fbYeSBc1Dt1lSI4sTufdTh6nXWSpekcHAyec5EZJUsP4FNdciSLj95F+ofMPnf+v1xVtXwW9MEKeSNXk8fpaeUe+9ZYk+z8BA1a1B8+VSyjT/Z28kOm/02v6f+Bo8tMPTM0E0fPTya0ieGXVtJpypV280M0XXVpJMbfmHBw==
Received: from BN8PR15CA0059.namprd15.prod.outlook.com (2603:10b6:408:80::36)
 by BL1PR12MB5110.namprd12.prod.outlook.com (2603:10b6:208:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 15:39:51 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::16) by BN8PR15CA0059.outlook.office365.com
 (2603:10b6:408:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21 via Frontend
 Transport; Fri, 10 Feb 2023 15:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.21 via Frontend Transport; Fri, 10 Feb 2023 15:39:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 10 Feb
 2023 07:39:48 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 10 Feb 2023 07:39:47 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 10 Feb 2023 07:39:47 -0800
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v3 1/2] Support NVIDIA BlueField-3 GPIO controller
Date:   Fri, 10 Feb 2023 10:39:40 -0500
Message-ID: <c1bf45a868edcd3df5263fa76a32b28e6c9ca3d1.1676042188.git.asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1676042188.git.asmaa@nvidia.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|BL1PR12MB5110:EE_
X-MS-Office365-Filtering-Correlation-Id: 541a6598-8ff0-481f-76ce-08db0b7d0c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q/vZAzS9jq4U3gdZjVbik669Bf8qYH79wta82TlXNk1gwFNEA/CnyT5pDv0tprgG6eUHvTXDkK5jo86p8qR/RCfpwP3tHIl4CU/euyO9FTyOVR4ychOgV/XZ7zQ8gZvMQY1hEXHvu/DMGkX+QIzleNGFhJ9GPQ8K/15IoJHwWixXvKWKWMTMuRt14m4TL7oGUnMg4yQPDgNIHn+B154j18yxV+/PwgofjoqvFqUreDBvjaRDpZ+LBiQLR8179hPNZOGOC0t/KLFvBKJs/3yxm3G5tkBd045HUjteUsVNM80NpnrhlfjRKuO0DGUGTBJHsyDel8U3w6y4/ARcXr78v/FvzHowDfD+h8KkLu/eJDcX24emAqI8qozK2O0+Jt0X0ByL1wR3fjat542B27r/3HLcEo0ptPqgR11Wmh7TtVrV/t7Pg3dkk+Cb2YD+mgy9/nC9BGXxJaii7i6Lt/Q9Lwip3VgI3uB2Az9ex41aE/Mz4FDz3XjUlXK75r68GjS8JIUEV+v5bBB8XbtDpy0n5ULtLI7S1MGtWsRA18r6Wo4E72Ol6PPiJxz8V0dESWB7K2gJEyjZ8jaNN7KBispJfkWeDkrS2MB1MGh1ajT4tZPbtkKvVlCfCp8FW8s/okZLJ2x6GTJomFtv9n9FDOi4wXQu1t/N5YBRbCzgoFlm+6oiCoshFc3WHWQvjd3RO89Ss0LqBIe+gN3sd742+XBu9Q==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199018)(36840700001)(40470700004)(46966006)(5660300002)(36756003)(82740400003)(356005)(41300700001)(36860700001)(7636003)(82310400005)(107886003)(86362001)(2616005)(2906002)(83380400001)(47076005)(40460700003)(336012)(426003)(186003)(8936002)(26005)(6666004)(110136005)(40480700001)(450100002)(316002)(478600001)(8676002)(4326008)(70586007)(7696005)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 15:39:51.0073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 541a6598-8ff0-481f-76ce-08db0b7d0c85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5110
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the BlueField-3 SoC GPIO driver
which allows:
- setting certain GPIOs as interrupts from other dependent drivers
- ability to manipulate certain GPIO pins via libgpiod tools

BlueField-3 has 56 GPIOs but the user is only allowed to change some
of them into GPIO mode. Use valid_mask to make it impossible to alter
the rest of the GPIOs.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/gpio/Kconfig       |   7 +
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-mlxbf3.c | 262 +++++++++++++++++++++++++++++++++++++
 3 files changed, 270 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf3.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ec7cfd4f52b1..3d56a83db284 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1534,6 +1534,13 @@ config GPIO_MLXBF2
 	help
 	  Say Y here if you want GPIO support on Mellanox BlueField 2 SoC.
 
+config GPIO_MLXBF3
+	tristate "Mellanox BlueField 3 SoC GPIO"
+	depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || (64BIT && COMPILE_TEST)
+	select GPIO_GENERIC
+	help
+	  Say Y here if you want GPIO support on Mellanox BlueField 3 SoC.
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
index 000000000000..ddd27c316035
--- /dev/null
+++ b/drivers/gpio/gpio-mlxbf3.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
+
+/*
+ * Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES
+ */
+
+#include <linux/acpi.h>
+#include <linux/gpio/driver.h>
+#include <linux/platform_device.h>
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
+	struct irq_chip irq_chip;
+
+	/* YU GPIO block address */
+	void __iomem *gpio_io;
+
+	/* YU GPIO cause block address */
+	void __iomem *gpio_cause_io;
+
+	/* Mask of valid gpios that can be accessed by software */
+	unsigned int valid_mask;
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
+		generic_handle_irq(irq_find_mapping(gc->irq.domain, level));
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
+	bool fall = false;
+	bool rise = false;
+	u32 val;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_BOTH:
+		fall = true;
+		rise = true;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		rise = true;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		fall = true;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+	if (fall) {
+		val = readl(gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
+		val |= BIT(offset);
+		writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_FALL_EN);
+	}
+
+	if (rise) {
+		val = readl(gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
+		val |= BIT(offset);
+		writel(val, gs->gpio_io + MLXBF_GPIO_CAUSE_RISE_EN);
+	}
+	raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+
+	return 0;
+}
+
+static int mlxbf3_gpio_init_valid_mask(struct gpio_chip *gc,
+				       unsigned long *valid_mask,
+				       unsigned int ngpios)
+{
+	struct mlxbf3_gpio_context *gs = gpiochip_get_data(gc);
+
+	*valid_mask = gs->valid_mask;
+
+	return 0;
+}
+
+static int
+mlxbf3_gpio_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mlxbf3_gpio_context *gs;
+	unsigned int npins, valid_mask;
+	struct gpio_irq_chip *girq;
+	struct gpio_chip *gc;
+	struct resource *res;
+	const char *name;
+	int ret, irq;
+
+	name = dev_name(dev);
+
+	gs = devm_kzalloc(dev, sizeof(*gs), GFP_KERNEL);
+	if (!gs)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	/* Resource shared with pinctrl driver */
+	gs->gpio_io = devm_ioremap(dev, res->start, resource_size(res));
+	if (!gs->gpio_io)
+		return -ENOMEM;
+
+	/* YU GPIO block address */
+	gs->gpio_cause_io = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(gs->gpio_cause_io))
+		return PTR_ERR(gs->gpio_cause_io);
+
+	if (device_property_read_u32(dev, "npins", &npins))
+		npins = MLXBF3_GPIO_MAX_PINS_PER_BLOCK;
+
+	if (device_property_read_u32(dev, "valid_mask", &valid_mask))
+		valid_mask = 0x0;
+
+	gs->valid_mask = valid_mask;
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
+	gc->init_valid_mask = mlxbf3_gpio_init_valid_mask;
+
+	gc->ngpio = npins;
+	gc->owner = THIS_MODULE;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq >= 0) {
+		gs->irq_chip.name = name;
+		gs->irq_chip.irq_set_type = mlxbf3_gpio_irq_set_type;
+		gs->irq_chip.irq_enable = mlxbf3_gpio_irq_enable;
+		gs->irq_chip.irq_disable = mlxbf3_gpio_irq_disable;
+
+		girq = &gs->gc.irq;
+		girq->chip = &gs->irq_chip;
+		girq->handler = handle_simple_irq;
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
+				       IRQF_SHARED, name, gs);
+		if (ret) {
+			dev_err(dev, "failed to request IRQ");
+			return ret;
+		}
+	}
+
+	platform_set_drvdata(pdev, gs);
+
+	ret = devm_gpiochip_add_data(dev, &gs->gc, gs);
+	if (ret) {
+		dev_err(dev, "Failed adding memory mapped gpiochip\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct acpi_device_id __maybe_unused mlxbf3_gpio_acpi_match[] = {
+	{ "MLNXBF33", 0 },
+	{},
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
+
+module_platform_driver(mlxbf3_gpio_driver);
+
+MODULE_DESCRIPTION("NVIDIA BlueField-3 GPIO Driver");
+MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.1

