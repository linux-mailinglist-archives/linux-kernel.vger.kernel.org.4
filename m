Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4586D3676
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjDBJN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjDBJNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:13:11 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBE2CDE2;
        Sun,  2 Apr 2023 02:13:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pq7bh1mxDz4f3lY3;
        Sun,  2 Apr 2023 17:13:04 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7MeRylkVUE8Gg--.50168S9;
        Sun, 02 Apr 2023 17:13:05 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     logang@deltatee.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v4 5/5] md: protect md_thread with rcu
Date:   Sun,  2 Apr 2023 17:12:36 +0800
Message-Id: <20230402091236.976723-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230402091236.976723-1-yukuai1@huaweicloud.com>
References: <20230402091236.976723-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7MeRylkVUE8Gg--.50168S9
X-Coremail-Antispam: 1UD129KBjvJXoWfJFWkWrWkXw13Zr18GrW3ZFb_yoWkZFW7p3
        yxta43Ar4UArW5Zr1UAa4DCa4Yqw10qFWqyryfCw1rA3ZFg3y3JFy5GFyUZwn8AF15GFya
        q3W5KFZ8ur4DKF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9G14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
        W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZX7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Our test reports a uaf for 'mddev->sync_thread':

T1                      T2
md_start_sync
 md_register_thread
 // mddev->sync_thread is set
			raid1d
			 md_check_recovery
			  md_reap_sync_thread
			   md_unregister_thread
			    kfree

 md_wakeup_thread
  wake_up
  ->sync_thread was freed

Root cause is that there is a small windown between register thread and
wake up thread, where the thread can be freed concurrently.

Currently, a global spinlock 'pers_lock' is borrowed to protect
'mddev->thread', this problem can be fixed likewise, however, there might
be similar problem for other md_thread, and I really don't like the idea to
borrow a global lock.

This patch protect md_thread with rcu.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c   | 21 ++++++++++----
 drivers/md/md.c          | 62 ++++++++++++++++++----------------------
 drivers/md/md.h          | 14 ++++-----
 drivers/md/raid1.c       |  4 +--
 drivers/md/raid1.h       |  2 +-
 drivers/md/raid10.c      |  4 +--
 drivers/md/raid10.h      |  2 +-
 drivers/md/raid5-cache.c |  2 +-
 drivers/md/raid5.c       |  4 +--
 drivers/md/raid5.h       |  2 +-
 10 files changed, 61 insertions(+), 56 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index f670c72d97be..dc2ea2ce0ae9 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1784,6 +1784,7 @@ void md_bitmap_wait_behind_writes(struct mddev *mddev)
 void md_bitmap_destroy(struct mddev *mddev)
 {
 	struct bitmap *bitmap = mddev->bitmap;
+	struct md_thread *thread;
 
 	if (!bitmap) /* there was no bitmap */
 		return;
@@ -1797,8 +1798,12 @@ void md_bitmap_destroy(struct mddev *mddev)
 	mddev->bitmap = NULL; /* disconnect from the md device */
 	spin_unlock(&mddev->lock);
 	mutex_unlock(&mddev->bitmap_info.mutex);
-	if (mddev->thread)
-		mddev->thread->timeout = MAX_SCHEDULE_TIMEOUT;
+
+	rcu_read_lock();
+	thread = rcu_dereference(mddev->thread);
+	if (thread)
+		thread->timeout = MAX_SCHEDULE_TIMEOUT;
+	rcu_read_unlock();
 
 	md_bitmap_free(bitmap);
 }
