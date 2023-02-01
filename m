Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB1686029
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjBAHBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBAHBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:01:48 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3120B5CE6C;
        Tue, 31 Jan 2023 23:01:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S9WirQV6Y3q96asZUmMtBlJdD4LoNfy2zsOmKtCltAT51MB7nteB78PL1dBUxo61RzABg3QUPv56f/fkmvo3RR+yc9oziP1JlQbStjaN/BJfU57x0kHHc/zVgixzGiBvuZ2gEuA+/aY2GRMX57dTI5movyUDwcQ1msdPRoz41KkE8HxcAO2fUXJIeG1m0tQAq2vtz9qsHS1/njiN1uPFPzAnMOGR4MOJpjva2w8+Y++9D3jq1XJIIFD3OnuLv22bg8lJ16Ubj1M9IUtTxe5xlv9oMCVtg7B+Wj2+q+5U+xBrHuErE8pfYDEUPA6k6m7b8oFrgzcALwLfc9A2gsXgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZ2v0sOzphUm9PmGAUqserPeBYocBB0x6+KV6IksPfQ=;
 b=Cnx1a20uCo802JtvjxhjneIbM8ngJIG8J+2Ia0/CPbbjEqZBhBvmqXAXGu5MzjZjce9Sf/ks/oBCWruclMxZCJgw8bEN9bCI8+lowobXG5X6WrS4fnocC6rBakKgijgLF4HCkYG5wMofZ6duQweLIYO857BOGwvwqdq07uOuyb6QPySwZras8YQof7l08zJoDRW94wIrBPk0q3pgstw2RkaalyjDzqVvfSUEwUybCM0hRWv8uIUbvGdYwhqtmnWDpgsqh5pZiOY8yagEGGW1pyfvE93TeE6MWMSkFi5+OB9rhlunbXe13NDwW6JXXRVLoqRXJXqEi22qt02TxuLlDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZ2v0sOzphUm9PmGAUqserPeBYocBB0x6+KV6IksPfQ=;
 b=BIQUEh4dFpCOtv7Xprvo+P/mGa9VMfSB5DtlebEY7TmoE2fLXrBzWzhdKJykdRn/oS1e1f6rxDT6njpupzkd18JHNGBalT5LO7B6XEmKqNbLVbWfbln3wECV4ioEve/3lDQlHTM7+B16rIYqFVp8X6wHdzCkFxLHOyhNW9UGHOw=
Received: from DM6PR11CA0034.namprd11.prod.outlook.com (2603:10b6:5:190::47)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Wed, 1 Feb
 2023 07:00:36 +0000
