Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957A26DC563
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjDJJyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjDJJyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:54:15 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CEE2697;
        Mon, 10 Apr 2023 02:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idQva2XK1FyZH3KdUFkp8hTV6xOLb5ams/pnb8zvKmU9rVOUqixVFSgLSEbmn7pg/B3yhsxB9mJzP2cAgcDrnlfppJoWVMWrybCgEpYxyiHrwBrYB3D5rdQtGKN8QFrucfiZiP5VGhGO2LmW9/Sq8hGYz8/lwsM5u6evfIPOKAiCoHe/hvzXzwU/hqluUFMmBQdvD47aXytP9DGBbZ+Q0OGH6xF+/msHTNYr/HDrcv9qBz1JtELNOdgFbjrY5iAbOOKFWuRci9k8g66OUAt+pprhaRp+BNyVqX3RaWGh+/UnXTiH2H8Pcmy8gjGf+2VcvIKlyXEfzQMhj/0bwHs6wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVBp+WOwcNwhJTjY12nhx2kQyTcaRuI6EdTm7u/V+QU=;
 b=c1Yfh93x7OPguuQTO403inKPDVqp7Q94ZY28vG2F6RRVM34hEs7r2wym2zVfzFbdivFukfPmdKZvgPuP90ODpoMcACRQ3O2jGcNvGTJ4ydxANX3niVvV61HuLiQ/ce0f8yuqwt/t9kbIk2vzAGAAvqSjdVBJpQjvs90EmoyoLH2mLiDzn8v9he4DoBHvSK1eIf5OqPh/sZ74rq/rwWojgBfoPTaSekCR1fG6tr7V7PrckHKZ99uqq5/eWiHgzaNl+/tQ4ZPdQySnUTY3uujBh/F+LDy9jAwB4p56JPjeSQaZNsKgfANcZbq8vhK6NXorP2FNEbSX4ubxBZWe3MoyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVBp+WOwcNwhJTjY12nhx2kQyTcaRuI6EdTm7u/V+QU=;
 b=AXFsx2mVYJ3nGedKP/g5URCwKIKZR+oIVkr5DnTqpedmkb5dhx2t46otPrGa0+f5plUt+Mm0hstkPUxvKKflNJd5UIgXVvzwSqLROZczlg2s1uMTrtmM0HvBOdbnzHtcgspExtn8S6aQNmxN705F05sHEjDwKwE5tlTLzv3Kh8s=
Received: from MW4PR02CA0024.namprd02.prod.outlook.com (2603:10b6:303:16d::9)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 09:54:10 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::2a) by MW4PR02CA0024.outlook.office365.com
 (2603:10b6:303:16d::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 09:54:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.21 via Frontend Transport; Mon, 10 Apr 2023 09:54:09 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 10 Apr
 2023 04:54:01 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <joel@joelfernandes.org>,
        <gautham.shenoy@amd.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH 2/2] amd_pstate: Add ->fast_switch() callback
Date:   Mon, 10 Apr 2023 09:53:39 +0000
Message-ID: <20230410095339.14923-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230410095045.14872-1-wyes.karny@amd.com>
References: <20230410095045.14872-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: d590cda1-7a4c-48a4-3ea4-08db39a98833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DcTzcL+VUuiFmriZQVtctQzRCLS1DxMBCiTHzRp3F67VW9+vchq8ny7ogJNZ82TJFYEPBlzy+zK2t6Wgm01GwIpoWhE43x0sQEFlYlSQkBbDnymqqWfoHO/UHwn21vYRJMW+EeDpVAMzTqmy5ckr5sMrGm6kqNsbXj9juUAGqgXd345kSDNPpLeigZbfn62IRG+TbwWgYb3sFNAM2ULJwhV6eZxw8gv9B0G2TDH/isKajBJIuGgZAFtSdYrH1SAfi1KVlp9e1SdlW2Fm0CB7IeF3tmlh7Riw62RsXoncfd/T+MXldGVImCjBzsS9072HMuFkq/kp5g3u11UUneLK2P5W1ooJ6Im9vpJ45rtx1oUd+QV1WoY9r3uKXW+J6d9Te146g7N1Gm1/ZpjDUoSudKfxs+3HD+zXwjJd7S65OnQZSlPwbj3GibLluSu+fRMCLvCuOpc4f5Y4D4N1JzT1HkcZ9C4kqmHEGcwNnnauh3k4J/E49gCOK3mfxnanhT7ril4tn+4GdVjYs3Mp5uUbZBgbhA6WEE8lFhtoREq6PKffsoX+E+7h+PQu4kn+uI7p75S0Q2GygumPJ7YVMI4ljEipjFMenBZ/Z/CeBe1uHxiTZZGVvQbEMw9gRWx8uclb+59y2cHn4qohzWhPOCHBezZUFn4S1SGFruiWiDcbVoTpBIBVya43J0bNIzndU1yt3hcvwyjUxFZ1dNUSgZYlDYRbSoq3du6Kw9WAme8erqrk76Kj0+FByg8iHkYWa8BM
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(8936002)(6666004)(7696005)(40480700001)(40460700003)(44832011)(7416002)(5660300002)(86362001)(70206006)(8676002)(70586007)(4326008)(478600001)(110136005)(316002)(82310400005)(36860700001)(82740400003)(356005)(54906003)(81166007)(2906002)(1076003)(26005)(2616005)(83380400001)(47076005)(426003)(336012)(186003)(41300700001)(36756003)(16526019)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 09:54:09.8810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d590cda1-7a4c-48a4-3ea4-08db39a98833
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/cpufreq/amd-pstate.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 73c7643b2697..b3d594b35c65 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -422,9 +422,8 @@ static int amd_pstate_verify(struct cpufreq_policy_data *policy)
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
@@ -443,14 +442,35 @@ static int amd_pstate_target(struct cpufreq_policy *policy,
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
 	amd_pstate_update(cpudata, min_perf, des_perf,
-			  max_perf, false);
-	cpufreq_freq_transition_end(policy, &freqs, false);
+			  max_perf, fast_switch);
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
@@ -1228,6 +1248,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
+	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,
-- 
2.34.1

