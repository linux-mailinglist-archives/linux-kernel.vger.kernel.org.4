Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643A270BBB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjEVLZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjEVLYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:24:32 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8D01FE6
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:21:21 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-564fb1018bcso21153957b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684754475; x=1687346475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cIw0V38F7EAw1HDE4zn4HtkfS4SFwenBLbiqkZiF2tk=;
        b=6rDOmfXOGOL1GW8BHq1lsmAkzsCgxjIn29uj6ZLID+SRaLqHrhM5DOXLA1DCB4iRhy
         a6Sk9ssRLW1lIRe1a08AwxJ0BAccFa/CgrcwVovKZQUfGQmd6jJ0qQPWDFU52nTje6Ve
         1q24H2eJS6v/mPNZCYJE19c+FSpEKqVmHIn36QwkuInYq6A35uygUpQ6n7qaQFOqi+vd
         GFbbq8j/7Gls9AgbMdbyd1j1SVhiG2e54nQdxqL740BwFA6P/sWV6/odg2s/pJ3Q699D
         5fHgG36i7bIXayaCDGk3RAO3su0zKcjC2JqYEecZCpk/VU295hRYwRTPKyfriu/y5jff
         zXAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684754475; x=1687346475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIw0V38F7EAw1HDE4zn4HtkfS4SFwenBLbiqkZiF2tk=;
        b=Md1jMwKvCOto2kXFvI411BQlWXlNhTR5Li2pnJOHWD8XUlfuTB9cbOVKI8Dw2Trm0v
         wI5h8oV5+VFs5YhP7zO30apuaNpJZpP5O6Hj0YLUv2HvgEVH7cgsEyhcvTwEjFMPJDZx
         UY+rxeMCntC5pqR2NOSbMhZx1esywbbD91iqlaODoFM3M6+7Rf938E8l1GKJZ1u3Frc5
         p3pHR2J6XeyNOsccOdPtAgjn6NfkFeJk7Apfw7A6K6Q3InV98rrlBzVvkL9of8IacHye
         wSXKl35R5iptGciE7FtH2Hvhuy6jOXkEPThVtkasWlCxuLV9c7XE4fojM0NqqCXKc9W8
         q5xQ==
X-Gm-Message-State: AC+VfDzCUXG+DDQv4L7Gj+xqHm9H6SPGv6DohSOWsPyATKJV9HOWdDsP
        XqW8as8xm3ax/VVdM1rbzlX0y2JHzbazRA==
X-Google-Smtp-Source: ACHHUZ4DoNgWjW81d3zb12J4YKX9fJCnoBsTiCFKxDr8tt1dmILx5fK2udZ/QgC3AM2KeSxtmeQ5pfTpZG18cA==
X-Received: from talumbau.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a81:dc01:0:b0:561:c98b:8e8e with SMTP id
 h1-20020a81dc01000000b00561c98b8e8emr6749837ywj.10.1684754475539; Mon, 22 May
 2023 04:21:15 -0700 (PDT)
Date:   Mon, 22 May 2023 11:20:58 +0000
In-Reply-To: <20230522112058.2965866-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230522112058.2965866-1-talumbau@google.com>
Message-ID: <20230522112058.2965866-4-talumbau@google.com>
Subject: [PATCH mm-unstable 4/4] mm: multi-gen LRU: cleanup lru_gen_test_recent()
From:   "T.J. Alumbaugh" <talumbau@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yuanchu Xie <yuanchu@google.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-mm@google.com, "T.J. Alumbaugh" <talumbau@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid passing memcg* and pglist_data* to lru_gen_test_recent()
since we only use the lruvec anyway.

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 mm/workingset.c | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/mm/workingset.c b/mm/workingset.c
index 90ae785d4c9c..5796e927e6d7 100644
--- a/mm/workingset.c
+++ b/mm/workingset.c
@@ -257,59 +257,46 @@ static void *lru_gen_eviction(struct folio *folio)
 
 /*
  * Tests if the shadow entry is for a folio that was recently evicted.
- * Fills in @memcgid, @pglist_data, @token, @workingset with the values
- * unpacked from shadow.
+ * Fills in @lruvec, @token, @workingset with the values unpacked from shadow.
  */
