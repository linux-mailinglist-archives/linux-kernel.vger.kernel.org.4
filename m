Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B00673780
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 12:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjASLyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 06:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjASLyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 06:54:00 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4244B4B9;
        Thu, 19 Jan 2023 03:53:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkvyqLivzf4BAbp1NC7PvbU8ioqHq7p/X9o0MR16NxqG34HK+QR3HH416kcq6bz/ifKy3iF36UxRlgpsBtp4ty2aYrZNjIQ8pP83oSbYwZ6RtXjuoOu2UeDU38Mr/24IPEBe+jD3jdNPsRMzhw7aka6o5Ak2NhHKAlhaN0pMJNNKthVEUojFrxw67fFC+Kt2ZKb3dNaT/rV7AQQQClcQLabEV1EhmhHBCHosg7df159l6svjFF0qYHYmJPt5XGCFQgs5s6T7l+Lz5JYbpXXeCRMNJ2k7ia6GsTcS5fJsRK3zj4uflbV0Q+gv7C/f2XuwwnXlY/Z+o+NZsf7DhneTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySkUoIANDrWEcEwIJ3J40AhyqLHlwikYn2xI1eJyKNE=;
 b=lLXN95LWZtFesCr76K8zb1D3Dd5JHFq6KS4QdLZt5OdRQudW4XWq4ae3Nfk/Uc4bPVEo23UcPu7B8KuyKhZk1fvgwI4xyl5pbE+YkSgeLZy5Nu30cqXAxmFbkRy8N54+6yVgtCE7t98eOr9M3GDESAEWzL4L7pR/gHCrcXaVQ5YK7vpHR5RkTsnIvoOhXLed2S22v2XAsZ1qhAWPR4V03DJND85Vzz6CMWmQM81gQm2aRoYF6y+BH4ogCotBPo81DkMH0VPN0+yqd48v6mcTrVM288IFRkvuiJtln0lY76LeSNspRCSNECIEKAMy6BuNI/DISQ2CR8C7QR3dOHRq2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySkUoIANDrWEcEwIJ3J40AhyqLHlwikYn2xI1eJyKNE=;
 b=R4sBAR0A/hTOS4VXgaq+7+VDsBAFhq6+AkKeYjHQ4C611sZ4MRtcYuvuf4UpH+3rmXpQJ3WbzFAzrnbzw6mloaSYiwyA+D1wD/th/LCKRx283zsD7SsmOuV40c/8u5ZQyh2gXp53wMmNscf2si1U0Rx4IogOsz72tPwoZGEJUWY=
Received: from DM6PR05CA0038.namprd05.prod.outlook.com (2603:10b6:5:335::7) by
 DS7PR12MB6070.namprd12.prod.outlook.com (2603:10b6:8:9e::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.23; Thu, 19 Jan 2023 11:53:50 +0000
Received: from DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::13) by DM6PR05CA0038.outlook.office365.com
 (2603:10b6:5:335::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6023.16 via Frontend
 Transport; Thu, 19 Jan 2023 11:53:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT106.mail.protection.outlook.com (10.13.172.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Thu, 19 Jan 2023 11:53:50 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 19 Jan
 2023 05:53:45 -0600
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
Subject: [PATCH v3 5/6] cpufreq: amd_pstate: Add guided mode control support via sysfs
Date:   Thu, 19 Jan 2023 11:50:16 +0000
Message-ID: <20230119115017.10188-6-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT106:EE_|DS7PR12MB6070:EE_
X-MS-Office365-Filtering-Correlation-Id: 235c9367-6684-4717-7135-08dafa13d4d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: heLDthIxPhEZZyZQ8NrZDUEG1YjCYXONbrn36yk/nGwUQA7qO9Eez9i3buoPlQP91njev9r8zgVGNPvP9OXpqnxb+IX6/7fJIx++Wzfg7CUh5vbZ3aHUD157o0V89CSMlExHKF2Vu8MGyiI07Gz4PSlr11YXe5WGEmTwT6Sx1HDUXxJNrgQfbuN5c6Rh83Uy91aGUFlkuDV1YlKc/eLaxaIbnfQwEtk3Ai4l32AxRL6NO+815J7MNpa759hYDnuYY7XFwWUk2Xx3fjgWklcBUMycr7aAxbdxchSjLUB2Yav8SNMxlMAz+hzdSHGWy1J6hTq5WTCp3h+AfdK4ykUItJ60bn8ZBTgYKHI/fi/ynUHO2Sye0NoTQNUFNCJci8fBsvrZhex71SUOlUX68sftapYBAOkYsGyncZIvXi1uaCCvOihxiCHSCXW+2qspXwu8dVfnFF+bPq0PekZBqAWt/pbEBzuSSK6DikJY3v0H0R7H+ZcAFmEzQtmopqUL6ppZsLRD/UmqjBPAISafKQKlj2IlG+ETe1Vv1dYTQAhgtkd8YDLQB/jPZ2LTOdR9Y6NiGCYGhkFyUjvl4J/HRMjpeuDk3NxFAniCThErzdf0GAZvpolDlQ6G8Rt/Vzg7HhFytlQjI9WIYUjC/RRw6n5HF9xu4qdoGVrT0bjS4baC/fcirNWgXYIEsztuhHDSiK4CjY1/Vnkxcfds7Q232dmTAUhv4rMoFq17m+QBZZIgam4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199015)(46966006)(40470700004)(36840700001)(44832011)(478600001)(186003)(16526019)(26005)(2616005)(6666004)(6636002)(1076003)(54906003)(110136005)(7696005)(336012)(8676002)(70586007)(4326008)(70206006)(83380400001)(47076005)(426003)(316002)(5660300002)(8936002)(7416002)(36860700001)(41300700001)(2906002)(81166007)(356005)(40460700003)(40480700001)(86362001)(82740400003)(36756003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 11:53:50.7318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 235c9367-6684-4717-7135-08dafa13d4d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 drivers/cpufreq/amd-pstate.c | 150 +++++++++++++++++++++++++----------
 1 file changed, 108 insertions(+), 42 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6736ad260485..8b234628ec47 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -65,6 +65,8 @@ static struct cpufreq_driver amd_pstate_epp_driver;
 static int cppc_state = AMD_PSTATE_DISABLE;
 struct kobject *amd_pstate_kobj;
 
+typedef int (*cppc_mode_transition_fn)(int);
+
 static inline int get_mode_idx_from_str(const char *str, size_t size)
 {
 	int i;
@@ -797,6 +799,105 @@ static ssize_t show_energy_performance_preference(
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
+/* Mode transition table */
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
@@ -805,57 +906,22 @@ static ssize_t amd_pstate_show_status(char *buf)
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

