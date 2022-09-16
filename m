Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087095BAC52
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiIPLYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiIPLXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:23:38 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D2F79623;
        Fri, 16 Sep 2022 04:23:36 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MTWqS3HndzKNp7;
        Fri, 16 Sep 2022 19:21:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgDXKXOzXCRjdyK5Aw--.60594S9;
        Fri, 16 Sep 2022 19:23:35 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, logang@deltatee.com, guoqing.jiang@linux.dev,
        pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v3 5/5] md/raid10: convert resync_lock to use seqlock
Date:   Fri, 16 Sep 2022 19:34:28 +0800
Message-Id: <20220916113428.774061-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220916113428.774061-1-yukuai1@huaweicloud.com>
References: <20220916113428.774061-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDXKXOzXCRjdyK5Aw--.60594S9
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw45Gr47JF4ftryruFWfXwb_yoWxWFWUpw
        4aqr15tFWUXrs0qr4DJa1q9r1Fgw4kKa47Ka9ru3WkZFs5tryfWF1UGr9Ygryqvr9xJFyv
        qFWrCFWfGw17tFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9E14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14
        v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZX7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently, wait_barrier() will hold 'resync_lock' to read 'conf->barrier',
and io can't be dispatched until 'barrier' is dropped.

Since holding the 'barrier' is not common, convert 'resync_lock' to use
seqlock so that holding lock can be avoided in fast path.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid10.c | 87 ++++++++++++++++++++++++++++++---------------
 drivers/md/raid10.h |  2 +-
 2 files changed, 59 insertions(+), 30 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 9a28abd19709..2daa7d57034c 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -79,6 +79,21 @@ static void end_reshape(struct r10conf *conf);
 
 #include "raid1-10.c"
 
+#define NULL_CMD
+#define cmd_before(conf, cmd) \
+	do { \
+		write_sequnlock_irq(&(conf)->resync_lock); \
+		cmd; \
+	} while (0)
+#define cmd_after(conf) write_seqlock_irq(&(conf)->resync_lock)
+
+#define wait_event_barrier_cmd(conf, cond, cmd) \
+	wait_event_cmd((conf)->wait_barrier, cond, cmd_before(conf, cmd), \
+		       cmd_after(conf))
+
+#define wait_event_barrier(conf, cond) \
+	wait_event_barrier_cmd(conf, cond, NULL_CMD)
+
 /*
  * for resync bio, r10bio pointer can be retrieved from the per-bio
  * 'struct resync_pages'.
@@ -936,30 +951,29 @@ static void flush_pending_writes(struct r10conf *conf)
 
 static void raise_barrier(struct r10conf *conf, int force)
 {
-	spin_lock_irq(&conf->resync_lock);
+	write_seqlock_irq(&conf->resync_lock);
 	BUG_ON(force && !conf->barrier);
 
 	/* Wait until no block IO is waiting (unless 'force') */
-	wait_event_lock_irq(conf->wait_barrier, force || !conf->nr_waiting,
-			    conf->resync_lock);
+	wait_event_barrier(conf, force || !conf->nr_waiting);
 
 	/* block any new IO from starting */
-	conf->barrier++;
+	WRITE_ONCE(conf->barrier, conf->barrier + 1);
 
 	/* Now wait for all pending IO to complete */
-	wait_event_lock_irq(conf->wait_barrier,
-			    !atomic_read(&conf->nr_pending) && conf->barrier < RESYNC_DEPTH,
-			    conf->resync_lock);
+	wait_event_barrier(conf, !atomic_read(&conf->nr_pending) &&
+				 conf->barrier < RESYNC_DEPTH);
 
-	spin_unlock_irq(&conf->resync_lock);
+	write_sequnlock_irq(&conf->resync_lock);
 }
 
 static void lower_barrier(struct r10conf *conf)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&conf->resync_lock, flags);
-	conf->barrier--;
-	spin_unlock_irqrestore(&conf->resync_lock, flags);
+
+	write_seqlock_irqsave(&conf->resync_lock, flags);
+	WRITE_ONCE(conf->barrier, conf->barrier - 1);
+	write_sequnlock_irqrestore(&conf->resync_lock, flags);
 	wake_up(&conf->wait_barrier);
 }
 
@@ -990,11 +1004,31 @@ static bool stop_waiting_barrier(struct r10conf *conf)
 	return false;
 }
 
