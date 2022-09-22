Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6145E6B0C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiIVSeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbiIVSeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:34:01 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6D310D0EC
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:31:57 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id c7so9967332pgt.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=QCY+Ve0GmwSK4E8jgplpUYH3SP9D0/JevojggP7tHEs=;
        b=bDCFNN0m5fWbAqCRu1Jqgsj5WxKMlVRgce6Era4TBU6XXOQOvFzOpqjLk93UNFZZgA
         gWFw5yM1JVE164nuwoGPoO9LRwd9TbeUJSEtCEcHqRvYuImibE6eclsj5iBo0VPypoqo
         BS5Fid2fm3BvNSKaO++1p+lguvM6S1qZucXJ8XoLxwVy46VvH/0H0x9xW06a+VxGVDTi
         ytirWljfyZjDz8mZYluPiSXDVaNW6stoTYclBRDwI2F59RtEZpK8jxJ9QLgwU3CCEE5h
         KHHX0zgWLfUityKN1ajD1KgGF9VQqUPhWTctiIP/yrgcokLzB/XMbTncUgJmElfOG4ta
         v3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QCY+Ve0GmwSK4E8jgplpUYH3SP9D0/JevojggP7tHEs=;
        b=0zgYmCaa5WumArrzWaAfBwsvjbtq7+AAuDhUwuY+OiPH1cKYDttvPVgKXZOhHznH6l
         07b+g01rOi30lO2WajFXIzy6Rek0mnd3cL0hxF5P5qfgAmu5VP9m6ahCgJVGqAe0ZqSQ
         7CYcMCxanraR3lKH1g0pBT0aLd0kMxu6CoW9Ejr0zZsUWOZfKA6cbpBh4lXzCFUUeWhR
         oFL6BNv+f5XBtNivhIE3y3/nO1cP3YXRdFkg2/FdZ86ZSzExBppT/golzXPGpoCphgoJ
         /xrB/3ePoN9uTr4OFfGy2TJ72b14eVRkZkWG/MOvQ6FUflTggbW5dZL+Nq12o6JQVw2h
         DsWw==
X-Gm-Message-State: ACrzQf3Itogro3A27T/I3qm0KCzg024HzwVmMK7m+KETs28W/KpWS6ET
        H7DdpZbhI8LCK6gjIRikdv1Www==
X-Google-Smtp-Source: AMsMyM669iF33adwjZmy1KQFNxlLtrwvYu3QKJfILmLyepy9WgFD5CNf/2XPFL/wuxJD6JApnu6XbQ==
X-Received: by 2002:a63:26c3:0:b0:439:9496:dd90 with SMTP id m186-20020a6326c3000000b004399496dd90mr4204309pgm.38.1663871517066;
        Thu, 22 Sep 2022 11:31:57 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id b23-20020a63cf57000000b00434651f9a96sm4049759pgj.15.2022.09.22.11.31.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Sep 2022 11:31:56 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     wangjie125@huawei.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        haifeng.zhao@linux.intel.com, john.garry@huawei.com,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [RESEND PATCH v3] iommu/iova: Optimize alloc_iova with rbtree_augmented
Date:   Fri, 23 Sep 2022 02:31:14 +0800
Message-Id: <20220922183114.15135-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current algorithm of alloc_iova is to scan all iovas until it finds
a gap that satisfies the condition to allocate. This can be very slow in
some scenarios. We can optimize alloc_iova() from time complexity O(n)
to O(log(n)).

In what scenarios will it be slow? Consider allocating some iova from a
completely empty address space. These iova are being used and not
released. The order of allocation is from high address to low address,
and a whole segment of space is in use. The cached node points to the
last allocated iova. An iova is released at this point, and the cached
node will be updated to the next iova of the released iova. If an
allocation is made at this time, it will be fast because there is a free
space before the cached node. But doing a second allocation, it will
probably be slow because finding a free space requires traversing the
long in-use space.

