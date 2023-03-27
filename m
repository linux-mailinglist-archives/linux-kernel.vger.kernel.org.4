Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119BC6CAB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjC0RBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbjC0RBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:01:37 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFB74216
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:01:29 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ew6so38931124edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679936488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MiwTgU7gCi7Y1Efu5iqCpK4GW+Ibe2u/4CDr6wU0ciU=;
        b=VuwcNy6RW81yA7xf/j2OkbcH2aJCR/IAPvX6ggUPJyMiRJOM3xgphsThTHMf3iIWsk
         qADyQMlC7N17pNN2HHtsL4sNmyhlr/NUlU3gfAaXaHdNbHsd3MCdirAT7CZyBIhXLnji
         rFHFUxKWDyR5+1AhUnW3m32hwt2egzgc3MyFr1Va4p+DaYpXcBD1GSb9Kc2gdDptu3g2
         qaKlY4AHOuXzQ3n7lViZv97v6u8YplWfF98/CgL8b7+exOQLmyVwB3SwkhG+uomPgYnX
         kFq2JmFvC9T9CmDuDz0G2k341sJinKa0gqoFeR4r0pM6rqLFiUvrZtQSG90xSt70YBOf
         Fzvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MiwTgU7gCi7Y1Efu5iqCpK4GW+Ibe2u/4CDr6wU0ciU=;
        b=GW+nGpK59VKVR+xT18hb9qu5/X26O+yC2a+pfCa14e6PlrhoSuLi7XRjnsQb3oRgmC
         EdpIz9dPVN1oAEdAW1IBGAhWCX+ohbM7ibLOQJXfzr3491O24AUmvsCQjOUmUSRyTNqf
         IwGmB0OSGIUiX0DDeWAgK5MBO7ZXRCAafE05VR2ldVAfCrFcAFCmwpmWUpZMO/8dY3mr
         3VujTSh3eUof21vN9AqKR+F5Vk7SHY9L24Zq4mdGPSrJRBnUtzdFqVSTLduDc4malj1W
         fF7UpLuGVau2/VkVtFQp6a/k7b1f7UQ8ahDxbNyOHg1BDfwyKu61HFKPAWnava5j2qns
         DxqA==
X-Gm-Message-State: AAQBX9c90i+2q+8eIcALtmT4+H0BIOjZ691Li4hcK8E2xJSjK5VsIoBT
        ywrcvZMSmHmjCjGPNIB7DLI=
X-Google-Smtp-Source: AKy350blcU31zArFdsw3R4rpxiKy5JwQp/0Wh2XL2VeKxnjpCY4W9K1IjkEdzo3FsQlP0SswPG9PDA==
X-Received: by 2002:aa7:c54f:0:b0:4fa:4bc4:a911 with SMTP id s15-20020aa7c54f000000b004fa4bc4a911mr12898927edr.13.1679936488024;
        Mon, 27 Mar 2023 10:01:28 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id t27-20020a50ab5b000000b004c0c5864cc5sm14936026edc.25.2023.03.27.10.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:01:27 -0700 (PDT)
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
Subject: [PATCH v3 1/2] mm: vmalloc: Remove a global vmap_blocks xarray
Date:   Mon, 27 Mar 2023 19:01:25 +0200
Message-Id: <20230327170126.406044-1-urezki@gmail.com>
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

v1 - v2:
   - Add more comments(Andrew Morton req.)
   - Switch to WARN_ON_ONCE(Lorenzo Stoakes req.)

v2 -> v3:
   - Fix a kernel-doc complain(Matthew Wilcox)

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 85 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 21 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 978194dc2bb8..821256ecf81c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1908,9 +1908,22 @@ static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 #define VMAP_BLOCK		0x2 /* mark out the vmap_block sub-type*/
 #define VMAP_FLAGS_MASK		0x3
 
