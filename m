Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CFD6F8C5A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 00:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjEEW3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 18:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjEEW3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 18:29:04 -0400
Received: from out-25.mta0.migadu.com (out-25.mta0.migadu.com [91.218.175.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E1440DB
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 15:29:02 -0700 (PDT)
Date:   Fri, 5 May 2023 15:28:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1683325740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AbhbxBZfqIMq6fti+QEBmNXG7jNfGprYLCJ2mpk5Tak=;
        b=KbC8MyVsivEGLYcsKo3/2GoaJAfK9YFreg06FJH4RI2Ym00ZKT+v2+yYECHcagi5SFS8KJ
        zpP/rMt0x1Jjbx/XoAivl/IxnVKwRUMPnkFDd4f4uxm89Cfm2fs+A5v9tRqrwljt7lFxC6
        lSFTL3bq8zJim3FxxCmI0ozQqhbc0T4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, ke.wang@unisoc.com
Subject: Re: [PATCHv2] mm: optimization on page allocation when CMA enabled
Message-ID: <ZFWDKCJ5n55Y5eq4@P9FQF9L96D.lan>
References: <1683194994-3070-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1683194994-3070-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 06:09:54PM +0800, zhaoyang.huang wrote:
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
> 
> Suggested-by: Roman Gushchin <roman.gushchin@linux.dev>

I didn't suggest it in this form, please, drop this tag.

> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
> v2: do proportion check when zone_watermark_ok, update commit message
> ---
> ---
>  mm/page_alloc.c | 36 ++++++++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0745aed..d0baeab 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3071,6 +3071,34 @@ static bool unreserve_highatomic_pageblock(const struct alloc_context *ac,
>  
>  }
>  
> +#ifdef CONFIG_CMA
> +static bool __if_use_cma_first(struct zone *zone, unsigned int order, unsigned int alloc_flags)
> +{
> +	unsigned long cma_proportion = 0;
> +	unsigned long cma_free_proportion = 0;
> +	unsigned long watermark = 0;
> +	long count = 0;
> +	bool cma_first = false;
> +
> +	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> +	/*check if GFP_MOVABLE pass previous watermark check via the help of CMA*/
> +	if (!zone_watermark_ok(zone, order, watermark, 0, alloc_flags & (~ALLOC_CMA)))
> +		/* WMARK_LOW failed lead to using cma first, this helps U&R stay
> +		 * around low when being drained by GFP_MOVABLE
> +		 */
> +		cma_first = true;

This part looks reasonable to me.

> +	else {
> +		/*check proportion when zone_watermark_ok*/
> +		count = atomic_long_read(&zone->managed_pages);
> +		cma_proportion = zone->cma_pages * 100 / count;
> +		cma_free_proportion = zone_page_state(zone, NR_FREE_CMA_PAGES) * 100
> +			/  zone_page_state(zone, NR_FREE_PAGES);
> +		cma_first = (cma_free_proportion >= cma_proportion * 2

Why *2? Please, explain.

> +				|| cma_free_proportion >= 50);

It will heavily boost the use of cma at early stages of uptime, when there is a lot of !cma
memory, making continuous (e.g. hugetlb) allocations fail more often. Not a good idea.

Thanks!
