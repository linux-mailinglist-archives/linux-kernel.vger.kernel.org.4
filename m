Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4447698E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjBPIU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjBPIUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:20:24 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D2427D50;
        Thu, 16 Feb 2023 00:20:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPhweyGhkJOjIt738yO8UCaeHFEF8ekq55RK+QJ2lX8cpzQWavsBl2FFln58NSHeDGn2FMcTX7JifodxulEbZsRxFCkD6OBTxKnioTKA1SFtuVhip+VL47xn3FWLKtcZ8F5AweaPV3KzpTRalS6as+Wrx8+b9tYfrwwS+N1bgKT0g6Cj4jIicBy7hJi15MOZqJrGNjmiU4JLFmyaH0Wa3PySZ9Po/GaidinIshieQQaMR4IXugeBvOEDCcgi258n3mrkTFctlmmvm5BgIh+xWqjTZRcW6xzR7MDVvQHfzCAipAVomG4IoRANV+MHXSewFoFgqfIKvPc1gadLuNEw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Fl/rKIdJL8gnuex8+b4QqwsI8z3hc/jKb2/ZedWW5w=;
 b=X0XkHFz/x1g0g2CptI8uD5L0hWubJYQihiz51eqqo6t+ppaU8H/tdDIId1146RopT2n/9IG8KXzOTuaOasM4BDVFIMn53HFc2Aqq6KeTpYVHWhyBwn0VotwuHRV07LVSZw2m2R+2ql7pQk2WX1+mfnA41hjwtsXNbH6ZYZhJcbgiB70n1BkdZXJWUKC2FYKKePlL6aHk5mQmYwl9+7tY5pKPd5Qr12YEuY/Mdk4+wfSa6IFVgW3NTl6aQ58DC+rHnc8KaZ41fjFyidAtqQ7dr1sBJHkbTkxboitEpcioIRCMbkWyQ02VgMSweITnLDCQo6KF8sWLmHJZZR6QcqNm6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Fl/rKIdJL8gnuex8+b4QqwsI8z3hc/jKb2/ZedWW5w=;
 b=x9XYXlwoMQMxr3LLSR/wE9HysBiGBGhW9JA+PZ3M9iWBxSeWzcHkbH308F/7brt0rVZqAxl9kxjRmJ+XvJV1lV+quWzwfX95pGYP8ZhWCWbMFOSnjZpFANi06aSN4WAq+yKy5z9m8OOpY7B8UcbfvWchidTq/aavHioybnlzdi8=
Received: from CY8PR02CA0013.namprd02.prod.outlook.com (2603:10b6:930:4d::24)
 by DM8PR12MB5446.namprd12.prod.outlook.com (2603:10b6:8:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 08:20:13 +0000
Received: from CY4PEPF0000C97E.namprd02.prod.outlook.com
 (2603:10b6:930:4d:cafe::9b) by CY8PR02CA0013.outlook.office365.com
 (2603:10b6:930:4d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13 via Frontend
 Transport; Thu, 16 Feb 2023 08:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97E.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6111.8 via Frontend Transport; Thu, 16 Feb 2023 08:20:13 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 16 Feb
 2023 02:20:04 -0600
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
        Russell Haley <yumpusamongus@gmail.com>,
        Wyes Karny <wyes.karny@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v7 4/6] cpufreq: amd-pstate: Add guided autonomous mode
Date:   Thu, 16 Feb 2023 08:18:00 +0000
Message-ID: <20230216081802.38007-5-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230216081802.38007-1-wyes.karny@amd.com>
References: <20230216081802.38007-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97E:EE_|DM8PR12MB5446:EE_
X-MS-Office365-Filtering-Correlation-Id: c080cad4-f43d-4b13-2586-08db0ff6a07a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m10Iz0pgOd89Zgm2/CYa07N1lkOPv3uEbrs6ji0ewalG0IBsmacGWNyXWcO6U98tDXSdeRqZsBAGA3t2tvpZs0P1f2voEyvQCCtMfGgrPtzUpDyexsEt5zcF/fYTBjGl5Ggul0eiIYOjlfAyJ45XrF5cXXKnkid9nNi5vGmBQQN+x+cwL0Zp11HqnqrjqUPIDVINKmlV1YuFrAjrzM4fh9qhb9m1+MBEJA4jPs6++xsYA1AQxseh1eLUKTTXSR6AzvMEOHyAXdsAgW11p1k/fh+ZgPCdyFBmovt8L6iakd/bPy+jhs5p3pupjhxR0Eh15Ggjm7XSiF2HHSYX5QZFv3tUTPpPKPDpLEThP5NjX9rTtC5jnBryGyYK58ao/BC2QcDLtmsqx0vn/rlB1xQs9M4XXIoL4Jv21V0SfpQsCnJNWX6BN5k9jhBr3IG13mrKC/liGIBjKVx7ozRJ5+hMo/kbbjddyZGJSiP797tlhNzLoLYB+bL5NrKfgf4yolDove4Agu3VX2j4eo3EuK2bz8PMVjQZ2oNauBrXepiAUvq8FkLsAkHuZ+Ue1KQVXQqaa1FQUQWsezQLgm1hqK4D7bFsevfD7FguINs6Ub7nmdFfqk2ZACdSJxUmM/C5DdiU6cb7nU6kkdyNbhxhTuXCCgRgGvnfyTj2aBAL6OlLJz1BkYrP7a5AiWFSq9tkC+k6KidkKgaysSYEclLYJq7/kk2oeYXSe8zQN5Nx5ZvKguo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199018)(36840700001)(46966006)(40470700004)(7416002)(2906002)(8936002)(70586007)(8676002)(4326008)(44832011)(5660300002)(110136005)(6636002)(54906003)(316002)(478600001)(7696005)(6666004)(36860700001)(16526019)(70206006)(1076003)(26005)(186003)(47076005)(426003)(336012)(41300700001)(40460700003)(81166007)(82740400003)(40480700001)(86362001)(356005)(83380400001)(82310400005)(36756003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 08:20:13.0692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c080cad4-f43d-4b13-2586-08db0ff6a07a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5446
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 .../admin-guide/kernel-parameters.txt         | 15 +++++---
 drivers/cpufreq/amd-pstate.c                  | 34 +++++++++++++++----
 include/linux/amd-pstate.h                    |  2 ++
 3 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 6ffcfb73e62f..e1241141535b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -344,11 +344,11 @@
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
@@ -356,6 +356,11 @@
 			  to the CPPC firmware. then CPPC power algorithm will
 			  calculate the runtime workload and adjust the realtime cores
 			  frequency.
+			guided
+			  Activate guided autonomous mode. Driver requests minimum and
+			  maximum performance level and the platform autonomously
+			  selects a performance level in this range and appropriate
+			  to the current workload.
 
 	amijoy.map=	[HW,JOY] Amiga joystick support
 			Map of devices attached to JOY0DAT and JOY1DAT
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b8862afef4e4..92f8402ebb34 100644
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
 
@@ -1278,7 +1300,7 @@ static int __init amd_pstate_init(void)
 	/* capability check */
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
-		if (cppc_state == AMD_PSTATE_PASSIVE)
+		if (cppc_state != AMD_PSTATE_ACTIVE)
 			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 	} else {
 		pr_debug("AMD CPPC shared memory based functionality is supported\n");
@@ -1340,7 +1362,7 @@ static int __init amd_pstate_param(char *str)
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

