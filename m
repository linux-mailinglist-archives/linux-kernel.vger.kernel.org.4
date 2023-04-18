Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC2B6E5963
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjDRGZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjDRGZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:25:19 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065FEB9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:25:16 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 543335FD57;
        Tue, 18 Apr 2023 09:25:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681799114;
        bh=7MTjAhk17Jfa37m9fE/raeY17+lmbDG/IO4oS0JOBFU=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=O0HhLxxiOVZ5ZvDS/LrzBmvgXC15q0/z2vM9JPSNZdJfoDfCs6AKI7FKjPhdT/Fft
         /e26Iya6eyxO4wRvxl1mAp+elaWp/5Vf/8d3cU44jS6ny3aZdN0mL+uEKP0jR7xX8W
         diRaxtrAmm+uIgxpl3wJANblOBCWJkh3rwjmhMsYB1jNCui0wfjlitv0fl0lRT9PHW
         MM76Z7+eSbqPJbPnTBLlkCdQ+u/CWnuCUBrTcOmXTBf+DBdnM3bL3no9Z92IfZyJK8
         H59sPAoEub3g5IL8hpdVw/fQ4J2vWGydD6Engei+ubzUgXXJe9Sus1LwX/9dDrfzya
         4I4Rufw+v85YQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 18 Apr 2023 09:25:14 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [RFC PATCH v1 3/5] mm/zsmalloc: introduce objects folding mechanism
Date:   Tue, 18 Apr 2023 09:25:01 +0300
Message-ID: <20230418062503.62121-4-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230418062503.62121-1-avromanov@sberdevices.ru>
References: <20230418062503.62121-1-avromanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/18 02:02:00 #21122658
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a mechanism to scan every zspage in zs_pool and
frees all identical objects, leaving only one in memory.
All zsmalloc handles which reference this freed objects now refer
to the same, not freed, object.

To implement this mechanism, we sequentially scan every allocated
object, counting the hash from the their contents and save the
object value in the hash table (hlist_head). If the hash matches,
we free the identical objects via obj_free() and update the link
rbtree.

To implement this mechanism a rbtree is needed. The tree node key
is a reference to the object value, and the value is the number
of references to this object. This is necessary for data
consistency so that we do not obj_free() the object referenced by
another handle object.

Also, this mechanism fully compatible with zs_compact() function.

Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
---
 include/linux/zsmalloc.h |   4 +
 mm/Kconfig               |   9 +
 mm/zsmalloc.c            | 470 ++++++++++++++++++++++++++++++++++++++-
 3 files changed, 476 insertions(+), 7 deletions(-)

diff --git a/include/linux/zsmalloc.h b/include/linux/zsmalloc.h
index a48cd0ffe57d..a581283c68b4 100644
--- a/include/linux/zsmalloc.h
+++ b/include/linux/zsmalloc.h
@@ -36,6 +36,8 @@ enum zs_mapmode {
 struct zs_pool_stats {
 	/* How many pages were migrated (freed) */
 	atomic_long_t pages_compacted;
+	/* How many pages were freed during objects folding */
+	atomic_long_t pages_folded;
 };
 
 struct zs_pool;
@@ -58,4 +60,6 @@ unsigned long zs_compact(struct zs_pool *pool);
 unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size);
 
 void zs_pool_stats(struct zs_pool *pool, struct zs_pool_stats *stats);
+
+unsigned long zs_fold(struct zs_pool *pool);
 #endif
diff --git a/mm/Kconfig b/mm/Kconfig
index ff7b209dec05..f01ec9038101 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -191,6 +191,15 @@ config ZSMALLOC_STAT
 	  information to userspace via debugfs.
 	  If unsure, say N.
 
+config ZSMALLOC_FOLD
+	bool "Export zsmalloc objects folding mechanism"
+	depends on ZSMALLOC
+	default n
+	help
+	  This option enables a mechanism for folding identical objects,
+	  which can reduce the amount of zsmalloc used memory.
+	  If unsure, say N.
+
 menu "SLAB allocator options"
 
 choice
diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 0a3b11aa07a9..de6be26cca65 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -62,6 +62,8 @@
 #include <linux/pagemap.h>
 #include <linux/fs.h>
 #include <linux/local_lock.h>
