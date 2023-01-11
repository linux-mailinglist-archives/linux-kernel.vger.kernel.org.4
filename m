Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C46D665EEF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbjAKPTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjAKPSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:18:55 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BB8167F1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:18:53 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A127A17D5A;
        Wed, 11 Jan 2023 15:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673450331; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hwhw0xueoRQfeRsCWppft2gnEQP/FMWyCk6R1o8Asho=;
        b=KmKPjMNWZsCwVeaDFB+fRZ5uBcKXjpMBjGXWHFq0tWO9XCW+39p8TZVLv5WdxlhMe8KXFz
        x/LWWti9rB+G7qdqWy9bSiET+4PwJ/r5dmYLAT6eqINOZn8wpfzcFOfJ9SqA63+fLD/VX4
        JEzqyib8FTGmYuagESKEYJp2hvN2Mb0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FE3C13591;
        Wed, 11 Jan 2023 15:18:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8Y5eHFvTvmMSLgAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 11 Jan 2023 15:18:51 +0000
Date:   Wed, 11 Jan 2023 16:18:50 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] mm/page_alloc: Rename ALLOC_HIGH to ALLOC_MIN_RESERVE
Message-ID: <Y77TWhr9/dPcthiF@dhcp22.suse.cz>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109151631.24923-2-mgorman@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-01-23 15:16:25, Mel Gorman wrote:
> __GFP_HIGH aliases to ALLOC_HIGH but the name does not really hint
> what it means. As ALLOC_HIGH is internal to the allocator, rename
> it to ALLOC_MIN_RESERVE to document that the min reserves can
> be depleted.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>

Naming is hard but ALLOC_HIGH is definitely much more confusing as it
can collide with high watermark. ALLOC_MIN_RESERVE says that some
reserves are involved. ALl the reserves are below min watermark by
defition but I cannot really come up with a better name. I do not think
we want to encode the amount of reserves into the name.

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
> ---
>  mm/internal.h   | 4 +++-
>  mm/page_alloc.c | 8 ++++----
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index bcf75a8b032d..403e4386626d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -736,7 +736,9 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  #endif
>  
>  #define ALLOC_HARDER		 0x10 /* try to alloc harder */
> -#define ALLOC_HIGH		 0x20 /* __GFP_HIGH set */
> +#define ALLOC_MIN_RESERVE	 0x20 /* __GFP_HIGH set. Allow access to 50%
> +				       * of the min watermark.
> +				       */
>  #define ALLOC_CPUSET		 0x40 /* check for correct cpuset */
>  #define ALLOC_CMA		 0x80 /* allow allocations from CMA areas */
>  #ifdef CONFIG_ZONE_DMA32
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0745aedebb37..244c1e675dc8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3976,7 +3976,7 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
>  	/* free_pages may go negative - that's OK */
>  	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
>  
> -	if (alloc_flags & ALLOC_HIGH)
> +	if (alloc_flags & ALLOC_MIN_RESERVE)
>  		min -= min / 2;
>  
>  	if (unlikely(alloc_harder)) {
> @@ -4818,18 +4818,18 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
>  	unsigned int alloc_flags = ALLOC_WMARK_MIN | ALLOC_CPUSET;
>  
>  	/*
> -	 * __GFP_HIGH is assumed to be the same as ALLOC_HIGH
> +	 * __GFP_HIGH is assumed to be the same as ALLOC_MIN_RESERVE
>  	 * and __GFP_KSWAPD_RECLAIM is assumed to be the same as ALLOC_KSWAPD
>  	 * to save two branches.
>  	 */
> -	BUILD_BUG_ON(__GFP_HIGH != (__force gfp_t) ALLOC_HIGH);
> +	BUILD_BUG_ON(__GFP_HIGH != (__force gfp_t) ALLOC_MIN_RESERVE);
>  	BUILD_BUG_ON(__GFP_KSWAPD_RECLAIM != (__force gfp_t) ALLOC_KSWAPD);
>  
>  	/*
>  	 * The caller may dip into page reserves a bit more if the caller
>  	 * cannot run direct reclaim, or if the caller has realtime scheduling
>  	 * policy or is asking for __GFP_HIGH memory.  GFP_ATOMIC requests will
> -	 * set both ALLOC_HARDER (__GFP_ATOMIC) and ALLOC_HIGH (__GFP_HIGH).
> +	 * set both ALLOC_HARDER (__GFP_ATOMIC) and ALLOC_MIN_RESERVE(__GFP_HIGH).
>  	 */
>  	alloc_flags |= (__force int)
>  		(gfp_mask & (__GFP_HIGH | __GFP_KSWAPD_RECLAIM));
> -- 
> 2.35.3

-- 
Michal Hocko
SUSE Labs
