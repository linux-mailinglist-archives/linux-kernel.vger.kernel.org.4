Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0332E655DB4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiLYQgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiLYQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:35:44 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF7662F8;
        Sun, 25 Dec 2022 08:35:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMAY+ICMyXmMLM7IRfa5C5EyEFfZqXYLFJLfAlPWxFwP2AiwKW308ZLlWhluZiiAwYKQez5H+rm3XIaTO3VPhFm6vy5XF8SgjGifrwkH7aNKVmYM4PMf5DvKz2uotCGhTlPOTaeiaQMUWEprsgapfxeu0dMw8SuTerWv5n9B5xT2AgtKdPHK8xRgTGabRPqUHN17mta/Ufu3rha9gBjckRuzyQWj1pOtAbnvqvo9bG97cNR4NCuZMlURofOE/UveEFrmooOxKsLGkr6krJtqpkCTnZ2Q2FRNQT59ZQIQSoe+7m/Mc6ezcRXIsDG8HDNalVXADxBCWySvy20wyVntDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYiy1DvPRJYOUYYwhGxx00tzglSyMPuVl54CiYJwYlI=;
 b=KtonHRM7zBdSXLPGje4aD4pD0Yu3qm6ZgGFKx66daAVDRqpDPs3rg6guaxOkHrg1YqRw5cCDIiJnwl/ljT4AxpOitKGhZn8rlO2yQw6p2UFIOa8B2fKuXbjjxtYcDRipGAF7VIcr6EoOm/HMqTRQlHbmkQGftOReZwgwrsJKIC6c/C9XsxrEfXxzYZShjf/UArX9r19aZ5DoUoDqdczxmxVlcY3pQ4vG7t/GZ7WEiPqOHyklKA1O5NqP+i4PM8pifEiqEoa9yETLdDDIOWYT8LTAjiLHTwTk+0s8n4psvtyyzTzfUwegrOEItyv4NTkx7a/ugiWNI4nKC1K6U/tebQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYiy1DvPRJYOUYYwhGxx00tzglSyMPuVl54CiYJwYlI=;
 b=AsZ0dsgUAjZeAIqbKf0S9bjmy45VCdq4oHHSEK6hCCXaN9L87i7ecKxjoW+/1chpg5TLQPLY1e3KRZwElbRuVFcUdII8GCyYQA+p8veDJyKszXrK7uUIaM4+WHI3xV89lqkUqRcVV2ozw6FcPrVN/x+jkXhoCXtYWxabjLRxQnM=
Received: from MW4PR04CA0078.namprd04.prod.outlook.com (2603:10b6:303:6b::23)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Sun, 25 Dec
 2022 16:35:25 +0000
Received: from CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::b9) by MW4PR04CA0078.outlook.office365.com
 (2603:10b6:303:6b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16 via Frontend
 Transport; Sun, 25 Dec 2022 16:35:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT024.mail.protection.outlook.com (10.13.174.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.16 via Frontend Transport; Sun, 25 Dec 2022 16:35:24 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 25 Dec 2022 10:35:20 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 07/13] cpufreq: amd-pstate: implement amd pstate cpu online and offline callback
Date:   Mon, 26 Dec 2022 00:34:36 +0800
Message-ID: <20221225163442.2205660-8-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225163442.2205660-1-perry.yuan@amd.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT024:EE_|BN9PR12MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 62716a4c-a315-42cf-0868-08dae696061b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Wn76+I+wm1U++Byy6WAYIMjzsevBMTe0t/HLXQPxZPV/9RU32QkUE2zLfLwkKsnmlvRFr4zZplb364c2Nx2ffAm5VKXxnA9Sf80bMchYMp3mGjThMassglEXssjRFYR6X5aC7bb8wVvFTSUMdm2XvzSIkQCXH6r8vrh1f3TnZ6AbxG5TMk33shXz69Qw4sA+bG3PWzIytTF3/rKBIGBdk0/0n+UY6MoNLuHlYMRWu+JkKcGu99aSTBqyDV3sB3sBRlVJP2iv340W63coOpsMvPMQIliGJGgodYaKAySl9Zvd+qxxtfItieGKsO+m4wqLh7BhvOJtw5Rbg4CGoQBCn6KHlof+OYRIm3shEDRD7UaP6J2aqeFmkKf2UqS302XyorEJugwZpYO8XI4XoP9ALP6xz4OkP1lbNsW88L/80fxtlD/d5r5UXhDZsfFbFr+fyUrBRSzSsE7WYOJDeef4JspYLHCqeR20JcPyo25yH9oKD8U7Th4eUvgxCq2KCeJF6cSRwrH6EsHSFWlDzsjFqcJ6ZrYuX5GVYZwDa9jaTVZrWBLdRoqhrtFvWxEt5IP5ZT6QYry0W+P0o/+pdDNJenZ0B3fBvdBW2T8+NJXqURZIW2PLgbA1Sf3WMzV4O1YoyIHx8hVwLdKlEASTw7PyoQxLgGz3yMwf6ueV2ovVzmBx6wn4f9NTSCrU/y4al1hDy50bkepiafC0Rcv9efhpfHirVPDuOeshTU3+joIc/0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(16526019)(26005)(186003)(5660300002)(44832011)(41300700001)(8936002)(70206006)(70586007)(4326008)(8676002)(356005)(36756003)(54906003)(110136005)(2906002)(40460700003)(478600001)(316002)(6666004)(86362001)(40480700001)(7696005)(336012)(2616005)(47076005)(426003)(1076003)(81166007)(83380400001)(82740400003)(36860700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 16:35:24.6858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62716a4c-a315-42cf-0868-08dae696061b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
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

Adds online and offline driver callback support to allow cpu cores go
offline and help to restore the previous working states when core goes
back online later for EPP driver mode.

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 82 ++++++++++++++++++++++++++++++++++++
 include/linux/amd-pstate.h   |  1 +
 2 files changed, 83 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 779bbb58d909..c671f4955766 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -954,6 +954,86 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
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
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
+
+	if (cppc_state == AMD_PSTATE_ACTIVE) {
+		amd_pstate_epp_reenable(cpudata);
+		cpudata->suspended = false;
+	}
+
+	return 0;
+}
+
+static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
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
+		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_BALANCE_POWERSAVE);
+		cppc_set_perf(cpudata->cpu, &perf_ctrls);
+	}
+	mutex_unlock(&amd_pstate_limits_lock);
+}
+
+static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	pr_debug("AMD CPU Core %d going offline\n", cpudata->cpu);
+
+	if (cpudata->suspended)
+		return 0;
+
+	if (cppc_state == AMD_PSTATE_ACTIVE)
+		amd_pstate_epp_offline(policy);
+
+	return 0;
+}
+
 static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
 {
 	cpufreq_verify_within_cpu_limits(policy);
@@ -980,6 +1060,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.setpolicy	= amd_pstate_epp_set_policy,
 	.init		= amd_pstate_epp_cpu_init,
 	.exit		= amd_pstate_epp_cpu_exit,
+	.offline	= amd_pstate_epp_cpu_offline,
+	.online		= amd_pstate_epp_cpu_online,
 	.name		= "amd_pstate_epp",
 	.attr		= amd_pstate_epp_attr,
 };
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 8341a2a2948a..15761a581e82 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -82,6 +82,7 @@ struct amd_cpudata {
 	s16	epp_cached;
 	u32	policy;
 	u64	cppc_cap1_cached;
+	bool	suspended;
 };
 
 /*
-- 
2.34.1