Bugs that may be triggered in reality:
The version of kernel is 5.4.56.
[Wed May 25 05:27:59 2022] watchdog: BUG:
soft lockup - CPU#58 stuck for 23s! [ksoftirqd/58:302]
[Wed May 25 05:27:59 2022] Call Trace:
[Wed May 25 05:27:59 2022]  alloc_iova+0xf2/0x140
[Wed May 25 05:27:59 2022]  alloc_iova_fast+0x56/0x251
[Wed May 25 05:27:59 2022]  dma_ops_alloc_iova.isra.27+0x4b/0x70
[Wed May 25 05:27:59 2022]  __map_single.isra.28+0x4a/0x1d0
[Wed May 25 05:27:59 2022]  mlx5e_sq_xmit+0x98d/0x12b0 [mlx5_core]

A single-threaded test that calls alloc_iova() and remove_iova() directly:
1. Initialize iova_domain with a 4k granule
2. Allocate iova of size 1 300000 times (limit = 2^48 / 2^12 -1)
Loop step 3,4 1000 times.
3. Randomly free an allocated iova
4. Allocate a new iova of size 1

Before optimization:
________________________________________________________________________
Tracing 1 functions for "alloc_iova"...
  nsecs               : count     distribution
    256 -> 511        : 524      |                                     |
    512 -> 1023       : 295065   |*************************************|
   1024 -> 2047       : 4309     |                                     |
   2048 -> 4095       : 368      |                                     |
   4096 -> 8191       : 240      |                                     |
   8192 -> 16383      : 0        |                                     |
  16384 -> 32767      : 6        |                                     |
  32768 -> 65535      : 6        |                                     |
  65536 -> 131071     : 13       |                                     |
 131072 -> 262143     : 28       |                                     |
 262144 -> 524287     : 65       |                                     |
 524288 -> 1048575    : 77       |                                     |
1048576 -> 2097151    : 144      |                                     |
2097152 -> 4194303    : 149      |                                     |
4194304 -> 8388607    : 6        |                                     |
avg = 3164 nsecs, total: 952408420 nsecs, count: 301000

Tracing 1 functions for "remove_iova"...
nsecs             : count     distribution
  256 -> 511      : 279402   |****************************************|
  512 -> 1023     : 21468    |***                                     |
 1024 -> 2047     : 127      |                                        |
 2048 -> 4095     : 3        |                                        |
avg = 433 nsecs, total: 130344721 nsecs, count: 301000
________________________________________________________________________

Optimized:
________________________________________________________________________
Tracing 1 functions for "alloc_iova"...
 nsecs            : count     distribution
   512 -> 1023    : 296014   |****************************************|
  1024 -> 2047    : 4328     |                                        |
  2048 -> 4095    : 517      |                                        |
  4096 -> 8191    : 141      |                                        |
avg = 661 nsecs, total: 198961817 nsecs, count: 301000

Tracing 1 functions for "remove_iova"...
 nsecs            : count     distribution
   256 -> 511     : 252871   |****************************************|
   512 -> 1023    : 47934    |*******                                 |
  1024 -> 2047    : 193      |                                        |
  2048 -> 4095    : 2        |                                        |
avg = 469 nsecs, total: 141258450 nsecs, count: 301000
________________________________________________________________________

Test results from  Jie Wang <wangjie125@huawei.com>:
________________________________________________________________________
nic's rx performance in large-capacity scenarios:
"before" row is the result of 5.19 rc4. "after" row means 5.19 rc4 with
this patch, the unit is Mbits/s.
          1     2     3     4     5     6     7     8
before  55430 76701 84194 77560 88292 90106 87770 77273
after   92770 92767 92792 92764 92742 92696 92781 92756
________________________________________________________________________

Introduce the improved algorithm:

------------------------------------------------------------------------
| gap1  |iova1| gap2 |iova2| gap3 |iova3|   gap4  |iova4| gap5  |anchor|
------------------------------------------------------------------------

