Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01AF654955
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 00:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiLVXcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 18:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235531AbiLVXcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 18:32:00 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FEA27B28;
        Thu, 22 Dec 2022 15:31:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4aObYBZEAjoAc4t+LKuOrXHRBroOornImjrqLXSV5X1X6Cxq5tuK0FWz/jVulZD/ERaNHmYAMBiC9Hu8RPKNtvqpoWKJogD2Ga+XOTzTiFlqfBQSfHYGhLIykSbsnv8Y2kCbWwX4kndbRQx35utIjR9Od8UpAHnRTh9ZDK7u/7JDOyAA6CaAtZzFBH6BLhnxekBo9nV7/XtGTcJACbc6aeEj7YnyLoEHBg1oL+RyHxd8zik5Ta1RwJOYz9JVIqRxogdV21ucwOHCq3i786HDHR4y/Op7x+UCJg/epn1bD8t+/M9FfIUuNtP/8KAO3TG7bBh452lUHDBMO8Ae44O5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEeciAaZNIcX84dQ2+o7NGFqkLIscB9krD01am5HSJ4=;
 b=l+WTK/NMQlHpbI+M7qxCn0J0YcIeP7i4PHrBqi/Xdfo8Yh81bFN36mzVfvcmaprzNfmcT6EWAkpapYJ0Mtyu8HYKWCmS5hkDzr1zvHMSPJR0/9czgHrhXD5As9c/+Po/i5AXjyaLRK1qo6kXhBXuyLNblE5A3/BXUsc9v/xb9k5hZs0EB7QroA9j6KBA1MHZyjgUpqhaluzZ0HXjZvp6L4kgg2R9MT8GBMKZc9bP2bFyEyDhDq2nh1F69ueRL3vvjtjChB100lIJh0hNG7XMyce64HHi7sN2VBx3EEEYEhMFOdjaiwo/8lSjgMnvNbxQd5ij9o5aJRBDHdNFFDLYzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEeciAaZNIcX84dQ2+o7NGFqkLIscB9krD01am5HSJ4=;
 b=LEYWy/MZxDqY4BTP9cdmg1OmFKYjZksgFRdap4a1QkKJagT7uZ1Au2UUm5Nt8pXEStv2StpS2ryJwY+islkc5TcQBcCFSjRdgNJT6AMuzm36H1UE6vKHCwlO7EIbdSeYlylRrilJoSDnEL/5TkOXQx71pvX1fpS45UHNfopwVtg=
Received: from CY5PR22CA0036.namprd22.prod.outlook.com (2603:10b6:930:1d::8)
 by SA1PR12MB6845.namprd12.prod.outlook.com (2603:10b6:806:25c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.12; Thu, 22 Dec
 2022 23:31:50 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:1d:cafe::80) by CY5PR22CA0036.outlook.office365.com
 (2603:10b6:930:1d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.21 via Frontend
 Transport; Thu, 22 Dec 2022 23:31:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5944.8 via Frontend Transport; Thu, 22 Dec 2022 23:31:49 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 17:31:43 -0600
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
Subject: [PATCH v10 06/13] x86/resctrl: Detect and configure Slow Memory Bandwidth Allocation
Date:   Thu, 22 Dec 2022 17:31:20 -0600
Message-ID: <20221222233127.910538-7-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|SA1PR12MB6845:EE_
X-MS-Office365-Filtering-Correlation-Id: 69aae9d1-464a-4359-374a-08dae474b33b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yHhT1cVlA55FKV5G3r1Yq+/VBx0lImRWwMFfIY3Wt0xWYQ1aNpZedDINcamuVO0GzsdVPOckkHa0mLH8HyycppDqvL58ZkAbpv3cVK1VoiGrMz40U5st/KF94uHiYIvSjnT+sKDxI8xfvgIDwu+G8x1yzHr/qmCBgWLtNjFFUXH9Rxot3FP2GmGVRIV1OCH3wbeczJi+GVHqExeiSRg/Hd4r/RMK3KANPko2UgPoDWf61y/1T8ECSdj3TAjW0cSRLnVIB0QxwgtNMdr5WVwdI7fxKSDgEsjtwafPsU+U/4pxAvDSoT/WC4M0XrAgTyT+OjeSMlVWySNe3mfBO0ojGHtci6BfnY4SRqimX29jHFBrH1BlseIfc8AX+FcmrTz64OuePmcBZiNcVQT5/aSOu3z6xnMTVi4Mhqn92t8lQrItFx0JmOB/zN3zxiGNh0daFvUdypcCo3yTaVoQb7neW3REI0Fh99zarH6Witv/rvM3L0Gj9cETSHqzy6FRoVAfAQ5tymVa0mWhJQWoLKjYjBVC69X8R2u99l5OwmlJ/INMDrcjZZrhAKIYbcHq2pWsRN9H51naHFr4/931PWhOrZg+IxSzlBfK5VCcFGirQ7e/lQ8vO79nLpYoTBUGIdUxrG1HXwqUue9p2C5xcEz1h49Vq506m1Mvnik2Xbnbl4JoqzxZKaFTrlCSX8PecOFMU65U2ZEu2FyMr2ocyNpH5MdY1b+jvRs4edfxGJlbNus=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(40470700004)(46966006)(36840700001)(16526019)(70206006)(8676002)(4326008)(70586007)(6666004)(186003)(26005)(40460700003)(2616005)(1076003)(7696005)(36756003)(478600001)(426003)(336012)(47076005)(83380400001)(81166007)(356005)(316002)(86362001)(41300700001)(54906003)(110136005)(40480700001)(36860700001)(44832011)(7416002)(5660300002)(7406005)(8936002)(82310400005)(2906002)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2022 23:31:49.8969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69aae9d1-464a-4359-374a-08dae474b33b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6845
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QoS slow memory configuration details are available via
CPUID_Fn80000020_EDX_x02. Detect the available details and
initialize the rest to defaults.

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/include/asm/msr-index.h          |  1 +
 arch/x86/kernel/cpu/resctrl/core.c        | 36 +++++++++++++++++++++--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  8 +++--
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 37ff47552bcb..e0a40027aa62 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1061,6 +1061,7 @@
 
 /* - AMD: */
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
+#define MSR_IA32_SMBA_BW_BASE		0xc0000280
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 10a8c9d96f32..b4fc851f6489 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -162,6 +162,13 @@ bool is_mba_sc(struct rdt_resource *r)
 	if (!r)
 		return rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl.membw.mba_sc;
 
+	/*
+	 * The software controller support is only applicable to MBA resource.
+	 * Make sure to check for resource type.
+	 */
+	if (r->rid != RDT_RESOURCE_MBA)
+		return false;
+
 	return r->membw.mba_sc;
 }
 
