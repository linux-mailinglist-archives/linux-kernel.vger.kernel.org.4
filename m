Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757BA68FD66
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 03:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjBICzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 21:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjBICyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 21:54:36 -0500
X-Greylist: delayed 416 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Feb 2023 18:51:52 PST
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D27286BF
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 18:51:51 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675910693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=6j791U1wIUFSOI7G5OFn8eDWYHiEod5wKDWuChvQKYw=;
        b=YxT2MBU6ERJfONrIkOap8zG+cxkJFGKQtMQMMqerZX2JyQAMZFxUDz8IrRZnONqOUFWPrS
        MGCYEkvg0+xid3z3ybjMcByY3Z4pmwpk5E3q5l0ZGTMS5VdXUPrZvwGrBSiF6r7xtE0D0B
        WGMhQb3Qe+2Aus6swE/JXS+/qAghOns=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org
Cc:     ziy@nvidia.com, mgorman@techsingularity.net, david@redhat.com,
        vbabka@suse.cz, rppt@linux.ibm.com, osalvador@suse.de,
        rppt@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/page_alloc: optimize the loop in find_suitable_fallback()
Date:   Thu,  9 Feb 2023 10:44:35 +0800
Message-Id: <20230209024435.3392916-1-yajun.deng@linux.dev>
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

There are only three rows in fallbacks, so reduce the first index size
from MIGRATE_TYPES to MIGRATE_PCPTYPES.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/page_alloc.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

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

