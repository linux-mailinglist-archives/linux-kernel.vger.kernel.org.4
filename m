Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613535BF29D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 03:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiIUBP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 21:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiIUBPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 21:15:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC55C3DBCB
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 18:15:20 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MXL253FNwzMnV0;
        Wed, 21 Sep 2022 09:10:37 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 09:15:18 +0800
Received: from [10.67.101.149] (10.67.101.149) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 21 Sep 2022 09:15:18 +0800
Subject: Re: [PATCH v2] iommu/iova: Optimize alloc_iova with rbtree_augmented
To:     Peng Zhang <zhangpeng.00@bytedance.com>, <joro@8bytes.org>,
        <will@kernel.org>
References: <20220824095139.66477-1-zhangpeng.00@bytedance.com>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <robin.murphy@arm.com>
From:   "wangjie (L)" <wangjie125@huawei.com>
Message-ID: <42909903-5b6c-efe8-9ed3-3ac012f1a421@huawei.com>
Date:   Wed, 21 Sep 2022 09:15:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20220824095139.66477-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.149]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch seems to solve the performance issues i have.  Currently my 
nic's rx performance is unstable in large-capacity scenarios. I applied 
this patch to 5.19 rc4 and tested 8 times rx performance in these 
scenes. Here are test results, "before" row is the result of 5.19 rc4. 
"after" row means 5.19 rc4 with this patch, the unit is Mbits/s

	1	2	3	4	5	6	7	8
before	55430	76701	84194	77560	88292	90106	87770	77273	
after	92770	92767	92792	92764	92742	92696	92781	92756

Obviously, after using this patch, the performance is stable.

