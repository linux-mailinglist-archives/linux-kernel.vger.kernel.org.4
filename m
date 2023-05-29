Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC0B714A10
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjE2NPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbjE2NPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:15:41 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C9811B;
        Mon, 29 May 2023 06:14:52 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QVGGG2chnz4f3sjt;
        Mon, 29 May 2023 21:14:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLNDpXRknNjnKQ--.28139S11;
        Mon, 29 May 2023 21:14:48 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, neilb@suse.de, akpm@osdl.org
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v3 7/7] md/raid1-10: limit the number of plugged bio
Date:   Mon, 29 May 2023 21:11:06 +0800
Message-Id: <20230529131106.2123367-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLNDpXRknNjnKQ--.28139S11
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4rKF4Duw45JFyUAw1xGrg_yoW5tryDpa
        1Dta4Yv3yUZrW7X3yDJa1UCFyFga1qgFWDCr95C395ZFy7XFWjga15GFWrCr1DZFZxWF9r
        J3Z8KrW7GF45tF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
        xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
        IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
        wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
        0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AK
        xVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
        WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZ
        X7UUUUU==
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

bio can be added to plug infinitely, and following writeback test can
trigger huge amount of plugged bio:

Test script:
modprobe brd rd_nr=4 rd_size=10485760
mdadm -CR /dev/md0 -l10 -n4 /dev/ram[0123] --assume-clean --bitmap=internal
echo 0 > /proc/sys/vm/dirty_background_ratio
fio -filename=/dev/md0 -ioengine=libaio -rw=write -bs=4k -numjobs=1 -iodepth=128 -name=test

Test result:
Monitor /sys/block/md0/inflight will found that inflight keep increasing
until fio finish writing, after running for about 2 minutes:

[root@fedora ~]# cat /sys/block/md0/inflight
       0  4474191

Fix the problem by limiting the number of plugged bio based on the number
of copies for original bio.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/raid1-10.c | 9 ++++++++-
 drivers/md/raid1.c    | 2 +-
 drivers/md/raid10.c   | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/md/raid1-10.c b/drivers/md/raid1-10.c
index 17e55c1fd5a1..bb1e23b66c45 100644
--- a/drivers/md/raid1-10.c
+++ b/drivers/md/raid1-10.c
@@ -21,6 +21,7 @@
 #define IO_MADE_GOOD ((struct bio *)2)
 
 #define BIO_SPECIAL(bio) ((unsigned long)bio <= 2)
+#define MAX_PLUG_BIO 32
 
 /* for managing resync I/O pages */
 struct resync_pages {
@@ -31,6 +32,7 @@ struct resync_pages {
 struct raid1_plug_cb {
 	struct blk_plug_cb	cb;
 	struct bio_list		pending;
+	unsigned int		count;
 };
 
 static void rbio_pool_free(void *rbio, void *data)
@@ -128,7 +130,7 @@ static inline void raid1_submit_write(struct bio *bio)
 }
 
 static inline bool raid1_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
-				      blk_plug_cb_fn unplug)
+				      blk_plug_cb_fn unplug, int copies)
 {
 	struct raid1_plug_cb *plug = NULL;
 	struct blk_plug_cb *cb;
@@ -148,6 +150,11 @@ static inline bool raid1_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
 
 	plug = container_of(cb, struct raid1_plug_cb, cb);
 	bio_list_add(&plug->pending, bio);
+	if (++plug->count / MAX_PLUG_BIO >= copies) {
+		list_del(&cb->list);
+		cb->callback(cb, false);
+	}
+
 
 	return true;
 }
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 006620fed595..dc89a1c4b1f1 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1562,7 +1562,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 					      r1_bio->sector);
 		/* flush_pending_writes() needs access to the rdev so...*/
 		mbio->bi_bdev = (void *)rdev;
-		if (!raid1_add_bio_to_plug(mddev, mbio, raid1_unplug)) {
+		if (!raid1_add_bio_to_plug(mddev, mbio, raid1_unplug, disks)) {
 			spin_lock_irqsave(&conf->device_lock, flags);
 			bio_list_add(&conf->pending_bio_list, mbio);
 			spin_unlock_irqrestore(&conf->device_lock, flags);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index fb22cfe94d32..9237dbeb07ba 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1306,7 +1306,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 
 	atomic_inc(&r10_bio->remaining);
 
-	if (!raid1_add_bio_to_plug(mddev, mbio, raid10_unplug)) {
+	if (!raid1_add_bio_to_plug(mddev, mbio, raid10_unplug, conf->copies)) {
 		spin_lock_irqsave(&conf->device_lock, flags);
 		bio_list_add(&conf->pending_bio_list, mbio);
 		spin_unlock_irqrestore(&conf->device_lock, flags);
-- 
2.39.2