+#include <linux/hashtable.h>
+#include <linux/xxhash.h>
 
 #define ZSPAGE_MAGIC	0x58
 
@@ -178,6 +180,7 @@ enum class_stat_type {
 	CLASS_FULL,
 	OBJ_ALLOCATED,
 	OBJ_USED,
+	OBJ_FOLDED,
 	NR_ZS_STAT_TYPE,
 };
 
@@ -219,6 +222,14 @@ struct size_class {
 
 	unsigned int index;
 	struct zs_size_stat stats;
+#ifdef CONFIG_ZSMALLOC_FOLD
+	/*
+	 * We use this rbtree only in zs_free() and __zs_fold().
+	 * This function always uses spin_lock(&pool->lock), so,
+	 * no additional lock specifically for rbtree is needed.
+	 */
+	struct rb_root fold_rbtree;
+#endif
 };
 
 /*
@@ -253,6 +264,9 @@ struct zs_pool {
 	struct size_class *size_class[ZS_SIZE_CLASSES];
 	struct kmem_cache *handle_cachep;
 	struct kmem_cache *zspage_cachep;
+#ifdef CONFIG_ZSMALLOC_FOLD
+	struct kmem_cache *fold_rbtree_cachep;
+#endif
 
 	atomic_long_t pages_allocated;
 
@@ -307,6 +321,129 @@ struct mapping_area {
 	enum zs_mapmode vm_mm; /* mapping mode */
 };
 
+#ifdef CONFIG_ZSMALLOC_FOLD
+struct obj_hash_node {
+	unsigned long handle;
+	struct hlist_node next;
+};
+
+struct hash_table {
+	struct hlist_head *table;
+	struct kmem_cache *cachep;
+	size_t size;
+};
+
+struct fold_rbtree_node {
+	struct rb_node node;
+	unsigned long key;
+	unsigned int cnt;
+};
+
+static int fold_rbtree_key_cmp(const void *k, const struct rb_node *node)
+{
+	const struct fold_rbtree_node *entry = rb_entry(node, struct fold_rbtree_node, node);
+	unsigned long key = *(unsigned long *)k;
+
+	if (entry->key == key)
+		return 0;
+
+	return key < entry->key ? -1 : 1;
+}
+
+static struct fold_rbtree_node *fold_rbtree_search(struct rb_root *root,
+		unsigned long key)
+{
+	struct rb_node *node =
+		rb_find((void *)&key, root, fold_rbtree_key_cmp);
+
+	if (!node)
+		return NULL;
+
+	return rb_entry(node, struct fold_rbtree_node, node);
+}
+
+static int fold_rbtree_node_cmp(struct rb_node *a_node, const struct rb_node *b_node)
+{
+	const struct fold_rbtree_node *a = rb_entry(a_node, struct fold_rbtree_node, node);
+
+	return fold_rbtree_key_cmp((void *)&a->key, b_node);
+}
+
+static bool fold_rbtree_insert(struct rb_root *root, struct fold_rbtree_node *data)
+{
+	return rb_find_add(&data->node, root, fold_rbtree_node_cmp);
+}
+
+static struct fold_rbtree_node *fold_rbtree_alloc_node(struct zs_pool *pool,
+		unsigned long key, unsigned int cnt)
+{
+	/*
+	 * This function is called under a spinlock,
+	 * so it is necessary to use GFP_ATOMIC flag
+	 */
+	struct fold_rbtree_node *node =
+		kmem_cache_alloc(pool->fold_rbtree_cachep, GFP_ATOMIC);
+
+	if (!node)
+		return NULL;
+
+	node->key = key;
+	node->cnt = cnt;
+
+	return node;
+}
+
+static void fold_rbtree_free_node(struct zs_pool *pool, struct fold_rbtree_node *node)
+{
+	kmem_cache_free(pool->fold_rbtree_cachep, node);
+}
+
+static void free_htable(struct hash_table *htable)
+{
+	size_t i;
+	struct hlist_node *tmp;
+	struct obj_hash_node *node;
+
+	for (i = 0; i < htable->size; i++) {
+		hlist_for_each_entry_safe(node, tmp, &htable->table[i], next) {
+			hlist_del(&node->next);
+			kmem_cache_free(htable->cachep, node);
+		}
+	}
+
+	vfree(htable->table);
+	kmem_cache_destroy(htable->cachep);
+}
+
+static int init_htable(struct hash_table *htable, size_t size)
+{
+	size_t i;
+
+	htable->size = size;
+	htable->table = vmalloc_array(htable->size, sizeof(struct hlist_head));
+	if (!htable->table)
+		return -ENOMEM;
+
+	htable->cachep = kmem_cache_create("fold_htable", sizeof(struct obj_hash_node),
+					0, 0, NULL);
+	if (!htable->cachep) {
+		vfree(htable->table);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < htable->size; i++)
+		INIT_HLIST_HEAD(&htable->table[i]);
+
+	return 0;
+}
+
+static void insert_htable(struct hash_table *htable, struct obj_hash_node *node,
+		unsigned long hash)
+{
+	hlist_add_head(&node->next, &htable->table[hash % htable->size]);
+}
+#endif /* CONFIG_ZSMALLOC_FOLD */
+
 /* huge object: pages_per_zspage == 1 && maxobj_per_zspage == 1 */
 static void SetZsHugePage(struct zspage *zspage)
 {
@@ -353,6 +490,18 @@ static int create_cache(struct zs_pool *pool)
 		return 1;
 	}
 
