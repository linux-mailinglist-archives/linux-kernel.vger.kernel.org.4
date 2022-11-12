Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473056268E5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 11:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiKLKdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 05:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiKLKdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 05:33:13 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271CF2D766
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 02:33:03 -0800 (PST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N8WzS6dx3zJndw;
        Sat, 12 Nov 2022 18:29:56 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 12 Nov 2022 18:33:01 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Sat, 12 Nov
 2022 18:33:00 +0800
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
Subject: [PATCH v3 1/3] mm/slab_common: Move cache_name to create_cache()
Date:   Sat, 12 Nov 2022 19:20:53 +0800
Message-ID: <20221112112055.1111078-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221112112055.1111078-1-liushixin2@huawei.com>
References: <20221112112055.1111078-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The string cache_name and its kmem_cache have same life cycle. The latter
is allocated in create_cache() so move cache_name to create_cache() too
for better error handing.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/slab_common.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 33b1886b06eb..e5f430a17d95 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -209,17 +209,21 @@ static struct kmem_cache *create_cache(const char *name,
 		struct kmem_cache *root_cache)
 {
 	struct kmem_cache *s;
-	int err;
+	const char *cache_name;
+	int err = -ENOMEM;
 
 	if (WARN_ON(useroffset + usersize > object_size))
 		useroffset = usersize = 0;
 
-	err = -ENOMEM;
 	s = kmem_cache_zalloc(kmem_cache, GFP_KERNEL);
 	if (!s)
-		goto out;
+		return ERR_PTR(err);
 
-	s->name = name;
+	cache_name = kstrdup_const(name, GFP_KERNEL);
+	if (!cache_name)
+		goto out_free_cache;
+
+	s->name = cache_name;
 	s->size = s->object_size = object_size;
 	s->align = align;
 	s->ctor = ctor;
@@ -228,18 +232,17 @@ static struct kmem_cache *create_cache(const char *name,
 
 	err = __kmem_cache_create(s, flags);
 	if (err)
-		goto out_free_cache;
+		goto out_free_name;
 
 	s->refcount = 1;
 	list_add(&s->list, &slab_caches);
-out:
-	if (err)
-		return ERR_PTR(err);
 	return s;
 
+out_free_name:
+	kfree_const(s->name);
 out_free_cache:
 	kmem_cache_free(kmem_cache, s);
-	goto out;
+	return ERR_PTR(err);
 }
 
 /**
@@ -278,7 +281,6 @@ kmem_cache_create_usercopy(const char *name,
 		  void (*ctor)(void *))
 {
 	struct kmem_cache *s = NULL;
-	const char *cache_name;
 	int err;
 
 #ifdef CONFIG_SLUB_DEBUG
@@ -326,19 +328,11 @@ kmem_cache_create_usercopy(const char *name,
 	if (s)
 		goto out_unlock;
 
-	cache_name = kstrdup_const(name, GFP_KERNEL);
-	if (!cache_name) {
-		err = -ENOMEM;
-		goto out_unlock;
-	}
-
-	s = create_cache(cache_name, size,
+	s = create_cache(name, size,
 			 calculate_alignment(flags, align, size),
 			 flags, useroffset, usersize, ctor, NULL);
-	if (IS_ERR(s)) {
+	if (IS_ERR(s))
 		err = PTR_ERR(s);
-		kfree_const(cache_name);
-	}
 
 out_unlock:
 	mutex_unlock(&slab_mutex);
-- 
2.25.1

