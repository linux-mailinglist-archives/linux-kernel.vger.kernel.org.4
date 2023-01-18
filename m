Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B47671650
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjARIak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjARI0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:26:05 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2041.outbound.protection.outlook.com [40.107.100.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5FC5B5AD;
        Tue, 17 Jan 2023 23:53:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ba6Q93CJ82bZGbm/tp+nQU74FknRGo/v2/J8HlSdUTYevrGltyuuRwv3vYHio5J8HEpl0LOSo4YTaIopO0RbpIUFMnBs+akpBIRhS5XuwSq2k5AiyQrzl5/vtVIVFlztWDg9dTqc+enzCIubhvbzuyRhvJ7zj72JHteQ4LXOVgY62cVM5xwCqTkLNIlsFgzuUMZZhLT1FLM68r0LUOzkYsLn2cT4hIhRioi+ACgRt2Nt/5zk9bEIXbrq6rYQITGfn2y45mK3mw0aITUcYCQzoyRccmVNlhSkUzlDxrzINkMRJanTxdO8BwFioUslIztvnmwadhmbfqkyavphngqdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32pMiOlV7Ishsq6tGX0Ullqnoye0YjjxIeEj2mFpxv8=;
 b=UT6kKZFmGU5bbQi+p26hFMrevZf5Ri5ulwWL9nXqIUJ3OJR288aFKrmvEe5+BYf4Xj/LQl2IcHyr9j66zCLa169X0+DP383rxbD/wUylBYq6Rk4ApyuY7lTISX84dIWhSRwQSRdFZ9tj5U5TPJXacCtYreHLyT0yR/Wa6FGhR1r2AtovqwLoFrV9n4Ly1ZanA8PPC2mpBEsWaAMN5DIJztEOu5QN1OvDu5/IrwhuNjHHumMImZguAnKIH8ZO6Li8IUYW/oR5t/MYBhO/jmsdjD3MOSqyv8J3/9uvMZ8XPTCUhAi1jNJqsrQ7/mVeLLosaY/Ir9rLa/L7Z3g6FQCFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32pMiOlV7Ishsq6tGX0Ullqnoye0YjjxIeEj2mFpxv8=;
 b=X5YAWGxQ9vFf9AkThIkXUTFyj9Vdk/B4ty9tKsOHAfEf/XEoLf/cSW5vDTIXSieHHuCGelh7LEl6qhUmLNHJxT3adAtbVHBemSfjKpguqpigEowI+Q6i20zMaqMFHhzpkSI2N65oTdbMuddTg34/iXR13iIpWukg/CT7b75RiDs=
Received: from MW2PR2101CA0009.namprd21.prod.outlook.com (2603:10b6:302:1::22)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 07:53:21 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::e) by MW2PR2101CA0009.outlook.office365.com
 (2603:10b6:302:1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.5 via Frontend
 Transport; Wed, 18 Jan 2023 07:53:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Wed, 18 Jan 2023 07:53:20 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 01:53:16 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 10/11] cpufreq: amd-pstate: convert sprintf with sysfs_emit()
Date:   Wed, 18 Jan 2023 15:52:09 +0800
Message-ID: <20230118075210.447418-11-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT013:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2eed60-f4d8-4383-d3ca-08daf9291198
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CN6ACeba/fobCRD8eXR+sWzyZKDtBGq9peLAoUUgidRTjkG2mJLkeBQbzrJY00GnwDN07UsjPQwpajrcf22zsIkEs8vBjxiBBNW7S0HsAq1owkgEl9mky7rpsoAFv2a+oEQwMTHiwtFXa2VrnRbhHQyH3XeW4gsRP42q7QgmzEAS8rLw7SHIEBW1XqHwrXTFCI2inq9LXOKi56FDZND8kCOduCn2r+QwrqEXVi71JYJ/vbo/mWZSgF2GRmWb4FdiLnAr/Nnqk1fXFGMzZncHprxsxoY+Ycr5Ag6b39vESxf1QsiEXLVRp+ncuzBXhGYVe5YOUxzWWzumw6r5AugKIY8geM7sR6QB1sWeel4nEOAwzQYkVQwZfTzbStCLZDoIeK/OIYypo36Lt1h+uhr5l9QrnmscQKxKS/ObGRVLMY5CW3SeDDyaxNxwKCfx2AxJzn2D4MiivXfMjgGJuLdDLO+2+zGExTwMHgepKoVkTot5BU4HRJKU9cvW0N43iNC8IxByCjbWq3AKEu1jxlDEwHETz49EBcYhTfKpLpD220Oz5N9oCfcg1Zdad//oAdU/2nlzgtvD41VyLXDTsQrvj7sQV/IgEAmka5BrdpzZie/lqmyy3AGLzTykwlcfOsxEA7SX6QTXgslolup5UPl33Jip45ojWQbEsVpmpLIp/FzkWkulA3KjMFaGGfbqUoxVYbU1LFH0KXNd4uLlSsEeESkwIpje3mXOjrGjxG7L5l0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(86362001)(356005)(2906002)(44832011)(70586007)(70206006)(8936002)(5660300002)(82740400003)(81166007)(36860700001)(54906003)(110136005)(6666004)(47076005)(426003)(7696005)(316002)(478600001)(36756003)(82310400005)(41300700001)(8676002)(4326008)(40480700001)(16526019)(186003)(1076003)(336012)(83380400001)(26005)(40460700003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 07:53:20.8987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2eed60-f4d8-4383-d3ca-08daf9291198
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace the sprintf with a more generic sysfs_emit function

No intended potential function impact

Acked-by: Huang Rui <ray.huang@amd.com>
Tested-by: Wyes Karny <wyes.karny@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2e5e594dc41e..c307d67a76ae 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -694,7 +694,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 	if (max_freq < 0)
 		return max_freq;
 
-	return sprintf(&buf[0], "%u\n", max_freq);
+	return sysfs_emit(buf, "%u\n", max_freq);
 }
 
 static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
@@ -707,7 +707,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 	if (freq < 0)
 		return freq;
 
-	return sprintf(&buf[0], "%u\n", freq);
+	return sysfs_emit(buf, "%u\n", freq);
 }
 
 /*
@@ -722,7 +722,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 
 	perf = READ_ONCE(cpudata->highest_perf);
 
-	return sprintf(&buf[0], "%u\n", perf);
+	return sysfs_emit(buf, "%u\n", perf);
 }
 
 static ssize_t show_energy_performance_available_preferences(
-- 
2.34.1