+#ifdef CONFIG_ZSMALLOC_FOLD
+	pool->fold_rbtree_cachep = kmem_cache_create("fold_rbtree",
+					sizeof(struct fold_rbtree_node), 0, 0, NULL);
+	if (!pool->fold_rbtree_cachep) {
+		kmem_cache_destroy(pool->handle_cachep);
+		kmem_cache_destroy(pool->zspage_cachep);
+		pool->handle_cachep = NULL;
+		pool->zspage_cachep = NULL;
+		return 1;
+	}
+#endif
+
 	return 0;
 }
 
@@ -360,6 +509,9 @@ static void destroy_cache(struct zs_pool *pool)
 {
 	kmem_cache_destroy(pool->handle_cachep);
 	kmem_cache_destroy(pool->zspage_cachep);
+#ifdef CONFIG_ZSMALLOC_FOLD
+	kmem_cache_destroy(pool->fold_rbtree_cachep);
+#endif
 }
 
 static unsigned long cache_alloc_handle(struct zs_pool *pool, gfp_t gfp)
@@ -639,15 +791,15 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 	struct size_class *class;
 	int objs_per_zspage;
 	unsigned long class_almost_full, class_almost_empty;
-	unsigned long obj_allocated, obj_used, pages_used, freeable;
+	unsigned long obj_allocated, obj_used, pages_used, freeable, folded;
 	unsigned long total_class_almost_full = 0, total_class_almost_empty = 0;
 	unsigned long total_objs = 0, total_used_objs = 0, total_pages = 0;
-	unsigned long total_freeable = 0;
+	unsigned long total_freeable = 0, total_folded = 0;
 
 	seq_printf(s, " %5s %5s %11s %12s %13s %10s %10s %16s %8s\n",
 			"class", "size", "almost_full", "almost_empty",
 			"obj_allocated", "obj_used", "pages_used",
-			"pages_per_zspage", "freeable");
+			"pages_per_zspage", "freeable", "folded");
 
 	for (i = 0; i < ZS_SIZE_CLASSES; i++) {
 		class = pool->size_class[i];
@@ -660,6 +812,7 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 		class_almost_empty = zs_stat_get(class, CLASS_ALMOST_EMPTY);
 		obj_allocated = zs_stat_get(class, OBJ_ALLOCATED);
 		obj_used = zs_stat_get(class, OBJ_USED);
+		folded = zs_stat_get(class, OBJ_FOLDED);
 		freeable = zs_can_compact(class);
 		spin_unlock(&pool->lock);
 
@@ -668,10 +821,10 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 				class->pages_per_zspage;
 
 		seq_printf(s, " %5u %5u %11lu %12lu %13lu"
-				" %10lu %10lu %16d %8lu\n",
+				" %10lu %10lu %16d %8lu %8lu\n",
 			i, class->size, class_almost_full, class_almost_empty,
 			obj_allocated, obj_used, pages_used,
-			class->pages_per_zspage, freeable);
+			class->pages_per_zspage, freeable, folded);
 
 		total_class_almost_full += class_almost_full;
 		total_class_almost_empty += class_almost_empty;
