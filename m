Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA3765FB52
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 07:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjAFGQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 01:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbjAFGQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 01:16:29 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32E26EC86;
        Thu,  5 Jan 2023 22:16:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9jofmOJlMQgZ2LbXS4ZzSQVh40uZGQ8Cg5A9wLHhK4ecnXucQroBstwcIaHSzjkJXEqx3rB4ecxqoA3usAR75UVx8cUp/8cdpjBGr8aRNLoJYqnvgY8ajLSHGJJwytftzOU0C5/IxYEEERBNZZnXiIzKiwy8ecD86Qa5GAbteKMlVNpRX+kkd8XW/PJF4oJI17Fo5xt+8gWWYCwq/bEa4xdknIXD9nJ/Hdc/bi3pg9vUn3J3+JP5Enp/TtkMblDviLJXk5wQWWsW8BuGzc8glGQKrEWMq/MTp01Lz/fRG2WtxHGNPPpoQ+6paG1dCDFYfQV3WJQMdnK9SsbbYSpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJcG1DVGvovzozJZIp2a+XnJBNpYNNKiRNkSCuGxXlM=;
 b=YZ10KNLH7BttCLViumwOtWEvGRMkxuieuhg81QntP990kQAVAgroCTxowEU7Rjqihng1vZk0OgkXFvxoM3SNstCpyWL14afK52WFXq0imUoZb3pbNyv5L3zJmNmflYjueOBc01qmr1tz+/LjcfS4b5200swieum3BebzZhLDsYfVfNM444HPborbN9+gPjf4GJ73CU2U/GHV+6C1a0fzm8tN95egx2D39NjTGZHFRCr/09L475U+kURasAEZ59+RqgUA3RkaEljObCBDAsa21ZO+WUVVP7orFyiTYCak+esK1NvaCoSSCI5HDLyoANrQjRL+ZQZYTWmnioaKJUy00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJcG1DVGvovzozJZIp2a+XnJBNpYNNKiRNkSCuGxXlM=;
 b=OT4jqRxjRQnQHKaxB0QASSL3ZklSCP/dkLp2VpLO/k7w9F0r7EPZ8dJifvicXH0focZ/YeQje5djRqCv2GCexeVetGPvKNb57ooVMErp3wf0dwgeyxoZXxPRWjSdDDvGCDfv6+5+WFVBruJhMKmi/fZkEtn6mmz+Yj7bf4myXEE=
Received: from DS7PR07CA0009.namprd07.prod.outlook.com (2603:10b6:5:3af::9) by
 SJ0PR12MB5453.namprd12.prod.outlook.com (2603:10b6:a03:37f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Fri, 6 Jan 2023 06:16:26 +0000
Received: from DS1PEPF0000E633.namprd02.prod.outlook.com
 (2603:10b6:5:3af:cafe::89) by DS7PR07CA0009.outlook.office365.com
 (2603:10b6:5:3af::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.15 via Frontend
 Transport; Fri, 6 Jan 2023 06:16:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E633.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.15 via Frontend Transport; Fri, 6 Jan 2023 06:16:26 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 6 Jan 2023 00:16:21 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 11/12] cpufreq: amd-pstate: convert sprintf with sysfs_emit()
Date:   Fri, 6 Jan 2023 14:14:19 +0800
Message-ID: <20230106061420.95715-12-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230106061420.95715-1-perry.yuan@amd.com>
References: <20230106061420.95715-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E633:EE_|SJ0PR12MB5453:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d27626-a396-439e-9bf0-08daefad8ae0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7XkDReTojz0g0UeqcGf/FpRW6dqrplcOAGPBIOhO18a/xhmvS2uo712sPFXOmizFGtlPafIVcNI+8AbPPvcBQwt2snjf4L7BlbjMmpTTcHVI8l9dZzagu7SHGaxxYKfTxLPymVofzBuatmueZ9zX4ABPzal/fKKozNC7m38s3xzVoT8v/PU6UkQ1Tge5ysco3DXvpN1njHAG+rlCC91930kbwKRBkyd4Z8aXrJMLc4+1aGaJAU6HCGRVihFQ8jVvd4IlJXPgqIDdq9Dip+XYHk4mah78nRw7d8GgzEqo5AUEK6OuVM1lEjW1117dTjaYt44aPRbhyzhH1VGBHKWVra6X8Bn3frSd0EOz0jy4kA7QViVr82JiEZS05CdCrbegkdja+BBd/4MReZEiZ2Ruk5PtoTakcOoSIUHBxCV8+JLkBhZBaZibHrpBCxBtgp0MwLE9qaLvCa8EJjwcGCvwzO+4zA627NuPTyEkCI34QeAXD2DtTCEfd40iYz+Ado1Sefstz75TjckkRW7Rc6EltSsG8GsaP+nNfKbY14jQv+xaDtEVcuREIV3oVMpxIpDDmWE6dWvf0ej2b8NlEax1IGDfrv4AzjvcJpC9d/wF88SEj+NNr73djOyJ/KW9Bc2w88JeEiTdw6qODIcrkAFciROX6f76dl5rDmrIeUuDblkNzlni6mi9Ijc4CseUoC66FsptIb4c/gZL58/xmvvL6Mwua+5nEcjBD7yvMUZimQw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(46966006)(36840700001)(40470700004)(44832011)(41300700001)(70206006)(8676002)(4326008)(54906003)(110136005)(2906002)(70586007)(8936002)(316002)(7696005)(478600001)(186003)(26005)(5660300002)(16526019)(2616005)(86362001)(40480700001)(426003)(83380400001)(1076003)(336012)(47076005)(36860700001)(82740400003)(356005)(36756003)(40460700003)(81166007)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 06:16:26.3921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d27626-a396-439e-9bf0-08daefad8ae0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E633.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5453
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
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d3f4cdd803f3..ea4a4a0c80be 100644
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

