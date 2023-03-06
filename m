Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C556A6AB8F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjCFI64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjCFI6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:58:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462341B30A;
        Mon,  6 Mar 2023 00:58:35 -0800 (PST)
Date:   Mon, 06 Mar 2023 08:58:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1678093112;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NX8Wzl/nEyCP9QiEXPCDpJo3gAFJkdS4gKHF79PRcDY=;
        b=zEBCjCbA+xW1BbBuLTw+258DXdVm8FrZemI+5csZ7cxXHkKueKUZvpuoviRIhGEVyFK2/D
        R9ugCWttoNoFSofprIl8mSWrhveC8Ke77h0brM47TPplzCISTpIEgwe3o9swCBE//zCjh3
        +J00buIVeO436XVA9sC6uW1h9q9YTFyRYwfVdfTaWuOlNFsffZsUVBcNUKu+yceRBTjTxR
        ZCN4Z6aO9OQr8obPzayBxTRTDzvNgUPOrWeeo6a0IP3YMXgFWhM67a6IbKHKr/6NidtCSf
        qEGCFI+0jIclHTM5QHFvFLFZjZepBEJhYIRXC/aWllO/8CWsHSGKxO+s2WcV4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1678093112;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NX8Wzl/nEyCP9QiEXPCDpJo3gAFJkdS4gKHF79PRcDY=;
        b=vRzmXvXiGiPm81yYUABXU5Ttac7S3/mdKFPsU9yCwrucdlv3d+1Cii5TImla32ah9U2iQS
        BJnM/idDPnP1EaAA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Merge activate_mm() and dup_mmap()
 callbacks
Cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230207075902.7539-1-jgross@suse.com>
References: <20230207075902.7539-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <167809311181.5837.8632360662903807710.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     c9ae1b10d9561012a222e05f0d3ab4e93d301f06
Gitweb:        https://git.kernel.org/tip/c9ae1b10d9561012a222e05f0d3ab4e93d301f06
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Tue, 07 Feb 2023 08:59:02 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 06 Mar 2023 09:41:37 +01:00

x86/paravirt: Merge activate_mm() and dup_mmap() callbacks

The two paravirt callbacks .mmu.activate_mm() and .mmu.dup_mmap() are
sharing the same implementations in all cases: for Xen PV guests they
are pinning the PGD of the new mm_struct, and for all other cases they
are a NOP.

In the end, both callbacks are meant to register an address space with
the underlying hypervisor, so there needs to be only a single callback
for that purpose.

So merge them to a common callback .mmu.enter_mmap() (in contrast to the
corresponding already existing .mmu.exit_mmap()).

As the first parameter of the old callbacks isn't used, drop it from the
replacement one.

  [ bp: Remove last occurrence of paravirt_activate_mm() in
    asm/mmu_context.h ]

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Link: https://lore.kernel.org/r/20230207075902.7539-1-jgross@suse.com
---
 arch/x86/include/asm/mmu_context.h    | 11 ++---------
 arch/x86/include/asm/paravirt.h       | 14 +++-----------
 arch/x86/include/asm/paravirt_types.h |  7 ++-----
 arch/x86/kernel/paravirt.c            |  3 +--
 arch/x86/mm/init.c                    |  2 +-
 arch/x86/xen/mmu_pv.c                 | 12 ++----------
 6 files changed, 11 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index e01aa74..c3ad8a5 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -16,13 +16,6 @@
 
 extern atomic64_t last_mm_ctx_id;
 
-#ifndef CONFIG_PARAVIRT_XXL
-static inline void paravirt_activate_mm(struct mm_struct *prev,
-					struct mm_struct *next)
-{
-}
-#endif	/* !CONFIG_PARAVIRT_XXL */
-
 #ifdef CONFIG_PERF_EVENTS
 DECLARE_STATIC_KEY_FALSE(rdpmc_never_available_key);
 DECLARE_STATIC_KEY_FALSE(rdpmc_always_available_key);
@@ -135,7 +128,7 @@ extern void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 #define activate_mm(prev, next)			\
 do {						\
-	paravirt_activate_mm((prev), (next));	\
+	paravirt_enter_mmap(next);		\
 	switch_mm((prev), (next), NULL);	\
 } while (0);
 
