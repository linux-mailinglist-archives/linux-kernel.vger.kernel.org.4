Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C806F1225
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 09:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345446AbjD1HND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 03:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjD1HNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 03:13:00 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D154312F;
        Fri, 28 Apr 2023 00:12:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q73j163QTz4f3kpB;
        Fri, 28 Apr 2023 15:12:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbHzcUtkB+tAIQ--.17791S4;
        Fri, 28 Apr 2023 15:12:52 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, neilb@suse.de, akpm@linux-foundation.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next] md: fix duplicate filename for rdev
Date:   Fri, 28 Apr 2023 15:10:59 +0800
Message-Id: <20230428071059.1988153-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbHzcUtkB+tAIQ--.17791S4
X-Coremail-Antispam: 1UD129KBjvJXoWxKrW7Cry8JrW7Kw1kXw18Xwb_yoWfCr13p3
        ySqa45GrWUJrW3Wa1UAws7u3WYgrn7KFZrtryfu3WSywnxGrnrG3WFqFy5XFyrCrZ5Zrn8
        Za18WF45Zay8GF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
        7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
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

commit 5792a2856a63 ("[PATCH] md: avoid a deadlock when removing a device
from an md array via sysfs") delay the deleting of rdev, however, this
introduce a window that rdev can be added again while the deleting is
not done yet, and sysfs will complain about duplicate filename.

Follow up patches try to fix this problem by flush workqueue, however,
flush_rdev_wq() is just dead code, the progress in
md_kick_rdev_from_array():

1) list_del_rcu(&rdev->same_set);
2) synchronize_rcu();
3) queue_work(md_rdev_misc_wq, &rdev->del_work);

So in flush_rdev_wq(), if rdev is found in the list, work_pending() can
never pass, in the meantime, if work is queued, then rdev can never be
found in the list.

flush_rdev_wq() can be replaced by flush_workqueue() directly, however,
this approach is not good:
- the workqueue is global, this synchronization for all raid disks is
  not necessary.
- flush_workqueue can't be called under 'reconfig_mutex', there is still
  a small window between flush_workqueue() and mddev_lock() that other
  context can queue new work, hence the problem is not solved completely.

sysfs already have apis to support delete itself through writer, and
these apis, specifically sysfs_break/unbreak_active_protection(), is used
so support deleting rdev synchronously. Therefore, the above commit can be
reverted, and sysfs duplicate filename can be avoided.

A new mdadm regression test [1] is proposed as well.

Link: https://lore.kernel.org/linux-raid/20230428062845.1975462-1-yukuai1@huaweicloud.com/
Fixes: 5792a2856a63 ("[PATCH] md: avoid a deadlock when removing a device from an md array via sysfs")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 85 +++++++++++++++++++++++++------------------------
 drivers/md/md.h |  8 +++++
 2 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0a4a10d4c0e0..e1bc223d58b3 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -83,12 +83,12 @@ static struct module *md_cluster_mod;
 static DECLARE_WAIT_QUEUE_HEAD(resync_wait);
 static struct workqueue_struct *md_wq;
 static struct workqueue_struct *md_misc_wq;
-static struct workqueue_struct *md_rdev_misc_wq;
 
 static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this);
 static void mddev_detach(struct mddev *mddev);
 static void md_wakeup_thread_directly(struct md_thread __rcu *thread);
