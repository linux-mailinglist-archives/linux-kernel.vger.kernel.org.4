Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7DE70B522
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjEVGe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjEVGef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:34:35 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00207FF;
        Sun, 21 May 2023 23:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOUncJWy3UvU9FuF/SqZmxTWMZlW1z7oZQ9f+4fCtyCRcSR9fVITlTGHHUD+dsOYRo2J4De3+x7RP2OTxcY/hQdQ0c5jNfCliU0kZkAVvDt0st82bCp/kEkF/sFPtlbUqvIc/9ELKmDnVjCzaE/nX9nn9qtJvVZN5IWtkLEyfEdjia+dvjz762RGe+tut+E8L7lii17t6tS22nNyzo0YA2CXZKqxRK3Ngx0oigfLCW7+9p89I2UNWhdBEW+u3GfMCGqcf1gXvc2JFth0AijmV6Sk033S/xhoHzcqvo1Gim5/fE33bxNh9CcnnOcvorduThf0RmtxUtxKwvygVuwrfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0vnKmSU4WhbsgTDlVSCFLn6eypNSwJkja+27TFMoCQ=;
 b=m4vnj6OgGulenqDoZri2NlKksHtquQkrXL5pWQUVuEaflPjuYg+AUpkL7iBx6F6m81oKzs3rzUWJJSBSM/3Ezf55P/ZyW+wVYT7887byE+4jVS8bxQPwP3wKOzI3qNPCohv4LaoN2lGABuZXdG6gIXS9Qkpg0/bZ0QVHNX+Q58dFADq2ek+9b2u6q8f0DwsN95O+eJjsR7qgjxt+KhS56s4Ivo2YGy0t5hcWAHxtK4U79VBMt4/Zwwy7fiNmUHexFnAl0p9OtQL7/DkCmQ7a9lwgM9ro5OuQWGgE7P0cQyqaAeBVEAfq3CgdIrkmUIFFMOiOkJQq2uIfKOssaYYNiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0vnKmSU4WhbsgTDlVSCFLn6eypNSwJkja+27TFMoCQ=;
 b=fibqtoIbyZA3ay5aB9BhRWBm27gu4VGoPiIaWducrZSLtDeR6TGKYhV/mIOu9K07SV3+h65rg/9kSRFDx78Cu8NyU8qcq9GexNTaCmQCLI4qJs39wApkz2vAsqGcaPRPeMSyFbHr1ZayK+muLmj4vIlUYDKXPR6PwxQju4JPrrA=
Received: from SJ0PR13CA0075.namprd13.prod.outlook.com (2603:10b6:a03:2c4::20)
 by DS0PR12MB8788.namprd12.prod.outlook.com (2603:10b6:8:14f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 06:34:23 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c4:cafe::9) by SJ0PR13CA0075.outlook.office365.com
 (2603:10b6:a03:2c4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.13 via Frontend
 Transport; Mon, 22 May 2023 06:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 06:34:22 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 22 May
 2023 01:34:19 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <Mario.Limonciello@amd.com>, <Jinzhou.Su@amd.com>,
        <Perry.Yuan@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 1/2] cpufreq/amd-pstate: Write CPPC enable bit for each core
