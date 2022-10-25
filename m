Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B6460C4C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiJYHKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiJYHKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:10:19 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F90BD6BB7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:10:17 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1666681815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L4lUHvQEMKR3V8SAeCBrP3BHLGEPzUD0h8eSeuTa0g0=;
        b=LKrUuJiSreMoY+tKEMbwSI72RM12OFTZdm7IK6q3O7G5z3rPQdSMTGautGCkdWY2TepW9+
        +mIWwfiClSQEivjImn8gq/nXc38pTqRp+xZrmM+BDk91g8L1AOUvFfvCkN/C4WNNVc+zhC
        1JCn47nCwuWbirLRgB/L9dCA3vpaCOs=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2] memblock: don't run loop in memblock_add_range() twice
Date:   Tue, 25 Oct 2022 15:09:43 +0800
Message-Id: <20221025070943.363578-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need round twice in memblock_add_range().

We can call memblock_double_array() to extend the size if type->cnt
greater or equal to type->max before memblock_insert_region(); otherwise,
we can insert the new region directly.

v2:
 - Add a comment when the allocation is required.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/memblock.c | 69 ++++++++++++++++++---------------------------------
 1 file changed, 24 insertions(+), 45 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 511d4783dcf1..602fa8ee9b71 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -578,10 +578,10 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 				phys_addr_t base, phys_addr_t size,
 				int nid, enum memblock_flags flags)
 {
-	bool insert = false;
 	phys_addr_t obase = base;
 	phys_addr_t end = base + memblock_cap_size(base, &size);
-	int idx, nr_new;
+	unsigned long ocnt = type->cnt;
+	int idx;
 	struct memblock_region *rgn;
 
 	if (!size)
@@ -598,25 +598,6 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
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
-	base = obase;
-	nr_new = 0;
-
 	for_each_memblock_type(idx, type, rgn) {
 		phys_addr_t rbase = rgn->base;
 		phys_addr_t rend = rbase + rgn->size;
@@ -634,11 +615,18 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 			WARN_ON(nid != memblock_get_region_node(rgn));
 #endif
 			WARN_ON(flags != rgn->flags);
-			nr_new++;
-			if (insert)
-				memblock_insert_region(type, idx++, base,
-						       rbase - base, nid,
-						       flags);
+
+			/*
+			 * if type->cnt greater or equal to type->max,
+			 * resize array; otherwise, insert directly.
+			 */
+			if ((type->cnt >= type->max) &&
+			    memblock_double_array(type, obase, size))
+				return -ENOMEM;
+
+			memblock_insert_region(type, idx++, base,
+					       rbase - base, nid,
+					       flags);
 		}
 		/* area below @rend is dealt with, forget about it */
 		base = min(rend, end);
@@ -646,29 +634,20 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
 
 	/* insert the remaining portion */
 	if (base < end) {
-		nr_new++;
-		if (insert)
-			memblock_insert_region(type, idx, base, end - base,
-					       nid, flags);
+		if ((type->cnt >= type->max) &&
+		    memblock_double_array(type, obase, size))
+			return -ENOMEM;
+
+		memblock_insert_region(type, idx, base, end - base,
+				       nid, flags);
 	}
 
-	if (!nr_new)
+	if (ocnt == type->cnt)
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
+
+	return 0;
 }
 
 /**
-- 
2.25.1