@@ -679,13 +832,14 @@ static int zs_stats_size_show(struct seq_file *s, void *v)
 		total_used_objs += obj_used;
 		total_pages += pages_used;
 		total_freeable += freeable;
+		total_folded += folded
 	}
 
 	seq_puts(s, "\n");
-	seq_printf(s, " %5s %5s %11lu %12lu %13lu %10lu %10lu %16s %8lu\n",
+	seq_printf(s, " %5s %5s %11lu %12lu %13lu %10lu %10lu %16s %8lu %8lu\n",
 			"Total", "", total_class_almost_full,
 			total_class_almost_empty, total_objs,
-			total_used_objs, total_pages, "", total_freeable);
+			total_used_objs, total_pages, "", total_freeable, total_folded);
 
 	return 0;
 }
@@ -1663,6 +1817,9 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	unsigned long obj;
 	struct size_class *class;
 	enum fullness_group fullness;
+#ifdef CONFIG_ZSMALLOC_FOLD
+	struct fold_rbtree_node *node;
+#endif
 
 	if (IS_ERR_OR_NULL((void *)handle))
 		return;
@@ -1677,6 +1834,22 @@ void zs_free(struct zs_pool *pool, unsigned long handle)
 	zspage = get_zspage(f_page);
 	class = zspage_class(pool, zspage);
 
+#ifdef CONFIG_ZSMALLOC_FOLD
+	node = fold_rbtree_search(&class->fold_rbtree, obj);
+	if (node) {
+		node->cnt--;
+
+		if (node->cnt) {
+			cache_free_handle(pool, handle);
+			spin_unlock(&pool->lock);
+			return;
+		}
+
+		rb_erase(&node->node, &class->fold_rbtree);
+		fold_rbtree_free_node(pool, node);
+	}
+#endif
+
 	class_stat_dec(class, OBJ_USED, 1);
 
 #ifdef CONFIG_ZPOOL
@@ -2345,6 +2518,286 @@ unsigned long zs_compact(struct zs_pool *pool)
 }
 EXPORT_SYMBOL_GPL(zs_compact);
 
