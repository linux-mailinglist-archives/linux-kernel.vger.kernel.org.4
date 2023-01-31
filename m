Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265C46823D8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 06:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjAaFZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 00:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjAaFZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 00:25:06 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AE21C591;
        Mon, 30 Jan 2023 21:24:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1Y5dzLSnt/uugGQE4eeOMOcyftZxbPWtnQeL9wl1eMI3sNi18t3hR32rZROEUCqm+GIj0fjBzcuLQa9KCpihfojvS6ELzTuxpPzjwDK79Wci6mPzn/ykl/DBGt7AYVmeLxEphwlVT3xsUdUKn5I7FAQlhw2y74ijTBD+28UCD+9+j6/JZA3+FdJzVD+kK3CWO40s+p6i3ZaWxhs80jKUmAUOFLhebQfcLygABBjjZ6CWnxZRGla6KejEsP7ksQqzStPh6w14zLplEVe2boDQuOcubvxXnfNnaPv6owuwHwNaQ4+N6h8bDtVp4wJY7YrZPrgyPIOLoKZvKa/6P3HHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1UfNsWUdZq5knJuCy+u7zeY0WlCV0QodY6FHXABrGI=;
 b=PuKlrAq1VyBrMzfSDXqxvu2kalos6/cf42ACbluaOAo0YzmQDUcFDGXirfCyoUGuSezApC4JdRa5STkUIuKDiJ+wQtEoTx9HovLijyJ19J8xb1sC1utmWG8dq2agCFhVywp7wxKbsJwayF6OJ4hHZ4LR0O16nFSRYaRj5lgmXWOBxL1Ixb2A2lgRhxjQbti6CpxkvZ9DNT7xwC7oC9H2U9Hn2z46qXJIqiGTNQvG4hNqro7QFS+kzV3R2H9zh2nm2xAox9CWwG90LBnhW9mbybbsaJfLHeMIyyPQLro6MCD3JqJtPC7O33HsYi71KE7jEVQZdZYakv80znMBsTeGVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1UfNsWUdZq5knJuCy+u7zeY0WlCV0QodY6FHXABrGI=;
 b=qizoNgwehJHly0PJvYdCgKdNt0N81gQE0z8GyHbUsQ1iUl4NEFTOhVmGriQrV4J8jD3ntbW5VMnZgpgi79YzBSydDSuPiwihZkFgP0rQoG1O2vL5cAF7DBtYMMSRRRs9gmpK0E2Aoo5RIsT8xpJVlu1f7ihkU6vS6+cqY+IdsjA=
Received: from DM6PR14CA0056.namprd14.prod.outlook.com (2603:10b6:5:18f::33)
 by DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 05:24:51 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::cd) by DM6PR14CA0056.outlook.office365.com
 (2603:10b6:5:18f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 05:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.22 via Frontend Transport; Tue, 31 Jan 2023 05:24:51 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Jan
 2023 23:24:45 -0600
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
        Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v4 5/6] cpufreq: amd_pstate: Add guided mode control support via sysfs
Date:   Tue, 31 Jan 2023 05:21:40 +0000
Message-ID: <20230131052141.96475-6-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131052141.96475-1-wyes.karny@amd.com>
References: <20230131052141.96475-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT037:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: b90b7c73-ad0f-43f2-e8c3-08db034b7a48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xoYjJMvxgvByZJ785wHIPhCt16dDdJf30b56u8m0wJEtOUi8p6kyxw16o64LpLzZ4S1/XPJXG1Di4+kHOO7heHgmNkxmRhvMaw+a66LdEvCZyarN8P23xExZleCjIW4Fg38fSsfo68w4IPlG73CN7AL6pNa56VZraqQtYnHh+CRPkJOqO3jYVW5USLtwst2SgVR+wvy2+B/nl0FASEwvvCbIXcOlDP7uAAuxive/b+8VgUbWWunPYriuK6LTpbPJeTVnJPwJZgj3lcs/dfbtMMCTB58gnVuyu8fEzEjYQbNWr5N0YbsV9Ca3eK0ngTf7+E0hYnJogwAE/JiV9Sa1S8N3tC3e8RqWBAPN5rixcmQdbq3eXjZGFVOOSSzbq8eW+WvNfn6vskHs65XqH0OkFOWMSucyuUnfeK7Esk1fcOJJYms6+UZEVYdFLeEsKH0IWyeviG/3jnvzydGSBpmCVX3X2uXaK7t2acLOA12MpGarzJ77l7mwXyM5OZUU5d6Bp49IKB66dHFJElv/lyOvHl0EoAy7vz4Ncjjv5fYza8J5+l3GAJsQVKFB8rBAkX5kAtCgs28I/7XxyG12fJmXlhknA5lRk/l0Cw+k3Pr3GcFGE1r8Oi6AMo8IV7bjkoaaYY15qjak/UDgKZePV2GEFhHFLLOlnQwhznZoLsUG6J1xk6HH/Npa/CFr0hB8l/nJyxGLAHfVARgPNZegxqZ5NZW7LFMy9CaV/9UUNcE0OCk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(70586007)(70206006)(6636002)(54906003)(110136005)(316002)(82310400005)(8676002)(4326008)(5660300002)(41300700001)(8936002)(7416002)(36860700001)(86362001)(81166007)(356005)(82740400003)(6666004)(16526019)(186003)(26005)(1076003)(83380400001)(336012)(426003)(40460700003)(40480700001)(44832011)(2906002)(7696005)(47076005)(478600001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 05:24:51.1305
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b90b7c73-ad0f-43f2-e8c3-08db034b7a48
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994
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
---
 drivers/cpufreq/amd-pstate.c | 150 +++++++++++++++++++++++++----------
 1 file changed, 108 insertions(+), 42 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 48ab4684c3a5..6c522dec6967 100644
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

