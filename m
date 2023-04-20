Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B8D6E92C4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjDTLcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbjDTLbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:31:45 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D333592;
        Thu, 20 Apr 2023 04:31:21 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q2Fpq23yfz4f3tps;
        Thu, 20 Apr 2023 19:31:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7OAIkFkVY8hHw--.17021S10;
        Thu, 20 Apr 2023 19:31:16 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, neilb@suse.de, akpm@osdl.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 6/8] md/md-bitmap: support to unplug bitmap asynchrously
Date:   Thu, 20 Apr 2023 19:29:44 +0800
Message-Id: <20230420112946.2869956-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420112946.2869956-1-yukuai1@huaweicloud.com>
References: <20230420112946.2869956-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7OAIkFkVY8hHw--.17021S10
X-Coremail-Antispam: 1UD129KBjvJXoW3JF17try8KF4UGr1xGFyfWFg_yoWxJrWfpr
        Z8t3s0kr45JFW3Xw1fAry7CF1Fv3Wvqr9rJryfC3s8uFy3XF9xXF48GFWjyw1DCrsxGF43
        Zw1Yyr98Gr1fXF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
        CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
        14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
        IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAv
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

If bitmap is enabled, bitmap must update before submiting write io, this
is why unplug callback must move these io to 'conf->pending_io_list' if
'current->bio_list' is not empty, which will suffer performance
degeration.

This patch add a new helper md_bitmap_unplug_async() to submit bitmap io
in a kworker, so that submit bitmap io in raid10_unplug() doesn't require
that 'current->bio_list' is empty.

This patch prepare to limit the number of plugged bio.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c | 59 +++++++++++++++++++++++++++++++++++++++---
 drivers/md/md-bitmap.h |  3 +++
 drivers/md/raid1.c     |  3 ++-
 drivers/md/raid10.c    |  2 +-
 4 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 4bd980b272ef..da8ad2e95e88 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1000,10 +1000,18 @@ static int md_bitmap_file_test_bit(struct bitmap *bitmap, sector_t block)
 	return set;
 }
 
-/* this gets called when the md device is ready to unplug its underlying
+struct bitmap_unplug_work {
+	struct work_struct work;
+	struct bitmap *bitmap;
+	struct completion *done;
+};
+
+/*
+ * This gets called when the md device is ready to unplug its underlying
  * (slave) device queues -- before we let any writes go down, we need to
- * sync the dirty pages of the bitmap file to disk */
-void md_bitmap_unplug(struct bitmap *bitmap)
+ * sync the dirty pages of the bitmap file to disk.
+ */
+static void md_do_bitmap_unplug(struct bitmap *bitmap)
 {
 	unsigned long i;
 	int dirty, need_write;
@@ -1035,9 +1043,45 @@ void md_bitmap_unplug(struct bitmap *bitmap)
 
 	if (test_bit(BITMAP_WRITE_ERROR, &bitmap->flags))
 		md_bitmap_file_kick(bitmap);
+
+}
+static void md_bitmap_unplug_fn(struct work_struct *work)
+{
+	struct bitmap_unplug_work *unplug_work =
+		container_of(work, struct bitmap_unplug_work, work);
+
+	md_do_bitmap_unplug(unplug_work->bitmap);
+	complete(unplug_work->done);
+}
+
+static void __md_bitmap_unplug(struct bitmap *bitmap, bool async)
+{
+	DECLARE_COMPLETION_ONSTACK(done);
+	struct bitmap_unplug_work unplug_work;
+
+	if (!async)
+		return md_do_bitmap_unplug(bitmap);
+
+	INIT_WORK(&unplug_work.work, md_bitmap_unplug_fn);
+	unplug_work.bitmap = bitmap;
+	unplug_work.done = &done;
+
+	queue_work(bitmap->unplug_wq, &unplug_work.work);
+	wait_for_completion(&done);
+}
+
+void md_bitmap_unplug(struct bitmap *bitmap)
+{
+	return __md_bitmap_unplug(bitmap, false);
 }
 EXPORT_SYMBOL(md_bitmap_unplug);
 
