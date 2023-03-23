Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391DD6C70FB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 20:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjCWTVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 15:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjCWTVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 15:21:32 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CD2E188
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:21:16 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ew6so28201364edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679599275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5k6nQvr+OAnndWm5Fm48bRo3kejRzJbUnDprd7Qh5FQ=;
        b=IplSCuy7Ci5TZrXducJfaeYesnruom2cYs74x5WP9HCfDT57vEDfBVZ+X7NyH7j79W
         yXbmHDrP+L9GzimyTtFrzLuk9siC/JjDqQI6Ay1X1Y6M+mODmylo+0qejtICjEFW6nk7
         VUBvyRC3fpFt5b3Jd705/z+DVOmq5LPVsjOo+/PK3QAn+nw7uwdIAdd9TnzNDGmwcr9S
         MEkRfubcyn9zr2ZuWBWRRaqOzXo6UlDfhd8QQeENDVsy+5AggNIxWAMwyTSwMhETLnen
         9vc3NYu/hSohZV4N7Hifc6fv4Ap+t5/o44UV1Yw+D8k6CH0yBtJEaVAIC14F2vsp71FF
         H70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679599275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5k6nQvr+OAnndWm5Fm48bRo3kejRzJbUnDprd7Qh5FQ=;
        b=4F8tjgTsZu5d6nEq7ucU/kZFBOTfRqdvF/uOy7DL2iDwponUfNICWusMQcf4JRYle8
         QcMNA8KHym4kv2uPTPXOZMG+KTr75rq65GsXhftT+cfiKnb+ZHEYBGR19EKUWV5naMfs
         as8HXn/M+QsLsiKxklOUO3UBwb2dTIuUQaJYjrZr6ESmK0atADaMLE+tZK8e7PSxrHqg
         UTULmrYJk7MwZIvwoMbyuTeK9ztRch4rkbUEdN27cdLVhKk17sbStO46LviC+bS70JXS
         7ISjcv3nI31Gjd4cI5ziGFCXmOosIlM+g7+wW1ukMQSgHg0Jq0bDLWnSCsLx2RUJTJ0u
         DTlA==
X-Gm-Message-State: AAQBX9clPNTm/MFxepkDYPp0Q3CrDSvrMYFiACKjfp7GKb1QBMtyVICe
        IPxeK/+4nUwrbfXdv12gCeo=
X-Google-Smtp-Source: AKy350aT9RetWNYMtA/DMqLMcjWJycj9i8QSHZRi78UI2y3XtCDrFQeGuoiG9bJBi5veZc+ec4I+KA==
X-Received: by 2002:a17:907:248c:b0:931:bbcf:eb6b with SMTP id zg12-20020a170907248c00b00931bbcfeb6bmr114330ejb.63.1679599274770;
        Thu, 23 Mar 2023 12:21:14 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id lz24-20020a170906fb1800b009334309eda5sm7213127ejb.196.2023.03.23.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 12:21:14 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 1/1] mm: vmalloc: Remove a global vmap_blocks xarray
Date:   Thu, 23 Mar 2023 20:21:11 +0100
Message-Id: <20230323192111.1501308-1-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A global vmap_blocks-xarray array can be contented under
heavy usage of the vm_map_ram()/vm_unmap_ram() APIs. The
lock_stat shows that a "vmap_blocks.xa_lock" lock is a
second in a top-list when it comes to contentions:

<snip>
----------------------------------------
class name con-bounces contentions ...
----------------------------------------
vmap_area_lock:         2554079 2554276 ...
  --------------
  vmap_area_lock        1297948  [<00000000dd41cbaa>] alloc_vmap_area+0x1c7/0x910
  vmap_area_lock        1256330  [<000000009d927bf3>] free_vmap_block+0x4a/0xe0
  vmap_area_lock              1  [<00000000c95c05a7>] find_vm_area+0x16/0x70
  --------------
  vmap_area_lock        1738590  [<00000000dd41cbaa>] alloc_vmap_area+0x1c7/0x910
  vmap_area_lock         815688  [<000000009d927bf3>] free_vmap_block+0x4a/0xe0
  vmap_area_lock              1  [<00000000c1d619d7>] __get_vm_area_node+0xd2/0x170

vmap_blocks.xa_lock:    862689  862698 ...
  -------------------
  vmap_blocks.xa_lock   378418    [<00000000625a5626>] vm_map_ram+0x359/0x4a0
  vmap_blocks.xa_lock   484280    [<00000000caa2ef03>] xa_erase+0xe/0x30
  -------------------
  vmap_blocks.xa_lock   576226    [<00000000caa2ef03>] xa_erase+0xe/0x30
  vmap_blocks.xa_lock   286472    [<00000000625a5626>] vm_map_ram+0x359/0x4a0
...
<snip>

that is a result of running vm_map_ram()/vm_unmap_ram() in
a loop. The test creates 64(on 64 CPUs system) threads and
each one maps/unmaps 1 page.

After this change the "xa_lock" can be considered as a noise
in the same test condition:

<snip>
...
&xa->xa_lock#1:         10333 10394 ...
  --------------
  &xa->xa_lock#1        5349      [<00000000bbbc9751>] xa_erase+0xe/0x30
  &xa->xa_lock#1        5045      [<0000000018def45d>] vm_map_ram+0x3a4/0x4f0
  --------------
  &xa->xa_lock#1        7326      [<0000000018def45d>] vm_map_ram+0x3a4/0x4f0
  &xa->xa_lock#1        3068      [<00000000bbbc9751>] xa_erase+0xe/0x30
