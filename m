Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29C62423B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiKJMWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiKJMWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:22:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9866725C1;
        Thu, 10 Nov 2022 04:22:00 -0800 (PST)
Date:   Thu, 10 Nov 2022 12:21:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668082919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjQJS5f93wLG/tWeWmV/ra8od2ybqaIhClDun19QQFs=;
        b=m9gAR3O89MkcO2X4NTCvFuBbvp8AKRIPQw3BEIzYvLHqaqHH6awGXaTffo37U5kxOCoMmV
        5jRgTHkUpMXKzYD46ts7zgVOoRIJ0OgozhW5mdus3blD1pv25QgiA157b3uT76LpjT68Mk
        eIEkY/5OznEMVqaBAnXnnT27xrj9Qm3nr2/O2nJj6YOT1ZPb0gd4KEfroJYLb2oIIb4u9R
        GOl0bbRHOwHDw+YIMNWS3Hqkno05UOm4VLsuL8dFuNUvXVR09/45urMjH+7OBhWeJS61/6
        jdMQ9CTn+sCSsdv6BHxdOKYlIEpez0zGmnuACUYfu4Abn2gTrDysg9qrbuTzSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668082919;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fjQJS5f93wLG/tWeWmV/ra8od2ybqaIhClDun19QQFs=;
        b=CdjyMuoA5lEauYGxiCxHzOSrP+txf3D0HUG9aENSKHMM/FEl4XK/RCZS1unFyI1zlc3erZ
        xNBdcMc64Q2gU+DA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mtrr: Rename prepare_set() and post_set()
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221102074713.21493-5-jgross@suse.com>
References: <20221102074713.21493-5-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166808291816.4906.2479732754463397288.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d5f66d5d10611978c3a93cc94a811d74e0cf6cbc
Gitweb:        https://git.kernel.org/tip/d5f66d5d10611978c3a93cc94a811d74e0cf6cbc
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 02 Nov 2022 08:47:01 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Nov 2022 13:12:44 +01:00

x86/mtrr: Rename prepare_set() and post_set()

Rename the currently MTRR-specific functions prepare_set() and
post_set() in preparation to move them. Make them non-static and put
their prototypes into cacheinfo.h, where they will end after moving them
to their final position anyway.

Expand the comment before the functions with an introductory line and
rename two related static variables, too.

  [ bp: Massage commit message. ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221102074713.21493-5-jgross@suse.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/cacheinfo.h   |  3 ++-
 arch/x86/kernel/cpu/mtrr/generic.c | 43 ++++++++++++++---------------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index c387396..6159874 100644
--- a/arch/x86/include/asm/cacheinfo.h
+++ b/arch/x86/include/asm/cacheinfo.h
@@ -10,4 +10,7 @@ extern unsigned int memory_caching_control;
 void cacheinfo_amd_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 void cacheinfo_hygon_init_llc_id(struct cpuinfo_x86 *c, int cpu);
 
+void cache_disable(void);
+void cache_enable(void);
+
 #endif /* _ASM_X86_CACHEINFO_H */
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 7bbaba4..2f3fc28 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -10,6 +10,7 @@
 #include <linux/mm.h>
 
 #include <asm/processor-flags.h>
+#include <asm/cacheinfo.h>
 #include <asm/cpufeature.h>
 #include <asm/tlbflush.h>
 #include <asm/mtrr.h>
@@ -396,9 +397,6 @@ print_fixed(unsigned base, unsigned step, const mtrr_type *types)
 	}
 }
 
-static void prepare_set(void);
-static void post_set(void);
-
 static void __init print_mtrr_state(void)
 {
 	unsigned int i;
@@ -450,11 +448,11 @@ void __init mtrr_bp_pat_init(void)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	prepare_set();
+	cache_disable();
 
 	pat_init();
 
-	post_set();
+	cache_enable();
 	local_irq_restore(flags);
 }
 
@@ -687,7 +685,7 @@ static u32 deftype_lo, deftype_hi;
  * NOTE: The CPU must already be in a safe state for MTRR changes, including
  *       measures that only a single CPU can be active in set_mtrr_state() in
  *       order to not be subject to races for usage of deftype_lo. This is
