Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55E76FCD39
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjEISGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjEISGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:06:06 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D866448D;
        Tue,  9 May 2023 11:06:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZYV2FYjw2GpCBd1XGDRLIgV/U5JCLWNq/6Bw0uJLthRhgO648TlcqO9NABDrYRMIEw8PNTBxqUpzhF+1gd5xcINHNCCEfUybY4F8XI80k5r8XMVyEoWpmnhfdgvuCsqcpGiHh3c08xlDj6dpJJdZuUQ1viY/JJSetsdDmtpjX3OVFp7w8Gu2SvSCDu8kHc+FlwOu2KBv8JPePee4SG6FDZ6hC/muFFKNPOYRTsOhVmGgWCKY6C1bo8EQNMm1hN/SPKvS9/kmnMm9yl3bFkx3VfPWxBI9ougCqilqU8zMtBcjTL7sVKW5vssRTvy/8VcIqZ7Puze6SxP6peg8xzLIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUp3YkeCTwRdescTIfzzWbX376iMRu3vChpGue1dJXc=;
 b=kdGlBqtQaBr29Rzk9iM4UyFzV+txNa6RpOF5HwRX3D1uaoWHulP1GqjF7ypdBG2ZcmEsSQ5f4v1FlvLouVbOYsA3xDtz8yvfjifZpT1QBLcDJR/p7TnR5psRJUADMMqpPiRy6hQKSF5K/871llcT2y5Qz0dtau57Xvat6AyefgH8TeNlfVo/zOqUwbXRkw3yihaKrgXY4YTqsxfQgXIOrbUJ3HCwIwJ2RoE6ybh2B0/qyMPV6xVZ8/llxy9NXCHTGTIeyW8A2MhnLtyg0MYPOjczFbXOQyt7F/2JHdakX3Or/i7Hvmo7840Yzs/F0hGaZbCT71z0mgYQ6TO/3PV6ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUp3YkeCTwRdescTIfzzWbX376iMRu3vChpGue1dJXc=;
 b=RrC0hFQuNLQQOeuKvuvHFu534g1j/I9kUzSm+0pCYmx/rc1j4rSot1GzcKKpxCv+3sMYXobfG8w8Kit+kY2g1eAIXBb+jzpL1DPG/BIT1v/gsPhO1ks1IicLOb9upiK1OLQzIpTeVMUCncAwEb9MqQ1Q7/agN2qPJKH2jl+erIw=
Received: from MW2PR2101CA0035.namprd21.prod.outlook.com (2603:10b6:302:1::48)
 by SJ2PR12MB8782.namprd12.prod.outlook.com (2603:10b6:a03:4d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 18:05:58 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::5f) by MW2PR2101CA0035.outlook.office365.com
 (2603:10b6:302:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.4 via Frontend
 Transport; Tue, 9 May 2023 18:05:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6363.33 via Frontend Transport; Tue, 9 May 2023 18:05:58 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 13:05:51 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <srinivas.pandruvada@linux.intel.com>,
        <lenb@kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <joel@joelfernandes.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Wyes Karny <wyes.karny@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH v2 1/2] cpufreq/schedutil: Remove fast_switch_possible flag if driver doesn't set fast_switch
