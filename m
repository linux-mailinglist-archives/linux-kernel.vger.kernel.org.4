Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C72C6268FB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 11:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiKLK62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 05:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLK60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 05:58:26 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A863DBC0C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 02:58:22 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N8Xbz2YFmzRp3V;
        Sat, 12 Nov 2022 18:58:07 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 18:58:21 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 12 Nov
 2022 18:58:20 +0800
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
Subject: [PATCH v4 3/3] mm/slub: Fix memory leak of kobj->name in sysfs_slab_add()
Date:   Sat, 12 Nov 2022 19:46:02 +0800
Message-ID: <20221112114602.1268989-4-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221112114602.1268989-1-liushixin2@huawei.com>
References: <20221112114602.1268989-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a memory leak of kobj->name in sysfs_slab_add():

 unreferenced object 0xffff88817e446440 (size 32):
   comm "insmod", pid 4085, jiffies 4296564501 (age 126.272s)
   hex dump (first 32 bytes):
     75 62 69 66 73 5f 69 6e 6f 64 65 5f 73 6c 61 62  ubifs_inode_slab
     00 65 44 7e 81 88 ff ff 00 00 00 00 00 00 00 00  .eD~............
   backtrace:
     [<000000005b30fbbd>] __kmalloc_node_track_caller+0x4e/0x150
     [<000000002f70da0c>] kstrdup_const+0x4b/0x80
     [<00000000c6712c61>] kobject_set_name_vargs+0x2f/0xb0
     [<00000000b151218e>] kobject_init_and_add+0xb0/0x120
     [<00000000e56a4cf5>] sysfs_slab_add+0x17d/0x220
     [<000000009326fd57>] __kmem_cache_create+0x406/0x590
     [<00000000dde33cff>] kmem_cache_create_usercopy+0x1fc/0x300
     [<00000000fe90cedb>] kmem_cache_create+0x12/0x20
     [<000000007a6531c8>] 0xffffffffa02d802d
     [<000000000e3b13c7>] do_one_initcall+0x87/0x2a0
     [<00000000995ecdcf>] do_init_module+0xdf/0x320
     [<000000008821941f>] load_module+0x2f98/0x3330
     [<00000000ef51efa4>] __do_sys_finit_module+0x113/0x1b0
     [<000000009339fbce>] do_syscall_64+0x35/0x80
     [<000000006b7f2033>] entry_SYSCALL_64_after_hwframe+0x46/0xb0

Following the rules stated in the comment for kobject_init_and_add():
 If this function returns an error, kobject_put() must be called to
 properly clean up the memory associated with the object.

kobject_put() is more appropriate for error handling after kobject_init().
And we can use this function to solve this problem.

For the cache created early, the related sysfs_slab_add() is called in
slab_sysfs_init(). Skip free these kmem_cache since they are important
for system. Keep them working without sysfs.

Fixes: 80da026a8e5d ("mm/slub: fix slab double-free in case of duplicate sysfs filename")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 include/linux/slub_def.h |  4 ++--
 mm/slab_common.c         |  6 ++----
 mm/slub.c                | 21 +++++++++++++++++----
 3 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index 26d56c4c74d1..90c3e06b77b1 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -144,11 +144,11 @@ struct kmem_cache {
 
 #ifdef CONFIG_SYSFS
 #define SLAB_SUPPORTS_SYSFS
-int sysfs_slab_add(struct kmem_cache *);
+int sysfs_slab_add(struct kmem_cache *, bool);
 void sysfs_slab_unlink(struct kmem_cache *);
 void sysfs_slab_release(struct kmem_cache *);
 #else
-static inline int sysfs_slab_add(struct kmem_cache *s)
+static inline int sysfs_slab_add(struct kmem_cache *s, bool free_slab)
 {
 	return 0;
 }
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 55e2cf064dfe..30808a1d1b32 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -237,11 +237,9 @@ static struct kmem_cache *create_cache(const char *name,
 #ifdef SLAB_SUPPORTS_SYSFS
 	/* Mutex is not taken during early boot */
 	if (slab_state >= FULL) {
-		err = sysfs_slab_add(s);
-		if (err) {
-			slab_kmem_cache_release(s);
+		err = sysfs_slab_add(s, true);
+		if (err)
 			return ERR_PTR(err);
-		}
 		debugfs_slab_add(s);
 	}
 #endif
diff --git a/mm/slub.c b/mm/slub.c
index a1ad759753ce..25575bce0c3c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5881,7 +5881,7 @@ static char *create_unique_id(struct kmem_cache *s)
 	return name;
 }
 
-int sysfs_slab_add(struct kmem_cache *s)
+int sysfs_slab_add(struct kmem_cache *s, bool free_slab)
 {
 	int err;
 	const char *name;
@@ -5911,14 +5911,17 @@ int sysfs_slab_add(struct kmem_cache *s)
 		 * for the symlinks.
 		 */
 		name = create_unique_id(s);
-		if (IS_ERR(name))
+		if (IS_ERR(name)) {
+			if (free_slab)
+				slab_kmem_cache_release(s);
 			return PTR_ERR(name);
+		}
 	}
 
 	s->kobj.kset = kset;
 	err = kobject_init_and_add(&s->kobj, &slab_ktype, NULL, "%s", name);
 	if (err)
-		goto out;
+		goto out_put_kobj;
 
 	err = sysfs_create_group(&s->kobj, &slab_attr_group);
 	if (err)
@@ -5934,6 +5937,16 @@ int sysfs_slab_add(struct kmem_cache *s)
 	return err;
 out_del_kobj:
 	kobject_del(&s->kobj);
+out_put_kobj:
+	/*
+	 * Skip free kmem_cache that create early since they are important
+	 * for system. Keep them working without sysfs. Only free the name
+	 * for early allocated kmem_cache.
+	 */
+	if (free_slab)
+		kobject_put(&s->kobj);
+	else
+		kfree_const(s->kobj.name);
 	goto out;
 }
 
@@ -6002,7 +6015,7 @@ static int __init slab_sysfs_init(void)
 	slab_state = FULL;
 
 	list_for_each_entry(s, &slab_caches, list) {
-		err = sysfs_slab_add(s);
+		err = sysfs_slab_add(s, false);
 		if (err)
 			pr_err("SLUB: Unable to add boot slab %s to sysfs\n",
 			       s->name);
-- 
2.25.1

