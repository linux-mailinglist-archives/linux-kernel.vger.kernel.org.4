Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E64A67D394
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 18:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjAZRyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 12:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjAZRyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 12:54:00 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855DEEC72;
        Thu, 26 Jan 2023 09:53:59 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id v23so2552695plo.1;
        Thu, 26 Jan 2023 09:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2Qla7I7Duq+UJ1Mp3OlMfujz6rxLRhpzw4lXUxns0Q=;
        b=PU0cFraLkBQHmG6k8BceQUnlKXiB0ESp0AO4vNxqRRemq54IBBuKglvIcBXp+OM2io
         hodn/SjfhmHSvubWptgZvJNSmefHlYfvT805uKwrxs69TFDYMZAsXUPEwRqLQYChVIsU
         x5vlIUgwI9392dDY8cirPQg5Ie+3w3+g4H/F2DKV08cmyA9fbjxZPedgBpjN1e22lkI8
         GTqpR9DMbdviXsQSsm00zCf0qdez0uqG9tgRZ2yXgLo3UH0fXqfhVLNNIp3HNNBq358W
         Qev3XTLLGkqSzOYgoeZV3TXrOcBT3w7DOaDrT1N9/tc734akha14UGNYjMpafPJEwb+z
         59Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2Qla7I7Duq+UJ1Mp3OlMfujz6rxLRhpzw4lXUxns0Q=;
        b=2abCKa3DFxIUpswJ7+/9FceHKOYLuFd1BpiSz3CT+KQVVsZjPaumKbpxFOeTR1PCbE
         TgTWG1keP8KgiT+plj6JbUF1eAXmIFRjOjIgqvCQrxnvffsJ0xRud9wP9KZvaFG2qV35
         jtk9xPAeyhSSQ1Yfi19ofs3SFURgsEMC8AiDo0wJy77EmAhunXDBulPaJ+mIQULNoQSR
         WPmiIYAmcDnjvAQlGufdHhzixedOdWTCtSsbkMtczcuY5ZMPgpgBXJmbjShtGyNr/6l+
         8c5DLjSUerokJ/Ra2IV+beSDodwn+iFLzex/gDCjtQ5i63lOz1lAbPQiIphk0B4zGS5J
         pMRg==
X-Gm-Message-State: AFqh2krjGh3gpSiYr0B9lQtr8kb7gKPX07f1+/89lGecdbW0+PL4o2XZ
        CPpscLXYDOMEBDYNTvRfPmo=
X-Google-Smtp-Source: AMrXdXtT2JnYGzbKA+WV0wM+FaZVtJPk1sjLRg//hOlVKp8fVWtxFE7Wu6V5yxBVpJInPJNJNzP+Hg==
X-Received: by 2002:a05:6a20:4ca1:b0:b5:f6de:e84c with SMTP id fq33-20020a056a204ca100b000b5f6dee84cmr34575199pzb.42.1674755638880;
        Thu, 26 Jan 2023 09:53:58 -0800 (PST)
Received: from localhost (fwdproxy-prn-008.fbsv.net. [2a03:2880:ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id b24-20020a656698000000b0047915d582ccsm1016661pgw.20.2023.01.26.09.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 09:53:58 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v8 1/3] workingset: refactor LRU refault to expose refault recency check
Date:   Thu, 26 Jan 2023 09:53:54 -0800
Message-Id: <20230126175356.1582123-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126175356.1582123-1-nphamcs@gmail.com>
References: <20230126175356.1582123-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for computing recently evicted pages in cachestat,
refactor workingset_refault and lru_gen_refault to expose a helper
function that would test if an evicted page is recently evicted.

Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 include/linux/swap.h |   1 +
 mm/workingset.c      | 142 +++++++++++++++++++++++++++++--------------
 2 files changed, 97 insertions(+), 46 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a18cf4b7c724..dae6f6f955eb 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -361,6 +361,7 @@ static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
 }
 
 /* linux/mm/workingset.c */
+bool workingset_test_recent(void *shadow, bool file, bool *workingset);
 void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
 void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg);
 void workingset_refault(struct folio *folio, void *shadow);
diff --git a/mm/workingset.c b/mm/workingset.c
index 79585d55c45d..5f1d20a0a2fd 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -244,6 +244,30 @@ static void *lru_gen_eviction(struct folio *folio)
 	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
 }
 
+/*
+ * Test if the folio is recently evicted.
+ *
+ * As a side effect, also populates the references with
+ * values unpacked from the shadow of the evicted folio.
+ */
+static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
+		struct pglist_data **pgdat, unsigned long *token, bool *workingset)
+{
+	struct mem_cgroup *eviction_memcg;
+	struct lruvec *lruvec;
+	struct lru_gen_struct *lrugen;
+	unsigned long min_seq;
+
+	unpack_shadow(shadow, memcgid, pgdat, token, workingset);
+	eviction_memcg = mem_cgroup_from_id(*memcgid);
+
+	lruvec = mem_cgroup_lruvec(eviction_memcg, *pgdat);
+	lrugen = &lruvec->lrugen;
+
+	min_seq = READ_ONCE(lrugen->min_seq[file]);
+	return (*token >> LRU_REFS_WIDTH) == (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH));
+}
+
 static void lru_gen_refault(struct folio *folio, void *shadow)
 {
 	int hist, tier, refs;
@@ -258,23 +282,22 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
 	int type = folio_is_file_lru(folio);
 	int delta = folio_nr_pages(folio);
 
-	unpack_shadow(shadow, &memcg_id, &pgdat, &token, &workingset);
-
-	if (pgdat != folio_pgdat(folio))
-		return;
-
 	rcu_read_lock();
 
+	if (!lru_gen_test_recent(shadow, type, &memcg_id, &pgdat, &token,
+			&workingset))
+		goto unlock;
+
 	memcg = folio_memcg_rcu(folio);
 	if (memcg_id != mem_cgroup_id(memcg))
 		goto unlock;
 
+	if (pgdat != folio_pgdat(folio))
+		return;
+
 	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	lrugen = &lruvec->lrugen;
-
 	min_seq = READ_ONCE(lrugen->min_seq[type]);
-	if ((token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)))
-		goto unlock;
 
 	hist = lru_hist_from_seq(min_seq);
 	/* see the comment in folio_lru_refs() */
