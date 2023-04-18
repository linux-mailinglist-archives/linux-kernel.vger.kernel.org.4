Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACB96E6CD8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjDRTPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjDRTOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:14:07 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C3BAF03
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:49 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id m21so19410750qtg.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845228; x=1684437228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kWGHSuKTgkf/KcYFfj9Qt8QOcgzsovuy8ycEW8Qbl8=;
        b=KFvVKf3QkfWQMBDUHAZr4VeBeoisE8O1GGsOodjwgMNuADxrQdnvk+SbprdpW2IP5r
         ag93cZ6VTR9I76TSMGwf5woII5HGfN9l2WN88UYR1tzcnTBufAlpM3lp/xMmNVG97M43
         eNnVONsHRxzcPVv/iZgrUj1Uz8RGQ4JjzKnpXZZNAJj/FsvWfEp9h8m3xbiQ4JGMIzXh
         Wd0SEOETtzw6tJD+77T1b7ruvzZOu+Nz8JErUfQPxnwB2Zm75Cbp78ju67EmWgaNaQRd
         j09JTsw/mPs41GthMRykMfarC7ahjfxAE2/z8L+r1gArqpDDy8cskY5OjwSOMNK5kLZu
         3VpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845228; x=1684437228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kWGHSuKTgkf/KcYFfj9Qt8QOcgzsovuy8ycEW8Qbl8=;
        b=jSONX7j92+MSG+GmHkB8ljJ/uXXzpWlkGQ+w1PdtwANCmEUguApYPmYIvSNQLAZ1uw
         HEtayMbn6AoVryuZ/1kGSi24nhQe/4yIlhHfkLCFACOocVFTmyKgiQB7/yPisbMTt7ad
         kVRM0i88BwqJEiuju/86lazFT5nnk15+nllZvFPdiAu+38UuHGEFRLpEZ0IH2uVH5q49
         EXV+G9QXcE8oB6GiGUCEk9SGvJSbRII+cIscRtiVlaPbuXWffN8X3O4GrWEiGQQ8kz0J
         CutmGuh0On1X0mPQLRBNbwia55AC2kDIuF086hVq+fEA1P7wvftIq6+n1lgdgtu6YL07
         A+zA==
X-Gm-Message-State: AAQBX9c9s25b2uK0AO8wxPxgZSBlc4xkxSyeoXcRcxuBdRA6o44h2gOK
        zG5oPz3E90H6TNTofZ/GA21vxA==
X-Google-Smtp-Source: AKy350ZnZudpfigs0VHBHaysAID+48G8C5CQkmg6KTT32vxOaKM82OTa8s5aOXsXXAzcGRMb+jKq5A==
X-Received: by 2002:ac8:5f0b:0:b0:3e6:4069:9136 with SMTP id x11-20020ac85f0b000000b003e640699136mr1124473qta.45.1681845228420;
        Tue, 18 Apr 2023 12:13:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id x6-20020ac84d46000000b003ef231cceeasm1122594qtv.23.2023.04.18.12.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:48 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 25/26] mm: page_alloc: disallow fallbacks when 2M defrag is enabled
Date:   Tue, 18 Apr 2023 15:13:12 -0400
Message-Id: <20230418191313.268131-26-hannes@cmpxchg.org>
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