Received: from DS1PEPF0000E659.namprd02.prod.outlook.com
 (2603:10b6:5:190:cafe::a5) by DM6PR11CA0034.outlook.office365.com
 (2603:10b6:5:190::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Wed, 1 Feb 2023 07:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E659.mail.protection.outlook.com (10.167.18.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Wed, 1 Feb 2023 07:00:36 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Feb
 2023 01:00:28 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        <santosh.shukla@amd.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>, Tor Vic <torvic9@mailbox.org>,
        Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 3/6] cpufreq: amd_pstate: Add guided autonomous mode
Date:   Wed, 1 Feb 2023 06:58:20 +0000
Message-ID: <20230201065823.189828-4-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230201065823.189828-1-wyes.karny@amd.com>
References: <20230201065823.189828-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E659:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: b444612d-25b0-4cdd-79c4-08db04220534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qp0U+mlK8QUs+fSoPSt5n18AwZtkWqYWDzwocS3/dcIQieW+yOeWrS9FVuudymS0qcsMmfltSHY4rViSlieY6NOPPJB/5PWnpIck8iIUweV38j/hTZEp1su55cyGvxJiYT7KpHKmKc/IrzI57og6KnJ+O1UJz9uKT5Xbap7TWcA7k3T/iUDFchvsgfil8IyqDDuccdBUj1oXKxIhUspeI4gz4PYYVE2N2pgPZDs9LAXVoZjMBlrKW8HYnvpGzO0CbfFhfZN2quvmYtdWtqJ4QsSu5aL7++JlRpvGrdcSqnx8DVhX3c6+j81gqg0usLJupK0NGK7ZZkOg/JPom8vU/bvqtVj0v7ePVlkV7KQ8q3DxEezVQGkjk4dgrbsGcNFxTtFgPAha5PsMBncBvNdCZLcpf2RQyNKGqptT519p0Sr7u2a44EB9kvfyF5VUyZAmmdpVvFBW5CEPPDYW6MfrRyzhTynWSW+QMKu/16NEJJsIjqmXk8u34mrR7zruYLvzyllpzpoS2gZU3zUd80Ht1ewXy1TJBhTTU0kaJEX2xgmo4CBl+3swgbPOkfVBYWDRXZ1RwHf9aAbX6rSf35TEWvpx/C7yyuGxhjdcX7zF27DASFtG1c97xGCULjcHeDuMD8IKk0otjtwdEQzrLv0j7YH1yda26Pr8QBnEZBVEnNMh1wdspH1sCtSvibgJEy/YRFrIjd0W5MlgaeXjbu7V9f0KuSFtvmcYTwCBWv6zaaw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199018)(46966006)(40470700004)(36840700001)(86362001)(356005)(478600001)(82310400005)(110136005)(2906002)(54906003)(7416002)(41300700001)(6666004)(7696005)(6636002)(26005)(44832011)(5660300002)(40480700001)(2616005)(8936002)(36860700001)(4326008)(81166007)(83380400001)(82740400003)(70206006)(70586007)(426003)(40460700003)(1076003)(336012)(47076005)(8676002)(16526019)(186003)(316002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 07:00:36.5000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b444612d-25b0-4cdd-79c4-08db04220534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E659.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From ACPI spec below 3 modes for CPPC can be defined:
1. Non autonomous: OS scaling governor specifies operating frequency/
   performance level through `Desired Performance` register and platform
follows that.
2. Guided autonomous: OS scaling governor specifies min and max
   frequencies/ performance levels through `Minimum Performance` and
`Maximum Performance` register, and platform can autonomously select an
operating frequency in this range.
3. Fully autonomous: OS only hints (via EPP) to platform for the required
   energy performance preference for the workload and platform autonomously
scales the frequency.

Currently (1) is supported by amd_pstate as passive mode, and (3) is
implemented by EPP support. This change is to support (2).

In guided autonomous mode the min_perf is based on the input from the
scaling governor. For example, in case of schedutil this value depends
on the current utilization. And max_perf is set to max capacity.

To activate guided auto mode ``amd_pstate=guided`` command line
parameter has to be passed in the kernel.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../admin-guide/kernel-parameters.txt         | 15 +++++---
 drivers/cpufreq/amd-pstate.c                  | 34 +++++++++++++++----
 include/linux/amd-pstate.h                    |  2 ++
 3 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e3618dfdb36a..0d8486325c9a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7015,11 +7015,11 @@
 			  Do not enable amd_pstate as the default
 			  scaling driver for the supported processors
 			passive
-			  Use amd_pstate as a scaling driver, driver requests a
-			  desired performance on this abstract scale and the power
-			  management firmware translates the requests into actual
-			  hardware states (core frequency, data fabric and memory
-			  clocks etc.)
+			  Use amd_pstate with passive mode as a scaling driver.
+			  In this mode autonomous selection is disabled.
+			  Driver requests a desired performance level and platform
+			  tries to match the same performance level if it is
+			  satisfied by guaranteed performance level.
 			active
 			  Use amd_pstate_epp driver instance as the scaling driver,
 			  driver provides a hint to the hardware if software wants
@@ -7027,3 +7027,8 @@
 			  to the CPPC firmware. then CPPC power algorithm will
 			  calculate the runtime workload and adjust the realtime cores
 			  frequency.
+			guided
+			  Activate guided autonomous mode. Driver requests minimum and
+			  maximum performance level and the platform autonomously
+			  selects a performance level in this range and appropriate
+			  to the current workload.
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 168a28bed6ee..e9b9327c249d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -308,7 +308,22 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 		   cppc_perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
 
-	return 0;
+	if (cppc_state == AMD_PSTATE_ACTIVE)
+		return 0;
+
+	ret = cppc_get_auto_sel_caps(cpudata->cpu, &cppc_perf);
+	if (ret) {
+		pr_warn("failed to get auto_sel, ret: %d\n", ret);
+		return 0;
+	}
+
+	ret = cppc_set_auto_sel(cpudata->cpu,
+			(cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
+
+	if (ret)
+		pr_warn("failed to set auto_sel, ret: %d\n", ret);
+
+	return ret;
 }
 
 DEFINE_STATIC_CALL(amd_pstate_init_perf, pstate_init_perf);
@@ -385,12 +400,18 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
 }
 
 static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
-			      u32 des_perf, u32 max_perf, bool fast_switch)
+			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u64 value = prev;
 
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
+
+	if ((cppc_state == AMD_PSTATE_GUIDED) && (gov_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
+		min_perf = des_perf;
+		des_perf = 0;
+	}
+
 	value &= ~AMD_CPPC_MIN_PERF(~0L);
 	value |= AMD_CPPC_MIN_PERF(min_perf);
 
@@ -445,7 +466,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 
 	cpufreq_freq_transition_begin(policy, &freqs);
 	amd_pstate_update(cpudata, min_perf, des_perf,
-			  max_perf, false);
+			  max_perf, false, policy->governor->flags);
 	cpufreq_freq_transition_end(policy, &freqs, false);
 
 	return 0;
@@ -479,7 +500,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
-	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
+	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
+			policy->governor->flags);
 	cpufreq_cpu_put(policy);
 }
 
@@ -1279,7 +1301,7 @@ static int __init amd_pstate_init(void)
 	/* capability check */
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
-		if (cppc_state == AMD_PSTATE_PASSIVE)
+		if (cppc_state != AMD_PSTATE_ACTIVE)
 			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 	} else {
 		pr_debug("AMD CPPC shared memory based functionality is supported\n");
@@ -1341,7 +1363,7 @@ static int __init amd_pstate_param(char *str)
 		if (cppc_state == AMD_PSTATE_ACTIVE)
 			current_pstate_driver = &amd_pstate_epp_driver;
 
-		if (cppc_state == AMD_PSTATE_PASSIVE)
+		if (cppc_state == AMD_PSTATE_PASSIVE || cppc_state == AMD_PSTATE_GUIDED)
 			current_pstate_driver = &amd_pstate_driver;
 
 		return 0;
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index f5f22418e64b..c10ebf8c42e6 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -97,6 +97,7 @@ enum amd_pstate_mode {
 	AMD_PSTATE_DISABLE = 0,
 	AMD_PSTATE_PASSIVE,
 	AMD_PSTATE_ACTIVE,
+	AMD_PSTATE_GUIDED,
 	AMD_PSTATE_MAX,
 };
 
@@ -104,6 +105,7 @@ static const char * const amd_pstate_mode_string[] = {
 	[AMD_PSTATE_DISABLE]     = "disable",
 	[AMD_PSTATE_PASSIVE]     = "passive",
 	[AMD_PSTATE_ACTIVE]      = "active",
+	[AMD_PSTATE_GUIDED]      = "guided",
 	NULL,
 };
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1