let A = allocatable_size
let B = max_allocatable_size
                    ____________
                  /    iova2     \      B = max( left_child->B,
                 |       A        |              right_child->B,
                  \      B       /               A)
                    ------------
                   /            \
                  /              \
    ____________                    ____________
  /    iova1     \                /    iova4     \
 |       A        |              |       A        |
  \      B       /                \      B        /
    ------------                    ------------
                                   /            \
                                  /              \
                    ____________                    ____________
                  /    iova3     \                /    anchor    \
                 |       A        |              |       A        |
                  \      B       /                \      B        /
                    ------------                    ------------

Define the gap of a iova is the gap between the iova and it's previous
iova. Such as the gap of iova3 is gap3.This gap can be used to allocate.

Add three variables to struct iova.
prev_iova:
         point to the previous iova, sush as iova3->prev_iova point to
         iova2.

allocatable_size:
         allocatable_size is the max size can be allocated from a gap.
         It is not the length of a gap because the allocated address
         may need to be aligned.

max_allocatable_size:
         max_allocatable_size is the max allocatable_size of all iova's
         gap in the subtree.

         max_allocatable_size = max( left_child->max_allocatable_size,
                                     right_child->max_allocatable_size,
                                     allocatable_size)

We can use rbtree_augmented to maintain max_allocatable_size in time
complexity O(log(n)).

In the rbtree, with the max_allocatable_size and allocatable_size,
searching the gap to allocate is fast and the time complexity is
O(log(n)).

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
Tested-by: Jie Wang <wangjie125@huawei.com>
---
 drivers/iommu/iova.c | 277 +++++++++++++++++++++++++++++++++----------
 include/linux/iova.h |  10 +-
 2 files changed, 221 insertions(+), 66 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index db77aa675145..44f9deee9ef4 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -43,6 +43,60 @@ static struct iova *to_iova(struct rb_node *node)
 	return rb_entry(node, struct iova, node);
 }
 
+/*
+ * We can't judge whether it can be allocated only by a given interval length
+ * because the address may be aligned.
+ * This function computes the max allocatable size for a given interval.
+ * The time complexity of this function is O(log(n)).
+ */
+static unsigned long __compute_allocatable_size(unsigned long lo,
+						unsigned long hi)
+{
+	unsigned long allocatable_size = 0;
+
+	if (lo == 0)
+		return hi;
+	while (lo < hi) {
+		/*
+		 * delta is the max size can be allocated from lo.
+		 * The address may be aligned so it isn't (hi - lo).
+		 */
+		unsigned long delta = 1UL << __ffs64(lo);
+
+		if (hi - lo <= delta) {
+			allocatable_size = max(allocatable_size, hi - lo);
+			break;
+		}
+		allocatable_size = max(allocatable_size, delta);
+		lo += delta;
+	}
+	return allocatable_size;
+}
+
+static inline unsigned long prev_iova_high(struct iova *iova)
+{
+	return iova->prev_iova ? iova->prev_iova->pfn_hi + 1 : 0;
+}
+
+static inline unsigned long iova_compute_allocatable_size(struct iova *iova)
+{
+	return __compute_allocatable_size(prev_iova_high(iova), iova->pfn_lo);
+}
+
+static inline unsigned long iova_get_allocatable_size(struct iova *iova)
+{
+	return iova->allocatable_size;
+}
+
+RB_DECLARE_CALLBACKS_MAX(static, iova_gap_callbacks, struct iova, node,
+			 unsigned long, max_allocatable_size,
+			 iova_get_allocatable_size)
+
+static inline void iova_max_allocatable_size_update(struct iova *iova)
+{
+	iova_gap_callbacks_propagate(&iova->node, NULL);
+}
+
 void
 init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	unsigned long start_pfn)
@@ -63,8 +117,16 @@ init_iova_domain(struct iova_domain *iovad, unsigned long granule,
 	iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
 	iovad->max32_alloc_size = iovad->dma_32bit_pfn;
 	iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
+	iovad->anchor.prev_iova = NULL;
+	iovad->anchor.allocatable_size =
+				__compute_allocatable_size(0, IOVA_ANCHOR);
+	iovad->anchor.max_allocatable_size  = iovad->anchor.allocatable_size;
+
 	rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
 	rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
+
+	if (start_pfn)
+		reserve_iova(iovad, 0, start_pfn - 1);
 }
 EXPORT_SYMBOL_GPL(init_iova_domain);
 
