Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D1674DD83
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 20:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjGJSkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 14:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbjGJSkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 14:40:02 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514D0AB;
        Mon, 10 Jul 2023 11:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czVjKH/6eYY5gp154wwvrUEodDhtCZ14Q0JvOyZubDzbwwjZZarDaMCiUQR3dE7RPkPl5hduIWc4Yv/kjfXDu8xCL+wP6D4lksJTf4SskyYDxVHRo5CQZDvZK4nwpXzGxNOco+MF76OyKxjwiROQ2Mtm5sf148aWAfOxaIJTC5OfxGQaBtcww6j15svCXeB3h9u7aFeAEmsT6qdZz57IemFnbPsXmRF+MqrRGGSlx65QVeJ26HnaPOHqZlzAq/bW58fsgN0DMBOBxpp/a5z6a+JliRxVuDRRFko/GoBC0Mi8FpDm2e2235rjizWAsJk7qxxNmT+3gHOKTtXpyLCOtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgglT6SVyRet3FDoGds2RrBUBF1nHxsRvPWhomsmGpU=;
 b=Dyc9ZaIAODUb3RpCH73xmUTheXMtsXDfl5VO7aOr1bGsCs4UOlt5VEYwYClpfUgCwBhl1X/TwjSUPrXqZEuRxNv3yVUunCqpnnfBGbiYol/cEbKHchcrEygJc8v9/Ba1l95I8FCOPkzsnrfWlaZ8OE+lVDlTE7ZyKznXozAdTeXnRIKQnp+HBfC6SbimkEpiAO8BjNr+f50Wnj6fckCwFi+ufme2rBBBFUbQ0YbytUV6DXJe7wDGIXZWJ6v3fxzvhD0tbbdozEQWK5erkIZPLznnfpQ7nvENdinLJGhrsSXePqsQF3HnKJ9TWVy2Yr7AD0vTe26b69iWmvEET4ut9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgglT6SVyRet3FDoGds2RrBUBF1nHxsRvPWhomsmGpU=;
 b=j5JBzQndSbiQygHGEQYOWWE/iC/bUfJubezM47mRAxExXVOPpkO2i0yhzOk/6k1TEbsOu0ZFvf6ehqG7NAE/o2IkSRYYj0PYM9oakxV9bX4dIlhEKd0fZnUapcKOzbgAbt4WqP/hQvQAq+8n7beosGg9oX1Ld69kr44xla4oRl4=
Received: from BY5PR04CA0013.namprd04.prod.outlook.com (2603:10b6:a03:1d0::23)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Mon, 10 Jul
 2023 18:39:54 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1d0:cafe::a9) by BY5PR04CA0013.outlook.office365.com
 (2603:10b6:a03:1d0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Mon, 10 Jul 2023 18:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Mon, 10 Jul 2023 18:39:54 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 13:39:52 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Mark Gross <mgross@linux.intel.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 1/2] platform/x86: Move s2idle quirk from thinkpad-acpi to amd-pmc
