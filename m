Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB7C67164F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjARI3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjARI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:26:04 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2069.outbound.protection.outlook.com [40.107.94.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5E05AB7B;
        Tue, 17 Jan 2023 23:53:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUmRNG1CtXX6poVVmme63Y9uQ01ylwRw0ehdLidBOuXo8YIhmlhrkS6vEUvAJK1rU2rhaj9Vp4S3xrJdeP949bDzMd2ZZM8fWWmjAQbkFSDfwnkeVkZeCSP/YmJxs7Ow69iMXs77xNjUubwBfVcN5J6MuK6EDcvnEwWoEwbYSvqcKynFyqSCcmfd5ojAJBDz6d7fX39rOGzAqme8DcgQI2UOFw3/1CnjutpxHoKD3gRm3d6OqMPiXFyVYL9i61dfWzDQQ7y6qFqbhs2A5puYU/5Om9NAAymHPTraYiFJRSW77LYQHR8RrldP5wysNlQeN3vMt3Lp8u1tErn6sz3r2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oy8nDwUSRvXQ62VsnddCwoTZ9v1negEr0DKnbzsmDN4=;
 b=R+Ztmg0Gw9TZnqsaLWcOCgPWWZX8R9Hn64QAqzaY9gk5acQApk12I4sGC7D/yL6psIgZ/WlfaiGvS/GvggQ8Iv9p+1N7ERni3Otvq50a0Pyo6iJhktssdlB2c8f6l3DxbC2PpyPrbgSu8u1H9O3SGZYSIZ+zXa9HWVu2biH8hw8atMVUxKPbLkFXoUgKgb7Pr51kgqOycfZih0VfwBnDkbZSnTR0Npd+fdN8hgDLGGPmHS8jEW0ZCiwTC0z2FjUdcjj4qRJ7MIFJnhuH4388AE9mOva/rQlDEa5yBQ3qumCSZTSdLTr7uAm/1+V0xKoC3Jq+5PE57f90EnUVUc+0EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oy8nDwUSRvXQ62VsnddCwoTZ9v1negEr0DKnbzsmDN4=;
 b=KFdWnRtQf47CgA5QkCc6mV/b/q2h0TwC4qZZQX2Dr+nbFQnUzqP80d0lpHcfXlI0CSNRi83syZtVJcPyRed0okw7XTcKeon4uE1KWT0mrFsABm66ExGZvdvNZQ/dZR0bjeqaboI5/jk9O8jpF7o1tck4WSOfHKWTquCxeHTFElU=
Received: from MW4PR02CA0017.namprd02.prod.outlook.com (2603:10b6:303:16d::24)
 by DS0PR12MB7606.namprd12.prod.outlook.com (2603:10b6:8:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Wed, 18 Jan
 2023 07:53:05 +0000
Received: from CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::72) by MW4PR02CA0017.outlook.office365.com
 (2603:10b6:303:16d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Wed, 18 Jan 2023 07:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT111.mail.protection.outlook.com (10.13.174.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 07:53:04 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 01:52:59 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 05/11] cpufreq: amd-pstate: implement amd pstate cpu online and offline callback
Date:   Wed, 18 Jan 2023 15:52:04 +0800
Message-ID: <20230118075210.447418-6-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230118075210.447418-1-perry.yuan@amd.com>
References: <20230118075210.447418-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT111:EE_|DS0PR12MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ed6160d-c674-4a89-084d-08daf929079d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o16+zzrKecxu+cvWzT/Kd++TL8r+qgxqqAcoji/KRDTEQ5II0wsDlUZUc4qI3UzkntdIjKyEp7lipO62WGDbjNGVkq2b0l4DHO05EudYiN0EpMLxpqVLZ1/+B0si0GF9qdEqzlK9F5VcoSmrfNg+IHb1chX1N4sPe0wQUY4MkAII9iCcerKXUZBJpEcjNen+l7bqfsZrfupa9SmmxV2sPA2wU0Bfp45m+3G2YF4uS6R7mAAssMPLH9QzLE8LrbiAO2otPopd0UPDB4eBfvdZyAO6apah/yPK4rWa5T/Xrd7TAmkN1vUJCCHNvD6Pi3vRuAmNECetN1QB5t/+P7G5WzYN+Ak76Pj/W6o1IxLScUfquTZL1Nj10ez+4Z40quqAns1tBWQmIPGHiZU/KZJy7xSCITt5vKB59RjcF1XMQ6NuefQdQ8iNqQtkOFdL2t6ewhcneB1Kl+6p//VzHfnF3OdyQeR0LiCoXywMZHcGXe3K/z/qJeRgVuLP33qEwHZIWppuDzhZfXmpW7DfxGQ6+QsNSR8Uv6ffQk3vckKCUPfMKjnuIi2rm0vdUktcx5vfFz6EDVQoEgciRrC6hZduqheANHdmUIPGVe6eUrQI/kwVtvBJONm/H/j1UzN35B+48tVZt2lUVNCURurgW5TxvAqJzsEF05oQCP7qpJlpF/YWekliO3qzqkUCJbFsBwplmZ0Yk4UdNrtVhLN+3YwzI+RJRw3UInpHsHjYySFFEfA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(396003)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(54906003)(1076003)(2616005)(7696005)(70206006)(4326008)(336012)(70586007)(186003)(16526019)(26005)(47076005)(478600001)(110136005)(8676002)(8936002)(83380400001)(44832011)(6666004)(5660300002)(41300700001)(426003)(2906002)(36860700001)(316002)(81166007)(82740400003)(356005)(86362001)(40460700003)(36756003)(40480700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:53:04.0710
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed6160d-c674-4a89-084d-08daf929079d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7606
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
Tested-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 82 ++++++++++++++++++++++++++++++++++++
 include/linux/amd-pstate.h   |  1 +
 2 files changed, 83 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2109ad3fdd42..1472a6382b29 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -958,6 +958,86 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
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
@@ -984,6 +1064,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.setpolicy	= amd_pstate_epp_set_policy,
 	.init		= amd_pstate_epp_cpu_init,
 	.exit		= amd_pstate_epp_cpu_exit,
+	.offline	= amd_pstate_epp_cpu_offline,
+	.online		= amd_pstate_epp_cpu_online,
 	.name		= "amd_pstate_epp",
 	.attr		= amd_pstate_epp_attr,
 };
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 9bfdabd9d930..e9e291b7c2f9 100644
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

