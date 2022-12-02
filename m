Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C2F64013F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiLBHu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbiLBHus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:50:48 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF545A054A;
        Thu,  1 Dec 2022 23:50:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYG7UGc3iR0y7VJYKnuUqNd+p28sCy/o2J8qEEvBqAC9mJu4e9nkhDkhDg3cp5FyWzxq8KO4ZRuFweYzXLDOVD549IERwfgu6R0w9NGaCZ8WArcA5NsFsgcK2/YuDeBw6m0P5lVOuQsNTrdynFSRLHIKorQxhDGM58JRdbQih6438/u8RQwzRzinFn9fN6KO9RwmHgFqshQpPuydBcMSJAWxlpgC7wV2LTJmud1kMs9dcgr3X9DZqtKZm/blnaD5TLQH8wLqTsHXR3l8tGXaicN8lNxfVBhUhFZx6kYl9LEZnop91tK1JzW1Ye6WjspS1byyaKJzYjZX2sX6O8iY8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+C4iUKjwXwEm0UuOYNQXdTkPvGvjj1IuenIn3mTcD4=;
 b=glVp9sgAIIUOpnuLAPHpG3lsiO+rkiUK0zVPfOSC1tY5Fl4XSvrefFnfCkZDM4wX5jlnj9gVEEePDCuOfLLr11V9IQilSYTl1N8sOHM8GUTq/u5wueQkDiS2QqntR94hBOBi0oncG5coTZFLPlFmBWoBMO0PBEK/ZTnUbv19gIzSes62GuMmNCLRU4OQUYE2PuMl71p3OvB7ApA/9YqG2/UPIP6DNdlV5TD91C68FHiiaF1AaRTOd6lHi3WI6SeLovpFK7IkYGZDcyg7X1dUNMt+cuP1hQjhJOdwV05uKqwh0UWhmh6UJ6LksWCa4oVdwA1mixv0zAOE3S4XNAOhBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+C4iUKjwXwEm0UuOYNQXdTkPvGvjj1IuenIn3mTcD4=;
 b=C1DnVSJeDOxJqyEWHHvT3gP6+Fk0zFE8Yj5WUX5C6wycBmOLqbhPz1ljcrmf+Jb7MZdyyyIkk89Rtekkd8qrV/gLKtyw2b63zGa1qTa/kYAdBKmrptKHfaoz/tZT2Uc2pcilkvZCsTxD4ORSP7UJAY59PeuYNd0tH2iHWhyVD/s=
Received: from DM6PR08CA0040.namprd08.prod.outlook.com (2603:10b6:5:1e0::14)
 by DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.8; Fri, 2 Dec 2022 07:50:35 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::d5) by DM6PR08CA0040.outlook.office365.com
 (2603:10b6:5:1e0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Fri, 2 Dec 2022 07:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.10 via Frontend Transport; Fri, 2 Dec 2022 07:50:35 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 2 Dec 2022 01:50:31 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 03/11] cpufreq: intel_pstate: use common macro definition for Energy Preference Performance(EPP)
