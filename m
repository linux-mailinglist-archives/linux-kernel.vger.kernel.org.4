Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D866A315D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjBZO5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjBZOyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:54:19 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61CF1ADFD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:50:14 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id k21-20020a17090aaa1500b002376652e160so3811503pjq.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f5xm65H9BLTSDcpU/nYsAyAok8lJrBUsJgeNL2FDrMI=;
        b=DU9ImCfzPDt6r5qsdIJgFlMqPyv1XNzrFdxX1MYevySp7rV/vBy4oHtHlXM0ehu+/q
         e7Sjxf8qsqyQGdUSKu80ZuyH8gv9rpDyqCA+6sYlagLU/RVK4FI8pl7xZiXV+Ojb41zx
         ezPpwq3uJvNV5TVTXIF7WKeiEmB772qpgZU/rJEebve9b47zOunZTUMe/f+gk7PISSjc
         Ehcf7cS8nj1sKVkD/JveUqUJzsUCxQfCPh/rzpzR2amvQmZsujUa/Epz4Eonu2OG9utb
         VbC/USw9zVaaeY/TFpc3MuKTAHI4ssQxadvh9v+878R2uidsPviikdk/mxseIFk0IHSC
         +N3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f5xm65H9BLTSDcpU/nYsAyAok8lJrBUsJgeNL2FDrMI=;
        b=ymEbfvJJflIhHcxxQE6BoqxhGeoqCLhJXYgVuxlV97/IVd1UihoKpx/CWKHzOIzRCr
         JvpzA2OjjJVrVtxK9YU+bpd/nic4OYuP/0GzSUKDxfaIJWnkecyzsf39L+TjifeNfatH
         LjPAJhpvO1eQYKTyZ+tAc0O0gshce6cSOcwdNO2/dQlqhsL8qRCuSUJiJ7RVq+X2zxHG
         Mfue5gjC4q7eS6EdhUHZIpRw4dyJdc3Ipy8w92qqVqYBKC6f/sqAnFbZONUmg8ukf5XO
         uOUbBLruTtMl01XueY4e+dYrxWwoRhf/OX6zBX4cr/X54DXXnNNo+whM3kz0pCCcinMo
         XoBg==
X-Gm-Message-State: AO0yUKVy+ht/6CI68ZBL7QtyC1hYcKXWhRbxLDk3PHmHEMi2jRQtyjXh
        EETxISgFJfYxYZw1sMYhRZYPdg==
X-Google-Smtp-Source: AK7set9OLUlQVvloHLhW8LBiRt1OW+15leJOMZQHQ9/zIbOmm9Z4KelXtK4HEXm+zbHSQlGGRoJ3MA==
X-Received: by 2002:a17:902:d4c8:b0:19a:7217:32af with SMTP id o8-20020a170902d4c800b0019a721732afmr23250125plg.5.1677422936561;
        Sun, 26 Feb 2023 06:48:56 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id y20-20020a170902ed5400b0019c2cf12d15sm2755589plb.116.2023.02.26.06.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 06:48:56 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 8/8] mm: shrinkers: convert shrinker_rwsem to mutex
