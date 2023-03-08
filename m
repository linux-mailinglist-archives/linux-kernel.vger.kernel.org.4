Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64416AFD5E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 04:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCHD2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 22:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjCHD17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 22:27:59 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C4C7ECF;
        Tue,  7 Mar 2023 19:27:55 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id s18so8901580pgq.1;
        Tue, 07 Mar 2023 19:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678246075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MG+emPX7mJCXZkl6Cr6yWLCcFG6GIk8J4ic4wm50wUs=;
        b=gwHanh3/+3jcVMEXte6zwnnreeVvlAGntpzYNNlhQ3m0tM9wm7rWZzX7U3mOYKnI/r
         gjdqy1lNCmj2OYl8DKQgkHxbKczJufnikis0x1b86T8GU4e3i94QJZ5a5HL9aIB38VX+
         hEWTMAIgzfTcUOehNXKDs7QZSWS3ZNnchiuMrc32ApZpQEp7+q9UC+sXuwLl1qO7m6di
         1wokNPuwJdUt/Q+DinlBURSAeMNMf8zccw1y10ipzzIxcxUnUsFLRcCf15qST/rY1ya9
         Z+xpnSqpq07lJTLhPqtasbunr0kNPJJ76TrNF9Ha/Ydzhv4xQHKxdKuZmySazyQ5CYB3
         mI4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678246075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MG+emPX7mJCXZkl6Cr6yWLCcFG6GIk8J4ic4wm50wUs=;
        b=cDCdbM9mBuf34aqWS2YBGXa9m/DyYA0Li4pac5ce2drUWoriWUllSI1mlpy7xptjPv
         NUA7ZAl2FbAkI4Z9prpfVPuLsMLYw401k0N2OJxiGju6J3AoyteYd/SLEMLu5bMCwsLs
         0co12o2/ClhShh0jowUTU/OEXf3yWboMpRbGgyPfzarqklmo6XVNmD5UCHlGXhn/x0g4
         GR7OF3ul0u1F2UU8tYYSh/UUqAGDPzAb0ZuAjHAkn0B+XJKsK2rCEwSZ5k62WfBCHShh
         g4puCziAAQOWMTcP7hQj+OMIgLPJcguLT6bkJCEA8CbSVicrgO9g2UH8EijB3jqSsvOe
         dkbw==
X-Gm-Message-State: AO0yUKUjh0WzBnqbvBfetl09Cq7r2juBX2O9DiKSn2I8382okOu5iDNV
        eV6kX/tW0W10jS3Rxw6CK9M=
X-Google-Smtp-Source: AK7set/gyvdCmRvWxyT7dMhBOzKnh6PWRLsfgAPuQBEkacCvkq/y7p/raE5mMHMQMnyKMwVDVJRDUg==
X-Received: by 2002:a05:6a00:cd:b0:5a8:cbcc:4b58 with SMTP id e13-20020a056a0000cd00b005a8cbcc4b58mr16717628pfj.12.1678246074792;
        Tue, 07 Mar 2023 19:27:54 -0800 (PST)
Received: from localhost ([113.161.42.54])
        by smtp.gmail.com with ESMTPSA id v24-20020a62a518000000b005dca6f0046dsm8827078pfm.12.2023.03.07.19.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 19:27:54 -0800 (PST)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, arnd@arndb.de, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: [PATCH v11 1/3] workingset: refactor LRU refault to expose refault recency check
Date:   Tue,  7 Mar 2023 19:27:46 -0800
Message-Id: <20230308032748.609510-2-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308032748.609510-1-nphamcs@gmail.com>
References: <20230308032748.609510-1-nphamcs@gmail.com>
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
 mm/workingset.c      | 145 +++++++++++++++++++++++++++++--------------
 2 files changed, 100 insertions(+), 46 deletions(-)

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
index 79585d55c45d..a60729c1b766 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -244,6 +244,29 @@ static void *lru_gen_eviction(struct folio *folio)
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
@@ -258,23 +281,22 @@ static void lru_gen_refault(struct folio *folio, void *shadow)
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
@@ -306,6 +328,12 @@ static void *lru_gen_eviction(struct folio *folio)
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
@@ -374,39 +402,34 @@ void *workingset_eviction(struct folio *folio, struct mem_cgroup *target_memcg)
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
@@ -483,7 +492,51 @@ void workingset_refault(struct folio *folio, void *shadow)
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
2.39.2
