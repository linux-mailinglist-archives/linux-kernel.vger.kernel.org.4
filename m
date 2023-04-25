Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F29E6EDA86
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 05:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjDYDNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 23:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjDYDNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 23:13:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DEFA8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 20:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682392415; x=1713928415;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=+d2IJmNCS85jvw/d/zpzihqKRQR4ygfmq9/yqpHotHQ=;
  b=PpkNEZg6phrn01wsrkLA5P2+UfNGHE9Us0rKJNHG/OV5O2VrXEmWeOdj
   taDHsBSbuLAL7nY09Q+iOUr+3iT29AlsM3aFGp3j4xlYRQ3tidTVOAIDu
   PSoOo3OE7Hi6FMVZEarZTMeWHL3wyDhGOsvFohDg4z64eNtyeFLBoNZlo
   WT0+94KQoLDYvAMdFkmdBSedSzWy+HmaAsRxy4ssYRaCNt7bb3Cp6sSlp
   RhJG2IFq+3Ws2zITLzUdUZ8KcA17j44/IKMcK7GTmQ62vCodYAjN600Pf
   nE8k+mJaNSIKHuN0OjSVLY5lNENU01cxaUDrPf6ot1G/VPvxUCMa5vHjj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="345389935"
X-IronPort-AV: E=Sophos;i="5.99,224,1677571200"; 
   d="scan'208";a="345389935"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 20:13:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="757937745"
X-IronPort-AV: E=Sophos;i="5.99,224,1677571200"; 
   d="scan'208";a="757937745"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 20:13:32 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 20/26] mm: vmscan: use compaction_suitable() check
 in kswapd
References: <20230418191313.268131-1-hannes@cmpxchg.org>
        <20230418191313.268131-21-hannes@cmpxchg.org>
Date:   Tue, 25 Apr 2023 11:12:28 +0800
In-Reply-To: <20230418191313.268131-21-hannes@cmpxchg.org> (Johannes Weiner's
        message of "Tue, 18 Apr 2023 15:13:07 -0400")
Message-ID: <87a5ywfyeb.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner <hannes@cmpxchg.org> writes:

> Kswapd currently bails on higher-order allocations with an open-coded
> check for whether it's reclaimed the compaction gap.
>
> compaction_suitable() is the customary interface to coordinate reclaim
> with compaction.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/vmscan.c | 67 ++++++++++++++++++-----------------------------------
>  1 file changed, 23 insertions(+), 44 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index ee8c8ca2e7b5..723705b9e4d9 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -6872,12 +6872,18 @@ static bool pgdat_balanced(pg_data_t *pgdat, int order, int highest_zoneidx)
>  		if (!managed_zone(zone))
>  			continue;
>  
> +		/* Allocation can succeed in any zone, done */
>  		if (sysctl_numa_balancing_mode & NUMA_BALANCING_MEMORY_TIERING)
>  			mark = wmark_pages(zone, WMARK_PROMO);
>  		else
>  			mark = high_wmark_pages(zone);
>  		if (zone_watermark_ok_safe(zone, order, mark, highest_zoneidx))
>  			return true;
> +
> +		/* Allocation can't succeed, but enough order-0 to compact */
> +		if (compaction_suitable(zone, order,
> +					highest_zoneidx) == COMPACT_CONTINUE)
> +			return true;

Should we check the following first?

        order > 0 && zone_watermark_ok_safe(zone, 0, mark, highest_zoneidx)

Best Regards,
Huang, Ying

