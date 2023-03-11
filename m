Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005236B5A19
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 10:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjCKJc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 04:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCKJcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 04:32:35 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7F9C4899;
        Sat, 11 Mar 2023 01:32:31 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PYd4C4T5vz4f3m6Z;
        Sat, 11 Mar 2023 17:32:27 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiCqSgxkFn3mEg--.16173S6;
        Sat, 11 Mar 2023 17:32:29 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 2/5] md: refactor md_wakeup_thread()
Date:   Sat, 11 Mar 2023 17:31:45 +0800
Message-Id: <20230311093148.2595222-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230311093148.2595222-1-yukuai1@huaweicloud.com>
References: <20230311093148.2595222-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiCqSgxkFn3mEg--.16173S6
X-Coremail-Antispam: 1UD129KBjvAXoWfWry5tF48Ar17CFy5tr43Jrb_yoW5ZrWDKo
        Z5Cr1aqF18X3WF9FyrtwnxtFW3XryUJ34Syw1rZFWkWFnruws5W343Zay3Jrn5K3ZxWF18
        XrnrWr4rGrn3K3yxn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYm7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M28IrcIa0x
        kI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
        jcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Pass a md_thread pointer and a mddev to md_wakeup_thread(), prepare to
use a disk level spinlock to protect md_thread, there are no functional
changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-raid.c      |  4 +--
 drivers/md/md-bitmap.c    |  6 ++--
 drivers/md/md-cluster.c   | 20 +++++------
 drivers/md/md-multipath.c |  2 +-
 drivers/md/md.c           | 76 ++++++++++++++++++++-------------------
 drivers/md/md.h           |  4 +--
 drivers/md/raid1.c        | 10 +++---
 drivers/md/raid10.c       | 14 ++++----
 drivers/md/raid5-cache.c  | 12 +++----
 drivers/md/raid5-ppl.c    |  2 +-
 drivers/md/raid5.c        | 31 ++++++++--------
 11 files changed, 93 insertions(+), 88 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 60632b409b80..257c9c9f2b4d 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3755,11 +3755,11 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 		 */
 		mddev->ro = 0;
 		if (!mddev->suspended && mddev->sync_thread)
-			md_wakeup_thread(mddev->sync_thread);
+			md_wakeup_thread(&mddev->sync_thread, mddev);
 	}
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	if (!mddev->suspended && mddev->thread)
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 
 	return 0;
 }
diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index e7cc6ba1b657..9489510405f7 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1942,7 +1942,7 @@ int md_bitmap_load(struct mddev *mddev)
 	set_bit(MD_RECOVERY_NEEDED, &bitmap->mddev->recovery);
 
 	mddev->thread->timeout = mddev->bitmap_info.daemon_sleep;
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread, mddev);
 
 	md_bitmap_update_sb(bitmap);
 
@@ -2363,7 +2363,7 @@ location_store(struct mddev *mddev, const char *buf, size_t len)
 		 * metadata promptly.
 		 */
 		set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 	}
 	rv = 0;
 out:
@@ -2454,7 +2454,7 @@ timeout_store(struct mddev *mddev, const char *buf, size_t len)
 		 */
 		if (mddev->thread->timeout < MAX_SCHEDULE_TIMEOUT) {
 			mddev->thread->timeout = timeout;
-			md_wakeup_thread(mddev->thread);
+			md_wakeup_thread(&mddev->thread, mddev);
 		}
 	}
 	return len;
diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index c19e29cb73bf..92b0e49b4e53 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -325,7 +325,7 @@ static void recover_bitmaps(struct md_thread *thread)
 		if (test_bit(MD_RESYNCING_REMOTE, &mddev->recovery) &&
 		    test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
 		    mddev->reshape_position != MaxSector)
-			md_wakeup_thread(mddev->sync_thread);
+			md_wakeup_thread(&mddev->sync_thread, mddev);
 
 		if (hi > 0) {
 			if (lo < mddev->recovery_cp)
@@ -340,7 +340,7 @@ static void recover_bitmaps(struct md_thread *thread)
 				clear_bit(MD_RESYNCING_REMOTE,
 					  &mddev->recovery);
 				set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-				md_wakeup_thread(mddev->thread);
+				md_wakeup_thread(&mddev->thread, mddev);
 			}
 		}
 clear_bit:
@@ -368,7 +368,7 @@ static void __recover_slot(struct mddev *mddev, int slot)
 			return;
 		}
 	}
-	md_wakeup_thread(cinfo->recovery_thread);
+	md_wakeup_thread(&cinfo->recovery_thread, mddev);
 }
 
 static void recover_slot(void *arg, struct dlm_slot *slot)
@@ -422,7 +422,7 @@ static void ack_bast(void *arg, int mode)
 
 	if (mode == DLM_LOCK_EX) {
 		if (test_bit(MD_CLUSTER_ALREADY_IN_CLUSTER, &cinfo->state))
-			md_wakeup_thread(cinfo->recv_thread);
+			md_wakeup_thread(&cinfo->recv_thread, mddev);
 		else
 			set_bit(MD_CLUSTER_PENDING_RECV_EVENT, &cinfo->state);
 	}
@@ -454,7 +454,7 @@ static void process_suspend_info(struct mddev *mddev,
 		clear_bit(MD_RESYNCING_REMOTE, &mddev->recovery);
 		remove_suspend_info(mddev, slot);
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 		return;
 	}
 
@@ -546,7 +546,7 @@ static void process_remove_disk(struct mddev *mddev, struct cluster_msg *msg)
 	if (rdev) {
 		set_bit(ClusterRemove, &rdev->flags);
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 	}
 	else
 		pr_warn("%s: %d Could not find disk(%d) to REMOVE\n",
@@ -696,7 +696,7 @@ static int lock_comm(struct md_cluster_info *cinfo, bool mddev_locked)
 		rv = test_and_set_bit_lock(MD_CLUSTER_HOLDING_MUTEX_FOR_RECVD,
 					      &cinfo->state);
 		WARN_ON_ONCE(rv);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 		set_bit = 1;
 	}
 
@@ -971,7 +971,7 @@ static void load_bitmaps(struct mddev *mddev, int total_slots)
 	set_bit(MD_CLUSTER_ALREADY_IN_CLUSTER, &cinfo->state);
 	/* wake up recv thread in case something need to be handled */
 	if (test_and_clear_bit(MD_CLUSTER_PENDING_RECV_EVENT, &cinfo->state))
-		md_wakeup_thread(cinfo->recv_thread);
+		md_wakeup_thread(&cinfo->recv_thread, mddev);
 }
 
 static void resync_bitmap(struct mddev *mddev)
@@ -1052,7 +1052,7 @@ static int metadata_update_start(struct mddev *mddev)
 	ret = test_and_set_bit_lock(MD_CLUSTER_HOLDING_MUTEX_FOR_RECVD,
 				    &cinfo->state);
 	WARN_ON_ONCE(ret);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread, mddev);
 
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
index ceec9e4b2a60..482536ec8850 100644
--- a/drivers/md/md-multipath.c
+++ b/drivers/md/md-multipath.c
@@ -57,7 +57,7 @@ static void multipath_reschedule_retry (struct multipath_bh *mp_bh)
 	spin_lock_irqsave(&conf->device_lock, flags);
 	list_add(&mp_bh->retry_list, &conf->retry_list);
 	spin_unlock_irqrestore(&conf->device_lock, flags);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread, mddev);
 }
 
 /*
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 0bbdde29a41f..97e87df4ee43 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -487,8 +487,9 @@ void mddev_resume(struct mddev *mddev)
 	mddev->pers->quiesce(mddev, 0);
 
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
-	md_wakeup_thread(mddev->sync_thread); /* possibly kick off a reshape */
+	md_wakeup_thread(&mddev->thread, mddev);
+	/* possibly kick off a reshape */
+	md_wakeup_thread(&mddev->sync_thread, mddev);
 }
 EXPORT_SYMBOL_GPL(mddev_resume);
 
@@ -804,7 +805,7 @@ void mddev_unlock(struct mddev *mddev)
 	 * make sure the thread doesn't disappear
 	 */
 	spin_lock(&pers_lock);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread, mddev);
 	wake_up(&mddev->sb_wait);
 	spin_unlock(&pers_lock);
 }
