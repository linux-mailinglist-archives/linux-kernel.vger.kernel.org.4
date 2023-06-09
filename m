Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1532B729D76
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241660AbjFIOzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241826AbjFIOzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:55:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1253A88;
        Fri,  9 Jun 2023 07:54:52 -0700 (PDT)
Date:   Fri, 09 Jun 2023 14:54:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686322490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqpL/bHF2qVquWuvqZqpUhbImgm41fmGiTri9EWuHqI=;
        b=W5FaNMv5D3KNnY6MZvPPCNXHsjLzLe8CbNdR/reX7pOEq9giwX6I12bQsqXZT7Ca5Cxliv
        7/YkDWxKlIAsnG5HROw7/uhK+cs+rXuWSBI3qDURWzSMN5yloH4ECTXmSXzYUHn1POj3nc
        +8X8Lty7SE9MIPzfOYdU6L/SiJpRBq5/vr/OYtS0DS6B93/oB3lQK1XoxUCraaXn19qzM/
        B7ZERyoxCPH0HblVtycxuZcjXnwXifQuifRh9jGEXeIYrScs4MCnQDZnvxMIcaxrhNF9Wd
        Ywdn4thVD8lLmP3JI9V32V8sPGWGs0g8+0qwkjKaUJdU0oNd6Ug4z0F1Lh/ADQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686322490;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xqpL/bHF2qVquWuvqZqpUhbImgm41fmGiTri9EWuHqI=;
        b=WOLaw36qm+mSScfGwL7i/OZynqU0137rJKbOomGLfWOcGbQIgDaaFWKT6jy3nGqrB7syWk
        Xo89epfgY1D3fDCA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Remove Xen-PV leftovers from init_32.c
Cc:     Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230609055100.12633-1-jgross@suse.com>
References: <20230609055100.12633-1-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <168632248969.404.6472440615064721846.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     78841cd185aa74bc92d3ac2c63a870395caaa086
Gitweb:        https://git.kernel.org/tip/78841cd185aa74bc92d3ac2c63a870395caaa086
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Fri, 09 Jun 2023 07:51:00 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 09 Jun 2023 11:00:21 +02:00

x86/mm: Remove Xen-PV leftovers from init_32.c

There are still some unneeded paravirt calls in arch/x86/mm/init_32.c.

Remove them.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230609055100.12633-1-jgross@suse.com
---
 arch/x86/mm/init_32.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index d4e2648..b63403d 100644
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
