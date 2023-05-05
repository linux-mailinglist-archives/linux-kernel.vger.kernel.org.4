Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42186F7A40
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 03:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjEEBAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 21:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEBAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 21:00:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CDF7EC1;
        Thu,  4 May 2023 18:00:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUDx50CBRyJ8A2VSc/nZvMVtFnBPDuYMGF4JtqWiTz6HPC5C4pampb+OPj0nEf1CeIiE9OVLe2E50LqGzZB1VX06ZhpLm6NRenhFFDcuq+1HC415ijlxyhwgOjjsefRzjVxUM8tssGS2Q3RgkfFSX9VuRyyxgA4uC9PubwYyFh/p6q/gAeGHJIBgMOpONDW0V9KoHpB+8Tji6F6U6uina9rzbqBe1UEGBNLZcxTtva1ftQvGGyA6mceh3CZaV/FnuDsQXTN6YMerOXEOfP+7rm2sB6Gakg87EnuzRF9x3dsRh+U5ydA/qmVVDgfDwwylSNfrvvBBqzv3Qjrbd/atXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwQoGir6v2Xn7Y/HrgBQugS9EA3laIOAHzr8+NNzFds=;
 b=oCcuNMhYrBtTLDDwo9QhEIxSP3YqevyU+wt3w4n4M0zf2U2vO6AMdvqlbxkCDWqrDqIZ9ISnWnK5FKlmCaqmliOiKTY1LYk965i0dnRRJ0dJiV7BAlDRl0fMnHCGIcc1QF3bMQlFP6pS6HAbCl9TqmQNgbXzNLqO3/JwtbTxiatpV7CtchqryrPQHV8CqG4UONJafpl1qx9OjdbLnE30+rufkNyX53DiZ8uj+TYieWIxUQAPgYZqVH53xIgx+MDWfoPzI2RnafHFNVy/v/o03YUty5rvhXOUepw3cD7wZJ0R35XjPTsGj9ZA/6jjy/qpYZh6N5uUXEDOOTsKG2HUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwQoGir6v2Xn7Y/HrgBQugS9EA3laIOAHzr8+NNzFds=;
 b=CRfouOFaMKzyv8HtwxCtpb+1ViFjXxMkF4RMT8GE2QHjyIqBASXxhj1dYCdh5LPeQBC6abf8a0sD8dpAvqC50lwe+58946v/+KTeud9lkAC8nLnwRw1paOMwfDEvz5XN5WoQ1z+L8Ju5LGQnbmdrvz0M02+tyUDRZfmcW1ojgsd8sZqxpG3EXzlAzjllid6FZXDka1FiS39mfefnscSGNUoJv8Hr3aZxezKpfKSnJaTCP9Nr72h4+BaISES6YWo7yl52rSU8z6E36pwBsPdxglt6e09G6ulDxZ9UIkht/b+9DynEGBCxM4wlGcjmJEpHJCMbJx5cfUL41VA2w92VzA==
