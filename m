Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39070737922
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjFUCbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFUCbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:31:05 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D859DB4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:31:03 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-25ed75fef0bso1550169a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687314663; x=1689906663;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2i6mxBMLlJpzwoYg2wZeOmq9J33Dk9/METQ7rddthzM=;
        b=fWo8m3veR2+Dh+41IRQkxot7E9H5Ga0natg38/c0ovy3NMSgF6qfN6kDIT+W9hDXdj
         sw5fhmDrn1cK0HoWCYIcUSV97oWVwJkVAsBLBO7AaRkjzY6oMV67Iy4VkWEmfaSIeSZQ
         RANT9wo3kWJhyolFjka1xQ/WnPo0lfX7WqbzhY0c/sZUyNywus125YAWCLcppYbbXDCr
         X855SxEMuvPSzjupi059z6GzFkyvoiaYeBHHWlRU+lkE17YcSGzWDStJUjN2RWO4bgll
         di12bINaMXyQfybzv0UdvIUcTu5EJjIT4+3Auw0prdWke+9ChOadWEGhIiEpHuMUA09s
         qO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687314663; x=1689906663;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2i6mxBMLlJpzwoYg2wZeOmq9J33Dk9/METQ7rddthzM=;
        b=AX4tpNggf8BttMq67yqqoP1lnfbL3qToz99A1G65lpl2LuVR8JVjgnX9j5+TcCnZl3
         fYfCRt+O39/wapZnBmX8FmXcT4rXleSnvabx7vZQ1cUij8mNOKIXfsTGGi3lHse30GWV
         8ZTy2dDXImPRbcbc0zyWijEU2+7BplULFAT29sbxC8+gQ8/guQAot5BhN0rWCM3NUznW
         W1tYA6ZaDHR7CfX4gtHNvz1cR885ayW7VhxEjwxdTHFwjOK6ok44NrZjglpzbC+jUz8+
         +5VFc/Ij8gKE+gzPg+oO7rio6Q+VGDcyv7FjGXovijF3Q9VqqaMitjPpUMPYwun7Xmau
         nlmw==
X-Gm-Message-State: AC+VfDz8y4Mma8vs3JuQTdODSclfCOYO37GLT4USY71iGNSVlxSIVgP3
        EtyAs2SKwn74rdIQfc9jlsXheleUmlppygA0
X-Google-Smtp-Source: ACHHUZ4wSiyW43/DbwdPIXmiSBoQP0oMQm+KTVuk3m/PT1ybCYpY9GCI1fNtqyYn2IN9N0HQBmdZQq3mQbNPrPaO
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:dac4:b0:25b:c272:ab34 with SMTP
 id g4-20020a17090adac400b0025bc272ab34mr1914359pjx.7.1687314663432; Tue, 20
 Jun 2023 19:31:03 -0700 (PDT)
Date:   Wed, 21 Jun 2023 02:31:01 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230621023101.432780-1-yosryahmed@google.com>
Subject: [PATCH 2/2] mm/vmscan: fix root proactive reclaim unthrottling
 unbalanced node
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

When memory.reclaim was introduced, it became the first case where
cgroup_reclaim() is true for the root cgroup. Johannes concluded [1]
that for most cases this is okay, except for one case. Historically,
kswapd would throttle reclaim on a node if a lot of pages marked for
reclaim are under writeback (aka the node is congested). This occurred
by setting LRUVEC_CONGESTED bit in lruvec->flags. The bit would be
cleared when the node is balanced.

Similarly, cgroup reclaim would set the same bit when an lruvec is
congested, and clear it on the way out of reclaim (to throttle local
reclaimers).

Before the introduction of memory.reclaim, the root memcg was the only
target of kswapd reclaim, and non-root memcgs were the only targets of
cgroup reclaim, so they would never interfere. Using the same bit for
both was fine. After memory.reclaim, it is possible for cgroup reclaim
on the root cgroup to clear the bit set by kswapd. This would result in
reclaim on the node to be unthrottled before the node is balanced.

Fix this by introducing separate bits for cgroup-level and node-level
congestion. kswapd can unthrottle an lruvec that is marked as congested
by cgroup reclaim (as the entire node should no longer be congested),
but not vice versa (to prevent premature unthrottling before the entire
node is balanced).