Date:   Mon, 22 May 2023 06:33:24 +0000
Message-ID: <20230522063325.80193-2-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522063325.80193-1-wyes.karny@amd.com>
References: <20230522063325.80193-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT041:EE_|DS0PR12MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eab8898-41dd-40b1-a8ef-08db5a8e94b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6KTFplS/+1xf4ZH+wBXYsOWvD2gTUs0bvnsSTP9HQ9O1NRRT5sQfU0dWKZ3f1Yzc/mtbGtbF1S2J0tFOAotK35TFl0wScTWhGdWtcw4whtXw3pzrYOksmmfQMl8KN49cx1pQiORbcD6qRer5Dr1X41nxC+gUqEUBOfAmeqlFS8IGvl5ufY9ndKOvv/vvirz29gCD8/GaAP0OnxcbZ20FtehWEeP5/SiAA6WjzTZVhu7tYn5cPCepe2jDXdBhoKrWyQRGOIvXJvxb4nyD8tehQQGHxYXBFWq0wNxrH3O/O6EyXiv2B8VhvnqT3B5H1a1YQ9ugARKadiPE5bzglTmKRUo9z6Ngu2LI152IdZ4+wVsVv1wcfB32nBV8/bEQhQose95VJvDv4umu94oaOcYiw9u8KRnNZvpAb52/uBvjUuKgh3PM98ttJDDTl/Z7o6gJ4sfd2ARr/zjlZpIUdXRKkNSskAWwMDf5tD5ta1jrjZFsz5cfQ95rs9Q8DkGZIAuMphNomGhrPVmKl9tPqCmqSraRlIE0z9EXxJ/75gUid6NdLazlYXfRFmrc31ggbUFL10sYnHQ8e9sFw8QX3ZzUNCqhYIKKbNFxwHfXmZSYxzWLK+Xl6fA0kK1hGLTsmtdfxS96j6YB+6AuTFUgwtDXT1udZyXUJf4fUPGIIl3BlY6JoBj0Rz+MMM7QUtHetzYHZnsmxt2BLiPa0yXUR3ipnDceVXiGlVDLPV8EmSfzPYNCEIpHm8EnZbW+EhHm64KinFvzQyynR3KqXQq5VLWR9OUsCIqnpNCxdh5F8rnZBMg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199021)(40470700004)(46966006)(36840700001)(8676002)(8936002)(44832011)(5660300002)(83380400001)(82310400005)(47076005)(36860700001)(186003)(16526019)(1076003)(26005)(2616005)(336012)(426003)(86362001)(356005)(81166007)(82740400003)(40460700003)(41300700001)(40480700001)(6666004)(7696005)(478600001)(966005)(4326008)(36756003)(70586007)(70206006)(316002)(54906003)(110136005)(2906002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 06:34:22.9130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eab8898-41dd-40b1-a8ef-08db5a8e94b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8788
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI specification [1] says: "CPPC Enable Register: If supported by the
platform, OSPM writes a one to this register to enable CPPC on this
processor."

Make amd_pstate align with the specification.

To do so, move amd_pstate_enable function to per-policy/per-core
callbacks.

Also remove per-cpu loop from cppc_enable, because it's called from
per-policy/per-core callbacks and it was causing duplicate MSR writes.
This will improve driver-load, suspend-resume and offline-online on
shared memory system.

[1]: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/08_Processor_Configuration_and_Control/declaring-processors.html#cppc-enable-register

Fixes: e059c184da47 ("cpufreq: amd-pstate: Introduce the support for the processors with shared memory solution")
Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 53 ++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 27 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5a3d4aa0f45a..8c72f95ac315 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -226,29 +226,27 @@ static int amd_pstate_set_energy_pref_index(struct amd_cpudata *cpudata,
 	return ret;
 }
 
-static inline int pstate_enable(bool enable)
+static inline int pstate_enable(int cpu, bool enable)
 {
-	return wrmsrl_safe(MSR_AMD_CPPC_ENABLE, enable);
+	return wrmsrl_safe_on_cpu(cpu, MSR_AMD_CPPC_ENABLE, enable);
 }
 
-static int cppc_enable(bool enable)
+static int cppc_enable(int cpu, bool enable)
 {
-	int cpu, ret = 0;
+	int ret = 0;
 	struct cppc_perf_ctrls perf_ctrls;
 
-	for_each_present_cpu(cpu) {
-		ret = cppc_set_enable(cpu, enable);
+	ret = cppc_set_enable(cpu, enable);
+	if (ret)
+		return ret;
+
+	/* Enable autonomous mode for EPP */
+	if (cppc_state == AMD_PSTATE_ACTIVE) {
+		/* Set desired perf as zero to allow EPP firmware control */
+		perf_ctrls.desired_perf = 0;
+		ret = cppc_set_perf(cpu, &perf_ctrls);
 		if (ret)
 			return ret;
-
-		/* Enable autonomous mode for EPP */
-		if (cppc_state == AMD_PSTATE_ACTIVE) {
-			/* Set desired perf as zero to allow EPP firmware control */
-			perf_ctrls.desired_perf = 0;
-			ret = cppc_set_perf(cpu, &perf_ctrls);
-			if (ret)
-				return ret;
-		}
 	}
 
 	return ret;
@@ -256,9 +254,9 @@ static int cppc_enable(bool enable)
 
 DEFINE_STATIC_CALL(amd_pstate_enable, pstate_enable);
 
-static inline int amd_pstate_enable(bool enable)
+static inline int amd_pstate_enable(int cpu, bool enable)
 {
-	return static_call(amd_pstate_enable)(enable);
+	return static_call(amd_pstate_enable)(cpu, enable);
 }
 
 static int pstate_init_perf(struct amd_cpudata *cpudata)
@@ -643,6 +641,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	cpudata->cpu = policy->cpu;
 
+	ret = amd_pstate_enable(policy->cpu, true);
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -724,7 +724,7 @@ static int amd_pstate_cpu_resume(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	ret = amd_pstate_enable(true);
+	ret = amd_pstate_enable(policy->cpu, true);
 	if (ret)
 		pr_err("failed to enable amd-pstate during resume, return %d\n", ret);
 
@@ -735,7 +735,7 @@ static int amd_pstate_cpu_suspend(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	ret = amd_pstate_enable(false);
+	ret = amd_pstate_enable(policy->cpu, false);
 	if (ret)
 		pr_err("failed to disable amd-pstate during suspend, return %d\n", ret);
 
@@ -841,7 +841,6 @@ static ssize_t show_energy_performance_preference(
 
 static void amd_pstate_driver_cleanup(void)
 {
-	amd_pstate_enable(false);
 	cppc_state = AMD_PSTATE_DISABLE;
 	current_pstate_driver = NULL;
 }
@@ -1039,6 +1038,8 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	cpudata->cpu = policy->cpu;
 	cpudata->epp_policy = 0;
 
+	ret = amd_pstate_enable(policy->cpu, true);
+
 	ret = amd_pstate_init_perf(cpudata);
 	if (ret)
 		goto free_cpudata1;
@@ -1180,13 +1181,13 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
+static void amd_pstate_epp_reenable(int cpu, struct amd_cpudata *cpudata)
 {
 	struct cppc_perf_ctrls perf_ctrls;
 	u64 value, max_perf;
 	int ret;
 
-	ret = amd_pstate_enable(true);
+	ret = amd_pstate_enable(cpu, true);
 	if (ret)
 		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
 
@@ -1209,7 +1210,7 @@ static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
 	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
 
 	if (cppc_state == AMD_PSTATE_ACTIVE) {
-		amd_pstate_epp_reenable(cpudata);
+		amd_pstate_epp_reenable(policy->cpu, cpudata);
 		cpudata->suspended = false;
 	}
 
@@ -1280,7 +1281,7 @@ static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
 	cpudata->suspended = true;
 
 	/* disable CPPC in lowlevel firmware */
-	ret = amd_pstate_enable(false);
+	ret = amd_pstate_enable(policy->cpu, false);
 	if (ret)
 		pr_err("failed to suspend, return %d\n", ret);
 
@@ -1295,7 +1296,7 @@ static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
 		mutex_lock(&amd_pstate_limits_lock);
 
 		/* enable amd pstate from suspend state*/
-		amd_pstate_epp_reenable(cpudata);
+		amd_pstate_epp_reenable(policy->cpu, cpudata);
 
 		mutex_unlock(&amd_pstate_limits_lock);
 
@@ -1370,8 +1371,6 @@ static int __init amd_pstate_init(void)
 		static_call_update(amd_pstate_update_perf, cppc_update_perf);
 	}
 
-	/* enable amd pstate feature */
-	ret = amd_pstate_enable(true);
 	if (ret) {
 		pr_err("failed to enable with return %d\n", ret);
 		return ret;
-- 
2.34.1

