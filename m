Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8290C5B3D61
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiIIQsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiIIQr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:47:29 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364E1145FF3;
        Fri,  9 Sep 2022 09:47:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1Xo7JU2Grr0BTjmPsRpi9LfIhHxU/n7ehu7REHBW0+FqrVH8q6vLN3/jF+jCCNKU1LHHhQP1qEFF0By00hJL09fjuwd0nj1MvW95gSkfU059ev0NvxpPBGZq6wQke4sGuxylIHeTagG9V0oQsizHzMC4ApOUsuc7RTn2jaXYQmsz3kGQGB8KTKBIHyNPZGFQ4P2F9qPHJKR1SigHGZ3tLdNHRZdCZqlDkqn4X3IA3S2vlhmoYZHgLlf6BwRr0gYzkxo0ozbFRpknhC5kGay4ARfjUaBkP8fUtYdRFUN4WJ+P+aPLjSKLgIzkfWnnvZns+dyiETEHvXBQIVB/H4HTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LI5aI5TQ86i03I/lSgUAXjM57gnJa+5XfjNLXi41C0k=;
 b=IM4rherZNqzmjMGGgMckgWsC4AxAgHBGgkPXxnw62Cz3zBYiNDJVWCMmZ2MFp/2znUrb8qcu6PvmSKxHZuCaMYDihZ1FCAlnizemJq0O+ar3xCRYz2NEjvWJryg57xC99U2brHXYcLLXlz3Jik9rvWla2SrA2/AnF4OeQbOlNmV335u+e3bvq2/dShaQdRJK+T7/Ck/g40GpVYk516WgtEBkew1NmcqoaoXLW447Yk8qmxD0QGKBdUV31GkiUta9QmPB9zVP8MHVO0tf0GEaHazTIGYhE3xWVRnzB1UqVZpJDnA+tXGNZOv1grohvdQSSnz7TaMnqeflfbh1evgVMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LI5aI5TQ86i03I/lSgUAXjM57gnJa+5XfjNLXi41C0k=;
 b=2Wg4CBje3gt7GDdQPR9ZxGHlUSeRSHW4WT75GdQnZRz2m9RAqV3Eg+EePAc1/uRAmadGNzhd7pyKotswT298fU1863/0at7R9q1Ui3Mq2KdxUUqKGlv4PpXpariM8lsUgqxVXh9HdCWBrUJV2UVxXc149QG9/1x2GvPSLIZPqlA=
Received: from BN9P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::9)
 by MW4PR12MB6898.namprd12.prod.outlook.com (2603:10b6:303:207::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Fri, 9 Sep
 2022 16:47:23 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::37) by BN9P223CA0004.outlook.office365.com
 (2603:10b6:408:10b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 16:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 16:47:22 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 9 Sep 2022 11:47:18 -0500
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Jinzhou.Su@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH 7/7] cpufreq: amd-pstate: implement suspend and resume callbacks
Date:   Sat, 10 Sep 2022 00:45:34 +0800
Message-ID: <20220909164534.71864-8-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220909164534.71864-1-Perry.Yuan@amd.com>
References: <20220909164534.71864-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|MW4PR12MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: ec581448-e894-44f6-977c-08da9282f7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O69V9Iup3x+3qrHQ4D4NFJM99o4yBVBYKCATrKCnSsNTUQgvqL/uDiX0I/7N/NJXvP5LONtheWjnxw6ml1U3X5qRUYbkkeqVIaqupAVEZvK1nHnh7eO2WWc37e3hAFXQzslJB1VqnryVE2wqVJCX/IVg93zZkSrY8OiiSYsQxiUCRRK7RE9mqbc6vRHH4+XB5audNCOaB4eb7BilTmYKyRwu/nc27lMu39d7fIStFcFHmirzyf9iB9ramAFahu5KG5xuuVp15dayyIqdZy8v5wg6DsQrBOmy3XrQ0pWTp9zpD64Pww7prA7v4yLzgTXl4w4VZUgEIWMrzbPGKIPeNbNyUvBUeCWq5xoMjoBPnfzM29eQmVpNHgAu3CMGO5NWnmL14PHHzoiaF/JMnsGf1mOpcE59VcdxpKUTGbe/F5EgoPNFxdNwa5ro49Z8vSx0okLRAJ9mVxRDFSp9LM+Kd1X9yc1KCFne0NsHqhK9JmViWD+03johFUaf5f9GGe9rAbizYpGSM+JxhjU757PeIXHw5tRAl/+cnX8Rxwiw+yRtEWqGTPv7czBNL8+18P4bXZVSYdVdbbIPwtRiSqqUH0/v1TaTAzgHp+cFjl9viiHdVdrceGFz1dfWe8RmX/s1BU4vvVJaw+y1Q1ImbSDmAx6gITCTT9/5xDnYsql1PTnWUeqzCX+eR56/EN1j3zsHMEB3i6gdLqcwH81qzC/Q67hJYJ+j7wmG+hwcvX5OEwekC3uQdoKNFUf5TwBdRqKs5t3li4uhcKlXhRs1awIgGUmYoMlv56eymvgv3EiAGnYU3WkS+iN/dK8U+RfAJHhhqMFLo6oe37QZNGEhanL3og==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(39860400002)(346002)(36840700001)(40470700004)(46966006)(2616005)(40480700001)(426003)(82740400003)(336012)(186003)(70206006)(1076003)(54906003)(15650500001)(8676002)(36756003)(83380400001)(110136005)(70586007)(316002)(26005)(5660300002)(47076005)(36860700001)(6666004)(2906002)(41300700001)(478600001)(82310400005)(356005)(86362001)(8936002)(16526019)(7696005)(40460700003)(4326008)(81166007)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:47:22.9167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec581448-e894-44f6-977c-08da9282f7f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6898
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index e63fed39f90c..749083d28b05 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1476,6 +1476,43 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
 	return amd_pstate_cpu_offline(policy);
 }
 
+static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+	int ret;
+
+	pr_debug("AMD CPU Core %d suspending\n", cpudata->cpu);
+
+	cpudata->suspended = true;
+
+	/* disable CPPC in lowlevel firmware */
+	ret = amd_pstate_enable(false);
+	if (ret)
+		pr_err("failed to disable amd pstate during suspend, return %d\n", ret);
+
+	return 0;
+}
+
+static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
+{
+	struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+
+	pr_debug("AMD CPU Core %d resuming\n", cpudata->cpu);
+
+	if (cpudata->suspended && epp_enabled) {
+		mutex_lock(&amd_pstate_limits_lock);
+
+		/* enable amd pstate from suspend state*/
+		amd_pstate_epp_reenable(cpudata);
+
+		mutex_unlock(&amd_pstate_limits_lock);
+	}
+
+	cpudata->suspended = false;
+
+	return 0;
+}
+
 static void amd_pstate_verify_cpu_policy(struct amd_cpudata *cpudata,
 					   struct cpufreq_policy_data *policy)
 {
@@ -1512,6 +1549,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
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

