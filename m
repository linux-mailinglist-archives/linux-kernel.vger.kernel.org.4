Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E026EF02B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 10:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240004AbjDZIWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 04:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbjDZIW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 04:22:28 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A333C1B;
        Wed, 26 Apr 2023 01:22:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q5sL649TFz4f55b3;
        Wed, 26 Apr 2023 16:22:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP2 (Coremail) with SMTP id Syh0CgBnW+k430hkUexVIA--.50201S11;
        Wed, 26 Apr 2023 16:22:23 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, akpm@osdl.org, neilb@suse.de
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v2 7/7] md/raid1-10: limit the number of plugged bio
Date:   Wed, 26 Apr 2023 16:20:31 +0800
Message-Id: <20230426082031.1299149-8-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230426082031.1299149-1-yukuai1@huaweicloud.com>
References: <20230426082031.1299149-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBnW+k430hkUexVIA--.50201S11
X-Coremail-Antispam: 1UD129KBjvJXoWxZr4rKF4fXry8CFyfZry3XFb_yoW5try8pa
        1Dta4YvrWUZFW7X3yDJayUCFyFga1DWFZFkrZ5C395ZF17XFWjga15JFWrWr1DZFZxGFy3
        J3Z8Kr4xGF15tF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
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
mdadm -CR /dev/md0 -l10 -n4 /dev/ram[0123] --assume-clean
echo 0 > /proc/sys/vm/dirty_background_ratio
echo 60 > /proc/sys/vm/dirty_ratio
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
index 98d678b7df3f..35fb80aa37aa 100644
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
@@ -127,7 +129,7 @@ static inline void md_submit_write(struct bio *bio)
 }
 
 static inline bool md_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
-				      blk_plug_cb_fn unplug)
+				      blk_plug_cb_fn unplug, int copies)
 {
 	struct raid1_plug_cb *plug = NULL;
 	struct blk_plug_cb *cb;
@@ -147,6 +149,11 @@ static inline bool md_add_bio_to_plug(struct mddev *mddev, struct bio *bio,
 
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
index 639e09cecf01..c6066408a913 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1562,7 +1562,7 @@ static void raid1_write_request(struct mddev *mddev, struct bio *bio,
 					      r1_bio->sector);
 		/* flush_pending_writes() needs access to the rdev so...*/
 		mbio->bi_bdev = (void *)rdev;
-		if (!md_add_bio_to_plug(mddev, mbio, raid1_unplug)) {
+		if (!md_add_bio_to_plug(mddev, mbio, raid1_unplug, disks)) {
 			spin_lock_irqsave(&conf->device_lock, flags);
 			bio_list_add(&conf->pending_bio_list, mbio);
 			spin_unlock_irqrestore(&conf->device_lock, flags);
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index bd9e655ca408..7135cfaf75db 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -1306,7 +1306,7 @@ static void raid10_write_one_disk(struct mddev *mddev, struct r10bio *r10_bio,
 
 	atomic_inc(&r10_bio->remaining);
 
-	if (!md_add_bio_to_plug(mddev, mbio, raid10_unplug)) {
+	if (!md_add_bio_to_plug(mddev, mbio, raid10_unplug, conf->copies)) {
 		spin_lock_irqsave(&conf->device_lock, flags);
 		bio_list_add(&conf->pending_bio_list, mbio);
 		spin_unlock_irqrestore(&conf->device_lock, flags);
-- 
2.39.2

