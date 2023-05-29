Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6727D714ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 19:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjE2RLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 13:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE2RLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 13:11:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E5ABE
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 10:11:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A68B521A09;
        Mon, 29 May 2023 17:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685380295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jO1xGJcRzVWbUcR6oYzFMG+6EcknIhSs9EPGKkrNan8=;
        b=e+oQly1Ee9i8DBS2bgSe0OS12We3ksWrG41i7+jiLDIe7nkOnOVKB8GXlyIYZZgNJtSb2W
        RIumEcq1VGZCK/5dflW+mDlUJ3sfDuPPx2A05DwmZVhtIAH7LD/tdZ/GXQkJpPd5EhMVrD
        fMw7yhDkNfPluqvQaBaRW4+MPZbJL14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685380295;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jO1xGJcRzVWbUcR6oYzFMG+6EcknIhSs9EPGKkrNan8=;
        b=C79tMy4ll71V0DjCxTtggYvXXtP1J/GsgXiXIGef8WeOFZls54Pj364TR8ofn6HJLGQjWm
        MfwkpqBAUW3LmvDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BA8B1332D;
        Mon, 29 May 2023 17:11:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ew5NIcfcdGS9XgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 29 May 2023 17:11:35 +0000
Message-ID: <5f3ad5f3-780d-1ff7-5f97-0dc8b5611581@suse.cz>
Date:   Mon, 29 May 2023 19:11:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/5] mm: compaction: refactor __compaction_suitable()
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
References: <20230519123959.77335-1-hannes@cmpxchg.org>
 <20230519123959.77335-4-hannes@cmpxchg.org>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230519123959.77335-4-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/23 14:39, Johannes Weiner wrote:
> __compaction_suitable() is supposed to check for available migration
> targets. However, it also checks whether the operation was requested
> via /proc/sys/vm/compact_memory, and whether the original allocation
> request can already succeed. These don't apply to all callsites.
> 
> Move the checks out to the callers, so that later patches can deal
> with them one by one. No functional change intended.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

Note comment on compaction_suitable() still mentions COMPACT_SUCCESS, that
is no longer possible, so delete that line?
Also on closer look, both compaction_suitable() and __compaction_suitable()
could now simply return bool. The callers use it that way anyway. There
would just be some extra fiddling internally aroud the tracepoint.

