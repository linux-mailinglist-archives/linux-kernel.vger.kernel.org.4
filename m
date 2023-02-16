Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA200699CC6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 20:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjBPTEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 14:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBPTEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 14:04:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF825036C;
        Thu, 16 Feb 2023 11:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Yawla20fuhgFU+ZM3/0+0yPtywAw64xLIG63jDmyTgk=; b=WJ5DhKnMSiKnsiY5Co43FPaRqa
        rM3DttQzJiela82Afuc+NxA9x76rhFPUEDEvauyhgRZVOYh/36ZefNavqhAMXeEJLnC8w1LsV9ZJz
        wnuQpdz3Ox4d6nWawtAb/YGlYdRYrZeLtv8SHw3odjH0WXM1SqTfnXyVx8+ZdAXMB69xSJxE/hWCq
        tosiooAHynOPpDiriNLCJ32QnxlOF6cYpYT22+DYUMaMjtlJUn4hoLKkn/Q+urGyU18zVThHpN2l7
        EJxmwN3IPgEtPxeyhuCmNjVaOTtU9EseAv3bdUV0KMtWtDcgrBRm5IhK8PGsq6o1l/8WhSy41dWt5
        pQmdTPsA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pSjYO-008e70-Gb; Thu, 16 Feb 2023 19:04:24 +0000
Date:   Thu, 16 Feb 2023 19:04:24 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     snitzer@kernel.org, Yang Shi <shy828301@gmail.com>,
        mgorman@techsingularity.net, agk@redhat.com, dm-devel@redhat.com,
        akpm@linux-foundation.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm-crypt: allocate compound pages if possible
Message-ID: <Y+5+OKbeTO2d9TsH@casper.infradead.org>
References: <alpine.LRH.2.21.2302161245210.18393@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.2302161245210.18393@file01.intranet.prod.int.rdu2.redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 12:47:08PM -0500, Mikulas Patocka wrote:
> +		while (order > 0) {
> +			page = alloc_pages(gfp_mask
> +				| __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN, order);

... | __GFP_COMP

>  		page = mempool_alloc(&cc->page_pool, gfp_mask);
>  		if (!page) {
>  			crypt_free_buffer_pages(cc, clone);
>  			bio_put(clone);
>  			gfp_mask |= __GFP_DIRECT_RECLAIM;
> +			order = 0;
>  			goto retry;
>  		}
>  
> -		len = (remaining_size > PAGE_SIZE) ? PAGE_SIZE : remaining_size;
> -
> -		bio_add_page(clone, page, len, 0);
> +have_pages:
> +		page->compound_order = order;

No.  You'll corrupt the next page if page is order-0, which it is if it
came from the mempool.  Also we've deleted page->compound_order in -next
so you can't make this mistake.  Using __GFP_COMP will set this field
for you, so you can just drop this line.

> -		remaining_size -= len;
> +		for (o = 0; o < 1U << order; o++) {
> +			unsigned len = min((unsigned)PAGE_SIZE, remaining_size);
> +			bio_add_page(clone, page, len, 0);
> +			remaining_size -= len;
> +			page++;

You can add multiple pages at once, whether they're compound or not.  So
replace this entire loop with:

		bio_add_page(clone, page, remaining_size, 0);

> @@ -1711,10 +1732,23 @@ static void crypt_free_buffer_pages(stru
>  {
>  	struct bio_vec *bv;
>  	struct bvec_iter_all iter_all;
> +	unsigned skip_entries = 0;
>  
>  	bio_for_each_segment_all(bv, clone, iter_all) {
> -		BUG_ON(!bv->bv_page);
> -		mempool_free(bv->bv_page, &cc->page_pool);
> +		unsigned order;
> +		struct page *page = bv->bv_page;
> +		BUG_ON(!page);
> +		if (skip_entries) {
> +			skip_entries--;
> +			continue;
> +		}
> +		order = page->compound_order;
> +		if (order) {
> +			__free_pages(page, order);
> +			skip_entries = (1U << order) - 1;
> +		} else {
> +			mempool_free(page, &cc->page_pool);
> +		}

You can simplify this by using the folio code.

	struct folio_iter fi;

	bio_for_each_folio_all(fi, bio) {
		if (folio_test_large(folio))
			folio_put(folio);
		else
			mempool_free(&folio->page, &cc->page_pool);
	}

(further work would actually convert this driver to use folios instead
of pages)
