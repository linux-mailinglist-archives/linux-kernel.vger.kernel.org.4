Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BAE736297
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 06:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjFTEPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 00:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjFTEPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:15:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3093CE6C;
        Mon, 19 Jun 2023 21:14:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iw3GLUODeBopP8Mhbv416u/ZkPrF0q6a8OtXXX/49p19OyRLi2AmfmoPenUDmIq+l6hOKe37gj3P6OB6sssrdYrxuUP5I2keDVJCErsB25Pg/OzE7uBt5heEUwDUitpQuaR7uuJZLH/cIT1nxak1fzLObXaO59YQOadi0hVrzjeoVghGMERrc/lSirD4LN3SzmJ8DpF8MIFg+FP/MXyuv4uO4iQi30qJ614ucnM3gW8pyQCYv2XgneYwalwb8+YlpvoTG255rhzrit9m6l5OCUlo1RRGE5oLg+nZ70DqX0nswrVvUphewxEQhMi5sE9ELPGzu99sdjIOBwHrD0Ml3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HL0PaeDXOWqazAYr6KNBtqsIehA3cdQw+NTkqCpIBX4=;
 b=nhnI3wVYPSgaCPTY6c5piEuSKruc9fwiAoyM/MGkzt72vavEnKwciB8/+UguZCSwfFm7rtC8y7EXI980BTUNfvFd2JbgV/CUq2E4bcqnGtDoXaliIh5fK0COmZBw9W2ffATDCfpxCt+Je2OnoQ3vfYH+tOAmdH2wi5v16xoQxRaNGigNYAM7sRPRCJleaVDVg/MtgGD9qLRpwauNSzMlIyM/YBdbkLVScqHMsWMgFKBaNY1qm2jAABLPRkxOSyx3Fz7HPH4qJup1WqMjUsLm9Ag/EGqVWZnTycZJ6ReU1LYhVlUrMMU4XBLPchp/fvWgtVg3smXkqoz3Ck6RKeQTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HL0PaeDXOWqazAYr6KNBtqsIehA3cdQw+NTkqCpIBX4=;
 b=aanYhV4XsUXHDMygoSiuA1tYvDqj/BQcvR61D9RHWnVmSmcrsgSS8TMD8bMGP78em3hgBQU5mmx6+jM00btjiTr221ReXXLGu/fQarBD/04+WpNTiW2cSFhBfiGf2eJAlkASeESrJ6BBMO3nPUsDdMDVt3iGGZRgpHwnHsQPtExunLeum+/uCz+Z5iCwFQQw9K3wuT3M86aJekdMB32zYBvpyDDz4dlObcQe8aQrhto6cOazCCoTE0H8EVSwt2LZUr3dPL53HqpkBD95BcnGjPYiLP7gvIhao+4rkAMQ1Tn3l3EhlQoCOB2iLSJJWoWHf+8u9YPhIbYoS97XS/f3OQ==
