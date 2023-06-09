Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A570728F6E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 07:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbjFIFvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 01:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjFIFvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 01:51:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EB330D3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 22:51:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CDF8921A02;
        Fri,  9 Jun 2023 05:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686289862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UyouZ59jZ1L5CU9YPnNfl4jMT/ujs57hNTuxiWy+JUQ=;
        b=BrdZPt5SEo12XNnFWwZQ1camI46oJRjkjWrxEliXh9XbNxCPYhjaNF1AE31E0cFCPgYD8X
        IDPEbTSw3DUhmlCr7IjHUPb/KVM2zr1WZ50607xKtCo6PyJhy4iorh6ObKUCCTQV36NibI
        S7BVsAWlTA1swVSRCuhaE/wvzlA72mY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 806DD133E6;
        Fri,  9 Jun 2023 05:51:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tQPpHca9gmRsKAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 09 Jun 2023 05:51:02 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/mm: Remove Xen-PV leftovers from init_32.c
Date:   Fri,  9 Jun 2023 07:51:00 +0200
Message-Id: <20230609055100.12633-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are still some unneeded paravirt calls in arch/x86/mm/init_32.c.

Remove them.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/mm/init_32.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index d4e2648a1dfb..b63403d7179d 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -45,7 +45,6 @@
 #include <asm/olpc_ofw.h>
 #include <asm/pgalloc.h>
 #include <asm/sections.h>
-#include <asm/paravirt.h>
 #include <asm/setup.h>
 #include <asm/set_memory.h>
 #include <asm/page_types.h>
@@ -74,7 +73,6 @@ static pmd_t * __init one_md_table_init(pgd_t *pgd)
 #ifdef CONFIG_X86_PAE
 	if (!(pgd_val(*pgd) & _PAGE_PRESENT)) {
 		pmd_table = (pmd_t *)alloc_low_page();
-		paravirt_alloc_pmd(&init_mm, __pa(pmd_table) >> PAGE_SHIFT);
 		set_pgd(pgd, __pgd(__pa(pmd_table) | _PAGE_PRESENT));
 		p4d = p4d_offset(pgd, 0);
 		pud = pud_offset(p4d, 0);
@@ -99,7 +97,6 @@ static pte_t * __init one_page_table_init(pmd_t *pmd)
 	if (!(pmd_val(*pmd) & _PAGE_PRESENT)) {
 		pte_t *page_table = (pte_t *)alloc_low_page();
 
-		paravirt_alloc_pte(&init_mm, __pa(page_table) >> PAGE_SHIFT);
 		set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
 		BUG_ON(page_table != pte_offset_kernel(pmd, 0));
 	}
@@ -181,12 +178,10 @@ static pte_t *__init page_table_kmap_check(pte_t *pte, pmd_t *pmd,
 			set_pte(newpte + i, pte[i]);
 		*adr = (void *)(((unsigned long)(*adr)) + PAGE_SIZE);
 
-		paravirt_alloc_pte(&init_mm, __pa(newpte) >> PAGE_SHIFT);
 		set_pmd(pmd, __pmd(__pa(newpte)|_PAGE_TABLE));
 		BUG_ON(newpte != pte_offset_kernel(pmd, 0));
 		__flush_tlb_all();
 
-		paravirt_release_pte(__pa(pte) >> PAGE_SHIFT);
 		pte = newpte;
 	}
 	BUG_ON(vaddr < fix_to_virt(FIX_KMAP_BEGIN - 1)
@@ -482,7 +477,6 @@ void __init native_pagetable_init(void)
 				pfn, pmd, __pa(pmd), pte, __pa(pte));
 		pte_clear(NULL, va, pte);
 	}
-	paravirt_alloc_pmd(&init_mm, __pa(base) >> PAGE_SHIFT);
 	paging_init();
 }
 
@@ -491,15 +485,8 @@ void __init native_pagetable_init(void)
  * point, we've been running on some set of pagetables constructed by
  * the boot process.
  *
- * If we're booting on native hardware, this will be a pagetable
- * constructed in arch/x86/kernel/head_32.S.  The root of the
- * pagetable will be swapper_pg_dir.
- *
- * If we're booting paravirtualized under a hypervisor, then there are
- * more options: we may already be running PAE, and the pagetable may
- * or may not be based in swapper_pg_dir.  In any case,
- * paravirt_pagetable_init() will set up swapper_pg_dir
- * appropriately for the rest of the initialization to work.
+ * This will be a pagetable constructed in arch/x86/kernel/head_32.S.
+ * The root of the pagetable will be swapper_pg_dir.
  *
  * In general, pagetable_init() assumes that the pagetable may already
  * be partially populated, and so it avoids stomping on any existing
-- 
2.35.3

