Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7466AD947
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCGIbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCGIbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:31:10 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B949E4B824
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:31:05 -0800 (PST)
Received: from dggpemm500006.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4PW7rq1FCbzKq79;
        Tue,  7 Mar 2023 16:28:59 +0800 (CST)
Received: from mdc.huawei.com (10.175.112.208) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 7 Mar 2023 16:31:03 +0800
From:   Chen Jun <chenjun102@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <vbabka@suse.cz>
CC:     <xuqiang36@huawei.com>, <chenjun102@huawei.com>
Subject: [RFC] mm/slub: Reduce memory consumption in extreme scenarios
Date:   Tue, 7 Mar 2023 08:28:11 +0000
Message-ID: <20230307082811.120774-1-chenjun102@huawei.com>
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

If call kmalloc_node with NO __GFP_THISNODE and node[A] with no memory.
Slub will alloc a slub page which is not belong to A, and put the page
to kmem_cache_node[page_to_nid(page)]. The page can not be reused
at next calling, because NULL will be get from get_partical().
That make kmalloc_node consume more memory.

On qemu with 4 numas and each numa has 1G memory, Write a test ko
to call kmalloc_node(196, 0xd20c0, 3) for 5 * 1024 * 1024 times.

cat /proc/slabinfo shows:
kmalloc-256       4302317 15151808    256   32    2 : tunables..

the total objects is much more then active objects.

After this patch, cat /prac/slubinfo shows:
kmalloc-256       5244950 5245088    256   32    2 : tunables..

Signed-off-by: Chen Jun <chenjun102@huawei.com>
---
 mm/slub.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 39327e98fce3..c0090a5de54e 100644
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
+	int try_thisndoe = 0;
 
 	stat(s, ALLOC_SLOWPATH);
 
@@ -3181,8 +3182,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	}
 
 new_objects:
-
 	pc.flags = gfpflags;
+
+	/* Try to get page from specific node even if __GFP_THISNODE is not set */
+	if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode)
+			pc.flags |= __GFP_THISNODE;
+
 	pc.slab = &slab;
 	pc.orig_size = orig_size;
 	freelist = get_partial(s, node, &pc);
@@ -3190,10 +3195,16 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		goto check_new_slab;
 
 	slub_put_cpu_ptr(s->cpu_slab);
-	slab = new_slab(s, gfpflags, node);
+	slab = new_slab(s, pc.flags, node);
 	c = slub_get_cpu_ptr(s->cpu_slab);
 
 	if (unlikely(!slab)) {
+		/* Try to get page from any other node */
+		if (node != NUMA_NO_NODE && !(gfpflags & __GFP_THISNODE) && try_thisnode) {
+			try_thisnode = 0;
+			goto new_objects;
+		}
+
 		slab_out_of_memory(s, gfpflags, node);
 		return NULL;
 	}
-- 
2.17.1

