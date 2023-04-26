Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7AE6EF02D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240206AbjDZIW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240118AbjDZIW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:22:27 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E6A3591;
        Wed, 26 Apr 2023 01:22:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Q5sL54Zfhz4f4WY6;
        Wed, 26 Apr 2023 16:22:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP2 (Coremail) with SMTP id Syh0CgBnW+k430hkUexVIA--.50201S10;
        Wed, 26 Apr 2023 16:22:23 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, akpm@osdl.org, neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 6/7] md/raid1-10: don't handle pluged bio by daemon thread
Date:   Wed, 26 Apr 2023 16:20:30 +0800
Message-Id: <20230426082031.1299149-7-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230426082031.1299149-1-yukuai1@huaweicloud.com>
References: <20230426082031.1299149-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBnW+k430hkUexVIA--.50201S10
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4DAw1ruF48GFyfWrW8tFb_yoWrAF1xp3
        yYqa1YqrWUJFW5Xw4DZFW8uFyFq3WvgFZrAFZ5uws5uFy3XF9xWFWrGFW0q34DZrsxGFy7
        Ary5trWDGa1YvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9K14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

current->bio_list will be set under submit_bio() context, in this case
bitmap io will be added to the list and wait for current io submission to
finish, while current io submission must wait for bitmap io to be done.
commit 874807a83139 ("md/raid1{,0}: fix deadlock in bitmap_unplug.") fix
the deadlock by handling plugged bio by daemon thread.

On the one hand, the deadlock won't exist after commit a214b949d8e3
("blk-mq: only flush requests from the plug in blk_mq_submit_bio"). On
the other hand, current solution makes it impossible to flush plugged bio
in raid1/10_make_request(), because this will cause that all the writes
will goto daemon thread.

In order to limit the number of plugged bio, commit 874807a83139
("md/raid1{,0}: fix deadlock in bitmap_unplug.") is reverted, and the
deadlock is fixed by handling bitmap io asynchronously.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1-10.c | 14 ++++++++++++++
 drivers/md/raid1.c    |  4 ++--
 drivers/md/raid10.c   |  8 +++-----
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 4167bda139b1..98d678b7df3f 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -150,3 +150,17 @@ static inline bool md_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
 
 	return true;
 }
+
+/*
+ * current->bio_list will be set under submit_bio() context, in this case bitmap
+ * io will be added to the list and wait for current io submission to finish,
+ * while current io submission must wait for bitmap io to be done. In order to
+ * avoid such deadlock, submit bitmap io asynchronously.
+ */
+static inline void md_prepare_flush_writes(struct bitmap *bitmap)
+{
+	if (current->bio_list)
+		md_bitmap_unplug_async(bitmap);
+	else
+		md_bitmap_unplug(bitmap);
+}
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index d79525d6ec8f..639e09cecf01 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -794,7 +794,7 @@ static int read_balance(struct r1conf *conf, struct r1bio *r1_bio, int *max_sect
 static void flush_bio_list(struct r1conf *conf, struct bio *bio)
 {
 	/* flush any pending bitmap writes to disk before proceeding w/ I/O */
-	md_bitmap_unplug(conf->mddev->bitmap);
+	md_prepare_flush_writes(conf->mddev->bitmap);
 	wake_up(&conf->wait_barrier);
 
 	while (bio) { /* submit pending writes */
@@ -1166,7 +1166,7 @@ static void raid1_unplug(struct blk_plug_cb *cb, bool from_schedule)
 	struct r1conf *conf = mddev->private;
 	struct bio *bio;
 
-	if (from_schedule || current->bio_list) {
+	if (from_schedule) {
 		spin_lock_irq(&conf->device_lock);
 		bio_list_merge(&conf->pending_bio_list, &plug->pending);
 		spin_unlock_irq(&conf->device_lock);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 626cb8ed2099..bd9e655ca408 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -902,9 +902,7 @@ static void flush_pending_writes(struct r10conf *conf)
 		__set_current_state(TASK_RUNNING);
 
 		blk_start_plug(&plug);
-		/* flush any pending bitmap writes to disk
-		 * before proceeding w/ I/O */
-		md_bitmap_unplug(conf->mddev->bitmap);
+		md_prepare_flush_writes(conf->mddev->bitmap);
 		wake_up(&conf->wait_barrier);
 
 		while (bio) { /* submit pending writes */
@@ -1108,7 +1106,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 	struct r10conf *conf = mddev->private;
 	struct bio *bio;
 
-	if (from_schedule || current->bio_list) {
+	if (from_schedule) {
 		spin_lock_irq(&conf->device_lock);
 		bio_list_merge(&conf->pending_bio_list, &plug->pending);
 		spin_unlock_irq(&conf->device_lock);
@@ -1120,7 +1118,7 @@ static void raid10_unplug(struct blk_plug_cb *cb, bool from_schedule)
 
 	/* we aren't scheduling, so we can do the write-out directly. */
 	bio = bio_list_get(&plug->pending);
-	md_bitmap_unplug(mddev->bitmap);
+	md_prepare_flush_writes(mddev->bitmap);
 	wake_up(&conf->wait_barrier);
 
 	while (bio) { /* submit pending writes */
-- 
2.39.2

