Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E314C624237
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiKJMWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbiKJMWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:22:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8074E71F2B;
        Thu, 10 Nov 2022 04:21:58 -0800 (PST)
Date:   Thu, 10 Nov 2022 12:21:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668082917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tgjSmAqkmz1bY9leLt7VCkU4La83/t2RRyVSCo4MU8=;
        b=mKreb+lJPPYkbzjt1TZbgfPZdyvl0Mv5LqnV9b8ayjQwu+rbniXNOk2GHWSvqbu/NqUVMN
        4uy4AJ55TkU8wLOm4LLOHXDXl+IX7YhCpFsqNkcs4GSskCzWKw/JM/q+BTorJOO9Dzt+Wt
        uf6PkeLNGxCk3gIMlxI3sPdhq73PvYtxfJrSIlUN6p7pdF0elazhRwBviOoYhc2U7wBiWs
        gdDVCPRSBI2k+PEQ6RdYpEv8AWJ8sFYNolKTiij8sXVkExIToo3Vf6DimoddtqtnQkcyUC
        /CdCzHvcfduygbM9BQL4IXravTeVvqZmKQvGP0JPiMx6aO451YzTBz9xhrxJ+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668082917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0tgjSmAqkmz1bY9leLt7VCkU4La83/t2RRyVSCo4MU8=;
        b=ICl8pvECo2gGCtKu31lS22cgFRXS//t8LM55jXx7K8vtJkbuh9r6twb+Adp8BGpRJ+o4rQ
        pni6l/WEPHUCdHDA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mtrr: Move cache control code to cacheinfo.c
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221102074713.21493-7-jgross@suse.com>
References: <20221102074713.21493-7-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <166808291596.4906.2150865566545766620.tip-bot2@tip-bot2>
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

Commit-ID:     23a63e369098a8503550d1df80f4b4801af32c19
Gitweb:        https://git.kernel.org/tip/23a63e369098a8503550d1df80f4b4801af32c19
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Wed, 02 Nov 2022 08:47:03 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 10 Nov 2022 13:12:44 +01:00

x86/mtrr: Move cache control code to cacheinfo.c

Prepare making PAT and MTRR support independent from each other by
moving some code needed by both out of the MTRR-specific sources.

  [ bp: Massage commit message. ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20221102074713.21493-7-jgross@suse.com
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/cacheinfo.c    | 77 +++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mtrr/generic.c | 74 +----------------------------
 2 files changed, 77 insertions(+), 74 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 32fb049..0cbacec 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -20,6 +20,8 @@
 #include <asm/cacheinfo.h>
 #include <asm/amd_nb.h>
 #include <asm/smp.h>
+#include <asm/mtrr.h>
+#include <asm/tlbflush.h>
 
 #include "cpu.h"
 
@@ -1043,3 +1045,78 @@ int populate_cache_leaves(unsigned int cpu)
 
 	return 0;
 }
