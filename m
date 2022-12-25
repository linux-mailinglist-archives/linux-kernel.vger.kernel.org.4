Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB2D655DBE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbiLYQhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiLYQgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:36:20 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C622D10F4;
        Sun, 25 Dec 2022 08:35:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUEZeUZkMt89iKUU+QBuzqz5IdijCTDcJNop/Db5E6P/c8grqy9G0DlkjPIWoOLsmWW1mmqnhO58zOYF21OpS5HTnYlMwEoyKvFn/rTctxGeEjCwpdm8jcbWxAlqH1xg6OcgOit+XOo040kezxPycwjqYZUeYpP2IFYE0c8tBqu8l1EMgeg4BJTL9shjK6Tdcq3IjJ+vbDLqqso81WiKFFmpvqqp7ddqrzKSpoEgGlPwRkErXds7iWqE38ZT8hY3fLELQbHvYZZ9UA6skd8z+VuI8FpRLMQUTiyUZaXueU++MHN0UXPa1k/YhW55gOs/ZJzEEBVyxecDo1Pk8aYvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJue3IARzR/+8PkgEGJuRSFCFzuMcT6eEVM0xNWREtM=;
 b=h+0ZPgy8O6cF3DZ1kyJoclewHC+X9xbUCq/NmyMA4BdAaRbredyNDki8+BE4kCOFHFjhETex3S9/tWxjpSO5vO7ymfloXw3JEOc+t/JwX55Xv8WlDHJLfLlBGDCc66Ghnuswt1H718Ox/MMZCwicpMw/7GmY89mK4kXFDRS8SRb+D3tlPTT95zXVYg0FlQjIpZQEXxViP8pn4iH0PrvaxV3lAMZTmNP8ls43h/MNtC3Ll4/BOZNPDF0jxqFmVgy3Cx4rrocJ+sFSvBqp6xPeuCG5257+A415H/s55V7vjAKlvorhzC2IWzkS0dSeJT/3z5lxJBAxSIJ3FbsU4MqRlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJue3IARzR/+8PkgEGJuRSFCFzuMcT6eEVM0xNWREtM=;
 b=Hzeus24w0YpBUqzxLLHdN5/iDmI2OtZcNIH3nCKL5RF+ZOXI5oP4d8np34B1I8y7qXA9k/vh7zuG0X72uc0wGxV5IUYJhZdO+CtjqLKrNQjo23YQpdbvrSJsMMUjlLlnqwOE9mey36sD738ji6C8OC84CnbMLzGsxkybW+Daq5w=
Received: from MW4PR03CA0354.namprd03.prod.outlook.com (2603:10b6:303:dc::29)
 by PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Sun, 25 Dec
 2022 16:35:46 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::98) by MW4PR03CA0354.outlook.office365.com
 (2603:10b6:303:dc::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16 via Frontend
 Transport; Sun, 25 Dec 2022 16:35:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.14 via Frontend Transport; Sun, 25 Dec 2022 16:35:41 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 25 Dec 2022 10:35:37 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 12/13] cpufreq: amd-pstate: convert sprintf with sysfs_emit()
Date:   Mon, 26 Dec 2022 00:34:41 +0800
Message-ID: <20221225163442.2205660-13-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221225163442.2205660-1-perry.yuan@amd.com>
References: <20221225163442.2205660-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 62b00c34-aff8-4a92-a017-08dae696100a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tAk0hEuNIsaQDLz94w6Sugfh6vL3dlgqibHIHe2B62fYKLDpX9QkN3rItGtCKfXTGDjzEKnOftiqo1wiT8C6Oo1EZS00U1bSJkEZfveddcj1JI3MvMeMxA2Wq6FHHOccVtlId+Pspp3ViRH5mYijETu34BKDW146wdwQo4u5HriG+d2KnnoZFBIMnCfXtm5WnoOHkmG5LmZcVXe6PExhGb84uIgBW+md3Iw1g+NCbLC51LDQ62gV/FaEy9p3DRjQ8NbcRmZSvOHgv0kqibh2xKjaxwX7WhyCZSe18IoD6sxdYFEMO47DjspZvjAviHEGgx04nQatQ1ighYG5WbfFHZIG7EBqfrOhJnzRJLKany85Y0+lq2aFa3fOmD0VVr/raBm/znpBn8c+S5Xf3U8fh2ltzNPPCI/omNxtM6PSElf87nmBtIFfvb19wpV1xlih+r1N4hz6a75e2hb2034vMr70gMWN7PTLouuvHS3+D9DRn7ZgUpiQQzgQ/CB88OP5pO+GtM0T0LlGTgSvZabl3UpIC4Xh+Zk1fNFb0WF+7qwg6l44sOZJBWlHc7+zU/UWkykDL6I0LQ5gaTc448p03cBO9rNjGy2g6XA6ntzhdxMDXEZ/h2mrLjG1eC70UeMHuWFVkO/sSnFlTWoI0wS+H75OZMXqdL7LQSZK1BreQ4QgjJXihY9/RQcN4scT//R0jyuGr7Z9iTu9bIETPTfydK79wTK4ev2FwuAOy/VRPqo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(36840700001)(40470700004)(46966006)(7696005)(81166007)(16526019)(6666004)(26005)(186003)(356005)(478600001)(1076003)(83380400001)(54906003)(110136005)(70586007)(8676002)(4326008)(86362001)(316002)(36860700001)(82740400003)(36756003)(2616005)(70206006)(426003)(40460700003)(336012)(5660300002)(47076005)(82310400005)(41300700001)(8936002)(2906002)(40480700001)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2022 16:35:41.3242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b00c34-aff8-4a92-a017-08dae696100a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050
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
index 8ceca4524fc1..87450413cf45 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -695,7 +695,7 @@ static ssize_t show_amd_pstate_max_freq(struct cpufreq_policy *policy,
 	if (max_freq < 0)
 		return max_freq;
 
-	return sprintf(&buf[0], "%u\n", max_freq);
+	return sysfs_emit(buf, "%u\n", max_freq);
 }
 
 static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *policy,
@@ -708,7 +708,7 @@ static ssize_t show_amd_pstate_lowest_nonlinear_freq(struct cpufreq_policy *poli
 	if (freq < 0)
 		return freq;
 
-	return sprintf(&buf[0], "%u\n", freq);
+	return sysfs_emit(buf, "%u\n", freq);
 }
 
 /*
@@ -723,7 +723,7 @@ static ssize_t show_amd_pstate_highest_perf(struct cpufreq_policy *policy,
 
 	perf = READ_ONCE(cpudata->highest_perf);
 
-	return sprintf(&buf[0], "%u\n", perf);
+	return sysfs_emit(buf, "%u\n", perf);
 }
 
 static ssize_t show_energy_performance_available_preferences(
-- 
2.34.1

