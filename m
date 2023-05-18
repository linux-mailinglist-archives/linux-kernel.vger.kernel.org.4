Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C0C7079FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 07:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjERF6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 01:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjERF6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 01:58:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20615.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::615])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11A72D64;
        Wed, 17 May 2023 22:58:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wc6Lxvcqouwa+p6ZvgdyrBmwKoOGO0BB0dTylxhfzY+y5Kih6eLq1RIQmzgQupfaEuKg/mxMA1FgJlN0+PihmP+XXQQ5UJ6IFj0yYUPyJHH1AzBWTNBp9x9SqCPa3GM4/XQ0VD6lFFTjSBdOW1bAIOuySs45ZtCQbzBTwS28LpEeqc6lhxahHJ+nh7V3FGPfpS34AetB83dKuWSuxZvmUiypGWFojvZ2IafzGmjS0e5BcNoCVu9O0T48dYMy344MXi9FIbAB8+zLTgdrngOdHvV0EUy43CRu4hPcEVrwdA4zUVuyhdWiNCJSagzYNlsQEnZnYCm4WqJw7W1ttXv+hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6WR2DgCXW3Kl6glbwSMRgvrsiAWS+FCAwJEX9Pr1jM=;
 b=SYHoDLIKEcExv76emApmlUpTq2D9F1ysZ68ikIB/sGeX7GxfiMBR7XmffHM5aCznJVumpn6lFETQNEoDRp1M+RIAIo6mYJ9A4Rc5bEnFfi3xFXEOlbxJJkKWuGZ8ZW/2uTJrFACWguTpwrkwF8s2l82FtCp3Pq30+etcXs+Vb7RFO5tD6mFFAP1SgTzHoWV4twfrGKlws0vOS0d4v0ePSJvtpesvANfhKwWr2SC9lIdHunTl41ZDU9c89fbJCiNJ++YDrHRkfq4pzBFmSXBRYN/dLbJ7JKrY5mbuGWHK4ePNHgFoaPyYnVRNovlsGYechFZLVjbrkik41oM2CM/7KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6WR2DgCXW3Kl6glbwSMRgvrsiAWS+FCAwJEX9Pr1jM=;
 b=XbGVRw3IYGJic/A8zKn29h91B4kzbC6uatWTMta2AzoOYs1cs2FMXFY3UUrkppmyjnoC+zIVkX2lZTdFsr4GsB+ReUvqe8UMhNi7OGjgGJN2+YVaChLEl02suvQBLglNRSZJQG6py7eRM3AX6wlN3jcOwHErvagxW1nDOTXsZEA=