On 2022/8/24 17:51, Peng Zhang wrote:
> The current algorithm of alloc_iova is to scan all iovas until it finds
> a gap that satisfies the condition to allocate. This can be very slow in
> some scenarios. We can optimize alloc_iova() from time complexity O(n)
> to O(log(n)).
>
> We can make a test like this:
> Write a module and initialize iova_domain with 4k granule.
> Then using a user-mode program to call the module to allocate iova of
> size 1 2^20 times within the allocation limit of 2^20. This is single
> threaded and the low 4g space is full after 2^20 allocations.
>
> Finally loop the following three steps:
> 1. Randomly releases an iova.
>
> 2. Allocate an iova of size 1 within the allocation limit of 2^20.
>
> 3. Allocate an iova of size 1 within the allocation limit of 2^20.
>    This will fail and take a very long time, because max32_alloc_size
>    is reset whenever an iova is released.
>
> The data below is the result of repeating the three steps 1024 times in
> a physical machine with a CPU clocked at 2.30GHz
>
> Before improvement:
> Tracing 1 functions for "alloc_iova"...
>    nsecs             : count    distbution
>      256 -> 511      : 1594    |                                      |
>      512 -> 1023     : 1030686 |**************************************|
>     1024 -> 2047     : 14661   |                                      |
>     2048 -> 4095     : 1730    |                                      |
>     4096 -> 8191     : 634     |                                      |
>     8192 -> 16383    : 20      |                                      |
>    16384 -> 32767    : 2       |                                      |
>    32768 -> 65535    : 2       |                                      |
>    65536 -> 131071   : 3       |                                      |
>   131072 -> 262143   : 6       |                                      |
>   262144 -> 524287   : 8       |                                      |
>   524288 -> 1048575  : 19      |                                      |
>  1048576 -> 2097151  : 35      |                                      |
>  2097152 -> 4194303  : 55      |                                      |
>  4194304 -> 8388607  : 117     |                                      |
>  8388608 -> 16777215 : 165     |                                      |
> 16777216 -> 33554431 : 1112    |                                      |
> avg = 33867 nsecs, total: 35589643563 nsecs, count: 1050849
>
> With improvement:
> Tracing 1 functions for "alloc_iova"...
> nsecs             : count     distribution
>   512 -> 1023     : 1033561  |****************************************|
>  1024 -> 2047     : 13631    |                                        |
>  2048 -> 4095     : 2981     |                                        |
>  4096 -> 8191     : 448      |                                        |
>  8192 -> 16383    : 5        |                                        |
> 16384 -> 32767    : 1        |                                        |
> avg = 696 nsecs, total: 732196323 nsecs, count: 1050627
>
> Introduce the improved algorithm:
>
> ------------------------------------------------------------------------
> | gap1  |iova1| gap2 |iova2| gap3 |iova3|   gap4  |iova4| gap5  |anchor|
> ------------------------------------------------------------------------
>
> let A = allocatable_size
> let B = max_allocatable_size
>                     ____________
>                   /    iova2     \      B = max( left_child->B,
>                  |       A        |              right_child->B,
>                   \      B       /               A)
>                     ------------
>                    /            \
>                   /              \
>     ____________                    ____________
>   /    iova1     \                /    iova4     \
>  |       A        |              |       A        |
>   \      B       /                \      B        /
>     ------------                    ------------
>                                    /            \
>                                   /              \
>                     ____________                    ____________
>                   /    iova3     \                /    anchor    \
>                  |       A        |              |       A        |
>                   \      B       /                \      B        /
>                     ------------                    ------------
>
> Define the gap of a iova is the gap between the iova and it's previous
> iova. Such as the gap of iova3 is gap3.This gap can be used to allocate.
>
> Add three variables to struct iova.
> prev_iova:
>          point to the previous iova, sush as iova3->prev_iova point to
>          iova2.
>
> allocatable_size:
>          allocatable_size is the max size can be allocated from a gap.
>          It is not the length of a gap because the allocated address
>          may need to be aligned.
>
> max_allocatable_size:
>          max_allocatable_size is the max allocatable_size of all iova's
>          gap in the subtree.
>
>          max_allocatable_size = max( left_child->max_allocatable_size,
>                                      right_child->max_allocatable_size,
>                                      allocatable_size)
>
> We can use rbtree_augmented to maintain max_allocatable_size in time
> complexity O(log(n)).
>
> In the rbtree, with the max_allocatable_size and allocatable_size,
> searching the gap to allocate is fast and the time complexity is
> O(log(n)).
>
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  drivers/iommu/iova.c | 265 ++++++++++++++++++++++++++++++++-----------
>  include/linux/iova.h |   5 +-
>  2 files changed, 204 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index db77aa675145..79625ac82560 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -43,6 +43,56 @@ static struct iova *to_iova(struct rb_node *node)
>  	return rb_entry(node, struct iova, node);
>  }
>
> +/*
> + * We can't judge whether it can be allocated only by a given interval length
> + * because the address may be aligned.
> + * This function computes the max allocatable size for a given interval.
> + * The time complexity of this function is O(log(n)).
> + */
> +static unsigned long __compute_allocatable_size(unsigned long lo,
> +						unsigned long hi)
> +{
> +	unsigned long allocatable_size = 0;
> +
> +	if (lo == 0)
> +		return hi;
> +	while (lo < hi) {
> +		unsigned long delta = 1UL << __ffs64(lo);
> +
> +		if (hi - lo <= delta) {
> +			allocatable_size = max(allocatable_size, hi - lo);
> +			break;
> +		}
> +		allocatable_size = max(allocatable_size, delta);
> +		lo += delta;
> +	}
> +	return allocatable_size;
> +}
> +
> +static inline unsigned long prev_iova_high(struct iova *iova)
> +{
> +	return iova->prev_iova ? iova->prev_iova->pfn_hi + 1 : 0;
> +}
> +
> +static inline unsigned long iova_compute_allocatable_size(struct iova *iova)
> +{
> +	return __compute_allocatable_size(prev_iova_high(iova), iova->pfn_lo);
> +}
> +
> +static inline unsigned long iova_get_allocatable_size(struct iova *iova)
> +{
> +	return iova->allocatable_size;
> +}
> +
> +RB_DECLARE_CALLBACKS_MAX(static, iova_gap_callbacks, struct iova, node,
> +			 unsigned long, max_allocatable_size,
> +			 iova_get_allocatable_size)
> +
> +static inline void iova_max_allocatable_size_update(struct iova *iova)
> +{
> +	iova_gap_callbacks_propagate(&iova->node, NULL);
> +}
> +
>  void
>  init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>  	unsigned long start_pfn)
> @@ -63,8 +113,16 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
>  	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
>  	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
>  	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
> +	iovad->anchor.prev_iova = NULL;
> +	iovad->anchor.allocatable_size =
> +				__compute_allocatable_size(0, IOVA_ANCHOR);
> +	iovad->anchor.max_allocatable_size  = iovad->anchor.allocatable_size;
> +
>  	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
>  	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
> +
> +	if (start_pfn)
> +		reserve_iova(iovad, 0, start_pfn - 1);
>  }
>  EXPORT_SYMBOL_GPL(init_iova_domain);
>
> @@ -87,7 +145,8 @@ __cached_rbnode_insert_update(struct iova_domain *iovad, struct iova *new)
>  }
>
>  static void
> -__cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
> +__cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free,
> +			      struct rb_node *next)
>  {
>  	struct iova *cached_iova;
>
> @@ -95,51 +154,32 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
>  	if (free == cached_iova ||
>  	    (free->pfn_hi < iovad->dma_32bit_pfn &&
>  	     free->pfn_lo >= cached_iova->pfn_lo))
> -		iovad->cached32_node = rb_next(&free->node);
> +		iovad->cached32_node = next;
>
>  	if (free->pfn_lo < iovad->dma_32bit_pfn)
>  		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
>
>  	cached_iova = to_iova(iovad->cached_node);
>  	if (free->pfn_lo >= cached_iova->pfn_lo)
> -		iovad->cached_node = rb_next(&free->node);
> +		iovad->cached_node = next;
>  }
>
> -static struct rb_node *iova_find_limit(struct iova_domain *iovad, unsigned long limit_pfn)
> +static struct rb_node *iova_find_limit(struct iova_domain *iovad,
> +				       unsigned long limit_pfn)
>  {
> -	struct rb_node *node, *next;
> -	/*
> -	 * Ideally what we'd like to judge here is whether limit_pfn is close
> -	 * enough to the highest-allocated IOVA that starting the allocation
> -	 * walk from the anchor node will be quicker than this initial work to
> -	 * find an exact starting point (especially if that ends up being the
> -	 * anchor node anyway). This is an incredibly crude approximation which
> -	 * only really helps the most likely case, but is at least trivially easy.
> -	 */
> -	if (limit_pfn > iovad->dma_32bit_pfn)
> -		return &iovad->anchor.node;
> -
> -	node = iovad->rbroot.rb_node;
> -	while (to_iova(node)->pfn_hi < limit_pfn)
> -		node = node->rb_right;
> -
> -search_left:
> -	while (node->rb_left && to_iova(node->rb_left)->pfn_lo >= limit_pfn)
> -		node = node->rb_left;
> -
> -	if (!node->rb_left)
> -		return node;
> -
> -	next = node->rb_left;
> -	while (next->rb_right) {
> -		next = next->rb_right;
> -		if (to_iova(next)->pfn_lo >= limit_pfn) {
> -			node = next;
> -			goto search_left;
> -		}
> -	}
> +	struct rb_node *curr = iovad->rbroot.rb_node;
>
> -	return node;
> +	while (curr) {
> +		struct iova *iova = to_iova(curr);
> +
> +		if (limit_pfn - 1 > iova->pfn_hi)
> +			curr = curr->rb_right;
> +		else if (limit_pfn <= prev_iova_high(iova))
> +			curr = curr->rb_left;
> +		else
> +			break;
> +	}
> +	return curr;
>  }
>
>  /* Insert the iova into domain rbtree by holding writer lock */
> @@ -148,6 +188,7 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova,
>  		   struct rb_node *start)
>  {
>  	struct rb_node **new, *parent = NULL;
> +	struct iova *next_iova;
>
>  	new = (start) ? &start : &(root->rb_node);
>  	/* Figure out where to put new node */
> @@ -166,61 +207,143 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova,
>  		}
>  	}
>  	/* Add new node and rebalance tree. */
> +
>  	rb_link_node(&iova->node, parent, new);
> -	rb_insert_color(&iova->node, root);
> +
> +	next_iova = to_iova(rb_next(&iova->node));
> +	iova->prev_iova = next_iova->prev_iova;
> +	next_iova->prev_iova = iova;
> +
> +	iova->allocatable_size = iova_compute_allocatable_size(iova);
> +	next_iova->allocatable_size = iova_compute_allocatable_size(next_iova);
> +
> +	/*
> +	 * Do't swap the following two lines, because next_iova is the ancestor
> +	 * of iova and updating iova first is faster.
> +	 */
> +	iova_max_allocatable_size_update(iova);
> +	iova_max_allocatable_size_update(next_iova);
> +
> +	rb_insert_augmented(&iova->node, root, &iova_gap_callbacks);
> +}
> +
> +static inline bool check_interval(unsigned long lo, unsigned long hi,
> +				  unsigned long limit_pfn, unsigned long size,
> +				  unsigned long align_mask)
> +{
> +	hi = min(hi, limit_pfn);
> +	if (lo >= hi)
> +		return false;
> +	if (hi >= size && ((hi - size) & align_mask) >= lo)
> +		return true;
> +	return false;
>  }
>
>  static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
>  		unsigned long size, unsigned long limit_pfn,
>  			struct iova *new, bool size_aligned)
>  {
> -	struct rb_node *curr, *prev;
> -	struct iova *curr_iova;
>  	unsigned long flags;
> -	unsigned long new_pfn, retry_pfn;
> +	struct rb_node *curr;
> +	struct rb_node *parent;
> +	struct iova *curr_iova;
>  	unsigned long align_mask = ~0UL;
> -	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
> +	bool ignore = false;
>
>  	if (size_aligned)
>  		align_mask <<= fls_long(size - 1);
>
> -	/* Walk the tree backwards */
>  	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
> +
>  	if (limit_pfn <= iovad->dma_32bit_pfn &&
>  			size >= iovad->max32_alloc_size)
>  		goto iova32_full;
>
>  	curr = __get_cached_rbnode(iovad, limit_pfn);
>  	curr_iova = to_iova(curr);
> -	retry_pfn = curr_iova->pfn_hi + 1;
>
> -retry:
> -	do {
> -		high_pfn = min(high_pfn, curr_iova->pfn_lo);
> -		new_pfn = (high_pfn - size) & align_mask;
> -		prev = curr;
> -		curr = rb_prev(curr);
> -		curr_iova = to_iova(curr);
> -	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
> -
> -	if (high_pfn < size || new_pfn < low_pfn) {
> -		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
> -			high_pfn = limit_pfn;
> -			low_pfn = retry_pfn;
> -			curr = iova_find_limit(iovad, limit_pfn);
> -			curr_iova = to_iova(curr);
> -			goto retry;
> +	if (limit_pfn >= curr_iova->pfn_lo &&
> +	    curr_iova->allocatable_size >= size)
> +		goto found;
> +
> +	/* If limit_pfn > dma_32bit_pfn, this could be faster. */
> +	if (limit_pfn > iovad->dma_32bit_pfn) {
> +		curr_iova = to_iova(&iovad->anchor.node);
> +
> +		while (curr_iova) {
> +			if (check_interval(prev_iova_high(curr_iova),
> +					   curr_iova->pfn_lo, limit_pfn,
> +					   size, align_mask))
> +				goto found;
> +			curr_iova = curr_iova->prev_iova;
>  		}
>  		iovad->max32_alloc_size = size;
>  		goto iova32_full;
>  	}
>
> +	curr = iova_find_limit(iovad, limit_pfn);
> +	curr_iova = to_iova(curr);
> +
> +	if (check_interval(prev_iova_high(curr_iova),
> +			   curr_iova->pfn_lo, limit_pfn,
> +			   size, align_mask))
> +		goto found;
> +
> +	while (true) {
> +		/* Check left subtree */
> +		if (!ignore && curr->rb_left) {
> +			curr_iova = to_iova(curr->rb_left);
> +			if (curr_iova->max_allocatable_size >= size)
> +				goto check_subtree;
> +		}
> +
> +		parent = rb_parent(curr);
> +		if (parent == NULL)
> +			break;
> +		/*
> +		 * If current node is the left child of it's parent,
> +		 * the parent node and the parent's right sub_tree should not
> +		 * to be checked because they exceed the limit_pfn.
> +		 */
> +		ignore = parent->rb_left == curr;
> +		curr = parent;
> +
> +		/* Check current node. */
> +		if (!ignore) {
> +			curr_iova = to_iova(curr);
> +			if (curr_iova->allocatable_size >= size)
> +				goto found;
> +		}
> +	}
> +	if (limit_pfn >= iovad->dma_32bit_pfn)
> +		iovad->max32_alloc_size = size;
> +	goto iova32_full;
> +
> +check_subtree:
> +	while (true) {
> +		if (curr_iova->allocatable_size >= size)
> +			goto found;
> +
> +		curr = &curr_iova->node;
> +		if (curr->rb_right &&
> +			to_iova(curr->rb_right)->max_allocatable_size >= size) {
> +			curr_iova = to_iova(curr->rb_right);
> +			continue;
> +		}
> +		WARN_ON(curr->rb_left == NULL);
> +		curr_iova = to_iova(curr->rb_left);
> +	}
> +
> +found:
>  	/* pfn_lo will point to size aligned address if size_aligned is set */
> -	new->pfn_lo = new_pfn;
> +	new->pfn_lo = (min(curr_iova->pfn_lo, limit_pfn) - size) & align_mask;
>  	new->pfn_hi = new->pfn_lo + size - 1;
>
> -	/* If we have 'prev', it's a valid place to start the insertion. */
> -	iova_insert_rbtree(&iovad->rbroot, new, prev);
> +	/*
> +	 * If we have 'prev' or 'next',
> +	 * it's a valid place to start the insertion.
> +	 */
> +	iova_insert_rbtree(&iovad->rbroot, new, &curr_iova->node);
>  	__cached_rbnode_insert_update(iovad, new);
>
>  	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
> @@ -352,9 +475,18 @@ private_find_iova(struct iova_domain *iovad, unsigned long pfn)
>
>  static void remove_iova(struct iova_domain *iovad, struct iova *iova)
>  {
> +	struct rb_node *next;
> +	struct iova *next_iova;
>  	assert_spin_locked(&iovad->iova_rbtree_lock);
> -	__cached_rbnode_delete_update(iovad, iova);
> -	rb_erase(&iova->node, &iovad->rbroot);
> +
> +	next = rb_next(&iova->node);
> +	__cached_rbnode_delete_update(iovad, iova, next);
> +
> +	next_iova = to_iova(next);
> +	next_iova->prev_iova = iova->prev_iova;
> +	next_iova->allocatable_size = iova_compute_allocatable_size(next_iova);
> +	iova_max_allocatable_size_update(next_iova);
> +	rb_erase_augmented(&iova->node, &iovad->rbroot, &iova_gap_callbacks);
>  }
>
>  /**
> @@ -554,8 +686,11 @@ static void
>  __adjust_overlap_range(struct iova *iova,
>  	unsigned long *pfn_lo, unsigned long *pfn_hi)
>  {
> -	if (*pfn_lo < iova->pfn_lo)
> +	if (*pfn_lo < iova->pfn_lo) {
>  		iova->pfn_lo = *pfn_lo;
> +		iova->allocatable_size = iova_compute_allocatable_size(iova);
> +		iova_max_allocatable_size_update(iova);
> +	}
>  	if (*pfn_hi > iova->pfn_hi)
>  		*pfn_lo = iova->pfn_hi + 1;
>  }
> diff --git a/include/linux/iova.h b/include/linux/iova.h
> index 320a70e40233..feb8121f104d 100644
> --- a/include/linux/iova.h
> +++ b/include/linux/iova.h
> @@ -11,7 +11,7 @@
>
>  #include <linux/types.h>
>  #include <linux/kernel.h>
> -#include <linux/rbtree.h>
> +#include <linux/rbtree_augmented.h>
>  #include <linux/dma-mapping.h>
>
>  /* iova structure */
> @@ -19,6 +19,9 @@ struct iova {
>  	struct rb_node	node;
>  	unsigned long	pfn_hi; /* Highest allocated pfn */
>  	unsigned long	pfn_lo; /* Lowest allocated pfn */
> +	struct iova	*prev_iova;
> +	unsigned long	allocatable_size;
> +	unsigned long	max_allocatable_size;
>  };
>
>
>
