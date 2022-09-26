Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39B65E9F04
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbiIZKRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiIZKQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:16:55 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DFE1EC51;
        Mon, 26 Sep 2022 03:14:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNeakxRdwZYJVEFv8pVLZo9KXDWBF9HIb6Fa9CD9Vpk3zzkElwjX5iqy/e1GRMeu7LCJUG57lHIiK1KvkkjCVhW0960zhDIR1OscYy1uoiTcWxLsgC9LdFAxgUbzT4Rpo7LuGWXpjAi21VD39IM1ru2pTXhotGtW/SD3nZX1JS2lXHlfLcVZXGBXFPHd4VY5YdyjBEqevtlG30uooIeY2No6Z8gZevJdE5yJKiPnoYJYnzoTr8X/izuW6v+mSSQioInPsIVyjinwETK3O5oXgxsw1eMK79B3ag9RLG77WCo8Lg4V/JgXzS+PaTgBnbiTUfJ9Ar0lFLozwneqdODPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYHWkPSZ5IN+6qLbfrU9mwPjFur2Go5G6maTwL796to=;
 b=AwLv2CtjFp/qImpp1x47Pa1vvQnUaOjJbXwrchwfjunb5OPlUs5OuJZAOOw70P69Ms+dAJkdIY0/oBPl2SuUZF5Mbs/neAxBkBtfGdt5tC8l4CZk4Jnxeim7zJfybApiTsG78cMDotmyLIPcgkVpSJWz5Q82VPlRB4eJqy59++WS7dmv792flhjB2zjBpPqENwpCGNncuLa08Glwz7B2mwkCl/SgkuDgdBzutQpGu/NjFReVjkSQF6f6gO29PxB+rk0aDD17Hd9pD1Q9i9OjKAzwdiYFcDGpU4twGUK5w0g+3JSiKy/wlrHY9qQycodwkSvl7CvAj9LzWbjePKP/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYHWkPSZ5IN+6qLbfrU9mwPjFur2Go5G6maTwL796to=;
 b=QtZD1pBARC5pzrgYZ2DewC6S8qOsdxUealbcVsNFzmKmAp11bFAFWUBHJIXJak2yqNKqohEy9OztFKIB9H36wpmbxT2bRTgNe8R0HHPUELLAB8NBojyAyAWH0DgUKKmetXW83uQnDzvuATEbg85f9JSygrZ94Dd7wE80VozwDao=
Received: from MW4PR03CA0285.namprd03.prod.outlook.com (2603:10b6:303:b5::20)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Mon, 26 Sep
 2022 10:14:40 +0000
Received: from CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::bf) by MW4PR03CA0285.outlook.office365.com
 (2603:10b6:303:b5::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 10:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT104.mail.protection.outlook.com (10.13.174.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 10:14:39 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 05:14:36 -0500
From:   Appana Durga Kedareswara rao 
        <appana.durga.kedareswara.rao@amd.com>
To:     <appanad@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <appana.durga.rao@xilinx.com>,
        <michal.simek@xilinx.com>, <derek.kiernan@xilinx.com>,
        <dragan.cvetic@xilinx.com>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <git@amd.com>
Subject: [PATCH v5 4/4] drivers: misc: Add Support for TMR Inject IP
Date:   Mon, 26 Sep 2022 15:43:46 +0530
Message-ID: <20220926101346.272720-5-appana.durga.kedareswara.rao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220926101346.272720-1-appana.durga.kedareswara.rao@amd.com>
References: <20220926101346.272720-1-appana.durga.kedareswara.rao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT104:EE_|DS0PR12MB6463:EE_
X-MS-Office365-Filtering-Correlation-Id: ad290e53-32f0-48ec-1455-08da9fa7ec15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4FZPCPT7XMTurhncUKEe3sokPEHOWr4TeH/t4JJ3Vrz9Co52t+e/r8bZfOdezZpSc1wJ3XunmlSmmDF4IBTgkWyUpSBioXLZK/gibtWViQaZPmo6RG/+gDo77v5aNmyAIcllbcR02k3qZGBQEX6y1tSa2OlPpynagXTKsNZFblZ3kc6HxRHauSRYCp1TvSh9ejuurqagW1QRlOfIZzGqMJJ5OZ0d8lK/L+J/kREgJA8gOiuS8A0yDQpThy5iGRsYJKbPrAl+rAq1KE44YNyrIuPtc1c0KDJBM7j8U/hG94EDSPkTSw9tlvjVO498Xct3v7WJETKaCInFy4wJ/rgrqDzfyDW+JBEzp4L0CWDdZQ4IfDct1KqsbYflrZvr2hV+O+m3E1goJgFaJQxNS7IocX8XnjCCh/r/SodcoMCeVEbuLGRIYAWVyRRvU2kMT/jdVVxKmdnJHlHr8Sb6R1qLo41xmfRIKcCQAZEW5T1kCglfS9cD03pv1fuZxRehcrGxew2mCSKdXHQsKf2Rso0hngkTUS5w1gWNZZNJ9+LAzDV/jnLUl8caomzwfw5W5il0NAQmNNvsnajUxRJ7rACrh/pAw4PeVmR4FgI0ZqDn3nSZp86tuJ9qhVPoK/DynaH2s/QJi+OwWX6VqmDTrr/LroGAnruS7zvVAAf0DK7no8urbxG50E26Hlpr4RaJAyl7aY2bG+TfPitkg/g0W8BPQmbpVZU/RMXJ2pI2a83hcqsIWn2Ufm+gBWP8ybyYK1vTSa8KM9LRVIY5vHov9WNvWjTvtBbfZBlJAYsbJqEv9GXNcTJzmDPTh44c4wj4Be4
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199015)(46966006)(40470700004)(36840700001)(316002)(86362001)(356005)(36756003)(336012)(8936002)(2906002)(81166007)(54906003)(921005)(40460700003)(83380400001)(16526019)(186003)(103116003)(1076003)(2616005)(40480700001)(110136005)(426003)(5660300002)(36860700001)(6666004)(478600001)(41300700001)(26005)(70586007)(70206006)(8676002)(4326008)(82310400005)(82740400003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 10:14:39.3474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad290e53-32f0-48ec-1455-08da9fa7ec15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
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
index 15805b4e314f..341d4fcd38b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13285,6 +13285,12 @@ F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
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
index ddb56ea1ed62..6422c43eebe1 100644
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