...
<snip>

This patch does not fix vmap_area_lock/free_vmap_area_lock and
purge_vmap_area_lock bottle-necks, it is rather a separate rework.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 978194dc2bb8..13b5342bed9a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1911,6 +1911,7 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 struct vmap_block_queue {
 	spinlock_t lock;
 	struct list_head free;
+	struct xarray vmap_blocks;
 };
 
 struct vmap_block {
@@ -1927,25 +1928,18 @@ struct vmap_block {
 /* Queue of free and dirty vmap blocks, for allocation and flushing purposes */
 static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
 
-/*
- * XArray of vmap blocks, indexed by address, to quickly find a vmap block
- * in the free path. Could get rid of this if we change the API to return a
- * "cookie" from alloc, to be passed to free. But no big deal yet.
- */
-static DEFINE_XARRAY(vmap_blocks);
-
-/*
- * We should probably have a fallback mechanism to allocate virtual memory
- * out of partially filled vmap blocks. However vmap block sizing should be
- * fairly reasonable according to the vmalloc size, so it shouldn't be a
- * big problem.
- */
+static struct vmap_block_queue *
+addr_to_vbq(unsigned long addr)
+{
+	int cpu = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+	return &per_cpu(vmap_block_queue, cpu);
+}
 
-static unsigned long addr_to_vb_idx(unsigned long addr)
+static unsigned long
+addr_to_vb_va_start(unsigned long addr)
 {
-	addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
-	addr /= VMAP_BLOCK_SIZE;
-	return addr;
+	/* A start address of block an address belongs to. */
+	return rounddown(addr, VMAP_BLOCK_SIZE);
 }
 
 static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
@@ -1953,7 +1947,7 @@ static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
 	unsigned long addr;
 
 	addr = va_start + (pages_off << PAGE_SHIFT);
-	BUG_ON(addr_to_vb_idx(addr) != addr_to_vb_idx(va_start));
+	BUG_ON(addr_to_vb_va_start(addr) != addr_to_vb_va_start(va_start));
 	return (void *)addr;
 }
 
@@ -1970,7 +1964,6 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	struct vmap_block_queue *vbq;
 	struct vmap_block *vb;
 	struct vmap_area *va;
-	unsigned long vb_idx;
 	int node, err;
 	void *vaddr;
 
@@ -2003,8 +1996,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	bitmap_set(vb->used_map, 0, (1UL << order));
 	INIT_LIST_HEAD(&vb->free_list);
 
-	vb_idx = addr_to_vb_idx(va->va_start);
-	err = xa_insert(&vmap_blocks, vb_idx, vb, gfp_mask);
+	vbq = addr_to_vbq(va->va_start);
+	err = xa_insert(&vbq->vmap_blocks, va->va_start, vb, gfp_mask);
 	if (err) {
 		kfree(vb);
 		free_vmap_area(va);
@@ -2021,9 +2014,11 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 
 static void free_vmap_block(struct vmap_block *vb)
 {
+	struct vmap_block_queue *vbq;
 	struct vmap_block *tmp;
 
-	tmp = xa_erase(&vmap_blocks, addr_to_vb_idx(vb->va->va_start));
+	vbq = addr_to_vbq(vb->va->va_start);
+	tmp = xa_erase(&vbq->vmap_blocks, vb->va->va_start);
 	BUG_ON(tmp != vb);
 
 	spin_lock(&vmap_area_lock);
@@ -2135,6 +2130,7 @@ static void vb_free(unsigned long addr, unsigned long size)
 	unsigned long offset;
 	unsigned int order;
 	struct vmap_block *vb;
+	struct vmap_block_queue *vbq;
 
 	BUG_ON(offset_in_page(size));
 	BUG_ON(size > PAGE_SIZE*VMAP_MAX_ALLOC);
@@ -2143,7 +2139,10 @@ static void vb_free(unsigned long addr, unsigned long size)
 
 	order = get_order(size);
 	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
-	vb = xa_load(&vmap_blocks, addr_to_vb_idx(addr));
+
+	vbq = addr_to_vbq(addr);
+	vb = xa_load(&vbq->vmap_blocks, addr_to_vb_va_start(addr));
+
 	spin_lock(&vb->lock);
 	bitmap_clear(vb->used_map, offset, (1UL << order));
 	spin_unlock(&vb->lock);
@@ -3486,6 +3485,7 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
 {
 	char *start;
 	struct vmap_block *vb;
+	struct vmap_block_queue *vbq;
 	unsigned long offset;
 	unsigned int rs, re, n;
 
@@ -3503,7 +3503,8 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
 	 * Area is split into regions and tracked with vmap_block, read out
 	 * each region and zero fill the hole between regions.
 	 */
-	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
+	vbq = addr_to_vbq((unsigned long) addr);
+	vb = xa_load(&vbq->vmap_blocks, addr_to_vb_va_start((unsigned long) addr));
 	if (!vb)
 		goto finished;
 
@@ -4272,6 +4273,7 @@ void __init vmalloc_init(void)
 		p = &per_cpu(vfree_deferred, i);
 		init_llist_head(&p->list);
 		INIT_WORK(&p->wq, delayed_vfree_work);
+		xa_init(&vbq->vmap_blocks);
 	}
 
 	/* Import existing vmlist entries. */
-- 
2.30.2

