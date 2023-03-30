Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99C86D0E50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjC3TGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbjC3TGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:06:45 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32EC1FC1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:06:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id er13so39514014edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680203202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gMDPnWdVAheu+FA3sHgGScLosUagPVFRIRKD4ygdXQc=;
        b=WUzsrGzNWUdd1YAcnxKaOXUtvUv60m4ynOJ6mZF/3yOTaGOHil5RqR67nCqK76fiWg
         qXYstK2Ec/btAxG4dKUELsg5NXB/TY04klx5r/RlH0wcZNoIt1x4oaTw4mqMkP0byHRs
         crSNNwtzE6ltpnTbf5/bcLbQQgYSXAXbupmZor3cNMlNxnIwvPOdxXPWM60591xokuoC
         Qdumg3jBYH99mn4dbDsIocFr0807D8RpHRP25kenEtGwUcxHXtd9cqCiNOcQDpBAPZQd
         0xB1WHe2Rp7m8x/iRq+NnpWSdnb+cdq40zlKV/eGBf99ye1h7G8lYm3R7J1xBJYLRfLJ
         6SyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMDPnWdVAheu+FA3sHgGScLosUagPVFRIRKD4ygdXQc=;
        b=Ee+fkHUvmO0OrJKa/a2A5E/wwvmJku3HNMQoNMTZiQ+FBZbNKTEKmSILdmRhKG9N8B
         C7cyxjWEpkwcg7P5MbDOQNGWFgg0gOnBYgCfHzQlvuHEoQ/IEU8UoY4bJ9/YD3Ws9UUF
         jNaFKqK3ZRkoZCKzhuRVvHfbmJCOKYVtIjlnBBCkK1uCAjn9S+bt5vVzVNAc9HtPdeUK
         hIjZODrl5N7Ygy8IOQo4a7pFt0RUJq9PtlBJmcxZ0GRcO8wktK/4mh9ttC4LsUIV9105
         5Bk4R9nZaSpA8lC7GQ4ICQcmynAokOvVEJRlfk3M5TzRLt8m6p0E/O0zW2Hnku/Vi9ZV
         ydMg==
X-Gm-Message-State: AAQBX9cM7yaHdZZVGWVvkFug9fTyWDmWnlzB+BeDDQck1sx5lRgKpINO
        pJiTwhglh/TZuC9goQKSUjg=
X-Google-Smtp-Source: AKy350Z+T9Xa3XfgAZWVQCHn67yDcdOVbMXZ1ew13MH6IyKVaA2hqPyeLjjE4gSc1jfMWXDPJiZOog==
X-Received: by 2002:a17:907:25cd:b0:93e:9362:75fe with SMTP id ae13-20020a17090725cd00b0093e936275femr28223925ejc.76.1680203202187;
        Thu, 30 Mar 2023 12:06:42 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o18-20020a17090608d200b0092973e209f2sm122240eje.109.2023.03.30.12.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 12:06:41 -0700 (PDT)
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
Subject: [PATCH v4 1/2] mm: vmalloc: Remove a global vmap_blocks xarray
Date:   Thu, 30 Mar 2023 21:06:38 +0200
Message-Id: <20230330190639.431589-1-urezki@gmail.com>
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

Running the test_vmalloc.sh run_test_mask=1024 nr_threads=64 nr_pages=5
shows around ~8 percent of throughput improvement of vm_map_ram() and
vm_unmap_ram() APIs.

This patch does not fix vmap_area_lock/free_vmap_area_lock and
purge_vmap_area_lock bottle-necks, it is rather a separate rework.

v1 - v2:
   - Add more comments(Andrew Morton req.)
   - Switch to WARN_ON_ONCE(Lorenzo Stoakes req.)

v2 -> v3:
   - Fix a kernel-doc complain(Matthew Wilcox)

