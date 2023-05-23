Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F55470D0F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 04:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjEWCON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 22:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjEWCOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:14:00 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7321BE;
        Mon, 22 May 2023 19:13:38 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QQHt70MXmz4f50nC;
        Tue, 23 May 2023 10:13:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rFMIWxkwVsOKA--.63694S9;
        Tue, 23 May 2023 10:13:36 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     logang@deltatee.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v8 5/5] md: protect md_thread with rcu
Date:   Tue, 23 May 2023 10:10:17 +0800
Message-Id: <20230523021017.3048783-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230523021017.3048783-1-yukuai1@huaweicloud.com>
References: <20230523021017.3048783-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rFMIWxkwVsOKA--.63694S9
X-Coremail-Antispam: 1UD129KBjvAXoW3uryxJw48Gr1kGF1UCw15Arb_yoW8Cw18to
        Z3Cw13Zr18JF1rZFy8tFsxtFZxX34DG3yfta15ZFs8WFn7Zws5Zr13XFW3JF1jqFnxWF4x
        Z34DXw48KFW8Kw48n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYl7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s0DM28Irc
        Ia0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l
        84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJV
        WxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
        3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
        x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
        JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr4
        1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
        67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
        8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently, there are many places that md_thread can be accessed without
protection, following are known scenarios that can cause
null-ptr-dereference or uaf:

1) sync_thread that is allocated and started from md_start_sync()
2) mddev->thread can be accessed directly from timeout_store() and
   md_bitmap_daemon_work()
3) md_unregister_thread() from action_store().

Currently, a global spinlock 'pers_lock' is borrowed to protect
'mddev->thread' in some places, this problem can be fixed likewise,
however, use a global lock for all the cases is not good.