@@ -2814,7 +2815,7 @@ static int add_bound_rdev(struct md_rdev *rdev)
 		set_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 	md_new_event();
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread, mddev);
 	return 0;
 }
 
@@ -2931,7 +2932,7 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 				md_kick_rdev_from_array(rdev);
 				if (mddev->pers) {
 					set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-					md_wakeup_thread(mddev->thread);
+					md_wakeup_thread(&mddev->thread, mddev);
 				}
 				md_new_event();
 			}
@@ -2962,7 +2963,7 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		clear_bit(BlockedBadBlocks, &rdev->flags);
 		wake_up(&rdev->blocked_wait);
 		set_bit(MD_RECOVERY_NEEDED, &rdev->mddev->recovery);
-		md_wakeup_thread(rdev->mddev->thread);
+		md_wakeup_thread(&rdev->mddev->thread, rdev->mddev);
 
 		err = 0;
 	} else if (cmd_match(buf, "insync") && rdev->raid_disk == -1) {
@@ -3000,7 +3001,7 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 		    !test_bit(Replacement, &rdev->flags))
 			set_bit(WantReplacement, &rdev->flags);
 		set_bit(MD_RECOVERY_NEEDED, &rdev->mddev->recovery);
-		md_wakeup_thread(rdev->mddev->thread);
+		md_wakeup_thread(&rdev->mddev->thread, rdev->mddev);
 		err = 0;
 	} else if (cmd_match(buf, "-want_replacement")) {
 		/* Clearing 'want_replacement' is always allowed.
@@ -3127,7 +3128,7 @@ slot_store(struct md_rdev *rdev, const char *buf, size_t len)
 		if (rdev->raid_disk >= 0)
 			return -EBUSY;
 		set_bit(MD_RECOVERY_NEEDED, &rdev->mddev->recovery);
-		md_wakeup_thread(rdev->mddev->thread);
+		md_wakeup_thread(&rdev->mddev->thread, rdev->mddev);
 	} else if (rdev->mddev->pers) {
 		/* Activating a spare .. or possibly reactivating
 		 * if we ever get bitmaps working here.
@@ -4359,7 +4360,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 		if (st == active) {
 			restart_array(mddev);
 			clear_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags);
-			md_wakeup_thread(mddev->thread);
+			md_wakeup_thread(&mddev->thread, mddev);
 			wake_up(&mddev->sb_wait);
 		} else /* st == clean */ {
 			restart_array(mddev);
@@ -4826,10 +4827,10 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 		 * canceling read-auto mode
 		 */
 		mddev->ro = MD_RDWR;
-		md_wakeup_thread(mddev->sync_thread);
+		md_wakeup_thread(&mddev->sync_thread, mddev);
 	}
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread, mddev);
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
 	return len;
 }
@@ -5733,7 +5734,7 @@ static void md_safemode_timeout(struct timer_list *t)
 	if (mddev->external)
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
 
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread, mddev);
 }
 
 static int start_dirty_degraded;
@@ -6045,8 +6046,9 @@ int do_md_run(struct mddev *mddev)
 	/* run start up tasks that require md_thread */
 	md_start(mddev);
 
-	md_wakeup_thread(mddev->thread);
-	md_wakeup_thread(mddev->sync_thread); /* possibly kick off a reshape */
+	md_wakeup_thread(&mddev->thread, mddev);
+	/* possibly kick off a reshape */
+	md_wakeup_thread(&mddev->sync_thread, mddev);
 
 	set_capacity_and_notify(mddev->gendisk, mddev->array_sectors);
 	clear_bit(MD_NOT_READY, &mddev->flags);
@@ -6066,10 +6068,10 @@ int md_start(struct mddev *mddev)
 
 	if (mddev->pers->start) {
 		set_bit(MD_RECOVERY_WAIT, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 		ret = mddev->pers->start(mddev);
 		clear_bit(MD_RECOVERY_WAIT, &mddev->recovery);
-		md_wakeup_thread(mddev->sync_thread);
+		md_wakeup_thread(&mddev->sync_thread, mddev);
 	}
 	return ret;
 }
