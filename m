Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C5C6BBF71
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjCOVvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232511AbjCOVu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:50:57 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E30859E45;
        Wed, 15 Mar 2023 14:50:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MftMIKr5UbbaZpMXQ4Jb421eDhaEPdYoN/6AX38ZevZRKRujflO+WymKCBLi+2l2SbZd9GJtiutsyhm9+SFvxuUXpi57DzPPACE/VpfYobh51/7+CWTdIU5rQiWdku6mbbCFFt/7I6pf1pPlmuZiL4qLKn/ejf2aj96Fpoe8FORT8ZnOt19JzWGN42z0GYYRzWu1vdKdRzDZAXwbhr+D7wTMvmsaFJDzVW42kYEVqdaLIOlYiJxM5dpEbsf/L9Q8Vwt79ZeaQH7Go0Qof5pTuTEPgymeHCma5aBerLFvUVUjy76s5+X6nChJdYku2/2aY2hl9PwPw2mdb1ox/G0ABg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bEtRwvvc/yv72CsKz1nOEpYTl6lFgy1CKKhkVqm/DF4=;
 b=SIvKBFAE7oMZmXRbU9Nwh0FrggEk9fIhD32TxyQ/z0512LX9vxrftAL639pyO9mLshLc3kC2K5NiETrgISfpRtAxnuRRYQPC85i02TGPTtiSvan7+TF4E1ehk/hOgtK01lisUh49hoAdlmmxGhz170CpUWHDA8CndR9hp/7r9oQ5NePOg9VMPosHPv5qd2Iwby3OMyEqn2pxe19SwYX3CjpqjqSgIM2WrCQE5oAePp2BJf8S59dwzWvlogn/9iP7fPO6ozxyg9otVjdGntx/ucJv14MBo6dqLacvQV0ogB76Tjo8mDGRfiNP/ZC0KdMFvx4aWIL1hEOQ27jInY+Qag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bEtRwvvc/yv72CsKz1nOEpYTl6lFgy1CKKhkVqm/DF4=;
 b=duMV+jAA0/Bmzke+YE+/l8Gjk6p1F3wXTlf3uZ+OUhoR0lgrMlJXTziidtKY5iah9hdgYLYR4BeQif/RsVDHED0++pyGGbeZpfuFc+gls6pp1bx6c//auXjF+e1czawYY1qjTHU9QF9bM/E7jyc4zmQV9vZn6Ra9wgpjvgs2W+guyCw6ohfJBzNlL08HidiraVxB9B44El2KPFxoI4CgQMdGeWoCQor/1AtSiuT96LL48KS8i1Sh+fMnygaEpOasM5u7tuBWeRmTOUqFKhX6X0tq8Qmfr13GjQMX9ltScG/rmyH0hWVsljH2FnddtMjXmPualnQyOUB+GKpFKGaS/g==
