Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E536F8AD4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjEEV0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjEEV0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:26:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE18659FE
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 14:25:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C9DA640C1
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 21:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A77C433EF;
        Fri,  5 May 2023 21:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683321932;
        bh=UD8mf/vU8OCemcmkbPhGj7HzuN6zSM93F/yg/1U40GY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y+WfXYhRbXGFej1vq4KHxxS0efVPHZS2EgOZS3CquPIAdOSjfS5ndfWVmbp1dZP4U
         RSj9+uVYESP1j9SNcxjqDq8jO0cjnRUMRwtHJGICxngAOw6VP3esEPKddRVJgrOf8f
         5AY6eFJ9bdULHqM05hYQ8Wa2E2X1k120f0QoCSUA=
Date:   Fri, 5 May 2023 14:25:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, <ke.wang@unisoc.com>
Subject: Re: [PATCHv2] mm: optimization on page allocation when CMA enabled
Message-Id: <20230505142531.95a3d2238f5498862194078a@linux-foundation.org>
In-Reply-To: <1683194994-3070-1-git-send-email-zhaoyang.huang@unisoc.com>
References: <1683194994-3070-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2023 18:09:54 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc.com> wrote:

> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Let us look at the series of scenarios below with WMARK_LOW=25MB,WMARK_MIN=5MB
> (managed pages 1.9GB). We can know that current 'fixed 1/2 ratio' start to use
> CMA since C which actually has caused U&R lower than WMARK_LOW (this should be
> deemed as against current memory policy, that is, U&R should either stay around
> WATERMARK_LOW when no allocation or do reclaim via enter slowpath)
> 
> free_cma/free_pages(MB)      A(12/30)     B(12/25)     C(12/20)
> fixed 1/2 ratio                 N             N           Y
> this commit                     Y             Y           Y

A few style issues.

> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3071,6 +3071,34 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
>  
>  }
>  
> +#ifdef CONFIG_CMA
> +static bool __if_use_cma_first(struct zone *zone, unsigned int order, unsigned int alloc_flags)

This function would benefit from a nice covering comment.  Explain what
it does and, especially, why it does it.

I'm not sure that "__if_use_cma_first" is a good name - I'd need to see
that explanation to decide.

> +{
> +	unsigned long cma_proportion = 0;
> +	unsigned long cma_free_proportion = 0;
> +	unsigned long watermark = 0;
> +	long count = 0;
> +	bool cma_first = false;

We seems to have some unnecessary initializations here.

> +	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> +	/*check if GFP_MOVABLE pass previous watermark check via the help of CMA*/

Space after /* and before */

	/*
	 * Check if GFP_MOVABLE passed the previous watermark check with the
	 * help of CMA
	 */

> +	if (!zone_watermark_ok(zone, order, watermark, 0, alloc_flags & (~ALLOC_CMA)))
> +		/* WMARK_LOW failed lead to using cma first, this helps U&R stay
> +		 * around low when being drained by GFP_MOVABLE
> +		 */

Unusual layout, text is hard to understand.  Maybe something like

		/*
		 * WMARK_LOW failed, leading to the use cma first.  This helps
		 * U&R stay low when <something> is being drained by
		 * GFP_MOVABLE
		 */

Also, please expand "U&R" into full words.  I don't recognize that
abbreviation.

> +		cma_first = true;
> +	else {
> +		/*check proportion when zone_watermark_ok*/

		/* check ... _ok */

Comments should seek to explain *why* a thing is being done, rather than
*what* is being done.

> +		count = atomic_long_read(&zone->managed_pages);
> +		cma_proportion = zone->cma_pages * 100 / count;
> +		cma_free_proportion = zone_page_state(zone, NR_FREE_CMA_PAGES) * 100
> +			/  zone_page_state(zone, NR_FREE_PAGES);
> +		cma_first = (cma_free_proportion >= cma_proportion * 2
> +				|| cma_free_proportion >= 50);
> +	}
> +	return cma_first;
> +}
> +#endif
>  /*
>   * Do the hard work of removing an element from the buddy allocator.
>   * Call me with the zone->lock already held.
> @@ -3087,10 +3115,10 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,

I wonder why git decided this hunk is unreserve_highatomic_pageblock().
It's actually in __rmqueue().

>  		 * allocating from CMA when over half of the zone's free memory
>  		 * is in the CMA area.
>  		 */
> -		if (alloc_flags & ALLOC_CMA &&
> -		    zone_page_state(zone, NR_FREE_CMA_PAGES) >
> -		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
> -			page = __rmqueue_cma_fallback(zone, order);
> +		if (migratetype == MIGRATE_MOVABLE) {
> +			bool cma_first = __if_use_cma_first(zone, order, alloc_flags);
> +
> +			page = cma_first ? __rmqueue_cma_fallback(zone, order) : NULL;

Code could be tidier and could avoid needless 80-column wordwrapping
and an unneeded local.

			page = NULL;
			if (__if_use_cma_first(zone, order, alloc_flags))
				page = __rmqueue_cma_fallback(zone, order);

>  			if (page)
>  				return page;
>  		}

Anyway, please take a look, fix the build error and send us a v3.  I
suggest you cc Minchan Kim, who might review it for us.

