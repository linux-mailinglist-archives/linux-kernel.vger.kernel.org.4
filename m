Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6D86F34ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjEARQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbjEARNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:13:09 -0400
Received: from out-51.mta0.migadu.com (out-51.mta0.migadu.com [IPv6:2001:41d0:1004:224b::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050A41FF5
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 10:12:14 -0700 (PDT)
Date:   Mon, 1 May 2023 10:12:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1682961132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4x5T3Q/c5NLcOH8sHPSyYz1LAl/Oui3iWtz8Ou0TELA=;
        b=MPA5h7hprdGRBRt8GnzewCY3kfxDJs3GElH6DlWeWQOj/Nuh52+eTtuWim/0ItsFa5CP8X
        mzTumzR8D7IX2h/aspnXt96wTj8uF2HIFWhpxCG+2BLB349fL7uUM58pH4c5yXtEdYcNqd
        T1N707rA8SN2sJgM0UBiXc/tV1sDbno=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCH] mm: optimization on page allocation when CMA enabled
Message-ID: <ZE/y5wMggipQrKvb@P9FQF9L96D>
References: <1682679641-13652-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1682679641-13652-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhaoyang!

On Fri, Apr 28, 2023 at 07:00:41PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Please be notice bellowing typical scenario that commit 168676649 introduce,
> that is, 12MB free cma pages 'help' GFP_MOVABLE to keep draining/fragmenting
> U&R page blocks until they shrink to 12MB without enter slowpath which against
> current reclaiming policy. This commit change the criteria from hard coded '1/2'
> to watermark check which leave U&R free pages stay around WMARK_LOW when being
> fallback.

Can you, please, explain the problem you're solving in more details?

If I understand your code correctly, you're effectively reducing the
use of cma areas for movable allocations. Why it's good?
Also, this is a hot path, please, make sure you're not adding
much overhead.

And please use scripts/checkpatch.pl next time, there are many
code style issues.

Thanks!

> 
> DMA32 free:25900kB boost:0kB min:4176kB low:25856kB high:29516kB
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  mm/page_alloc.c | 40 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0745aed..97768fe 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3071,6 +3071,39 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
>  
>  }
>  
> +#ifdef CONFIG_CMA
> +static bool __if_use_cma_first(struct zone *zone, unsigned int order, unsigned int alloc_flags)
> +{
> +	unsigned long cma_proportion = 0;
> +	unsigned long cma_free_proportion = 0;
> +	unsigned long watermark = 0;
> +	unsigned long wm_fact[ALLOC_WMARK_MASK] = {1, 1, 2};
> +	long count = 0;
> +	bool cma_first = false;
> +
> +	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> +	/*check if GFP_MOVABLE pass previous watermark check via the help of CMA*/
> +	if (!zone_watermark_ok(zone, order, watermark, 0, alloc_flags & (~ALLOC_CMA)))
> +	{
> +		alloc_flags &= ALLOC_WMARK_MASK;
> +		/* WMARK_LOW failed lead to using cma first, this helps U&R stay
> +		 * around low when being drained by GFP_MOVABLE
> +		 */
> +		if (alloc_flags <= ALLOC_WMARK_LOW)
> +			cma_first = true;
> +		/*check proportion for WMARK_HIGH*/
> +		else {
> +			count = atomic_long_read(&zone->managed_pages);
> +			cma_proportion = zone->cma_pages * 100 / count;
> +			cma_free_proportion = zone_page_state(zone, NR_FREE_CMA_PAGES) * 100
> +				/  zone_page_state(zone, NR_FREE_PAGES);
> +			cma_first = (cma_free_proportion >= wm_fact[alloc_flags] * cma_proportion
> +					|| cma_free_proportion >= 50);
> +		}
> +	}
> +	return cma_first;
> +}
> +#endif
>  /*
>   * Do the hard work of removing an element from the buddy allocator.
>   * Call me with the zone->lock already held.
> @@ -3087,10 +3120,9 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
>  		 * allocating from CMA when over half of the zone's free memory
>  		 * is in the CMA area.
>  		 */
> -		if (alloc_flags & ALLOC_CMA &&
> -		    zone_page_state(zone, NR_FREE_CMA_PAGES) >
> -		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
> -			page = __rmqueue_cma_fallback(zone, order);
> +		if (migratetype == MIGRATE_MOVABLE) {
> +			bool cma_first = __if_use_cma_first(zone, order, alloc_flags);
> +			page = cma_first ? __rmqueue_cma_fallback(zone, order) : NULL;
>  			if (page)
>  				return page;
>  		}
> -- 
> 1.9.1
> 
> 
