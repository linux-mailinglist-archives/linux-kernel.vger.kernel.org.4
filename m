Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA370638396
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 06:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiKYFnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 00:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKYFnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 00:43:05 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F441C935;
        Thu, 24 Nov 2022 21:43:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SK6W7gJhxsV6kxoaWG9xMtNjugbe0UlkqcDywzYMa8QBadLme04AoOyPLgKUPn66t/BrU54FNm0Vtqn1EAzITzfL9osp/aMJTu4L9cTWmLjCVtgsmPzEVdjCrsM7h3qjaTKfzHFZK6sxHG6+GVOxPz4cddC4RV0/KjU9QpwgAKUmbuOJ6KlTqATomAAGGlloCboamrnBgd+cVcbkyB4uSYDY1ZafQ6NWDS6wUUhuIXw8IRk4SbVjTBVPyyUXmnw5up6stUrDrvL+dGmLw94KSY6b6J1X2batfwLk0aQmgK9/GwqlUdwa5fyN92pbbTHyWceDlL2YydIyNC98y/ticw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UH2DRh2I6ViNFJsUc1g1Y/GfIp8QSxvxMldoZSbDftc=;
 b=g1tste354TLtLpn9uPpIk2P4l9K4yWDor6xVq3+XoVtZ8cJB5cB5Dcuxbg4ahoi/4HHFFBcPhA5juvbWHrehXEbbEa+I81UFgRh/Fymp5TcM5t36SkQ7uQqU2jBhIpHQQob5BkQ5tFE5t0Pg/PiMUFTjCnZmEHX5G8b7xpdhKaLVoGyFWPTyU3yL6/OIf267nAWI/sTiudJM/L2XKqZJQzr1mvDDVmDT7MbJnfJeoM95BX5vu5aOgeOpXG7UpxXoMr9TBcBGLBJHxee/vt7YudekijnDNbjqOKHTXdgunK2H3E/uNvzc48YPyMHI4Hm/tWPCXbD7TKB2Afq/HMJM2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UH2DRh2I6ViNFJsUc1g1Y/GfIp8QSxvxMldoZSbDftc=;
 b=KQM1xXYzcpgeZYpGMdsV0vv6ULnXGQqeUujB3hIJEM7a0O/o6+Sop6MF8nOwK3eDApKnA4XaP6resAUlwWaER18IRt6ZJ7VktchfArzo1lqiGuWcdxBxdBqFhqSr6r/SrhYRuF785RH+AzPKcDQ01y87RmDy/yR39bOxU0MGxSE=
