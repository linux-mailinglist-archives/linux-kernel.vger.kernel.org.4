Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9636D643B52
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 03:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbiLFCe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 21:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiLFCeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:34:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A4E1E3FA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 18:34:20 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b4-20020a253404000000b006fad1bb09f4so14249385yba.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 18:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jPLZgAUlS+7QpJFptknQoJ63ocBqUst2yPMDlo562Iw=;
        b=N/YGhe+Lsh8EoscWEjWpIO6y6VRuWPXo8FK17vhQmESVY+glSNG0ZX21C5Pp8mrRwj
         l9vNNbsh1J2qCtLf4F3DqqjrnOAmo2Y+mL8szliH2uTWx2+/rACvp3HhDYGaL5wBnysL
         +J+GFilVBQsrOx6lxzeN6D2JDlwcX0H/S4GmOKEGyiSQlitopObfNzsSch5hJM+m+U+4
         y7wtS2/8hA4t1MmV7oRwVYxk9muuuAUD4T8h+3oPzZE5iM4vzzw7gSLNSUsbn/vv5rYI
         rFBBknDsROqjTWhP/IP8YE3e0rtlPxwwmJH1bsy449hU0VxXXbfwmr8LGCp/SjVsNrn6
         2/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPLZgAUlS+7QpJFptknQoJ63ocBqUst2yPMDlo562Iw=;
        b=YiAtYQw3Wx240ia2UnS71ko2y9pL98bs4xu2aOVtrmY0Ev6ie/cg9CPYzXWXTqhX2M
         atzDPzitzwhFAjzSy+whnnECgTTCqvjOAdK14C/st70QsvAqV6wR5GzIEfQupBc/APcn
         eicrf8UMZJ2vmLmMrLUOq9RAPGqDG4DTv9WyyTg+Xv30Okczc1mwjlst9qQAqyCL17k8
         occub+dHDwS6KIMijOXni3QOE0SUX/hVqwXpAxhWZp4p+tUMvt/j1nbAi9ec49QXkyQ/
         fZnAf8aMWTGIYMzkx3PO5LFDaBWgFNKGQ9NzSJcuL69O+tSxJ6KsDDhmWb13yLh5rIIr
         feEQ==
X-Gm-Message-State: ANoB5pn574X2u/GStQ7sXKPBvLZK3rql5bPLLWzbRg6pL3SKY3RmXagb
        +TU3Ny1iT3yxc+CNFpEJuvSm9rAi3gV8yJaqWw==
X-Google-Smtp-Source: AA0mqf4Ol7JyWd3qZd0da+qOuT14l1cx556K0Sn0229COs8F51OTWwaSRgckQp+t8ZjGADsrSi8ckgipO4M7Hj3mlA==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2d4:203:8537:326f:6d74:8d03])
 (user=almasrymina job=sendgmr) by 2002:a25:c7cb:0:b0:6fc:834c:9c89 with SMTP
 id w194-20020a25c7cb000000b006fc834c9c89mr18227229ybe.43.1670294060089; Mon,
 05 Dec 2022 18:34:20 -0800 (PST)
Date:   Mon,  5 Dec 2022 18:34:05 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221206023406.3182800-1-almasrymina@google.com>
Subject: [PATCH v3] [mm-unstable] mm: Fix memcg reclaim on memory tiered systems
From:   Mina Almasry <almasrymina@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, Mina Almasry <almasrymina@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
reclaim"") enabled demotion in memcg reclaim, which is the right thing
to do, however, it introduced a regression in the behavior of
try_to_free_mem_cgroup_pages().

The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
of the cgroup should reduce by nr_pages. The callers expect
try_to_free_mem_cgroup_pages() to also return the number of pages
reclaimed, not demoted.

However, what try_to_free_mem_cgroup_pages() actually does is it
unconditionally counts demoted pages as reclaimed pages. So in practice
when it is called it will often demote nr_pages and return the number of
demoted pages to the caller. Demoted pages don't lower the memcg usage,
and so try_to_free_mem_cgroup_pages() is not actually doing what the
callers want it to do.

Various things work suboptimally on memory tiered systems or don't work
at all due to this:

- memory.high enforcement likely doesn't work (it just demotes nr_pages
  instead of lowering the memcg usage by nr_pages).
- try_charge_memcg() will keep retrying the charge while
  try_to_free_mem_cgroup_pages() is just demoting pages and not actually
  making any room for the charge.
- memory.reclaim has a wonky interface. It advertises to the user it
  reclaims the provided amount but it will actually often demote that
  amount.

There may be more effects to this issue.

To fix these issues I propose shrink_folio_list() to only count pages
demoted from inside of sc->nodemask to outside of sc->nodemask as
'reclaimed'.

