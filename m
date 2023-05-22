Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9882570BB58
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbjEVLOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjEVLOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:14:00 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DEC1BD4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96fab30d1e1so374667766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684753736; x=1687345736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrvLnO25dwGFFlUS7GxG9ba70dEBhOOiZuR4m0pcTUM=;
        b=flXewQ2yArAVYlv2skHOfRQSd1S7Cqlwt9MNZZJrqFsSrWWwyouqmQjJ95oq8wCC6C
         ad1/P8xGdXwlSwJMGJC8rDQai6cooJJwK0WkPCEKTPeV1R4JhMhzlsAxID+3OAx7hyz8
         qGIYAx4Fe+Vqa5htZtPnUE8LV6kn4rgy+MrpLn2fFSbuz9hRvORwAIU7W24PqNv/v/A+
         Vvb0nbx4byHbsHsQfe2U6VreF5LdyXSZ3hV+iYjamkAgVT/lQoTYVkBdU0CzbUpSU/0c
         71/85NUEE602yGx29yMZLdgzUhf6phivNIaZUU/ts0HMXqTu7rh81+XTKlpL8mliOzmO
         yxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753736; x=1687345736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrvLnO25dwGFFlUS7GxG9ba70dEBhOOiZuR4m0pcTUM=;
        b=h2Kwnm8vDDqbKunIIATkwt0b+UcxSqEo01h6/45STBs0711TjZwFQEnrawbLF9ANQQ
         k954fTwA1a0MEBa/y8YLZv0hjgOwbB5ZlQYKKhWh5uk/F7bSuPGMOa99TcSo+9XBjS9I
         q/amZY1cYcfmpEWQqQqgCAmPkh6WuGXNVyC3MK15e/07qo7Q+lfCKFC3NcQBUlLdzVSL
         FTlGpe+51SFVH1YOgP0P+uip2uO8XnyoOAgjduYDkj5kqnGvxXkhOwCvJZZa7N8a9tbo
         uPPxZT3df8jMbXCZ5zJvK2CBgERYqRVNcNnuCY0PDSLcrFmqyX0dw6ZVc5C5ogX6tLHM
         YXMg==
X-Gm-Message-State: AC+VfDzHgwMa8o5V+1pRfW3uKWEUpKPGwIPtvnBnK/7t80kX9aV7tJUZ
        Vrx1HNQxRVpEw/Ngbl0SVpwsYZ2RnWm2Ew==
X-Google-Smtp-Source: ACHHUZ7/gXy6/G0+Tbl7lFR3/PBdDHxq7cTgGtR+aeCBks9BrXjxTCNVbHQV45jJ3L/ks2X1AHOsiw==
X-Received: by 2002:a17:907:961e:b0:96f:c545:6fd with SMTP id gb30-20020a170907961e00b0096fc54506fdmr4438428ejc.10.1684753736024;
        Mon, 22 May 2023 04:08:56 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id lx19-20020a170906af1300b0094f07545d40sm2949453ejb.220.2023.05.22.04.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 04:08:55 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 5/9] mm: vmalloc: Insert busy-VA per-cpu zone
Date:   Mon, 22 May 2023 13:08:45 +0200
Message-Id: <20230522110849.2921-6-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522110849.2921-1-urezki@gmail.com>
References: <20230522110849.2921-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store busy-VA objects per a CPU zone. A va->va_start address is
converted into a correct zone where it is placed and resides. An
addr_to_cvz() function is used to do a proper address conversion.

Such approach balances VAs across CPUs. That is why an access
becomes scalable to number of CPUs in a system.

Please note:

Since a zone size is set to ULONG_MAX, i.e. everything is bound
thus accessed to the CPU_0 so far, this patch does not give any
difference comparing with a current behavior.

The global vmap_area_lock, vmap_area_root are removed as there
is no need in it anymore. The vmap_area_list is still kept and
is _empty_. It is exported for a kexec only.

The vmallocinfo and vread() have to be reworked to be able to
handle multiple zones. As a result of this patch it can handle
only one zone, i.e. when cache is disabled.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 127 ++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 84 insertions(+), 43 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index f6da2590b4de..a9170fe19909 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -729,11 +729,9 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 #define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
 
 
-static DEFINE_SPINLOCK(vmap_area_lock);
 static DEFINE_SPINLOCK(free_vmap_area_lock);
 /* Export for kexec only */
 LIST_HEAD(vmap_area_list);
