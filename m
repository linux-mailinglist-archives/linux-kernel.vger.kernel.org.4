Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411C96507B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 07:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiLSGnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 01:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiLSGm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 01:42:29 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222B7DE98;
        Sun, 18 Dec 2022 22:41:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2OlJ+m5G7vdre2nbbKCu2S485WKMdxo2KAcDjtaH+d91tL5TAFvujz//dEySR0RtSCZach7hsu3C1PwzadJU2eK1sc0DuBWg/4fvHu2wn/aP0NH3U8TqBWTMKBI+eKmmT+gAQU7vhvNdWO6hwwPGunL/NPlhRbB4JPbFBbP2NlXjfrtXBcVbsw+1eGcd8Ldihe/y3udZQdarGGR2F6JrY7w46hxzC+BPKyxBbHjA5oSLwb8cEuyX0TN/f+WkdraaS8lytkcbAe3gA13Vvm+EXLCdc+VSMmyEf8X0tJsbh7CIZ0mXhlf+nLKDfpWZzIx7WBDJaV48n+eZbsngQWfUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8x6qSR0djgaZD8lk2wgmQviMIM3tRRLyl9aop1Hr4lg=;
 b=jEFBHyPEA5cAhaJY1h1iuNkF5BMTt+yGZAhJrj8CWJvqTFj6xzawTKEJ/PgRFqO+oMNEYdb49G0dJF7Qi+pFr/jQVfGG6BDfj+y0jgOVfijc8J4oeBF32FTw5WG1ZYQDoLerEF6NdYzF3l2JZ+MOEfic4CB62oY+iQcwMc4+BylBoYavK62ay6uY26ut3B2hDJJpziv31FnWpa9gNeuvhw+KmDqgGXr0iKK4tKqfC6Z1c2bNTIVcBIMYTWWzEETo7eHsmHDPA+jtwBw5+37B0pUlDbHAc19LuE63qfFC+Tl01vuOYAgWW9guPCkcIfwum90tlNJbtuGs6Dynmt7hfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x6qSR0djgaZD8lk2wgmQviMIM3tRRLyl9aop1Hr4lg=;
 b=UZGd+jsUVi4gIGg1VIOoTUmOGATp3vfyKOcXDaz0ziVMHQXT4VtldGQRnlRHFQRV7Pba1/uIHt/CpcIXxPQVu+aPUWQ71rGL707cU7n9zCk/qKb7kjmVLSwGwuGDG2ioelcgJKg2WrRSAnQiLaLCe9svZm0yF/ANut+EDE+RR/Y=
Received: from DM6PR04CA0028.namprd04.prod.outlook.com (2603:10b6:5:334::33)
 by BL1PR12MB5923.namprd12.prod.outlook.com (2603:10b6:208:39a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Mon, 19 Dec
 2022 06:41:48 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::88) by DM6PR04CA0028.outlook.office365.com
 (2603:10b6:5:334::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.20 via Frontend
 Transport; Mon, 19 Dec 2022 06:41:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.16 via Frontend Transport; Mon, 19 Dec 2022 06:41:47 +0000
Received: from pyuan-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 19 Dec 2022 00:41:44 -0600
From:   Perry Yuan <perry.yuan@amd.com>
To:     <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
        <ray.huang@amd.com>, <viresh.kumar@linaro.org>
CC:     <Deepak.Sharma@amd.com>, <Nathan.Fontenot@amd.com>,
        <Alexander.Deucher@amd.com>, <Shimmer.Huang@amd.com>,
        <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <wyes.karny@amd.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v8 08/13] cpufreq: amd-pstate: implement suspend and resume callbacks
