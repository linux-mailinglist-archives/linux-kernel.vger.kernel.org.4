Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3FD65494A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbiLVXbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:31:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiLVXbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:31:41 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2076.outbound.protection.outlook.com [40.107.212.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35573AD;
        Thu, 22 Dec 2022 15:31:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FSuMxC2RL5NL77uvsoNl0rQNxQSx+6fOrNA3J4ofvRrxaHZzT0JeTf9mh7KEnGWEOoNqC4hl+JeMkrShx3glQqZYl4mlytny0Xh3eLZxH+bTt5TO54RKOjBjkYdYWs9oyYZEWX4wslbo14vtcGtrIJlUMW3lH61u2XMBW4Fqre6Dto5sjfO9Jqcy3Z/CfOM/X4KhQNLapeo+pBiqxgQ6cW7U9fP2YS5hNHGrROvteVHxStv8uxPLOtXuztuSJ4v6uhCBYUS6fIOpGE/N1K2yldrb6dS9K2zsAyP5aMqqJWOcinMNGMh6smGJnIywHteRlmBwrSj26iv8irmOEb1vEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BndlPIIiJPlr/hda6D6rK6HZPNq2hN+cAU2cFMRHg0g=;
 b=P199zWRcFM1/pw4lBtDVJ7mHzRAB4wxd2o7PfHg064TcXfhLcaovim6xBfciRhqjQ5DSZzF2MYV/7BPpN1GPUH9t4pRQaFXdFDNHv9YIbSia0Jsvi5Qxio1s4RlUEfBiZMTN7A7sUQ+kQ93NLd8MRxiOqfLms3pooSnAoSzv1nX2YcO1tfV3nRTt/2hnkhE2QwABMnLPnsSmIA6SITUWkp2Az3juD/X3StxFD7pU2zu3xwSWCzTK3+47qiV0hybjb7CF5hABzFhr1zDI+vhSe1Mo9a8XCdH/gGoo4GWrsogb0se8VDUn9eV1By8P7dyglfdngVoRT8n7j714LRraIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BndlPIIiJPlr/hda6D6rK6HZPNq2hN+cAU2cFMRHg0g=;
 b=JVMcuurHoKn5CmX92kC+QhGaFy13cbeu8nF58iFCMwBwtGHoaDxZIAuQe6aco8Pb8HpKltQZ2ucziKTjc3gKYxgn4DyKc/PYxQvofPT5IZR8AsN7YQmUE2ml7qg7wJHZtDJtvQD9Lfx5Mt5K9KGtl0nXnjuicfZVUJvZgae+Lq4=
Received: from CY5PR19CA0118.namprd19.prod.outlook.com (2603:10b6:930:64::22)
 by BN9PR12MB5163.namprd12.prod.outlook.com (2603:10b6:408:11c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Thu, 22 Dec
 2022 23:31:37 +0000
Received: from CY4PEPF0000C977.namprd02.prod.outlook.com
 (2603:10b6:930:64:cafe::ea) by CY5PR19CA0118.outlook.office365.com
 (2603:10b6:930:64::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Thu, 22 Dec 2022 23:31:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C977.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Thu, 22 Dec 2022 23:31:37 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 17:31:35 -0600
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <reinette.chatre@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>, <babu.moger@amd.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
Subject: [PATCH v10 01/13] x86/resctrl: Replace smp_call_function_many() with on_each_cpu_mask()
Date:   Thu, 22 Dec 2022 17:31:15 -0600
Message-ID: <20221222233127.910538-2-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222233127.910538-1-babu.moger@amd.com>
References: <20221222233127.910538-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C977:EE_|BN9PR12MB5163:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dd387b1-5f80-4476-7634-08dae474abb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nJsTki0WADw85wBQmFeGJ4CRWS5l169OSAialcA1FfQebjDw9U66jYmQ2FnYJEA9ZWiq0a4q8pVhKWyJ5D6ZgK1hp2t9MCE337unBH8lRddVFCftfYOSj5feChUTK9UFjZT4w+pDDy+IUjVonSv7Dj36gLPWw4mBE1Y3/JykZWhU+85IH0n8Y6DkIon3FPem+jPmF/xoPcRo916t1jz7qt1EllAj/ogHk+THgx0w5jiUlLJHUWMEacDE+h8PWqOq3xrXGa2EgGjsc6bQDj6+ZeWngI7mEarEIsqUuoEkKoU9iLHT27p6VE5p8DKkCwYAAMoh9Dk8WTA8v3+H3BsYn/gq223sCrKPJFoiUvCRzebMK+fQ0fk4CQzllNp3mPVgigkSLbRLfZtu+iOktkqjvftJOg78vCRiBUxNRKYKh/bonOSiayey3T0w13fBU/ntYutl/VXFpyh5+5opZMCxHpfOZHNsXpNfmufP5niDL/p38OASencZVBIWS4LW8lqs8Ig5I/H1m6AOkGHJ+mOTm/ZPSG8XW+mFIRBDfpGKj5vm4nD28aAGoU3zrQxVz+0P3n8rDWxkit2CxY4IrgJEhAzN2cbDo8/cZXvCHeVSkFmlMCQqWNimVy0Sta1ykNNM1O7/fbn3tR8SsEdbRV0f68KXU3kpNxNdBuu3PBaV7qx9tOGl7DoSWuxa2lHv0Dk3xbhLZc3uT1fHaBPbr35cWQfDsWtFQfCwFxFFSVpG2LU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(40470700004)(36840700001)(46966006)(2906002)(44832011)(7406005)(7416002)(5660300002)(110136005)(36860700001)(8676002)(8936002)(70206006)(70586007)(6666004)(4326008)(316002)(41300700001)(1076003)(36756003)(47076005)(40460700003)(26005)(16526019)(54906003)(82310400005)(7696005)(186003)(2616005)(86362001)(356005)(336012)(83380400001)(40480700001)(478600001)(426003)(81166007)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 23:31:37.3181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dd387b1-5f80-4476-7634-08dae474abb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C977.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

on_each_cpu_mask() runs the function on each CPU specified by cpumask,
which may include the local processor.

Replace smp_call_function_many() with on_each_cpu_mask() to simplify
the code.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 11 +++------
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 29 +++++++----------------
 2 files changed, 11 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 1df0e3262bca..7eece3d2d0c3 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -310,7 +310,6 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 	enum resctrl_conf_type t;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
-	int cpu;
 	u32 idx;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
@@ -341,13 +340,9 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
 
 	if (cpumask_empty(cpu_mask))
 		goto done;
-	cpu = get_cpu();
-	/* Update resource control msr on this CPU if it's in cpu_mask. */
-	if (cpumask_test_cpu(cpu, cpu_mask))
-		rdt_ctrl_update(&msr_param);
-	/* Update resource control msr on other CPUs. */
-	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
-	put_cpu();
+
+	/* Update resource control msr on all the CPUs. */
+	on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);
 
 done:
 	free_cpumask_var(cpu_mask);
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e5a48f05e787..e4e6cdc1ee62 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -325,12 +325,7 @@ static void update_cpu_closid_rmid(void *info)
 static void
 update_closid_rmid(const struct cpumask *cpu_mask, struct rdtgroup *r)
 {
-	int cpu = get_cpu();
-
-	if (cpumask_test_cpu(cpu, cpu_mask))
-		update_cpu_closid_rmid(r);
-	smp_call_function_many(cpu_mask, update_cpu_closid_rmid, r, 1);
-	put_cpu();
+	on_each_cpu_mask(cpu_mask, update_cpu_closid_rmid, r, 1);
 }
 
 static int cpus_mon_write(struct rdtgroup *rdtgrp, cpumask_var_t newmask,
@@ -1864,13 +1859,9 @@ static int set_cache_qos_cfg(int level, bool enable)
 			/* Pick one CPU from each domain instance to update MSR */
 			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 	}
-	cpu = get_cpu();
-	/* Update QOS_CFG MSR on this cpu if it's in cpu_mask. */
-	if (cpumask_test_cpu(cpu, cpu_mask))
-		update(&enable);
-	/* Update QOS_CFG MSR on all other cpus in cpu_mask. */
-	smp_call_function_many(cpu_mask, update, &enable, 1);
-	put_cpu();
+
+	/* Update QOS_CFG MSR on all the CPUs in cpu_mask */
+	on_each_cpu_mask(cpu_mask, update, &enable, 1);
 
 	free_cpumask_var(cpu_mask);
 
@@ -2347,7 +2338,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
-	int i, cpu;
+	int i;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
@@ -2368,13 +2359,9 @@ static int reset_all_ctrls(struct rdt_resource *r)
 		for (i = 0; i < hw_res->num_closid; i++)
 			hw_dom->ctrl_val[i] = r->default_ctrl;
 	}
-	cpu = get_cpu();
-	/* Update CBM on this cpu if it's in cpu_mask. */
-	if (cpumask_test_cpu(cpu, cpu_mask))
-		rdt_ctrl_update(&msr_param);
-	/* Update CBM on all other cpus in cpu_mask. */
-	smp_call_function_many(cpu_mask, rdt_ctrl_update, &msr_param, 1);
-	put_cpu();
+
+	/* Update CBM on all the CPUs in cpu_mask */
+	on_each_cpu_mask(cpu_mask, rdt_ctrl_update, &msr_param, 1);
 
 	free_cpumask_var(cpu_mask);
 
-- 
2.34.1

