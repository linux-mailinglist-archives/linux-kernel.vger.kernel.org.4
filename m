Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A6B647530
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 18:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiLHRzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 12:55:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLHRzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 12:55:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C12ABA3B
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 09:55:02 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D5E7337BE;
        Thu,  8 Dec 2022 17:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670522101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h98rSvnrYt4Vjk/nsZlMEPOhDf8efhGehbJ5JxvZNQk=;
        b=B4mpOZ/CSVcbSy+pvRqd3VCXBFvlKoqqXjl68jMMDE6Z5XR155rfcsh9CXIgxl5/UYFPvT
        4LJcVOe+HQai34Phn2B2c8/6BPbgoajD9PE9tGmvQmvcXaI2TOxry+AHMV9NGsOf3ZIzgj
        CWko5RFxgiHM8mP1tuXkYyxSjG0e4hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670522101;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h98rSvnrYt4Vjk/nsZlMEPOhDf8efhGehbJ5JxvZNQk=;
        b=nwqb8ytuptXZrMGh6H6rVpGMLEkgA+uTiNlAAqAPmq8HtH1NssoZBwUk5syd5KfS70k88Z
        yuSNmpePV85KRFAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1CA8138E0;
        Thu,  8 Dec 2022 17:55:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vKFENvQkkmP8TAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 08 Dec 2022 17:55:00 +0000
Message-ID: <fbe2d13c-147d-7ce5-91e7-27fcf3d2e5d9@suse.cz>
Date:   Thu, 8 Dec 2022 18:55:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/6] mm/page_alloc: Explicitly define what alloc flags
 deplete min reserves
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20221129151701.23261-1-mgorman@techsingularity.net>
 <20221129151701.23261-5-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221129151701.23261-5-mgorman@techsingularity.net>
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

On 11/29/22 16:16, Mel Gorman wrote:
> As there are more ALLOC_ flags that affect reserves, define what flags
> affect reserves and clarify the effect of each flag.

Seems to me this does more than a clarification, but also some functional
tweaks, so it could be helpful if those were spelled out in the changelog.

> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/internal.h   |  3 +++
>  mm/page_alloc.c | 36 +++++++++++++++++++++++-------------
>  2 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 9a9d9b5ee87f..370500718732 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -757,6 +757,9 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
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
> index e2b65767dda0..85a87d0ac57a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3944,15 +3944,14 @@ ALLOW_ERROR_INJECTION(should_fail_alloc_page, TRUE);
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
> @@ -3976,25 +3975,36 @@ bool __zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
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
> +	if (alloc_flags & ALLOC_RESERVES) {

Do we want to keep this unlikely() as alloc_harder did before?

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
> +		if (alloc_flags & (ALLOC_HARDER|ALLOC_HIGHATOMIC))
> +			min -= min / 4;

For example this seems to change the allowed dip to reserves for
ALLOC_HIGHATOMIC.

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

(noted that this patch doesn't seem to change the concern I raised in
previous patch)

>  	/*
> @@ -5293,7 +5303,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  		 * could deplete whole memory reserves which would just make
>  		 * the situation worse
>  		 */
> -		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_HARDER, ac);
> +		page = __alloc_pages_cpuset_fallback(gfp_mask, order, ALLOC_MIN_RESERVE|ALLOC_HARDER, ac);

And this AFAICS seems to give __GFP_NOFAIL 3/4 of min reserves instead of
1/4, which seems like a significant change (but hopefully ok) so worth
noting at least.

>  		if (page)
>  			goto got_pg;
>  

