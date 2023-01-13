Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877A8669C22
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjAMP24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjAMP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:28:19 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE9E75D12;
        Fri, 13 Jan 2023 07:21:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Blg/I62q3EvqrQFF/P+qiGo3FT5UZtWNKWwYWrErFx5FeHwex3/nXMN9YPHad/ZAMEGdeJaDKE8JQivHwuO0mx/VulQ+J7/QaQoC2k0Ye3okzBK1lWrJqzIw95HwsQPiobvteiZEckS7nrA6XKQiZjn16Q1GJIucCcX3xYJWCI1hAzt5jsxpuwpWIT3jml4cT4NFS0Uh3alsrYVe+IkTXwBXd0TTWS1rSyYhf/X4I9mH5a8xDzO/tMB/db3JF7MW1fYzOG8DQixWf1XrOo86+UlUYKLiR4LXY+7fBFegnrfsFy9JMI/HCCbfpmUAxMam4+e27xjOFf56cP3AN/XokQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lz96FydM6N0HqNepUYg1z5NtBOEohclEsRdt6b2Pk1Q=;
 b=mT4sGAxYo/XP4Jy0PRBQgIcU1VmLqjc0DYFvC4rpGuZNu/PpOEtivN02oYkcO2DrS7PjbOXVVu57A/qY8sQVY8zzQtKlgjElT+2EHiLR3xwutrvlx6MKIsNEGjAx2zh7AHiJAgv0LdslVPVGiyb8bmkkwvsRWb08gZJhSvdi62H/waO5vLBR4Bmb4vLVfxyVZB0p17oJkPB9A41SveYBvZJApWfN0+ImlTeubu948ko8d0a6jEMEQjiILas5MxOxQweHyVeoZEGsVSy2zEBmL2HyQvzQzFyhE1PiDMDNeK+SooT20uet7oxTS/kljwVx5sdEdnUU31EbrIUrmjdiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lz96FydM6N0HqNepUYg1z5NtBOEohclEsRdt6b2Pk1Q=;
 b=l9s6g7EHHfrAcSLfWB3CTKD5ZaEeXcaFu5gU8hSQ/YHPCTr1pyx6cjUd7Z6gDIYWx49ZLVuQ9nUih2DZVNrveU2ogeS0znLyWwfeXqWAf2cL0yAnrhqej75iVtGPgzhpqtQWB458n3NFzjGgbAf0JA+rxmGhibRlpyHO6HvvGXc=
Received: from BN8PR07CA0017.namprd07.prod.outlook.com (2603:10b6:408:ac::30)
 by MN2PR12MB4343.namprd12.prod.outlook.com (2603:10b6:208:26f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Fri, 13 Jan
 2023 15:21:47 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::15) by BN8PR07CA0017.outlook.office365.com
 (2603:10b6:408:ac::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.16 via Frontend
 Transport; Fri, 13 Jan 2023 15:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 15:21:47 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 09:20:57 -0600
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
Subject: [PATCH v12 01/13] x86/resctrl: Replace smp_call_function_many() with on_each_cpu_mask()
Date:   Fri, 13 Jan 2023 09:20:27 -0600
Message-ID: <20230113152039.770054-2-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113152039.770054-1-babu.moger@amd.com>
References: <20230113152039.770054-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|MN2PR12MB4343:EE_
X-MS-Office365-Filtering-Correlation-Id: 846f362b-34b7-419e-3070-08daf579e2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NvEPkJcaifwMgefK1NZlxY0T6eTlKgN6N8fUO3Gcp6oGBqE6eRK6pfhinF8u32fOx2Gd8XfD9md5vXx7s4xXq62IKVExWgRxRz8KJmrthXDwFW/BrEKnEvd8KODCi8ledUCv8qlRQJOmL4O00+SFDJXBgEx8W7oH5bmc6/cKTMOKCMyVPT+nnpv4aPrx9SfJrLt82CjmOGRr0igJOy8m12a86CZuuUAgiD1E5WO7cTelhdPsd/JnaVHCMLh9Fa/6HBGeOrTzxsiQZCzua4Al5ZUV2QWD0CWndjUuzAop1oo39UW2fJAzawj8Q7Oik+Fni7Qp16jluBI0uWULotsqcKR4KWqvCBFwzryLcU4mtWhFErl9a0LnlbQYYpSm5Y6rm/QVXljLmQZsEpsEmm2RLFAoM3onUbw6uk/8zFwoQKKD+u/oAEPYE+my4ssBj7gkLqvjreHBb26HoreR+YhRSS1HwY3xNCrBbroD7ByxpO09sI6emcvW3oCKWVcBQQE82FmhY/EasEwKv70IfOZbK1XeBrccPXuLMfb72cty0i3MidjWfx4M3F53Whyva+s1tXTd8I0pnUMKZ9qvawKvdDRZyE1oZQq4grt+cMksGBvMjJ/oyBYMk+xjsLFK7K8sU4caGcb/pRjb1knlHfgyzsK8RCyqnWTZ/rdW+qnHuWlzJAHXIduELxHpLQUJlZOm0igdLJiBfn4UKqTP+1UytHw5dGcOlALFVh28Qmd6Jw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(41300700001)(426003)(7416002)(47076005)(44832011)(7406005)(5660300002)(8936002)(6666004)(2906002)(83380400001)(36860700001)(336012)(82740400003)(8676002)(70586007)(70206006)(81166007)(356005)(1076003)(316002)(54906003)(478600001)(7696005)(36756003)(40460700003)(110136005)(4326008)(40480700001)(2616005)(82310400005)(86362001)(186003)(26005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:21:47.3878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 846f362b-34b7-419e-3070-08daf579e2fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4343
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

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
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
index 5993da21d822..d23fbc45ecd1 100644
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
@@ -1866,13 +1861,9 @@ static int set_cache_qos_cfg(int level, bool enable)
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
 
@@ -2349,7 +2340,7 @@ static int reset_all_ctrls(struct rdt_resource *r)
 	struct msr_param msr_param;
 	cpumask_var_t cpu_mask;
 	struct rdt_domain *d;
-	int i, cpu;
+	int i;
 
 	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
@@ -2370,13 +2361,9 @@ static int reset_all_ctrls(struct rdt_resource *r)
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