-static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
-		struct pglist_data **pgdat, unsigned long *token, bool *workingset)
+static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec **lruvec,
+				unsigned long *token, bool *workingset)
 {
-	struct mem_cgroup *eviction_memcg;
-	struct lruvec *lruvec;
-	struct lru_gen_folio *lrugen;
+	int memcg_id;
 	unsigned long min_seq;
+	struct mem_cgroup *memcg;
+	struct pglist_data *pgdat;
 
-	unpack_shadow(shadow, memcgid, pgdat, token, workingset);
-	eviction_memcg = mem_cgroup_from_id(*memcgid);
+	unpack_shadow(shadow, &memcg_id, &pgdat, token, workingset);
 
-	lruvec = mem_cgroup_lruvec(eviction_memcg, *pgdat);
-	lrugen = &lruvec->lrugen;
+	memcg = mem_cgroup_from_id(memcg_id);
+	*lruvec = mem_cgroup_lruvec(memcg, pgdat);
 
-	min_seq = READ_ONCE(lrugen->min_seq[file]);
+	min_seq = READ_ONCE((*lruvec)->lrugen.min_seq[file]);
 	return (*token >> LRU_REFS_WIDTH) == (min_seq & (EVICTION_MASK >> LRU_REFS_WIDTH));
 }
 
 static void lru_gen_refault(struct folio *folio, void *shadow)
 {
 	int hist, tier, refs;
-	int memcg_id;
 	bool workingset;
 	unsigned long token;
-	unsigned long min_seq;
 	struct lruvec *lruvec;
 	struct lru_gen_folio *lrugen;
-	struct mem_cgroup *memcg;
-	struct pglist_data *pgdat;
 	int type = folio_is_file_lru(folio);
 	int delta = folio_nr_pages(folio);
 
 	rcu_read_lock();
 
-	if (!lru_gen_test_recent(shadow, type, &memcg_id, &pgdat, &token,
-			&workingset))
+	if (!lru_gen_test_recent(shadow, type, &lruvec, &token, &workingset))
 		goto unlock;
 
-	memcg = folio_memcg_rcu(folio);
-	if (memcg_id != mem_cgroup_id(memcg))
+	if (lruvec != folio_lruvec(folio))
 		goto unlock;
 
-	if (pgdat != folio_pgdat(folio))
-		goto unlock;
-
-	lruvec = mem_cgroup_lruvec(memcg, pgdat);
 	lrugen = &lruvec->lrugen;
-	min_seq = READ_ONCE(lrugen->min_seq[type]);
 
-	hist = lru_hist_from_seq(min_seq);
+	hist = lru_hist_from_seq(READ_ONCE(lrugen->min_seq[type]));
 	/* see the comment in folio_lru_refs() */
 	refs = (token & (BIT(LRU_REFS_WIDTH) - 1)) + workingset;
 	tier = lru_tier_from_refs(refs);
@@ -339,8 +326,8 @@ static void *lru_gen_eviction(struct folio *folio)
 	return NULL;
 }
 
-static bool lru_gen_test_recent(void *shadow, bool file, int *memcgid,
-		struct pglist_data **pgdat, unsigned long *token, bool *workingset)
+static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec **lruvec,
+				unsigned long *token, bool *workingset)
 {
 	return false;
 }
@@ -435,8 +422,7 @@ bool workingset_test_recent(void *shadow, bool file, bool *workingset)
 	unsigned long eviction;
 
 	if (lru_gen_enabled())
-		return lru_gen_test_recent(shadow, file, &memcgid, &pgdat, &eviction,
-			workingset);
+		return lru_gen_test_recent(shadow, file, &eviction_lruvec, &eviction, workingset);
 
 	unpack_shadow(shadow, &memcgid, &pgdat, &eviction, workingset);
 	eviction <<= bucket_order;
-- 
2.40.1.698.g37aff9b760-goog