Date:   Tue, 9 May 2023 18:05:02 +0000
Message-ID: <20230509180503.739208-2-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230509180503.739208-1-wyes.karny@amd.com>
References: <20230509180503.739208-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT021:EE_|SJ2PR12MB8782:EE_
X-MS-Office365-Filtering-Correlation-Id: eb994f30-98a3-426b-b077-08db50b80a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3CAFiV3kWOu0oQQl5o2SrskB3chFaLzLImpeKYRRfFrGE6T6VUr0I/twRGi/yZgqqIAR0Dtx5595Adjad6uIEzMYx40YwVGf7Bhl+5SrzQ5n7wdw9iKs5IiEVrWPvkAFs+n2KaDTljNXqG7f4JeX4e2wfPuw3n3vtlC/HYJ3vlp8TZQcI167RaL4PXEhJY5uiDWxDbSziJUjY9eAWyLZFHUBmfLQgtCEQ8fOT1lAr3LHEwl/C9G4Kn5CwOBikVbqPaqjBfyY4DVo4VT8odnsuJOwZht9t6Td8cv0JOfSPhjrFTr+IBER9o3nJ0DufDcAL/JtDzciSHVLUPXfNOiU/ilwLIe6+MWBoLECCImaxvU/pbJV/n38Gnrkd42j04ww7LStFWHV1d0K1FIo/CjDC8mY286sTwAMi3NXujuKeD+G7zcbpopisQtLUGUdDSj4QtQsKkcLHaDwUCKF60c0jltkltGagWI1w2lbUuLF0BtSoUySrnoAzPNWt9BjefjYJF7Lpce2eG2lt/o7/DZVEcjMKnKG+KesCrwFTYRHEAGC0AHxuwcIXKsc9vD07yHopcs4OG2hWnJdhovdbfunCifyVWi28MVriq/zCDc4SIOMwEGypND7icgOLSjOMfgQen5Tqcgtl7P9ZJaEO/oHgwFtkE1FWEElv3scLL6YirmMu0209FT7KzIW8IIF7vkdx1mNAbYQPb8bASNL+LyB0mBAablCLO/rc37n+POo+fP98jc+V7wzAyurEzN+LWzlCp7YMSQbvkgeIfPq7IgmUFqODbJM7nFQluiFJedsFR0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(16526019)(81166007)(356005)(478600001)(7696005)(110136005)(54906003)(8936002)(44832011)(7416002)(86362001)(70586007)(70206006)(82310400005)(4326008)(6666004)(316002)(8676002)(41300700001)(40480700001)(26005)(2616005)(336012)(47076005)(83380400001)(82740400003)(186003)(1076003)(2906002)(40460700003)(36756003)(426003)(36860700001)(5660300002)(2101003)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 18:05:58.3175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb994f30-98a3-426b-b077-08db50b80a91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8782
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The set value of `fast_switch_enabled` indicates that fast_switch
callback is set. For some drivers such as amd_pstate and intel_pstate,
the adjust_perf callback is used but it still sets
`fast_switch_possible` flag. This is because this flag also decides
whether schedutil governor selects adjust_perf function for frequency
update. This condition in the schedutil governor forces the scaling
driver to set the `fast_switch_possible` flag.

Remove `fast_switch_enabled` check when schedutil decides to select
adjust_perf function for frequency update. Thus removing this drivers
are now free to remove `fast_switch_possible` flag if they don't use
fast_switch callback.

This issue becomes apparent when aperf/mperf overflow occurs.  When this
happens, kernel disables frequency invariance calculation which causes
schedutil to fallback to sugov_update_single_freq which currently relies
on the fast_switch callback.

Normal flow:
  sugov_update_single_perf
    cpufreq_driver_adjust_perf
      cpufreq_driver->adjust_perf

Error case flow:
  sugov_update_single_perf
    sugov_update_single_freq  <-- This is chosen because the freq invariant is disabled due to aperf/mperf overflow
      cpufreq_driver_fast_switch
         cpufreq_driver->fast_switch <-- Here NULL pointer dereference is happening, because fast_switch is not set

This change fixes this NULL pointer dereference issue.

Fixes: a61dec744745 ("cpufreq: schedutil: Avoid missing updates for one-CPU policies")
Signed-off-by: Wyes Karny <wyes.karny@amd.com>

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/cpufreq/amd-pstate.c     | 10 +++++++---
 drivers/cpufreq/cpufreq.c        | 20 +++++++++++++++++++-
 drivers/cpufreq/intel_pstate.c   |  3 +--
 include/linux/cpufreq.h          |  1 +
 kernel/sched/cpufreq_schedutil.c |  2 +-
 5 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5a3d4aa0f45a..007bfe724a6a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -671,8 +671,14 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* It will be updated by governor */
 	policy->cur = policy->cpuinfo.min_freq;
 
