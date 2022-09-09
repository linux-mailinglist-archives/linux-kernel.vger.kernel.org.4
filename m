Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BC95B2EB3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiIIGUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiIIGTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:19:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9011D29C88;
        Thu,  8 Sep 2022 23:19:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgWFfjvlVNGo4pfU2RmgIvWP2nskppkLa3tfSJnsfEzzqaIYVB234eIsHEn9Q/cyBujnfU2ksL+0IkZQ6FvdaBzwcERlQEqE+hmgZj33KNEvHf9f26NFx/Xqzs6OfRCAJ3VsE76VfZXZjKJShaVEhztiZgvZ0wmfyCfr5vBAHsMAGR2TocI/aude22xBwd9I6eumO1Xmd2IqFXKRJ/fGwjeUgtU6TzA73NgYC8YZQBSNw5D21mZrCBvfUDFNG5LdhZ/fveGpWZ0A10XGhfqBUmD/29WpY1Yku8LxtOt5FJhO3BcV06GIdSzbot0abCDi/f6WWWIOdBZeIR5VOFuTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRLDPzk/IXtkUOCPF6fxJxZ9+6NnXheVbiEM2Oup570=;
 b=ntyb3F9QrkxRfEDmYHbIYH/+CSd8C1gI5Q6Y/zw41oxxk7iiyTK47ZDec/Tj4TBYfQggS1vLVq3yGsSeDwjSJzNcttfJh9xvQXChlSFg4+66wV/a1TH888omyPM4qs/obpG0OIrqFwDl0trDYYa003RERDc9youoIaUQVeqlm6wlDdyLfqJy2gWjAEURxk+3Eod89P63cktd/5eG+9gWqZTXCxE8jCmhmHT+Tt8YWGXDSlLX3YrhniYm9l8hLGP7ja8hGz4yN73WL5q8Ej7RKc4RdHnQMOeh4GeI51HXAJlZSM73OQQJz8DiyUkTvn/z7vYwwayaBCskz6lpR73tqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRLDPzk/IXtkUOCPF6fxJxZ9+6NnXheVbiEM2Oup570=;
 b=AcfcbObrUDWF2PvJeCVcptRl7CPqkRgOKzXGnUSRV6XFklJk2Y3cHULsRmmydn5don0tKbATF3xgmxoYUrqFs6f8FiDHEgfJ/Bqb+KpNSRRmCLyOz/guB4YdpkdFKkxtfwbDO2uGXf/hjMoJ2yR+zcPizf/O0saVt2uJbAmdqIk=
Received: from DM6PR03CA0091.namprd03.prod.outlook.com (2603:10b6:5:333::24)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Fri, 9 Sep
 2022 06:19:37 +0000
Received: from DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::4f) by DM6PR03CA0091.outlook.office365.com
 (2603:10b6:5:333::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 06:19:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT082.mail.protection.outlook.com (10.13.173.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 06:19:37 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 01:19:35 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [PATCH v4 4/4] drivers: misc: Add Support for TMR Inject IP
Date:   Fri, 9 Sep 2022 11:49:16 +0530
Message-ID: <20220909061916.2935431-5-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909061916.2935431-1-appana.durga.kedareswara.rao@amd.com>
References: <20220909061916.2935431-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT082:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: cd72e09a-e148-4a42-3f38-08da922b4597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9LAb4UAwEavabKpAtDJ2wAnlEHOJZUY4OiFNMH0E0XgTDfkML58cFw2k7NfoXHys0oIkDe/p2ugVoD7+T0v8gozGcBmsfj8JkdF/Tj67Rr+ZA8yWMXxfBaHaL18JyA8jKngLO3Q53Rae+i2UeDfHmkFNq+WKwhN4n9DemhWyRyYBgLi3lTJ+165IwMfgmWYHGcNMX7aU188/qMStFBdgclFZ0yqQpwYrpHAi08IbvQTl0fqOdtPD/cUkYtvrpxHU+oN303BIk2QnaSutUVnp96T/YnHBK3q27ruaVnNxsL0ICjRT72twur6ssBSWl6PQCBCZXBO08CRuQ4+iwK9FnJugHRm02iHCKebpVBrHMu3JAUXM7pbDWEss2AiB0RbYdRHY7B6GA2h3qOJKzp3njCBi0h+uTi5lOfyvnEzfj5mCvAOU0MsWVHOAAQOWce6ABPyT0K+4UcW7ywPEaddGCi0JvKo/2waysD1NHc++0aA6mqWsrB7+h9z1r8o1IBF8fjUQW4nGifg+Y0/VMbYnw6hM9TcgzRXscNA5bhTBosp5/T/PTV8K7zicHcZX04oIDo/5AZL9ZDBj5eYZX+qgJZ0kvfjvUaXu3LhcUuEDo+KUL7QxwvGQ7llvJWzD/WAi3huR8igzs1TrR5WSpAFGo5HhFkmCWVSY//XucSABeRISRm89C+p9jWevUc0RL3JL0j923XQvo5E/NP1Xn+86JlzWKx3pHIMS7V6UhGlojj52ZigNAAQMZ8zUYCw3cejn1i6PMElT8vGtAPR9ukQZ7tXH33mn5RKn8w9UvNKQWjfPd71OzilLHxPGKCwM/v0V
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(396003)(346002)(36840700001)(46966006)(40470700004)(5660300002)(426003)(83380400001)(103116003)(40480700001)(186003)(47076005)(2906002)(16526019)(2616005)(4326008)(8936002)(1076003)(70586007)(70206006)(8676002)(82310400005)(36756003)(86362001)(316002)(110136005)(336012)(6666004)(54906003)(40460700003)(26005)(82740400003)(41300700001)(921005)(36860700001)(478600001)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 06:19:37.4041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd72e09a-e148-4a42-3f38-08da922b4597
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Triple Modular Redundancy(TMR) provides functional fault injection by
changing selected MicroBlaze instructions, which provides the possibility
to verify that the TMR subsystem error detection and fault recovery logic
is working properly, provided sysfs entries which allow the user to inject
a fault.

Usage:
echo 1 > /sys/kernel/debug/xtmr_inject/inject_fault/inject_fault

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.kedareswara.rao@amd.com>
---
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
 drivers/misc/xilinx_tmr_inject.c | 173 +++++++++++++++++++++++++++++++
 4 files changed, 190 insertions(+)
 create mode 100644 drivers/misc/xilinx_tmr_inject.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 5fc5ec13985e..1207effa8e15 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13284,6 +13284,12 @@ F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
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
index 1508cc29b05a..9f8372497ad8 100644
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
index 4918f6632531..fff8606d505c 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -62,3 +62,4 @@ obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
 obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
 obj-$(CONFIG_TMR_MANAGER)      += xilinx_tmr_manager.o
+obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
diff --git a/drivers/misc/xilinx_tmr_inject.c b/drivers/misc/xilinx_tmr_inject.c
new file mode 100644
index 000000000000..da42cb1a0ee0
--- /dev/null
+++ b/drivers/misc/xilinx_tmr_inject.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Xilinx TMR Inject IP.
+ *
+ * Copyright (C) 2022 Xilinx, Inc.
+ *
+ * Description:
+ * This driver is developed for TMR Inject IP,The Triple Modular Redundancy(TMR)
+ * Inject provides fault injection.
+ * Fault injection and detection features are provided through sysfs entries
+ * which allow the user to generate a fault.
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
+ * allocation and creates sysfs entries for the device.
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