Received: from BN0PR04CA0075.namprd04.prod.outlook.com (2603:10b6:408:ea::20)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.26; Fri, 5 May
 2023 01:00:29 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::df) by BN0PR04CA0075.outlook.office365.com
 (2603:10b6:408:ea::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27 via Frontend
 Transport; Fri, 5 May 2023 01:00:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.27 via Frontend Transport; Fri, 5 May 2023 01:00:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 4 May 2023
 18:00:12 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 4 May 2023
 18:00:11 -0700
Received: from msst-build.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 4 May 2023 18:00:11 -0700
From:   Besar Wicaksono <bwicaksono@nvidia.com>
To:     <suzuki.poulose@arm.com>, <robin.murphy@arm.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>, <vsethi@nvidia.com>,
        <rwiley@nvidia.com>, <efunsten@nvidia.com>,
        "Besar Wicaksono" <bwicaksono@nvidia.com>
Subject: [PATCH v3] perf: arm_cspmu: Separate Arm and vendor module
Date:   Thu, 4 May 2023 19:59:56 -0500
Message-ID: <20230505005956.22837-1-bwicaksono@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|DM4PR12MB5867:EE_
X-MS-Office365-Filtering-Correlation-Id: a1f09375-be10-4cc2-1506-08db4d041e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ri9/k/34b19yL7K492cW7KvYO5+52zzLtzCf488DD4/x5tL9AruhwbBk41p5bb3YuN/HBKJF7/oudd86pWojCAXFpI8//dSWpw8pbMXcGs86fIOH/GkPznGoDr9wrrGp+/c0WIznonTe9OqxWXBx688qluBzb/0nMGHG+cx37PdlTlAJripy1Lbx4A1Pk+BOMcB/kVKNZqvJkd6ks4JgObCdD91JQeG/82RMjrmZVB2loiimgv8gOHwY4okre4OlNvD59vAqgnkulk9H6cK7THGxV2J+52mEOoOs0MTkFDF4WqgHlIz1TTpk750iywVM+b9RdXT8FImKj7ybAVPMLpaM6Vh7qlnq6mammgxqxHxDpk8899221BaFxA8HXDTjgCP7RVdiUNBjxUseXtCRIKJZlxCzhSrIZpWOtXozfM30ltE9w4KaLKZYv9DhQGxDKWxANNM6hVcDHPBik/UzTWP1OZ5I9da8WYvi8bKZxGQAM2txM3+RqWzdjX7/tlulw0k9gREwSOzuc2Xs0At+P3UyrKI7d2gO1B0J9EMRRORdzXcIP7AV193D85Lf1Jxy3LbbAGQfvqV0wus8mOIYG/qy9Plm+vnEwj9akzC8P5jaw4AryOlZ2jSMkUv4AuHVHZTT8xCmZdImJRIn42yaeJctofflRKp2fo9h2UAvCbib+wtzOIesivuV36wKCmwezT/ErldmMWzxQvxh5MCPLk2JnC8uZ9Cm41BnYFnN+Wf8zFnaZbK3mxSzDCMMg69BDlW2G8Mw8/oNSHbDZYRCVqXtp1+wNnjhEv+xuXcAhO8=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(8676002)(40480700001)(8936002)(966005)(86362001)(36756003)(316002)(4326008)(7696005)(82310400005)(41300700001)(70586007)(70206006)(82740400003)(356005)(7636003)(40460700003)(478600001)(6666004)(47076005)(36860700001)(30864003)(2906002)(110136005)(54906003)(2616005)(26005)(1076003)(107886003)(83380400001)(186003)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 01:00:28.4776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1f09375-be10-4cc2-1506-08db4d041e4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm Coresight PMU driver consists of main standard code and vendor
backend code. Both are currently built as a single module.
This patch adds vendor registration API to separate the two to
keep things modular. Main driver maintains a list of backend module
and will request it when probing the device.

Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
---

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
 drivers/perf/arm_cspmu/Kconfig          |   9 +-
 drivers/perf/arm_cspmu/Makefile         |   7 +-
 drivers/perf/arm_cspmu/arm_cspmu.c      |  86 ++++++------------
 drivers/perf/arm_cspmu/arm_cspmu.h      |  55 ++++++++++--
 drivers/perf/arm_cspmu/arm_cspmu_impl.c | 114 ++++++++++++++++++++++++
 drivers/perf/arm_cspmu/nvidia_cspmu.c   |  35 +++++++-
 drivers/perf/arm_cspmu/nvidia_cspmu.h   |  17 ----
 7 files changed, 235 insertions(+), 88 deletions(-)
 create mode 100644 drivers/perf/arm_cspmu/arm_cspmu_impl.c
 delete mode 100644 drivers/perf/arm_cspmu/nvidia_cspmu.h

diff --git a/drivers/perf/arm_cspmu/Kconfig b/drivers/perf/arm_cspmu/Kconfig
index 0b316fe69a45..8ce7b45a0075 100644
--- a/drivers/perf/arm_cspmu/Kconfig
+++ b/drivers/perf/arm_cspmu/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 
 config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
 	tristate "ARM Coresight Architecture PMU"
@@ -11,3 +11,10 @@ config ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
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
index fedb17df982d..602ecb99dc57 100644
--- a/drivers/perf/arm_cspmu/Makefile
+++ b/drivers/perf/arm_cspmu/Makefile
@@ -1,6 +1,9 @@
-# Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+# Copyright (c) 2022-2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
 #
 # SPDX-License-Identifier: GPL-2.0
 
+obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_impl.o
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu_module.o
-arm_cspmu_module-y := arm_cspmu.o nvidia_cspmu.o
+arm_cspmu_module-y := arm_cspmu.o
+
+obj-$(CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += nvidia_cspmu.o
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index a3f1c410b417..04c318744f55 100644
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
 
@@ -31,7 +31,6 @@
 #include <acpi/processor.h>
 
 #include "arm_cspmu.h"
-#include "nvidia_cspmu.h"
 
 #define PMUNAME "arm_cspmu"
 #define DRVNAME "arm-cs-arch-pmu"
@@ -117,9 +116,6 @@
  */
 #define HILOHI_MAX_POLL	1000
 
-/* JEDEC-assigned JEP106 identification code */
-#define ARM_CSPMU_IMPL_ID_NVIDIA		0x36B
-
 static unsigned long arm_cspmu_cpuhp_state;
 
 /*
@@ -186,16 +182,6 @@ static inline bool use_64b_counter_reg(const struct arm_cspmu *cspmu)
 	return (counter_size(cspmu) > 32);
 }
 
-ssize_t arm_cspmu_sysfs_event_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct dev_ext_attribute *eattr =
-		container_of(attr, struct dev_ext_attribute, attr);
-	return sysfs_emit(buf, "event=0x%llx\n",
-			  (unsigned long long)eattr->var);
-}
-EXPORT_SYMBOL_GPL(arm_cspmu_sysfs_event_show);
-
 /* Default event list. */
 static struct attribute *arm_cspmu_event_attrs[] = {
 	ARM_CSPMU_EVENT_ATTR(cycles, ARM_CSPMU_EVT_CYCLES_DEFAULT),
@@ -231,16 +217,6 @@ arm_cspmu_event_attr_is_visible(struct kobject *kobj,
 	return attr->mode;
 }
 
-ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
-				struct device_attribute *attr,
-				char *buf)
-{
-	struct dev_ext_attribute *eattr =
-		container_of(attr, struct dev_ext_attribute, attr);
-	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
-}
-EXPORT_SYMBOL_GPL(arm_cspmu_sysfs_format_show);
-
 static struct attribute *arm_cspmu_format_attrs[] = {
 	ARM_CSPMU_FORMAT_EVENT_ATTR,
 	ARM_CSPMU_FORMAT_FILTER_ATTR,
@@ -379,27 +355,12 @@ static struct attribute_group arm_cspmu_cpumask_attr_group = {
 	.attrs = arm_cspmu_cpumask_attrs,
 };
 
-struct impl_match {
-	u32 pmiidr;
-	u32 mask;
-	int (*impl_init_ops)(struct arm_cspmu *cspmu);
-};
-
-static const struct impl_match impl_match[] = {
-	{
-	  .pmiidr = ARM_CSPMU_IMPL_ID_NVIDIA,
-	  .mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
-	  .impl_init_ops = nv_cspmu_init_ops
-	},
-	{}
-};
-
 static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 {
-	int ret;
+	int ret = 0;
 	struct acpi_apmt_node *apmt_node = cspmu->apmt_node;
 	struct arm_cspmu_impl_ops *impl_ops = &cspmu->impl.ops;
-	const struct impl_match *match = impl_match;
+	const struct arm_cspmu_impl_module *match;
 
 	/*
 	 * Get PMU implementer and product id from APMT node.
@@ -411,18 +372,21 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu *cspmu)
 				       readl(cspmu->base0 + PMIIDR);
 
 	/* Find implementer specific attribute ops. */
-	for (; match->pmiidr; match++) {
-		const u32 mask = match->mask;
-
-		if ((match->pmiidr & mask) == (cspmu->impl.pmiidr & mask)) {
-			ret = match->impl_init_ops(cspmu);
-			if (ret)
-				return ret;
-
-			break;
+	match = arm_cspmu_impl_match_module(cspmu->impl.pmiidr);
+	if (match) {
+		request_module(match->name);
+
+		if (match->param.module && match->param.impl_init_ops) {
+			if (try_module_get(match->param.module)) {
+				cspmu->impl.module = match->param.module;
+				ret = match->param.impl_init_ops(cspmu);
+			}
 		}
 	}
 
+	if (ret)
+		return ret;
+
 	/* Use default callbacks if implementer doesn't provide one. */
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_event_attrs);
 	CHECK_DEFAULT_IMPL_OPS(impl_ops, get_format_attrs);
@@ -484,11 +448,6 @@ arm_cspmu_alloc_attr_group(struct arm_cspmu *cspmu)
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
@@ -1203,11 +1162,21 @@ static int arm_cspmu_device_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = arm_cspmu_init_impl_ops(cspmu);
+	if (ret)
+		goto module_put;
+
 	ret = arm_cspmu_register_pmu(cspmu);
 	if (ret)
-		return ret;
+		goto module_put;
 
 	return 0;
+
+module_put:
+	if (cspmu->impl.module)
+		module_put(cspmu->impl.module);
+
+	return ret;
 }
 
 static int arm_cspmu_device_remove(struct platform_device *pdev)
@@ -1217,6 +1186,9 @@ static int arm_cspmu_device_remove(struct platform_device *pdev)
 	perf_pmu_unregister(&cspmu->pmu);
 	cpuhp_state_remove_instance(arm_cspmu_cpuhp_state, &cspmu->cpuhp_node);
 
+	if (cspmu->impl.module)
+		module_put(cspmu->impl.module);
+
 	return 0;
 }
 
diff --git a/drivers/perf/arm_cspmu/arm_cspmu.h b/drivers/perf/arm_cspmu/arm_cspmu.h
index 51323b175a4a..0b60165f770a 100644
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
 
@@ -68,8 +68,13 @@
 
 /* PMIIDR register field */
 #define ARM_CSPMU_PMIIDR_IMPLEMENTER	GENMASK(11, 0)
+#define ARM_CSPMU_PMIIDR_REVISION	GENMASK(15, 12)
+#define ARM_CSPMU_PMIIDR_VARIANT	GENMASK(19, 16)
 #define ARM_CSPMU_PMIIDR_PRODUCTID	GENMASK(31, 20)
 
+/* JEDEC-assigned JEP106 identification code */
+#define ARM_CSPMU_IMPL_ID_NVIDIA	0x36B
+
 struct arm_cspmu;
 
 /* This tracks the events assigned to each counter in the PMU. */
@@ -107,10 +112,28 @@ struct arm_cspmu_impl_ops {
 					 struct attribute *attr, int unused);
 };
 
+/* Vendor/implementer registration parameter. */
+struct arm_cspmu_impl_param {
+	/* Backend module. */
+	struct module *module;
+	/* PMIIDR value/mask. */
+	u32 pmiidr_val;
+	u32 pmiidr_mask;
+	/* Callback to vendor backend to init arm_cspmu_impl::ops. */
+	int (*impl_init_ops)(struct arm_cspmu *cspmu);
+};
+
+/* Vendor/implementer module. */
+struct arm_cspmu_impl_module {
+	const char *name;
+	struct arm_cspmu_impl_param param;
+};
+
 /* Vendor/implementer descriptor. */
 struct arm_cspmu_impl {
 	u32 pmiidr;
 	struct arm_cspmu_impl_ops ops;
+	struct module *module;
 	void *ctx;
 };
 
@@ -139,13 +162,31 @@ struct arm_cspmu {
 };
 
 /* Default function to show event attribute in sysfs. */
-ssize_t arm_cspmu_sysfs_event_show(struct device *dev,
-				   struct device_attribute *attr,
-				   char *buf);
+static inline ssize_t arm_cspmu_sysfs_event_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *eattr =
+		container_of(attr, struct dev_ext_attribute, attr);
+	return sysfs_emit(buf, "event=0x%llx\n",
+			  (unsigned long long)eattr->var);
+}
 
 /* Default function to show format attribute in sysfs. */
-ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
-				    struct device_attribute *attr,
-				    char *buf);
+static inline ssize_t arm_cspmu_sysfs_format_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct dev_ext_attribute *eattr =
+		container_of(attr, struct dev_ext_attribute, attr);
+	return sysfs_emit(buf, "%s\n", (char *)eattr->var);
+}
+
+/* Register vendor backend. */
+int arm_cspmu_impl_register(const struct arm_cspmu_impl_param *impl_param);
+
+/* Unregister vendor backend. */
+void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_param *impl_param);
+
+/* Get matching vendor module compatible with /p pmiidr. */
+const struct arm_cspmu_impl_module *arm_cspmu_impl_match_module(u32 pmiidr);
 
 #endif /* __ARM_CSPMU_H__ */
