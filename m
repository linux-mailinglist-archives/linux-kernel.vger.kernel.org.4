Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF7465FB44
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjAFGPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjAFGPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:15:08 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F75F6CFD3;
        Thu,  5 Jan 2023 22:15:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lPcwsVK+uwHdCRgA+/4VZyzF5K4Db0hWIuZi/mVzsquf3Yz5JjG5XjXF5VoGLucqJYL6fu/O/dGKqnKvKfPi+cT9JrQzwNvJEiCPhcFKaIDbSWa9zGcksZkduvD35WdnxRXiGbgGa5tNpBLhDqHdIgvRDJkdVeKowTaCSk0UehsbaBJEo9GMbzyK+cAMTFoiPFv6+CYIig67VDjjfbYgXeHNfpOMxaFSD6ABQdr3aGbUsHmLmzPAe4Bj8z9HtCiDnl3rJrAqGb9LJj0aOp7bFuDH8qyj+g/v1wzThLkiZYPbel9fzvz9cYIv7neT8R2k2Om+Uc+IZZQXWyn38F5rsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjNk/Yg9cp/Hbs/emrPgDzuFqz8DhyuBJXkwlFZ3DAM=;
 b=I89fPnWWeSgAlp7oRVVRdgeZjqzxqKtT7giLivHU2JzbCVPN+Y4syfbwnMnQIM9BuCN7+WKmmj7B1y9RVBtB8qOhylUc3hA5GEcNQyjceD3xbTFgf0gQwyvD8JwSllEt9K1IFcgYTnrWslkmc+GCvSkzeTgOSEvVvy8m6hclqOWYQ1qX14PDR4g4oQ2+S7i1GjlE01VLdu8s1/uwMtb513oaiciBbMHKEZhq0zV4P+jezIinrQH6WZrGOT577MIPOduZiwrWtDb+WJ8HbxWM/MfXHgsjNASXxbWC4U1Dy7pFaadaklWCRvLfUZHxneJBhDq/AIvbDEWwVLAsFYACVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjNk/Yg9cp/Hbs/emrPgDzuFqz8DhyuBJXkwlFZ3DAM=;
 b=Bqtq1mqQmN5ZAz4hXxvRbv71SXi6rqe4rNYjt4SP2F0HHYPa6kuA8PsRjTPkDqpaJ6RyUNwHjJjZr/qXLiuC9Gro5dQbcM1uMUBh4OqyIBkAQbIndI3krSmMwahpr1GSvzC4UIbiDl4V/nxOKju9uvrKWDB1NxC13vmpWy7kMCg=