-static struct rb_root vmap_area_root = RB_ROOT;
 static bool vmap_initialized __read_mostly;
 
 static struct rb_root purge_vmap_area_root = RB_ROOT;
@@ -823,7 +821,7 @@ addr_to_cpu(unsigned long addr)
 }
 
 static inline struct cpu_vmap_zone *
-__maybe_unused addr_to_cvz(unsigned long addr)
+addr_to_cvz(unsigned long addr)
 {
 	return &per_cpu(cpu_vmap_zone, addr_to_cpu(addr));
 }
@@ -859,10 +857,10 @@ unsigned long vmalloc_nr_pages(void)
 }
 
 /* Look up the first VA which satisfies addr < va_end, NULL if none. */
-static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr)
+static struct vmap_area *find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
 {
 	struct vmap_area *va = NULL;
-	struct rb_node *n = vmap_area_root.rb_node;
+	struct rb_node *n = root->rb_node;
 
 	addr = (unsigned long)kasan_reset_tag((void *)addr);
 
@@ -1608,12 +1606,14 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
  */
 static void free_vmap_area(struct vmap_area *va)
 {
+	struct cpu_vmap_zone *z = addr_to_cvz(va->va_start);
+
 	/*
 	 * Remove from the busy tree/list.
 	 */
-	spin_lock(&vmap_area_lock);
-	unlink_va(va, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	fbl_lock(z, BUSY);
+	unlink_va(va, &fbl_root(z, BUSY));
+	fbl_unlock(z, BUSY);
 
 	/*
 	 * Insert/Merge it back to the free tree/list.
@@ -1656,6 +1656,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 				int node, gfp_t gfp_mask,
 				unsigned long va_flags)
 {
+	struct cpu_vmap_zone *z;
 	struct vmap_area *va;
 	unsigned long freed;
 	unsigned long addr;
@@ -1701,9 +1702,11 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
 	va->vm = NULL;
 	va->flags = va_flags;
 
-	spin_lock(&vmap_area_lock);
-	insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
-	spin_unlock(&vmap_area_lock);
+	z = addr_to_cvz(va->va_start);
+
+	fbl_lock(z, BUSY);
+	insert_vmap_area(va, &fbl_root(z, BUSY), &fbl_head(z, BUSY));
+	fbl_unlock(z, BUSY);
 
 	BUG_ON(!IS_ALIGNED(va->va_start, align));
 	BUG_ON(va->va_start < vstart);
@@ -1926,24 +1929,26 @@ static void free_unmap_vmap_area(struct vmap_area *va)
 
 struct vmap_area *find_vmap_area(unsigned long addr)
 {
+	struct cpu_vmap_zone *z = addr_to_cvz(addr);
 	struct vmap_area *va;
 
-	spin_lock(&vmap_area_lock);
-	va = __find_vmap_area(addr, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	fbl_lock(z, BUSY);
+	va = __find_vmap_area(addr, &fbl_root(z, BUSY));
+	fbl_unlock(z, BUSY);
 
 	return va;
 }
 
 static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
 {
+	struct cpu_vmap_zone *z = addr_to_cvz(addr);
 	struct vmap_area *va;
 
-	spin_lock(&vmap_area_lock);
-	va = __find_vmap_area(addr, &vmap_area_root);
+	fbl_lock(z, BUSY);
+	va = __find_vmap_area(addr, &fbl_root(z, BUSY));
 	if (va)
-		unlink_va(va, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+		unlink_va(va, &fbl_root(z, BUSY));
+	fbl_unlock(z, BUSY);
 
 	return va;
 }
@@ -2095,14 +2100,17 @@ static void *new_vmap_block(unsigned int order, gfp_t gfp_mask)
 
 static void free_vmap_block(struct vmap_block *vb)
 {
+	struct cpu_vmap_zone *z;
 	struct vmap_block *tmp;
 
 	tmp = xa_erase(&vmap_blocks, addr_to_vb_idx(vb->va->va_start));
 	BUG_ON(tmp != vb);
 
-	spin_lock(&vmap_area_lock);
-	unlink_va(vb->va, &vmap_area_root);
-	spin_unlock(&vmap_area_lock);
+	z = addr_to_cvz(vb->va->va_start);
+
+	fbl_lock(z, BUSY);
+	unlink_va(vb->va, &fbl_root(z, BUSY));
+	fbl_unlock(z, BUSY);
 
 	free_vmap_area_noflush(vb->va);
 	kfree_rcu(vb, rcu_head);
@@ -2484,9 +2492,11 @@ static inline void setup_vmalloc_vm_locked(struct vm_struct *vm,
 static void setup_vmalloc_vm(struct vm_struct *vm, struct vmap_area *va,
 			      unsigned long flags, const void *caller)
 {
-	spin_lock(&vmap_area_lock);
+	struct cpu_vmap_zone *z = addr_to_cvz(va->va_start);
+
+	fbl_lock(z, BUSY);
 	setup_vmalloc_vm_locked(vm, va, flags, caller);
-	spin_unlock(&vmap_area_lock);
+	fbl_unlock(z, BUSY);
 }
 
 static void clear_vm_uninitialized_flag(struct vm_struct *vm)
@@ -3605,6 +3615,7 @@ static void vmap_ram_vread(char *buf, char *addr, int count, unsigned long flags
  */
 long vread(char *buf, char *addr, unsigned long count)
 {
+	struct cpu_vmap_zone *z;
 	struct vmap_area *va;
 	struct vm_struct *vm;
 	char *vaddr, *buf_start = buf;
@@ -3617,8 +3628,11 @@ long vread(char *buf, char *addr, unsigned long count)
 	if ((unsigned long) addr + count < count)
 		count = -(unsigned long) addr;
 
-	spin_lock(&vmap_area_lock);
-	va = find_vmap_area_exceed_addr((unsigned long)addr);
+	/* Hooked to CPU0 because a cache is not activated. */
+	z = &per_cpu(cpu_vmap_zone, 0);
+	fbl_lock(z, BUSY);
+
+	va = find_vmap_area_exceed_addr((unsigned long)addr, &fbl_root(z, BUSY));
 	if (!va)
 		goto finished;
 
@@ -3626,7 +3640,7 @@ long vread(char *buf, char *addr, unsigned long count)
 	if ((unsigned long)addr + count <= va->va_start)
 		goto finished;
 
-	list_for_each_entry_from(va, &vmap_area_list, list) {
+	list_for_each_entry_from(va, &fbl_head(z, BUSY), list) {
 		if (!count)
 			break;
 
@@ -3674,7 +3688,7 @@ long vread(char *buf, char *addr, unsigned long count)
 		count -= n;
 	}
 finished:
-	spin_unlock(&vmap_area_lock);
+	fbl_unlock(z, BUSY);
 
 	if (buf == buf_start)
 		return 0;
@@ -4014,14 +4028,15 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 	}
 
 	/* insert all vm's */
-	spin_lock(&vmap_area_lock);
 	for (area = 0; area < nr_vms; area++) {
-		insert_vmap_area(vas[area], &vmap_area_root, &vmap_area_list);
+		struct cpu_vmap_zone *z = addr_to_cvz(vas[area]->va_start);
 
+		fbl_lock(z, BUSY);
+		insert_vmap_area(vas[area], &fbl_root(z, BUSY), &fbl_head(z, BUSY));
 		setup_vmalloc_vm_locked(vms[area], vas[area], VM_ALLOC,
 				 pcpu_get_vm_areas);
+		fbl_unlock(z, BUSY);
 	}
-	spin_unlock(&vmap_area_lock);
 
 	/*
 	 * Mark allocated areas as accessible. Do it now as a best-effort
@@ -4145,24 +4160,24 @@ bool vmalloc_dump_obj(void *object)
 #ifdef CONFIG_PROC_FS
 static void *s_start(struct seq_file *m, loff_t *pos)
 	__acquires(&vmap_purge_lock)
-	__acquires(&vmap_area_lock)
+	__acquires(&fbl(&per_cpu(cpu_vmap_zone, 0), BUSY, lock))
 {
 	mutex_lock(&vmap_purge_lock);
-	spin_lock(&vmap_area_lock);
+	fbl_lock((&per_cpu(cpu_vmap_zone, 0)), BUSY);
 
-	return seq_list_start(&vmap_area_list, *pos);
+	return seq_list_start(&fbl_head((&per_cpu(cpu_vmap_zone, 0)), BUSY), *pos);
 }
 
 static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 {
-	return seq_list_next(p, &vmap_area_list, pos);
+	return seq_list_next(p, &fbl_head((&per_cpu(cpu_vmap_zone, 0)), BUSY), pos);
 }
 
 static void s_stop(struct seq_file *m, void *p)
-	__releases(&vmap_area_lock)
+	__releases(&fbl(&per_cpu(cpu_vmap_zone, 0), BUSY, lock))
 	__releases(&vmap_purge_lock)
 {
-	spin_unlock(&vmap_area_lock);
+	fbl_unlock((&per_cpu(cpu_vmap_zone, 0)), BUSY);
 	mutex_unlock(&vmap_purge_lock);
 }
 
@@ -4258,7 +4273,7 @@ static int s_show(struct seq_file *m, void *p)
 	 * As a final step, dump "unpurged" areas.
 	 */
 final:
-	if (list_is_last(&va->list, &vmap_area_list))
+	if (list_is_last(&va->list, &fbl_head((&per_cpu(cpu_vmap_zone, 0)), BUSY)))
 		show_purge_info(m);
 
 	return 0;
@@ -4289,7 +4304,8 @@ static void vmap_init_free_space(void)
 {
 	unsigned long vmap_start = 1;
 	const unsigned long vmap_end = ULONG_MAX;
-	struct vmap_area *busy, *free;
+	struct vmap_area *free;
+	struct vm_struct *busy;
 
 	/*
 	 *     B     F     B     B     B     F
@@ -4297,12 +4313,12 @@ static void vmap_init_free_space(void)
 	 *  |           The KVA space           |
 	 *  |<--------------------------------->|
 	 */
-	list_for_each_entry(busy, &vmap_area_list, list) {
-		if (busy->va_start - vmap_start > 0) {
+	for (busy = vmlist; busy; busy = busy->next) {
+		if (busy->addr - vmap_start > 0) {
 			free = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
 			if (!WARN_ON_ONCE(!free)) {
 				free->va_start = vmap_start;
-				free->va_end = busy->va_start;
+				free->va_end = (unsigned long) busy->addr;
 
 				insert_vmap_area_augment(free, NULL,
 					&free_vmap_area_root,
@@ -4310,7 +4326,7 @@ static void vmap_init_free_space(void)
 			}
 		}
 
-		vmap_start = busy->va_end;
+		vmap_start = (unsigned long) busy->addr + busy->size;
 	}
 
 	if (vmap_end - vmap_start > 0) {
@@ -4326,6 +4342,22 @@ static void vmap_init_free_space(void)
 	}
 }
 
+static void vmap_init_pcpu_zones(void)
+{
+	struct cpu_vmap_zone *z;
+	int i, j;
+
+	for_each_possible_cpu(i) {
+		z = per_cpu_ptr(&cpu_vmap_zone, i);
+
+		for (j = 0; j < ARRAY_SIZE(z->fbl); j++) {
+			INIT_LIST_HEAD(&z->fbl[j].head);
+			z->fbl[j].root = RB_ROOT;
+			spin_lock_init(&z->fbl[j].lock);
+		}
+	}
+}
+
 void __init vmalloc_init(void)
 {
 	struct vmap_area *va;
@@ -4349,8 +4381,15 @@ void __init vmalloc_init(void)
 		INIT_WORK(&p->wq, delayed_vfree_work);
 	}
 
+	/*
+	 * Setup per-cpu data before importing vmlist.
+	 */
+	vmap_init_pcpu_zones();
+
 	/* Import existing vmlist entries. */
 	for (tmp = vmlist; tmp; tmp = tmp->next) {
+		struct cpu_vmap_zone *z;
+
 		va = kmem_cache_zalloc(vmap_area_cachep, GFP_NOWAIT);
 		if (WARN_ON_ONCE(!va))
 			continue;
@@ -4358,7 +4397,9 @@ void __init vmalloc_init(void)
 		va->va_start = (unsigned long)tmp->addr;
 		va->va_end = va->va_start + tmp->size;
 		va->vm = tmp;
-		insert_vmap_area(va, &vmap_area_root, &vmap_area_list);
+
+		z = addr_to_cvz(va->va_start);
+		insert_vmap_area(va, &fbl_root(z, BUSY), &fbl_head(z, BUSY));
 	}
 
 	/*
-- 
2.30.2

