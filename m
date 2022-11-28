Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2550A63AE7F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbiK1RIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiK1RIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:08:22 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F8926AE1;
        Mon, 28 Nov 2022 09:08:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEZBMepzjlCFvG3MOsfe/N4s2YjY7tnmKUwBPw3QoOSI0HKAhR++SM13+RsKDFXbHjU1qrP1p3lH9+Vmk9+c8mDCCvhULWcEXc0EokuKdV0WqrtFa1X1CqF/+foVpIv0Ox7lLlLhVhjIfyIads5KWHKDge8O+MBL31ICAkipPQMatquHenHl5M/rXLHgujMEfIUY1x5C1JJ8RUoXyGI6GpKYk4a5/lQxdMVky4GF6yAeC/4oGniabE3cgFN4pmgnVjKh9jn+4L24Yst3S7BTPACXT73lbUwi/he7jI2d+9iGLhmX7nY+zwO5uW5bJwGEi1KJ7ZyLipveNmvP3B4pzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08gMA6tTXZy/EYPC8WWPz16oytXcUuiEWlnfIWnShcI=;
 b=mu9l/qPOmc26uDRNvnM9a7k9chnvL0qz9AdMqXYyZnUDfkcQtHiWyAuszHZfW6PK62+KKXRXcbyryEuYb16MGqffXq7agosutbSXCvU0rSFtEkWh7iLGCUl0+kRz+SLGEzQC+E8cWDuNKQqSoe1NrspoVmuZlO6sJ/jt2GGGGkUwixmrgOdZuH7w0n1aSE79R2mfGgGV7XsrqK9lDIkxt/1L5IaQtVdQkXBIruHl55DGG6Tg+/ucVlHCjplRjFjOh2TzCSy+rXYx/AIV7NrzEASe9B5/BNO+ih0KAWhC8QBcCnS5/jmyXTICamjGuKDagwBQn7JyB4crKLq9H755hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08gMA6tTXZy/EYPC8WWPz16oytXcUuiEWlnfIWnShcI=;
 b=RtYuXoPClGAVRgI9oUfQSsD1My9KlQlCHU11EXyyf63CteclZ3xVO6KmkXpgqJx9/SRpYNMPjJvCWXwUZ710zjmN2HqWG2ihNxsLcTa4NtzgMtRyS90OEue3mT5SbcioazzdYOf7OON9Ccbo6SEuPRSAynVptwhkM66IJ6UTeKk=
Received: from BN9PR03CA0335.namprd03.prod.outlook.com (2603:10b6:408:f6::10)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.22; Mon, 28 Nov
 2022 17:08:14 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f6:cafe::30) by BN9PR03CA0335.outlook.office365.com
 (2603:10b6:408:f6::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Mon, 28 Nov 2022 17:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.23 via Frontend Transport; Mon, 28 Nov 2022 17:08:12 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 28 Nov 2022 11:08:07 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/9] cpufreq: amd_pstate: implement amd pstate cpu online and offline callback
Date:   Tue, 29 Nov 2022 01:03:09 +0800
Message-ID: <20221128170314.2276636-5-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT036:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e1a4129-db39-4567-4c41-08dad163221b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxqwbYIYBY+w/vMmGSxkx5SED4ME9vc8HGWkYL0INJn69Zy3xF0OxYsHn+WskGdkAGZqLKS+xRoSVzwl00k1qj1af/wwlzA6TNvEPl9SXh5BvRj90DdY0XB1TmqekHMw6A4XCeMI9nw07OBojB31XpW5Q1iKER4JIsuVLFWG7y1wVjIZVEJymQFrNGz4dtND7einjD6mSEaLCWNRVQ5FD1V5uGtRrfC05+IKF1DH17pD+gaTZsCG+nKqtHE/Wjp77Ygn6isk4h6fPLr3ar093DYb9xvqfuzPa+cYHraXQKh+xrN6R4CR009Q+vY/fByH0RkAF+N7b1PvfoL8weyB8JqCQBCVDBoyt/VlNY5NssSEWp6qBtCPL0EQzePREaVtTQn6chExQB/IOgMqD7yc+4ZsfzH55h+K1uBgTebLKgpevTbQDivhuP5ukW+tQv3USf0x5h6iegGJGYvsCSZp/a2SZwdgvCWPG4ByvtWQqFcQarwZgrvNEy5Fg/qEGoxnWx11zdjUDSsR9e72aTmK5qDB9UMC+w+rUFPfPfpD9RhX1pH23Sod1VOumJcBIyo0O7zC87ZC0xM66fFAStmw46rnXSA26/UrDvvFCqDwzUu7FntqGuMd0ExJTWM/JHQ14T26pazmFE6tr3JqB+DqFoHGNkObO9oLEOt1XfsvF1/N6q12q79/klGYhqH2z6+2sJ6FHA2FE+d4WXZnBMIbL4C+4y5GsM95FSUuiCOBFEs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(36840700001)(46966006)(40470700004)(47076005)(426003)(7696005)(86362001)(478600001)(356005)(2906002)(40480700001)(81166007)(36756003)(40460700003)(44832011)(1076003)(82740400003)(336012)(83380400001)(2616005)(82310400005)(16526019)(186003)(41300700001)(70586007)(70206006)(4326008)(8676002)(36860700001)(110136005)(54906003)(26005)(316002)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 17:08:12.8028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1a4129-db39-4567-4c41-08dad163221b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
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

