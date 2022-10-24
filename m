Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AE4609ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 08:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiJXGyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 02:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiJXGyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 02:54:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB455B7A5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 23:54:04 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mwm1B6HgJzpVrh;
        Mon, 24 Oct 2022 14:50:38 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 24 Oct 2022 14:54:02 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 14:54:01 +0800
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
Subject: [PATCH 4/4] mm/slab_common: Fix memory leak of kobj->name in sysfs_slab_add()
Date:   Mon, 24 Oct 2022 15:42:32 +0800
Message-ID: <20221024074232.151383-5-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221024074232.151383-1-liushixin2@huawei.com>
References: <20221024074232.151383-1-liushixin2@huawei.com>
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

Fixes: 80da026a8e5d ("mm/slub: fix slab double-free in case of duplicate sysfs filename")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 mm/slab_common.c | 4 +---
 mm/slub.c        | 8 ++++++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index f146dea3f9de..e60f873c1aaf 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -237,10 +237,8 @@ static struct kmem_cache *create_cache(const char *name,
 	/* Mutex is not taken during early boot */
 	if (slab_state >= FULL) {
 		err = sysfs_slab_add(s);
-		if (err) {
-			slab_kmem_cache_release(s);
+		if (err)
 			return ERR_PTR(err);
-		}
 		debugfs_slab_add(s);
 	}
 
diff --git a/mm/slub.c b/mm/slub.c
index a1ad759753ce..f8883bc642b8 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5911,14 +5911,16 @@ int sysfs_slab_add(struct kmem_cache *s)
 		 * for the symlinks.
 		 */
 		name = create_unique_id(s);
-		if (IS_ERR(name))
+		if (IS_ERR(name)) {
+			slab_kmem_cache_release(s);
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
@@ -5934,6 +5936,8 @@ int sysfs_slab_add(struct kmem_cache *s)
 	return err;
 out_del_kobj:
 	kobject_del(&s->kobj);
+out_put_kobj:
+	kobject_put(&s->kobj);
 	goto out;
 }
 
-- 
2.25.1