@@ -168,7 +161,7 @@ static inline void arch_dup_pkeys(struct mm_struct *oldmm,
 static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
 {
 	arch_dup_pkeys(oldmm, mm);
-	paravirt_arch_dup_mmap(oldmm, mm);
+	paravirt_enter_mmap(mm);
 	return ldt_dup_context(oldmm, mm);
 }
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index cf40e81..b497786 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -334,16 +334,9 @@ static inline void tss_update_io_bitmap(void)
 }
 #endif
 
-static inline void paravirt_activate_mm(struct mm_struct *prev,
-					struct mm_struct *next)
+static inline void paravirt_enter_mmap(struct mm_struct *next)
 {
-	PVOP_VCALL2(mmu.activate_mm, prev, next);
-}
-
-static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
-					  struct mm_struct *mm)
-{
-	PVOP_VCALL2(mmu.dup_mmap, oldmm, mm);
+	PVOP_VCALL1(mmu.enter_mmap, next);
 }
 
 static inline int paravirt_pgd_alloc(struct mm_struct *mm)
@@ -789,8 +782,7 @@ extern void default_banner(void);
 
 #ifndef __ASSEMBLY__
 #ifndef CONFIG_PARAVIRT_XXL
-static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
-					  struct mm_struct *mm)
+static inline void paravirt_enter_mmap(struct mm_struct *mm)
 {
 }
 #endif
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 8c1da41..71bf64b 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -164,11 +164,8 @@ struct pv_mmu_ops {
 	unsigned long (*read_cr3)(void);
 	void (*write_cr3)(unsigned long);
 
-	/* Hooks for intercepting the creation/use of an mm_struct. */
-	void (*activate_mm)(struct mm_struct *prev,
-			    struct mm_struct *next);
-	void (*dup_mmap)(struct mm_struct *oldmm,
-			 struct mm_struct *mm);
+	/* Hook for intercepting the creation/use of an mm_struct. */
+	void (*enter_mmap)(struct mm_struct *mm);
 
 	/* Hooks for allocating and freeing a pagetable top-level */
 	int  (*pgd_alloc)(struct mm_struct *mm);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 42e1828..0e68a31 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -363,8 +363,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.make_pte		= PTE_IDENT,
 	.mmu.make_pgd		= PTE_IDENT,
 
-	.mmu.dup_mmap		= paravirt_nop,
-	.mmu.activate_mm	= paravirt_nop,
+	.mmu.enter_mmap		= paravirt_nop,
 
 	.mmu.lazy_mode = {
 		.enter		= paravirt_nop,
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index cb258f5..cbc53da 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -806,7 +806,7 @@ void __init poking_init(void)
 	BUG_ON(!poking_mm);
 
 	/* Xen PV guests need the PGD to be pinned. */
-	paravirt_arch_dup_mmap(NULL, poking_mm);
+	paravirt_enter_mmap(poking_mm);
 
 	/*
 	 * Randomize the poking address, but make sure that the following page
diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index ee29fb5..b3b8d28 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -885,14 +885,7 @@ void xen_mm_unpin_all(void)
 	spin_unlock(&pgd_lock);
 }
 
-static void xen_activate_mm(struct mm_struct *prev, struct mm_struct *next)
-{
-	spin_lock(&next->page_table_lock);
-	xen_pgd_pin(next);
-	spin_unlock(&next->page_table_lock);
-}
-
-static void xen_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
+static void xen_enter_mmap(struct mm_struct *mm)
 {
 	spin_lock(&mm->page_table_lock);
 	xen_pgd_pin(mm);
@@ -2153,8 +2146,7 @@ static const typeof(pv_ops) xen_mmu_ops __initconst = {
 		.make_p4d = PV_CALLEE_SAVE(xen_make_p4d),
 #endif
 
-		.activate_mm = xen_activate_mm,
-		.dup_mmap = xen_dup_mmap,
+		.enter_mmap = xen_enter_mmap,
 		.exit_mmap = xen_exit_mmap,
 
 		.lazy_mode = {
