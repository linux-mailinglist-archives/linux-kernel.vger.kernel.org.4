Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B09164014C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiLBHwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiLBHvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:51:35 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8396A1C0B;
        Thu,  1 Dec 2022 23:51:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LAdJcrjIZaDeIQeZeLlWn6PY7F+z0gbBEqS7m1OQdJ9NnPesd+PQ1VAHSj78cVWCmEhsIL9ij2U0ju/A3W+0sMWmCaw0x9x4EJVg3pdxtT8m2bf9pnXojphmiFk6zA5vgAWJ66u/qZjR/qZE/KeevjhZ8PDUxz2EIMJGeTJsRHCqzw/bCTkTCZGvGIknwkZzID5ax0+0mjNarT4aPXvP5Sw+xJEyWfprMrkvAeA7id96r8bDZNzqMs5nKRGGek6Rfg2aKDAzYQLZFqVLxj9MivtvPH/qLvqwCExDQUE4RrLWK2hCVUc7ljf/VF7mrBPnb6lUdpWxvLDWf8Db1y6HHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0twL0htuKEWjgmgwAUFoURCxZ8iLhYjjEP18lP/gGUo=;
 b=hgOR8CMicevPEuTWi3z+MbXFDuUC7P9W9xL5ftWirhPK6YC2Me+iGV5i/WK6uBcZPGDKsu77J8tHwJ+5amvRhMHzBT+aGxnotazjqg15pQUUVK/hHSl5dPzFuXESmYyZWwAK8KleemvSaC/6e0L00AFNInkUJyOXw9xKQMSGmOojRGr8nt8TIba7LHjNxhoYUcARLBANx7gIVEsxHWnhRrsOPY/p2g+v8Fdu6mhrlYI6L0Txo8yfXa6V2zhIxadScdeMhJGEMXCgN/RjXwKup4O4Y8F+TPdlqr+eqTzqXt3Br2CEvWyMqFFFP/CZV1sFijCaY84Qnie+HIzNQuk7Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0twL0htuKEWjgmgwAUFoURCxZ8iLhYjjEP18lP/gGUo=;
 b=mKovbGwCEImXDWHbJSunf4yALd/z9/VTDkaJXH9CB8WmoAr3KTposPwzPQO6p9ubKltYVV9skhrmUyTA1YeD/Gm8mcnLI1pxI/ir37axCLHdVd0WQRMgODylEZnsI84Xh1GHIaxD4Eri7wII2fk6A5wINwS+OjJAQioA2vlN4J8=
Received: from DM6PR14CA0060.namprd14.prod.outlook.com (2603:10b6:5:18f::37)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 07:51:27 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::41) by DM6PR14CA0060.outlook.office365.com
 (2603:10b6:5:18f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10 via Frontend
 Transport; Fri, 2 Dec 2022 07:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Fri, 2 Dec 2022 07:51:27 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 2 Dec 2022 01:51:23 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 07/11] cpufreq: amd-pstate: add frequency dynamic boost sysfs control
Date:   Fri, 2 Dec 2022 15:47:15 +0800
Message-ID: <20221202074719.623673-8-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202074719.623673-1-perry.yuan@amd.com>
References: <20221202074719.623673-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d45da11-2c5a-4677-c1d2-08dad43a0460
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w1yfk/sUHLnm1k//f9im3Oz53IFbP4CxYkoKMFYMxoWKR6uNr4rcCbP77ZPnNsgtS3xSkJXnWgG7LRzs6ea2b4I08fBKyHnmuTbvoNv/j5tyuNiUSID+TzKZpGiKQwUGpDSE9BU1TBvGP3gFbfHzUVfvTjIQEcZS5RAkt4fJwTMY18TCni0WVD/c4cf2rv5yc59in9QV+87TJeKGacwSf+MErl9BmQwkB4A6tZyirjlm8m872emUm+CU21oehEGjNOOhNOums1yrsMzzdVofAwxHROHku5YCKDFTwSruQwx9/PcYy07b4JBGoCkG4368GOnZP0eBOEm/y1jVPtrlSRE/9K9+hUMZYD78xON2glq8wZT7YYcI86xmqBtTcRSVok79Ms4qEh+grgRS8uT8Tp/gALD3sqfqA9MuWKVHfHTS0dOsuOaHcyHDxOc0ANNYj4Yc9VX1EmI/ayuhe7pZaIc0Is6jl1/4zhztcziGlH3Czyiy1y6sL0gLlQBtocInWnCIwu9ySO0KyBtb8Djn+PuKqamGktQRstx26bgpo1UpQLBsdCVyg94rAwX3Hw8k4TRx0sXJi75bIjoC3NPAtZqrY1kK8xB+WMaDRWrWOa5GOb8fBMHOuReUbomubKlqJzmF7WUjRoS9gk5qlEgOG/eH60CAD60zTOaKf4lvfSTYoc2QzyluTafde0oxuUxuylzQJM5NgtLDOEA2ZYpVWNIVWAuxN4ZPUHefjFznoDVR09kvkqEyIdC0BohwtsIDJlIpj3u7Y3LPyJHtLW8K1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(41300700001)(7696005)(6666004)(316002)(44832011)(83380400001)(2616005)(54906003)(36756003)(356005)(40460700003)(336012)(426003)(82740400003)(70206006)(86362001)(478600001)(16526019)(81166007)(70586007)(8676002)(186003)(5660300002)(4326008)(82310400005)(1076003)(110136005)(47076005)(8936002)(2906002)(26005)(36860700001)(40480700001)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 07:51:27.1581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d45da11-2c5a-4677-c1d2-08dad43a0460
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512
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
index b3a82cee2e83..6936df6e8642 100644
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
@@ -1415,9 +1458,28 @@ static int __init amd_pstate_init(void)
 
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

