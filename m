Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7F46248DE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiKJR7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbiKJR7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:59:33 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3A145EE2;
        Thu, 10 Nov 2022 09:59:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYn/WAijyWjPoHm41au4kYq51vpNCMfynTgDqpeRBT3JYxKAXeUMPfAOOslwGeEQvNOeo0l9TsAt9L7m4iwTorOHmGqdcYhX2+OhvY+pTLZedeS5YVNjdLwMncfaeuVbki5xsZopjqZHinmtLOQDHo2p8F7I1OxagHQxwK8+KlPHILcSd8d47q2WWrsAkSUyKmzx/Xsac2GUUBJdI/0nQjXgYEae3cu5cmVlHm83mVQnL5JZRy6jzf4b66VasMLvIucTTEn646w5ksaJPXPLA23Oak+QDImSnRRIlsX+6zNaUkXnDf/0jvOXlY5V7vz7kBYVrxFK4TjLlS2SEUdqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+5k49sTT3ndU5xvhlLCFpmGpuszq/9rsln3ImBn9vU=;
 b=H0skZ/tGr356qhraOfQjgQVPJn2uOuBdwIbkSw3y/iZzThrgJWpLZEUHn6wwCBt1RTnlaGsJQRjl0yYR6OlU29sIhojr38rydZ2xUnP5Uh1ixPz9x03/KSHosxLCwk51ZCvW5GCN5a1t8hPYS5nia3o35EvEuqoA6VLA12nZW1gcdx9xu6chGXxY0h7JWUqMIQ9yE4zohdUeT0QmLpUqbjZAPUxCG7+H6n4xSRhLlaC1Xqr7Jbl61ath4tmC9OApIsIBNbLQfmMuVwyQpH2nPf9KcC/gA2PEuYuC9yJRxMUqoaMoT7ALnLc+0QcoJsQB94mud1e41PaK5elhgN7sBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+5k49sTT3ndU5xvhlLCFpmGpuszq/9rsln3ImBn9vU=;
 b=zUYVoIlMdZHASeONOaLuLBa57LoTzYDDzfyDC4qcb81xhcnR2LoryYeRmXN7ioPFyYGM53qudjMqA6eHl93eYWQvsYkzU/cB5T9yePgaEkkfU6sHei2SU0eUxwOONDsYKM4nhM7ksix6nVYwT4fFqZiHOttpaOhD1xELa+egHSc=
Received: from BN9PR03CA0875.namprd03.prod.outlook.com (2603:10b6:408:13c::10)
 by DS7PR12MB6023.namprd12.prod.outlook.com (2603:10b6:8:85::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.25; Thu, 10 Nov 2022 17:59:27 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::d0) by BN9PR03CA0875.outlook.office365.com
 (2603:10b6:408:13c::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13 via Frontend
 Transport; Thu, 10 Nov 2022 17:59:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 17:59:27 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 11:59:23 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 4/9] cpufreq: amd_pstate: implement Pstate EPP support for the AMD processors
Date:   Fri, 11 Nov 2022 01:58:42 +0800
Message-ID: <20221110175847.3098728-5-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221110175847.3098728-1-Perry.Yuan@amd.com>
References: <20221110175847.3098728-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|DS7PR12MB6023:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a680f37-fbab-43f8-dbee-08dac3454f1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtcDKMPD9AEpAy3Gu8sK1ZD9+np1BjLsFIAuZejF/r91SlNyjFWr+dX6rsKIChQL030koz/qwznsor7fyzflJz8lCumlHK/rN5hlwpx509qVq8l9jaFh1OJJjbITzCRidgMWAjoXisxcZ0HcuLW9k+yYNISoUaUmkzkuy1uROg2hETLOOzmvCsRHXFR3xdnXRCGOqGrxk1BnIt5UuuVPcU4V5gPFK/74QBiPzB/EDL3lr37NiHv2P/7hgixBAUHmeRreFsfqDJXhfs9L0RB7BqEjgVrZAzsn/pRDLCirELDM0W3UpsNIXGIAsbRk0/xsO1vFO3+nETjgbA/dx9AMEqDuMVu0EyMKElcF796JiLMVRHRjjZDTcvQgFrcGFjxtUs+SPdIYifd5XZkgroq6TMHF5Hv62tkqQKoA7QVNnWvLnvUJR9ony4PVaSeQ0Po5JUd/omzfYEYwyOmDHvxIXb0NzLBsv3P6yLsI5SDenlThp8d5yZMVoVxCBZOZElpz5EZxBYOPExmNpfHokch+WKLrIjpOftrEif7ffXSXeVNSck/TRAMsRnlLLdYx78XE13Gb7HOfAbWjlL1X/RGFBOKiMN2/bjWBW1rjHk6Wr44JvQt4USzyVl3wdQZiczwMyJ5DYe5jgmPBL+n6Zlpkr7dL8w4WLf3rc70cWwvqdsEM1zbs+Ad6drqeR8uvT12FRAZjwgP5kHX+8g6lO1a1fz4p6D9xIwD7CT0yFFKz2HliNyrs0KPWCV1kgwQSAj1QC8E/F0ktyXkrsqzciVjmr2uZnW28rWUcgfHKZJrQRtM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(83380400001)(8936002)(86362001)(478600001)(356005)(81166007)(54906003)(5660300002)(82740400003)(40480700001)(70206006)(6666004)(70586007)(8676002)(316002)(2906002)(186003)(2616005)(426003)(30864003)(26005)(47076005)(1076003)(16526019)(7696005)(40460700003)(110136005)(82310400005)(4326008)(336012)(41300700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 17:59:27.3550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a680f37-fbab-43f8-dbee-08dac3454f1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6023
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 652 ++++++++++++++++++++++++++++++++++-
 include/linux/amd-pstate.h   |  81 +++++
 2 files changed, 726 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 85a0b3fb56c2..7b3a12772582 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -60,8 +60,131 @@
  * module parameter to be able to enable it manually for debugging.
  */
 static bool shared_mem __read_mostly;
+static int cppc_active __read_mostly;
+static int cppc_load __initdata;
+static int epp_off __initdata;
 
-static struct cpufreq_driver amd_pstate_driver;
+static struct cpufreq_driver *default_pstate_driver;
+static struct amd_cpudata **all_cpu_data;
+
+static struct amd_pstate_params global_params;
+
+static DEFINE_MUTEX(amd_pstate_limits_lock);
+static DEFINE_MUTEX(amd_pstate_driver_lock);
+
+static bool cppc_boost __read_mostly;
+struct kobject *amd_pstate_kobj;
+
+#ifdef CONFIG_ACPI_CPPC_LIB
+static s16 amd_pstate_get_epp(struct amd_cpudata *cpudata, u64 cppc_req_cached)
+{
+	s16 epp;
+	struct cppc_perf_caps perf_caps;
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
+		ret = cppc_get_epp_caps(cpudata->cpu, &perf_caps);
+		if (ret < 0) {
+			pr_debug("Could not retrieve energy perf value (%d)\n", ret);
+			return -EIO;
+		}
+		epp = (s16) perf_caps.energy_perf;
+	}
+
+	return epp;
+}
+#endif
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
+		case AMD_CPPC_EPP_PERFORMANCE:
+			index = EPP_INDEX_PERFORMANCE;
+			break;
+		case AMD_CPPC_EPP_BALANCE_PERFORMANCE:
+			index = EPP_INDEX_BALANCE_PERFORMANCE;
+			break;
+		case AMD_CPPC_EPP_BALANCE_POWERSAVE:
+			index = EPP_INDEX_BALANCE_POWERSAVE;
+			break;
+		case AMD_CPPC_EPP_POWERSAVE:
+			index = EPP_INDEX_POWERSAVE;
+			break;
+		default:
+			break;
+	}
+
+	return index;
+}
+
+#ifdef CONFIG_ACPI_CPPC_LIB
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
+#endif
 
 static inline int pstate_enable(bool enable)
 {
@@ -71,11 +194,21 @@ static inline int pstate_enable(bool enable)
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
+		if (!cppc_active) {
+			/* Set desired perf as zero to allow EPP firmware control */
+			perf_ctrls.desired_perf = 0;
+			ret = cppc_set_perf(cpu, &perf_ctrls);
+			if (ret)
+				return ret;
+		}
 	}
 
 	return ret;
@@ -418,7 +551,7 @@ static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
 		return;
 
 	cpudata->boost_supported = true;
-	amd_pstate_driver.boost_enabled = true;
+	default_pstate_driver->boost_enabled = true;
 }
 
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
@@ -582,10 +715,62 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 	return sprintf(&buf[0], "%u\n", perf);
 }
 