Date:   Mon, 19 Dec 2022 14:40:37 +0800
Message-ID: <20221219064042.661122-9-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221219064042.661122-1-perry.yuan@amd.com>
References: <20221219064042.661122-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT056:EE_|BL1PR12MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 831b0681-0571-4787-c7a6-08dae18c1a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AIuCZXfkwo8mTdpPZocjgj3zGMYIucEPxe6uxRG1l2WJq37qbq5powH7g6kaD2Z/LRLr0MEBgKfOmGLyFmSZEBa6n9GepB5l6KBER9Rq5XlrAnn/isD8I3Otfyi1D3O7kWGTX4iAr1meza3B5fNECXkYPJLqUQxUn3HS0WSSclaydyPst0Ec6XsP+D1u7IxlCGDnsLbW9IjRoF34+E86XzcEXvbv9waVEdzQQ/AhFjiNf3MvrcLb7xQpuM+rZX7ocAaVAKiO34yPmmPlDxqoVXP2uSyQ5EomGV4lDQixbZ1SZLZz43Azfhc9EvaHB97yiRnwFaMD9l0Ock9B0MxQ5urtncGTUkG3IeHy753uz0CBqbkYuu2VmocDbbooHQBq1FntF9K0kjuRDdRrlwFG2itO/2vBEXwQtAhFBRIXeZ2lrfDv2Ib8uS8/4km+YcyFQ5SK8QEmrujcGkzSFdiZ5Qgof7KrR1U+wKbUYJ7AAZeqLt09DVitz2Y46Gosj59WEI/7VgQRrPp5pqZ7r9/TdoiZRe8YBkQ4jXJ/4y5fYBxCpSv9k+3Kj7SeVjsSxrQatRBp51VNFlENqcim4MBM8U7fpOYmAYJL8mLisq/Ao6EMdaLIrpKIArgcussplBWldDjTMqV+8MoT6PjV4UN+E1XI2AgM2mczsTwd9QKEO5aN7d0A4bJ1SEBLpXxq7bA2kqGOC91+Lv/f0b6wyVt4mGlN1YQ4jYf1uQDq+e9otfY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(46966006)(36840700001)(40470700004)(54906003)(36860700001)(110136005)(336012)(44832011)(15650500001)(41300700001)(4326008)(47076005)(40460700003)(86362001)(426003)(36756003)(8936002)(5660300002)(83380400001)(2906002)(316002)(8676002)(40480700001)(2616005)(16526019)(70586007)(70206006)(1076003)(82310400005)(6666004)(26005)(186003)(82740400003)(81166007)(478600001)(356005)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2022 06:41:47.9917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 831b0681-0571-4787-c7a6-08dae18c1a62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5923
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

Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 41 ++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index cb647f55a169..fc12d35bc7bd 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1107,6 +1107,45 @@ static int amd_pstate_epp_verify_policy(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
+static int amd_pstate_epp_suspend(struct cpufreq_policy *policy)
+{
+        struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+        int ret;
+
+        /* avoid suspending when EPP is not enabled */
+        if (cppc_state != AMD_PSTATE_ACTIVE)
+                return 0;
+
+        /* set this flag to avoid setting core offline*/
+        cpudata->suspended = true;
+
+        /* disable CPPC in lowlevel firmware */
+        ret = amd_pstate_enable(false);
+        if (ret)
+                pr_err("failed to suspend, return %d\n", ret);
+
+        return 0;
+}
+
+static int amd_pstate_epp_resume(struct cpufreq_policy *policy)
+{
+        struct amd_cpudata *cpudata = all_cpu_data[policy->cpu];
+
+        if (cpudata->suspended) {
+                mutex_lock(&amd_pstate_limits_lock);
+
+                /* enable amd pstate from suspend state*/
+                amd_pstate_epp_reenable(cpudata);
+
+                mutex_unlock(&amd_pstate_limits_lock);
+
+                cpudata->suspended = false;
+        }
+
+        return 0;
+}
+
+
 static struct cpufreq_driver amd_pstate_driver = {
 	.flags		= CPUFREQ_CONST_LOOPS | CPUFREQ_NEED_UPDATE_LIMITS,
 	.verify		= amd_pstate_verify,
@@ -1129,6 +1168,8 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
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