For callers such as reclaim_high() or try_charge_memcg() that set
sc->nodemask to NULL, try_to_free_mem_cgroup_pages() will try to
actually reclaim nr_pages and return the number of pages reclaimed. No
demoted pages would count towards the nr_pages requirement.

For callers such as memory_reclaim() that set sc->nodemask,
try_to_free_mem_cgroup_pages() will free nr_pages from that nodemask
with either reclaim or demotion.

Tested this change using memory.reclaim interface. I set up a test case where
I allocate 500m in a cgroup, and then do:

    echo "50m" > memory.reclaim

Without this fix, my kernel demotes 70mb and reclaims 4 mb
(memory.current is reduced by about 4mb).

With this fix, my kernel demotes all memory possible and reclaims 60mb
(memory.current is reduced by about 60mb).

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

Changes in v3:
- Reverted back to v1 implementation: "try to demote but don't count
  demoted pages unless they are demoted to outside the nodemask" as Ying
  suggested.
- Made sure demotions that fall back to non next_demotion_target() are
  not counted as Wei suggested.
- Updated comment in shrink_folio_list() as Ying suggested.
- Added before/after for the test case in commit message since Ying
  asked.
- Fixed call sites that don't provide sc->nodemask but expect demotion
  from a specific node as Ying pointed out.

Cc: weixugc@google.com
Cc: ying.huang@intel.com

This is developed on top of mm-unstable largely because I want the
solution to be compatible with the recently added nodes= arg on
mm-unstable.
---
 mm/vmscan.c | 91 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 78 insertions(+), 13 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2b42ac9ad755..f324e80395c3 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1555,13 +1555,18 @@ static void folio_check_dirty_writeback(struct folio *folio,
 		mapping->a_ops->is_dirty_writeback(folio, dirty, writeback);
 }

+struct demotion_control {
+	struct migration_target_control *mtc;
+	nodemask_t *demote_from_nodemask;
+	unsigned long nr_demoted_outside_nodemask;
+};
+
 static struct page *alloc_demote_page(struct page *page, unsigned long private)
 {
 	struct page *target_page;
 	nodemask_t *allowed_mask;
-	struct migration_target_control *mtc;
-
-	mtc = (struct migration_target_control *)private;
+	struct demotion_control *dc = (struct demotion_control *)private;
+	struct migration_target_control *mtc = dc->mtc;

 	allowed_mask = mtc->nmask;
 	/*
@@ -1576,13 +1581,31 @@ static struct page *alloc_demote_page(struct page *page, unsigned long private)
 	mtc->nmask = NULL;
 	mtc->gfp_mask |= __GFP_THISNODE;
 	target_page = alloc_migration_target(page, (unsigned long)mtc);
-	if (target_page)
+	if (!target_page) {
+		mtc->gfp_mask &= ~__GFP_THISNODE;
+		mtc->nmask = allowed_mask;
+		target_page = alloc_migration_target(page, (unsigned long)mtc);
+	}
+
+	if (!target_page)
 		return target_page;

-	mtc->gfp_mask &= ~__GFP_THISNODE;
-	mtc->nmask = allowed_mask;
+	if (dc->demote_from_nodemask &&
+	    !node_isset(page_to_nid(target_page), *dc->demote_from_nodemask))
+		dc->nr_demoted_outside_nodemask++;

-	return alloc_migration_target(page, (unsigned long)mtc);
+	return target_page;
+}
+
+void free_demote_page(struct page *page, unsigned long private)
+{
+	struct demotion_control *dc = (struct demotion_control *)private;
+
+	if (dc->demote_from_nodemask &&
+	    !node_isset(page_to_nid(page), *dc->demote_from_nodemask))
+		dc->nr_demoted_outside_nodemask--;
+
+	folio_put(page_folio(page));
 }

 /*
@@ -1590,7 +1613,8 @@ static struct page *alloc_demote_page(struct page *page, unsigned long private)
  * Folios which are not demoted are left on @demote_folios.
  */
 static unsigned int demote_folio_list(struct list_head *demote_folios,
-				     struct pglist_data *pgdat)
+				      struct pglist_data *pgdat,
+				      nodemask_t *nodemask)
 {
 	int target_nid = next_demotion_node(pgdat->node_id);
 	unsigned int nr_succeeded;
@@ -1608,6 +1632,12 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 		.nmask = &allowed_mask
 	};

+	struct demotion_control dc = {
+		.mtc = &mtc,
+		.demote_from_nodemask = nodemask,
+		.nr_demoted_outside_nodemask = 0,
+	};
+
 	if (list_empty(demote_folios))
 		return 0;

@@ -1617,13 +1647,13 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	node_get_allowed_targets(pgdat, &allowed_mask);

 	/* Demotion ignores all cpuset and mempolicy settings */
