Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046A3706E2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjEQQ3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEQQ3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:29:21 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92238682;
        Wed, 17 May 2023 09:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8u3QsfiXEFaULDZhbLp0zGFzK1afA2Iw0vkNHvo18xQoX2PtYnqH26PEBszhzUHtejiHJnqCJxAWj/bYYPeWrLhLZFpGHzTzN1ERDCw9iaWgNUuTsSWu8FONW+dAlSJkHT7GBVOofQGiJ6PHnytEbYarA/Bz/rlSeUxCLXWqkDj6xSaKMOEDf10MyKwFV7+42mpqbfl5eVq1MxFmt3SnFhvnM4PW7XmxZDSTqkbg4WiL62yFjxe5yjy+zFEd8+XypZ6lLiY4IXVTkumDuO5nR7tAhjX4CeGCDyB+6aelN05nVzoXyGI/znGU1RRZ+hZS/D3Z/9fsnW19fYfiTxH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYc4SnWDZAlkPdAhitrjJxoj6jNPhcC968l940yDx3M=;
 b=QS6Vu4fAgQuIz0o8ArRMGYM9QMMFCIs53s6QmEZOrySnXkHfETksTOKfzJgxmbWPd1DpAu0lnt8QBRtN28RrJ5hKbnUQ0D1I3lSvmV/6iVGmrZdKehnvG/zw54paNIBNb0Twk6nSFBrTfRxLfqhqOmZwtCjXHGKh7bvM3xBzv7uRJZOlnJDQw6TD5EYvcNSiCIouYEC/iHm8/t/oWEZgpz6kOMwnjypI6k71ueWMTRn1VQNhXRmCZfpYNT7pYUT8QWaBUbd4Np6Q5mGfxbTTkRRRea30F2OFdkWm7Kwd2BPzVZGVwft2LNM7TQK2Le0Ipk/5/ot83fLX89PUpWLxoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYc4SnWDZAlkPdAhitrjJxoj6jNPhcC968l940yDx3M=;
 b=XhibRrJVP7BwH84HhCxC+20cH9OP8/1mIt0zIPVyCUGxLUqXnEQ+XVHaf88sbtZ/Lx8+NweSMUy+9qUkdxy6TRMKBCG1+I2kwgUCiAO5js/c1Xq5nW+ZeMaVTQfM2TGHKlvY0Bixj59fZQq6nzhSn32o/1zyMIuKr9tQjsq8RU0=
Received: from BN9PR03CA0904.namprd03.prod.outlook.com (2603:10b6:408:107::9)
 by PH0PR12MB8007.namprd12.prod.outlook.com (2603:10b6:510:28e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 16:29:17 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::35) by BN9PR03CA0904.outlook.office365.com
 (2603:10b6:408:107::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Wed, 17 May 2023 16:29:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.17 via Frontend Transport; Wed, 17 May 2023 16:29:16 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 11:29:09 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gautham.shenoy@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH v4 1/3] amd_pstate: Add ->fast_switch() callback
Date:   Wed, 17 May 2023 16:28:15 +0000
Message-ID: <20230517162817.8538-2-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517162817.8538-1-wyes.karny@amd.com>
References: <20230517162817.8538-1-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|PH0PR12MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: a06b4506-44b0-4619-4290-08db56f3dbc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dShs4QRcq1lJP9QD88aZR/gMx/yRy2Utaure9m+8nDkCWyh00u4ELYT4qlyGVp4a8XZ60CcoPkm1ordzZHWa82X1QHthFbWguD9NpG+pvapFckT2656DWmIrEL706E9Xgx3yw6/a/v6hLEDgGR/3/l1+fnG8HRs5GG6CUDQsdzthufMl7mdKzsDCIWIiHOG6U5id7+Sueuy9kg/1ryc0ctA2RI9Z4pOue+1AVAmA978wtztWJbkImAO+PrdA8+uPoj4tgcw7Bf5ah0U/Ifv4qX0uxgaNSH9l6s8snzkPRdHIGWGHXwqWiUNbn+q6bVXdVQLdzFSNo8unX3s5VFdPnX6huMIxA241Q6jBRKltrNuh/GQlg5FNB7ksL3+k6+CPXHJbl+4F/qTV1tyCKMQHDJXuQmDVbUI9nCf2NL1ohpdakBcIOa4ez3+Yg/TMV9rVXv8ylLYDAn7FVx/u8jEIQHbDcgjkFyBwMB49LyLQ3/kzmaA7Rpfi3jh9Bi+D4GfTCAhnhYNOcKFlmFi+PEzifLQ9UUaXq8DZFo5d7lnhhmrqiyAsAzHEcOYtwTZeZ1FQfqpL3tL9Hh2Lrv5yBA41j2gmmFIgWcfrS8xONIUgTovZVCW4f/EVR5hyt6YOSfiDOwtz+sl2L/yX3RuF2vTvWrIlRrK/LSYXAcf/PVzJxNT+afyCD4SRLHEeAZ6V7rh7zv2KAGkyIjzv1PYP928Dhb3LwAiJ6L6mFLz9jqk3bQoeR0sMDBd3rwbjK+yIlCL8wOTs7ZQjfgND0GPzStQpBOV0WeFcso3LkxVxv02CU1s=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(5660300002)(8936002)(86362001)(44832011)(336012)(426003)(8676002)(2616005)(82310400005)(47076005)(36860700001)(83380400001)(81166007)(82740400003)(1076003)(356005)(26005)(186003)(16526019)(40460700003)(41300700001)(7696005)(478600001)(6666004)(110136005)(316002)(40480700001)(70206006)(54906003)(70586007)(36756003)(4326008)(2906002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 16:29:16.6924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a06b4506-44b0-4619-4290-08db56f3dbc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8007
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
invoke fast_switch. So, there is a chance of kernel crash if this
function pointer is not set. To protect against this scenario add
fast_switch callback to amd_pstate driver.

Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5a3d4aa0f45a..45711fc0a856 100644
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
@@ -715,6 +737,7 @@ static int amd_pstate_cpu_exit(struct cpufreq_policy *policy)
 
 	freq_qos_remove_request(&cpudata->req[1]);
 	freq_qos_remove_request(&cpudata->req[0]);
+	policy->fast_switch_possible = false;
 	kfree(cpudata);
 
 	return 0;
@@ -1309,6 +1332,7 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
 	.target		= amd_pstate_target,
+	.fast_switch    = amd_pstate_fast_switch,
 	.init		= amd_pstate_cpu_init,
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,
-- 
2.34.1

