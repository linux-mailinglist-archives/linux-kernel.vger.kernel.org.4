Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001E26C43CA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 08:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCVHCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 03:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjCVHB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 03:01:57 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90545B5F3;
        Wed, 22 Mar 2023 00:01:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PhJmn4w7pz4f3l6q;
        Wed, 22 Mar 2023 14:42:17 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgC3YiBHoxpkI55qFQ--.38915S8;
        Wed, 22 Mar 2023 14:42:19 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     guoqing.jiang@linux.dev, logang@deltatee.com,
        pmenzel@molgen.mpg.de, agk@redhat.com, snitzer@kernel.org,
        song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 4/6] md: refactor idle/frozen_sync_thread()
Date:   Wed, 22 Mar 2023 14:41:20 +0800
Message-Id: <20230322064122.2384589-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
References: <20230322064122.2384589-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgC3YiBHoxpkI55qFQ--.38915S8
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4xKr4xWF4DXF1kCF4kJFb_yoWrtr48pa
        yxtFn5Ar4UArW3ZrsrJ3Zrua4rZw109a9rtrW3ua4xArnagr43tF15uFy8ZFykZaySyr45
        X3WrXay3ZFWUWr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
        X7UUUUU==
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

Our test found a following deadlock in raid10:

1) Issue a normal write, and such write failed:

  raid10_end_write_request
   set_bit(R10BIO_WriteError, &r10_bio->state)
   one_write_done
    reschedule_retry

  // later from md thread
  raid10d
   handle_write_completed
    list_add(&r10_bio->retry_list, &conf->bio_end_io_list)

  // later from md thread
  raid10d
   if (!test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
    list_move(conf->bio_end_io_list.prev, &tmp)
    r10_bio = list_first_entry(&tmp, struct r10bio, retry_list)
    raid_end_bio_io(r10_bio)

Dependency chain 1: normal io is waiting for updating superblock

2) Trigger a recovery:

  raid10_sync_request
   raise_barrier

Dependency chain 2: sync thread is waiting for normal io

3) echo idle/frozen to sync_action:

  action_store
   mddev_lock
    md_unregister_thread
     kthread_stop

Dependency chain 3: drop 'reconfig_mutex' is waiting for sync thread

4) md thread can't update superblock:

  raid10d
   md_check_recovery
    if (mddev_trylock(mddev))
     md_update_sb

Dependency chain 4: update superblock is waiting for 'reconfig_mutex'

Hence cyclic dependency exist, in order to fix the problem, we must
break one of them. Dependency 1 and 2 can't be broken because they are
foundation design. Dependency 4 may be possible if it can be guaranteed
that no io can be inflight, however, this requires a new mechanism which
seems complex. Dependency 3 is a good choice, because idle/frozen only
requires sync thread to finish, which can be done asynchronously that is
already implemented, and 'reconfig_mutex' is not needed anymore.

This patch switch 'idle' and 'frozen' to wait sync thread to be done
asynchronously, and this patch also add a sequence counter to record how
many times sync thread is done, so that 'idle' won't keep waiting on new
started sync thread.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 24 ++++++++++++++++++++----
 drivers/md/md.h |  2 ++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 223c03149852..ddf33a11d8de 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -662,6 +662,7 @@ void mddev_init(struct mddev *mddev)
 	timer_setup(&mddev->safemode_timer, md_safemode_timeout, 0);
 	atomic_set(&mddev->active, 1);
 	atomic_set(&mddev->openers, 0);
+	atomic_set(&mddev->sync_seq, 0);
 	spin_lock_init(&mddev->lock);
 	atomic_set(&mddev->flush_pending, 0);
 	init_waitqueue_head(&mddev->sb_wait);
@@ -4774,19 +4775,28 @@ static void stop_sync_thread(struct mddev *mddev)
 	if (work_pending(&mddev->del_work))
 		flush_workqueue(md_misc_wq);
 
-	if (mddev->sync_thread) {
-		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-		md_reap_sync_thread(mddev);
-	}
+	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
+	/*
+	 * Thread might be blocked waiting for metadata update which will now
+	 * never happen.
+	 */
+	if (mddev->sync_thread)
+		wake_up_process(mddev->sync_thread->tsk);
 
 	mddev_unlock(mddev);
 }
 
 static void idle_sync_thread(struct mddev *mddev)
 {
+	int sync_seq = atomic_read(&mddev->sync_seq);
+
 	mutex_lock(&mddev->sync_mutex);
 	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	stop_sync_thread(mddev);
+
+	wait_event(resync_wait, sync_seq != atomic_read(&mddev->sync_seq) ||
+			!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
+
 	mutex_unlock(&mddev->sync_mutex);
 }
 
@@ -4795,6 +4805,10 @@ static void frozen_sync_thread(struct mddev *mddev)
 	mutex_lock(&mddev->sync_mutex);
 	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	stop_sync_thread(mddev);
+
+	wait_event(resync_wait, mddev->sync_thread == NULL &&
+			!test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
+
 	mutex_unlock(&mddev->sync_mutex);
 }
 
@@ -9451,6 +9465,8 @@ void md_reap_sync_thread(struct mddev *mddev)
 
 	/* resync has finished, collect result */
 	md_unregister_thread(&mddev->sync_thread);
+	atomic_inc(&mddev->sync_seq);
+
 	if (!test_bit(MD_RECOVERY_INTR, &mddev->recovery) &&
 	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery) &&
 	    mddev->degraded != mddev->raid_disks) {
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 64474e458545..10d425a3daa3 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -537,6 +537,8 @@ struct mddev {
 
 	/* Used to synchronize idle and frozen for action_store() */
 	struct mutex sync_mutex;
+	/* The sequence number for sync thread */
+	atomic_t sync_seq;
 };
 
 enum recovery_flags {
-- 
2.31.1