Date:   Fri, 2 Dec 2022 15:47:11 +0800
Message-ID: <20221202074719.623673-4-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202074719.623673-1-perry.yuan@amd.com>
References: <20221202074719.623673-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT065:EE_|DM8PR12MB5445:EE_
X-MS-Office365-Filtering-Correlation-Id: ca69a75b-3585-41cc-d23e-08dad439e589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2xGcXB04kYD+BkrAFFKCIWvgXhNf2rF3Fbp63+bSiuOjIAQ77F86+DlHrQPJXg/yegace0kIiHOdIpjZmQtEADMvJpfNGGl7OJsY0eqbUl6Zpm5MHaz0LHcHSRs3dFBAmJq+/yIE5rXSf2nEQM4M4quW8kq3LE4dKLXPg7aC2IvjGUcMoFWOkx2lq/zjDI57veAsiWdtf1ST9KzNDKoQf45955g66mcA0s+qiX2D/9+U/Lqc0cE2F2dCJWW3Bm8ZCHOSzBH4H/mxJgTrERhvDor1f7a2LAMApCLtvBNx29GABWHXBHQY5rqA1zirRwyq4WctQBhS3E0QX4xld+2oHVjbe7PJvXNYVah2612jL9zw7HDYy80jAr0DHPryv0dYKmuc4twYmJ0lwmTYSOEwPu7ogOCMm2Iqz4J2aNNoOamSA8I262NRV2e7bwBy1SQEBGxuunj2692UUc4/lDy9Ace1+qFyhnVe97+/xFpNx03tfQx+44l4E6o5hHqpmDMPVMDuxWz6ex+PNhRnnYhULZqg+hEqIt/tuPTrshT9buAmy08GnsLrNQsQXcPnp0lt/Zmi/rDUy1RaX/XzFcfRtNQ+EGjDNqVykz/H+4rstPmR/e/9htFXGMQdFbN0tMN+AMwvxPHOg4LmosM4pxOQrLqdD9gXS/aJaQcDlPRoB3MfuD8a9A7BX9KuUQggsPvSlHmnBKRgbD5bCt23zpZCURIRcqdeVyuhWA0ZpOxtsU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(136003)(396003)(451199015)(36840700001)(46966006)(40470700004)(2906002)(44832011)(5660300002)(41300700001)(8936002)(8676002)(70586007)(316002)(110136005)(4326008)(54906003)(70206006)(36860700001)(36756003)(6666004)(1076003)(336012)(16526019)(82310400005)(478600001)(86362001)(47076005)(26005)(186003)(2616005)(426003)(82740400003)(40460700003)(83380400001)(7696005)(356005)(81166007)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 07:50:35.4804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca69a75b-3585-41cc-d23e-08dad439e589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5445
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make the energy preference performance strings and profiles using one
common header for intel_pstate driver, then the amd_pstate epp driver can
use the common header as well. This will simpify the intel_pstate and
amd_pstate driver.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 arch/x86/include/asm/msr-index.h |  4 ---
 drivers/cpufreq/intel_pstate.c   | 37 +--------------------
 include/linux/cpufreq_common.h   | 56 ++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 40 deletions(-)
 create mode 100644 include/linux/cpufreq_common.h

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 4a2af82553e4..3983378cff5b 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -472,10 +472,6 @@
 #define HWP_MAX_PERF(x) 		((x & 0xff) << 8)
 #define HWP_DESIRED_PERF(x)		((x & 0xff) << 16)
 #define HWP_ENERGY_PERF_PREFERENCE(x)	(((unsigned long long) x & 0xff) << 24)
-#define HWP_EPP_PERFORMANCE		0x00
-#define HWP_EPP_BALANCE_PERFORMANCE	0x80
-#define HWP_EPP_BALANCE_POWERSAVE	0xC0
-#define HWP_EPP_POWERSAVE		0xFF
 #define HWP_ACTIVITY_WINDOW(x)		((unsigned long long)(x & 0xff3) << 32)
 #define HWP_PACKAGE_CONTROL(x)		((unsigned long long)(x & 0x1) << 42)
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ad9be31753b6..65036ca21719 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -25,6 +25,7 @@
 #include <linux/acpi.h>
 #include <linux/vmalloc.h>
 #include <linux/pm_qos.h>
+#include <linux/cpufreq_common.h>
 #include <trace/events/power.h>
 
 #include <asm/cpu.h>
@@ -628,42 +629,6 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
 	return 0;
 }
 
