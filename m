Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8E962AE57
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238619AbiKOW1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbiKOW0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:26:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F503317DA;
        Tue, 15 Nov 2022 14:26:30 -0800 (PST)
Date:   Tue, 15 Nov 2022 22:26:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668551189;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UUpgfcrTKSECYHTVg0ABlQOiEvHImTXeejhGqScpExY=;
        b=JH838R0KbldAcqXDlO0b85M4qTSLcWgCInkCdv9n/MtZR06m9Gz4ckQZruy4Bieq3Y4c2P
        mp/HowNbIEhTIWFlZzgnoJ5YC4KFiXUuoIzEaHDzlQm6Kz3iwn8OWJPBpNmzOHS75KN8qH
        SL2bw3QVD699WUf/rnY/0zhwCsyH4uBtl64LeuHw92Ju5SmGtECA7lXVhhwT61TazL1Bgd
        MAvvhpyCjugR5M4p8EgvbZ8Kz+SA4rt3G4cMFGfAsd2TflrliV0k4a4VDhHq6G9wlGxY3n
        TdpeHxipqwvlDNuRCiZeXHYPjtbtKxewoj+oODMW5aeJ717vluO4zrIjutBKsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668551189;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UUpgfcrTKSECYHTVg0ABlQOiEvHImTXeejhGqScpExY=;
        b=aJnrOC2LPrk7CTadegUTv9rK1l7u/caxSFtZRFmoQoyt72b0A0RS1AE3BOHVAHEc0hCnKp
        3ZmFWNMbGCciZ6Bg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Untangle __change_page_attr_set_clr(.checkalias)
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166855118776.4906.2762544730968503706.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     5ab815e3771eff22c9dab9e620e8050ba85f7812
Gitweb:        https://git.kernel.org/tip/5ab815e3771eff22c9dab9e620e8050ba85f7812
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 10 Nov 2022 13:33:54 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Nov 2022 22:29:57 +01:00

x86/mm: Untangle __change_page_attr_set_clr(.checkalias)

The .checkalias argument to __change_page_attr_set_clr() is overloaded
and serves two different purposes:

 - it inhibits the call to cpa_process_alias() -- as suggested by the
   name; however,

 - it also serves as 'primary' indicator for __change_page_attr()
   ( which in turn also serves as a recursion terminator for
     cpa_process_alias() ).

Untangle these by extending the use of CPA_NO_CHECK_ALIAS to all
callsites that currently use .checkalias=0 for this purpose.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20221110125544.527267183%40infradead.org
---
 arch/x86/mm/pat/set_memory.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 50f81ea..4943f6c 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1727,7 +1727,7 @@ static int __change_page_attr_set_clr(struct cpa_data *cpa, int checkalias)
 		if (ret)
 			goto out;
 
-		if (checkalias) {
+		if (checkalias && !(cpa->flags & CPA_NO_CHECK_ALIAS)) {
 			ret = cpa_process_alias(cpa);
 			if (ret)
 				goto out;
@@ -1801,18 +1801,12 @@ static int change_page_attr_set_clr(unsigned long *addr, int numpages,
 	cpa.numpages = numpages;
 	cpa.mask_set = mask_set;
 	cpa.mask_clr = mask_clr;
-	cpa.flags = 0;
+	cpa.flags = in_flag;
 	cpa.curpage = 0;
 	cpa.force_split = force_split;
 
-	if (in_flag & (CPA_ARRAY | CPA_PAGES_ARRAY))
-		cpa.flags |= in_flag;
-
 	/* No alias checking for _NX bit modifications */
 	checkalias = (pgprot_val(mask_set) | pgprot_val(mask_clr)) != _PAGE_NX;
-	/* Has caller explicitly disabled alias checking? */
-	if (in_flag & CPA_NO_CHECK_ALIAS)
-		checkalias = 0;
 
 	ret = __change_page_attr_set_clr(&cpa, checkalias);
 
@@ -2067,11 +2061,9 @@ int set_memory_np(unsigned long addr, int numpages)
 
 int set_memory_np_noalias(unsigned long addr, int numpages)
 {
-	int cpa_flags = CPA_NO_CHECK_ALIAS;
-
 	return change_page_attr_set_clr(&addr, numpages, __pgprot(0),
 					__pgprot(_PAGE_PRESENT), 0,
-					cpa_flags, NULL);
+					CPA_NO_CHECK_ALIAS, NULL);
 }
 
 int set_memory_4k(unsigned long addr, int numpages)
@@ -2288,7 +2280,7 @@ static int __set_pages_p(struct page *page, int numpages)
 				.numpages = numpages,
 				.mask_set = __pgprot(_PAGE_PRESENT | _PAGE_RW),
 				.mask_clr = __pgprot(0),
-				.flags = 0};
+				.flags = CPA_NO_CHECK_ALIAS };
 
 	/*
 	 * No alias checking needed for setting present flag. otherwise,
@@ -2296,7 +2288,7 @@ static int __set_pages_p(struct page *page, int numpages)
 	 * mappings (this adds to complexity if we want to do this from
 	 * atomic context especially). Let's keep it simple!
 	 */
-	return __change_page_attr_set_clr(&cpa, 0);
+	return __change_page_attr_set_clr(&cpa, 1);
 }
 
 static int __set_pages_np(struct page *page, int numpages)
@@ -2307,7 +2299,7 @@ static int __set_pages_np(struct page *page, int numpages)
 				.numpages = numpages,
 				.mask_set = __pgprot(0),
 				.mask_clr = __pgprot(_PAGE_PRESENT | _PAGE_RW),
-				.flags = 0};
+				.flags = CPA_NO_CHECK_ALIAS };
 
 	/*
 	 * No alias checking needed for setting not present flag. otherwise,
@@ -2315,7 +2307,7 @@ static int __set_pages_np(struct page *page, int numpages)
 	 * mappings (this adds to complexity if we want to do this from
 	 * atomic context especially). Let's keep it simple!
 	 */
-	return __change_page_attr_set_clr(&cpa, 0);
+	return __change_page_attr_set_clr(&cpa, 1);
 }
 
 int set_direct_map_invalid_noflush(struct page *page)
@@ -2386,7 +2378,7 @@ int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 		.numpages = numpages,
 		.mask_set = __pgprot(0),
 		.mask_clr = __pgprot(~page_flags & (_PAGE_NX|_PAGE_RW)),
-		.flags = 0,
+		.flags = CPA_NO_CHECK_ALIAS,
 	};
 
 	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
@@ -2399,7 +2391,7 @@ int __init kernel_map_pages_in_pgd(pgd_t *pgd, u64 pfn, unsigned long address,
 
 	cpa.mask_set = __pgprot(_PAGE_PRESENT | page_flags);
 
-	retval = __change_page_attr_set_clr(&cpa, 0);
+	retval = __change_page_attr_set_clr(&cpa, 1);
 	__flush_tlb_all();
 
 out:
@@ -2429,12 +2421,12 @@ int __init kernel_unmap_pages_in_pgd(pgd_t *pgd, unsigned long address,
 		.numpages	= numpages,
 		.mask_set	= __pgprot(0),
 		.mask_clr	= __pgprot(_PAGE_PRESENT | _PAGE_RW),
-		.flags		= 0,
+		.flags		= CPA_NO_CHECK_ALIAS,
 	};
 
 	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
 
-	retval = __change_page_attr_set_clr(&cpa, 0);
+	retval = __change_page_attr_set_clr(&cpa, 1);
 	__flush_tlb_all();
 
 	return retval;