diff --git a/drivers/perf/arm_cspmu/arm_cspmu_impl.c b/drivers/perf/arm_cspmu/arm_cspmu_impl.c
new file mode 100644
index 000000000000..35e0f4c2410a
--- /dev/null
+++ b/drivers/perf/arm_cspmu/arm_cspmu_impl.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Implementation specific backend registration.
+ *
+ * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ *
+ */
+
+#include <linux/mutex.h>
+
+#include "arm_cspmu.h"
+
+static DEFINE_MUTEX(arm_cspmu_lock);
+
+static struct arm_cspmu_impl_module module_list[] = {
+	{
+		.name = "nvidia_cspmu",
+		.param = {
+			.pmiidr_val = ARM_CSPMU_IMPL_ID_NVIDIA,
+			.pmiidr_mask = ARM_CSPMU_PMIIDR_IMPLEMENTER,
+		},
+	},
+	{}
+};
+
+static struct arm_cspmu_impl_module *arm_cspmu_impl_find_module(
+	const struct arm_cspmu_impl_param *impl_param)
+{
+	struct arm_cspmu_impl_module *module;
+
+	for (module = module_list; module->name; module++) {
+		if (!strcmp(module->name, impl_param->module->name) &&
+		    module->param.pmiidr_val == impl_param->pmiidr_val &&
+		    module->param.pmiidr_mask == impl_param->pmiidr_mask)
+			return module;
+	}
+
+	return NULL;
+}
+
+const struct arm_cspmu_impl_module *arm_cspmu_impl_match_module(u32 pmiidr)
+{
+	struct arm_cspmu_impl_module *module;
+
+	mutex_lock(&arm_cspmu_lock);
+
+	for (module = module_list; module->name; module++) {
+		u32 mask = module->param.pmiidr_mask;
+
+		if ((module->param.pmiidr_val & mask) == (pmiidr & mask)) {
+			mutex_unlock(&arm_cspmu_lock);
+			return module;
+		}
+	}
+
+	mutex_unlock(&arm_cspmu_lock);
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(arm_cspmu_impl_match_module);
+
+int arm_cspmu_impl_register(const struct arm_cspmu_impl_param *impl_param)
+{
+	struct arm_cspmu_impl_module *module;
+	int ret = 0;
+
+	if (!impl_param->module || !impl_param->impl_init_ops) {
+		pr_err("arm_cspmu reg failed, invalid module or init_ops\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&arm_cspmu_lock);
+
+	module = arm_cspmu_impl_find_module(impl_param);
+	if (module) {
+		module->param.module = impl_param->module;
+		module->param.impl_init_ops = impl_param->impl_init_ops;
+	} else {
+		pr_err("arm_cspmu reg failed, unable to find pmiidr: 0x%x, mask: 0x%x, module: %s\n",
+			impl_param->pmiidr_val,
+			impl_param->pmiidr_mask,
+			impl_param->module->name);
+
+		ret = -EINVAL;
+	}
+
+
+	mutex_unlock(&arm_cspmu_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(arm_cspmu_impl_register);
+
+void arm_cspmu_impl_unregister(const struct arm_cspmu_impl_param *impl_param)
+{
+	struct arm_cspmu_impl_module *module;
+
+	mutex_lock(&arm_cspmu_lock);
+
+	module = arm_cspmu_impl_find_module(impl_param);
+	if (module) {
+		module->param.module = NULL;
+		module->param.impl_init_ops = NULL;
+	} else
+		pr_err("arm_cspmu unreg failed, unable to find pmiidr: 0x%x, mask: 0x%x, module: %s\n",
+			impl_param->pmiidr_val,
+			impl_param->pmiidr_mask,
+			impl_param->module->name);
+
+	mutex_unlock(&arm_cspmu_lock);
+}
+EXPORT_SYMBOL_GPL(arm_cspmu_impl_unregister);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/perf/arm_cspmu/nvidia_cspmu.c b/drivers/perf/arm_cspmu/nvidia_cspmu.c
index 72ef80caa3c8..7ac8f17de116 100644
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
@@ -395,6 +396,32 @@ int nv_cspmu_init_ops(struct arm_cspmu *cspmu)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nv_cspmu_init_ops);
+
+/* Match all NVIDIA Coresight PMU devices */
+static const struct arm_cspmu_impl_param nv_cspmu_param = {
+	.module		= THIS_MODULE,
+	.pmiidr_val	= ARM_CSPMU_IMPL_ID_NVIDIA,
+	.pmiidr_mask	= ARM_CSPMU_PMIIDR_IMPLEMENTER,
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

base-commit: 145e5cddfe8b4bf607510b2dcf630d95f4db420f
-- 
2.17.1

