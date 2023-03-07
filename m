Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D956ADD65
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjCGLbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjCGLbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:31:07 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23516A1C7;
        Tue,  7 Mar 2023 03:30:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGU+xn9xzYrY599TAFzTzOe5pwcjzQI2tjL8gQYc0v6hl31tg4ccH7DoNnUXIUofM1jjOTc4vormJlx19Gif68GMrGRd+1gfmWL1yX10gKV4hRExEqzS6d9bq6VyBSmv7YiTOjQxWIQHshgduAHLnJQqbeUv/e5VwxZvCMHYyZ45IjhTAGpmgWU0i3a4J8RyVM4XheeD3cqETkkbW1j74kKNHmVKUCgYIxaGvdoy6VnZf5EAf/nXRQ2oBFuyiAA0YjgG15j5CVOL0cOwO14PLQPFjXZwWsgcRNoTKYR5C6z9yqFL6ZV3Hln/N09ZMqiHKuFFZNEeqiPyqSKzsEqN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cYgxY7jS9RkiNJddweKT7G3Fpt9JgJeRru7SxRPUno=;
 b=ceIvr3Xmnpt57RcQX/9UbgmicFRzRqKjcriKc78FS0qJDw8g7KqgWjfKTSoTMNWkSnBP8IEA2aCa6C04OH0kcbmdtrAGE9fIyhWmz13HUrLAOVoZyidbxlHufuYmn4y3VbKrXJu4wPShwGiT7vaHib1uQIW6khXkBn/MTCacNZ4a0626OSsAVzNhC84h9K1XeNcC9SFApv/JhU50GiVe7EEFEBEOqbSLiJerjIuqKuSQpGudfHoUX+y6yWsQPs3QCQS9D1wcTihyhdLHc2yTN+AUM2ix28u3BkGnoC3oed6gtWUmcwCO0y308oGqZoeUS2iCY9InCfKwHK+ZPZj1yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cYgxY7jS9RkiNJddweKT7G3Fpt9JgJeRru7SxRPUno=;
 b=YyYdfraE1Kx+aITe/LtqyWDJKq3vdxdWg5lUWsjvrro10QWIxjixj2zD1Y713a/dvmp0WFWBr3DKRlkTu3m4pXYCnIbRSpU0eiFrQl/AoJQhs9LpfX9iK+QkmcG/J0KqYmnw7kC09kYNJzzhUa2XbrBmvib1PjStfbxI9bS/IvQ=
Received: from MW4PR04CA0352.namprd04.prod.outlook.com (2603:10b6:303:8a::27)
 by MN2PR12MB4208.namprd12.prod.outlook.com (2603:10b6:208:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 11:30:01 +0000
Received: from CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::b4) by MW4PR04CA0352.outlook.office365.com
 (2603:10b6:303:8a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29 via Frontend
 Transport; Tue, 7 Mar 2023 11:30:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT112.mail.protection.outlook.com (10.13.174.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.16 via Frontend Transport; Tue, 7 Mar 2023 11:30:00 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 05:29:54 -0600
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
        Mario Limonciello <mario.limonciello@amd.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: [PATCH v8 4/6] cpufreq: amd-pstate: Add guided autonomous mode
Date:   Tue, 7 Mar 2023 11:27:38 +0000
Message-ID: <20230307112740.132338-5-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307112740.132338-1-wyes.karny@amd.com>
References: <20230307112740.132338-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT112:EE_|MN2PR12MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab298db-f4c1-4dc7-8840-08db1eff4a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f6GJiI4EnrAnqL7YSqT9gBxD+PjWPXrLoXXZYZd2QEE819PDUNo9EZ3FJRi/RIiJnpItHwdODh6A5ATD6QhuGOW38QhJh0MPDW63v/25waFPID0J8zFRTBFhN0M5pz0IP16IFUwnI48kBJm+xZCeBvwwt9Cw2q1OevyY7QmkRrEkLwXZhIky06yfXNvSiynDUF6nEBANchi+9BrnAvZIfEI/+//Z5kWdslwQOM6B7cnkNd3OuDTEybwmp3ap9EJole6EVa45sN2akrFTPOgWHm2CXUGeT51ONrWZwl0q0lDhG65JH3yf9rqkHmQ/r9FKm1kfDPpyPt6CUyxDjzQajVyiDAme59RY/P5mOmwswKvytbKWCZj79kHU0iLYpkkmyAkzdaPv7K23hI5x6fvSZxKCkguhOVhA337EJ0420V24o7gGr9RVT/dEby0Ze22iIwWWVRuX1AyRNGAk7ucx8NW+68AmEOj5H/JII1gadEIfVUAUuLMNd8oEqDaq0MwG4Ah2AQuz0pc6YnRraLBNETHSo+mcfYiMPtxH/J9DJk/1qTkE4xXLRc9nzfadiGCQjXj7Aur0RZH9IGXWwWKI1NEIDtDRWR/XUUenwLZA6lSrWHWn7kC5pBCBAu3G/JQYPdAOWgQYsvKgBRS95qisz2CatZmolP9vO3sNimk1RlRFDbHjADCRyO2fS7leybo27fzNAUjGMsY4UFOyIULke5ZxUvQBIiJt1R+90UfASQM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(8936002)(44832011)(5660300002)(7416002)(2906002)(41300700001)(4326008)(70206006)(83380400001)(70586007)(8676002)(316002)(54906003)(6636002)(6666004)(478600001)(110136005)(7696005)(40460700003)(426003)(1076003)(336012)(40480700001)(2616005)(186003)(86362001)(16526019)(47076005)(82310400005)(81166007)(356005)(82740400003)(26005)(36756003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 11:30:00.9656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab298db-f4c1-4dc7-8840-08db1eff4a1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4208
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 .../admin-guide/kernel-parameters.txt         | 15 +++++---
 drivers/cpufreq/amd-pstate.c                  | 34 +++++++++++++++----
 include/linux/amd-pstate.h                    |  2 ++
 3 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1e38f3ae0e62..1e5fe4891dd7 100644
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
index 73c7643b2697..61dcd7b89b26 100644
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

