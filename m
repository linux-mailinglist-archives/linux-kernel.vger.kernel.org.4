Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C476474A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiLHQvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiLHQvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:51:15 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7A9AE4ED
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:51:13 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 489FE20344;
        Thu,  8 Dec 2022 16:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670518272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Saz5QgfCYR/nWPEclN397UURX/bkVNc1D/XuX66CnZI=;
        b=qnsBLEQT3iDoKkDNafEf7lPX9FmGREx7SafHUyPckD1t/K2tpF0WPM61qWa0DNHPcm9vOc
        yWR2KVVo1PXYJvxB+CwanAlZoRPKRXGp6Y6p8029qoxDdUkQTNnbI3SJQCmzujCVFHyFqp
        tI/M54xm4o4bvtlasJp/Fn4WnJnKebI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670518272;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Saz5QgfCYR/nWPEclN397UURX/bkVNc1D/XuX66CnZI=;
        b=+cDGWmUBtam63br8ghz04WYngLeKSDU06IRsLLVWzR2SivnvOwWrf0FioS0xRKosTNlw6+
        Y3WF0Yk92re9nCBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 28A5513416;
        Thu,  8 Dec 2022 16:51:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k7E/CQAWkmPgMQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 08 Dec 2022 16:51:12 +0000
Message-ID: <915a5034-53e6-9464-3fc7-4d1b5a0aa26d@suse.cz>
Date:   Thu, 8 Dec 2022 17:51:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 3/6] mm/page_alloc: Explicitly record high-order atomic
 allocations in alloc_flags
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20221129151701.23261-1-mgorman@techsingularity.net>
 <20221129151701.23261-4-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221129151701.23261-4-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 16:16, Mel Gorman wrote:
> A high-order ALLOC_HARDER allocation is assumed to be atomic. While that
> is accurate, it changes later in the series. In preparation, explicitly
> record high-order atomic allocations in gfp_to_alloc_flags().
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/internal.h   |  1 +
>  mm/page_alloc.c | 19 +++++++++++++------
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index d503e57a57a1..9a9d9b5ee87f 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -754,6 +754,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  #else
>  #define ALLOC_NOFRAGMENT	  0x0
>  #endif
> +#define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
>  #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
>  
>  enum ttu_flags;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index da746e9eb2cf..e2b65767dda0 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3710,7 +3710,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
>  		 * reserved for high-order atomic allocation, so order-0
>  		 * request should skip it.
>  		 */
> -		if (order > 0 && alloc_flags & ALLOC_HARDER)
> +		if (alloc_flags & ALLOC_HIGHATOMIC)
>  			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
>  		if (!page) {
>  			page = __rmqueue(zone, order, migratetype, alloc_flags);
> @@ -4028,8 +4028,10 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
>  			return true;
>  		}
>  #endif
> -		if (alloc_harder && !free_area_empty(area, MIGRATE_HIGHATOMIC))
> +		if ((alloc_flags & ALLOC_HIGHATOMIC) &&
> +		    !free_area_empty(area, MIGRATE_HIGHATOMIC)) {
>  			return true;

alloc_harder is defined as
	(alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
AFAICS this means we no longer allow ALLOC_OOM to use the highatomic
reserve. Isn't that a risk?

> +		}
>  	}
>  	return false;
>  }
> @@ -4291,7 +4293,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
>  			 * If this is a high-order atomic allocation then check
>  			 * if the pageblock should be reserved for the future
>  			 */
> -			if (unlikely(order && (alloc_flags & ALLOC_HARDER)))
> +			if (unlikely(alloc_flags & ALLOC_HIGHATOMIC))
>  				reserve_highatomic_pageblock(page, zone, order);
>  
>  			return page;
> @@ -4818,7 +4820,7 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
>  }
>  
>  static inline unsigned int
> -gfp_to_alloc_flags(gfp_t gfp_mask)
> +gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
>  {
>  	unsigned int alloc_flags = ALLOC_WMARK_MIN | ALLOC_CPUSET;
>  
> @@ -4844,8 +4846,13 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
>  		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
>  		 * if it can't schedule.
>  		 */
> -		if (!(gfp_mask & __GFP_NOMEMALLOC))
> +		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
>  			alloc_flags |= ALLOC_HARDER;
> +
> +			if (order > 0)
> +				alloc_flags |= ALLOC_HIGHATOMIC;
> +		}
> +
>  		/*
>  		 * Ignore cpuset mems for GFP_ATOMIC rather than fail, see the
>  		 * comment for __cpuset_node_allowed().
> @@ -5053,7 +5060,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  	 * kswapd needs to be woken up, and to avoid the cost of setting up
>  	 * alloc_flags precisely. So we do that now.
>  	 */
> -	alloc_flags = gfp_to_alloc_flags(gfp_mask);
> +	alloc_flags = gfp_to_alloc_flags(gfp_mask, order);
>  
>  	/*
>  	 * We need to recalculate the starting point for the zonelist iterator

