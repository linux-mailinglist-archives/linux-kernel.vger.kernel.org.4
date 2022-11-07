Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E33061FCA1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbiKGSD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbiKGSCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:02:15 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2058.outbound.protection.outlook.com [40.107.96.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EA327934;
        Mon,  7 Nov 2022 09:58:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt90tXAc9Jokl/UiytxbfAewW/XEhB3A6iP2MUyVIOnYeeFjfAJQGyefhbOycZQrJDe1lrauMbdKiWTwuI3+8nyNg0xXYJZhuVinF5vWNhL+AvxnDHvir8ZkaadhJA4x0s79V3I6OUKiCzEJY8uC6RMxKHMIYE1Nj8wB/odnXm0hSfXASf3V3006jEQ2pRsrZe8TxmUQNfkYiS5cMi0X5egEfuHTV5GcNqp/aHyJmXwu1KJ8LQXlP3/j4UCOQd8HVG5JjMKqIxMgE8BbVozQX09nBoy8avDldpVMMbPU7Pnd4bSxxmXPfoQtVilVEqGike8FZBIvHHSfZG88DJP+Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O58UxkGRrM/a+lVd9+yTsqiBWEngm7z/weOiLv7gMDM=;
 b=TUYk9gxL7Gnt3MYqfo6l/ePcOoQ1RuMNBgdwIbbW4Wm5xLydP/EbdtembYEd5S2C+Fc3mMp8F2jdq26sPQFg/MKE+9F/hIdLgyZNNevYFDnCtEv9HQaaGyDPf12rciQJPv6EVDHom7Y1K8HgUGn5jYpWFAI3aHEoTxpuaqrhO2TQsptomX+KP5ELnZu5bEzhCcNq36w2ffnxNOpwcQTKaiKH3HQtzfa52GWgnSmJcv4/H2BC4TFaK5TbBIH52+Vs4+eJZogiErg+julJiUGrE/Ladmdc/gKFPXXkNtBoFDdxy7Rbe/20IOM/ZkR2aDAB7JmXpW6YYzBcYxP4wrSenw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O58UxkGRrM/a+lVd9+yTsqiBWEngm7z/weOiLv7gMDM=;
 b=X6UllXVV/Bbqh0akAnt3UWuOlc6fzRzD2snuWryYgCO/jOU7EBjNo+Nw+28ZpSM5q5GCYUGA0492m2s6z+T0IeehMbqmd1WWurILhaLSIQXMygOJIkNqUKs/broKeeElew9Hy+9xUPY3qrPEIu7BUhBVj1M3E9OknENogz8QU78=
Received: from DS7PR03CA0300.namprd03.prod.outlook.com (2603:10b6:5:3ad::35)
 by DS7PR12MB5982.namprd12.prod.outlook.com (2603:10b6:8:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 17:58:43 +0000
Received: from DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::56) by DS7PR03CA0300.outlook.office365.com
 (2603:10b6:5:3ad::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26 via Frontend
 Transport; Mon, 7 Nov 2022 17:58:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT067.mail.protection.outlook.com (10.13.172.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.20 via Frontend Transport; Mon, 7 Nov 2022 17:58:42 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 11:58:38 -0600
From:   Perry Yuan <Perry.Yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <ray.huang@amd.com>,
        <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Mario.Limonciello@amd.com>,
        <Nathan.Fontenot@amd.com>, <Alexander.Deucher@amd.com>,
        <Shimmer.Huang@amd.com>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Perry Yuan <Perry.Yuan@amd.com>
Subject: [PATCH v3 6/8] cpufreq: amd-pstate: implement suspend and resume callbacks
Date:   Tue, 8 Nov 2022 01:57:03 +0800
Message-ID: <20221107175705.2207842-7-Perry.Yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107175705.2207842-1-Perry.Yuan@amd.com>
References: <20221107175705.2207842-1-Perry.Yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT067:EE_|DS7PR12MB5982:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f9c833-c55d-4ce0-7f39-08dac0e9b570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D+wv+tANqBayn4aogKEA2bFMm2sSBMwBeq+jq46KrXxIJZeFeYhn/Yb948B0Nr4tzbLYdJFyu+qIK9pTVDKjZ833EH/n06ZYRdl1QqbPgrxjNSE/urn/U27b2QEr7l5dVlIJ3IH5r3ohQy1M5GVPxpPp0IFMP0sRiyzzqOMGstbbxTODM1ZhIKD30+Sgx72iAHpd0t8YPXom589YzJBxVDG4RoYw69Dj7E0jgnmyrQZr+6sc3KL/7Dixx7Bi4e0+C99PsuIP6lyYDxbfJOWIC2pIX9NXsVLSu7GmPtbo8lr/sKsvmhdS3o6JRtl/XeqQUF7tpAp1uD1M4j2cM8dxvieno0Pp7Z87yDxdeNWOdqh9EMNSCxhi8MD284kF8BwSqn3ty/pSvoLoFalmkGezfsMgi+vF2rBi3YH8IPP8HEgSA/i6V1fiDioCZ7PMUJoIVEOZETRzYHJPga3AFzfUZgcfg68CBFiU5UPylmrfaBDL11aGdxd6CDqKbcUuEwMFYPgzmbiBVVhX+z3eqW/jZ9ugCY1kDYOSHY5R3JwAusP28KV17MV+Fd+OrUtFuPoPGb+AFDbzDfkrSVwtpL7cmWOTQ/YaHu4/khdGbr/9/6y3sXHKps14UfmqcC2G3Ky16HdB/gOUWrPZHs/HcMpCtKP3bya/dPrzAcSP0oXek5A8TrHdAAtiQEryd90kDp4xr+niV6GIK7IPtVfT3px2F9AgHFq6O3j5pcxfKIharSBOum4blXOUu0O3iuotc/DY3If2uVN29K2D8eK4k66PFrP+slJf3XFWPDXaw/6GOARJgNLLE5yusIymRLR3JrkZDcKepKeRLS2xpyjMQwgsYw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(316002)(110136005)(8676002)(54906003)(40460700003)(4326008)(2906002)(478600001)(36756003)(70586007)(70206006)(86362001)(82310400005)(356005)(36860700001)(83380400001)(426003)(47076005)(1076003)(82740400003)(81166007)(40480700001)(7696005)(6666004)(26005)(2616005)(336012)(16526019)(186003)(8936002)(5660300002)(41300700001)(15650500001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:58:42.9370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f9c833-c55d-4ce0-7f39-08dac0e9b570
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5982
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

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 6ce9fca0a128..841b1e2383b8 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1282,6 +1282,44 @@ static int amd_pstate_epp_cpu_offline(struct cpufreq_policy *policy)
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
@@ -1318,6 +1356,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
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