Received: from DM6PR03CA0077.namprd03.prod.outlook.com (2603:10b6:5:333::10)
 by IA0PR12MB8715.namprd12.prod.outlook.com (2603:10b6:208:487::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29; Wed, 15 Mar
 2023 21:50:46 +0000
Received: from CY4PEPF0000C985.namprd02.prod.outlook.com
 (2603:10b6:5:333:cafe::2c) by DM6PR03CA0077.outlook.office365.com
 (2603:10b6:5:333::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.29 via Frontend
 Transport; Wed, 15 Mar 2023 21:50:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000C985.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Wed, 15 Mar 2023 21:50:46 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 15 Mar 2023
 14:50:36 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 15 Mar 2023 14:50:36 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.5 via Frontend
 Transport; Wed, 15 Mar 2023 14:50:35 -0700
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <andy.shevchenko@gmail.com>, <linus.walleij@linaro.org>,
        <bgolaszewski@baylibre.com>, <niyas.sait@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v6 2/2] pinctrl: mlxbf3: Add pinctrl driver support
Date:   Wed, 15 Mar 2023 17:50:27 -0400
Message-ID: <20230315215027.30685-3-asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20230315215027.30685-1-asmaa@nvidia.com>
References: <20230315215027.30685-1-asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C985:EE_|IA0PR12MB8715:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9cbcf9-840c-4f4b-f928-08db259f5545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADCNbuLREDoMIdvllPYOgcuBu9LXZfA0csh4p6Y3464c0Nr9BBarrYfh000hUdywlOvp8MaDZHF1oh/7V754LODElpXzqaCnoCg7ULbvVWLuwQ6iJCoseO6tGGhXSCpKB+CXuFdvhIqwQ4VZD+PIZMyPT0xdHk9FdBKdIad6saaGQYjZ4e+uC+lMwLiNvkTtuXuiEm+EnPVBnyASW4Mn69d+5FgYF9o7ovXYqJCbWy88WgganejIL2I/w5qK5EehlnBGhQARVL3RNbMo3RH1HELF8+CH/qZD+ryVmpG8HeaK4gTTfX70vwqvu39NRkk3DvoOkmIIXhIee5vMGHvdBoOrC/AYQrzeQFo8+7QdUNP/XqU2HzZoDogUG/bYJ7QwIefYKeBXqowmxGKvKexGt+d2657zHv8hiv+7PN1mEzmQYTNFqRcvoSdk5XuB3ot00YUoDcGHqlPsrYiyosRxplWp9y+9ygPoWv+O//q/GJsAQhfzLg2/C0WYcg8ORFYT7GdZzwqWLgfoIIUhkBpcb7NJW/Vl/URwp2ECiYw0ajA7ilodOt2FgfFT9IxoEWbAatSebBd8l/rts0ZmXAOQPThe/7EL8lrNAAGj2rbXpNy/72TcEWtMLeiNpe97QofnsdIlwD4kbLBHqSYCPpaGeroSBaP8AI70gALTqSim0WcekyxswwgGbAdgEc7KJLlqFJv8ez2vlp6Ge9o/d2XDcRwFEO+CUSaE8dO5cbCdFL+piyBAkUd9Zk5G3r/VR+CN
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(26005)(30864003)(478600001)(70206006)(316002)(8676002)(70586007)(110136005)(41300700001)(5660300002)(4326008)(8936002)(186003)(356005)(86362001)(36756003)(40460700003)(336012)(7696005)(1076003)(7636003)(40480700001)(6666004)(107886003)(426003)(47076005)(2616005)(82740400003)(2906002)(82310400005)(83380400001)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 21:50:46.2639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9cbcf9-840c-4f4b-f928-08db259f5545
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C985.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8715
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA BlueField-3 SoC has a few pins that can be used as GPIOs
or take the default hardware functionality. Add a driver for
the pin muxing.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/pinctrl/Kconfig          |  13 ++
 drivers/pinctrl/Makefile         |   1 +
 drivers/pinctrl/pinctrl-mlxbf3.c | 320 +++++++++++++++++++++++++++++++
 3 files changed, 334 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-mlxbf3.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 7d5f5458c72e..9009bc6adbea 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -523,6 +523,19 @@ config PINCTRL_ZYNQMP
 	  This driver can also be built as a module. If so, the module
 	  will be called pinctrl-zynqmp.
 
+config PINCTRL_MLXBF3
+	tristate "NVIDIA BlueField-3 SoC Pinctrl driver"
+	depends on (MELLANOX_PLATFORM && ARM64) || COMPILE_TEST
+	select PINMUX
+	select GPIOLIB
+	select GPIOLIB_IRQCHIP
+	select GPIO_MLXBF3
+	help
+	  Say Y to select the pinctrl driver for BlueField-3 SoCs.
+	  This pin controller allows selecting the mux function for
+	  each pin. This driver can also be built as a module called
+	  pinctrl-mlxbf3.
+
 source "drivers/pinctrl/actions/Kconfig"
 source "drivers/pinctrl/aspeed/Kconfig"
 source "drivers/pinctrl/bcm/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index d5939840bb2a..10dd072e8423 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_PINCTRL_MCP23S08_I2C)	+= pinctrl-mcp23s08_i2c.o
 obj-$(CONFIG_PINCTRL_MCP23S08_SPI)	+= pinctrl-mcp23s08_spi.o
 obj-$(CONFIG_PINCTRL_MCP23S08)	+= pinctrl-mcp23s08.o
 obj-$(CONFIG_PINCTRL_MICROCHIP_SGPIO)	+= pinctrl-microchip-sgpio.o
+obj-$(CONFIG_PINCTRL_MLXBF3)	+= pinctrl-mlxbf3.o
 obj-$(CONFIG_PINCTRL_OCELOT)	+= pinctrl-ocelot.o
 obj-$(CONFIG_PINCTRL_OXNAS)	+= pinctrl-oxnas.o
 obj-$(CONFIG_PINCTRL_PALMAS)	+= pinctrl-palmas.o
diff --git a/drivers/pinctrl/pinctrl-mlxbf3.c b/drivers/pinctrl/pinctrl-mlxbf3.c
new file mode 100644
index 000000000000..3698f7bbd88d
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-mlxbf3.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
+/* Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#define MLXBF3_NGPIOS_GPIO0    32
+#define MLXBF3_MAX_GPIO_PINS   56
+
+enum {
+	MLXBF3_GPIO_HW_MODE,
+	MLXBF3_GPIO_SW_MODE,
+};
+
+struct mlxbf3_pinctrl {
+	void __iomem *fw_ctrl_set0;
+	void __iomem *fw_ctrl_clr0;
+	void __iomem *fw_ctrl_set1;
+	void __iomem *fw_ctrl_clr1;
+	struct device *dev;
+	struct pinctrl_dev *pctl;
+	struct pinctrl_gpio_range gpio_range;
+};
+
+#define MLXBF3_GPIO_RANGE(_id, _pinbase, _gpiobase, _npins)	\
+	{							\
+		.name = "mlxbf3_gpio_range",			\
+		.id = _id,					\
+		.base = _gpiobase,				\
+		.pin_base = _pinbase,				\
+		.npins = _npins,				\
+	}
+
+static struct pinctrl_gpio_range mlxbf3_pinctrl_gpio_ranges[] = {
+	MLXBF3_GPIO_RANGE(0, 0,  480, 32),
+	MLXBF3_GPIO_RANGE(1,  32, 456, 24),
+};
+
+static const struct pinctrl_pin_desc mlxbf3_pins[] = {
+	PINCTRL_PIN(0, "gpio0"),
+	PINCTRL_PIN(1, "gpio1"),
+	PINCTRL_PIN(2, "gpio2"),
+	PINCTRL_PIN(3, "gpio3"),
+	PINCTRL_PIN(4, "gpio4"),
+	PINCTRL_PIN(5, "gpio5"),
+	PINCTRL_PIN(6, "gpio6"),
+	PINCTRL_PIN(7, "gpio7"),
+	PINCTRL_PIN(8, "gpio8"),
+	PINCTRL_PIN(9, "gpio9"),
+	PINCTRL_PIN(10, "gpio10"),
+	PINCTRL_PIN(11, "gpio11"),
+	PINCTRL_PIN(12, "gpio12"),
+	PINCTRL_PIN(13, "gpio13"),
+	PINCTRL_PIN(14, "gpio14"),
+	PINCTRL_PIN(15, "gpio15"),
+	PINCTRL_PIN(16, "gpio16"),
+	PINCTRL_PIN(17, "gpio17"),
+	PINCTRL_PIN(18, "gpio18"),
+	PINCTRL_PIN(19, "gpio19"),
+	PINCTRL_PIN(20, "gpio20"),
+	PINCTRL_PIN(21, "gpio21"),
+	PINCTRL_PIN(22, "gpio22"),
+	PINCTRL_PIN(23, "gpio23"),
+	PINCTRL_PIN(24, "gpio24"),
+	PINCTRL_PIN(25, "gpio25"),
+	PINCTRL_PIN(26, "gpio26"),
+	PINCTRL_PIN(27, "gpio27"),
+	PINCTRL_PIN(28, "gpio28"),
+	PINCTRL_PIN(29, "gpio29"),
+	PINCTRL_PIN(30, "gpio30"),
+	PINCTRL_PIN(31, "gpio31"),
+	PINCTRL_PIN(32, "gpio32"),
+	PINCTRL_PIN(33, "gpio33"),
+	PINCTRL_PIN(34, "gpio34"),
+	PINCTRL_PIN(35, "gpio35"),
+	PINCTRL_PIN(36, "gpio36"),
+	PINCTRL_PIN(37, "gpio37"),
+	PINCTRL_PIN(38, "gpio38"),
+	PINCTRL_PIN(39, "gpio39"),
+	PINCTRL_PIN(40, "gpio40"),
+	PINCTRL_PIN(41, "gpio41"),
+	PINCTRL_PIN(42, "gpio42"),
+	PINCTRL_PIN(43, "gpio43"),
+	PINCTRL_PIN(44, "gpio44"),
+	PINCTRL_PIN(45, "gpio45"),
+	PINCTRL_PIN(46, "gpio46"),
+	PINCTRL_PIN(47, "gpio47"),
+	PINCTRL_PIN(48, "gpio48"),
+	PINCTRL_PIN(49, "gpio49"),
+	PINCTRL_PIN(50, "gpio50"),
+	PINCTRL_PIN(51, "gpio51"),
+	PINCTRL_PIN(52, "gpio52"),
+	PINCTRL_PIN(53, "gpio53"),
+	PINCTRL_PIN(54, "gpio54"),
+	PINCTRL_PIN(55, "gpio55"),
+};
+
+/*
+ * All single-pin functions can be mapped to any GPIO, however pinmux applies
+ * functions to pin groups and only those groups declared as supporting that
+ * function. To make this work we must put each pin in its own dummy group so
+ * that the functions can be described as applying to all pins.
+ * We use the same name as in the datasheet.
+ */
+static const char * const mlxbf3_pinctrl_single_group_names[] = {
+	"gpio0", "gpio1",  "gpio2",  "gpio3",  "gpio4",  "gpio5",  "gpio6", "gpio7",
+	"gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13", "gpio14", "gpio15",
+	"gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21", "gpio22", "gpio23",
+	"gpio24", "gpio25", "gpio26", "gpio27", "gpio28", "gpio29", "gpio30", "gpio31",
+	"gpio32", "gpio33", "gpio34", "gpio35", "gpio36", "gpio37", "gpio38", "gpio39",
+	"gpio40", "gpio41", "gpio42", "gpio43", "gpio44", "gpio45", "gpio46", "gpio47",
+	"gpio48", "gpio49", "gpio50", "gpio51", "gpio52", "gpio53", "gpio54", "gpio55",
+};
+
+static int mlxbf3_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	/* Number single-pin groups */
+	return MLXBF3_MAX_GPIO_PINS;
+}
+
+static const char *mlxbf3_get_group_name(struct pinctrl_dev *pctldev,
+					 unsigned int selector)
+{
+	return mlxbf3_pinctrl_single_group_names[selector];
+}
+
+static int mlxbf3_get_group_pins(struct pinctrl_dev *pctldev,
+				 unsigned int selector,
+				 const unsigned int **pins,
+				 unsigned int *num_pins)
+{
+	/* return the dummy group for a single pin */
+	*pins = &selector;
+	*num_pins = 1;
+
+	return 0;
+}
+
+static const struct pinctrl_ops mlxbf3_pinctrl_group_ops = {
+	.get_groups_count = mlxbf3_get_groups_count,
+	.get_group_name = mlxbf3_get_group_name,
+	.get_group_pins = mlxbf3_get_group_pins,
+};
+
+/*
+ * Only 2 functions are supported and they apply to all pins:
+ * 1) Default hardware functionality
+ * 2) Software controlled GPIO
+ */
+static const char * const mlxbf3_gpiofunc_group_names[] = { "swctrl" };
+static const char * const mlxbf3_hwfunc_group_names[]   = { "hwctrl" };
+
+struct pinfunction mlxbf3_pmx_funcs[] = {
+	PINCTRL_PINFUNCTION("hwfunc", mlxbf3_hwfunc_group_names, 1),
+	PINCTRL_PINFUNCTION("gpiofunc", mlxbf3_gpiofunc_group_names, 1),
+};
+
+static int mlxbf3_pmx_get_funcs_count(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(mlxbf3_pmx_funcs);
+}
+
+static const char *mlxbf3_pmx_get_func_name(struct pinctrl_dev *pctldev,
+					   unsigned int selector)
+{
+	return mlxbf3_pmx_funcs[selector].name;
+}
+
+static int mlxbf3_pmx_get_groups(struct pinctrl_dev *pctldev,
+				 unsigned int selector,
+				 const char * const **groups,
+				 unsigned int * const num_groups)
+{
+	*groups = mlxbf3_pmx_funcs[selector].groups;
+	*num_groups = MLXBF3_MAX_GPIO_PINS;
+
+	return 0;
+}
+
+static int mlxbf3_pmx_set(struct pinctrl_dev *pctldev,
+			      unsigned int selector,
+			      unsigned int group)
+{
+	struct mlxbf3_pinctrl *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	if (selector == MLXBF3_GPIO_HW_MODE) {
+		if (group < MLXBF3_NGPIOS_GPIO0)
+			writel(BIT(group), priv->fw_ctrl_clr0);
+		else
+			writel(BIT(group % MLXBF3_NGPIOS_GPIO0), priv->fw_ctrl_clr1);
+	}
+
+	if (selector == MLXBF3_GPIO_SW_MODE) {
+		if (group < MLXBF3_NGPIOS_GPIO0)
+			writel(BIT(group), priv->fw_ctrl_set0);
+		else
+			writel(BIT(group % MLXBF3_NGPIOS_GPIO0), priv->fw_ctrl_set1);
+	}
+
+	return 0;
+}
+
+static int mlxbf3_gpio_request_enable(struct pinctrl_dev *pctldev,
+				     struct pinctrl_gpio_range *range,
+				     unsigned int offset)
+{
+	struct mlxbf3_pinctrl *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	if (offset < MLXBF3_NGPIOS_GPIO0)
+		writel(BIT(offset), priv->fw_ctrl_set0);
+	else
+		writel(BIT(offset % MLXBF3_NGPIOS_GPIO0), priv->fw_ctrl_set1);
+
+	return 0;
+}
+
+static void mlxbf3_gpio_disable_free(struct pinctrl_dev *pctldev,
+				    struct pinctrl_gpio_range *range,
+				    unsigned int offset)
+{
+	struct mlxbf3_pinctrl *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	/* disable GPIO functionality by giving control back to hardware */
+	if (offset < MLXBF3_NGPIOS_GPIO0)
+		writel(BIT(offset), priv->fw_ctrl_clr0);
+	else
+		writel(BIT(offset % MLXBF3_NGPIOS_GPIO0), priv->fw_ctrl_clr1);
+}
+
+static const struct pinmux_ops mlxbf3_pmx_ops = {
+	.get_functions_count = mlxbf3_pmx_get_funcs_count,
+	.get_function_name = mlxbf3_pmx_get_func_name,
+	.get_function_groups = mlxbf3_pmx_get_groups,
+	.set_mux = mlxbf3_pmx_set,
+	.gpio_request_enable = mlxbf3_gpio_request_enable,
+	.gpio_disable_free = mlxbf3_gpio_disable_free,
+};
+
+static struct pinctrl_desc mlxbf3_pin_desc = {
+	.name = "pinctrl-mlxbf3",
+	.pins = mlxbf3_pins,
+	.npins = ARRAY_SIZE(mlxbf3_pins),
+	.pctlops = &mlxbf3_pinctrl_group_ops,
+	.pmxops = &mlxbf3_pmx_ops,
+	.owner = THIS_MODULE,
+};
+
+static_assert(ARRAY_SIZE(mlxbf3_pinctrl_single_group_names) == MLXBF3_MAX_GPIO_PINS);
+
+static int mlxbf3_pinctrl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mlxbf3_pinctrl *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+
+	priv->fw_ctrl_set0 = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->fw_ctrl_set0))
+		return PTR_ERR(priv->fw_ctrl_set0);
+
+	priv->fw_ctrl_clr0 = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(priv->fw_ctrl_set0))
+		return PTR_ERR(priv->fw_ctrl_set0);
+
+	priv->fw_ctrl_set1 = devm_platform_ioremap_resource(pdev, 2);
+	if (IS_ERR(priv->fw_ctrl_set0))
+		return PTR_ERR(priv->fw_ctrl_set0);
+
+	priv->fw_ctrl_clr1 = devm_platform_ioremap_resource(pdev, 3);
+	if (IS_ERR(priv->fw_ctrl_set0))
+		return PTR_ERR(priv->fw_ctrl_set0);
+
+	ret = devm_pinctrl_register_and_init(dev,
+					     &mlxbf3_pin_desc,
+					     priv,
+					     &priv->pctl);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register pinctrl\n");
+
+	ret = pinctrl_enable(priv->pctl);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable pinctrl\n");
+
+	pinctrl_add_gpio_ranges(priv->pctl, mlxbf3_pinctrl_gpio_ranges, 2);
+
+	return 0;
+}
+
+static const struct acpi_device_id mlxbf3_pinctrl_acpi_ids[] = {
+	{ "MLNXBF34", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, mlxbf3_pinctrl_acpi_ids);
+
+static struct platform_driver mlxbf3_pinctrl_driver = {
+	.driver = {
+		.name = "pinctrl-mlxbf3",
+		.acpi_match_table = mlxbf3_pinctrl_acpi_ids,
+	},
+	.probe = mlxbf3_pinctrl_probe,
+};
+module_platform_driver(mlxbf3_pinctrl_driver);
+
+MODULE_DESCRIPTION("NVIDIA pinctrl driver");
+MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.1