Received: from DM6PR02CA0052.namprd02.prod.outlook.com (2603:10b6:5:177::29)
 by IA1PR12MB6258.namprd12.prod.outlook.com (2603:10b6:208:3e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 06:14:57 +0000
Received: from DS1PEPF0000E632.namprd02.prod.outlook.com
 (2603:10b6:5:177:cafe::f7) by DM6PR02CA0052.outlook.office365.com
 (2603:10b6:5:177::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Fri, 6 Jan 2023 06:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E632.mail.protection.outlook.com (10.167.17.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.15 via Frontend Transport; Fri, 6 Jan 2023 06:14:57 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 00:14:53 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 05/12] cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors
Date:   Fri, 6 Jan 2023 14:14:13 +0800
Message-ID: <20230106061420.95715-6-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106061420.95715-1-perry.yuan@amd.com>
References: <20230106061420.95715-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E632:EE_|IA1PR12MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: e1517129-eb5f-4968-bd66-08daefad55df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mN6JpxwMLKO/+vk4lOINBuKU61ocKlDlsJSWofvwfYzLmCTn9rJFWNcczck9gNDPhR+17ZdZ5tf9gvD61dWkI3OB+oiI1HBKjtG3fZ3TgBpTYzzGoYz/2D1Wzn2J5JBxgm94IUTS8GXBwXiR+jJWk4g5T+4MA1+lquQz4JBZohMobTW9l7UzqSD8Q88HyAMDkkj6WZc0Jmgrmpc4ENlT6O0tJHVkQuR0vz02p0hYjpFA2MnwDKHxA0EU3eUkFG8gVFcOlDiY4/70xG8GoCAUq3FNT55w/IE30AK1C/HFx95oJsXGnRWSTE5/1DX0uyFH+ykuQHAyyMCvMOSEmTY0Ia9GMl+3i1FTrV7ZxbV8thuWTmFprtBjcQEm6P0sSl2aq4EsuySUktTx9zgy0vMKusXhfoUonTeLiIzVdJz9/a8IKA3aDDuGopn3tBfWBh41X/7YHgVFTR+yUsaQ6Gn+cYxLuhCEu/nIoROs9yzh3k8x4h15abNRHTB6PR/+qr9zaKOSonGcJH2WVIxmk3srBQeORVOut9v+1yJlatr6rUkYPZIVYxAWNQ/NllzZXWNkLtFslhzmWEmjCVSqc53LdWTSTqocJlkVstM0shrSWi2F4DH/b7Ge22UbNftc+BBPHaOVvb+uU0QS03wqf0mppz6KwepknhAGepRBMl8wQQkbUamVBdRq9w4IahsC9CQ+FC3zAeaUC3f5oVGANTCQOQXaPD6/rtgKVc0f3PdZSQM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(2906002)(5660300002)(44832011)(30864003)(8936002)(41300700001)(478600001)(4326008)(316002)(8676002)(54906003)(70206006)(110136005)(70586007)(6666004)(26005)(40480700001)(336012)(82310400005)(16526019)(83380400001)(426003)(47076005)(7696005)(1076003)(186003)(82740400003)(81166007)(356005)(2616005)(40460700003)(86362001)(36860700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 06:14:57.4516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1517129-eb5f-4968-bd66-08daefad55df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E632.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6258
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <Perry.Yuan@amd.com>

Add EPP driver support for AMD SoCs which support a dedicated MSR for
CPPC.  EPP is used by the DPM controller to configure the frequency that
a core operates at during short periods of activity.

The SoC EPP targets are configured on a scale from 0 to 255 where 0
represents maximum performance and 255 represents maximum efficiency.

The amd-pstate driver exports profile string names to userspace that are
tied to specific EPP values.

The balance_performance string (0x80) provides the best balance for
efficiency versus power on most systems, but users can choose other
strings to meet their needs as well.

$ cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_available_preferences
default performance balance_performance balance_power power

$ cat /sys/devices/system/cpu/cpufreq/policy0/energy_performance_preference
balance_performance

To enable the driver,it needs to add `amd_pstate=active` to kernel
command line and kernel will load the active mode epp driver

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 374 ++++++++++++++++++++++++++++++++++-
 include/linux/amd-pstate.h   |  10 +
 2 files changed, 378 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1a8b31277620..9a92c71af80f 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -59,7 +59,9 @@
  * we disable it by default to go acpi-cpufreq on these processors and add a
  * module parameter to be able to enable it manually for debugging.
  */
+static struct cpufreq_driver *current_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
+static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_DISABLE;
 
 static inline int get_mode_idx_from_str(const char *str, size_t size)
@@ -73,6 +75,114 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
 	return -EINVAL;
 }
 
+static DEFINE_MUTEX(amd_pstate_limits_lock);
+static DEFINE_MUTEX(amd_pstate_driver_lock);
+
+static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
+{
+	u64 epp;
+	int ret;
+
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		if (!cppc_req_cached) {
+			epp = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
+					&cppc_req_cached);
+			if (epp)
+				return epp;
+		}
+		epp = (cppc_req_cached >> 24) & 0xFF;
+	} else {
+		ret = cppc_get_epp_perf(cpudata->cpu, &epp);
+		if (ret < 0) {
+			pr_debug("Could not retrieve energy perf value (%d)\n", ret);
+			return -EIO;
+		}
+	}
+
+	return (s16)(epp & 0xff);
+}
+
+static int amd_pstate_get_energy_pref_index(struct amd_cpudata *cpudata)
+{
+	s16 epp;
+	int index = -EINVAL;
+
+	epp = amd_pstate_get_epp(cpudata, 0);
+	if (epp < 0)
+		return epp;
+
+	switch (epp) {
+	case HWP_EPP_PERFORMANCE:
+		index = EPP_INDEX_PERFORMANCE;
+		break;
+	case HWP_EPP_BALANCE_PERFORMANCE:
+		index = EPP_INDEX_BALANCE_PERFORMANCE;
+		break;
+	case HWP_EPP_BALANCE_POWERSAVE:
+		index = EPP_INDEX_BALANCE_POWERSAVE;
+		break;
+	case HWP_EPP_POWERSAVE:
+		index = EPP_INDEX_POWERSAVE;
+		break;
+	default:
+		break;
+	}
+
+	return index;
+}
+
+static int amd_pstate_set_epp(struct amd_cpudata *cpudata, u32 epp)
+{
+	int ret;
+	struct cppc_perf_ctrls perf_ctrls;
+
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		u64 value = READ_ONCE(cpudata->cppc_req_cached);
+
+		value &= ~GENMASK_ULL(31, 24);
+		value |= (u64)epp << 24;
+		WRITE_ONCE(cpudata->cppc_req_cached, value);
+
+		ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+		if (!ret)
+			cpudata->epp_cached = epp;
+	} else {
+		perf_ctrls.energy_perf = epp;
+		ret = cppc_set_epp_perf(cpudata->cpu, &perf_ctrls, 1);
+		if (ret) {
+			pr_debug("failed to set energy perf value (%d)\n", ret);
+			return ret;
+		}
+		cpudata->epp_cached = epp;
+	}
+
+	return ret;
+}
+
+static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
+		int pref_index)
+{
+	int epp = -EINVAL;
+	int ret;
+
+	if (!pref_index) {
+		pr_debug("EPP pref_index is invalid\n");
+		return -EINVAL;
+	}
+
+	if (epp == -EINVAL)
+		epp = epp_values[pref_index];
+
+	if (epp > 0 && cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
+		pr_debug("EPP cannot be set under performance policy\n");
+		return -EBUSY;
+	}
+
+	ret = amd_pstate_set_epp(cpudata, epp);
+
+	return ret;
+}
+
 static inline int pstate_enable(bool enable)
 {
 	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
@@ -81,11 +191,21 @@ static inline int pstate_enable(bool enable)
 static int cppc_enable(bool enable)
 {
 	int cpu, ret = 0;
+	struct cppc_perf_ctrls perf_ctrls;
 
 	for_each_present_cpu(cpu) {
 		ret = cppc_set_enable(cpu, enable);
 		if (ret)
 			return ret;
+
+		/* Enable autonomous mode for EPP */
+		if (cppc_state == AMD_PSTATE_ACTIVE) {
+			/* Set desired perf as zero to allow EPP firmware control */
+			perf_ctrls.desired_perf = 0;
+			ret = cppc_set_perf(cpu, &perf_ctrls);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return ret;
@@ -428,7 +548,7 @@ static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
 		return;
 
 	cpudata->boost_supported = true;
-	amd_pstate_driver.boost_enabled = true;
+	current_pstate_driver->boost_enabled = true;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -602,10 +722,61 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 	return sprintf(&buf[0], "%u\n", perf);
 }
 
+static ssize_t show_energy_performance_available_preferences(
+				struct cpufreq_policy *policy, char *buf)
+{
+	int i = 0;
+	int offset = 0;
+
+	while (energy_perf_strings[i] != NULL)
+		offset += sysfs_emit_at(buf, offset, "%s ", energy_perf_strings[i++]);
+
+	sysfs_emit_at(buf, offset, "\n");
+
+	return offset;
+}
+
+static ssize_t store_energy_performance_preference(
+		struct cpufreq_policy *policy, const char *buf, size_t count)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	char str_preference[21];
+	ssize_t ret;
+
+	ret = sscanf(buf, "%20s", str_preference);
+	if (ret != 1)
+		return -EINVAL;
+
+	ret = match_string(energy_perf_strings, -1, str_preference);
+	if (ret < 0)
+		return -EINVAL;
+
+	mutex_lock(&amd_pstate_limits_lock);
+	ret = amd_pstate_set_energy_pref_index(cpudata, ret);
+	mutex_unlock(&amd_pstate_limits_lock);
+
+	return ret ?: count;
+}
+
+static ssize_t show_energy_performance_preference(
+				struct cpufreq_policy *policy, char *buf)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	int preference;
+
+	preference = amd_pstate_get_energy_pref_index(cpudata);
+	if (preference < 0)
+		return preference;
+
+	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
 cpufreq_freq_attr_ro(amd_pstate_highest_perf);
+cpufreq_freq_attr_rw(energy_performance_preference);
+cpufreq_freq_attr_ro(energy_performance_available_preferences);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -614,6 +785,181 @@ static struct freq_attr *amd_pstate_attr[] = {
 	NULL,
 };
 
+static struct freq_attr *amd_pstate_epp_attr[] = {
+	&amd_pstate_max_freq,
+	&amd_pstate_lowest_nonlinear_freq,
+	&amd_pstate_highest_perf,
+	&energy_performance_preference,
+	&energy_performance_available_preferences,
+	NULL,
+};
+
+static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
+{
+	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
+	struct amd_cpudata *cpudata;
+	struct device *dev;
+	int rc;
+	u64 value;
+
+	dev = get_cpu_device(policy->cpu);
+	if (!dev)
+		goto free_cpudata1;
+
+	cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
+	if (!cpudata)
+		return -ENOMEM;
+
+	cpudata->cpu = policy->cpu;
+	cpudata->epp_policy = 0;
+
+	rc = amd_pstate_init_perf(cpudata);
+	if (rc)
+		goto free_cpudata1;
+
+	min_freq = amd_get_min_freq(cpudata);
+	max_freq = amd_get_max_freq(cpudata);
+	nominal_freq = amd_get_nominal_freq(cpudata);
+	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
+	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
+		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
+				min_freq, max_freq);
+		ret = -EINVAL;
+		goto free_cpudata1;
+	}
+
+	policy->cpuinfo.min_freq = min_freq;
+	policy->cpuinfo.max_freq = max_freq;
+	/* It will be updated by governor */
+	policy->cur = policy->cpuinfo.min_freq;
+
+	/* Initial processor data capability frequencies */
+	cpudata->max_freq = max_freq;
+	cpudata->min_freq = min_freq;
+	cpudata->nominal_freq = nominal_freq;
+	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
+
+	policy->driver_data = cpudata;
+
+	cpudata->epp_cached = amd_pstate_get_epp(cpudata, value);
+
+	policy->min = policy->cpuinfo.min_freq;
+	policy->max = policy->cpuinfo.max_freq;
+
+	/*
+	 * Set the policy to powersave to provide a valid fallback value in case
+	 * the default cpufreq governor is neither powersave nor performance.
+	 */
+	policy->policy = CPUFREQ_POLICY_POWERSAVE;
+
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		policy->fast_switch_possible = true;
+		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
+		if (ret)
+			return ret;
+		WRITE_ONCE(cpudata->cppc_req_cached, value);
+
+		ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1, &value);
+		if (ret)
+			return ret;
+		WRITE_ONCE(cpudata->cppc_cap1_cached, value);
+	}
+	amd_pstate_boost_init(cpudata);
+
+	return 0;
+
+free_cpudata1:
+	kfree(cpudata);
+	return ret;
+}
+
+static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
+{
+	pr_debug("CPU %d exiting\n", policy->cpu);
+	policy->fast_switch_possible = false;
+	return 0;
+}
+
+static void amd_pstate_epp_init(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+	struct amd_cpudata *cpudata = policy->driver_data;
+	u32 max_perf, min_perf;
+	u64 value;
+	s16 epp;
+
+	max_perf = READ_ONCE(cpudata->highest_perf);
+	min_perf = READ_ONCE(cpudata->lowest_perf);
+
+	value = READ_ONCE(cpudata->cppc_req_cached);
+
+	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE)
+		min_perf = max_perf;
+
+	/* Initial min/max values for CPPC Performance Controls Register */
+	value &= ~AMD_CPPC_MIN_PERF(~0L);
+	value |= AMD_CPPC_MIN_PERF(min_perf);
+
+	value &= ~AMD_CPPC_MAX_PERF(~0L);
+	value |= AMD_CPPC_MAX_PERF(max_perf);
+
+	/* CPPC EPP feature require to set zero to the desire perf bit */
+	value &= ~AMD_CPPC_DES_PERF(~0L);
+	value |= AMD_CPPC_DES_PERF(0);
+
+	if (cpudata->epp_policy == cpudata->policy)
+		goto skip_epp;
+
+	cpudata->epp_policy = cpudata->policy;
+
+	if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
+		epp = amd_pstate_get_epp(cpudata, value);
+		if (epp < 0)
+			goto skip_epp;
+		/* force the epp value to be zero for performance policy */
+		epp = 0;
+	} else {
+		/* Get BIOS pre-defined epp value */
+		epp = amd_pstate_get_epp(cpudata, value);
+		if (epp)
+			goto skip_epp;
+	}
+	/* Set initial EPP value */
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		value &= ~GENMASK_ULL(31, 24);
+		value |= (u64)epp << 24;
+	}
+
+skip_epp:
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
+	amd_pstate_set_epp(cpudata, epp);
+	cpufreq_cpu_put(policy);
+}
+
+static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	if (!policy->cpuinfo.max_freq)
+		return -ENODEV;
+
+	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
+				policy->cpuinfo.max_freq, policy->max);
+
+	cpudata->policy = policy->policy;
+
+	amd_pstate_epp_init(policy->cpu);
+
+	return 0;
+}
+
+static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
+{
+	cpufreq_verify_within_cpu_limits(policy);
+	pr_debug("policy_max =%d, policy_min=%d\n", policy->max, policy->min);
+	return 0;
+}
+
 static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
