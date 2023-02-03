Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EFF6894CB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjBCKKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjBCKKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:10:12 -0500
X-Greylist: delayed 501 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Feb 2023 02:10:09 PST
Received: from out-63.mta1.migadu.com (out-63.mta1.migadu.com [95.215.58.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC208F53E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:10:09 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675418507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jVqxFf3JRfqjs768IBtScFknblotNYt6b9ZAM/rAAcc=;
        b=N2IKYpf8zv/QbWkNAoZoxZILiqR1lS1XhBXWc0GvpNnwaTTbN5ZKbzV8sLrDKERbLgmKla
        5XTX+V8wJe5h+VHPdQ93dja0oCJRSXomPii8OB5E6mtTef4/lZqOEv/zAuWl1BwR1JyIlt
        kUU+kulKfdXKItaDyh2e8JlvVIZ3/Uk=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] mm/page_alloc: reduce fallbacks to (MIGRATE_PCPTYPES - 1)
Date:   Fri,  3 Feb 2023 18:01:32 +0800
Message-Id: <20230203100132.1627787-1-yajun.deng@linux.dev>
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

The commit 1dd214b8f21c ("mm: page_alloc: avoid merging non-fallbackable
pageblocks with others") has removed MIGRATE_CMA and MIGRATE_ISOLATE from
fallbacks list. so there is no need to add an element at the end of every
type.

Reduce fallbacks to (MIGRATE_PCPTYPES - 1).

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/page_alloc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5ebce58026f1..21d820c42900 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2603,10 +2603,10 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
  *
  * The other migratetypes do not have fallbacks.
  */
-static int fallbacks[MIGRATE_TYPES][3] = {
-	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE,   MIGRATE_TYPES },
-	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE, MIGRATE_TYPES },
-	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE,   MIGRATE_TYPES },
+static int fallbacks[MIGRATE_TYPES][MIGRATE_PCPTYPES - 1] = {
+	[MIGRATE_UNMOVABLE]   = { MIGRATE_RECLAIMABLE, MIGRATE_MOVABLE   },
+	[MIGRATE_MOVABLE]     = { MIGRATE_RECLAIMABLE, MIGRATE_UNMOVABLE },
+	[MIGRATE_RECLAIMABLE] = { MIGRATE_UNMOVABLE,   MIGRATE_MOVABLE   },
 };
 
 #ifdef CONFIG_CMA
@@ -2865,11 +2865,8 @@ int find_suitable_fallback(struct free_area *area, unsigned int order,
 		return -1;
 
 	*can_steal = false;
-	for (i = 0;; i++) {
+	for (i = 0; i < MIGRATE_PCPTYPES - 1 ; i++) {
 		fallback_mt = fallbacks[migratetype][i];
-		if (fallback_mt == MIGRATE_TYPES)
-			break;
-
 		if (free_area_empty(area, fallback_mt))
 			continue;
 
-- 
2.25.1

