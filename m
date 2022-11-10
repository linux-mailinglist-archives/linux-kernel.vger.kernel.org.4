Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81C16242AC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:58:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiKJM6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiKJM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:58:45 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE5B70192
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=fK9e3H2vvSo4YD2UMwim5ynsXg6YjBcd0FJLh46S8ZE=; b=V36svHFuawhbJZoUBai89Jf8Tv
        CFKRKQKvE4eRIkh+tbevxX60TvNpowHCphz2U9NnQdYocNofptdwB2r0dCca1VLKpZS2uck02NOeP
        j2YRIpujpv82ScV+V+jhaKoZ37JECkNup5yK0wtzNoSwfqrvxviiiShTm5ed7RjOmFKQqCrn8C1QI
        GarWOmJQ6q5xXabemmbbEzU2sGRHccoOB4OSXDxW2KklKXhINPq7TIbrblXzy2clpufwlIB+hPiRV
        gswHXEBbbqZSnPlRZZ7ozQ2fa9ASBL7dhmKi2hs9ZiCrrttcmSBIorHDPkV644UiHN6JnIqNJiIgR
        TN2g0sYg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ot78X-00AHCh-9x; Thu, 10 Nov 2022 12:58:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C8FB130036B;
        Thu, 10 Nov 2022 13:58:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A45B4205A765D; Thu, 10 Nov 2022 13:58:27 +0100 (CET)
Message-ID: <20221110125544.527267183@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Nov 2022 13:52:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, dave.hansen@intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, oliver.sang@intel.com
Subject: [PATCH 2/4] x86/mm: Untangle __change_page_attr_set_clr(.checkalias)
References: <20221110125253.240704966@infradead.org>
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
---
 arch/x86/mm/pat/set_memory.c |   30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1721,7 +1721,7 @@ static int __change_page_attr_set_clr(st
 		if (ret)
 			goto out;
 
-		if (checkalias) {
+		if (checkalias && !(cpa->flags & CPA_NO_CHECK_ALIAS)) {
 			ret = cpa_process_alias(cpa);
 			if (ret)
 				goto out;
@@ -1795,18 +1795,12 @@ static int change_page_attr_set_clr(unsi
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
 
@@ -2061,11 +2055,9 @@ int set_memory_np(unsigned long addr, in
 
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
@@ -2282,7 +2274,7 @@ static int __set_pages_p(struct page *pa
 				.numpages = numpages,
 				.mask_set = __pgprot(_PAGE_PRESENT | _PAGE_RW),
 				.mask_clr = __pgprot(0),
-				.flags = 0};
+				.flags = CPA_NO_CHECK_ALIAS };
 
 	/*
 	 * No alias checking needed for setting present flag. otherwise,
@@ -2290,7 +2282,7 @@ static int __set_pages_p(struct page *pa
 	 * mappings (this adds to complexity if we want to do this from
 	 * atomic context especially). Let's keep it simple!
 	 */
-	return __change_page_attr_set_clr(&cpa, 0);
+	return __change_page_attr_set_clr(&cpa, 1);
 }
 
 static int __set_pages_np(struct page *page, int numpages)
@@ -2301,7 +2293,7 @@ static int __set_pages_np(struct page *p
 				.numpages = numpages,
 				.mask_set = __pgprot(0),
 				.mask_clr = __pgprot(_PAGE_PRESENT | _PAGE_RW),
-				.flags = 0};
+				.flags = CPA_NO_CHECK_ALIAS };
 
 	/*
 	 * No alias checking needed for setting not present flag. otherwise,
@@ -2309,7 +2301,7 @@ static int __set_pages_np(struct page *p
 	 * mappings (this adds to complexity if we want to do this from
 	 * atomic context especially). Let's keep it simple!
 	 */
-	return __change_page_attr_set_clr(&cpa, 0);
+	return __change_page_attr_set_clr(&cpa, 1);
 }
 
 int set_direct_map_invalid_noflush(struct page *page)
@@ -2380,7 +2372,7 @@ int __init kernel_map_pages_in_pgd(pgd_t
 		.numpages = numpages,
 		.mask_set = __pgprot(0),
 		.mask_clr = __pgprot(~page_flags & (_PAGE_NX|_PAGE_RW)),
-		.flags = 0,
+		.flags = CPA_NO_CHECK_ALIAS,
 	};
 
 	WARN_ONCE(num_online_cpus() > 1, "Don't call after initializing SMP");
@@ -2393,7 +2385,7 @@ int __init kernel_map_pages_in_pgd(pgd_t
 
 	cpa.mask_set = __pgprot(_PAGE_PRESENT | page_flags);
 
-	retval = __change_page_attr_set_clr(&cpa, 0);
+	retval = __change_page_attr_set_clr(&cpa, 1);
 	__flush_tlb_all();
 
 out:
@@ -2423,12 +2415,12 @@ int __init kernel_unmap_pages_in_pgd(pgd
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