+static ssize_t show_energy_performance_available_preferences(
+				struct cpufreq_policy *policy, char *buf)
+{
+	int i = 0;
+	int ret = 0;
+
+	while (energy_perf_strings[i] != NULL)
+		ret += sprintf(&buf[ret], "%s ", energy_perf_strings[i++]);
+
+	ret += sprintf(&buf[ret], "\n");
+
+	return ret;
+}
+
+static ssize_t store_energy_performance_preference(
+		struct cpufreq_policy *policy, const char *buf, size_t count)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+	char str_preference[21];
+	ssize_t ret;
+	u32 epp = 0;
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
+	return  sprintf(buf, "%s\n", energy_perf_strings[preference]);
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
 cpufreq_freq_attr_ro(amd_pstate_highest_perf);
+cpufreq_freq_attr_rw(energy_performance_preference);
+cpufreq_freq_attr_ro(energy_performance_available_preferences);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -594,6 +779,415 @@ static struct freq_attr *amd_pstate_attr[] = {
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
+static inline void update_boost_state(void)
+{
+	u64 misc_en;
+	struct amd_cpudata *cpudata;
+
+	cpudata = all_cpu_data[0];
+	rdmsrl(MSR_K7_HWCR, misc_en);
+	global_params.cppc_boost_disabled = misc_en & BIT_ULL(25);
+}
+
+static int amd_pstate_init_cpu(unsigned int cpunum)
+{
+	struct amd_cpudata *cpudata;
+
+	cpudata = all_cpu_data[cpunum];
+	if (!cpudata) {
+		cpudata = kzalloc(sizeof(*cpudata), GFP_KERNEL);
+		if (!cpudata)
+			return -ENOMEM;
+		WRITE_ONCE(all_cpu_data[cpunum], cpudata);
+
+		cpudata->cpu = cpunum;
+	}
+	cpudata->epp_powersave = -EINVAL;
+	cpudata->epp_policy = 0;
+	pr_debug("controlling: cpu %d\n", cpunum);
+	return 0;
+}
+
+static int __amd_pstate_cpu_init(struct cpufreq_policy *policy)
+{
+	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
+	struct amd_cpudata *cpudata;
+	struct device *dev;
+	int rc;
+	u64 value;
+
+	rc = amd_pstate_init_cpu(policy->cpu);
+	if (rc)
+		return rc;
+
+	cpudata = all_cpu_data[policy->cpu];
+
+	dev = get_cpu_device(policy->cpu);
+	if (!dev)
+		goto free_cpudata1;
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
+	policy->min = min_freq;
+	policy->max = max_freq;
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
+	update_boost_state();
+	cpudata->epp_cached = amd_pstate_get_epp(cpudata, value);
+
+	policy->min = policy->cpuinfo.min_freq;
+	policy->max = policy->cpuinfo.max_freq;
+
+	if (boot_cpu_has(X86_FEATURE_CPPC))
+		policy->fast_switch_possible = true;
+
+	if (!shared_mem && boot_cpu_has(X86_FEATURE_CPPC)) {
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
+static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
+{
+	int ret;
+
+	ret = __amd_pstate_cpu_init(policy);
+	if (ret)
+		return ret;
+	/*
+	 * Set the policy to powersave to provide a valid fallback value in case
+	 * the default cpufreq governor is neither powersave nor performance.
+	 */
+	policy->policy = CPUFREQ_POLICY_POWERSAVE;
+
+	return 0;
+}
+
+static int amd_pstate_epp_cpu_exit(struct cpufreq_policy *policy)
+{
+	pr_debug("CPU %d exiting\n", policy->cpu);
+	policy->fast_switch_possible = false;
+	return 0;
+}
+
+static void amd_pstate_update_max_freq(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = policy = cpufreq_cpu_get(cpu);
+
+	if (!policy)
+		return;
+
+	refresh_frequency_limits(policy);
+	cpufreq_cpu_put(policy);
+}
+
+static void amd_pstate_epp_update_limits(unsigned int cpu)
+{
+	mutex_lock(&amd_pstate_driver_lock);
+	update_boost_state();
+	if (global_params.cppc_boost_disabled) {
+		for_each_possible_cpu(cpu)
+			amd_pstate_update_max_freq(cpu);
+	} else {
+		cpufreq_update_policy(cpu);
+	}
+	mutex_unlock(&amd_pstate_driver_lock);
+}
+
+static int cppc_boost_hold_time_ns = 3 * NSEC_PER_MSEC;
+
+static inline void amd_pstate_boost_up(struct amd_cpudata *cpudata)
+{
+	u64 hwp_req = READ_ONCE(cpudata->cppc_req_cached);
+	u64 hwp_cap = READ_ONCE(cpudata->cppc_cap1_cached);
+	u32 max_limit = (hwp_req & 0xff);
+	u32 min_limit = (hwp_req & 0xff00) >> 8;
+	u32 boost_level1;
+
+	/* If max and min are equal or already at max, nothing to boost */
+	if (max_limit == min_limit)
+		return;
+
+	/* Set boost max and min to initial value */
+	if (!cpudata->cppc_boost_min)
+		cpudata->cppc_boost_min = min_limit;
+
+	boost_level1 = ((AMD_CPPC_NOMINAL_PERF(hwp_cap) + min_limit) >> 1);
+
+	if (cpudata->cppc_boost_min < boost_level1)
+		cpudata->cppc_boost_min = boost_level1;
+	else if (cpudata->cppc_boost_min < AMD_CPPC_NOMINAL_PERF(hwp_cap))
+		cpudata->cppc_boost_min = AMD_CPPC_NOMINAL_PERF(hwp_cap);
+	else if (cpudata->cppc_boost_min == AMD_CPPC_NOMINAL_PERF(hwp_cap))
+		cpudata->cppc_boost_min = max_limit;
+	else
+		return;
+
+	hwp_req &= ~AMD_CPPC_MIN_PERF(~0L);
+	hwp_req |= AMD_CPPC_MIN_PERF(cpudata->cppc_boost_min);
+	wrmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, hwp_req);
+	cpudata->last_update = cpudata->sample.time;
+}
+
+static inline void amd_pstate_boost_down(struct amd_cpudata *cpudata)
+{
+	bool expired;
+
+	if (cpudata->cppc_boost_min) {
+		expired = time_after64(cpudata->sample.time, cpudata->last_update +
+					cppc_boost_hold_time_ns);
+
+		if (expired) {
+			wrmsrl_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ,
+						cpudata->cppc_req_cached);
+			cpudata->cppc_boost_min = 0;
+		}
+	}
+
+	cpudata->last_update = cpudata->sample.time;
+}
+
+static inline void amd_pstate_boost_update_util(struct amd_cpudata *cpudata,
+						      u64 time)
+{
+	cpudata->sample.time = time;
+	if (smp_processor_id() != cpudata->cpu)
+		return;
+
+	if (cpudata->sched_flags & SCHED_CPUFREQ_IOWAIT) {
+		bool do_io = false;
+
+		cpudata->sched_flags = 0;
+		/*
+		 * Set iowait_boost flag and update time. Since IO WAIT flag
+		 * is set all the time, we can't just conclude that there is
+		 * some IO bound activity is scheduled on this CPU with just
+		 * one occurrence. If we receive at least two in two
+		 * consecutive ticks, then we treat as boost candidate.
+		 * This is leveraged from Intel Pstate driver.
+		 */
+		if (time_before64(time, cpudata->last_io_update + 2 * TICK_NSEC))
+			do_io = true;
+
+		cpudata->last_io_update = time;
+
+		if (do_io)
+			amd_pstate_boost_up(cpudata);
+
+	} else {
+		amd_pstate_boost_down(cpudata);
+	}
+}
+
+static inline void amd_pstate_cppc_update_hook(struct update_util_data *data,
+						u64 time, unsigned int flags)
+{
+	struct amd_cpudata *cpudata = container_of(data,
+				struct amd_cpudata, update_util);
+
+	cpudata->sched_flags |= flags;
+
+	if (smp_processor_id() == cpudata->cpu)
+		amd_pstate_boost_update_util(cpudata, time);
+}
+
+static void amd_pstate_clear_update_util_hook(unsigned int cpu)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[cpu];
+
+	if (!cpudata->update_util_set)
+		return;
+
+	cpufreq_remove_update_util_hook(cpu);
+	cpudata->update_util_set = false;
+	synchronize_rcu();
+}
+
+static void amd_pstate_set_update_util_hook(unsigned int cpu_num)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[cpu_num];
+
+	if (!cppc_boost) {
+		if (cpudata->update_util_set)
+			amd_pstate_clear_update_util_hook(cpudata->cpu);
+		return;
+	}
+
+	if (cpudata->update_util_set)
+		return;
+
+	cpudata->sample.time = 0;
+	cpufreq_add_update_util_hook(cpu_num, &cpudata->update_util,
+						amd_pstate_cppc_update_hook);
+	cpudata->update_util_set = true;
+}
+
+static void amd_pstate_epp_init(unsigned int cpu)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[cpu];
+	u32 max_perf, min_perf;
+	u64 value;
+	s16 epp;
+	int ret;
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
+		cpudata->epp_powersave = epp;
+		if (epp < 0)
+			goto skip_epp;
+		/* force the epp value to be zero for performance policy */
+		epp = 0;
+	} else {
+		if (cpudata->epp_powersave < 0)
+			goto skip_epp;
+		/* Get BIOS pre-defined epp value */
+		epp = amd_pstate_get_epp(cpudata, value);
+		if (epp)
+			goto skip_epp;
+		epp = cpudata->epp_powersave;
+	}
+	/* Set initial EPP value */
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		value &= ~GENMASK_ULL(31, 24);
+		value |= (u64)epp << 24;
+	}
+
+skip_epp:
+	WRITE_ONCE(cpudata->cppc_req_cached, value);
+	ret = wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+	if (!ret)
+		cpudata->epp_cached = epp;
+}
+
+static void amd_pstate_set_max_limits(struct amd_cpudata *cpudata)
+{
+	u64 hwp_cap = READ_ONCE(cpudata->cppc_cap1_cached);
+	u64 hwp_req = READ_ONCE(cpudata->cppc_req_cached);
+	u32 max_limit = (hwp_cap >> 24) & 0xff;
+
+	hwp_req &= ~AMD_CPPC_MIN_PERF(~0L);
+	hwp_req |= AMD_CPPC_MIN_PERF(max_limit);
+	wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, hwp_req);
+}
+
+static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata;
+
+	if (!policy->cpuinfo.max_freq)
+		return -ENODEV;
+
+	pr_debug("set_policy: cpuinfo.max %u policy->max %u\n",
+				policy->cpuinfo.max_freq, policy->max);
+
+	cpudata = all_cpu_data[policy->cpu];
+	cpudata->policy = policy->policy;
+
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		mutex_lock(&amd_pstate_limits_lock);
+
+		if (cpudata->policy == CPUFREQ_POLICY_PERFORMANCE) {
+			amd_pstate_clear_update_util_hook(policy->cpu);
+			amd_pstate_set_max_limits(cpudata);
+		} else {
+			amd_pstate_set_update_util_hook(policy->cpu);
+		}
+
+		if (boot_cpu_has(X86_FEATURE_CPPC))
+			amd_pstate_epp_init(policy->cpu);
+
+		mutex_unlock(&amd_pstate_limits_lock);
+	}
+
+	return 0;
+}
+
+static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
+					   struct cpufreq_policy_data *policy)
+{
+	update_boost_state();
+	cpufreq_verify_within_cpu_limits(policy);
+}
+
+static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
+{
+	amd_pstate_verify_cpu_policy(all_cpu_data[policy->cpu], policy);
+	pr_debug("policy_max =%d, policy_min=%d\n", policy->max, policy->min);
+	return 0;
+}
+
 static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