@@ -87,7 +149,8 @@ __cached_rbnode_insert_update(struct iova_domain *iovad, struct iova *new)
 }
 
 static void
-__cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
+__cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free,
+			      struct rb_node *next)
 {
 	struct iova *cached_iova;
 
@@ -95,51 +158,32 @@ __cached_rbnode_delete_update(struct iova_domain *iovad, struct iova *free)
 	if (free == cached_iova ||
 	    (free->pfn_hi < iovad->dma_32bit_pfn &&
 	     free->pfn_lo >= cached_iova->pfn_lo))
-		iovad->cached32_node = rb_next(&free->node);
+		iovad->cached32_node = next;
 
 	if (free->pfn_lo < iovad->dma_32bit_pfn)
 		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
 
 	cached_iova = to_iova(iovad->cached_node);
 	if (free->pfn_lo >= cached_iova->pfn_lo)
-		iovad->cached_node = rb_next(&free->node);
+		iovad->cached_node = next;
 }
 
-static struct rb_node *iova_find_limit(struct iova_domain *iovad, unsigned long limit_pfn)
+static struct rb_node *iova_find_limit(struct iova_domain *iovad,
+				       unsigned long limit_pfn)
 {
-	struct rb_node *node, *next;
-	/*
-	 * Ideally what we'd like to judge here is whether limit_pfn is close
-	 * enough to the highest-allocated IOVA that starting the allocation
-	 * walk from the anchor node will be quicker than this initial work to
-	 * find an exact starting point (especially if that ends up being the
-	 * anchor node anyway). This is an incredibly crude approximation which
-	 * only really helps the most likely case, but is at least trivially easy.
-	 */
-	if (limit_pfn > iovad->dma_32bit_pfn)
-		return &iovad->anchor.node;
-
-	node = iovad->rbroot.rb_node;
-	while (to_iova(node)->pfn_hi < limit_pfn)
-		node = node->rb_right;
-
-search_left:
-	while (node->rb_left && to_iova(node->rb_left)->pfn_lo >= limit_pfn)
-		node = node->rb_left;
-
-	if (!node->rb_left)
-		return node;
-
-	next = node->rb_left;
-	while (next->rb_right) {
-		next = next->rb_right;
-		if (to_iova(next)->pfn_lo >= limit_pfn) {
-			node = next;
-			goto search_left;
-		}
-	}
+	struct rb_node *curr = iovad->rbroot.rb_node;
+
+	while (curr) {
+		struct iova *iova = to_iova(curr);
 
-	return node;
+		if (limit_pfn - 1 > iova->pfn_hi)
+			curr = curr->rb_right;
+		else if (limit_pfn <= prev_iova_high(iova))
+			curr = curr->rb_left;
+		else
+			break;
+	}
+	return curr;
 }
 
 /* Insert the iova into domain rbtree by holding writer lock */
@@ -148,6 +192,7 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova,
 		   struct rb_node *start)
 {
 	struct rb_node **new, *parent = NULL;
+	struct iova *next_iova;
 
 	new = (start) ? &start : &(root->rb_node);
 	/* Figure out where to put new node */
@@ -166,61 +211,151 @@ iova_insert_rbtree(struct rb_root *root, struct iova *iova,
 		}
 	}
 	/* Add new node and rebalance tree. */
+
 	rb_link_node(&iova->node, parent, new);
