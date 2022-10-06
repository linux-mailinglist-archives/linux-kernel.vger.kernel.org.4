Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEEF5F6A05
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJFOsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbiJFOrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:47:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B3BAE841
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665067654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V7KJVCGDP1E6PHwh3K1PS2Vq1v9Vxn8/icFx8u9Ndy0=;
        b=Uzir6y93FyA+9BkSzYVG0nmol7iN1nMQFXUu1WG4hbutl1Qpw+UZ6QYEnU25f9mgBDyltw
        HczKbKu4DLmUbrop/a1VjXTEEsWsiuRoiKn2fxnPGs6u74xwrmnyBL8Rc1LLNSEXT3f8VT
        0X8aPdfgAvm/unyl8Cr0gtTNd2cChUo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-Y0S2tTfdPj2HXP6uChQ8Ug-1; Thu, 06 Oct 2022 10:47:23 -0400
X-MC-Unique: Y0S2tTfdPj2HXP6uChQ8Ug-1
Received: by mail-qk1-f197.google.com with SMTP id h7-20020a05620a400700b006cebec84734so1601426qko.23
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 07:47:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7KJVCGDP1E6PHwh3K1PS2Vq1v9Vxn8/icFx8u9Ndy0=;
        b=FRT0ickHzb6yGkrv1SOxFChxh2QQnUOluBje/SaIgwKbO8IGgOPAI4RUF/WEkIurA7
         IixJrrEtxC6MIx3gleMkXmmY5AHCdYqzM8gOlJ3jcb8UVHSOa4i5yLdacxplUEY7mG49
         cwbuEdL7QKSygJAD4sbOHwJDoBMgmwJI5AWRNLXnletZ/b4AGhHpgdi2M1cV6udtjEv3
         MzpZt1gaCsY/8mz6GaRAWqjUXRhe7g3+Eqq6RI2HJXc7iiZiD82bSmUVKc/t5Ot/HZIW
         fDvzx0ziV8pWbZAp8flRoqjmyUyQqj61x1pdnkjoEObDnPQbDG3B0CC3or3VuWHy1oEn
         8czQ==
X-Gm-Message-State: ACrzQf3CklDvQIx8TYoPu+rjTJhk4or/U5vmG4tGUq6sb2JUsdMJhlFd
        KUtRbIHIoW4O0Ws+NxmT7z+FJJ7u7muxGuG01vW3jsS8OUEM6VvdYT2Zl50c/khFEbys+9F91vN
        SL2Hakx910stIZHeRSY7P7tQq
X-Received: by 2002:a05:6214:242a:b0:4aa:9c94:5d77 with SMTP id gy10-20020a056214242a00b004aa9c945d77mr83384qvb.99.1665067642952;
        Thu, 06 Oct 2022 07:47:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5OOQ87tnoM4g+nsxhTviTOUzCc0wFPb5JS+fAFspnuAaAOWqj1mCTZjwNgGex0q2mmvO7zGg==
X-Received: by 2002:a05:6214:242a:b0:4aa:9c94:5d77 with SMTP id gy10-20020a056214242a00b004aa9c945d77mr83348qvb.99.1665067642543;
        Thu, 06 Oct 2022 07:47:22 -0700 (PDT)
Received: from bfoster (c-24-61-119-116.hsd1.ma.comcast.net. [24.61.119.116])
        by smtp.gmail.com with ESMTPSA id h6-20020a05620a244600b006d94c499d8fsm5500940qkn.50.2022.10.06.07.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 07:47:22 -0700 (PDT)
Date:   Thu, 6 Oct 2022 10:47:20 -0400
From:   Brian Foster <bfoster@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     mgorman@techsingularity.net, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: mempool: introduce page bulk allocator
Message-ID: <Yz7qeI0s6TjSEIFe@bfoster>
References: <20221005180341.1738796-1-shy828301@gmail.com>
 <20221005180341.1738796-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005180341.1738796-3-shy828301@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 11:03:39AM -0700, Yang Shi wrote:
