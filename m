Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5134643C1E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 05:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiLFEPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 23:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLFEPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 23:15:42 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1F7BC2B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 20:15:40 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id i2so13107001vsc.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 20:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dj7bj7s2N2DRMLBZoVp/5SSfoND0SEldqQgP3dtmfSE=;
        b=sR8ZOppEdKACGQKI+m/lf7k9pj0JDJ5U6b0HzZtXcWTUtz+utBxWsZW7ughNXBAK53
         6Dj2mHadB6Rec+oC41SDOh2PZYoHx4DnEaLJS+jmnC7emU4ekwtwzTCjj57lqykOAF9Z
         vnPY8L9CuXaEjJ5XxIENtbYZxJlaboot0nwm/f1cMmAT6tFPOwWvEe0I6gZIgpBaGNPn
         qoX5OXJEif1fPuGZipFPksYuXC/AjqoVJJPnXT2RoL+B7QUdi5qZvNlCCF4WNZYCu77A
         XJZWd8yDJSCea12tTfwX4/v9O4Ud6jeEfv8X05dJQyTlcEUoN+7mtG6r3+OhvqHP+QDf
         AH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dj7bj7s2N2DRMLBZoVp/5SSfoND0SEldqQgP3dtmfSE=;
        b=zMhwUGMMXe51w+ULmFH9jwh/82HnpSBPm0ZKCv77Hy/qTld4zXdITMgwA37vaXtBee
         xRMP+BwNnOWuynlFTICUb3zXVjO/uqd4nUm1aqV2mjA8/mRPLWghZ7YK6ODecw0W/UrZ
         6Ixe9B+oV5mr2GkG6NH0OL9hL7N3uUMz57LB01iLaAYQ2EwFKL4tfq7w5TvG5V+3PCLd
         z9vd6mXr3+llN8yMNlLiFDD6RPuzN9HQmCKU1yHCKc/RSUkedxCmiON9JhIJOBGqSe+E
         MIaLMVyUlI337dTheO/bRSmv1cYe87xVORLr02liy3mUwUrwUrIxFAAAUlth+XVKTkpL
         68DQ==
X-Gm-Message-State: ANoB5pkWiJJdz4lFxbYgJ1B5BiOzll2BoYJT/tDwWlpnephM1Fb1H1B1
        S0lued+F9rXqsArCCsQXZoy8TuoA+BL+uvIQs6Ridw==
X-Google-Smtp-Source: AA0mqf497FUV/AaphX+85vZn+n5d1egSs4oaVbE5DJnYld3jxopQO0ccCy+n4mg5b7aqpMUj/7Jb0ilIZ7xjCXmm1cQ=
X-Received: by 2002:a67:ea04:0:b0:3a7:d7bc:c2e9 with SMTP id
 g4-20020a67ea04000000b003a7d7bcc2e9mr38009687vso.61.1670300139777; Mon, 05
 Dec 2022 20:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20221206023406.3182800-1-almasrymina@google.com> <87wn75dy1q.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87wn75dy1q.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 5 Dec 2022 20:15:28 -0800
