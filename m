Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E336D048B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjC3MVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjC3MVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:21:31 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF36E7AB5;
        Thu, 30 Mar 2023 05:21:27 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PnMwM3Nwdz4f3kKj;
        Thu, 30 Mar 2023 20:21:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLC5fiVkFoZ2GQ--.46838S6;
        Thu, 30 Mar 2023 20:21:25 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     logang@deltatee.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v3 2/3] md: pass a md_thread pointer to md_wakeup_thread()
Date:   Fri, 31 Mar 2023 04:20:45 +0800
Message-Id: <20230330202046.795213-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230330202046.795213-1-yukuai1@huaweicloud.com>
References: <20230330202046.795213-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLC5fiVkFoZ2GQ--.46838S6
X-Coremail-Antispam: 1UD129KBjvAXoWfZrWfZw4DJF1xWFyDAr45GFg_yoW5CFy5uo
        Z5Cr1aq3W8Xa4FvFyFywnxtFZ8XryUJ34Syw1rZFWkWFnruws5W343Zay3Jrn5t3ZxWF18
        XrnrWF4fGF4fK3yxn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUOe7kC6x804xWl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8Xw
        A2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26r4j6ryUM28lY4IE
        w2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84
        ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0D
        M28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc
        02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
        wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4
        CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
        0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
        v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x
        0piHmhUUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.4 required=5.0 tests=DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Pprepare to protect md_thread with rcu, there are no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-raid.c      |  4 +--
 drivers/md/md-bitmap.c    |  6 ++--
 drivers/md/md-cluster.c   | 20 +++++------
 drivers/md/md-multipath.c |  2 +-
 drivers/md/md.c           | 74 ++++++++++++++++++++-------------------
 drivers/md/md.h           |  4 +--
 drivers/md/raid1.c        | 10 +++---
 drivers/md/raid10.c       | 14 ++++----
 drivers/md/raid5-cache.c  | 12 +++----
 drivers/md/raid5-ppl.c    |  2 +-
 drivers/md/raid5.c        | 30 ++++++++--------
 11 files changed, 90 insertions(+), 88 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 0601edbf579f..2ab83836cb30 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3754,11 +3754,11 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 		 */
 		mddev->ro = 0;
 		if (!mddev->suspended && mddev->sync_thread)
-			md_wakeup_thread(mddev->sync_thread);
+			md_wakeup_thread(&mddev->sync_thread);
 	}
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	if (!mddev->suspended && mddev->thread)
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 
 	return 0;
 }
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index e7cc6ba1b657..14e890e35bbb 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1942,7 +1942,7 @@ int md_bitmap_load(struct mddev *mddev)
 	set_bit(MD_RECOVERY_NEEDED, &bitmap->mddev->recovery);
 
 	mddev->thread->timeout = mddev->bitmap_info.daemon_sleep;
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread);
 
 	md_bitmap_update_sb(bitmap);
 
@@ -2363,7 +2363,7 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 		 * metadata promptly.
 		 */
 		set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 	}
 	rv = 0;
 out:
@@ -2454,7 +2454,7 @@ timeout_store(struct mddev *mddev, const char *buf, size_t len)
 		 */
 		if (mddev->thread->timeout < MAX_SCHEDULE_TIMEOUT) {
 			mddev->thread->timeout = timeout;
-			md_wakeup_thread(mddev->thread);
+			md_wakeup_thread(&mddev->thread);
 		}
 	}
 	return len;
diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index c19e29cb73bf..29c0b55a1142 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -325,7 +325,7 @@ static void recover_bitmaps(struct md_thread *thread)
 		if (test_bit(MD_RESYNCING_REMOTE, &mddev->recovery) &&
 		    test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
 		    mddev->reshape_position != MaxSector)
-			md_wakeup_thread(mddev->sync_thread);
+			md_wakeup_thread(&mddev->sync_thread);
 
 		if (hi > 0) {
 			if (lo < mddev->recovery_cp)
@@ -340,7 +340,7 @@ static void recover_bitmaps(struct md_thread *thread)
 				clear_bit(MD_RESYNCING_REMOTE,
 					  &mddev->recovery);
 				set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-				md_wakeup_thread(mddev->thread);
+				md_wakeup_thread(&mddev->thread);
 			}
 		}
 clear_bit:
