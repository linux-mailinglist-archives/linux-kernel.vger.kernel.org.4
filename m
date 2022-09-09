Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EBA5B3D5D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiIIQr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiIIQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:47:26 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBFE146D04;
        Fri,  9 Sep 2022 09:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx7EP9mqFK+TXGJND4QNtB0hsEyF+qp9h+Y6d/0irAZ3OWAT/iS7aLtGfiR3TU5sEScyC43fGFLPfMRvSnhgnb2EiBdnh2O6UkAWdB5OBmeEKZfUN8RURCb02um42Lfq+ZGo3Jj7w3drJfQnDzWLsQe3ZjUdtbtoV6/5g/xqmG7g1ZRJbBu4WEIe6oqT3QpcOhiszQ8mE+Urz01B5zCPM+eKTPLyr6DPzkZGn47ySxuQs4HFaNtAGEwIjQ7LhdetEdR3s7xX04MEKM5Rr8d+8Mliqb7iJoMw0E0gkI1NmApJQhmCRiPvAq2rZnilGboRCGCYe1+rf3DfK1kogxZaNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6Ycvo2wuZ7o7I7F+cCdX7XCjNYwQAdEJAO9ivbW850=;
 b=HkownsdW6ZLaahHmBOosLH2cYiwGmbpzQngv2h+dQ+zJqE21xKm2Tpkr2BfyLDfuXPH2Se8us81tv7jb2rlqJBS3wPiMSxcvjrNXYxyufNYzgpbzcdxPkrdJS6Rm3iHLnwPbd2KbDjAvSdDM7rh8/om246RJYKkSOV64HX4jm+IJXztTNR58wqPUSHn5sMaqOdgrHzyY0DAFKpKd+sNTrwd+g2g86jy1DfnDL3rC1hM6j/rgVlvFGCLsugw1By/rbwlI2NBSSU58dg2jRYzHjN73SptZgFyTPrYsWYwoHkB9lvwQ7HavNg35G3QVmmuIlhJF/7VuupEcHU8EieygMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6Ycvo2wuZ7o7I7F+cCdX7XCjNYwQAdEJAO9ivbW850=;
 b=1djuIjQ1rNF4LA89w1YtKB9IACp17ilAL6zS/biP3R/BJH84JuIfikz5vTB85Sunck1MdBjCa2yPRGa6tWoljPnm9MIZXXNVQ2zeNAKCUQmaurLuT53rgxY9lwwsUEmYRUYRoMxaQ1NvFozz6nVIlP66cyQx9pXyfGZne37MDk8=
Received: from BN0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:e4::24)
 by DS7PR12MB6190.namprd12.prod.outlook.com (2603:10b6:8:99::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 16:47:18 +0000
Received: from BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::68) by BN0PR02CA0019.outlook.office365.com
 (2603:10b6:408:e4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 16:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT091.mail.protection.outlook.com (10.13.176.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 16:47:18 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 9 Sep 2022 11:47:14 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 6/7] cpufreq: amd_pstate: implement amd pstate cpu online and offline callback
Date:   Sat, 10 Sep 2022 00:45:33 +0800
Message-ID: <20220909164534.71864-7-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909164534.71864-1-Perry.Yuan@amd.com>
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT091:EE_|DS7PR12MB6190:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd43aae-8a70-499a-9030-08da9282f57d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7LE6V53kZhNHMgiGoQvF09DOLafgW8XLe9wdevaSBcMSZOOAcK6ReZQBOW449RfuTAVsX6myIMAFzm8fFKQdpH9/pwQbrY0ed/WnFF5WTfYk+18JYClhoMxTG069xVsUPg8kL3IshWLsY0Oltz8dtjf2fJx54MPNjT+M44YK/5BuMK17dYbYE6Re5NqMAjbGeLKxyC6Z3Mr+p0SG+LSmOIrOiFiQN3atXErspwSA8REloX2r59jR0gJJvyeNzJAPzufWAmre/ChEEDpKSaYv+i8rPkMOC7tXNNC2cva09fqzLWWtUIHd0p+LwiVKlGauTHHU1Bv73sxdkOrjArT93yqxfOxLJILGrcQMOJjXwIw+qBXhSLFOEOHpVOzSl31NPiZrYpB02preKuwSskTnljK+vUN/Q7E+KnRaspsBSFncS2mLSTx/DJXFZ+jyWCi//Bor2UyVr/mqMehRM5HnkOgPUFaoOMAZTaJ5TwOzHkYqvtYnqZCfczFMjbGavEbjEk3C9w4yckYexkSAM8UPlOkmxt1DQZkXx8bzl4AxMulPBg4eWIiRgh+RhyuNmvN2RUW4tgyv4bcCxiYUTjCP/PBEfmD7wT3/jr2V54NQOfhtSfasb/KJ+lsSfjV3Gqeog5YbJugdrEE8S8Qw9jml4w8GRM4TeYSpUSaTSdV8niib7vS43kBscJU3BiEOfKDd2ygU3TuibufnpLS8LNuGaz6W8/zoZi7OaHOkv9LXWDQxJj7R1mrUGjlhKQHCyJOS9j2gc2axjwgJGKNJbKOv9+L/RVe/U1Y4F/nvjbahgnvGPoFF0Gz8yJHaBcO4KeTvF40AYk/XN3/yzAvU1UUfog==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966006)(40470700004)(36840700001)(82740400003)(41300700001)(36860700001)(356005)(81166007)(40460700003)(54906003)(316002)(110136005)(40480700001)(5660300002)(2906002)(8936002)(336012)(70206006)(70586007)(4326008)(8676002)(47076005)(7696005)(426003)(2616005)(16526019)(186003)(82310400005)(6666004)(83380400001)(1076003)(478600001)(86362001)(26005)(36756003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:47:18.7147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd43aae-8a70-499a-9030-08da9282f57d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6190
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds online and offline driver callback to support to allow cpu cores go
offline and help to restore the previous working states when core goes
back online later for EPP driver mode.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 93 +++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e71b06e20050..e63fed39f90c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -111,7 +111,8 @@ struct amd_aperf_mperf {
  * @cppc_cap1_cached: Cached value of the last CPPC Capabilities MSR
  * @update_util: Cpufreq utility callback information
  * @sample: the stored performance sample
-
+ * @suspended:	Whether or not the driver has been suspended.
+ *
  * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
  * represents all the attributes and goals that AMD P-State requests at runtime.
  */
@@ -151,6 +152,7 @@ struct amd_cpudata {
 	u64	cppc_cap1_cached;
 	struct	update_util_data update_util;
 	struct	amd_aperf_mperf sample;
+	bool suspended;
 };
 
 /**
@@ -1387,6 +1389,93 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static void amd_pstate_epp_reenable(struct amd_cpudata * cpudata)
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
+                value |= AMD_CPPC_MAX_PERF(min_perf);
+                value &= ~AMD_CPPC_MIN_PERF(~0L);
+                value |= AMD_CPPC_MIN_PERF(min_perf);
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
@@ -1421,6 +1510,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.init		= amd_pstate_epp_cpu_init,
 	.exit		= amd_pstate_epp_cpu_exit,
 	.update_limits	= amd_pstate_epp_update_limits,
+	.offline	= amd_pstate_epp_cpu_offline,
+	.online		= amd_pstate_epp_cpu_online,
 	.name		= "amd_pstate_epp",
 	.attr		= amd_pstate_epp_attr,
 };
-- 
2.34.1