Date:   Sun, 26 Feb 2023 22:46:55 +0800
Message-Id: <20230226144655.79778-9-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
References: <20230226144655.79778-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now there are no readers of shrinker_rwsem, so we
can simply replace it with mutex lock.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 drivers/md/dm-cache-metadata.c |  2 +-
 drivers/md/dm-thin-metadata.c  |  2 +-
 fs/super.c                     |  2 +-
 mm/shrinker_debug.c            | 14 +++++++-------
 mm/vmscan.c                    | 34 +++++++++++++++++-----------------
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/md/dm-cache-metadata.c b/drivers/md/dm-cache-metadata.c
index acffed750e3e..9e0c69958587 100644
--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -1828,7 +1828,7 @@ int dm_cache_metadata_abort(struct dm_cache_metadata *cmd)
 	 * Replacement block manager (new_bm) is created and old_bm destroyed outside of
 	 * cmd root_lock to avoid ABBA deadlock that would result (due to life-cycle of
 	 * shrinker associated with the block manager's bufio client vs cmd root_lock).
-	 * - must take shrinker_rwsem without holding cmd->root_lock
+	 * - must take shrinker_mutex without holding cmd->root_lock
 	 */
 	new_bm = dm_block_manager_create(cmd->bdev, DM_CACHE_METADATA_BLOCK_SIZE << SECTOR_SHIFT,
 					 CACHE_MAX_CONCURRENT_LOCKS);
diff --git a/drivers/md/dm-thin-metadata.c b/drivers/md/dm-thin-metadata.c
index fd464fb024c3..9f5cb52c5763 100644
--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -1887,7 +1887,7 @@ int dm_pool_abort_metadata(struct dm_pool_metadata *pmd)
 	 * Replacement block manager (new_bm) is created and old_bm destroyed outside of
 	 * pmd root_lock to avoid ABBA deadlock that would result (due to life-cycle of
 	 * shrinker associated with the block manager's bufio client vs pmd root_lock).
-	 * - must take shrinker_rwsem without holding pmd->root_lock
+	 * - must take shrinker_mutex without holding pmd->root_lock
 	 */
 	new_bm = dm_block_manager_create(pmd->bdev, THIN_METADATA_BLOCK_SIZE << SECTOR_SHIFT,
 					 THIN_MAX_CONCURRENT_LOCKS);
diff --git a/fs/super.c b/fs/super.c
index 84332d5cb817..91a4037b1d95 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -54,7 +54,7 @@ static char *sb_writers_name[SB_FREEZE_LEVELS] = {
  * One thing we have to be careful of with a per-sb shrinker is that we don't
  * drop the last active reference to the superblock from within the shrinker.
  * If that happens we could trigger unregistering the shrinker from within the
- * shrinker path and that leads to deadlock on the shrinker_rwsem. Hence we
+ * shrinker path and that leads to deadlock on the shrinker_mutex. Hence we
  * take a passive reference to the superblock to avoid this from occurring.
  */
 static unsigned long super_cache_scan(struct shrinker *shrink,
diff --git a/mm/shrinker_debug.c b/mm/shrinker_debug.c
index 6aa7a7ec69da..b0f6aff372df 100644
--- a/mm/shrinker_debug.c
+++ b/mm/shrinker_debug.c
@@ -7,7 +7,7 @@
 #include <linux/memcontrol.h>
 
 /* defined in vmscan.c */
-extern struct rw_semaphore shrinker_rwsem;
+extern struct mutex shrinker_mutex;
 extern struct list_head shrinker_list;
 extern struct srcu_struct shrinker_srcu;
 
@@ -167,7 +167,7 @@ int shrinker_debugfs_add(struct shrinker *shrinker)
 	char buf[128];
 	int id;
 
-	lockdep_assert_held(&shrinker_rwsem);
+	lockdep_assert_held(&shrinker_mutex);
 
 	/* debugfs isn't initialized yet, add debugfs entries later. */
 	if (!shrinker_debugfs_root)
@@ -210,7 +210,7 @@ int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 	if (!new)
 		return -ENOMEM;
 
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 
 	old = shrinker->name;
 	shrinker->name = new;
@@ -228,7 +228,7 @@ int shrinker_debugfs_rename(struct shrinker *shrinker, const char *fmt, ...)
 			shrinker->debugfs_entry = entry;
 	}
 
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 
 	kfree_const(old);
 
@@ -240,7 +240,7 @@ struct dentry *shrinker_debugfs_remove(struct shrinker *shrinker)
 {
 	struct dentry *entry = shrinker->debugfs_entry;
 
-	lockdep_assert_held(&shrinker_rwsem);
+	lockdep_assert_held(&shrinker_mutex);
 
 	kfree_const(shrinker->name);
 	shrinker->name = NULL;
@@ -265,14 +265,14 @@ static int __init shrinker_debugfs_init(void)
 	shrinker_debugfs_root = dentry;
 
 	/* Create debugfs entries for shrinkers registered at boot */
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	list_for_each_entry(shrinker, &shrinker_list, list)
 		if (!shrinker->debugfs_entry) {
 			ret = shrinker_debugfs_add(shrinker);
 			if (ret)
 				break;
 		}
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 
 	return ret;
 }
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2d71fd565c78..6c5d21ba0c9a 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -35,7 +35,7 @@
 #include <linux/cpuset.h>
 #include <linux/compaction.h>
 #include <linux/notifier.h>
-#include <linux/rwsem.h>
+#include <linux/mutex.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
@@ -202,7 +202,7 @@ static void set_task_reclaim_state(struct task_struct *task,
 }
 
 LIST_HEAD(shrinker_list);
-DECLARE_RWSEM(shrinker_rwsem);
+DEFINE_MUTEX(shrinker_mutex);
 DEFINE_SRCU(shrinker_srcu);
 static atomic_t shrinker_srcu_generation = ATOMIC_INIT(0);
 
@@ -225,7 +225,7 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
 {
 	return srcu_dereference_check(memcg->nodeinfo[nid]->shrinker_info,
 				      &shrinker_srcu,
-				      lockdep_is_held(&shrinker_rwsem));
+				      lockdep_is_held(&shrinker_mutex));
 }
 
 static struct shrinker_info *shrinker_info_srcu(struct mem_cgroup *memcg,
@@ -310,7 +310,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 	int nid, size, ret = 0;
 	int map_size, defer_size = 0;
 
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	map_size = shrinker_map_size(shrinker_nr_max);
 	defer_size = shrinker_defer_size(shrinker_nr_max);
 	size = map_size + defer_size;
@@ -326,7 +326,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 		info->map_nr_max = shrinker_nr_max;
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
 	}
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 
 	return ret;
 }
@@ -342,7 +342,7 @@ static int expand_shrinker_info(int new_id)
 	if (!root_mem_cgroup)
 		goto out;
 
-	lockdep_assert_held(&shrinker_rwsem);
+	lockdep_assert_held(&shrinker_mutex);
 
 	map_size = shrinker_map_size(new_nr_max);
 	defer_size = shrinker_defer_size(new_nr_max);
@@ -392,7 +392,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	if (mem_cgroup_disabled())
 		return -ENOSYS;
 
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -406,7 +406,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	shrinker->id = id;
 	ret = 0;
 unlock:
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 	return ret;
 }
 
