Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5053714A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjE2NP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjE2NPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:15:11 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640BC110;
        Mon, 29 May 2023 06:14:50 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QVGGG11Hmz4f3pBW;
        Mon, 29 May 2023 21:14:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHcLNDpXRknNjnKQ--.28139S9;
        Mon, 29 May 2023 21:14:47 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, neilb@suse.de, akpm@osdl.org
Cc:     xni@redhat.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v3 5/7] md/md-bitmap: add a new helper to unplug bitmap asynchrously
Date:   Mon, 29 May 2023 21:11:04 +0800
Message-Id: <20230529131106.2123367-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
References: <20230529131106.2123367-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHcLNDpXRknNjnKQ--.28139S9
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWfZF1UZw43WF17KF17ZFb_yoWrCw1rpF
        W5t345Cr45JF47W345A34UuFySka4vqr9rJryfCw4ruF9xXF9xJF48GFWjywn8WFs8GFnI
        va1rtF98CF1Fqr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
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
        xVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
        UUUUU
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

If bitmap is enabled, bitmap must update before submitting write io, this
is why unplug callback must move these io to 'conf->pending_io_list' if
'current->bio_list' is not empty, which will suffer performance
degradation.

A new helper md_bitmap_unplug_async() is introduced to submit bitmap io
in a kworker, so that submit bitmap io in raid10_unplug() doesn't require
that 'current->bio_list' is empty.

This patch prepare to limit the number of plugged bio.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c | 29 +++++++++++++++++++++++++++++
 drivers/md/md-bitmap.h |  1 +
 drivers/md/md.c        |  9 +++++++++
 drivers/md/md.h        |  1 +
 4 files changed, 40 insertions(+)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 3ee590cf12a7..25cd72b317f1 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1054,6 +1054,35 @@ void md_bitmap_unplug(struct bitmap *bitmap)
 }
 EXPORT_SYMBOL(md_bitmap_unplug);
 
+struct bitmap_unplug_work {
+	struct work_struct work;
+	struct bitmap *bitmap;
+	struct completion *done;
+};
+
+static void md_bitmap_unplug_fn(struct work_struct *work)
+{
+	struct bitmap_unplug_work *unplug_work =
+		container_of(work, struct bitmap_unplug_work, work);
+
+	md_bitmap_unplug(unplug_work->bitmap);
+	complete(unplug_work->done);
+}
+
+void md_bitmap_unplug_async(struct bitmap *bitmap)
+{
+	DECLARE_COMPLETION_ONSTACK(done);
+	struct bitmap_unplug_work unplug_work;
+
+	INIT_WORK(&unplug_work.work, md_bitmap_unplug_fn);
+	unplug_work.bitmap = bitmap;
+	unplug_work.done = &done;
+
+	queue_work(md_bitmap_wq, &unplug_work.work);
+	wait_for_completion(&done);
+}
+EXPORT_SYMBOL(md_bitmap_unplug_async);
+
 static void md_bitmap_set_memory_bits(struct bitmap *bitmap, sector_t offset, int needed);
 /* * bitmap_init_from_disk -- called at bitmap_create time to initialize
  * the in-memory bitmap from the on-disk bitmap -- also, sets up the
diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
index 3a4750952b3a..8a3788c9bfef 100644
--- a/drivers/md/md-bitmap.h
+++ b/drivers/md/md-bitmap.h
@@ -264,6 +264,7 @@ void md_bitmap_sync_with_cluster(struct mddev *mddev,
 				 sector_t new_lo, sector_t new_hi);
 
 void md_bitmap_unplug(struct bitmap *bitmap);
+void md_bitmap_unplug_async(struct bitmap *bitmap);
 void md_bitmap_daemon_work(struct mddev *mddev);
 
 int md_bitmap_resize(struct bitmap *bitmap, sector_t blocks,
diff --git a/drivers/md/md.c b/drivers/md/md.c
index e592f37a1071..a5a7af2f4e59 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -83,6 +83,7 @@ static struct module *md_cluster_mod;
 static DECLARE_WAIT_QUEUE_HEAD(resync_wait);
 static struct workqueue_struct *md_wq;
 static struct workqueue_struct *md_misc_wq;
+struct workqueue_struct *md_bitmap_wq;
 
 static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this);
@@ -9636,6 +9637,11 @@ static int __init md_init(void)
 	if (!md_misc_wq)
 		goto err_misc_wq;
 
+	md_bitmap_wq = alloc_workqueue("md_bitmap", WQ_MEM_RECLAIM | WQ_UNBOUND,
+				       0);
+	if (!md_bitmap_wq)
+		goto err_bitmap_wq;
+
 	ret = __register_blkdev(MD_MAJOR, "md", md_probe);
 	if (ret < 0)
 		goto err_md;
@@ -9654,6 +9660,8 @@ static int __init md_init(void)
 err_mdp:
 	unregister_blkdev(MD_MAJOR, "md");
 err_md:
+	destroy_workqueue(md_bitmap_wq);
+err_bitmap_wq:
 	destroy_workqueue(md_misc_wq);
 err_misc_wq:
 	destroy_workqueue(md_wq);
@@ -9950,6 +9958,7 @@ static __exit void md_exit(void)
 	spin_unlock(&all_mddevs_lock);
 
 	destroy_workqueue(md_misc_wq);
+	destroy_workqueue(md_bitmap_wq);
 	destroy_workqueue(md_wq);
 }
 
diff --git a/drivers/md/md.h b/drivers/md/md.h
index a50122165fa1..bfd2306bc750 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -852,6 +852,7 @@ struct mdu_array_info_s;
 struct mdu_disk_info_s;
 
 extern int mdp_major;
+extern struct workqueue_struct *md_bitmap_wq;
 void md_autostart_arrays(int part);
 int md_set_array_info(struct mddev *mddev, struct mdu_array_info_s *info);
 int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info);
-- 
2.39.2

