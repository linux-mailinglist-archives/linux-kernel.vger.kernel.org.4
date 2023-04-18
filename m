Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC846E6CBF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjDRTOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjDRTNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:13:32 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A779ABBB5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:22 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id a15so7394815qvn.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 12:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1681845201; x=1684437201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+u1UuZT1pIMEXypNrA+9XQUlZTAHYDviJjF8gqonVQU=;
        b=SR96bpw9MNAx3LCxCgWDO8w9zD5dt4ByUGuuyAnVydDGhAmlwQbHzS187awsb5xwdO
         3E5aqY4YcBiZQTeoz3fQUkUokUCWEDRMjGydvXec0gcHjnJOsbk/0vKlUc/tnBFoT/0C
         kWH+7WMwtws4YbPqzcCRt8bBH1bl+ICBQsLfkT1ezlUyIH/5+oOmw29dhYFofT1hkTdY
         fyMPwBPciCacz/1C0AgpYcdlzBi7yEJearS5hkjaNIgnLfuukw0DCDMopCTZGHeXjebj
         KTN/KuXdWL+pLGpBy6kKsnYoyQAxLtS4wrxhGbhjaIIdY/MpFdAuz6/NMu5kBVygLQNV
         /nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845201; x=1684437201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+u1UuZT1pIMEXypNrA+9XQUlZTAHYDviJjF8gqonVQU=;
        b=X2DgNCD8iHy7cBrtqeA5Eyw5LsmyfKXosug9cG5W91cyuNSs6Ym8j1SekBHrR28+IJ
         LrxwtQw1Q3DU4/iuJkl9V74eZ8jXagzL2c+QG6SruliU80+b01A2XsEMGSqhdtJ1q7RG
         H889eYEHTeVdExUKGq/meiELk4qcGwl+A4Pq0o1IxXyS9O8OMF1YTOxsUaUwUwEEsogK
         DxgY30n2PLanFWLsvOEdokbOafmeIS2fNcNs3iA6cPetBiLDQr1Oz6F1mkOpTMc/gBqD
         cfwTz4DzoLaQohKRqkr+R0RAkAZ4NB9hWstjYiuSJlBM/1cf3kmCflaN2UEGfoRNqgEo
         I3jQ==
X-Gm-Message-State: AAQBX9dniAE+KPaXODHQvSd7dOkaqeMb+a5p3EZ0pAspejtVuFMNZ9Up
        uPQkynf0t5aQqrcPJn5sUio0DQ==
X-Google-Smtp-Source: AKy350Y9G6t8iPg8KGaVLYACgNehTbb26PoR9hC3G0xtoef9vY2sm05dJCXh7ylUzUWaDJ07gr2qMA==
X-Received: by 2002:ad4:5b82:0:b0:5e9:9eb:e026 with SMTP id 2-20020ad45b82000000b005e909ebe026mr25993947qvp.29.1681845201676;
        Tue, 18 Apr 2023 12:13:21 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:e646])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05620a17a300b0074e0951c7e7sm428997qkb.28.2023.04.18.12.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:13:21 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     linux-mm@kvack.org
Cc:     Kaiyang Zhao <kaiyang2@cs.cmu.edu>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [RFC PATCH 02/26] mm: compaction: avoid GFP_NOFS deadlocks
Date:   Tue, 18 Apr 2023 15:12:49 -0400
Message-Id: <20230418191313.268131-3-hannes@cmpxchg.org>
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

During stress testing, two deadlock scenarios were observed:

1. One GFP_NOFS allocation was sleeping on too_many_isolated(), and
   all CPUs were busy with compactors that appeared to be spinning on
   buffer locks.

   Give GFP_NOFS compactors additional isolation headroom, the same
   way we do during reclaim, to eliminate this deadlock scenario.

2. In a more pernicious scenario, the GFP_NOFS allocation was
   busy-spinning in compaction, but seemingly never making
   progress. Upon closer inspection, memory was dominated by file
   pages, which the fs compactor isn't allowed to touch. The remaining
   anon pages didn't have the contiguity to satisfy the request.

   Allow GFP_NOFS allocations to bypass watermarks when compaction
   failed at the highest priority.

While these deadlocks were encountered only in tests with the
subsequent patches (which put a lot more demand on compaction), in
theory these problems already exist in the code today. Fix them now.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/compaction.c | 15 +++++++++++++--
 mm/page_alloc.c | 10 +++++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 8238e83385a7..84db84e8fd3a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -745,8 +745,9 @@ isolate_freepages_range(struct compact_control *cc,
 }
 
 /* Similar to reclaim, but different enough that they don't share logic */
-static bool too_many_isolated(pg_data_t *pgdat)
+static bool too_many_isolated(struct compact_control *cc)
 {
+	pg_data_t *pgdat = cc->zone->zone_pgdat;
 	bool too_many;
 
 	unsigned long active, inactive, isolated;
@@ -758,6 +759,16 @@ static bool too_many_isolated(pg_data_t *pgdat)
 	isolated = node_page_state(pgdat, NR_ISOLATED_FILE) +
 			node_page_state(pgdat, NR_ISOLATED_ANON);
 
+	/*
+	 * GFP_NOFS callers are allowed to isolate more pages, so they
+	 * won't get blocked by normal direct-reclaimers, forming a
+	 * circular deadlock. GFP_NOIO won't get here.
+	 */
+	if (cc->gfp_mask & __GFP_FS) {
+		inactive >>= 3;
+		active >>= 3;
+	}
+
 	too_many = isolated > (inactive + active) / 2;
 	if (!too_many)
 		wake_throttle_isolated(pgdat);
@@ -806,7 +817,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 	 * list by either parallel reclaimers or compaction. If there are,
 	 * delay for some time until fewer pages are isolated
 	 */
-	while (unlikely(too_many_isolated(pgdat))) {
+	while (unlikely(too_many_isolated(cc))) {
 		/* stop isolation if there are still pages not migrated */
 		if (cc->nr_migratepages)
 			return -EAGAIN;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3bb3484563ed..ac03571e0532 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4508,8 +4508,16 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 		prep_new_page(page, order, gfp_mask, alloc_flags);
 
 	/* Try get a page from the freelist if available */
-	if (!page)
+	if (!page) {
+		/*
+		 * It's possible that the only migration sources are
+		 * file pages, and the GFP_NOFS stack is holding up
+		 * other compactors. Use reserves to avoid deadlock.
+		 */
+		if (prio == MIN_COMPACT_PRIORITY && !(gfp_mask & __GFP_FS))
+			alloc_flags |= ALLOC_NO_WATERMARKS;
 		page = get_page_from_freelist(gfp_mask, order, alloc_flags, ac);
+	}
 
 	if (page) {
 		struct zone *zone = page_zone(page);
-- 
2.39.2