@@ -225,9 +232,15 @@ static bool __rdt_get_mem_config_amd(struct rdt_resource *r)
 	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
 	union cpuid_0x10_3_eax eax;
 	union cpuid_0x10_x_edx edx;
-	u32 ebx, ecx;
+	u32 ebx, ecx, subleaf;
 
-	cpuid_count(0x80000020, 1, &eax.full, &ebx, &ecx, &edx.full);
+	/*
+	 * Query CPUID_Fn80000020_EDX_x01 for MBA and
+	 * CPUID_Fn80000020_EDX_x02 for SMBA
+	 */
+	subleaf = (r->rid == RDT_RESOURCE_SMBA) ? 2 :  1;
+
+	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);
 	hw_res->num_closid = edx.split.cos_max + 1;
 	r->default_ctrl = MAX_MBA_BW_AMD;
 
@@ -750,6 +763,19 @@ static __init bool get_mem_config(void)
 	return false;
 }
 
+static __init bool get_slow_mem_config(void)
+{
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_SMBA];
+
+	if (!rdt_cpu_has(X86_FEATURE_SMBA))
+		return false;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+		return __rdt_get_mem_config_amd(&hw_res->r_resctrl);
+
+	return false;
+}
+
 static __init bool get_rdt_alloc_resources(void)
 {
 	struct rdt_resource *r;
@@ -780,6 +806,9 @@ static __init bool get_rdt_alloc_resources(void)
 	if (get_mem_config())
 		ret = true;
 
+	if (get_slow_mem_config())
+		ret = true;
+
 	return ret;
 }
 
@@ -869,6 +898,9 @@ static __init void rdt_init_res_defs_amd(void)
 		} else if (r->rid == RDT_RESOURCE_MBA) {
 			hw_res->msr_base = MSR_IA32_MBA_BW_BASE;
 			hw_res->msr_update = mba_wrmsr_amd;
+		} else if (r->rid == RDT_RESOURCE_SMBA) {
+			hw_res->msr_base = MSR_IA32_SMBA_BW_BASE;
+			hw_res->msr_update = mba_wrmsr_amd;
 		}
 	}
 }
diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
index 7eece3d2d0c3..eb07d4435391 100644
--- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
+++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
@@ -209,7 +209,7 @@ static int parse_line(char *line, struct resctrl_schema *s,
 	unsigned long dom_id;
 
 	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP &&
-	    r->rid == RDT_RESOURCE_MBA) {
+	    (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)) {
 		rdt_last_cmd_puts("Cannot pseudo-lock MBA resource\n");
 		return -EINVAL;
 	}
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e4e6cdc1ee62..aa469d708991 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1208,7 +1208,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
-		if (r->rid == RDT_RESOURCE_MBA)
+		if (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)
 			continue;
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
@@ -1397,7 +1397,8 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 					ctrl = resctrl_arch_get_config(r, d,
 								       closid,
 								       type);
-				if (r->rid == RDT_RESOURCE_MBA)
+				if (r->rid == RDT_RESOURCE_MBA ||
+				    r->rid == RDT_RESOURCE_SMBA)
 					size = ctrl;
 				else
 					size = rdtgroup_cbm_to_size(r, d, ctrl);
@@ -2832,7 +2833,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
-		if (r->rid == RDT_RESOURCE_MBA) {
+		if (r->rid == RDT_RESOURCE_MBA ||
+		    r->rid == RDT_RESOURCE_SMBA) {
 			rdtgroup_init_mba(r, rdtgrp->closid);
 			if (is_mba_sc(r))
 				continue;
-- 
2.34.1

