Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC13E675E5B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjATTsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjATTsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:48:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9CE94324
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d03v7w3Y8XlCff6/igHH0oG20Hre0Avz6+XHwVubR4M=; b=BdJbrjdi06pDLVM5tbWxRZ44cA
        ExOvpVsVE3JY9GP6qCHzk1++rM1Kfhr2+GQehjehl2bbBDCMutwJUv+sQg1gGKgj9Bi1Y5Ej8YSdU
        MVgVi27aTKjBFhFBRk7H6ozd3AS+8pYnqjrXKsas3ZOV2ticNZDDL6vk+1V7us0TtAz+7aCRMHC8A
        9R4EoeI+82A2VN3n+1V5Eh/udQcWeOQSeNezfY2hjwkIguOb8ZabvNNWDZlAvqrP6Bzq3ItJaV9+8
        /5wTealt3nuwoEMJNarZFzByWlLy0hjfcairU6GiTBzLfYcPF84L7RJcvEE3qRxbDN1zMt6e/fkXN
        rianS3PQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIxMV-002MtE-4I; Fri, 20 Jan 2023 19:47:43 +0000
Date:   Fri, 20 Jan 2023 19:47:43 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Yin, Fengwei" <fengwei.yin@intel.com>
Cc:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable 5/5] mm/mempolicy: Convert migrate_page_add()
 to migrate_folio_add()
Message-ID: <Y8rv3/GfW8XDDXj7@casper.infradead.org>
References: <20230118232219.27038-1-vishal.moola@gmail.com>
 <20230118232219.27038-6-vishal.moola@gmail.com>
 <4dd1a4f4-4da6-8079-a8de-bea7d8c18681@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dd1a4f4-4da6-8079-a8de-bea7d8c18681@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 09:24:16AM +0800, Yin, Fengwei wrote:
> On 1/19/2023 7:22 AM, Vishal Moola (Oracle) wrote:
> > @@ -1022,27 +1022,23 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
> >  }
> >  
> >  #ifdef CONFIG_MIGRATION
> > -/*
> > - * page migration, thp tail pages can be passed.
> > - */
> > -static int migrate_page_add(struct page *page, struct list_head *pagelist,
> > +static int migrate_folio_add(struct folio *folio, struct list_head *foliolist,
> >  				unsigned long flags)
> >  {
> > -	struct page *head = compound_head(page);
> >  	/*
> > -	 * Avoid migrating a page that is shared with others.
> > +	 * Avoid migrating a folio that is shared with others.
> >  	 */
> > -	if ((flags & MPOL_MF_MOVE_ALL) || page_mapcount(head) == 1) {
> > -		if (!isolate_lru_page(head)) {
> > -			list_add_tail(&head->lru, pagelist);
> > -			mod_node_page_state(page_pgdat(head),
> > -				NR_ISOLATED_ANON + page_is_file_lru(head),
> > -				thp_nr_pages(head));
> > +	if ((flags & MPOL_MF_MOVE_ALL) || folio_mapcount(folio) == 1) {
> One question to the page_mapcount -> folio_mapcount here.
> 
> For a large folio with 0 entire mapcount, if the first sub-page and any
> other sub-page are mapped, page_mapcount(head) == 1 is true while
> folio_mapcount(folio) == 1 is not.

We had a good discussion about this in today's THP Cabal meeting [1].  I
didn't quite check everything that I said was true, so let me summarise
& correct it now ...

 - This is a heuristic.  We're trying to see whether this folio is
   mapped by multiple processes (because if it is, it's probably not
   worth migrating).  If the heuristic is wrong, it probably doesn't
   matter _too_ much?
 - A proper heuristic for this would be
		folio_total_mapcount(folio) == folio_nr_pages(folio)
   but this would be expensive to calculate as it requires examining
   512 cachelines for a 2MB page.
 - For a large folio which is smaller than PMD size, we're guaranteed
   that folio_mapcount() is 0 today.
 - In the meeting I said that page_mapcount() of the head of a THP
   page was zero; that's not true; I had forgotten that we added in
   entire_mapcount to the individual page mapcount.

so I now think this should be:

	page_mapcount(folio_page(folio, 0))

with an explanation that checking every page is too heavy-weight.
Maybe it should be its own function:

static inline int folio_estimated_mapcount(folio)
{
	return page_mapcount(folio_page(folio, 0));
}

with a nice comment explaining what's going on.

[1] https://www.youtube.com/watch?v=A3PoGQQQD3Q is the recording of
today's meeting.
