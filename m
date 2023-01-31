Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A73682811
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjAaJFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjAaJE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:04:58 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAA512F1D;
        Tue, 31 Jan 2023 01:01:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVrquHnov8xG8YE1vPPkh7Ts72jY1G5cNARVCyxVS2thFWxeV1ox84YgowpBrbKC+AQHFCkwIpy3EJxWOx9cuFr2V8jOTwBnOLuuvR1SVtMcLWHWFPEdZ/9Cl+sa/PrEXVR8HftZoJAJapHbS2wP/jS6954ANibKg69C1mcfDqkvARXI/ix0befnoPUO1Z7f6jUICSPeDITdzP9WwpSpR/2xbb/CuXiUrwdSkrxnr9TI/QrkDbJx1+q0+JA23Q8MiF4FuLvO/MnvkcdswGtXgyH/l4uRNFJHmB9pkT1kXOyQ6m8h/3AdgVGDYg6jfo/oiptsRE4bg7FMoNM+64bvqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5uA2rmTwSFb/euFCMFD8jQ/zaTV1h7q4gy2KstYMewU=;
 b=k+VuCbilb608A/YjW1uHFx3+dSo3+hN+E+Oy+47nMwMBtaG+nMfNKF7wSPKIOg3oO7ONgWP4OgWL9mfcnNgLgi03MdBkt1t22LGFpRnA2R3zYBx4NEejChWHYS/NZ8FjcjcmqP2oHZmZXNai56xFcuAnfh725wdptmcfNiweE0rkqCX+2HJrqdXuXaW3ZCGXNIHfDeYa67UnVHUjliYAQtuf5fU9frMY3eFPEVE5Iy7gPLpETTqeOpPqdets9KkZ7zv+vadsK5y7oLCTtosGXht6d7pEZjUMAKW1Vqq/oA+2rwItpD+V8VqiPOzhYZBpcDEHgXAHS7zleIGtdArQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5uA2rmTwSFb/euFCMFD8jQ/zaTV1h7q4gy2KstYMewU=;
 b=j3hXNCJSTXw5edfwwwpBQma/ft/4uTCNfeopRkRfaiFrwf6mZZVqZY9MOw4M5DLHk2ve3u4X/liyD2RHw6/mKBTHqtIZELV1LGTSGUJQpxIjFSB7OC2UigUXOtpOy6ibLTCZY7rV9yrXNNotXOv/5jw7nSssGuJX2U88laJOQyc=
Received: from MW2PR16CA0071.namprd16.prod.outlook.com (2603:10b6:907:1::48)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 09:00:59 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::f1) by MW2PR16CA0071.outlook.office365.com
 (2603:10b6:907:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 09:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Tue, 31 Jan 2023 09:00:59 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 31 Jan 2023 03:00:54 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 04/11] cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors
Date:   Tue, 31 Jan 2023 17:00:09 +0800
Message-ID: <20230131090016.3970625-5-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131090016.3970625-1-perry.yuan@amd.com>
References: <20230131090016.3970625-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|BL1PR12MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: dc67783e-5990-4af9-c109-08db0369abef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voquU9EnSK1ny2c/R82zgOu82LNbK0SarpoyGLm6khRpjZK3mM7gScxZNsT9Bhyv3b1crcijBxcqAe/bWuO86n0W8iGxBx4v/ZoQQTSf04rn71ClGD8zcbY5B6Nj47E9UqHFyuJz0ScOVqSaG39zeQ+ah6iFSM1LKUQNZD/0aud7UI22sj0OEjlK2p1MNXEQl3t2CxxXXUfTBsCnhEzBn3HK8Fa7hu0ojv7nOEy0btcqEwV3NKsFjVyPSfj78jJktWZf02TosP7XbAFdYtA63YbVbWgCnaRrcPfrm12QCH0lXU/C4Ij2xaRLd35OS3PEspe9NTzWt9uv4q+PTJ053KX9iNLFUJs1v8t/yAwkPBsttpbS1xJgeia7Rtm122RgLZLoDwenoLVfImfUGk5efQ6q40DmCycejTEbLUSTgAm7kVc19TdQ2U87rQst2+u1kmUFHkeZq1SWEq3M7tdHARj1j1CJJdgu+jR5m5xrRub5NQQfrJyW2uaDkN52T7A5VPs0ZAySN41Sgqz1tjZGLDpIlBn+JnwR5rnG2XbpHt9/qAQTxyvymzgi5rUCUayUATh/bH340v6Cl8M7ruQQgVDvg1B+lRAvMe9+sb3blkugdlr4jiwXFmSFa0BP77NHi6jjSoK0Qp+ySTTUcG2vW53XLXHvSU2V5Kj/nRnRbTB1kp4iAx7m6Uxrzv9gu/V5wvvdTSy9/H5CXa01lEy2/bYO9P3hwVxTZ4eEKiYyqLo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199018)(40470700004)(46966006)(36840700001)(36756003)(70206006)(54906003)(316002)(110136005)(82310400005)(8676002)(4326008)(5660300002)(70586007)(41300700001)(8936002)(86362001)(81166007)(356005)(82740400003)(36860700001)(66899018)(6666004)(16526019)(186003)(26005)(1076003)(30864003)(83380400001)(336012)(426003)(40480700001)(40460700003)(44832011)(2906002)(7696005)(47076005)(478600001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:00:59.2560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc67783e-5990-4af9-c109-08db0369abef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 420 ++++++++++++++++++++++++++++++++++-
 include/linux/amd-pstate.h   |  16 +-
 2 files changed, 429 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 65c16edbbb20..bca86b5b8b12 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -59,9 +59,52 @@
  * we disable it by default to go acpi-cpufreq on these processors and add a
  * module parameter to be able to enable it manually for debugging.
  */
+static struct cpufreq_driver *current_pstate_driver;
 static struct cpufreq_driver amd_pstate_driver;
+static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_DISABLE;
 
+/*
+ * AMD Energy Preference Performance (EPP)
+ * The EPP is used in the CCLK DPM controller to drive
+ * the frequency that a core is going to operate during
+ * short periods of activity. EPP values will be utilized for
+ * different OS profiles (balanced, performance, power savings)
+ * display strings corresponding to EPP index in the
+ * energy_perf_strings[]
+ *	index		String
+ *-------------------------------------
+ *	0		default
+ *	1		performance
+ *	2		balance_performance
+ *	3		balance_power
+ *	4		power
+ */
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
+	[EPP_INDEX_DEFAULT] = 0,
+	[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_PERFORMANCE,
+	[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_BALANCE_PERFORMANCE,
+	[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_BALANCE_POWERSAVE,
+	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
+ };
+
 static inline int get_mode_idx_from_str(const char *str, size_t size)
 {
 	int i;
@@ -73,6 +116,114 @@ static inline int get_mode_idx_from_str(const char *str, size_t size)
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
+	case AMD_CPPC_EPP_PERFORMANCE:
+		index = EPP_INDEX_PERFORMANCE;
+		break;
+	case AMD_CPPC_EPP_BALANCE_PERFORMANCE:
+		index = EPP_INDEX_BALANCE_PERFORMANCE;
+		break;
+	case AMD_CPPC_EPP_BALANCE_POWERSAVE:
+		index = EPP_INDEX_BALANCE_POWERSAVE;
+		break;
+	case AMD_CPPC_EPP_POWERSAVE:
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
@@ -81,11 +232,21 @@ static inline int pstate_enable(bool enable)
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
@@ -429,7 +590,7 @@ static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
 		return;
 
 	cpudata->boost_supported = true;
-	amd_pstate_driver.boost_enabled = true;
+	current_pstate_driver->boost_enabled = true;
 }
 
 static void amd_perf_ctl_reset(unsigned int cpu)
@@ -603,10 +764,61 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
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
@@ -615,6 +827,186 @@ static struct freq_attr *amd_pstate_attr[] = {
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
+	/*
+	 * Resetting PERF_CTL_MSR will put the CPU in P0 frequency,
+	 * which is ideal for initialization process.
+	 */
+	amd_perf_ctl_reset(policy->cpu);
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
+	cpudata->epp_cached = amd_pstate_get_epp(cpudata, 0);
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
@@ -628,6 +1020,16 @@ static struct cpufreq_driver amd_pstate_driver = {
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
@@ -656,7 +1058,8 @@ static int __init amd_pstate_init(void)
 	/* capability check */
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
-		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
+		if (cppc_state == AMD_PSTATE_PASSIVE)
+			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 	} else {
 		pr_debug("AMD CPPC shared memory based functionality is supported\n");
 		static_call_update(amd_pstate_enable, cppc_enable);
@@ -667,14 +1070,13 @@ static int __init amd_pstate_init(void)
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
@@ -696,6 +1098,12 @@ static int __init amd_pstate_param(char *str)
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
index dae2ce0f6735..72ea7cf85ca3 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -12,6 +12,11 @@
 
 #include <linux/pm_qos.h>
 
+#define AMD_CPPC_EPP_PERFORMANCE		0x00
+#define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
+#define AMD_CPPC_EPP_BALANCE_POWERSAVE		0xBF
+#define AMD_CPPC_EPP_POWERSAVE			0xFF
+
 /*********************************************************************
  *                        AMD P-state INTERFACE                       *
  *********************************************************************/
@@ -47,6 +52,10 @@ struct amd_aperf_mperf {
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
@@ -72,6 +81,12 @@ struct amd_cpudata {
 
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
@@ -90,5 +105,4 @@ static const char * const amd_pstate_mode_string[] = {
 	[AMD_PSTATE_ACTIVE]      = "active",
 	NULL,
 };
-
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1

