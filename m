Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4000068C4AB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjBFR0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBFR03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:26:29 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08682CFC2;
        Mon,  6 Feb 2023 09:25:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCTKZxnM7HO77nK2EkDhBcKN/Xl17/B7biNmlXV7t3e+Ql7Hs6R6hDnkUG8G9FoylMgo3KXv3ZsjhoXmYrHlwQxzke0WYpIpt3YO4TAYGlKunpq4aiQuhgpudJEnv7BkDw/hlKjrLbw/5sv0R2hvIJ8AnZSH2CPD606X8D2VvGTwhaiK0+9mC5xSXCFWT6MfZZfJIdfJdzx1j4mYDk+QPPpo0FOpZn3QTqoZ2IiMZ4qRIIM5iZtMcDagbljrZkSCn2AWyKycyh4w7UYM8hK5U2XugaCtA/G9yJZHbZJp660YisG1GIPAinyiWT1G2MhFRdsBoRiUU8t3srznuOb97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Z1XsLW+BHt5QJlZTUgs5bieXo3vQEvZL9DKkOeE+/Y=;
 b=RoQh2DuA+xB66hP0k1qafxrPgqXNe40RfwBqy3IYags6UQhX/961J/NLRdwjPUL9Vs2al9IfQ4pb41GYcMKUjfTqlGUft41nA1eXvG+YSAKOgLwtRghdxFvSJzOkNvrrIHFQOyX40EusnBdMco/9gBKlzp5EA6NxmeB6WUs31kJJDaL0Yg+y61mXRhRDVFe0g9TzU9VGIDYH60l0FWQk9DUWKkJvYV6S40fWIqvA+pt6+lFBWSM9YuQd5qxbTdnuQUyijny5KbzbGc5qpAA15Hc3MV2FYMpfWNvh63ZBJKwGd4/XUgrVHmi8NncYViSnLwdoPr3ywrmF6vgi3xfqoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Z1XsLW+BHt5QJlZTUgs5bieXo3vQEvZL9DKkOeE+/Y=;
 b=Ey4kXvcwTWgehXahy4n5L+KXBWHKd5tw2dRH7leV+lqq7exjqzCMZYetyDPoICvN7J4k45EQO2EIz2avQ4C+tHMt4Paf4LLhJw5mVyCRClwwydXfaFmQ8/LVGaQInMLCS4R6Nrn60POPGP4+fJklDC24eTB9oGyrOzAESKNQWH8=
Received: from DS7PR03CA0158.namprd03.prod.outlook.com (2603:10b6:5:3b2::13)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34; Mon, 6 Feb
 2023 17:24:55 +0000
Received: from DS1PEPF0000B07A.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::59) by DS7PR03CA0158.outlook.office365.com
 (2603:10b6:5:3b2::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.34 via Frontend
 Transport; Mon, 6 Feb 2023 17:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B07A.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.17 via Frontend Transport; Mon, 6 Feb 2023 17:24:55 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Feb
 2023 11:24:49 -0600
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
Subject: [PATCH v6 5/6] cpufreq: amd_pstate: Add guided mode control support via sysfs
Date:   Mon, 6 Feb 2023 17:21:56 +0000
Message-ID: <20230206172157.49887-6-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230206172157.49887-1-wyes.karny@amd.com>
References: <20230206172157.49887-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B07A:EE_|MN2PR12MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a79d49-ef52-4b3f-0560-08db086710b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjjNETiuP91p34+GmlJfWfF1LSLCs8hT/tNK6tIbqXSaiFI13VdRZ0HA7lhz3d7Td0H8PfeauoljMDXN86wyQgY+VyX/teHj3Tk6FhGjupZ51V4wErqc0oHgIC+pVEkVSpAiGLnDElF31M5oXBmBWTLqrk/19jD2a4JDkimVV7ns2V2GuRka/PAGSeq/VzQ/FP4GpfYRPNfaNX4sLtUcS6hnHPoHmQSLAVeVK4YJZrj5rpqvSsknCBBPXsxxDtIYt+m07N0DiioCuVBgcVWvTX6ucmUN9f2B/G84XulZtDPwBT46+RIqKgDMruyGt9LUkSozwgNR7r3QZoaiI8IRz4vij9z0GXfmVS1anSZKXHsIM0mNLnJNuopzrzgXgSnDIsIN0rJaZAKwjmELuBwlrht3nP2XUQ1tomWHxKAlNgPm4YbAYzmvaLr/yuvJAZWXWBhM+l4oTJmMHRKNRgES/W2fwo/VXWO3NfARAPtq8hIw+0lyk2a9NoQIJVuPjgEd8nf0KuhFklZewfoKe2Fg2QGWryc0GUS6ju/+rp+U5DZt8j5V1qZeimn+R2tjWX7J8hhRi/hynVELe4oT+gMTgNVv5bR45r7xH2JebOPwYkaVY0VBD7FqcvhS23F26PropgeE4nqbj/0ZnjvuQbVqrz/VXoPeEBtxipNZQE9TTOaAFt82lmXUENs8YWbDb2hzgxZanof393ksm3ivJKNHHQIEGONV+GNoqnO7Icpehmc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199018)(46966006)(36840700001)(40470700004)(36756003)(4326008)(70586007)(70206006)(356005)(8676002)(81166007)(47076005)(110136005)(54906003)(6636002)(316002)(36860700001)(82740400003)(7696005)(26005)(1076003)(16526019)(6666004)(40460700003)(5660300002)(44832011)(186003)(7416002)(86362001)(40480700001)(82310400005)(426003)(83380400001)(8936002)(336012)(2616005)(478600001)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 17:24:55.6900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a79d49-ef52-4b3f-0560-08db086710b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B07A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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
state is possible after this change.

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
index 6582c922ad3a..4e74f59804ae 100644
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
+	return 0;
 }
 
 static ssize_t show_status(struct kobject *kobj,
-- 
2.34.1

