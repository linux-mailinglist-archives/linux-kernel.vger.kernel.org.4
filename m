Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5B861FC9D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbiKGSDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbiKGSCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:02:13 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A401AF0D;
        Mon,  7 Nov 2022 09:58:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=enkUawXVZYH1h3ulZPVjQ+qtOloOLmcgQk4MSkJEFZCkiECCn8PB48h7yLGs41qXiQCOLXoklQU3r9MQ8VOAiiEh9IVE9DVR91bQza+6vC32NX3lbIt8PqE/TD7dATeAGfEVEc/waSudhDqLANt8+c+iZ+TcxNiF5BSOiCcNHCRLDIdjuBhG/AAqVf3+y3CJoRXJ8Q5Vri2owhc2a316g/+xKMEcGw7ZzhfWSnIbK3ZaWQEJbPTgbfhpT4Mp2oKk5rYsgm4So4b0/Zz/vVi8Mn0HfKV4BW0SPHHu9KbvVoDinqc4IJK7+rK0cDqk1DAZIsCo7DnDiH23af5DnSKu5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5XkR+f6hwgRLPic66USNXfjx5kiDB8SwqB2wva+S6o=;
 b=lM5qNEX7ceN6t5dtY8SKc8S0nJ2pd9Do/n7KzWaynyBfi403l4Ql847cAut5Ae3SCSTxC2Nl+cUTPQzUF1jy63k4ejs76wMWBgMRwu6L5B/K7gEY9Wk77j+pPvqm/yRqjFoynabcz+ttI/szkllmQ4J8nxy76ocjf6UZupexdFD3dCp7sbmoGtR8iH8s2WET5MX3cy9amTw5c7MS2NLcvZjWahr6kD5LTiXSvYr+4PObuTZAX4fbYG89hK6vUmxLL78dTGGIzXKzAKKh13r6RcugXWsxdq/4yuHB3/H7MYK6joOeVxmAkGTCMSpcFA8qujwom7wfb9xQAleykNPAdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5XkR+f6hwgRLPic66USNXfjx5kiDB8SwqB2wva+S6o=;
 b=iAY6h8NpNlMwMldA3dI1oXMRU7NLT5i+EofMc1TUMXuDgZ4DiSWUOLqhpO2/NGy5Emc2muFIYe6MZXkpGvXAI/WEdIksosc2s1VWkuQ4GPAaiyDd2JFytO0E9RdkvBd7PnRWs4/0oN1VtXlv6s+h7rd0C6eMwgq0jr/HwGzSMo4=
Received: from DM6PR11CA0043.namprd11.prod.outlook.com (2603:10b6:5:14c::20)
 by CY5PR12MB6382.namprd12.prod.outlook.com (2603:10b6:930:3e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Mon, 7 Nov
 2022 17:58:39 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::8e) by DM6PR11CA0043.outlook.office365.com
 (2603:10b6:5:14c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 17:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 17:58:39 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 11:58:35 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 5/8] cpufreq: amd_pstate: implement amd pstate cpu online and offline callback
Date:   Tue, 8 Nov 2022 01:57:02 +0800
Message-ID: <20221107175705.2207842-6-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107175705.2207842-1-Perry.Yuan@amd.com>
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|CY5PR12MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d6d8a8-6771-4790-aaf2-08dac0e9b32e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hjMvCS0r3B4awqO2g7vaIO7oswrW1LT848StjxXNyTiW8BJrE3dN1QX/ZZbAlprK/uGgZs+yXJHbeNtkwbVq2pBhnJDERMZgwmyPBC70yDMiE4Q87DBjL5gvbvitc2NbrpnjSQOQfghj+CXsgUl5pz8xOAAdeHAaLTSh8TLpf7UaODCoTzx+WHp4CCJsObeEIfG3g7kbVWJUDmvnhhVn0MBGWwCz+ap5iS7XKrwROaNjjJNdBrKWbU+0EnAnhox0JFzPGTxtN2Zg6hV1a49X+vY9z8SDxgtyuHgk4W70/kO/VziHdrV0Ypdi7383OIsbhE6dBb5TxrTzW/934nkWH15wqkJrSDLZPkpdQ42RnM/4SmFLEv0NZlcYbIxiBejRYw/is9B2mdVhknB1qyErzuCEm2Fbgcx8qEuR1uW7hQiXItA+2E7HBJOAU8pIfh62+ncRjWSEXKt8n1AjxBUIjwbpicmPr0qOjOaP11US3/GebO7Q3Hgxy2s0PrTb30WPTaoDAIEDZRUfz0t5pAeGr2FLraQn4E6QlTebOG8c1/86UxWZpbqCNAVRpOdsaEdQ5Gc5q7j/1E1Qkm9jFEayz+mV+ESagRUB6gG/LV4kLXRkSVcXFJl4iLttY9JE7M+vmRwGhh5c4cV5pprDEO6v3jlXH1gNTLBEg6DlBvsq63oZZyUAGvPtpyQtxlgkpr79KayOGvvaHT8IEy9GregepurZlqFm7U/N7xBsUuOa4oQPiZ7fW3D+B9BncXAwEBxA71qmIM5T25VsCqaQf7WaFoU7PSHzqKTSypUbFOcHaJQQ8KE7iAmthb60uQ9QCkxm4nkILYQN+9tUh+yUwEUWgQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(40480700001)(36756003)(36860700001)(86362001)(5660300002)(356005)(2906002)(81166007)(83380400001)(426003)(2616005)(478600001)(1076003)(186003)(110136005)(316002)(26005)(336012)(82740400003)(54906003)(40460700003)(16526019)(47076005)(8676002)(4326008)(8936002)(41300700001)(70586007)(70206006)(6666004)(82310400005)(7696005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:58:39.1814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d6d8a8-6771-4790-aaf2-08dac0e9b32e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6382
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds online and offline driver callback support to allow cpu cores go
offline and help to restore the previous working states when core goes
back online later for EPP driver mode.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 89 ++++++++++++++++++++++++++++++++++++
 include/linux/amd-pstate.h   |  1 +
 2 files changed, 90 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index eb82bc6a7f66..6ce9fca0a128 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1195,6 +1195,93 @@ static int amd_pstate_epp_set_policy(struct cpufreq_policy *policy)
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
@@ -1229,6 +1316,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
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

