Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF55C6E92BE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 13:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbjDTLbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 07:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDTLbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 07:31:43 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C1C30F5;
        Thu, 20 Apr 2023 04:31:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q2Fpn6qSpz4f3r7S;
        Thu, 20 Apr 2023 19:31:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7OAIkFkVY8hHw--.17021S7;
        Thu, 20 Apr 2023 19:31:15 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, neilb@suse.de, akpm@osdl.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 3/8] md/raid1-10: factor out a helper to add bio to plug
Date:   Thu, 20 Apr 2023 19:29:41 +0800
Message-Id: <20230420112946.2869956-4-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420112946.2869956-1-yukuai1@huaweicloud.com>
References: <20230420112946.2869956-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7OAIkFkVY8hHw--.17021S7
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWUXw1UAF1kAryDJFWxCrg_yoW5uFWfpa
        15Ka4avrWDXrW5Xw4kJF4DuFy5K3ZIgFZFkr93C3s3JFy7XFWUGa15JFWrCrn8uFZxury7
        Jwn0krZrGa13KFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
        x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUd8n5UUUUU=
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

The code in raid1 and raid10 is identical, prepare to limit the number
of pluged bios.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1-10.h | 16 ++++++++++++++++
 drivers/md/raid1.c    | 12 +-----------
 drivers/md/raid10.c   | 11 +----------
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/md/raid1-10.h b/drivers/md/raid1-10.h
index 04beef35142d..664646a3591a 100644
--- a/drivers/md/raid1-10.h
+++ b/drivers/md/raid1-10.h
@@ -112,4 +112,20 @@ static inline void md_bio_reset_resync_pages(struct bio *bio,
 		size -= len;
 	} while (idx++ < RESYNC_PAGES && size > 0);
 }
+
+static inline bool md_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
+				      blk_plug_cb_fn unplug)
+{
+	struct raid1_plug_cb *plug = NULL;
+	struct blk_plug_cb *cb = blk_check_plugged(unplug, mddev,
+						   sizeof(*plug));
+
+	if (!cb)
+		return false;
+
+	plug = container_of(cb, struct raid1_plug_cb, cb);
+	bio_list_add(&plug->pending, bio);
+
+	return true;
+}
 #endif
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 84724b9b20b8..44c8d113621f 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1341,8 +1341,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	struct bitmap *bitmap = mddev->bitmap;
 	unsigned long flags;
 	struct md_rdev *blocked_rdev;
-	struct blk_plug_cb *cb;
-	struct raid1_plug_cb *plug = NULL;
 	int first_clone;
 	int max_sectors;
 	bool write_behind = false;
@@ -1571,15 +1569,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 					      r1_bio->sector);
 		/* flush_pending_writes() needs access to the rdev so...*/
 		mbio->bi_bdev = (void *)rdev;
-
-		cb = blk_check_plugged(raid1_unplug, mddev, sizeof(*plug));
-		if (cb)
-			plug = container_of(cb, struct raid1_plug_cb, cb);
-		else
-			plug = NULL;
-		if (plug) {
-			bio_list_add(&plug->pending, mbio);
-		} else {
+		if (!md_add_bio_to_plug(mddev, mbio, raid1_unplug)) {
 			spin_lock_irqsave(&conf->device_lock, flags);
 			bio_list_add(&conf->pending_bio_list, mbio);
 			spin_unlock_irqrestore(&conf->device_lock, flags);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 50d56b6af42f..d67c5672933c 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1279,8 +1279,6 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
 	const blk_opf_t do_fua = bio->bi_opf & REQ_FUA;
 	unsigned long flags;
-	struct blk_plug_cb *cb;
-	struct raid1_plug_cb *plug = NULL;
 	struct r10conf *conf = mddev->private;
 	struct md_rdev *rdev;
 	int devnum = r10_bio->devs[n_copy].devnum;
@@ -1320,14 +1318,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 
 	atomic_inc(&r10_bio->remaining);
 
-	cb = blk_check_plugged(raid10_unplug, mddev, sizeof(*plug));
-	if (cb)
-		plug = container_of(cb, struct raid1_plug_cb, cb);
-	else
-		plug = NULL;
-	if (plug) {
-		bio_list_add(&plug->pending, mbio);
-	} else {
+	if (!md_add_bio_to_plug(mddev, mbio, raid10_unplug)) {
 		spin_lock_irqsave(&conf->device_lock, flags);
 		bio_list_add(&conf->pending_bio_list, mbio);
 		spin_unlock_irqrestore(&conf->device_lock, flags);
-- 
2.39.2