+static void export_rdev(struct md_rdev *rdev);
 
 enum md_ro_state {
 	MD_RDWR,
@@ -674,9 +674,11 @@ void mddev_init(struct mddev *mddev)
 {
 	mutex_init(&mddev->open_mutex);
 	mutex_init(&mddev->reconfig_mutex);
+	mutex_init(&mddev->delete_mutex);
 	mutex_init(&mddev->bitmap_info.mutex);
 	INIT_LIST_HEAD(&mddev->disks);
 	INIT_LIST_HEAD(&mddev->all_mddevs);
+	INIT_LIST_HEAD(&mddev->deleting);
 	timer_setup(&mddev->safemode_timer, md_safemode_timeout, 0);
 	atomic_set(&mddev->active, 1);
 	atomic_set(&mddev->openers, 0);
@@ -778,6 +780,23 @@ static void mddev_free(struct mddev *mddev)
 
 static const struct attribute_group md_redundancy_group;
 
+static void md_free_rdev(struct mddev *mddev)
+{
+	struct md_rdev *rdev;
+	struct md_rdev *tmp;
+
+	if (list_empty_careful(&mddev->deleting))
+		return;
+
+	mutex_lock(&mddev->delete_mutex);
+	list_for_each_entry_safe(rdev, tmp, &mddev->deleting, same_set) {
+		list_del_init(&rdev->same_set);
+		kobject_del(&rdev->kobj);
+		export_rdev(rdev);
+	}
+	mutex_unlock(&mddev->delete_mutex);
+}
+
 void mddev_unlock(struct mddev *mddev)
 {
 	if (mddev->to_remove) {
@@ -819,6 +838,8 @@ void mddev_unlock(struct mddev *mddev)
 	} else
 		mutex_unlock(&mddev->reconfig_mutex);
 
+	md_free_rdev(mddev);
+
 	md_wakeup_thread(mddev->thread);
 	wake_up(&mddev->sb_wait);
 }
@@ -2454,13 +2475,6 @@ static int bind_rdev_to_array(struct md_rdev *rdev, struct mddev *mddev)
 	return err;
 }
 
-static void rdev_delayed_delete(struct work_struct *ws)
-{
-	struct md_rdev *rdev = container_of(ws, struct md_rdev, del_work);
-	kobject_del(&rdev->kobj);
-	kobject_put(&rdev->kobj);
-}
-
 void md_autodetect_dev(dev_t dev);
 
 static void export_rdev(struct md_rdev *rdev)
@@ -2478,6 +2492,8 @@ static void export_rdev(struct md_rdev *rdev)
 
 static void md_kick_rdev_from_array(struct md_rdev *rdev)
 {
+	struct mddev *mddev = rdev->mddev;
+
 	bd_unlink_disk_holder(rdev->bdev, rdev->mddev->gendisk);
 	list_del_rcu(&rdev->same_set);
 	pr_debug("md: unbind<%pg>\n", rdev->bdev);
@@ -2491,15 +2507,17 @@ static void md_kick_rdev_from_array(struct md_rdev *rdev)
 	rdev->sysfs_unack_badblocks = NULL;
 	rdev->sysfs_badblocks = NULL;
 	rdev->badblocks.count = 0;
-	/* We need to delay this, otherwise we can deadlock when
-	 * writing to 'remove' to "dev/state".  We also need
-	 * to delay it due to rcu usage.
-	 */
+
 	synchronize_rcu();
-	INIT_WORK(&rdev->del_work, rdev_delayed_delete);
-	kobject_get(&rdev->kobj);
-	queue_work(md_rdev_misc_wq, &rdev->del_work);
-	export_rdev(rdev);
+
+	/*
+	 * kobject_del() will wait for all in progress writers to be done, where
+	 * reconfig_mutex is held, hence it can't be called under
+	 * reconfig_mutex and it's delayed to mddev_unlock().
+	 */
+	mutex_lock(&mddev->delete_mutex);
+	list_add(&rdev->same_set, &mddev->deleting);
+	mutex_unlock(&mddev->delete_mutex);
 }
 
 static void export_array(struct mddev *mddev)
@@ -3564,6 +3582,7 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
 {
 	struct rdev_sysfs_entry *entry = container_of(attr, struct rdev_sysfs_entry, attr);
 	struct md_rdev *rdev = container_of(kobj, struct md_rdev, kobj);
+	struct kernfs_node *kn = NULL;
 	ssize_t rv;
 	struct mddev *mddev = rdev->mddev;
 
@@ -3571,6 +3590,10 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
 		return -EIO;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
+
+	if (entry->store == state_store && cmd_match(page, "remove"))
+		kn = sysfs_break_active_protection(kobj, attr);
+
 	rv = mddev ? mddev_lock(mddev) : -ENODEV;
 	if (!rv) {
 		if (rdev->mddev == NULL)
@@ -3579,6 +3602,10 @@ rdev_attr_store(struct kobject *kobj, struct attribute *attr,
 			rv = entry->store(rdev, page, length);
 		mddev_unlock(mddev);
 	}
+
+	if (kn)
+		sysfs_unbreak_active_protection(kn);
+
 	return rv;
 }
 
@@ -4502,20 +4529,6 @@ null_show(struct mddev *mddev, char *page)
 	return -EINVAL;
 }
 
-/* need to ensure rdev_delayed_delete() has completed */
-static void flush_rdev_wq(struct mddev *mddev)
-{
-	struct md_rdev *rdev;
-
-	rcu_read_lock();
-	rdev_for_each_rcu(rdev, mddev)
-		if (work_pending(&rdev->del_work)) {
-			flush_workqueue(md_rdev_misc_wq);
-			break;
-		}
-	rcu_read_unlock();
-}
-
 static ssize_t
 new_dev_store(struct mddev *mddev, const char *buf, size_t len)
 {
@@ -4543,7 +4556,6 @@ new_dev_store(struct mddev *mddev, const char *buf, size_t len)
 	    minor != MINOR(dev))
 		return -EOVERFLOW;
 
-	flush_rdev_wq(mddev);
 	err = mddev_lock(mddev);
 	if (err)
 		return err;
@@ -5603,7 +5615,6 @@ struct mddev *md_alloc(dev_t dev, char *name)
 	 * removed (mddev_delayed_delete).
 	 */
 	flush_workqueue(md_misc_wq);
-	flush_workqueue(md_rdev_misc_wq);
 
 	mutex_lock(&disks_mutex);
 	mddev = mddev_alloc(dev);
@@ -7569,9 +7580,6 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 
 	}
 
