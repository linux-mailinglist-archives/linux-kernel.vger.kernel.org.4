Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79D3679428
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjAXJ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjAXJ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:26:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B2F3A8A;
        Tue, 24 Jan 2023 01:26:41 -0800 (PST)
Date:   Tue, 24 Jan 2023 09:26:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1674552397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JdsggK7FzLyZAwgALqWgLy7E9ToxzqebgBrgK4iiSNE=;
        b=DWd9FkbOhnimc7HBcL5cy7umwscP8sIb+gkkVd6WpYIHVDieZCp8XdbK3d21Z//TinFtPF
        Jx+3+bgMlh3LoBcNqfDD9w4EdFevGpfrEDL4fXMnQM8W5T+oDnHj2ZD9kTah2xUhspclM1
        f+HjGJnoBaSjov2ZCTmgmhtMbB1whQNDN6QFp13dKvpArWICAck3V3Nxu3ZDi3g0hrMwlA
        1OND6EhUbCRhRNDZGZ0D1TQcVMZjrd+umdW0K716E1Ed6Yv+hpXblSw23T1AWzBDPJWZLx
        dA0vcrJEQ1Ph4r+nz9vGTZOdkVeAspS00VtoUrQKS5edawyw2pVgvQHa2Vv2DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1674552397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JdsggK7FzLyZAwgALqWgLy7E9ToxzqebgBrgK4iiSNE=;
        b=lYSjkrr8ONb4y49P3+3NuXGIHDqczsHF5OJkLr8aIvuT727eQ2fbK+9X4Sr9wezb7FixtZ
        NSodPkMzF0Cw9MBw==
From:   "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Detect and configure Slow Memory
 Bandwidth Allocation
Cc:     Babu Moger <babu.moger@amd.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230113152039.770054-7-babu.moger@amd.com>
References: <20230113152039.770054-7-babu.moger@amd.com>
MIME-Version: 1.0
Message-ID: <167455239730.4906.16138208729063128746.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     5b6fac3fa44bafee12e0c3d1c5cbae6d058e9c98
Gitweb:        https://git.kernel.org/tip/5b6fac3fa44bafee12e0c3d1c5cbae6d058e9c98
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 13 Jan 2023 09:20:32 -06:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Jan 2023 17:38:44 +01:00

x86/resctrl: Detect and configure Slow Memory Bandwidth Allocation

The QoS slow memory configuration details are available via
CPUID_Fn80000020_EDX_x02. Detect the available details and
initialize the rest to defaults.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20230113152039.770054-7-babu.moger@amd.com
---
 arch/x86/include/asm/msr-index.h          |  1 +-
 arch/x86/kernel/cpu/resctrl/core.c        | 36 ++++++++++++++++++++--
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c |  2 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |  8 +++--
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 37ff475..e0a4002 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1061,6 +1061,7 @@
 
 /* - AMD: */
 #define MSR_IA32_MBA_BW_BASE		0xc0000200
+#define MSR_IA32_SMBA_BW_BASE		0xc0000280
 
 /* MSR_IA32_VMX_MISC bits */
 #define MSR_IA32_VMX_MISC_INTEL_PT                 (1ULL << 14)
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 10a8c9d..b4fc851 100644
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
index 7eece3d..eb07d44 100644
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
index d23fbc4..7516968 100644
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