-	migrate_pages(demote_folios, alloc_demote_page, NULL,
-		      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
+	migrate_pages(demote_folios, alloc_demote_page, free_demote_page,
+		      (unsigned long)&dc, MIGRATE_ASYNC, MR_DEMOTION,
 		      &nr_succeeded);

 	__count_vm_events(PGDEMOTE_KSWAPD + reclaimer_offset(), nr_succeeded);

-	return nr_succeeded;
+	return dc.nr_demoted_outside_nodemask;
 }

 static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
@@ -1643,7 +1673,12 @@ static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
 }

 /*
- * shrink_folio_list() returns the number of reclaimed pages
+ * shrink_folio_list() returns the number of reclaimed pages.
+ *
+ * Demoted pages are counted as reclaimed iff:
+ *   (a) sc->nodemask arg is provided.
+ *   (b) page has been demoted from a node inside sc->nodemask to a node
+ *   outside sc->nodemask.
  */
 static unsigned int shrink_folio_list(struct list_head *folio_list,
 		struct pglist_data *pgdat, struct scan_control *sc,
@@ -1653,6 +1688,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	LIST_HEAD(free_folios);
 	LIST_HEAD(demote_folios);
 	unsigned int nr_reclaimed = 0;
+	unsigned int nr_demoted_outside_nodemask = 0;
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
 	struct swap_iocb *plug = NULL;
@@ -2085,7 +2121,12 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	/* 'folio_list' is always empty here */

 	/* Migrate folios selected for demotion */
-	nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
+	nr_demoted_outside_nodemask =
+		demote_folio_list(&demote_folios, pgdat, sc->nodemask);
+
+	if (sc->nodemask)
+		nr_reclaimed += nr_demoted_outside_nodemask;
+
 	/* Folios that could not be demoted are still in @demote_folios */
 	if (!list_empty(&demote_folios)) {
 		/* Folios which weren't demoted go back on @folio_list */
@@ -2130,9 +2171,11 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					   struct list_head *folio_list)
 {
+	nodemask_t nodemask = NODE_MASK_NONE;
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.may_unmap = 1,
+		.nodemask = &nodemask
 	};
 	struct reclaim_stat stat;
 	unsigned int nr_reclaimed;
@@ -2140,6 +2183,12 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 	LIST_HEAD(clean_folios);
 	unsigned int noreclaim_flag;

+	/*
+	 * Set the nodemask in sc to indicate to shrink_folio_list() that we're
+	 * looking for reclaim from this node.
+	 */
+	node_set(zone->zone_pgdat->node_id, nodemask);
+
 	list_for_each_entry_safe(folio, next, folio_list, lru) {
 		if (!folio_test_hugetlb(folio) && folio_is_file_lru(folio) &&
 		    !folio_test_dirty(folio) && !__folio_test_movable(folio) &&
@@ -7031,12 +7080,20 @@ static int balance_pgdat(pg_data_t *pgdat, int order, int highest_zoneidx)
 	unsigned long zone_boosts[MAX_NR_ZONES] = { 0, };
 	bool boosted;
 	struct zone *zone;
+	nodemask_t nodemask = NODE_MASK_NONE;
 	struct scan_control sc = {
 		.gfp_mask = GFP_KERNEL,
 		.order = order,
 		.may_unmap = 1,
+		.nodemask = &nodemask,
 	};

+	/*
+	 * Set the nodemask in sc to indicate to kswapd_shrink_node() that we're
+	 * looking for reclaim from this node.
+	 */
+	node_set(pgdat->node_id, nodemask);
+
 	set_task_reclaim_state(current, &sc.reclaim_state);
 	psi_memstall_enter(&pflags);
 	__fs_reclaim_acquire(_THIS_IP_);
@@ -7642,6 +7699,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	const unsigned long nr_pages = 1 << order;
 	struct task_struct *p = current;
 	unsigned int noreclaim_flag;
+	nodemask_t nodemask = NODE_MASK_NONE;
 	struct scan_control sc = {
 		.nr_to_reclaim = max(nr_pages, SWAP_CLUSTER_MAX),
 		.gfp_mask = current_gfp_context(gfp_mask),
@@ -7651,9 +7709,16 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 		.may_unmap = !!(node_reclaim_mode & RECLAIM_UNMAP),
 		.may_swap = 1,
 		.reclaim_idx = gfp_zone(gfp_mask),
+		.nodemask = &nodemask,
 	};
 	unsigned long pflags;

+	/*
+	 * Set the nodemask in sc to indicate to shrink_node() that we're
+	 * looking for reclaim from this node.
+	 */
+	node_set(pgdat->node_id, nodemask);
+
 	trace_mm_vmscan_node_reclaim_begin(pgdat->node_id, order,
 					   sc.gfp_mask);

--
2.39.0.rc0.267.gcb52ba06e7-goog
