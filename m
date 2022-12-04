Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116F2641C0C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 10:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLDJaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 04:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiLDJaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 04:30:19 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C345112D29
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 01:30:17 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3c44ac82606so94520417b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 01:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OaLjpR/QVt3hQbpdZlq+Q/65ck99KOIfezFgNLpv2/M=;
        b=jTqf8mCrAhYdbQXet7tnzjdA4IOXTGDFOyvIOTyDJDCAH0yNC5q95Z6bT5WYF8q2a0
         GBkyNHGwVngkLcFbXsseKJl42kkpXy+cck1DIAKSpPpUgBmRrico0VnE4Gjwm4izpa6X
         wBxVDUYrRfPV4iwrFSYnwJBc3veHTwcBOMaXprk1cNKhTt2PkugHq2xNOmmcdtrIOctd
         VHcwn6p+I2JL2cKt5zz1+BOnmH5vrl+O2GKDU08xKZx79XPpljVqCJt1IIFDPRTVNDEn
         bYgovauUQXITwD1kAox3GoUvdzbqgWanMPS0Di0vgx8pt5wZM+WHpopY35RsbwM0/JtL
         wcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OaLjpR/QVt3hQbpdZlq+Q/65ck99KOIfezFgNLpv2/M=;
        b=O8sKyfxLq7Rd6mamggrQho5rPtp5guwlaDT3d33tKGidAxklNiKxVoDaZ8XCr2wlN0
         XAPD9N3DWwGAdH8PnvfPiQem+sPYHT45YjyFEkQ6mUDz6SbLJQJpgVESZjEVf7vStAqd
         3eFNCUXBtVQGzWL0Z21XIxsONNc3Hb0mi+fpREgCVpQmIDnrnrEiy3g9YaRBx8IMsDJN
         UqaB/wOGp9kVskdSjRlV/08lS3nXfLx1n08qoL6RGxm7/p6ONESvFbLiT6qN1XPxxnpK
         Kx5LXw48lOjCNHYOmdJyildTbFElxH89mJm42Vx6inWg9WG/6poHy6WtNDhlFyQXm3Et
         wFdA==
X-Gm-Message-State: ANoB5pnbddAv+9Ul1ThSG579EHzMDuaVJs886qLqJdXKIs7FCi7Nw3uc
        KW5WPshTCyu+bpjX740M2GWohwKk8weonVVXAQ==
X-Google-Smtp-Source: AA0mqf42y9I7uXztT0FS34KLkixeTnSfbwsr3AolFQbkLL5vqRufMVL512qBUwGDSZR/RruLkiNKK9Y+mTxSVXliTg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2d4:203:8120:ce77:bb35:7eba])
 (user=almasrymina job=sendgmr) by 2002:a25:5d3:0:b0:6fe:f001:b029 with SMTP
 id 202-20020a2505d3000000b006fef001b029mr4468732ybf.324.1670146217039; Sun,
 04 Dec 2022 01:30:17 -0800 (PST)
Date:   Sun,  4 Dec 2022 01:30:06 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221204093008.2620459-1-almasrymina@google.com>
Subject: [PATCH v2] [mm-unstable] mm: Fix memcg reclaim on memory tiered systems
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
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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
to do, but introduced a regression in the behavior of
try_to_free_mem_cgroup_pages().

The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
of the cgroup should reduce by nr_pages. The callers expect
try_to_free_mem_cgroup_pages() to also return the number of pages
reclaimed, not demoted.

However, try_to_free_mem_cgroup_pages() actually unconditionally counts
demoted pages as reclaimed pages. So in practice when it is called it will
often demote nr_pages and return the number of demoted pages to the caller.
Demoted pages don't lower the memcg usage as the caller requested.

I suspect various things work suboptimally on memory systems or don't
work at all due to this:

- memory.high enforcement likely doesn't work (it just demotes nr_pages
  instead of lowering the memcg usage by nr_pages).
- try_charge_memcg() will keep retrying the charge while
  try_to_free_mem_cgroup_pages() is just demoting pages and not actually
  making any room for the charge.
- memory.reclaim has a wonky interface. It advertises to the user it
  reclaims the provided amount but it will actually demote that amount.

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
with either demotion or reclaim.

Tested this change using memory.reclaim interface. With this change,

	echo "1m" > memory.reclaim

Will cause freeing of 1m of memory from the cgroup regardless of the
demotions happening inside.

	echo "1m nodes=0" > memory.reclaim