@@ -6111,8 +6113,8 @@ static int restart_array(struct mddev *mddev)
 	pr_debug("md: %s switched to read-write mode.\n", mdname(mddev));
 	/* Kick recovery or resync if necessary */
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
-	md_wakeup_thread(mddev->sync_thread);
+	md_wakeup_thread(&mddev->thread, mddev);
+	md_wakeup_thread(&mddev->sync_thread, mddev);
 	sysfs_notify_dirent_safe(mddev->sysfs_state);
 	return 0;
 }
@@ -6261,7 +6263,7 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
 		did_freeze = 1;
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 	}
 	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
@@ -6287,7 +6289,7 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 		if (did_freeze) {
 			clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-			md_wakeup_thread(mddev->thread);
+			md_wakeup_thread(&mddev->thread, mddev);
 		}
 		err = -EBUSY;
 		goto out;
@@ -6302,7 +6304,7 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 		set_disk_ro(mddev->gendisk, 1);
 		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 		sysfs_notify_dirent_safe(mddev->sysfs_state);
 		err = 0;
 	}
@@ -6325,7 +6327,7 @@ static int do_md_stop(struct mddev *mddev, int mode,
 	if (!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery)) {
 		did_freeze = 1;
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 	}
 	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
@@ -6350,7 +6352,7 @@ static int do_md_stop(struct mddev *mddev, int mode,
 		if (did_freeze) {
 			clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-			md_wakeup_thread(mddev->thread);
+			md_wakeup_thread(&mddev->thread, mddev);
 		}
 		return -EBUSY;
 	}
@@ -6893,7 +6895,7 @@ static int hot_remove_disk(struct mddev *mddev, dev_t dev)
 	md_kick_rdev_from_array(rdev);
 	set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
 	if (mddev->thread)
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 	else
 		md_update_sb(mddev, 1);
 	md_new_event();
@@ -6976,7 +6978,7 @@ static int hot_add_disk(struct mddev *mddev, dev_t dev)
 	 * array immediately.
 	 */
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread, mddev);
 	md_new_event();
 	return 0;
 
@@ -7886,8 +7888,10 @@ static int md_thread(void *arg)
 	return 0;
 }
 
-void md_wakeup_thread(struct md_thread *thread)
+void md_wakeup_thread(struct md_thread **threadp, struct mddev *mddev)
 {
+	struct md_thread *thread = *threadp;
+
 	if (thread) {
 		pr_debug("md: waking up MD thread %s.\n", thread->tsk->comm);
 		set_bit(THREAD_WAKEUP, &thread->flags);
@@ -7963,7 +7967,7 @@ void md_error(struct mddev *mddev, struct md_rdev *rdev)
 	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 	if (!test_bit(MD_BROKEN, &mddev->flags)) {
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 	}
 	if (mddev->event_work.func)
 		queue_work(md_misc_wq, &mddev->event_work);
@@ -8474,7 +8478,7 @@ void md_done_sync(struct mddev *mddev, int blocks, int ok)
 	if (!ok) {
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 		set_bit(MD_RECOVERY_ERROR, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 		// stop recovery, signal do_sync ....
 	}
 }
@@ -8499,8 +8503,8 @@ bool md_write_start(struct mddev *mddev, struct bio *bi)
 		/* need to switch to read/write */
 		mddev->ro = MD_RDWR;
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
-		md_wakeup_thread(mddev->sync_thread);
+		md_wakeup_thread(&mddev->thread, mddev);
+		md_wakeup_thread(&mddev->sync_thread, mddev);
 		did_change = 1;
 	}
 	rcu_read_lock();
@@ -8515,7 +8519,7 @@ bool md_write_start(struct mddev *mddev, struct bio *bi)
 			mddev->in_sync = 0;
 			set_bit(MD_SB_CHANGE_CLEAN, &mddev->sb_flags);
 			set_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags);
-			md_wakeup_thread(mddev->thread);
+			md_wakeup_thread(&mddev->thread, mddev);
 			did_change = 1;
 		}
 		spin_unlock(&mddev->lock);