@@ -368,7 +368,7 @@ static void __recover_slot(struct mddev *mddev, int slot)
 			return;
 		}
 	}
-	md_wakeup_thread(cinfo->recovery_thread);
+	md_wakeup_thread(&cinfo->recovery_thread);
 }
 
 static void recover_slot(void *arg, struct dlm_slot *slot)
@@ -422,7 +422,7 @@ static void ack_bast(void *arg, int mode)
 
 	if (mode == DLM_LOCK_EX) {
 		if (test_bit(MD_CLUSTER_ALREADY_IN_CLUSTER, &cinfo->state))
-			md_wakeup_thread(cinfo->recv_thread);
+			md_wakeup_thread(&cinfo->recv_thread);
 		else
 			set_bit(MD_CLUSTER_PENDING_RECV_EVENT, &cinfo->state);
 	}
@@ -454,7 +454,7 @@ static void process_suspend_info(struct mddev *mddev,
 		clear_bit(MD_RESYNCING_REMOTE, &mddev->recovery);
 		remove_suspend_info(mddev, slot);
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 		return;
 	}
 
@@ -546,7 +546,7 @@ static void process_remove_disk(struct mddev *mddev, struct cluster_msg *msg)
 	if (rdev) {
 		set_bit(ClusterRemove, &rdev->flags);
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 	}
 	else
 		pr_warn("%s: %d Could not find disk(%d) to REMOVE\n",
@@ -696,7 +696,7 @@ static int lock_comm(struct md_cluster_info *cinfo, bool mddev_locked)
 		rv = test_and_set_bit_lock(MD_CLUSTER_HOLDING_MUTEX_FOR_RECVD,
 					      &cinfo->state);
 		WARN_ON_ONCE(rv);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 		set_bit = 1;
 	}
 
@@ -971,7 +971,7 @@ static void load_bitmaps(struct mddev *mddev, int total_slots)
 	set_bit(MD_CLUSTER_ALREADY_IN_CLUSTER, &cinfo->state);
 	/* wake up recv thread in case something need to be handled */
 	if (test_and_clear_bit(MD_CLUSTER_PENDING_RECV_EVENT, &cinfo->state))
-		md_wakeup_thread(cinfo->recv_thread);
+		md_wakeup_thread(&cinfo->recv_thread);
 }
 
 static void resync_bitmap(struct mddev *mddev)
@@ -1052,7 +1052,7 @@ static int metadata_update_start(struct mddev *mddev)
 	ret = test_and_set_bit_lock(MD_CLUSTER_HOLDING_MUTEX_FOR_RECVD,
 				    &cinfo->state);
 	WARN_ON_ONCE(ret);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread);
 
 	wait_event(cinfo->wait,
 		   !test_and_set_bit(MD_CLUSTER_SEND_LOCK, &cinfo->state) ||
@@ -1430,7 +1430,7 @@ static int add_new_disk(struct mddev *mddev, struct md_rdev *rdev)
 		/* Since MD_CHANGE_DEVS will be set in add_bound_rdev which
 		 * will run soon after add_new_disk, the below path will be
 		 * invoked:
-		 *   md_wakeup_thread(mddev->thread)
+		 *   md_wakeup_thread(&mddev->thread)
 		 *	-> conf->thread (raid1d)
 		 *	-> md_check_recovery -> md_update_sb
 		 *	-> metadata_update_start/finish
diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
index ceec9e4b2a60..14541b63c959 100644
--- a/drivers/md/md-multipath.c
+++ b/drivers/md/md-multipath.c
@@ -57,7 +57,7 @@ static void multipath_reschedule_retry (struct multipath_bh *mp_bh)
 	spin_lock_irqsave(&conf->device_lock, flags);
 	list_add(&mp_bh->retry_list, &conf->retry_list);
 	spin_unlock_irqrestore(&conf->device_lock, flags);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread);
 }
 
 /*
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 6a678b4c584e..9e80c5491c9a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -487,8 +487,8 @@ void mddev_resume(struct mddev *mddev)
 	mddev->pers->quiesce(mddev, 0);
 
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
-	md_wakeup_thread(mddev->sync_thread); /* possibly kick off a reshape */
+	md_wakeup_thread(&mddev->thread);
+	md_wakeup_thread(&mddev->sync_thread); /* possibly kick off a reshape */
 }
 EXPORT_SYMBOL_GPL(mddev_resume);
 