@@ -627,6 +973,16 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.attr		= amd_pstate_attr,
 };
 
+static struct cpufreq_driver amd_pstate_epp_driver = {
+	.flags		= CPUFREQ_CONST_LOOPS,
+	.verify		= amd_pstate_epp_verify_policy,
+	.setpolicy	= amd_pstate_epp_set_policy,
+	.init		= amd_pstate_epp_cpu_init,
+	.exit		= amd_pstate_epp_cpu_exit,
+	.name		= "amd_pstate_epp",
+	.attr		= amd_pstate_epp_attr,
+};
+
 static int __init amd_pstate_init(void)
 {
 	int ret;
@@ -655,7 +1011,8 @@ static int __init amd_pstate_init(void)
 	/* capability check */
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
-		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
+		if (cppc_state == AMD_PSTATE_PASSIVE)
+			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 	} else {
 		pr_debug("AMD CPPC shared memory based functionality is supported\n");
 		static_call_update(amd_pstate_enable, cppc_enable);
@@ -666,14 +1023,13 @@ static int __init amd_pstate_init(void)
 	/* enable amd pstate feature */
 	ret = amd_pstate_enable(true);
 	if (ret) {
-		pr_err("failed to enable amd-pstate with return %d\n", ret);
+		pr_err("failed to enable with return %d\n", ret);
 		return ret;
 	}
 
-	ret = cpufreq_register_driver(&amd_pstate_driver);
+	ret = cpufreq_register_driver(current_pstate_driver);
 	if (ret)
-		pr_err("failed to register amd_pstate_driver with return %d\n",
-		       ret);
+		pr_err("failed to register with return %d\n", ret);
 
 	return ret;
 }
