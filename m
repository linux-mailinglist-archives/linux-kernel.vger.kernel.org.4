Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 776FC5FA1E4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiJJQYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJJQY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:24:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EAD75488;
        Mon, 10 Oct 2022 09:24:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AG3RYrn1ER0Fq/9Enl3QSEjvCcKkeHK6mfKI7ulLXiDgEE5MBBqka/fbgOAkXMuP5ptUOgNT8bXGwZCS66QI4BninxRtnEUOFkUGcRtBAYTmnkUh36tA7ipk76UL1sa4NfkqmnL11BY9KXNtTzCCxm1Hg+fEkIE2S/ZoYBVJnF0ZPPfCQ6bMC10Kb/7Yyr7kCt5wd2bAIzy130kuagHw48IN+cZUpb55u2MB+cedLauRHoFDcgBn65M5gWB9wQQKZ0JfifogLNuCUbbcmcEjErLjJ8p6b6bXrEn3tymijStqwSWXEK5WfmUcf1vtI0GAlu0K4G8/gR/6rF9nVU8n9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2Yiqcd9DpiLO3Xbupw0WSuLfxWSL9oxgTFNoruRZeo=;
 b=NSEyU3Q4KT0286vELJTA+XO601U/cJ/obpzBd2ISljcVbVt/8Hlwcdk52Z/wO0RDb1dOPJGiqiSAd4HAE66iLRJdNDgA8xcMbdkYk9vYXAM1Mw2gnZfpOqPULD3J+qH6eF2js10/BoOk0D0dVr0wcPOVQJA38e7HgKmwL3PJikRPCIVbl9xcWKQmn555+OPs8mCY/c4bXGOFTmkIOnDIFPaWC90El3Jf9nKFgMs+/UAn6RlM6X8LPOapJsUseOSezSlI0Mj7qqriV2xz/rytg0stAGQfFRC+SeMCjdmCWmRzlDV/BtUzl8YiDV9XxVJen6YjO30L2SfNf8CYNLBUzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2Yiqcd9DpiLO3Xbupw0WSuLfxWSL9oxgTFNoruRZeo=;
 b=iR4PmhuDGnMpQzx31t3LlmVwhhq/UpuWFt0QAjdQMGl0AXNq6+6TdwL8xaDZ7NQj05oD8b3oB0frfGwx16m3bRnE6Oa83EAA3jnMori4ZrW1d5e+DMJxC9qbsL713fVt8wNlqAXhQmIDfNGjZW3z7PkdFuvTUnSe1Djn8zDQoOE=