@@ -806,7 +806,7 @@ void mddev_unlock(struct mddev *mddev)
 	 * make sure the thread doesn't disappear
 	 */
 	spin_lock(&pers_lock);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread);
 	wake_up(&mddev->sb_wait);
 	spin_unlock(&pers_lock);
 }
@@ -2816,7 +2816,7 @@ static int add_bound_rdev(struct md_rdev *rdev)
 		set_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	md_new_event();
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread);
 	return 0;
 }
 
@@ -2933,7 +2933,7 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 				md_kick_rdev_from_array(rdev);
 				if (mddev->pers) {
 					set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-					md_wakeup_thread(mddev->thread);
+					md_wakeup_thread(&mddev->thread);
 				}
 				md_new_event();
 			}
@@ -2964,7 +2964,7 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		clear_bit(BlockedBadBlocks, &rdev->flags);
 		wake_up(&rdev->blocked_wait);
 		set_bit(MD_RECOVERY_NEEDED, &rdev->mddev->recovery);
-		md_wakeup_thread(rdev->mddev->thread);
+		md_wakeup_thread(&rdev->mddev->thread);
 
 		err = 0;
 	} else if (cmd_match(buf, "insync") && rdev->raid_disk == -1) {
@@ -3002,7 +3002,7 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		    !test_bit(Replacement, &rdev->flags))
 			set_bit(WantReplacement, &rdev->flags);
 		set_bit(MD_RECOVERY_NEEDED, &rdev->mddev->recovery);
-		md_wakeup_thread(rdev->mddev->thread);
+		md_wakeup_thread(&rdev->mddev->thread);
 		err = 0;
 	} else if (cmd_match(buf, "-want_replacement")) {
 		/* Clearing 'want_replacement' is always allowed.
@@ -3132,7 +3132,7 @@ slot_store(struct md_rdev *rdev, const char *buf, size_t len)
 		if (rdev->raid_disk >= 0)
 			return -EBUSY;
 		set_bit(MD_RECOVERY_NEEDED, &rdev->mddev->recovery);
-		md_wakeup_thread(rdev->mddev->thread);
+		md_wakeup_thread(&rdev->mddev->thread);
 	} else if (rdev->mddev->pers) {
 		/* Activating a spare .. or possibly reactivating
 		 * if we ever get bitmaps working here.
@@ -4364,7 +4364,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 		if (st == active) {
 			restart_array(mddev);
 			clear_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags);
-			md_wakeup_thread(mddev->thread);
+			md_wakeup_thread(&mddev->thread);
 			wake_up(&mddev->sb_wait);
 		} else /* st == clean */ {
 			restart_array(mddev);
@@ -4864,10 +4864,10 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 		 * canceling read-auto mode
 		 */
 		mddev->ro = MD_RDWR;
-		md_wakeup_thread(mddev->sync_thread);
+		md_wakeup_thread(&mddev->sync_thread);
 	}
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread);
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
 	return len;
 }
@@ -5771,7 +5771,7 @@ static void md_safemode_timeout(struct timer_list *t)
 	if (mddev->external)
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
 
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread);
 }
 
 static int start_dirty_degraded;
@@ -6083,8 +6083,8 @@ int do_md_run(struct mddev *mddev)
 	/* run start up tasks that require md_thread */
 	md_start(mddev);
 
-	md_wakeup_thread(mddev->thread);
-	md_wakeup_thread(mddev->sync_thread); /* possibly kick off a reshape */
+	md_wakeup_thread(&mddev->thread);
+	md_wakeup_thread(&mddev->sync_thread); /* possibly kick off a reshape */
 
 	set_capacity_and_notify(mddev->gendisk, mddev->array_sectors);
 	clear_bit(MD_NOT_READY, &mddev->flags);