@@ -8558,7 +8562,7 @@ void md_write_end(struct mddev *mddev)
 	percpu_ref_put(&mddev->writes_pending);
 
 	if (mddev->safemode == 2)
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 	else if (mddev->safemode_delay)
 		/* The roundup() ensures this only performs locking once
 		 * every ->safemode_delay jiffies
@@ -9100,7 +9104,7 @@ void md_do_sync(struct md_thread *thread)
 	spin_unlock(&mddev->lock);
 
 	wake_up(&resync_wait);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread, mddev);
 	return;
 }
 EXPORT_SYMBOL_GPL(md_do_sync);
@@ -9218,7 +9222,7 @@ static void md_start_sync(struct work_struct *ws)
 			if (mddev->sysfs_action)
 				sysfs_notify_dirent_safe(mddev->sysfs_action);
 	} else
-		md_wakeup_thread(mddev->sync_thread);
+		md_wakeup_thread(&mddev->sync_thread, mddev);
 	sysfs_notify_dirent_safe(mddev->sysfs_action);
 	md_new_event();
 }
@@ -9534,7 +9538,7 @@ int rdev_set_badblocks(struct md_rdev *rdev, sector_t s, int sectors,
 		sysfs_notify_dirent_safe(rdev->sysfs_state);
 		set_mask_bits(&mddev->sb_flags, 0,
 			      BIT(MD_SB_CHANGE_CLEAN) | BIT(MD_SB_CHANGE_PENDING));
-		md_wakeup_thread(rdev->mddev->thread);
+		md_wakeup_thread(&rdev->mddev->thread, mddev);
 		return 1;
 	} else
 		return 0;
@@ -9699,7 +9703,7 @@ static void check_sb_changes(struct mddev *mddev, struct md_rdev *rdev)
 				/* wakeup mddev->thread here, so array could
 				 * perform resync with the new activated disk */
 				set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-				md_wakeup_thread(mddev->thread);
+				md_wakeup_thread(&mddev->thread, mddev);
 			}
 			/* device faulty
 			 * We just want to do the minimum to mark the disk
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 344e055e4d0f..aeb2fc6b65c7 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -734,7 +734,7 @@ int md_register_thread(struct md_thread **threadp,
 		       void (*run)(struct md_thread *thread),
 		       struct mddev *mddev, const char *name);
 extern void md_unregister_thread(struct md_thread **threadp);
-extern void md_wakeup_thread(struct md_thread *thread);
+extern void md_wakeup_thread(struct md_thread **threadp, struct mddev *mddev);
 extern void md_check_recovery(struct mddev *mddev);
 extern void md_reap_sync_thread(struct mddev *mddev);
 extern int mddev_init_writes_pending(struct mddev *mddev);
@@ -805,7 +805,7 @@ static inline void rdev_dec_pending(struct md_rdev *rdev, struct mddev *mddev)
 	int faulty = test_bit(Faulty, &rdev->flags);
 	if (atomic_dec_and_test(&rdev->nr_pending) && faulty) {
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 	}
 }
 
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 1217c1db0a40..391ff239c711 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -289,7 +289,7 @@ static void reschedule_retry(struct r1bio *r1_bio)
 	spin_unlock_irqrestore(&conf->device_lock, flags);
 
 	wake_up(&conf->wait_barrier);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread, mddev);
 }
 
 /*
@@ -1180,7 +1180,7 @@ static void raid1_unplug(struct blk_plug_cb *cb, bool from_schedule)
 		bio_list_merge(&conf->pending_bio_list, &plug->pending);
 		spin_unlock_irq(&conf->device_lock);
 		wake_up(&conf->wait_barrier);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 		kfree(plug);
 		return;
 	}
@@ -1585,7 +1585,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 			spin_lock_irqsave(&conf->device_lock, flags);
 			bio_list_add(&conf->pending_bio_list, mbio);
 			spin_unlock_irqrestore(&conf->device_lock, flags);
-			md_wakeup_thread(mddev->thread);
+			md_wakeup_thread(&mddev->thread, mddev);
 		}
 	}
 
@@ -2501,7 +2501,7 @@ static void handle_write_finished(struct r1conf *conf, struct r1bio *r1_bio)
 		 * get_unqueued_pending() == extra to be true.
 		 */
 		wake_up(&conf->wait_barrier);