Adds online and offline driver callback support to allow cpu cores go
offline and help to restore the previous working states when core goes
back online later for EPP driver mode.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 89 ++++++++++++++++++++++++++++++++++++
 include/linux/amd-pstate.h   |  1 +
 2 files changed, 90 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5a19b832afdf..b77f5b1f3565 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1183,6 +1183,93 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
 	return 0;
 }
 
+static void amd_pstate_epp_reenable(struct amd_cpudata *cpudata)
+{
+	struct cppc_perf_ctrls perf_ctrls;
+	u64 value, max_perf;
+	int ret;
+
+	ret = amd_pstate_enable(true);
+	if (ret)
+		pr_err("failed to enable amd pstate during resume, return %d\n", ret);
+
+	value = READ_ONCE(cpudata->cppc_req_cached);
+	max_perf = READ_ONCE(cpudata->highest_perf);
+
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+	} else {
+		perf_ctrls.max_perf = max_perf;
+		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(cpudata->epp_cached);
+		cppc_set_perf(cpudata->cpu, &perf_ctrls);
+	}
+}
+
+static int amd_pstate_epp_cpu_online(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+
+	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
+
+	if (cppc_active) {
+		amd_pstate_epp_reenable(cpudata);
+		cpudata->suspended = false;
+	}
+
+	return 0;
+}
+
+static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+	struct cppc_perf_ctrls perf_ctrls;
+	int min_perf;
+	u64 value;
+
+	min_perf = READ_ONCE(cpudata->lowest_perf);
+	value = READ_ONCE(cpudata->cppc_req_cached);
+
+	mutex_lock(&amd_pstate_limits_lock);
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
+		cpudata->epp_policy = CPUFREQ_POLICY_UNKNOWN;
+
+		/* Set max perf same as min perf */
+		value &= ~AMD_CPPC_MAX_PERF(~0L);
+		value |= AMD_CPPC_MAX_PERF(min_perf);
+		value &= ~AMD_CPPC_MIN_PERF(~0L);
+		value |= AMD_CPPC_MIN_PERF(min_perf);
+		wrmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+	} else {
+		perf_ctrls.desired_perf = 0;
+		perf_ctrls.max_perf = min_perf;
+		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(AMD_CPPC_EPP_POWERSAVE);
+		cppc_set_perf(cpudata->cpu, &perf_ctrls);
+	}
+	mutex_unlock(&amd_pstate_limits_lock);
+}
+
+static int amd_pstate_cpu_offline(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+
+	pr_debug("AMD CPU Core %d going offline\n", cpudata->cpu);
+
+	if (cpudata->suspended)
+		return 0;
+
+	if (cppc_active)
+		amd_pstate_epp_offline(policy);
+
+	return 0;
+}
+
+static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
+{
+	amd_pstate_clear_update_util_hook(policy->cpu);
+
+	return amd_pstate_cpu_offline(policy);
+}
+
 static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
 					   struct cpufreq_policy_data *policy)
 {
@@ -1217,6 +1304,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.init		= amd_pstate_epp_cpu_init,
 	.exit		= amd_pstate_epp_cpu_exit,
 	.update_limits	= amd_pstate_epp_update_limits,
+	.offline	= amd_pstate_epp_cpu_offline,
+	.online		= amd_pstate_epp_cpu_online,
 	.name		= "amd_pstate_epp",
 	.attr		= amd_pstate_epp_attr,
 };
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 7e6e8cab97b3..c0ad7eedcae3 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -99,6 +99,7 @@ struct amd_cpudata {
 	u64	cppc_cap1_cached;
 	struct	update_util_data update_util;
 	struct	amd_aperf_mperf sample;
+	bool suspended;
 };
 
 /**
-- 
2.34.1

