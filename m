Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CEA668B3C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjAMFYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjAMFYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:24:04 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111A961319;
        Thu, 12 Jan 2023 21:24:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iR++8NWQ0+KQr7vri0DeUPJU1ouFQ92vCVGb+mzn9zWWDvoiXK7kXOZ5yZgzAW1anDWUJ6/16j3+gSDYe4NZoBmcmZ0Uxts9eQnfsR3ZOqbvG9U08Br/m184Rs1PHmeqTlcbW47dlNbNtpPNgI6HIAylmd3RnyqTEz1IEyhnsQRG5K8dudb8c9MawALPjOVaGcl9Ano8DS8FY3U1gTaCguplSfCrYxmQbRZDroVf4pww8F63/bhOUMKTX1tOwMqgwmxu1mU3VvVdrW9bbFY13CcDUDoGrFGarNcHmxKrg6Rr/yralisD2C4ylUUO8FOq23dPvQRCQvd7wpiMb959nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax0+dEekv6wiRqcp+uoIWJhYZhQNxZdvgaxfNEDVoBE=;
 b=kX0UyR4lZKKeWea4TXMU3/z8Cui57OeMgMflrI0kDRSXkiIOhFUmH7RzGP3nAW+aw1qUOFf7tELRghU7TwO72AlLNG54shr1A124V5cGYQ3CESXi/08q2f+VlS8DJ4Hn3QeuL/LoQDxwX1cKEJqOQMQmAd2Eb8b64zv+G+MiefvS4coQcczciOlN4ERosM6fGKLPpbhlLNESA6Ls/9ghIZV4ptVUqfMlehN+bi1ErLkp5bCunYF5RTHamVDP7IbfqB50RIvUDWc20CFwdtQpH4/7WLIa4MZL+DfE4pjPrQ+c+aTBqSY/0wV8IqX/aKs7UW2tC07yMoSpwoeceyj0/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax0+dEekv6wiRqcp+uoIWJhYZhQNxZdvgaxfNEDVoBE=;
 b=pfd1tJiY8IeUmhgOdlPuEJdR29D0JUfGyceeZ/wB9eUhsod/K+GrVJXBGYqnmlI3f9FEYsYzpP7EeU5kKTVpmRzPRMFxZvlWhXeWMogk1j18oHakZkXMd+8FsGVYS4TejmaN8fy9QuCyZ3Kl47XD3jDQKSzzTQofjwgmysOHB9Q=
Received: from DM6PR21CA0004.namprd21.prod.outlook.com (2603:10b6:5:174::14)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 13 Jan
 2023 05:24:00 +0000
Received: from DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::cd) by DM6PR21CA0004.outlook.office365.com
 (2603:10b6:5:174::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.3 via Frontend
 Transport; Fri, 13 Jan 2023 05:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT094.mail.protection.outlook.com (10.13.172.195) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 05:23:59 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 23:23:54 -0600
From:   Wyes Karny <wyes.karny@amd.com>
To:     Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        <Mario.Limonciello@amd.com>, <Perry.Yuan@amd.com>,
        Ananth Narayan <ananth.narayan@amd.com>,
        <gautham.shenoy@amd.com>
CC:     <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>,
        <santosh.shukla@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v2 3/6] cpufreq: amd_pstate: Add guided autonomous mode