-		md_wakeup_thread(conf->mddev->thread);
+		md_wakeup_thread(&conf->mddev->thread, conf->mddev);
 	} else {
 		if (test_bit(R1BIO_WriteError, &r1_bio->state))
 			close_write(r1_bio);
@@ -3344,7 +3344,7 @@ static int raid1_reshape(struct mddev *mddev)
 
 	set_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread, mddev);
 
 	mempool_exit(&oldpool);
 	return 0;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index f1e54c62f930..920e5722040f 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -309,7 +309,7 @@ static void reschedule_retry(struct r10bio *r10_bio)
 	/* wake up frozen array... */
 	wake_up(&conf->wait_barrier);
 
-	md_wakeup_thread(mddev->thread);
+	md_wakeup_thread(&mddev->thread, mddev);
 }
 
 /*
@@ -1114,7 +1114,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 		bio_list_merge(&conf->pending_bio_list, &plug->pending);
 		spin_unlock_irq(&conf->device_lock);
 		wake_up(&conf->wait_barrier);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 		kfree(plug);
 		return;
 	}
@@ -1329,7 +1329,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 		spin_lock_irqsave(&conf->device_lock, flags);
 		bio_list_add(&conf->pending_bio_list, mbio);
 		spin_unlock_irqrestore(&conf->device_lock, flags);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 	}
 }
 
@@ -1441,7 +1441,7 @@ static void raid10_write_request(struct mddev *mddev, struct bio *bio,
 		mddev->reshape_position = conf->reshape_progress;
 		set_mask_bits(&mddev->sb_flags, 0,
 			      BIT(MD_SB_CHANGE_DEVS) | BIT(MD_SB_CHANGE_PENDING));
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 		if (bio->bi_opf & REQ_NOWAIT) {
 			allow_barrier(conf);
 			bio_wouldblock_error(bio);
@@ -3079,7 +3079,7 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 			 * nr_pending == nr_queued + extra to be true.
 			 */
 			wake_up(&conf->wait_barrier);
-			md_wakeup_thread(conf->mddev->thread);
+			md_wakeup_thread(&conf->mddev->thread, conf->mddev);
 		} else {
 			if (test_bit(R10BIO_WriteError,
 				     &r10_bio->state))
@@ -4692,7 +4692,7 @@ static int raid10_start_reshape(struct mddev *mddev)
 		goto abort;
 	}
 	conf->reshape_checkpoint = jiffies;
-	md_wakeup_thread(mddev->sync_thread);
+	md_wakeup_thread(&mddev->sync_thread, mddev);
 	md_new_event();
 	return 0;
 
@@ -4874,7 +4874,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr,
 			mddev->curr_resync_completed = conf->reshape_progress;
 		conf->reshape_checkpoint = jiffies;
 		set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 		wait_event(mddev->sb_wait, mddev->sb_flags == 0 ||
 			   test_bit(MD_RECOVERY_INTR, &mddev->recovery));
 		if (test_bit(MD_RECOVERY_INTR, &mddev->recovery)) {
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 0464d4d551fc..d6ee6a7a83b7 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -600,7 +600,7 @@ static void r5l_log_endio(struct bio *bio)
 	spin_unlock_irqrestore(&log->io_list_lock, flags);
 
 	if (log->need_cache_flush)
-		md_wakeup_thread(log->rdev->mddev->thread);
+		md_wakeup_thread(&log->rdev->mddev->thread, log->rdev->mddev);
 
 	/* finish flush only io_unit and PAYLOAD_FLUSH only io_unit */
 	if (has_null_flush) {
@@ -1491,7 +1491,7 @@ static void r5c_do_reclaim(struct r5conf *conf)
 	if (!test_bit(R5C_LOG_CRITICAL, &conf->cache_state))
 		r5l_run_no_space_stripes(log);
 
-	md_wakeup_thread(conf->mddev->thread);
+	md_wakeup_thread(&conf->mddev->thread, conf->mddev);
 }
 
 static void r5l_do_reclaim(struct r5l_log *log)
@@ -1519,7 +1519,7 @@ static void r5l_do_reclaim(struct r5l_log *log)
 		     list_empty(&log->finished_ios)))
 			break;
 
-		md_wakeup_thread(log->rdev->mddev->thread);
+		md_wakeup_thread(&log->rdev->mddev->thread, log->rdev->mddev);
 		wait_event_lock_irq(log->iounit_wait,
 				    r5l_reclaimable_space(log) > reclaimable,
 				    log->io_list_lock);