+void md_bitmap_unplug_async(struct bitmap *bitmap)
+{
+	return __md_bitmap_unplug(bitmap, true);
+}
+EXPORT_SYMBOL(md_bitmap_unplug_async);
+
 static void md_bitmap_set_memory_bits(struct bitmap *bitmap, sector_t offset, int needed);
 /* * bitmap_init_from_disk -- called at bitmap_create time to initialize
  * the in-memory bitmap from the on-disk bitmap -- also, sets up the
@@ -1753,6 +1797,9 @@ void md_bitmap_free(struct bitmap *bitmap)
 	if (!bitmap) /* there was no bitmap */
 		return;
 
+	if (bitmap->unplug_wq)
+		destroy_workqueue(bitmap->unplug_wq);
+
 	if (bitmap->sysfs_can_clear)
 		sysfs_put(bitmap->sysfs_can_clear);
 
@@ -1843,6 +1890,12 @@ struct bitmap *md_bitmap_create(struct mddev *mddev, int slot)
 	if (!bitmap)
 		return ERR_PTR(-ENOMEM);
 
+	bitmap->unplug_wq = create_workqueue("md_bitmap");
+	if (!bitmap->unplug_wq) {
+		err  = -ENOMEM;
+		goto error;
+	}
+
 	spin_lock_init(&bitmap->counts.lock);
 	atomic_set(&bitmap->pending_writes, 0);
 	init_waitqueue_head(&bitmap->write_wait);
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 3a4750952b3a..55531669db24 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -231,6 +231,8 @@ struct bitmap {
 
 	struct kernfs_node *sysfs_can_clear;
 	int cluster_slot;		/* Slot offset for clustered env */
+
+	struct workqueue_struct *unplug_wq;
 };
 
 /* the bitmap API */
@@ -264,6 +266,7 @@ void md_bitmap_sync_with_cluster(struct mddev *mddev,
 				 sector_t new_lo, sector_t new_hi);
 
 void md_bitmap_unplug(struct bitmap *bitmap);
+void md_bitmap_unplug_async(struct bitmap *bitmap);
 void md_bitmap_daemon_work(struct mddev *mddev);
 
 int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index c068ed3e6c96..7389e599f34e 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -792,7 +792,6 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 static void flush_bio_list(struct r1conf *conf, struct bio *bio)
 {
 	/* flush any pending bitmap writes to disk before proceeding w/ I/O */
-	md_bitmap_unplug(conf->mddev->bitmap);
 	wake_up(&conf->wait_barrier);
 
 	while (bio) { /* submit pending writes */
@@ -829,6 +828,7 @@ static void flush_pending_writes(struct r1conf *conf)
 		 */
 		__set_current_state(TASK_RUNNING);
 		blk_start_plug(&plug);
+		md_bitmap_unplug(conf->mddev->bitmap);
 		flush_bio_list(conf, bio);
 		blk_finish_plug(&plug);
 	} else
@@ -1176,6 +1176,7 @@ static void raid1_unplug(struct blk_plug_cb *cb, bool from_schedule)
 
 	/* we aren't scheduling, so we can do the write-out directly. */
 	bio = bio_list_get(&plug->pending);
+	md_bitmap_unplug_async(conf->mddev->bitmap);
 	flush_bio_list(conf, bio);
 	kfree(plug);
 }
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index fd625026c97b..9f307ff5d4f6 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1113,7 +1113,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 
 	/* we aren't scheduling, so we can do the write-out directly. */
 	bio = bio_list_get(&plug->pending);
-	md_bitmap_unplug(mddev->bitmap);
+	md_bitmap_unplug_async(mddev->bitmap);
 	wake_up(&conf->wait_barrier);
 
 	while (bio) { /* submit pending writes */
-- 
2.39.2