Date:   Fri, 13 Jan 2023 05:21:38 +0000
Message-ID: <20230113052141.2874296-4-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113052141.2874296-1-wyes.karny@amd.com>
References: <20230113052141.2874296-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT094:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: e54fbf9d-1b39-4961-ed81-08daf526600c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpBBio/hT7lfNK8i6LUQwgZgZIFV7tcxjCDq8wiAdyDBV0qyJLyoHntHN7Ss6fE1ke4P0zsgYZ7DYY6BjlhFlenVxBw9IO3zNMoDreieZlIOdXgqRGgtZNHXNI46nsqUV+Lxj21ES7gCwSkGHtsV/cpBirk2SFxSJu3MhZcXFV/q98e9JrLRPMJ+oi3v2fQhOVc9OWAKpfRBbzwJAT2aHrESTHaM+OmDG3CZwZuP0f26c+U2tEVnIkKhx46wHIC0Ba1IQggcXhWYeTihfjuyITdav5XKGlCQQQ4ssTD8Q2deANgjOEuOpQ4XJXEhXJf0hut1BSTh/oxjVqB6jJD4d1XCZVImYTBBh2PeLyo75CgZcVoLKLh+lfDGev0uIg/E+++txHiSL1e0mXHHn/9qgjaGzMH5+ls45EjIknnkQEFooWNMOC+myBZI55wrleNHBwKI3lkvJCADHF3rYg9ZRv628uLgfH+7YQEas9JBEpl4nx+w93vJ6fE7XFtVznvFCvaGpeocm0NDbKylgZ0mxmBH73++EJcQ7N78RZVgxv5W29UeQKdvE7kIZLqIdlHEF9vmUdQ9oa/OtNM026kxgJa2tREh6TBLg+VDtW/RxYy1UjUomQGbEkiez3817tRj0BmOFj2RErWv87G3vqIyEXD2PemJEP1+1enP91dxWz5re5LxmFH6XdLKT22hg47EOzdIiYKLdMHxNqaYE0gUKoc5cmVvbiZ7tBZjJCNkrl8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(83380400001)(41300700001)(70586007)(4326008)(8676002)(70206006)(47076005)(8936002)(426003)(36860700001)(82310400005)(5660300002)(336012)(1076003)(82740400003)(16526019)(44832011)(36756003)(2906002)(81166007)(186003)(26005)(110136005)(2616005)(6636002)(6666004)(54906003)(316002)(478600001)(40480700001)(86362001)(40460700003)(356005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 05:23:59.4587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e54fbf9d-1b39-4961-ed81-08daf526600c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 .../admin-guide/kernel-parameters.txt         | 15 ++++++----
 drivers/cpufreq/amd-pstate.c                  | 29 ++++++++++++++++---
 include/linux/amd-pstate.h                    |  2 ++
 3 files changed, 37 insertions(+), 9 deletions(-)

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
+			  tires to match the same performance level (if it is
+			  satisfied by guaranteed performance level).
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
index 87450413cf45..20d78dad712d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -267,6 +267,20 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
 		   cppc_perf.lowest_nonlinear_perf);
 	WRITE_ONCE(cpudata->lowest_perf, cppc_perf.lowest_perf);
 
+	ret = cppc_get_auto_sel_caps(cpudata->cpu, &cppc_perf);
+	if (ret) {
+		pr_warn("failed to get auto_sel\n");
+		return 0;
+	}
+
+	if (cppc_state == AMD_PSTATE_PASSIVE)
+		ret = cppc_set_auto_sel(cpudata->cpu, 0);
+	else if (cppc_state == AMD_PSTATE_GUIDED)
+		ret = cppc_set_auto_sel(cpudata->cpu, 1);
+
+	if (ret)
+		pr_warn("failed to set auto_sel\n");
+
 	return 0;
 }
 
@@ -344,12 +358,18 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
 }
 
 static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
-			      u32 des_perf, u32 max_perf, bool fast_switch)
+			      u32 des_perf, u32 max_perf, bool fast_switch, int guv_flags)
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
 	u64 value = prev;
 
 	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
+
+	if ((cppc_state == AMD_PSTATE_GUIDED) && (guv_flags & CPUFREQ_GOV_DYNAMIC_SWITCHING)) {
+		min_perf = des_perf;
+		des_perf = 0;
+	}
+
 	value &= ~AMD_CPPC_MIN_PERF(~0L);
 	value |= AMD_CPPC_MIN_PERF(min_perf);
 
@@ -404,7 +424,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 
 	cpufreq_freq_transition_begin(policy, &freqs);
 	amd_pstate_update(cpudata, min_perf, des_perf,
-			  max_perf, false);
+			  max_perf, false, policy->governor->flags);
 	cpufreq_freq_transition_end(policy, &freqs, false);
 
 	return 0;
@@ -438,7 +458,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
-	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
+	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
+			policy->governor->flags);
 	cpufreq_cpu_put(policy);
 }
 
@@ -1233,7 +1254,7 @@ static int __init amd_pstate_init(void)
 	/* capability check */
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
-		if (cppc_state == AMD_PSTATE_PASSIVE)
+		if (cppc_state != AMD_PSTATE_ACTIVE)
 			default_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 	} else {
 		pr_debug("AMD CPPC shared memory based functionality is supported\n");
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 15761a581e82..e07cfbd63560 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -92,6 +92,7 @@ enum amd_pstate_mode {
 	AMD_PSTATE_DISABLE = 0,
 	AMD_PSTATE_PASSIVE,
 	AMD_PSTATE_ACTIVE,
+	AMD_PSTATE_GUIDED,
 	AMD_PSTATE_MAX,
 };
 
@@ -99,6 +100,7 @@ static const char * const amd_pstate_mode_string[] = {
 	[AMD_PSTATE_DISABLE]     = "disable",
 	[AMD_PSTATE_PASSIVE]     = "passive",
 	[AMD_PSTATE_ACTIVE]      = "active",
+	[AMD_PSTATE_GUIDED]      = "guided",
 	NULL,
 };
 
-- 
2.34.1

