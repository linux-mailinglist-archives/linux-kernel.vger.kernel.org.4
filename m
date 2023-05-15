Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB10702B9D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241438AbjEOLiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241362AbjEOLgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:36:10 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6AE1BD8;
        Mon, 15 May 2023 04:35:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgeWeAJb/WU4GjP22xUI4uv/G5X+yrzKLvz3+iatpj76URMG7r/Mgt4vt6hXmJCUQID9WpeN2Qr1CCEpL6zwMHNS/3vHf5WytcQwrxy9tjjfF3uzVVoRiEvf1T9+5Xh7q/hBcDVa1FML6qpSFvssiTywVB5oREkqnRY5KDUFpN/oqacSafkHT4uJ04mhwoCQmOXbCUl0MT07mwXp+qieVwcF8pS5yqKWd3US+0VIJt/dpXnbwrppFwRcsp9Sn5Kqi5C1qLFiENiaCpbwUwp28ofhZEBx42zDyli6EuN/YjpY1x89R4DXbRtgsCnnpJ3E+ZFrQEhMpcVu+zRLZP+0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxy456+bDyioAHl8rt+EmlAMD6U3zGwG379wUhNzEu0=;
 b=kFLpyksiIeuampFrY2O2Zvk13iC/jvfUbk8RRe2Vq/ocWsvHWJT0X0qrOjA7QZj06fpfM2t4yxKwn+p5logiCfpDHiGh82fl6ZisHEfmvsyZbUkw2JW4x+31oIP5TGSg9XR0jFFT5QhaPVo3sHDXDxv/zFs3YjX5JCwIYzSK32+6pOnvK/aZ5GKcZr7RJgu4uHaMwJOK7LnCUcthVmCVPfCVf2MpT15u/hIRZf6O47deTpNko2pucsavuMcWJcmbLBvgX6g99cQ0TmaNZZg9CjMkqBTt3kxjJ2agXdqlrGUMLWFRK5n4xtKwpP2Tw1NWdW58yBHSHXWfBAJgvwoYqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxy456+bDyioAHl8rt+EmlAMD6U3zGwG379wUhNzEu0=;
 b=5uDnffe/9PbVHs/KbceVfQ41k9xvV2CN4cnUgp6dDBrf3CWCsWlxdVZdXoAyM9IqV5s0PkZMiqh0VTxS9Hf+qZlki/wMtW2CmZ+D0O2wYRBKixnM+oFYXTTqMhaebeZpSO37VSAExJdU7RzzOFaOvwhRxy4WT1KCJmbad/0mxxM=
Received: from DS7PR05CA0078.namprd05.prod.outlook.com (2603:10b6:8:57::24) by
 SA1PR12MB7269.namprd12.prod.outlook.com (2603:10b6:806:2be::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.30; Mon, 15 May 2023 11:35:03 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::a2) by DS7PR05CA0078.outlook.office365.com
 (2603:10b6:8:57::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.15 via Frontend
 Transport; Mon, 15 May 2023 11:35:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 11:35:03 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 06:34:59 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gautham.shenoy@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v3 1/2] amd_pstate: Add ->fast_switch() callback
Date:   Mon, 15 May 2023 11:34:03 +0000
Message-ID: <20230515113404.4259-2-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230515113404.4259-1-wyes.karny@amd.com>
References: <20230515113404.4259-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT020:EE_|SA1PR12MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ed8674-d7d6-46a2-d7dc-08db55386c96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8UQw+BKGsCcFL8j7HWmbhPBKmtfGBWUq9m3QeKG3STAR3N+qtZGlfXb783RFdz6VbJHnCPsfKm4pmFbj8v/Vmp8x8YMchcgwde5vVKvWYjVu0s3G80dNOXpo59nbxfyaaWP8abibbNbZzybjyIb153XX3Ys8n0A2iigcC8wWeQPwS51PAFg4z9qVGCwsd+ecZo3/Xr1jCBWHBtGaU02IiKoBXgWuzhXzkLusCJG37rTxlUrhAPrC6lmJ1cmhsbiJqdoG/3rgJW7cD2WxuOKMXQHId4LqCB4SNse7y/wIEJt7a6mePWoCmfdTVVJagG2QdDacdNrYXMUVDvSniIDaEIbgcyii/zgQyjYYRXhGd0bCbufdrVGmLaUhwuE1NkfBNhdHDpYF0LV/SL0xu1zjwlQLKYXijV8cxHmcCfsWAMd2/6+88DAdDMf/daIRmz+9f3MwEOirbke6dxIeE6nYiXmCL6SKMMhIcRqiT1TaVYHXilUCcqv1HIlgwjj7N3e+bdx8fZQWZnd0AlZeX8G8ft4bLHMFzxf9biOFWaMxP+LbrLnRDJjuEpxIb4gJmvdN+sCjW1BwNE7R5bw8kj21IvKKhSM1McEQEzg3N7wuPmvX9zwLuCnPX4AMwxgIcF4aO011qGhF70CsbPSxUew1Qrs0fEEiIxQqb0pIC6yFvLHpvCRCGyy1kbAPa2pqMUK8V/FM8LaocnrA6uK8nRXjyddYO9ilB3UCRZlXb9K8Qbz/jipG7mZFSMPkX3zPRZ0eJ/Nq3khZEUQ5Kp5ePgCDZF1BpxSTbevTJcBaOFavX7Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(36756003)(110136005)(54906003)(40460700003)(478600001)(8936002)(8676002)(356005)(316002)(82740400003)(70206006)(70586007)(40480700001)(41300700001)(4326008)(44832011)(81166007)(5660300002)(2906002)(26005)(1076003)(16526019)(186003)(86362001)(36860700001)(47076005)(83380400001)(2616005)(426003)(336012)(7696005)(82310400005)(6666004)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 11:35:03.0630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ed8674-d7d6-46a2-d7dc-08db55386c96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7269
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

Schedutil normally calls the adjust_perf callback for drivers with
adjust_perf callback available and fast_switch_possible flag set.
However, when frequency invariance is disabled, schedutil tries to
invoke fast_switch. So, there is a chance of kernel crash if this
function pointer is not set. To protect against this scenario add
fast_switch callback in amd_pstate driver.

Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5a3d4aa0f45a..6cf875d94c41 100644
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
@@ -1309,6 +1331,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
+	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,
-- 
2.34.1

