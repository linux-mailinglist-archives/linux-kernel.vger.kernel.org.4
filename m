Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E43A6507AE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbiLSGlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiLSGl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:41:27 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723625F95;
        Sun, 18 Dec 2022 22:41:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXTsMN/+9xSuxcSGnwsbZu5kly83tDwt39BpxXKOmXHVEe/zMAzoqcEUFY6V6ZkZbRw2c87cyrc9dPgqwFRtJfOiQLVioGaPGOjWlAL26DsJoopaqVahpJCrRdYOLA+68s+UkV3pF1yXPYF9X6TYz8FZtExln4u9F4BeqhQweKi+u7Z6c+WlMOQXccTUvAX2gON2mJ6nndajpFLiml4l/biJQnywQkRMtG8CtuKIrBJEtyzfhg/vfx1JzWAEmtwvDj7nBNgO8TME6j9gOR9Y+FgzdJcs3HsweMBrqUY2AX0tEy0TevzPT0dcJCDd8sfCQgmww+jAKopW7q41w17Oxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g607Gbfc0wzy0Md7QQLevN5MlXbFDshEp6Ypr6gr+cI=;
 b=HnACkxnWgBwixPX/GsDSHX9Cud/Z4RWwj2MYHNOZhpZh0b0h0cry5YmcrbdTelkj2pQ/MAMF3eoScoTQVX0s0l6vHGHy9zNz+4cpM22AhK6pfu+JFooEN3mTjqLG5i9Ii8XuvqvvAYnKyht60+0nEh3w6wXSRWsPgqo7KcaT0VR9hwMCWR1t4HzsMiE7Kdi0rxlUPqDS3J5iXGWbGZmZjntHODyutTHW/ak2FF1qirLy3taIPV+3IoEIm/v3DEZOylpu0GLeYfs63PZqOVgsAt4YknBCufXtTe7yWxx2bkYIS5etPLXjJt3WtUmnz2VM3uzZNmH2LJmn6Ypm7yIKqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g607Gbfc0wzy0Md7QQLevN5MlXbFDshEp6Ypr6gr+cI=;
 b=xxpr6ODFC3dE3d/s/h1TTH5SWh47dddh8qEnxyXKwJEwwKgzXiOt8dzsMxqHm5LxTEcG8qjLXd1hXZulKF87UaKhZq3lCgiLHANra0Q7gTurzBiwhS3wopwhHrrL3mCtod3/kIQcw9W9xtREGvAW6TwN0ksPTL0903psph/CuO4=
Received: from DM6PR02CA0070.namprd02.prod.outlook.com (2603:10b6:5:177::47)
 by SJ0PR12MB6712.namprd12.prod.outlook.com (2603:10b6:a03:44e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 06:41:21 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::ee) by DM6PR02CA0070.outlook.office365.com
 (2603:10b6:5:177::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.20 via Frontend
 Transport; Mon, 19 Dec 2022 06:41:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.16 via Frontend Transport; Mon, 19 Dec 2022 06:41:21 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 00:41:17 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 05/13] cpufreq: amd-pstate: optimize driver working mode selection in amd_pstate_param()