+	/**
+	 * For shared memory system frequency update takes time that's why
+	 * do this in deferred kthread context.
+	 */
 	if (boot_cpu_has(X86_FEATURE_CPPC))
-		policy->fast_switch_possible = true;
+		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
+	else
+		current_pstate_driver->adjust_perf = NULL;
 
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
 				   FREQ_QOS_MIN, policy->cpuinfo.min_freq);
@@ -697,8 +703,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	policy->driver_data = cpudata;
 
 	amd_pstate_boost_init(cpudata);
-	if (!current_pstate_driver->adjust_perf)
-		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
 
 	return 0;
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6b52ebe5a890..366747012104 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -501,6 +501,13 @@ void cpufreq_enable_fast_switch(struct cpufreq_policy *policy)
 	if (!policy->fast_switch_possible)
 		return;
 
+	/**
+	 * It's not expected driver's fast_switch callback is not set
+	 * even fast_switch_possible is true.
+	 */
+	if (WARN_ON(!cpufreq_driver_has_fast_switch()))
+		return;
+
 	mutex_lock(&cpufreq_fast_switch_lock);
 	if (cpufreq_fast_switch_count >= 0) {
 		cpufreq_fast_switch_count++;
@@ -2143,6 +2150,17 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
 
+/**
+ * cpufreq_driver_has_fast_switch - Check "fast switch" callback.
+ *
+ * Return 'true' if the ->fast_switch callback is present for the
+ * current driver or 'false' otherwise.
+ */
+bool cpufreq_driver_has_fast_switch(void)
+{
+	return !!cpufreq_driver->fast_switch;
+}
+
 /**
  * cpufreq_driver_adjust_perf - Adjust CPU performance level in one go.
  * @cpu: Target CPU.
@@ -2157,7 +2175,7 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
  * and it is expected to select a suitable performance level equal to or above
  * @min_perf and preferably equal to or below @target_perf.
  *
- * This function must not be called if policy->fast_switch_enabled is unset.
+ * By default this function takes the fast frequency update path.
  *
  * Governors calling this function must guarantee that it will never be invoked
  * twice in parallel for the same CPU and that it will never be called in
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 2548ec92faa2..007893514c87 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2698,8 +2698,6 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
 
 	intel_pstate_init_acpi_perf_limits(policy);
 
-	policy->fast_switch_possible = true;
-
 	return 0;
 }
 
@@ -2955,6 +2953,7 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	if (ret)
 		return ret;
 
+	policy->fast_switch_possible = true;
 	policy->cpuinfo.transition_latency = INTEL_CPUFREQ_TRANSITION_LATENCY;
 	/* This reflects the intel_pstate_get_cpu_pstates() setting. */
 	policy->cur = policy->cpuinfo.min_freq;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 26e2eb399484..7a32cfca26c9 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -604,6 +604,7 @@ struct cpufreq_governor {
 /* Pass a target to the cpufreq driver */
 unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq);
+bool cpufreq_driver_has_fast_switch(void);
 void cpufreq_driver_adjust_perf(unsigned int cpu,
 				unsigned long min_perf,
 				unsigned long target_perf,
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e3211455b203..f993ecf731a9 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -776,7 +776,7 @@ static int sugov_start(struct cpufreq_policy *policy)
 
 	if (policy_is_shared(policy))
 		uu = sugov_update_shared;
-	else if (policy->fast_switch_enabled && cpufreq_driver_has_adjust_perf())
+	else if (cpufreq_driver_has_adjust_perf())
 		uu = sugov_update_single_perf;
 	else
 		uu = sugov_update_single_freq;
-- 
2.34.1

