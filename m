Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C54F6D3674
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 11:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDBJNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 05:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjDBJNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 05:13:11 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BAACC36;
        Sun,  2 Apr 2023 02:13:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Pq7bg22Y6z4f3lKM;
        Sun,  2 Apr 2023 17:13:03 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7MeRylkVUE8Gg--.50168S7;
        Sun, 02 Apr 2023 17:13:05 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     logang@deltatee.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v4 3/5] md: add a helper to access md_thread() directly
Date:   Sun,  2 Apr 2023 17:12:34 +0800
Message-Id: <20230402091236.976723-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230402091236.976723-1-yukuai1@huaweicloud.com>
References: <20230402091236.976723-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7MeRylkVUE8Gg--.50168S7
X-Coremail-Antispam: 1UD129KBjvJXoWxuFy5tw18ZFWrWry5Jr4ktFb_yoWrCFy8pa
        yvqFyY9w48AFW3Zr1DAaykuFyFqwn2gF9rKryfC3yrC3W5G398Jry5CFyjyr1DZF1FyF43
        tF15Kr48GF4vgr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9v14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
        W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbJ73DUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.0 required=5.0 tests=KHOP_HELO_FCRDNS,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

In some context it's safe to access md_thread directly without
protection, this patch add a helper to do that. There are no functional
changes, prepare to protect md_thread with rcu.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c   | 7 ++++---
 drivers/md/md.c          | 4 +++-
 drivers/md/md.h          | 6 ++++++
 drivers/md/raid10.c      | 2 +-
 drivers/md/raid5-cache.c | 7 ++++---
 5 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index e7cc6ba1b657..f670c72d97be 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1246,7 +1246,7 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 
 	bitmap->daemon_lastrun = jiffies;
 	if (bitmap->allclean) {
-		mddev->thread->timeout = MAX_SCHEDULE_TIMEOUT;
+		get_md_thread(mddev->thread)->timeout = MAX_SCHEDULE_TIMEOUT;
 		goto done;
 	}
 	bitmap->allclean = 1;
@@ -1343,7 +1343,7 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 
  done:
 	if (bitmap->allclean == 0)
-		mddev->thread->timeout =
+		get_md_thread(mddev->thread)->timeout =
 			mddev->bitmap_info.daemon_sleep;
 	mutex_unlock(&mddev->bitmap_info.mutex);
 }
@@ -1941,7 +1941,8 @@ int md_bitmap_load(struct mddev *mddev)
 	/* Kick recovery in case any bits were set */
 	set_bit(MD_RECOVERY_NEEDED, &bitmap->mddev->recovery);
 
-	mddev->thread->timeout = mddev->bitmap_info.daemon_sleep;
+	get_md_thread(mddev->thread)->timeout =
+				mddev->bitmap_info.daemon_sleep;
 	md_wakeup_thread(mddev->thread);
 
 	md_bitmap_update_sb(bitmap);
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 139c7b0202e3..d5a29ccb24ec 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -458,7 +458,9 @@ static void md_submit_bio(struct bio *bio)
  */
 void mddev_suspend(struct mddev *mddev)
 {
-	WARN_ON_ONCE(mddev->thread && current == mddev->thread->tsk);
+	struct md_thread *thread = get_md_thread(mddev->thread);
+
+	WARN_ON_ONCE(thread && current == thread->tsk);
 	lockdep_assert_held(&mddev->reconfig_mutex);
 	if (mddev->suspended++)
 		return;
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 344e055e4d0f..5acdd704a922 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -718,6 +718,12 @@ struct md_io_acct {
 
 #define THREAD_WAKEUP  0
 
+/* caller need to make sured returned md_thread won't be freed */
+static inline struct md_thread *get_md_thread(struct md_thread *t)
+{
+	return t;
+}
+
 static inline void safe_put_page(struct page *p)
 {
 	if (p) put_page(p);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 0171ba4f19b0..fc8d07fb1c7d 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -996,7 +996,7 @@ static bool stop_waiting_barrier(struct r10conf *conf)
 		return true;
 
 	/* move on if recovery thread is blocked by us */
-	if (conf->mddev->thread->tsk == current &&
+	if (get_md_thread(conf->mddev->thread)->tsk == current &&
 	    test_bit(MD_RECOVERY_RUNNING, &conf->mddev->recovery) &&
 	    conf->nr_queued > 0)
 		return true;
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 0464d4d551fc..7e45df3e093f 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -1582,11 +1582,11 @@ void r5l_quiesce(struct r5l_log *log, int quiesce)
 		/* make sure r5l_write_super_and_discard_space exits */
 		mddev = log->rdev->mddev;
 		wake_up(&mddev->sb_wait);
-		kthread_park(log->reclaim_thread->tsk);
+		kthread_park(get_md_thread(log->reclaim_thread)->tsk);
 		r5l_wake_reclaim(log, MaxSector);
 		r5l_do_reclaim(log);
 	} else
-		kthread_unpark(log->reclaim_thread->tsk);
+		kthread_unpark(get_md_thread(log->reclaim_thread)->tsk);
 }
 
 bool r5l_log_disk_error(struct r5conf *conf)
@@ -3124,7 +3124,8 @@ int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev)
 	if (md_register_thread(&log->reclaim_thread, r5l_reclaim_thread,
 			       log->rdev->mddev, "reclaim"))
 		goto reclaim_thread;
-	log->reclaim_thread->timeout = R5C_RECLAIM_WAKEUP_INTERVAL;
+	get_md_thread(log->reclaim_thread)->timeout =
+				R5C_RECLAIM_WAKEUP_INTERVAL;
 
 	init_waitqueue_head(&log->iounit_wait);
 
-- 
2.39.2

