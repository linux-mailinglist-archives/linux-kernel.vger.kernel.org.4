Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155A86FCD3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjEISGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjEISGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:06:36 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD66D49C5;
        Tue,  9 May 2023 11:06:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKf2cKU+ppTAeW2Xyx7Efby5ltoA4QRl+RPjJue4mP2j1c9kflCb+NTKDMajdhXz0hrxAwUZHl1IsB8QzMxn/U2cmpO0C3zRs+ukR+7AE8fO1U+jUJco3WlAomtuyINW7EDUw+g6YSugbigDH2mn8mR3wmKE/i65EcQbtQ6FtaHWumHV3FZLBQXJYGXIsZM17hH2+nImM1k0qDNcixMtVW6lQuPy4EQJiTn/xIIvprdvmeyFpO9BirfIYgWE2ijtZK5xGOfDNw8VDWj0NJYBMnKVYj31RgSmJJloJs1WJ5Ii3xn8XCbYBy8t6tTgzoiGOistASK2ipEZh8R9IJtOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ba9Oypk3aH9v6k+TDMemlEBm2+m6dHmsCJJ+RMXFFfg=;
 b=LfGDxcRzKazo9vm8JRbQS+ky14yTaXOmHeqqB4sW78wRvpb0Cp8oaG+DFRl0RvqKG7TQ2b4Z8D4zc+SH6+1eyQKiNEeH9Cb//bW0OQBcM6Jx9qvzl0Y6PP0NSSsXWq+2YLpB5S5Ma4WlizDOgBj+XHwx7sLPd6bKJLy55SnjMh2vhnP2rqMvsOZRQ5deN4kJitQWpznt3zR2aXuCwKskUsnRAjYs1eM1T+nOPwYhEMaom9pHb6beNQ3Dr5V6smFa0BIElIFBfJ/0nSQk5jYXR1sCqwTn5TJ7nDXDKXfftl3GJMGdZJYM0gPWFkQiIW40nYlxDtiXE/MNCXg7LRAaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ba9Oypk3aH9v6k+TDMemlEBm2+m6dHmsCJJ+RMXFFfg=;
 b=gpr+ZEnbPhhvOCnSEP/80L1oY+ZW7eCNAO60XlnqSBliszUMY68KbBEKwCQzJrcVEZ5M4KSwGgxqtQ578IXJD/TEa/WfWg0tj8gRUgAl8C8dATOnQ81YHZxMCb5czmQ9uQUMa0lLumJpOzxajbjZoyFR5193lgmbcAozUmfKY4s=
Received: from MW4P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::13)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 18:06:24 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::41) by MW4P221CA0008.outlook.office365.com
 (2603:10b6:303:8b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 18:06:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 18:06:22 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 13:06:17 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <srinivas.pandruvada@linux.intel.com>,
        <lenb@kernel.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <joel@joelfernandes.org>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v2 2/2] amd_pstate: Add ->fast_switch() callback
