Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEC36D4E22
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjDCQjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDCQjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:39:46 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704CB1721;
        Mon,  3 Apr 2023 09:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb2rFrsuyIcJNSxDKym3WlKaqTMLQVS5DtcFJ7MhTooLHZIy3RpXf6AbsUQQIv1V7JxrtcKhaYjg1NsUMdmVaq8eub5bciFeBu7WGWV+a+ToO1Fi9AEddBysgT7fNqIj1vpCHUN7F089ghgTbC4iw56w/JQCdeRjK/H0jlmWGeVro4Hy7ludcWGNtPFerebPohO724k9WfP3nRihbzN434UGgoOLe3FXCiyGmekOYpod6WUGBfD7X/38RfBAp0DyLuZa3Lm0Sg4hreMKUCADcW2UBBeEd3FLOjSmZR/y/qy3HzHRbdx6bL3ElcNKXIptHDpSowSmfWtAH+oXphapDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lvMx3TQoltuImMR1BwsVYv8SfTbCeyMGXz5YJiK0lA=;
 b=JmEo5eavWCB+spGK4q95sJyHc4ahrmgXq11/+6NUsrFYKv5DYZMFlkairslauW9Ao3D5Lt5RvHExwh+cOzwH51Lzr67Ksz9qZAMzgUQY4TZiXl+bv/AB1Fxfmbfd8ruEEq2CKwYQ5U4xxatDcArVsT5FHKD6B+IeBk/alH1oky1h6otLYJG5kTY39NW2/aeSmw3ibL2LDKTuxbNLG5P2Lu8WYarW3sidHfzaG4Hz3cARbcJnKVaCpjCSTEFjnK6Q35vUglQ5RdtMibHpQ9HU0AXk3Mq1nNFHjJXpotaXJtCbpCh24377MrCraTL+aw8rLSGFqMzWSoFkjmOS+siZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lvMx3TQoltuImMR1BwsVYv8SfTbCeyMGXz5YJiK0lA=;
 b=SdOBCtBNaSZLskM3hjFR98e3GLOu9csGae40Iz2Ut4UNiz7G8ytvqxWxsaq1K3SH0ejy6kOw3fX7w2Iwvu9YwrgbA6VZGWtBSB52ut/a2p48r47ujckN5bjQVEDKVo52Z4DN54HbD+1UG/KcsdljvbW4P1MHSbG9lzjZi+CwQlCPSXpUA/3f2exfv9GXQ5zY+/bVtflKJNdaJX79JsIE+bdb/+Sg4tPcAmXUK4gFUsRNm9b6ZwEswMEuiwY3yXGjKcxlxcCf03Qr1F44znmiYpEeT2p2sbKAKJCYyDR0MOwQrcyGT5zG2ewe3Rv9rrLjS5ASrtCmmpAgtlVeKLFC5w==
