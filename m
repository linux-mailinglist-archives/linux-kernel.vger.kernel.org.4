Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F9D64924A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 05:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiLKD7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 22:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLKD7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 22:59:53 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8211115F
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 19:59:51 -0800 (PST)
Received: from dggpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NV9wv5wnwz15MPT;
        Sun, 11 Dec 2022 11:58:55 +0800 (CST)
Received: from [10.174.178.178] (10.174.178.178) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sun, 11 Dec 2022 11:59:49 +0800
Message-ID: <ce630960-386d-8bde-2fa8-2fc3532c8da7@huawei.com>
Date:   Sun, 11 Dec 2022 11:59:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [PATCH mm-unstable v1 3/8] mm: multi-gen LRU: remove eviction
 fairness safeguard
To:     Yu Zhao <yuzhao@google.com>
CC:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20221201223923.873696-1-yuzhao@google.com>
 <20221201223923.873696-4-yuzhao@google.com>
From:   Chen Wandun <chenwandun@huawei.com>
In-Reply-To: <20221201223923.873696-4-yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.178]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/12/2 6:39, Yu Zhao 写道:
> Recall that the eviction consumes the oldest generation: first it
> bucket-sorts folios whose gen counters were updated by the aging and
> reclaims the rest; then it increments lrugen->min_seq.
>
> The current eviction fairness safeguard for global reclaim has a
> dilemma: when there are multiple eligible memcgs, should it continue
> or stop upon meeting the reclaim goal? If it continues, it overshoots
> and increases direct reclaim latency; if it stops, it loses fairness
> between memcgs it has taken memory away from and those it has yet to.
>
> With memcg LRU, the eviction, while ensuring eventual fairness, will
> stop upon meeting its goal. Therefore the current eviction fairness
> safeguard for global reclaim will not be needed.
>
> Note that memcg LRU only applies to global reclaim. For memcg reclaim,
> the eviction will continue, even if it is overshooting. This becomes
> unconditional due to code simplification.
>
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> ---
>   mm/vmscan.c | 81 +++++++++++++++--------------------------------------
>   1 file changed, 23 insertions(+), 58 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ebab1ec3d400..d714a777c88b 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -449,6 +449,11 @@ static bool cgroup_reclaim(struct scan_control *sc)
>   	return sc->target_mem_cgroup;
>   }
>   
> +static bool global_reclaim(struct scan_control *sc)
> +{
> +	return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->target_mem_cgroup);
> +}
> +
>   /**
>    * writeback_throttling_sane - is the usual dirty throttling mechanism available?
>    * @sc: scan_control in question
> @@ -499,6 +504,11 @@ static bool cgroup_reclaim(struct scan_control *sc)
>   	return false;
>   }
>   
> +static bool global_reclaim(struct scan_control *sc)
> +{
> +	return true;
> +}
> +
>   static bool writeback_throttling_sane(struct scan_control *sc)
>   {
>   	return true;
> @@ -4991,8 +5001,7 @@ static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int sw
>   	return scanned;
>   }
>   
> -static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness,
> -			bool *need_swapping)
> +static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness)
>   {
>   	int type;
>   	int scanned;
> @@ -5081,9 +5090,6 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
>   		goto retry;
>   	}
>   
> -	if (need_swapping && type == LRU_GEN_ANON)
> -		*need_swapping = true;
> -
>   	return scanned;
>   }
>   
> @@ -5122,67 +5128,26 @@ static unsigned long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *
>   	return min_seq[!can_swap] + MIN_NR_GENS <= max_seq ? nr_to_scan : 0;
>   }
>   
> -static bool should_abort_scan(struct lruvec *lruvec, unsigned long seq,
> -			      struct scan_control *sc, bool need_swapping)
> +static unsigned long get_nr_to_reclaim(struct scan_control *sc)
>   {
> -	int i;
> -	DEFINE_MAX_SEQ(lruvec);
> +	/* don't abort memcg reclaim to ensure fairness */
> +	if (!global_reclaim(sc))
> +		return -1;
The return type of the function is unsigned long. Does the return of - 1 
mean something else?
>   
> -	if (!current_is_kswapd()) {
> -		/* age each memcg at most once to ensure fairness */
> -		if (max_seq - seq > 1)
> -			return true;
> +	/* discount the previous progress for kswapd */
> +	if (current_is_kswapd())
> +		return sc->nr_to_reclaim + sc->last_reclaimed;
>   
> -		/* over-swapping can increase allocation latency */
> -		if (sc->nr_reclaimed >= sc->nr_to_reclaim && need_swapping)
> -			return true;
> -
> -		/* give this thread a chance to exit and free its memory */
> -		if (fatal_signal_pending(current)) {
> -			sc->nr_reclaimed += MIN_LRU_BATCH;
> -			return true;
> -		}
> -
> -		if (cgroup_reclaim(sc))
> -			return false;
> -	} else if (sc->nr_reclaimed - sc->last_reclaimed < sc->nr_to_reclaim)
> -		return false;
> -
> -	/* keep scanning at low priorities to ensure fairness */
> -	if (sc->priority > DEF_PRIORITY - 2)
> -		return false;
> -
> -	/*
> -	 * A minimum amount of work was done under global memory pressure. For
> -	 * kswapd, it may be overshooting. For direct reclaim, the allocation
> -	 * may succeed if all suitable zones are somewhat safe. In either case,
> -	 * it's better to stop now, and restart later if necessary.
> -	 */
> -	for (i = 0; i <= sc->reclaim_idx; i++) {
> -		unsigned long wmark;
> -		struct zone *zone = lruvec_pgdat(lruvec)->node_zones + i;
> -
> -		if (!managed_zone(zone))
> -			continue;
> -
> -		wmark = current_is_kswapd() ? high_wmark_pages(zone) : low_wmark_pages(zone);
> -		if (wmark > zone_page_state(zone, NR_FREE_PAGES))
> -			return false;
> -	}
> -
> -	sc->nr_reclaimed += MIN_LRU_BATCH;
> -
> -	return true;
> +	return max(sc->nr_to_reclaim, compact_gap(sc->order));
>   }
>   
>   static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
>   {
>   	struct blk_plug plug;
>   	bool need_aging = false;
> -	bool need_swapping = false;
>   	unsigned long scanned = 0;
>   	unsigned long reclaimed = sc->nr_reclaimed;
> -	DEFINE_MAX_SEQ(lruvec);
> +	unsigned long nr_to_reclaim = get_nr_to_reclaim(sc);
>   
>   	lru_add_drain();
>   
> @@ -5206,7 +5171,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
>   		if (!nr_to_scan)
>   			goto done;
>   
> -		delta = evict_folios(lruvec, sc, swappiness, &need_swapping);
> +		delta = evict_folios(lruvec, sc, swappiness);
>   		if (!delta)
>   			goto done;
>   
> @@ -5214,7 +5179,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
>   		if (scanned >= nr_to_scan)
>   			break;
>   
> -		if (should_abort_scan(lruvec, max_seq, sc, need_swapping))
> +		if (sc->nr_reclaimed >= nr_to_reclaim)
>   			break;
>   
>   		cond_resched();
> @@ -5661,7 +5626,7 @@ static int run_eviction(struct lruvec *lruvec, unsigned long seq, struct scan_co
>   		if (sc->nr_reclaimed >= nr_to_reclaim)
>   			return 0;
>   
> -		if (!evict_folios(lruvec, sc, swappiness, NULL))
> +		if (!evict_folios(lruvec, sc, swappiness))
>   			return 0;
>   
>   		cond_resched();

