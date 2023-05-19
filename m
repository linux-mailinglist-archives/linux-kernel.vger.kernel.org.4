Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E810370975F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjESMk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjESMkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:40:21 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7091D10D
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:40:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96f0678de80so584063166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 05:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1684500011; x=1687092011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I12hzcEozsRt6JPAOpJEFjq1ISq2RgZIT2QaHAH/cww=;
        b=GT59zzmhCzWRze5Mlw1ALcSFM9y1f9VU/vsZANEVBYHqrlCkXWWh82A+SSfKkAhcf4
         3tQ4UFzmxgxZ15dHaxAEnORekxc5TClUeKGWjmM3kIdHBVyDw4ORdXKtk4UyFNmyLKsx
         bPrrt63f3L9CI/VluEvxZgTjbObARXFRQrS6O0wUVIlJvsvAh4EhyRGdH/5mzFfSMvAU
         Ma2idKjNNvoYRHFytUI0nQaXf6rj3SDgQr9NpgZmmj7Yk6zkusJ3ACinYJ0FWUKgb/PF
         jUETXeREzOwQbPb+s4QGvIlHS2Hg954aU5qGVb5Th2SArEQNshM7l3a3RdF3R0fs+NVo
         k1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684500011; x=1687092011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I12hzcEozsRt6JPAOpJEFjq1ISq2RgZIT2QaHAH/cww=;
        b=S0E8WVigr6I4kZgbh5Q5UKSNyRk/yRSF2DvrSgmOUOJg0NbMUJDt70G+kcomsVCB4V
         ew3uK1AjBYgsIyYu/MH+Ru+pfFlr6vevuyci/e5VkcaIOmDwSA6qHOkxGo/GJxCuvu0z
         C+NmZ9oBlbTBA6wjd9lJfv6eqn0OD/MxLU8rcVJIxKF/ndJkcUZRLrm1v9Uj4uga2q0r
         ol12c058vVCS+B3qVT7QIWrdOs3dUCeb5Hu5ccYRla3B3GnJaOtszGP53QKzCMj8qjkq
         n7ybNTYSxHQ0h8m7U93aEEbtJ83ufXk1yDpGlKUQjGlxHGr4Mi03fsXWMLu1nsWusmbN
         k7xQ==
X-Gm-Message-State: AC+VfDz5S7WbBZh3rv8vnZwgUf7SLQ8UrshsXCQGocnZpWKpVzChR+WV
        LGdbfK8ZbTc23RGpYHlWR7yscw==
X-Google-Smtp-Source: ACHHUZ4u90+qy6wcMhun2oAgrbOIc2XjLRHqEiy1bSQkvwbZrSERksL8jCVIYbiTqqILkLPHJwuusA==
X-Received: by 2002:a17:907:5c7:b0:96a:ed6e:7d58 with SMTP id wg7-20020a17090705c700b0096aed6e7d58mr1561004ejb.7.1684500010821;
        Fri, 19 May 2023 05:40:10 -0700 (PDT)
Received: from localhost ([2a02:8070:6389:7d40:e266:3092:9afb:a7b1])
        by smtp.gmail.com with ESMTPSA id q26-20020a170906145a00b00966069b78absm2236221ejc.192.2023.05.19.05.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:40:10 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 4/5] mm: compaction: remove unnecessary is_via_compact_memory() checks
Date:   Fri, 19 May 2023 14:39:58 +0200
Message-Id: <20230519123959.77335-5-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230519123959.77335-1-hannes@cmpxchg.org>
References: <20230519123959.77335-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove from all paths not reachable via /proc/sys/vm/compact_memory.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/compaction.c | 11 +----------
 mm/vmscan.c     |  8 +-------
 2 files changed, 2 insertions(+), 17 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 8f61cfa87c49..83ecbc829c62 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2293,9 +2293,6 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 		unsigned long available;
 		unsigned long watermark;
 
-		if (is_via_compact_memory(order))
-			return true;
-
 		/* Allocation can already succeed, nothing to do */
 		watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
 		if (zone_watermark_ok(zone, order, watermark,
@@ -2850,9 +2847,6 @@ static bool kcompactd_node_suitable(pg_data_t *pgdat)
 		if (!populated_zone(zone))
 			continue;
 
-		if (is_via_compact_memory(pgdat->kcompactd_max_order))
-			return true;
-
 		/* Allocation can already succeed, check other zones */
 		if (zone_watermark_ok(zone, pgdat->kcompactd_max_order,
 				      min_wmark_pages(zone),
@@ -2897,9 +2891,6 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		if (compaction_deferred(zone, cc.order))
 			continue;
 
-		if (is_via_compact_memory(cc.order))
-			goto compact;
-
 		/* Allocation can already succeed, nothing to do */
 		if (zone_watermark_ok(zone, cc.order,
 				      min_wmark_pages(zone), zoneid, 0))
@@ -2908,7 +2899,7 @@ static void kcompactd_do_work(pg_data_t *pgdat)
 		if (compaction_suitable(zone, cc.order,
 					zoneid) != COMPACT_CONTINUE)
 			continue;
-compact:
+
 		if (kthread_should_stop())
 			return;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index c9c0f3e081f5..c0cfa9b86b48 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6397,9 +6397,6 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 		if (!managed_zone(zone))
 			continue;
 
-		if (sc->order == -1) /* is_via_compact_memory() */
-			return false;
-
 		/* Allocation can already succeed, nothing to do */
 		if (zone_watermark_ok(zone, sc->order, min_wmark_pages(zone),
 				      sc->reclaim_idx, 0))
@@ -6596,9 +6593,6 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 {
 	unsigned long watermark;
 
-	if (sc->order == -1) /* is_via_compact_memory() */
-		goto suitable;
-
 	/* Allocation can already succeed, nothing to do */
 	if (zone_watermark_ok(zone, sc->order, min_wmark_pages(zone),
 			      sc->reclaim_idx, 0))
@@ -6608,7 +6602,7 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 	if (compaction_suitable(zone, sc->order,
 				sc->reclaim_idx) == COMPACT_SKIPPED)
 		return false;
-suitable:
+
 	/*
 	 * Compaction is already possible, but it takes time to run and there
 	 * are potentially other callers using the pages just freed. So proceed
-- 
2.40.0