Received: from DM5PR07CA0063.namprd07.prod.outlook.com (2603:10b6:4:ad::28) by
 BY5PR12MB4226.namprd12.prod.outlook.com (2603:10b6:a03:203::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 04:14:55 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:4:ad:cafe::54) by DM5PR07CA0063.outlook.office365.com
 (2603:10b6:4:ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Tue, 20 Jun 2023 04:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.19 via Frontend Transport; Tue, 20 Jun 2023 04:14:54 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 19 Jun 2023
 21:14:53 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 19 Jun
 2023 21:14:53 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 19 Jun 2023 21:14:52 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <suzuki.poulose@arm.com>, <robin.murphy@arm.com>,
        <ilkka@os.amperecomputing.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <rwiley@nvidia.com>, <efunsten@nvidia.com>,
        "Besar Wicaksono" <bwicaksono@nvidia.com>
Subject: [PATCH v4] perf: arm_cspmu: Separate Arm and vendor module
Date:   Mon, 19 Jun 2023 23:14:38 -0500
Message-ID: <20230620041438.32514-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|BY5PR12MB4226:EE_
X-MS-Office365-Filtering-Correlation-Id: 407f9948-8089-41a1-771a-08db7144e6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 37MWe7gugELLpre9wQYTDc/m8LtfSFeZttRhhWWEZZabxdxLCEFObq9VCQ8ivN1cppEQRdrvVncD8f1NHQ6byc2mo0Lh4tROprTFE+tIZ1F2yV05mSPi3WBdWd/NIH4WNVa6itkBm4VzpVZLiVXz25G67NXGIT75di/bNc/hvVvegVMVATyFbAVrfPCo9wBp//571qFOjzW6a0fJOtoVaaGBxhzLPT8oxi01ZeAzK/DcVkIcsWncepG+UhYdt7ZxFBWW9gtm6mLcm6DDCKM4y4t2P9edCDZ8GwlNgwJLamNpQN8aZsVPiTfOcfhbf02bX05ECqSZo0qS8JYiM90DycT6BNzgQw7GnZsvKOPtIF0XrLQvlZahcw+VENc5qoNFG9GQEHbnSOfM4kkLrn0zGqJWTjw/xWlMeh+I3QfhUAd2zhgPiamoIVOS73x8wsXdgGnWbolBSw+ooqqIIGxn/ByTrQ5l4HugWoFcFqDde2eQjkldKT1AJ2D5pO5NLuAMPQQD4WZi6ovyHB6bkYqnRjgaIdOpbPrXupwXMpdEYRC4+7GXVWbUqxB6NlRK6yFBv/XB+fNaNiWrjPxPsiSSZrIo5nJxX/lmVmmMiYch992RRC84HPUYDNdlsodWSsUp3OlVfTZvmdSyEYsko69u25AZXRKECZx5t9AmWVPgk7/SvcGVkJjmK6XdLx6wYjhZkEaiGMwHIXR73B740ycWNUXgszpFISuUHn0hTpUbL5dd31arb+Hvrtez+Sl/S+Ax1QRXDFDU2EGOec78EuFlWjRTLlK+vnhAVUyKq+Jr42ZFDNJHmAXCg6qBzByCQ3ef
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(46966006)(40470700004)(36840700001)(2616005)(36860700001)(110136005)(54906003)(426003)(336012)(107886003)(83380400001)(47076005)(26005)(1076003)(966005)(36756003)(6666004)(86362001)(478600001)(356005)(7696005)(7636003)(82740400003)(316002)(2906002)(30864003)(41300700001)(4326008)(82310400005)(70586007)(70206006)(5660300002)(8676002)(8936002)(186003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 04:14:54.8721
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 407f9948-8089-41a1-771a-08db7144e6f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4226
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm Coresight PMU driver consists of main standard code and
vendor backend code. Both are currently built as a single module.
This patch adds vendor registration API to separate the two to
keep things modular. The main driver requests each known backend
module during initialization and defer device binding process.
The backend module then registers an init callback to the main
driver and continue the device driver binding process.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---

Changes from v3:
 * Move impl registration module back to main driver module.
 * Rebase from will (for-next/perf)
Thanks to Robin for the feedback.
v3: https://lore.kernel.org/linux-arm-kernel/20230505005956.22837-1-bwicaksono@nvidia.com/T/#u

Changes from v2:
 * Move sysfs_event/format_show definition to arm_cspmu.h and move impl
   registration API definition to a separate module so main driver and vendor
   module are independent.
 * The registration API now just sets the impl_init_ops callback, no reprobe.
 * Add PMIIDR table that maps to the vendor module name. During device probe,
   main driver requests the vendor module if PMIIDR is matching.
 * Keeping the name of the main driver module as arm_cspmu_module.
Thanks to Robin and Suzuki for the feedback.
v2:  https://lore.kernel.org/linux-arm-kernel/20230418062030.45620-1-bwicaksono@nvidia.com/T/#u

Changes from v1:
 * Added separate Kconfig entry for nvidia backend
 * Added lock to protect accesses to the lists
 * Added support for matching subset devices from a vendor
 * Added state tracking to avoid reprobe when a device is in use
Thanks to Suzuki for the feedback.
v1: https://lore.kernel.org/linux-arm-kernel/20230403163905.20354-1-bwicaksono@nvidia.com/T/#u

---
 drivers/perf/arm_cspmu/Kconfig        |   9 +-
 drivers/perf/arm_cspmu/Makefile       |   6 +-
 drivers/perf/arm_cspmu/arm_cspmu.c    | 166 +++++++++++++++++++++-----
 drivers/perf/arm_cspmu/arm_cspmu.h    |  24 +++-
 drivers/perf/arm_cspmu/nvidia_cspmu.c |  34 +++++-
 drivers/perf/arm_cspmu/nvidia_cspmu.h |  17 ---
 6 files changed, 199 insertions(+), 57 deletions(-)
 delete mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h

diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
index 25d25ded0983..d5f787d22234 100644
--- a/drivers/perf/arm_cspmu/Kconfig
+++ b/drivers/perf/arm_cspmu/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
 	tristate "ARM Coresight Architecture PMU"
@@ -10,3 +10,10 @@ config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
 	  based on ARM CoreSight PMU architecture. Note that this PMU
 	  architecture does not have relationship with the ARM CoreSight
 	  Self-Hosted Tracing.
+
+config NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU
+	tristate "NVIDIA Coresight Architecture PMU"
+	depends on ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
+	help
+	  Provides NVIDIA specific attributes for performance monitoring unit
+	  (PMU) devices based on ARM CoreSight PMU architecture.
diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
index fedb17df982d..0309d2ff264a 100644
--- a/drivers/perf/arm_cspmu/Makefile
+++ b/drivers/perf/arm_cspmu/Makefile
@@ -1,6 +1,8 @@
-# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 #
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_module.o
-arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o
+arm_cspmu_module-y := arm_cspmu.o
+
+obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += nvidia_cspmu.o
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index e2b7827c4563..6a824201c92a 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -16,7 +16,7 @@
  * The user should refer to the vendor technical documentation to get details
  * about the supported events.
  *
- * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
  *
  */
 
@@ -26,11 +26,11 @@
 #include <linux/interrupt.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 
 #include "arm_cspmu.h"
-#include "nvidia_cspmu.h"
 
 #define PMUNAME "arm_cspmu"
 #define DRVNAME "arm-cs-arch-pmu"
@@ -112,11 +112,10 @@
  */
 #define HILOHI_MAX_POLL	1000
 
-/* JEDEC-assigned JEP106 identification code */
-#define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
-
 static unsigned long arm_cspmu_cpuhp_state;
 
+static DEFINE_MUTEX(arm_cspmu_lock);
+
 static struct acpi_apmt_node *arm_cspmu_apmt_node(struct device *dev)
 {
 	return *(struct acpi_apmt_node **)dev_get_platdata(dev);
@@ -373,27 +372,37 @@ static struct attribute_group arm_cspmu_cpumask_attr_group = {
 	.attrs = arm_cspmu_cpumask_attrs,
 };
 
-struct impl_match {
-	u32 pmiidr;
-	u32 mask;
-	int (*impl_init_ops)(struct arm_cspmu *cspmu);
-};
-
-static const struct impl_match impl_match[] = {
+static struct arm_cspmu_impl_match impl_match[] = {
 	{
-	  .pmiidr = ARM_CSPMU_IMPL_ID_NVIDIA,
-	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
-	  .impl_init_ops = nv_cspmu_init_ops
+		.module_name	= "nvidia_cspmu",
+		.pmiidr_val	= ARM_CSPMU_IMPL_ID_NVIDIA,
+		.pmiidr_mask	= ARM_CSPMU_PMIIDR_IMPLEMENTER,
+		.module		= NULL,
+		.impl_init_ops	= NULL,
 	},
-	{}
+	{0}
 };
 
+struct arm_cspmu_impl_match *arm_cspmu_impl_match_get(u32 pmiidr)
+{
+	struct arm_cspmu_impl_match *match = impl_match;
+
+	for (; match->pmiidr_val; match++) {
+		u32 mask = match->pmiidr_mask;
+
+		if ((match->pmiidr_val & mask) == (pmiidr & mask))
+			break;
+	}
+
+	return match;
+}
+
 static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 {
-	int ret;
+	int ret = 0;
 	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
 	struct acpi_apmt_node *apmt_node = arm_cspmu_apmt_node(cspmu->dev);
-	const struct impl_match *match = impl_match;
+	struct arm_cspmu_impl_match *match;
 
 	/*
 	 * Get PMU implementer and product id from APMT node.
@@ -405,16 +414,31 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 				       readl(cspmu->base0 + PMIIDR);
 
 	/* Find implementer specific attribute ops. */
-	for (; match->pmiidr; match++) {
-		const u32 mask = match->mask;
+	match = arm_cspmu_impl_match_get(cspmu->impl.pmiidr);
+
+	/* Load implementer module and initialize the callbacks. */
+	if (match) {
+		mutex_lock(&arm_cspmu_lock);
+
+		if (match->impl_init_ops) {
+			if (try_module_get(match->module)) {
+				cspmu->impl.match = match;
+				ret = match->impl_init_ops(cspmu);
+				module_put(match->module);
+			} else {
+				WARN(1, "arm_cspmu failed to get module: %s\n",
+					match->module_name);
+				ret = -EINVAL;
+			}
+		} else {
+			request_module_nowait(match->module_name);
+			ret = -EPROBE_DEFER;
+		}
 
-		if ((match->pmiidr & mask) == (cspmu->impl.pmiidr & mask)) {
-			ret = match->impl_init_ops(cspmu);
-			if (ret)
-				return ret;
+		mutex_unlock(&arm_cspmu_lock);
 
-			break;
-		}
+		if (ret)
+			return ret;
 	}
 
 	/* Use default callbacks if implementer doesn't provide one. */
@@ -478,11 +502,6 @@ arm_cspmu_alloc_attr_group(struct arm_cspmu *cspmu)
 	struct attribute_group **attr_groups = NULL;
 	struct device *dev = cspmu->dev;
 	const struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
-	int ret;
-
-	ret = arm_cspmu_init_impl_ops(cspmu);
-	if (ret)
-		return NULL;
 
 	cspmu->identifier = impl_ops->get_identifier(cspmu);
 	cspmu->name = impl_ops->get_name(cspmu);
@@ -1129,6 +1148,11 @@ static int arm_cspmu_get_cpus(struct arm_cspmu *cspmu)
 	return arm_cspmu_acpi_get_cpus(cspmu);
 }
 
+static inline struct module *arm_cspmu_get_module(struct arm_cspmu *cspmu)
+{
+	return (cspmu->impl.match) ? cspmu->impl.match->module : THIS_MODULE;
+}
+
 static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
 {
 	int ret, capabilities;
@@ -1149,7 +1173,7 @@ static int arm_cspmu_register_pmu(struct arm_cspmu *cspmu)
 
 	cspmu->pmu = (struct pmu){
 		.task_ctx_nr	= perf_invalid_context,
-		.module		= THIS_MODULE,
+		.module		= arm_cspmu_get_module(cspmu),
 		.pmu_enable	= arm_cspmu_enable,
 		.pmu_disable	= arm_cspmu_disable,
 		.event_init	= arm_cspmu_event_init,
@@ -1196,6 +1220,10 @@ static int arm_cspmu_device_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = arm_cspmu_init_impl_ops(cspmu);
+	if (ret)
+		return ret;
+
 	ret = arm_cspmu_register_pmu(cspmu);
 	if (ret)
 		return ret;
@@ -1300,6 +1328,80 @@ static void __exit arm_cspmu_exit(void)
 	cpuhp_remove_multi_state(arm_cspmu_cpuhp_state);
 }
 
+int arm_cspmu_impl_register(const struct arm_cspmu_impl_match *impl_match)
+{
+	struct arm_cspmu_impl_match *match;
+	int ret = 0;
+
+	match = arm_cspmu_impl_match_get(impl_match->pmiidr_val);
+
+	if (match) {
+		mutex_lock(&arm_cspmu_lock);
+
+		if (!match->impl_init_ops) {
+			match->module = impl_match->module;
+			match->impl_init_ops = impl_match->impl_init_ops;
+		} else {
+			/* Broken match table may contain non-unique entries */
+			WARN(1, "arm_cspmu backend already registered for module: %s, pmiidr: 0x%x, mask: 0x%x\n",
+				match->module_name,
+				match->pmiidr_val,
+				match->pmiidr_mask);
+
+			ret = -EINVAL;
+		}
+
+		mutex_unlock(&arm_cspmu_lock);
+
+		if (!ret)
+			ret = driver_attach(&arm_cspmu_driver.driver);
+	} else {
+		pr_err("arm_cspmu reg failed, unable to find a match for pmiidr: 0x%x\n",
+			impl_match->pmiidr_val);
+
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(arm_cspmu_impl_register);
+
+static int arm_cspmu_match_device(struct device *dev, const void *match)
+{
+	struct arm_cspmu *cspmu = platform_get_drvdata(to_platform_device(dev));
+
+	return (cspmu && cspmu->impl.match == match) ? 1 : 0;
+}
+
+void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_match *impl_match)
+{
+	struct device *dev;
+	struct arm_cspmu_impl_match *match;
+
+	match = arm_cspmu_impl_match_get(impl_match->pmiidr_val);
+
+	WARN_ON(!match);
+
+	if (match) {
+		/* Unbind the driver from all matching backend devices. */
+dev_release:
+		dev = driver_find_device(&arm_cspmu_driver.driver, NULL,
+			match, arm_cspmu_match_device);
+		if (dev) {
+			device_release_driver(dev);
+			goto dev_release;
+		}
+
+		mutex_lock(&arm_cspmu_lock);
+
+		match->module = NULL;
+		match->impl_init_ops = NULL;
+
+		mutex_unlock(&arm_cspmu_lock);
+	}
+}
+EXPORT_SYMBOL_GPL(arm_cspmu_impl_unregister);
+
 module_init(arm_cspmu_init);
 module_exit(arm_cspmu_exit);
 
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index 83df53d1c132..e5c6dff2ce7f 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.h
+++ b/drivers/perf/arm_cspmu/arm_cspmu.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0
  *
  * ARM CoreSight Architecture PMU driver.
- * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
  *
  */
 
@@ -69,6 +69,9 @@
 #define ARM_CSPMU_PMIIDR_IMPLEMENTER	GENMASK(11, 0)
 #define ARM_CSPMU_PMIIDR_PRODUCTID	GENMASK(31, 20)
 
+/* JEDEC-assigned JEP106 identification code */
+#define ARM_CSPMU_IMPL_ID_NVIDIA	0x36B
+
 struct arm_cspmu;
 
 /* This tracks the events assigned to each counter in the PMU. */
@@ -106,9 +109,22 @@ struct arm_cspmu_impl_ops {
 					 struct attribute *attr, int unused);
 };
 
+/* Vendor/implementer registration parameter. */
+struct arm_cspmu_impl_match {
+	/* Backend module. */
+	struct module *module;
+	const char *module_name;
+	/* PMIIDR value/mask. */
+	u32 pmiidr_val;
+	u32 pmiidr_mask;
+	/* Callback to vendor backend to init arm_cspmu_impl::ops. */
+	int (*impl_init_ops)(struct arm_cspmu *cspmu);
+};
+
 /* Vendor/implementer descriptor. */
 struct arm_cspmu_impl {
 	u32 pmiidr;
+	struct arm_cspmu_impl_match *match;
 	struct arm_cspmu_impl_ops ops;
 	void *ctx;
 };
@@ -147,4 +163,10 @@ ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf);
 
+/* Register vendor backend. */
+int arm_cspmu_impl_register(const struct arm_cspmu_impl_match *impl_match);
+
+/* Unregister vendor backend. */
+void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_match *impl_match);
+
 #endif /* __ARM_CSPMU_H__ */
diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
index 72ef80caa3c8..0382b702f092 100644
--- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
+++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
@@ -1,14 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
  *
  */
 
 /* Support for NVIDIA specific attributes. */
 
+#include <linux/module.h>
 #include <linux/topology.h>
 
-#include "nvidia_cspmu.h"
+#include "arm_cspmu.h"
 
 #define NV_PCIE_PORT_COUNT           10ULL
 #define NV_PCIE_FILTER_ID_MASK       GENMASK_ULL(NV_PCIE_PORT_COUNT - 1, 0)
@@ -351,7 +352,7 @@ static char *nv_cspmu_format_name(const struct arm_cspmu *cspmu,
 	return name;
 }
 
-int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
+static int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
 {
 	u32 prodid;
 	struct nv_cspmu_ctx *ctx;
@@ -395,6 +396,31 @@ int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nv_cspmu_init_ops);
+
+/* Match all NVIDIA Coresight PMU devices */
+static const struct arm_cspmu_impl_match nv_cspmu_param = {
+	.pmiidr_val	= ARM_CSPMU_IMPL_ID_NVIDIA,
+	.module		= THIS_MODULE,
+	.impl_init_ops	= nv_cspmu_init_ops
+};
+
+static int __init nvidia_cspmu_init(void)
+{
+	int ret;
+
+	ret = arm_cspmu_impl_register(&nv_cspmu_param);
+	if (ret)
+		pr_err("nvidia_cspmu backend registration error: %d\n", ret);
+
+	return ret;
+}
+
+static void __exit nvidia_cspmu_exit(void)
+{
+	arm_cspmu_impl_unregister(&nv_cspmu_param);
+}
+
+module_init(nvidia_cspmu_init);
+module_exit(nvidia_cspmu_exit);
 
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.h b/drivers/perf/arm_cspmu/nvidia_cspmu.h
deleted file mode 100644
index 71e18f0dc50b..000000000000
--- a/drivers/perf/arm_cspmu/nvidia_cspmu.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0
- *
- * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
- *
- */
-
-/* Support for NVIDIA specific attributes. */
-
-#ifndef __NVIDIA_CSPMU_H__
-#define __NVIDIA_CSPMU_H__
-
-#include "arm_cspmu.h"
-
-/* Allocate NVIDIA descriptor. */
-int nv_cspmu_init_ops(struct arm_cspmu *cspmu);
-
-#endif /* __NVIDIA_CSPMU_H__ */

base-commit: ea8d1c062a0e876e999e4f347daeb598d5e677ab
-- 
2.17.1

