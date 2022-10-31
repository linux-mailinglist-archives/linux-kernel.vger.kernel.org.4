Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B495B613739
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 13:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiJaM7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 08:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbiJaM7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 08:59:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4ECFAF7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 05:59:38 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1Cnd6PHTzpW7W;
        Mon, 31 Oct 2022 20:56:05 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 20:59:36 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 20:59:36 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        "David Rientjes" <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Roman Gushchin" <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH v2 2/3] mm/slub: Refactor __kmem_cache_create()
Date:   Mon, 31 Oct 2022 21:47:46 +0800
Message-ID: <20221031134747.3049593-3-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031134747.3049593-1-liushixin2@huawei.com>
References: <20221031134747.3049593-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate sysfs_slab_add() and debugfs_slab_add() from __kmem_cache_create()
can help to fix a memory leak about kobject. After this patch, we can fix
the memory leak naturally by calling kobject_put() to free kobject and
associated kmem_cache when sysfs_slab_add() failed.

Besides, after that, we can easy to provide sysfs and debugfs support for
other allocators too.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 include/linux/slub_def.h | 11 ++++++++++
 mm/slab_common.c         | 12 +++++++++++
 mm/slub.c                | 44 +++++++---------------------------------
 3 files changed, 30 insertions(+), 37 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index f9c68a9dac04..26d56c4c74d1 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -144,9 +144,14 @@ struct kmem_cache {
 
 #ifdef CONFIG_SYSFS
 #define SLAB_SUPPORTS_SYSFS
+int sysfs_slab_add(struct kmem_cache *);
 void sysfs_slab_unlink(struct kmem_cache *);
 void sysfs_slab_release(struct kmem_cache *);
 #else
+static inline int sysfs_slab_add(struct kmem_cache *s)
+{
+	return 0;
+}
 static inline void sysfs_slab_unlink(struct kmem_cache *s)
 {
 }
@@ -155,6 +160,12 @@ static inline void sysfs_slab_release(struct kmem_cache *s)
 }
 #endif
 
+#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
+void debugfs_slab_add(struct kmem_cache *);
+#else
+static inline void debugfs_slab_add(struct kmem_cache *s) { }
+#endif
+
 void *fixup_red_left(struct kmem_cache *s, void *p);
 
 static inline void *nearest_obj(struct kmem_cache *cache, const struct slab *slab,
diff --git a/mm/slab_common.c b/mm/slab_common.c
index e5f430a17d95..55e2cf064dfe 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -234,6 +234,18 @@ static struct kmem_cache *create_cache(const char *name,
 	if (err)
 		goto out_free_name;
 
+#ifdef SLAB_SUPPORTS_SYSFS
+	/* Mutex is not taken during early boot */
+	if (slab_state >= FULL) {
+		err = sysfs_slab_add(s);
+		if (err) {
+			slab_kmem_cache_release(s);
+			return ERR_PTR(err);
+		}
+		debugfs_slab_add(s);
+	}
+#endif
+
 	s->refcount = 1;
 	list_add(&s->list, &slab_caches);
 	return s;
diff --git a/mm/slub.c b/mm/slub.c
index ba94eb6fda78..a1ad759753ce 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -299,20 +299,12 @@ struct track {
 enum track_item { TRACK_ALLOC, TRACK_FREE };
 
 #ifdef CONFIG_SYSFS
-static int sysfs_slab_add(struct kmem_cache *);
 static int sysfs_slab_alias(struct kmem_cache *, const char *);
 #else
-static inline int sysfs_slab_add(struct kmem_cache *s) { return 0; }
 static inline int sysfs_slab_alias(struct kmem_cache *s, const char *p)
 							{ return 0; }
 #endif
 
-#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
-static void debugfs_slab_add(struct kmem_cache *);
-#else
-static inline void debugfs_slab_add(struct kmem_cache *s) { }
-#endif
-
 static inline void stat(const struct kmem_cache *s, enum stat_item si)
 {
 #ifdef CONFIG_SLUB_STATS
@@ -4297,7 +4289,7 @@ static int calculate_sizes(struct kmem_cache *s)
 	return !!oo_objects(s->oo);
 }
 
-static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
+int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 {
 	s->flags = kmem_cache_flags(s->size, flags, s->name);
 #ifdef CONFIG_SLAB_FREELIST_HARDENED
@@ -4900,30 +4892,6 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
 	return s;
 }
 
-int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
-{
-	int err;
-
-	err = kmem_cache_open(s, flags);
-	if (err)
-		return err;
-
-	/* Mutex is not taken during early boot */
-	if (slab_state <= UP)
-		return 0;
-
-	err = sysfs_slab_add(s);
-	if (err) {
-		__kmem_cache_release(s);
-		return err;
-	}
-
-	if (s->flags & SLAB_STORE_USER)
-		debugfs_slab_add(s);
-
-	return 0;
-}
-
 #ifdef CONFIG_SYSFS
 static int count_inuse(struct slab *slab)
 {
@@ -5913,7 +5881,7 @@ static char *create_unique_id(struct kmem_cache *s)
 	return name;
 }
 
-static int sysfs_slab_add(struct kmem_cache *s)
+int sysfs_slab_add(struct kmem_cache *s)
 {
 	int err;
 	const char *name;
@@ -6236,10 +6204,13 @@ static const struct file_operations slab_debugfs_fops = {
 	.release = slab_debug_trace_release,
 };
 
-static void debugfs_slab_add(struct kmem_cache *s)
+void debugfs_slab_add(struct kmem_cache *s)
 {
 	struct dentry *slab_cache_dir;
 
+	if (!(s->flags & SLAB_STORE_USER))
+		return;
+
 	if (unlikely(!slab_debugfs_root))
 		return;
 
@@ -6264,8 +6235,7 @@ static int __init slab_debugfs_init(void)
 	slab_debugfs_root = debugfs_create_dir("slab", NULL);
 
 	list_for_each_entry(s, &slab_caches, list)
-		if (s->flags & SLAB_STORE_USER)
-			debugfs_slab_add(s);
+		debugfs_slab_add(s);
 
 	return 0;
 
-- 
2.25.1