@@ -6104,10 +6104,10 @@ int md_start(struct mddev *mddev)
 
 	if (mddev->pers->start) {
 		set_bit(MD_RECOVERY_WAIT, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 		ret = mddev->pers->start(mddev);
 		clear_bit(MD_RECOVERY_WAIT, &mddev->recovery);
-		md_wakeup_thread(mddev->sync_thread);
+		md_wakeup_thread(&mddev->sync_thread);
 	}
 	return ret;
 }
@@ -6149,8 +6149,8 @@ static int restart_array(struct mddev *mddev)
 	pr_debug("md: %s switched to read-write mode.\n", mdname(mddev));
 	/* Kick recovery or resync if necessary */
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
-	md_wakeup_thread(mddev->sync_thread);
+	md_wakeup_thread(&mddev->thread);
+	md_wakeup_thread(&mddev->sync_thread);
 	sysfs_notify_dirent_safe(mddev->sysfs_state);
 	return 0;
 }
@@ -6299,7 +6299,7 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
 		did_freeze = 1;
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 	}
 	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
@@ -6325,7 +6325,7 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 		if (did_freeze) {
 			clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-			md_wakeup_thread(mddev->thread);
+			md_wakeup_thread(&mddev->thread);
 		}
 		err = -EBUSY;
 		goto out;
@@ -6340,7 +6340,7 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 		set_disk_ro(mddev->gendisk, 1);
 		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
 		err = 0;
 	}
@@ -6363,7 +6363,7 @@ static int do_md_stop(struct mddev *mddev, int mode,
 	if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
 		did_freeze = 1;
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 	}
 	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
@@ -6388,7 +6388,7 @@ static int do_md_stop(struct mddev *mddev, int mode,
 		if (did_freeze) {
 			clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-			md_wakeup_thread(mddev->thread);
+			md_wakeup_thread(&mddev->thread);
 		}
 		return -EBUSY;
 	}
@@ -6931,7 +6931,7 @@ static int hot_remove_disk(struct mddev *mddev, dev_t dev)
 	md_kick_rdev_from_array(rdev);
 	set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
 	if (mddev->thread)
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 	else
 		md_update_sb(mddev, 1);
 	md_new_event();
@@ -7014,7 +7014,7 @@ static int hot_add_disk(struct mddev *mddev, dev_t dev)
 	 * array immediately.
 	 */
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread);
 	md_new_event();
 	return 0;
 
@@ -7919,8 +7919,10 @@ static int md_thread(void *arg)
 	return 0;
 }
 
-void md_wakeup_thread(struct md_thread *thread)
+void md_wakeup_thread(struct md_thread **threadp)
 {
+	struct md_thread *thread = *threadp;
+
 	if (thread) {
 		pr_debug("md: waking up MD thread %s.\n", thread->tsk->comm);
 		set_bit(THREAD_WAKEUP, &thread->flags);
@@ -7996,7 +7998,7 @@ void md_error(struct mddev *mddev, struct md_rdev *rdev)
 	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 	if (!test_bit(MD_BROKEN, &mddev->flags)) {
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 	}
 	if (mddev->event_work.func)
 		queue_work(md_misc_wq, &mddev->event_work);
@@ -8507,7 +8509,7 @@ void md_done_sync(struct mddev *mddev, int blocks, int ok)
 	if (!ok) {
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 		set_bit(MD_RECOVERY_ERROR, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 		// stop recovery, signal do_sync ....
 	}
 }
@@ -8532,8 +8534,8 @@ bool md_write_start(struct mddev *mddev, struct bio *bi)
 		/* need to switch to read/write */
 		mddev->ro = MD_RDWR;
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
-		md_wakeup_thread(mddev->sync_thread);
+		md_wakeup_thread(&mddev->thread);
+		md_wakeup_thread(&mddev->sync_thread);
 		did_change = 1;
 	}
 	rcu_read_lock();
@@ -8548,7 +8550,7 @@ bool md_write_start(struct mddev *mddev, struct bio *bi)
 			mddev->in_sync = 0;
 			set_bit(MD_SB_CHANGE_CLEAN, &mddev->sb_flags);
 			set_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags);
