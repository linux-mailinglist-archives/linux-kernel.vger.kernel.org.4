Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96432647553
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiLHSHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiLHSHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:07:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CC12FBC2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:07:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2C9F6337BE;
        Thu,  8 Dec 2022 18:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670522827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2IVFdreTiW3Ao76M0ZnFXsibpRuEnW0G9TNOeobmX04=;
        b=fSbt6kLY63AOz+vIZuy4QK+CplJnBNxZh4n9ub+MlrIRjqChSxJ9Uo9q7oB/1CB4V7OOVX
        rBDWYpzRc03wJBWUUxFyBUitjmI5/fRNP3CY7k2byohmqKLG3OVw1IthirZQGjOekOm4v3
        jSOG6pJDIugFm3FH9bb6IHIZrbEisjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670522827;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2IVFdreTiW3Ao76M0ZnFXsibpRuEnW0G9TNOeobmX04=;
        b=cd4pX7eaU2waBv+JzMDNpQDtWsG6lwe1eWMZTu58/TxXMwzz+avDzSAa/oAhgFnNo+HC4b
        WMjc+MHj0tFmOQBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0524E138E0;
        Thu,  8 Dec 2022 18:07:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e6AzAMsnkmP/UQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 08 Dec 2022 18:07:07 +0000
Message-ID: <ebe54af3-f679-32ab-1ef1-17f565796ef2@suse.cz>
Date:   Thu, 8 Dec 2022 19:07:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 5/6] mm/page_alloc: Give GFP_ATOMIC and non-blocking
 allocations access to reserves
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20221129151701.23261-1-mgorman@techsingularity.net>
 <20221129151701.23261-6-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221129151701.23261-6-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 16:17, Mel Gorman wrote:
> Explicit GFP_ATOMIC allocations get flagged ALLOC_HARDER which is a bit
> vague. In preparation for removing __GFP_ATOMIC, give GFP_ATOMIC and
> other non-blocking allocation requests equal access to reserve.  Rename
> ALLOC_HARDER to ALLOC_NON_BLOCK to make it more clear what the flag
> means.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/internal.h   |  7 +++++--
>  mm/page_alloc.c | 23 +++++++++++++----------
>  2 files changed, 18 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 370500718732..98b1e526559d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -743,7 +743,10 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  #define ALLOC_OOM		ALLOC_NO_WATERMARKS
>  #endif
>  
> -#define ALLOC_HARDER		 0x10 /* try to alloc harder */
> +#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. Allow access
> +				       * to 25% of the min watermark or
> +				       * 62.5% if __GFP_HIGH is set.
> +				       */
>  #define ALLOC_MIN_RESERVE	 0x20 /* __GFP_HIGH set. Allow access to 50%
>  				       * of the min watermark.
>  				       */
> @@ -758,7 +761,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
>  
>  /* Flags that allow allocations below the min watermark. */
> -#define ALLOC_RESERVES (ALLOC_HARDER|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
> +#define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
>  
>  enum ttu_flags;
>  struct tlbflush_unmap_batch;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 85a87d0ac57a..6bee987ec9a3 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3994,7 +3994,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
>  		 * if it cannot get memory quickly, particularly if it's
>  		 * also __GFP_HIGH.
>  		 */
> -		if (alloc_flags & (ALLOC_HARDER|ALLOC_HIGHATOMIC))
> +		if (alloc_flags & (ALLOC_NON_BLOCK|ALLOC_HIGHATOMIC))
>  			min -= min / 4;
>  
>  		/*
> @@ -4846,28 +4846,30 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
>  	 * The caller may dip into page reserves a bit more if the caller
>  	 * cannot run direct reclaim, or if the caller has realtime scheduling
>  	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
> -	 * set both ALLOC_HARDER (__GFP_ATOMIC) and ALLOC_MIN_RESERVE(__GFP_HIGH).
> +	 * set both ALLOC_NON_BLOCK and ALLOC_MIN_RESERVE(__GFP_HIGH).
>  	 */
>  	alloc_flags |= (__force int)
>  		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
>  
> -	if (gfp_mask & __GFP_ATOMIC) {
> +	if (!(gfp_mask & __GFP_RECLAIM)) {

This is supposed to be __GFP_DIRECT_RECLAIM right? Otherwise that includes
also __GFP_KSWAPD_RECLAIM and GFP_ATOMIC sets that one...

>  		/*
>  		 * Not worth trying to allocate harder for __GFP_NOMEMALLOC even
>  		 * if it can't schedule.
>  		 */
>  		if (!(gfp_mask & __GFP_NOMEMALLOC)) {
> -			alloc_flags |= ALLOC_HARDER;
> +			alloc_flags |= ALLOC_NON_BLOCK;
>  
>  			if (order > 0)
>  				alloc_flags |= ALLOC_HIGHATOMIC;
>  		}
>  
>  		/*
> -		 * Ignore cpuset mems for GFP_ATOMIC rather than fail, see the
> -		 * comment for __cpuset_node_allowed().
> +		 * Ignore cpuset mems for non-blocking __GFP_HIGH (probably
> +		 * GFP_ATOMIC) rather than fail, see the comment for
> +		 * __cpuset_node_allowed().
>  		 */
> -		alloc_flags &= ~ALLOC_CPUSET;
> +		if (alloc_flags & ALLOC_MIN_RESERVE)
> +			alloc_flags &= ~ALLOC_CPUSET;
>  	} else if (unlikely(rt_task(current)) && in_task())
>  		alloc_flags |= ALLOC_MIN_RESERVE;
>  
> @@ -5299,11 +5301,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  
>  		/*
>  		 * Help non-failing allocations by giving them access to memory
> -		 * reserves but do not use ALLOC_NO_WATERMARKS because this
> +		 * reserves normally used for high priority non-blocking
> +		 * allocations but do not use ALLOC_NO_WATERMARKS because this
>  		 * could deplete whole memory reserves which would just make
> -		 * the situation worse
> +		 * the situation worse.
>  		 */
> -		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE|ALLOC_HARDER, ac);
> +		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE|ALLOC_NON_BLOCK, ac);
>  		if (page)
>  			goto got_pg;
>  