Date:   Mon, 10 Jul 2023 13:39:33 -0500
Message-ID: <20230710183934.17315-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710183934.17315-1-mario.limonciello@amd.com>
References: <20230710183934.17315-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|MW3PR12MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 367da6fe-de70-451d-3ca1-08db81750da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6pvIOnHCpyQjIlQnzI5uxLRYw1oDQnautIDRXFqR4Uk92RvUJtYxvIgUOoeuAl9hQWSraXY4WEiTDKYy9RV7y+XMiGH0QZxuF50XFDeKkLC96OrbbU5mx4rlLD+spVHUazaTcOrj/6NzNjKQg4mYB9dN8fogAaQhFPCIS4qRYdqu7DjxbI6di6YPFI1t8iAScuy6EqcrmxndmNiZ6Mh2OBtdEwL9qskYjLoTbvKgya+WpokZ02HY98p57Nc2j4y3dfPzsMWKqnEFOU4wpuaoCd97xjjJIEMCbVI1dgWSXS6PAfH1LosCwt+ao0C3S49mTQUqExNypmZpRSTazLQyMhB1EybHjmBXU0s7ciGFhOfucPv6AXlYnL+xFbsAa+U4Kl9GpRP+2w9U3ScgQ8WzMugFhV0K3YBy4pk+lsILLHmGDXwgiV8NDXkLbMh3dA2Zca98GZv0314ey2bwaCuK6Z29ckad04OPs5CukWoconU+HSgQi2e1OMMzl9V/emYrDlo+heQOxpsJ1UMd40EmgMLFRTe755ISfFhqGiztG/sjpWf4ggZFJfu2ECiJoAkyGcqHIDYz7CNlukaf/8SjCRyW8OSx2rihW8radrIsVFnBTMAU1zstu46APeDP2Dhk2d8n1KsB/d+QtHJDFCbCePD3Rxh1kz+JgWnIJV5fyHVPbyY/FWbYHlOu178i47KsHggtcqZ+6gZUNTaVmK2ZLOnkKCFyMusyu2aV2Zrw+3m09ICJmXAekmocE98YO80DVShNEVkLbXdo4QZxA9CDg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(6666004)(478600001)(7696005)(54906003)(36860700001)(47076005)(426003)(83380400001)(36756003)(40460700003)(86362001)(40480700001)(2616005)(2906002)(30864003)(70206006)(82310400005)(186003)(70586007)(16526019)(1076003)(26005)(336012)(81166007)(82740400003)(356005)(8676002)(6916009)(316002)(5660300002)(4326008)(41300700001)(8936002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 18:39:54.2037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 367da6fe-de70-451d-3ca1-08db81750da0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that some-non Lenovo systems can benefit from the quirk
introduced for Lenovo systems in commit 455cd867b85b5 ("platform/x86:
thinkpad_acpi: Add a s2idle resume quirk for a number of laptops").

So move this quirk into running from the amd-pmc driver instead.
No intended functional changes.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/amd/Makefile     |   2 +-
 drivers/platform/x86/amd/pmc-quirks.c | 164 ++++++++++++++++++++++++++
 drivers/platform/x86/amd/pmc.c        |  30 +----
 drivers/platform/x86/amd/pmc.h        |  43 +++++++
 drivers/platform/x86/thinkpad_acpi.c  | 143 ----------------------
 5 files changed, 214 insertions(+), 168 deletions(-)
 create mode 100644 drivers/platform/x86/amd/pmc-quirks.c
 create mode 100644 drivers/platform/x86/amd/pmc.h

diff --git a/drivers/platform/x86/amd/Makefile b/drivers/platform/x86/amd/Makefile
index 2c229198e24c9..65732f0a3913f 100644
--- a/drivers/platform/x86/amd/Makefile
+++ b/drivers/platform/x86/amd/Makefile
@@ -4,7 +4,7 @@
 # AMD x86 Platform-Specific Drivers
 #
 
-amd-pmc-y			:= pmc.o
+amd-pmc-y			:= pmc.o pmc-quirks.o
 obj-$(CONFIG_AMD_PMC)		+= amd-pmc.o
 amd_hsmp-y			:= hsmp.o
 obj-$(CONFIG_AMD_HSMP)		+= amd_hsmp.o
diff --git a/drivers/platform/x86/amd/pmc-quirks.c b/drivers/platform/x86/amd/pmc-quirks.c
new file mode 100644
index 0000000000000..387855ccea812
--- /dev/null
+++ b/drivers/platform/x86/amd/pmc-quirks.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD SoC Power Management Controller Driver Quirks
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Mario Limonciello <mario.limonciello@amd.com>
+ */
+
+#include <linux/dmi.h>
+
+#include "pmc.h"
+
+struct quirk_entry {
+	u32 s2idle_bug_mmio;
+};
+
+static struct quirk_entry quirk_s2idle_bug = {
+	.s2idle_bug_mmio = 0xfed80380,
+};
+
+static const struct dmi_system_id fwbug_list[] = {
+	{
+		.ident = "L14 Gen2 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20X5"),
+		}
+	},
+	{
+		.ident = "T14s Gen2 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20XF"),
+		}
+	},
+	{
+		.ident = "X13 Gen2 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20XH"),
+		}
+	},
+	{
+		.ident = "T14 Gen2 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20XK"),
+		}
+	},
+	{
+		.ident = "T14 Gen1 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20UD"),
+		}
+	},
+	{
+		.ident = "T14 Gen1 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20UE"),
+		}
+	},
+	{
+		.ident = "T14s Gen1 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20UH"),
+		}
+	},
+	{
+		.ident = "T14s Gen1 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20UJ"),
+		}
+	},
+	{
+		.ident = "P14s Gen1 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "20Y1"),
+		}
+	},
+	{
+		.ident = "P14s Gen2 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21A0"),
+		}
+	},
+	{
+		.ident = "P14s Gen2 AMD",
+		.driver_data = &quirk_s2idle_bug,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21A1"),
+		}
+	},
+	{}
+};
+
+/*
+ * Laptops that run a SMI handler during the D3->D0 transition that occurs
+ * specifically when exiting suspend to idle which can cause
+ * large delays during resume when the IOMMU translation layer is enabled (the default
+ * behavior) for NVME devices:
+ *
+ * To avoid this firmware problem, skip the SMI handler on these machines before the
+ * D0 transition occurs.
+ */
+static void amd_pmc_skip_nvme_smi_handler(u32 s2idle_bug_mmio)
+{
+	struct resource *res;
+	void __iomem *addr;
+	u8 val;
+
+	res = request_mem_region_muxed(s2idle_bug_mmio, 1, "amd_pmc_pm80");
+	if (!res)
+		return;
+
+	addr = ioremap(s2idle_bug_mmio, 1);
+	if (!addr)
+		goto cleanup_resource;
+
+	val = ioread8(addr);
+	iowrite8(val & ~BIT(0), addr);
+
+	iounmap(addr);
+cleanup_resource:
+	release_resource(res);
+	kfree(res);
+}
+
+void amd_pmc_process_restore_quirks(struct amd_pmc_dev *dev)
+{
+	if (dev->quirks && dev->quirks->s2idle_bug_mmio)
+		amd_pmc_skip_nvme_smi_handler(dev->quirks->s2idle_bug_mmio);
+}
+
+void amd_pmc_quirks_init(struct amd_pmc_dev *dev)
+{
+	const struct dmi_system_id *dmi_id;
+
+	dmi_id = dmi_first_match(fwbug_list);
+	if (!dmi_id)
+		return;
+	dev->quirks = dmi_id->driver_data;
+	if (dev->quirks->s2idle_bug_mmio)
+		pr_info("Using s2idle quirk to avoid %s platform firmware bug\n",
+			dmi_id->ident);
+}
diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
index f7bda8a64c955..586ba3a56e189 100644
--- a/drivers/platform/x86/amd/pmc.c
+++ b/drivers/platform/x86/amd/pmc.c
@@ -20,7 +20,6 @@
 #include <linux/iopoll.h>
 #include <linux/limits.h>
 #include <linux/module.h>
