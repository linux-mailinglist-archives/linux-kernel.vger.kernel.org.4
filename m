Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0155270BB5E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 13:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjEVLPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 07:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjEVLOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 07:14:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C6640F4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:59 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96f99222e80so434939666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 04:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684753738; x=1687345738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdmHm9JMTKbIdAZzyhemwDZBEVKcMOyv00QDGf853lw=;
        b=W+JtWfgKVMFA959Uc5C8wiOgCsYc9+SYai8nupDO9KlapBo9VlFnbVWgJAQ004f/QK
         mZQgkKrt4awtWG7HH1AMVsq0BI7HDBAsUxUanMdXJuT1NjGXA8j91P6MNQVZ7/2q/uOl
         u8b46ysLxNwbLImafPVAYrKfHx5ge512UBdEXib49XuWenSq7+MfDhUI4cQN2Y29QWPG
         8ukh8J/sV1fqVvb+o7S1LN2QlrXlkMocODGZyaNkalUBH3toAXu0mQeN6PrvNuypiv2Q
         zaaZIwTdJUy/uadYITY2t/C6AJEJ4AgkDslYAlw0hmiXnARf/cNIGN7mPPlYm11bAx6x
         3eRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684753738; x=1687345738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdmHm9JMTKbIdAZzyhemwDZBEVKcMOyv00QDGf853lw=;
        b=Lx6m+HdMS/Hwxc8nsiCZCqf+5OrtGd0GNPZp7yP3vX4SWQLx+Of9EE6kX9eAqNBPXS
         ddjXsV3jw40kkkRzWUCSP5nti6tn7MQRSZGOyLPHkk0UySnpPc95qSRzS4QL5tBr97bg
         llzIQ0YKwGKvpacQOLG8yiCvSRDkDavvl1aJ/n6Tg2VI7dYdHQNCBqrJFCAgB3Y2E0Ev
         t1ubtbXFgWMAfcUK69lBRAJXMIF3n02lBhbRrqRSswOar6wVGJdI/ojm85W9rPWDb74z
         Hi9uPOMlVBSWhLrg/yagusFcy9kgo2sr31MrghxeQyE7pvVQqs7P1zeAL4j8/PoW3U7n
         7iLg==
X-Gm-Message-State: AC+VfDxLxaHdCpzTR14qWJwIxrBc8oQ10n/H8TvjbeHWnM6mytlbJWT3
        u+BKDdhk9vYWkl5jA+/OIBU=
X-Google-Smtp-Source: ACHHUZ4lpJZI6b774mW0GGFUcH9S7bFeeu1TaXyRQOPcceEGL/AxG3iytu1ZZc95ZLsmsCWn+xcxSw==
X-Received: by 2002:a17:907:3eaa:b0:96f:8d00:43be with SMTP id hs42-20020a1709073eaa00b0096f8d0043bemr6754703ejc.0.1684753737692;
        Mon, 22 May 2023 04:08:57 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id lx19-20020a170906af1300b0094f07545d40sm2949453ejb.220.2023.05.22.04.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 04:08:57 -0700 (PDT)
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
Subject: [PATCH 7/9] mm: vmalloc: Insert lazy-VA per-cpu zone
Date:   Mon, 22 May 2023 13:08:47 +0200
Message-Id: <20230522110849.2921-8-urezki@gmail.com>
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

Similar to busy VAs, lazy ones are stored per a CPU zone
also. Freed address is converted into a correct zone it
belongs to and resides there for further handling.

Such approach does not require to have any global locking
primitive, instead an access becomes scalable to number of
CPUs.

This patch removes a global purge-lock, global purge-tree
and list.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 127 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 71 insertions(+), 56 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index dd83deb5ef4f..fe993c0561dd 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -734,10 +734,6 @@ static DEFINE_SPINLOCK(free_vmap_area_lock);
 LIST_HEAD(vmap_area_list);
 static bool vmap_initialized __read_mostly;
 
-static struct rb_root purge_vmap_area_root = RB_ROOT;
-static LIST_HEAD(purge_vmap_area_list);
-static DEFINE_SPINLOCK(purge_vmap_area_lock);
-
 /*
  * This kmem_cache is used for vmap_area objects. Instead of
  * allocating from slab we reuse an object from this cache to
@@ -1792,39 +1788,17 @@ static DEFINE_MUTEX(vmap_purge_lock);
 /* for per-CPU blocks */
 static void purge_fragmented_blocks_allcpus(void);
 
