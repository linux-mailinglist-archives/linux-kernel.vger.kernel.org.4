Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38646DC657
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjDJLhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjDJLhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:37:00 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3144C26;
        Mon, 10 Apr 2023 04:36:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pw6Py3HJtz4f3lXZ;
        Mon, 10 Apr 2023 19:36:54 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbDT9DNk0tNvHA--.50875S10;
        Mon, 10 Apr 2023 19:36:55 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     logang@deltatee.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v5 6/6] md: protect md_thread with rcu
Date:   Mon, 10 Apr 2023 19:35:59 +0800
Message-Id: <20230410113559.1610455-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230410113559.1610455-1-yukuai1@huaweicloud.com>
References: <20230410113559.1610455-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbDT9DNk0tNvHA--.50875S10
X-Coremail-Antispam: 1UD129KBjvAXoWfJFWkWrWkWr13KF1xKF1xZrb_yoW8Xr1fXo
        Z3Cw13Zr18GF1rXFyUJrn3tFsxX34DG3yfta15uFs8WFnFv395Zr13XF43JF1jqFnxWr47
        Zr9rXw4IgFW8tw48n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYL7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
        Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
        84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
        WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
        3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
        x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
        JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr4
        1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20E
        Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
        AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZX7UUUUU==
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
be similar problem elsewhere, and use a global lock for all the cases is
not good.

This patch protect md_thread with rcu.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c   | 29 ++++++++++++-----
 drivers/md/md.c          | 68 +++++++++++++++++++---------------------
 drivers/md/md.h          | 10 +++---
 drivers/md/raid1.c       |  4 +--
 drivers/md/raid1.h       |  2 +-
 drivers/md/raid10.c      | 10 ++++--
 drivers/md/raid10.h      |  2 +-
 drivers/md/raid5-cache.c | 15 +++++----
 drivers/md/raid5.c       |  4 +--
 drivers/md/raid5.h       |  2 +-
 10 files changed, 81 insertions(+), 65 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 29fd41ef55a6..b9baeea5605e 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1219,15 +1219,27 @@ static bitmap_counter_t *md_bitmap_get_counter(struct bitmap_counts *bitmap,
 					       int create);
 
 static void mddev_set_timeout(struct mddev *mddev, unsigned long timeout,
-			      bool force)
+			      bool force, bool protected)
 {
-	struct md_thread *thread = mddev->thread;
+	struct md_thread *thread;
+
+	if (!protected) {
+		rcu_read_lock();
+		thread = rcu_dereference(mddev->thread);
+	} else {
+		thread = rcu_dereference_protected(mddev->thread,
+				lockdep_is_held(&mddev->reconfig_mutex));
+	}
 
 	if (!thread)
-		return;
+		goto out;
 
 	if (force || thread->timeout < MAX_SCHEDULE_TIMEOUT)
 		thread->timeout = timeout;
+
+out:
+	if (!protected)
+		rcu_read_unlock();
 }
 
 /*
@@ -1257,7 +1269,7 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 
 	bitmap->daemon_lastrun = jiffies;
 	if (bitmap->allclean) {
-		mddev_set_timeout(mddev, MAX_SCHEDULE_TIMEOUT, true);
+		mddev_set_timeout(mddev, MAX_SCHEDULE_TIMEOUT, true, false);
 		goto done;
 	}
 	bitmap->allclean = 1;
@@ -1354,7 +1366,8 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 
  done:
 	if (bitmap->allclean == 0)
-		mddev_set_timeout(mddev, mddev->bitmap_info.daemon_sleep, true);
+		mddev_set_timeout(mddev, mddev->bitmap_info.daemon_sleep, true,
+				  false);
 	mutex_unlock(&mddev->bitmap_info.mutex);
 }
 
@@ -1807,7 +1820,7 @@ void md_bitmap_destroy(struct mddev *mddev)
 	mddev->bitmap = NULL; /* disconnect from the md device */
 	spin_unlock(&mddev->lock);
 	mutex_unlock(&mddev->bitmap_info.mutex);
-	mddev_set_timeout(mddev, MAX_SCHEDULE_TIMEOUT, true);
+	mddev_set_timeout(mddev, MAX_SCHEDULE_TIMEOUT, true, true);
 
 	md_bitmap_free(bitmap);
 }
@@ -1950,7 +1963,7 @@ int md_bitmap_load(struct mddev *mddev)
 	/* Kick recovery in case any bits were set */
 	set_bit(MD_RECOVERY_NEEDED, &bitmap->mddev->recovery);
 
-	mddev_set_timeout(mddev, mddev->bitmap_info.daemon_sleep, true);
+	mddev_set_timeout(mddev, mddev->bitmap_info.daemon_sleep, true, true);
 	md_wakeup_thread(mddev->thread);
 
 	md_bitmap_update_sb(bitmap);