v3 -> v4:
   - Improve comments about hashing logic(Lorenzo Stoakes)
   - Improve code design(Lorenzo Stoakes)
   - Keep the addr_to_vb_idx() func. to cut index length(Baoquan He)

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 63 insertions(+), 8 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 978194dc2bb8..671d6d5d5b78 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1911,6 +1911,13 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 struct vmap_block_queue {
 	spinlock_t lock;
 	struct list_head free;
+
+	/*
+	 * An xarray requires an extra memory dynamically to
+	 * be allocated. If it is an issue, we can use rb-tree
+	 * instead.
+	 */
+	struct xarray vmap_blocks;
 };
 
 struct vmap_block {
@@ -1928,11 +1935,48 @@ struct vmap_block {
 static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
 
 /*
- * XArray of vmap blocks, indexed by address, to quickly find a vmap block
- * in the free path. Could get rid of this if we change the API to return a
- * "cookie" from alloc, to be passed to free. But no big deal yet.
+ * In order to fast access to any "vmap_block" associated with a
+ * specific address, we use a hash.
+ *
+ * A per-cpu vmap_block_queue is used in both ways, to serialize
+ * an access to free block chains among CPUs(alloc path) and it
+ * also acts as a vmap_block hash(alloc/free paths). It means we
+ * overload it, since we already have the per-cpu array which is
+ * used as a hash table. When used as a hash a 'cpu' passed to
+ * per_cpu() is not actually a CPU but rather a hash index.
+ *
+ * A hash function is addr_to_vb_xarray() which hashes any address
+ * to a specific index(in a hash) it belongs to. This then uses a
+ * per_cpu() macro to access an array with generated index.
+ *
+ * An example:
+ *
+ *  CPU_1  CPU_2  CPU_0
+ *    |      |      |
+ *    V      V      V
+ * 0     10     20     30     40     50     60
+ * |------|------|------|------|------|------|...<vmap address space>
+ *   CPU0   CPU1   CPU2   CPU0   CPU1   CPU2
+ *
+ * - CPU_1 invokes vm_unmap_ram(6), 6 belongs to CPU0 zone, thus
+ *   it access: CPU0/INDEX0 -> vmap_blocks -> xa_lock;
+ *
+ * - CPU_2 invokes vm_unmap_ram(11), 11 belongs to CPU1 zone, thus
+ *   it access: CPU1/INDEX1 -> vmap_blocks -> xa_lock;
+ *
+ * - CPU_0 invokes vm_unmap_ram(20), 20 belongs to CPU2 zone, thus
+ *   it access: CPU2/INDEX2 -> vmap_blocks -> xa_lock.
+ *
+ * This technique almost always avoids lock contention on insert/remove,
+ * however xarray spinlocks protect against any contention that remains.
  */
-static DEFINE_XARRAY(vmap_blocks);
+static struct xarray *
+addr_to_vb_xarray(unsigned long addr)
+{
+	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
+
+	return &per_cpu(vmap_block_queue, index).vmap_blocks;
+}
 
 /*
  * We should probably have a fallback mechanism to allocate virtual memory
@@ -1970,6 +2014,7 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	struct vmap_block_queue *vbq;
 	struct vmap_block *vb;
 	struct vmap_area *va;
+	struct xarray *xa;
 	unsigned long vb_idx;
 	int node, err;
 	void *vaddr;
@@ -2003,8 +2048,9 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	bitmap_set(vb->used_map, 0, (1UL << order));
 	INIT_LIST_HEAD(&vb->free_list);
 
+	xa = addr_to_vb_xarray(va->va_start);
 	vb_idx = addr_to_vb_idx(va->va_start);
-	err = xa_insert(&vmap_blocks, vb_idx, vb, gfp_mask);
+	err = xa_insert(xa, vb_idx, vb, gfp_mask);
 	if (err) {
 		kfree(vb);
 		free_vmap_area(va);
@@ -2022,8 +2068,10 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 static void free_vmap_block(struct vmap_block *vb)
 {
 	struct vmap_block *tmp;
+	struct xarray *xa;
 
-	tmp = xa_erase(&vmap_blocks, addr_to_vb_idx(vb->va->va_start));
+	xa = addr_to_vb_xarray(vb->va->va_start);
+	tmp = xa_erase(xa, addr_to_vb_idx(vb->va->va_start));
 	BUG_ON(tmp != vb);
 
 	spin_lock(&vmap_area_lock);
@@ -2135,6 +2183,7 @@ static void vb_free(unsigned long addr, unsigned long size)
 	unsigned long offset;
 	unsigned int order;
 	struct vmap_block *vb;
+	struct xarray *xa;
 
 	BUG_ON(offset_in_page(size));
 	BUG_ON(size > PAGE_SIZE*VMAP_MAX_ALLOC);
@@ -2143,7 +2192,10 @@ static void vb_free(unsigned long addr, unsigned long size)
 
 	order = get_order(size);
 	offset = (addr & (VMAP_BLOCK_SIZE - 1)) >> PAGE_SHIFT;
-	vb = xa_load(&vmap_blocks, addr_to_vb_idx(addr));
+
+	xa = addr_to_vb_xarray(addr);
+	vb = xa_load(xa, addr_to_vb_idx(addr));
+
 	spin_lock(&vb->lock);
 	bitmap_clear(vb->used_map, offset, (1UL << order));
 	spin_unlock(&vb->lock);
@@ -3486,6 +3538,7 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
 {
 	char *start;
 	struct vmap_block *vb;
+	struct xarray *xa;
 	unsigned long offset;
 	unsigned int rs, re, n;
 
@@ -3503,7 +3556,8 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
 	 * Area is split into regions and tracked with vmap_block, read out
 	 * each region and zero fill the hole between regions.
 	 */
-	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
+	xa = addr_to_vb_xarray((unsigned long) addr);
+	vb = xa_load(xa, addr_to_vb_idx((unsigned long)addr));
 	if (!vb)
 		goto finished;
 
@@ -4272,6 +4326,7 @@ void __init vmalloc_init(void)
 		p = &per_cpu(vfree_deferred, i);
 		init_llist_head(&p->list);
 		INIT_WORK(&p->wq, delayed_vfree_work);
+		xa_init(&vbq->vmap_blocks);
 	}
 
 	/* Import existing vmlist entries. */
-- 
2.30.2

