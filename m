Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9548F6248E7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiKJSAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbiKJR77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:59:59 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2083.outbound.protection.outlook.com [40.107.212.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FC64D5C2;
        Thu, 10 Nov 2022 09:59:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jf3rSWDOX/W/dM03s7VRmW97S93AV1zxRfrmeTUYRI5eK7L9wx6r36PR7umWgmEBBzBomMBurKVOTX1zKr1J4GYp8cxiFt66kGCJa9tETQcuYtfDcgqv2D8nKx49EXmefT43u7XLJWqIkj1Q+cGxiuKhQaqeEf1ymfpvX3NHGYoYW7CW6n468rE5vFsqfGp+UfYOVRzSgOgJfBMmJ2p+mG18epep/9xPNyMWWnoM/7dxs8JdmF5jM6kCsGl925cUsqBLYMedjY4r286cuJz4NUuKhoBuD5SLhjFDt1QdDuOjT9AWVGNwDP8AxEmoLd0KlqYBscpD1dpN8QbDcTF/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahoQ6TafYVsvKiCzN5J76aLP+KQBCq70Wep5Trl7hpQ=;
 b=Az9O+lEljWKloWY98dZtueafpP2n+t/eCqcUgK2IgJmLqXHYzxMgwZxyFqek4a4+fnY94H92NnUaa55NMi+WjDAXSJgcrCvAtQFhh7d4HD389O2YDls49dH4EyYzf+EYQxgLwgFTQSVKk77jzbTEZy9YDJWtJSREeeu7/1fK/NClfcuyQRzDoeF1GyeWyU1T40wEIGOnsIV6uiHEnGEvVs5Ij6v3sy1oXSy2X9RdnxBfAotvcgnmdJhYoZm07zSU6bN0fZ6i84TtUbGh5GNFOsuD3O/GbJylg2+Q6XnoWx71tdizHWIN9VswykD6V+WTqOHGxU1XfA9uXi+smHSC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahoQ6TafYVsvKiCzN5J76aLP+KQBCq70Wep5Trl7hpQ=;
 b=AHsbdfmAuT53/zMskiHO5L43ZpKKTK+9/pn8jX6NNd7adSuF47q+KHoUB0LJQv9+xbYOLS8CU9emII3ENk4QkPD6CpRCh01ysiQtqS2Tw6f6PH7xkPgu1EbVx/XDCstGo+qDi5UMDQaYY2TLSSD3sAv6tL0Iodpq24o0axM3h2g=
Received: from BN0PR02CA0055.namprd02.prod.outlook.com (2603:10b6:408:e5::30)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 17:59:38 +0000
Received: from BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::7d) by BN0PR02CA0055.outlook.office365.com
 (2603:10b6:408:e5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13 via Frontend
 Transport; Thu, 10 Nov 2022 17:59:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT107.mail.protection.outlook.com (10.13.176.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 17:59:37 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 11:59:30 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH v4 6/9] cpufreq: amd-pstate: implement suspend and resume callbacks
Date:   Fri, 11 Nov 2022 01:58:44 +0800
Message-ID: <20221110175847.3098728-7-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221110175847.3098728-1-Perry.Yuan@amd.com>
References: <20221110175847.3098728-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT107:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: e976bcd5-4a7a-4634-5023-08dac3455530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m5MVXf2dMUnqo+xsjmse5tAw+j9E5RAgUtlR0jQpHxF3iQaNRa1zh5E3KZqVaj2AvGRwtCE9rMeR8CAW52ip/Sro1wRTAOOBeJWzl0XaNxl/SmmaVPDlE8P2Uvpov/Dbi371Z4VX1wrhLP4+nBY1KFcZ+k7rRtS1lko/qmWF6Fg4nQU60v90zD2PWRt8T8iUdjV0KmG+2CfmYmoY4ik3G1Y+oN3kpZddPjSlK7b/2KLoP6t2oJlAErnlj26GoYUXlPWkYh8bwD1hYMUccW9/UWAYDIPY62WucOwKHACSeXiHyO1+1h76ObnpDOfOtBSqSPhQhAfLlh1exsF0KxanE3TbNi3A4nz8MIMDx6Kn3u3xarI1+WR8scBaGY8I8tR7pCfsA9okcev4NAP7GKsmTFiX5YeKu0dcE28EvaFCndGmtWBDOM/lQcxktJB5mIITy3m7FTTPrKRPD3UpAEgnrUKX9EzM3c/K41UoFaS/D+M4BM02lzObyH8QGE9K525ARcW1CMmcxt+gCnlAOskmn9ZDXHFbLeO3cZrC9N+F9RXn//hqFZvCemZf9NvT/fiUcMnMgzange+MIZojVplFDxlr4TuLxk3mtXiMvat3Um3i1QrTIQPcv87/tCsTxuibg0pjxSCIlEjFh4EB+kpsxgmxkqwBY+aMCSxfU0ByHvESTuxgB1zbQXsWlj5P1s72+R+gAOVbzn1nY0ZlUFvpcVdORa/QLmGEE/z2lrCZewKO1gGLsIldx8os04ehZbbQGzoKAhngx0FOoix5ZyNuRQmkbfNY0+U+B8asFgFEZrQaxlTDyG7OalCiJs3eCnoX
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(36840700001)(46966006)(40470700004)(41300700001)(70586007)(86362001)(5660300002)(70206006)(8676002)(4326008)(316002)(54906003)(8936002)(82740400003)(81166007)(36756003)(40480700001)(36860700001)(40460700003)(356005)(1076003)(83380400001)(7696005)(26005)(110136005)(6666004)(15650500001)(478600001)(82310400005)(2906002)(16526019)(186003)(2616005)(336012)(47076005)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 17:59:37.5267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e976bcd5-4a7a-4634-5023-08dac3455530
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add suspend and resume support for the AMD processors by amd_pstate_epp
driver instance.

When the CPPC is suspended, EPP driver will set EPP profile to 'power'
profile and set max/min perf to lowest perf value.
When resume happens, it will restore the MSR registers with
previous cached value.

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9a9abb755a18..645706d65173 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1261,6 +1261,44 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	return amd_pstate_cpu_offline(policy);
 }
 
+static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+	int ret;
+
+	/* avoid suspending when EPP is not enabled */
+	if (!cppc_active)
+		return 0;
+
+	/* set this flag to avoid setting core offline*/
+	cpudata->suspended = true;
+
+	/* disable CPPC in lowlevel firmware */
+	ret = amd_pstate_enable(false);
+	if (ret)
+		pr_err("failed to suspend, return %d\n", ret);
+
+	return 0;
+}
+
+static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+
+	if (cpudata->suspended) {
+		mutex_lock(&amd_pstate_limits_lock);
+
+		/* enable amd pstate from suspend state*/
+		amd_pstate_epp_reenable(cpudata);
+
+		mutex_unlock(&amd_pstate_limits_lock);
+
+		cpudata->suspended = false;
+	}
+
+	return 0;
+}
+
 static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
 					   struct cpufreq_policy_data *policy)
 {
@@ -1297,6 +1335,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
 	.update_limits	= amd_pstate_epp_update_limits,
 	.offline	= amd_pstate_epp_cpu_offline,
 	.online		= amd_pstate_epp_cpu_online,
+	.suspend	= amd_pstate_epp_suspend,
+	.resume		= amd_pstate_epp_resume,
 	.name		= "amd_pstate_epp",
 	.attr		= amd_pstate_epp_attr,
 };
-- 
2.34.1

