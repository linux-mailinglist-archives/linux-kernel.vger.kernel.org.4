Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40D15F3DF9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiJDINF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJDIL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:11:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFA81117D;
        Tue,  4 Oct 2022 01:11:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E66CD1F8E6;
        Tue,  4 Oct 2022 08:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664871094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sXtW6VbAsfhLQrd3GTyybS8RtSCDFCFG8eE8+2mhkJQ=;
        b=tK5+5qWU6QqlanarLETnd9adLzur/RpmLl3bInowlpNXMZUxf9FtBqJ6g7EP/7GOC4L6mw
        wo3PqkZVCUsruha/5K6wp1US4AjMgakGA94ZpXdGTIQESNnOqJsazw6V/Y9WDAarZss0sY
        d/6Nqu9Xl4eKs5YBlR89KD7ZM9znPTY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9601D139EF;
        Tue,  4 Oct 2022 08:11:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uzBYI7bqO2OiSAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 04 Oct 2022 08:11:34 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v4 12/16] x86/mtrr: add a stop_machine() handler calling only cache_cpu_init()
Date:   Tue,  4 Oct 2022 10:10:19 +0200
Message-Id: <20221004081023.32402-13-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221004081023.32402-1-jgross@suse.com>
References: <20221004081023.32402-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having a stop_machine() handler for either a specific MTRR
register or all state at once, add a handler just for calling
cache_cpu_init() if appropriate.

Add functions for calling stop_machine() with this handler as well.

Add a generic replacements for mtrr_bp_restore() and a wrapper for
mtrr_bp_init().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- completely new replacement of former patch 2
---
 arch/x86/include/asm/cacheinfo.h |  7 +--
 arch/x86/include/asm/mtrr.h      |  4 --
 arch/x86/kernel/cpu/cacheinfo.c  | 61 +++++++++++++++++++++-
 arch/x86/kernel/cpu/common.c     |  3 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c  | 87 +-------------------------------
 arch/x86/kernel/setup.c          |  3 +-
 arch/x86/kernel/smpboot.c        |  4 +-
 arch/x86/power/cpu.c             |  3 +-
 8 files changed, 73 insertions(+), 99 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index 1339bf0908dc..77fe39a11679 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -7,14 +7,15 @@ extern unsigned int memory_caching_control;
 #define CACHE_MTRR 0x01
 #define CACHE_PAT  0x02
 
-extern bool cache_aps_delayed_init;
-
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 
 void cache_disable(void);
 void cache_enable(void);
-void cache_cpu_init(void);
 void set_cache_aps_delayed_init(void);
+void cache_bp_init(void);
+void cache_bp_restore(void);
+void cache_ap_init(void);
+void cache_aps_init(void);
 
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index 5d31219c8529..ec73d1e5bafb 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -42,8 +42,6 @@ extern int mtrr_add_page(unsigned long base, unsigned long size,
 extern int mtrr_del(int reg, unsigned long base, unsigned long size);
 extern int mtrr_del_page(int reg, unsigned long base, unsigned long size);
 extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
-extern void mtrr_ap_init(void);
-extern void mtrr_aps_init(void);
 extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
@@ -85,8 +83,6 @@ static inline int mtrr_trim_uncached_memory(unsigned long end_pfn)
 static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 {
 }
-#define mtrr_ap_init() do {} while (0)
-#define mtrr_aps_init() do {} while (0)
 #define mtrr_bp_restore() do {} while (0)
 #define mtrr_disable() do {} while (0)
 #define mtrr_enable() do {} while (0)
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 330aa412be63..5867325809a6 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -15,6 +15,7 @@
 #include <linux/capability.h>
 #include <linux/sysfs.h>
 #include <linux/pci.h>
+#include <linux/stop_machine.h>
 
 #include <asm/cpufeature.h>
 #include <asm/cacheinfo.h>
@@ -1121,7 +1122,7 @@ void cache_enable(void) __releases(cache_disable_lock)
 	raw_spin_unlock(&cache_disable_lock);
 }
 
-void cache_cpu_init(void)
+static void cache_cpu_init(void)
 {
 	unsigned long flags;
 
@@ -1138,9 +1139,65 @@ void cache_cpu_init(void)
 	local_irq_restore(flags);
 }
 
-bool cache_aps_delayed_init;
+static bool cache_aps_delayed_init;
 
 void set_cache_aps_delayed_init(void)
 {
 	cache_aps_delayed_init = true;
 }
