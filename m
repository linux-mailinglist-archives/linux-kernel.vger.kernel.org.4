Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C9E6ADD6D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjCGLbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjCGLbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:31:32 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6E454C85;
        Tue,  7 Mar 2023 03:30:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPhlRy5r8eMTrnquTz0yCmJQbnGrecdGU/7wMdlCtnnW19vSbpUHOGnu/dzPhlMtc+fVEMiNpq1sPj3sFgIp7K06z1Ny81k5qLKANrl/bx1YOzFP+Hd0O1l966NOsSmbDnz31YdmILnVEmriBb4Py5HlYdH/bwx+Eh1P/QOVuAGU8sAZE+9cVMmTSGJUzzspDHFZHj3jeJnjs/rkMQkTmAxr3rq3LtBv20nunQXqAxZWOmJ5VsgYPuCc0iihtiPSeSehmRh9zXWUO3isyRHoIu3NNtQA68SZO0ZEu+qBVGYpVrtPFP8TfQgv6XODkxw5/F7AUoGwCsbK9xyChDaPCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOnZlLrGEYf1/bHyJj+hOsRjUJ2z2CxK+Pf03tzIqFM=;
 b=NN/PW7tFbvwKZGz6Q7MPQaA5OTCcselLkjfLGrgMw1UjyD14C7XRMEWQRUq/xufDGwkzPwQI2QiHwX8poa5G6UMmX0CwWI06kM6gltfLbG+zdy4cXyIZS1d0W4HDVD7b9ZUblem5uXpv+SYWxFptET8jGxb9N0t1Rz0JY97coC8USrL7k8H0oSZl/CJE2BhmSYVkPYOuXzQfK4GPYPoYi2LBJWVEsZO0+XQnQOw/o19swBclVq0ZpyCXne/AbuYc/C6FzX+T64KWPd1yslFF8O8XgTZmsr+K1AQw7ewXbS4LO1jObaaDJHfAqeGMKcXj1Bn4XlsSb5NZwa9WPXu5tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOnZlLrGEYf1/bHyJj+hOsRjUJ2z2CxK+Pf03tzIqFM=;
 b=h03eehklU2syzUzCmtlsoo3E/Fn29cXtBXe/nYt9WnrkFmd6ArXIyIs5vHphLRDcC0VfB3EDtjjc+ctnHTTmglEJq/+bgHkFyxxdoT38n9gRjn51VQze5zfvkfhP4QtyTJ2HWYQ1kTrC2eMouTzNe1FLI+5EvaLrBzFsNCg6jE8=
Received: from DS7PR03CA0244.namprd03.prod.outlook.com (2603:10b6:5:3b3::9) by
 BY5PR12MB4243.namprd12.prod.outlook.com (2603:10b6:a03:20f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 11:30:25 +0000
Received: from DS1PEPF0000B07A.namprd05.prod.outlook.com
 (2603:10b6:5:3b3:cafe::c7) by DS7PR03CA0244.outlook.office365.com
 (2603:10b6:5:3b3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Tue, 7 Mar 2023 11:30:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B07A.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Tue, 7 Mar 2023 11:30:25 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 7 Mar
 2023 05:30:19 -0600
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
Subject: [PATCH v8 5/6] cpufreq: amd-pstate: Add guided mode control support via sysfs
Date:   Tue, 7 Mar 2023 11:27:39 +0000
Message-ID: <20230307112740.132338-6-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B07A:EE_|BY5PR12MB4243:EE_
X-MS-Office365-Filtering-Correlation-Id: a5867b76-837c-4455-60e9-08db1eff58ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JY5kw0sn8HoqDGWNwgX6gxZReGkH0R88wOi+dconLSC7f2dk7juFrxJXm8//2y46F589d7KkKFDkpw6B7RGY3KHd2DrDaDAOqDhn1ZeVg79Jir0bhQpYpKYe6hKQiVmPTdTspGbZNomA2BxvqGNX9CvI8r031SZjU21VMqBG6EQ5suVTWkmEotUtLlJvoKVFs+AjZpAkk6sPa+33tx/iufnNISNluexdfH5W/xaQu8Dz4qkw82//E25wbjuRu7hx6V+mangh9q6/106L0doKE5RCiHOQHdjjh7EKve+VNw8IZTVOqgRkfTTEEbJUmo53JhSYc+781JWSD/nh8uc9MoB42v1iC/ZyPGv5Px4+jc6rYtkNQJCQglaDF24qCu3a5U38HiP3s9dm9vl68RZNFYDl0DjU2vf0+DjJb3VyOAgi443E5eAA0xn3CTifG//fdTrtfKmHBvkT1YWtnZQK0UTvFmxFhcX+5XSnjOz3YKXSBg3QJxrJhHepYWKZLI4RAPIf4jQIn1aN+6xKSrsB84MXJ3ErzOYwik9BNPxVcQaW8yk9wFGdcOOLKROdDYFrW4fKmQ0ogZMLPhY820PRR6R5ote/u7klVOdxqHX4n/NsB5xNIc+ucnwpp/B1cNNOfdfBk55Qo0Ct4HHPrHvq92La+2Up1LcpI/O5APqrK8WZRv3hNHq/HEcmpfGF5B8eqLuGbRdFovQIe7gKl2ClWYwU360CIL6z/iRQwcq8WhM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199018)(36840700001)(40470700004)(46966006)(2906002)(356005)(81166007)(36860700001)(336012)(82740400003)(186003)(26005)(16526019)(2616005)(1076003)(44832011)(7696005)(6666004)(40460700003)(82310400005)(478600001)(70586007)(70206006)(5660300002)(8936002)(7416002)(40480700001)(41300700001)(47076005)(110136005)(426003)(54906003)(6636002)(36756003)(4326008)(8676002)(316002)(86362001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 11:30:25.5592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5867b76-837c-4455-60e9-08db1eff58ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B07A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4243
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 143 +++++++++++++++++++++++++----------
 1 file changed, 101 insertions(+), 42 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 61dcd7b89b26..7955cfc91c31 100644
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
@@ -838,6 +840,98 @@ static ssize_t show_energy_performance_preference(
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
+	cpufreq_unregister_driver(current_pstate_driver);
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
@@ -846,57 +940,22 @@ static ssize_t amd_pstate_show_status(char *buf)
 	return sysfs_emit(buf, "%s\n", amd_pstate_mode_string[cppc_state]);
 }
 
-static void amd_pstate_driver_cleanup(void)
-{
-	current_pstate_driver = NULL;
-}
-
 static int amd_pstate_update_status(const char *buf, size_t size)
 {
-	int ret = 0;
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
-		cpufreq_unregister_driver(current_pstate_driver);
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