> ---
>  include/linux/compaction.h |  4 +-
>  mm/compaction.c            | 78 ++++++++++++++++++++++++--------------
>  mm/vmscan.c                | 35 ++++++++++-------
>  3 files changed, 73 insertions(+), 44 deletions(-)
> 
> diff --git a/include/linux/compaction.h b/include/linux/compaction.h
> index 1f0328a2ba48..9f7cf3e1bf89 100644
> --- a/include/linux/compaction.h
> +++ b/include/linux/compaction.h
> @@ -90,7 +90,7 @@ extern enum compact_result try_to_compact_pages(gfp_t gfp_mask,
>  		struct page **page);
>  extern void reset_isolation_suitable(pg_data_t *pgdat);
>  extern enum compact_result compaction_suitable(struct zone *zone, int order,
> -		unsigned int alloc_flags, int highest_zoneidx);
> +					       int highest_zoneidx);
>  
>  extern void compaction_defer_reset(struct zone *zone, int order,
>  				bool alloc_success);
> @@ -108,7 +108,7 @@ static inline void reset_isolation_suitable(pg_data_t *pgdat)
>  }
>  
>  static inline enum compact_result compaction_suitable(struct zone *zone, int order,
> -					int alloc_flags, int highest_zoneidx)
> +						      int highest_zoneidx)
>  {
>  	return COMPACT_SKIPPED;
>  }
> diff --git a/mm/compaction.c b/mm/compaction.c
> index c9a4b6dffcf2..8f61cfa87c49 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -2206,24 +2206,10 @@ static enum compact_result compact_finished(struct compact_control *cc)
>  }
>  
>  static enum compact_result __compaction_suitable(struct zone *zone, int order,
> -					unsigned int alloc_flags,
>  					int highest_zoneidx,
>  					unsigned long wmark_target)
>  {
>  	unsigned long watermark;
> -
> -	if (is_via_compact_memory(order))
> -		return COMPACT_CONTINUE;
> -
> -	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> -	/*
> -	 * If watermarks for high-order allocation are already met, there
> -	 * should be no need for compaction at all.
> -	 */
> -	if (zone_watermark_ok(zone, order, watermark, highest_zoneidx,
> -								alloc_flags))
> -		return COMPACT_SUCCESS;
> -
>  	/*
>  	 * Watermarks for order-0 must be met for compaction to be able to
>  	 * isolate free pages for migration targets. This means that the
> @@ -2256,13 +2242,12 @@ static enum compact_result __compaction_suitable(struct zone *zone, int order,
>   *   COMPACT_CONTINUE - If compaction should run now
>   */
>  enum compact_result compaction_suitable(struct zone *zone, int order,
> -					unsigned int alloc_flags,
>  					int highest_zoneidx)
>  {
>  	enum compact_result ret;
>  	int fragindex;
>  
> -	ret = __compaction_suitable(zone, order, alloc_flags, highest_zoneidx,
> +	ret = __compaction_suitable(zone, order, highest_zoneidx,
>  				    zone_page_state(zone, NR_FREE_PAGES));
>  	/*
>  	 * fragmentation index determines if allocation failures are due to
> @@ -2306,7 +2291,16 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
>  	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
>  				ac->highest_zoneidx, ac->nodemask) {
>  		unsigned long available;
> -		enum compact_result compact_result;
> +		unsigned long watermark;
> +
> +		if (is_via_compact_memory(order))
> +			return true;
> +
> +		/* Allocation can already succeed, nothing to do */
> +		watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> +		if (zone_watermark_ok(zone, order, watermark,
> +				      ac->highest_zoneidx, alloc_flags))
> +			continue;
>  
>  		/*
>  		 * Do not consider all the reclaimable memory because we do not
> @@ -2316,9 +2310,8 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
>  		 */
>  		available = zone_reclaimable_pages(zone) / order;
>  		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
> -		compact_result = __compaction_suitable(zone, order, alloc_flags,
> -				ac->highest_zoneidx, available);
> -		if (compact_result == COMPACT_CONTINUE)
> +		if (__compaction_suitable(zone, order, ac->highest_zoneidx,
> +					  available) == COMPACT_CONTINUE)
>  			return true;
>  	}
>  
> @@ -2348,11 +2341,23 @@ compact_zone(struct compact_control *cc, struct capture_control *capc)
>  	INIT_LIST_HEAD(&cc->migratepages);
>  
>  	cc->migratetype = gfp_migratetype(cc->gfp_mask);
> -	ret = compaction_suitable(cc->zone, cc->order, cc->alloc_flags,
> -							cc->highest_zoneidx);
> -	/* Compaction is likely to fail */
> -	if (ret == COMPACT_SUCCESS || ret == COMPACT_SKIPPED)
> -		return ret;
> +
> +	if (!is_via_compact_memory(cc->order)) {
> +		unsigned long watermark;
> +
> +		/* Allocation can already succeed, nothing to do */
> +		watermark = wmark_pages(cc->zone,
> +					cc->alloc_flags & ALLOC_WMARK_MASK);
> +		if (zone_watermark_ok(cc->zone, cc->order, watermark,
> +				      cc->highest_zoneidx, cc->alloc_flags))
> +			return COMPACT_SUCCESS;
> +
> +		ret = compaction_suitable(cc->zone, cc->order,
> +					  cc->highest_zoneidx);
> +		/* Compaction is likely to fail */
> +		if (ret == COMPACT_SKIPPED)
> +			return ret;
> +	}
>  
>  	/*
>  	 * Clear pageblock skip if there were failures recently and compaction
> @@ -2845,7 +2850,16 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
>  		if (!populated_zone(zone))
>  			continue;
>  
> -		if (compaction_suitable(zone, pgdat->kcompactd_max_order, 0,
> +		if (is_via_compact_memory(pgdat->kcompactd_max_order))
> +			return true;
> +
> +		/* Allocation can already succeed, check other zones */
> +		if (zone_watermark_ok(zone, pgdat->kcompactd_max_order,
> +				      min_wmark_pages(zone),
> +				      highest_zoneidx, 0))
> +			continue;
> +
> +		if (compaction_suitable(zone, pgdat->kcompactd_max_order,
>  					highest_zoneidx) == COMPACT_CONTINUE)
>  			return true;
>  	}
> @@ -2883,10 +2897,18 @@ static void kcompactd_do_work(pg_data_t *pgdat)
>  		if (compaction_deferred(zone, cc.order))
>  			continue;
>  
> -		if (compaction_suitable(zone, cc.order, 0, zoneid) !=
> -							COMPACT_CONTINUE)
> +		if (is_via_compact_memory(cc.order))
> +			goto compact;
> +
> +		/* Allocation can already succeed, nothing to do */
> +		if (zone_watermark_ok(zone, cc.order,
> +				      min_wmark_pages(zone), zoneid, 0))
>  			continue;
>  
> +		if (compaction_suitable(zone, cc.order,
> +					zoneid) != COMPACT_CONTINUE)
> +			continue;
> +compact:
>  		if (kthread_should_stop())
>  			return;
>  
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index d257916f39e5..c9c0f3e081f5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6397,14 +6397,17 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
>  		if (!managed_zone(zone))
>  			continue;
>  
> -		switch (compaction_suitable(zone, sc->order, 0, sc->reclaim_idx)) {
> -		case COMPACT_SUCCESS:
> -		case COMPACT_CONTINUE:
> +		if (sc->order == -1) /* is_via_compact_memory() */
> +			return false;
> +
> +		/* Allocation can already succeed, nothing to do */
> +		if (zone_watermark_ok(zone, sc->order, min_wmark_pages(zone),
> +				      sc->reclaim_idx, 0))
> +			return false;
> +
> +		if (compaction_suitable(zone, sc->order,
> +					sc->reclaim_idx) == COMPACT_CONTINUE)
>  			return false;
> -		default:
> -			/* check next zone */
> -			;
> -		}
>  	}
>  
>  	/*
> @@ -6592,16 +6595,20 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
>  static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
>  {
>  	unsigned long watermark;
> -	enum compact_result suitable;
>  
> -	suitable = compaction_suitable(zone, sc->order, 0, sc->reclaim_idx);
> -	if (suitable == COMPACT_SUCCESS)
> -		/* Allocation should succeed already. Don't reclaim. */
> +	if (sc->order == -1) /* is_via_compact_memory() */
> +		goto suitable;
> +
> +	/* Allocation can already succeed, nothing to do */
> +	if (zone_watermark_ok(zone, sc->order, min_wmark_pages(zone),
> +			      sc->reclaim_idx, 0))
>  		return true;
> -	if (suitable == COMPACT_SKIPPED)
> -		/* Compaction cannot yet proceed. Do reclaim. */
> -		return false;
>  
> +	/* Compaction cannot yet proceed. Do reclaim. */
> +	if (compaction_suitable(zone, sc->order,
> +				sc->reclaim_idx) == COMPACT_SKIPPED)
> +		return false;
> +suitable:
>  	/*
>  	 * Compaction is already possible, but it takes time to run and there
>  	 * are potentially other callers using the pages just freed. So proceed