Date:   Mon, 19 Dec 2022 14:40:34 +0800
Message-ID: <20221219064042.661122-6-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219064042.661122-1-perry.yuan@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|SJ0PR12MB6712:EE_
X-MS-Office365-Filtering-Correlation-Id: 35dca283-d606-4032-0025-08dae18c0a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rm8kHqBAVRfR+Z6X1bp3p3whQf2bPxcJMQU1IBzFerf+cOPJ4eUFmsDOnosBvyFY+ZAkMETEL6VKrjWIwHfQHCIDk/FzyjCNJDsKpfQdQqWCEgmVdT30o8JRsFR3fWad4PCKdN6ajuqiMLa4WoF2jWJT0Taqq5mVXtJKbz9bfH7VZ7JULXRHGeed74zLubQvD0KIslFTpZWdJ2+ecij27ppZKaKph0veIh0SOEjfYd5ZqJAzg8BTex5daqaMzp90ucG3WUKp5Mf1jg/51ChKQkjGqM9GfEEs7SNOYppY6WdcWHCDhY2HkYKEJj1jDOVUJSSN9yDARt2ddehoNkX05ib2R9MRfw2IwTZn5KvsAf1WdT67vCSSC7rBpPInFe2AlUJPEBBcoY4DOdEA4KbggfKEXlEE/DzGhO6a4D1UQtRjDMlSbmuchOqwJI91F5HxUxi0kOV3RzGiOi7ggUBgrv1ZGA4k1kZxL2kD2tgMAFRiaEqAKvi3fzaQ3bhB1xfcluw4eupbbnGbP0bAMIh67ELmZtNECSR5Nr9AcjgneqGd9HXJnwU92i6b5C7EKyWGwDF6FSXh5SkUj1TiOrV4wcABDT04DoKESbW3wUj1BvOVYbsYJswNoab0pRRF9q+mUS/tK0xmURnUjqjrP6QW0zDkNwsU/9lKoHER11Qgby94xdhBFptyRBkg/EsBH9xTLtnj6eLNE0JZiHOAwH8C1bBDkvh9TFqJEtKNdVXCu10=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(5660300002)(8676002)(4326008)(44832011)(54906003)(70586007)(70206006)(110136005)(2906002)(478600001)(6666004)(16526019)(26005)(186003)(7696005)(41300700001)(426003)(47076005)(86362001)(40480700001)(83380400001)(82310400005)(36860700001)(2616005)(1076003)(336012)(82740400003)(356005)(81166007)(36756003)(8936002)(316002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 06:41:21.2020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dca283-d606-4032-0025-08dae18c0a6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6712
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some other amd pstate driver working mode to be supported.
Here we use cppc_state var to indicate which mode is enabled.
This change will help to simplify the the amd_pstate_param() to choose
which mode used for the following driver registeration.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 35 +++++++++++++++++++++++++++--------
 include/linux/amd-pstate.h   | 29 +++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c17bd845f5fc..861a905f9324 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -60,7 +60,18 @@
  * module parameter to be able to enable it manually for debugging.
  */
 static struct cpufreq_driver amd_pstate_driver;
-static int cppc_load __initdata;
+static int cppc_state = AMD_PSTATE_DISABLE;
+
+static inline int get_mode_idx_from_str(const char *str, size_t size)
+{
+	int i;
+
+	for (i=0; i < AMD_PSTATE_MAX; i++) {
+		if (!strncmp(str, amd_pstate_mode_string[i], size))
+			return i;
+	}
+	return -EINVAL;
+}
 
 static inline int pstate_enable(bool enable)
 {
@@ -628,7 +639,7 @@ static int __init amd_pstate_init(void)
 	 * enable the amd_pstate passive mode driver explicitly
 	 * with amd_pstate=passive in kernel command line
 	 */
-	if (!cppc_load) {
+	if (cppc_state == AMD_PSTATE_DISABLE) {
 		pr_debug("driver load is disabled, boot with amd_pstate=passive to enable this\n");
 		return -ENODEV;
 	}
@@ -671,16 +682,24 @@ device_initcall(amd_pstate_init);
 
 static int __init amd_pstate_param(char *str)
 {
+	size_t size;
+	int mode_idx;
+
 	if (!str)
 		return -EINVAL;
 
-	if (!strcmp(str, "disable")) {
-		cppc_load = 0;
-		pr_info("driver is explicitly disabled\n");
-	} else if (!strcmp(str, "passive"))
-		cppc_load = 1;
+	size = strlen(str);
+	mode_idx = get_mode_idx_from_str(str, size);
 
-	return 0;
+	if (mode_idx >= AMD_PSTATE_DISABLE && mode_idx < AMD_PSTATE_MAX) {
+		cppc_state = mode_idx;
+		if (cppc_state == AMD_PSTATE_DISABLE)
+			pr_info("driver is explicitly disabled\n");
+
+		return 0;
+	}
+
+	return -EINVAL;
 }
 early_param("amd_pstate", amd_pstate_param);
 
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 1c4b8659f171..922d05a13902 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -74,4 +74,33 @@ struct amd_cpudata {
 	bool	boost_supported;
 };
 
+/**
+ * enum amd_pstate_mode - driver working mode of amd pstate
+ */
+
+enum amd_pstate_mode {
+	/** @AMD_PSTATE_DISABLE: Driver mode is disabled */
+	AMD_PSTATE_DISABLE = 0,
+
+	/** @AMD_PSTATE_PASSIVE: Drier mode is passive mode */
+	AMD_PSTATE_PASSIVE = 1,
+
+	/** @AMD_PSTATE_ACTIVE: Driver mode is active mode */
+	AMD_PSTATE_ACTIVE = 2,
+
+	/** @AMD_PSTATE_GUIDE: Driver mode is guided mode */
+	AMD_PSTATE_GUIDE = 3,
+
+	/** @AMD_PSTATE_MAX */
+	AMD_PSTATE_MAX = 4,
+};
+
+static const char * const amd_pstate_mode_string[] = {
+	[AMD_PSTATE_DISABLE]     = "disable",
+	[AMD_PSTATE_PASSIVE]     = "passive",
+	[AMD_PSTATE_ACTIVE]      = "active",
+	[AMD_PSTATE_GUIDE]      = "guide",
+	NULL,
+};
+
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1

