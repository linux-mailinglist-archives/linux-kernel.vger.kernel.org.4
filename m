Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6F96507AD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiLSGlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiLSGlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:41:19 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834872705;
        Sun, 18 Dec 2022 22:41:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iLDJB6rOyoztVuVcYHMi8TGY0berLEla896dbQl4KhGOh0IUd9aLAVtLt9xlykIxopc5IIYGn9zrIKku8ToEY0WZXW75lKpYt7KvaT1OeXuL+Yvl9tVAeUsfMmMVuZRmrhZPW+3TrIgNcSPCgGw7ppM588tyM4U+JO2/YggKlwyyp7V29wQa+2dh9O7F9QVLLnH/K21lum11mJVLwRrlO8dnS+phRxj+8m4pHvdHonxcBHsABw91N2L+YVoA7PsQ3i6vWCQf/3/vPxUPFEYAGY9hjJbIhG6mJM4urEM7txryJCT7BkJR39Y6welTCoTbHMiR7b9ICP+gB8Rwa9g0tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnGzgkj1d5hl5bqxaj97jkRjB2piESwrOgPJMHi0N3o=;
 b=DbZ6mZBEiEbvxlALm48x3S5ZHPst6rDciw++v84vNwJi7lIApXqC6eSQaHrFfskB11/q3hTJUhdnZbkNNnFePRVLEAPD+ER7lzF7isTRuzjyn7ANbk/kV0AIb98O+qWEw6tZZR4fL/DLALKcNoSrdDkKZi7ug2i0vTxHEYAZVDLxUlbJzeP+6CxeY7P8wdj828NspnAVsgGqO+wndcaYmsQjkueslqD5f79fzyDF211A0BU4/eE+8K4TzC/geVp7qRu3bUPeFW1lRiG5IFu4yYl58PYANcJlqhRxKQWsajExq1gock5r6WyBhZI7oh6fKWhGgGwNwNx+uOmhurre5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnGzgkj1d5hl5bqxaj97jkRjB2piESwrOgPJMHi0N3o=;
 b=oND5HEWEerZ4sHYMkqGwJ/jU9JH8hiwwwDyN/oITtiomx+ZamScXa/wMAZxor9EYvrSxPAH83UkfnpLZ37Qmzm0sdpMdgow/rpBOi+51mpyJ6/5CJhvgtg6GyvGu0JgRuEYhYD3TowSmQqoZMTOm0Zk6o81YIr2HfxSyjFeiQ8o=
Received: from DS7PR03CA0304.namprd03.prod.outlook.com (2603:10b6:8:2b::16) by
 DM4PR12MB6664.namprd12.prod.outlook.com (2603:10b6:8:bb::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5924.16; Mon, 19 Dec 2022 06:41:14 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::5c) by DS7PR03CA0304.outlook.office365.com
 (2603:10b6:8:2b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.20 via Frontend
 Transport; Mon, 19 Dec 2022 06:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.16 via Frontend Transport; Mon, 19 Dec 2022 06:41:14 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 00:41:10 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 03/13] cpufreq: intel_pstate: use common macro definition for Energy Preference Performance(EPP)