Date:   Tue, 9 May 2023 18:05:03 +0000
Message-ID: <20230509180503.739208-3-wyes.karny@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f82251-35b1-4c73-4fff-08db50b81930
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W+2LrWN+24oiALBA0qEP/WZuS6e5ZCewvtA0LWucSekFjICUWborex//FU/XxXj8Vyktg/JHBhHsCCr979HN4ig/0pITIyT2TD6M7xlZi16gzLfyfebtDeCWSVeb0wiREGZKtV6/+IuH2xZ7b8kEraF/OkP29ZTbXUx8zOlnbVLvgj47X547ymc0FCn/oUXocEkTWXkTjicD+U70a8bT7DV1wTGJZVv4/igyh/CH8YsfoFzvcJtWv3RtgWnWHAUJ+2YKKb39nUzk9Fs/auXo5yHJ622ChJh0PFg7Kw87x9l1rkxSlF6SZq6KJWUqWqHh5tJbMRnbwUmYdKHIVbmIMeQ6DOAEio3QVkBLke0cMkxCkjKxEGRz6/t764WVKRjBeFF2CPJNz6ML2mnzf8QHLBBkIrDU0YdMcXYLDqv9JQkitD/TiNIHIioMFzFU+2yAmPKFI6I8hU74TiPW1sDd5v2kO0FeKlpPEQA1JXy4xcrJ/Gx/151yJOds2wixcxHZGnRxY8w8o91HRenrlzDvraagHc9oX9m02Ak2F2/9nVVhhQ8e1expFJBGxFDHWWGs9KuXJk67ZOu5F5jUdJfYf+3+cuLtcYHb3oY6ggtEYWi/wDm3Cc/4UXg4IK9r1mZfa+Kk2m6kKrfg6qAtVrCFCDxwTgxniGj5u/miitcnp1cFzLgA5QEHf5v5S9snVMH7hASooVers5arR3705KVWARQXNToPNR8G1MzRCkuk8REfLCYZLqwzytK/DRmTd+44
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(40470700004)(36840700001)(46966006)(426003)(83380400001)(336012)(186003)(16526019)(2616005)(2906002)(40460700003)(36756003)(82310400005)(86362001)(356005)(81166007)(82740400003)(36860700001)(47076005)(40480700001)(5660300002)(8676002)(8936002)(7416002)(44832011)(70206006)(70586007)(4326008)(478600001)(41300700001)(7696005)(26005)(6666004)(316002)(54906003)(1076003)(110136005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 18:06:22.8295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f82251-35b1-4c73-4fff-08db50b81930
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
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

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

Schedutil normally calls the adjust_perf callback for drivers with
adjust_perf callback available and fast_switch_possible flag set.
However, when frequency invariance is disabled and schedutil tries to
invoke fast_switch, and that callback is NULL, it schedules a kthread to
invoke the target() callback, which could slow down the frequency
update.

Prevent the frequency update slow down by implementing the fast_switch
callback for amd_pstate.

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 40 ++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 007bfe724a6a..d5758b67b6f3 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -444,9 +444,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
-static int amd_pstate_target(struct cpufreq_policy *policy,
-			     unsigned int target_freq,
-			     unsigned int relation)
+static int amd_pstate_update_freq(struct cpufreq_policy *policy,
+				  unsigned int target_freq, bool fast_switch)
 {
 	struct cpufreq_freqs freqs;
 	struct amd_cpudata *cpudata = policy->driver_data;
@@ -465,14 +464,37 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
 	des_perf = DIV_ROUND_CLOSEST(target_freq * cap_perf,
 				     cpudata->max_freq);
 
-	cpufreq_freq_transition_begin(policy, &freqs);
+	WARN_ON(fast_switch && !policy->fast_switch_enabled);
+	/*
+	 * If fast_switch is desired, then there aren't any registered
+	 * transition notifiers. See comment for
+	 * cpufreq_enable_fast_switch().
+	 */
+	if (!fast_switch)
+		cpufreq_freq_transition_begin(policy, &freqs);
+
 	amd_pstate_update(cpudata, min_perf, des_perf,
-			  max_perf, false, policy->governor->flags);
-	cpufreq_freq_transition_end(policy, &freqs, false);
+			max_perf, fast_switch, policy->governor->flags);
+
+	if (!fast_switch)
+		cpufreq_freq_transition_end(policy, &freqs, false);
 
 	return 0;
 }
 
+static int amd_pstate_target(struct cpufreq_policy *policy,
+			     unsigned int target_freq,
+			     unsigned int relation)
+{
+	return amd_pstate_update_freq(policy, target_freq, false);
+}
+
+static unsigned int amd_pstate_fast_switch(struct cpufreq_policy *policy,
+				  unsigned int target_freq)
+{
+	return amd_pstate_update_freq(policy, target_freq, true);
+}
+
 static void amd_pstate_adjust_perf(unsigned int cpu,
 				   unsigned long _min_perf,
 				   unsigned long target_perf,
@@ -675,9 +697,10 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	 * For shared memory system frequency update takes time that's why
 	 * do this in deferred kthread context.
 	 */
-	if (boot_cpu_has(X86_FEATURE_CPPC))
+	if (boot_cpu_has(X86_FEATURE_CPPC)) {
 		current_pstate_driver->adjust_perf = amd_pstate_adjust_perf;
-	else
+		policy->fast_switch_possible = true;
+	} else
 		current_pstate_driver->adjust_perf = NULL;
 
 	ret = freq_qos_add_request(&policy->constraints, &cpudata->req[0],
@@ -1313,6 +1336,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
+	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,
-- 
2.34.1