Will cause freeing of 1m of node 0 by demotion if a demotion target is
available, and by reclaim if no demotion target is available.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

This is developed on top of mm-unstable largely to test with memory.reclaim
nodes= arg and ensure the fix is compatible with that.

v2:
- Shortened the commit message a bit.
- Fixed issue when demotion falls back to other allowed target nodes returned by
  node_get_allowed_targets() as Wei suggested.

Cc: weixugc@google.com
---
 include/linux/memory-tiers.h |  7 +++++--
 mm/memory-tiers.c            | 10 +++++++++-
 mm/vmscan.c                  | 20 +++++++++++++++++---
 3 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index fc9647b1b4f9..f3f359760fd0 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -38,7 +38,8 @@ void init_node_memory_type(int node, struct memory_dev_type *default_type);
 void clear_node_memory_type(int node, struct memory_dev_type *memtype);
 #ifdef CONFIG_MIGRATION
 int next_demotion_node(int node);
-void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
+void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets,
+			      nodemask_t *demote_from_targets);
 bool node_is_toptier(int node);
 #else
 static inline int next_demotion_node(int node)
@@ -46,7 +47,9 @@ static inline int next_demotion_node(int node)
 	return NUMA_NO_NODE;
 }

-static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
+static inline void node_get_allowed_targets(pg_data_t *pgdat,
+					    nodemask_t *targets,
+					    nodemask_t *demote_from_targets)
 {
 	*targets = NODE_MASK_NONE;
 }
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index c734658c6242..7f8f0b5de2b3 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -264,7 +264,8 @@ bool node_is_toptier(int node)
 	return toptier;
 }

-void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
+void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets,
+			      nodemask_t *demote_from_targets)
 {
 	struct memory_tier *memtier;

@@ -280,6 +281,13 @@ void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
 	else
 		*targets = NODE_MASK_NONE;
 	rcu_read_unlock();
+
+	/*
+	 * Exclude the demote_from_targets from the allowed targets if we're
+	 * trying to demote from a specific set of nodes.
+	 */
+	if (demote_from_targets)
+		nodes_andnot(*targets, *targets, *demote_from_targets);
 }

 /**
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2b42ac9ad755..97ca0445b5dc 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1590,7 +1590,8 @@ static struct page *alloc_demote_page(struct page *page, unsigned long private)
  * Folios which are not demoted are left on @demote_folios.
  */
 static unsigned int demote_folio_list(struct list_head *demote_folios,
-				     struct pglist_data *pgdat)
+				      struct pglist_data *pgdat,
+				      nodemask_t *demote_from_nodemask)
 {
 	int target_nid = next_demotion_node(pgdat->node_id);
 	unsigned int nr_succeeded;
@@ -1614,7 +1615,7 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
 	if (target_nid == NUMA_NO_NODE)
 		return 0;

-	node_get_allowed_targets(pgdat, &allowed_mask);
+	node_get_allowed_targets(pgdat, &allowed_mask, demote_from_nodemask);

 	/* Demotion ignores all cpuset and mempolicy settings */
 	migrate_pages(demote_folios, alloc_demote_page, NULL,
@@ -1653,6 +1654,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	LIST_HEAD(free_folios);
 	LIST_HEAD(demote_folios);
 	unsigned int nr_reclaimed = 0;
+	unsigned int nr_demoted = 0;
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
 	struct swap_iocb *plug = NULL;
@@ -2085,7 +2087,19 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	/* 'folio_list' is always empty here */

 	/* Migrate folios selected for demotion */
-	nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
+	nr_demoted = demote_folio_list(&demote_folios, pgdat, sc->nodemask);
+
+	/*
+	 * Only count demoted folios as reclaimed if the caller has requested
+	 * demotion from a specific nodemask. In this case pages inside the
+	 * noedmask have been demoted to outside the nodemask and we can count
+	 * these pages as reclaimed. If no nodemask is passed, then the caller
+	 * is requesting reclaim from all memory, which should not count
+	 * demoted pages.
+	 */
+	if (sc->nodemask)
+		nr_reclaimed += nr_demoted;
+
 	/* Folios that could not be demoted are still in @demote_folios */
 	if (!list_empty(&demote_folios)) {
 		/* Folios which weren't demoted go back on @folio_list */
--
2.39.0.rc0.267.gcb52ba06e7-goog
