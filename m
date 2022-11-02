Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FEE615D1F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiKBHrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiKBHrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:47:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93DB26AE7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:47:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5050B338F3;
        Wed,  2 Nov 2022 07:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667375258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gjmwwu1nE4qkYJE0/hC2MZUBh8G9fijNxWNwmPmBasU=;
        b=Loy3jBzVbq4Y8fth8Cvtw/EA441/lsaVmGenyW7/NEybkX1pS6vP7gtya6fQ6KHWA4PhpK
        wbeaEPqMMccegCd1zFzdo8fKmErtB89wKkH5+KPeMIJarCCpYI2XDYXS7st9zG+2aJzQm8
        tCz5nHYwSsnQ78kGr7Wk9tDLkIr++Eo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 13A0B1376E;
        Wed,  2 Nov 2022 07:47:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qoR6A5ogYmOucgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 02 Nov 2022 07:47:38 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 04/16] x86/mtrr: rename prepare_set() and post_set()
Date:   Wed,  2 Nov 2022 08:47:01 +0100
Message-Id: <20221102074713.21493-5-jgross@suse.com>
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

Rename the currently MTRR specific functions prepare_set() and
post_set() for preparing to move them. Make them non-static and put
their prototypes into cacheinfo.h, where they will end after moving
them to their final position anyway.

Expand the comment before the functions with an introductory line and
rename two related static variables, too.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V4:
- carved out from other patch (Borislav Petkov)
---
 arch/x86/include/asm/cacheinfo.h   |  3 +++
 arch/x86/kernel/cpu/mtrr/generic.c | 43 +++++++++++++++---------------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/cacheinfo.h b/arch/x86/include/asm/cacheinfo.h
index c3873962a7cd..6159874b4183 100644
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
index 81742870ecc5..aebdc90a2489 100644
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
  *       order to not be subject to races for usage of deftype_lo (this is
- *       accomplished by taking set_atomicity_lock).
+ *       accomplished by taking cache_disable_lock).
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
 
-- 
2.35.3