> Since v5.13 the page bulk allocator was introduced to allocate order-0
> pages in bulk.  There are a few mempool allocator callers which does
> order-0 page allocation in a loop, for example, dm-crypt, f2fs compress,
> etc.  A mempool page bulk allocator seems useful.  So introduce the
> mempool page bulk allocator.
> 
> It introduces the below APIs:
>   - mempool_init_pages_bulk()
>   - mempool_create_pages_bulk()
> They initialize the mempool for page bulk allocator.  The pool is filled
> by alloc_page() in a loop.
> 
>   - mempool_alloc_pages_bulk_list()
>   - mempool_alloc_pages_bulk_array()
> They do bulk allocation from mempool.
> They do the below conceptually:
>   1. Call bulk page allocator
>   2. If the allocation is fulfilled then return otherwise try to
>      allocate the remaining pages from the mempool
>   3. If it is fulfilled then return otherwise retry from #1 with sleepable
>      gfp
>   4. If it is still failed, sleep for a while to wait for the mempool is
>      refilled, then retry from #1
> The populated pages will stay on the list or array until the callers
> consume them or free them.
> Since mempool allocator is guaranteed to success in the sleepable context,
> so the two APIs return true for success or false for fail.  It is the
> caller's responsibility to handle failure case (partial allocation), just
> like the page bulk allocator.
> 
> The mempool typically is an object agnostic allocator, but bulk allocation
> is only supported by pages, so the mempool bulk allocator is for page
> allocation only as well.
> 
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---

Hi Yang,

I'm not terribly familiar with either component so I'm probably missing
context/details, but just a couple high level thoughts when reading your
patches...