Fallbacks are already unlikely due to watermarks being enforced
against MIGRATE_FREE blocks. Eliminate them altogether. This allows
compaction to look exclusively at movable blocks, reducing the number
of pageblocks it needs to scan on an ongoing basis.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/compaction.c | 52 +++++--------------------------------------------
 mm/internal.h   |  2 +-
 mm/page_alloc.c |  8 ++++++++
 3 files changed, 14 insertions(+), 48 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index e33c99eb34a8..37dfd1878bef 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1258,46 +1258,6 @@ isolate_migratepages_range(struct compact_control *cc, unsigned long start_pfn,
 #endif /* CONFIG_COMPACTION || CONFIG_CMA */
 #ifdef CONFIG_COMPACTION
 
-static bool suitable_migration_source(struct compact_control *cc,
-							struct page *page)
-{
-	int block_mt;
-
-	if (pageblock_skip_persistent(page))
-		return false;
-
-	if ((cc->mode != MIGRATE_ASYNC) || !cc->direct_compaction)
-		return true;
-
-	block_mt = get_pageblock_migratetype(page);
-
-	if (cc->migratetype == MIGRATE_MOVABLE)
-		return is_migrate_movable(block_mt);
-	else
-		return block_mt == cc->migratetype;
-}
-
-/* Returns true if the page is within a block suitable for migration to */
-static bool suitable_migration_target(struct compact_control *cc,
-							struct page *page)
-{
-	int mt = get_pageblock_migratetype(page);
-
-	/* If the page is a large free page, then disallow migration */
-	if (mt == MIGRATE_FREE)
-		return false;
-
-	if (cc->ignore_block_suitable)
-		return true;
-
-	/* If the block is MIGRATE_MOVABLE or MIGRATE_CMA, allow migration */
-	if (is_migrate_movable(mt))
-		return true;
-
-	/* Otherwise skip the block */
-	return false;
-}
-
 static inline unsigned int
 freelist_scan_limit(struct compact_control *cc)
 {
@@ -1620,7 +1580,7 @@ static void isolate_freepages(struct compact_control *cc)
 			continue;
 
 		/* Check the block is suitable for migration */
-		if (!suitable_migration_target(cc, page))
+		if (!is_migrate_movable(get_pageblock_migratetype(page)))
 			continue;
 
 		/* If isolation recently failed, do not retry */
@@ -1927,14 +1887,12 @@ static isolate_migrate_t isolate_migratepages(struct compact_control *cc)
 			continue;
 
 		/*
-		 * For async direct compaction, only scan the pageblocks of the
-		 * same migratetype without huge pages. Async direct compaction
-		 * is optimistic to see if the minimum amount of work satisfies
-		 * the allocation. The cached PFN is updated as it's possible
-		 * that all remaining blocks between source and target are
+		 * The cached PFN is updated as it's possible that all
+		 * remaining blocks between source and target are
 		 * unsuitable and the compaction scanners fail to meet.
 		 */
-		if (!suitable_migration_source(cc, page)) {
+		if (pageblock_skip_persistent(page) ||
+		    !is_migrate_movable(get_pageblock_migratetype(page))) {
 			update_cached_migrate(cc, block_end_pfn);
 			continue;
 		}
diff --git a/mm/internal.h b/mm/internal.h
index 24f43f5db88b..1c0886c3ce0e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -741,7 +741,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_HIGH		 0x20 /* __GFP_HIGH set */
 #define ALLOC_CPUSET		 0x40 /* check for correct cpuset */
 #define ALLOC_CMA		 0x80 /* allow allocations from CMA areas */
-#ifdef CONFIG_ZONE_DMA32
+#if defined(CONFIG_ZONE_DMA32) && !defined(CONFIG_COMPACTION)
 #define ALLOC_NOFRAGMENT	0x100 /* avoid mixing pageblock types */
 #else
 #define ALLOC_NOFRAGMENT	  0x0
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f835a5548164..9db588a1de3b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2622,11 +2622,19 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
  *
  * The other migratetypes do not have fallbacks.
  */
+#ifdef CONFIG_COMPACTION
+static int fallbacks[MIGRATE_TYPES][2] = {
+	[MIGRATE_UNMOVABLE]   = { MIGRATE_FREE, MIGRATE_TYPES },
+	[MIGRATE_MOVABLE]     = { MIGRATE_FREE, MIGRATE_TYPES },
+	[MIGRATE_RECLAIMABLE] = { MIGRATE_FREE, MIGRATE_TYPES },
+};
+#else
 static int fallbacks[MIGRATE_TYPES][4] = {
 	[MIGRATE_UNMOVABLE]   = { MIGRATE_FREE, MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRATE_TYPES },
 	[MIGRATE_MOVABLE]     = { MIGRATE_FREE, MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_TYPES },
 	[MIGRATE_RECLAIMABLE] = { MIGRATE_FREE, MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   MIGRATE_TYPES },
 };
+#endif
 
 #ifdef CONFIG_CMA
 static __always_inline struct page *__rmqueue_cma_fallback(struct zone *zone,
-- 
2.39.2