- *       accomplished by taking set_atomicity_lock.
+ *       accomplished by taking cache_disable_lock.
  * RETURNS: 0 if no changes made, else a mask indicating what was changed.
  */
 static unsigned long set_mtrr_state(void)
@@ -718,18 +716,19 @@ static unsigned long set_mtrr_state(void)
 	return change_mask;
 }
 
-
-static unsigned long cr4;
-static DEFINE_RAW_SPINLOCK(set_atomicity_lock);
-
 /*
+ * Disable and enable caches. Needed for changing MTRRs and the PAT MSR.
+ *
  * Since we are disabling the cache don't allow any interrupts,
  * they would run extremely slow and would only increase the pain.
  *
  * The caller must ensure that local interrupts are disabled and
- * are reenabled after post_set() has been called.
+ * are reenabled after cache_enable() has been called.
  */
-static void prepare_set(void) __acquires(set_atomicity_lock)
+static unsigned long saved_cr4;
+static DEFINE_RAW_SPINLOCK(cache_disable_lock);
+
+void cache_disable(void) __acquires(cache_disable_lock)
 {
 	unsigned long cr0;
 
@@ -740,7 +739,7 @@ static void prepare_set(void) __acquires(set_atomicity_lock)
 	 * changes to the way the kernel boots
 	 */
 
-	raw_spin_lock(&set_atomicity_lock);
+	raw_spin_lock(&cache_disable_lock);
 
 	/* Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
 	cr0 = read_cr0() | X86_CR0_CD;
@@ -757,8 +756,8 @@ static void prepare_set(void) __acquires(set_atomicity_lock)
 
 	/* Save value of CR4 and clear Page Global Enable (bit 7) */
 	if (boot_cpu_has(X86_FEATURE_PGE)) {
-		cr4 = __read_cr4();
-		__write_cr4(cr4 & ~X86_CR4_PGE);
+		saved_cr4 = __read_cr4();
+		__write_cr4(saved_cr4 & ~X86_CR4_PGE);
 	}
 
 	/* Flush all TLBs via a mov %cr3, %reg; mov %reg, %cr3 */
@@ -776,7 +775,7 @@ static void prepare_set(void) __acquires(set_atomicity_lock)
 		wbinvd();
 }
 
-static void post_set(void) __releases(set_atomicity_lock)
+void cache_enable(void) __releases(cache_disable_lock)
 {
 	/* Flush TLBs (no need to flush caches - they are disabled) */
 	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
@@ -790,8 +789,8 @@ static void post_set(void) __releases(set_atomicity_lock)
 
 	/* Restore value of CR4 */
 	if (boot_cpu_has(X86_FEATURE_PGE))
-		__write_cr4(cr4);
-	raw_spin_unlock(&set_atomicity_lock);
+		__write_cr4(saved_cr4);
+	raw_spin_unlock(&cache_disable_lock);
 }
 
 static void generic_set_all(void)
@@ -800,7 +799,7 @@ static void generic_set_all(void)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	prepare_set();
+	cache_disable();
 
 	/* Actually set the state */
 	mask = set_mtrr_state();
@@ -808,7 +807,7 @@ static void generic_set_all(void)
 	/* also set PAT */
 	pat_init();
 
-	post_set();
+	cache_enable();
 	local_irq_restore(flags);
 
 	/* Use the atomic bitops to update the global mask */
@@ -839,7 +838,7 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
 	vr = &mtrr_state.var_ranges[reg];
 
 	local_irq_save(flags);
-	prepare_set();
+	cache_disable();
 
 	if (size == 0) {
 		/*
@@ -858,7 +857,7 @@ static void generic_set_mtrr(unsigned int reg, unsigned long base,
 		mtrr_wrmsr(MTRRphysMask_MSR(reg), vr->mask_lo, vr->mask_hi);
 	}
 
-	post_set();
+	cache_enable();
 	local_irq_restore(flags);
 }
 
