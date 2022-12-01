Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA76363FAB1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbiLAWkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:40:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiLAWj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:39:57 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63498C8D1C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:39:48 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id k7-20020a256f07000000b006cbcc030bc8so3191119ybc.18
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JHZglG5ilwT7hsqyBjm+nL4wtqZp55RCSn8BZ+7jNpg=;
        b=RHNDbvszyBbPFEB77yE6AJGQfBt0EWpkE3qN5H9J3Pp5Q77hSPzW8ArtLS4SmB33mD
         8SXDsp5hzK2/hxWT7MKoqC3fSW77JLZagIWlq/EqS/blNXzBtdfoH26kkDNbrKgwi2Tm
         JjamnWumeGYaJKFjwgbEqgqlyxC6Jx2bu0SUugLD26lLkdaQpsAYAiFUKxkw19M6otbb
         1Z3qS4bBjRYFp6/H6vgSb6BjlQ2H8QkpZ1WmZkealqf3ubG/R58XI2SQtnO7fhHTTiOr
         1saN6mqKZeo9AQuP9prToIk9MQu8V2Z8qFrUVWJgcECwRdBaWIGCcT4+RTIcmpvH7gmP
         0EVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHZglG5ilwT7hsqyBjm+nL4wtqZp55RCSn8BZ+7jNpg=;
        b=T95ebS5Y5GQRC33mAKNJYlYoss+08V9bOxihPVLJZCwAXc80OgxMS3M+acOlGXmlvC
         7Dw8nCPKORZbSUMikKuj1kJzFG+EJx/maQYsL0EqcIAwnRBCb2epFAhIfr792wQjCRgN
         eYsjbSEpTf9E5ic5/hF3j7mU/T8uurpj7X2JMpJ0x2oNynps6DoK4Yeb44VtrtZxxu3b
         3lVcbtEE2ShyUpxLXdpCTr9blacgNKOE83B93Nn0k5lkWkdtQss0a2Gw+O2UKvbIbGDZ
         s9M03Gudu8UxY4NOKbF0utuDDR90TrC9UYtuWCFr+OzXhPvsXEdA5sVx4CWUxnpDqXnl
         gGwg==
X-Gm-Message-State: ANoB5pndXC4Ae8iHDgDzdSwT9YV6fmo6L/85Sp1p6XgmsBaH2tvvtxLG
        AsghenAdjiUHMJVqb/S5lfbu4ArYVsM=
X-Google-Smtp-Source: AA0mqf7944UNERKD5m4EdoDunAUNDT5CtA5j6zI05nuoJYATtJBJKXDdLhv1W54WaUpHG3XVTXdKF39O88I=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:1d8c:fe8c:ee3e:abb])
 (user=yuzhao job=sendgmr) by 2002:a81:4789:0:b0:39a:adfe:bf5c with SMTP id
 u131-20020a814789000000b0039aadfebf5cmr46711595ywa.403.1669934387675; Thu, 01
 Dec 2022 14:39:47 -0800 (PST)
Date:   Thu,  1 Dec 2022 15:39:21 -0700
In-Reply-To: <20221201223923.873696-1-yuzhao@google.com>
Message-Id: <20221201223923.873696-6-yuzhao@google.com>
Mime-Version: 1.0
References: <20221201223923.873696-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Subject: [PATCH mm-unstable v1 5/8] mm: multi-gen LRU: shuffle should_run_aging()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com,
        Yu Zhao <yuzhao@google.com>
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

Move should_run_aging() next to its only caller left.

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 124 ++++++++++++++++++++++++++--------------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 67967a4b18a9..0557adce75c5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4452,68 +4452,6 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
 	return true;
 }
 