-			md_wakeup_thread(mddev->thread);
+			md_wakeup_thread(&mddev->thread);
 			did_change = 1;
 		}
 		spin_unlock(&mddev->lock);
@@ -8591,7 +8593,7 @@ void md_write_end(struct mddev *mddev)
 	percpu_ref_put(&mddev->writes_pending);
 
 	if (mddev->safemode == 2)
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 	else if (mddev->safemode_delay)
 		/* The roundup() ensures this only performs locking once
 		 * every ->safemode_delay jiffies
@@ -9133,7 +9135,7 @@ void md_do_sync(struct md_thread *thread)
 	spin_unlock(&mddev->lock);
 
 	wake_up(&resync_wait);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread);
 	return;
 }
 EXPORT_SYMBOL_GPL(md_do_sync);
@@ -9251,7 +9253,7 @@ static void md_start_sync(struct work_struct *ws)
 			if (mddev->sysfs_action)
 				sysfs_notify_dirent_safe(mddev->sysfs_action);
 	} else
-		md_wakeup_thread(mddev->sync_thread);
+		md_wakeup_thread(&mddev->sync_thread);
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
 	md_new_event();
 }
@@ -9576,7 +9578,7 @@ int rdev_set_badblocks(struct md_rdev *rdev, sector_t s, int sectors,
 		sysfs_notify_dirent_safe(rdev->sysfs_state);
 		set_mask_bits(&mddev->sb_flags, 0,
 			      BIT(MD_SB_CHANGE_CLEAN) | BIT(MD_SB_CHANGE_PENDING));
-		md_wakeup_thread(rdev->mddev->thread);
+		md_wakeup_thread(&rdev->mddev->thread);
 		return 1;
 	} else
 		return 0;
@@ -9741,7 +9743,7 @@ static void check_sb_changes(struct mddev *mddev, struct md_rdev *rdev)
 				/* wakeup mddev->thread here, so array could
 				 * perform resync with the new activated disk */
 				set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-				md_wakeup_thread(mddev->thread);
+				md_wakeup_thread(&mddev->thread);
 			}
 			/* device faulty
 			 * We just want to do the minimum to mark the disk
diff --git a/drivers/md/md.h b/drivers/md/md.h
index d0cc4544893d..eaaf49eba503 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -739,7 +739,7 @@ int md_register_thread(struct md_thread **threadp,
 		       void (*run)(struct md_thread *thread),
 		       struct mddev *mddev, const char *name);
 extern void md_unregister_thread(struct md_thread **threadp);
-extern void md_wakeup_thread(struct md_thread *thread);
+extern void md_wakeup_thread(struct md_thread **threadp);
 extern void md_check_recovery(struct mddev *mddev);
 extern void md_reap_sync_thread(struct mddev *mddev);
 extern int mddev_init_writes_pending(struct mddev *mddev);
@@ -810,7 +810,7 @@ static inline void rdev_dec_pending(struct md_rdev *rdev, struct mddev *mddev)
 	int faulty = test_bit(Faulty, &rdev->flags);
 	if (atomic_dec_and_test(&rdev->nr_pending) && faulty) {
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 	}
 }
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 1217c1db0a40..8e241caecb7e 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -289,7 +289,7 @@ static void reschedule_retry(struct r1bio *r1_bio)
 	spin_unlock_irqrestore(&conf->device_lock, flags);
 
 	wake_up(&conf->wait_barrier);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread);
 }
 
 /*
@@ -1180,7 +1180,7 @@ static void raid1_unplug(struct blk_plug_cb *cb, bool from_schedule)
 		bio_list_merge(&conf->pending_bio_list, &plug->pending);
 		spin_unlock_irq(&conf->device_lock);
 		wake_up(&conf->wait_barrier);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 		kfree(plug);
 		return;
 	}
@@ -1585,7 +1585,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 			spin_lock_irqsave(&conf->device_lock, flags);
 			bio_list_add(&conf->pending_bio_list, mbio);
 			spin_unlock_irqrestore(&conf->device_lock, flags);
-			md_wakeup_thread(mddev->thread);
+			md_wakeup_thread(&mddev->thread);
 		}
 	}
 
@@ -2501,7 +2501,7 @@ static void handle_write_finished(struct r1conf *conf, struct r1bio *r1_bio)
 		 * get_unqueued_pending() == extra to be true.
 		 */
 		wake_up(&conf->wait_barrier);
