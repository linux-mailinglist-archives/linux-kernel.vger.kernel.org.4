Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06D564015E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 08:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiLBHxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 02:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiLBHw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 02:52:59 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD4EA47EC;
        Thu,  1 Dec 2022 23:52:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRA8YyG7q3jpS4J90cklf9/XaNzXryKw71NzY/VIdgFHDg8t5HclDYBEQRL+VF64Z7VA1bUmdXYuwwFETUwl1mwopk+1VkQX/fhvD/UVyW/hsAGc3WRYvhZdr77jLGteegs1e9MwIgwlj6yCZ+NEy4fWVKH3aiPRYDgNZSwwAwih6UqvSIM63g/bDk6f6MpiLSe5XkvMEwAGXbgBPBeZidYDVRPj+YRoL8OhHY/jp5gOXTEEb+c8onD7C0Vcqr9OvXf7FK+RDdYyEmGPwhoJOQEftwyVjreaqo6ukOiBVM6/jMEKSQbheVnMTJQDCph2mzR+u36gNd7l2gK8HxRcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YbQawOW+HGXAJpP8lctUQddE5uvyrzxvUTs4UCIx/xs=;
 b=WXXqHDK126MABN2hFNp1BiqRUgPOUUOeMWe7TjNqa3YJOV/8jpJYpDxT6wA7hTkScJvu4T9LEJ5cF24RyDpS5SNBqGm5cNj+5nIE1otzMJRhMkj+jK5peT3uXW3y7lLG4A/q177TgPOkmwe7fXseCN0P6yzI38PfEUNq4E+OU+p4XncFJAovjoZ/GYQAipSDghyAPj5DUXHDkzX6sqCLs9G6DHKCCTN7zsr3GT/ORfgfoRWNtzdIHgfPM4R47MW/W/WKhAsIfTjYLRHg7KtCOkwknskWJjnW/KQbutexcJnzZ2AZOLh0TMaIKeM9wuaAVyWi2aLeZDFGjgwB49VuMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YbQawOW+HGXAJpP8lctUQddE5uvyrzxvUTs4UCIx/xs=;
 b=pQ2zqgAhDvDovtssbd5BTGCxwVISRVd0eq2/a9x6secRoVjGMeYpNvXihsbEIQaFDC0X3CwDG2AEDJ6pYUwACLK6ibl3AvAkt+G1MJh6rH53JhYD0OCYfvNVRgbOemyZGWbe0+E5oY9iWIGstcypXTP4PN/WnB/iCxuAb0PqTHM=
Received: from DM6PR18CA0007.namprd18.prod.outlook.com (2603:10b6:5:15b::20)
 by PH8PR12MB6721.namprd12.prod.outlook.com (2603:10b6:510:1cc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Fri, 2 Dec
 2022 07:52:12 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::6) by DM6PR18CA0007.outlook.office365.com
 (2603:10b6:5:15b::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8 via Frontend
 Transport; Fri, 2 Dec 2022 07:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.10 via Frontend Transport; Fri, 2 Dec 2022 07:52:12 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 2 Dec 2022 01:52:07 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 11/11] cpufreq: amd_pstate: convert sprintf with sysfs_emit()
Date:   Fri, 2 Dec 2022 15:47:19 +0800
Message-ID: <20221202074719.623673-12-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|PH8PR12MB6721:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b743755-5667-40cd-2d22-08dad43a1f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SoymmnN7LgGuZgYqSx3acxsTbgbww4tcdhwCFoAf2acPsXQK2IU2hkFvm3f2tpQfNyGrMpS/JRpDkgjJZzZrnhr6PRC04h6i+cHSgZ8GVc/lkM6u5RrLHsTNc4IahNcWZq/In/+zeKwnFwFRsRnBqZBsrahIAF55MEdrE1BIuy2pxCEl1N+RBaqLfl7QrMfHiZryiIDRdHiC39KKCa2XvN7KfmHdSWGu71MjRi8j6cfe7dMYGCPMkIK8eUJg16WoYwHTUEoIf4eKUh3Sm5sZUIUjscp3iSyErFd/ui2nyeh2jy2M0Ob0sbc7PdXygbU8WlgQ9onAycyziy3DNWLRZCoa/u4CfV14yUcC+LjJgaunKrgbwv5Ds1bw1gYiWT1SnvmRAJDbN0OccAAnLX4AbaWhX6aT0/1c0YG3/gbqCbADzzOfZCNpnqwdgAFjmnlYUuBMMr4tW0alJcN16HNRfX2CVkcDpJi8mxTezo5am6tiR/fwePFDR/axc5hkQ31mB3Uqz800e4JFTLSD0+CnAV0378vqnCynbn0ei2yCabqFm2H1ZMh78W0D2Ym3AaHfIblepbX00qv02toZIZHxrhF2uywdSaaKf1YQgmh0Ey3eKZMx4QD14LvCuBiIxHeDRQouHa4ZM+yURMJHofC6P9HmMBy5p2ZypkmTrqTrE5zVYgn/CC2kKcQmon/8thr8O+xxGBWmpfY4+zHQPhWDgsXFxk7uZGG6Y9wzOWSJkSs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(40470700004)(36840700001)(46966006)(40480700001)(81166007)(36756003)(86362001)(356005)(40460700003)(110136005)(316002)(44832011)(5660300002)(8936002)(70206006)(4326008)(70586007)(8676002)(41300700001)(478600001)(36860700001)(83380400001)(6666004)(82740400003)(2906002)(47076005)(26005)(7696005)(186003)(426003)(82310400005)(2616005)(16526019)(336012)(54906003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 07:52:12.2204
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b743755-5667-40cd-2d22-08dad43a1f33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6721
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

No potential function impact

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 7f748a579023..28e2dbaad542 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -696,7 +696,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 	if (max_freq < 0)
 		return max_freq;
 
-	return sprintf(&buf[0], "%u\n", max_freq);
+	return sysfs_emit(buf, "%u\n", max_freq);
 }
 
 static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
@@ -709,7 +709,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 	if (freq < 0)
 		return freq;
 
-	return sprintf(&buf[0], "%u\n", freq);
+	return sysfs_emit(buf, "%u\n", freq);
 }
 
 /*
@@ -724,7 +724,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 
 	perf = READ_ONCE(cpudata->highest_perf);
 
-	return sprintf(&buf[0], "%u\n", perf);
+	return sysfs_emit(buf, "%u\n", perf);
 }
 
 static ssize_t show_energy_performance_available_preferences(
-- 
2.34.1

