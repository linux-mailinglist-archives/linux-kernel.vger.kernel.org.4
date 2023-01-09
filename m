Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8940C662B97
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjAIQpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjAIQo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:44:28 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BBC5F43;
        Mon,  9 Jan 2023 08:44:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BO66cnmEe3396n36Y2+RRdIbszE3s/sPUvPi5LUQOcg5uGymLbHbPDOtPG7b9YsBIVDQZJW7+EOhNU60T9GFLIqfGF8oNPwr2pIktFd8l798ysBATGSyAQh+Kopt4se25O9c9x1QmFOkWjK0jUeDz2DaOUfA/IRmjmXe9QVNL7PeV7J6D6UqeFo4XaQ/04uXCh3r+S+DGnmPtmddq86mV2fDF4OkKDZfmQtj7UAUFSsi1e5MfRTK59VGtzEEwuCAG1z6/bgmMtN97soyzEKQVOnjH7IOLFQTxwyactSdEGO02DxIUL4GiS3ScRx+HsEPxv9dtxYrxHweVnV8zUhlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mEeciAaZNIcX84dQ2+o7NGFqkLIscB9krD01am5HSJ4=;
 b=az/NyDdyWJmlc4mxzlCDMAo8mlvV+QWm5i7HHpx869MsY1U8EE4FgA3gm0NuT9XEh9RoneleXvvkDHnT3pCBWVP4kM9wIQOzGcym5c3pCcBM6LB/TzNyo1kss5fe2KCIXJ3Jaan02LJ8XwOdPJ5uuwrdcsVyyFVBKfOPPzeQAIh1VZ4ASxLGMAwtjPqTX1+LJ91msl28HAPMM2QfA+nLhdP0uJc/pr4jo1f9+JzC7+hVZVO17ZKDAnzncCYrmjvEljl5N1jUGsFLbS3jhKA116wJdgnMvTJUtSAQ/z/tAp3ftx9dRoEtSBPEvWyauaQOasjCPwJoHudYOGmAjRvtqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mEeciAaZNIcX84dQ2+o7NGFqkLIscB9krD01am5HSJ4=;
 b=wuRdGIP2ivi77xlDEqNHsIZrpFSaFIBNkTiuzs6AAEtkAwDwywqZvq3igE9qBPB7Lfh3gVrw2YDZ9aZv5rH9OtEU4f+uPbSDzNGSJGgSB3CuXM4/M0eacp7z/Y71nHECCXpuq0hrAeCO8n3pAUZI6xxX4bMtnMypKZ4iWSsaiDE=
Received: from DS7PR05CA0092.namprd05.prod.outlook.com (2603:10b6:8:56::10) by
 IA1PR12MB8334.namprd12.prod.outlook.com (2603:10b6:208:3ff::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 16:44:23 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::a9) by DS7PR05CA0092.outlook.office365.com
 (2603:10b6:8:56::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11 via Frontend
 Transport; Mon, 9 Jan 2023 16:44:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.18 via Frontend Transport; Mon, 9 Jan 2023 16:44:23 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 10:44:21 -0600
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
Subject: [PATCH v11 06/13] x86/resctrl: Detect and configure Slow Memory Bandwidth Allocation
Date:   Mon, 9 Jan 2023 10:43:58 -0600
Message-ID: <20230109164405.569714-7-babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|IA1PR12MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: d22b1dda-8fa8-49a2-38e4-08daf260c36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVTkeOX+jK8Q+uecXvpUwTuVudWz56tgLQY7Thizv9NhybejAYPKfIqo65eBoBLKRghIKHtEJoHzAACcZ0W4CHi5Ub3rOiyqi+ygZZdiCFXUEZGkUtl97uusQAuxyHUmtXh5QjYe/r5BSdXpyyY9W4J9ZPzkLenla2dZMfc02iecF4d3WmFzwqjjtYNX8Nm+B74wiiEf24KHZufIukRmuE+6Z/OoN8gW4pB/fvQAT15map4SFKWiiGyY3SI1YPFWYTq6GbeskC9yQCWC8jenVYn6JSvrn5zNtREsCTFmsdk7wC075auyaxQSYnjTVlAYHPrBvOZdiaT5F6WVNxV4fhMTiZ8ENanbmYVHOk4CghieIDqPwTIoxk+1zBRHR2bNJ8jko5Mr39HbC08OSXwUmIheMquH/4MIEo7EgqmGsMi+UJFI00ZZAgTJdmC9xB/f7p/c+cqtnb8Ngy3x4GZnRPEBpLI392cvdmoe0fUPlfxBrh96+WJHRU4mpUxDtKgG3F/Ct9C+qq8JD9rU1d4rgz7zPkfuVwWEGGVztcfL6lJF/1NfccLTROx39J96i9JiCqGMFlGbtjI1Hk/B35yxcacohiFdooN5AFqVsLVH7VsVmnChWMtVN27bl0e1mxAcNHFBYNF21V04vrnx1HS9eV+2ssUw/LbP6dNwjhheG8folzlnoV57s28vTcopYSd/Hl/BNDlSWLzF8Y5r8/Hoe8DtUA/mY0oOPPqigJci5F4=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(356005)(81166007)(36860700001)(83380400001)(86362001)(70206006)(8676002)(4326008)(41300700001)(70586007)(54906003)(40460700003)(110136005)(426003)(316002)(40480700001)(44832011)(7406005)(7416002)(5660300002)(2906002)(8936002)(47076005)(1076003)(336012)(16526019)(82310400005)(2616005)(26005)(186003)(478600001)(7696005)(6666004)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:44:23.4866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d22b1dda-8fa8-49a2-38e4-08daf260c36a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8334
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