Fix this problem by protecting all md_thread with rcu.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c    | 10 ++++--
 drivers/md/md-cluster.c   | 17 ++++++----
 drivers/md/md-multipath.c |  4 +--
 drivers/md/md.c           | 69 ++++++++++++++++++---------------------
 drivers/md/md.h           |  8 ++---
 drivers/md/raid1.c        |  7 ++--
 drivers/md/raid1.h        |  2 +-
 drivers/md/raid10.c       | 20 +++++++-----
 drivers/md/raid10.h       |  2 +-
 drivers/md/raid5-cache.c  | 22 ++++++++-----
 drivers/md/raid5.c        | 15 +++++----
 drivers/md/raid5.h        |  2 +-
 12 files changed, 97 insertions(+), 81 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 23522df41ca5..ad5a3456cd8a 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1237,13 +1237,19 @@ static bitmap_counter_t *md_bitmap_get_counter(struct bitmap_counts *bitmap,
 static void mddev_set_timeout(struct mddev *mddev, unsigned long timeout,
 			      bool force)
 {
-	struct md_thread *thread = mddev->thread;
+	struct md_thread *thread;
+
+	rcu_read_lock();
+	thread = rcu_dereference(mddev->thread);
 
 	if (!thread)
-		return;
+		goto out;
 
 	if (force || thread->timeout < MAX_SCHEDULE_TIMEOUT)
 		thread->timeout = timeout;
+
+out:
+	rcu_read_unlock();
 }
 
 /*
diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 10e0c5381d01..3d9fd74233df 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -75,14 +75,14 @@ struct md_cluster_info {
 	sector_t suspend_hi;
 	int suspend_from; /* the slot which broadcast suspend_lo/hi */
 
-	struct md_thread *recovery_thread;
+	struct md_thread __rcu *recovery_thread;
 	unsigned long recovery_map;
 	/* communication loc resources */
 	struct dlm_lock_resource *ack_lockres;
 	struct dlm_lock_resource *message_lockres;
 	struct dlm_lock_resource *token_lockres;
 	struct dlm_lock_resource *no_new_dev_lockres;
-	struct md_thread *recv_thread;
+	struct md_thread __rcu *recv_thread;
 	struct completion newdisk_completion;
 	wait_queue_head_t wait;
 	unsigned long state;
@@ -362,8 +362,8 @@ static void __recover_slot(struct mddev *mddev, int slot)
 
 	set_bit(slot, &cinfo->recovery_map);
 	if (!cinfo->recovery_thread) {
-		cinfo->recovery_thread = md_register_thread(recover_bitmaps,
-				mddev, "recover");
+		rcu_assign_pointer(cinfo->recovery_thread,
+			md_register_thread(recover_bitmaps, mddev, "recover"));
 		if (!cinfo->recovery_thread) {
 			pr_warn("md-cluster: Could not create recovery thread\n");
 			return;
@@ -526,11 +526,15 @@ static void process_add_new_disk(struct mddev *mddev, struct cluster_msg *cmsg)
 static void process_metadata_update(struct mddev *mddev, struct cluster_msg *msg)
 {
 	int got_lock = 0;
+	struct md_thread *thread;
 	struct md_cluster_info *cinfo = mddev->cluster_info;
 	mddev->good_device_nr = le32_to_cpu(msg->raid_slot);
 
 	dlm_lock_sync(cinfo->no_new_dev_lockres, DLM_LOCK_CR);
-	wait_event(mddev->thread->wqueue,
+
+	/* daemaon thread must exist */
+	thread = rcu_dereference_protected(mddev->thread, true);
+	wait_event(thread->wqueue,
 		   (got_lock = mddev_trylock(mddev)) ||
 		    test_bit(MD_CLUSTER_HOLDING_MUTEX_FOR_RECVD, &cinfo->state));
 	md_reload_sb(mddev, mddev->good_device_nr);
@@ -889,7 +893,8 @@ static int join(struct mddev *mddev, int nodes)
 	}
 	/* Initiate the communication resources */
 	ret = -ENOMEM;
-	cinfo->recv_thread = md_register_thread(recv_daemon, mddev, "cluster_recv");
+	rcu_assign_pointer(cinfo->recv_thread,
+			md_register_thread(recv_daemon, mddev, "cluster_recv"));
 	if (!cinfo->recv_thread) {
 		pr_err("md-cluster: cannot allocate memory for recv_thread!\n");
 		goto err;
diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
index 66edf5e72bd6..92c45be203d7 100644
--- a/drivers/md/md-multipath.c
+++ b/drivers/md/md-multipath.c
@@ -400,8 +400,8 @@ static int multipath_run (struct mddev *mddev)
 	if (ret)
 		goto out_free_conf;
 
-	mddev->thread = md_register_thread(multipathd, mddev,
-					   "multipath");
+	rcu_assign_pointer(mddev->thread,
+			   md_register_thread(multipathd, mddev, "multipath"));
 	if (!mddev->thread)
 		goto out_free_conf;
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 66a7a17510ce..50da6b671c49 100644
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
 
@@ -92,7 +88,7 @@ static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this);
 static void mddev_detach(struct mddev *mddev);
 static void export_rdev(struct md_rdev *rdev);
-static void md_wakeup_thread_directly(struct md_thread *thread);
+static void md_wakeup_thread_directly(struct md_thread __rcu *thread);
 
 /*
  * Default number of read corrections we'll attempt on an rdev
@@ -442,8 +438,10 @@ static void md_submit_bio(struct bio *bio)
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
@@ -810,13 +808,8 @@ void mddev_unlock(struct mddev *mddev)
 
 	md_free_rdev(mddev);
 
-	/* As we've dropped the mutex we need a spinlock to
-	 * make sure the thread doesn't disappear
-	 */
-	spin_lock(&pers_lock);
 	md_wakeup_thread(mddev->thread);
 	wake_up(&mddev->sb_wait);
-	spin_unlock(&pers_lock);
 }
 EXPORT_SYMBOL_GPL(mddev_unlock);
 
@@ -7897,19 +7890,29 @@ static int md_thread(void *arg)
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
 
@@ -7939,22 +7942,15 @@ struct md_thread *md_register_thread(void (*run) (struct md_thread *),
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
@@ -9220,9 +9216,8 @@ static void md_start_sync(struct work_struct *ws)
 {
 	struct mddev *mddev = container_of(ws, struct mddev, del_work);
 
-	mddev->sync_thread = md_register_thread(md_do_sync,
-						mddev,
-						"resync");
+	rcu_assign_pointer(mddev->sync_thread,
+			   md_register_thread(md_do_sync, mddev, "resync"));
 	if (!mddev->sync_thread) {
 		pr_warn("%s: could not start resync thread...\n",
 			mdname(mddev));
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 4d191db831da..15d82517572e 100644
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
@@ -760,8 +760,8 @@ extern struct md_thread *md_register_thread(
 	void (*run)(struct md_thread *thread),
 	struct mddev *mddev,
 	const char *name);
-extern void md_unregister_thread(struct md_thread **threadp);
-extern void md_wakeup_thread(struct md_thread *thread);
+extern void md_unregister_thread(struct md_thread __rcu **threadp);
+extern void md_wakeup_thread(struct md_thread __rcu *thread);
 extern void md_check_recovery(struct mddev *mddev);
 extern void md_reap_sync_thread(struct mddev *mddev);
 extern int mddev_init_writes_pending(struct mddev *mddev);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 68a9e2d9985b..2f1011ffdf09 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3084,7 +3084,8 @@ static struct r1conf *setup_conf(struct mddev *mddev)
 	}
 
 	err = -ENOMEM;
-	conf->thread = md_register_thread(raid1d, mddev, "raid1");
+	rcu_assign_pointer(conf->thread,
+			   md_register_thread(raid1d, mddev, "raid1"));
 	if (!conf->thread)
 		goto abort;
 
@@ -3177,8 +3178,8 @@ static int raid1_run(struct mddev *mddev)
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
index 4fcfcb350d2b..32fb4ff0acdb 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -982,6 +982,7 @@ static void lower_barrier(struct r10conf *conf)
 static bool stop_waiting_barrier(struct r10conf *conf)
 {
 	struct bio_list *bio_list = current->bio_list;
+	struct md_thread *thread;
 
 	/* barrier is dropped */
 	if (!conf->barrier)
@@ -997,12 +998,14 @@ static bool stop_waiting_barrier(struct r10conf *conf)
 	    (!bio_list_empty(&bio_list[0]) || !bio_list_empty(&bio_list[1])))
 		return true;
 
+	/* daemon thread must exist while handling io */
+	thread = rcu_dereference_protected(conf->mddev->thread, true);
 	/*
 	 * move on if io is issued from raid10d(), nr_pending is not released
 	 * from original io(see handle_read_error()). All raise barrier is
 	 * blocked until this io is done.
 	 */
-	if (conf->mddev->thread->tsk == current) {
+	if (thread->tsk == current) {
 		WARN_ON_ONCE(atomic_read(&conf->nr_pending) == 0);
 		return true;
 	}
@@ -4107,7 +4110,8 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 	atomic_set(&conf->nr_pending, 0);
 
 	err = -ENOMEM;
-	conf->thread = md_register_thread(raid10d, mddev, "raid10");
+	rcu_assign_pointer(conf->thread,
+			   md_register_thread(raid10d, mddev, "raid10"));
 	if (!conf->thread)
 		goto out;
 
@@ -4152,8 +4156,8 @@ static int raid10_run(struct mddev *mddev)
 	if (!conf)
 		goto out;
 
-	mddev->thread = conf->thread;
-	conf->thread = NULL;
+	rcu_assign_pointer(mddev->thread, conf->thread);
+	rcu_assign_pointer(conf->thread, NULL);
 
 	if (mddev_is_clustered(conf->mddev)) {
 		int fc, fo;
@@ -4296,8 +4300,8 @@ static int raid10_run(struct mddev *mddev)
 		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 		set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
 		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
-		mddev->sync_thread = md_register_thread(md_do_sync, mddev,
-							"reshape");
+		rcu_assign_pointer(mddev->sync_thread,
+			md_register_thread(md_do_sync, mddev, "reshape"));
 		if (!mddev->sync_thread)
 			goto out_free_conf;
 	}
@@ -4698,8 +4702,8 @@ static int raid10_start_reshape(struct mddev *mddev)
 	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
 	set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
 
-	mddev->sync_thread = md_register_thread(md_do_sync, mddev,
-						"reshape");
+	rcu_assign_pointer(mddev->sync_thread,
+			   md_register_thread(md_do_sync, mddev, "reshape"));
 	if (!mddev->sync_thread) {
 		ret = -EAGAIN;
 		goto abort;
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
index 46182b955aef..040f5d6e1298 100644
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
@@ -3063,6 +3064,7 @@ void r5c_update_on_rdev_error(struct mddev *mddev, struct md_rdev *rdev)
 int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev)
 {
 	struct r5l_log *log;
+	struct md_thread *thread;
 	int ret;
 
 	pr_debug("md/raid:%s: using device %pg as journal\n",
@@ -3121,11 +3123,13 @@ int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev)
 	spin_lock_init(&log->tree_lock);
 	INIT_RADIX_TREE(&log->big_stripe_tree, GFP_NOWAIT | __GFP_NOWARN);
 
-	log->reclaim_thread = md_register_thread(r5l_reclaim_thread,
-						 log->rdev->mddev, "reclaim");
-	if (!log->reclaim_thread)
+	thread = md_register_thread(r5l_reclaim_thread, log->rdev->mddev,
+				    "reclaim");
+	if (!thread)
 		goto reclaim_thread;
-	log->reclaim_thread->timeout = R5C_RECLAIM_WAKEUP_INTERVAL;
+
+	thread->timeout = R5C_RECLAIM_WAKEUP_INTERVAL;
+	rcu_assign_pointer(log->reclaim_thread, thread);
 
 	init_waitqueue_head(&log->iounit_wait);
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 01c55f24ab09..7e2bbcfef325 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7731,7 +7731,8 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	}
 
 	sprintf(pers_name, "raid%d", mddev->new_level);
-	conf->thread = md_register_thread(raid5d, mddev, pers_name);
+	rcu_assign_pointer(conf->thread,
+			   md_register_thread(raid5d, mddev, pers_name));
 	if (!conf->thread) {
 		pr_warn("md/raid:%s: couldn't allocate thread.\n",
 			mdname(mddev));
@@ -7954,8 +7955,8 @@ static int raid5_run(struct mddev *mddev)
 	}
 
 	conf->min_offset_diff = min_offset_diff;
-	mddev->thread = conf->thread;
-	conf->thread = NULL;
+	rcu_assign_pointer(mddev->thread, conf->thread);
+	rcu_assign_pointer(conf->thread, NULL);
 	mddev->private = conf;
 
 	for (i = 0; i < conf->raid_disks && conf->previous_raid_disks;
@@ -8052,8 +8053,8 @@ static int raid5_run(struct mddev *mddev)
 		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 		set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
 		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
-		mddev->sync_thread = md_register_thread(md_do_sync, mddev,
-							"reshape");
+		rcu_assign_pointer(mddev->sync_thread,
+			md_register_thread(md_do_sync, mddev, "reshape"));
 		if (!mddev->sync_thread)
 			goto abort;
 	}
@@ -8631,8 +8632,8 @@ static int raid5_start_reshape(struct mddev *mddev)
 	clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
 	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
 	set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
-	mddev->sync_thread = md_register_thread(md_do_sync, mddev,
-						"reshape");
+	rcu_assign_pointer(mddev->sync_thread,
+			   md_register_thread(md_do_sync, mddev, "reshape"));
 	if (!mddev->sync_thread) {
 		mddev->recovery = 0;
 		spin_lock_irq(&conf->device_lock);
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

