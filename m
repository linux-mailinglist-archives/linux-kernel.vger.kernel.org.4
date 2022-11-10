Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30D46248E8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiKJSAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiKJSAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:00:01 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D0E4D5D2;
        Thu, 10 Nov 2022 09:59:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuglJS0Dp4YIck3PN4ln+8NlcEL/LSXH9ySheUtagZ5ILl3YtUnsMb3v1WUdeORX9ie/oSE0YExO5X2FzqFNlKKMNwAfuhmzBB3umot+JMWR3CflvBgwYhnQwlbnKyq20j6Sxs+sgaapC5F5P6KJ8blJcDQlS+L4WcMnhk2gt7IJsWwqGLhiaWhVGpINrzBUamxsxjrZmc859pH/WZ1AzS8RIbQ0JmvR+6VlP5eVS5EzEAG7+dzAq44SEDkrTHVx5o+RBunTy/+BlQkaWR8bc14OkLgoG1XC+mpgnDdxqQSBIRdGls8If7jlM1TuOxrPDVqEz4z8MFtqf33NF5BeAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5XvbAsGwctxiPGDpM4BvEKmqsb8MKYiFVGhS7LjHld0=;
 b=nlS1qXGBT5XjwjqnQ2mR0PDd841H/0c4vm9i/DTv89TNRKGD+f7swcVXh/GVvXQG/pahylu++lfOiKNhZFeyR2e3EDtPhu2oqUTyYMRVXM6E5Ox80Qj8dmC2N4GbzNDYnSf7qhjVypAsyMW1XFbhrtfRUoGn4/KFp/ymeDOg3fpNRTBey/EBf0GKRWc+AmYmOQjfEh030C8gCjryauaW6r6sf5BPIXlHpiksl8ad51CKltbEOoyutmcoRD3SSB8cGNLbyBAPzEqfEIEVafG5REmfPDNUr+Cmvl97eX/WAAtbxPEl417UKHZ/cisNu4AS6WGTW4ZEm4KchMLpS/4erw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5XvbAsGwctxiPGDpM4BvEKmqsb8MKYiFVGhS7LjHld0=;
 b=MOxG+3JE67OpIOC1hvvrKqedFdu+vC5maUEPLo0WWLqrmpEaeQbvxL+QRTsDrdb2thGe1ZwVc57BlDfrULPZpg7cl6iSgpW/eW4ggJ0F66q7Y87UQdDg/6UxvKK+OZUtxgc79UYDNUk6v3lpPg5dg1n00ld2q1e9CgXkmPot2aA=
Received: from BN0PR02CA0046.namprd02.prod.outlook.com (2603:10b6:408:e5::21)
 by CY5PR12MB6226.namprd12.prod.outlook.com (2603:10b6:930:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.12; Thu, 10 Nov
 2022 17:59:38 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::4d) by BN0PR02CA0046.outlook.office365.com
 (2603:10b6:408:e5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13 via Frontend
 Transport; Thu, 10 Nov 2022 17:59:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 17:59:38 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 11:59:34 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v4 7/9] cpufreq: amd-pstate: add frequency dynamic boost sysfs control