Received: from BN9PR03CA0234.namprd03.prod.outlook.com (2603:10b6:408:f8::29)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Fri, 25 Nov
 2022 05:43:02 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::1b) by BN9PR03CA0234.outlook.office365.com
 (2603:10b6:408:f8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20 via Frontend
 Transport; Fri, 25 Nov 2022 05:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Fri, 25 Nov 2022 05:43:02 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 24 Nov
 2022 23:43:00 -0600
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [PATCH v7 4/4] drivers: misc: Add Support for TMR Inject IP
Date:   Fri, 25 Nov 2022 11:11:13 +0530
Message-ID: <20221125054113.122833-5-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221125054113.122833-1-appana.durga.kedareswara.rao@amd.com>
References: <20221125054113.122833-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 12888818-8aca-47f6-dbff-08dacea7eacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Y55Kb8N7r5BHJ4RnlDC98WvPGifZzyBgdZF7URNuNODKDNUXEL1ub1ZyGTZbbFRMWN+xUOV3PVXOz7ZKbWHcHebLvJA/cFEoa5XzDsrLPQy3dXKgh97Co1ehRgbP7G4oSD0taZhlvu3DUweoSzgUCJSq3Xk3UpIbxtcC3McPCXYCX5SkCrSJroVSC+Ygraedv8C7ogLMfue5e597gg9TZ9tHicpcDm1Xg3etJOKQXo5UPvWQlr2MyxMf7E0AK07lk9Jimss0uz61iSMS36WI9ktwHvdXMd8kLBsmXl2k0Uf0PU1WgVrnIS0IjeHz3GcHFYi59mgDXaL/nnf5kL1Kyna5ZKoAD7OCDk3KY2MnsE8vxsjXyOmJZFOKSZxxdRQP/jRoeFtu0K3fsZFZN2bLSdNUA6jHeNkSDLQEdSXO1MDVPkP/75cU0cbcfjboNnvxtNzHOe9qToUBSb8LvDroRfTlS8OAZT9xAf2f+KaVBQEAxTVi6esJkjS40sn4JR4QrA4+EgdBBXE6a/qAOt/uiRTHA4LEyMS8YbSpdsafzdkc5myOc2f7MqevpYO4Nn9m3yXrCKPbKb2dNa834+ZQt0iDaxMAgb/97HvhEgaupmgrcf7btvbUP99CWpmVKI1nvhSCznG5r20rE1Ks0KgqtBJN9AoFoEK1CmF6F/RaSKSJYi4Usr3lbPStHGfU/ShYQ89+8brmmn7cbxQatGgaWGa1wJ3GAbvruZjSNJQpDdNhIgSST1g4Ens9DhWb7Ag
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(36840700001)(46966006)(40470700004)(103116003)(36756003)(921005)(82740400003)(41300700001)(81166007)(8676002)(356005)(426003)(83380400001)(2906002)(36860700001)(86362001)(47076005)(316002)(1076003)(26005)(70206006)(4326008)(70586007)(336012)(186003)(110136005)(16526019)(54906003)(5660300002)(40460700003)(40480700001)(8936002)(6666004)(2616005)(82310400005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 05:43:02.0188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12888818-8aca-47f6-dbff-08dacea7eacc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Triple Modular Redundancy(TMR) provides functional fault injection by
changing selected MicroBlaze instructions, which provides the possibility
to verify that the TMR subsystem error detection and fault recovery logic
is working properly.

Usage:
echo 1 > /sys/kernel/debug/xtmr_inject/inject_fault/inject_fault

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
---
Changes for v7:
--> Removed the reported-by kernel test robot
from the commit message and update the change log
description for the same in the corresponding patch version,
rebased patch on top of torvalds master branch.
Changes for v6:
--> Fixed -Wmissing-prototypes warning reported by kernel test robot.
Changes for v5:
--> None.
Changes for v4:
--> Update depends on with FAULT_INJECTION_DEBUG_FS instead of
FAULT_INJECTION.
Changes for v3:
--> Updated the driver to use fault-injection api as suggested by Greg.
--> Updated the Kconfig to compile the driver as a module.
Changes for v2:
--> Fixed Month in the sysfs description.
--> Fixed line over 80 char in driver.
--> Replaced kstrtol with kstrtoul as suggested by Michal.
--> Added error check for xlnx,magic value.

 MAINTAINERS                      |   6 ++
 drivers/misc/Kconfig             |  10 ++
 drivers/misc/Makefile            |   1 +
 drivers/misc/xilinx_tmr_inject.c | 171 +++++++++++++++++++++++++++++++
 4 files changed, 188 insertions(+)
 create mode 100644 drivers/misc/xilinx_tmr_inject.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5f0344f14192..6dd1a3491946 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13429,6 +13429,12 @@ F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
 F:	Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
 F:	drivers/misc/xilinx_tmr_manager.c
 
+MICROBLAZE TMR INJECT
+M:	Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/misc/xlnx,tmr-inject.yaml
+F:	drivers/misc/xilinx_tmr_inject.c
+
 MICROCHIP AT91 DMA DRIVERS
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index a61445008f9e..35a5d333fc37 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -506,6 +506,16 @@ config TMR_MANAGER
 
 	  Say N here unless you know what you are doing.
 
+config TMR_INJECT
+	tristate "Select TMR Inject"
+	depends on TMR_MANAGER && FAULT_INJECTION_DEBUG_FS
+	help
+	  This option enables the driver developed for TMR Inject.
+	  The Triple Modular Redundancy(TMR) Inject provides
+	  fault injection.
+
+	  Say N here unless you know what you are doing.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index b93b782a52f4..b2d8dd39f4d5 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -63,3 +63,4 @@ obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
 obj-$(CONFIG_GP_PCI1XXXX)	+= mchp_pci1xxxx/
 obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
 obj-$(CONFIG_TMR_MANAGER)      += xilinx_tmr_manager.o
+obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
diff --git a/drivers/misc/xilinx_tmr_inject.c b/drivers/misc/xilinx_tmr_inject.c
new file mode 100644
index 000000000000..d96f6d7cd109
--- /dev/null
+++ b/drivers/misc/xilinx_tmr_inject.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Xilinx TMR Inject IP.
+ *
+ * Copyright (C) 2022 Advanced Micro Devices, Inc.
+ *
+ * Description:
+ * This driver is developed for TMR Inject IP,The Triple Modular Redundancy(TMR)
+ * Inject provides fault injection.
+ */
+
+#include <asm/xilinx_mb_manager.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/fault-inject.h>
+
+/* TMR Inject Register offsets */
+#define XTMR_INJECT_CR_OFFSET		0x0
+#define XTMR_INJECT_AIR_OFFSET		0x4
+#define XTMR_INJECT_IIR_OFFSET		0xC
+#define XTMR_INJECT_EAIR_OFFSET		0x10
+#define XTMR_INJECT_ERR_OFFSET		0x204
+
+/* Register Bitmasks/shifts */
+#define XTMR_INJECT_CR_CPUID_SHIFT	8
+#define XTMR_INJECT_CR_IE_SHIFT		10
+#define XTMR_INJECT_IIR_ADDR_MASK	GENMASK(31, 16)
+
+#define XTMR_INJECT_MAGIC_MAX_VAL	255
+
+/**
+ * struct xtmr_inject_dev - Driver data for TMR Inject
+ * @regs: device physical base address
+ * @magic: Magic hardware configuration value
+ */
+struct xtmr_inject_dev {
+	void __iomem *regs;
+	u32 magic;
+};
+
+static DECLARE_FAULT_ATTR(inject_fault);
+static char *inject_request;
+module_param(inject_request, charp, 0);
+MODULE_PARM_DESC(inject_request, "default fault injection attributes");
+static struct dentry *dbgfs_root;
+
+/* IO accessors */
+static inline void xtmr_inject_write(struct xtmr_inject_dev *xtmr_inject,
+				     u32 addr, u32 value)
+{
+	iowrite32(value, xtmr_inject->regs + addr);
+}
+
+static inline u32 xtmr_inject_read(struct xtmr_inject_dev *xtmr_inject,
+				   u32 addr)
+{
+	return ioread32(xtmr_inject->regs + addr);
+}
+
+static int xtmr_inject_set(void *data, u64 val)
+{
+	if (val != 1)
+		return -EINVAL;
+
+	xmb_inject_err();
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(xtmr_inject_fops, NULL, xtmr_inject_set, "%llu\n");
+
+static void xtmr_init_debugfs(struct xtmr_inject_dev *xtmr_inject)
+{
+	struct dentry *dir;
+
+	dbgfs_root = debugfs_create_dir("xtmr_inject", NULL);
+	dir = fault_create_debugfs_attr("inject_fault", dbgfs_root,
+					&inject_fault);
+	debugfs_create_file("inject_fault", 0200, dir, NULL,
+			    &xtmr_inject_fops);
+}
+
+static void xtmr_inject_init(struct xtmr_inject_dev *xtmr_inject)
+{
+	u32 cr_val;
+
+	if (inject_request)
+		setup_fault_attr(&inject_fault, inject_request);
+	/* Allow fault injection */
+	cr_val = xtmr_inject->magic |
+		 (1 << XTMR_INJECT_CR_IE_SHIFT) |
+		 (1 << XTMR_INJECT_CR_CPUID_SHIFT);
+	xtmr_inject_write(xtmr_inject, XTMR_INJECT_CR_OFFSET,
+			  cr_val);
+	/* Initialize the address inject and instruction inject registers */
+	xtmr_inject_write(xtmr_inject, XTMR_INJECT_AIR_OFFSET,
+			  XMB_INJECT_ERR_OFFSET);
+	xtmr_inject_write(xtmr_inject, XTMR_INJECT_IIR_OFFSET,
+			  XMB_INJECT_ERR_OFFSET & XTMR_INJECT_IIR_ADDR_MASK);
+}
+
+/**
+ * xtmr_inject_probe - Driver probe function
+ * @pdev: Pointer to the platform_device structure
+ *
+ * This is the driver probe routine. It does all the memory
+ * allocation for the device.
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int xtmr_inject_probe(struct platform_device *pdev)
+{
+	struct xtmr_inject_dev *xtmr_inject;
+	int err;
+
+	xtmr_inject = devm_kzalloc(&pdev->dev, sizeof(*xtmr_inject),
+				   GFP_KERNEL);
+	if (!xtmr_inject)
+		return -ENOMEM;
+
+	xtmr_inject->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(xtmr_inject->regs))
+		return PTR_ERR(xtmr_inject->regs);
+
+	err = of_property_read_u32(pdev->dev.of_node, "xlnx,magic",
+				   &xtmr_inject->magic);
+	if (err < 0) {
+		dev_err(&pdev->dev, "unable to read xlnx,magic property");
+		return err;
+	}
+
+	if (xtmr_inject->magic > XTMR_INJECT_MAGIC_MAX_VAL) {
+		dev_err(&pdev->dev, "invalid xlnx,magic property value");
+		return -EINVAL;
+	}
+
+	/* Initialize TMR Inject */
+	xtmr_inject_init(xtmr_inject);
+
+	xtmr_init_debugfs(xtmr_inject);
+
+	platform_set_drvdata(pdev, xtmr_inject);
+
+	return 0;
+}
+
+static int xtmr_inject_remove(struct platform_device *pdev)
+{
+	debugfs_remove_recursive(dbgfs_root);
+	dbgfs_root = NULL;
+	return 0;
+}
+
+static const struct of_device_id xtmr_inject_of_match[] = {
+	{
+		.compatible = "xlnx,tmr-inject-1.0",
+	},
+	{ /* end of table */ }
+};
+MODULE_DEVICE_TABLE(of, xtmr_inject_of_match);
+
+static struct platform_driver xtmr_inject_driver = {
+	.driver = {
+		.name = "xilinx-tmr_inject",
+		.of_match_table = xtmr_inject_of_match,
+	},
+	.probe = xtmr_inject_probe,
+	.remove = xtmr_inject_remove,
+};
+module_platform_driver(xtmr_inject_driver);
+MODULE_AUTHOR("Advanced Micro Devices, Inc");
+MODULE_DESCRIPTION("Xilinx TMR Inject Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