@@ -306,6 +329,12 @@ static void *lru_gen_eviction(struct folio *folio)
 	return NULL;
 }
 
+static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
+		struct pglist_data **pgdat, unsigned long *token, bool *workingset)
+{
+	return false;
+}
+
 static void lru_gen_refault(struct folio *folio, void *shadow)
 {
 }
@@ -373,40 +402,31 @@ void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
 				folio_test_workingset(folio));
 }
 
-/**
- * workingset_refault - Evaluate the refault of a previously evicted folio.
- * @folio: The freshly allocated replacement folio.
- * @shadow: Shadow entry of the evicted folio.
+/*
+ * Test if the folio is recently evicted by checking if
+ * refault distance of shadow exceeds workingset size.
  *
- * Calculates and evaluates the refault distance of the previously
- * evicted folio in the context of the node and the memcg whose memory
- * pressure caused the eviction.
+ * As a side effect, populate workingset with the value
+ * unpacked from shadow.
  */
-void workingset_refault(struct folio *folio, void *shadow)
+bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 {
-	bool file = folio_is_file_lru(folio);
 	struct mem_cgroup *eviction_memcg;
 	struct lruvec *eviction_lruvec;
 	unsigned long refault_distance;
 	unsigned long workingset_size;
-	struct pglist_data *pgdat;
-	struct mem_cgroup *memcg;
-	unsigned long eviction;
-	struct lruvec *lruvec;
 	unsigned long refault;
-	bool workingset;
 	int memcgid;
-	long nr;
+	struct pglist_data *pgdat;
+	unsigned long eviction;
 
-	if (lru_gen_enabled()) {
-		lru_gen_refault(folio, shadow);
-		return;
-	}
+	if (lru_gen_enabled())
+		return lru_gen_test_recent(shadow, file, &memcgid, &pgdat, &eviction,
+			workingset);
 
-	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
+	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
 	eviction <<= bucket_order;
 
-	rcu_read_lock();
 	/*
 	 * Look up the memcg associated with the stored ID. It might
 	 * have been deleted since the folio's eviction.
@@ -425,7 +445,8 @@ void workingset_refault(struct folio *folio, void *shadow)
 	 */
 	eviction_memcg = mem_cgroup_from_id(memcgid);
 	if (!mem_cgroup_disabled() && !eviction_memcg)
-		goto out;
+		return false;
+
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
 	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
 
@@ -447,21 +468,6 @@ void workingset_refault(struct folio *folio, void *shadow)
 	 */
 	refault_distance = (refault - eviction) & EVICTION_MASK;
 
-	/*
-	 * The activation decision for this folio is made at the level
-	 * where the eviction occurred, as that is where the LRU order
-	 * during folio reclaim is being determined.
-	 *
-	 * However, the cgroup that will own the folio is the one that
-	 * is actually experiencing the refault event.
-	 */
-	nr = folio_nr_pages(folio);
-	memcg = folio_memcg(folio);
-	pgdat = folio_pgdat(folio);
-	lruvec = mem_cgroup_lruvec(memcg, pgdat);
-
-	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
-
 	mem_cgroup_flush_stats_delayed();
 	/*
 	 * Compare the distance to the existing workingset size. We
@@ -483,7 +489,51 @@ void workingset_refault(struct folio *folio, void *shadow)
 						     NR_INACTIVE_ANON);
 		}
 	}
-	if (refault_distance > workingset_size)
+
+	return refault_distance <= workingset_size;
+}
+
+/**
+ * workingset_refault - Evaluate the refault of a previously evicted folio.
+ * @folio: The freshly allocated replacement folio.
+ * @shadow: Shadow entry of the evicted folio.
+ *
+ * Calculates and evaluates the refault distance of the previously
+ * evicted folio in the context of the node and the memcg whose memory
+ * pressure caused the eviction.
+ */
+void workingset_refault(struct folio *folio, void *shadow)
+{
+	bool file = folio_is_file_lru(folio);
+	struct pglist_data *pgdat;
+	struct mem_cgroup *memcg;
+	struct lruvec *lruvec;
+	bool workingset;
+	long nr;
+
+	if (lru_gen_enabled()) {
+		lru_gen_refault(folio, shadow);
+		return;
+	}
+
+	rcu_read_lock();
+
+	/*
+	 * The activation decision for this folio is made at the level
+	 * where the eviction occurred, as that is where the LRU order
+	 * during folio reclaim is being determined.
+	 *
+	 * However, the cgroup that will own the folio is the one that
+	 * is actually experiencing the refault event.
+	 */
+	nr = folio_nr_pages(folio);
+	memcg = folio_memcg(folio);
+	pgdat = folio_pgdat(folio);
+	lruvec = mem_cgroup_lruvec(memcg, pgdat);
+
+	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
+
+	if (!workingset_test_recent(shadow, file, &workingset))
 		goto out;
 
 	folio_set_active(folio);
-- 
2.30.2