Received: from DM6PR08CA0004.namprd08.prod.outlook.com (2603:10b6:5:80::17) by
 PH0PR12MB7907.namprd12.prod.outlook.com (2603:10b6:510:28d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Thu, 18 May
 2023 05:58:39 +0000
Received: from DS1PEPF0000E634.namprd02.prod.outlook.com
 (2603:10b6:5:80:cafe::b2) by DM6PR08CA0004.outlook.office365.com
 (2603:10b6:5:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19 via Frontend
 Transport; Thu, 18 May 2023 05:58:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E634.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.11 via Frontend Transport; Thu, 18 May 2023 05:58:39 +0000
Received: from beas.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 00:58:33 -0500
From:   Wyes Karny <wyes.karny@amd.com>
To:     <ray.huang@amd.com>, <rafael@kernel.org>, <viresh.kumar@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gautham.shenoy@amd.com>, Wyes Karny <wyes.karny@amd.com>
Subject: [PATCH] cpufreq: amd-pstate: Update policy->cur for adjust perf
Date:   Thu, 18 May 2023 05:58:19 +0000
Message-ID: <20230518055819.71585-1-wyes.karny@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E634:EE_|PH0PR12MB7907:EE_
X-MS-Office365-Filtering-Correlation-Id: 12dd08a7-dd9d-48b8-77e3-08db5764ed3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 472hIJNPxvPRqF3vW2P54tHEU/F5PEKDcM1qKTgOSba7cvS7l1Peopq0HvCt3cz0xSx/s4OceiHxt2tIlXTz15tgUj7XN8p1eBsEmm9HC3gtt7mn5y82pkORTwAq72DyJuMplHmE03xIN/DHinqsL9A92qzMlvoWZnUtLCgxXpgX282HXaSHyKkTN4r2rLgiiix6zN71tVJxcwYkms20lGbPtTAayDemdDSWnbXxDr87SOanua076VgA4mRj3EugSDcGar6Q+KZFDuleiu2q2hnMbt+mRidxXn6G6pMSpttV9sJbvqnmklLuZh5VKj0iBQifbxcaevWFdqf4IxuPS4CqGCXXg0SSIvz1fwDNwZjxuLGIWsUgm1drTo5cAf9krlQGbfwuo7CL9uhElV7l81jdQM2ju9h3seotvx+QDT6TpKP0CJqJsSy6MkMbrzf/KXWg6lM/zc0C+y22Cbi1XsJn07x8AcBoRG+fJq1Ca0qCnhZqqCQOT2stbAwVbOVeNE4tuhFT2piJAzXikHLuAQg5q2JmlmY9iCCb0LSD6cMMwU3q/uBhnMliAgCNx2nBFUMRCk0g53ED6F3Nh/+O/9uILEuTJZhUcRFlqvzV/7n+8lkQ3/g1AJ/ENtmZRW4bF/Ef6hs/DpqlLDdZPUi/pAdQVJCGgTBT+qPddlPZZZOZzNwtVmHuq7cFD5ThueIF4/KpzyMmb35SQ2DsludWJa9xAUvFnrmct3zUrDhJqRV/WYO6cudLk1rtu05pS/tAK7rW17jc+6Kf+Dczf5BHsL8I3fBGMxeywxxfTK+b/dY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(4326008)(47076005)(70586007)(70206006)(110136005)(316002)(54906003)(36756003)(86362001)(478600001)(7696005)(1076003)(186003)(336012)(16526019)(2616005)(426003)(83380400001)(36860700001)(6666004)(44832011)(8936002)(40480700001)(5660300002)(2906002)(15650500001)(81166007)(41300700001)(82310400005)(82740400003)(26005)(8676002)(356005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 05:58:39.0719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12dd08a7-dd9d-48b8-77e3-08db5764ed3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E634.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7907
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver should update policy->cur after updating the frequency.
Currently amd_pstate doesn't update policy->cur when `adjust_perf`
is used. Which causes /proc/cpuinfo to show wrong cpu frequency.
Fix this by updating policy->cur with correct frequency value in
adjust_perf function callback.

- Before the fix: (setting min freq to 1.5 MHz)

[root@amd]# cat /proc/cpuinfo | grep "cpu MHz" | sort | uniq --count
      1 cpu MHz         : 1777.016
      1 cpu MHz         : 1797.160
      1 cpu MHz         : 1797.270
    189 cpu MHz         : 400.000

- After the fix: (setting min freq to 1.5 MHz)

[root@amd]# cat /proc/cpuinfo | grep "cpu MHz" | sort | uniq --count
      1 cpu MHz         : 1753.353
      1 cpu MHz         : 1756.838
      1 cpu MHz         : 1776.466
      1 cpu MHz         : 1776.873
      1 cpu MHz         : 1777.308
      1 cpu MHz         : 1779.900
    183 cpu MHz         : 1805.231
      1 cpu MHz         : 1956.815
      1 cpu MHz         : 2246.203
      1 cpu MHz         : 2259.984

Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for AMD P-State")

Signed-off-by: Wyes Karny <wyes.karny@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 5a3d4aa0f45a..736dab69ba1e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -479,12 +479,14 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 				   unsigned long capacity)
 {
 	unsigned long max_perf, min_perf, des_perf,
-		      cap_perf, lowest_nonlinear_perf;
+		      cap_perf, lowest_nonlinear_perf, max_freq;
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	struct amd_cpudata *cpudata = policy->driver_data;
+	unsigned int target_freq;
 
 	cap_perf = READ_ONCE(cpudata->highest_perf);
 	lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
+	max_freq = READ_ONCE(cpudata->max_freq);
 
 	des_perf = cap_perf;
 	if (target_perf < capacity)
@@ -501,6 +503,10 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
 	if (max_perf < min_perf)
 		max_perf = min_perf;
 
+	des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
+	target_freq = div_u64(des_perf * max_freq, max_perf);
+	policy->cur = target_freq;
+
 	amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true,
 			policy->governor->flags);
 	cpufreq_cpu_put(policy);
-- 
2.34.1