@@ -2433,6 +2438,7 @@ timeout_store(struct mddev *mddev, const char *buf, size_t len)
 {
 	/* timeout can be set at any time */
 	unsigned long timeout;
+	struct md_thread *thread;
 	int rv = strict_strtoul_scaled(buf, &timeout, 4);
 	if (rv)
 		return rv;
@@ -2448,16 +2454,21 @@ timeout_store(struct mddev *mddev, const char *buf, size_t len)
 	if (timeout < 1)
 		timeout = 1;
 	mddev->bitmap_info.daemon_sleep = timeout;
-	if (mddev->thread) {
+
+	rcu_read_lock();
+	thread = rcu_dereference(mddev->thread);
+	if (thread) {
 		/* if thread->timeout is MAX_SCHEDULE_TIMEOUT, then
 		 * the bitmap is all clean and we don't need to
 		 * adjust the timeout right now
 		 */
-		if (mddev->thread->timeout < MAX_SCHEDULE_TIMEOUT) {
-			mddev->thread->timeout = timeout;
+		if (thread->timeout < MAX_SCHEDULE_TIMEOUT) {
+			thread->timeout = timeout;
 			md_wakeup_thread(mddev->thread);
 		}
 	}
+	rcu_read_unlock();
+
 	return len;
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index d5a29ccb24ec..5609b7e3abab 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -70,11 +70,7 @@
 #include "md-bitmap.h"
 #include "md-cluster.h"
 
-/* pers_list is a list of registered personalities protected
- * by pers_lock.
- * pers_lock does extra service to protect accesses to
- * mddev->thread when the mutex cannot be held.
- */
+/* pers_list is a list of registered personalities protected by pers_lock. */
 static LIST_HEAD(pers_list);
 static DEFINE_SPINLOCK(pers_lock);
 
@@ -92,7 +88,7 @@ static struct workqueue_struct *md_rdev_misc_wq;
 static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this);
 static void mddev_detach(struct mddev *mddev);
-static void md_wakeup_thread_directly(struct md_thread *thread);
+static void md_wakeup_thread_directly(struct md_thread __rcu *thread);
 
 enum md_ro_state {
 	MD_RDWR,
@@ -803,13 +799,8 @@ void mddev_unlock(struct mddev *mddev)
 	} else
 		mutex_unlock(&mddev->reconfig_mutex);
 
-	/* As we've dropped the mutex we need a spinlock to
-	 * make sure the thread doesn't disappear
-	 */
-	spin_lock(&pers_lock);
 	md_wakeup_thread(mddev->thread);
 	wake_up(&mddev->sb_wait);
-	spin_unlock(&pers_lock);
 }
 EXPORT_SYMBOL_GPL(mddev_unlock);
 
@@ -7893,23 +7884,33 @@ static int md_thread(void *arg)
 	return 0;
 }
 
-static void md_wakeup_thread_directly(struct md_thread *thread)
+static void md_wakeup_thread_directly(struct md_thread __rcu *thread)
 {
-	if (thread)
-		wake_up_process(thread->tsk);
+	struct md_thread *t;
+
+	rcu_read_lock();
+	t = rcu_dereference(thread);
+	if (t)
+		wake_up_process(t->tsk);
+	rcu_read_unlock();
 }
 
