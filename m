Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81A16A0A85
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbjBWN3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjBWN2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:28:55 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39E6580E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:28:33 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id s17so5734044pgv.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1677158912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPT0nfWhMLdXxcydHyGYHy0yeE/SVJFKwHgDhpkqgDM=;
        b=F520qmCvl0UEhHNkuOAEZmp1N3sJcaWVf0fYb3nWYbFg7xaH1VreJ8NIxoJDOHmFWr
         fELDUoigMokRIqsdrxc8qGRde4TK1nfn/8m7o3tkhJa2mENEjDgadGrxnY5rqaQzkamU
         /RQ3vIZgVEe9OraPz+1/MMz1EuxiVvI+ZzojzqD2odCLdWNcrBtEzqVENWF6dvVswnZp
         a5ziG4nnVMEgF32yQD6np3wXBRQz+Q5XT41L4iM1wqrQtqSrf4Zc9extvwH12AOU6F09
         0I920tJGW3EBzguj8MSWNnfH8JyQvo7rAULuvJmoQCsifU2+4i+3CRIKl8d3zaj+Lf9T
         fE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677158912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPT0nfWhMLdXxcydHyGYHy0yeE/SVJFKwHgDhpkqgDM=;
        b=OSwzX/hIORNmafzfslC01cVAXvUQXQ55+vTzvyBeHgTC/w9acJm6c/47iKxnSEJSA9
         g7VKlU+6FtiXhvAm/eAnqxz76v9/Xz/VLf9SRAeoergjDC3RMRbORH/6V3aDc6m8RMlq
         Unmhe1Y5Gi0t6uo5uiz+YRN94KSJZZ7+Lay/Tn9XR+XI/OlK3LoKO5OlAN9chFOaM9Mo
         1enoVFKyale2oSqLwr793j4RDVyHn+Zhf9O4wvayt1HvL41EHQIdce/PBrqG4uYK8ti0
         28zFVXWlQj38k5JDFQkkSyxFYz3mQYi9jew8hnFDk7EQrr9WkJBqWl6D9rjxxzCuEl9Q
         z1rg==
X-Gm-Message-State: AO0yUKXM5Zr0OsfzOV6clZ1Wl+eedJMtA4hLuN+GYwH2jKGM8vSzvoOk
        4n2qD58KXNa8GmhJ/0u6wyo77A==
X-Google-Smtp-Source: AK7set/SbEDbsO6C9L1y9CGpBIcDIvy9sr0sucapoT0kr6uR9zXluUZnIOxXK5HS7OjmFknadGlwnA==
X-Received: by 2002:a05:6a00:4006:b0:5d9:f3a6:ef8e with SMTP id by6-20020a056a00400600b005d9f3a6ef8emr3764664pfb.2.1677158912664;
        Thu, 23 Feb 2023 05:28:32 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78752000000b005a9bf65b591sm3848591pfo.135.2023.02.23.05.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 05:28:32 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tkhai@ya.ru, hannes@cmpxchg.org,
        shakeelb@google.com, mhocko@kernel.org, roman.gushchin@linux.dev,
        muchun.song@linux.dev, david@redhat.com, shy828301@gmail.com
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 7/7] mm: shrinkers: convert shrinker_rwsem to mutex
Date:   Thu, 23 Feb 2023 21:27:25 +0800
Message-Id: <20230223132725.11685-8-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
References: <20230223132725.11685-1-zhengqi.arch@bytedance.com>
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
index d1a95d60d127..27ef9946ae8a 100644
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
@@ -308,7 +308,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 	int nid, size, ret = 0;
 	int map_size, defer_size = 0;
 
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	map_size = shrinker_map_size(shrinker_nr_max);
 	defer_size = shrinker_defer_size(shrinker_nr_max);
 	size = map_size + defer_size;
@@ -324,7 +324,7 @@ int alloc_shrinker_info(struct mem_cgroup *memcg)
 		info->map_nr_max = shrinker_nr_max;
 		rcu_assign_pointer(memcg->nodeinfo[nid]->shrinker_info, info);
 	}
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 
 	return ret;
 }
@@ -343,7 +343,7 @@ static int expand_shrinker_info(int new_id)
 	if (!root_mem_cgroup)
 		goto out;
 
-	lockdep_assert_held(&shrinker_rwsem);
+	lockdep_assert_held(&shrinker_mutex);
 
 	map_size = shrinker_map_size(new_nr_max);
 	defer_size = shrinker_defer_size(new_nr_max);
@@ -391,7 +391,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	if (mem_cgroup_disabled())
 		return -ENOSYS;
 
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	id = idr_alloc(&shrinker_idr, shrinker, 0, 0, GFP_KERNEL);
 	if (id < 0)
 		goto unlock;
@@ -405,7 +405,7 @@ static int prealloc_memcg_shrinker(struct shrinker *shrinker)
 	shrinker->id = id;
 	ret = 0;
 unlock:
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 	return ret;
 }
 
@@ -415,7 +415,7 @@ static void unregister_memcg_shrinker(struct shrinker *shrinker)
 
 	BUG_ON(id < 0);
 
-	lockdep_assert_held(&shrinker_rwsem);
+	lockdep_assert_held(&shrinker_mutex);
 
 	idr_remove(&shrinker_idr, id);
 }
@@ -450,7 +450,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 		parent = root_mem_cgroup;
 
 	/* Prevent from concurrent shrinker_info expand */
-	down_write(&shrinker_rwsem);
+	mutex_lock(&shrinker_mutex);
 	for_each_node(nid) {
 		child_info = shrinker_info_protected(memcg, nid);
 		parent_info = shrinker_info_protected(parent, nid);
@@ -459,7 +459,7 @@ void reparent_shrinker_deferred(struct mem_cgroup *memcg)
 			atomic_long_add(nr, &parent_info->nr_deferred[i]);
 		}
 	}
-	up_write(&shrinker_rwsem);
+	mutex_unlock(&shrinker_mutex);
 }
 
 static bool cgroup_reclaim(struct scan_control *sc)
@@ -708,9 +708,9 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
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
 
@@ -720,11 +720,11 @@ void free_prealloced_shrinker(struct shrinker *shrinker)
 
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
@@ -774,13 +774,13 @@ void unregister_shrinker(struct shrinker *shrinker)
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

