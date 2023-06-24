Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353D873C65E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 04:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjFXCqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 22:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjFXCql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 22:46:41 -0400
Received: from out-62.mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62328E1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 19:46:39 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687574797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=N99W1PdAr0OWUT49Ca/cf/ovMzOhIoXmt9jkyLCr7jE=;
        b=lqUpTigKQWW+JM3OWisaO4ZycziI/PYiu2SZKvQXrXnlrDSgLjvdEo3KwjuH5AcLXGJHWv
        BkY3n32PECh8mZToUHXKjqT68SXKlX/cQWVBjZWsZu44JKcq2CHMJxp/qaKQ8nmpKIsVRg
        hxHYwyeCsNcBYyaY+xwHnWyKeSNqTnw=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] memblock: Introduce memblock_reserve_node()
Date:   Sat, 24 Jun 2023 10:46:22 +0800
Message-Id: <20230624024622.2959376-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It only returns address now in memblock_find_in_range_node(), we can add a
parameter pointing to integer for node id of the range, which can be used
to pass the node id to the new reserve region.

Introduce memblock_reserve_node() so that the node id can be passed to
the reserve region in memblock_alloc_range_nid().

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/memblock.c | 39 +++++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index f9e61e565a53..6b5f6c246458 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -204,6 +204,7 @@ bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
  * @align: alignment of free area to find
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  * @flags: pick from blocks based on memory attributes
+ * @p_nid: ptr to int for nid of the range, can be %NULL
  *
  * Utility called from memblock_find_in_range_node(), find free area bottom-up.
  *
@@ -213,12 +214,12 @@ bool __init_memblock memblock_overlaps_region(struct memblock_type *type,
 static phys_addr_t __init_memblock
 __memblock_find_range_bottom_up(phys_addr_t start, phys_addr_t end,
 				phys_addr_t size, phys_addr_t align, int nid,
-				enum memblock_flags flags)
+				enum memblock_flags flags, int *p_nid)
 {
 	phys_addr_t this_start, this_end, cand;
 	u64 i;
 
-	for_each_free_mem_range(i, nid, flags, &this_start, &this_end, NULL) {
+	for_each_free_mem_range(i, nid, flags, &this_start, &this_end, p_nid) {
 		this_start = clamp(this_start, start, end);
 		this_end = clamp(this_end, start, end);
 
@@ -239,6 +240,7 @@ __memblock_find_range_bottom_up(phys_addr_t start, phys_addr_t end,
  * @align: alignment of free area to find
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  * @flags: pick from blocks based on memory attributes
+ * @p_nid: ptr to int for nid of the range, can be %NULL
  *
  * Utility called from memblock_find_in_range_node(), find free area top-down.
  *
@@ -248,13 +250,13 @@ __memblock_find_range_bottom_up(phys_addr_t start, phys_addr_t end,
 static phys_addr_t __init_memblock
 __memblock_find_range_top_down(phys_addr_t start, phys_addr_t end,
 			       phys_addr_t size, phys_addr_t align, int nid,
-			       enum memblock_flags flags)
+			       enum memblock_flags flags, int *p_nid)
 {
 	phys_addr_t this_start, this_end, cand;
 	u64 i;
 
 	for_each_free_mem_range_reverse(i, nid, flags, &this_start, &this_end,
-					NULL) {
+					p_nid) {
 		this_start = clamp(this_start, start, end);
 		this_end = clamp(this_end, start, end);
 
@@ -278,6 +280,7 @@ __memblock_find_range_top_down(phys_addr_t start, phys_addr_t end,
  *       %MEMBLOCK_ALLOC_ACCESSIBLE
  * @nid: nid of the free area to find, %NUMA_NO_NODE for any node
  * @flags: pick from blocks based on memory attributes
+ * @p_nid: ptr to int for nid of the range, can be %NULL
  *
  * Find @size free area aligned to @align in the specified range and node.
  *
@@ -287,7 +290,7 @@ __memblock_find_range_top_down(phys_addr_t start, phys_addr_t end,
 static phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
 					phys_addr_t align, phys_addr_t start,
 					phys_addr_t end, int nid,
-					enum memblock_flags flags)
+					enum memblock_flags flags, int *p_nid)
 {
 	/* pump up @end */
 	if (end == MEMBLOCK_ALLOC_ACCESSIBLE ||
@@ -300,10 +303,10 @@ static phys_addr_t __init_memblock memblock_find_in_range_node(phys_addr_t size,
 
 	if (memblock_bottom_up())
 		return __memblock_find_range_bottom_up(start, end, size, align,
-						       nid, flags);
+						       nid, flags, p_nid);
 	else
 		return __memblock_find_range_top_down(start, end, size, align,
-						      nid, flags);
+						      nid, flags, p_nid);
 }
 
 /**
@@ -328,7 +331,7 @@ static phys_addr_t __init_memblock memblock_find_in_range(phys_addr_t start,
 
 again:
 	ret = memblock_find_in_range_node(size, align, start, end,
-					    NUMA_NO_NODE, flags);
+					    NUMA_NO_NODE, flags, NULL);
 
 	if (!ret && (flags & MEMBLOCK_MIRROR)) {
 		pr_warn_ratelimited("Could not allocate %pap bytes of mirrored memory\n",
@@ -863,6 +866,17 @@ int __init_memblock memblock_phys_free(phys_addr_t base, phys_addr_t size)
 	return memblock_remove_range(&memblock.reserved, base, size);
 }
 
+static int __init_memblock memblock_reserve_node(phys_addr_t base, phys_addr_t size,
+						 int nid, enum memblock_flags flags)
+{
+	phys_addr_t end = base + size - 1;
+
+	memblock_dbg("%s: [%pa-%pa] nid=%d flags=%x %pS\n", __func__,
+		     &base, &end, nid, flags, (void *)_RET_IP_);
+
+	return memblock_add_range(&memblock.reserved, base, size, nid, flags);
+}
+
 int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
 {
 	phys_addr_t end = base + size - 1;
@@ -1389,6 +1403,7 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 {
 	enum memblock_flags flags = choose_memblock_flags();
 	phys_addr_t found;
+	int p_nid;
 
 	if (WARN_ONCE(nid == MAX_NUMNODES, "Usage of MAX_NUMNODES is deprecated. Use NUMA_NO_NODE instead\n"))
 		nid = NUMA_NO_NODE;
@@ -1401,15 +1416,15 @@ phys_addr_t __init memblock_alloc_range_nid(phys_addr_t size,
 
 again:
 	found = memblock_find_in_range_node(size, align, start, end, nid,
-					    flags);
-	if (found && !memblock_reserve(found, size))
+					    flags, &p_nid);
+	if (found && !memblock_reserve_node(found, size, p_nid, flags))
 		goto done;
 
 	if (nid != NUMA_NO_NODE && !exact_nid) {
 		found = memblock_find_in_range_node(size, align, start,
 						    end, NUMA_NO_NODE,
-						    flags);
-		if (found && !memblock_reserve(found, size))
+						    flags, &p_nid);
+		if (found && !memblock_reserve_node(found, size, p_nid, flags))
 			goto done;
 	}
 
-- 
2.25.1

