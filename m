Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C7865E0BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 00:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjADXLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 18:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjADXLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 18:11:02 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C8639F88
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 15:11:00 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id k19so16329336pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 15:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRguhEw3CY77NjO4ltDj62CfZtUxun2rreMj0XQVN6o=;
        b=FVyF3/gVe3ARIGfgW9nhT1QjatOnyKsZZp9poD7NhPKIVs7wzTvzqFh6nuBC2/T1st
         6MiVwqYSwEAawuDKYt48jliWlQR7a9rLqts8J95ADpzfgLskuxMSHs8I9walhxmfPMIA
         AMAKUTPRQr1+//sRK+oRWOtL3XGUvVnFldJq1QUl5xOD7RIjdFTUWrYLdwKXvbvG9YQL
         rcprsx4aVhGWNFaeN/g5BDoJYyNOszPAaVm6w/6s/f3eLeM0YmHTa78ng+TmjKXPrZ2x
         gueZyrdX1b4tGYDtLOvUFvAX7sc19JqPTaIMqLlpV6xanwMQTjoRgGS57VJz/TvMHixr
         68LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YRguhEw3CY77NjO4ltDj62CfZtUxun2rreMj0XQVN6o=;
        b=lxvkOmpYO5hbGUZSG1TvcB8jwnjaJBNsjsu26CeH5hllym2Cs8GIgwafqqqEU09aIJ
         1+2Rgs10M6G6VgXEMp3wcBdz1Vxdc6srozopyzIUnV51YsujDhvM4ytK/usCesZWwed3
         6RNQUYbBtFcxW4c3HR/T+D080XQiEYLY5tVwuuOSHDtTkTvTBxzWQ9/ug98PhaQT98rA
         AQZ2BfiEfMUNRTdzklueaVWtA6EwS6MeM+RNlwkFCW1FOcFzI7tnp5Vm4DGV2LBXW8e4
         eMuQesAYyT9E31sh23NaUs+6edztIuzn1VkdXlYROguTnTWZerqWDKwZptEAy6zdQnBT
         fdRQ==
X-Gm-Message-State: AFqh2kqcu4aheJSe/mHWyF4nv/fI2LMigvtiHMfS2WQS7DOEM/5BqrP7
        qLdEAb2+PMZMQ+853OYuCiU=
X-Google-Smtp-Source: AMrXdXtA4D2lE/TpwyaUnXuyj3yzHbo48zrNA1EgBxqoIt98qEwuBLyeSAI6MQlKlPzRAIONEL1ZLw==
X-Received: by 2002:aa7:88c3:0:b0:580:963d:8064 with SMTP id k3-20020aa788c3000000b00580963d8064mr63487290pff.20.1672873859587;
        Wed, 04 Jan 2023 15:10:59 -0800 (PST)
Received: from localhost (fwdproxy-prn-116.fbsv.net. [2a03:2880:ff:74::face:b00c])
        by smtp.gmail.com with ESMTPSA id c21-20020a621c15000000b00581498190efsm17072522pfc.161.2023.01.04.15.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 15:10:59 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, kernel-team@meta.com
Subject: [PATCH v5 1/3] workingset: refactor LRU refault to expose refault recency check
Date:   Wed,  4 Jan 2023 15:10:55 -0800
Message-Id: <20230104231057.2632639-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230104231057.2632639-1-nphamcs@gmail.com>
References: <20230104231057.2632639-1-nphamcs@gmail.com>
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