>  	}
>  
>  	/*
> @@ -6968,16 +6974,6 @@ static bool kswapd_shrink_node(pg_data_t *pgdat,
>  	 */
>  	shrink_node(pgdat, sc);
>  
> -	/*
> -	 * Fragmentation may mean that the system cannot be rebalanced for
> -	 * high-order allocations. If twice the allocation size has been
> -	 * reclaimed then recheck watermarks only at order-0 to prevent
> -	 * excessive reclaim. Assume that a process requested a high-order
> -	 * can direct reclaim/compact.
> -	 */
> -	if (sc->order && sc->nr_reclaimed >= compact_gap(sc->order))
> -		sc->order = 0;
> -
>  	return sc->nr_scanned >= sc->nr_to_reclaim;
>  }
>  
> @@ -7018,15 +7014,13 @@ clear_reclaim_active(pg_data_t *pgdat, int highest_zoneidx)
>   * that are eligible for use by the caller until at least one zone is
>   * balanced.
>   *
> - * Returns the order kswapd finished reclaiming at.
> - *
>   * kswapd scans the zones in the highmem->normal->dma direction.  It skips
>   * zones which have free_pages > high_wmark_pages(zone), but once a zone is
>   * found to have free_pages <= high_wmark_pages(zone), any page in that zone
>   * or lower is eligible for reclaim until at least one usable zone is
>   * balanced.
>   */
> -static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> +static void balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>  {
>  	int i;
>  	unsigned long nr_soft_reclaimed;
> @@ -7226,14 +7220,6 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>  	__fs_reclaim_release(_THIS_IP_);
>  	psi_memstall_leave(&pflags);
>  	set_task_reclaim_state(current, NULL);
> -
> -	/*
> -	 * Return the order kswapd stopped reclaiming at as
> -	 * prepare_kswapd_sleep() takes it into account. If another caller
> -	 * entered the allocator slow path while kswapd was awake, order will
> -	 * remain at the higher level.
> -	 */
> -	return sc.order;
>  }
>  
>  /*
> @@ -7251,7 +7237,7 @@ static enum zone_type kswapd_highest_zoneidx(pg_data_t *pgdat,
>  	return curr_idx == MAX_NR_ZONES ? prev_highest_zoneidx : curr_idx;
>  }
>  
> -static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_order,
> +static void kswapd_try_to_sleep(pg_data_t *pgdat, int order,
>  				unsigned int highest_zoneidx)
>  {
>  	long remaining = 0;
> @@ -7269,7 +7255,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
>  	 * eligible zone balanced that it's also unlikely that compaction will
>  	 * succeed.
>  	 */
> -	if (prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
> +	if (prepare_kswapd_sleep(pgdat, order, highest_zoneidx)) {
>  		/*
>  		 * Compaction records what page blocks it recently failed to
>  		 * isolate pages from and skips them in the future scanning.
> @@ -7282,7 +7268,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
>  		 * We have freed the memory, now we should compact it to make
>  		 * allocation of the requested order possible.
>  		 */
> -		wakeup_kcompactd(pgdat, alloc_order, highest_zoneidx);
> +		wakeup_kcompactd(pgdat, order, highest_zoneidx);
>  
>  		remaining = schedule_timeout(HZ/10);
>  
> @@ -7296,8 +7282,8 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
>  					kswapd_highest_zoneidx(pgdat,
>  							highest_zoneidx));
>  
> -			if (READ_ONCE(pgdat->kswapd_order) < reclaim_order)
> -				WRITE_ONCE(pgdat->kswapd_order, reclaim_order);
> +			if (READ_ONCE(pgdat->kswapd_order) < order)
> +				WRITE_ONCE(pgdat->kswapd_order, order);
>  		}
>  
>  		finish_wait(&pgdat->kswapd_wait, &wait);
> @@ -7308,8 +7294,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
>  	 * After a short sleep, check if it was a premature sleep. If not, then
>  	 * go fully to sleep until explicitly woken up.
>  	 */
> -	if (!remaining &&
> -	    prepare_kswapd_sleep(pgdat, reclaim_order, highest_zoneidx)) {
> +	if (!remaining && prepare_kswapd_sleep(pgdat, order, highest_zoneidx)) {
>  		trace_mm_vmscan_kswapd_sleep(pgdat->node_id);
>  
>  		/*
> @@ -7350,8 +7335,7 @@ static void kswapd_try_to_sleep(pg_data_t *pgdat, int alloc_order, int reclaim_o
>   */
>  static int kswapd(void *p)
>  {
> -	unsigned int alloc_order, reclaim_order;
> -	unsigned int highest_zoneidx = MAX_NR_ZONES - 1;
> +	unsigned int order, highest_zoneidx;
>  	pg_data_t *pgdat = (pg_data_t *)p;
>  	struct task_struct *tsk = current;
>  	const struct cpumask *cpumask = cpumask_of_node(pgdat->node_id);
> @@ -7374,22 +7358,20 @@ static int kswapd(void *p)
>  	tsk->flags |= PF_MEMALLOC | PF_KSWAPD;
>  	set_freezable();
>  
> -	WRITE_ONCE(pgdat->kswapd_order, 0);
> +	order = 0;
> +	highest_zoneidx = MAX_NR_ZONES - 1;
> +	WRITE_ONCE(pgdat->kswapd_order, order);
>  	WRITE_ONCE(pgdat->kswapd_highest_zoneidx, MAX_NR_ZONES);
> +
>  	atomic_set(&pgdat->nr_writeback_throttled, 0);
> +
>  	for ( ; ; ) {
>  		bool ret;
>  
> -		alloc_order = reclaim_order = READ_ONCE(pgdat->kswapd_order);
> -		highest_zoneidx = kswapd_highest_zoneidx(pgdat,
> -							highest_zoneidx);
> -
> -kswapd_try_sleep:
> -		kswapd_try_to_sleep(pgdat, alloc_order, reclaim_order,
> -					highest_zoneidx);
> +		kswapd_try_to_sleep(pgdat, order, highest_zoneidx);
>  
>  		/* Read the new order and highest_zoneidx */
> -		alloc_order = READ_ONCE(pgdat->kswapd_order);
> +		order = READ_ONCE(pgdat->kswapd_order);
>  		highest_zoneidx = kswapd_highest_zoneidx(pgdat,
>  							highest_zoneidx);
>  		WRITE_ONCE(pgdat->kswapd_order, 0);
> @@ -7415,11 +7397,8 @@ static int kswapd(void *p)
>  		 * request (alloc_order).
>  		 */
>  		trace_mm_vmscan_kswapd_wake(pgdat->node_id, highest_zoneidx,
> -						alloc_order);
> -		reclaim_order = balance_pgdat(pgdat, alloc_order,
> -						highest_zoneidx);
> -		if (reclaim_order < alloc_order)
> -			goto kswapd_try_sleep;
> +					    order);
> +		balance_pgdat(pgdat, order, highest_zoneidx);
>  	}
>  
>  	tsk->flags &= ~(PF_MEMALLOC | PF_KSWAPD);
