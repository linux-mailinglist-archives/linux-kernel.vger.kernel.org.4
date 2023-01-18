Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87287670EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 01:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjARAmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 19:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjARAlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 19:41:31 -0500
Received: from mail-ot1-x34a.google.com (mail-ot1-x34a.google.com [IPv6:2607:f8b0:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD71E3BDB3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:45 -0800 (PST)
Received: by mail-ot1-x34a.google.com with SMTP id 46-20020a9d0331000000b00684ce0aa309so7650904otv.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 16:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fBsOlKlcuwYg1TO5fnMZqwWlWQzMMR0DkSccvt40dYk=;
        b=XayJErSb1aUIDJQCWLMV0aDRWh/VtUQOtmRqg/ZJxZnU40ttu0e9zM+Xhxtdl++5pZ
         lPE3P44X2Ej530Kl88sXanY2BnvXQKxEhrYGsF3QszLz1C4W4SMucbXVkGn/GRTAgsn2
         fFc12zaIEm71Lua2HdCr1jxbKNOSRWe49p+eLsRiILK9qxazoqtwDNvvc2+AMNizUPm2
         e+/XjaknM6u/pigZ5eKwgASGZNUD+/mH4qvaYvqulYP8AIKpFrvSNg+xpxnOuBFuUz7C
         HVMdu1disoW9P4vfqufI7AfwND1y3wI1M6ClDfOdPy2+sDpqlvuwiGDN617BzYG4SlL3
         kYvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fBsOlKlcuwYg1TO5fnMZqwWlWQzMMR0DkSccvt40dYk=;
        b=nttOwYamA1P+NOvfhiHpRdqrvAZoU3q+nmFpOHcGGok8uVfQNWNN+DodfioCf4GUj8
         4fi7zuFRYMqpDWXqwMdHHf11c9dul2ecL7v8SFXd260M7krf7jgIhTrsH0jcYxejZv4P
         ipBWBctfFZUutNSuJ1mjYWMdHXvnM5AOOOxLL7cjj3iEuN+AkWIL0R1FX5Yk+lFdLN19
         GToQibJLh3yBhsYQiphuzJGfS4PSSb6ABhXBFBsnq2n2oYq75OHZNgjGZCBzYB80fqbF
         wXlNbaEDgNwOfyRVoseC9+iPfnLMaZaOlBOCEi75YiGaeZcSfaCo4+icBxSjkAZe9rZa
         /8AA==
X-Gm-Message-State: AFqh2kqEVUbeTUf7F4AK1yZ46n0NjCTlGhdsjv5Zi5bD4C5URb/kYnMj
        mzQfVSkms3Dn4LflsoeczsRY4BVt9fDcfw==
X-Google-Smtp-Source: AMrXdXvyo6DW2fTIellOLWSjvwbbsAvYsTAnHGBC++acHS1loujh0p6QFwQu+rlsujM/lM0FuAgtv4WyxwJreA==
X-Received: from talumbau.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a05:6808:6d8:b0:35b:58e9:8890 with SMTP
 id m24-20020a05680806d800b0035b58e98890mr272274oih.243.1674001125047; Tue, 17
 Jan 2023 16:18:45 -0800 (PST)
Date:   Wed, 18 Jan 2023 00:18:23 +0000
In-Reply-To: <20230118001827.1040870-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230118001827.1040870-1-talumbau@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230118001827.1040870-4-talumbau@google.com>
Subject: [PATCH mm-unstable v1 3/7] mm: multi-gen LRU: section for Bloom filters
From:   "T.J. Alumbaugh" <talumbau@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com, "T.J. Alumbaugh" <talumbau@google.com>
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

Move Bloom filters code into a dedicated section. Improve the design
doc to explain Bloom filter usage and connection between aging and
eviction in their use.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 Documentation/mm/multigen_lru.rst |  16 +++
 mm/vmscan.c                       | 180 +++++++++++++++---------------
 2 files changed, 108 insertions(+), 88 deletions(-)

diff --git a/Documentation/mm/multigen_lru.rst b/Documentation/mm/multigen_lru.rst
index bd988a142bc2..770b5d539856 100644
--- a/Documentation/mm/multigen_lru.rst
+++ b/Documentation/mm/multigen_lru.rst
@@ -170,6 +170,22 @@ promotes hot pages. If the scan was done cacheline efficiently, it
 adds the PMD entry pointing to the PTE table to the Bloom filter. This
 forms a feedback loop between the eviction and the aging.
 
+Bloom Filters
+-------------
+Bloom filters are a space and memory efficient data structure for set
+membership test, i.e., test if an element is not in the set or may be
+in the set.
+
+In the eviction path, specifically, in ``lru_gen_look_around()``, if a
+PMD has a sufficient number of hot pages, its address is placed in the
+filter. In the aging path, set membership means that the PTE range
+will be scanned for young pages.
+
+Note that Bloom filters are probabilistic on set membership. If a test
+is false positive, the cost is an additional scan of a range of PTEs,
+which may yield hot pages anyway. Parameters of the filter itself can
+control the false positive rate in the limit.
+
 Summary
 -------
 The multi-gen LRU can be disassembled into the following parts:
diff --git a/mm/vmscan.c b/mm/vmscan.c
index eb9263bf6806..1be9120349f8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3233,6 +3233,98 @@ static bool __maybe_unused seq_is_valid(struct lruvec *lruvec)
 	       get_nr_gens(lruvec, LRU_GEN_ANON) <= MAX_NR_GENS;
 }
 
+/******************************************************************************
+ *                          Bloom filters
+ ******************************************************************************/
+
+/*
+ * Bloom filters with m=1<<15, k=2 and the false positive rates of ~1/5 when
+ * n=10,000 and ~1/2 when n=20,000, where, conventionally, m is the number of
+ * bits in a bitmap, k is the number of hash functions and n is the number of
+ * inserted items.
+ *
+ * Page table walkers use one of the two filters to reduce their search space.
+ * To get rid of non-leaf entries that no longer have enough leaf entries, the
+ * aging uses the double-buffering technique to flip to the other filter each
+ * time it produces a new generation. For non-leaf entries that have enough
+ * leaf entries, the aging carries them over to the next generation in
+ * walk_pmd_range(); the eviction also report them when walking the rmap
+ * in lru_gen_look_around().
+ *
+ * For future optimizations:
+ * 1. It's not necessary to keep both filters all the time. The spare one can be
+ *    freed after the RCU grace period and reallocated if needed again.
+ * 2. And when reallocating, it's worth scaling its size according to the number
+ *    of inserted entries in the other filter, to reduce the memory overhead on
+ *    small systems and false positives on large systems.
+ * 3. Jenkins' hash function is an alternative to Knuth's.
+ */
+#define BLOOM_FILTER_SHIFT	15
+
+static inline int filter_gen_from_seq(unsigned long seq)
+{
+	return seq % NR_BLOOM_FILTERS;
+}
+
+static void get_item_key(void *item, int *key)
+{
+	u32 hash = hash_ptr(item, BLOOM_FILTER_SHIFT * 2);
+
+	BUILD_BUG_ON(BLOOM_FILTER_SHIFT * 2 > BITS_PER_TYPE(u32));
+
+	key[0] = hash & (BIT(BLOOM_FILTER_SHIFT) - 1);
+	key[1] = hash >> BLOOM_FILTER_SHIFT;
+}
+
+static bool test_bloom_filter(struct lruvec *lruvec, unsigned long seq, void *item)
+{
+	int key[2];
+	unsigned long *filter;
+	int gen = filter_gen_from_seq(seq);
+
+	filter = READ_ONCE(lruvec->mm_state.filters[gen]);
+	if (!filter)
+		return true;
+
+	get_item_key(item, key);
+
+	return test_bit(key[0], filter) && test_bit(key[1], filter);
+}
+
+static void update_bloom_filter(struct lruvec *lruvec, unsigned long seq, void *item)
+{
+	int key[2];
+	unsigned long *filter;
+	int gen = filter_gen_from_seq(seq);
+
+	filter = READ_ONCE(lruvec->mm_state.filters[gen]);
+	if (!filter)
+		return;
+
+	get_item_key(item, key);
+
+	if (!test_bit(key[0], filter))
+		set_bit(key[0], filter);
+	if (!test_bit(key[1], filter))
+		set_bit(key[1], filter);
+}
+
+static void reset_bloom_filter(struct lruvec *lruvec, unsigned long seq)
+{
+	unsigned long *filter;
+	int gen = filter_gen_from_seq(seq);
+
+	filter = lruvec->mm_state.filters[gen];
+	if (filter) {
+		bitmap_clear(filter, 0, BIT(BLOOM_FILTER_SHIFT));
+		return;
+	}
+
+	filter = bitmap_zalloc(BIT(BLOOM_FILTER_SHIFT),
+			       __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
+	WRITE_ONCE(lruvec->mm_state.filters[gen], filter);
+}
+
 /******************************************************************************
  *                          mm_struct list
  ******************************************************************************/
@@ -3352,94 +3444,6 @@ void lru_gen_migrate_mm(struct mm_struct *mm)
 }
 #endif
 
-/*
- * Bloom filters with m=1<<15, k=2 and the false positive rates of ~1/5 when
- * n=10,000 and ~1/2 when n=20,000, where, conventionally, m is the number of
- * bits in a bitmap, k is the number of hash functions and n is the number of
- * inserted items.
- *
- * Page table walkers use one of the two filters to reduce their search space.
- * To get rid of non-leaf entries that no longer have enough leaf entries, the
- * aging uses the double-buffering technique to flip to the other filter each
- * time it produces a new generation. For non-leaf entries that have enough
- * leaf entries, the aging carries them over to the next generation in
- * walk_pmd_range(); the eviction also report them when walking the rmap
- * in lru_gen_look_around().
- *
- * For future optimizations:
- * 1. It's not necessary to keep both filters all the time. The spare one can be
- *    freed after the RCU grace period and reallocated if needed again.
- * 2. And when reallocating, it's worth scaling its size according to the number
- *    of inserted entries in the other filter, to reduce the memory overhead on
- *    small systems and false positives on large systems.
- * 3. Jenkins' hash function is an alternative to Knuth's.
- */
-#define BLOOM_FILTER_SHIFT	15
-
-static inline int filter_gen_from_seq(unsigned long seq)
-{
-	return seq % NR_BLOOM_FILTERS;
-}
-
-static void get_item_key(void *item, int *key)
-{
-	u32 hash = hash_ptr(item, BLOOM_FILTER_SHIFT * 2);
-
-	BUILD_BUG_ON(BLOOM_FILTER_SHIFT * 2 > BITS_PER_TYPE(u32));
-
-	key[0] = hash & (BIT(BLOOM_FILTER_SHIFT) - 1);
-	key[1] = hash >> BLOOM_FILTER_SHIFT;
-}
-
-static void reset_bloom_filter(struct lruvec *lruvec, unsigned long seq)
-{
-	unsigned long *filter;
-	int gen = filter_gen_from_seq(seq);
-
-	filter = lruvec->mm_state.filters[gen];
-	if (filter) {
-		bitmap_clear(filter, 0, BIT(BLOOM_FILTER_SHIFT));
-		return;
-	}
-
-	filter = bitmap_zalloc(BIT(BLOOM_FILTER_SHIFT),
-			       __GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN);
-	WRITE_ONCE(lruvec->mm_state.filters[gen], filter);
-}
-
-static void update_bloom_filter(struct lruvec *lruvec, unsigned long seq, void *item)
-{
-	int key[2];
-	unsigned long *filter;
-	int gen = filter_gen_from_seq(seq);
-
-	filter = READ_ONCE(lruvec->mm_state.filters[gen]);
-	if (!filter)
-		return;
-
-	get_item_key(item, key);
-
-	if (!test_bit(key[0], filter))
-		set_bit(key[0], filter);
-	if (!test_bit(key[1], filter))
-		set_bit(key[1], filter);
-}
-
-static bool test_bloom_filter(struct lruvec *lruvec, unsigned long seq, void *item)
-{
-	int key[2];
-	unsigned long *filter;
-	int gen = filter_gen_from_seq(seq);
-
-	filter = READ_ONCE(lruvec->mm_state.filters[gen]);
-	if (!filter)
-		return true;
-
-	get_item_key(item, key);
-
-	return test_bit(key[0], filter) && test_bit(key[1], filter);
-}
-
 static void reset_mm_stats(struct lruvec *lruvec, struct lru_gen_mm_walk *walk, bool last)
 {
 	int i;
-- 
2.39.0.314.g84b9a713c41-goog