-void md_wakeup_thread(struct md_thread *thread)
+void md_wakeup_thread(struct md_thread __rcu *thread)
 {
-	if (thread) {
-		pr_debug("md: waking up MD thread %s.\n", thread->tsk->comm);
-		set_bit(THREAD_WAKEUP, &thread->flags);
-		wake_up(&thread->wqueue);
+	struct md_thread *t;
+
+	rcu_read_lock();
+	t = rcu_dereference(thread);
+	if (t) {
+		pr_debug("md: waking up MD thread %s.\n", t->tsk->comm);
+		set_bit(THREAD_WAKEUP, &t->flags);
+		wake_up(&t->wqueue);
 	}
+	rcu_read_unlock();
 }
 EXPORT_SYMBOL(md_wakeup_thread);
 
-int md_register_thread(struct md_thread **threadp,
+int md_register_thread(struct md_thread __rcu **threadp,
 		       void (*run)(struct md_thread *),
 		       struct mddev *mddev, const char *name)
 {
@@ -7933,27 +7934,20 @@ int md_register_thread(struct md_thread **threadp,
 		return err;
 	}
 
-	*threadp = thread;
+	rcu_assign_pointer(*threadp, thread);
 	return 0;
 }
 EXPORT_SYMBOL(md_register_thread);
 
-void md_unregister_thread(struct md_thread **threadp)
+void md_unregister_thread(struct md_thread __rcu **threadp)
 {
-	struct md_thread *thread;
+	struct md_thread *thread = rcu_access_pointer(*threadp);
 
-	/*
-	 * Locking ensures that mddev_unlock does not wake_up a
-	 * non-existent thread
-	 */
-	spin_lock(&pers_lock);
-	thread = *threadp;
-	if (!thread) {
-		spin_unlock(&pers_lock);
+	if (!thread)
 		return;
-	}
-	*threadp = NULL;
-	spin_unlock(&pers_lock);
+
+	rcu_assign_pointer(*threadp, NULL);
+	synchronize_rcu();
 
 	pr_debug("interrupting MD-thread pid %d\n", task_pid_nr(thread->tsk));
 	kthread_stop(thread->tsk);
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 5acdd704a922..0525f6d66a4d 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -367,8 +367,8 @@ struct mddev {
 	int				new_chunk_sectors;
 	int				reshape_backwards;
 
-	struct md_thread		*thread;	/* management thread */
-	struct md_thread		*sync_thread;	/* doing resync or reconstruct */
+	struct md_thread __rcu		*thread;	/* management thread */
+	struct md_thread __rcu		*sync_thread;	/* doing resync or reconstruct */
 
 	/* 'last_sync_action' is initialized to "none".  It is set when a
 	 * sync operation (i.e "data-check", "requested-resync", "resync",
@@ -719,9 +719,9 @@ struct md_io_acct {
 #define THREAD_WAKEUP  0
 
 /* caller need to make sured returned md_thread won't be freed */
-static inline struct md_thread *get_md_thread(struct md_thread *t)
+static inline struct md_thread *get_md_thread(struct md_thread __rcu *t)
 {
-	return t;
+	return rcu_access_pointer(t);
 }
 
 static inline void safe_put_page(struct page *p)
@@ -736,11 +736,11 @@ extern int register_md_cluster_operations(struct md_cluster_operations *ops,
 extern int unregister_md_cluster_operations(void);
 extern int md_setup_cluster(struct mddev *mddev, int nodes);
 extern void md_cluster_stop(struct mddev *mddev);
-int md_register_thread(struct md_thread **threadp,
+int md_register_thread(struct md_thread __rcu **threadp,
 		       void (*run)(struct md_thread *thread),
 		       struct mddev *mddev, const char *name);
-extern void md_unregister_thread(struct md_thread **threadp);
-extern void md_wakeup_thread(struct md_thread *thread);
+extern void md_unregister_thread(struct md_thread __rcu **threadp);
+extern void md_wakeup_thread(struct md_thread __rcu *thread);
 extern void md_check_recovery(struct mddev *mddev);
 extern void md_reap_sync_thread(struct mddev *mddev);
 extern int mddev_init_writes_pending(struct mddev *mddev);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 1217c1db0a40..64f019e3615f 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3176,8 +3176,8 @@ static int raid1_run(struct mddev *mddev)
 	/*
 	 * Ok, everything is just fine now
 	 */
-	mddev->thread = conf->thread;
-	conf->thread = NULL;
+	rcu_assign_pointer(mddev->thread, conf->thread);
+	rcu_assign_pointer(conf->thread, NULL);
 	mddev->private = conf;
 	set_bit(MD_FAILFAST_SUPPORTED, &mddev->flags);
 
diff --git a/drivers/md/raid1.h b/drivers/md/raid1.h
index ebb6788820e7..468f189da7a0 100644
--- a/drivers/md/raid1.h
+++ b/drivers/md/raid1.h
@@ -130,7 +130,7 @@ struct r1conf {
 	/* When taking over an array from a different personality, we store
 	 * the new thread here until we fully activate the array.
 	 */
-	struct md_thread	*thread;
+	struct md_thread __rcu	*thread;
 
 	/* Keep track of cluster resync window to send to other
 	 * nodes.
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index fc8d07fb1c7d..5509955b79ec 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4140,8 +4140,8 @@ static int raid10_run(struct mddev *mddev)
 		}
 	}
 
-	mddev->thread = conf->thread;
-	conf->thread = NULL;
+	rcu_assign_pointer(mddev->thread, conf->thread);
+	rcu_assign_pointer(conf->thread, NULL);
 
 	if (mddev->queue) {
 		blk_queue_max_write_zeroes_sectors(mddev->queue, 0);
diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index 8c072ce0bc54..63e48b11b552 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -100,7 +100,7 @@ struct r10conf {
 	/* When taking over an array from a different personality, we store
 	 * the new thread here until we fully activate the array.
 	 */
-	struct md_thread	*thread;
+	struct md_thread __rcu	*thread;
 
 	/*
 	 * Keep track of cluster resync window to send to other nodes.
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 7e45df3e093f..b677441d8889 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -120,7 +120,7 @@ struct r5l_log {
 	struct bio_set bs;
 	mempool_t meta_pool;
 
-	struct md_thread *reclaim_thread;
+	struct md_thread __rcu *reclaim_thread;
 	unsigned long reclaim_target;	/* number of space that need to be
 					 * reclaimed.  if it's 0, reclaim spaces
 					 * used by io_units which are in
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 04b1093195d0..a7e47c37daf3 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7888,8 +7888,8 @@ static int raid5_run(struct mddev *mddev)
 	}
 
 	conf->min_offset_diff = min_offset_diff;
-	mddev->thread = conf->thread;
-	conf->thread = NULL;
+	rcu_assign_pointer(mddev->thread, conf->thread);
+	rcu_assign_pointer(conf->thread, NULL);
 	mddev->private = conf;
 
 	for (i = 0; i < conf->raid_disks && conf->previous_raid_disks;
diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
index e873938a6125..f19707189a7b 100644
--- a/drivers/md/raid5.h
+++ b/drivers/md/raid5.h
@@ -679,7 +679,7 @@ struct r5conf {
 	/* When taking over an array from a different personality, we store
 	 * the new thread here until we fully activate the array.
 	 */
-	struct md_thread	*thread;
+	struct md_thread __rcu	*thread;
 	struct list_head	temp_inactive_list[NR_STRIPE_HASH_LOCKS];
 	struct r5worker_group	*worker_groups;
 	int			group_cnt;
-- 
2.39.2

