Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8410A615D21
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbiKBHsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiKBHsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:48:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB63F27170
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 00:47:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A5D971F8B0;
        Wed,  2 Nov 2022 07:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667375269; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NhfPGIkSQGMzUIyLCC2u9IISPCoq9TUFQ1/WyCEAvPA=;
        b=aUuF0bLWXXy0fVLbPkMPgxknmGre45Rj0LWrTujtDYRMlIC5iGoyJdB3SMfRKClXzIeZfp
        O1NeIAfRF5gbasriCALR3LHJTSP3SX0ciNr9ETvPMZZTFtlhzMaEsVqFzKj4arMyWIJ8CV
        QyRqHfboyRR3bQyJmJ/+ivlIvvFribE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 632D11376E;
        Wed,  2 Nov 2022 07:47:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aPWnFqUgYmPPcgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 02 Nov 2022 07:47:49 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v5 06/16] x86: move some code out of arch/x86/kernel/cpu/mtrr
Date:   Wed,  2 Nov 2022 08:47:03 +0100
Message-Id: <20221102074713.21493-7-jgross@suse.com>
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

Prepare making PAT and MTRR support independent from each other by
moving some code needed by both out of the MTRR specific sources.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- move code from cpu/common.c to cpu/cacheinfo.c (Borislav Petkov)
V4:
- carved out all non-movement modifications (Borislav Petkov)
---
 arch/x86/kernel/cpu/cacheinfo.c    | 77 ++++++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mtrr/generic.c | 74 ----------------------------
 2 files changed, 77 insertions(+), 74 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 5228fb9a3798..c6a17e21301e 100644
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
index 4edf0827f7ee..bfe13eedaca8 100644
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
-- 
2.35.3

