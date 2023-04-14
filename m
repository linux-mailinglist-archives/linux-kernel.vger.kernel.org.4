Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7046E2AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDNUNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 16:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDNUNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 16:13:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2650565B3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 13:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IFVgDJvaqoP8L0V4Ig7LOdBTpqO29/AtKOKBDjrNX24=; b=vi878U9Ico1+rwTYJ8O3q5tu1r
        4nQ0nB+d74xJhAbaFdoTjSer3VFaOgN6DSKeTO83N0NW95JfG7pXyWIqHsmEPrwuIRJegPHSeGvDF
        cR9kzVX5NVQ9+XNImzVSlwEo5XGnI8037c3KAFw6pOx4pUFdeBmds7jGaRWMO/q1If0rVqoiJqsgo
        UxMpeqr5L5Tkb5PR70EfvZFDgYOTEd8kautDqFps1UhItacTATzeflJCO9F7mzn3x7ypUEqZ3UeIM
        PXlVTdncIj/fggtHWt3o2dx7UdTup2L8tsiWiRYP1arBupwSdQBpA5ab+RKAZ41CUo7eX55GTl6kR
        qnBfb/xA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pnPmz-00933Z-7u; Fri, 14 Apr 2023 20:12:57 +0000
Date:   Fri, 14 Apr 2023 21:12:57 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Tarun Sahu <tsahu@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, mike.kravetz@oracle.com,
        aneesh.kumar@linux.ibm.com, sidhartha.kumar@oracle.com,
        gerald.schaefer@linux.ibm.com, linux-kernel@vger.kernel.org,
        jaypatel@linux.ibm.com
Subject: Re: [PATCH] mm/folio: Avoid special handling for order value 0 in
 folio_set_order
Message-ID: <ZDmzyag88pO1Kdk8@casper.infradead.org>
References: <20230414194832.973194-1-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414194832.973194-1-tsahu@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 01:18:32AM +0530, Tarun Sahu wrote:
> folio_set_order(folio, 0); which is an abuse of folio_set_order as 0-order
> folio does not have any tail page to set order.

I think you're missing the point of how folio_set_order() is used.
When splitting a large folio, we need to zero out the folio_nr_pages
in the tail, so it does have a tail page, and that tail page needs to
be zeroed.  We even assert that there is a tail page:

        if (WARN_ON_ONCE(!folio_test_large(folio)))
                return;

Or maybe you need to explain yourself better.

> folio->_folio_nr_pages is
> set to 0 for order 0 in folio_set_order. It is required because
> _folio_nr_pages overlapped with page->mapping and leaving it non zero
> caused "bad page" error while freeing gigantic hugepages. This was fixed in
> Commit ba9c1201beaa ("mm/hugetlb: clear compound_nr before freeing gigantic
> pages"). Also commit a01f43901cfb ("hugetlb: be sure to free demoted CMA
> pages to CMA") now explicitly clear page->mapping and hence we won't see
> the bad page error even if _folio_nr_pages remains unset. Also the order 0
> folios are not supposed to call folio_set_order, So now we can get rid of
> folio_set_order(folio, 0) from hugetlb code path to clear the confusion.

... this is all very confusing.

> The patch also moves _folio_set_head and folio_set_order calls in
> __prep_compound_gigantic_folio() such that we avoid clearing them in the
> error path.

But don't we need those bits set while we operate on the folio to set it
up?  It makes me nervous if we don't have those bits set because we can
end up with speculative references that point to a head page while that
page is not marked as a head page.  It may not be a problem, but I want
to see some air-tight analysis of that.

> Testing: I have run LTP tests, which all passes. and also I have written
> the test in LTP which tests the bug caused by compound_nr and page->mapping
> overlapping.
> 
> https://lore.kernel.org/all/20230413090753.883953-1-tsahu@linux.ibm.com/
> 
> Running on older kernel ( < 5.10-rc7) with the above bug this fails while
> on newer kernel and, also with this patch it passes.
> 
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  mm/hugetlb.c  | 9 +++------
>  mm/internal.h | 8 ++------
>  2 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f16b25b1a6b9..e2540269c1dc 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1489,7 +1489,6 @@ static void __destroy_compound_gigantic_folio(struct folio *folio,
>  			set_page_refcounted(p);
>  	}
>  
> -	folio_set_order(folio, 0);
>  	__folio_clear_head(folio);
>  }
>  
> @@ -1951,9 +1950,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>  	struct page *p;
>  
>  	__folio_clear_reserved(folio);
> -	__folio_set_head(folio);
> -	/* we rely on prep_new_hugetlb_folio to set the destructor */
> -	folio_set_order(folio, order);
>  	for (i = 0; i < nr_pages; i++) {
>  		p = folio_page(folio, i);
>  
> @@ -1999,6 +1995,9 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>  		if (i != 0)
>  			set_compound_head(p, &folio->page);
>  	}
> +	__folio_set_head(folio);
> +	/* we rely on prep_new_hugetlb_folio to set the destructor */
> +	folio_set_order(folio, order);
>  	atomic_set(&folio->_entire_mapcount, -1);
>  	atomic_set(&folio->_nr_pages_mapped, 0);
>  	atomic_set(&folio->_pincount, 0);
> @@ -2017,8 +2016,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>  		p = folio_page(folio, j);
>  		__ClearPageReserved(p);
>  	}
> -	folio_set_order(folio, 0);
> -	__folio_clear_head(folio);
>  	return false;
>  }
>  
> diff --git a/mm/internal.h b/mm/internal.h
> index 18cda26b8a92..0d96a3bc1d58 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -425,16 +425,12 @@ int split_free_page(struct page *free_page,
>   */
>  static inline void folio_set_order(struct folio *folio, unsigned int order)
>  {
> -	if (WARN_ON_ONCE(!folio_test_large(folio)))
> +	if (WARN_ON_ONCE(!order || !folio_test_large(folio)))
>  		return;
>  
>  	folio->_folio_order = order;
>  #ifdef CONFIG_64BIT
> -	/*
> -	 * When hugetlb dissolves a folio, we need to clear the tail
> -	 * page, rather than setting nr_pages to 1.
> -	 */
> -	folio->_folio_nr_pages = order ? 1U << order : 0;
> +	folio->_folio_nr_pages = 1U << order;
>  #endif
>  }
>  
> -- 
> 2.31.1
> 
