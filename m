Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C079615D2B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbiKBHtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiKBHsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:48:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6FC2610D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:48:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BDBF21F8B0;
        Wed,  2 Nov 2022 07:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667375320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SkMhXh10I996ogHNk1iHONe/Tn2QI4iwdDoxFOo7ziE=;
        b=cb6qsJD1Rkw1pfAhLr10zuRBQukLiY/H3TeGxwjAIRapVdkuRuxjlo+tDPenQTTeASmlfP
        hA4a78kWEQCMmPlWT563YnpAX3ey8KBNwLCNDxzDx+w72hWxcrVogIbGch8A+KRvMz4/Xc
        xPLB9ZBu2e7J2pK+IU4eBCILKwXvaxw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8208C1376E;
        Wed,  2 Nov 2022 07:48:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nX1lHtggYmNRcwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 02 Nov 2022 07:48:40 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 15/16] x86: do MTRR/PAT setup on all secondary CPUs in parallel
Date:   Wed,  2 Nov 2022 08:47:12 +0100
Message-Id: <20221102074713.21493-16-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221102074713.21493-1-jgross@suse.com>
References: <20221102074713.21493-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of serializing MTRR/PAT setup on the secondary CPUs in order
to avoid clobbering of static variables used by the setup process, put
those variables into a structure held on the stack and drop the
serialization.

This speeds up the start of secondary CPUs a little bit (on a small
system with 8 CPUs the time needed for starting the secondary CPUs was
measured to go down from about 60 milliseconds without this patch to
about 55 milliseconds with this patch applied).

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V4:
- new patch
---
 arch/x86/include/asm/cacheinfo.h   | 10 ++++++--
 arch/x86/include/asm/mtrr.h        | 13 +++++-----
 arch/x86/kernel/cpu/cacheinfo.c    | 28 ++++++++-------------
 arch/x86/kernel/cpu/mtrr/generic.c | 40 ++++++++++++++----------------
 4 files changed, 45 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index ce9685fc78d8..f66578e1e4e1 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -10,8 +10,14 @@ extern unsigned int memory_caching_control;
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 
-void cache_disable(void);
-void cache_enable(void);
+struct cache_state {
+	unsigned long cr4;
+	u32 mtrr_deftype_lo;
+	u32 mtrr_deftype_hi;
+};
+
+void cache_disable(struct cache_state *state);
+void cache_enable(struct cache_state *state);
 void set_cache_aps_delayed_init(bool val);
 bool get_cache_aps_delayed_init(void);
 void cache_bp_init(void);
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index f0eeaf6e5f5f..2ea4a9de7318 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -23,6 +23,7 @@
 #ifndef _ASM_X86_MTRR_H
 #define _ASM_X86_MTRR_H
 
+#include <asm/cacheinfo.h>
 #include <uapi/asm/mtrr.h>
 
 /*
@@ -44,9 +45,9 @@ extern void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi);
 extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
-void mtrr_disable(void);
-void mtrr_enable(void);
-void mtrr_generic_set_state(void);
+void mtrr_disable(struct cache_state *state);
+void mtrr_enable(struct cache_state *state);
+void mtrr_generic_set_state(struct cache_state *state);
 #  else
 static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
 {
@@ -84,9 +85,9 @@ static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 }
 #define mtrr_bp_init() do {} while (0)
 #define mtrr_bp_restore() do {} while (0)
-#define mtrr_disable() do {} while (0)
-#define mtrr_enable() do {} while (0)
-#define mtrr_generic_set_state() do {} while (0)
+#define mtrr_disable(s) do {} while (0)
+#define mtrr_enable(s) do {} while (0)
+#define mtrr_generic_set_state(s) do {} while (0)
 #  endif
 
 #ifdef CONFIG_COMPAT
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 231cf1ff0641..7e370c979417 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -1057,10 +1057,7 @@ int populate_cache_leaves(unsigned int cpu)
  * The caller must ensure that local interrupts are disabled and
  * are reenabled after cache_enable() has been called.
  */
-static unsigned long saved_cr4;
-static DEFINE_RAW_SPINLOCK(cache_disable_lock);
-
-void cache_disable(void) __acquires(cache_disable_lock)
+void cache_disable(struct cache_state *state)
 {
 	unsigned long cr0;
 
@@ -1071,8 +1068,6 @@ void cache_disable(void) __acquires(cache_disable_lock)
 	 * changes to the way the kernel boots
 	 */
 
-	raw_spin_lock(&cache_disable_lock);
-
 	/* Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
 	cr0 = read_cr0() | X86_CR0_CD;
 	write_cr0(cr0);
@@ -1088,8 +1083,8 @@ void cache_disable(void) __acquires(cache_disable_lock)
 
 	/* Save value of CR4 and clear Page Global Enable (bit 7) */
 	if (cpu_feature_enabled(X86_FEATURE_PGE)) {
-		saved_cr4 = __read_cr4();
-		__write_cr4(saved_cr4 & ~X86_CR4_PGE);
+		state->cr4 = __read_cr4();
+		__write_cr4(state->cr4 & ~X86_CR4_PGE);
 	}
 
 	/* Flush all TLBs via a mov %cr3, %reg; mov %reg, %cr3 */
@@ -1097,46 +1092,45 @@ void cache_disable(void) __acquires(cache_disable_lock)
 	flush_tlb_local();
 
 	if (cpu_feature_enabled(X86_FEATURE_MTRR))
-		mtrr_disable();
+		mtrr_disable(state);
 
 	/* Again, only flush caches if we have to. */
 	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
 		wbinvd();
 }
 