@@ -607,8 +1201,20 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.attr		= amd_pstate_attr,
 };
 
+static struct cpufreq_driver amd_pstate_epp_driver = {
+	.flags		= CPUFREQ_CONST_LOOPS,
+	.verify		= amd_pstate_epp_verify_policy,
+	.setpolicy	= amd_pstate_epp_set_policy,
+	.init		= amd_pstate_epp_cpu_init,
+	.exit		= amd_pstate_epp_cpu_exit,
+	.update_limits	= amd_pstate_epp_update_limits,
+	.name		= "amd_pstate_epp",
+	.attr		= amd_pstate_epp_attr,
+};
+
 static int __init amd_pstate_init(void)
 {
+	static struct amd_cpudata **cpudata;
 	int ret;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
@@ -623,19 +1229,37 @@ static int __init amd_pstate_init(void)
 	if (cpufreq_get_current_driver())
 		return -EEXIST;
 
+	/* set the pstate driver disabled by default if there
+	 * is no early parameters set
+	 */
+	if (!cppc_load) {
+		pr_debug("disabled to load\n");
+		return -ENODEV;
+	}
+
+	if (!epp_off) {
+		WRITE_ONCE(cppc_active, 1);
+		if (!default_pstate_driver)
+			default_pstate_driver = &amd_pstate_epp_driver;
+	}
+
 	/* capability check */
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
-		pr_debug("AMD CPPC MSR based functionality is supported\n");
-		amd_pstate_driver.adjust_perf = amd_pstate_adjust_perf;
+		if (!cppc_active)
+			default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 	} else if (shared_mem) {
 		static_call_update(amd_pstate_enable, cppc_enable);
 		static_call_update(amd_pstate_init_perf, cppc_init_perf);
 		static_call_update(amd_pstate_update_perf, cppc_update_perf);
 	} else {
-		pr_info("This processor supports shared memory solution, you can enable it with amd_pstate.shared_mem=1\n");
+		pr_info("This processor supports shared memory solution, enable it with amd_pstate=legacy_cppc\n");
 		return -ENODEV;
 	}
 
