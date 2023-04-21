Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692BE6EB59E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 01:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbjDUXOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 19:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjDUXO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 19:14:26 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE6F1FCF;
        Fri, 21 Apr 2023 16:14:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-51f597c97c5so2039717a12.0;
        Fri, 21 Apr 2023 16:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682118864; x=1684710864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Leee/43AWJ8Q1BedRn9GrIwj8H1dQXKt4vvVqdpQ7zA=;
        b=qpzapAUXJSG/VSkZAcIof66MBA6g3b5FkbFLwfeFp6lMkj0KeYA1L2DPWCUCaX55b5
         58lTt9YmvZsiyymOOCAk1pfZ/4vUUtyyDnCugENVZXo4Hts19czpCzfJJhQdTQVATqpc
         F3h4ciihVzkjEXCDGwMyDIHET8jZyOYQ2605i0A57uWLfHS3FTFz3IIfVn5SxGUhpz9F
         8HkwegZeAySWkFzBKLskrElCF4Ea09TTATHVpywkd2zF1/+QTMgxTwbsFAuHj2m29EHR
         KhLKgIH/IRj6bN7bwRXiWqDcfq4/mfKnK7XnACVL4VYU706AaMLstyWVcDIw9A53QPrk
         +27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682118864; x=1684710864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Leee/43AWJ8Q1BedRn9GrIwj8H1dQXKt4vvVqdpQ7zA=;
        b=Xt2WF0Xwy9wmFkj44KZh/Q7EDWkAo87cA55b/TmOey89XV7gKbEgjfA2lOoZRP7Dxx
         DLURj7yMyOmS0J6lMur9bQSVBKjLCuhvKIE1xQI1/D0YKWKuhpWE1pRCu0WPIv2RUgMZ
         M1bElMasA/GX9hgDExhOPiKHFMHBQm3P40OVHWG4FGpwee7LvGUdn29p5+kvTMyYmyMI
         uZVlzrZQvq3W+Fquh1706CSRAbccXgEipqDzxM7TEohGum2QmBrX1QNHwilgvYKPcLlP
         NlVFm257nvL1xAnIXfmk81zIvIIDd90+3FPvxpF1abiJoDG7CdMAuXnGybntaWubBYGX
         ho0Q==
X-Gm-Message-State: AAQBX9caWQ/0W12zRjvD8S5Ls296V/Q+VfNIiivm4SPYAhK85k5rz8+M
        K1TRGt+6FqT0QV/svihr254=
X-Google-Smtp-Source: AKy350bcFaY1hRgAoGPvRk70m6ChPhjgG1GESyjlVu0QqKyDnYX0AUVVRTS5wsIqL6PrFbsOH7i/4A==
X-Received: by 2002:a17:90a:fb95:b0:248:839e:551 with SMTP id cp21-20020a17090afb9500b00248839e0551mr6469738pjb.35.1682118864039;
        Fri, 21 Apr 2023 16:14:24 -0700 (PDT)
Received: from localhost (fwdproxy-prn-004.fbsv.net. [2a03:2880:ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090a784800b002476ee46dbfsm4808420pjl.57.2023.04.21.16.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 16:14:23 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v12 1/3] workingset: refactor LRU refault to expose refault recency check
Date:   Fri, 21 Apr 2023 16:14:19 -0700
Message-Id: <20230421231421.2401346-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421231421.2401346-1-nphamcs@gmail.com>
References: <20230421231421.2401346-1-nphamcs@gmail.com>
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
index 7f7d5b9ddf7e..417d965d46d0 100644
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