+static bool wait_barrier_nolock(struct r10conf *conf)
+{
+	unsigned int seq = read_seqbegin(&conf->resync_lock);
+
+	if (READ_ONCE(conf->barrier))
+		return false;
+
+	atomic_inc(&conf->nr_pending);
+	if (!read_seqretry(&conf->resync_lock, seq))
+		return true;
+
+	if (atomic_dec_and_test(&conf->nr_pending))
+		wake_up_barrier(conf);
+
+	return false;
+}
+
 static bool wait_barrier(struct r10conf *conf, bool nowait)
 {
 	bool ret = true;
 
-	spin_lock_irq(&conf->resync_lock);
+	if (wait_barrier_nolock(conf))
+		return true;
+
+	write_seqlock_irq(&conf->resync_lock);
 	if (conf->barrier) {
 		/* Return false when nowait flag is set */
 		if (nowait) {
@@ -1002,9 +1036,7 @@ static bool wait_barrier(struct r10conf *conf, bool nowait)
 		} else {
 			conf->nr_waiting++;
 			raid10_log(conf->mddev, "wait barrier");
-			wait_event_lock_irq(conf->wait_barrier,
-					    stop_waiting_barrier(conf),
-					    conf->resync_lock);
+			wait_event_barrier(conf, stop_waiting_barrier(conf));
 			conf->nr_waiting--;
 		}
 		if (!conf->nr_waiting)
@@ -1013,7 +1045,7 @@ static bool wait_barrier(struct r10conf *conf, bool nowait)
 	/* Only increment nr_pending when we wait */
 	if (ret)
 		atomic_inc(&conf->nr_pending);
-	spin_unlock_irq(&conf->resync_lock);
+	write_sequnlock_irq(&conf->resync_lock);
 	return ret;
 }
 
@@ -1038,27 +1070,24 @@ static void freeze_array(struct r10conf *conf, int extra)
 	 * must match the number of pending IOs (nr_pending) before
 	 * we continue.
 	 */
-	spin_lock_irq(&conf->resync_lock);
+	write_seqlock_irq(&conf->resync_lock);
 	conf->array_freeze_pending++;
-	conf->barrier++;
+	WRITE_ONCE(conf->barrier, conf->barrier + 1);
 	conf->nr_waiting++;
-	wait_event_lock_irq_cmd(conf->wait_barrier,
-				atomic_read(&conf->nr_pending) == conf->nr_queued+extra,
-				conf->resync_lock,
-				flush_pending_writes(conf));
-
+	wait_event_barrier_cmd(conf, atomic_read(&conf->nr_pending) ==
+			conf->nr_queued + extra, flush_pending_writes(conf));
 	conf->array_freeze_pending--;
-	spin_unlock_irq(&conf->resync_lock);
+	write_sequnlock_irq(&conf->resync_lock);
 }
 
 static void unfreeze_array(struct r10conf *conf)
 {
 	/* reverse the effect of the freeze */
-	spin_lock_irq(&conf->resync_lock);
-	conf->barrier--;
+	write_seqlock_irq(&conf->resync_lock);
+	WRITE_ONCE(conf->barrier, conf->barrier - 1);
 	conf->nr_waiting--;
 	wake_up(&conf->wait_barrier);
-	spin_unlock_irq(&conf->resync_lock);
+	write_sequnlock_irq(&conf->resync_lock);
 }
 
 static sector_t choose_data_offset(struct r10bio *r10_bio,
@@ -4044,7 +4073,7 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 	INIT_LIST_HEAD(&conf->retry_list);
 	INIT_LIST_HEAD(&conf->bio_end_io_list);
 
-	spin_lock_init(&conf->resync_lock);
+	seqlock_init(&conf->resync_lock);
 	init_waitqueue_head(&conf->wait_barrier);
 	atomic_set(&conf->nr_pending, 0);
 
@@ -4363,7 +4392,7 @@ static void *raid10_takeover_raid0(struct mddev *mddev, sector_t size, int devs)
 				rdev->new_raid_disk = rdev->raid_disk * 2;
 				rdev->sectors = size;
 			}
-		conf->barrier = 1;
+		WRITE_ONCE(conf->barrier, 1);
 	}
 
 	return conf;
diff --git a/drivers/md/raid10.h b/drivers/md/raid10.h
index 5c0804d8bb1f..8c072ce0bc54 100644
--- a/drivers/md/raid10.h
+++ b/drivers/md/raid10.h
@@ -76,7 +76,7 @@ struct r10conf {
 	/* queue pending writes and submit them on unplug */
 	struct bio_list		pending_bio_list;
 
-	spinlock_t		resync_lock;
+	seqlock_t		resync_lock;
 	atomic_t		nr_pending;
 	int			nr_waiting;
 	int			nr_queued;
-- 
2.31.1

