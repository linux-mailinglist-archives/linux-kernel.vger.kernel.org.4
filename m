Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44DF69C783
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbjBTJRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjBTJRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:17:33 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78A915543
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:17:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id co23-20020a17090afe9700b002341fadc370so539917pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 01:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3B7sNafZtBlgHmh5fpLAa14mnyUBnuiEHhgxOSu4EUY=;
        b=4puz4Jgz93txeceBh3fQ+lEdkKu9A4lOtC1kYgX78UKROjsP3O5+Y11jVMsovlB8oU
         sXuaRzKA6g9H9MXb3TdaF5sp9f/QMmV6iVKEx444zjffMm5LRNXcvYaal2t+iybJaLjY
         dOAt6AzfkgtaTHsJmUt79SpRjjglW8OOcC+KtEe+U5VqwR2qSZOga5VUjMCAWJRD00IM
         JG/qWE7eie2G7sZ4cJOwULL9sO4k8JkKSdEghpO73ZZLKfjRUL1R74gz0k7djhVwirUQ
         TM5T4chfi9rC4wta62Q+8DdRwAl1M2SQDAocd2oBCkh1qD+vWeFfRIBKkH20GK8x1S4Z
         r++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3B7sNafZtBlgHmh5fpLAa14mnyUBnuiEHhgxOSu4EUY=;
        b=H5ysqQGJuRDIH5nBKd9UGUQzbVrrx3b1XPONajKCf0lMWAOrmKn5sxzwlSjquzNb+i
         j6HUVAs8F2vBa9uVJE28aWmWjmTIXlV3A6JL5fRDCpCqF4Gaim3SYJJSeeYiPhusbC1N
         oC9hdvbDSwHkOXhmUmTxgc2/mcLgmLU+49VaDNVkZ+jFGs97cLRNthNAiGzdkLMvDbtU
         IxQkUkXeOlHOJrZ2/BjUuBxNs+FkYPNTzLksqr5S6vrNqsl2C/KjWmkkEGhL9xKXXa/Z
         YlRVPs8mn8QLI9rs8omSIW98nsObQMwUSAePN1QB1AnLbv0rUlo0OApG2dSLWAIUsbvV
         YWpQ==
X-Gm-Message-State: AO0yUKUXMOW5eTzuDSDDgVM4okhxBgyHJN6DJpo6cae4h3TRdF8CJUYN
        dOI8i36Xab0VLsl2cZOdQMgENQ==
X-Google-Smtp-Source: AK7set/FrMA+DzzJjfgDbDVBnD4DP8OP+6IttlJ5FihjDu+ykoY0DseCdfCDQOT7VAaqhwcLBAHAYg==
X-Received: by 2002:a17:90b:948:b0:236:7f67:8338 with SMTP id dw8-20020a17090b094800b002367f678338mr365975pjb.4.1676884650199;
        Mon, 20 Feb 2023 01:17:30 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id fs13-20020a17090af28d00b002339195a47bsm432382pjb.53.2023.02.20.01.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 01:17:29 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, hannes@cmpxchg.org, shakeelb@google.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, muchun.song@linux.dev,
        david@redhat.com, shy828301@gmail.com
Cc:     tkhai@ya.ru, sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 5/5] mm: shrinkers: convert shrinker_rwsem to mutex
Date:   Mon, 20 Feb 2023 17:16:37 +0800
Message-Id: <20230220091637.64865-6-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230220091637.64865-1-zhengqi.arch@bytedance.com>
References: <20230220091637.64865-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 mm/vmscan.c                    | 30 +++++++++++++++---------------
 5 files changed, 25 insertions(+), 25 deletions(-)

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
index 6a26e8ac40aa..4c3a5d9afb5c 100644
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
index b8da56beba96..f94bfe540675 100644
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
 
 #ifdef CONFIG_MEMCG
@@ -224,7 +224,7 @@ static struct shrinker_info *shrinker_info_protected(struct mem_cgroup *memcg,
 {
 	return srcu_dereference_check(memcg->nodeinfo[nid]->shrinker_info,
 				      &shrinker_srcu,
-				      lockdep_is_held(&shrinker_rwsem));
+				      lockdep_is_held(&shrinker_mutex));
 }
 
 static struct shrinker_info *shrinker_info_srcu(struct mem_cgroup *memcg,
@@ -297,7 +297,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 	int nid, size, ret = 0;
 	int map_size, defer_size = 0;
 
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	map_size = shrinker_map_size(shrinker_nr_max);
 	defer_size = shrinker_defer_size(shrinker_nr_max);
 	size = map_size + defer_size;
@@ -312,7 +312,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 		info->map = (void *)info->nr_deferred + defer_size;
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
 	}
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 
 	return ret;
 }
@@ -337,7 +337,7 @@ static int expand_shrinker_info(int new_id)
 	if (!root_mem_cgroup)
 		goto out;
 
-	lockdep_assert_held(&shrinker_rwsem);
+	lockdep_assert_held(&shrinker_mutex);
 
 	map_size = shrinker_map_size(new_nr_max);
 	defer_size = shrinker_defer_size(new_nr_max);
@@ -384,7 +384,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	if (mem_cgroup_disabled())
 		return -ENOSYS;
 
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -398,7 +398,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	shrinker->id = id;
 	ret = 0;
 unlock:
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 	return ret;
 }
 
@@ -408,7 +408,7 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 
 	BUG_ON(id < 0);
 
-	lockdep_assert_held(&shrinker_rwsem);
+	lockdep_assert_held(&shrinker_mutex);
 
 	idr_remove(&shrinker_idr, id);
 }
@@ -701,9 +701,9 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
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
 
@@ -713,11 +713,11 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 
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
@@ -767,13 +767,13 @@ void unregister_shrinker(struct shrinker *shrinker)
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
 
 	synchronize_srcu(&shrinker_srcu);
 
-- 
2.20.1