[1]https://lore.kernel.org/lkml/20230405200150.GA35884@cmpxchg.org/

Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Closes: https://lore.kernel.org/lkml/20230405200150.GA35884@cmpxchg.org/
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 include/linux/mmzone.h | 18 +++++++++++++++---
 mm/vmscan.c            | 19 ++++++++++++-------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 3e822335f214..d863698a84e0 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -293,9 +293,21 @@ static inline bool is_active_lru(enum lru_list lru)
 #define ANON_AND_FILE 2
 
 enum lruvec_flags {
-	LRUVEC_CONGESTED,		/* lruvec has many dirty pages
-					 * backed by a congested BDI
-					 */
+	/*
+	 * An lruvec has many dirty pages backed by a congested BDI:
+	 * 1. LRUVEC_CGROUP_CONGESTED is set by cgroup-level reclaim.
+	 *    It can be cleared by cgroup reclaim or kswapd.
+	 * 2. LRUVEC_NODE_CONGESTED is set by kswapd node-level reclaim.
+	 *    It can only be cleared by kswapd.
+	 *
+	 * Essentially, kswapd can unthrottle an lruvec throttled by cgroup
+	 * reclaim, but not vice versa. This only applies to the root cgroup.
+	 * The goal is to prevent cgroup reclaim on the root cgroup (e.g.
+	 * memory.reclaim) to unthrottle an unbalanced node (that was throttled
+	 * by kswapd).
+	 */
+	LRUVEC_CGROUP_CONGESTED,
+	LRUVEC_NODE_CONGESTED,
 };
 
 #endif /* !__GENERATING_BOUNDS_H */
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0dbbf718c53e..c22e4e7368da 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6592,10 +6592,13 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 * Legacy memcg will stall in page writeback so avoid forcibly
 	 * stalling in reclaim_throttle().
 	 */
-	if ((current_is_kswapd() ||
-	     (cgroup_reclaim(sc) && writeback_throttling_sane(sc))) &&
-	    sc->nr.dirty && sc->nr.dirty == sc->nr.congested)
-		set_bit(LRUVEC_CONGESTED, &target_lruvec->flags);
+	if (sc->nr.dirty && sc->nr.dirty == sc->nr.congested) {
+		if (cgroup_reclaim(sc) && writeback_throttling_sane(sc))
+			set_bit(LRUVEC_CGROUP_CONGESTED, &target_lruvec->flags);
+
+		if (current_is_kswapd())
+			set_bit(LRUVEC_NODE_CONGESTED, &target_lruvec->flags);
+	}
 
 	/*
 	 * Stall direct reclaim for IO completions if the lruvec is
@@ -6605,7 +6608,8 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 	 */
 	if (!current_is_kswapd() && current_may_throttle() &&
 	    !sc->hibernation_mode &&
-	    test_bit(LRUVEC_CONGESTED, &target_lruvec->flags))
+	    (test_bit(LRUVEC_CGROUP_CONGESTED, &target_lruvec->flags) ||
+	     test_bit(LRUVEC_NODE_CONGESTED, &target_lruvec->flags)))
 		reclaim_throttle(pgdat, VMSCAN_THROTTLE_CONGESTED);
 
 	if (should_continue_reclaim(pgdat, nr_node_reclaimed, sc))
@@ -6862,7 +6866,7 @@ static unsigned long do_try_to_free_pages(struct zonelist *zonelist,
 
 			lruvec = mem_cgroup_lruvec(sc->target_mem_cgroup,
 						   zone->zone_pgdat);
-			clear_bit(LRUVEC_CONGESTED, &lruvec->flags);
+			clear_bit(LRUVEC_CGROUP_CONGESTED, &lruvec->flags);
 		}
 	}
 
@@ -7251,7 +7255,8 @@ static void clear_pgdat_congested(pg_data_t *pgdat)
 {
 	struct lruvec *lruvec = mem_cgroup_lruvec(NULL, pgdat);
 
-	clear_bit(LRUVEC_CONGESTED, &lruvec->flags);
+	clear_bit(LRUVEC_NODE_CONGESTED, &lruvec->flags);
+	clear_bit(LRUVEC_CGROUP_CONGESTED, &lruvec->flags);
 	clear_bit(PGDAT_DIRTY, &pgdat->flags);
 	clear_bit(PGDAT_WRITEBACK, &pgdat->flags);
 }
-- 
2.41.0.162.gfafddb0af9-goog

