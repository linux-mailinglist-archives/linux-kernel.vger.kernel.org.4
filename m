Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0536B9669
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCNNhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjCNNhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:37:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACCC6A426
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:33:33 -0700 (PDT)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PbXzR67ZhzHwfV;
        Tue, 14 Mar 2023 20:34:59 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 14 Mar 2023 20:37:09 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <vbabka@suse.cz>
CC:     <xuqiang36@huawei.com>, <chenjun102@huawei.com>,
        <wangkefeng.wang@huawei.com>
Subject: [PATCH] mm/slub: Reduce memory consumption in extreme scenarios
Date:   Tue, 14 Mar 2023 12:34:03 +0000
Message-ID: <20230314123403.100158-1-chenjun102@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kmalloc_node() is called without __GFP_THISNODE and the target node
lacks sufficient memory, SLUB allocates a folio from a different node
other than the requested node, instead of taking a partial slab from it.

However, since the allocated folio does not belong to the requested
node, it is deactivated and added to the partial slab list of the node
it belongs to.

This behavior can result in excessive memory usage when the requested
node has insufficient memory, as SLUB will repeatedly allocate folios
from other nodes without reusing the previously allocated ones.

To prevent memory wastage,
when (node != NUMA_NO_NODE) && (gfpflags & __GFP_THISNODE) is:
1) try to get a partial slab from target node with __GFP_THISNODE.
2) if 1) failed, try to allocate a new slab from target node with
   __GFP_THISNODE.
3) if 2) failed, retry 1) and 2) without __GFP_THISNODE constraint.

when node != NUMA_NO_NODE || (gfpflags & __GFP_THISNODE), the behavior
remains unchanged.

On qemu with 4 numa nodes and each numa has 1G memory. Write a test ko
to call kmalloc_node(196, GFP_KERNEL, 3) for (4 * 1024 + 4) * 1024 times.

cat /proc/slabinfo shows:
kmalloc-256       4200530 13519712    256   32    2 : tunables..

after this patch,
cat /proc/slabinfo shows:
kmalloc-256       4200558 4200768    256   32    2 : tunables..

Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 mm/slub.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 39327e98fce3..32e436957e03 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2384,7 +2384,7 @@ static void *get_partial(struct kmem_cache *s, int node, struct partial_context
 		searchnode = numa_mem_id();
 
 	object = get_partial_node(s, get_node(s, searchnode), pc);
-	if (object || node != NUMA_NO_NODE)
+	if (object || (node != NUMA_NO_NODE && (pc->flags & __GFP_THISNODE)))
 		return object;
 
 	return get_any_partial(s, pc);
@@ -3069,6 +3069,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	struct slab *slab;
 	unsigned long flags;
 	struct partial_context pc;
+	bool try_thisnode = true;
 
 	stat(s, ALLOC_SLOWPATH);
 
@@ -3181,8 +3182,18 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	}
 
 new_objects:
-
 	pc.flags = gfpflags;
+
+	/*
+	 * when (node != NUMA_NO_NODE) && (gfpflags & __GFP_THISNODE)
+	 * 1) try to get a partial slab from target node with __GFP_THISNODE.
+	 * 2) if 1) failed, try to allocate a new slab from target node with
+	 *    __GFP_THISNODE.
+	 * 3) if 2) failed, retry 1) and 2) without __GFP_THISNODE constraint.
+	 */
+	if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode)
+			pc.flags |= __GFP_THISNODE;
+
 	pc.slab = &slab;
 	pc.orig_size = orig_size;
 	freelist = get_partial(s, node, &pc);
@@ -3190,10 +3201,15 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto check_new_slab;
 
 	slub_put_cpu_ptr(s->cpu_slab);
-	slab = new_slab(s, gfpflags, node);
+	slab = new_slab(s, pc.flags, node);
 	c = slub_get_cpu_ptr(s->cpu_slab);
 
 	if (unlikely(!slab)) {
+		if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode) {
+			try_thisnode = false;
+			goto new_objects;
+		}
+
 		slab_out_of_memory(s, gfpflags, node);
 		return NULL;
 	}
-- 
2.17.1

