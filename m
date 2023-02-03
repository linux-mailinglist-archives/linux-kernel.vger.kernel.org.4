Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F3B68A279
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:04:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjBCTET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbjBCTEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:04:16 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FB51C587;
        Fri,  3 Feb 2023 11:04:15 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z1so6201170plg.6;
        Fri, 03 Feb 2023 11:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2Qla7I7Duq+UJ1Mp3OlMfujz6rxLRhpzw4lXUxns0Q=;
        b=HwsMYazSFWj5Ss4irgfWFeLiGYVSYDAETzx/xwd6gADPebLaYY2Lu6GkERV3fZUbxU
         HqotSCvhEIYQdCj0p9v0SYA5nTyFEBkkIEOYVA8fz/BlhkJM3s7q7vWBH6oT5ksFlDD9
         9+K5YxKa9EueDhfoYdvwBwxsl62mD9JTdh3leYTWL8n88nJ2HZSAqloeombAXcOGSnZ5
         qPZ5iq2OsLENvF/cx8VZLPuxkrdKTJlWpA+zUVFLWAmQ7SPf5LEhmhFta2MyfetTxr/A
         G1mtn+SRa6/yxg+50EewCcZ5ufyIme+TfjUzj0eOs8qPto6sdoCiYrDz5PwZ9KCacoQP
         gbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2Qla7I7Duq+UJ1Mp3OlMfujz6rxLRhpzw4lXUxns0Q=;
        b=aGlnULsEa5dI32dpVv9a+JR9kA8Nh5g3TRilk6RuVlnoY8PTbAIzFdZjrFtpEYhOLw
         1U7yhfCtAyoxRHJ1JZ5eqMQGlyyl0vhXhXuMtSoZWozf6yztZqaJb9z2CU1OFVoeT8Lc
         N1fE1uX/dHXwBjX0ost9dlID2E6MrwYb8if7u2Ic6uu88ygSTkDffJDqVSFnjLCuH0+j
         JZE3T37+Ncvh2j8cwZ06yFKaCdQu8ldM2Sr/+bJqlzCEZK6IwM9IoyZAZsjNXjqI2sjz
         +YyroLkUF+E+CbiW6iGy7E98mSkU8UA+A16b1ELj8Nyd/Lk9x5cAa6md1rBwedBkWegv
         2NLw==
X-Gm-Message-State: AO0yUKW0SBknY4S9Vx3HxPk+kb4dgxWeB25uNetMiLdEH9JEInE0rsbN
        0iCxv7Bdmlx0nnA8BE1Q1XM=
X-Google-Smtp-Source: AK7set8fmFZVJshKZthm5lkec3wEMqp3U6Vckuu9lmM9sq8EAYpsCygfsgHDWDY69J7iHIQ4LAB9Rw==
X-Received: by 2002:a17:90b:4d10:b0:229:ee75:5d09 with SMTP id mw16-20020a17090b4d1000b00229ee755d09mr11792635pjb.40.1675451054769;
        Fri, 03 Feb 2023 11:04:14 -0800 (PST)
Received: from localhost (fwdproxy-prn-003.fbsv.net. [2a03:2880:ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id l11-20020a633e0b000000b0045ff216a0casm1852791pga.3.2023.02.03.11.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 11:04:14 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v9 1/3] workingset: refactor LRU refault to expose refault recency check
Date:   Fri,  3 Feb 2023 11:04:11 -0800
Message-Id: <20230203190413.2559707-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230203190413.2559707-1-nphamcs@gmail.com>
References: <20230203190413.2559707-1-nphamcs@gmail.com>
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
