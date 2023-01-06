Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6989365FBE8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 08:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjAFH2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 02:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjAFH2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 02:28:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C746ECBD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 23:28:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04B1C61CAC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 07:28:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF99EC433F0;
        Fri,  6 Jan 2023 07:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672990129;
        bh=hnLVUbqW+hMDWxgzBrfbafMeO7GTTiLPMHRcilAYX/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jM5DZ7M/a5kh4030dVn82fp3noZPdHrkH7L0NFLA4nqLducIf/sLlsXWRUyYcp8Lm
         OvSqvEin1hEXD7IWB3oiPttj4MUJFiHVTGwnr4EbUVRhM7pKW6VAndCtBFP9kPYZpZ
         /IE99rLxs30RSZn71qz92E8QmJzsyj3trtI8dELkEi/lgK3ahUR89ScwmBCpMRMJCV
         gBtu9F3GokQbe7FgmA4cVmkBmXciqw70oCJ1bakwBGa9Pt4xppGPs1fS0oseriiNX5
         vwncSyCXl/AF2NnHxZR6zzKegO9DqBY6V026ZmIwOJ0sm86w6Ge+tjEs1Vbcz/quQY
         ntjmJFrpYUSKQ==
Date:   Fri, 6 Jan 2023 09:28:35 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] maple_tree: Remove GFP_ZERO from kmem_cache_alloc() and
 kmem_cache_alloc_bulk()