+
+/*
+ * Disable and enable caches. Needed for changing MTRRs and the PAT MSR.
+ *
+ * Since we are disabling the cache don't allow any interrupts,
+ * they would run extremely slow and would only increase the pain.
+ *
+ * The caller must ensure that local interrupts are disabled and
+ * are reenabled after cache_enable() has been called.
+ */
+static unsigned long saved_cr4;
+static DEFINE_RAW_SPINLOCK(cache_disable_lock);
+
+void cache_disable(void) __acquires(cache_disable_lock)
+{
+	unsigned long cr0;
+
+	/*
+	 * Note that this is not ideal
+	 * since the cache is only flushed/disabled for this CPU while the
+	 * MTRRs are changed, but changing this requires more invasive
+	 * changes to the way the kernel boots
+	 */
+
+	raw_spin_lock(&cache_disable_lock);
+
+	/* Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
+	cr0 = read_cr0() | X86_CR0_CD;
+	write_cr0(cr0);
+
+	/*
+	 * Cache flushing is the most time-consuming step when programming
+	 * the MTRRs. Fortunately, as per the Intel Software Development
+	 * Manual, we can skip it if the processor supports cache self-
+	 * snooping.
+	 */
+	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
+		wbinvd();
+
+	/* Save value of CR4 and clear Page Global Enable (bit 7) */
+	if (cpu_feature_enabled(X86_FEATURE_PGE)) {
+		saved_cr4 = __read_cr4();
+		__write_cr4(saved_cr4 & ~X86_CR4_PGE);
+	}
+
+	/* Flush all TLBs via a mov %cr3, %reg; mov %reg, %cr3 */
+	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
+	flush_tlb_local();
+
+	if (cpu_feature_enabled(X86_FEATURE_MTRR))
+		mtrr_disable();
+
+	/* Again, only flush caches if we have to. */
+	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
+		wbinvd();
+}
+
+void cache_enable(void) __releases(cache_disable_lock)
+{
+	/* Flush TLBs (no need to flush caches - they are disabled) */
+	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
+	flush_tlb_local();
+
+	if (cpu_feature_enabled(X86_FEATURE_MTRR))
+		mtrr_enable();
+
+	/* Enable caches */
+	write_cr0(read_cr0() & ~X86_CR0_CD);
+
+	/* Restore value of CR4 */
+	if (cpu_feature_enabled(X86_FEATURE_PGE))
+		__write_cr4(saved_cr4);
+
+	raw_spin_unlock(&cache_disable_lock);
+}
diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
index 0db0770..396cb1e 100644
--- a/arch/x86/kernel/cpu/mtrr/generic.c
+++ b/arch/x86/kernel/cpu/mtrr/generic.c
@@ -731,80 +731,6 @@ void mtrr_enable(void)
 	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
 }
 
-/*
- * Disable and enable caches. Needed for changing MTRRs and the PAT MSR.
- *
- * Since we are disabling the cache don't allow any interrupts,
- * they would run extremely slow and would only increase the pain.
- *
- * The caller must ensure that local interrupts are disabled and
- * are reenabled after cache_enable() has been called.
- */
-static unsigned long saved_cr4;
-static DEFINE_RAW_SPINLOCK(cache_disable_lock);
-
-void cache_disable(void) __acquires(cache_disable_lock)
-{
-	unsigned long cr0;
-
-	/*
-	 * Note that this is not ideal
-	 * since the cache is only flushed/disabled for this CPU while the
-	 * MTRRs are changed, but changing this requires more invasive
-	 * changes to the way the kernel boots
-	 */
-
-	raw_spin_lock(&cache_disable_lock);
-
-	/* Enter the no-fill (CD=1, NW=0) cache mode and flush caches. */
-	cr0 = read_cr0() | X86_CR0_CD;
-	write_cr0(cr0);
-
-	/*
-	 * Cache flushing is the most time-consuming step when programming
-	 * the MTRRs. Fortunately, as per the Intel Software Development
-	 * Manual, we can skip it if the processor supports cache self-
-	 * snooping.
-	 */
-	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
-		wbinvd();
-
-	/* Save value of CR4 and clear Page Global Enable (bit 7) */
-	if (boot_cpu_has(X86_FEATURE_PGE)) {
-		saved_cr4 = __read_cr4();
-		__write_cr4(saved_cr4 & ~X86_CR4_PGE);
-	}
-
-	/* Flush all TLBs via a mov %cr3, %reg; mov %reg, %cr3 */
-	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
-	flush_tlb_local();
-
-	if (cpu_feature_enabled(X86_FEATURE_MTRR))
-		mtrr_disable();
-
-	/* Again, only flush caches if we have to. */
-	if (!static_cpu_has(X86_FEATURE_SELFSNOOP))
-		wbinvd();
-}
-
-void cache_enable(void) __releases(cache_disable_lock)
-{
-	/* Flush TLBs (no need to flush caches - they are disabled) */
-	count_vm_tlb_event(NR_TLB_LOCAL_FLUSH_ALL);
-	flush_tlb_local();
-
-	if (cpu_feature_enabled(X86_FEATURE_MTRR))
-		mtrr_enable();
-
-	/* Enable caches */
-	write_cr0(read_cr0() & ~X86_CR0_CD);
-
-	/* Restore value of CR4 */
-	if (boot_cpu_has(X86_FEATURE_PGE))
-		__write_cr4(saved_cr4);
-	raw_spin_unlock(&cache_disable_lock);
-}
-
 static void generic_set_all(void)
 {
 	unsigned long mask, count;