-		md_wakeup_thread(conf->mddev->thread);
+		md_wakeup_thread(&conf->mddev->thread);
 	} else {
 		if (test_bit(R1BIO_WriteError, &r1_bio->state))
 			close_write(r1_bio);
@@ -3344,7 +3344,7 @@ static int raid1_reshape(struct mddev *mddev)
 
 	set_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread);
 
 	mempool_exit(&oldpool);
 	return 0;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0171ba4f19b0..53a6510c4a9a 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -309,7 +309,7 @@ static void reschedule_retry(struct r10bio *r10_bio)
 	/* wake up frozen array... */
 	wake_up(&conf->wait_barrier);
 
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread);
 }
 
 /*
@@ -1112,7 +1112,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 		bio_list_merge(&conf->pending_bio_list, &plug->pending);
 		spin_unlock_irq(&conf->device_lock);
 		wake_up(&conf->wait_barrier);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 		kfree(plug);
 		return;
 	}
@@ -1327,7 +1327,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 		spin_lock_irqsave(&conf->device_lock, flags);
 		bio_list_add(&conf->pending_bio_list, mbio);
 		spin_unlock_irqrestore(&conf->device_lock, flags);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 	}
 }
 
@@ -1439,7 +1439,7 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		mddev->reshape_position = conf->reshape_progress;
 		set_mask_bits(&mddev->sb_flags, 0,
 			      BIT(MD_SB_CHANGE_DEVS) | BIT(MD_SB_CHANGE_PENDING));
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 		if (bio->bi_opf & REQ_NOWAIT) {
 			allow_barrier(conf);
 			bio_wouldblock_error(bio);
@@ -3074,7 +3074,7 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 			 * nr_pending == nr_queued + extra to be true.
 			 */
 			wake_up(&conf->wait_barrier);
-			md_wakeup_thread(conf->mddev->thread);
+			md_wakeup_thread(&conf->mddev->thread);
 		} else {
 			if (test_bit(R10BIO_WriteError,
 				     &r10_bio->state))
@@ -4690,7 +4690,7 @@ static int raid10_start_reshape(struct mddev *mddev)
 		goto abort;
 	}
 	conf->reshape_checkpoint = jiffies;
-	md_wakeup_thread(mddev->sync_thread);
+	md_wakeup_thread(&mddev->sync_thread);
 	md_new_event();
 	return 0;
 
@@ -4872,7 +4872,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 			mddev->curr_resync_completed = conf->reshape_progress;
 		conf->reshape_checkpoint = jiffies;
 		set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 		wait_event(mddev->sb_wait, mddev->sb_flags == 0 ||
 			   test_bit(MD_RECOVERY_INTR, &mddev->recovery));
 		if (test_bit(MD_RECOVERY_INTR, &mddev->recovery)) {
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 0464d4d551fc..3c5b21284b1c 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -600,7 +600,7 @@ static void r5l_log_endio(struct bio *bio)
 	spin_unlock_irqrestore(&log->io_list_lock, flags);
 
 	if (log->need_cache_flush)
-		md_wakeup_thread(log->rdev->mddev->thread);
+		md_wakeup_thread(&log->rdev->mddev->thread);
 
 	/* finish flush only io_unit and PAYLOAD_FLUSH only io_unit */
 	if (has_null_flush) {
@@ -1491,7 +1491,7 @@ static void r5c_do_reclaim(struct r5conf *conf)
 	if (!test_bit(R5C_LOG_CRITICAL, &conf->cache_state))
 		r5l_run_no_space_stripes(log);
 
-	md_wakeup_thread(conf->mddev->thread);
+	md_wakeup_thread(&conf->mddev->thread);
 }
 
 static void r5l_do_reclaim(struct r5l_log *log)
@@ -1519,7 +1519,7 @@ static void r5l_do_reclaim(struct r5l_log *log)
 		     list_empty(&log->finished_ios)))
 			break;
 