Message-ID: <Y7fNo4IElYXCyPmd@kernel.org>
References: <20230105160427.2988454-1-Liam.Howlett@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105160427.2988454-1-Liam.Howlett@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 04:05:34PM +0000, Liam Howlett wrote:
> Preallocations are common in the VMA code to avoid allocating under
> certain locking conditions.  The preallocations must also cover the
> worst-case scenario.  Removing the GFP_ZERO flag from the
> kmem_cache_alloc() (and bulk variant) calls will reduce the amount of
> time spent zeroing memory that may not be used.  Only zero out the
> necessary area to keep track of the allocations in the maple state.
> Zero the entire node prior to using it in the tree.
> 
> This required internal changes to node counting on allocation, so the
> test code is also updated.
> 
> This restores some micro-benchmark performance:
> up to +9% in mmtests mmap1 by my testing
> +10% to +20% in mmap, mmapaddr, mmapmany tests reported by Red Hat
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2149636
> Reported-by: Jirka Hladky <jhladky@redhat.com>
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Liam Howlett <Liam.Howlett@oracle.com>
> ---
>  lib/maple_tree.c                 | 80 +++++++++++++++++---------------
>  tools/testing/radix-tree/maple.c | 18 +++----
>  2 files changed, 52 insertions(+), 46 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 26e2045d3cda..82a8121fe49b 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -149,13 +149,12 @@ struct maple_subtree_state {
>  /* Functions */
>  static inline struct maple_node *mt_alloc_one(gfp_t gfp)
>  {
> -	return kmem_cache_alloc(maple_node_cache, gfp | __GFP_ZERO);
> +	return kmem_cache_alloc(maple_node_cache, gfp);
>  }
>  
>  static inline int mt_alloc_bulk(gfp_t gfp, size_t size, void **nodes)
>  {
> -	return kmem_cache_alloc_bulk(maple_node_cache, gfp | __GFP_ZERO, size,
> -				     nodes);
> +	return kmem_cache_alloc_bulk(maple_node_cache, gfp, size, nodes);
>  }
>  
>  static inline void mt_free_bulk(size_t size, void __rcu **nodes)
> @@ -1127,9 +1126,10 @@ static inline struct maple_node *mas_pop_node(struct ma_state *mas)
>  {
>  	struct maple_alloc *ret, *node = mas->alloc;
>  	unsigned long total = mas_allocated(mas);
> +	unsigned int req = mas_alloc_req(mas);
>  
>  	/* nothing or a request pending. */
> -	if (unlikely(!total))
> +	if (WARN_ON(!total))

Hmm, isn't WARN_ON() here too much?

>  		return NULL;
>  
>  	if (total == 1) {
> @@ -1139,27 +1139,25 @@ static inline struct maple_node *mas_pop_node(struct ma_state *mas)
>  		goto single_node;
>  	}
>  
> -	if (!node->node_count) {
> +	if (node->node_count == 1) {
>  		/* Single allocation in this node. */
>  		mas->alloc = node->slot[0];
> -		node->slot[0] = NULL;
>  		mas->alloc->total = node->total - 1;
>  		ret = node;
>  		goto new_head;
>  	}
> -
>  	node->total--;
> -	ret = node->slot[node->node_count];
> -	node->slot[node->node_count--] = NULL;
> +	ret = node->slot[--node->node_count];
> +	node->slot[node->node_count] = NULL;
>  
>  single_node:
>  new_head:
> -	ret->total = 0;
> -	ret->node_count = 0;
> -	if (ret->request_count) {
> -		mas_set_alloc_req(mas, ret->request_count + 1);
> -		ret->request_count = 0;
> +	if (req) {
> +		req++;
> +		mas_set_alloc_req(mas, req);
>  	}
> +
> +	memset(ret, 0, sizeof(*ret));
>  	return (struct maple_node *)ret;
>  }
>  
> @@ -1178,21 +1176,20 @@ static inline void mas_push_node(struct ma_state *mas, struct maple_node *used)
>  	unsigned long count;
>  	unsigned int requested = mas_alloc_req(mas);
>  
> -	memset(reuse, 0, sizeof(*reuse));
>  	count = mas_allocated(mas);
>  
> -	if (count && (head->node_count < MAPLE_ALLOC_SLOTS - 1)) {
> -		if (head->slot[0])
> -			head->node_count++;
> -		head->slot[head->node_count] = reuse;
> +	reuse->request_count = 0;
> +	reuse->node_count = 0;
> +	if (count && (head->node_count < MAPLE_ALLOC_SLOTS)) {
> +		head->slot[head->node_count++] = reuse;
>  		head->total++;
>  		goto done;
>  	}
>  
>  	reuse->total = 1;
>  	if ((head) && !((unsigned long)head & 0x1)) {
> -		head->request_count = 0;
>  		reuse->slot[0] = head;
> +		reuse->node_count = 1;
>  		reuse->total += head->total;
>  	}
>  
> @@ -1211,7 +1208,6 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
>  {
>  	struct maple_alloc *node;
>  	unsigned long allocated = mas_allocated(mas);
> -	unsigned long success = allocated;
>  	unsigned int requested = mas_alloc_req(mas);
>  	unsigned int count;
>  	void **slots = NULL;
> @@ -1227,24 +1223,29 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
>  		WARN_ON(!allocated);
>  	}
>  
> -	if (!allocated || mas->alloc->node_count == MAPLE_ALLOC_SLOTS - 1) {
> +	if (!allocated || mas->alloc->node_count == MAPLE_ALLOC_SLOTS) {
>  		node = (struct maple_alloc *)mt_alloc_one(gfp);
>  		if (!node)
>  			goto nomem_one;
>  
> -		if (allocated)
> +		if (allocated) {
>  			node->slot[0] = mas->alloc;
> +			node->node_count = 1;
> +		} else {
> +			node->node_count = 0;
> +		}
>  
> -		success++;
>  		mas->alloc = node;
> +		node->total = ++allocated;
>  		requested--;
>  	}
>  
>  	node = mas->alloc;
> +	node->request_count = 0;
>  	while (requested) {
>  		max_req = MAPLE_ALLOC_SLOTS;
> -		if (node->slot[0]) {
> -			unsigned int offset = node->node_count + 1;
> +		if (node->node_count) {
> +			unsigned int offset = node->node_count;
>  
>  			slots = (void **)&node->slot[offset];
>  			max_req -= offset;
> @@ -1258,15 +1259,13 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
>  			goto nomem_bulk;
>  
>  		node->node_count += count;
> -		/* zero indexed. */
> -		if (slots == (void **)&node->slot)
> -			node->node_count--;
> -
> -		success += count;
> +		allocated += count;
>  		node = node->slot[0];
> +		node->node_count = 0;
> +		node->request_count = 0;
>  		requested -= count;
>  	}
> -	mas->alloc->total = success;
> +	mas->alloc->total = allocated;
>  	return;
>  
>  nomem_bulk:
> @@ -1275,7 +1274,7 @@ static inline void mas_alloc_nodes(struct ma_state *mas, gfp_t gfp)
>  nomem_one:
>  	mas_set_alloc_req(mas, requested);
>  	if (mas->alloc && !(((unsigned long)mas->alloc & 0x1)))
> -		mas->alloc->total = success;
> +		mas->alloc->total = allocated;
>  	mas_set_err(mas, -ENOMEM);
>  	return;
>  
> @@ -5745,6 +5744,7 @@ int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>  void mas_destroy(struct ma_state *mas)
>  {
>  	struct maple_alloc *node;
> +	unsigned long total;
>  
>  	/*
>  	 * When using mas_for_each() to insert an expected number of elements,
> @@ -5767,14 +5767,20 @@ void mas_destroy(struct ma_state *mas)
>  	}
>  	mas->mas_flags &= ~(MA_STATE_BULK|MA_STATE_PREALLOC);
>  
> -	while (mas->alloc && !((unsigned long)mas->alloc & 0x1)) {
> +	total = mas_allocated(mas);
> +	while (total) {
>  		node = mas->alloc;
>  		mas->alloc = node->slot[0];
> -		if (node->node_count > 0)
> -			mt_free_bulk(node->node_count,
> -				     (void __rcu **)&node->slot[1]);
> +		if (node->node_count > 1) {
> +			size_t count = node->node_count - 1;
> +
> +			mt_free_bulk(count, (void __rcu **)&node->slot[1]);
> +			total -= count;
> +		}
>  		kmem_cache_free(maple_node_cache, node);
> +		total--;
>  	}
> +
>  	mas->alloc = NULL;
>  }
>  EXPORT_SYMBOL_GPL(mas_destroy);
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index 81fa7ec2e66a..1f36bc1c5d36 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -173,11 +173,11 @@ static noinline void check_new_node(struct maple_tree *mt)
>  
>  		if (!MAPLE_32BIT) {
>  			if (i >= 35)
> -				e = i - 35;
> +				e = i - 34;
>  			else if (i >= 5)
> -				e = i - 5;
> +				e = i - 4;
>  			else if (i >= 2)
> -				e = i - 2;
> +				e = i - 1;
>  		} else {
>  			if (i >= 4)
>  				e = i - 4;
> @@ -305,17 +305,17 @@ static noinline void check_new_node(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas.node != MA_ERROR(-ENOMEM));
>  	MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
>  	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 1);
> -	MT_BUG_ON(mt, mas.alloc->node_count != MAPLE_ALLOC_SLOTS - 1);
> +	MT_BUG_ON(mt, mas.alloc->node_count != MAPLE_ALLOC_SLOTS);
>  
>  	mn = mas_pop_node(&mas); /* get the next node. */
>  	MT_BUG_ON(mt, mn == NULL);
>  	MT_BUG_ON(mt, not_empty(mn));
>  	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS);
> -	MT_BUG_ON(mt, mas.alloc->node_count != MAPLE_ALLOC_SLOTS - 2);
> +	MT_BUG_ON(mt, mas.alloc->node_count != MAPLE_ALLOC_SLOTS - 1);
>  
>  	mas_push_node(&mas, mn);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 1);
> -	MT_BUG_ON(mt, mas.alloc->node_count != MAPLE_ALLOC_SLOTS - 1);
> +	MT_BUG_ON(mt, mas.alloc->node_count != MAPLE_ALLOC_SLOTS);
>  
>  	/* Check the limit of pop/push/pop */
>  	mas_node_count(&mas, MAPLE_ALLOC_SLOTS + 2); /* Request */
> @@ -323,14 +323,14 @@ static noinline void check_new_node(struct maple_tree *mt)
>  	MT_BUG_ON(mt, mas.node != MA_ERROR(-ENOMEM));
>  	MT_BUG_ON(mt, !mas_nomem(&mas, GFP_KERNEL));
>  	MT_BUG_ON(mt, mas_alloc_req(&mas));
> -	MT_BUG_ON(mt, mas.alloc->node_count);
> +	MT_BUG_ON(mt, mas.alloc->node_count != 1);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 2);
>  	mn = mas_pop_node(&mas);
>  	MT_BUG_ON(mt, not_empty(mn));
>  	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 1);
> -	MT_BUG_ON(mt, mas.alloc->node_count  != MAPLE_ALLOC_SLOTS - 1);
> +	MT_BUG_ON(mt, mas.alloc->node_count  != MAPLE_ALLOC_SLOTS);
>  	mas_push_node(&mas, mn);
> -	MT_BUG_ON(mt, mas.alloc->node_count);
> +	MT_BUG_ON(mt, mas.alloc->node_count != 1);
>  	MT_BUG_ON(mt, mas_allocated(&mas) != MAPLE_ALLOC_SLOTS + 2);
>  	mn = mas_pop_node(&mas);
>  	MT_BUG_ON(mt, not_empty(mn));
> -- 
> 2.35.1
> 

-- 
Sincerely yours,
Mike.