-	rb_insert_color(&iova->node, root);
+
+	next_iova = to_iova(rb_next(&iova->node));
+	iova->prev_iova = next_iova->prev_iova;
+	next_iova->prev_iova = iova;
+
+	iova->allocatable_size = iova_compute_allocatable_size(iova);
+	next_iova->allocatable_size = iova_compute_allocatable_size(next_iova);
+
+	/*
+	 * Do't swap the following two lines, because next_iova is the ancestor
+	 * of iova and updating iova first is faster.
+	 */
+	iova_max_allocatable_size_update(iova);
+	iova_max_allocatable_size_update(next_iova);
+
+	rb_insert_augmented(&iova->node, root, &iova_gap_callbacks);
+}
+
+static inline bool check_interval(unsigned long lo, unsigned long hi,
+				  unsigned long limit_pfn, unsigned long size,
+				  unsigned long align_mask)
+{
+	hi = min(hi, limit_pfn);
+	if (lo >= hi)
+		return false;
+	if (hi >= size && ((hi - size) & align_mask) >= lo)
+		return true;
+	return false;
 }
 
 static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 		unsigned long size, unsigned long limit_pfn,
 			struct iova *new, bool size_aligned)
 {
-	struct rb_node *curr, *prev;
-	struct iova *curr_iova;
 	unsigned long flags;
-	unsigned long new_pfn, retry_pfn;
+	struct rb_node *curr;
+	struct rb_node *parent;
+	struct iova *curr_iova;
 	unsigned long align_mask = ~0UL;
-	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
+	bool ignore = false;
 
 	if (size_aligned)
 		align_mask <<= fls_long(size - 1);
 
-	/* Walk the tree backwards */
 	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+
 	if (limit_pfn <= iovad->dma_32bit_pfn &&
 			size >= iovad->max32_alloc_size)
 		goto iova32_full;
 
 	curr = __get_cached_rbnode(iovad, limit_pfn);
 	curr_iova = to_iova(curr);
-	retry_pfn = curr_iova->pfn_hi + 1;
 
-retry:
-	do {
-		high_pfn = min(high_pfn, curr_iova->pfn_lo);
-		new_pfn = (high_pfn - size) & align_mask;
-		prev = curr;
-		curr = rb_prev(curr);
-		curr_iova = to_iova(curr);
-	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
-
-	if (high_pfn < size || new_pfn < low_pfn) {
-		if (low_pfn == iovad->start_pfn && retry_pfn < limit_pfn) {
-			high_pfn = limit_pfn;
-			low_pfn = retry_pfn;
-			curr = iova_find_limit(iovad, limit_pfn);
-			curr_iova = to_iova(curr);
-			goto retry;
+	if (check_interval(prev_iova_high(curr_iova),
+			   curr_iova->pfn_lo, limit_pfn,
+			   size, align_mask))
+		goto found;
+
+	/* If limit_pfn > dma_32bit_pfn, searching list could be faster? */
+	if (limit_pfn > iovad->dma_32bit_pfn) {
+		int count = 0;
+
+		curr_iova = to_iova(&iovad->anchor.node);
+		while (curr_iova) {
+			if (check_interval(prev_iova_high(curr_iova),
+					   curr_iova->pfn_lo, limit_pfn,
+					   size, align_mask))
+				goto found;
+			/* If try many times, break it. */
+			if (++count >= 32)
+				goto search_rbtree;
+			curr_iova = curr_iova->prev_iova;
 		}
 		iovad->max32_alloc_size = size;
 		goto iova32_full;
 	}
 
+search_rbtree:
+	curr = iova_find_limit(iovad, limit_pfn);
+	curr_iova = to_iova(curr);
+
+	if (check_interval(prev_iova_high(curr_iova),
+			   curr_iova->pfn_lo, limit_pfn,
+			   size, align_mask))
+		goto found;
+
+	while (true) {
+		/* Check left subtree */
+		if (!ignore && curr->rb_left) {
+			curr_iova = to_iova(curr->rb_left);
+			if (curr_iova->max_allocatable_size >= size)
+				goto check_subtree;
+		}
+
+		parent = rb_parent(curr);
+		if (parent == NULL)
+			break;
+		/*
+		 * If current node is the left child of it's parent,
+		 * the parent node and the parent's right sub_tree should not
+		 * to be checked because they exceed the limit_pfn.
+		 */
+		ignore = parent->rb_left == curr;
+		/* Goto parent */
+		curr = parent;
+
+		/* Check current node. */
+		if (!ignore) {
+			curr_iova = to_iova(curr);
+			if (curr_iova->allocatable_size >= size)
+				goto found;
+		}
+	}
+	if (limit_pfn >= iovad->dma_32bit_pfn)
+		iovad->max32_alloc_size = size;
+	goto iova32_full;
+
+check_subtree:
+	/* It should be must successfully found here */
+	while (true) {
+		if (curr_iova->allocatable_size >= size)
+			goto found;
+
+		curr = &curr_iova->node;
+		if (curr->rb_right &&
+			to_iova(curr->rb_right)->max_allocatable_size >= size) {
+			curr_iova = to_iova(curr->rb_right);
+			continue;
+		}
+		WARN_ON(curr->rb_left == NULL);
+		curr_iova = to_iova(curr->rb_left);
+	}
+
+found:
 	/* pfn_lo will point to size aligned address if size_aligned is set */
-	new->pfn_lo = new_pfn;
+	new->pfn_lo = (min(curr_iova->pfn_lo, limit_pfn) - size) & align_mask;
 	new->pfn_hi = new->pfn_lo + size - 1;
 
-	/* If we have 'prev', it's a valid place to start the insertion. */
-	iova_insert_rbtree(&iovad->rbroot, new, prev);
+	/*
+	 * If we have 'prev' or 'next',
+	 * it's a valid place to start the insertion.
+	 */
+	iova_insert_rbtree(&iovad->rbroot, new, &curr_iova->node);
 	__cached_rbnode_insert_update(iovad, new);
 
 	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
@@ -352,9 +487,18 @@ private_find_iova(struct iova_domain *iovad, unsigned long pfn)
 
 static void remove_iova(struct iova_domain *iovad, struct iova *iova)
 {
+	struct rb_node *next;
+	struct iova *next_iova;
 	assert_spin_locked(&iovad->iova_rbtree_lock);
-	__cached_rbnode_delete_update(iovad, iova);
-	rb_erase(&iova->node, &iovad->rbroot);
+
+	next = rb_next(&iova->node);
+	__cached_rbnode_delete_update(iovad, iova, next);
+
+	next_iova = to_iova(next);
+	next_iova->prev_iova = iova->prev_iova;
+	next_iova->allocatable_size = iova_compute_allocatable_size(next_iova);
+	iova_max_allocatable_size_update(next_iova);
+	rb_erase_augmented(&iova->node, &iovad->rbroot, &iova_gap_callbacks);
 }
 
 /**
@@ -554,8 +698,11 @@ static void
 __adjust_overlap_range(struct iova *iova,
 	unsigned long *pfn_lo, unsigned long *pfn_hi)
 {
-	if (*pfn_lo < iova->pfn_lo)
+	if (*pfn_lo < iova->pfn_lo) {
 		iova->pfn_lo = *pfn_lo;
+		iova->allocatable_size = iova_compute_allocatable_size(iova);
+		iova_max_allocatable_size_update(iova);
+	}
 	if (*pfn_hi > iova->pfn_hi)
 		*pfn_lo = iova->pfn_hi + 1;
 }
diff --git a/include/linux/iova.h b/include/linux/iova.h
index 320a70e40233..8eb9ea339289 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -11,7 +11,7 @@
 
 #include <linux/types.h>
 #include <linux/kernel.h>
-#include <linux/rbtree.h>
+#include <linux/rbtree_augmented.h>
 #include <linux/dma-mapping.h>
 
 /* iova structure */
@@ -19,6 +19,14 @@ struct iova {
 	struct rb_node	node;
 	unsigned long	pfn_hi; /* Highest allocated pfn */
 	unsigned long	pfn_lo; /* Lowest allocated pfn */
+	struct iova	*prev_iova;
+	/*
+	 * The max size of iova can be allocated from a gap between this iova
+	 * and previous iova.
+	 */
+	unsigned long	allocatable_size;
+	/* The maximum value of all allocatable_size in the subtree. */
+	unsigned long	max_allocatable_size;
 };
 
 
-- 
2.20.1