-void cache_enable(void) __releases(cache_disable_lock)
+void cache_enable(struct cache_state *state)
 {
 	/* Flush TLBs (no need to flush caches - they are disabled) */
 	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
 	flush_tlb_local();
 
 	if (cpu_feature_enabled(X86_FEATURE_MTRR))
-		mtrr_enable();
+		mtrr_enable(state);
 
 	/* Enable caches */
 	write_cr0(read_cr0() & ~X86_CR0_CD);
 
 	/* Restore value of CR4 */
 	if (cpu_feature_enabled(X86_FEATURE_PGE))
-		__write_cr4(saved_cr4);
-
-	raw_spin_unlock(&cache_disable_lock);
+		__write_cr4(state->cr4);
 }
 
 static void cache_cpu_init(void)
 {
 	unsigned long flags;
+	struct cache_state state;
 
 	local_irq_save(flags);
-	cache_disable();
+	cache_disable(&state);
 
 	if (memory_caching_control & CACHE_MTRR)
-		mtrr_generic_set_state();
+		mtrr_generic_set_state(&state);
 
 	if (memory_caching_control & CACHE_PAT)
 		pat_cpu_init();
 
-	cache_enable();
+	cache_enable(&state);
 	local_irq_restore(flags);
 }
 
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 2f2485d6657f..cddb440f330d 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -663,18 +663,13 @@ static bool set_mtrr_var_ranges(unsigned int index, struct mtrr_var_range *vr)
 	return changed;
 }
 
-static u32 deftype_lo, deftype_hi;
-
 /**
  * set_mtrr_state - Set the MTRR state for this CPU.
  *
- * NOTE: The CPU must already be in a safe state for MTRR changes, including
- *       measures that only a single CPU can be active in set_mtrr_state() in
- *       order to not be subject to races for usage of deftype_lo (this is
- *       accomplished by taking cache_disable_lock).
+ * NOTE: The CPU must already be in a safe state for MTRR changes.
  * RETURNS: 0 if no changes made, else a mask indicating what was changed.
  */
-static unsigned long set_mtrr_state(void)
+static unsigned long set_mtrr_state(struct cache_state *state)
 {
 	unsigned long change_mask = 0;
 	unsigned int i;
@@ -691,38 +686,40 @@ static unsigned long set_mtrr_state(void)
 	 * Set_mtrr_restore restores the old value of MTRRdefType,
 	 * so to set it we fiddle with the saved value:
 	 */
-	if ((deftype_lo & 0xff) != mtrr_state.def_type
-	    || ((deftype_lo & 0xc00) >> 10) != mtrr_state.enabled) {
-
-		deftype_lo = (deftype_lo & ~0xcff) | mtrr_state.def_type |
-			     (mtrr_state.enabled << 10);
+	if ((state->mtrr_deftype_lo & 0xff) != mtrr_state.def_type
+	    || ((state->mtrr_deftype_lo & 0xc00) >> 10) != mtrr_state.enabled) {
+		state->mtrr_deftype_lo = (state->mtrr_deftype_lo & ~0xcff) |
+					 mtrr_state.def_type |
+					 (mtrr_state.enabled << 10);
 		change_mask |= MTRR_CHANGE_MASK_DEFTYPE;
 	}
 
 	return change_mask;
 }
 
-void mtrr_disable(void)
+void mtrr_disable(struct cache_state *state)
 {
 	/* Save MTRR state */
-	rdmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
+	rdmsr(MSR_MTRRdefType, state->mtrr_deftype_lo, state->mtrr_deftype_hi);
 
 	/* Disable MTRRs, and set the default type to uncached */
-	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo & ~0xcff, deftype_hi);
+	mtrr_wrmsr(MSR_MTRRdefType, state->mtrr_deftype_lo & ~0xcff,
+		   state->mtrr_deftype_hi);
 }
 
-void mtrr_enable(void)
+void mtrr_enable(struct cache_state *state)
 {
 	/* Intel (P6) standard MTRRs */
-	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
+	mtrr_wrmsr(MSR_MTRRdefType, state->mtrr_deftype_lo,
+		   state->mtrr_deftype_hi);
 }
 
-void mtrr_generic_set_state(void)
+void mtrr_generic_set_state(struct cache_state *state)
 {
 	unsigned long mask, count;
 
 	/* Actually set the state */
-	mask = set_mtrr_state();
+	mask = set_mtrr_state(state);
 
 	/* Use the atomic bitops to update the global mask */
 	for (count = 0; count < sizeof(mask) * 8; ++count) {
@@ -747,11 +744,12 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
 {
 	unsigned long flags;
 	struct mtrr_var_range *vr;
+	struct cache_state state;
 
 	vr = &mtrr_state.var_ranges[reg];
 
 	local_irq_save(flags);
-	cache_disable();
+	cache_disable(&state);
 
 	if (size == 0) {
 		/*
@@ -770,7 +768,7 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
 		mtrr_wrmsr(MTRRphysMask_MSR(reg), vr->mask_lo, vr->mask_hi);
 	}
 
-	cache_enable();
+	cache_enable(&state);
 	local_irq_restore(flags);
 }
 
-- 
2.35.3