@@ -695,6 +1051,12 @@ static int __init amd_pstate_param(char *str)
 		if (cppc_state == AMD_PSTATE_DISABLE)
 			pr_info("driver is explicitly disabled\n");
 
+		if (cppc_state == AMD_PSTATE_ACTIVE)
+			current_pstate_driver = &amd_pstate_epp_driver;
+
+		if (cppc_state == AMD_PSTATE_PASSIVE)
+			current_pstate_driver = &amd_pstate_driver;
+
 		return 0;
 	}
 
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index dae2ce0f6735..8341a2a2948a 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -47,6 +47,10 @@ struct amd_aperf_mperf {
  * @prev: Last Aperf/Mperf/tsc count value read from register
  * @freq: current cpu frequency value
  * @boost_supported: check whether the Processor or SBIOS supports boost mode
+ * @epp_policy: Last saved policy used to set energy-performance preference
+ * @epp_cached: Cached CPPC energy-performance preference value
+ * @policy: Cpufreq policy value
+ * @cppc_cap1_cached Cached MSR_AMD_CPPC_CAP1 register value
  *
  * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
  * represents all the attributes and goals that AMD P-State requests at runtime.
@@ -72,6 +76,12 @@ struct amd_cpudata {
 
 	u64	freq;
 	bool	boost_supported;
+
+	/* EPP feature related attributes*/
+	s16	epp_policy;
+	s16	epp_cached;
+	u32	policy;
+	u64	cppc_cap1_cached;
 };
 
 /*
-- 
2.34.1

