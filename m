Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2767F68D11E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjBGH7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBGH7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:59:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864021E9E0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:59:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4186C340B7;
        Tue,  7 Feb 2023 07:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675756744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=5gbyCaKdJ8Mi2SS92SeXVfp2L0hg2wIdbGtZaSSemJk=;
        b=cSLouw+eDRwsEhh4tCdzm/mXIkiN3VaizXDinxf3AxfRlZvMB13J7nYgvv8ambeU0sM7ey
        DfSm73Mxx8bw6U4fEBZZv1JatzASdbZIRMW3lo65fJ3jM7DsZCHiJEcXBD8HwsYeoYT9mU
        PVM2qzsER8TVJkPgRfU9baF5PVtydIw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8DD613467;
        Tue,  7 Feb 2023 07:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k7yxL8cE4mOhXgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 07 Feb 2023 07:59:03 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org
Subject: [PATCH v2] x86/paravirt: merge activate_mm and dup_mmap callbacks
Date:   Tue,  7 Feb 2023 08:59:02 +0100
Message-Id: <20230207075902.7539-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
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

The two paravirt callbacks .mmu.activate_mm and .mmu.dup_mmap are
sharing the same implementations in all cases: for Xen PV guests they
are pinning the PGD of the new mm_struct, and for all other cases
they are a NOP.

In the end both callbacks are meant to register an address space with
the underlying hypervisor, so there needs to be only a single callback
for that purpose.

So merge them to a common callback .mmu.enter_mmap (in contrast to the
corresponding already existing .mmu.exit_mmap).

As the first parameter of the old callbacks isn't used, drop it from
the replacement one.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
V2:
- expand commit message (Srivatsa S. Bhat)
---
 arch/x86/include/asm/mmu_context.h    |  4 ++--
 arch/x86/include/asm/paravirt.h       | 14 +++-----------
 arch/x86/include/asm/paravirt_types.h |  7 ++-----
 arch/x86/kernel/paravirt.c            |  3 +--
 arch/x86/mm/init.c                    |  2 +-
 arch/x86/xen/mmu_pv.c                 | 12 ++----------
 6 files changed, 11 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index b8d40ddeab00..6a14b6c2165c 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -134,7 +134,7 @@ extern void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 
 #define activate_mm(prev, next)			\
 do {						\
-	paravirt_activate_mm((prev), (next));	\
+	paravirt_enter_mmap(next);		\
 	switch_mm((prev), (next), NULL);	\
 } while (0);
 
@@ -167,7 +167,7 @@ static inline void arch_dup_pkeys(struct mm_struct *oldmm,
 static inline int arch_dup_mmap(struct mm_struct *oldmm, struct mm_struct *mm)
 {
 	arch_dup_pkeys(oldmm, mm);
-	paravirt_arch_dup_mmap(oldmm, mm);
+	paravirt_enter_mmap(mm);
 	return ldt_dup_context(oldmm, mm);
 }
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 73e9522db7c1..07bbdceaf35a 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -332,16 +332,9 @@ static inline void tss_update_io_bitmap(void)
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
@@ -787,8 +780,7 @@ extern void default_banner(void);
 
 #ifndef __ASSEMBLY__
 #ifndef CONFIG_PARAVIRT_XXL
-static inline void paravirt_arch_dup_mmap(struct mm_struct *oldmm,
-					  struct mm_struct *mm)
+static inline void paravirt_enter_mmap(struct mm_struct *mm)
 {
 }
 #endif
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 8c1da419260f..71bf64b963df 100644
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
index 327757afb027..ff1109b9c6cd 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -352,8 +352,7 @@ struct paravirt_patch_template pv_ops = {
 	.mmu.make_pte		= PTE_IDENT,
 	.mmu.make_pgd		= PTE_IDENT,
 
-	.mmu.dup_mmap		= paravirt_nop,
-	.mmu.activate_mm	= paravirt_nop,
+	.mmu.enter_mmap		= paravirt_nop,
 
 	.mmu.lazy_mode = {
 		.enter		= paravirt_nop,
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index cb258f58fdc8..cbc53da4c1b4 100644
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
index ee29fb558f2e..b3b8d289b9ab 100644
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
-- 
2.35.3

