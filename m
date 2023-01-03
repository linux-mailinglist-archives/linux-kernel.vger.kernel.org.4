Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E2965C59D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238636AbjACSC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238611AbjACSCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:02:32 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6C812758
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 10:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672768949; x=1704304949;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q0x8csfN7wsoyn+pz3gFYTMKHtMvDkQiL+H6SEMMaV0=;
  b=KUutnocCm0kC6JwAwaC6WB3XDoILk/3b1KxeYl/DWHVSoLpp0jmV+X00
   drKh3ejOl+xqtEJucjyo35S6OP2RTnRiA8fzh737p4fqgJTTcb7Oo6Puw
   KKoGD0GLlxuMkgrGn2u5mrKMHVyvPsmWwx0+dEDGmmvcytCsn4tzhh8Pa
   rxyWjy2nLUfFKceviNHeCHsr8+j0PrFdPUKAmzx9/xHDRCwkQ8rWBAwoE
   OVSiR9Raf1H1g3Ln+sdFA4ziF/fJ4Hp2RxnNZp3kSMMoYGHhfIes3m2EY
   KiwC/lq2wX5ebBAke+5DY5oLUdrMenNPFslCLDFJPSKTriPejR15KKugk
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="384010641"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="384010641"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 10:02:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="654876882"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="654876882"
Received: from araj-ucode.jf.intel.com ([10.23.0.19])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 10:02:24 -0800
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH v3 2/6] x86/microcode/core: Take a snapshot before and after applying microcode
Date:   Tue,  3 Jan 2023 10:02:08 -0800
Message-Id: <20230103180212.333496-3-ashok.raj@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103180212.333496-1-ashok.raj@intel.com>
References: <20230103180212.333496-1-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel caches features about each CPU's features at boot in an
x86_capability[] structure. The microcode update takes one snapshot and
compares it with the saved copy at boot.

However, the capabilities in the boot copy can be turned off as a result of
certain command line parameters or configuration restrictions. This can
cause a mismatch when comparing the values before and after the microcode
update.

microcode_check() is called after an update to report any previously
cached CPUID bits might have changed due to the update.

microcode_store_cpu_caps() basically stores the original CPU reported
values and not the OS modified values. This will avoid giving a false
warning even if no capabilities have changed.

Ignore the capabilities recorded at boot. Take a new snapshot before the
update and compare with a snapshot after the update to eliminate the false
warning.

Fixes: 1008c52c09dc ("x86/CPU: Add a microcode loader callback")
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: x86 <x86@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
---
Changes since last post

- Boris
	- Change function from copy_cpu_caps() -> store_cpu_caps()
	- Keep microcode_check() inside cpu/common.c and not bleed
	  get_cpu_caps() outside of core code.

- Thomas : Commit log changes.
---
 arch/x86/include/asm/processor.h     |  1 +
 arch/x86/kernel/cpu/common.c         | 31 +++++++++++++++++++++-------
 arch/x86/kernel/cpu/microcode/core.c |  7 +++++++
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 387578049de0..ac2e67156b9b 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -697,6 +697,7 @@ bool xen_set_default_idle(void);
 #endif
 
 void __noreturn stop_this_cpu(void *dummy);
+void microcode_store_cpu_caps(struct cpuinfo_x86 *info);
 void microcode_check(struct cpuinfo_x86 *info);
 
 enum l1tf_mitigations {
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b9c7529c920e..7c86c6fd07ae 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2297,28 +2297,43 @@ void cpu_init_secondary(void)
 #endif
 
 #ifdef CONFIG_MICROCODE_LATE_LOADING
+
+void microcode_store_cpu_caps(struct cpuinfo_x86 *info)
+{
+	/* Reload CPUID max function as it might've changed. */
+	info->cpuid_level = cpuid_eax(0);
+
+	/*
+	 * Copy all capability leafs to pick up the synthetic ones so that
+	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
+	 * get overwritten in get_cpu_cap().
+	 */
+	memcpy(info->x86_capability, &boot_cpu_data.x86_capability,
+	       sizeof(info->x86_capability));
+
+	get_cpu_cap(info);
+}
+
 /*
  * The microcode loader calls this upon late microcode load to recheck features,
  * only when microcode has been updated. Caller holds microcode_mutex and CPU
  * hotplug lock.
  */
-void microcode_check(struct cpuinfo_x86 *info)
+void microcode_check(struct cpuinfo_x86 *orig)
 {
-	perf_check_microcode();
+	struct cpuinfo_x86 info;
 
-	/* Reload CPUID max function as it might've changed. */
-	info->cpuid_level = cpuid_eax(0);
+	perf_check_microcode();
 
 	/*
 	 * Copy all capability leafs to pick up the synthetic ones so that
 	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
 	 * get overwritten in get_cpu_cap().
 	 */
-	memcpy(&info->x86_capability, &boot_cpu_data.x86_capability, sizeof(info->x86_capability));
-
-	get_cpu_cap(info);
+	microcode_store_cpu_caps(&info);
 
-	if (!memcmp(&info->x86_capability, &boot_cpu_data.x86_capability, sizeof(info->x86_capability)))
+	if (!memcmp(&info.x86_capability, &orig->x86_capability,
+		    sizeof(info.x86_capability)))
 		return;
 
 	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index d86a4f910a6b..14d9031ed68a 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -447,6 +447,13 @@ static int microcode_reload_late(void)
 	atomic_set(&late_cpus_in,  0);
 	atomic_set(&late_cpus_out, 0);
 
+	/*
+	 * Take a snapshot before the microcode update, so we can compare
+	 * them after the update is successful to check for any bits
+	 * changed.
+	 */
+	microcode_store_cpu_caps(&info);
+
 	ret = stop_machine_cpuslocked(__reload_late, NULL, cpu_online_mask);
 	if (ret == 0)
 		microcode_check(&info);
-- 
2.34.1