-#include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 #include <linux/serio.h>
@@ -28,6 +27,8 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 
+#include "pmc.h"
+
 /* SMU communication registers */
 #define AMD_PMC_REGISTER_MESSAGE	0x538
 #define AMD_PMC_REGISTER_RESPONSE	0x980
@@ -146,29 +147,6 @@ static const struct amd_pmc_bit_map soc15_ip_blk[] = {
 	{}
 };
 
-struct amd_pmc_dev {
-	void __iomem *regbase;
-	void __iomem *smu_virt_addr;
-	void __iomem *stb_virt_addr;
-	void __iomem *fch_virt_addr;
-	bool msg_port;
-	u32 base_addr;
-	u32 cpu_id;
-	u32 active_ips;
-	u32 dram_size;
-	u32 num_ips;
-	u32 s2d_msg_id;
-/* SMU version information */
-	u8 smu_program;
-	u8 major;
-	u8 minor;
-	u8 rev;
-	struct device *dev;
-	struct pci_dev *rdev;
-	struct mutex lock; /* generic mutex lock */
-	struct dentry *dbgfs_dir;
-};
-
 static bool enable_stb;
 module_param(enable_stb, bool, 0644);
 MODULE_PARM_DESC(enable_stb, "Enable the STB debug mechanism");