@@ -1571,7 +1571,7 @@ void r5l_wake_reclaim(struct r5l_log *log, sector_t space)
 		if (new < target)
 			return;
 	} while (!try_cmpxchg(&log->reclaim_target, &target, new));
-	md_wakeup_thread(log->reclaim_thread);
+	md_wakeup_thread(&log->reclaim_thread, log->rdev->mddev);
 }
 
 void r5l_quiesce(struct r5l_log *log, int quiesce)
@@ -2776,7 +2776,7 @@ void r5c_release_extra_page(struct stripe_head *sh)
 
 	if (using_disk_info_extra_page) {
 		clear_bit(R5C_EXTRA_PAGE_IN_USE, &conf->cache_state);
-		md_wakeup_thread(conf->mddev->thread);
+		md_wakeup_thread(&conf->mddev->thread, conf->mddev);
 	}
 }
 
@@ -2832,7 +2832,7 @@ void r5c_finish_stripe_write_out(struct r5conf *conf,
 
 	if (test_and_clear_bit(STRIPE_FULL_WRITE, &sh->state))
 		if (atomic_dec_and_test(&conf->pending_full_writes))
-			md_wakeup_thread(conf->mddev->thread);
+			md_wakeup_thread(&conf->mddev->thread, conf->mddev);
 
 	if (do_wakeup)
 		wake_up(&conf->wait_for_overlap);
diff --git a/drivers/md/raid5-ppl.c b/drivers/md/raid5-ppl.c
index e495939bb3e0..47cf1e85c48d 100644
--- a/drivers/md/raid5-ppl.c
+++ b/drivers/md/raid5-ppl.c
@@ -601,7 +601,7 @@ static void ppl_flush_endio(struct bio *bio)
 
 	if (atomic_dec_and_test(&io->pending_flushes)) {
 		ppl_io_unit_finished(io);
-		md_wakeup_thread(conf->mddev->thread);
+		md_wakeup_thread(&conf->mddev->thread, conf->mddev);
 	}
 }
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 04b1093195d0..2c0695d41436 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -195,7 +195,7 @@ static void raid5_wakeup_stripe_thread(struct stripe_head *sh)
 	}
 
 	if (conf->worker_cnt_per_group == 0) {
-		md_wakeup_thread(conf->mddev->thread);
+		md_wakeup_thread(&conf->mddev->thread, conf->mddev);
 		return;
 	}
 
@@ -268,13 +268,14 @@ static void do_release_stripe(struct r5conf *conf, struct stripe_head *sh,
 				return;
 			}
 		}