-/*
- * EPP/EPB display strings corresponding to EPP index in the
- * energy_perf_strings[]
- *	index		String
- *-------------------------------------
- *	0		default
- *	1		performance
- *	2		balance_performance
- *	3		balance_power
- *	4		power
- */
-
-enum energy_perf_value_index {
-	EPP_INDEX_DEFAULT = 0,
-	EPP_INDEX_PERFORMANCE,
-	EPP_INDEX_BALANCE_PERFORMANCE,
-	EPP_INDEX_BALANCE_POWERSAVE,
-	EPP_INDEX_POWERSAVE,
-};
-
-static const char * const energy_perf_strings[] = {
-	[EPP_INDEX_DEFAULT] = "default",
-	[EPP_INDEX_PERFORMANCE] = "performance",
-	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
-	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
-	[EPP_INDEX_POWERSAVE] = "power",
-	NULL
-};
-static unsigned int epp_values[] = {
-	[EPP_INDEX_DEFAULT] = 0, /* Unused index */
-	[EPP_INDEX_PERFORMANCE] = HWP_EPP_PERFORMANCE,
-	[EPP_INDEX_BALANCE_PERFORMANCE] = HWP_EPP_BALANCE_PERFORMANCE,
-	[EPP_INDEX_BALANCE_POWERSAVE] = HWP_EPP_BALANCE_POWERSAVE,
-	[EPP_INDEX_POWERSAVE] = HWP_EPP_POWERSAVE,
-};
-
 static int intel_pstate_get_energy_pref_index(struct cpudata *cpu_data, int *raw_epp)
 {
 	s16 epp;
diff --git a/include/linux/cpufreq_common.h b/include/linux/cpufreq_common.h
new file mode 100644
index 000000000000..2d14b0b0f55c
--- /dev/null
+++ b/include/linux/cpufreq_common.h
@@ -0,0 +1,56 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * linux/include/linux/cpufreq_common.h
+ *
+ * Copyright (C) 2022 Advanced Micro Devices, Inc.
+ *
+ * Author: Perry Yuan <Perry.Yuan@amd.com>
+ */
+
+#ifndef _LINUX_CPUFREQ_COMMON_H
+#define _LINUX_CPUFREQ_COMMON_H
+
+#include <asm/msr.h>
+/*
+ * EPP/EPB display strings corresponding to EPP index in the
+ * energy_perf_strings[]
+ *	index		String
+ *-------------------------------------
+ *	0		default
+ *	1		performance
+ *	2		balance_performance
+ *	3		balance_power
+ *	4		power
+ */
+
+#define HWP_EPP_PERFORMANCE		0x00
+#define HWP_EPP_BALANCE_PERFORMANCE	0x80
+#define HWP_EPP_BALANCE_POWERSAVE	0xC0
+#define HWP_EPP_POWERSAVE		0xFF
+
+enum energy_perf_value_index {
+	EPP_INDEX_DEFAULT = 0,
+	EPP_INDEX_PERFORMANCE,
+	EPP_INDEX_BALANCE_PERFORMANCE,
+	EPP_INDEX_BALANCE_POWERSAVE,
+	EPP_INDEX_POWERSAVE,
+};
+
+static const char * const energy_perf_strings[] = {
+	[EPP_INDEX_DEFAULT] = "default",
+	[EPP_INDEX_PERFORMANCE] = "performance",
+	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
+	[EPP_INDEX_BALANCE_POWERSAVE] = "balance_power",
+	[EPP_INDEX_POWERSAVE] = "power",
+	NULL
+};
+
+static unsigned int epp_values[] = {
+	[EPP_INDEX_DEFAULT] = 0, /* Unused index */
+	[EPP_INDEX_PERFORMANCE] = HWP_EPP_PERFORMANCE,
+	[EPP_INDEX_BALANCE_PERFORMANCE] = HWP_EPP_BALANCE_PERFORMANCE,
+	[EPP_INDEX_BALANCE_POWERSAVE] = HWP_EPP_BALANCE_POWERSAVE,
+	[EPP_INDEX_POWERSAVE] = HWP_EPP_POWERSAVE,
+};
+
+#endif /* _LINUX_CPUFREQ_COMMON_H */
\ No newline at end of file
-- 
2.34.1

