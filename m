Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E0B653B34
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 05:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiLVEUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 23:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235016AbiLVETu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 23:19:50 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709A522295
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:48 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id l3-20020a056e021aa300b00304be32e9e5so487800ilv.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 20:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S9ZuAyfwqYLskluTxeMZ1Oyj25JaC3jpnfC7bM5WyD4=;
        b=awokrXW2IaKsda0feV8JW/aYhMrUqKzEHQX+f5UsTBU2+8KVpH/XEmCKdVW/3j64+P
         LX4/xKKwf3yGaOd1RMWjLx+SBKbq5b79RaWXbvO3uvqC1rK19G2lTd+XOyNc4OAudt0G
         BNVuAfZmPTiS12q4Pp+vrGp7KjeUeKAD9fMxEibkXqvB9XoQo6+4i1rCFGj5s/wHCCxE
         YvcF1Rui1WagXwkNShtpDS8/0ZLm9UBhXa7tsws0qPh8YIdTW6gtnBpxOGzSDL8IeNie
         vd507zZFTZU4yPE5FV0HqFBmaZ/37IUyHVnBJLcsj1LUs4dMyMtEtQhrG/k+tqR6EKRe
         4JXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S9ZuAyfwqYLskluTxeMZ1Oyj25JaC3jpnfC7bM5WyD4=;
        b=YBzsnGRXmDqbkoWe7sN9lr7nou4wJpv8/SDWWuqjESTPn2F35iuz7pfjvcsGKqFBOj
         hbt7INYrNnsJsdVqH7pMMu+CgnfP9Fcyybc7XWfK0rkgFtS93hZJ5hCmsnBe/0EcObyJ
         kYAYA/4PEI8e8nsWu9mgGVxImnnvPoBVrJ+4dVeQNLpJA+Nv2DuomUyHaG18J7AXVVCB
         kZPFgn5Wbh+gfX+klmegxkRiaTef+kVMCdeb9htSEZ2PKyMWwaj6AtRQtXJ/fG0ICdMy
         ovzrIQBnFVvgcSENLIcafaIgRlpqYGz90mbDRMbjAQIulg85mj0pQ+dhBWT66IAiO3v/
         fJvQ==
X-Gm-Message-State: AFqh2kq6vjOLHLWgSRuEu5YxRWcyV0cnQpPBVyfwA1tn7CLCJkOYh3w9
        8uFFQiTYpB8325Ijf8cmCtaWifZzOdg=
X-Google-Smtp-Source: AMrXdXuEY3YkuSyiXYaG/rF71AtXpvUi99HGEHzJyq69UdzONGfza3jeMcIIHRBjZ3l13oxwVLYTLfNu04M=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:a463:5f7b:440e:5c77])
 (user=yuzhao job=sendgmr) by 2002:a92:cb42:0:b0:305:eba6:78ab with SMTP id
 f2-20020a92cb42000000b00305eba678abmr300227ilq.316.1671682787850; Wed, 21 Dec
 2022 20:19:47 -0800 (PST)
Date:   Wed, 21 Dec 2022 21:19:03 -0700
In-Reply-To: <20221222041905.2431096-1-yuzhao@google.com>
Message-Id: <20221222041905.2431096-6-yuzhao@google.com>
Mime-Version: 1.0
References: <20221222041905.2431096-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v3 5/8] mm: multi-gen LRU: shuffle should_run_aging()
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
---
 mm/vmscan.c | 124 ++++++++++++++++++++++++++--------------------------
 1 file changed, 62 insertions(+), 62 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 65cc82208b6e..dd9f7b7abe1c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4467,68 +4467,6 @@ static bool try_to_inc_max_seq(struct lruvec *lruvec, unsigned long max_seq,
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
@@ -5112,6 +5050,68 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
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

