Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F17664F1AC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 20:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiLPTWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 14:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiLPTVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 14:21:54 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56E357B67
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:21:53 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id x2so3223105plb.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 11:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRguhEw3CY77NjO4ltDj62CfZtUxun2rreMj0XQVN6o=;
        b=bLCK2hqNYii/SsuUXicmahKFilm2y4LcmrGmBqCz6pUsilTWoASCwxc5AO4LkgY3GK
         BNDtUeOhpeK0OZJemExWg+NJLRLCmUtTrkCMfeba5o4kgT13f1nupOwKsbt0XPUqhYqI
         kkWz6T/+1q6oITzCcCVnfELipcygpGvxD+qEEhJMyjr+0b2zkF5e5UD6FCnTPriEQBkI
         z3OnhM/2gar1E8V7Z/DnlFlygglYKXpXsw9P7BciJ0kqjkCxtM7fCq937BfA/KhDKlCy
         qusCzpwm8/LQI382ikTfyrstyx14AtV+mjzebb+NL2RAzHM0fbstMWma32uyciV1qlTB
         PHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRguhEw3CY77NjO4ltDj62CfZtUxun2rreMj0XQVN6o=;
        b=I6FUgf4ftDWoW0/AH1JEXTl2eHPisYyLGTy4BND379K3enY+d/mXzeDvy1G40md9Pp
         yKij6lxxTtzZqLgYAVRn6FERLgsJwWdFq4iDdea9/W5x/w1jHc7uJUjW8AgamX7vHQE0
         hX015s5Bhy7U/hwR68Ma1BbwqQcABm0nFjUqZwjH+51dScA8StzmzVfF3BcRAIjvnhkP
         GIqa4zLH++ciwHaLEu2/thPX7bgbRgLTYbhPLGFyN3j/lAJOVwLBZu4GMLRzuQ1+U1Gq
         fO8NSlq6XFTATEh+V5LdFQFNjYvLptSjkP5iitVKem+5JjFLIVtAlOosEjuIbEgg1rW/
         LDdw==
X-Gm-Message-State: ANoB5pmGAtjd0DugRiqC8LwgKKLgE9uwzSepLu+xJ54bhRqMOBiUMkgu
        JgGRzZEMnqtfGkptlEGECU8=
X-Google-Smtp-Source: AA0mqf7XjbbHvBcGpWGYcKcB2pbEbhG53XHIzX/B65NQolULlkjq9BvuiIdLGc8YSdD0HDuycD39uA==
X-Received: by 2002:a17:902:c213:b0:189:aa51:e27f with SMTP id 19-20020a170902c21300b00189aa51e27fmr43162444pll.44.1671218513304;
        Fri, 16 Dec 2022 11:21:53 -0800 (PST)
Received: from localhost (fwdproxy-prn-120.fbsv.net. [2a03:2880:ff:78::face:b00c])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090311cf00b0018912c37c8fsm1982895plh.129.2022.12.16.11.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 11:21:52 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH v4 2/4] workingset: refactor LRU refault to expose refault recency check
Date:   Fri, 16 Dec 2022 11:21:47 -0800
Message-Id: <20221216192149.3902877-3-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221216192149.3902877-1-nphamcs@gmail.com>
References: <20221216192149.3902877-1-nphamcs@gmail.com>
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
 mm/workingset.c      | 129 ++++++++++++++++++++++++++++++-------------
 2 files changed, 92 insertions(+), 38 deletions(-)

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
index 79585d55c45d..006482c4e0bd 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -244,6 +244,33 @@ static void *lru_gen_eviction(struct folio *folio)
 	return pack_shadow(mem_cgroup_id(memcg), pgdat, token, refs);
 }
 
+/*
+ * Test if the folio is recently evicted.
+ *
+ * As a side effect, also populates the references with
+ * values unpacked from the shadow of the evicted folio.
+ */
+static bool lru_gen_test_recent(void *shadow, bool file, bool *workingset)
+{
+	struct mem_cgroup *eviction_memcg;
+	struct lruvec *lruvec;
+	struct lru_gen_struct *lrugen;
+	unsigned long min_seq;
+
+	int memcgid;
+	struct pglist_data *pgdat;
+	unsigned long token;
+
+	unpack_shadow(shadow, &memcgid, &pgdat, &token, workingset);
+	eviction_memcg = mem_cgroup_from_id(memcgid);
+
+	lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
+	lrugen = &lruvec->lrugen;
+
+	min_seq = READ_ONCE(lrugen->min_seq[file]);
+	return !((token >> LRU_REFS_WIDTH) != (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH)));
+}
+
 static void lru_gen_refault(struct folio *folio, void *shadow)
 {
 	int hist, tier, refs;
@@ -306,6 +333,11 @@ static void *lru_gen_eviction(struct folio *folio)
 	return NULL;
 }
 
+static bool lru_gen_test_recent(void *shadow, bool file, bool *workingset)
+{
+	return true;
+}
+
 static void lru_gen_refault(struct folio *folio, void *shadow)
 {
 }
@@ -373,40 +405,31 @@ void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
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
+
 	int memcgid;
-	long nr;
+	struct pglist_data *pgdat;
+	unsigned long eviction;
 
-	if (lru_gen_enabled()) {
-		lru_gen_refault(folio, shadow);
-		return;
-	}
+	if (lru_gen_enabled())
+		return lru_gen_test_recent(shadow, file, workingset);
 
-	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, &workingset);
+	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
 	eviction <<= bucket_order;
 
-	rcu_read_lock();
 	/*
 	 * Look up the memcg associated with the stored ID. It might
 	 * have been deleted since the folio's eviction.
@@ -425,7 +448,8 @@ void workingset_refault(struct folio *folio, void *shadow)
 	 */
 	eviction_memcg = mem_cgroup_from_id(memcgid);
 	if (!mem_cgroup_disabled() && !eviction_memcg)
-		goto out;
+		return false;
+
 	eviction_lruvec = mem_cgroup_lruvec(eviction_memcg, pgdat);
 	refault = atomic_long_read(&eviction_lruvec->nonresident_age);
 
@@ -447,21 +471,6 @@ void workingset_refault(struct folio *folio, void *shadow)
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
@@ -483,8 +492,51 @@ void workingset_refault(struct folio *folio, void *shadow)
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
+	nr = folio_nr_pages(folio);
+	memcg = folio_memcg(folio);
+	pgdat = folio_pgdat(folio);
+	lruvec = mem_cgroup_lruvec(memcg, pgdat);
+
+	if (!workingset_test_recent(shadow, file, &workingset)) {
+		/*
+		 * The activation decision for this folio is made at the level
+		 * where the eviction occurred, as that is where the LRU order
+		 * during folio reclaim is being determined.
+		 *
+		 * However, the cgroup that will own the folio is the one that
+		 * is actually experiencing the refault event.
+		 */
 		goto out;
+	}
 
 	folio_set_active(folio);
 	workingset_age_nonresident(lruvec, nr);
@@ -498,6 +550,7 @@ void workingset_refault(struct folio *folio, void *shadow)
 		mod_lruvec_state(lruvec, WORKINGSET_RESTORE_BASE + file, nr);
 	}
 out:
+	mod_lruvec_state(lruvec, WORKINGSET_REFAULT_BASE + file, nr);
 	rcu_read_unlock();
 }
 
-- 
2.30.2
