Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D2060454A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiJSMai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiJSMaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:30:08 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49CD18C438
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:07:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666181081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9Zp0rsOwaZAudeS2Yn3cYhCuuXMlRO2UwNZgHWLJ9K8=;
        b=Q9+90QS7LNNNm7kvUFJq+pkQ4l+2WZSD6FZFg0q7ZB5/5f5Xs5+3GMbwNjkTuCj7iJOrW5
        YUKLmIry915vUhFojJ/KmG4rSx+AD/GffFSwQ4Qra4DtOzTkjNXNHx6VsCv+TPUnXe8fUU
        tKcSlGnMJLvICa4C26YADM1IV2yUjmQ=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] memblock: remove repeat round
Date:   Wed, 19 Oct 2022 20:03:37 +0800
Message-Id: <20221019120337.2098298-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need round twice in memblock_add_range().

We can call memblock_double_array() to extand the size if type->cnt no
less than type->max before memblock_insert_region(), otherwise we can
insert the new region directly.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/memblock.c | 54 +++++++++++++++------------------------------------
 1 file changed, 16 insertions(+), 38 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 511d4783dcf1..1679244b4a1a 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -578,7 +578,6 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 				phys_addr_t base, phys_addr_t size,
 				int nid, enum memblock_flags flags)
 {
-	bool insert = false;
 	phys_addr_t obase = base;
 	phys_addr_t end = base + memblock_cap_size(base, &size);
 	int idx, nr_new;
@@ -598,22 +597,6 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 		return 0;
 	}
 
-	/*
-	 * The worst case is when new range overlaps all existing regions,
-	 * then we'll need type->cnt + 1 empty regions in @type. So if
-	 * type->cnt * 2 + 1 is less than type->max, we know
-	 * that there is enough empty regions in @type, and we can insert
-	 * regions directly.
-	 */
-	if (type->cnt * 2 + 1 < type->max)
-		insert = true;
-
-repeat:
-	/*
-	 * The following is executed twice.  Once with %false @insert and
-	 * then with %true.  The first counts the number of regions needed
-	 * to accommodate the new area.  The second actually inserts them.
-	 */
 	base = obase;
 	nr_new = 0;
 
@@ -635,10 +618,14 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 #endif
 			WARN_ON(flags != rgn->flags);
 			nr_new++;
-			if (insert)
-				memblock_insert_region(type, idx++, base,
-						       rbase - base, nid,
-						       flags);
+
+			if ((type->cnt >= type->max) &&
+			    (memblock_double_array(type, obase, size) < 0))
+				return -ENOMEM;
+
+			memblock_insert_region(type, idx++, base,
+					       rbase - base, nid,
+					       flags);
 		}
 		/* area below @rend is dealt with, forget about it */
 		base = min(rend, end);
@@ -647,28 +634,19 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 	/* insert the remaining portion */
 	if (base < end) {
 		nr_new++;
-		if (insert)
-			memblock_insert_region(type, idx, base, end - base,
-					       nid, flags);
+		if ((type->cnt >= type->max) &&
+		    (memblock_double_array(type, obase, size) < 0))
+			return -ENOMEM;
+
+		memblock_insert_region(type, idx, base, end - base,
+				       nid, flags);
 	}
 
 	if (!nr_new)
 		return 0;
 
-	/*
-	 * If this was the first round, resize array and repeat for actual
-	 * insertions; otherwise, merge and return.
-	 */
-	if (!insert) {
-		while (type->cnt + nr_new > type->max)
-			if (memblock_double_array(type, obase, size) < 0)
-				return -ENOMEM;
-		insert = true;
-		goto repeat;
-	} else {
-		memblock_merge_regions(type);
-		return 0;
-	}
+	memblock_merge_regions(type);
+	return 0;
 }
 
 /**
-- 
2.25.1