@@ -416,7 +416,7 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 
 	BUG_ON(id < 0);
 
-	lockdep_assert_held(&shrinker_rwsem);
+	lockdep_assert_held(&shrinker_mutex);
 
 	idr_remove(&shrinker_idr, id);
 }
@@ -451,7 +451,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/* Prevent from concurrent shrinker_info expand */
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
@@ -460,7 +460,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 			atomic_long_add(nr, &parent_info->nr_deferred[i]);
 		}
 	}
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 }
 
 static bool cgroup_reclaim(struct scan_control *sc)
@@ -709,9 +709,9 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 	shrinker->name = NULL;
 #endif
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE) {
-		down_write(&shrinker_rwsem);
+		mutex_lock(&shrinker_mutex);
 		unregister_memcg_shrinker(shrinker);
-		up_write(&shrinker_rwsem);
+		mutex_unlock(&shrinker_mutex);
 		return;
 	}
 
@@ -721,11 +721,11 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 
 void register_shrinker_prepared(struct shrinker *shrinker)
 {
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	list_add_tail_rcu(&shrinker->list, &shrinker_list);
 	shrinker->flags |= SHRINKER_REGISTERED;
 	shrinker_debugfs_add(shrinker);
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 }
 
 static int __register_shrinker(struct shrinker *shrinker)
@@ -775,13 +775,13 @@ void unregister_shrinker(struct shrinker *shrinker)
 	if (!(shrinker->flags & SHRINKER_REGISTERED))
 		return;
 
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	list_del_rcu(&shrinker->list);
 	shrinker->flags &= ~SHRINKER_REGISTERED;
 	if (shrinker->flags & SHRINKER_MEMCG_AWARE)
 		unregister_memcg_shrinker(shrinker);
 	debugfs_entry = shrinker_debugfs_remove(shrinker);
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 
 	atomic_inc(&shrinker_srcu_generation);
 	synchronize_srcu(&shrinker_srcu);
-- 
2.20.1

