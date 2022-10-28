Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EB1610CAB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiJ1JCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiJ1JCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:02:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CC81C5A51;
        Fri, 28 Oct 2022 02:02:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2XiwStuLa1ONJ6ppVOb+tN8RkjGQz/vdl6yaqNhZrspIYaGS0/5/xzU1ca09hGgNV3tRvPtRU5aFx7ATOVSyex/vP5n7w5/RfLylF2B3FtTSs78fGN6d+0SyixKj+L46y0Uh5d1H3ON1LAIS+xofYwGAJrno+mrDAsfsgmoD7saaddeE9XwhGBXte+NNsJC3aFVv4tvCzfGLuDsziI6eYMl4YKmMMDcM9lHiXWBvEF433g4lK50o+478VLPE3A14jDiEbUB4nvFLF/tNEjDbKLnhFuSPMXADZyZdFzKC0GVU+SpZmzymgn5fclpR5574VbcCUKRlD4cxTnCYsCgGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b98PR0HB0DnbMVoz3Amp+vimcz4HfQYCCwfAh89HIRU=;
 b=Kq7A7nEQDExBjYI95HpGg5JLZo0Rz+wK8iwS8in7rziN05TdsywSBeGbTOZsgKm1tlecT0zoW+vgWV+SkpwPwj8n6RZLZCjKWHOJzID5qgAuB1paex89KWtZwB5E3ZCIKO/VJSLprnSqpQP436+7YXgULJ21sfvI7L18NSW4xcw5id9TJWmwOxApfdO57TkifkFEFtvxJ+QE69RTwwfxLCSBqWR8oCA4cXJMZked/VW5elxO/lfCZABGsurDzji+cbB9F12vcL6Fhgc7ikUcag1iYftTI8C6YDPiTQb+qd8fIG2pQD70l2xqkI49pVN13qLUwbpefE9SO6TIZTtNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b98PR0HB0DnbMVoz3Amp+vimcz4HfQYCCwfAh89HIRU=;
 b=ZF1cT50oeRw2zn6vM9HGFf2iLZQVyHsTXhFuR3Anb82ABhps+aWsr3letYDHoBUI1AzhzqIY5xVnlrofNcxkp34Cy6Q8yuiTpCzduzCxnlyT6wkGU6uEO8JP7+zz6S+WADJdkVypGagNrXRZLpsDToV6PnvdGh5faAC47f4WX3U=
Received: from BN9PR03CA0893.namprd03.prod.outlook.com (2603:10b6:408:13c::28)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 09:02:31 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::aa) by BN9PR03CA0893.outlook.office365.com
 (2603:10b6:408:13c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.29 via Frontend
 Transport; Fri, 28 Oct 2022 09:02:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Fri, 28 Oct 2022 09:02:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 28 Oct
 2022 04:02:11 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <appana.durga.rao@xilinx.com>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [RESEND PATCH v5 4/4] drivers: misc: Add Support for TMR Inject IP
Date:   Fri, 28 Oct 2022 14:31:06 +0530
Message-ID: <20221028090106.1456940-5-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221028090106.1456940-1-appana.durga.kedareswara.rao@amd.com>
References: <20221028090106.1456940-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT021:EE_|SA1PR12MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: c02f7b6d-02f2-472e-2ea2-08dab8c32582
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xgjouQusocceKYy+ojwGWMSk9pdIla5ODjbUveRV5Tc/63xOEmG84BKd6DisE7v9Sape/+yr5/EChQLR7zbuN/guTQ40R2iG/YjI76cls20QBL8KAzfvxLrj+saSGME33U8KtMEs3Wz9ozInhbllnTXOqmRdQozWIueozk6PW9S8PjPF4mjZLtL1kpnucbXHGknDtk53/g2VrnXNg2NUrvZgWQLzqZxHAfna3C1VAOxiNk8DN1qq1H/XHRCQcr5l0PNj7XPYkg2an2aAvPk678JSxd2PNJC1ajsKNXdE14m59TE+HBD+j3a50CrdlCsG0dDWoN9cRhDJDdbu3kp9KHGqQUs7ahJIkF37guH4KzP28U3QXNi0SEYKAJIIywnWKIyR9ZBR0M8/HcJMgMs5xscPLmHves5Yti3F6fA00PZMeoqivjArR2ggjSZlqyw4u+kzlR0+kJl5WquipIMlmH/+U9Mj+HeumlyoxYv5dxN7Pas3fFmPChOi+pfv0rSTqG8mjJYdATJD14yktzCd/7ploouYdacZF0XIOCfq/rOPkvRmPbrfeV6DiGMFN9YGsBu9Zk8wDAQjbj9TEeM+xzB6ndd1T/QZZKA49kJiZ+CZ4bZQKoW/uaZ6hoK+hxw8kB/XmG9IbMJsgwPARGQv1RhU/WpSHiVKrr4skA4uxI8+yXCKRhKmXgNkzmEwYNy9sp8A9JypDt99vflMhkTXocRV0QMxMMTTvS9oCg7Q9amv/fjODJWXjYHvh+exmGDy3gzZVjlj9qsTCdrlsti9Q4ASjADcd7HghGhc+zlneqg29AnCxJMaSWff2P7wwUD
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199015)(46966006)(40470700004)(36840700001)(921005)(2906002)(70586007)(316002)(8936002)(110136005)(5660300002)(8676002)(54906003)(40460700003)(36860700001)(478600001)(103116003)(36756003)(41300700001)(426003)(4326008)(40480700001)(336012)(16526019)(47076005)(83380400001)(82310400005)(86362001)(186003)(2616005)(1076003)(81166007)(356005)(82740400003)(26005)(70206006)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 09:02:31.3299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c02f7b6d-02f2-472e-2ea2-08dab8c32582
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
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
index 2cd9e7594759..d8ecd9feb188 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13423,6 +13423,12 @@ F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
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
index 000000000000..d4db15b8899d
--- /dev/null
+++ b/drivers/misc/xilinx_tmr_inject.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Xilinx TMR Inject IP.
+ *
+ * Copyright (C) 2022 Xilinx, Inc.
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
+void xtmr_init_debugfs(struct xtmr_inject_dev *xtmr_inject)
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
+MODULE_AUTHOR("Xilinx, Inc");
+MODULE_DESCRIPTION("Xilinx TMR Inject Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

