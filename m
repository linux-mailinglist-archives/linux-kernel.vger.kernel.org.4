Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92081669CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjAMPu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjAMPt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:49:56 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03337278B;
        Fri, 13 Jan 2023 07:42:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4io6oLqCKDkFizzRcSOOEPCkxDBc6NjONj+dGzu3sCex6jiig6ywTH58Obp3n8UWyvFzAnZkrEO8bQhKj3MijvkbGsQi7fV1FlWKAzvPQzD1ZQKHC3ZrtVyRAL0zsifDULgtsmeAf5P7MYy/F+LEr6S5/6zfsknCjxzJ3qBKhUYhx+cl8DrjjxXmHS9D3aui2hpgdE7bleQj61+jLRDCvVhNKQkYaHf63W3KZxDj4q1JdkHzE1xI3UAQjEmJ5F7mCwaoqo89dRxnsapVatwxlI7SBqnpgKouwhS9+thW7QhuEOPY89OXK+WcVpIFYtZmI9NEfIe57JtIgvHdruGtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgINMMaGyjGOt8j7LBPnaxnyoo4i4t2gT3dnWVHgbzM=;
 b=PEXnp83nxl76/eVg9j0+4RtsAaNqH14KF8qZuKkFVtB4dNl23Rdw9+ZM57nINm6/jVvmj2Fbx6ZbzG6tVQHTtBaIHe98Zh3nW1TJ2PoAXD4K6jhJebwYsL+fY739nSuNRkSBmZftOwOmRuIzq5uDc5RnF7Ul7jjeRJNrb5YVAgBMGGQv50ZLF4iXFSfVMDnLJMpzWczPUp0O9aZbkggi5d8qI/1dc1cS8sNFZS5wNYViqDWGBY/vziM2lLCzzZoMq84rqULZ53zOhnHe0oSl8dCHGODRUjdek7JIfg28Qlh/GL8q1tAATjQbqUN1N91D9CNdkKCEfTrm/9z7gVwu4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgINMMaGyjGOt8j7LBPnaxnyoo4i4t2gT3dnWVHgbzM=;
 b=FcBCpK0d84HEHTUHD2YlGunb9iH8axmM1Ka0Na7Ms8QCSuxZwU4386sN8O/ofLTNwKnHUEJF1eVsJFrdJRCu4ekTSNimPDTJWzAItCO280THwAVURwxBBX/6lMJ2V1CNdA5rMfZwSTQiPlfQ65suhYay49CA2Wl0iM3w/sl6ygo=
Received: from BN0PR04CA0179.namprd04.prod.outlook.com (2603:10b6:408:eb::34)
 by IA1PR12MB6412.namprd12.prod.outlook.com (2603:10b6:208:3af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 15:42:46 +0000
Received: from BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::ac) by BN0PR04CA0179.outlook.office365.com
 (2603:10b6:408:eb::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.14 via Frontend
 Transport; Fri, 13 Jan 2023 15:42:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT024.mail.protection.outlook.com (10.13.177.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.13 via Frontend Transport; Fri, 13 Jan 2023 15:42:46 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 09:21:05 -0600
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
Subject: [PATCH v12 06/13] x86/resctrl: Detect and configure Slow Memory Bandwidth Allocation
Date:   Fri, 13 Jan 2023 09:20:32 -0600
Message-ID: <20230113152039.770054-7-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT024:EE_|IA1PR12MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: d776be53-89b3-49d5-c3e5-08daf57cd15c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O0wXpAkcMBjeInTLGvoMq//jtdEwLspcSYVEkse2YEOZyrlV0+yCGC4nBPdh0Qr6RcxY2vkPm6DmFI1GUKUPP5DjtJNJgwoU3ylA9pbUaqEMtzBmHOM95ot3wjnjJybxqtEEzGc6QhCmtSyJKD5q0hPOfbM5CATxHU/nkH+FcEBqli335y+qDjCVjEOWrxxPwfb1v8pkWGXnsjoxh/4+bPCjN7bUY/15WnRsvZJeuExYx9uzcm2WkPgE8+J7PXj7SuPDApz2WjWTSzLoATilrMsTBluNnbqGH4vxxgh2NcPgiR9YthpC48opk3GxA2IkoX88ialNuM3gkGPXg2YF5ReNoLYJOKgtBQcaxqWcimLjIaBmFT+Htb6pp2UjewWsz+qya8b66TIXGO/ZPNqw912CdZjP8UaGZo8eCQx+A2K7JSqFHVDkcFG+UsTD9DbaAUZYKYHkFZOBZnzs1nHC9SBthX81cziTqRw3jaD3bXBgW0n0Vu3Wf7f1RkR6EQ5PCD0SQ6kR2mVSaH2JZh6cOTUH8P/epxYEbd1BIy14Iny8wVr18niEd+wjHEmpqSVcADneQU3LC4C/M44n6m8qjdWIeqCtADmdXLHLjqH1SOhZLL6VZCwejRwgoBdJfe9pG8Bh0Kj59pFbfBEA9kfW1yaNhxaKRmyJlg38Se88v8L+B33eVgbZRdINUGv3Ef2lejqFgCIz/cJjJ10wDAOcWYI3T2liVUV/JUIyOWXq0TU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(70206006)(82310400005)(2906002)(7416002)(7406005)(5660300002)(44832011)(36756003)(6666004)(7696005)(70586007)(2616005)(8676002)(316002)(4326008)(54906003)(41300700001)(110136005)(478600001)(40480700001)(8936002)(26005)(186003)(336012)(1076003)(16526019)(426003)(86362001)(83380400001)(36860700001)(81166007)(47076005)(356005)(82740400003)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:42:46.3145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d776be53-89b3-49d5-c3e5-08daf57cd15c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6412
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
index a85019756003..eaeeb7b415d6 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1068,6 +1068,7 @@
 
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
index d23fbc45ecd1..75169680516b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1210,7 +1210,7 @@ static bool rdtgroup_mode_test_exclusive(struct rdtgroup *rdtgrp)
 
 	list_for_each_entry(s, &resctrl_schema_all, list) {
 		r = s->res;
-		if (r->rid == RDT_RESOURCE_MBA)
+		if (r->rid == RDT_RESOURCE_MBA || r->rid == RDT_RESOURCE_SMBA)
 			continue;
 		has_cache = true;
 		list_for_each_entry(d, &r->domains, list) {
@@ -1399,7 +1399,8 @@ static int rdtgroup_size_show(struct kernfs_open_file *of,
 					ctrl = resctrl_arch_get_config(r, d,
 								       closid,
 								       type);
-				if (r->rid == RDT_RESOURCE_MBA)
+				if (r->rid == RDT_RESOURCE_MBA ||
+				    r->rid == RDT_RESOURCE_SMBA)
 					size = ctrl;
 				else
 					size = rdtgroup_cbm_to_size(r, d, ctrl);
@@ -2842,7 +2843,8 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 
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

