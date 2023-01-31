Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0B8682834
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbjAaJHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbjAaJGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:06:46 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20614.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB76305E4;
        Tue, 31 Jan 2023 01:02:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpQFtowh2idv+txbZuadjvVMRJcAlvlZdcW2xkR2ZA/rqq6g7XOmEc/XGNvi/6zRuSD4Epn0upvP5lPMltQqxGA5abHrdzNR5K2qhCr0yoAqjLm34jNwaucwAjiRewhVZcNXtOGQraZjgR4vCC+QT3H67r67Ru9SjLcToG03/Qeom7USLE1fagzl1WZ3u8dTMZcDssvA8Uqm+aeF40AJbJQ2R32d/0YuU+A2szLTFJCYUrgNHA+RnZhNK+98BCKvN1uZTrdG/ywgDydlqzYNPGgYRM6PYHjmUVlnFOfxS48Z9vdfBclSM5aFtcGoisCH6r6bq6duDA761UfbWhrQuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNSrK1JrZ7+I/Bgd1zZ7pnme2Vl/ZIJ4yjpEYf2L+Ko=;
 b=R2NcxuZNx7+h39k9FFkRAFXpDmL8pBL60AQDg9EtTQ95saTeaXnTdp4w0/NnavLForVQAER2CQS2FKnQ6IRFg151l1INdhVFrEG37GQ+ur10kPKE3h67SWrggx6cLKtqGpcQgUbQi6wOyCoss9wQaipGUGSR3CcQbMOQusGaNID/mbMtvZ8xh8uVWfB0+zWuZkUoUyA1k3R37Eb9FVMhN1+WNEwzMNteUDKck/PG0e9fwZFnXRENsa7bOu9tanPGfsK8+IUF922DDGTemz+A/RDscoiFR2dk3lBgFXYZZ6E/II4jhHCHAuqQIMtLK4TaeSJLmJcIfPtppAe96VDJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNSrK1JrZ7+I/Bgd1zZ7pnme2Vl/ZIJ4yjpEYf2L+Ko=;
 b=gm6n/Gj9WWwUa45i5HiTUneoG5VGcBGxsFri35ppR/AOSK1FIGVkH8/HjjBy9E4M1Od1bcMMBprRrp4a6snL9nQshhEfWUJawNbggCz5zm9yjnaU4MooAa5sc+cLXcNxeSHtlsSLnhWdWenEL3bCduWMYTfI4UGk/wuFu/7LEdY=
Received: from MW4PR03CA0193.namprd03.prod.outlook.com (2603:10b6:303:b8::18)
 by BL0PR12MB5011.namprd12.prod.outlook.com (2603:10b6:208:1c9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 09:01:05 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::c4) by MW4PR03CA0193.outlook.office365.com
 (2603:10b6:303:b8::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38 via Frontend
 Transport; Tue, 31 Jan 2023 09:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.21 via Frontend Transport; Tue, 31 Jan 2023 09:01:04 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 31 Jan 2023 03:00:58 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 05/11] cpufreq: amd-pstate: implement amd pstate cpu online and offline callback
Date:   Tue, 31 Jan 2023 17:00:10 +0800
Message-ID: <20230131090016.3970625-6-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230131090016.3970625-1-perry.yuan@amd.com>
References: <20230131090016.3970625-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|BL0PR12MB5011:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c77fa64-0f5e-4bba-d7cb-08db0369af4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9Z1szOzRH3z11phG+zNLyaPU8JpblSCAlYmrslqnDGg2uSAi4dyh/ZXTvaIxS+tLQwDxcp6W8KW/FJNbSSleTyYOAXQ3ZojKYTlYN3t8ofWthOqdnZKfjwIGsp7ZdZ2GMB79u7+OvF40bGOUvSbtxTDZE0zAVbvmJYwDJgiXbEv9zNnDtlTBjoRGNqLKG6KCjKESfsVpY1f+SQ1fctbsHblpDXSLsidmFm2CxIhJPo2r/J3tTYqSMSU7i6A84JsjrWmP1wGjkSC2NUJXGy+yWBCoCstKw4OAvd5TLNztY1xrpJy9nBk5s3Ifih0t2UW/uB8rO/3Q57GhGuZJ5Qt1mwKBbKpF9XWbc2xI+/RTsFImgvnImwoxSrYWkjyGZdY8EuscGtAnnaE9k/ssfvRvdfnQ+sBrL+6mV0SInfA+bngnXIR/BdMvcpWHZBflCQHcamZoiNbEtbRTkAStTdRluZqKumMmq9WPVkZ1V8XxzL4WQIdkHkQfNdKxrljns4w5wHx3EPRJf9gyVHKBIOez2MPfBVzrYRi6n1YsLUq1aSznx/rmOwg5F5Qz1frFprWhuuwb13wCZF8V/rnWxlDkPzH3YZTIKEOuYv1IjxLcm7XKe2ozzLlRTXgOaOc/KDm7L7uFRdmpdmTaVoRI0D+NaCZ+/pvEuIIi51QSoqQ49sGs4AOrWzPB16TdglBJWtu0GfdHft7iAN9mJ6Ur9Ess70f2h355p+OffL79KVQwXk=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(346002)(376002)(39860400002)(451199018)(40470700004)(46966006)(36840700001)(86362001)(40460700003)(36756003)(47076005)(82310400005)(83380400001)(336012)(426003)(110136005)(54906003)(1076003)(6666004)(316002)(478600001)(7696005)(26005)(2616005)(186003)(16526019)(8936002)(5660300002)(356005)(81166007)(44832011)(4326008)(40480700001)(70586007)(70206006)(36860700001)(82740400003)(8676002)(41300700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 09:01:04.8589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c77fa64-0f5e-4bba-d7cb-08db0369af4d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5011
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Wyes Karny <wyes.karny@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 82 ++++++++++++++++++++++++++++++++++++
 include/linux/amd-pstate.h   |  1 +
 2 files changed, 83 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index bca86b5b8b12..26f6ac83d87e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1000,6 +1000,86 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
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
@@ -1026,6 +1106,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.setpolicy	= amd_pstate_epp_set_policy,
 	.init		= amd_pstate_epp_cpu_init,
 	.exit		= amd_pstate_epp_cpu_exit,
+	.offline	= amd_pstate_epp_cpu_offline,
+	.online		= amd_pstate_epp_cpu_online,
 	.name		= "amd_pstate_epp",
 	.attr		= amd_pstate_epp_attr,
 };
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 72ea7cf85ca3..f5f22418e64b 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -87,6 +87,7 @@ struct amd_cpudata {
 	s16	epp_cached;
 	u32	policy;
 	u64	cppc_cap1_cached;
+	bool	suspended;
 };
 
 /*
-- 
2.34.1

