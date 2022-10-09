Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415C85F89F6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 09:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiJIHMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 03:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiJIHMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 03:12:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537EA32EC8;
        Sun,  9 Oct 2022 00:11:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIHjWcxtQ9uvIPVzNW1w9wwzB/q5Z8oQeORHje8wYEEoGPw4CDambTSUHEpQBe36HlfToYAISjHpJ3G8ELFpb6nbcDd4jGnnu4XA1Iti9a/oxoYeCjNVs1A5iW1dh2HGIFlVGab6i9izKlqP9s7kIpYR+NfeVFNATQ3CFnw5KE5CpXunfQERoFdr43nPfBB9nb6JygfF2Uy2/HV8fKNzPamdztv6qyVupPb+kErSofWN0uIZ6vpp+0S5tEWTyslZ+WeMrpSyBXMHstRYxF/wDa50yZMF45gTdKKfErXVoLY1yxDIPn2fYzG9FzX3/BFa+qJsalppoH+MTeFEvgAH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rur2Ae3e0XBhSL02k2EV41i/hm2m/P/8GHajXbu4SXA=;
 b=Lt9/uJpzxXtl20XhuMuteylhu8b16AOHWxS5ejnws5atvEntCB3ZlErk0IlLZXvMoG4ss0gIge0Iow9oJYOUTx9bWnhkQvJ47b4wzQ5x+wja4u1r9e/kzOs7MF0Y4pWZfj04nRS5/F6jUlC3Q0zTVW75Bm6dAvR2M3gw1XgDyh+mn6egYUtIKpVOMpi1wVoT4wy9cJgxg16oGmfyzWluD0fwuN79+Kg+fV6wCRjm2VW0u1wCefLKZ0tRBuNs82SZLLrW0ADoBI+0d7NtKDaO9Nux+SSC5PZcZLDGdOzAu7MgCgq+IX+EXVbGh8RVR/IXAJo1pQtqvqrPZ1d+9zLheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rur2Ae3e0XBhSL02k2EV41i/hm2m/P/8GHajXbu4SXA=;
 b=FoQ0M4L8RL3fTZPUT9LVeWiLpF7F25Uy8kNEADuMajQBhC6Qi9up/qrXsms0jri1jeNyuGb+HUluwl3wIyvTC6XWT/sHXFLUyvJGizyoDkUYxpw7MD5S/Xo5lZRvnCeV6ST/65VgF1c047zvZs0goSmQWxogwwrpG6mMlIuND20=
