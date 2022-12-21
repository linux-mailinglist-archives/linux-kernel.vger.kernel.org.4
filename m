Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAC3652A56
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiLUANU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiLUAMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:12:48 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CFD20365
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:12:43 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i10-20020a25f20a000000b006ea4f43c0ddso16056099ybe.21
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5gz0YgVLNDGFuqc3Lh4NnPiIlhtb3z+cq+FKhQZOoZk=;
        b=pYjtLo94emkX9HO5dNLwhnNl1q+/QkmPT4BV1Q2CYxKbEqjmuBFe+6E8hDAD23TmkJ
         rM8E5hVkIT1iJndDE4GFfnTHJmPy8rBNDiU6xKV12vavnbPR7PD/inFgUi8kelq6KFXs
         0OyI9IPv8w8vh7ij2xerLvGSfzs7TWadUGqYgShpNGJ5FVlZQd8389NLfnqGGFtFYhZ5
         yMAQh71Vn5/4k+ix3kKLG2LnpGcKhFJb6ylWem23nVTzY3PJF0dMSMUj/ohq835xZL4p
         HniHGo7EmzRDdAifMnyP6l1XmBjesx3FTwryw+4a+i46NpHmyyWubfVZzsndi55Y/SZd
         SgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5gz0YgVLNDGFuqc3Lh4NnPiIlhtb3z+cq+FKhQZOoZk=;
        b=kglMooeIGQ6Fd4xNyKy73FLgcdYGLiQo8DY+MBhGQkikv1GwPl+TDd8WgjD1fuO8HZ
         xSQuH8wMX39UJw3U1UmdiiB9VVSz3Q6Dwqe+5S0nf6E0ySp6ABLt0KBxLW/iMt2xwExx
         ru9f/vWz1YaSZfKv06qzDg/Ys4Yy1PoOzLlt2qz594OzfcsjmwQtZeudjO5mr+M9wwyL
         9a2Ig6wmO26tbJlZlOQuYCCQ0fTfNIgfO8uxdaHssNT8GdtJsmAfKi0p0jtbitW5DZn+
         YVnbxisWibqzF9a6PSwio3lD/P1FNWRJR9jrMj22JycgyaXVxVV+6mf6CyJkP9T3SCWs
         +jTg==
X-Gm-Message-State: ANoB5pmDuLs3lShyj3HvLD/T0+5ZHIthaLGzBJAktgdge3fSHclzjSUk
        OJXa7ahTTqGABkf/GpWQ0Oggs08KuSU=
X-Google-Smtp-Source: AA0mqf5J92WPjbmjq0S0/8L8nqyD/H5zHMKEWJbsreI8pJ3tp81Dmd741SGe/PrsNv8NhFNSwOv39dKlDJo=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:a589:30f2:2daa:4ab7])
 (user=yuzhao job=sendgmr) by 2002:a81:4d07:0:b0:427:c319:1abe with SMTP id
 a7-20020a814d07000000b00427c3191abemr3853654ywb.328.1671581562522; Tue, 20
 Dec 2022 16:12:42 -0800 (PST)
Date:   Tue, 20 Dec 2022 17:12:05 -0700
In-Reply-To: <20221221001207.1376119-1-yuzhao@google.com>
Message-Id: <20221221001207.1376119-6-yuzhao@google.com>
Mime-Version: 1.0
References: <20221221001207.1376119-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v2 5/8] mm: multi-gen LRU: shuffle should_run_aging()
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Larabel <michael@michaellarabel.com>,
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
Change-Id: I07e5372b98ca28c003861fdeddadde4304abcfe4
---
 mm/vmscan.c | 124 ++++++++++++++++++++++++++--------------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a2f71400b8be..c424cc06f8c6 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4470,68 +4470,6 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
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
@@ -5115,6 +5053,68 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
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
2.39.0.314.g84b9a713c41-goog

