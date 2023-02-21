Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F3369DDD8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:27:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjBUK1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232692AbjBUK1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:27:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C842366A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:27:15 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 980FF5C39D;
        Tue, 21 Feb 2023 10:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676975234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLUBEigsXZYSt8itUZLTiLTXmXVNsAMFtduWi1WKJTU=;
        b=vA05RYox8ztfcEJ43/EZhkn1DaTbK1KIz6Z8F9YmqLAk8i+2o751EFVNmTXQG+/LRGK4vb
        4/QZUoAGXvPO/JWRnxnj2JRzwygpIMv2Z/tHRHw+xMbBspoJ7/RDq4Kh2hfx7zXXMz4Mlp
        zypG2iokHzdSAUyAejbPMz9W+MXiNKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676975234;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fLUBEigsXZYSt8itUZLTiLTXmXVNsAMFtduWi1WKJTU=;
        b=uQlWtgHGTLt/Iqd/dPdSyjBIC4E5dcLLbsNY8i95Tqi6gf0kBnSTTc/dpmFy7yH9IweJUR
        OGjLPoBdt4FNA/Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80E1A13223;
        Tue, 21 Feb 2023 10:27:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zY7CHoKc9GPCSwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Feb 2023 10:27:14 +0000
Message-ID: <89778da7-74a3-2f2a-1668-afe7b15487dc@suse.cz>
Date:   Tue, 21 Feb 2023 11:27:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm, page_alloc: batch cma update on pcp buffer refill
To:     Alexander Halbuer <halbuer@sra.uni-hannover.de>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230217120504.87043-1-halbuer@sra.uni-hannover.de>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230217120504.87043-1-halbuer@sra.uni-hannover.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/23 13:05, Alexander Halbuer wrote:
> As proposed by Vlastimil Babka [1] this is an extension to the previous patch
> "mm: reduce lock contention of pcp buffer refill". This version also moves the
> is_migrate_cma() check from the critical section to the loop below.

Hi, thanks for trying it out!

> The optimization has several advantages:
> - Less time in critical section
> - Batching update of NR_FREE_CMA_PAGES into a single call to
>   mod_zone_page_state()
> - Utilizing cache locality of the related struct page when doing the cma check
>   is_migrate_cma() and the sanity check check_pcp_refill() in the same loop

The last point probably doesn't apply as we are reading/modifying page->lru
with __rmqueue()/list_add_tail() so that brings the struct page to cache
already.

> 
> However, this change only affects performance with CONFIG_CMA=true which
> may not be the common case. Another possibly negative effect is that the
> actual update of NR_FREE_CMA_PAGES is delayed beyond the release of the
> zone lock resulting in a short time span of inaccuracy between the
> counter and the actual number of cma pages in the zone.

Hmm didn't realize that, that might be perhaps a problem.

> The tables below compare this patch with the initial one using a
> parallel allocation benchmark. The used kernel config is based on the default
> debian config but with CONFIG_INIT_ON_ALLOC_DEFAULT_ON=FALSE and
> CONFIG_CMA=TRUE. The benchmarks have been performed with the default sanity
> checks enabled as the patch "mm, page_alloc: reduce page alloc/free sanity
> checks" [2] was not enabled on my test branch.
> The given times are average allocation times. The improvement is not
> significant, but the general trend is visible.

Yeah there's some improvement, but if [2] is accepted, then keeping two
loops there just for the cma update (as there will be no more checking in
the second loop) will almost certainly stop being a win. And with the risk
of inaccuracy you pointed out, on top.

Incidentally, did you observe any improvements by [2] with your test,
especially as the batch freeing side also no longer does checking under zone
lock?

Thanks!

