Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E33668B45
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 06:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236847AbjAMF0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 00:26:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236478AbjAMFZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 00:25:16 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2057.outbound.protection.outlook.com [40.107.102.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB7621B5;
        Thu, 12 Jan 2023 21:24:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3Gu8D7vU5yLSPrU4gWyAFmnTPhl/NYbfNczvhvdwHglEPtDby2opJdMKMdE1yFvhp4tG2KUG0ksEdrllipE6+oEi55PNJYCleHRKZ/GDQAUAmLrkHZL3ZSK0WkMY+nhwmkbq525ot5Y+5Y6P+zIvqBa1RUikylsVt5Pq/R75qTUrPx8hCOimXEQbcgGSNCsWNhy2+83fnyrQIb6bG0qu0q8183BnkjfmPlIkw+h8F218nJsdzgyBByD77NkTbhhzVn3Nef8Ue6K0iGEUCfkXlaAwJuCpTlEwVdJguVv3vS09kxCc8eQApgTRzPMxvDOUoujjTIuvnDMRPQOsp8u9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6NdZDDlwli7C8W873FcbXa5fNvq5NIShjUGvulXh9s=;
 b=VwByethADYAlhka5axHBmHpm/dqjRioYaDNcD4apUXU4eJi9XNvI4fWT0LnNxfs3JHEEaGbsqLexbjCXwd+v9O2sxbBF8RSK2rSw18SbkyNl7B48I/goh/GJ1wyYbsQBpv8Ab3wD3VijKq4KuuZPzbINLNnl9PGIsfNgxavROgSaT0lG8uufvzWS7TycFh34LevG3HLDHEuWOut7xHaJ+jERKUw4uotpsrOY+DNI4CySgLB5DDAGI6y1eRgIsongy38aAWvZb5iAFFc07SIgyi8tTSSCCieAvleBa0at8hwa5KpRR/sXKsPP7FB/7fbwgwvxzx2hQzVbZcTaylljZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6NdZDDlwli7C8W873FcbXa5fNvq5NIShjUGvulXh9s=;
 b=RPzk+7QrpfBeUFGgEKvAVD1kCXB/zEknS3ig3cdpgsmIsjgonmQ6xwjBEoofDB1rkSC8x5QyTjN+TxhePbOunt8ucPNys+VgP/grPWmZ/G/TGXUdWHY27xQEoGQBq6AtBdI9O57tkQAXNdQ0E6ANE8t5NKt9nUqNsNpDyFvl8lw=
Received: from DS7PR06CA0014.namprd06.prod.outlook.com (2603:10b6:8:2a::11) by
 SJ0PR12MB7083.namprd12.prod.outlook.com (2603:10b6:a03:4ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 05:24:54 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::81) by DS7PR06CA0014.outlook.office365.com
 (2603:10b6:8:2a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Fri, 13 Jan 2023 05:24:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 05:24:53 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 12 Jan
 2023 23:24:48 -0600
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
Subject: [PATCH v2 5/6] cpufreq: amd_pstate: Add guided mode control support via sysfs
Date:   Fri, 13 Jan 2023 05:21:40 +0000
Message-ID: <20230113052141.2874296-6-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|SJ0PR12MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: f21002f1-6227-4610-03ac-08daf5268084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YUXiHYyyvaM3ukiEXjlMVl7ynSZDTNA0vH6ibumTKvhUk1wxJsI9ZXkn0vdSemxseAH97I70ZeM2VPzc146VnAK+ZVeS4wQHl31kio+KoAkk0H1ZkJR5yVcqL5fwhD8fep+fbJyH05Uk1v83I2YmYCWnNF8kot3uGYoSzDxhIiIeosvmGXr1pbxYCP4MN7i0DobdDu/ZtjSTw9cLTEaWjDPgtKkMEPHf359KNRdNqO8+uA76vK/SiRWSYU2eJPhwvMeSnsN3z2gJptlZPEiZA1k9V99uP8OvZkDxLi5gYITjXKFSXkVDcO2vxq8az6ugy40VLf0t0aeg9thL3QeIokiqToRNdUbbJAbOUd4Glr/wYLhmsm6tmZcoy5h1H9I04np/NqA7PM3l84HKqjB5W6nJ6Wsd7dKNpe5omf0WA9XvFy9eTGjrpm0aakvGzpDNwi9uBJL0VozFeIn70Ekbc5m5yUaf+s9E4hKxRqohEuRi89fU5qp5lYLlGkZ8iky6eJ0tSvZd9fYBnw02FcMh7PGzw0HCSydpK+B9TXR0R3ks987hSQ/IesKCFHjpTvil5InnyB58vj0GDgKTtmISNNTKV9tolL8k+ddgQQUGEpmDTFd/AFaZ1DlpNz6/3ZbM3RHmP845JNruWZIQODr/OT+FB88XiCGhE7QsrU/tF0Dzyk/dqkolJSVFGQaIrcYWgD0vuiVw95GhhgY735j9HU4Rm2pfNV+FBdKbxbwW3Os=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(40470700004)(46966006)(36840700001)(36860700001)(6666004)(2906002)(70206006)(16526019)(36756003)(5660300002)(83380400001)(8936002)(44832011)(4326008)(8676002)(82740400003)(81166007)(41300700001)(356005)(47076005)(478600001)(426003)(26005)(336012)(70586007)(40480700001)(7696005)(82310400005)(186003)(1076003)(86362001)(40460700003)(2616005)(316002)(110136005)(54906003)(6636002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 05:24:53.9263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f21002f1-6227-4610-03ac-08daf5268084
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083
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
 drivers/cpufreq/amd-pstate.c | 144 ++++++++++++++++++++++++++---------
 1 file changed, 109 insertions(+), 35 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 20d78dad712d..4a2b559fd712 100644
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
@@ -806,55 +808,127 @@ static ssize_t amd_pstate_show_status(char *buf)
 
 static void amd_pstate_driver_cleanup(void)
 {
+	amd_pstate_enable(false);
+	cppc_state = AMD_PSTATE_DISABLE;
 	default_pstate_driver = NULL;
 }
 
-static int amd_pstate_update_status(const char *buf, size_t size)
+static int amd_pstate_register_driver(int mode)
 {
 	int ret;
-	int mode_idx;
 
-	if (size > 7 || size < 3)
+	if (mode == AMD_PSTATE_PASSIVE || mode == AMD_PSTATE_GUIDED)
+		default_pstate_driver = &amd_pstate_driver;
+	else if (mode == AMD_PSTATE_ACTIVE)
+		default_pstate_driver = &amd_pstate_epp_driver;
+	else
 		return -EINVAL;
-	mode_idx = get_mode_idx_from_str(buf, size);
 
-	switch(mode_idx) {
-	case AMD_PSTATE_DISABLE:
-		if (!default_pstate_driver)
-			return -EINVAL;
-		if (cppc_state == AMD_PSTATE_ACTIVE)
-			return -EBUSY;
-		ret = cpufreq_unregister_driver(default_pstate_driver);
+	ret = cpufreq_register_driver(default_pstate_driver);
+	if (ret) {
 		amd_pstate_driver_cleanup();
-		break;
-	case AMD_PSTATE_PASSIVE:
-		if (default_pstate_driver) {
-			if (default_pstate_driver == &amd_pstate_driver)
-				return 0;
-			cpufreq_unregister_driver(default_pstate_driver);
-			cppc_state = AMD_PSTATE_PASSIVE;
-			default_pstate_driver = &amd_pstate_driver;
-		}
+		return ret;
+	}
 
-		ret = cpufreq_register_driver(default_pstate_driver);
-		break;
-	case AMD_PSTATE_ACTIVE:
-		if (default_pstate_driver) {
-			if (default_pstate_driver == &amd_pstate_epp_driver)
-				return 0;
-			cpufreq_unregister_driver(default_pstate_driver);
-			default_pstate_driver = &amd_pstate_epp_driver;
-			cppc_state = AMD_PSTATE_ACTIVE;
+	cppc_state = mode;
+	return 0;
+}
+
+static int amd_pstate_unregister_driver(int dummy)
+{
+	int ret;
+
+	ret = cpufreq_unregister_driver(default_pstate_driver);
+
+	if (ret)
+		return ret;
+
+	amd_pstate_driver_cleanup();
+	return 0;
+}
+
+static void amd_pstate_change_mode_without_dvr_change(int mode)
+{
+	int cpu = 0;
+
+	cppc_state = mode;
+	if (!boot_cpu_has(X86_FEATURE_CPPC)) {
+		if (cppc_state == AMD_PSTATE_PASSIVE) {
+			for_each_present_cpu(cpu) {
+				cppc_set_auto_sel(cpu, 0);
+			}
+		} else if (cppc_state == AMD_PSTATE_GUIDED) {
+				for_each_present_cpu(cpu) {
+					cppc_set_auto_sel(cpu, 1);
+				}
 		}
+	}
+}
 
-		ret = cpufreq_register_driver(default_pstate_driver);
-		break;
-	default:
-		break;
-		ret = -EINVAL;
+static int amd_pstate_change_driver_mode(int mode)
+{
+	int ret;
+
+	if ((mode == AMD_PSTATE_GUIDED && cppc_state == AMD_PSTATE_PASSIVE) ||
+			(mode == AMD_PSTATE_PASSIVE && cppc_state == AMD_PSTATE_GUIDED)) {
+		amd_pstate_change_mode_without_dvr_change(mode);
+		return 0;
 	}
 
-	return ret;
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
+		[AMD_PSTATE_GUIDED]      = amd_pstate_change_driver_mode,
+	},
+	[AMD_PSTATE_ACTIVE]          = {
+		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
+		[AMD_PSTATE_PASSIVE]     = amd_pstate_change_driver_mode,
+		[AMD_PSTATE_ACTIVE]      = NULL,
+		[AMD_PSTATE_GUIDED]      = amd_pstate_change_driver_mode,
+	},
+	[AMD_PSTATE_GUIDED]          = {
+		[AMD_PSTATE_DISABLE]     = amd_pstate_unregister_driver,
+		[AMD_PSTATE_PASSIVE]     = amd_pstate_change_driver_mode,
+		[AMD_PSTATE_ACTIVE]      = amd_pstate_change_driver_mode,
+		[AMD_PSTATE_GUIDED]      = NULL,
+	},
+};
+
+static int amd_pstate_update_status(const char *buf, size_t size)
+{
+	int mode_idx;
+
+	if (size > 7 || size < 3)
+		return -EINVAL;
+	mode_idx = get_mode_idx_from_str(buf, size);
+
+	if (mode_idx < 0 || mode_idx >= AMD_PSTATE_MAX)
+		return -EINVAL;
+
+	if (mode_state_machine[cppc_state][mode_idx])
+		return mode_state_machine[cppc_state][mode_idx](mode_idx);
+
+	return -EBUSY;
 }
 
 static ssize_t show_status(struct kobject *kobj,
-- 
2.34.1

