Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B811646E45
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 12:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiLHLTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 06:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLHLTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 06:19:24 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0334E41A;
        Thu,  8 Dec 2022 03:19:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKc/7FMHsOGQNThPhZmcQY/Z+iCpXkAysT71ouyO9MdQ/REqm+ST6ohzckJGdsANCluyl9Lxufyyf975/duyRAgMLNClbB+GnwYvTFoZmISDwYLCjdFXmJUn5aGerqqY2uBjCQzxSDA0tCTFmsqHAvFdlJpL/JvSMku3/UiunI/3aTJcxmWf8al6K/g0dKsddFWak0kWFpDHGOzBFx2DYXWeOxGPM7yz3Tdl0iN58XZn30Xzsjib4RgjnKLN2ng+Pbi5KU75Rtvc7AgmTLTzXZc2XKkf2A1rmx3XZBDMBvuTgdtpUd8QANZu5MqCSSYJG73yXy1BA5sW89oXeW3hLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=508HYr51YNonVzKbhrMdNR33HGNXYzF4bHqF361H0js=;
 b=VGn7HY18Rr3bit1yH/e15bSGhqVRN3r2FyAlMhiiYHMW73UVY//P3ZzTAww2KzThavCo+thh5tqmSfhKWXx5xVwbs9/LtO3azf1lXDSkOMZVdeUksQF7I6LwtXPdrh+4lLG8DxsaYzKscfbMuQ6aQzQAa3Fe0voZMqmAvtAfExmjYHIj57HKVaVb/Q3pOrQo//CDobHEng/GrNVHpBgOlNTTBto+OTNDkWe8NEpZnq6HSTMlccS3s/BTl6XTChvIsXdJIydrF500dmqrsjkrMf9viuVpmAOnIt5gJpWApYSKazy8qDjHYXKkczrZa4DoMrAayYPm83DYREOrxutWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=508HYr51YNonVzKbhrMdNR33HGNXYzF4bHqF361H0js=;
 b=1EpvEa6ZN2z/qRg1MF7yb4kFhYnpDTWONwErF31/KeQySY/jyxaIeHlHomI6t4zrErs1JL3Jm0Y8YrUNMpKOJ8Xn33XmuoHGsHA4hy+HBvt5hpBAHiRfgCwqYApvzooqFkDgxrqiDSOZ30eFrPJ6C+C39WfjvjPXnGvz4sfG3lw=
Received: from DM6PR11CA0051.namprd11.prod.outlook.com (2603:10b6:5:14c::28)
 by BY5PR12MB4918.namprd12.prod.outlook.com (2603:10b6:a03:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 11:19:22 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::ba) by DM6PR11CA0051.outlook.office365.com
 (2603:10b6:5:14c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16 via Frontend
 Transport; Thu, 8 Dec 2022 11:19:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 11:19:21 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 8 Dec 2022 05:19:17 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 03/13] cpufreq: intel_pstate: use common macro definition for Energy Preference Performance(EPP)
Date:   Thu, 8 Dec 2022 19:18:42 +0800
Message-ID: <20221208111852.386731-4-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208111852.386731-1-perry.yuan@amd.com>
References: <20221208111852.386731-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT034:EE_|BY5PR12MB4918:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ff73f6-9b05-42e8-6975-08dad90e0e21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhn11mzdcGxjkMmZRK8zJ+2OGAjN8dwC2Oc4EJAuyIdjkKDO5CvR7a7Pl70r7TybneZjPLPF6ROnot4isIvXdE+B37tl51pFeyGgueTfN0iEtITFvXaCzBdEzjdRNpJsyF7PVxO9laQb8xNsGj/nXQTqBjbBY3l8FsB9pfJY+uvM0Ggqx5EqXo6nGthEZHF+0uYCjo0h4fNKQATbwUvSQCyX9/OPt+kYwwrng8sRfar7abmdOf2Bf7GmvFEOAxlvSKzqqF3S1T03JmKrSCVgVbqq1RNftMfYAJin7aRL+oRsm4QEDpn3/OY6oKucuT5Eu4BMEjRw/9vvET2kQwOqYsTSSGfuDam+8wQllmbmY7M8xJnV9/UOhi2QiJ1PSjX4b0PCnO1oqhpu+FmeJRxwJWeuvED9IYRecSYoEUaQgi9hz0imTavYSwmtgC6Fn3D+5ZUX6JN2J+0iGAM1i68fGSoMAaXQjw6f/xv/KuKNUHQr3reTrG8HB21sEx6QVAwmqgIRUpXv0iwBYVNDCR44w+kDxulbD1GR2bYGka4EiqG/hQ4NVtNURAN3NR3uUvC/Dolt/7DMvSrsus5W5tiuKnlHLTYYLLBFS4xcemBsmKJpnmrQCxmucoO1rmI8qkoRiqoBynQ0X8tsQ7rZ5LUICPC77/oQexmK4pBq9jc9nRPObKlyA//kaZAxlT0MBu8MbT4AaIGc/j6AYy3pUJyLBqoy1+FFcb9Kzok87HgpLJI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(39860400002)(376002)(396003)(451199015)(40470700004)(36840700001)(46966006)(2906002)(36860700001)(83380400001)(40480700001)(16526019)(2616005)(41300700001)(1076003)(40460700003)(336012)(86362001)(82740400003)(36756003)(82310400005)(81166007)(110136005)(356005)(26005)(426003)(44832011)(5660300002)(8676002)(478600001)(8936002)(47076005)(4326008)(70206006)(186003)(70586007)(316002)(6666004)(7696005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 11:19:21.5405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ff73f6-9b05-42e8-6975-08dad90e0e21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4918
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
 drivers/cpufreq/intel_pstate.c   | 37 +---------------------
 include/linux/cpufreq_common.h   | 53 ++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+), 40 deletions(-)
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
index ad9be31753b6..1b842ed874ab 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -26,6 +26,7 @@
 #include <linux/vmalloc.h>
 #include <linux/pm_qos.h>
 #include <trace/events/power.h>
+#include <linux/cpufreq_common.h>
 
 #include <asm/cpu.h>
 #include <asm/div64.h>
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
index 000000000000..c1224e3bc68b
--- /dev/null
+++ b/include/linux/cpufreq_common.h
@@ -0,0 +1,53 @@
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
+#endif /* _LINUX_CPUFREQ_COMMON_H */
-- 
2.34.1

