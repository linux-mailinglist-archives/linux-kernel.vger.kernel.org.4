Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE3465FB42
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjAFGP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbjAFGPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:15:03 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19B46E0F7;
        Thu,  5 Jan 2023 22:14:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPA0FsBfDQEuQbbgD9kmn5sp1cDHHHpyjRBLSU3DNi1WL6d0SlbiQgU09AuElWWJHzZcP8zskOMuaW9fSJhbVzc5olxCrKftj1kClm9OUJLLFILI/kpVJ/SV85jUwFvdk95uXi0CxtC0hkKAsjM6MyWy0gFs0/cruA8ihltijnXw6WCSOpvjWZRjOmHYCYcglDI6h//gcM1E2a0C1tZSH4Qz9oJmBgMgbrLRTwiAWEuszlOBM2PXs313IUv4qPhg/qy8orTTEZsGGv8rOp+Aau5OdK8BIYzOm8Zn9qT9IN7ffK7WUFHKxd4mZVbSHdB7LyBfY/e/rA2SzViSWg65EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BwTC5MCWQdYxtubuPK2R52dh4i0DxJ9x5Hl2agLBVU=;
 b=X7vBKsY9IMlLM+tjG+NjbVsiD+RKRpNFyr0uD1W1Qc69miWYkvn1B8iXNZsYGg+qUiVQcCHDrNanCPxEp5R7cvBqhtAdS94VQodVUDkvmPIwiPi5s5Hf6Po9KHF+MT0euKT3acnEgJbUFrOY82A8kPCbaBlJV4XeqHqfWQTKb1/ft252L1EVDxgcfM5ZN4pdq3sk32A1gvHSwPMM1qeLVX+BijQxdttNCKIUZCak/6+dloAQEuSfRuY2cEAytPGZqNRhbrM3lypjeXGC5m15sAap3LUC+WZw4JLpn7GGh7voa4kAA/O0ijTGHPPakzcxiPFQUBCmzKGauBRuitpNhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BwTC5MCWQdYxtubuPK2R52dh4i0DxJ9x5Hl2agLBVU=;
 b=4SG46O+DDR+snsAHXehwSoEWlzu6T9P3rzWPaK2cSSYKi2A/fUxohYNcvFpM67/Y4iqTrXmUAgJrnCJwHSngMc00f15qCXNfWQMFmBCJhPBI31LXIMPUL0PEf/XvPUUebZj6VZW7JBmFD5W/3wiQozQaeVP4ZAp/1uSxEIes6m0=
