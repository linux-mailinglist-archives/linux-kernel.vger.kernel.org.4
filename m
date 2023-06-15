Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8BF730DB0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 05:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbjFODuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 23:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbjFODti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 23:49:38 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00867211C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 20:49:12 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-662f0feafb2so265043b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 20:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686800952; x=1689392952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ru9RQc/YctUd3oofmNo9B/wQzL/S7hlbQkvymAiMmdk=;
        b=RFOEvPUJE1xXVdLOmJQw4AYx9wGU3W9LSe9MDMMyjAwqI9uTfSl9XBmBC6yV1Yi4Kh
         H5ihk+wgHHlCnOOdlsK+YQIKHKcsa0sxfObaLcDMztLxyRgjxloUdUKjfcaCc5G09DE4
         T1ZtX0M7w/f+A68B0vXL/ZEVD92E9KMiC/kc5Ymc3uTz6/eN3y0FCb3l4BVRWFuozSP1
         zpZda+7WfBf2P6fjRmGIp0NBM73LgZXiCoJsxszp3yFdP3mEa7LVogULdTubmA4Z8Va2
         dcEwfzIurYedtwnU1JpEKfxiGNiABEwM5APuMvNbbDATP0bRmEYfjh+gAcGsup4LFKbK
         uUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686800952; x=1689392952;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ru9RQc/YctUd3oofmNo9B/wQzL/S7hlbQkvymAiMmdk=;
        b=fVPWcJOatRvOAgI11NHMreL28SuxaC/f8P5wCEDdk68Qai6hYZMFdukAiSfsttfvF0
         Y9sr2mOiiZfDRs1hcP1C6mP2ftAcOuZO3WZ1K6icsvgJV8egyISsXgih+b+NBctzLuHb
         ce7VqpMDXyKJ8sybunDM7vtr7WNK7XfuEJhdLma9LA9aqg6yCUxjRiLW1g/B9cY+N7ef
         ZMxa4EyAneAwTpHw3MsqRgqQ3390xzeADllvDuvyD3GohZxXibu5M/aXlV2MeV01qkv7
         rBVWDu5mPs3o8EHfKVRTudZ5tnXnLYxrzH4zknNWtYNsA1JjJfBoXsvUcC7KCXG1zyBA
         +vow==
X-Gm-Message-State: AC+VfDzcx/yq1kal2ZRa7WODHeUGBZWuDuJ6Ea1ihfuyOAFRfaQr4A21
        /2Qvwj2oGHx2fouDh19PRzJrAA==
X-Google-Smtp-Source: ACHHUZ4uuJz+fwISKlsP9Eu7UCx/w4kIpOrZngm6hKKNWnuEab1aS4tbt3/zosNjXGxk7SIc4kGFVg==
X-Received: by 2002:a05:6a00:2e17:b0:650:1a64:d8d3 with SMTP id fc23-20020a056a002e1700b006501a64d8d3mr4983241pfb.14.1686800952295;
        Wed, 14 Jun 2023 20:49:12 -0700 (PDT)
Received: from Tower.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id u6-20020a62ed06000000b00661694f1469sm6090369pfh.74.2023.06.14.20.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 20:49:11 -0700 (PDT)
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
To:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [RFC PATCH 3/3] zsmalloc: charge the zspage's object to obj_cgroup
Date:   Thu, 15 Jun 2023 11:49:05 +0800
Message-Id: <20230615034905.1362034-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zspage's object is not charge to any memory cgroup.The
memory of a task will have no limit if the zram swap device
is large enough even though the task is limited by memory
cgroup.

So, it should be necessary to charge the zspage's object to
obj_cgroup,just like slub.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 mm/zsmalloc.c | 196 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 191 insertions(+), 5 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index 02f7f414aade..a5d1c484dd8f 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -62,6 +62,7 @@
 #include <linux/pagemap.h>
 #include <linux/fs.h>
 #include <linux/local_lock.h>
+#include <linux/memcontrol.h>
 
 #define ZSPAGE_MAGIC	0x58
 
@@ -311,6 +312,7 @@ static bool ZsHugePage(struct zspage *zspage)
 static void migrate_lock_init(struct zspage *zspage);
 static void migrate_read_lock(struct zspage *zspage);
 static void migrate_read_unlock(struct zspage *zspage);
+static void zs_free_page_obj_cgroups(struct zspage *zspage);
 
 #ifdef CONFIG_COMPACTION
 static void migrate_write_lock(struct zspage *zspage);
