Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D92640148
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbiLBHv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232524AbiLBHvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:51:31 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E8FA47D7;
        Thu,  1 Dec 2022 23:51:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPYYiI1mqerWTvkJk802kO25MSRib/VxuLyHRlji7BqsCkWatIy2LlpoymZAJBPPGZ4Tx1GXUlOdIdrgc1uhVOC5nggaD1KeFRuO8zEpnwWpCeCDKr85bJ/RmGaMRlghZCP/AxqJkGPaO+OlnBdr5e2RY57hfZGdUi4kTGcry9JY8JGrn94g1yIIo/m67oIhUmsiKLtBYzscZp49/FCL70v2eze/8Q07Pz9zegBVZiYAqptBfzXo9RcCGX0qr4wPqwqcYFuqTTkzmpUnOSWZOGFKKpNz6VMgC9AGwWuksFDtx2VyHVw1kcHWPTYdcWMrE/X+nDiuAJ/3YN5ysggEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8p1B2I7gYf0TBpPAqQScBCWZPmvftlr0SCE594g6M8=;
 b=DqVvDQuXEPePz66NJ1cjQ+ka1tpfCTfnz/msnZIven9hXRDSNaPdTs0G3WnBsa5KCgslFNfpzNAoEMW7arlWsF0vLHdHrGpSjyQCksSh2wkPU7ivzNcAjiS7SOufOR67/yOxLDtXl5LLDmRiBDa4PhGaRY4BMqV89Wh306/IMDutSVTS4jto3h23rWrLFQkjzw9dDHvMWL3xaOu2oyoRTRefIKxkDqvUN7US7V9lfJwbh38wHfPuGu/I6qbDLEu7XGJ4ZPt7JpWYevrDilZkkpjiypbTgX/f0g35V6snF9jbcrtT6Xm73lYuUny202km3F/NUIBQOmYkKKgMt/kUSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8p1B2I7gYf0TBpPAqQScBCWZPmvftlr0SCE594g6M8=;
 b=Nxiea2YB1FJEYJltTzVPS6zmSZkYOFuAu0my48m/NQUt9SKh/R+ihwSGbIq7y8LoeEYOpswGgf4VBEaYNpNtc7ANj1lWYXGHL3escFc/WtIAwg+2GrtVXnb7z90kHEDRcrlYpopxieripq4+sx6WqWlOtjKW89v3mPBUGTmkJ2I=
Received: from DS7PR05CA0105.namprd05.prod.outlook.com (2603:10b6:8:56::19) by
 IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Fri, 2 Dec
 2022 07:51:24 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::8b) by DS7PR05CA0105.outlook.office365.com
 (2603:10b6:8:56::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5901.8 via Frontend
 Transport; Fri, 2 Dec 2022 07:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Fri, 2 Dec 2022 07:51:23 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 2 Dec 2022 01:51:19 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 06/11] cpufreq: amd-pstate: implement suspend and resume callbacks
Date:   Fri, 2 Dec 2022 15:47:14 +0800
Message-ID: <20221202074719.623673-7-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202074719.623673-1-perry.yuan@amd.com>
References: <20221202074719.623673-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT055:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aaf6891-566b-43e7-ae73-08dad43a0264
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HGuoSI0uyFC11JEQDnbwuh9LCI97iWRW4xjqdkbfscg9l38KSqeVevUZepQJOtozv6ZwroydGltWfNdtsHLd64va7IZNXRX1AeMiBQTWjULsT3MvwNBdR0rw1KicQZ+9gSXhyhW4CHFHPnMcBJz0oLD5wAGIKqj/RlDOCbNIQASgIdxcma4Je650UlY9QqRtZjmkx+oQsFe/hmHfVny9SXovPvR49YRq755muoK7VnIVruI4DyKUawtBT52NBf/hboepJw6AOu4SkK10zDG8PL12ZtqznIE9cyyRvcHJo2clHEkDpOPbCMjsuUFv2DryJpCxVFEVlnV2g8ZdODFyt/dSsqKNdsGQro5JWxq0hJG4jnwDuMGgbJGhfYkUR1dtsdrGensCpcqianvNDm6RAN//lAgoLRk+fFJh/xWFAKba7ent5ELKUeakCwBtdGKoSl2lZVkIMsmrElmtORMe6OlwtWOoCjuE91OPrTNjVbIriStRvnAUNNrbgG00yEkJey73HBcVhh8htzz6EXLvjj79feBKEN+tRhRKbUfn4iNEsbU1lp9ZqqQyUr8VHUCqCAHQBrfRWO93z/6PAqZ8H+Idi5T2j6ghJPxH6XYt5Qwf84asquKX5b9Z8ydX6Q7tM9xdeBoaSnrnkjBTlKgKhBrDY4TmpZscMtved+TdqnDcUv7c+GydypSkBHfdjn+UkMFph3KytKzNEtrkcGpxpT3XIBgpwU/y6+E7VjwyZ1w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(40470700004)(46966006)(36840700001)(2616005)(36860700001)(2906002)(83380400001)(7696005)(40460700003)(15650500001)(70586007)(26005)(8676002)(70206006)(356005)(81166007)(40480700001)(82310400005)(82740400003)(6666004)(478600001)(36756003)(41300700001)(426003)(1076003)(186003)(8936002)(47076005)(5660300002)(16526019)(316002)(54906003)(336012)(44832011)(110136005)(86362001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 07:51:23.8909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaf6891-566b-43e7-ae73-08dad43a0264
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Perry Yuan <Perry.Yuan@amd.com>

add suspend and resume support for the AMD processors by amd_pstate_epp
driver instance.

When the CPPC is suspended, EPP driver will set EPP profile to 'power'
profile and set max/min perf to lowest perf value.
When resume happens, it will restore the MSR registers with
previous cached value.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7545d83a934b..b3a82cee2e83 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1284,6 +1284,44 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
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
@@ -1320,6 +1358,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
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