+
+static int cache_rendezvous_handler(void *unused)
+{
+	if (cache_aps_delayed_init || !cpu_online(smp_processor_id()))
+		cache_cpu_init();
+
+	return 0;
+}
+
+void __init cache_bp_init(void)
+{
+	mtrr_bp_init();
+
+	if (memory_caching_control)
+		cache_cpu_init();
+}
+
+void cache_bp_restore(void)
+{
+	if (memory_caching_control)
+		cache_cpu_init();
+}
+
+void cache_ap_init(void)
+{
+	if (!memory_caching_control || cache_aps_delayed_init)
+		return;
+
+	/*
+	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
+	 * changed, but this routine will be called in cpu boot time,
+	 * holding the lock breaks it.
+	 *
+	 * This routine is called in two cases:
+	 *
+	 *   1. very early time of software resume, when there absolutely
+	 *      isn't mtrr entry changes;
+	 *
+	 *   2. cpu hotadd time. We let mtrr_add/del_page hold cpuhotplug
+	 *      lock to prevent mtrr entry changes
+	 */
+	stop_machine_from_inactive_cpu(cache_rendezvous_handler, NULL,
+				       cpu_callout_mask);
+}
+
+/*
+ * Delayed cache initialization for all AP's
+ */
+void cache_aps_init(void)
+{
+	if (!memory_caching_control || !cache_aps_delayed_init)
+		return;
+
+	stop_machine(cache_rendezvous_handler, NULL, cpu_online_mask);
+	cache_aps_delayed_init = false;
+}
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e508f239098..fd058b547f8d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -52,6 +52,7 @@
 #include <asm/cpu.h>
 #include <asm/mce.h>
 #include <asm/msr.h>
+#include <asm/cacheinfo.h>
 #include <asm/memtype.h>
 #include <asm/microcode.h>
 #include <asm/microcode_intel.h>
@@ -1948,7 +1949,7 @@ void identify_secondary_cpu(struct cpuinfo_x86 *c)
 #ifdef CONFIG_X86_32
 	enable_sep_cpu();
 #endif
-	mtrr_ap_init();
+	cache_ap_init();
 	validate_apic_and_package_id(c);
 	x86_spec_ctrl_setup_ap();
 	update_srbds_msr();
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 68376c924b75..61666931abc4 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -69,9 +69,6 @@ static const struct mtrr_ops *mtrr_ops[X86_VENDOR_NUM] __ro_after_init;
 
 const struct mtrr_ops *mtrr_if;
 
