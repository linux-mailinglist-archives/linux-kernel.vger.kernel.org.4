Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A34E692272
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjBJPkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232835AbjBJPkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:40:15 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC16878D5D;
        Fri, 10 Feb 2023 07:39:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g89oUYJbBvlZbS5483lNREAlnOCexTjl+yiI+ZFYizavj4mMflKok+WfLblqMvbzbe2Cxj1mTPQXyYbBeNQ5pYc46XBvAPtn4mAzV0gq8S9Zd0GGA667gEYWgi7OHz9GiPe7OLuIAqPOpmFt4oD0/tylzlpvizL4pB8QFaiHBlVDA/Z0nPQ/L0tLbkDdkpCuB0xAw2khRPg5kJI9krVAaD1L7JCXwxJRseuVUpt4o1Jfj1NhekkhKdC94WlMHGXX3BmS5p6O1W6KCaQTA/TlHfqhQ+Cu2vkjFKcpFsE8Dw1VVbtV7kBHLPgpnOl2bjpCNJPNK9bXPl9v1QEa6b4mmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDP5igdxEu0k/3Vnrn/qaGRTa9O88UGRBzFszvTXeqU=;
 b=f13KrIdQvQwb1dBGFJhkyqPR+bU0IW4NPmMTrRNdP6oSLLTT/8ya+DH+mNZi+7pMi25yMfAjr8yeXDpirYVfwyNdBzKkg5pbduBDKzi6DRH9rERNA16Fu2PE4WbHzeTMrpmmVTMc1g7phoVLIiFZALVzdG+y1T3yS/9grHIKEmzDGb1uw7tIJFdVuAdZP17de9eHLn3CC9QDcOVL/bW0ilmIeAlPgZdcuWDcLli4LOfwJ5kF1jNw2Wb+FLSIxE6lzu/9TjmtcElbFzZeEBwecqXu96hoe5RdsLeBMtDPtx87IQtbp89uafetEJQ+gpXdS4A9T8bTK0xVWoS1Hn8zSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDP5igdxEu0k/3Vnrn/qaGRTa9O88UGRBzFszvTXeqU=;
 b=NoYmTq6JiVPaqYwchb8eEERN2T422dbHbObc5vykFCeYOgVZKfLO7t9y4ETHW7L8F9zSonGbI3HQqMB8sEkpXNpbdzSddquJcU2Vmzs/+wbDwgQ62TDplPNQwyr0YPsFMtYpJ7Z4ozRQKong7z72J77P2Ye+IK7O+4fUMK/HgyfzeX+cVJjRGF0eZyyrY+nYETpHX6fKSWHCiSPC8KeAroJaXyHa4ObEggFlBJhJTo/eN3CYIag7mfYFEtv9n7egikrtXu+X4E3PsMxg+TrOHQoHbRwYSzfV3BncGQR7WNjXD+GnTzEQM+2ihY/3BqX/rZMRIKw7Sao04P61yCwcBw==
Received: from BN9PR03CA0571.namprd03.prod.outlook.com (2603:10b6:408:10d::6)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Fri, 10 Feb
 2023 15:39:57 +0000
