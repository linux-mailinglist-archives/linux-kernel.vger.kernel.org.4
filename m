Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E64737921
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjFUCbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjFUCbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:31:03 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD275B7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:30:57 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-25edb0c31ccso1494020a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687314656; x=1689906656;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zMvVDCIqwutYRW7BL6wWIoprb3WJoHOr+n8+HE8xmyM=;
        b=rmtJdI5G1/6wEp0nVhAgxso+a3Mm7glgZlr7ICu1hFJ9UoSvLcjsh3iroBWHa+roOa
         AlXXj0ZNZ4hSg/+DDCeZOJVVN2p7j+QQybGU9VsOYiep+h1HWn88LZQitJlFD4XqaV2c
         Id+3mXdrhiILKsof5gCOVh6cJIaFI9CVt7E8nxPUB8QfNhtwY8SlyJKpf6YXzxx2X/sC
         LphIp6fDHG1B1niycXyy0t/qCTXgGgCkYmuLNeONUblJoGNRa541t5sR+YcFNYs1Cax4
         S4EQ9LBP0i8YH17eUqtGY9s2I8q3AgmHKcG+FUBveB69EbKNh8UKtWihNq7wWxRTJ3Ew
         q/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314656; x=1689906656;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zMvVDCIqwutYRW7BL6wWIoprb3WJoHOr+n8+HE8xmyM=;
        b=KrZbuobo1o2GLgk/DP0uzH3aRl9CM6oIhEJdf3AQ0L6J8/ctXr9s3jcxa6LfbzFIVl
         CJUeN1HxsR8VmDzhcjV1U4eQO4VnWjND64DbGtk/5OEB9EMDmSHq1HLmRjvJ/OMR9S8q
         CwdUlz/tuA+ai5MqeXikZpSKMqxZPXpRq5N8xWnYCdCJZVWE0ko6EqlhMLGyEslLDS6A
         1FsRa3V7g7dEqjx37+4AcwTTMcBiNtkIZ+Hw8H9zJQlpWXXyy7pCrvElWHgrQgx9MZWt
         8J0xApe4tUNdxEFK5AkfJRntWFYShQakDrLA0Z34giqWlHuNRyG04MOubRq+KMLZos63
         O4+g==
X-Gm-Message-State: AC+VfDxZgY5+BVjkDuJUuCZVwL1iW4rX6cInBUXCctWdaJxIC1cyWMVi
        b2mru2nSZE+GcyO9NN+avAkY58UveTvAH3gU
X-Google-Smtp-Source: ACHHUZ4wvD8NisRGZkbCm16bHHzOVT6pr5ElJPtaQQsrB+7eK5uc4EwB8Wn4MiiBKHnFztWWKZDJEm0QnPReByj0
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90b:78b:b0:25f:612:b17e with SMTP
 id l11-20020a17090b078b00b0025f0612b17emr1096620pjz.7.1687314656443; Tue, 20
 Jun 2023 19:30:56 -0700 (PDT)
Date:   Wed, 21 Jun 2023 02:30:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621023053.432374-1-yosryahmed@google.com>
Subject: [PATCH 1/2] mm: memcg: rename and document global_reclaim()
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosryahmed@google.com>
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

Evidently, global_reclaim() can be a confusing name. Especially that it
used to exist before with a subtly different definition (removed by
commit b5ead35e7e1d ("mm: vmscan: naming fixes: global_reclaim() and
sane_reclaim()"). It can be interpreted as non-cgroup reclaim, even
though it returns true for cgroup reclaim on the root memcg
(through memory.reclaim).

Rename it to root_reclaim() in an attempt to make it less ambiguous, and
add documentation to it as well as cgroup_reclaim.

Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Closes: https://lore.kernel.org/lkml/20230405200150.GA35884@cmpxchg.org/
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/vmscan.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index e305c11ec8fc..0dbbf718c53e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -445,12 +445,17 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 	mutex_unlock(&shrinker_mutex);
 }
 
+/* Returns true for reclaim through cgroup limits or cgroup interfaces. */
 static bool cgroup_reclaim(struct scan_control *sc)
 {
 	return sc->target_mem_cgroup;
 }
 
-static bool global_reclaim(struct scan_control *sc)
+/*
+ * Returns true for reclaim on the root cgroup. This is true for direct
+ * allocator reclaim and reclaim through cgroup interfaces on the root cgroup.
+ */
+static bool root_reclaim(struct scan_control *sc)
 {
 	return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->target_mem_cgroup);
 }
@@ -505,7 +510,7 @@ static bool cgroup_reclaim(struct scan_control *sc)
 	return false;
 }
 
-static bool global_reclaim(struct scan_control *sc)
+static bool root_reclaim(struct scan_control *sc)
 {
 	return true;
 }
@@ -562,7 +567,7 @@ static void flush_reclaim_state(struct scan_control *sc)
 	 * memcg reclaim, to make reporting more accurate and reduce
 	 * underestimation, but it's probably not worth the complexity for now.
 	 */
-	if (current->reclaim_state && global_reclaim(sc)) {
+	if (current->reclaim_state && root_reclaim(sc)) {
 		sc->nr_reclaimed += current->reclaim_state->reclaimed;
 		current->reclaim_state->reclaimed = 0;
 	}
@@ -5339,7 +5344,7 @@ static long get_nr_to_scan(struct lruvec *lruvec, struct scan_control *sc, bool
 static unsigned long get_nr_to_reclaim(struct scan_control *sc)
 {
 	/* don't abort memcg reclaim to ensure fairness */
-	if (!global_reclaim(sc))
+	if (!root_reclaim(sc))
 		return -1;
 
 	return max(sc->nr_to_reclaim, compact_gap(sc->order));
@@ -5491,7 +5496,7 @@ static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc
 {
 	struct blk_plug plug;
 
-	VM_WARN_ON_ONCE(global_reclaim(sc));
+	VM_WARN_ON_ONCE(root_reclaim(sc));
 	VM_WARN_ON_ONCE(!sc->may_writepage || !sc->may_unmap);
 
 	lru_add_drain();
@@ -5552,7 +5557,7 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 	struct blk_plug plug;
 	unsigned long reclaimed = sc->nr_reclaimed;
 
-	VM_WARN_ON_ONCE(!global_reclaim(sc));
+	VM_WARN_ON_ONCE(!root_reclaim(sc));
 
 	/*
 	 * Unmapped clean folios are already prioritized. Scanning for more of
@@ -6274,7 +6279,7 @@ static void shrink_lruvec(struct lruvec *lruvec, struct scan_control *sc)
 	bool proportional_reclaim;
 	struct blk_plug plug;
 
-	if (lru_gen_enabled() && !global_reclaim(sc)) {
+	if (lru_gen_enabled() && !root_reclaim(sc)) {
 		lru_gen_shrink_lruvec(lruvec, sc);
 		return;
 	}
@@ -6515,7 +6520,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	struct lruvec *target_lruvec;
 	bool reclaimable = false;
 
-	if (lru_gen_enabled() && global_reclaim(sc)) {
+	if (lru_gen_enabled() && root_reclaim(sc)) {
 		lru_gen_shrink_node(pgdat, sc);
 		return;
 	}
-- 
2.41.0.162.gfafddb0af9-goog