+/*
+ * We should probably have a fallback mechanism to allocate virtual memory
+ * out of partially filled vmap blocks. However vmap block sizing should be
+ * fairly reasonable according to the vmalloc size, so it shouldn't be a
+ * big problem.
+ */
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
@@ -1928,24 +1941,46 @@ struct vmap_block {
 static DEFINE_PER_CPU(struct vmap_block_queue, vmap_block_queue);
 
 /*
- * XArray of vmap blocks, indexed by address, to quickly find a vmap block
- * in the free path. Could get rid of this if we change the API to return a
- * "cookie" from alloc, to be passed to free. But no big deal yet.
+ * In order to fast access to any "vmap_block" associated with a
+ * specific address, we store them into a per-cpu xarray. A hash
+ * function is addr_to_vbq() whereas a key is a vb->va->va_start
+ * value.
+ *
+ * Please note, a vmap_block_queue, which is a per-cpu, is not
+ * serialized by a raw_smp_processor_id() current CPU, instead
+ * it is chosen based on a CPU-index it belongs to, i.e. it is
+ * a hash-table.
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
  */
-static DEFINE_XARRAY(vmap_blocks);
+static struct vmap_block_queue *
+addr_to_vbq(unsigned long addr)
+{
+	int index = (addr / VMAP_BLOCK_SIZE) % num_possible_cpus();
 
-/*
- * We should probably have a fallback mechanism to allocate virtual memory
- * out of partially filled vmap blocks. However vmap block sizing should be
- * fairly reasonable according to the vmalloc size, so it shouldn't be a
- * big problem.
- */
+	return &per_cpu(vmap_block_queue, index);
+}
 
-static unsigned long addr_to_vb_idx(unsigned long addr)
+static unsigned long
+addr_to_vb_va_start(unsigned long addr)
 {
-	addr -= VMALLOC_START & ~(VMAP_BLOCK_SIZE-1);
-	addr /= VMAP_BLOCK_SIZE;
-	return addr;
+	return rounddown(addr, VMAP_BLOCK_SIZE);
 }
 
 static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
@@ -1953,7 +1988,7 @@ static void *vmap_block_vaddr(unsigned long va_start, unsigned long pages_off)
 	unsigned long addr;
 
 	addr = va_start + (pages_off << PAGE_SHIFT);
-	BUG_ON(addr_to_vb_idx(addr) != addr_to_vb_idx(va_start));
+	WARN_ON_ONCE(addr_to_vb_va_start(addr) != va_start);
 	return (void *)addr;
 }
 
@@ -1970,7 +2005,6 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	struct vmap_block_queue *vbq;
 	struct vmap_block *vb;
 	struct vmap_area *va;
-	unsigned long vb_idx;
 	int node, err;
 	void *vaddr;
 
@@ -2003,8 +2037,8 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 	bitmap_set(vb->used_map, 0, (1UL << order));
 	INIT_LIST_HEAD(&vb->free_list);
 
-	vb_idx = addr_to_vb_idx(va->va_start);
-	err = xa_insert(&vmap_blocks, vb_idx, vb, gfp_mask);
+	vbq = addr_to_vbq(va->va_start);
+	err = xa_insert(&vbq->vmap_blocks, va->va_start, vb, gfp_mask);
 	if (err) {
 		kfree(vb);
 		free_vmap_area(va);
@@ -2021,9 +2055,11 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 
 static void free_vmap_block(struct vmap_block *vb)
 {
+	struct vmap_block_queue *vbq;
 	struct vmap_block *tmp;
 
-	tmp = xa_erase(&vmap_blocks, addr_to_vb_idx(vb->va->va_start));
+	vbq = addr_to_vbq(vb->va->va_start);
+	tmp = xa_erase(&vbq->vmap_blocks, vb->va->va_start);
 	BUG_ON(tmp != vb);
 
 	spin_lock(&vmap_area_lock);
@@ -2135,6 +2171,7 @@ static void vb_free(unsigned long addr, unsigned long size)
 	unsigned long offset;
 	unsigned int order;
 	struct vmap_block *vb;
+	struct vmap_block_queue *vbq;
 
 	BUG_ON(offset_in_page(size));
 	BUG_ON(size > PAGE_SIZE*VMAP_MAX_ALLOC);
@@ -2143,7 +2180,10 @@ static void vb_free(unsigned long addr, unsigned long size)
 
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
@@ -3486,6 +3526,7 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
 {
 	char *start;
 	struct vmap_block *vb;
+	struct vmap_block_queue *vbq;
 	unsigned long offset;
 	unsigned int rs, re, n;
 
@@ -3503,7 +3544,8 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
 	 * Area is split into regions and tracked with vmap_block, read out
 	 * each region and zero fill the hole between regions.
 	 */
-	vb = xa_load(&vmap_blocks, addr_to_vb_idx((unsigned long)addr));
+	vbq = addr_to_vbq((unsigned long) addr);
+	vb = xa_load(&vbq->vmap_blocks, addr_to_vb_va_start((unsigned long) addr));
 	if (!vb)
 		goto finished;
 
@@ -4272,6 +4314,7 @@ void __init vmalloc_init(void)
 		p = &per_cpu(vfree_deferred, i);
 		init_llist_head(&p->list);
 		INIT_WORK(&p->wq, delayed_vfree_work);
+		xa_init(&vbq->vmap_blocks);
 	}
 
 	/* Import existing vmlist entries. */
-- 
2.30.2

