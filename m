Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1148C6412EF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 02:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiLCBLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 20:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234966AbiLCBLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 20:11:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41F5BE4F4
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 17:11:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 203-20020a2502d4000000b006f94ab02400so6824138ybc.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 17:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/nFR+wx3fDh2jF+K9/Q6SHeUTNnF6C4ZtCGpq7JUDE0=;
        b=MeZG/Gqxyp/tTgTVrJI9XN6sIrGfZKGsvwpnx4AHGwBdG+OWLYFHLJhw0cd8K8Ef+0
         yG81P7JvXIEbTXa1zJvjOPe4Bbs36R3mIFG4v1l3Bq++h8W3bHcV/drAXV3VmlO7KD5e
         IIwSUyBd6u/VJXBWUAO1/RGXFgsXcdq3canItaKNtl+Ff7RMbc+r5pkcmwyPD2/LQCLI
         2gu8lfvDfWwUOlxiX1mdcXb+hbaX/xI94k3LOAvwt98TVZ+BL4e7jFpYYlFFMuWLljQi
         Dmhi562LLY4/Y1igpOaRFei7nukuzmBdpzsOcB6wB0yQMJBXMGxz6p3fU5Nes+fXgea9
         vtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/nFR+wx3fDh2jF+K9/Q6SHeUTNnF6C4ZtCGpq7JUDE0=;
        b=elNiXna3rfvT5ZRKMm3Ht0+DGaocaKbvDWOGoougYOQhCBoVfYD072Nc82vzJ2z0ES
         FHiSxLduf8PGfqIWUWmtM6VHOVNgyEnXE8a44FIBltzdCuROVMky0sLphuIpuSlmh0uZ
         osusJn3p2vYpk06ovE0OhoAOPYZNuz1mzVDXU+XGBkZFHQuU05WXdQfV9SmpN2lYeoGn
         cbz6YegpsOqyVCGhDSwzMZnbN2g56WvY1MCgGI4u8XLZoLh5mZHFpyrQmxJFB5964ZPp
         squF7PjT+TtF84mXgVc1sd4kQXarXXhtoMm7ApXqZcWqkq70Qm0J/7GVwlAKxmXEsbEe
         raUQ==
X-Gm-Message-State: ANoB5pmtVU1lsIiotca2V1QtDLIKHUTX94p0jhY+dB3WdUfVSCP3Z/2t
        7YXI1mOUEZtm8awNyEdv4QbTf0TZn9BS2YpiIA==
X-Google-Smtp-Source: AA0mqf6E37hjDbRWoBovKVGFhOxSdBTvuUVJhtHQ9SzNJkbMeXEp28FeVH4fAGLQ+4QVoYUWusCkN8UEjWGYGUfPPg==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2d4:203:e655:31e2:2ad4:2421])
 (user=almasrymina job=sendgmr) by 2002:a25:3504:0:b0:6ee:984b:3d08 with SMTP
 id c4-20020a253504000000b006ee984b3d08mr52761857yba.116.1670029895188; Fri,
 02 Dec 2022 17:11:35 -0800 (PST)
Date:   Fri,  2 Dec 2022 17:11:19 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221203011120.2361610-1-almasrymina@google.com>
Subject: [PATCH v1] [mm-unstable] mm: Fix memcg reclaim on memory tiered systems
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
to do, however, I suspect it introduced a regression in the behavior of
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
and so I think try_to_free_mem_cgroup_pages() is not actually doing what
the callers want it to do.

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
with either reclaim or demotion.

Tested this change using memory.reclaim interface. With this change,

	echo "1m" > memory.reclaim

Will cause freeing of 1m of memory from the cgroup regardless of the
demotions happening inside.

	echo "1m nodes=0" > memory.reclaim

Will cause freeing of 1m of node 0 by demotion if a demotion target is
available, and by reclaim if no demotion target is available.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---

This is developed on top of mm-unstable largely because I need the
memory.reclaim nodes= arg to test it properly.
---
 mm/vmscan.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2b42ac9ad755..8f6e993b870d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1653,6 +1653,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	LIST_HEAD(free_folios);
 	LIST_HEAD(demote_folios);
 	unsigned int nr_reclaimed = 0;
+	unsigned int nr_demoted = 0;
 	unsigned int pgactivate = 0;
 	bool do_demote_pass;
 	struct swap_iocb *plug = NULL;
@@ -2085,7 +2086,17 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 	/* 'folio_list' is always empty here */

 	/* Migrate folios selected for demotion */
-	nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
+	nr_demoted = demote_folio_list(&demote_folios, pgdat);
+
+	/*
+	 * Only count demoted folios as reclaimed if we demoted them from
+	 * inside of the nodemask to outside of the nodemask, hence reclaiming
+	 * pages in the nodemask.
+	 */
+	if (sc->nodemask && node_isset(pgdat->node_id, *sc->nodemask) &&
+	    !node_isset(next_demotion_node(pgdat->node_id), *sc->nodemask))
+		nr_reclaimed += nr_demoted;
+
 	/* Folios that could not be demoted are still in @demote_folios */
 	if (!list_empty(&demote_folios)) {
 		/* Folios which weren't demoted go back on @folio_list */
--
2.39.0.rc0.267.gcb52ba06e7-goog