-static void set_mtrr(unsigned int reg, unsigned long base,
-		     unsigned long size, mtrr_type type);
-
 void __init set_mtrr_ops(const struct mtrr_ops *ops)
 {
 	if (ops->vendor && ops->vendor < X86_VENDOR_NUM)
@@ -154,25 +151,8 @@ static int mtrr_rendezvous_handler(void *info)
 {
 	struct set_mtrr_data *data = info;
 
-	/*
-	 * We use this same function to initialize the mtrrs during boot,
-	 * resume, runtime cpu online and on an explicit request to set a
-	 * specific MTRR.
-	 *
-	 * During boot or suspend, the state of the boot cpu's mtrrs has been
-	 * saved, and we want to replicate that across all the cpus that come
-	 * online (either at the end of boot or resume or during a runtime cpu
-	 * online). If we're doing that, @reg is set to something special and on
-	 * all the cpu's we do cache_cpu_init() (On the logical cpu that
-	 * started the boot/resume sequence, this might be a duplicate
-	 * cache_cpu_init()).
-	 */
-	if (data->smp_reg != ~0U) {
-		mtrr_if->set(data->smp_reg, data->smp_base,
-			     data->smp_size, data->smp_type);
-	} else if (cache_aps_delayed_init || !cpu_online(smp_processor_id())) {
-		cache_cpu_init();
-	}
+	mtrr_if->set(data->smp_reg, data->smp_base,
+		     data->smp_size, data->smp_type);
 	return 0;
 }
 
@@ -242,19 +222,6 @@ static void set_mtrr_cpuslocked(unsigned int reg, unsigned long base,
 	stop_machine_cpuslocked(mtrr_rendezvous_handler, &data, cpu_online_mask);
 }
 
-static void set_mtrr_from_inactive_cpu(unsigned int reg, unsigned long base,
-				      unsigned long size, mtrr_type type)
-{
-	struct set_mtrr_data data = { .smp_reg = reg,
-				      .smp_base = base,
-				      .smp_size = size,
-				      .smp_type = type
-				    };
-
-	stop_machine_from_inactive_cpu(mtrr_rendezvous_handler, &data,
-				       cpu_callout_mask);
-}
-
 /**
  * mtrr_add_page - Add a memory type region
  * @base: Physical base address of region in pages (in units of 4 kB!)
@@ -756,7 +723,6 @@ void __init mtrr_bp_init(void)
 			if (get_mtrr_state()) {
 				memory_caching_control |= CACHE_MTRR | CACHE_PAT;
 				changed_by_mtrr_cleanup = mtrr_cleanup(phys_addr);
-				cache_cpu_init();
 			} else {
 				mtrr_if = NULL;
 			}
@@ -775,27 +741,6 @@ void __init mtrr_bp_init(void)
 	}
 }
 
-void mtrr_ap_init(void)
-{
-	if (!memory_caching_control || cache_aps_delayed_init)
-		return;
-
-	/*
-	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
-	 * changed, but this routine will be called in cpu boot time,
-	 * holding the lock breaks it.
-	 *
-	 * This routine is called in two cases:
-	 *
-	 *   1. very early time of software resume, when there absolutely
-	 *      isn't mtrr entry changes;
-	 *
-	 *   2. cpu hotadd time. We let mtrr_add/del_page hold cpuhotplug
-	 *      lock to prevent mtrr entry changes
-	 */
-	set_mtrr_from_inactive_cpu(~0U, 0, 0, 0);
-}
-
 /**
  * mtrr_save_state - Save current fixed-range MTRR state of the first
  *	cpu in cpu_online_mask.
@@ -811,34 +756,6 @@ void mtrr_save_state(void)
 	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
 }
 
-/*
- * Delayed MTRR initialization for all AP's
- */
-void mtrr_aps_init(void)
-{
-	if (!memory_caching_control)
-		return;
-
-	/*
-	 * Check if someone has requested the delay of AP MTRR initialization,
-	 * by doing set_mtrr_aps_delayed_init(), prior to this point. If not,
-	 * then we are done.
-	 */
-	if (!cache_aps_delayed_init)
-		return;
-
-	set_mtrr(~0U, 0, 0, 0);
-	cache_aps_delayed_init = false;
-}
-
-void mtrr_bp_restore(void)
-{
-	if (!memory_caching_control)
-		return;
-
-	cache_cpu_init();
-}
-
 static int __init mtrr_init_finialize(void)
 {
 	if (!mtrr_if)
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 216fee7144ee..e0e185ee0229 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -34,6 +34,7 @@
 #include <asm/numa.h>
 #include <asm/bios_ebda.h>
 #include <asm/bugs.h>
+#include <asm/cacheinfo.h>
 #include <asm/cpu.h>
 #include <asm/efi.h>
 #include <asm/gart.h>
@@ -1075,7 +1076,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* update e820 for memory not covered by WB MTRRs */
 	if (IS_ENABLED(CONFIG_MTRR))
-		mtrr_bp_init();
+		cache_bp_init();
 	else
 		pat_disable("PAT support disabled because CONFIG_MTRR is disabled in the kernel.");
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index de2082c21e8b..fb225a02455f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1445,7 +1445,7 @@ void arch_thaw_secondary_cpus_begin(void)
 
 void arch_thaw_secondary_cpus_end(void)
 {
-	mtrr_aps_init();
+	cache_aps_init();
 }
 
 /*
@@ -1488,7 +1488,7 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
 
 	nmi_selftest();
 	impress_friends();
-	mtrr_aps_init();
+	cache_aps_init();
 }
 
 static int __initdata setup_possible_cpus = -1;
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index bb176c72891c..754221c9a1c3 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -23,6 +23,7 @@
 #include <asm/fpu/api.h>
 #include <asm/debugreg.h>
 #include <asm/cpu.h>
+#include <asm/cacheinfo.h>
 #include <asm/mmu_context.h>
 #include <asm/cpu_device_id.h>
 #include <asm/microcode.h>
@@ -261,7 +262,7 @@ static void notrace __restore_processor_state(struct saved_context *ctxt)
 	do_fpu_end();
 	tsc_verify_tsc_adjust(true);
 	x86_platform.restore_sched_clock_state();
-	mtrr_bp_restore();
+	cache_bp_restore();
 	perf_restore_debug_store();
 
 	c = &cpu_data(smp_processor_id());
-- 
2.35.3