@@ -973,6 +975,7 @@ static void __free_zspage(struct zs_pool *pool, struct size_class *class,
 	free_handles(pool, class, zspage);
 
 	next = page = get_first_page(zspage);
+	zs_free_page_obj_cgroups(zspage);
 	do {
 		VM_BUG_ON_PAGE(!PageLocked(page), page);
 		next = get_next_page(page);
@@ -1420,6 +1423,170 @@ size_t zs_huge_class_size(struct zs_pool *pool)
 }
 EXPORT_SYMBOL_GPL(zs_huge_class_size);
 
+
+#ifdef CONFIG_MEMCG_KMEM
+
+static inline struct obj_cgroup **page_objcgs_check(struct page *page)
+{
+	unsigned long memcg_data = READ_ONCE(page->memcg_data);
+
+	if (!memcg_data || !(memcg_data & MEMCG_DATA_OBJCGS))
+		return NULL;
+
+	VM_BUG_ON_PAGE(memcg_data & MEMCG_DATA_KMEM, page);
+
+	return (struct obj_cgroup **)(memcg_data & ~MEMCG_DATA_FLAGS_MASK);
+}
+
+
+static void zs_free_page_obj_cgroups(struct zspage *zspage)
+{
+	struct obj_cgroup **objcgs;
+	struct page *page = zspage->first_page;
+
+	objcgs = page_objcgs_check(page);
+	if (!objcgs)
+		return;
+
+	kfree(objcgs);
+	page->memcg_data = 0;
+}
+
+static inline size_t zs_obj_full_size(struct size_class *class)
+{
+	return class->size + sizeof(struct obj_cgroup *);
+}
+
+static inline void zs_objcg_exchange(struct page *s_page, unsigned int s_index,
+				struct page *d_page, unsigned int d_index)
+{
+	struct page *sf_page, *df_page;
+	struct obj_cgroup **s_objcgs, **d_objcgs;
+
+	sf_page = get_first_page(get_zspage(s_page));
+	df_page = get_first_page(get_zspage(d_page));
+
+	s_objcgs =  page_objcgs_check(sf_page);
+	d_objcgs =  page_objcgs_check(df_page);
+
+	if (!s_objcgs || !d_objcgs)
+		return;
+
+	d_objcgs[d_index] = s_objcgs[s_index];
+	s_objcgs[s_index] = NULL;
+}
+
+void zs_alloc_obj_cgroups(struct zspage *zspage, struct size_class *class)
+{
+	struct page *page = zspage->first_page;
+	int objects = class->objs_per_zspage;
+	unsigned long memcg_data = 0;
+	void *vec;
+
+	vec = kcalloc_node(objects, sizeof(struct obj_cgroup *),
+			GFP_NOWAIT|__GFP_NOWARN|
+			__GFP_ZERO|__GFP_MOVABLE,
+			page_to_nid(page));
+
+	if (vec)
+		memcg_data = (unsigned long)vec | MEMCG_DATA_OBJCGS;
+	page->memcg_data = memcg_data;
+}
+
+static inline bool zs_obj_pre_alloc_hook(struct size_class *class,
+				struct obj_cgroup **objcgp, gfp_t flags)
+{
+	struct obj_cgroup *objcg;
+
+	*objcgp = NULL;
+
+	objcg = get_obj_cgroup_from_current();
+	if (!objcg)
+		return true;
+
+	if (obj_cgroup_charge(objcg, flags, zs_obj_full_size(class))) {
+		obj_cgroup_put(objcg);
+		return false;
+	}
+
+	*objcgp = objcg;
+	return true;
+}
+
+static inline void zs_obj_post_alloc_hook(struct size_class *class,
+				struct zspage *zspage,
+				unsigned int idx,
+				struct obj_cgroup *objcg)
+{
+	struct obj_cgroup **objcgs = NULL;
+
+	if (!objcg)
+		return;
+
+	if (zspage)
+		objcgs = page_objcgs_check(zspage->first_page);
+
+	if (!objcgs) {
+		obj_cgroup_uncharge(objcg, zs_obj_full_size(class));
+		obj_cgroup_put(objcg);
+		return;
+	}
+
+	objcgs[idx] = objcg;
+}
+
+static inline void zs_obj_free_hook(int class_size, struct zspage *zspage,
+				unsigned int idx)
+{
+	struct obj_cgroup **objcgs, *objcg;
+
+	objcgs = page_objcgs_check(zspage->first_page);
+
+	if (WARN_ON(!objcgs))
+		return;
+
+	objcg = objcgs[idx];
+	if (!objcg)
+		return;
+
+	objcgs[idx] = NULL;
+	obj_cgroup_uncharge(objcg, class_size + sizeof(struct obj_cgroup *));
+	obj_cgroup_put(objcg);
+}
+#else
+
+static void zs_free_page_obj_cgroups(struct zspage *zspage)
+{
+}
+
+static inline void zs_objcg_exchange(struct page *s_page, unsigned int s_index,
+				struct page *d_page, unsigned int d_index)
+{
+}
+
+int zs_alloc_obj_cgroups(struct zspage *zspage, struct size_class *class)
+{
+	return 0;
+}
+
+static inline bool zs_obj_pre_alloc_hook(struct size_class *class,
+				struct obj_cgroup **objcgp, gfp_t flags)
+{
+	return true;
+}
+
+static inline void zs_obj_post_alloc_hook(struct size_class *class,
+				struct page *page,
+				unsigned int idx,
+				struct obj_cgroup *objcg)
+{
+}
+static inline void zs_obj_free_hook(int class_size, struct zspage *zspage,
+				unsigned int idx)
+{
+}
+#endif
+
 static unsigned long obj_malloc(struct zs_pool *pool,
 				struct zspage *zspage, unsigned long handle)
 {
@@ -1475,7 +1642,8 @@ static unsigned long obj_malloc(struct zs_pool *pool,
  */
 unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 {
-	unsigned long handle, obj;
+	unsigned long handle, obj, index;
+	struct obj_cgroup *objcg;
 	struct size_class *class;
 	int newfg;
 	struct zspage *zspage;
@@ -1491,17 +1659,23 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	size += ZS_HANDLE_SIZE;
 	class = pool->size_class[get_size_class_index(size)];
 
+	if (!zs_obj_pre_alloc_hook(class, &objcg, gfp)) {
+		cache_free_handle(pool, handle);
+		return (unsigned long)ERR_PTR(-ENOMEM);
+	}
+
 	/* pool->lock effectively protects the zpage migration */
 	spin_lock(&pool->lock);
 	zspage = find_get_zspage(class);
 	if (likely(zspage)) {
+		index = get_freeobj(zspage);
 		obj = obj_malloc(pool, zspage, handle);
 		/* Now move the zspage to another fullness group, if required */
 		fix_fullness_group(class, zspage);
 		record_obj(handle, obj);
 		class_stat_inc(class, ZS_OBJS_INUSE, 1);
 
-		goto out;
+		goto out_unlock;
 	}
 
 	spin_unlock(&pool->lock);
@@ -1509,9 +1683,12 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	zspage = alloc_zspage(pool, class, gfp);
 	if (!zspage) {
 		cache_free_handle(pool, handle);
-		return (unsigned long)ERR_PTR(-ENOMEM);
+		handle =  (unsigned long)ERR_PTR(-ENOMEM);
+		goto out;
 	}
 
+	zs_alloc_obj_cgroups(zspage, class);
+	index = get_freeobj(zspage);
 	spin_lock(&pool->lock);
 	obj = obj_malloc(pool, zspage, handle);
 	newfg = get_fullness_group(class, zspage);
@@ -1524,7 +1701,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 
 	/* We completely set up zspage so mark them as movable */
 	SetZsPageMovable(pool, zspage);
-out:
+out_unlock:
 #ifdef CONFIG_ZPOOL
 	/* Add/move zspage to beginning of LRU */
 	if (!list_empty(&zspage->lru))
@@ -1533,6 +1710,8 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 #endif
 
 	spin_unlock(&pool->lock);
+out:
+	zs_obj_post_alloc_hook(class, zspage, index, objcg);
 
 	return handle;
 }
@@ -1573,7 +1752,7 @@ static void obj_free(int class_size, unsigned long obj, unsigned long *handle)
 			f_page->index = 0;
 		set_freeobj(zspage, f_objidx);
 	}
-
+	zs_obj_free_hook(class_size, zspage, f_objidx);
 	kunmap_atomic(vaddr);
 	mod_zspage_inuse(zspage, -1);
 }
@@ -1640,6 +1819,7 @@ static void zs_object_copy(struct size_class *class, unsigned long dst,
 	obj_to_location(src, &s_page, &s_objidx);
 	obj_to_location(dst, &d_page, &d_objidx);
 
+	zs_objcg_exchange(s_page, s_objidx, d_page, d_objidx);
 	s_off = (class->size * s_objidx) & ~PAGE_MASK;
 	d_off = (class->size * d_objidx) & ~PAGE_MASK;
 
@@ -1960,6 +2140,12 @@ static void replace_sub_page(struct size_class *class, struct zspage *zspage,
 	int idx = 0;
 
 	page = get_first_page(zspage);
+#ifdef CONFIG_MEMCG_KMEM
+	if (page == oldpage) {
+		newpage->memcg_data = page->memcg_data;
+		page->memcg_data = 0;
+	}
+#endif
 	do {
 		if (page == oldpage)
 			pages[idx] = newpage;
-- 
2.25.1

