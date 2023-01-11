Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32AE665F45
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237937AbjAKPiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239124AbjAKPhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:37:48 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDF81E3FC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:37:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AAE3A8B896;
        Wed, 11 Jan 2023 15:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1673451453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H5PrZhGxAXPih4jW/nQocRH5mJY9ZxQOPuFJC4UKqxc=;
        b=ANOeU6imNYB3YhDQhQexlYgh0cL0lzk3Nt32U9yhMFbLO42nW6eeTkOWED21iFXAgb/SVp
        TK2apZMAjfWHNRtFCzX2s3xRfaZFQK11gncGb5+MDWyQLpvBoBruZ+n8NKqxqNAybU+m6V
        /Ykdr6nnso/PjaSV9/uABIpvWi1Q/Nk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8EDD61358A;
        Wed, 11 Jan 2023 15:37:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HgAAIL3XvmM6OAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 11 Jan 2023 15:37:33 +0000
Date:   Wed, 11 Jan 2023 16:37:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] mm/page_alloc: Explicitly define what alloc flags
 deplete min reserves
Message-ID: <Y77XvABeJEgnyIY9@dhcp22.suse.cz>
References: <20230109151631.24923-1-mgorman@techsingularity.net>
 <20230109151631.24923-5-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109151631.24923-5-mgorman@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-01-23 15:16:28, Mel Gorman wrote:
> As there are more ALLOC_ flags that affect reserves, define what flags
> affect reserves and clarify the effect of each flag.

I like this! It makes the code much easier to follow.

> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  mm/internal.h   |  3 +++
>  mm/page_alloc.c | 34 ++++++++++++++++++++++------------
>  2 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 178484d9fd94..8706d46863df 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -749,6 +749,9 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
>  #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
>  
> +/* Flags that allow allocations below the min watermark. */
> +#define ALLOC_RESERVES (ALLOC_HARDER|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
> +
>  enum ttu_flags;
>  struct tlbflush_unmap_batch;
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0ef4f3236a5a..6f41b84a97ac 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3949,15 +3949,14 @@ ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
>  static inline long __zone_watermark_unusable_free(struct zone *z,
>  				unsigned int order, unsigned int alloc_flags)
>  {
> -	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
>  	long unusable_free = (1 << order) - 1;
>  
>  	/*
> -	 * If the caller does not have rights to ALLOC_HARDER then subtract
> -	 * the high-atomic reserves. This will over-estimate the size of the
> -	 * atomic reserve but it avoids a search.
> +	 * If the caller does not have rights to reserves below the min
> +	 * watermark then subtract the high-atomic reserves. This will
> +	 * over-estimate the size of the atomic reserve but it avoids a search.
>  	 */
> -	if (likely(!alloc_harder))
> +	if (likely(!(alloc_flags & ALLOC_RESERVES)))
>  		unusable_free += z->nr_reserved_highatomic;
>  
>  #ifdef CONFIG_CMA
> @@ -3981,25 +3980,36 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
>  {
>  	long min = mark;
>  	int o;
> -	const bool alloc_harder = (alloc_flags & (ALLOC_HARDER|ALLOC_OOM));
>  
>  	/* free_pages may go negative - that's OK */
>  	free_pages -= __zone_watermark_unusable_free(z, order, alloc_flags);
>  
> -	if (alloc_flags & ALLOC_MIN_RESERVE)
> -		min -= min / 2;
> +	if (unlikely(alloc_flags & ALLOC_RESERVES)) {
> +		/*
> +		 * __GFP_HIGH allows access to 50% of the min reserve as well
> +		 * as OOM.
> +		 */
> +		if (alloc_flags & ALLOC_MIN_RESERVE)
> +			min -= min / 2;
>  
> -	if (unlikely(alloc_harder)) {
>  		/*
> -		 * OOM victims can try even harder than normal ALLOC_HARDER
> +		 * Non-blocking allocations can access some of the reserve
> +		 * with more access if also __GFP_HIGH. The reasoning is that
> +		 * a non-blocking caller may incur a more severe penalty
> +		 * if it cannot get memory quickly, particularly if it's
> +		 * also __GFP_HIGH.
> +		 */
> +		if (alloc_flags & ALLOC_HARDER)
> +			min -= min / 4;
> +
> +		/*
> +		 * OOM victims can try even harder than the normal reserve
>  		 * users on the grounds that it's definitely going to be in
>  		 * the exit path shortly and free memory. Any allocation it
>  		 * makes during the free path will be small and short-lived.
>  		 */
>  		if (alloc_flags & ALLOC_OOM)
>  			min -= min / 2;
> -		else
> -			min -= min / 4;
>  	}
>  
>  	/*
> -- 
> 2.35.3

-- 
Michal Hocko
SUSE Labs
