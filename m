Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A676B686032
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 08:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjBAHEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 02:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjBAHD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 02:03:56 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA3D32533;
        Tue, 31 Jan 2023 23:03:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWwsfMY1VMBmRxAR0h7GGwlgLqy878q/MsIvW6HQfz2zhw/w+eC4RARWcsIXD92pXOAbvWIPm16Ekf0USEWQ2KsAr/v5jlX6SmKXZa+cOfBdMqjpE22pzh+LVhHNDGMsm9IAMyMfnVGQBCEXGWlZw5JjmD0mpVJ07xyD/b1goiRv2lN/31gNYImEx9oyNCcVSDd87XbPMF8FTzQGPERwDb4dnp3UmcSNtvfso2V3L+8LOuTnSLMwMgTtJoQerLZ9beEvdsLliU5SoTHaMIkCclWPqcekvUAwRGRiwgQIqm1g76ecMthAHy62bVYH3W2Mhc3QIYvyTza/i8eYCcH0Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HG8sMo1SMnfyIQsw7eMXfdmW59SQ18zFaXGPz13Ch28=;
 b=imdAgYD2Cjr1TlURQVUsFYvBopto/HPtnjo0MGIsrV56UUBx842xeCUbZRP7+f8RL5AlnYLsEZe6q33wSK11bGiLpydaXj6rFoRiP7x91G8TqeRwvfdgVWgIzWqwMzBw+W8OQRTrjXjTB5w1PJTE1UgqyF9hcLcpplebgGAcf4V9XqU56Zg36EWC0aJorzj3bVf5Y74AYlDXoQS6WkTJz7r+siGamXENELwKbfOpkmfjc0GqZwBLW8W2xwbQAcujGjtUqeomKK8YfMhz1v6TzBY+GsoczJh8TGYoivijzhIPuw/oTq1b3LOXhDUPn7tVGktG+xfSjbKF878rz1I9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HG8sMo1SMnfyIQsw7eMXfdmW59SQ18zFaXGPz13Ch28=;
 b=QK4OzadgYd57yzH2LEUApTCugS7DRuaYeXtAw5GQSsv0oHToC8okCElrg4iP889pvk9lnxxu/ZHnqMOyG/UW9miplpeAThoA+VRXWsU4UvZsCrrMh0ibLgFc0F3U3bIRFViEBlHOAVT6lhO11+fXGLuojQglr1GRpWQTQKnOYbo=