Received: from DM6PR02CA0077.namprd02.prod.outlook.com (2603:10b6:5:1f4::18)
 by PH0PR12MB5450.namprd12.prod.outlook.com (2603:10b6:510:e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 06:14:53 +0000
Received: from DS1PEPF0000E633.namprd02.prod.outlook.com
 (2603:10b6:5:1f4:cafe::88) by DM6PR02CA0077.outlook.office365.com
 (2603:10b6:5:1f4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Fri, 6 Jan 2023 06:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E633.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.15 via Frontend Transport; Fri, 6 Jan 2023 06:14:53 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 00:14:49 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 04/12] cpufreq: amd-pstate: optimize driver working mode selection in amd_pstate_param()
Date:   Fri, 6 Jan 2023 14:14:12 +0800
Message-ID: <20230106061420.95715-5-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106061420.95715-1-perry.yuan@amd.com>
References: <20230106061420.95715-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E633:EE_|PH0PR12MB5450:EE_
X-MS-Office365-Filtering-Correlation-Id: f317e992-ea38-410b-eced-08daefad536c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GkEiWJaxo9qShqDzO7HH3tDLz0ziisilBcULzMx5a1rdHTKUZ6cGEy0YcUcVYdmL3/ob6J9cx3S/91fZHG7mUys6xq0SWsXYLr6o1Rvxi71Ax3RrluBvj2epaeaiDnrJp2DURoxYA3b3NUK89psYb35zZ1lxXOumt+vAT3NvmnJcBlDhBs8V4Q0h6VtQpca2+CLl5wA4O06AqtX3mXDnzrHpA3Yvzyw+XBXuLoOIJRHuQjagKrU7ZMgVdvX6O1QI9d78un1mzNon4rUbRTmEzV1Ida497UwjOQsEbKo9jgBiqxJK/zIeD/XYU50YTzFaI0a4HHdW4RUsSy7swRnrv9k9kKKPVr2n5MlCMkfQ04DrfloNqcG8Nb92piOnK/QLhM/jjvystszXBZK1TsAP8Bj6OC7ILR++cke+xeXNXeOLmRSAgYHv8mZfFZza5R0MItux4QuzuvAvi3fZCqRc/ZZJCPkmdOXJCY37ZFrqy8mZLJ33JecMQ10thbvPuhfEZlyH68tNAIuNjm3ZQOJHN4FDtK3NOjNLnMEWyrHRehQos2g8asRqElhIRVw9lRzmMrf1fiKZcpoRIJxFLiT7ikLgiITwB0Sujs2vM3cE2dpaXIwoc+ywWMBirz8lJt2zCsc46o52AA3Sw/WtzGfaLReDDwaaljdUuV94XqTipvJE5VsUnsYOWVuvDYyD2POjS76gwW5TbeUKL5osUauqeQqAdDrG6X5OJDSoAZUO2dc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199015)(36840700001)(40470700004)(46966006)(8936002)(83380400001)(5660300002)(44832011)(41300700001)(426003)(47076005)(2906002)(81166007)(40480700001)(40460700003)(356005)(82310400005)(86362001)(36756003)(82740400003)(26005)(110136005)(186003)(54906003)(16526019)(316002)(36860700001)(6666004)(7696005)(2616005)(1076003)(478600001)(4326008)(70206006)(336012)(8676002)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 06:14:53.3593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f317e992-ea38-410b-eced-08daefad536c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E633.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5450
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wyes Karny <wyes.karny@amd.com>

The amd-pstate driver may support multiple working modes.
Introduce a variable to keep track of which mode is currently enabled.
Here we use cppc_state var to indicate which mode is enabled.
This change will help to simplify the the amd_pstate_param() to choose
which mode used for the following driver registration.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 39 +++++++++++++++++++++++++++---------
 include/linux/amd-pstate.h   | 17 ++++++++++++++++
 2 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 204e39006dda..1a8b31277620 100644
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
@@ -625,10 +636,10 @@ static int __init amd_pstate_init(void)
 	/*
 	 * by default the pstate driver is disabled to load
 	 * enable the amd_pstate passive mode driver explicitly
-	 * with amd_pstate=passive in kernel command line
+	 * with amd_pstate=passive or other modes in kernel command line
 	 */
-	if (!cppc_load) {
-		pr_debug("driver load is disabled, boot with amd_pstate=passive to enable this\n");
+	if (cppc_state == AMD_PSTATE_DISABLE) {
+		pr_debug("driver load is disabled, boot with specific mode to enable this\n");
 		return -ENODEV;
 	}
 
@@ -670,16 +681,24 @@ device_initcall(amd_pstate_init);
 
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
index 1c4b8659f171..dae2ce0f6735 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -74,4 +74,21 @@ struct amd_cpudata {
 	bool	boost_supported;
 };
 
+/*
+ * enum amd_pstate_mode - driver working mode of amd pstate
+ */
+enum amd_pstate_mode {
+	AMD_PSTATE_DISABLE = 0,
+	AMD_PSTATE_PASSIVE,
+	AMD_PSTATE_ACTIVE,
+	AMD_PSTATE_MAX,
+};
+
+static const char * const amd_pstate_mode_string[] = {
+	[AMD_PSTATE_DISABLE]     = "disable",
+	[AMD_PSTATE_PASSIVE]     = "passive",
+	[AMD_PSTATE_ACTIVE]      = "active",
+	NULL,
+};
+
 #endif /* _LINUX_AMD_PSTATE_H */
-- 
2.34.1

