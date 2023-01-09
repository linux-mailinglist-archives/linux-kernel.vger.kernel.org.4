Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0134B662B8C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236594AbjAIQo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbjAIQoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:44:18 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5412E5F43;
        Mon,  9 Jan 2023 08:44:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLqZlaYUgv7rch+8lqIa3hINX3TutW+jFvqXqe4NcXlZ8z5AZv1lgxB6Q+DUXz1udvngf1TSWgi8nvCwih+OxkcugdB+EJPv79v7uEF480AMpXIGtVuAR4Msj105+AgoyxWTH89is954UMFasg/CzvHvBt6bP/8XaBWTSTDptiD6BpCMT88WBxFpMRE/vvCvv123kswpERh1bLZ5QZ2LkI1MRwbfFpzjqXgALtNc6mHOOOZyipNQxyhlU7xKfPKlzE8jpADi1rw2eQbE5dmihEYXxsM3CEDFs81DukLXZ7cOjQIzzWqy//fuyshDWLBLTYV88txUtOhIieAFohKG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgVeecox9aCJooi/qcyiRrJ1TSTmj4nKFh4IAaq/f3g=;
 b=f0gJotOHTl8bIhXfbRuJOdKZAjx+iUISPQN1O/im3hMf/5sjA8HwOPuz1VyRd3THvN9QUKzD0t+pCaCkI7lgMObgOVNci5MJVLy/6YN0fPRtwsAviFH2ChD+l525tZqFk0qNRjSR5N6JODgX/iPzoel+64L+J/6UI339S1q3rde7E8JF927HP4QOfEWzveNFRTyVQQHjgpUQkkA1v3tVb8NQuVVHLDhNICR2DX8W4p+QAflp7vf0cRi0ZW5onKKA5Lc+9xlLKzQc+HB14xHXyBE04W05wrGPxGxsryqmdT+WYz/iARuMy+EbKi0HvFUADt4VtZjou1VHfD+W+229zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgVeecox9aCJooi/qcyiRrJ1TSTmj4nKFh4IAaq/f3g=;
 b=3dVjJ5vOan3xQhVGWScU0GP8Hz0eKfSzW5cpZ7Nd0pJzGLaOjihSw0vNvy5hUG4eEsLsXD2Mw7IftSp6XEdlo/MFa6W5X7Z9gvFF8azNVP9a9dalLPP3XJuv3a7HcuO1dpgeTEuf0B2HsUuzY4DOMxCa/k4fY30oVTdL17n5vYE=
Received: from DM6PR12CA0035.namprd12.prod.outlook.com (2603:10b6:5:1c0::48)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5986.18; Mon, 9 Jan 2023 16:44:14 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::67) by DM6PR12CA0035.outlook.office365.com
 (2603:10b6:5:1c0::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18 via Frontend
 Transport; Mon, 9 Jan 2023 16:44:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 16:44:14 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 10:44:12 -0600
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
Subject: [PATCH v11 01/13] x86/resctrl: Replace smp_call_function_many() with on_each_cpu_mask()
Date:   Mon, 9 Jan 2023 10:43:53 -0600
Message-ID: <20230109164405.569714-2-babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230109164405.569714-1-babu.moger@amd.com>
References: <20230109164405.569714-1-babu.moger@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e788f38-2767-443e-4dde-08daf260be39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EvgQHjSDaGALReu6DxmxF/BcARTwxnQQibeHXgNPWnuY2kZ7y7+VXxtkz0qivNRK+EVPsBv7NpfZ7eG3Ov6zoFIOqSnEAtYpbdcetNIBhmNlRKpjZMw2zSgFE8bVDsCFF9JIZ85rPjaevqU9SWB4QOfIFLrzQuqymTyCrcH6dQ7ZydIZjYZc/1fFxjIqBfVKtexx+BdjyIyqpyLhWQCyYuCDhgDacA5GQhYzdyFlBTkt2+gNvgP2WN86VgLWFIipP0khxauSgNCWmKCfDRlduhuTGbhHT4eQ1Cv05luLoLyINQiLPf3DDxNYqgEp21gu6/aakxfMW0MR4fHIPnpjFl1NdBOeIbJ9LOOjvsExpU0xqZ1WJ4Vd0Sa8plzxjnLgIvtzL0xlJqgbtNPD5XmGnw/gViTLt9W/XObP0QjmheSp10PkB9oHMN1C5GbNmlcfc/2PnyR2Fiwop56hv163qOykF5+EzqYawUuCMjvCheQCL5MFL9gk4u4E3gtRYVFcsC62BkVKuJm/rz0RB8Y+YZ1AC5WhmNCG1CimEKiyK84k/yU114RswFchnTG0W6/JWXGMUPJ+KyakN2uIL+pjrDvkSa47py+pGMFRuOrza3F/XmO5moLKdAGtolYiMz8JhuxfKm1b3I0zbaCnD51u8VPALEm96+lAu+vJYSmfZSSbhxOllZqStwyhUX5griT7g59RA2T5cSCGFdxSzd+94lamQXk2JsoKeVNN6wZwSLM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(36840700001)(40470700004)(46966006)(478600001)(426003)(47076005)(36756003)(86362001)(110136005)(82740400003)(54906003)(40460700003)(7416002)(5660300002)(4326008)(70586007)(70206006)(8676002)(7406005)(41300700001)(8936002)(356005)(81166007)(26005)(316002)(7696005)(83380400001)(36860700001)(2906002)(44832011)(186003)(16526019)(1076003)(2616005)(336012)(6666004)(40480700001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:44:14.7774
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e788f38-2767-443e-4dde-08daf260be39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
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

