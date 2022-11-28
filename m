Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4750E63AE80
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbiK1RJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232847AbiK1RIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:08:22 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8AB26AE7;
        Mon, 28 Nov 2022 09:08:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6CExzJ8sruvgjM48SwnmyS9yn9vBmAJWVWCZGVwP8XQ7ohHR96jYNfAXn9zhWJGews3KTyqVBAVoDEjhR/5o3a1SVlo69V2ADEyA6NQcmNaac+pMtzalNzfYpCxF4z73++hAX4cddMmcYnAdwbg//MJ2Mu+9ank1jnrSpQOHgXt2u8HglcttW4rH+5qsKoPIzOwcgtGtA2xO+JQ7WTyZHrWAthfbE4q76Fnfls74ZfvpGjzs2PSD07f9KyEdRHW+ccDj3eX4Jo9JeAavCjDMmNgx+Be08oZrd2oykVobDin1a3rx2OHGR3SR+TcpRDSeHT7Gn959C1Z4jOObyl2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LocI76GysW5AeBu+QgZjrA5SO3ONrWnDshYaJ+jS3JM=;
 b=jHQvt51oFCy31iSgKUUPM7CWY3uS5xWQeId18GCl1wuBEfiASAsSMompnY3JrvGlQ6A8vTFlAOi9SYMNC8jBSWHr6a/fgIhrS7MiARGgGuKqcgtAiH2LQVhnLBqm9btbDU2k7AELn/vXP+czDYKIk+WZcof0pH9hHh/Y3DJOLgsSN0kmGrKyWlowyXDw+zdl7omA0aYba2ei7KLvZiaELkFxkkNPltIVfA4CLM54ZT9Qp9GcWCJynlYteN1e/M5/8xVcybtal9KR7wzAMXWlsp7zPZN4cMteRjF+sifDwQbk8wTtcW0tqRsBc/3qQtekbMaFbvT/sY3K0uOBwD2BpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LocI76GysW5AeBu+QgZjrA5SO3ONrWnDshYaJ+jS3JM=;
 b=NQG2q0PC4GarMZN8fFP8CzKxklCHaD5jraVq0pLQs8r5BHkx6fwzSfaujxeVoUQI1GxkeyAG+toRmUX64N+XMqikhZrYch1OQKyKm0cPabQT17DJnrZfobRvhRksweRaiUJa73gC9EJ+yzx8hpkWQraEtGKrz8Xph1Fuc8s9b/c=
Received: from BN9PR03CA0860.namprd03.prod.outlook.com (2603:10b6:408:13d::25)
 by MW4PR12MB6976.namprd12.prod.outlook.com (2603:10b6:303:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Mon, 28 Nov
 2022 17:08:15 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::bf) by BN9PR03CA0860.outlook.office365.com
 (2603:10b6:408:13d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22 via Frontend
 Transport; Mon, 28 Nov 2022 17:08:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Mon, 28 Nov 2022 17:08:14 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 28 Nov 2022 11:08:10 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 5/9] cpufreq: amd-pstate: implement suspend and resume callbacks
Date:   Tue, 29 Nov 2022 01:03:10 +0800
Message-ID: <20221128170314.2276636-6-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT059:EE_|MW4PR12MB6976:EE_
X-MS-Office365-Filtering-Correlation-Id: f7883baf-c76d-4c48-1374-08dad16322ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TQSbgpzR43VfUrS2D0L96UfvkC7msDB/bh6JD7v0FeNDWmfjScShCvBV8e7fEEoTx3Ktr3eUvlIIsk/l/yBp7FyAh0X9swv+L3SZKCcA0zXrIfR8SjCUkexQB1fY4gubsWumjhJvLzRI4JxZ/IQtVp6dCSzhdvimH4O86z3vRnzFp3sjRg0gh16l+3sc7ISqgxLYIN7j+pXN8ZqWe+eRbA0w1QDu7t1to8ChTakboM+txKEQNCYA+xBK4cMq+ZS1CNViXCSK5JDjoQoxCwmdjFXp7r1Ww2wrOHN8z86ijC7XAdA/XB8zsqwurcIf1TPzRadEW4Na4ocOfnD1hEm5i4D6hwZLjdUGijG7bWnekmv0yxyMFUbbEkMJIH/TowpLZN5pZYTztckWEXgyY7lR2rKFI7lvFDRMHLpKqhvZIfpOJkBYaEjCW83xr0E43nrX3DrHQagiuXYKaKTFZ0maHGF5yJDjz29AW5bLkFxm58RODou0N8RgaTCwSebPkJ8/6XPAUk0kgplaPDhC90VWQFsOFY6Et98i6qBVD8bHHN0vjFcR5ZHx6EB3/HigcL+ilxN47YK0IwpvIIjqiLRsxgqUjaJdVnU7lkqmHFWhNQhRzr2e8hOB7lcUfmYZYNnjMMS+T3rqKfayjWAgl24UL+xaEqpScqODjmo6hU9/+t0rw2I2GwUjsV5Of0tSrd0vQFhgu2LRUkz5/BRfm3tsVxR2xei3KFF9MXAZsQdIhPM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(451199015)(46966006)(40470700004)(36840700001)(86362001)(83380400001)(2906002)(186003)(336012)(426003)(36860700001)(8936002)(4326008)(5660300002)(40460700003)(70586007)(478600001)(82740400003)(70206006)(82310400005)(15650500001)(26005)(7696005)(1076003)(16526019)(2616005)(41300700001)(81166007)(47076005)(8676002)(40480700001)(44832011)(54906003)(110136005)(316002)(356005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 17:08:14.1776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7883baf-c76d-4c48-1374-08dad16322ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6976
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

add suspend and resume support for the AMD processors by amd_pstate_epp
driver instance.

When the CPPC is suspended, EPP driver will set EPP profile to 'power'
profile and set max/min perf to lowest perf value.
When resume happens, it will restore the MSR registers with
previous cached value.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index b77f5b1f3565..3626ae1e8f9a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1270,6 +1270,44 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	return amd_pstate_cpu_offline(policy);
 }
 
+static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+	int ret;
+
+	/* avoid suspending when EPP is not enabled */
+	if (!cppc_active)
+		return 0;
+
+	/* set this flag to avoid setting core offline*/
+	cpudata->suspended = true;
+
+	/* disable CPPC in lowlevel firmware */
+	ret = amd_pstate_enable(false);
+	if (ret)
+		pr_err("failed to suspend, return %d\n", ret);
+
+	return 0;
+}
+
+static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+
+	if (cpudata->suspended) {
+		mutex_lock(&amd_pstate_limits_lock);
+
+		/* enable amd pstate from suspend state*/
+		amd_pstate_epp_reenable(cpudata);
+
+		mutex_unlock(&amd_pstate_limits_lock);
+
+		cpudata->suspended = false;
+	}
+
+	return 0;
+}
+
 static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
 					   struct cpufreq_policy_data *policy)
 {
@@ -1306,6 +1344,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.update_limits	= amd_pstate_epp_update_limits,
 	.offline	= amd_pstate_epp_cpu_offline,
 	.online		= amd_pstate_epp_cpu_online,
+	.suspend	= amd_pstate_epp_suspend,
+	.resume		= amd_pstate_epp_resume,
 	.name		= "amd_pstate_epp",
 	.attr		= amd_pstate_epp_attr,
 };
-- 
2.34.1

