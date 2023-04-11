Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98056DD5B8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjDKIhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbjDKIg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:36:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6064219F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 01:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681202218; x=1712738218;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=xCD60pUtFq5X+vmcLrFss+cTndUk3KpHKOoOb2NCMDo=;
  b=PnPaBbY/HNC8vhpSMw3cUKFqq5GeupU8F4Jc6pyfWU0sTNhXukz1nIAq
   Ac8XhB4fUUQKEdIxajYrp4q24pszxYAfRA9eRGjtgLb8zsejR1EmGC4SS
   3B3YNfpkhMSoM1vFq895WckHZvq8Qccoy2hECuHMYkg/Cs9YfimUqfU8r
   FEEue0fK6/phYh+B8Sh4YxAVco7N4pOB+voeu2v9/T60TfDV/G/PFNWCU
   /n/GTTJ9+ixQU1YOSv5hFnRPDrmDAIsbsia5iFGTNZtZux046LHase89b
   V3e38BXZPjkm1L/Ca8XIbJZ4YHzXsBjMboy0xyARlTX0uVcsV7RtKmBWg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="323919910"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="323919910"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 01:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="934637486"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="934637486"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 01:36:55 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: Re: [RFC PATCHv2] mm: introduce defer free for cma
References: <1681116395-18633-1-git-send-email-zhaoyang.huang@unisoc.com>
Date:   Tue, 11 Apr 2023 16:35:49 +0800
In-Reply-To: <1681116395-18633-1-git-send-email-zhaoyang.huang@unisoc.com>
        (zhaoyang huang's message of "Mon, 10 Apr 2023 16:46:35 +0800")
Message-ID: <87mt3e24uy.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"zhaoyang.huang" <zhaoyang.huang@unisoc.com> writes:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> Continues page blocks are expensive for the system. Introducing defer free
> mechanism to buffer some which make the allocation easier. The shrinker will
> ensure the page block can be reclaimed when there is memory pressure.

Why do you need this patch?  What is the problem that this patch want to
address?  If this helps performance, can you provide some data to
support it?

Best Regards,
Huang, Ying

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: fix build warning and regist shrinker
> ---
> ---
>  mm/cma.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  mm/cma.h |  11 +++++
>  2 files changed, 160 insertions(+), 2 deletions(-)
>
> diff --git a/mm/cma.c b/mm/cma.c
> index 4a978e0..6d2fd24 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -39,6 +39,10 @@
>  unsigned cma_area_count;
>  static DEFINE_MUTEX(cma_mutex);
>  
> +static unsigned long cma_defer_free_count(struct shrinker *shrinker,
> +					struct shrink_control *sc);
> +static unsigned long cma_defer_free_scan(struct shrinker *shrinker,
> +					struct shrink_control *sc);
>  phys_addr_t cma_get_base(const struct cma *cma)
>  {
>  	return PFN_PHYS(cma->base_pfn);
> @@ -153,6 +157,20 @@ static int __init cma_init_reserved_areas(void)
>  }
>  core_initcall(cma_init_reserved_areas);
>  
> +static unsigned long cma_free_get(struct cma *cma)
> +{
> +	unsigned long used;
> +	unsigned long val;
> +
> +	spin_lock_irq(&cma->lock);
> +	/* pages counter is smaller than sizeof(int) */
> +	used = bitmap_weight(cma->bitmap, (int)cma_bitmap_maxno(cma));
> +	val = cma->count - ((u64)used << cma->order_per_bit);
> +	spin_unlock_irq(&cma->lock);
> +
> +	return val;
> +}
> +
>  void __init cma_reserve_pages_on_error(struct cma *cma)
>  {
>  	cma->reserve_pages_on_error = true;
> @@ -212,6 +230,13 @@ int __init cma_init_reserved_mem(phys_addr_t base, phys_addr_t size,
>  	cma_area_count++;
>  	totalcma_pages += (size / PAGE_SIZE);
>  
> +	cma->batch = cma->count >> 1;
> +	cma->shrinker.count_objects = cma_defer_free_count;
> +	cma->shrinker.scan_objects = cma_defer_free_scan;
> +	cma->shrinker.seeks = DEFAULT_SEEKS;
> +	cma->shrinker.batch = 0;
> +
> +	register_shrinker(&cma->shrinker, "cma-shrinker");
>  	return 0;
>  }
>  
> @@ -411,6 +436,46 @@ static void cma_debug_show_areas(struct cma *cma)
>  static inline void cma_debug_show_areas(struct cma *cma) { }
>  #endif
>  
> +static int cma_defer_area_fetch(struct cma *cma, unsigned long pfn,
> +		unsigned long count)
> +{
> +	struct cma_defer_free_area *area;
> +	unsigned long new_pfn;
> +	int ret = -1;
> +
> +	if (!atomic64_read(&cma->defer_count))
> +		return ret;
> +	if (count <= atomic64_read(&cma->defer_count)) {
> +		spin_lock_irq(&cma->lock);
> +		list_for_each_entry(area, &cma->defer_free, list) {
> +			/*area found for given pfn and count*/
> +			if (pfn >= area->pfn && count <= area->count) {
> +				list_del(&area->list);
> +				/*set bits for allocated pfn*/
> +				bitmap_set(cma->bitmap, pfn - cma->base_pfn, count);
> +				kfree(area);
> +				atomic64_sub(count, &cma->defer_count);
> +				/*release the rest pfn to cma*/
> +				if (!list_empty(&cma->defer_free) && (pfn == area->pfn)) {
> +					new_pfn = pfn + count;
> +					cma_release(cma, pfn_to_page(new_pfn), area->count - count);
> +				}
> +				ret = 0;
> +				spin_unlock_irq(&cma->lock);
> +				return ret;
> +			}
> +		}
> +	}
> +	/*no area found, release all to buddy*/
> +	list_for_each_entry(area, &cma->defer_free, list) {
> +		list_del(&area->list);
> +		free_contig_range(area->pfn, area->count);
> +		cma_clear_bitmap(cma, area->pfn, area->count);
> +		kfree(area);
> +	}
> +	spin_unlock_irq(&cma->lock);
> +	return ret;
> +}
>  /**
>   * cma_alloc() - allocate pages from contiguous area
>   * @cma:   Contiguous memory region for which the allocation is performed.
> @@ -469,9 +534,11 @@ struct page *cma_alloc(struct cma *cma, unsigned long count,
>  		spin_unlock_irq(&cma->lock);
>  
>  		pfn = cma->base_pfn + (bitmap_no << cma->order_per_bit);
> +
>  		mutex_lock(&cma_mutex);
> -		ret = alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
> -				     GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0));
> +		/*search defer area first*/
> +		ret = cma_defer_area_fetch(cma, pfn, count) ? alloc_contig_range(pfn, pfn + count, MIGRATE_CMA,
> +				     GFP_KERNEL | (no_warn ? __GFP_NOWARN : 0)) : 0;
>  		mutex_unlock(&cma_mutex);
>  		if (ret == 0) {
>  			page = pfn_to_page(pfn);
> @@ -556,6 +623,8 @@ bool cma_release(struct cma *cma, const struct page *pages,
>  		 unsigned long count)
>  {
>  	unsigned long pfn;
> +	unsigned long flags;
> +	struct cma_defer_free_area *defer_area;
>  
>  	if (!cma_pages_valid(cma, pages, count))
>  		return false;
> @@ -566,6 +635,19 @@ bool cma_release(struct cma *cma, const struct page *pages,
>  
>  	VM_BUG_ON(pfn + count > cma->base_pfn + cma->count);
>  
> +	if (atomic64_read(&cma->defer_count) < cma->batch) {
> +		defer_area = kmalloc(sizeof(struct cma_defer_free_area), GFP_KERNEL);
> +		if (defer_area) {
> +			defer_area->pfn = pfn;
> +			defer_area->count = count;
> +			spin_lock_irqsave(&cma->lock, flags);
> +			list_add(&defer_area->list, &cma->defer_free);
> +			atomic64_add(count, &cma->defer_count);
> +			spin_unlock_irqrestore(&cma->lock, flags);
> +			cma_clear_bitmap(cma, pfn, count);
> +			return true;
> +		}
> +	}
>  	free_contig_range(pfn, count);
>  	cma_clear_bitmap(cma, pfn, count);
>  	trace_cma_release(cma->name, pfn, pages, count);
> @@ -586,3 +668,68 @@ int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data)
>  
>  	return 0;
>  }
> +
> +static unsigned long cma_defer_free_count(struct shrinker *shrinker,
> +					struct shrink_control *sc)
> +{
> +	struct cma *cma = container_of(shrinker, struct cma, shrinker);
> +	unsigned long val;
> +
> +	val = atomic64_read(&cma->defer_count);
> +	return val;
> +}
> +
> +static unsigned long cma_defer_free_scan(struct shrinker *shrinker,
> +					struct shrink_control *sc)
> +{
> +	struct cma *cma = container_of(shrinker, struct cma, shrinker);
> +	unsigned long to_scan;
> +	struct cma_defer_free_area *area;
> +	unsigned long new_pfn;
> +	unsigned long defer_count;
> +
> +	if (sc->nr_to_scan < cma->batch)
> +		return 0;
> +
> +	to_scan = cma->batch - sc->nr_to_scan;
> +	defer_count = atomic64_read(&cma->defer_count);
> +	spin_lock_irq(&cma->lock);
> +
> +	/*large to_scan, free all node*/
> +	if (to_scan >= defer_count) {
> +		list_for_each_entry(area, &cma->defer_free, list) {
> +			list_del(&area->list);
> +			free_contig_range(area->pfn, area->count);
> +			cma_clear_bitmap(cma, area->pfn, area->count);
> +			kfree(area);
> +		}
> +		atomic64_set(&cma->defer_count, 0);
> +		return defer_count;
> +	}
> +	/*iterate all defer_area*/
> +	list_for_each_entry(area, &cma->defer_free, list) {
> +		if (to_scan <= area->count) {
> +			list_del(&area->list);
> +			free_contig_range(area->pfn, area->count);
> +			cma_clear_bitmap(cma, area->pfn, area->count);
> +			kfree(area);
> +			atomic64_sub(to_scan, &cma->defer_count);
> +			/*release the rest pfn to cma*/
> +			if (!list_empty(&cma->defer_free)) {
> +				new_pfn = area->pfn + to_scan;
> +				cma_release(cma, pfn_to_page(new_pfn), area->count - to_scan);
> +			}
> +			break;
> +		}
> +		else {
> +			list_del(&area->list);
> +			free_contig_range(area->pfn, area->count);
> +			cma_clear_bitmap(cma, area->pfn, area->count);
> +			kfree(area);
> +			to_scan = to_scan - atomic64_read(&cma->defer_count);
> +			continue;
> +		}
> +	}
> +	spin_unlock_irq(&cma->lock);
> +	return 0;
> +}
> diff --git a/mm/cma.h b/mm/cma.h
> index 88a0595..e1e3e2f 100644
> --- a/mm/cma.h
> +++ b/mm/cma.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/debugfs.h>
>  #include <linux/kobject.h>
> +#include <linux/shrinker.h>
>  
>  struct cma_kobject {
>  	struct kobject kobj;
> @@ -31,6 +32,16 @@ struct cma {
>  	struct cma_kobject *cma_kobj;
>  #endif
>  	bool reserve_pages_on_error;
> +	struct list_head defer_free;
> +	atomic64_t defer_count;
> +	unsigned long batch;
> +	struct shrinker shrinker;
> +};
> +
> +struct cma_defer_free_area {
> +	unsigned long pfn;
> +	unsigned long count;
> +	struct list_head list;
>  };
>  
>  extern struct cma cma_areas[MAX_CMA_AREAS];
