Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68F5643BB5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 04:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiLFDOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 22:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbiLFDOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 22:14:30 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3ED26107
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 19:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670296469; x=1701832469;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=QTObGhPP9rmloIJIOIBZ1rTMLO7GqbM4fHVpMFX+cBw=;
  b=lEc8u9e4oOCuhHM/2Z5rY6FBUQHizRbpNwZlXWNw6kGcDmorxfe1O6/5
   /3/6vLTlws+qocpYlTOePxFl6gfnRepf8eP14bgLjJTvbMibNRnVK6Kx4
   6xBtjPdwdmUc9mYvX1ihqUERO4ORNujRj+byCcbqvu+jZhJSwI/QVTKju
   rtTMRLyPYFgO0PphPnhJxTPmkFDpv9BXFRj/Uk19b4aBaNW+NyI4ZzE45
   iw1U4mWz6S2bCFW1to3ZRopk0vfGKn1vs8BGmvWRxHKaseWBaM2enGucb
   jsrLchv8tZRrl3m0CB8421g7wS0vu9sZN6xlDnH12dTLmP5ieuDvuyA9d
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="296213916"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="296213916"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 19:14:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="891214969"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="891214969"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 19:14:26 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v3] [mm-unstable] mm: Fix memcg reclaim on memory tiered
 systems
References: <20221206023406.3182800-1-almasrymina@google.com>
Date:   Tue, 06 Dec 2022 11:13:37 +0800
In-Reply-To: <20221206023406.3182800-1-almasrymina@google.com> (Mina Almasry's
        message of "Mon, 5 Dec 2022 18:34:05 -0800")
Message-ID: <87wn75dy1q.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mina Almasry <almasrymina@google.com> writes:

> commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> reclaim"") enabled demotion in memcg reclaim, which is the right thing
> to do, however, it introduced a regression in the behavior of
> try_to_free_mem_cgroup_pages().
>
> The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
> reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
> of the cgroup should reduce by nr_pages. The callers expect
> try_to_free_mem_cgroup_pages() to also return the number of pages
> reclaimed, not demoted.
>
> However, what try_to_free_mem_cgroup_pages() actually does is it
> unconditionally counts demoted pages as reclaimed pages. So in practnice
> when it is called it will often demote nr_pages and return the number of
> demoted pages to the caller. Demoted pages don't lower the memcg usage,
> and so try_to_free_mem_cgroup_pages() is not actually doing what the
> callers want it to do.
>
> Various things work suboptimally on memory tiered systems or don't work
> at all due to this:
>
> - memory.high enforcement likely doesn't work (it just demotes nr_pages
>   instead of lowering the memcg usage by nr_pages).
> - try_charge_memcg() will keep retrying the charge while
>   try_to_free_mem_cgroup_pages() is just demoting pages and not actually
>   making any room for the charge.
> - memory.reclaim has a wonky interface. It advertises to the user it
>   reclaims the provided amount but it will actually often demote that
>   amount.
>
> There may be more effects to this issue.
>
> To fix these issues I propose shrink_folio_list() to only count pages
> demoted from inside of sc->nodemask to outside of sc->nodemask as
> 'reclaimed'.
>
> For callers such as reclaim_high() or try_charge_memcg() that set
> sc->nodemask to NULL, try_to_free_mem_cgroup_pages() will try to
> actually reclaim nr_pages and return the number of pages reclaimed. No
> demoted pages would count towards the nr_pages requirement.
>
> For callers such as memory_reclaim() that set sc->nodemask,
> try_to_free_mem_cgroup_pages() will free nr_pages from that nodemask
> with either reclaim or demotion.
>
> Tested this change using memory.reclaim interface. I set up a test case where
> I allocate 500m in a cgroup, and then do:
>
>     echo "50m" > memory.reclaim
>
> Without this fix, my kernel demotes 70mb and reclaims 4 mb
> (memory.current is reduced by about 4mb).
>
> With this fix, my kernel demotes all memory possible and reclaims 60mb
> (memory.current is reduced by about 60mb).
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> ---
>
> Changes in v3:
> - Reverted back to v1 implementation: "try to demote but don't count
>   demoted pages unless they are demoted to outside the nodemask" as Ying
>   suggested.
> - Made sure demotions that fall back to non next_demotion_target() are
>   not counted as Wei suggested.
> - Updated comment in shrink_folio_list() as Ying suggested.
> - Added before/after for the test case in commit message since Ying
>   asked.
> - Fixed call sites that don't provide sc->nodemask but expect demotion
>   from a specific node as Ying pointed out.
>
> Cc: weixugc@google.com
> Cc: ying.huang@intel.com
>
> This is developed on top of mm-unstable largely because I want the
> solution to be compatible with the recently added nodes= arg on
> mm-unstable.
> ---
>  mm/vmscan.c | 91 +++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 78 insertions(+), 13 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2b42ac9ad755..f324e80395c3 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1555,13 +1555,18 @@ static void folio_check_dirty_writeback(struct folio *folio,
>  		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
>  }
>
> +struct demotion_control {
> +	struct migration_target_control *mtc;
> +	nodemask_t *demote_from_nodemask;
> +	unsigned long nr_demoted_outside_nodemask;
> +};
> +
>  static struct page *alloc_demote_page(struct page *page, unsigned long private)
>  {
>  	struct page *target_page;
>  	nodemask_t *allowed_mask;
> -	struct migration_target_control *mtc;
> -
> -	mtc = (struct migration_target_control *)private;
> +	struct demotion_control *dc = (struct demotion_control *)private;
> +	struct migration_target_control *mtc = dc->mtc;
>
>  	allowed_mask = mtc->nmask;
>  	/*
> @@ -1576,13 +1581,31 @@ static struct page *alloc_demote_page(struct page *page, unsigned long private)
>  	mtc->nmask = NULL;
>  	mtc->gfp_mask |= __GFP_THISNODE;
>  	target_page = alloc_migration_target(page, (unsigned long)mtc);
> -	if (target_page)
> +	if (!target_page) {
> +		mtc->gfp_mask &= ~__GFP_THISNODE;
> +		mtc->nmask = allowed_mask;
> +		target_page = alloc_migration_target(page, (unsigned long)mtc);
> +	}
> +
> +	if (!target_page)
>  		return target_page;
>
> -	mtc->gfp_mask &= ~__GFP_THISNODE;
> -	mtc->nmask = allowed_mask;
> +	if (dc->demote_from_nodemask &&
> +	    !node_isset(page_to_nid(target_page), *dc->demote_from_nodemask))

Use mtc->nid directly?

> +		dc->nr_demoted_outside_nodemask++;
>
> -	return alloc_migration_target(page, (unsigned long)mtc);
> +	return target_page;
> +}
> +
> +void free_demote_page(struct page *page, unsigned long private)
> +{
> +	struct demotion_control *dc = (struct demotion_control *)private;
> +
> +	if (dc->demote_from_nodemask &&
> +	    !node_isset(page_to_nid(page), *dc->demote_from_nodemask))

ditto

> +		dc->nr_demoted_outside_nodemask--;
> +
> +	folio_put(page_folio(page));
>  }
>
>  /*
> @@ -1590,7 +1613,8 @@ static struct page *alloc_demote_page(struct page *page, unsigned long private)
>   * Folios which are not demoted are left on @demote_folios.
>   */
>  static unsigned int demote_folio_list(struct list_head *demote_folios,
> -				     struct pglist_data *pgdat)
> +				      struct pglist_data *pgdat,
> +				      nodemask_t *nodemask)
>  {
>  	int target_nid = next_demotion_node(pgdat->node_id);
>  	unsigned int nr_succeeded;
> @@ -1608,6 +1632,12 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
>  		.nmask = &allowed_mask
>  	};
>
> +	struct demotion_control dc = {
> +		.mtc = &mtc,
> +		.demote_from_nodemask = nodemask,
> +		.nr_demoted_outside_nodemask = 0,
> +	};
> +
>  	if (list_empty(demote_folios))
>  		return 0;
>
> @@ -1617,13 +1647,13 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
>  	node_get_allowed_targets(pgdat, &allowed_mask);
>
>  	/* Demotion ignores all cpuset and mempolicy settings */
> -	migrate_pages(demote_folios, alloc_demote_page, NULL,
> -		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
> +	migrate_pages(demote_folios, alloc_demote_page, free_demote_page,
> +		      (unsigned long)&dc, MIGRATE_ASYNC, MR_DEMOTION,
>  		      &nr_succeeded);
>
>  	__count_vm_events(PGDEMOTE_KSWAPD + reclaimer_offset(), nr_succeeded);
>
> -	return nr_succeeded;
> +	return dc.nr_demoted_outside_nodemask;
>  }
>
>  static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
> @@ -1643,7 +1673,12 @@ static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
>  }
>
>  /*
> - * shrink_folio_list() returns the number of reclaimed pages
> + * shrink_folio_list() returns the number of reclaimed pages.
> + *
> + * Demoted pages are counted as reclaimed iff:
> + *   (a) sc->nodemask arg is provided.
> + *   (b) page has been demoted from a node inside sc->nodemask to a node
> + *   outside sc->nodemask.
>   */
>  static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		struct pglist_data *pgdat, struct scan_control *sc,
> @@ -1653,6 +1688,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  	LIST_HEAD(free_folios);
>  	LIST_HEAD(demote_folios);
>  	unsigned int nr_reclaimed = 0;
> +	unsigned int nr_demoted_outside_nodemask = 0;
>  	unsigned int pgactivate = 0;
>  	bool do_demote_pass;
>  	struct swap_iocb *plug = NULL;
> @@ -2085,7 +2121,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  	/* 'folio_list' is always empty here */
>
>  	/* Migrate folios selected for demotion */
> -	nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
> +	nr_demoted_outside_nodemask =
> +		demote_folio_list(&demote_folios, pgdat, sc->nodemask);
> +
> +	if (sc->nodemask)
> +		nr_reclaimed += nr_demoted_outside_nodemask;
> +
>  	/* Folios that could not be demoted are still in @demote_folios */
>  	if (!list_empty(&demote_folios)) {
>  		/* Folios which weren't demoted go back on @folio_list */
> @@ -2130,9 +2171,11 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  					   struct list_head *folio_list)
>  {
> +	nodemask_t nodemask = NODE_MASK_NONE;

Is it necessary for us to use NODEMASK_ALLOC/NODEMASK_FREE to save stack space?

Best Regards,
Huang, Ying

>  	struct scan_control sc = {
>  		.gfp_mask = GFP_KERNEL,
>  		.may_unmap = 1,
> +		.nodemask = &nodemask
>  	};
>  	struct reclaim_stat stat;
>  	unsigned int nr_reclaimed;
> @@ -2140,6 +2183,12 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  	LIST_HEAD(clean_folios);
>  	unsigned int noreclaim_flag;
>
> +	/*
> +	 * Set the nodemask in sc to indicate to shrink_folio_list() that we're
> +	 * looking for reclaim from this node.
> +	 */
> +	node_set(zone->zone_pgdat->node_id, nodemask);
> +
>  	list_for_each_entry_safe(folio, next, folio_list, lru) {
>  		if (!folio_test_hugetlb(folio) && folio_is_file_lru(folio) &&
>  		    !folio_test_dirty(folio) && !__folio_test_movable(folio) &&
> @@ -7031,12 +7080,20 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
>  	unsigned long zone_boosts[MAX_NR_ZONES] = { 0, };
>  	bool boosted;
>  	struct zone *zone;
> +	nodemask_t nodemask = NODE_MASK_NONE;
>  	struct scan_control sc = {
>  		.gfp_mask = GFP_KERNEL,
>  		.order = order,
>  		.may_unmap = 1,
> +		.nodemask = &nodemask,
>  	};
>
> +	/*
> +	 * Set the nodemask in sc to indicate to kswapd_shrink_node() that we're
> +	 * looking for reclaim from this node.
> +	 */
> +	node_set(pgdat->node_id, nodemask);
> +
>  	set_task_reclaim_state(current, &sc.reclaim_state);
>  	psi_memstall_enter(&pflags);
>  	__fs_reclaim_acquire(_THIS_IP_);
> @@ -7642,6 +7699,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
>  	const unsigned long nr_pages = 1 << order;
>  	struct task_struct *p = current;
>  	unsigned int noreclaim_flag;
> +	nodemask_t nodemask = NODE_MASK_NONE;
>  	struct scan_control sc = {
>  		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
>  		.gfp_mask = current_gfp_context(gfp_mask),
> @@ -7651,9 +7709,16 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
>  		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
>  		.may_swap = 1,
>  		.reclaim_idx = gfp_zone(gfp_mask),
> +		.nodemask = &nodemask,
>  	};
>  	unsigned long pflags;
>
> +	/*
> +	 * Set the nodemask in sc to indicate to shrink_node() that we're
> +	 * looking for reclaim from this node.
> +	 */
> +	node_set(pgdat->node_id, nodemask);
> +
>  	trace_mm_vmscan_node_reclaim_begin(pgdat->node_id, order,
>  					   sc.gfp_mask);
>
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