@@ -891,6 +869,8 @@ static void amd_pmc_s2idle_restore(void)
 
 	/* Notify on failed entry */
 	amd_pmc_validate_deepest(pdev);
+
+	amd_pmc_process_restore_quirks(pdev);
 }
 
 static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops = {
@@ -1087,6 +1067,8 @@ static int amd_pmc_probe(struct platform_device *pdev)
 		err = acpi_register_lps0_dev(&amd_pmc_s2idle_dev_ops);
 		if (err)
 			dev_warn(dev->dev, "failed to register LPS0 sleep handler, expect increased power consumption\n");
+		if (!disable_workarounds)
+			amd_pmc_quirks_init(dev);
 	}
 
 	amd_pmc_dbgfs_register(dev);
diff --git a/drivers/platform/x86/amd/pmc.h b/drivers/platform/x86/amd/pmc.h
new file mode 100644
index 0000000000000..8f78985ba340b
--- /dev/null
+++ b/drivers/platform/x86/amd/pmc.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * AMD SoC Power Management Controller Driver
+ *
+ * Copyright (c) 2023, Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Author: Mario Limonciello <mario.limonciello@amd.com>
+ */
+
+#ifndef PMC_H
+#define PMC_H
+
+#include <linux/pci.h>
+
+struct amd_pmc_dev {
+	void __iomem *regbase;
+	void __iomem *smu_virt_addr;
+	void __iomem *stb_virt_addr;
+	void __iomem *fch_virt_addr;
+	bool msg_port;
+	u32 base_addr;
+	u32 cpu_id;
+	u32 active_ips;
+	u32 dram_size;
+	u32 num_ips;
+	u32 s2d_msg_id;
+/* SMU version information */
+	u8 smu_program;
+	u8 major;
+	u8 minor;
+	u8 rev;
+	struct device *dev;
+	struct pci_dev *rdev;
+	struct mutex lock; /* generic mutex lock */
+	struct dentry *dbgfs_dir;
+	struct quirk_entry *quirks;
+};
+
+void amd_pmc_process_restore_quirks(struct amd_pmc_dev *dev);
+void amd_pmc_quirks_init(struct amd_pmc_dev *dev);
+
+#endif /* PMC_H */
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 187018ffb0686..ad460417f901a 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -315,17 +315,12 @@ struct ibm_init_struct {
 /* DMI Quirks */
 struct quirk_entry {
 	bool btusb_bug;
-	u32 s2idle_bug_mmio;
 };
 
 static struct quirk_entry quirk_btusb_bug = {
 	.btusb_bug = true,
 };
 
-static struct quirk_entry quirk_s2idle_bug = {
-	.s2idle_bug_mmio = 0xfed80380,
-};
-
 static struct {
 	u32 bluetooth:1;
 	u32 hotkey:1;
@@ -4422,136 +4417,9 @@ static const struct dmi_system_id fwbug_list[] __initconst = {
 			DMI_MATCH(DMI_BOARD_NAME, "20MV"),
 		},
 	},
-	{
-		.ident = "L14 Gen2 AMD",
-		.driver_data = &quirk_s2idle_bug,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20X5"),
-		}
-	},
-	{
-		.ident = "T14s Gen2 AMD",
-		.driver_data = &quirk_s2idle_bug,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20XF"),
-		}
-	},
-	{
-		.ident = "X13 Gen2 AMD",
-		.driver_data = &quirk_s2idle_bug,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20XH"),
-		}
-	},
-	{
-		.ident = "T14 Gen2 AMD",
-		.driver_data = &quirk_s2idle_bug,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20XK"),
-		}
-	},
-	{
-		.ident = "T14 Gen1 AMD",
-		.driver_data = &quirk_s2idle_bug,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20UD"),
-		}
-	},
-	{
-		.ident = "T14 Gen1 AMD",
-		.driver_data = &quirk_s2idle_bug,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20UE"),
-		}
-	},
-	{
-		.ident = "T14s Gen1 AMD",
-		.driver_data = &quirk_s2idle_bug,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20UH"),
-		}
-	},
-	{
-		.ident = "T14s Gen1 AMD",
-		.driver_data = &quirk_s2idle_bug,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20UJ"),
-		}
-	},
-	{
-		.ident = "P14s Gen1 AMD",
-		.driver_data = &quirk_s2idle_bug,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "20Y1"),
-		}
-	},
-	{
-		.ident = "P14s Gen2 AMD",
-		.driver_data = &quirk_s2idle_bug,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "21A0"),
-		}
-	},
-	{
-		.ident = "P14s Gen2 AMD",
-		.driver_data = &quirk_s2idle_bug,
-		.matches = {
-			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "21A1"),
-		}
-	},
 	{}
 };
 
