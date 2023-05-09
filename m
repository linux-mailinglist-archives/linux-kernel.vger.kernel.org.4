Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241F06FCB53
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjEIQaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjEIQad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:30:33 -0400
Received: from out-61.mta1.migadu.com (out-61.mta1.migadu.com [IPv6:2001:41d0:203:375::3d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55404210
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 09:30:31 -0700 (PDT)
Date:   Tue, 9 May 2023 09:30:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683649828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RUFaoQGha0Z+r6iw9RZNHszlUlMEAfaTJMqTQTGUWXg=;
        b=eN6lGg1p85j+EO3nZANcz+n1hAtqWJc2bKAptsZuSfZF7YgjtaSW94kF6PiYG45+aWHMYG
        WTRlT0ksVpyGlaUUd/te0Ch05Od/VyZwyUYNXSLw4ZsqJgC1YFW9Cal5VuO7bgYyPfwPPt
        RoyDWUCxP3IARIgtB+usYU0UIaJ0L+o=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCHv3] mm: optimization on page allocation when CMA enabled
Message-ID: <ZFp1EB7863TAxzbs@P9FQF9L96D.corp.robot.car>
References: <1683355547-10524-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683355547-10524-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 02:45:47PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Let us look at the series of scenarios below with WMARK_LOW=25MB,WMARK_MIN=5MB
> (managed pages 1.9GB). We can know that current 'fixed 1/2 ratio' start to use
> CMA since C which actually has caused U&R lower than WMARK_LOW (this should be
> deemed as against current memory policy, that is, UNMOVABLE & RECLAIMABLE should
> either stay around WATERMARK_LOW when no allocation or do reclaim via entering
> slowpath)
> 
> -- Free_pages
> |
> |
> -- WMARK_LOW
> |
> -- Free_CMA
> |
> |
> --
> 
> Free_CMA/Free_pages(MB)      A(12/30)     B(12/25)     C(12/20)
> fixed 1/2 ratio                 N             N           Y
> this commit                     Y             Y           Y
> 
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: do proportion check when zone_watermark_ok, update commit message
> v3: update coding style and simplify the logic when zone_watermark_ok

We're getting closer, thank you for working on it.

> ---
> ---
>  mm/page_alloc.c | 46 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0745aed..7aca49d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3071,6 +3071,41 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
>  
>  }
>  
> +#ifdef CONFIG_CMA
> +/*
> + * GFP_MOVABLE allocation could drain UNMOVABLE & RECLAIMABLE page blocks via
> + * the help of CMA which makes GFP_KERNEL failed. Checking if zone_watermark_ok
> + * again without ALLOC_CMA to see if to use CMA first.
> + */
> +static bool __if_use_cma_first(struct zone *zone, unsigned int order, unsigned int alloc_flags)

Can you, please, rename it to use_cma_first()?

> +{
> +	unsigned long watermark;
> +	bool cma_first = false;
> +
> +	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> +	/* check if GFP_MOVABLE pass previous zone_watermark_ok via the help of CMA */
> +	if (!zone_watermark_ok(zone, order, watermark, 0, alloc_flags & (~ALLOC_CMA)))

Please, add {} for both "if" and "else" parts. Also, please, invert the order to make it
easier to follow:

if (zone_watermark_ok(...)) {
	...
} else {
	...
}

> +		/*
> +		 * watermark failed means UNMOVABLE & RECLAIMBLE is not enough
> +		 * now, we should use cma first to keep them stay around the
> +		 * corresponding watermark
> +		 */
> +		cma_first = true;
> +	else
> +		/*
> +		 * remain previous fixed 1/2 logic when watermark ok as we have

Nobody knows what was previously here once your change is applied. Please, do not refer
to the previous state, add a comment about the current state. You can probably (partially)
move the comment from __rmqueue().

> +		 * above protection now
> +		 */
> +		cma_first = (zone_page_state(zone, NR_FREE_CMA_PAGES) >
> +				zone_page_state(zone, NR_FREE_PAGES) / 2);
> +	return cma_first;
> +}
> +#else
> +static bool __if_use_cma_first(struct zone *zone, unsigned int order, unsigned int alloc_flags)
> +{
> +	return false;
> +}
> +#endif
>  /*
>   * Do the hard work of removing an element from the buddy allocator.
>   * Call me with the zone->lock already held.
> @@ -3084,13 +3119,12 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
>  	if (IS_ENABLED(CONFIG_CMA)) {
>  		/*
>  		 * Balance movable allocations between regular and CMA areas by
> -		 * allocating from CMA when over half of the zone's free memory
> -		 * is in the CMA area.
> +		 * allocating from CMA base on judging zone_watermark_ok again
> +		 * to see if the latest check got pass via the help of CMA
>  		 */
> -		if (alloc_flags & ALLOC_CMA &&
> -		    zone_page_state(zone, NR_FREE_CMA_PAGES) >
> -		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
> -			page = __rmqueue_cma_fallback(zone, order);
> +		if (migratetype == MIGRATE_MOVABLE) {
> +			page = __if_use_cma_first(zone, order, alloc_flags) ?
> +				__rmqueue_cma_fallback(zone, order) : NULL;

Can you put it like
if (migratetype == MIGRATE_MOVABLE && use_cma_first(...)) {
	page = ...
	if (page)
		return page;
}

to avoid using a ternary operator without a good reason?

Thanks!