> Hopefully, without sanity checks and disabled cma, a compiler will be able
> to optimize away the second loop entirely.
> 
> [1] https://lore.kernel.org/lkml/1d468148-936f-8816-eb71-1662f2d4945b@suse.cz/
> [2] https://lore.kernel.org/linux-mm/20230216095131.17336-1-vbabka@suse.cz/
> 
> Normal Pages
> +-------+---------+---------+---------+
> | Cores | Patch 1 | Patch 2 | Patch 2 |
> |       |    (ns) |    (ns) |    Diff |
> +-------+---------+---------+---------+
> |     1 |     132 |     129 | (-2.3%) |
> |     2 |     147 |     145 | (-1.4%) |
> |     3 |     148 |     147 | (-0.7%) |
> |     4 |     175 |     173 | (-1.1%) |
> |     6 |     263 |     255 | (-3.0%) |
> |     8 |     347 |     337 | (-2.9%) |
> |    10 |     432 |     421 | (-2.5%) |
> |    12 |     516 |     505 | (-2.1%) |
> |    14 |     604 |     590 | (-2.3%) |
> |    16 |     695 |     680 | (-2.2%) |
> |    20 |     869 |     844 | (-2.9%) |
> |    24 |    1043 |    1015 | (-2.7%) |
> +-------+---------+---------+---------+
> 
> Huge Pages
> +-------+---------+---------+---------+
> | Cores | Patch 1 | Patch 2 | Patch 2 |
> |       |    (ns) |    (ns) |    Diff |
> +-------+---------+---------+---------+
> |     1 |    3177 |    3133 | (-1.4%) |
> |     2 |    3486 |    3471 | (-0.4%) |
> |     3 |    3644 |    3634 | (-0.3%) |
> |     4 |    3669 |    3643 | (-0.7%) |
> |     6 |    3587 |    3578 | (-0.3%) |
> |     8 |    3635 |    3621 | (-0.4%) |
> |    10 |    4015 |    3960 | (-1.4%) |
> |    12 |    4681 |    4510 | (-3.7%) |
> |    14 |    5398 |    5180 | (-4.0%) |
> |    16 |    6239 |    5891 | (-5.6%) |
> |    20 |    7864 |    7435 | (-5.5%) |
> |    24 |    9011 |    8971 | (-0.4%) |
> +-------+---------+---------+---------+
> 
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Alexander Halbuer <halbuer@sra.uni-hannover.de>
> ---
>  mm/page_alloc.c | 48 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 36 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0745aedebb37..f82a59eeb4fe 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3119,17 +3119,17 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  {
>  	unsigned long flags;
>  	int i, allocated = 0;
> +	int cma_pages = 0;
> +	struct list_head *prev_tail = list->prev;
> +	struct page *pos, *n;
>  
>  	spin_lock_irqsave(&zone->lock, flags);
>  	for (i = 0; i < count; ++i) {
> -		struct page *page = __rmqueue(zone, order, migratetype,
> -								alloc_flags);
> +		struct page *page =
> +			__rmqueue(zone, order, migratetype, alloc_flags);
>  		if (unlikely(page == NULL))
>  			break;
>  
> -		if (unlikely(check_pcp_refill(page, order)))
> -			continue;
> -
>  		/*
>  		 * Split buddy pages returned by expand() are received here in
>  		 * physical page order. The page is added to the tail of
> @@ -3141,20 +3141,44 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
>  		 * pages are ordered properly.
>  		 */
>  		list_add_tail(&page->pcp_list, list);
> -		allocated++;
> -		if (is_migrate_cma(get_pcppage_migratetype(page)))
> -			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
> -					      -(1 << order));
>  	}
>  
>  	/*
> -	 * i pages were removed from the buddy list even if some leak due
> -	 * to check_pcp_refill failing so adjust NR_FREE_PAGES based
> -	 * on i. Do not confuse with 'allocated' which is the number of
> +	 * i pages were removed from the buddy list so adjust NR_FREE_PAGES
> +	 * based on i. Do not confuse with 'allocated' which is the number of
>  	 * pages added to the pcp list.
>  	 */
>  	__mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
> +
>  	spin_unlock_irqrestore(&zone->lock, flags);
> +
> +	/*
> +	 * Pages are appended to the pcp list without checking to reduce the
> +	 * time holding the zone lock. Checking the appended pages happens right
> +	 * after the critical section while still holding the pcp lock.
> +	 */
> +	pos = list_first_entry(prev_tail, struct page, pcp_list);
> +	list_for_each_entry_safe_from(pos, n, list, pcp_list) {
> +		/*
> +		 * Count number of cma pages to batch update of
> +		 * NR_FREE_CMA_PAGES into a single function call.
> +		 */
> +		if (is_migrate_cma(get_pcppage_migratetype(pos)))
> +			cma_pages++;
> +
> +		if (unlikely(check_pcp_refill(pos, order))) {
> +			list_del(&pos->pcp_list);
> +			continue;
> +		}
> +
> +		allocated++;
> +	}
> +
> +	if (cma_pages > 0) {
> +		mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
> +				    -(cma_pages << order));
> +	}
> +
>  	return allocated;
>  }
>  