-		md_wakeup_thread(log->rdev->mddev->thread);
+		md_wakeup_thread(&log->rdev->mddev->thread);
 		wait_event_lock_irq(log->iounit_wait,
 				    r5l_reclaimable_space(log) > reclaimable,
 				    log->io_list_lock);
@@ -1571,7 +1571,7 @@ void r5l_wake_reclaim(struct r5l_log *log, sector_t space)
 		if (new < target)
 			return;
 	} while (!try_cmpxchg(&log->reclaim_target, &target, new));
-	md_wakeup_thread(log->reclaim_thread);
+	md_wakeup_thread(&log->reclaim_thread);
 }
 
 void r5l_quiesce(struct r5l_log *log, int quiesce)
@@ -2776,7 +2776,7 @@ void r5c_release_extra_page(struct stripe_head *sh)
 
 	if (using_disk_info_extra_page) {
 		clear_bit(R5C_EXTRA_PAGE_IN_USE, &conf->cache_state);
-		md_wakeup_thread(conf->mddev->thread);
+		md_wakeup_thread(&conf->mddev->thread);
 	}
 }
 
@@ -2832,7 +2832,7 @@ void r5c_finish_stripe_write_out(struct r5conf *conf,
 
 	if (test_and_clear_bit(STRIPE_FULL_WRITE, &sh->state))
 		if (atomic_dec_and_test(&conf->pending_full_writes))
-			md_wakeup_thread(conf->mddev->thread);
+			md_wakeup_thread(&conf->mddev->thread);
 
 	if (do_wakeup)
 		wake_up(&conf->wait_for_overlap);
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index e495939bb3e0..990201fb6d52 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -601,7 +601,7 @@ static void ppl_flush_endio(struct bio *bio)
 
 	if (atomic_dec_and_test(&io->pending_flushes)) {
 		ppl_io_unit_finished(io);
-		md_wakeup_thread(conf->mddev->thread);
+		md_wakeup_thread(&conf->mddev->thread);
 	}
 }
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 04b1093195d0..36762c58a46b 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -195,7 +195,7 @@ static void raid5_wakeup_stripe_thread(struct stripe_head *sh)
 	}
 
 	if (conf->worker_cnt_per_group == 0) {
-		md_wakeup_thread(conf->mddev->thread);
+		md_wakeup_thread(&conf->mddev->thread);
 		return;
 	}
 
@@ -268,13 +268,13 @@ static void do_release_stripe(struct r5conf *conf, struct stripe_head *sh,
 				return;
 			}
 		}