Received: from BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10d:cafe::59) by BN9PR03CA0571.outlook.office365.com
 (2603:10b6:408:10d::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.21 via Frontend
 Transport; Fri, 10 Feb 2023 15:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT043.mail.protection.outlook.com (10.13.177.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.21 via Frontend Transport; Fri, 10 Feb 2023 15:39:57 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 10 Feb
 2023 07:39:50 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Fri, 10 Feb 2023 07:39:49 -0800
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Fri, 10 Feb 2023 07:39:49 -0800
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     Asmaa Mnebhi <asmaa@nvidia.com>
Subject: [PATCH v3 2/2] Support NVIDIA BlueField-3 pinctrl driver
Date:   Fri, 10 Feb 2023 10:39:41 -0500
Message-ID: <acd85e20d3e8d45ce3254e6ffe5ad2b5039b1a34.1676042188.git.asmaa@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1676042188.git.asmaa@nvidia.com>
References: <cover.1676042188.git.asmaa@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT043:EE_|PH7PR12MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5eb5dd-2ceb-42ae-f775-08db0b7d1030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4J5k4MiFXG0hom1blZkbrgnR2lWztsDJOgc3fRUFom9mZsSSHECZO61tQJZYzpgPkVSg4h6ydk4HG+gTgKf6aDHifw/pnmmBnY6QKDGKQaXYzCnMDizeBFOhZv5JYx9sQLRm5xRqYvyVhJwwpG439oxPqYWKkWbGAPAdHOlx5eeS7GjMAPpSFv2ibrHnq075tbeRKMnMfW+ZnrrNRPHMLgUDEOzX8zQGMVcHtKJ6npa3sAMtLkVw3P+UUPlJslFmzzWY8TpSoeirIL1vMUM4jBZ7auczDPlc713TO8uQNnDkmT66E1uQMLH+xzKgGgeyJ3P5zyNSiz1qe93lvKoifnFDjE/KWB4AdSbHyBacd4PLnZbXA8tdNdlgQ/YM9kxr8l5lcc0H42Vnc5JWBn43XfxRxIZ2zeZdH+hB0u15wKKCod5SBKZaDn1WiqTxZycuy/W+dKl0PBNaZedM0mkTvdjk3+eLO7BGuytvMZGbsGbJ1R1w+r7Cux5k0CkY+A5zN8rVUvAl8c/TVF4HPYMqXLj6zdPZ3iM+03EXovh9x47ppzK/1oiEfJ8SUaC7H2o3ElkM7FTwxc7eozw7xBFuLFZ6CuOsl+THP9jyMcCHMKgsZvLEKc8g3ZI/HzH17p3Mb+kbgqarCn7A+ZwzQVYK0SvHgy1LdSYuhM72bIMpWMBdFadTmX2vX7GueBSjPKCPSmRf8VSR0OWFy2+XHslkw==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199018)(40470700004)(46966006)(36840700001)(336012)(2616005)(450100002)(70586007)(70206006)(41300700001)(4326008)(186003)(26005)(8676002)(8936002)(107886003)(6666004)(316002)(86362001)(478600001)(2906002)(83380400001)(7696005)(110136005)(36756003)(47076005)(5660300002)(82310400005)(40460700003)(356005)(40480700001)(426003)(30864003)(82740400003)(7636003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 15:39:57.1644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5eb5dd-2ceb-42ae-f775-08db0b7d1030
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to the BlueField-3 SoC pin controller.
It allows muxing individual GPIOs to switch from the default
hardware mode to software controlled mode.

Signed-off-by: Asmaa Mnebhi <asmaa@nvidia.com>
---
 drivers/pinctrl/Kconfig         |  10 +
 drivers/pinctrl/Makefile        |   1 +
 drivers/pinctrl/pinctrl-mlxbf.c | 341 ++++++++++++++++++++++++++++++++
 3 files changed, 352 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-mlxbf.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 7d5f5458c72e..7040d79a757a 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -523,6 +523,16 @@ config PINCTRL_ZYNQMP
 	  This driver can also be built as a module. If so, the module
 	  will be called pinctrl-zynqmp.
 
+config PINCTRL_MLXBF
+	tristate "NVIDIA BlueField-3 SoC Pinctrl driver"
+	depends on (MELLANOX_PLATFORM && ARM64 && ACPI)
+	select PINMUX
+	select GPIOLIB
+	select GPIOLIB_IRQCHIP
+	select GPIO_MLXBF3
+	help
+	  This selects the pinctrl driver for BlueField-3 SoCs.
+
 source "drivers/pinctrl/actions/Kconfig"
 source "drivers/pinctrl/aspeed/Kconfig"
 source "drivers/pinctrl/bcm/Kconfig"
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index d5939840bb2a..67252469e76b 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_PINCTRL_MCP23S08_I2C)	+= pinctrl-mcp23s08_i2c.o
 obj-$(CONFIG_PINCTRL_MCP23S08_SPI)	+= pinctrl-mcp23s08_spi.o
 obj-$(CONFIG_PINCTRL_MCP23S08)	+= pinctrl-mcp23s08.o
 obj-$(CONFIG_PINCTRL_MICROCHIP_SGPIO)	+= pinctrl-microchip-sgpio.o
+obj-$(CONFIG_PINCTRL_MLXBF)	+= pinctrl-mlxbf.o
 obj-$(CONFIG_PINCTRL_OCELOT)	+= pinctrl-ocelot.o
 obj-$(CONFIG_PINCTRL_OXNAS)	+= pinctrl-oxnas.o
 obj-$(CONFIG_PINCTRL_PALMAS)	+= pinctrl-palmas.o
diff --git a/drivers/pinctrl/pinctrl-mlxbf.c b/drivers/pinctrl/pinctrl-mlxbf.c
new file mode 100644
index 000000000000..405e5a906ee4
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-mlxbf.c
@@ -0,0 +1,341 @@
+// SPDX-License-Identifier: GPL-2.0-only or BSD-3-Clause
+
+/*
+ * Copyright (C) 2022 NVIDIA CORPORATION & AFFILIATES
+ */
+
+#include <linux/acpi.h>
+#include <linux/platform_device.h>
+
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/pinctrl/pinmux.h>
+
+#define MLXBF_GPIO0_FW_CONTROL_SET   0
+#define MLXBF_GPIO0_FW_CONTROL_CLEAR 0x14
+#define MLXBF_GPIO1_FW_CONTROL_SET   0x80
+#define MLXBF_GPIO1_FW_CONTROL_CLEAR 0x94
+
+#define MLXBF_NGPIOS_GPIO0    32
+
+enum {
+	MLXBF_GPIO_HW_MODE,
+	MLXBF_GPIO_SW_MODE
+};
+
+struct mlxbf_pinctrl {
+	void __iomem *base;
+	struct device *dev;
+	struct pinctrl_dev *pctl;
+	struct pinctrl_gpio_range gpio_range;
+};
+
+#define MLXBF_GPIO_RANGE(_id, _pinbase, _gpiobase, _npins)	\
+	{							\
+		.name = "mlxbf_gpio_range",			\
+		.id = _id,					\
+		.base = _gpiobase,				\
+		.pin_base = _pinbase,				\
+		.npins = _npins,				\
+	}
+
+static struct pinctrl_gpio_range mlxbf_pinctrl_gpio_ranges[] = {
+	MLXBF_GPIO_RANGE(0, 0,  480, 32),
+	MLXBF_GPIO_RANGE(1,  32, 456, 24),
+};
+
+static const struct pinctrl_pin_desc mlxbf_pins[] = {
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
+static const char * const mlxbf_pinctrl_single_group_names[] = {
+	"gpio0", "gpio1",  "gpio2",  "gpio3",  "gpio4",  "gpio5",  "gpio6",
+	"gpio7", "gpio8",  "gpio9",  "gpio10", "gpio11", "gpio12", "gpio13",
+	"gpio14", "gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20",
+	"gpio21", "gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27",
+	"gpio28", "gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34",
+	"gpio35", "gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41",
+	"gpio42", "gpio43", "gpio44", "gpio45", "gpio46", "gpio47", "gpio48",
+	"gpio49", "gpio50", "gpio51", "gpio52", "gpio53", "gpio54", "gpio55"
+};
+
+/* Set of pin numbers for single-pin groups */
+static const unsigned int mlxbf_pinctrl_single_group_pins[] = {
+	0,  1,  2,  3,  4,  5,  6,
+	7,  8,  9, 10, 11, 12, 13,
+	14, 15, 16, 17, 18, 19, 20,
+	21, 22, 23, 24, 25, 26, 27,
+	28, 29, 30, 31, 32, 33, 34,
+	35, 36, 37, 38, 39, 40, 41,
+	42, 43, 44, 45, 46, 47, 48,
+	49, 50, 51, 52, 53, 54, 55,
+};
+
+static int mlxbf_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	/* Number single-pin groups */
+	return ARRAY_SIZE(mlxbf_pinctrl_single_group_pins);
+}
+
+static const char *mlxbf_get_group_name(struct pinctrl_dev *pctldev,
+					 unsigned int selector)
+{
+	return mlxbf_pinctrl_single_group_names[selector];
+}
+
+static int mlxbf_get_group_pins(struct pinctrl_dev *pctldev,
+				 unsigned int selector,
+				 const unsigned int **pins,
+				 unsigned int *num_pins)
+{
+	/* return the dummy group for a single pin */
+	*pins = &mlxbf_pinctrl_single_group_pins[selector];
+	*num_pins = 1;
+
+	return 0;
+}
+
+static const struct pinctrl_ops mlxbf_pinctrl_group_ops = {
+	.get_groups_count = mlxbf_get_groups_count,
+	.get_group_name = mlxbf_get_group_name,
+	.get_group_pins = mlxbf_get_group_pins,
+};
+
+static const char * const mlxbf_gpiofunc_group_names[] = { "swctrl" };
+static const char * const mlxbf_hwfunc_group_names[]   = { "hwctrl" };
+
+/*
+ * Only 2 functions are supported and they apply to all pins:
+ * 1) Default hardware functionality
+ * 2) Software controlled GPIO
+ */
+static const struct {
+	const char *name;
+	const char * const *group_names;
+} mlxbf_pmx_funcs[] = {
+	{
+		.name = "hwfunc",
+		.group_names = mlxbf_hwfunc_group_names
+	},
+	{
+		.name = "gpiofunc",
+		.group_names = mlxbf_gpiofunc_group_names
+	},
+};
+
+static int mlxbf_pmx_get_funcs_count(struct pinctrl_dev *pctldev)
+{
+	return ARRAY_SIZE(mlxbf_pmx_funcs);
+}
+
+static const char *mlxbf_pmx_get_func_name(struct pinctrl_dev *pctldev,
+					   unsigned int selector)
+{
+	return mlxbf_pmx_funcs[selector].name;
+}
+
+static int mlxbf_pmx_get_groups(struct pinctrl_dev *pctldev,
+				 unsigned int selector,
+				 const char * const **groups,
+				 unsigned int * const num_groups)
+{
+	*groups = mlxbf_pmx_funcs[selector].group_names;
+	*num_groups = ARRAY_SIZE(mlxbf_pinctrl_single_group_pins);
+
+	return 0;
+}
+
+static int mlxbf_pmx_set(struct pinctrl_dev *pctldev,
+			      unsigned int selector,
+			      unsigned int group)
+{
+	struct mlxbf_pinctrl *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	if (selector == MLXBF_GPIO_HW_MODE) {
+		if (group < MLXBF_NGPIOS_GPIO0)
+			writel(BIT(group), priv->base + MLXBF_GPIO0_FW_CONTROL_CLEAR);
+		else
+			writel(BIT(group % MLXBF_NGPIOS_GPIO0), priv->base + MLXBF_GPIO1_FW_CONTROL_CLEAR);
+	}
+
+	if (selector == MLXBF_GPIO_SW_MODE) {
+		if (group < MLXBF_NGPIOS_GPIO0)
+			writel(BIT(group), priv->base + MLXBF_GPIO0_FW_CONTROL_SET);
+		else
+			writel(BIT(group % MLXBF_NGPIOS_GPIO0), priv->base + MLXBF_GPIO1_FW_CONTROL_SET);
+	}
+
+	return 0;
+}
+
+static int mlxbf_gpio_request_enable(struct pinctrl_dev *pctldev,
+				     struct pinctrl_gpio_range *range,
+				     unsigned int offset)
+{
+	struct mlxbf_pinctrl *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	if (offset < MLXBF_NGPIOS_GPIO0)
+		writel(BIT(offset), priv->base + MLXBF_GPIO0_FW_CONTROL_SET);
+	else
+		writel(BIT(offset % MLXBF_NGPIOS_GPIO0), priv->base + MLXBF_GPIO1_FW_CONTROL_SET);
+
+	return 0;
+}
+
+static void mlxbf_gpio_disable_free(struct pinctrl_dev *pctldev,
+				    struct pinctrl_gpio_range *range,
+				    unsigned int offset)
+{
+	struct mlxbf_pinctrl *priv = pinctrl_dev_get_drvdata(pctldev);
+
+	/* disable GPIO functionality by giving control back to hardware */
+	if (offset < MLXBF_NGPIOS_GPIO0)
+		writel(BIT(offset), priv->base + MLXBF_GPIO0_FW_CONTROL_CLEAR);
+	else
+		writel(BIT(offset % MLXBF_NGPIOS_GPIO0), priv->base + MLXBF_GPIO1_FW_CONTROL_CLEAR);
+
+}
+
+static const struct pinmux_ops mlxbf_pmx_ops = {
+	.get_functions_count = mlxbf_pmx_get_funcs_count,
+	.get_function_name = mlxbf_pmx_get_func_name,
+	.get_function_groups = mlxbf_pmx_get_groups,
+	.set_mux = mlxbf_pmx_set,
+	.gpio_request_enable = mlxbf_gpio_request_enable,
+	.gpio_disable_free = mlxbf_gpio_disable_free,
+};
+
+static struct pinctrl_desc mlxbf_pin_desc = {
+	.name = "pinctrl-mlxbf",
+	.pins = mlxbf_pins,
+	.npins = ARRAY_SIZE(mlxbf_pins),
+	.pctlops = &mlxbf_pinctrl_group_ops,
+	.pmxops = &mlxbf_pmx_ops,
+	.owner = THIS_MODULE,
+};
+
+static int mlxbf_pinctrl_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mlxbf_pinctrl *priv;
+	struct resource *res;
+	int ret;
+
+	BUILD_BUG_ON(ARRAY_SIZE(mlxbf_pinctrl_single_group_names) !=
+		     ARRAY_SIZE(mlxbf_pinctrl_single_group_pins));
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	priv->base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!priv->base)
+		return -ENOMEM;
+
+	ret = devm_pinctrl_register_and_init(priv->dev,
+					     &mlxbf_pin_desc,
+					     priv,
+					     &priv->pctl);
+	if (ret) {
+		dev_err(priv->dev, "Failed pinctrl register (%d)\n", ret);
+		return ret;
+	}
+
+	ret = pinctrl_enable(priv->pctl);
+	if (ret) {
+		dev_err(priv->dev, "Failed to enable pinctrl (%d)\n", ret);
+		return ret;
+	}
+
+	pinctrl_add_gpio_range(priv->pctl, &mlxbf_pinctrl_gpio_ranges[0]);
+	pinctrl_add_gpio_range(priv->pctl, &mlxbf_pinctrl_gpio_ranges[1]);
+
+	return 0;
+}
+
+static const struct acpi_device_id mlxbf_pinctrl_acpi_ids[] = {
+	{ "MLNXBF34", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, mlxbf_pinctrl_acpi_ids);
+
+static struct platform_driver mlxbf_pinctrl_driver = {
+	.driver = {
+		.name = "pinctrl-mlxbf",
+		.acpi_match_table = mlxbf_pinctrl_acpi_ids,
+	},
+	.probe = mlxbf_pinctrl_probe,
+};
+
+module_platform_driver(mlxbf_pinctrl_driver);
+
+MODULE_DESCRIPTION("NVIDIA pinctrl driver");
+MODULE_AUTHOR("Asmaa Mnebhi <asmaa@nvidia.com>");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.1