+#ifdef CONFIG_ZSMALLOC_FOLD
+struct zs_fold_control {
+	struct zspage *src_zspage;
+	unsigned long handle;
+	char *current_buf;
+	char *folded_buf;
+};
+
+static unsigned long obj_get_hash(void *src, size_t len)
+{
+	return xxhash(src, len, 0);
+}
+
+static void read_object(void *buf, struct zs_pool *pool, unsigned long handle)
+{
+	struct zspage *zspage;
+	struct page *page;
+	unsigned long obj, off;
+	unsigned int obj_idx;
+	struct size_class *class;
+	struct mapping_area *area;
+	struct page *pages[2];
+	void *ret;
+
+	obj = handle_to_obj(handle);
+	obj_to_location(obj, &page, &obj_idx);
+	zspage = get_zspage(page);
+
+	class = zspage_class(pool, zspage);
+	off = offset_in_page(class->size * obj_idx);
+
+	local_lock(&zs_map_area.lock);
+	area = this_cpu_ptr(&zs_map_area);
+	area->vm_mm = ZS_MM_RO;
+	if (off + class->size <= PAGE_SIZE) {
+		area->vm_addr = kmap_local_page(page);
+		ret = area->vm_addr + off;
+		if (likely(!ZsHugePage(zspage)))
+			ret += ZS_HANDLE_SIZE;
+
+		memcpy(buf, ret, class->size);
+		kunmap_local(area->vm_addr);
+		goto out;
+	}
+
+	pages[0] = page;
+	pages[1] = get_next_page(page);
+
+	ret = __zs_map_object(area, pages, off, class->size);
+	if (likely(!ZsHugePage(zspage)))
+		ret += ZS_HANDLE_SIZE;
+
+	memcpy(buf, ret, class->size);
+
+	__zs_unmap_object(area, pages, off, class->size);
+out:
+	local_unlock(&zs_map_area.lock);
+}
+
+static void fold_object(struct size_class *class, unsigned long obj)
+{
+	class_stat_dec(class, OBJ_USED, 1);
+	class_stat_inc(class, OBJ_FOLDED, 1);
+	obj_free(class->size, obj, NULL);
+}
+
+static int zs_cmp_obj_and_fold(struct zs_pool *pool, struct size_class *class,
+		struct hash_table *htable, const struct zs_fold_control *fc)
+{
+	struct fold_rbtree_node *current_rbnode, *fold_rbnode;
+	struct obj_hash_node *hash_node;
+	struct zspage *current_zspage;
+	struct page *page;
+	unsigned long hash;
+
+	read_object(fc->folded_buf, pool, fc->handle);
+	hash = obj_get_hash(fc->folded_buf, class->size);
+
+	hlist_for_each_entry(hash_node, &htable->table[hash % htable->size], next) {
+		unsigned long current_obj, folded_obj;
+		int cmp;
+
+		current_obj = handle_to_obj(hash_node->handle);
+		obj_to_page(current_obj, &page);
+		current_zspage = get_zspage(page);
+
+		/*
+		 * Because we can fold objects on the same zspage,
+		 * current_zspage and fc->src_zspage can be equal and
+		 * fc->src_zspage is already locked.
+		 */
+		if (current_zspage != fc->src_zspage)
+			migrate_write_lock(current_zspage);
+
+		read_object(fc->current_buf, pool, hash_node->handle);
+		cmp = memcmp(fc->folded_buf, fc->current_buf, class->size);
+
+		if (!cmp) {
+			/* Skip the already folded objects */
+			folded_obj = handle_to_obj(fc->handle);
+			if (current_obj == folded_obj)
+				return 0;
+
+			current_rbnode = fold_rbtree_search(&class->fold_rbtree, current_obj);
+			if (!current_rbnode) {
+				/* Two handles refer to an object */
+				current_rbnode = fold_rbtree_alloc_node(pool, current_obj, 2);
+				if (!current_rbnode) {
+					if (current_zspage != fc->src_zspage)
+						migrate_write_unlock(current_zspage);
+
+					return -ENOMEM;
+				}
+
+				fold_rbtree_insert(&class->fold_rbtree, current_rbnode);
+			} else {
+				current_rbnode->cnt++;
+			}
+
+			record_obj(fc->handle, current_obj);
+
+			/*
+			 * This check is necessary in order to avoid freeing an object
+			 * that someone already refers to. This situation can occur when
+			 * there are repeated calls to zs_fold(). For example:
+			 *
+			 * [handle0] [handle1] [handle2] [handle3] [handle4]
+			 *   [obj0]    [obj1]    [obj2]    [obj3]    [obj4]
+			 *
+			 * Let's imagine that obj2 and obj3 are equal, and we call zs_fold():
+			 *
+			 * [handle0] [handle1] [handle2] [handle3] [handle4]
+			 *   [obj0]    [obj1]    [obj2]    [obj2]    [obj4]
+			 *
+			 * Now, handle2 and handle3 refer to the obj2 object. Time passes,
+			 * and now handle0 refers to obj0_n, which is equal to obj2:
+			 *
+			 * [handle0]  [handle1] [handle2] [handle3] [handle4]
+			 *  [obj0_n]    [obj1]    [obj2]    [obj2]    [obj4]
+			 *
+			 * If we call the zs_fold() function again, we come to handle2,
+			 * and we understand that the obj2 and obj0_n hashes are the same.
+			 * We can't just free obj2 because handle3 also refers to it already!
+			 */
+			fold_rbnode = fold_rbtree_search(&class->fold_rbtree, folded_obj);
+			if (fold_rbnode) {
+				fold_rbnode->cnt--;
+
+				if (!fold_rbnode->cnt) {
+					rb_erase(&fold_rbnode->node, &class->fold_rbtree);
+					fold_object(class, folded_obj);
+					fold_rbtree_free_node(pool, fold_rbnode);
+				}
+			} else {
+				fold_object(class, folded_obj);
+			}
+
+			if (current_zspage != fc->src_zspage)
+				migrate_write_unlock(current_zspage);
+
+			return 0;
+		} else if (current_zspage != fc->src_zspage) {
+			migrate_write_unlock(current_zspage);
+		}
+	}
+
+	/* We use GFP_ATOMIC because we under spin-lock */
+	hash_node = kmem_cache_alloc(htable->cachep, GFP_ATOMIC);
+	if (!hash_node)
+		return -ENOMEM;
+
+	hash_node->handle = fc->handle;
+	insert_htable(htable, hash_node, hash);
+	return 0;
+}
+
+static unsigned long __zs_fold(struct zs_pool *pool, struct size_class *class)
+{
+	struct zspage *src_zspage, *tmp;
+	struct zs_fold_control fc;
+	struct hash_table htable;
+	struct page *s_page;
+	unsigned long pages_freed = 0, handle;
+	enum fullness_group fg, newfg;
+	size_t htable_size;
+	int obj_idx;
+
+	htable_size = zs_stat_get(class, OBJ_USED);
+	if (!htable_size)
+		return 0;
+
+	init_htable(&htable, htable_size);
+
+	/*
+	 * We can't allocate these buffers inside zs_cmp_obj_and_fold()
+	 * because the function is under spinlock. In this case, we have
+	 * to use kmalloc with GFP_ATOMIC, but allocations happen very often.
+	 * Therefore, it is better to allocate these two buffers here.
+	 */
+	fc.current_buf = kmalloc(class->size, GFP_KERNEL);
+	if (!fc.current_buf)
+		return 0;
+
+	fc.folded_buf = kmalloc(class->size, GFP_KERNEL);
+	if (!fc.folded_buf) {
+		kfree(fc.current_buf);
+		return 0;
+	}
+
+	spin_lock(&pool->lock);
+
+	for (fg = ZS_ALMOST_EMPTY; fg <= ZS_FULL; fg++) {
+		list_for_each_entry_safe(src_zspage, tmp, &class->fullness_list[fg], list) {
+			remove_zspage(class, src_zspage, fg);
+			migrate_write_lock(src_zspage);
+
+			fc.src_zspage = src_zspage;
+			s_page = get_first_page(src_zspage);
+			obj_idx = 0;
+
+			/* Iterate over all the objects on the zspage */
+			while (1) {
+				handle = find_alloced_obj(class, s_page, &obj_idx);
+				if (!handle) {
+					s_page = get_next_page(s_page);
+					if (!s_page)
+						break;
+
+					obj_idx = 0;
+					continue;
+				}
+
+				fc.handle = handle;
+				/*
+				 * Nothing bad will happen if we ignore the return code from
+				 * zs_cmp_obj_and_fold(). Errors only occur in case of allocator
+				 * failure. Furthermore, even if an error occurs, this function
+				 * doesn't corrupt any data structures in any way.
+				 */
+				zs_cmp_obj_and_fold(pool, class, &htable, &fc);
+				obj_idx++;
+			}
+
+			newfg = putback_zspage(class, src_zspage);
+			migrate_write_unlock(src_zspage);
+			if (newfg == ZS_EMPTY) {
+				free_zspage(pool, class, src_zspage);
+				pages_freed += class->pages_per_zspage;
+			}
+		}
+	}
+
+	spin_unlock(&pool->lock);
+	free_htable(&htable);
+	kfree(fc.current_buf);
+	kfree(fc.folded_buf);
+
+	return pages_freed;
+}
+
+unsigned long zs_fold(struct zs_pool *pool)
+{
+	int i;
+	struct size_class *class;
+	unsigned long pages_freed = 0;
+
+	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
+		class = pool->size_class[i];
+		if (class->index != i)
+			continue;
+
+		pages_freed += __zs_fold(pool, class);
+	}
+	atomic_long_add(pages_freed, &pool->stats.pages_folded);
+
+	return pages_freed;
+}
+EXPORT_SYMBOL_GPL(zs_fold);
+#endif /* CONFIG_ZSMALLOC_FOLD */
+
 void zs_pool_stats(struct zs_pool *pool, struct zs_pool_stats *stats)
 {
 	memcpy(stats, &pool->stats, sizeof(struct zs_pool_stats));
@@ -2496,6 +2949,9 @@ struct zs_pool *zs_create_pool(const char *name)
 		class->index = i;
 		class->pages_per_zspage = pages_per_zspage;
 		class->objs_per_zspage = objs_per_zspage;
+#ifdef CONFIG_ZSMALLOC_FOLD
+		class->fold_rbtree = RB_ROOT;
+#endif
 		pool->size_class[i] = class;
 		for (fullness = ZS_EMPTY; fullness < NR_ZS_FULLNESS;
 							fullness++)
-- 
2.38.1