-		md_wakeup_thread(conf->mddev->thread);
+		md_wakeup_thread(&conf->mddev->thread, conf->mddev);
 	} else {
 		BUG_ON(stripe_operations_active(sh));
 		if (test_and_clear_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
 			if (atomic_dec_return(&conf->preread_active_stripes)
 			    < IO_THRESHOLD)
-				md_wakeup_thread(conf->mddev->thread);
+				md_wakeup_thread(&conf->mddev->thread,
+						 conf->mddev);
 		atomic_dec(&conf->active_stripes);
 		if (!test_bit(STRIPE_EXPANDING, &sh->state)) {
 			if (!r5c_is_writeback(conf->log))
@@ -356,7 +357,7 @@ static void release_inactive_stripe_list(struct r5conf *conf,
 		if (atomic_read(&conf->active_stripes) == 0)
 			wake_up(&conf->wait_for_quiescent);
 		if (conf->retry_read_aligned)
-			md_wakeup_thread(conf->mddev->thread);
+			md_wakeup_thread(&conf->mddev->thread, conf->mddev);
 	}
 }
 
@@ -407,7 +408,7 @@ void raid5_release_stripe(struct stripe_head *sh)
 		goto slow_path;
 	wakeup = llist_add(&sh->release_list, &conf->released_stripes);
 	if (wakeup)
-		md_wakeup_thread(conf->mddev->thread);
+		md_wakeup_thread(&conf->mddev->thread, conf->mddev);
 	return;
 slow_path:
 	/* we are ok here if STRIPE_ON_RELEASE_LIST is set or not */
@@ -981,7 +982,7 @@ static void stripe_add_to_batch_list(struct r5conf *conf,
 	if (test_and_clear_bit(STRIPE_PREREAD_ACTIVE, &sh->state))
 		if (atomic_dec_return(&conf->preread_active_stripes)
 		    < IO_THRESHOLD)
-			md_wakeup_thread(conf->mddev->thread);
+			md_wakeup_thread(&conf->mddev->thread, conf->mddev);
 
 	if (test_and_clear_bit(STRIPE_BIT_DELAY, &sh->state)) {
 		int seq = sh->bm_seq;
@@ -3759,7 +3760,7 @@ handle_failed_stripe(struct r5conf *conf, struct stripe_head *sh,
 
 	if (test_and_clear_bit(STRIPE_FULL_WRITE, &sh->state))
 		if (atomic_dec_and_test(&conf->pending_full_writes))
-			md_wakeup_thread(conf->mddev->thread);
+			md_wakeup_thread(&conf->mddev->thread, conf->mddev);
 }
 
 static void
@@ -4156,7 +4157,7 @@ static void handle_stripe_clean_event(struct r5conf *conf,
 
 	if (test_and_clear_bit(STRIPE_FULL_WRITE, &sh->state))
 		if (atomic_dec_and_test(&conf->pending_full_writes))
-			md_wakeup_thread(conf->mddev->thread);
+			md_wakeup_thread(&conf->mddev->thread, conf->mddev);
 
 	if (head_sh->batch_head && do_endio)
 		break_stripe_batch_list(head_sh, STRIPE_EXPAND_SYNC_FLAGS);
@@ -5369,7 +5370,7 @@ static void handle_stripe(struct stripe_head *sh)
 		atomic_dec(&conf->preread_active_stripes);
 		if (atomic_read(&conf->preread_active_stripes) <
 		    IO_THRESHOLD)
-			md_wakeup_thread(conf->mddev->thread);
+			md_wakeup_thread(&conf->mddev->thread, conf->mddev);
 	}
 
 	clear_bit_unlock(STRIPE_ACTIVE, &sh->state);
@@ -5436,7 +5437,7 @@ static void add_bio_to_retry(struct bio *bi,struct r5conf *conf)
 	conf->retry_read_aligned_list = bi;
 
 	spin_unlock_irqrestore(&conf->device_lock, flags);
-	md_wakeup_thread(conf->mddev->thread);
+	md_wakeup_thread(&conf->mddev->thread, conf->mddev);
 }
 
 static struct bio *remove_bio_from_retry(struct r5conf *conf,
@@ -6045,7 +6046,7 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 		 * Stripe is busy expanding or add failed due to
 		 * overlap. Flush everything and wait a while.
 		 */
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 		ret = STRIPE_SCHEDULE_AND_RETRY;
 		goto out_release;
 	}
@@ -6345,7 +6346,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 
 		conf->reshape_checkpoint = jiffies;
 		set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 		wait_event(mddev->sb_wait, mddev->sb_flags == 0 ||
 			   test_bit(MD_RECOVERY_INTR, &mddev->recovery));
 		if (test_bit(MD_RECOVERY_INTR, &mddev->recovery))
@@ -6453,7 +6454,7 @@ static sector_t reshape_request(struct mddev *mddev, sector_t sector_nr, int *sk
 					rdev->recovery_offset = sector_nr;
 		conf->reshape_checkpoint = jiffies;
 		set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 		wait_event(mddev->sb_wait,
 			   !test_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags)
 			   || test_bit(MD_RECOVERY_INTR, &mddev->recovery));
@@ -8585,7 +8586,7 @@ static int raid5_start_reshape(struct mddev *mddev)
 		return -EAGAIN;
 	}
 	conf->reshape_checkpoint = jiffies;
-	md_wakeup_thread(mddev->sync_thread);
+	md_wakeup_thread(&mddev->sync_thread, mddev);
 	md_new_event();
 	return 0;
 }
@@ -8815,7 +8816,7 @@ static int raid5_check_reshape(struct mddev *mddev)
 			mddev->chunk_sectors = new_chunk;
 		}
 		set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
-		md_wakeup_thread(mddev->thread);
+		md_wakeup_thread(&mddev->thread, mddev);
 	}
 	return check_reshape(mddev);
 }
-- 
2.31.1