Received: from DS7P222CA0025.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::31) by
 PH7PR12MB6761.namprd12.prod.outlook.com (2603:10b6:510:1ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Sun, 9 Oct
 2022 07:11:36 +0000
Received: from DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::63) by DS7P222CA0025.outlook.office365.com
 (2603:10b6:8:2e::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Sun, 9 Oct 2022 07:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT046.mail.protection.outlook.com (10.13.172.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Sun, 9 Oct 2022 07:11:35 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 9 Oct 2022 02:11:32 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v2 8/9] cpufreq: amd_pstate: implement amd pstate cpu online and offline callback
Date:   Sun, 9 Oct 2022 15:10:32 +0800
Message-ID: <20221009071033.21170-9-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221009071033.21170-1-Perry.Yuan@amd.com>
References: <20221009071033.21170-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT046:EE_|PH7PR12MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e23a09c-d815-4a9c-6960-08daa9c580b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWF9QqK58jCc3XgH3tkAUvIAe6DTcF69Mo5xBN6/Ie80d6orNqXGDbPV/5MeMrgAcTvqweqG2zhX4dqm9BC3AkQ/9DhR83/A3wOg2kTRMuUOQQVizcTurt+IeqTGk2iteaV49pwsaHA17Az0bJAVeIUFHDl49eMO0q78CtwQbKkva+I0HJIW0eQBfsRrPao5KQTRCEq7IJLpDLITm7GMUM/efuGw1vlPDHPPMrjsoVcXl+WMxJ2i5lvna1ZkXumgeNM7fduWSKUrBTtfNtEvn6nrNhNTLGu4902mvy9kHlnBeobBL39abRPUWI7SwLL2CBPdfCUFfgbl6VP4uNtUbUS0rE2eR3+jHpWDAIK9yr3S6MFvgKgcwW/3GmKCtjH0lEEqahTvbgiJAM/1pRb3a3+Neebs/3owbbaLHBYOWinHuiQcv2dri/kbGXAFwyVxApD2Dv9k6UOVHf8gfBzxMgNqgaZwGoVEqshe2hLk9Jz7TR8AB11YiX+gvDpKLU6Be5jsi1vhUIi6xY/7s9VRC4xXwgbVYyNjuR+X2IAcgs8R7yn2aExTpOe/z9I/GjYao9FXcmmge1KrA2jKcdMPKDlhhv1V33R05rUTMSbIGy0jSlJohuuuSMhhDjGCSJZmLJERGhKbq6axbZhwugKvZ1wPWHqYRruV7sWimuMX8CEwDBuMyhUMD/FnrcY+AxHiphJaJLoFyZFqxu91mMLFKobwY3ftchVRsg+e0jrs3lrKUgAhFUKzUwtc1rw2tE9XxMJHA1A7K6OAnGudDbhH49kYVA368MV1l4oFEIbtPgJ+RvAVDuofGzxKQsQOPkWD4wS/M8DAn7y2ddEj/eDnRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(40470700004)(46966006)(36840700001)(70586007)(82310400005)(36756003)(70206006)(8676002)(2906002)(40480700001)(110136005)(40460700003)(186003)(478600001)(5660300002)(1076003)(26005)(54906003)(86362001)(4326008)(7696005)(81166007)(16526019)(83380400001)(82740400003)(8936002)(2616005)(426003)(36860700001)(316002)(41300700001)(356005)(336012)(47076005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 07:11:35.8851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e23a09c-d815-4a9c-6960-08daa9c580b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6761
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
index 98fb4a31791e..1a3ecc2e148a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -116,7 +116,8 @@ struct amd_aperf_mperf {
  * @cppc_cap1_cached: Cached value of the last CPPC Capabilities MSR
  * @update_util: Cpufreq utility callback information
  * @sample: the stored performance sample
-
+ * @suspended:	Whether or not the driver has been suspended.
+ *
  * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
  * represents all the attributes and goals that AMD P-State requests at runtime.
  */
@@ -156,6 +157,7 @@ struct amd_cpudata {
 	u64	cppc_cap1_cached;
 	struct	update_util_data update_util;
 	struct	amd_aperf_mperf sample;
+	bool suspended;
 };
 
 /**
@@ -216,6 +218,9 @@ static DEFINE_SPINLOCK(amd_pstate_cpu_lock);
 static bool cppc_boost __read_mostly;
 struct kobject *amd_pstate_kobj;
 
+/* the flag whether the pstate driver is exiting */
+static bool pstate_exiting;
+
 #ifdef CONFIG_ACPI_CPPC_LIB
 static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
 {
@@ -1378,6 +1383,96 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
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
+	if (epp_enabled) {
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
+	if (epp_enabled)
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
@@ -1412,6 +1507,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.init		= amd_pstate_epp_cpu_init,
 	.exit		= amd_pstate_epp_cpu_exit,
 	.update_limits	= amd_pstate_epp_update_limits,
+	.offline	= amd_pstate_epp_cpu_offline,
+	.online		= amd_pstate_epp_cpu_online,
 	.name		= "amd_pstate_epp",
 	.attr		= amd_pstate_epp_attr,
 };
@@ -1481,6 +1578,7 @@ static int __init amd_pstate_init(void)
 		pr_err("amd-pstate: Sysfs attribute export failed with error %d.\n",
 		       ret);
 	}
+	pstate_exiting = false;
 
 	return ret;
 }
@@ -1495,6 +1593,7 @@ static void __exit amd_pstate_exit(void)
 {
 	unsigned int cpu;
 
+	pstate_exiting = true;
 	cpufreq_unregister_driver(default_pstate_driver);
 
 	amd_pstate_enable(false);
-- 
2.34.1

