Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37D2673774
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjASLwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjASLwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:52:38 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6491BF0;
        Thu, 19 Jan 2023 03:52:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keKlL6n5LAP1dnZJajJC4715pKa6sRkouzXSnZnUbnojFSqmmhXdxQpoVHjLQZysA2YWdBVF7hjgnQ222G/nrG6nS64tWDOVnzxfnVcV6l0YitTlm8tFdQVOuwEQtOMom8igNsAqjxomfZuBzeDv2CkKRHLuZnfH63575CCGifkl+bLNE+LWFlpNZ1pcWvyQuIKQL1hMNikIpjSxpsfLrixk6GrMaWwxQ0tg9OivEFWFWSS6UJxCOId/OHwPuh+16/RPc8SiM1zJvzwDkLZHhXYEFXCpal67j9gLXdf/QB5O+CXtyA1i6j9h7o/fLxr6R5m2vgfG/Z3xbyU+2DjkQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wWsJsm/gG9sQiEORfxagttjLjTIjchwoB3h+8doG7vQ=;
 b=ixM0K+gkuhF/czVT5192mQOYPNL6fwFN2EEMqp2CHrmed6w2dx2tGTMY15C4sDEyrsJnxy5lNa+Tfa8l23q+fqj5+zhO/PrjhUYogcLQpBWxIRXh166MbTmIe96pC1Ufk11t6Hqj6TIBoOCBHS8e7U3FXyuuiiEzwrsiead8UgIzVurGUI2TbMEKsi4c1I/9eTkw3fbvkWhg/w86RZ6ZZoxEqZnCtg0+CnNOVYNtcxBMbeumxcRoQtVpTifWD4wI1xbUmSULhztDcbeDcUvbGjakKVwt2XOeZQBa87DrcyDo4fJIZitEeIWqe7TCpAN8qAIER1liKpAZfLvO117Fyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wWsJsm/gG9sQiEORfxagttjLjTIjchwoB3h+8doG7vQ=;
 b=N9KbFpgU+MBhl+2gKbdpnHmCOOH/war98iZ65U3zh0TmbWmpxibgSDCOCaad/xbajmFEnnqAfYcy0YwUsXf8Qx9CSRu0I2qLIlTG32VIVmNFgDqPTCoLumEp5X8z6CPRp0XNDEq48Oc7g2QorGdQrcud+fb7W5JM4PiyVqXdc88=
Received: from DM6PR18CA0027.namprd18.prod.outlook.com (2603:10b6:5:15b::40)
 by SA3PR12MB7997.namprd12.prod.outlook.com (2603:10b6:806:307::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 11:52:33 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::5f) by DM6PR18CA0027.outlook.office365.com
 (2603:10b6:5:15b::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Thu, 19 Jan 2023 11:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Thu, 19 Jan 2023 11:52:33 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 05:52:27 -0600
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
        <santosh.shukla@amd.com>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@suse.de>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v3 3/6] cpufreq: amd_pstate: Add guided autonomous mode
Date:   Thu, 19 Jan 2023 11:50:14 +0000
Message-ID: <20230119115017.10188-4-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230119115017.10188-1-wyes.karny@amd.com>
References: <20230119115017.10188-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT056:EE_|SA3PR12MB7997:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f707830-6969-4330-9f32-08dafa13a693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4DxbgCUbw9Aogvk1DMXvgwo80KZJ1c+npZu2DzMXA7+2sDiruMYuxFBVlg0YOqYsgnukavC2NiCtp+k9pKQs79/OarxEpPi7TUYnJJ3+D7lV+lolCjFCuSESJzjjRnJg2+AQZTilViun2YlX/8Lpvwkjn01/zKPDOKuiwrsG6kl8Z4/NiEf8hYuYQDQrWPfaSeE3cwjLoIv81HFAbAJ/vKM69wkjNz9TdWAixFdqWuuRtRbLZqFVrxbYW+hSC428QxWNxWjxoVxSODVHdd0L8bIMZ/TC0OyH03agS8Zswww7eFkpmQ9vjDC8tj56GZ7URgHFWgIFdf9lwGxqTYW0wVqU7NcReqYs1Yq3wzTwnOPk7WcUOI9z48Jd2ycTTS7gtpV5EHh/FTRNZ3lYwm4Hl0MU2kei6WtdEMPD5TVk+7C2GEULS31E2+J5/xTpETt/FWOAPNbQ4d5LocFQ0cTe5pDTWw98+V9ec1CU0yPH6VKrb8RP+oYjPBnDX51r/O+dI5LLNY3KNFxAMSrFLIjyDzS98AH3Quw4DlPC/TTXpTBKSMuXhYjG1wSEJMGqkmMVA4wpmpps1NlQQdFCP0JTPfuNX9UXh3Pj9KtCbsh+PviorazWcRqK5mynGLkDxzXQU3efg4CARvrI9sxfU6TheFjeZKrcXBJTuWRAZbR4ScYLk8r7SoDXFB7sR7jX807nIYBkR/LJaNEftx3aTi/ilOb+NH93PFg4q4marEMJADA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(136003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(82740400003)(36860700001)(316002)(81166007)(70586007)(86362001)(5660300002)(8936002)(2906002)(44832011)(70206006)(7416002)(40480700001)(26005)(41300700001)(8676002)(82310400005)(40460700003)(2616005)(83380400001)(336012)(16526019)(1076003)(186003)(47076005)(7696005)(426003)(110136005)(54906003)(6666004)(6636002)(356005)(4326008)(36756003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 11:52:33.1580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f707830-6969-4330-9f32-08dafa13a693
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7997
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
index c5731fefcbef..6736ad260485 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -267,7 +267,22 @@ static int cppc_init_perf(struct amd_cpudata *cpudata)
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
@@ -344,12 +359,18 @@ static inline bool amd_pstate_sample(struct amd_cpudata *cpudata)
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
 
@@ -404,7 +425,7 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 
 	cpufreq_freq_transition_begin(policy, &freqs);
 	amd_pstate_update(cpudata, min_perf, des_perf,
-			  max_perf, false);
+			  max_perf, false, policy->governor->flags);
 	cpufreq_freq_transition_end(policy, &freqs, false);
 
 	return 0;
@@ -438,7 +459,8 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
-	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
+	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
+			policy->governor->flags);
 	cpufreq_cpu_put(policy);
 }
 
@@ -1238,7 +1260,7 @@ static int __init amd_pstate_init(void)
 	/* capability check */
 	if (boot_cpu_has(X86_FEATURE_CPPC)) {
 		pr_debug("AMD CPPC MSR based functionality is supported\n");
-		if (cppc_state == AMD_PSTATE_PASSIVE)
+		if (cppc_state != AMD_PSTATE_ACTIVE)
 			current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 	} else {
 		pr_debug("AMD CPPC shared memory based functionality is supported\n");
@@ -1300,7 +1322,7 @@ static int __init amd_pstate_param(char *str)
 		if (cppc_state == AMD_PSTATE_ACTIVE)
 			current_pstate_driver = &amd_pstate_epp_driver;
 
-		if (cppc_state == AMD_PSTATE_PASSIVE)
+		if (cppc_state == AMD_PSTATE_PASSIVE || cppc_state == AMD_PSTATE_GUIDED)
 			current_pstate_driver = &amd_pstate_driver;
 
 		return 0;
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index e9e291b7c2f9..85e980b8e0ac 100644
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