-#ifdef CONFIG_SUSPEND
-/*
- * Lenovo laptops from a variety of generations run a SMI handler during the D3->D0
- * transition that occurs specifically when exiting suspend to idle which can cause
- * large delays during resume when the IOMMU translation layer is enabled (the default
- * behavior) for NVME devices:
- *
- * To avoid this firmware problem, skip the SMI handler on these machines before the
- * D0 transition occurs.
- */
-static void thinkpad_acpi_amd_s2idle_restore(void)
-{
-	struct resource *res;
-	void __iomem *addr;
-	u8 val;
-
-	res = request_mem_region_muxed(tp_features.quirks->s2idle_bug_mmio, 1,
-					"thinkpad_acpi_pm80");
-	if (!res)
-		return;
-
-	addr = ioremap(tp_features.quirks->s2idle_bug_mmio, 1);
-	if (!addr)
-		goto cleanup_resource;
-
-	val = ioread8(addr);
-	iowrite8(val & ~BIT(0), addr);
-
-	iounmap(addr);
-cleanup_resource:
-	release_resource(res);
-	kfree(res);
-}
-
-static struct acpi_s2idle_dev_ops thinkpad_acpi_s2idle_dev_ops = {
-	.restore = thinkpad_acpi_amd_s2idle_restore,
-};
-#endif
-
 static const struct pci_device_id fwbug_cards_ids[] __initconst = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x24F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x24FD) },
@@ -11668,10 +11536,6 @@ static void thinkpad_acpi_module_exit(void)
 
 	tpacpi_lifecycle = TPACPI_LIFE_EXITING;
 
-#ifdef CONFIG_SUSPEND
-	if (tp_features.quirks && tp_features.quirks->s2idle_bug_mmio)
-		acpi_unregister_lps0_dev(&thinkpad_acpi_s2idle_dev_ops);
-#endif
 	if (tpacpi_hwmon)
 		hwmon_device_unregister(tpacpi_hwmon);
 	if (tp_features.sensors_pdrv_registered)
@@ -11861,13 +11725,6 @@ static int __init thinkpad_acpi_module_init(void)
 		tp_features.input_device_registered = 1;
 	}
 
-#ifdef CONFIG_SUSPEND
-	if (tp_features.quirks && tp_features.quirks->s2idle_bug_mmio) {
-		if (!acpi_register_lps0_dev(&thinkpad_acpi_s2idle_dev_ops))
-			pr_info("Using s2idle quirk to avoid %s platform firmware bug\n",
-				(dmi_id && dmi_id->ident) ? dmi_id->ident : "");
-	}
-#endif
 	return 0;
 }
 
-- 
2.34.1

