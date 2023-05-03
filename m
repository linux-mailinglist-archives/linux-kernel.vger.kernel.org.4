Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1571C6F4E9D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 03:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjECBgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 21:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjECBgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 21:36:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227962D59;
        Tue,  2 May 2023 18:36:11 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so2047045ad.3;
        Tue, 02 May 2023 18:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683077770; x=1685669770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MM6teyjPlmkc2NzJ+Re62gPlYr2XnVPXuXbH/2DQ358=;
        b=p1yGAarxO09PbCP0WqCQvBy9dOXFLCU/jbfRSJ7zl4ThLhzF/99QvitdmQfZATQO4Z
         mXlwX+1OeWixhf944Nm9DoVYa9IDRBve633yEpMykaSkvvo59OuWKmJgtdc6/gptOx8s
         UL4KBFpStrCCxH/3gvuENWUj9c9GgqS6fePf/GrtaFzZ7R+ksFtFSeskgRNC8Zl2rLoT
         +MIUwMFeXCQt8bM4pJT7RtTujk1eDFrAPwNCVxm/PwYxVrz+Uvgyhq0lc/sUIa+cNTrk
         SreR49cxb2n2mslRvCsTVykUqNuqjYWQulou+sbVshMOmztKLKnqRq0fRP7HQ5YEpspv
         YCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683077770; x=1685669770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MM6teyjPlmkc2NzJ+Re62gPlYr2XnVPXuXbH/2DQ358=;
        b=I7vwQKigM92pSiwtKq8fymPjJ0zddQGHcVv0w3Uq4p9c68ujxpsgUVv09aO33vjCE6
         c9rTdWBSpjiwsEv21zo3iJ54OZso/3eoGtldqDdiVkZdoLkNx3tA6ggRKwq7dZb2rawR
         LGJrgBviJXKAbJm9PeBTmDf9QXioqZhrEy/7Fp4N6E5OvgZ2RjXic20cTPQIqvxvRC0P
         lHqsCKA0OG7WD/vnW52Rw3Ia6nVGyGAAThVGlK9pbw3G3rGiveL5gLGMG6Vm/IY2J5+j
         O+2KrsXTxVMrl2Ii21VLQJpZU3SHvMW3KJ7EKNDK0VEMV4upvwSZ1i7IOB1mk4mYdFqc
         Ckcg==
X-Gm-Message-State: AC+VfDyo3TnxE449KCnolVA4/lHvUsW9LVCW4DhUk+cin/I3XR9e1uuo
        ZE0LPv0makTqis8AOZ0vBXs=
X-Google-Smtp-Source: ACHHUZ7Aj65pS61wKFRteplQIiZVAALUH5If9YUR1v5VwcrbQSoRpAvqAiy1vEiWPIBJwFBNM581iQ==
X-Received: by 2002:a17:902:ecc3:b0:1aa:f173:2892 with SMTP id a3-20020a170902ecc300b001aaf1732892mr478420plh.57.1683077770360;
        Tue, 02 May 2023 18:36:10 -0700 (PDT)
Received: from localhost (fwdproxy-prn-014.fbsv.net. [2a03:2880:ff:e::face:b00c])
        by smtp.gmail.com with ESMTPSA id g22-20020a170902869600b001a67759f9f8sm20301684plo.106.2023.05.02.18.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 18:36:10 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v13 1/3] workingset: refactor LRU refault to expose refault recency check
Date:   Tue,  2 May 2023 18:36:06 -0700
Message-Id: <20230503013608.2431726-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230503013608.2431726-1-nphamcs@gmail.com>
References: <20230503013608.2431726-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 mm/workingset.c      | 150 +++++++++++++++++++++++++++++--------------
 2 files changed, 103 insertions(+), 48 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 3c69cb653cb9..b2128df5edea 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -368,6 +368,7 @@ static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t entry)
 }
 
 /* linux/mm/workingset.c */
+bool workingset_test_recent(void *shadow, bool file, bool *workingset);
 void workingset_age_nonresident(struct lruvec *lruvec, unsigned long nr_pages);
 void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg);
 void workingset_refault(struct folio *folio, void *shadow);
diff --git a/mm/workingset.c b/mm/workingset.c
index 817758951886..d81f9dafc9f1 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -255,6 +255,29 @@ static void *lru_gen_eviction(struct folio *folio)
 	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
 }
 
+/*
+ * Tests if the shadow entry is for a folio that was recently evicted.
+ * Fills in @memcgid, @pglist_data, @token, @workingset with the values
+ * unpacked from shadow.
+ */
+static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
+		struct pglist_data **pgdat, unsigned long *token, bool *workingset)
+{
+	struct mem_cgroup *eviction_memcg;
+	struct lruvec *lruvec;
+	struct lru_gen_folio *lrugen;
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
@@ -269,23 +292,22 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
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
@@ -317,6 +339,12 @@ static void *lru_gen_eviction(struct folio *folio)
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
@@ -385,42 +413,34 @@ void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
 }
 
 /**
- * workingset_refault - Evaluate the refault of a previously evicted folio.
- * @folio: The freshly allocated replacement folio.
- * @shadow: Shadow entry of the evicted folio.
- *
- * Calculates and evaluates the refault distance of the previously
- * evicted folio in the context of the node and the memcg whose memory
- * pressure caused the eviction.
+ * workingset_test_recent - tests if the shadow entry is for a folio that was
+ * recently evicted. Also fills in @workingset with the value unpacked from
+ * shadow.
+ * @shadow: the shadow entry to be tested.
+ * @file: whether the corresponding folio is from the file lru.
+ * @workingset: where the workingset value unpacked from shadow should
+ * be stored.
+ *
+ * Return: true if the shadow is for a recently evicted folio; false otherwise.
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
 
-	/* Flush stats (and potentially sleep) before holding RCU read lock */
-	mem_cgroup_flush_stats_ratelimited();
-
-	rcu_read_lock();
 	/*
 	 * Look up the memcg associated with the stored ID. It might
 	 * have been deleted since the folio's eviction.
@@ -439,7 +459,8 @@ void workingset_refault(struct folio *folio, void *shadow)
 	 */
 	eviction_memcg = mem_cgroup_from_id(memcgid);
 	if (!mem_cgroup_disabled() && !eviction_memcg)
-		goto out;
+		return false;
+
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
 	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
 
@@ -461,20 +482,6 @@ void workingset_refault(struct folio *folio, void *shadow)
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
 	/*
 	 * Compare the distance to the existing workingset size. We
 	 * don't activate pages that couldn't stay resident even if
@@ -495,7 +502,54 @@ void workingset_refault(struct folio *folio, void *shadow)
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
+	/* Flush stats (and potentially sleep) before holding RCU read lock */
+	mem_cgroup_flush_stats_ratelimited();
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
2.34.1
