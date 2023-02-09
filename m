Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7584669047D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjBIKMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBIKML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:12:11 -0500
Received: from out-99.mta1.migadu.com (out-99.mta1.migadu.com [95.215.58.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD9FCDCB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:12:04 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675937521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=acc/K+18agrKkErMDlxGWmadF0URH1WEryhRG2AiOO0=;
        b=bCrZpQ6GGjG0vYTus6GLvux5o0qoWwOLfzRuP9WjEQEbWFy2yTDQn52GHf7tn+h7PsM7yC
        dFHuQKkjLbFgUYl5pEekrFspst31lhqSSKUStdC/LzDt9AN43tyFKDQ8AI3OdQVetbj89B
        dZVV0wvShWg9mU8EMKnr/qzBEjeRxHw=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org
Cc:     ziy@nvidia.com, mgorman@techsingularity.net, david@redhat.com,
        vbabka@suse.cz, rppt@linux.ibm.com, osalvador@suse.de,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2] mm/page_alloc: optimize find_suitable_fallback() and fallbacks array
Date:   Thu,  9 Feb 2023 18:11:44 +0800
Message-Id: <20230209101144.496144-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to execute the next loop if it not return in the first
loop. So add a break at the end of the loop.

At the same time, add !migratetype_is_mergeable() before the loop and
reduce the first index size from MIGRATE_TYPES to MIGRATE_PCPTYPES in
fallbacks array.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mmzone.h |  2 +-
 mm/page_alloc.c        | 11 +++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index ab94985ee7d9..0a817b8c7fb2 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -85,7 +85,7 @@ static inline bool is_migrate_movable(int mt)
  * Check whether a migratetype can be merged with another migratetype.
  *
  * It is only mergeable when it can fall back to other migratetypes for
- * allocation. See fallbacks[MIGRATE_TYPES][3] in page_alloc.c.
+ * allocation. See fallbacks[][] array in page_alloc.c.
  */
 static inline bool migratetype_is_mergeable(int mt)
 {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1113483fa6c5..536e8d838fb5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2603,7 +2603,7 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
  *
  * The other migratetypes do not have fallbacks.
  */
-static int fallbacks[MIGRATE_TYPES][MIGRATE_PCPTYPES - 1] = {
+static int fallbacks[MIGRATE_PCPTYPES][MIGRATE_PCPTYPES - 1] = {
 	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE   },
 	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE },
 	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE   },
@@ -2861,7 +2861,7 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 	int i;
 	int fallback_mt;
 
-	if (area->nr_free == 0)
+	if (area->nr_free == 0 || !migratetype_is_mergeable(migratetype))
 		return -1;
 
 	*can_steal = false;
@@ -2873,11 +2873,10 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 		if (can_steal_fallback(order, migratetype))
 			*can_steal = true;
 
-		if (!only_stealable)
-			return fallback_mt;
-
-		if (*can_steal)
+		if (!only_stealable || *can_steal)
 			return fallback_mt;
+		else
+			break;
 	}
 
 	return -1;
-- 
2.25.1

