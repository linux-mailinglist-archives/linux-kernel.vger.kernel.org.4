Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B7063AE83
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiK1RJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiK1RIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:08:22 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92994B7F2;
        Mon, 28 Nov 2022 09:08:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOQG9w9i9pGB7rcntux3A+HdAlYQS9Hhd6x7VA2tQ1yySD6p5wEZ4G5fLgsThwqPPsCJD9XG1eZw2DVXn3bBTfVomfuUc7HfwE/VBSZq3i2/TmqMO5uc8lDk9uzB0R0aRUJvtciCtj0+5tDBxD3yLtbeEqQF+SzP+iwJRC1KmK0nCGw+pB/z3+Q+rqv/xXVlW5GI2nDL8iUqqOWZxw1BenDX80NGzbGTQUtJjaWf3bEhCiNx4CTLPG1eZN5Vs7qcFjYs9MzgUw1Uc6KOEmFqAQ6KwoJm+Ma81FNoBhr1gcwATy+Nt/C6UEA0FpXYZ0Tav63b3Q6sk6x5NBNkgcBvuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2h487Q0hQFGNgamOD1vrf2gs3BPC1B5UD6MT/wdjXEE=;
 b=UwKiHEo/iwFkMzJdkXjdN7CrRDu9L6fAR1vIhwLGJwI9BOwEpBMJW5wKg/05TqxYAX4I6C0AJBMFD2U+z5LkXTr7VhTvQTNdNsmxJiAGMMv+r7Vsme1aF/1/tVVyfHogsQV71AD6hJ2EPmYuG7uHwzPizZB4FzqyyU44QyRMMoI/QlfeJB1+nh1/bpj1vQ0opp+kst8bWHJ+qFpqLX8wX7xmZtJss0TeBV3jyME/foNajamwwVaM7+ihZzxzxyFEI0seyZAtQdxtqkJj5DbP+tSwCzpKDswXV41ywrYIqXh2StURHopU6tXwsALRzn7WAFgc0rBh8DcVPGBuveMpHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2h487Q0hQFGNgamOD1vrf2gs3BPC1B5UD6MT/wdjXEE=;
 b=W7IcqJza47naKHCmBYpnJ/UQ4FhqbmVIs5OgeZ+Urq1LJKlsDLNpsSuArT9xbnYCHjyruWjatHcNrLFHG/IuJy9y6dM08f9b3MdsxmepThej379Eg/thC0om42FMurDzgmwvgc4AIyIWuSlS3RCQ3ogbJVIgImBDCz459RL4GE8=
Received: from BN9PR03CA0038.namprd03.prod.outlook.com (2603:10b6:408:fb::13)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Mon, 28 Nov
 2022 17:08:19 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::8e) by BN9PR03CA0038.outlook.office365.com
 (2603:10b6:408:fb::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22 via Frontend
 Transport; Mon, 28 Nov 2022 17:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.17 via Frontend Transport; Mon, 28 Nov 2022 17:08:18 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 28 Nov 2022 11:08:14 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 6/9] cpufreq: amd-pstate: add frequency dynamic boost sysfs control
Date:   Tue, 29 Nov 2022 01:03:11 +0800
Message-ID: <20221128170314.2276636-7-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221128170314.2276636-1-perry.yuan@amd.com>
References: <20221128170314.2276636-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT026:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ae7e86-6d24-4e19-8d53-08dad1632557
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBXio7yuEMMDErAdRtSf3cZ2q54KS9OIwbeu0O9e1BW5ZqUnYG8w8jZqH3brZVACSmDhZfs/H9UDslRg1brpZ/ByM+i6ONWy3o2ecyahfCrdlIba7NpJI7ATQPyhykOJL7Q4YkFasHYTuW6pFZWz4OQQRh6otElPQgQIJYVIb0n9hv4FnmmV8zapkW9zFMW4VJDPgw1m8Y+5c4UL7r1OpI5bqctLi0GOL00cG8qE6KlSZxdv4IBLd5IDKYhUbxvtMDLABLuFc/xQSABvVQORDv2vKVegkJtVBloNBuu5Ws8kdI+9zG7nFrQgmGAA7wXSfh9Af25ncR91qtWqzq66vbq9CWJJcTDoyKxw6tFv1MOZzPDfiretGAahgYSU/JtxvW3ybGRpnnO1BO5qj1ktuH7HDazYUSW1siObg+cM/Eq79/HtrUN04sN7PdupTElgTXM+YXFbsxCBiqaIUxr2yZLjeHoXB3RaHoWKYFV7vC+zaIcQcPxxpeNqC4THjRW+NjcDNsrELLlnnjeNDwMCiC2QTo7mD6B9oI4oE2dDndBcZoeVLTHaypi+mc2Vye06pBy9RprIEh0eoT/X7syppseQBvVZx5i/McQaE91jSul3Fg7TsvS3Gk5XZVTYlUSVn6AlidxxoFkMrNVu6oiBSNP4j9DEBWZxGkwGdqYXSWedt2hOeJK+uA/2Fr3cucOsjrjt4+mt09CgdWniTscUTIt1hx8OaWdmT0a3lTJG1qsqUyggTjyOyLJwEXN5xyzV4OduvnHcolho14TRBsje8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199015)(40470700004)(36840700001)(46966006)(7696005)(478600001)(316002)(26005)(81166007)(110136005)(54906003)(70206006)(8676002)(4326008)(70586007)(6666004)(44832011)(41300700001)(5660300002)(40460700003)(186003)(8936002)(426003)(336012)(16526019)(2906002)(36860700001)(36756003)(1076003)(2616005)(83380400001)(82740400003)(356005)(82310400005)(47076005)(86362001)(40480700001)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 17:08:18.4183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ae7e86-6d24-4e19-8d53-08dad1632557
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <Perry.Yuan@amd.com>

Add one sysfs entry to control the CPU cores frequency boost state
The attribute file can allow user to set max performance boosted or
keeping at normal perf level.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 66 ++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 3626ae1e8f9a..3335e7aa76f1 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -774,12 +774,46 @@ static ssize_t show_energy_performance_preference(
 	return  sysfs_emit(buf, "%s\n", energy_perf_strings[preference]);
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
+	return sysfs_emit(buf, "%u\n", cppc_boost);
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
@@ -797,6 +831,15 @@ static struct freq_attr *amd_pstate_epp_attr[] = {
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
@@ -1407,9 +1450,28 @@ static int __init amd_pstate_init(void)
 
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

