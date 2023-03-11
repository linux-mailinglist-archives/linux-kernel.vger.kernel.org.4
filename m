Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3196B5A18
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 10:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbjCKJct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 04:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjCKJce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 04:32:34 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCC8DD344;
        Sat, 11 Mar 2023 01:32:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PYd4D279Bz4f3jJ5;
        Sat, 11 Mar 2023 17:32:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiCqSgxkFn3mEg--.16173S8;
        Sat, 11 Mar 2023 17:32:30 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 4/5] md: pass a mddev to md_unregister_thread()
Date:   Sat, 11 Mar 2023 17:31:47 +0800
Message-Id: <20230311093148.2595222-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230311093148.2595222-1-yukuai1@huaweicloud.com>
References: <20230311093148.2595222-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiCqSgxkFn3mEg--.16173S8
X-Coremail-Antispam: 1UD129KBjvJXoW3XF4fKw4kWw4ruw4fGFWDtwb_yoW3JrWUp3
        yrXFy3Ar4FvrW3Zr4DJayDuay5Z3WIqFWqyryfC3yrX3WfGrW5GFyY9FyDZr1DZa4rAr43
        ta15KF48ZFWvgr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
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

Prepare to use a disk level spinlock to protect md_thread, there are no
functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/dm-raid.c     |  2 +-
 drivers/md/md-cluster.c  |  8 ++++----
 drivers/md/md.c          | 13 +++++++------
 drivers/md/md.h          |  3 ++-
 drivers/md/raid1.c       |  4 ++--
 drivers/md/raid10.c      |  2 +-
 drivers/md/raid5-cache.c |  2 +-
 drivers/md/raid5.c       |  2 +-
 8 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 257c9c9f2b4d..1393c80b083b 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3729,7 +3729,7 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 	if (!strcasecmp(argv[0], "idle") || !strcasecmp(argv[0], "frozen")) {
 		if (mddev->sync_thread) {
 			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-			md_unregister_thread(&mddev->sync_thread);
+			md_unregister_thread(&mddev->sync_thread, mddev);
 			md_reap_sync_thread(mddev);
 		}
 	} else if (decipher_sync_action(mddev, mddev->recovery) != st_idle)
diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 92b0e49b4e53..4d538c9ab7b3 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -946,8 +946,8 @@ static int join(struct mddev *mddev, int nodes)
 	return 0;
 err:
 	set_bit(MD_CLUSTER_HOLDING_MUTEX_FOR_RECVD, &cinfo->state);
-	md_unregister_thread(&cinfo->recovery_thread);
-	md_unregister_thread(&cinfo->recv_thread);
+	md_unregister_thread(&cinfo->recovery_thread, mddev);
+	md_unregister_thread(&cinfo->recv_thread, mddev);
 	lockres_free(cinfo->message_lockres);
 	lockres_free(cinfo->token_lockres);
 	lockres_free(cinfo->ack_lockres);
@@ -1009,8 +1009,8 @@ static int leave(struct mddev *mddev)
 		resync_bitmap(mddev);
 
 	set_bit(MD_CLUSTER_HOLDING_MUTEX_FOR_RECVD, &cinfo->state);
-	md_unregister_thread(&cinfo->recovery_thread);
-	md_unregister_thread(&cinfo->recv_thread);
+	md_unregister_thread(&cinfo->recovery_thread, mddev);
+	md_unregister_thread(&cinfo->recv_thread, mddev);
 	lockres_free(cinfo->message_lockres);
 	lockres_free(cinfo->token_lockres);
 	lockres_free(cinfo->ack_lockres);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 4ecfd0508afb..ab9299187cfe 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -4775,7 +4775,8 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 
 				mddev_unlock(mddev);
 				set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-				md_unregister_thread(&mddev->sync_thread);
+				md_unregister_thread(&mddev->sync_thread,
+						     mddev);
 				mddev_lock_nointr(mddev);
 				/*
 				 * set RECOVERY_INTR again and restore reshape
@@ -6175,7 +6176,7 @@ static void __md_stop_writes(struct mddev *mddev)
 		flush_workqueue(md_misc_wq);
 	if (mddev->sync_thread) {
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-		md_unregister_thread(&mddev->sync_thread);
+		md_unregister_thread(&mddev->sync_thread, mddev);
 		md_reap_sync_thread(mddev);
 	}
 
@@ -6215,7 +6216,7 @@ static void mddev_detach(struct mddev *mddev)
 		mddev->pers->quiesce(mddev, 1);
 		mddev->pers->quiesce(mddev, 0);
 	}
-	md_unregister_thread(&mddev->thread);
+	md_unregister_thread(&mddev->thread, mddev);
 	if (mddev->queue)
 		blk_sync_queue(mddev->queue); /* the unplug fn references 'conf'*/
 }
