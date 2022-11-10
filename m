Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332976242AB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 13:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiKJM6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 07:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiKJM6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 07:58:45 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF4370193
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 04:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=aPpH2DkMTrxhIpV4/nr31HwzcYRECeuZHF/THcTg9IQ=; b=bOrHaMwgqQMBbaFqDrfYG5Hxae
        T/Nqo44VJCmxtdGCuA1GZz7PuqLSbypNVFCoIj/yLx2D5hIiVO57+QtCOEn/p2auvvRoDvl0/5EzZ
        Yodhh4+8gmn1z6tGkQsJPRi01Hf0KxkgAS2RXSeEEayJEOelh3C/TOaCYGqjoIrYNzUGMVKYaFhv5
        dDVQPE3Sz9JIrKb++4X8p+Y0AAZMQhJc+lMOKvc+RxpmoulwxAL45ylxpZGN9817SYJc1D5EIWIs9
        3gX0vbXgAcB9b9a1wHU2UrHXymxBPJMiezENM+A1jWh3V3vg29Nuzir/mUvM4Le5gQBEVTis8OnpU
        XKAryR9w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ot78X-00AHCf-9x; Thu, 10 Nov 2022 12:58:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCCF8300487;
        Thu, 10 Nov 2022 13:58:27 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AA85D2B97262B; Thu, 10 Nov 2022 13:58:27 +0100 (CET)
Message-ID: <20221110125544.594991716@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Nov 2022 13:52:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, dave.hansen@intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, oliver.sang@intel.com
Subject: [PATCH 3/4] x86/mm: Inhibit _PAGE_NX changes from cpa_process_alias()
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

There is a cludge in change_page_attr_set_clr() that inhibits
propagating NX changes to the aliases (directmap and highmap) -- this
is a cludge twofold:

 - it also inhibits the primary checks in __change_page_attr();
 - it hard depends on single bit changes.

The introduction of set_memory_rox() triggered this last issue for
clearing both _PAGE_RW and _PAGE_NX.

Explicitly ignore _PAGE_NX in cpa_process_alias() instead.

Fixes: b38994948567 ("x86/mm: Implement native set_memory_rox()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Debugged-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pat/set_memory.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1663,6 +1663,12 @@ static int cpa_process_alias(struct cpa_
 		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
 		alias_cpa.curpage = 0;
 
+		/* Directmap always has NX set, do not modify. */
+		if (__supported_pte_mask & _PAGE_NX) {
+			alias_cpa.mask_clr.pgprot &= ~_PAGE_NX;
+			alias_cpa.mask_set.pgprot &= ~_PAGE_NX;
+		}
+
 		cpa->force_flush_all = 1;
 
 		ret = __change_page_attr_set_clr(&alias_cpa, 0);
@@ -1685,6 +1691,15 @@ static int cpa_process_alias(struct cpa_
 		alias_cpa.flags &= ~(CPA_PAGES_ARRAY | CPA_ARRAY);
 		alias_cpa.curpage = 0;
 
+		/*
+		 * [_text, _brk_end) also covers data, do not modify NX except
+		 * in cases where the highmap is the primary target.
+		 */
+		if (__supported_pte_mask & _PAGE_NX) {
+			alias_cpa.mask_clr.pgprot &= ~_PAGE_NX;
+			alias_cpa.mask_set.pgprot &= ~_PAGE_NX;
+		}
+
 		cpa->force_flush_all = 1;
 		/*
 		 * The high mapping range is imprecise, so ignore the
@@ -1703,6 +1718,12 @@ static int __change_page_attr_set_clr(st
 	unsigned long rempages = numpages;
 	int ret = 0;
 
+	/*
+	 * No changes, easy!
+	 */
+	if (!(pgprot_val(cpa->mask_set) | pgprot_val(cpa->mask_clr)))
+		return ret;
+
 	while (rempages) {
 		/*
 		 * Store the remaining nr of pages for the large page
@@ -1749,7 +1770,7 @@ static int change_page_attr_set_clr(unsi
 				    struct page **pages)
 {
 	struct cpa_data cpa;
-	int ret, cache, checkalias;
+	int ret, cache;
 
 	memset(&cpa, 0, sizeof(cpa));
 
@@ -1799,10 +1820,7 @@ static int change_page_attr_set_clr(unsi
 	cpa.curpage = 0;
 	cpa.force_split = force_split;
 
-	/* No alias checking for _NX bit modifications */
-	checkalias = (pgprot_val(mask_set) | pgprot_val(mask_clr)) != _PAGE_NX;
-
-	ret = __change_page_attr_set_clr(&cpa, checkalias);
+	ret = __change_page_attr_set_clr(&cpa, 1);
 
 	/*
 	 * Check whether we really changed something:


