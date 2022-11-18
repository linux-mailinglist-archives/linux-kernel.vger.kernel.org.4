Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CC862F75A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbiKRObJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241326AbiKRObC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:31:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C60627FE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:31:00 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CD3EE21EFB;
        Fri, 18 Nov 2022 14:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1668781858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p5HxxiDG0eqNrAIBu00sqo6F9PU57FyKSnnHnLC7aD0=;
        b=3ESN/ayvAFKjCC0eKwke3jc86KDQhE/9CpOZUbBwdp9d4slLrRVVcVTEzc39pur0yKzA0M
        zxv3Bo5W25gSbArpRoNoZUvzYr7sIHD+MLLJ7WqL02aTv5VS/l/5xmJXSFP0c094s6BJs0
        Xp4AUtZl0zd/4zqgG6Yos9W6y/AYLzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1668781858;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p5HxxiDG0eqNrAIBu00sqo6F9PU57FyKSnnHnLC7aD0=;
        b=PwOfhWXHL6M0JBTPpJRBePeMZbXNd3el1wW0PmGotABPLxnsn9RgI5yFxRsagxcYKvXlJB
        gILyfu4NdcWzMXBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B50461345B;
        Fri, 18 Nov 2022 14:30:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id I4wRKyGXd2OjSgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 18 Nov 2022 14:30:57 +0000
Message-ID: <f9acd363-bf53-c582-78ec-347fd7ec5c37@suse.cz>
Date:   Fri, 18 Nov 2022 15:30:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] mm/page_alloc: Leave IRQs enabled for per-cpu page
 allocations
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20221118101714.19590-1-mgorman@techsingularity.net>
 <20221118101714.19590-3-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221118101714.19590-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 11:17, Mel Gorman wrote:
> The pcp_spin_lock_irqsave protecting the PCP lists is IRQ-safe as a task
> allocating from the PCP must not re-enter the allocator from IRQ context.
> In each instance where IRQ-reentrancy is possible, the lock is acquired
> using pcp_spin_trylock_irqsave() even though IRQs are disabled and
> re-entrancy is impossible.
> 
> Demote the lock to pcp_spin_lock avoids an IRQ disable/enable in the common
> case at the cost of some IRQ allocations taking a slower path. If the PCP
> lists need to be refilled, the zone lock still needs to disable IRQs but
> that will only happen on PCP refill and drain. If an IRQ is raised when
> a PCP allocation is in progress, the trylock will fail and fallback to
> using the buddy lists directly. Note that this may not be a universal win
> if an interrupt-intensive workload also allocates heavily from interrupt
> context and contends heavily on the zone->lock as a result.
> 
> [yuzhao@google.com: Reported lockdep issue on IO completion from softirq]
> [hughd@google.com: Fix list corruption, lock improvements, micro-optimsations]
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Some nits below:

> @@ -3516,10 +3485,10 @@ void free_unref_page(struct page *page, unsigned int order)
>   */
>  void free_unref_page_list(struct list_head *list)
>  {
> +	unsigned long __maybe_unused UP_flags;
>  	struct page *page, *next;
>  	struct per_cpu_pages *pcp = NULL;
>  	struct zone *locked_zone = NULL;
> -	unsigned long flags;
>  	int batch_count = 0;
>  	int migratetype;
>  
> @@ -3550,11 +3519,26 @@ void free_unref_page_list(struct list_head *list)
>  
>  		/* Different zone, different pcp lock. */
>  		if (zone != locked_zone) {
> -			if (pcp)
> -				pcp_spin_unlock_irqrestore(pcp, flags);
> +			if (pcp) {
> +				pcp_spin_unlock(pcp);
> +				pcp_trylock_finish(UP_flags);
> +			}
>  
> +			/*
> +			 * trylock is necessary as pages may be getting freed
> +			 * from IRQ or SoftIRQ context after an IO completion.
> +			 */
> +			pcp_trylock_prepare(UP_flags);
> +			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
> +			if (!pcp) {

Perhaps use unlikely() here?

> +				pcp_trylock_finish(UP_flags);
> +				free_one_page(zone, page, page_to_pfn(page),
> +					      0, migratetype, FPI_NONE);

Not critical for correctness, but the migratepage here might be stale and we
should do get_pcppage_migratetype(page);

> +				locked_zone = NULL;
> +				continue;
> +			}
>  			locked_zone = zone;
> -			pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
> +			batch_count = 0;
>  		}
>  
>  		/*
> @@ -3569,18 +3553,23 @@ void free_unref_page_list(struct list_head *list)
>  		free_unref_page_commit(zone, pcp, page, migratetype, 0);
>  
>  		/*
> -		 * Guard against excessive IRQ disabled times when we get
> -		 * a large list of pages to free.
> +		 * Guard against excessive lock hold times when freeing
> +		 * a large list of pages. Lock will be reacquired if
> +		 * necessary on the next iteration.
>  		 */
>  		if (++batch_count == SWAP_CLUSTER_MAX) {
> -			pcp_spin_unlock_irqrestore(pcp, flags);
> +			pcp_spin_unlock(pcp);
> +			pcp_trylock_finish(UP_flags);
>  			batch_count = 0;
> -			pcp = pcp_spin_lock_irqsave(locked_zone->per_cpu_pageset, flags);
> +			pcp = NULL;
> +			locked_zone = NULL;

AFAICS if this block was just "locked_zone = NULL;" then the existing code
would do the right thing.
Or maybe to have simpler code, just do batch_count++ here and
make the relocking check do
if (zone != locked_zone || batch_count == SWAP_CLUSTER_MAX)

>  		}
>  	}
>  
> -	if (pcp)
> -		pcp_spin_unlock_irqrestore(pcp, flags);
> +	if (pcp) {
> +		pcp_spin_unlock(pcp);
> +		pcp_trylock_finish(UP_flags);
> +	}
>  }
>  
>  /*