@@ -7933,7 +7934,7 @@ int md_register_thread(struct md_thread **threadp,
 }
 EXPORT_SYMBOL(md_register_thread);
 
-void md_unregister_thread(struct md_thread **threadp)
+void md_unregister_thread(struct md_thread **threadp, struct mddev *mddev)
 {
 	struct md_thread *thread;
 
@@ -9324,7 +9325,7 @@ void md_check_recovery(struct mddev *mddev)
 			 * ->spare_active and clear saved_raid_disk
 			 */
 			set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-			md_unregister_thread(&mddev->sync_thread);
+			md_unregister_thread(&mddev->sync_thread, mddev);
 			md_reap_sync_thread(mddev);
 			clear_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
 			clear_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
@@ -9360,7 +9361,7 @@ void md_check_recovery(struct mddev *mddev)
 			goto unlock;
 		}
 		if (mddev->sync_thread) {
-			md_unregister_thread(&mddev->sync_thread);
+			md_unregister_thread(&mddev->sync_thread, mddev);
 			md_reap_sync_thread(mddev);
 			goto unlock;
 		}
diff --git a/drivers/md/md.h b/drivers/md/md.h
index aeb2fc6b65c7..8f4137ad2dde 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -733,7 +733,8 @@ extern void md_cluster_stop(struct mddev *mddev);
 int md_register_thread(struct md_thread **threadp,
 		       void (*run)(struct md_thread *thread),
 		       struct mddev *mddev, const char *name);
-extern void md_unregister_thread(struct md_thread **threadp);
+extern void md_unregister_thread(struct md_thread **threadp,
+				 struct mddev *mddev);
 extern void md_wakeup_thread(struct md_thread **threadp, struct mddev *mddev);
 extern void md_check_recovery(struct mddev *mddev);
 extern void md_reap_sync_thread(struct mddev *mddev);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 391ff239c711..8329a1ba9d12 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3158,7 +3158,7 @@ static int raid1_run(struct mddev *mddev)
 	 * RAID1 needs at least one disk in active
 	 */
 	if (conf->raid_disks - mddev->degraded < 1) {
-		md_unregister_thread(&conf->thread);
+		md_unregister_thread(&conf->thread, mddev);
 		ret = -EINVAL;
 		goto abort;
 	}
@@ -3185,7 +3185,7 @@ static int raid1_run(struct mddev *mddev)
 
 	ret = md_integrity_register(mddev);
 	if (ret) {
-		md_unregister_thread(&mddev->thread);
+		md_unregister_thread(&mddev->thread, mddev);
 		goto abort;
 	}
 	return 0;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 920e5722040f..47d18d56000e 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4293,7 +4293,7 @@ static int raid10_run(struct mddev *mddev)
 	return 0;
 
 out_free_conf:
-	md_unregister_thread(&mddev->thread);
+	md_unregister_thread(&mddev->thread, mddev);
 	raid10_free_conf(conf);
 	mddev->private = NULL;
 out:
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index d6ee6a7a83b7..588c3d1f7467 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -3166,7 +3166,7 @@ void r5l_exit_log(struct r5conf *conf)
 	/* Ensure disable_writeback_work wakes up and exits */
 	wake_up(&conf->mddev->sb_wait);
 	flush_work(&log->disable_writeback_work);
-	md_unregister_thread(&log->reclaim_thread);
+	md_unregister_thread(&log->reclaim_thread, conf->mddev);
 
 	conf->log = NULL;
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 2c0695d41436..b9f2688b141f 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -8070,7 +8070,7 @@ static int raid5_run(struct mddev *mddev)
 
 	return 0;
 abort:
-	md_unregister_thread(&mddev->thread);
+	md_unregister_thread(&mddev->thread, mddev);
 	print_raid5_conf(conf);
 	free_conf(conf);
 	mddev->private = NULL;
-- 
2.31.1

