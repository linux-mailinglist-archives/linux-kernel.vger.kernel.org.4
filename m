Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9335EEA8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 02:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiI2A3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 20:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiI2A3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 20:29:05 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C883F30A;
        Wed, 28 Sep 2022 17:29:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnY1Hy+bD3x6mAEWVhzcLTB3afPkHNyTeJLezfw74HFJor7jecHrfAlhtcuaWXno6JH8P1fdw4TqqlrLh8RGMF+KjAo+RJhS8UmwgruEsgPDn6IdEJ4ve3WBHf+MQehOcZ8FpZik8Ofh1QdRB1D73m02FAeEILVmlGJc4K8UnmRXatMWATR4MVVHtr5+UKjaNTt1PCDxh7cf1ito3aLldm1NG4B8lOObzLblvS0FyKxzVL/gx0OwDvwe4w5NRVQulO4eRPOrTDKC8+0I25HYE0T9iiy57SrumkstPfsXnlrZUY7yPqOIy9oTrWieg3XvKSI/2FpQQhRmMVz8kJw4qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+akvTvhl880RQ+JJoIByXbKbSrj69mKLNtbbs3uwtN4=;
 b=nS5nmW1MSoCVpKYxY5E6D9DEtxqYqVCx8+qvr/cBnad898RvyDlCLGZnf2VqFP+KID11Y7MKJPE6sfh89rHDflZnXqkFRDwIs/Sj5v7yEDoo03pPd8fTW/Niz/nOVINPcO/STULBYpRBmSwve0SvCRhYFAz2tcGbuLGljDSBULfywrnThr1WKTzHAsJ1yt0fe1TwN+DXfym3safAcVT0qs3pop3mWJ7zgKZsdJmTfdgRLGXDkqukPha41QTUcBT3UEojcuDOyXut4aBDeGaWa6Gj2haWOPPM6ahwkLTMyWQffkhKyufqMs2/sXi5MjenUzxI73BVlasouPpQLez+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+akvTvhl880RQ+JJoIByXbKbSrj69mKLNtbbs3uwtN4=;
 b=pav/0eifzCW7wgRPPZnKF3HAj+FA0j3Z8nRoLr1var86RUO4MyCm9+9dqX+K3+V1E/hXQuPEsDA0DQF62SnuT6LKyat8HjN47JLxwCiq5gM4PUuo6rtG85s6SS/2VJn2FAb+ZCR/wzUW/6lnzHEZI8wIFhL2AaTxGMwkcE6MjHttbMHgk5/NY01avfaZBdnH30ZSpPoaI+jvXE0lw2aba35dpR6pSHAfnwi71RiXl7P5ozLgj2Dnx/52U9MhJcLm6980xkvOkOc1DA4vPe2OGlwjw//e3LHs7l28lC4+p6CknRFQwso/FqWpHq47ubt94379ROMPMWess3kefAqfhQ==