Date:   Fri, 11 Nov 2022 01:58:45 +0800
Message-ID: <20221110175847.3098728-8-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221110175847.3098728-1-Perry.Yuan@amd.com>
References: <20221110175847.3098728-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|CY5PR12MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: de1b6c66-9f9f-4f66-47f6-08dac34555ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3p+YtEezixGwoRxF0S4tkW/XSzQXKS9LYRfiAl4daXnJBkUGLPlK8a0+D/FMxRAMcKJXOCjrhmHUHbw/e7yHuPGYQeIPQRrA9KmGLXewsqXScyq8Uhgjv11WLH0BX3IUlLMNOnJFB1NbNxQSnnQPqkQhtqZ4Q8pNt8Q0qqBFNNSMIpEtpvBXNAMX1YV95S3A7jCHjkoZdq5HgR5Ae/NIpcZ+rQOBO704gdoicTDoMF5MmicIHafPwDuJhJvi4QTBmZ5VFaRbSXFHZeyrdswniAV/v+jSIu8Mgt78JLqmat6mUytoxB1JYfhlkQvw40kZuVED8IqZPQDjGFY6es7wf9fHaXzRcciYNL6AYDGDm0yaeCzVjktNV7yIlelI/znh7mJucc+HOIO2dPPtweOEo1ieF2q7TNR4BwPBcOpxuU8dns/kxaS9egYcuYDLrtL2BjfPeuAncYOS5OHbqvIGYp+2CQqXnokldRyptdK9LOg32VNRGIZdG8og57LOSm3j0N9HMd67vdH03kw/TPoH7CYpIOZFzdUbeSot7jR8n4fkZDVJOGnNahaInI+qak3lc9CAypiqipudyC2GcDPr0ZMOEsw5+A7D9Kgx6ypD6tM8p77vWIxMC783o/R/tGduBQJTLDYuTz81RVfALjhoawWVpKRdJGFT5gFfdnZIm+8aEjvSIcJyB4zD101ifT7a4ehPEOO/6VjTICayNNmY8SEdBecD1+6Xs+n1dvC5zi10z3AEjdQbISLTuK+ULmhF48R3rqp9qpocd0gE9GsvK2IYtJJDjjTfA9n6Smb1YGD48EhIcOCs5VsxMz37qF6xrLTKakYM5Zbou18eve9muQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(40480700001)(54906003)(70206006)(86362001)(41300700001)(110136005)(8936002)(5660300002)(1076003)(356005)(81166007)(82740400003)(2616005)(478600001)(40460700003)(2906002)(36756003)(7696005)(4326008)(26005)(8676002)(36860700001)(316002)(70586007)(426003)(16526019)(336012)(82310400005)(47076005)(83380400001)(186003)(6666004)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 17:59:38.3391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1b6c66-9f9f-4f66-47f6-08dac34555ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6226
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one sysfs entry to control the CPU cores frequency boost state
The attribute file can allow user to set max performance boosted or
keeping at normal perf level.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 66 ++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 645706d65173..b71bfbbb7639 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -765,12 +765,46 @@ static ssize_t show_energy_performance_preference(
 	return  sprintf(buf, "%s\n", energy_perf_strings[preference]);
 }
 
+static void amd_pstate_update_policies(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		cpufreq_update_policy(cpu);
+}
+
+static ssize_t show_boost(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%u\n", cppc_boost);
+}
+
+static ssize_t store_boost(struct kobject *a,
+				       struct kobj_attribute *b,
+				       const char *buf, size_t count)
+{
+	bool new_state;
+	int ret;
+
+	ret = kstrtobool(buf, &new_state);
+	if (ret)
+		return -EINVAL;
+
+	mutex_lock(&amd_pstate_driver_lock);
+	cppc_boost = !!new_state;
+	amd_pstate_update_policies();
+	mutex_unlock(&amd_pstate_driver_lock);
+
+	return count;
+}
+
 cpufreq_freq_attr_ro(amd_pstate_max_freq);
 cpufreq_freq_attr_ro(amd_pstate_lowest_nonlinear_freq);
 
 cpufreq_freq_attr_ro(amd_pstate_highest_perf);
 cpufreq_freq_attr_rw(energy_performance_preference);
 cpufreq_freq_attr_ro(energy_performance_available_preferences);
+define_one_global_rw(boost);
 
 static struct freq_attr *amd_pstate_attr[] = {
 	&amd_pstate_max_freq,
@@ -788,6 +822,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
 	NULL,
 };
 
+static struct attribute *pstate_global_attributes[] = {
+	&boost.attr,
+	NULL
+};
+
+static const struct attribute_group amd_pstate_global_attr_group = {
+	.attrs = pstate_global_attributes,
+};
+
 static inline void update_boost_state(void)
 {
 	u64 misc_en;
@@ -1398,9 +1441,28 @@ static int __init amd_pstate_init(void)
 
 	ret = cpufreq_register_driver(default_pstate_driver);
 	if (ret)
-		pr_err("failed to register amd pstate driver with return %d\n",
-		       ret);
+		pr_err("failed to register driver with return %d\n", ret);
+
+	amd_pstate_kobj = kobject_create_and_add("amd-pstate", &cpu_subsys.dev_root->kobj);
+	if (!amd_pstate_kobj) {
+		ret = -EINVAL;
+		pr_err("global sysfs registration failed.\n");
+		goto kobject_free;
+	}
+
+	ret = sysfs_create_group(amd_pstate_kobj, &amd_pstate_global_attr_group);
+	if (ret) {
+		pr_err("sysfs attribute export failed with error %d.\n", ret);
+		goto global_attr_free;
+	}
+
+	return ret;
 
+global_attr_free:
+	kobject_put(amd_pstate_kobj);
+kobject_free:
+	kfree(cpudata);
+	cpufreq_unregister_driver(default_pstate_driver);
 	return ret;
 }
 device_initcall(amd_pstate_init);
-- 
2.34.1