Received: from DM6PR02CA0103.namprd02.prod.outlook.com (2603:10b6:5:1f4::44)
 by IA0PR12MB8087.namprd12.prod.outlook.com (2603:10b6:208:401::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 16:39:42 +0000
Received: from DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::ac) by DM6PR02CA0103.outlook.office365.com
 (2603:10b6:5:1f4::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Mon, 3 Apr 2023 16:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT035.mail.protection.outlook.com (10.13.172.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.18 via Frontend Transport; Mon, 3 Apr 2023 16:39:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 3 Apr 2023
 09:39:33 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 3 Apr 2023
 09:39:33 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 3 Apr 2023 09:39:31 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <suzuki.poulose@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <rwiley@nvidia.com>, <efunsten@nvidia.com>,
        "Besar Wicaksono" <bwicaksono@nvidia.com>
Subject: [PATCH] perf: arm_cspmu: Separate Arm and vendor module
Date:   Mon, 3 Apr 2023 11:39:05 -0500
Message-ID: <20230403163905.20354-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT035:EE_|IA0PR12MB8087:EE_
X-MS-Office365-Filtering-Correlation-Id: d84f6704-1b47-40e8-7c58-08db34620638
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+zPl1JoOj9Tt+E2d5S1z8ZQwTBV462uOhrNvPzSb6G3JZklV2DD0/H1SK1Gg1SCs+SuOSDLyDd7Acyj/VEfHL5Fs85lk9GiEP14oRoFk8hw5CbcXIlfzcZnjM34M6r/1AWDn8HqHsmHD9bcKmvo4D/AGcdfhDwwcsYPj8UuK0h45ImpT92/gKfQiNEmvDTDJ3aP1oWMZj1zO+vH+Ph/MvkqxXF1JIvSXUqQacVlq4D5JXwmldKMiyn4H63JklvuIW8C54rq0OYMwMszyaTKFGckbQzOEU/LITJxsQs5OUPWNjr1DzcEOzvp+xLscpiwYiPaBtGLyOLeefsMxnrRNIuPnCcKMmbzZ0474kDRuZq5GpguCMpf5Jm+wwR1CBuQ8WAB0rr8bSmBVmk49l+oS9fYvQOY1r3K0+VwsbbF7MDABQI2YhY9FzemiocgGIvykO07iSvYlUbHlK+wQW3sYZQ+a6sPyb7/+QL3OHtdtg6YVHxr6mjdmZUC+baXN5OL1aECCV+sprDuA7+MQuYTnpdHUiq+N9uKo7jMRPo4KT0JxNZk4xsEKT8I90CWbCMcyfXg0LeSD+vbg2ys+cSGY0XQUL/sEp26sQqW7VLLutj7JR5o6kQX1ZGfvzgVPuGcpljrPUXh2WWrX98r/YRtwNR2XqtPT3WIOiFH2YwKtjfy+XhMCHhasKVrNSUz2wEBU8o95CuhXUyCyNkcPASCVeJt/+ZTE4sw6XmZO6SsQNLyqrxFDS24zgphwEo1E36s9zr8hKUHXeTNLRuEobIKZG0CetJnzC9ImlghxabNWbk=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(2616005)(86362001)(82310400005)(2906002)(36756003)(40480700001)(47076005)(34020700004)(7696005)(336012)(83380400001)(186003)(426003)(1076003)(26005)(107886003)(6666004)(4326008)(8676002)(478600001)(70206006)(36860700001)(70586007)(40460700003)(82740400003)(41300700001)(7636003)(356005)(5660300002)(316002)(54906003)(110136005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 16:39:41.7143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d84f6704-1b47-40e8-7c58-08db34620638
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8087
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm Coresight PMU driver consists of main standard code and vendor
backend code. Both are currently built as a single module.
This patch adds vendor registration API to separate the two to
keep things modular. Vendor module shall register to the main
module on loading and trigger device reprobe.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---
 drivers/perf/arm_cspmu/Makefile       |   3 +-
 drivers/perf/arm_cspmu/arm_cspmu.c    | 113 +++++++++++++++++++++-----
 drivers/perf/arm_cspmu/arm_cspmu.h    |  10 ++-
 drivers/perf/arm_cspmu/nvidia_cspmu.c |  24 +++++-
 drivers/perf/arm_cspmu/nvidia_cspmu.h |  17 ----
 5 files changed, 124 insertions(+), 43 deletions(-)
 delete mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h

diff --git a/drivers/perf/arm_cspmu/Makefile b/drivers/perf/arm_cspmu/Makefile
index fedb17df982d..2514ad34aaf0 100644
--- a/drivers/perf/arm_cspmu/Makefile
+++ b/drivers/perf/arm_cspmu/Makefile
@@ -2,5 +2,4 @@
 #
 # SPDX-License-Identifier: GPL-2.0
 
-obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_module.o
-arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o
+obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu.o nvidia_cspmu.o
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index e31302ab7e37..6dbcd46d9fdf 100644
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
 
@@ -25,13 +25,13 @@
 #include <linux/ctype.h>
 #include <linux/interrupt.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/list.h>
 #include <linux/module.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <acpi/processor.h>
 
 #include "arm_cspmu.h"
-#include "nvidia_cspmu.h"
 
 #define PMUNAME "arm_cspmu"
 #define DRVNAME "arm-cs-arch-pmu"
@@ -117,11 +117,14 @@
  */
 #define HILOHI_MAX_POLL	1000
 
-/* JEDEC-assigned JEP106 identification code */
-#define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
-
 static unsigned long arm_cspmu_cpuhp_state;
 
+/* List of Coresight PMU instances in the system. */
+static LIST_HEAD(cspmus);
+
+/* List of registered vendor backends. */
+static LIST_HEAD(cspmu_impls);
+
 /*
  * In CoreSight PMU architecture, all of the MMIO registers are 32-bit except
  * counter register. The counter register can be implemented as 32-bit or 64-bit
@@ -380,26 +383,94 @@ static struct attribute_group arm_cspmu_cpumask_attr_group = {
 };
 
 struct impl_match {
-	u32 pmiidr;
-	u32 mask;
+	struct list_head next;
+	u32 pmiidr_impl;
 	int (*impl_init_ops)(struct arm_cspmu *cspmu);
 };
 
-static const struct impl_match impl_match[] = {
-	{
-	  .pmiidr = ARM_CSPMU_IMPL_ID_NVIDIA,
-	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
-	  .impl_init_ops = nv_cspmu_init_ops
-	},
-	{}
-};
+static struct impl_match *arm_cspmu_get_impl_match(u32 pmiidr_impl)
+{
+	struct impl_match *impl_match;
+
+	list_for_each_entry(impl_match, &cspmu_impls, next) {
+		if (impl_match->pmiidr_impl == pmiidr_impl)
+			return impl_match;
+	}
+
+	return NULL;
+}
+
+static int arm_cspmu_device_reprobe(u32 pmiidr_impl)
+{
+	int ret;
+	struct arm_cspmu *cspmu, *temp;
+
+	/* Reprobe all arm_cspmu devices associated with implementer id. */
+	list_for_each_entry_safe(cspmu, temp, &cspmus, next) {
+		const u32 impl_id = FIELD_GET(ARM_CSPMU_PMIIDR_IMPLEMENTER,
+					cspmu->impl.pmiidr);
+
+		if (pmiidr_impl == impl_id) {
+			ret = device_reprobe(cspmu->dev);
+			if (ret) {
+				dev_err(cspmu->dev, "Failed reprobe %s\n",
+					cspmu->name);
+				return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
+int arm_cspmu_impl_register(u32 pmiidr_impl,
+	int (*impl_init_ops)(struct arm_cspmu *cspmu))
+{
+	struct impl_match *impl;
+
+	if (arm_cspmu_get_impl_match(pmiidr_impl)) {
+		pr_err("ARM CSPMU implementer: 0x%x is already registered\n",
+			pmiidr_impl);
+		return -EEXIST;
+	}
+
+	impl = kzalloc(sizeof(struct impl_match), GFP_KERNEL);
+
+	list_add(&impl->next, &cspmu_impls);
+
+	impl->pmiidr_impl = pmiidr_impl;
+	impl->impl_init_ops = impl_init_ops;
+
+	return arm_cspmu_device_reprobe(pmiidr_impl);
+}
+EXPORT_SYMBOL_GPL(arm_cspmu_impl_register);
+
+void arm_cspmu_impl_unregister(u32 pmiidr_impl)
+{
+	struct impl_match *impl;
+
+	impl = arm_cspmu_get_impl_match(pmiidr_impl);
+	if (!impl) {
+		pr_err("Unable to find ARM CSPMU implementer: 0x%x\n",
+			pmiidr_impl);
+		return;
+	}
+
+	list_del(&impl->next);
+	kfree(impl);
+
+	if (arm_cspmu_device_reprobe(pmiidr_impl))
+		pr_err("ARM CSPMU failed reprobe implementer: 0x%x\n",
+			pmiidr_impl);
+}
+EXPORT_SYMBOL_GPL(arm_cspmu_impl_unregister);
 
 static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 {
 	int ret;
 	struct acpi_apmt_node *apmt_node = cspmu->apmt_node;
 	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
-	const struct impl_match *match = impl_match;
+	const struct impl_match *match;
 
 	/*
 	 * Get PMU implementer and product id from APMT node.
@@ -411,10 +482,11 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 				       readl(cspmu->base0 + PMIIDR);
 
 	/* Find implementer specific attribute ops. */
-	for (; match->pmiidr; match++) {
-		const u32 mask = match->mask;
+	list_for_each_entry(match, &cspmu_impls, next) {
+		const u32 impl_id = FIELD_GET(ARM_CSPMU_PMIIDR_IMPLEMENTER,
+						cspmu->impl.pmiidr);
 
-		if ((match->pmiidr & mask) == (cspmu->impl.pmiidr & mask)) {
+		if (match->pmiidr_impl == impl_id) {
 			ret = match->impl_init_ops(cspmu);
 			if (ret)
 				return ret;
@@ -924,6 +996,8 @@ static struct arm_cspmu *arm_cspmu_alloc(struct platform_device *pdev)
 	if (!cspmu)
 		return NULL;
 
+	list_add(&cspmu->next, &cspmus);
+
 	cspmu->dev = dev;
 	cspmu->apmt_node = apmt_node;
 
@@ -1214,6 +1288,7 @@ static int arm_cspmu_device_remove(struct platform_device *pdev)
 
 	perf_pmu_unregister(&cspmu->pmu);
 	cpuhp_state_remove_instance(arm_cspmu_cpuhp_state, &cspmu->cpuhp_node);
+	list_del(&cspmu->next);
 
 	return 0;
 }
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index 51323b175a4a..64c3b565f1b1 100644
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
 
@@ -116,6 +116,7 @@ struct arm_cspmu_impl {
 
 /* Coresight PMU descriptor. */
 struct arm_cspmu {
+	struct list_head next;
 	struct pmu pmu;
 	struct device *dev;
 	struct acpi_apmt_node *apmt_node;
@@ -148,4 +149,11 @@ ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf);
 
+/* Register vendor backend. */
+int arm_cspmu_impl_register(u32 pmiidr_impl,
+	int (*impl_init_ops)(struct arm_cspmu *cspmu));
+
+/* Unregister vendor backend. */
+void arm_cspmu_impl_unregister(u32 pmiidr_impl);
+
 #endif /* __ARM_CSPMU_H__ */
diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
index 72ef80caa3c8..d7083fed135d 100644
--- a/drivers/perf/arm_cspmu/nvidia_cspmu.c
+++ b/drivers/perf/arm_cspmu/nvidia_cspmu.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ * Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
  *
  */
 
@@ -8,7 +8,10 @@
 
 #include <linux/topology.h>
 
-#include "nvidia_cspmu.h"
+#include "arm_cspmu.h"
+
+/* JEDEC-assigned JEP106 identification code */
+#define ARM_CSPMU_IMPL_ID_NVIDIA     0x36B
 
 #define NV_PCIE_PORT_COUNT           10ULL
 #define NV_PCIE_FILTER_ID_MASK       GENMASK_ULL(NV_PCIE_PORT_COUNT - 1, 0)
@@ -351,7 +354,7 @@ static char *nv_cspmu_format_name(const struct arm_cspmu *cspmu,
 	return name;
 }
 
-int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
+static int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
 {
 	u32 prodid;
 	struct nv_cspmu_ctx *ctx;
@@ -395,6 +398,19 @@ int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nv_cspmu_init_ops);
+
+static int __init nvidia_cspmu_init(void)
+{
+	return arm_cspmu_impl_register(ARM_CSPMU_IMPL_ID_NVIDIA,
+		nv_cspmu_init_ops);
+}
+
+static void __exit nvidia_cspmu_exit(void)
+{
+	arm_cspmu_impl_unregister(ARM_CSPMU_IMPL_ID_NVIDIA);
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

base-commit: 73f2c2a7e1d2b31fdd5faa6dfa151c437a6c0a5a
prerequisite-patch-id: fb691dc01d87597bcbaa4d352073304287c20f73
-- 
2.17.1

