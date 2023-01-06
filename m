Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B7365FB4C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjAFGQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjAFGPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:15:41 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0AA6CFCE;
        Thu,  5 Jan 2023 22:15:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEOuQJck5bwyS59CFycmdLGEZQmh5V4g9qxM5wVBkhjiLQEk8IVbrB4ASxq2YKtvnBhD4G1rvzV+CQySb+m0TW2r6brifkxFNWO/hqnmiUG/Yilwt8PE4IPXTgfTQ4Z7jmBp/6BK2q0pXapfv2yq/FwbIeJK7A4Nb4BjD/TCLiTGeXxDc/qDlqZdcM6CU5w069QZdw4BxL+My5E5J2pdl7TdyE73D6rg33NLDY0ArWMGrPD/hl4J3tCdYkl9skbp3gR9OUA0dLmv5CcPFbx8CrhPvFQxiVIkZO0Grza7VuReit1x28wsZBSDU5htjPx+1NPEmzM7Ui8kFOSVphqdkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KiN2WsXyqSj9/ByAn/G3QK6A/0GdxoMA9ifN6vAss24=;
 b=hmggKlKL+iRlrXHTR98EP/T2T14gtlG7ooCxOrYnhSqXDHj4nRQJzWFwsrDIeccogbbQdhq3nrPla+ZtxoTcaEEk+eG0a4U/t2DbuntOsMaQ2uz358SLAJOOYqkXoauQ3Expn9ntRAn+xTMh71I7bW7pcD3ihzf9ptOni5ggc8zMwXngqxqcQ8vexiItmODaG5p6GxthELUN8L/SVYwJEqcT5UIxkIfMFu++XuW1FhDQ4ESqlVBDER3xcUGLmEu11MpEDqPzf+NFtiZaYuGmNySdm9gUNgl0QeWC9mm25lPUELLkenpM7n30BPUXZ1z9u5kPtLOQ+d33hAY9lK78KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KiN2WsXyqSj9/ByAn/G3QK6A/0GdxoMA9ifN6vAss24=;
 b=EobAnBnlX60Eq3NGwqaAorO+g78THDRAKbmxcs+253VG2ktiRyooDJxSm2msgsR44La9WvOIFJFRAy5wGwoZkhZKIWdkuMdZjURUCdO+7NZe7BEqfV9wOIQrX1qP0hbYZ8yf/XihgHVK0cCpjA6eiIKhyMYMS6v+Zg6mUOR1v1Q=
Received: from DM6PR08CA0024.namprd08.prod.outlook.com (2603:10b6:5:80::37) by
 DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Fri, 6 Jan 2023 06:15:36 +0000
Received: from DS1PEPF0000E631.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::dc) by DM6PR08CA0024.outlook.office365.com
 (2603:10b6:5:80::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Fri, 6 Jan 2023 06:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E631.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.15 via Frontend Transport; Fri, 6 Jan 2023 06:15:35 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 00:14:57 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 06/12] cpufreq: amd-pstate: implement amd pstate cpu online and offline callback
Date:   Fri, 6 Jan 2023 14:14:14 +0800
Message-ID: <20230106061420.95715-7-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E631:EE_|DM6PR12MB4075:EE_
X-MS-Office365-Filtering-Correlation-Id: 1156ae9c-3a90-4f41-4f54-08daefad6cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BgKduX/sO9GeHxc61oD5BluDZXbhxJK1zesX9YGU/TJddwoPoRRvy+nStYmHf8lVilJkZE8X3J/8L8eksTXnL55JCapq0nkXXEyJq5YoI6Yl9VaGogb5yHv/mReZfMUIh69PnH3Xtkk8kqs4fPdp1VsL6mRzq6bq9b/TSGg5UAaGDsIZeSFNEmqEg9HCV46tIJwB6+50kyzmJNz5YkfL2Rb9nu7t26u0mllAX4aosa//IjfrulTKjouwqrfSVYuNM4Zcc4x5/s3aXkUMDv5EwIOTf0Dr6tdO3DyMdIHTEEaXDUzNgzrMpn1lb66hg6p0HZ22c1pSZvkppm6MaXBxuCbS2ctAYJbnQbuI+wzefFbZPBbqbINKgw7iQHt6Lt04rWoiDPvQV6KZzpVd/qc+JyoXkY27SjsVEzvOkvvJJd4uGKmwYYqdnFFUcsSZ+qt5DUfp76oWVy+teT1w4BBtRN4P9qEcRpIyLF+Z3KXzXPbrLawFryLsS7/97puBM4+eA/ryjK5iL4FQBomN7r9hnQgxZcuFRoG2/kgLdh1Pp2atiKHTExGx7OBgOAsqBsEf3xNTMf+o/7yi8BUZypEh1haSiLbimcZ3cP7qcjs6M+sQKdqhdNr9hyWAEfLocKMMLGXLlrhiK/b4p37cpL96Uwy9Hu1lgC01cKCoAmTnreY76yq+keRmwanWFE0HZfeESmb28QzGBOnuW+fzdwNcEoxkWn6iIe/i6YFZj8ymQjo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(81166007)(82740400003)(356005)(40480700001)(82310400005)(316002)(86362001)(40460700003)(36756003)(54906003)(1076003)(110136005)(2616005)(7696005)(478600001)(6666004)(16526019)(26005)(186003)(5660300002)(44832011)(83380400001)(2906002)(36860700001)(8676002)(70586007)(4326008)(70206006)(41300700001)(8936002)(336012)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 06:15:35.9995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1156ae9c-3a90-4f41-4f54-08daefad6cd7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E631.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4075
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

Acked-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 82 ++++++++++++++++++++++++++++++++++++
 include/linux/amd-pstate.h   |  1 +
 2 files changed, 83 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9a92c71af80f..ae6d2bf18e16 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -953,6 +953,86 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
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
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	pr_debug("AMD CPU Core %d going online\n", cpudata->cpu);
+
+	if (cppc_state == AMD_PSTATE_ACTIVE) {
+		amd_pstate_epp_reenable(cpudata);
+		cpudata->suspended = false;
+	}
+
+	return 0;
+}
+
+static void amd_pstate_epp_offline(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
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
+		perf_ctrls.energy_perf = AMD_CPPC_ENERGY_PERF_PREF(HWP_EPP_BALANCE_POWERSAVE);
+		cppc_set_perf(cpudata->cpu, &perf_ctrls);
+	}
+	mutex_unlock(&amd_pstate_limits_lock);
+}
+
+static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = policy->driver_data;
+
+	pr_debug("AMD CPU Core %d going offline\n", cpudata->cpu);
+
+	if (cpudata->suspended)
+		return 0;
+
+	if (cppc_state == AMD_PSTATE_ACTIVE)
+		amd_pstate_epp_offline(policy);
+
+	return 0;
+}
+
 static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
 {
 	cpufreq_verify_within_cpu_limits(policy);
@@ -979,6 +1059,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.setpolicy	= amd_pstate_epp_set_policy,
 	.init		= amd_pstate_epp_cpu_init,
 	.exit		= amd_pstate_epp_cpu_exit,
+	.offline	= amd_pstate_epp_cpu_offline,
+	.online		= amd_pstate_epp_cpu_online,
 	.name		= "amd_pstate_epp",
 	.attr		= amd_pstate_epp_attr,
 };
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 8341a2a2948a..15761a581e82 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -82,6 +82,7 @@ struct amd_cpudata {
 	s16	epp_cached;
 	u32	policy;
 	u64	cppc_cap1_cached;
+	bool	suspended;
 };
 
 /*
-- 
2.34.1