-		md_wakeup_thread(conf->mddev->thread);
+		md_wakeup_thread(&conf->mddev->thread);
 	} else {
 		BUG_ON(stripe_operations_active(sh));
 		if (test_and_clear_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
 			if (atomic_dec_return(&conf->preread_active_stripes)
 			    < IO_THRESHOLD)
-				md_wakeup_thread(conf->mddev->thread);
+				md_wakeup_thread(&conf->mddev->thread);
 		atomic_dec(&conf->active_stripes);
 		if (!test_bit(STRIPE_EXPANDING, &sh->state)) {
 			if (!r5c_is_writeback(conf->log))
@@ -356,7 +356,7 @@ static void release_inactive_stripe_list(struct r5conf *conf,
 		if (atomic_read(&conf->active_stripes) == 0)
 			wake_up(&conf->wait_for_quiescent);
 		if (conf->retry_read_aligned)
-			md_wakeup_thread(conf->mddev->thread);
+			md_wakeup_thread(&conf->mddev->thread);
 	}
 }
 
@@ -407,7 +407,7 @@ void raid5_release_stripe(struct stripe_head *sh)
 		goto slow_path;
 	wakeup = llist_add(&sh->release_list, &conf->released_stripes);
 	if (wakeup)
-		md_wakeup_thread(conf->mddev->thread);
+		md_wakeup_thread(&conf->mddev->thread);
 	return;
 slow_path:
 	/* we are ok here if STRIPE_ON_RELEASE_LIST is set or not */
@@ -981,7 +981,7 @@ static void stripe_add_to_batch_list(struct r5conf *conf,
 	if (test_and_clear_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
 		if (atomic_dec_return(&conf->preread_active_stripes)
 		    < IO_THRESHOLD)
-			md_wakeup_thread(conf->mddev->thread);
+			md_wakeup_thread(&conf->mddev->thread);
 
 	if (test_and_clear_bit(STRIPE_BIT_DELAY, &sh->state)) {
 		int seq = sh->bm_seq;
@@ -3759,7 +3759,7 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 
 	if (test_and_clear_bit(STRIPE_FULL_WRITE, &sh->state))
 		if (atomic_dec_and_test(&conf->pending_full_writes))
-			md_wakeup_thread(conf->mddev->thread);
+			md_wakeup_thread(&conf->mddev->thread);
 }
 
 static void
@@ -4156,7 +4156,7 @@ static void handle_stripe_clean_event(struct r5conf *conf,
 
 	if (test_and_clear_bit(STRIPE_FULL_WRITE, &sh->state))
 		if (atomic_dec_and_test(&conf->pending_full_writes))
-			md_wakeup_thread(conf->mddev->thread);
+			md_wakeup_thread(&conf->mddev->thread);
 
 	if (head_sh->batch_head && do_endio)
 		break_stripe_batch_list(head_sh, STRIPE_EXPAND_SYNC_FLAGS);
@@ -5369,7 +5369,7 @@ static void handle_stripe(struct stripe_head *sh)
 		atomic_dec(&conf->preread_active_stripes);
 		if (atomic_read(&conf->preread_active_stripes) <
 		    IO_THRESHOLD)
-			md_wakeup_thread(conf->mddev->thread);
+			md_wakeup_thread(&conf->mddev->thread);
 	}
 
 	clear_bit_unlock(STRIPE_ACTIVE, &sh->state);
@@ -5436,7 +5436,7 @@ static void add_bio_to_retry(struct bio *bi,struct r5conf *conf)
 	conf->retry_read_aligned_list = bi;
 
 	spin_unlock_irqrestore(&conf->device_lock, flags);
-	md_wakeup_thread(conf->mddev->thread);
+	md_wakeup_thread(&conf->mddev->thread);
 }
 
 static struct bio *remove_bio_from_retry(struct r5conf *conf,
@@ -6045,7 +6045,7 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 		 * Stripe is busy expanding or add failed due to
 		 * overlap. Flush everything and wait a while.
 		 */
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 		ret = STRIPE_SCHEDULE_AND_RETRY;
 		goto out_release;
 	}
@@ -6345,7 +6345,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 
 		conf->reshape_checkpoint = jiffies;
 		set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 		wait_event(mddev->sb_wait, mddev->sb_flags == 0 ||
 			   test_bit(MD_RECOVERY_INTR, &mddev->recovery));
 		if (test_bit(MD_RECOVERY_INTR, &mddev->recovery))
@@ -6453,7 +6453,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 					rdev->recovery_offset = sector_nr;
 		conf->reshape_checkpoint = jiffies;
 		set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 		wait_event(mddev->sb_wait,
 			   !test_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags)
 			   || test_bit(MD_RECOVERY_INTR, &mddev->recovery));
@@ -8585,7 +8585,7 @@ static int raid5_start_reshape(struct mddev *mddev)
 		return -EAGAIN;
 	}
 	conf->reshape_checkpoint = jiffies;
-	md_wakeup_thread(mddev->sync_thread);
+	md_wakeup_thread(&mddev->sync_thread);
 	md_new_event();
 	return 0;
 }
@@ -8815,7 +8815,7 @@ static int raid5_check_reshape(struct mddev *mddev)
 			mddev->chunk_sectors = new_chunk;
 		}
 		set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread);
 	}
 	return check_reshape(mddev);
 }
-- 
2.39.2

