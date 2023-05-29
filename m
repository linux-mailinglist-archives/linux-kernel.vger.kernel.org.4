Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C95A714A07
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjE2NPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjE2NPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:15:07 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400D5F9;
        Mon, 29 May 2023 06:14:49 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QVGGD5WPQz4f454K;
        Mon, 29 May 2023 21:14:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLNDpXRknNjnKQ--.28139S6;
        Mon, 29 May 2023 21:14:45 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, neilb@suse.de, akpm@osdl.org
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v3 2/7] md/raid1-10: factor out a helper to add bio to plug
Date:   Mon, 29 May 2023 21:11:01 +0800
Message-Id: <20230529131106.2123367-3-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLNDpXRknNjnKQ--.28139S6
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWUXFWkCr1xtw43ury7Awb_yoW5uw4fpa
        15KFyavrWDXrW5Xw1kJF4DuF45K3ZIgFZFkr93C3s3Jr17XFWUWa15JFWrCr98ZFZxury7
        Jrn0krsrCF43KFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM2
        8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
        v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWx
        JVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUc6pPUUUUU
        =
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

The code in raid1 and raid10 is identical, prepare to limit the number
of plugged bios.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1-10.c | 16 ++++++++++++++++
 drivers/md/raid1.c    | 12 +-----------
 drivers/md/raid10.c   | 11 +----------
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index e61f6cad4e08..9bf19a3409ce 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -109,3 +109,19 @@ static void md_bio_reset_resync_pages(struct bio *bio, struct resync_pages *rp,
 		size -= len;
 	} while (idx++ < RESYNC_PAGES && size > 0);
 }
+
+static inline bool raid1_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
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
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 2f1011ffdf09..e86c5e71c604 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1343,8 +1343,6 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 	struct bitmap *bitmap = mddev->bitmap;
 	unsigned long flags;
 	struct md_rdev *blocked_rdev;
-	struct blk_plug_cb *cb;
-	struct raid1_plug_cb *plug = NULL;
 	int first_clone;
 	int max_sectors;
 	bool write_behind = false;
@@ -1573,15 +1571,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
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
+		if (!raid1_add_bio_to_plug(mddev, mbio, raid1_unplug)) {
 			spin_lock_irqsave(&conf->device_lock, flags);
 			bio_list_add(&conf->pending_bio_list, mbio);
 			spin_unlock_irqrestore(&conf->device_lock, flags);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 6b31f848a6d9..18702051ebd1 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1287,8 +1287,6 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 	const blk_opf_t do_sync = bio->bi_opf & REQ_SYNC;
 	const blk_opf_t do_fua = bio->bi_opf & REQ_FUA;
 	unsigned long flags;
-	struct blk_plug_cb *cb;
-	struct raid1_plug_cb *plug = NULL;
 	struct r10conf *conf = mddev->private;
 	struct md_rdev *rdev;
 	int devnum = r10_bio->devs[n_copy].devnum;
@@ -1328,14 +1326,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 
 	atomic_inc(&r10_bio->remaining);
 
-	cb = blk_check_plugged(raid10_unplug, mddev, sizeof(*plug));
-	if (cb)
-		plug = container_of(cb, struct raid1_plug_cb, cb);
-	else
-		plug = NULL;
-	if (plug) {
-		bio_list_add(&plug->pending, mbio);
-	} else {
+	if (!raid1_add_bio_to_plug(mddev, mbio, raid10_unplug)) {
 		spin_lock_irqsave(&conf->device_lock, flags);
 		bio_list_add(&conf->pending_bio_list, mbio);
 		spin_unlock_irqrestore(&conf->device_lock, flags);
-- 
2.39.2