Received: from DM6PR18CA0002.namprd18.prod.outlook.com (2603:10b6:5:15b::15)
 by SJ1PR12MB6195.namprd12.prod.outlook.com (2603:10b6:a03:457::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Mon, 10 Oct
 2022 16:24:01 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::de) by DM6PR18CA0002.outlook.office365.com
 (2603:10b6:5:15b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19 via Frontend
 Transport; Mon, 10 Oct 2022 16:24:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Mon, 10 Oct 2022 16:24:00 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 10 Oct 2022 11:23:56 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [RESEND PATCH V2 8/9] cpufreq: amd_pstate: implement amd pstate cpu online and offline callback
Date:   Tue, 11 Oct 2022 00:22:47 +0800
Message-ID: <20221010162248.348141-9-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010162248.348141-1-Perry.Yuan@amd.com>
References: <20221010162248.348141-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|SJ1PR12MB6195:EE_
X-MS-Office365-Filtering-Correlation-Id: 269ed44f-b39c-49d3-2ad6-08daaadbd70f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHRHRQrUf82Uxzz0uXHNnrx3dBtwUEX5dAz+Ixn1V+K/ofnWhYl4GOlcrxky7JN7MG3Ko1+TaP9CmZQMiPSi/xFlElqGGwy7LSVQ5ljUsNIlZPNSZkXGLY7V8nNQ8ikhXcCO1jLobC4/2Yj+Utsz4KbQQgG0sTWUBmHBr2ZMhuLMxKNix5Rql/9n4N/YT9W4zbozKCfWwYVttj/zLf36hE9tzASUqA3qH8HrN6yrLNxjUG1sJaNnnCRXVEcLDafawxx1kdK/3hz+z+ntNKtMzmudSzabyIdszTj8i7awi1EQtLpO9HGoAW4IX0oJUGfJFaqwTzMZuX5MxHmVKbDJVILrnwwY26MB1o3+Zx0UzGIy2RXknKICxaDCY6U4BZA/STLSUNv7pqSnTJeePMcjHZASR/2atqNHe9/Gb6WPUCBdD8O+6rFwOCFQOOrIeX9dRsCh/MdgWIi3miMT/x+/fw9xXf+suPdqkbu+CkP3pBNAe7XNcJXJ87tU0Z/a1IjlbhZb1FArq72O24NIFIx8BW9mmdpgYLw8Ds6JdDPp4SX09h41zz5uLky+dBtMb9SFd1Xo7omVALh6qG1v1/I+kW6Tv/Hw+r57jGzFsaI50LCOTTYGQ5nhtCoYXRwbq7Do+HW/8Z4NgaMxicjAkhDDdeDcA1xWDQsj21OhldTbjbBHl9TkjrbdkSoXsg4k7r9szWedv7RQ/y/2J7f7dC2Jf4+S0KP+PHPUv3gquHLc62f4QGIQQUTIF5qoOfJghLjNzidstUWTgXTvqNcaB57B8dh9F2Ql4Mbu8VAmAJBTVW7vamkIKDdIFAId9wX41Y7VwPOUgxebUlj2kOE8CrjVNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(16526019)(426003)(40460700003)(1076003)(83380400001)(47076005)(336012)(186003)(8936002)(41300700001)(316002)(82740400003)(356005)(7696005)(2616005)(36860700001)(26005)(36756003)(478600001)(4326008)(40480700001)(54906003)(5660300002)(2906002)(110136005)(81166007)(86362001)(70206006)(82310400005)(8676002)(6666004)(70586007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 16:24:00.8220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 269ed44f-b39c-49d3-2ad6-08daaadbd70f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6195
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds online and offline driver callback support to allow cpu cores go
offline and help to restore the previous working states when core goes
back online later for EPP driver mode.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 101 ++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 58418808aadf..8d99714022e3 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -115,7 +115,8 @@ struct amd_aperf_mperf {
  * @cppc_cap1_cached: Cached value of the last CPPC Capabilities MSR
  * @update_util: Cpufreq utility callback information
  * @sample: the stored performance sample
-
+ * @suspended:	Whether or not the driver has been suspended.
+ *
  * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
  * represents all the attributes and goals that AMD P-State requests at runtime.
  */
@@ -155,6 +156,7 @@ struct amd_cpudata {
 	u64	cppc_cap1_cached;
 	struct	update_util_data update_util;
 	struct	amd_aperf_mperf sample;
+	bool suspended;
 };
 
 /**
@@ -215,6 +217,9 @@ static DEFINE_SPINLOCK(amd_pstate_cpu_lock);
 static bool cppc_boost __read_mostly;
 struct kobject *amd_pstate_kobj;
 
+/* the flag whether the pstate driver is exiting */
+static bool pstate_exiting;
+
 #ifdef CONFIG_ACPI_CPPC_LIB
 static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
 {
@@ -1377,6 +1382,96 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
+{
+	struct cppc_perf_ctrls perf_ctrls;
+	u64 value, max_perf;
+	int ret;
+
+	ret = amd_pstate_enable(true);
+	if (ret)
+		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
+
+	value = READ_ONCE(cpudata->cppc_req_cached);
+	max_perf = READ_ONCE(cpudata->highest_perf);
+
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+	} else {
+		perf_ctrls.max_perf = max_perf;
+		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(cpudata->epp_cached);
+		cppc_set_perf(cpudata->cpu, &perf_ctrls);
+	}
+}
+
+static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+
+	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
+
+	if (epp) {
+		amd_pstate_epp_reenable(cpudata);
+		cpudata->suspended = false;
+	}
+
+	return 0;
+}
+
+static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+	struct cppc_perf_ctrls perf_ctrls;
+	int min_perf;
+	u64 value;
+
+	min_perf = READ_ONCE(cpudata->lowest_perf);
+	value = READ_ONCE(cpudata->cppc_req_cached);
+
+	mutex_lock(&amd_pstate_limits_lock);
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
+
+		/* Set max perf same as min perf */
+		value &= ~AMD_CPPC_MAX_PERF(~0L);
+		value |= AMD_CPPC_MAX_PERF(min_perf);
+		value &= ~AMD_CPPC_MIN_PERF(~0L);
+		value |= AMD_CPPC_MIN_PERF(min_perf);
+		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+	} else {
+		perf_ctrls.desired_perf = 0;
+		perf_ctrls.max_perf = min_perf;
+		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(AMD_CPPC_EPP_POWERSAVE);
+		cppc_set_perf(cpudata->cpu, &perf_ctrls);
+	}
+	mutex_unlock(&amd_pstate_limits_lock);
+}
+
+static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+
+	pr_debug("AMD CPU Core %d going offline\n", cpudata->cpu);
+
+	if (cpudata->suspended)
+		return 0;
+
+	if (pstate_exiting)
+		return 0;
+
+	if (epp)
+		amd_pstate_epp_offline(policy);
+
+	return 0;
+}
+
+static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
+{
+	amd_pstate_clear_update_util_hook(policy->cpu);
+
+	return amd_pstate_cpu_offline(policy);
+}
+
 static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
 					   struct cpufreq_policy_data *policy)
 {
@@ -1411,6 +1506,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.init		= amd_pstate_epp_cpu_init,
 	.exit		= amd_pstate_epp_cpu_exit,
 	.update_limits	= amd_pstate_epp_update_limits,
+	.offline	= amd_pstate_epp_cpu_offline,
+	.online		= amd_pstate_epp_cpu_online,
 	.name		= "amd_pstate_epp",
 	.attr		= amd_pstate_epp_attr,
 };
@@ -1480,6 +1577,7 @@ static int __init amd_pstate_init(void)
 		pr_err("amd-pstate: Sysfs attribute export failed with error %d.\n",
 		       ret);
 	}
+	pstate_exiting = false;
 
 	return ret;
 }
@@ -1494,6 +1592,7 @@ static void __exit amd_pstate_exit(void)
 {
 	unsigned int cpu;
 
+	pstate_exiting = true;
 	cpufreq_unregister_driver(default_pstate_driver);
 
 	amd_pstate_enable(false);
-- 
2.34.1