Message-ID: <CAHS8izMxoP9u3=Xa7D_GzNDSyLCuj-pSGbJdsp8E_D+pWBgjhA@mail.gmail.com>
Subject: Re: [PATCH v3] [mm-unstable] mm: Fix memcg reclaim on memory tiered systems
To:     "Huang, Ying" <ying.huang@intel.com>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 5, 2022 at 7:14 PM Huang, Ying <ying.huang@intel.com> wrote:
>
> Mina Almasry <almasrymina@google.com> writes:
>
> > commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> > reclaim"") enabled demotion in memcg reclaim, which is the right thing
> > to do, however, it introduced a regression in the behavior of
> > try_to_free_mem_cgroup_pages().
> >
> > The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
> > reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
> > of the cgroup should reduce by nr_pages. The callers expect
> > try_to_free_mem_cgroup_pages() to also return the number of pages
> > reclaimed, not demoted.
> >
> > However, what try_to_free_mem_cgroup_pages() actually does is it
> > unconditionally counts demoted pages as reclaimed pages. So in practnice
> > when it is called it will often demote nr_pages and return the number of
> > demoted pages to the caller. Demoted pages don't lower the memcg usage,
> > and so try_to_free_mem_cgroup_pages() is not actually doing what the
> > callers want it to do.
> >
> > Various things work suboptimally on memory tiered systems or don't work
> > at all due to this:
> >
> > - memory.high enforcement likely doesn't work (it just demotes nr_pages
> >   instead of lowering the memcg usage by nr_pages).
> > - try_charge_memcg() will keep retrying the charge while
> >   try_to_free_mem_cgroup_pages() is just demoting pages and not actually
> >   making any room for the charge.
> > - memory.reclaim has a wonky interface. It advertises to the user it
> >   reclaims the provided amount but it will actually often demote that
> >   amount.
> >
> > There may be more effects to this issue.
> >
> > To fix these issues I propose shrink_folio_list() to only count pages
> > demoted from inside of sc->nodemask to outside of sc->nodemask as
> > 'reclaimed'.
> >
> > For callers such as reclaim_high() or try_charge_memcg() that set
> > sc->nodemask to NULL, try_to_free_mem_cgroup_pages() will try to
> > actually reclaim nr_pages and return the number of pages reclaimed. No
> > demoted pages would count towards the nr_pages requirement.
> >
> > For callers such as memory_reclaim() that set sc->nodemask,
> > try_to_free_mem_cgroup_pages() will free nr_pages from that nodemask
> > with either reclaim or demotion.
> >
> > Tested this change using memory.reclaim interface. I set up a test case where
> > I allocate 500m in a cgroup, and then do:
> >
> >     echo "50m" > memory.reclaim
> >
> > Without this fix, my kernel demotes 70mb and reclaims 4 mb
> > (memory.current is reduced by about 4mb).
> >
> > With this fix, my kernel demotes all memory possible and reclaims 60mb
> > (memory.current is reduced by about 60mb).
> >
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > Changes in v3:
> > - Reverted back to v1 implementation: "try to demote but don't count
> >   demoted pages unless they are demoted to outside the nodemask" as Ying
> >   suggested.
> > - Made sure demotions that fall back to non next_demotion_target() are
> >   not counted as Wei suggested.
> > - Updated comment in shrink_folio_list() as Ying suggested.
> > - Added before/after for the test case in commit message since Ying
> >   asked.
> > - Fixed call sites that don't provide sc->nodemask but expect demotion
> >   from a specific node as Ying pointed out.
> >
> > Cc: weixugc@google.com
> > Cc: ying.huang@intel.com
> >
> > This is developed on top of mm-unstable largely because I want the
> > solution to be compatible with the recently added nodes= arg on
> > mm-unstable.
> > ---
> >  mm/vmscan.c | 91 +++++++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 78 insertions(+), 13 deletions(-)
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 2b42ac9ad755..f324e80395c3 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -1555,13 +1555,18 @@ static void folio_check_dirty_writeback(struct folio *folio,
> >               mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
> >  }
> >
> > +struct demotion_control {
> > +     struct migration_target_control *mtc;
> > +     nodemask_t *demote_from_nodemask;
> > +     unsigned long nr_demoted_outside_nodemask;
> > +};
> > +
> >  static struct page *alloc_demote_page(struct page *page, unsigned long private)
> >  {
> >       struct page *target_page;
> >       nodemask_t *allowed_mask;
> > -     struct migration_target_control *mtc;
> > -
> > -     mtc = (struct migration_target_control *)private;
> > +     struct demotion_control *dc = (struct demotion_control *)private;
> > +     struct migration_target_control *mtc = dc->mtc;
> >
> >       allowed_mask = mtc->nmask;
> >       /*
> > @@ -1576,13 +1581,31 @@ static struct page *alloc_demote_page(struct page *page, unsigned long private)
> >       mtc->nmask = NULL;
> >       mtc->gfp_mask |= __GFP_THISNODE;
> >       target_page = alloc_migration_target(page, (unsigned long)mtc);
> > -     if (target_page)
> > +     if (!target_page) {
> > +             mtc->gfp_mask &= ~__GFP_THISNODE;
> > +             mtc->nmask = allowed_mask;
> > +             target_page = alloc_migration_target(page, (unsigned long)mtc);
> > +     }
> > +
> > +     if (!target_page)
> >               return target_page;
> >
> > -     mtc->gfp_mask &= ~__GFP_THISNODE;
> > -     mtc->nmask = allowed_mask;
> > +     if (dc->demote_from_nodemask &&
> > +         !node_isset(page_to_nid(target_page), *dc->demote_from_nodemask))
>
> Use mtc->nid directly?
>

mtc->nid is the next_demotion_node(). Wei's earlier comment is that
the page may be allocated anywhere on the get_allowed_targets(), not
necessarily the next_demotion_node(), so I don't think I can use
mtc->nid. I think I have to check on which node the page was allocated
as I'm doing here. Let me know if I missed something.

> > +             dc->nr_demoted_outside_nodemask++;
> >
> > -     return alloc_migration_target(page, (unsigned long)mtc);
> > +     return target_page;
> > +}
> > +
> > +void free_demote_page(struct page *page, unsigned long private)
> > +{
> > +     struct demotion_control *dc = (struct demotion_control *)private;
> > +
> > +     if (dc->demote_from_nodemask &&
> > +         !node_isset(page_to_nid(page), *dc->demote_from_nodemask))
>
> ditto
>
> > +             dc->nr_demoted_outside_nodemask--;
> > +
> > +     folio_put(page_folio(page));
> >  }
> >
> >  /*
> > @@ -1590,7 +1613,8 @@ static struct page *alloc_demote_page(struct page *page, unsigned long private)
> >   * Folios which are not demoted are left on @demote_folios.
> >   */
> >  static unsigned int demote_folio_list(struct list_head *demote_folios,
> > -                                  struct pglist_data *pgdat)
> > +                                   struct pglist_data *pgdat,
> > +                                   nodemask_t *nodemask)
> >  {
> >       int target_nid = next_demotion_node(pgdat->node_id);
> >       unsigned int nr_succeeded;
> > @@ -1608,6 +1632,12 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
> >               .nmask = &allowed_mask
> >       };
> >
> > +     struct demotion_control dc = {
> > +             .mtc = &mtc,
> > +             .demote_from_nodemask = nodemask,
> > +             .nr_demoted_outside_nodemask = 0,
> > +     };
> > +
> >       if (list_empty(demote_folios))
> >               return 0;
> >
> > @@ -1617,13 +1647,13 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
> >       node_get_allowed_targets(pgdat, &allowed_mask);
> >
> >       /* Demotion ignores all cpuset and mempolicy settings */
> > -     migrate_pages(demote_folios, alloc_demote_page, NULL,
> > -                   (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
> > +     migrate_pages(demote_folios, alloc_demote_page, free_demote_page,
> > +                   (unsigned long)&dc, MIGRATE_ASYNC, MR_DEMOTION,
> >                     &nr_succeeded);
> >
> >       __count_vm_events(PGDEMOTE_KSWAPD + reclaimer_offset(), nr_succeeded);
> >
> > -     return nr_succeeded;
> > +     return dc.nr_demoted_outside_nodemask;
> >  }
> >
> >  static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
> > @@ -1643,7 +1673,12 @@ static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
> >  }
> >
> >  /*
> > - * shrink_folio_list() returns the number of reclaimed pages
> > + * shrink_folio_list() returns the number of reclaimed pages.
> > + *
> > + * Demoted pages are counted as reclaimed iff:
> > + *   (a) sc->nodemask arg is provided.
> > + *   (b) page has been demoted from a node inside sc->nodemask to a node
> > + *   outside sc->nodemask.
> >   */
> >  static unsigned int shrink_folio_list(struct list_head *folio_list,
> >               struct pglist_data *pgdat, struct scan_control *sc,
> > @@ -1653,6 +1688,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> >       LIST_HEAD(free_folios);
> >       LIST_HEAD(demote_folios);
> >       unsigned int nr_reclaimed = 0;
> > +     unsigned int nr_demoted_outside_nodemask = 0;
> >       unsigned int pgactivate = 0;
> >       bool do_demote_pass;
> >       struct swap_iocb *plug = NULL;
> > @@ -2085,7 +2121,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> >       /* 'folio_list' is always empty here */
> >
> >       /* Migrate folios selected for demotion */
> > -     nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
> > +     nr_demoted_outside_nodemask =
> > +             demote_folio_list(&demote_folios, pgdat, sc->nodemask);
> > +
> > +     if (sc->nodemask)
> > +             nr_reclaimed += nr_demoted_outside_nodemask;
> > +
> >       /* Folios that could not be demoted are still in @demote_folios */
> >       if (!list_empty(&demote_folios)) {
> >               /* Folios which weren't demoted go back on @folio_list */
> > @@ -2130,9 +2171,11 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
> >  unsigned int reclaim_clean_pages_from_list(struct zone *zone,
> >                                          struct list_head *folio_list)
> >  {
> > +     nodemask_t nodemask = NODE_MASK_NONE;
>
> Is it necessary for us to use NODEMASK_ALLOC/NODEMASK_FREE to save stack space?
>

I can certainly use NODEMASK_ALLOC/NODEMASK_FREE if you'd like. I
think there are a few places that stack allocate nodemask_t already,
including one place I recently added in memory_reclaim(), so it
doesn't seem _necessary_ per say.

If you're asking my opinion, AFAICT it's not an issue. I think you
need > 32 numa nodes before nodemask_t becomes an array of size 2
longs on a 32-bit machine, and even then I think it's not a huge deal.
Up to you; I have no issue with converting to
NODEMASK_ALLOC/NODEMASK_FREE in v4.

> Best Regards,
> Huang, Ying
>
> >       struct scan_control sc = {
> >               .gfp_mask = GFP_KERNEL,
> >               .may_unmap = 1,
> > +             .nodemask = &nodemask
> >       };
> >       struct reclaim_stat stat;
> >       unsigned int nr_reclaimed;
> > @@ -2140,6 +2183,12 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
> >       LIST_HEAD(clean_folios);
> >       unsigned int noreclaim_flag;
> >
> > +     /*
> > +      * Set the nodemask in sc to indicate to shrink_folio_list() that we're
> > +      * looking for reclaim from this node.
> > +      */
> > +     node_set(zone->zone_pgdat->node_id, nodemask);
> > +
> >       list_for_each_entry_safe(folio, next, folio_list, lru) {
> >               if (!folio_test_hugetlb(folio) && folio_is_file_lru(folio) &&
> >                   !folio_test_dirty(folio) && !__folio_test_movable(folio) &&
> > @@ -7031,12 +7080,20 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
> >       unsigned long zone_boosts[MAX_NR_ZONES] = { 0, };
> >       bool boosted;
> >       struct zone *zone;
> > +     nodemask_t nodemask = NODE_MASK_NONE;
> >       struct scan_control sc = {
> >               .gfp_mask = GFP_KERNEL,
> >               .order = order,
> >               .may_unmap = 1,
> > +             .nodemask = &nodemask,
> >       };
> >
> > +     /*
> > +      * Set the nodemask in sc to indicate to kswapd_shrink_node() that we're
> > +      * looking for reclaim from this node.
> > +      */
> > +     node_set(pgdat->node_id, nodemask);
> > +
> >       set_task_reclaim_state(current, &sc.reclaim_state);
> >       psi_memstall_enter(&pflags);
> >       __fs_reclaim_acquire(_THIS_IP_);
> > @@ -7642,6 +7699,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
> >       const unsigned long nr_pages = 1 << order;
> >       struct task_struct *p = current;
> >       unsigned int noreclaim_flag;
> > +     nodemask_t nodemask = NODE_MASK_NONE;
> >       struct scan_control sc = {
> >               .nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
> >               .gfp_mask = current_gfp_context(gfp_mask),
> > @@ -7651,9 +7709,16 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
> >               .may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
> >               .may_swap = 1,
> >               .reclaim_idx = gfp_zone(gfp_mask),
> > +             .nodemask = &nodemask,
> >       };
> >       unsigned long pflags;
> >
> > +     /*
> > +      * Set the nodemask in sc to indicate to shrink_node() that we're
> > +      * looking for reclaim from this node.
> > +      */
> > +     node_set(pgdat->node_id, nodemask);
> > +
> >       trace_mm_vmscan_node_reclaim_begin(pgdat->node_id, order,
> >                                          sc.gfp_mask);
> >
> > --
> > 2.39.0.rc0.267.gcb52ba06e7-goog
>
