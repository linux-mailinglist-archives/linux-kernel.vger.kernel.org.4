Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C8068F1E1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjBHPUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjBHPUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:20:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74551FF22
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:20:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3250833787;
        Wed,  8 Feb 2023 15:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1675869633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cs8iOEKaeBiQdcppkSfO3JjWOnZh497QODuGuSRJaTs=;
        b=xvWDmY9Sfj0nPhJCf7yJ4nURQx807QVmRAexoVe3WV0yvgRxeIy5Und7zDBj1gM7RXViDM
        RcUMIDl41fZ9RweDSaFNxeAKyYLZXBG9bmb8TQ3xH+uO9WFMLg1PJYsLBrjoloSUQtiI8q
        Kl4FzIzS2JX6RbqfdcO/RO8OAUJdR/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1675869633;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cs8iOEKaeBiQdcppkSfO3JjWOnZh497QODuGuSRJaTs=;
        b=um5AsSpneM75mybSSmBSnFo+2E8H6EkULEx1lio7HK4VagojfDEaRncXIHom9Z3OoChX0m
        zI7sASw4/veTSpCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DFBB13425;
        Wed,  8 Feb 2023 15:20:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id i9KMBsG942M8PQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 08 Feb 2023 15:20:33 +0000
Message-ID: <1d468148-936f-8816-eb71-1662f2d4945b@suse.cz>
Date:   Wed, 8 Feb 2023 16:20:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm: reduce lock contention of pcp buffer refill
Content-Language: en-US
To:     Alexander Halbuer <halbuer@sra.uni-hannover.de>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
References: <20230201162549.68384-1-halbuer@sra.uni-hannover.de>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230201162549.68384-1-halbuer@sra.uni-hannover.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/23 17:25, Alexander Halbuer wrote:
> The `rmqueue_bulk` function batches the allocation of multiple elements to
> refill the per-CPU buffers into a single hold of the zone lock. Each
> element is allocated and checked using the `check_pcp_refill` function.
> The check touches every related struct page which is especially expensive
> for higher order allocations (huge pages). This patch reduces the time
> holding the lock by moving the check out of the critical section similar
> to the `rmqueue_buddy` function which allocates a single element.
> Measurements of parallel allocation-heavy workloads show a reduction of
> the average huge page allocation latency of 50 percent for two cores and
> nearly 90 percent for 24 cores.
> 
> Signed-off-by: Alexander Halbuer <halbuer@sra.uni-hannover.de>

Even if we proceed with disabling the checks in default
non-debugging/non-hardened configurations, this would still help those
configurations, so:

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Suggestion below:

> ---
>  mm/page_alloc.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0745aedebb37..4b80438b1f59 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3119,6 +3119,8 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  {
>  	unsigned long flags;
>  	int i, allocated = 0;
> +	struct list_head *prev_tail = list->prev;
> +	struct page *pos, *n;
>  
>  	spin_lock_irqsave(&zone->lock, flags);
>  	for (i = 0; i < count; ++i) {
> @@ -3127,9 +3129,6 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  		if (unlikely(page == NULL))
>  			break;
>  
> -		if (unlikely(check_pcp_refill(page, order)))
> -			continue;
> -
>  		/*
>  		 * Split buddy pages returned by expand() are received here in
>  		 * physical page order. The page is added to the tail of
> @@ -3141,7 +3140,6 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  		 * pages are ordered properly.
>  		 */
>  		list_add_tail(&page->pcp_list, list);
> -		allocated++;
>  		if (is_migrate_cma(get_pcppage_migratetype(page)))
>  			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,

As another benefit of your patch, the NR_FREE_CMA_PAGES will not become
inaccurate if we leak CMA pages failing the check, anymore.

You could also try another patch that will move the above check into the
loop below, see if it makes any difference in your benchmark. The loop could
count is_migrate_cma pages, and afterwards do a single "if (cma_pages > 0)
mod_zone_page_state(...)" - because we are no longer inside
spin_lock_irqsave() block, we need to use the safe mod_zone_page... variant
without underscores.

Thanks!

>  					      -(1 << order));
> @@ -3155,6 +3153,22 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  	 */
>  	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
>  	spin_unlock_irqrestore(&zone->lock, flags);
> +
> +	/*
> +	 * Pages are appended to the pcp list without checking to reduce the
> +	 * time holding the zone lock. Checking the appended pages happens right
> +	 * after the critical section while still holding the pcp lock.
> +	 */
> +	pos = list_first_entry(prev_tail, struct page, pcp_list);
> +	list_for_each_entry_safe_from(pos, n, list, pcp_list) {
> +		if (unlikely(check_pcp_refill(pos, order))) {
> +			list_del(&pos->pcp_list);
> +			continue;
> +		}
> +
> +		allocated++;
> +	}
> +
>  	return allocated;
>  }
>  