Received: from MW4PR03CA0140.namprd03.prod.outlook.com (2603:10b6:303:8c::25)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Wed, 1 Feb
 2023 07:02:51 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::41) by MW4PR03CA0140.outlook.office365.com
 (2603:10b6:303:8c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Wed, 1 Feb 2023 07:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.24 via Frontend Transport; Wed, 1 Feb 2023 07:02:51 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Feb
 2023 01:02:01 -0600
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
Subject: [PATCH v5 5/6] cpufreq: amd_pstate: Add guided mode control support via sysfs
Date:   Wed, 1 Feb 2023 06:58:22 +0000
Message-ID: <20230201065823.189828-6-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|DM4PR12MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 591d958e-2f2a-4298-9a40-08db0422559f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d83bjFWtz4kni+kctJYGRLLIBzpzPntPCfmbJtMq/8rdp/MmsWndfYrxxVqCx+RB6T7PPpbMwz3r8RIz0N5W2mep9cgHVMx83s36zXTA2izO0O5qud3pv/l7EF9rmNkAJJ6bwU/Iy+hWpcrVQbsEtHvaso1ANOS6bryjlEkep8xkUf78CwJUzlUQsTGxiHt6kcs3MHxSxDm9ml8aml9VFSNUIoBd3RuQa9Oj0OSSI8d4NykNmqHXDjOEK3f84Mz9jcb2QE/GD+whB1IWg4msMXWRI6XFOsrldIk6VPrUiQLf+G9IcwHsBjrFAIFJoJrBYwDbqjfygMS2FGsztxGtJfOsWrIwWWIVFvFSkQOiDRMKIdMKRW/d6gNWVgIkwlltGkbhasY3p+vbxx65J7BMoLBjAfxvNPDfxhGz7HejZjopI/1vw8Nnufy/NAvdhjYRDmWksg0qfU+FBS6xUS+wIynFSu2Lt2wLza70kbr1OUkzcSnO3YbSwFTmOHFqw0g2eKD7uOMX6grsxiGL1b/L/iHzXLmwAM9eNKhGoqbp3Sy+nBP48sRcpNnrqsFdY/mzu5vwSuW7QIIZRVsce4HiEgCdSC1d8waG5+1h9ckoTVwby+ueOH3ZdPSt2n5upwUKnzRgS7zmGjPpt/zcJxjMRX4N4fqBOG7JWrAQmFcwNXKyQB+LfyPN5otvVRpJJfGQDacH36cKhyHjMP4jdWMZDz7/0awpXu4rhouRzLGaGjw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199018)(36840700001)(46966006)(40470700004)(316002)(2616005)(82740400003)(82310400005)(356005)(81166007)(26005)(16526019)(47076005)(336012)(426003)(83380400001)(186003)(36860700001)(6636002)(40460700003)(44832011)(36756003)(7416002)(54906003)(110136005)(5660300002)(40480700001)(2906002)(6666004)(1076003)(478600001)(86362001)(70206006)(70586007)(8676002)(8936002)(41300700001)(7696005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 07:02:51.3573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 591d958e-2f2a-4298-9a40-08db0422559f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

amd_pstate driver's `status` sysfs entry helps to control the driver's
mode dynamically by user. After the addition of guided mode the
combinations of mode transitions have been increased (16 combinations).
Therefore optimise the amd_pstate_update_status function by implementing
a state transition table.

There are 4 states amd_pstate supports, namely: 'disable', 'passive',
'active', and 'guided'.  The transition from any state to any other
state is possible after this change. Only if the state requested matches
with the current state then -EBUSY value is returned.

Sysfs interface:

To disable amd_pstate driver:
 # echo disable > /sys/devices/system/cpu/amd_pstate/status

To enable passive mode:
 # echo passive > /sys/devices/system/cpu/amd_pstate/status

To change mode to active:
 # echo active > /sys/devices/system/cpu/amd_pstate/status

To change mode to guided:
 # echo guided > /sys/devices/system/cpu/amd_pstate/status

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 149 +++++++++++++++++++++++++----------
 1 file changed, 107 insertions(+), 42 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e9b9327c249d..6631aef8258b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -106,6 +106,8 @@ static unsigned int epp_values[] = {
 	[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_POWERSAVE,
  };
 
+typedef int (*cppc_mode_transition_fn)(int);
+
 static inline int get_mode_idx_from_str(const char *str, size_t size)
 {
 	int i;
@@ -838,6 +840,104 @@ static ssize_t show_energy_performance_preference(
 	return sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
 }
 
+static void amd_pstate_driver_cleanup(void)
+{
+	amd_pstate_enable(false);
+	cppc_state = AMD_PSTATE_DISABLE;
+	current_pstate_driver = NULL;
+}
+
+static int amd_pstate_register_driver(int mode)
+{
+	int ret;
+
+	if (mode == AMD_PSTATE_PASSIVE || mode == AMD_PSTATE_GUIDED)
+		current_pstate_driver = &amd_pstate_driver;
+	else if (mode == AMD_PSTATE_ACTIVE)
+		current_pstate_driver = &amd_pstate_epp_driver;
+	else
+		return -EINVAL;
+
+	cppc_state = mode;
+	ret = cpufreq_register_driver(current_pstate_driver);
+	if (ret) {
+		amd_pstate_driver_cleanup();
+		return ret;
+	}
+	return 0;
+}
+
+static int amd_pstate_unregister_driver(int dummy)
+{
+	int ret;
+
+	ret = cpufreq_unregister_driver(current_pstate_driver);
+
+	if (ret)
+		return ret;
+
+	amd_pstate_driver_cleanup();
+	return 0;
+}
+
+static int amd_pstate_change_mode_without_dvr_change(int mode)
+{
+	int cpu = 0;
+
+	cppc_state = mode;
+
+	if (boot_cpu_has(X86_FEATURE_CPPC) || cppc_state == AMD_PSTATE_ACTIVE)
+		return 0;
+
+	for_each_present_cpu(cpu) {
+		cppc_set_auto_sel(cpu, (cppc_state == AMD_PSTATE_PASSIVE) ? 0 : 1);
+	}
+
+	return 0;
+}
+
+static int amd_pstate_change_driver_mode(int mode)
+{
+	int ret;
+
+	ret = amd_pstate_unregister_driver(0);
+	if (ret)
+		return ret;
+
+	ret = amd_pstate_register_driver(mode);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+cppc_mode_transition_fn mode_state_machine[AMD_PSTATE_MAX][AMD_PSTATE_MAX] = {
+	[AMD_PSTATE_DISABLE]         = {
+		[AMD_PSTATE_DISABLE]     = NULL,
+		[AMD_PSTATE_PASSIVE]     = amd_pstate_register_driver,
+		[AMD_PSTATE_ACTIVE]      = amd_pstate_register_driver,
+		[AMD_PSTATE_GUIDED]      = amd_pstate_register_driver,
+	},
+	[AMD_PSTATE_PASSIVE]         = {
+		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
+		[AMD_PSTATE_PASSIVE]     = NULL,
+		[AMD_PSTATE_ACTIVE]      = amd_pstate_change_driver_mode,
+		[AMD_PSTATE_GUIDED]      = amd_pstate_change_mode_without_dvr_change,
+	},
+	[AMD_PSTATE_ACTIVE]          = {
+		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
+		[AMD_PSTATE_PASSIVE]     = amd_pstate_change_driver_mode,
+		[AMD_PSTATE_ACTIVE]      = NULL,
+		[AMD_PSTATE_GUIDED]      = amd_pstate_change_driver_mode,
+	},
+	[AMD_PSTATE_GUIDED]          = {
+		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
+		[AMD_PSTATE_PASSIVE]     = amd_pstate_change_mode_without_dvr_change,
+		[AMD_PSTATE_ACTIVE]      = amd_pstate_change_driver_mode,
+		[AMD_PSTATE_GUIDED]      = NULL,
+	},
+};
+
 static ssize_t amd_pstate_show_status(char *buf)
 {
 	if (!current_pstate_driver)
@@ -846,57 +946,22 @@ static ssize_t amd_pstate_show_status(char *buf)
 	return sysfs_emit(buf, "%s\n", amd_pstate_mode_string[cppc_state]);
 }
 
-static void amd_pstate_driver_cleanup(void)
-{
-	current_pstate_driver = NULL;
-}
-
 static int amd_pstate_update_status(const char *buf, size_t size)
 {
-	int ret;
 	int mode_idx;
 
-	if (size > 7 || size < 6)
+	if (size > strlen("passive") || size < strlen("active"))
 		return -EINVAL;
-	mode_idx = get_mode_idx_from_str(buf, size);
 
-	switch(mode_idx) {
-	case AMD_PSTATE_DISABLE:
-		if (!current_pstate_driver)
-			return -EINVAL;
-		if (cppc_state == AMD_PSTATE_ACTIVE)
-			return -EBUSY;
-		ret = cpufreq_unregister_driver(current_pstate_driver);
-		amd_pstate_driver_cleanup();
-		break;
-	case AMD_PSTATE_PASSIVE:
-		if (current_pstate_driver) {
-			if (current_pstate_driver == &amd_pstate_driver)
-				return 0;
-			cpufreq_unregister_driver(current_pstate_driver);
-			cppc_state = AMD_PSTATE_PASSIVE;
-			current_pstate_driver = &amd_pstate_driver;
-		}
+	mode_idx = get_mode_idx_from_str(buf, size);
 
-		ret = cpufreq_register_driver(current_pstate_driver);
-		break;
-	case AMD_PSTATE_ACTIVE:
-		if (current_pstate_driver) {
-			if (current_pstate_driver == &amd_pstate_epp_driver)
-				return 0;
-			cpufreq_unregister_driver(current_pstate_driver);
-			current_pstate_driver = &amd_pstate_epp_driver;
-			cppc_state = AMD_PSTATE_ACTIVE;
-		}
+	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
+		return -EINVAL;
 
-		ret = cpufreq_register_driver(current_pstate_driver);
-		break;
-	default:
-		ret = -EINVAL;
-		break;
-	}
+	if (mode_state_machine[cppc_state][mode_idx])
+		return mode_state_machine[cppc_state][mode_idx](mode_idx);
 
-	return ret;
+	return -EBUSY;
 }
 
 static ssize_t show_status(struct kobject *kobj,
-- 
2.34.1