-/*
- * Purges all lazily-freed vmap areas.
- */
-static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
+static unsigned long
+purge_cpu_vmap_zone(struct cpu_vmap_zone *z)
 {
-	unsigned long resched_threshold;
-	unsigned int num_purged_areas = 0;
-	struct list_head local_purge_list;
+	unsigned long num_purged_areas = 0;
 	struct vmap_area *va, *n_va;
 
-	lockdep_assert_held(&vmap_purge_lock);
-
-	spin_lock(&purge_vmap_area_lock);
-	purge_vmap_area_root = RB_ROOT;
-	list_replace_init(&purge_vmap_area_list, &local_purge_list);
-	spin_unlock(&purge_vmap_area_lock);
-
-	if (unlikely(list_empty(&local_purge_list)))
+	if (list_empty(&z->purge_list))
 		goto out;
 
-	start = min(start,
-		list_first_entry(&local_purge_list,
-			struct vmap_area, list)->va_start);
-
-	end = max(end,
-		list_last_entry(&local_purge_list,
-			struct vmap_area, list)->va_end);
-
-	flush_tlb_kernel_range(start, end);
-	resched_threshold = lazy_max_pages() << 1;
-
 	spin_lock(&free_vmap_area_lock);
-	list_for_each_entry_safe(va, n_va, &local_purge_list, list) {
+	list_for_each_entry_safe(va, n_va, &z->purge_list, list) {
 		unsigned long nr = (va->va_end - va->va_start) >> PAGE_SHIFT;
 		unsigned long orig_start = va->va_start;
 		unsigned long orig_end = va->va_end;
@@ -1846,13 +1820,57 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
 
 		atomic_long_sub(nr, &vmap_lazy_nr);
 		num_purged_areas++;
-
-		if (atomic_long_read(&vmap_lazy_nr) < resched_threshold)
-			cond_resched_lock(&free_vmap_area_lock);
 	}
 	spin_unlock(&free_vmap_area_lock);
 
 out:
+	return num_purged_areas;
+}
+
+/*
+ * Purges all lazily-freed vmap areas.
+ */
+static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
+{
+	unsigned long num_purged_areas = 0;
+	struct cpu_vmap_zone *z;
+	int need_purge = 0;
+	int i;
+
+	lockdep_assert_held(&vmap_purge_lock);
+
+	for_each_possible_cpu(i) {
+		z = per_cpu_ptr(&cpu_vmap_zone, i);
+		INIT_LIST_HEAD(&z->purge_list);
+
+		if (RB_EMPTY_ROOT(&fbl_root(z, LAZY)))
+			continue;
+
+		fbl_lock(z, LAZY);
+		WRITE_ONCE(fbl(z, LAZY, root.rb_node), NULL);
+		list_replace_init(&fbl_head(z, LAZY), &z->purge_list);
+		fbl_unlock(z, LAZY);
+
+		start = min(start,
+			list_first_entry(&z->purge_list,
+				struct vmap_area, list)->va_start);
+
+		end = max(end,
+			list_last_entry(&z->purge_list,
+				struct vmap_area, list)->va_end);
+
+		need_purge++;
+	}
+
+	if (need_purge) {
+		flush_tlb_kernel_range(start, end);
+
+		for_each_possible_cpu(i) {
+			z = per_cpu_ptr(&cpu_vmap_zone, i);
+			num_purged_areas += purge_cpu_vmap_zone(z);
+		}
+	}
+
 	trace_purge_vmap_area_lazy(start, end, num_purged_areas);
 	return num_purged_areas > 0;
 }
@@ -1870,16 +1888,9 @@ static void purge_vmap_area_lazy(void)
 
 static void drain_vmap_area_work(struct work_struct *work)
 {
-	unsigned long nr_lazy;
-
-	do {
-		mutex_lock(&vmap_purge_lock);
-		__purge_vmap_area_lazy(ULONG_MAX, 0);
-		mutex_unlock(&vmap_purge_lock);
-
-		/* Recheck if further work is required. */
-		nr_lazy = atomic_long_read(&vmap_lazy_nr);
-	} while (nr_lazy > lazy_max_pages());
+	mutex_lock(&vmap_purge_lock);
+	__purge_vmap_area_lazy(ULONG_MAX, 0);
+	mutex_unlock(&vmap_purge_lock);
 }
 
 /*
@@ -1889,6 +1900,7 @@ static void drain_vmap_area_work(struct work_struct *work)
  */
 static void free_vmap_area_noflush(struct vmap_area *va)
 {
+	struct cpu_vmap_zone *z = addr_to_cvz(va->va_start);
 	unsigned long nr_lazy_max = lazy_max_pages();
 	unsigned long va_start = va->va_start;
 	unsigned long nr_lazy;
@@ -1902,10 +1914,9 @@ static void free_vmap_area_noflush(struct vmap_area *va)
 	/*
 	 * Merge or place it to the purge tree/list.
 	 */
-	spin_lock(&purge_vmap_area_lock);
-	merge_or_add_vmap_area(va,
-		&purge_vmap_area_root, &purge_vmap_area_list);
-	spin_unlock(&purge_vmap_area_lock);
+	fbl_lock(z, LAZY);
+	merge_or_add_vmap_area(va, &fbl_root(z, LAZY), &fbl_head(z, LAZY));
+	fbl_unlock(z, LAZY);
 
 	trace_free_vmap_area_noflush(va_start, nr_lazy, nr_lazy_max);
 
@@ -4199,17 +4210,21 @@ static void show_numa_info(struct seq_file *m, struct vm_struct *v)
 
 static void show_purge_info(struct seq_file *m)
 {
+	struct cpu_vmap_zone *z;
 	struct vmap_area *va;
+	int i;
 
-	mutex_lock(&vmap_purge_lock);
-	spin_lock(&purge_vmap_area_lock);
-	list_for_each_entry(va, &purge_vmap_area_list, list) {
-		seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
-			(void *)va->va_start, (void *)va->va_end,
-			va->va_end - va->va_start);
+	for_each_possible_cpu(i) {
+		z = per_cpu_ptr(&cpu_vmap_zone, i);
+
+		fbl_lock(z, LAZY);
+		list_for_each_entry(va, &fbl_head(z, LAZY), list) {
+			seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\n",
+				(void *)va->va_start, (void *)va->va_end,
+				va->va_end - va->va_start);
+		}
+		fbl_unlock(z, LAZY);
 	}
-	spin_unlock(&purge_vmap_area_lock);
-	mutex_unlock(&vmap_purge_lock);
 }
 
 static int s_show(struct seq_file *m, void *p)
-- 
2.30.2

