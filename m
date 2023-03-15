Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94366BBF6E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjCOVu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjCOVuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:50:52 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08765B43B;
        Wed, 15 Mar 2023 14:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaTpZ6IG3PT0uUqKlhQVxvRDWOG4xBpLyZciPx/xd5icRqwNx84lPzNba9s8Zt/LNEGFD/FlAy9OS+qOEFkeW6nO8+X5LzSJ1Bkt6FNCvAHLQvxI4CiUUSlm4zJSuSV6uC4HQafko6Dup+50YqFzacSkZJb1omOeRMmGFgZD8+yKNaN9PsgBUspMyh0ALoVJHeakvzLrK51sDYBWqryRp8JBitbEIkc8ohaf4yP1++V3xTZyFGZRdYYkYsdnMnKnui8aviM99kTnjziwM2R1KTxIylYlUNpNWMgrLVCHTW3Ae6x+aqcE84BnLv3us2VzTr6IxYj/3kQNSw7mLQHjBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0UGZovqQkvrD2MYMKUqhHU6bNsC4oA10F1EmCSHlzg=;
 b=eS4W23GxNbfHS+KPkH37hlq5g28fL92uxHVkA2PrJQ/1Rrt63OnkXrvJl2nmCwZ1RRtF5A/UB2GdBAmP3F8sqMShQFLUpctLqpr8ld/enVq6aBtoXUMKFdctQhbWPhzpT+QdiAw1i///J4+T57S1+wQCRPV7Z4T6Wj8cDxsA0lFEMoXoj7hksGsaedMjFwBjMf/npThZPFdcUIaAjFBJIxmus/wmxgCtbB0hEfYckxHh56fhNxh5Fj0UOoDpYC0fdHmrtMtFKsnvp13GRMXpbiB25qHb+x1M2yIipkKz07BxY55O5YMeE0XnKYMjz+baBfI9aXYBErBTapZWG5nwTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0UGZovqQkvrD2MYMKUqhHU6bNsC4oA10F1EmCSHlzg=;
 b=aa5Z5Sr6PnGrHInrunqFs/hmTMEKA1fHbN3PcnTINjZyRR0yzCX2Y8mrVP47c8ZCW4gTRr+9nlkvF274ry2b9YormheLTNZ+hKWQP2NxrwDMuvi5NPs4+Najt2oZa1lzkjuyPLXD9moIoAEnKucf56Xpml38Y6oapvnAMQB7IPb3424OpkdKr0dIWl5qse3w0MLlCUKOm8uBeUq0oHh6EXEPGNSQlXPO9JNpMqi/Kfju/5/cqYTY5MQb47UIFBOBDKTHOGHcuWppascj2BDRBXuEos/CWqiKyDgpC8M1zGLwqQRF//C61BI/rkR9staFaK7+bJc6XxQOR8stJguq6w==
Received: from BLAPR03CA0160.namprd03.prod.outlook.com (2603:10b6:208:32f::25)
 by BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 21:50:45 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::8a) by BLAPR03CA0160.outlook.office365.com
 (2603:10b6:208:32f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29 via Frontend
 Transport; Wed, 15 Mar 2023 21:50:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.12 via Frontend Transport; Wed, 15 Mar 2023 21:50:44 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 15 Mar 2023
 14:50:33 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 15 Mar 2023 14:50:33 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 15 Mar 2023 14:50:32 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v6 1/2] gpio: mlxbf3: Add gpio driver support
Date:   Wed, 15 Mar 2023 17:50:26 -0400
Message-ID: <20230315215027.30685-2-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230315215027.30685-1-asmaa@nvidia.com>
References: <20230315215027.30685-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|BL1PR12MB5286:EE_
X-MS-Office365-Filtering-Correlation-Id: 49888f77-721b-4577-0863-08db259f5487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IMCkgf8upiaMsHBj8VHTSTR/L5mILnfvyox3CEyp3s0jzW5vL4nmJp/swFIWiX+UmhV+1lJFEepVEQx3kNvPCe6H1rnMlgmZmtO1KOsOrgY4PTEVyu/H12g5y6hvwJXgA4DcwMFGow8aCCoJclDBzvoQ16XvvrJxPf7b+AXp3e4/G629DPYeMKKKIfJcqwThNmDqWJKIdDwDp6pq9ClIrh55O/o3gMxb+DrS9s0KNVO80QEHFuhwLDuRMo5znfeAVuSN4Qd3f7eO3Rp9rtUanZXVCGIJqfwNkbsIsQ5WBPpAX9nSGunpTHRzPMy4gVHMWyHoRwziSp1eSmadnC+hX0ozBVRxblRjTRzzsIYjDaxEPsAD30nryd/5GlGpTFCWon4c70x/CY+iTu+YXrueQjqPJP2o4C46qCiGERkW9dk7Z74hcNl5DByTBtdXGyFOFA8w/Ixv+IJg9+XvbO2hLFd1XR97Yoj0+HF74GGZP51HjBKpGH/QTFawFK8tXxkzpK65S0QTK03O/xxOgjolI+CFDzh33eRpHDpw4UuwfGCkDX/bZoavdRIgMfx+MCCy96ua841IQNLu3V6WIiM74YHqKmt4iPOr01THdf3XT6fjynWRGOdqkUuz8VT+747PuTO1a7FGxQK6QY/RWymOzku1ZtKCX9WdbyPtOEKKHXnpyQfbNZgjosTHwd3VongVKLf1Nw60nNSeAuMd+T0bYs0deMykM5BQGinoYOOJDTJMk6Zt7DH95xRJCn5zogjr
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199018)(46966006)(36840700001)(40470700004)(8936002)(5660300002)(41300700001)(4326008)(36860700001)(82310400005)(356005)(40480700001)(86362001)(36756003)(40460700003)(82740400003)(7636003)(2906002)(26005)(2616005)(336012)(478600001)(186003)(107886003)(83380400001)(6666004)(1076003)(7696005)(47076005)(426003)(8676002)(70206006)(316002)(110136005)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 21:50:44.6063
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49888f77-721b-4577-0863-08db259f5487
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/gpio/gpio-mlxbf3.c | 248 +++++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf3.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index ec7cfd4f52b1..beec1f6c34ff 100644
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
+	  This controller should be used in parallel with pinctrl-mlxbf3 to
+	  control the desired GPIOs.
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
index 000000000000..e30cee108986
--- /dev/null
+++ b/drivers/gpio/gpio-mlxbf3.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
+/* Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
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
+	gpiochip_enable_irq(gc, offset);
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
+	irq_hw_number_t offset = irqd_to_hwirq(irqd);
+	unsigned long flags;
+	u32 val;
+
+	raw_spin_lock_irqsave(&gs->gc.bgpio_lock, flags);
+	val = readl(gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
+	val &= ~BIT(offset);
+	writel(val, gs->gpio_cause_io + MLXBF_GPIO_CAUSE_OR_EVTEN0);
+	raw_spin_unlock_irqrestore(&gs->gc.bgpio_lock, flags);
+
+	gpiochip_disable_irq(gc, offset);
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
+/* This function needs to be defined for handle_edge_irq() */
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
+static const struct acpi_device_id mlxbf3_gpio_acpi_match[] = {
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