Received: from MW3PR05CA0016.namprd05.prod.outlook.com (2603:10b6:303:2b::21)
 by CH2PR12MB4310.namprd12.prod.outlook.com (2603:10b6:610:a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Thu, 29 Sep
 2022 00:29:00 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::78) by MW3PR05CA0016.outlook.office365.com
 (2603:10b6:303:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.7 via Frontend
 Transport; Thu, 29 Sep 2022 00:29:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Thu, 29 Sep 2022 00:29:00 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 28 Sep
 2022 17:28:50 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Wed, 28 Sep 2022 17:28:50 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Wed, 28 Sep 2022 17:28:49 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <rafael@kernel.org>, <lenb@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <guohanjun@huawei.com>, <sudeep.holla@arm.com>
CC:     <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Besar Wicaksono" <bwicaksono@nvidia.com>
Subject: [PATCH v2] ACPI: ARM Performance Monitoring Unit Table (APMT) initial support
Date:   Wed, 28 Sep 2022 19:28:34 -0500
Message-ID: <20220929002834.32664-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|CH2PR12MB4310:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0182a6-fcd5-47cd-eb26-08daa1b19aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YYLwxWxyEMu38gCDOAfrjaB8fcbX2qE/wZmE71dqj1lsAyF24e3p8KxU3OZ1OlmHcrGMsIWAvWlc0tRtkWAGm4tfZpc1PBJ81Mh3fiyphq7Qi9wwGiUkaqZbrYC+0B3aOHWw9Ti+AKjCcEaU+BdMqsJ1etmc/mF+UWZZdC3dqJX4ks2UUFe3uqX+YRy8LQ+Cc8/3aUukngtbtTZOx0Oii91tqYb+sx5A4wrhbDw1ub9eM0aryBCNZuBEzS1rLMv4ZCm84FxxPKj4bdldFeYvF0YArpSt4IGLA0x3h+feKuu1tzM7yPn5M8WHI3aGJfJusPLlu/ZVgnHVZ6EgjaKsYE8Wbei+n8VxpIpjfYsFXKxo09UD3iCq+FnuVRoqnrrz5KO7qyfeUzrMGDDa3ZxuZYxFagkhp9Rp+EPJNLdQTqGblsYJlDjDg0rDdxvZMGAXd9MKKnYYi4431KKcSm+b1T+8IuDaivQIOKnvagyeccYc72/VaprdEGnZ4Ic0Su0T+54Qu2EPaZnpoJrOQJN7Puinakq+Hz75qQ1pz/sCaZ4i69Ks4efsGm+RVu2vYYkl940IYaj2duSzffF624DWyyX8oXsN6lOXNAaJjhMHzPpoI//oaJ6V/yrkvUeLLKcc4iKFEP0sxNR7/oZrzmivFEySdp+Is5UnZ2oMvqiiBO1/nSJ9C0B0M4SCx1V646BtcefyroZH2/T9f47HtRSVgv1QbkDnrWPmos4hCC+YTItM97RgRx8oeWlp0lQQlJiL/5hgJQVB0rPJSqn8chWu/MqIibSIhKSoQHe6odeqF58EFTNxrtSz3nwrtZSTI1WIdO7DdtH32XWtje325LeJnJ1DsqgG5HGfMlxyup+Cj6ByOlRqy+PjZstfw1pnwEyC47IBiiJJxlp/rDlw5yEUqA==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(2906002)(36756003)(7636003)(356005)(41300700001)(8676002)(8936002)(7416002)(4326008)(5660300002)(82310400005)(70206006)(70586007)(54906003)(86362001)(966005)(110136005)(40480700001)(316002)(82740400003)(478600001)(1076003)(26005)(7696005)(6666004)(40460700003)(36860700001)(107886003)(336012)(426003)(47076005)(2616005)(83380400001)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 00:29:00.1690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0182a6-fcd5-47cd-eb26-08daa1b19aae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4310
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM Performance Monitoring Unit Table describes the properties of PMU
support in ARM-based system. The APMT table contains a list of nodes,
each represents a PMU in the system that conforms to ARM CoreSight PMU
architecture. The properties of each node include information required
to access the PMU (e.g. MMIO base address, interrupt number) and also
identification. For more detailed information, please refer to the
specification below:
 * APMT: https://developer.arm.com/documentation/den0117/latest
 * ARM Coresight PMU:
        https://developer.arm.com/documentation/ihi0091/latest

The initial support adds the detection of APMT table and generic
infrastructure to create platform devices for ARM CoreSight PMUs.
Similar to IORT the root pointer of APMT is preserved during runtime
and each PMU platform device is given a pointer to the corresponding
APMT node.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---

The patch applies on top of
  https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  master next-20220524

Changes from v1:
 * Include acpi_apmt.h header file
 * Update the device name. Related driver patch:
   https://lore.kernel.org/linux-arm-kernel/20220928201830.45637-1-bwicaksono@nvidia.com/
v1: https://lkml.org/lkml/2022/4/19/1395

 arch/arm64/Kconfig          |   1 +
 drivers/acpi/arm64/Kconfig  |   3 +
 drivers/acpi/arm64/Makefile |   1 +
 drivers/acpi/arm64/apmt.c   | 177 ++++++++++++++++++++++++++++++++++++
 drivers/acpi/bus.c          |   2 +
 include/linux/acpi_apmt.h   |  19 ++++
 6 files changed, 203 insertions(+)
 create mode 100644 drivers/acpi/arm64/apmt.c
 create mode 100644 include/linux/acpi_apmt.h

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index aaeb70358979..dbcb09ee29dd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config ARM64
 	def_bool y
+	select ACPI_APMT if ACPI
 	select ACPI_CCA_REQUIRED if ACPI
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_GTDT if ACPI
diff --git a/drivers/acpi/arm64/Kconfig b/drivers/acpi/arm64/Kconfig
index d4a72835f328..b3ed6212244c 100644
--- a/drivers/acpi/arm64/Kconfig
+++ b/drivers/acpi/arm64/Kconfig
@@ -18,3 +18,6 @@ config ACPI_AGDI
 	  reset command.
 
 	  If set, the kernel parses AGDI table and listens for the command.
+
+config ACPI_APMT
+	bool
diff --git a/drivers/acpi/arm64/Makefile b/drivers/acpi/arm64/Makefile
index 7b9e4045659d..e21a9e84e394 100644
--- a/drivers/acpi/arm64/Makefile
+++ b/drivers/acpi/arm64/Makefile
@@ -2,4 +2,5 @@
 obj-$(CONFIG_ACPI_AGDI) 	+= agdi.o
 obj-$(CONFIG_ACPI_IORT) 	+= iort.o
 obj-$(CONFIG_ACPI_GTDT) 	+= gtdt.o
+obj-$(CONFIG_ACPI_APMT) 	+= apmt.o
 obj-y				+= dma.o
diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
new file mode 100644
index 000000000000..f55167ca51e7
--- /dev/null
+++ b/drivers/acpi/arm64/apmt.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ARM APMT table support.
+ * Design document number: ARM DEN0117.
+ *
+ * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+
+#define pr_fmt(fmt)	"ACPI: APMT: " fmt
+
+#include <linux/acpi.h>
+#include <linux/acpi_apmt.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+
+#define DEV_NAME "arm-cs-arch-pmu"
+
+/* There can be up to 3 resources: page 0 and 1 address, and interrupt. */
+#define DEV_MAX_RESOURCE_COUNT 3
+
+/* Root pointer to the mapped APMT table */
+static struct acpi_table_header *apmt_table;
+
+static int __init apmt_init_resources(struct resource *res,
+					      struct acpi_apmt_node *node)
+{
+	int irq, trigger;
+	int num_res = 0;
+
+	res[num_res].start = node->base_address0;
+	res[num_res].end = node->base_address0 + SZ_4K - 1;
+	res[num_res].flags = IORESOURCE_MEM;
+
+	num_res++;
+
+	res[num_res].start = node->base_address1;
+	res[num_res].end = node->base_address1 + SZ_4K - 1;
+	res[num_res].flags = IORESOURCE_MEM;
+
+	num_res++;
+
+	if (node->ovflw_irq != 0) {
+		trigger = (node->ovflw_irq_flags & ACPI_APMT_OVFLW_IRQ_FLAGS_MODE);
+		trigger = (trigger == ACPI_APMT_OVFLW_IRQ_FLAGS_MODE_LEVEL) ?
+			ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
+		irq = acpi_register_gsi(NULL, node->ovflw_irq, trigger,
+						ACPI_ACTIVE_HIGH);
+
+		if (irq <= 0) {
+			pr_warn("APMT could not register gsi hwirq %d\n", irq);
+			return num_res;
+		}
+
+		res[num_res].start = irq;
+		res[num_res].end = irq;
+		res[num_res].flags = IORESOURCE_IRQ;
+
+		num_res++;
+	}
+
+	return num_res;
+}
+
+/**
+ * apmt_add_platform_device() - Allocate a platform device for APMT node
+ * @node: Pointer to device ACPI APMT node
+ *
+ * Returns: 0 on success, <0 failure
+ */
+static int __init apmt_add_platform_device(struct acpi_apmt_node *node,
+							struct fwnode_handle *fwnode)
+{
+	struct platform_device *pdev;
+	int ret, count;
+	struct resource res[DEV_MAX_RESOURCE_COUNT];
+
+	pdev = platform_device_alloc(DEV_NAME, PLATFORM_DEVID_AUTO);
+	if (!pdev)
+		return -ENOMEM;
+
+	memset(res, 0, sizeof(res));
+
+	count = apmt_init_resources(res, node);
+
+	ret = platform_device_add_resources(pdev, res, count);
+	if (ret)
+		goto dev_put;
+
+	/*
+	 * Add a copy of APMT node pointer to platform_data to be used to
+	 * retrieve APMT data information.
+	 */
+	ret = platform_device_add_data(pdev, &node, sizeof(node));
+	if (ret)
+		goto dev_put;
+
+	pdev->dev.fwnode = fwnode;
+
+	ret = platform_device_add(pdev);
+
+	if (ret)
+		goto dev_put;
+
+	return 0;
+
+dev_put:
+	platform_device_put(pdev);
+
+	return ret;
+}
+
+static int __init apmt_init_platform_devices(void)
+{
+	struct acpi_apmt_node *apmt_node;
+	struct acpi_table_apmt *apmt;
+	struct fwnode_handle *fwnode;
+	u64 offset, end;
+	int ret;
+
+	/*
+	 * apmt_table and apmt both point to the start of APMT table, but
+	 * have different struct types
+	 */
+	apmt = (struct acpi_table_apmt *)apmt_table;
+	offset = sizeof(*apmt);
+	end = apmt->header.length;
+
+	while (offset < end) {
+		apmt_node = ACPI_ADD_PTR(struct acpi_apmt_node, apmt,
+				 offset);
+
+		fwnode = acpi_alloc_fwnode_static();
+		if (!fwnode)
+			return -ENOMEM;
+
+		ret = apmt_add_platform_device(apmt_node, fwnode);
+		if (ret) {
+			acpi_free_fwnode_static(fwnode);
+			return ret;
+		}
+
+		offset += apmt_node->length;
+	}
+
+	return 0;
+}
+
+void __init acpi_apmt_init(void)
+{
+	acpi_status status;
+	int ret;
+
+	/**
+	 * APMT table nodes will be used at runtime after the apmt init,
+	 * so we don't need to call acpi_put_table() to release
+	 * the APMT table mapping.
+	 */
+	status = acpi_get_table(ACPI_SIG_APMT, 0, &apmt_table);
+
+	if (ACPI_FAILURE(status)) {
+		if (status != AE_NOT_FOUND) {
+			const char *msg = acpi_format_exception(status);
+
+			pr_err("Failed to get APMT table, %s\n", msg);
+		}
+
+		return;
+	}
+
+	ret = apmt_init_platform_devices();
+	if (ret) {
+		pr_err("Failed to initialize APMT platform devices, ret: %d\n", ret);
+		acpi_put_table(apmt_table);
+	}
+}
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 86fa61a21826..f9dc5b3d5c55 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -27,6 +27,7 @@
 #include <linux/dmi.h>
 #endif
 #include <linux/acpi_agdi.h>
+#include <linux/acpi_apmt.h>
 #include <linux/acpi_iort.h>
 #include <linux/acpi_viot.h>
 #include <linux/pci.h>
@@ -1411,6 +1412,7 @@ static int __init acpi_init(void)
 	acpi_setup_sb_notify_handler();
 	acpi_viot_init();
 	acpi_agdi_init();
+	acpi_apmt_init();
 	return 0;
 }
 
diff --git a/include/linux/acpi_apmt.h b/include/linux/acpi_apmt.h
new file mode 100644
index 000000000000..40bd634d082f
--- /dev/null
+++ b/include/linux/acpi_apmt.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * ARM CoreSight PMU driver.
+ * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES.
+ *
+ */
+
+#ifndef __ACPI_APMT_H__
+#define __ACPI_APMT_H__
+
+#include <linux/acpi.h>
+
+#ifdef CONFIG_ACPI_APMT
+void acpi_apmt_init(void);
+#else
+static inline void acpi_apmt_init(void) { }
+#endif /* CONFIG_ACPI_APMT */
+
+#endif /* __ACPI_APMT_H__ */

base-commit: 09ce5091ff971cdbfd67ad84dc561ea27f10d67a
-- 
2.17.1