-	if (cmd == ADD_NEW_DISK || cmd == HOT_ADD_DISK)
-		flush_rdev_wq(mddev);
-
 	if (cmd == HOT_REMOVE_DISK)
 		/* need to ensure recovery thread has run */
 		wait_event_interruptible_timeout(mddev->sb_wait,
@@ -9645,10 +9653,6 @@ static int __init md_init(void)
 	if (!md_misc_wq)
 		goto err_misc_wq;
 
-	md_rdev_misc_wq = alloc_workqueue("md_rdev_misc", 0, 0);
-	if (!md_rdev_misc_wq)
-		goto err_rdev_misc_wq;
-
 	ret = __register_blkdev(MD_MAJOR, "md", md_probe);
 	if (ret < 0)
 		goto err_md;
@@ -9667,8 +9671,6 @@ static int __init md_init(void)
 err_mdp:
 	unregister_blkdev(MD_MAJOR, "md");
 err_md:
-	destroy_workqueue(md_rdev_misc_wq);
-err_rdev_misc_wq:
 	destroy_workqueue(md_misc_wq);
 err_misc_wq:
 	destroy_workqueue(md_wq);
@@ -9964,7 +9966,6 @@ static __exit void md_exit(void)
 	}
 	spin_unlock(&all_mddevs_lock);
 
-	destroy_workqueue(md_rdev_misc_wq);
 	destroy_workqueue(md_misc_wq);
 	destroy_workqueue(md_wq);
 }
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 6fa71d90fb4d..a228e78e7f3a 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -531,6 +531,14 @@ struct mddev {
 	unsigned int			good_device_nr;	/* good device num within cluster raid */
 	unsigned int			noio_flag; /* for memalloc scope API */
 
+	/*
+	 * Temporarily store rdev that will be finally removed when
+	 * reconfig_mutex is unlocked.
+	 */
+	struct list_head		deleting;
+	/* Protect the deleting list */
+	struct mutex			delete_mutex;
+
 	bool	has_superblocks:1;
 	bool	fail_last_dev:1;
 	bool	serialize_policy:1;
-- 
2.39.2

