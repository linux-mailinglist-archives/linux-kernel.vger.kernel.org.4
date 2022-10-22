Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A448608CF0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJVLs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJVLsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:48:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21121250293
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=lkZdGp83/TthtV3rxO0LKzlFIb0aX3v3XYJ5iZQQNzg=; b=DvKf19ngBUpdzl0ij7xBmZMRXh
        ui/RMKslNxqoOsZHJQEPa5zDXLSQ3lYvqgHe3zbQqojpn0U9BuDn4pJaoxbaK86/AQqbdKJhh3oYD
        ktC6an0vkVyWJJKA9MR4FG0zwzprr5Xgm+MolIvlAy29FCTpuSFLo1xrWIqCK/O8Qs5Gsck/i8qIQ
        4mfjWuAYUdAynm0EIt1Pp3+QSrXSg1pT6whi7abx5v7Sj6NZsGkXKAvhdlLwSQjvnDw18bP07Zv4y
        Mc6ZlO9yHBlrAsiBQYNLFfQ3Yhfz13CO5XsuOaulhx5bKEzAJXiaIYGya4dd4IzKwJEJA1YcKJKVh
        2tGUPmqA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1omCzM-005XdR-WF; Sat, 22 Oct 2022 11:48:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDB32302D62;
        Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3015B28B8E511; Sat, 22 Oct 2022 13:48:26 +0200 (CEST)
Message-ID: <20221022114424.841277397@infradead.org>
User-Agent: quilt/0.66
Date:   Sat, 22 Oct 2022 13:14:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, willy@infradead.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, aarcange@redhat.com,
        kirill.shutemov@linux.intel.com, jroedel@suse.de, ubizjak@gmail.com
Subject: [PATCH 06/13] mm: Rename pmd_read_atomic()
References: <20221022111403.531902164@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no point in having the identical routines for PTE/PMD have
different names.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/pgtable.h    |    9 ++-------
 mm/hmm.c                   |    2 +-
 mm/khugepaged.c            |    2 +-
 mm/mapping_dirty_helpers.c |    2 +-
 mm/mprotect.c              |    2 +-
 mm/userfaultfd.c           |    2 +-
 mm/vmscan.c                |    4 ++--
 7 files changed, 9 insertions(+), 14 deletions(-)

--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1352,11 +1352,6 @@ static inline int pud_trans_unstable(pud
 #endif
 }
 
-static inline pmd_t pmd_read_atomic(pmd_t *pmdp)
-{
-	return pmdp_get_lockless(pmdp);
-}
-
 #ifndef arch_needs_pgtable_deposit
 #define arch_needs_pgtable_deposit() (false)
 #endif
@@ -1383,13 +1378,13 @@ static inline pmd_t pmd_read_atomic(pmd_
  */
 static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
 {
-	pmd_t pmdval = pmd_read_atomic(pmd);
+	pmd_t pmdval = pmdp_get_lockless(pmd);
 	/*
 	 * The barrier will stabilize the pmdval in a register or on
 	 * the stack so that it will stop changing under the code.
 	 *
 	 * When CONFIG_TRANSPARENT_HUGEPAGE=y on x86 32bit PAE,
-	 * pmd_read_atomic is allowed to return a not atomic pmdval
+	 * pmdp_get_lockless is allowed to return a not atomic pmdval
 	 * (for example pointing to an hugepage that has never been
 	 * mapped in the pmd). The below checks will only care about
 	 * the low part of the pmd with 32bit PAE x86 anyway, with the
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -361,7 +361,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 		 * huge or device mapping one and compute corresponding pfn
 		 * values.
 		 */
-		pmd = pmd_read_atomic(pmdp);
+		pmd = pmdp_get_lockless(pmdp);
 		barrier();
 		if (!pmd_devmap(pmd) && !pmd_trans_huge(pmd))
 			goto again;
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -862,7 +862,7 @@ static int find_pmd_or_thp_or_none(struc
 	if (!*pmd)
 		return SCAN_PMD_NULL;
 
-	pmde = pmd_read_atomic(*pmd);
+	pmde = pmdp_get_lockless(*pmd);
 
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	/* See comments in pmd_none_or_trans_huge_or_clear_bad() */
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -126,7 +126,7 @@ static int clean_record_pte(pte_t *pte,
 static int wp_clean_pmd_entry(pmd_t *pmd, unsigned long addr, unsigned long end,
 			      struct mm_walk *walk)
 {
-	pmd_t pmdval = pmd_read_atomic(pmd);
+	pmd_t pmdval = pmdp_get_lockless(pmd);
 
 	if (!pmd_trans_unstable(&pmdval))
 		return 0;
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -292,7 +292,7 @@ static unsigned long change_pte_range(st
  */
 static inline int pmd_none_or_clear_bad_unless_trans_huge(pmd_t *pmd)
 {
-	pmd_t pmdval = pmd_read_atomic(pmd);
+	pmd_t pmdval = pmdp_get_lockless(pmd);
 
 	/* See pmd_none_or_trans_huge_or_clear_bad for info on barrier */
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -613,7 +613,7 @@ static __always_inline ssize_t __mcopy_a
 			break;
 		}
 
-		dst_pmdval = pmd_read_atomic(dst_pmd);
+		dst_pmdval = pmdp_get_lockless(dst_pmd);
 		/*
 		 * If the dst_pmd is mapped as THP don't
 		 * override it and just be strict.
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4039,9 +4039,9 @@ static void walk_pmd_range(pud_t *pud, u
 	/* walk_pte_range() may call get_next_vma() */
 	vma = args->vma;
 	for (i = pmd_index(start), addr = start; addr != end; i++, addr = next) {
-		pmd_t val = pmd_read_atomic(pmd + i);
+		pmd_t val = pmdp_get_lockless(pmd + i);
 
-		/* for pmd_read_atomic() */
+		/* for pmdp_get_lockless() */
 		barrier();
 
 		next = pmd_addr_end(addr, end);


