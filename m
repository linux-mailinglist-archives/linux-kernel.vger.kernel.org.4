Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E50868D963
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjBGNcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjBGNcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:32:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769622A981
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:32:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1EE2120BAD;
        Tue,  7 Feb 2023 13:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675776753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Pjo9sCDErwUpV57a05qf368X7pvLHyv4C1Em8MgSnc=;
        b=fedF29CyZrqVI/weXAhU7IVm3Iehp/lDdfaN2G+B/ET7DFc7uj4tp/kPznoCLVqq9VORVT
        w5NXYBICTGFmwjgK3TBe00AcMMhDDcrbz1bNZGKPZXPAt1k26Y0pySHtEpFQaZJfi5Qzdo
        vG7RUqnMDYANOasxtR5GnBrYsjyhUa8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675776753;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Pjo9sCDErwUpV57a05qf368X7pvLHyv4C1Em8MgSnc=;
        b=Oeb6cbim92YmnmhJu0cJ1cmTfDZzR1WlSRmKssz7KLUJ7+JelI4EkBcvyzbRGtSobeCRtI
        s01h9e/q7jZpgFCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EF804139ED;
        Tue,  7 Feb 2023 13:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ovnZOfBS4mNSdAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 07 Feb 2023 13:32:32 +0000
Message-ID: <26a97c64-11e6-122f-178d-0207226b8693@suse.cz>
Date:   Tue, 7 Feb 2023 14:32:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 5/6] mm/page_alloc: Explicitly define how __GFP_HIGH
 non-blocking allocations accesses reserves
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230113111217.14134-1-mgorman@techsingularity.net>
 <20230113111217.14134-6-mgorman@techsingularity.net>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230113111217.14134-6-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/23 12:12, Mel Gorman wrote:
> GFP_ATOMIC allocations get flagged ALLOC_HARDER which is a vague
> description. In preparation for the removal of GFP_ATOMIC redefine

						^ __GFP_ATOMC

> __GFP_ATOMIC to simply mean non-blocking and renaming ALLOC_HARDER to
> ALLOC_NON_BLOCK accordingly. __GFP_HIGH is required for access to reserves
> but non-blocking is granted more access. For example, GFP_NOWAIT is
> non-blocking but has no special access to reserves. A __GFP_NOFAIL
> blocking allocation is granted access similar to __GFP_HIGH if the
> only alternative is an OOM kill.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Well just for the lore record (too late for git)

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Nit below:

> ---
>  mm/internal.h   |  7 +++++--
>  mm/page_alloc.c | 44 ++++++++++++++++++++++++--------------------
>  2 files changed, 29 insertions(+), 22 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 8706d46863df..23a37588073a 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -735,7 +735,10 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  #define ALLOC_OOM		ALLOC_NO_WATERMARKS
>  #endif
>  
> -#define ALLOC_HARDER		 0x10 /* try to alloc harder */
> +#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. Allow access
> +				       * to 25% of the min watermark or
> +				       * 62.5% if __GFP_HIGH is set.

This is now (as of v3) inaccurate (the 25% part), right?

> +				       */
>  #define ALLOC_MIN_RESERVE	 0x20 /* __GFP_HIGH set. Allow access to 50%
>  				       * of the min watermark.
>  				       */
> @@ -750,7 +753,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
>  
>  /* Flags that allow allocations below the min watermark. */
> -#define ALLOC_RESERVES (ALLOC_HARDER|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
> +#define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
>  
>  enum ttu_flags;
>  struct tlbflush_unmap_batch;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6f41b84a97ac..b9ae0ba0a2ab 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3989,18 +3989,19 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
>  		 * __GFP_HIGH allows access to 50% of the min reserve as well
>  		 * as OOM.
>  		 */
> -		if (alloc_flags & ALLOC_MIN_RESERVE)
> +		if (alloc_flags & ALLOC_MIN_RESERVE) {
>  			min -= min / 2;
>  
> -		/*
> -		 * Non-blocking allocations can access some of the reserve
> -		 * with more access if also __GFP_HIGH. The reasoning is that
> -		 * a non-blocking caller may incur a more severe penalty
> -		 * if it cannot get memory quickly, particularly if it's
> -		 * also __GFP_HIGH.
> -		 */
> -		if (alloc_flags & ALLOC_HARDER)
> -			min -= min / 4;
> +			/*
> +			 * Non-blocking allocations (e.g. GFP_ATOMIC) can
> +			 * access more reserves than just __GFP_HIGH. Other
> +			 * non-blocking allocations requests such as GFP_NOWAIT
> +			 * or (GFP_KERNEL & ~__GFP_DIRECT_RECLAIM) do not get
> +			 * access to the min reserve.
> +			 */
> +			if (alloc_flags & ALLOC_NON_BLOCK)
> +				min -= min / 4;
> +		}
>  
>  		/*
>  		 * OOM victims can try even harder than the normal reserve
> @@ -4851,28 +4852,30 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
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
> +	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
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
> @@ -5303,12 +5306,13 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		WARN_ON_ONCE_GFP(costly_order, gfp_mask);
>  
>  		/*
> -		 * Help non-failing allocations by giving them access to memory
> -		 * reserves but do not use ALLOC_NO_WATERMARKS because this
> +		 * Help non-failing allocations by giving some access to memory
> +		 * reserves normally used for high priority non-blocking
> +		 * allocations but do not use ALLOC_NO_WATERMARKS because this
>  		 * could deplete whole memory reserves which would just make
> -		 * the situation worse
> +		 * the situation worse.
>  		 */
> -		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_HARDER, ac);
> +		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE, ac);
>  		if (page)
>  			goto got_pg;
>  