+	cpudata = vzalloc(array_size(sizeof(void *), num_possible_cpus()));
+	if (!cpudata)
+		return -ENOMEM;
+	WRITE_ONCE(all_cpu_data, cpudata);
 	/* enable amd pstate feature */
 	ret = amd_pstate_enable(true);
 	if (ret) {
@@ -643,9 +1267,9 @@ static int __init amd_pstate_init(void)
 		return ret;
 	}
 
-	ret = cpufreq_register_driver(&amd_pstate_driver);
+	ret = cpufreq_register_driver(default_pstate_driver);
 	if (ret)
-		pr_err("failed to register amd_pstate_driver with return %d\n",
+		pr_err("failed to register amd pstate driver with return %d\n",
 		       ret);
 
 	return ret;
@@ -657,6 +1281,20 @@ static int __init amd_pstate_param(char *str)
 	if (!str)
 		return -EINVAL;
 
+	/*
+	 * Disable amd-pstate driver by default for now
+	 * append amd-pstate=active or amd-pstate=active
+	 * to enable driver loaded
+	 */
+	if (!strcmp(str, "active")) {
+		cppc_load = 1;
+		default_pstate_driver = &amd_pstate_epp_driver;
+	} else if (!strcmp(str, "passive")) {
+		epp_off = 1;
+		cppc_load = 1;
+		default_pstate_driver = &amd_pstate_driver;
+	}
+
 	/*
 	 * support shared memory type CPPC which has no MSR function.
 	 * enable amd-pstate on processors with shared memory solution
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 1c4b8659f171..7e6e8cab97b3 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -25,6 +25,7 @@ struct amd_aperf_mperf {
 	u64 aperf;
 	u64 mperf;
 	u64 tsc;
+	u64 time;
 };
 
 /**
@@ -47,6 +48,18 @@ struct amd_aperf_mperf {
  * @prev: Last Aperf/Mperf/tsc count value read from register
  * @freq: current cpu frequency value
  * @boost_supported: check whether the Processor or SBIOS supports boost mode
+ * @epp_powersave: Last saved CPPC energy performance preference
+				when policy switched to performance
+ * @epp_policy: Last saved policy used to set energy-performance preference
+ * @epp_cached: Cached CPPC energy-performance preference value
+ * @policy: Cpufreq policy value
+ * @sched_flags: Store scheduler flags for possible cross CPU update
+ * @update_util_set: CPUFreq utility callback is set
+ * @last_update: Time stamp of the last performance state update
+ * @cppc_boost_min: Last CPPC boosted min performance state
+ * @cppc_cap1_cached: Cached value of the last CPPC Capabilities MSR
+ * @update_util: Cpufreq utility callback information
+ * @sample: the stored performance sample
  *
  * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
  * represents all the attributes and goals that AMD P-State requests at runtime.
@@ -72,6 +85,74 @@ struct amd_cpudata {
 
 	u64	freq;
 	bool	boost_supported;
+
+	/* EPP feature related attributes*/
+	s16	epp_powersave;
+	s16	epp_policy;
+	s16	epp_cached;
+	u32	policy;
+	u32	sched_flags;
+	bool	update_util_set;
+	u64	last_update;
+	u64	last_io_update;
+	u32	cppc_boost_min;
+	u64	cppc_cap1_cached;
+	struct	update_util_data update_util;
+	struct	amd_aperf_mperf sample;
+};
+
+/**
+ * struct amd_pstate_params - global parameters for the performance control
+ * @ cppc_boost_disabled wheher the core performance boost disabled
+ */
+struct amd_pstate_params {
+	bool cppc_boost_disabled;
+};
+
+#define AMD_CPPC_EPP_PERFORMANCE		0x00
+#define AMD_CPPC_EPP_BALANCE_PERFORMANCE	0x80
+#define AMD_CPPC_EPP_BALANCE_POWERSAVE		0xBF
+#define AMD_CPPC_EPP_POWERSAVE			0xFF
+
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
 };
 
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1