-static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq,
-			     struct scan_control *sc, bool can_swap, unsigned long *nr_to_scan)
-{
-	int gen, type, zone;
-	unsigned long old = 0;
-	unsigned long young = 0;
-	unsigned long total = 0;
-	struct lru_gen_folio *lrugen = &lruvec->lrugen;
-	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
-	DEFINE_MIN_SEQ(lruvec);
-
-	/* whether this lruvec is completely out of cold folios */
-	if (min_seq[!can_swap] + MIN_NR_GENS > max_seq) {
-		*nr_to_scan = 0;
-		return true;
-	}
-
-	for (type = !can_swap; type < ANON_AND_FILE; type++) {
-		unsigned long seq;
-
-		for (seq = min_seq[type]; seq <= max_seq; seq++) {
-			unsigned long size = 0;
-
-			gen = lru_gen_from_seq(seq);
-
-			for (zone = 0; zone < MAX_NR_ZONES; zone++)
-				size += max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
-
-			total += size;
-			if (seq == max_seq)
-				young += size;
-			else if (seq + MIN_NR_GENS == max_seq)
-				old += size;
-		}
-	}
-
-	/* try to scrape all its memory if this memcg was deleted */
-	*nr_to_scan = mem_cgroup_online(memcg) ? (total >> sc->priority) : total;
-
-	/*
-	 * The aging tries to be lazy to reduce the overhead, while the eviction
-	 * stalls when the number of generations reaches MIN_NR_GENS. Hence, the
-	 * ideal number of generations is MIN_NR_GENS+1.
-	 */
-	if (min_seq[!can_swap] + MIN_NR_GENS < max_seq)
-		return false;
-
-	/*
-	 * It's also ideal to spread pages out evenly, i.e., 1/(MIN_NR_GENS+1)
-	 * of the total number of pages for each generation. A reasonable range
-	 * for this average portion is [1/MIN_NR_GENS, 1/(MIN_NR_GENS+2)]. The
-	 * aging cares about the upper bound of hot pages, while the eviction
-	 * cares about the lower bound of cold pages.
-	 */
-	if (young * MIN_NR_GENS > total)
-		return true;
-	if (old * (MIN_NR_GENS + 2) < total)
-		return true;
-
-	return false;
-}
-
 static bool lruvec_is_sizable(struct lruvec *lruvec, struct scan_control *sc)
 {
 	int gen, type, zone;
@@ -5097,6 +5035,68 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 	return scanned;
 }
 
+static bool should_run_aging(struct lruvec *lruvec, unsigned long max_seq,
+			     struct scan_control *sc, bool can_swap, unsigned long *nr_to_scan)
+{
+	int gen, type, zone;
+	unsigned long old = 0;
+	unsigned long young = 0;
+	unsigned long total = 0;
+	struct lru_gen_folio *lrugen = &lruvec->lrugen;
+	struct mem_cgroup *memcg = lruvec_memcg(lruvec);
+	DEFINE_MIN_SEQ(lruvec);
+
+	/* whether this lruvec is completely out of cold folios */
+	if (min_seq[!can_swap] + MIN_NR_GENS > max_seq) {
+		*nr_to_scan = 0;
+		return true;
+	}
+
+	for (type = !can_swap; type < ANON_AND_FILE; type++) {
+		unsigned long seq;
+
+		for (seq = min_seq[type]; seq <= max_seq; seq++) {
+			unsigned long size = 0;
+
+			gen = lru_gen_from_seq(seq);
+
+			for (zone = 0; zone < MAX_NR_ZONES; zone++)
+				size += max(READ_ONCE(lrugen->nr_pages[gen][type][zone]), 0L);
+
+			total += size;
+			if (seq == max_seq)
+				young += size;
+			else if (seq + MIN_NR_GENS == max_seq)
+				old += size;
+		}
+	}
+
+	/* try to scrape all its memory if this memcg was deleted */
+	*nr_to_scan = mem_cgroup_online(memcg) ? (total >> sc->priority) : total;
+
+	/*
+	 * The aging tries to be lazy to reduce the overhead, while the eviction
+	 * stalls when the number of generations reaches MIN_NR_GENS. Hence, the
+	 * ideal number of generations is MIN_NR_GENS+1.
+	 */
+	if (min_seq[!can_swap] + MIN_NR_GENS < max_seq)
+		return false;
+
+	/*
+	 * It's also ideal to spread pages out evenly, i.e., 1/(MIN_NR_GENS+1)
+	 * of the total number of pages for each generation. A reasonable range
+	 * for this average portion is [1/MIN_NR_GENS, 1/(MIN_NR_GENS+2)]. The
+	 * aging cares about the upper bound of hot pages, while the eviction
+	 * cares about the lower bound of cold pages.
+	 */
+	if (young * MIN_NR_GENS > total)
+		return true;
+	if (old * (MIN_NR_GENS + 2) < total)
+		return true;
+
+	return false;
+}
+
 /*
  * For future optimizations:
  * 1. Defer try_to_inc_max_seq() to workqueues to reduce latency for memcg
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