Date:   Mon, 19 Dec 2022 14:40:32 +0800
Message-ID: <20221219064042.661122-4-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219064042.661122-1-perry.yuan@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|DM4PR12MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c77821-82d4-4a1f-8c04-08dae18c0657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/YS4Wc1nO4ZuNSqx2ono+2aU1YLIxBKQYFtG538BkTiXlttX9aM2Wmk4Y/Qhoa6QRPc8Le8qhALwO/2/M9eo8Yukvd6nD8+gaW5/WhkupZBCa7vZsJl1BGxcUd7jO149OY0RwolPV4RkpF9Bg0031J68BB2miflyF/V8dU1uq2rCyq3rZp1FnW1Fj0USOlzhFS0pDfMgGyKEdOaEmk4kLtajVm/1Z8Tddlwm1CUKKnhpxSr3HetfZ4KhvJYD1vfd5Iv7agPQgGOYoVbbysqojx6J9jCJCjUXfQLK39XMGQOvTXNJgBkHF7WBekVI1GC2R4rywJeukNRGak1BJQ/IF4PLhuscqe20dazKlU3+HU1RyiV6E2jk5ARsOrGgLmZZ/+bNS1OsFjjT88MAFi0+0Tt0+MFVCaUmMqiKI4kUKlux9BsE8O0BU7Yd9zPOUeOdOcqvrMiBXGJ9rk/33SQBWIXUANOmD/jk8lOxF0SapfFoyH2UCQYLdEE64pD19yrsnGLeZzruhbYsFoHDJWG3ot4dGI7rUAQJ9q/syGXvQFFSJDA4kbX/ns+7kHfqJATWvscpwNrcJm6HUPozpwCJpPVNDGh1Eh9K1VwXhF7cJFhXvTNbw9rzhzsGvbY9Bfhrynb6SrGjVrHteDL/n1zKID+IPeBZN7QLd0s1Q3hMQE3JO4Bv5Bb4x/r2pXYS5UnU9fwCpfdXVjVU4fyzhaDpTpm6BIoo5OExPvjzsDVqZU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(46966006)(40470700004)(36840700001)(6666004)(54906003)(316002)(110136005)(36860700001)(40480700001)(2906002)(70586007)(70206006)(40460700003)(478600001)(1076003)(47076005)(426003)(86362001)(2616005)(26005)(4326008)(8676002)(16526019)(186003)(36756003)(8936002)(44832011)(81166007)(82740400003)(7696005)(82310400005)(41300700001)(356005)(83380400001)(5660300002)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 06:41:14.3793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c77821-82d4-4a1f-8c04-08dae18c0657
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6664
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
 drivers/cpufreq/intel_pstate.c | 13 +++----------
 include/linux/cpufreq.h        | 11 +++++++++++
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ad9be31753b6..93a60fdac0fc 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -640,15 +640,7 @@ static int intel_pstate_set_epb(int cpu, s16 pref)
  *	4		power
  */
 
-enum energy_perf_value_index {
-	EPP_INDEX_DEFAULT = 0,
-	EPP_INDEX_PERFORMANCE,
-	EPP_INDEX_BALANCE_PERFORMANCE,
-	EPP_INDEX_BALANCE_POWERSAVE,
-	EPP_INDEX_POWERSAVE,
-};
-
-static const char * const energy_perf_strings[] = {
+const char * const energy_perf_strings[] = {
 	[EPP_INDEX_DEFAULT] = "default",
 	[EPP_INDEX_PERFORMANCE] = "performance",
 	[EPP_INDEX_BALANCE_PERFORMANCE] = "balance_performance",
@@ -656,7 +648,8 @@ static const char * const energy_perf_strings[] = {
 	[EPP_INDEX_POWERSAVE] = "power",
 	NULL
 };
-static unsigned int epp_values[] = {
+
+unsigned int epp_values[] = {
 	[EPP_INDEX_DEFAULT] = 0, /* Unused index */
 	[EPP_INDEX_PERFORMANCE] = HWP_EPP_PERFORMANCE,
 	[EPP_INDEX_BALANCE_PERFORMANCE] = HWP_EPP_BALANCE_PERFORMANCE,
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d5595d57f4e5..e63309d497fe 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -20,6 +20,7 @@
 #include <linux/pm_qos.h>
 #include <linux/spinlock.h>
 #include <linux/sysfs.h>
+#include <asm/msr.h>
 
 /*********************************************************************
  *                        CPUFREQ INTERFACE                          *
@@ -185,6 +186,16 @@ struct cpufreq_freqs {
 	u8 flags;		/* flags of cpufreq_driver, see below. */
 };
 
+enum energy_perf_value_index {
+	EPP_INDEX_DEFAULT = 0,
+	EPP_INDEX_PERFORMANCE,
+	EPP_INDEX_BALANCE_PERFORMANCE,
+	EPP_INDEX_BALANCE_POWERSAVE,
+	EPP_INDEX_POWERSAVE,
+};
+extern const char * const energy_perf_strings[];
+extern unsigned int epp_values[];
+
 /* Only for ACPI */
 #define CPUFREQ_SHARED_TYPE_NONE (0) /* None */
 #define CPUFREQ_SHARED_TYPE_HW	 (1) /* HW does needed coordination */
-- 
2.34.1