>  include/linux/mempool.h |  19 ++++
>  mm/mempool.c            | 188 +++++++++++++++++++++++++++++++++++++---
>  2 files changed, 197 insertions(+), 10 deletions(-)
> 
...
> diff --git a/mm/mempool.c b/mm/mempool.c
> index ba32151f3843..7711ca2e6d66 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -177,6 +177,7 @@ void mempool_destroy(mempool_t *pool)
>  EXPORT_SYMBOL(mempool_destroy);
>  
>  static inline int __mempool_init(mempool_t *pool, int min_nr,
> +				 mempool_alloc_pages_bulk_t *alloc_pages_bulk_fn,
>  				 mempool_alloc_t *alloc_fn,
>  				 mempool_free_t *free_fn, void *pool_data,
>  				 gfp_t gfp_mask, int node_id)
> @@ -186,8 +187,11 @@ static inline int __mempool_init(mempool_t *pool, int min_nr,
>  	pool->pool_data = pool_data;
>  	pool->alloc	= alloc_fn;
>  	pool->free	= free_fn;
> +	pool->alloc_pages_bulk = alloc_pages_bulk_fn;
>  	init_waitqueue_head(&pool->wait);
>  
> +	WARN_ON_ONCE(alloc_pages_bulk_fn && alloc_fn);
> +
>  	pool->elements = kmalloc_array_node(min_nr, sizeof(void *),
>  					    gfp_mask, node_id);
>  	if (!pool->elements)
> @@ -199,7 +203,10 @@ static inline int __mempool_init(mempool_t *pool, int min_nr,
>  	while (pool->curr_nr < pool->min_nr) {
>  		void *element;
>  
> -		element = pool->alloc(gfp_mask, pool->pool_data);
> +		if (pool->alloc_pages_bulk)
> +			element = alloc_page(gfp_mask);

Any reason to not use the callback from the caller for the bulk variant
here? It looks like some users might expect consistency between the
alloc / free callbacks for the pool. I.e., I'm not familiar with
dm-crypt, but the code modified in the subsequent patches looks like it
keeps an allocated page count. Will that still work with this, assuming
these pages are freed through free_fn?

> +		else
> +			element = pool->alloc(gfp_mask, pool->pool_data);
>  		if (unlikely(!element)) {
>  			mempool_exit(pool);
>  			return -ENOMEM;
...
> @@ -457,6 +499,132 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL(mempool_alloc);
>  
> +/**
> + * mempool_alloc_pages_bulk - allocate a bulk of pagesfrom a specific
> + *                           memory pool
> + * @pool:       pointer to the memory pool which was allocated via
> + *              mempool_create().
> + * @gfp_mask:   the usual allocation bitmask.
> + * @nr:         the number of requested pages.
> + * @page_list:  the list the pages will be added to.
> + * @page_array: the array the pages will be added to.
> + *
> + * this function only sleeps if the alloc_pages_bulk_fn() function sleeps
> + * or the allocation can not be satisfied even though the mempool is depleted.
> + * Note that due to preallocation, this function *never* fails when called
> + * from process contexts. (it might fail if called from an IRQ context.)
> + * Note: using __GFP_ZERO is not supported.  And the caller should not pass
> + * in both valid page_list and page_array.
> + *
> + * Return: true when nr pages are allocated or false if not.  It is the
> + *         caller's responsibility to free the partial allocated pages.
> + */
> +static bool mempool_alloc_pages_bulk(mempool_t *pool, gfp_t gfp_mask,
> +				     unsigned int nr,
> +				     struct list_head *page_list,
> +				     struct page **page_array)
> +{
> +	unsigned long flags;
> +	wait_queue_entry_t wait;
> +	gfp_t gfp_temp;
> +	int i;
> +	unsigned int ret, nr_remaining;
> +	struct page *page;
> +

This looks like a lot of duplicate boilerplate from mempool_alloc().
Could this instead do something like: rename the former to
__mempool_alloc() and add a count parameter, implement bulk alloc
support in there for count > 1, then let traditional (i.e., non-bulk)
mempool_alloc() callers pass a count of 1?

Along the same lines, I also wonder if there's any value in generic bulk
alloc support for mempool. For example, I suppose technically this could
be implemented via one change to support a pool->alloc_bulk() callback
that any user could implement via a loop if they wanted
mempool_alloc_bulk() support backed by a preallocated pool. The page
based user could then just use that to call alloc_pages_bulk_*() as an
optimization without the mempool layer needing to know or care about
whether the underlying elements are pages or not. Hm?

Brian

> +	VM_WARN_ON_ONCE(gfp_mask & __GFP_ZERO);
> +	might_alloc(gfp_mask);
> +
> +	gfp_mask |= __GFP_NOMEMALLOC;   /* don't allocate emergency reserves */
> +	gfp_mask |= __GFP_NORETRY;      /* don't loop in __alloc_pages */
> +	gfp_mask |= __GFP_NOWARN;       /* failures are OK */
> +
> +	gfp_temp = gfp_mask & ~(__GFP_DIRECT_RECLAIM|__GFP_IO);
> +
> +repeat_alloc:
> +	i = 0;
> +	ret = pool->alloc_pages_bulk(gfp_temp, nr, pool->pool_data, page_list,
> +				     page_array);
> +
> +	if (ret == nr)
> +		return true;
> +
> +	nr_remaining = nr - ret;
> +
> +	spin_lock_irqsave(&pool->lock, flags);
> +	/* Allocate page from the pool and add to the list or array */
> +	while (pool->curr_nr && (nr_remaining > 0)) {
> +		page = remove_element(pool);
> +		spin_unlock_irqrestore(&pool->lock, flags);
> +		smp_wmb();
> +
> +		kmemleak_update_trace((void *)page);
> +
> +		if (page_list)
> +			list_add(&page->lru, page_list);
> +		else
> +			page_array[ret + i] = page;
> +
> +		i++;
> +		nr_remaining--;
> +
> +		spin_lock_irqsave(&pool->lock, flags);
> +	}
> +
> +	spin_unlock_irqrestore(&pool->lock, flags);
> +
> +	if (!nr_remaining)
> +		return true;
> +
> +	/*
> +	 * The bulk allocator counts in the populated pages for array,
> +	 * but don't do it for list.
> +	 */
> +	if (page_list)
> +		nr = nr_remaining;
> +
> +	/*
> +	 * We use gfp mask w/o direct reclaim or IO for the first round.  If
> +	 * alloc failed with that and @pool was empty, retry immediately.
> +	 */
> +	if (gfp_temp != gfp_mask) {
> +		gfp_temp = gfp_mask;
> +		goto repeat_alloc;
> +	}
> +
> +	/* We must not sleep if !__GFP_DIRECT_RECLAIM */
> +	if (!(gfp_mask & __GFP_DIRECT_RECLAIM))
> +		return false;
> +
> +	/* Let's wait for someone else to return an element to @pool */
> +	init_wait(&wait);
> +	prepare_to_wait(&pool->wait, &wait, TASK_UNINTERRUPTIBLE);
> +
> +	/*
> +	 * FIXME: this should be io_schedule().  The timeout is there as a
> +	 * workaround for some DM problems in 2.6.18.
> +	 */
> +	io_schedule_timeout(5*HZ);
> +
> +	finish_wait(&pool->wait, &wait);
> +	goto repeat_alloc;
> +}
> +
> +bool mempool_alloc_pages_bulk_list(mempool_t *pool, gfp_t gfp_mask,
> +				   unsigned int nr,
> +				   struct list_head *page_list)
> +{
> +	return mempool_alloc_pages_bulk(pool, gfp_mask, nr, page_list, NULL);
> +}
> +EXPORT_SYMBOL(mempool_alloc_pages_bulk_list);
> +
> +bool mempool_alloc_pages_bulk_array(mempool_t *pool, gfp_t gfp_mask,
> +				    unsigned int nr,
> +				    struct page **page_array)
> +{
> +	return mempool_alloc_pages_bulk(pool, gfp_mask, nr, NULL, page_array);
> +}
> +EXPORT_SYMBOL(mempool_alloc_pages_bulk_array);
> +
>  /**
>   * mempool_free - return an element to the pool.
>   * @element:   pool element pointer.
> -- 
> 2.26.3
> 

