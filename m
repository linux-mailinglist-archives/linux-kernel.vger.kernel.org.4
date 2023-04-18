Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152796E6CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjDRTOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjDRTOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:04 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF177AAC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:38 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id u37so5543976qtc.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845217; x=1684437217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1QAyddYnWJUKuKAIak/itfaS7Ph3sBa4ofaAGmayWk=;
        b=ROm0ArlPuXBY1EzWc/8PRgqaTVBI+lb7icLJ0Q57BP9ugdMTZmrUmryBS96SSVH9Nh
         eeLrq3q4kINpOOeYwSiqOxAJrdmOgMg80zVTThvjx9VkzE5k0WCPil9tESj3Hku5cLuy
         SPJk1gyPDWl9cU4d7hzMlhCvpJn6xdGkNXplbkrtzq0OiV6LSdAYuNrP+KJa/f3MP5dx
         4wKlDRUsNPqCre2MCxjIRsO9xKT8/coTjpyJXWIkKBFyHmv7zdnJQKHUNs+zIEe6gm+0
         cTwYRc8KLsJOFaKN9aFOQI6B99BvcPA5pw+NCRvbGraHEF3iyw5uVssKuGhFRoPeJkSZ
         mtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845217; x=1684437217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1QAyddYnWJUKuKAIak/itfaS7Ph3sBa4ofaAGmayWk=;
        b=a/3MVAwYaenWGRkNW+3s+HwVmndtlicBXR8l69mZCam7rrAZ3xYX6Z5K+HJbdtCr+w
         qBBzimbzK3qAnHMll4HiGdW5X7xZ3CdnYm0EAkgnfVD11axqGBlonu+bhcQ2GFKpA2N8
         WNOtygLpubWcc6b76v5Ox0I/2Kxkbp2j0WhSXXpK7EHQxnMutvXKS8qcbCuqltVdustu
         w4FhX05SymI7z/5JkLA+GLLHIoOJxnN4kqHV2bDNFM1YQdbutedlaNhHCzEQ1GuniIkc
         hn1TOOQT6nOPGKONDyDYNe+yvojh2aX4hdVQSJ3C4+J6mBsTjlTAKE44J8H2/cg+yJl5
         PmPA==
X-Gm-Message-State: AAQBX9dOkVdTwji/zz3D/cgesxFmiTPRrLy9hZyQDygRf2wevTnL62rW
        U7KnBJpiMmZuxtV+Bl9B8fH4eg==
X-Google-Smtp-Source: AKy350ZUW/3fdavMXIT1x5ul2i8OAycLqVKqq8/q+G7rUbGTG7TjkJBhgSj/nJexX1DU7fRe/5Ryig==
X-Received: by 2002:a05:622a:1703:b0:3e4:deff:4634 with SMTP id h3-20020a05622a170300b003e4deff4634mr1499645qtk.24.1681845217590;
        Tue, 18 Apr 2023 12:13:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id w4-20020ac86b04000000b003e64d076256sm4281417qts.51.2023.04.18.12.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:37 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 16/26] mm: compaction: improve compaction_suitable() accuracy
Date:   Tue, 18 Apr 2023 15:13:03 -0400
Message-Id: <20230418191313.268131-17-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230418191313.268131-1-hannes@cmpxchg.org>
References: <20230418191313.268131-1-hannes@cmpxchg.org>
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

With the new per-mt free counts, compaction can check the watermarks
specifically against suitable migration targets. This ensures reclaim
keeps going when the free pages are in blocks that aren't actually
suitable migration targets: MIGRATE_FREE, UNMOVABLE, RECLAIMABLE.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/compaction.c | 23 +++++++++++++++--------
 mm/vmscan.c     |  7 +++++--
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index b9eed0d43403..f637b4ed7f3c 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2226,11 +2226,17 @@ enum compact_result compaction_suitable(struct zone *zone, int order,
 					unsigned int alloc_flags,
 					int highest_zoneidx)
 {
+	unsigned long free_pages;
 	enum compact_result ret;
 	int fragindex;
 
-	ret = __compaction_suitable(zone, order, alloc_flags, highest_zoneidx,
-				    zone_page_state(zone, NR_FREE_PAGES));
+	/* Suitable migration targets */
+	free_pages = zone_page_state(zone, NR_FREE_MOVABLE);
+	free_pages += zone_page_state(zone, NR_FREE_CMA_PAGES);
+
+	ret = __compaction_suitable(zone, order, alloc_flags,
+				    highest_zoneidx, free_pages);
+
 	/*
 	 * fragmentation index determines if allocation failures are due to
 	 * low memory or external fragmentation
@@ -2273,19 +2279,20 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 	for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
 				ac->highest_zoneidx, ac->nodemask) {
 		unsigned long available;
-		enum compact_result compact_result;
 
+		available = zone_page_state_snapshot(zone, NR_FREE_MOVABLE);
+		available += zone_page_state_snapshot(zone, NR_FREE_CMA_PAGES);
 		/*
 		 * Do not consider all the reclaimable memory because we do not
 		 * want to trash just for a single high order allocation which
 		 * is even not guaranteed to appear even if __compaction_suitable
 		 * is happy about the watermark check.
 		 */
-		available = zone_reclaimable_pages(zone) / order;
-		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
-		compact_result = __compaction_suitable(zone, order, alloc_flags,
-				ac->highest_zoneidx, available);
-		if (compact_result == COMPACT_CONTINUE)
+		available += zone_reclaimable_pages(zone) / order;
+
+		if (__compaction_suitable(zone, order, alloc_flags,
+					  ac->highest_zoneidx,
+					  available) == COMPACT_CONTINUE)
 			return true;
 	}
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5b7b8d4f5297..9ecf29f4dab8 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -6270,6 +6270,7 @@ static void shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 {
 	unsigned long watermark;
+	unsigned long free_pages;
 	enum compact_result suitable;
 
 	suitable = compaction_suitable(zone, sc->order, 0, sc->reclaim_idx);
@@ -6290,8 +6291,10 @@ static inline bool compaction_ready(struct zone *zone, struct scan_control *sc)
 	 * we are already above the high+gap watermark, don't reclaim at all.
 	 */
 	watermark = high_wmark_pages(zone) + compact_gap(sc->order);
-
-	return zone_watermark_ok_safe(zone, 0, watermark, sc->reclaim_idx);
+	free_pages = zone_page_state_snapshot(zone, NR_FREE_MOVABLE);
+	free_pages += zone_page_state_snapshot(zone, NR_FREE_CMA_PAGES);
+	return __zone_watermark_ok(zone, 0, watermark, sc->reclaim_idx,
+				   ALLOC_CMA, free_pages);
 }
 
 static void consider_reclaim_throttle(pg_data_t *pgdat, struct scan_control *sc)
-- 
2.39.2

