Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37FB5B7E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiINBia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiINBiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:38:21 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A759C6A481;
        Tue, 13 Sep 2022 18:38:18 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MS2x50rKPz6S3MZ;
        Wed, 14 Sep 2022 09:36:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgDHGXOGMCFj24dCAw--.23886S6;
        Wed, 14 Sep 2022 09:38:17 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, logang@deltatee.com, guoqing.jiang@linux.dev,
        pmenzel@molgen.mpg.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH v2 2/4] md/raid10: prevent unnecessary calls to wake_up() in fast path
Date:   Wed, 14 Sep 2022 09:49:12 +0800
Message-Id: <20220914014914.398712-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914014914.398712-1-yukuai1@huaweicloud.com>
References: <20220914014914.398712-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDHGXOGMCFj24dCAw--.23886S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4fXF13JrWruF1UJr18Xwb_yoWrAr48p3
        yaqF45tFW5ZFZ0qw4DJFWUu3Wjgw1ktFWIkFWvk3s7ZFn5tryftF1UGFyqkryqvrZ3uryU
        ZFWayrWfGw48tFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Currently, wake_up() is called unconditionally in fast path such as
raid10_make_request(), which will cause lock contention under high
concurrency:

raid10_make_request
 wake_up
  __wake_up_common_lock
   spin_lock_irqsave

Improve performance by only call wake_up() if waitqueue is not empty.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid10.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 56458a53043d..0edcd98461fe 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -274,6 +274,12 @@ static void put_buf(struct r10bio *r10_bio)
 	lower_barrier(conf);
 }
 
+static void wake_up_barrier(struct r10conf *conf)
+{
+	if (wq_has_sleeper(&conf->wait_barrier))
+		wake_up(&conf->wait_barrier);
+}
+
 static void reschedule_retry(struct r10bio *r10_bio)
 {
 	unsigned long flags;
@@ -286,7 +292,7 @@ static void reschedule_retry(struct r10bio *r10_bio)
 	spin_unlock_irqrestore(&conf->device_lock, flags);
 
 	/* wake up frozen array... */
-	wake_up(&conf->wait_barrier);
+	wake_up_barrier(conf);
 
 	md_wakeup_thread(mddev->thread);
 }
@@ -884,7 +890,7 @@ static void flush_pending_writes(struct r10conf *conf)
 		/* flush any pending bitmap writes to disk
 		 * before proceeding w/ I/O */
 		md_bitmap_unplug(conf->mddev->bitmap);
-		wake_up(&conf->wait_barrier);
+		wake_up_barrier(conf);
 
 		while (bio) { /* submit pending writes */
 			struct bio *next = bio->bi_next;
@@ -954,7 +960,7 @@ static void lower_barrier(struct r10conf *conf)
 	spin_lock_irqsave(&conf->resync_lock, flags);
 	conf->barrier--;
 	spin_unlock_irqrestore(&conf->resync_lock, flags);
-	wake_up(&conf->wait_barrier);
+	wake_up_barrier(conf);
 }
 
 static bool stop_waiting_barrier(struct r10conf *conf)
@@ -1004,7 +1010,7 @@ static bool wait_barrier(struct r10conf *conf, bool nowait)
 			conf->nr_waiting--;
 		}
 		if (!conf->nr_waiting)
-			wake_up(&conf->wait_barrier);
+			wake_up_barrier(conf);
 	}
 	/* Only increment nr_pending when we wait */
 	if (ret)
@@ -1017,7 +1023,7 @@ static void allow_barrier(struct r10conf *conf)
 {
 	if ((atomic_dec_and_test(&conf->nr_pending)) ||
 			(conf->array_freeze_pending))
-		wake_up(&conf->wait_barrier);
+		wake_up_barrier(conf);
 }
 
 static void freeze_array(struct r10conf *conf, int extra)
@@ -1053,7 +1059,7 @@ static void unfreeze_array(struct r10conf *conf)
 	spin_lock_irq(&conf->resync_lock);
 	conf->barrier--;
 	conf->nr_waiting--;
-	wake_up(&conf->wait_barrier);
+	wake_up_barrier(conf);
 	spin_unlock_irq(&conf->resync_lock);
 }
 
@@ -1078,7 +1084,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 		spin_lock_irq(&conf->device_lock);
 		bio_list_merge(&conf->pending_bio_list, &plug->pending);
 		spin_unlock_irq(&conf->device_lock);
-		wake_up(&conf->wait_barrier);
+		wake_up_barrier(conf);
 		md_wakeup_thread(mddev->thread);
 		kfree(plug);
 		return;
@@ -1087,7 +1093,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 	/* we aren't scheduling, so we can do the write-out directly. */
 	bio = bio_list_get(&plug->pending);
 	md_bitmap_unplug(mddev->bitmap);
-	wake_up(&conf->wait_barrier);
+	wake_up_barrier(conf);
 
 	while (bio) { /* submit pending writes */
 		struct bio *next = bio->bi_next;
@@ -1893,7 +1899,7 @@ static bool raid10_make_request(struct mddev *mddev, struct bio *bio)
 	__make_request(mddev, bio, sectors);
 
 	/* In case raid10d snuck in to freeze_array */
-	wake_up(&conf->wait_barrier);
+	wake_up_barrier(conf);
 	return true;
 }
 
@@ -3040,7 +3046,7 @@ static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
 			 * In case freeze_array() is waiting for condition
 			 * nr_pending == nr_queued + extra to be true.
 			 */
-			wake_up(&conf->wait_barrier);
+			wake_up_barrier(conf);
 			md_wakeup_thread(conf->mddev->thread);
 		} else {
 			if (test_bit(R10BIO_WriteError,
-- 
2.31.1