@@ -2457,7 +2470,7 @@ timeout_store(struct mddev *mddev, const char *buf, size_t len)
 		timeout = 1;
 
 	mddev->bitmap_info.daemon_sleep = timeout;
-	mddev_set_timeout(mddev, timeout, false);
+	mddev_set_timeout(mddev, timeout, false, false);
 	md_wakeup_thread(mddev->thread);
 
 	return len;
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 139c7b0202e3..3afece35f0ee 100644
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
@@ -458,8 +454,10 @@ static void md_submit_bio(struct bio *bio)
  */
 void mddev_suspend(struct mddev *mddev)
 {
-	WARN_ON_ONCE(mddev->thread && current == mddev->thread->tsk);
-	lockdep_assert_held(&mddev->reconfig_mutex);
+	struct md_thread *thread = rcu_dereference_protected(mddev->thread,
+			lockdep_is_held(&mddev->reconfig_mutex));
+
+	WARN_ON_ONCE(thread && current == thread->tsk);
 	if (mddev->suspended++)
 		return;
 	wake_up(&mddev->sb_wait);
@@ -801,13 +799,8 @@ void mddev_unlock(struct mddev *mddev)
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
 
@@ -7891,23 +7884,33 @@ static int md_thread(void *arg)
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
@@ -7931,27 +7934,20 @@ int md_register_thread(struct md_thread **threadp,
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
+	struct md_thread *thread = rcu_dereference_protected(*threadp, true);
 
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
index 7af45b8432e9..621a3f183afd 100644
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
@@ -730,11 +730,11 @@ extern int register_md_cluster_operations(struct md_cluster_operations *ops,
 extern int unregister_md_cluster_operations(void);
 extern int md_setup_cluster(struct mddev *mddev, int nodes);
 extern void md_cluster_stop(struct mddev *mddev);
-extern int md_register_thread(struct md_thread **threadp,
+extern int md_register_thread(struct md_thread __rcu **threadp,
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
index 0171ba4f19b0..8fa4e61c3f79 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -980,6 +980,7 @@ static void lower_barrier(struct r10conf *conf)
 static bool stop_waiting_barrier(struct r10conf *conf)
 {
 	struct bio_list *bio_list = current->bio_list;
+	struct md_thread *thread;
 
 	/* barrier is dropped */
 	if (!conf->barrier)
@@ -995,8 +996,11 @@ static bool stop_waiting_barrier(struct r10conf *conf)
 	    (!bio_list_empty(&bio_list[0]) || !bio_list_empty(&bio_list[1])))
 		return true;
 
+	/* daemon thread must exist while handling io */
+	thread = rcu_dereference_protected(conf->mddev->thread, true);
+
 	/* move on if recovery thread is blocked by us */
-	if (conf->mddev->thread->tsk == current &&
+	if (thread->tsk == current &&
 	    test_bit(MD_RECOVERY_RUNNING, &conf->mddev->recovery) &&
 	    conf->nr_queued > 0)
 		return true;
@@ -4140,8 +4144,8 @@ static int raid10_run(struct mddev *mddev)
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
index 0464d4d551fc..68c4d3a1fd25 100644
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
@@ -1576,17 +1576,18 @@ void r5l_wake_reclaim(struct r5l_log *log, sector_t space)
 
 void r5l_quiesce(struct r5l_log *log, int quiesce)
 {
-	struct mddev *mddev;
+	struct mddev *mddev = log->rdev->mddev;
+	struct md_thread *thread = rcu_dereference_protected(
+		log->reclaim_thread, lockdep_is_held(&mddev->reconfig_mutex));
 
 	if (quiesce) {
 		/* make sure r5l_write_super_and_discard_space exits */
-		mddev = log->rdev->mddev;
 		wake_up(&mddev->sb_wait);
-		kthread_park(log->reclaim_thread->tsk);
+		kthread_park(thread->tsk);
 		r5l_wake_reclaim(log, MaxSector);
 		r5l_do_reclaim(log);
 	} else
-		kthread_unpark(log->reclaim_thread->tsk);
+		kthread_unpark(thread->tsk);
 }
 
 bool r5l_log_disk_error(struct r5conf *conf)
@@ -3124,7 +3125,9 @@ int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev)
 	if (md_register_thread(&log->reclaim_thread, r5l_reclaim_thread,
 			       log->rdev->mddev, "reclaim"))
 		goto reclaim_thread;
-	log->reclaim_thread->timeout = R5C_RECLAIM_WAKEUP_INTERVAL;
+
+	rcu_dereference_protected(log->reclaim_thread, true)->timeout =
+						R5C_RECLAIM_WAKEUP_INTERVAL;
 
 	init_waitqueue_head(&log->iounit_wait);
 
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

