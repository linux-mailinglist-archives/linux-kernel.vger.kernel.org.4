Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8216E0C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjDMLdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjDMLda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:33:30 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C22010DE;
        Thu, 13 Apr 2023 04:33:26 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PxyBT6ylGz4f3whK;
        Thu, 13 Apr 2023 19:33:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCH77KA6DdkC6FCHQ--.33135S8;
        Thu, 13 Apr 2023 19:33:23 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     dm-devel@redhat.com, song@kernel.org, logang@deltatee.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v6 4/5] md/bitmap: factor out a helper to set timeout
Date:   Thu, 13 Apr 2023 19:32:16 +0800
Message-Id: <20230413113217.1934353-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413113217.1934353-1-yukuai1@huaweicloud.com>
References: <20230413113217.1934353-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77KA6DdkC6FCHQ--.33135S8
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1xXrWfJryrKF4UKw18Grg_yoWrXFyUp3
        yfKas0yF18XrWfXw4xJaykCF1rXr1vqFZrtryxX34rCwn8Gws3tFyrWa4Dt3WDC34rAFs0
        q3W5GrW8CFyUWr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9G14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
        W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbmZX7UUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Register/unregister 'mddev->thread' are both under 'reconfig_mutex',
however, some context didn't hold the mutex to access mddev->thread,
which can cause null-ptr-deference:

1) md_bitmap_daemon_work() can be called from md_check_recovery() where
'reconfig_mutex' is not held, deference 'mddev->thread' might cause
null-ptr-deference, because md_unregister_thread() reset the pointer
before stopping the thread.

2) timeout_store() access 'mddev->thread' multiple times,
null-ptr-deference can be triggered if 'mddev->thread' is reset in the
middle.

This patch factor out a helper to set timeout, the new helper always
check if 'mddev->thread' is null first, so that problem 1 can be fixed.

Now that this helper only access 'mddev->thread' once, but it's possible
that 'mddev->thread' is freed while this helper is still in progress,
hence the problem is not fixed yet. Follow up patches will fix this by
protecting md_thread with rcu.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-bitmap.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
index 014e5c8a4fe0..29fd41ef55a6 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1218,11 +1218,22 @@ static bitmap_counter_t *md_bitmap_get_counter(struct bitmap_counts *bitmap,
 					       sector_t offset, sector_t *blocks,
 					       int create);
 
+static void mddev_set_timeout(struct mddev *mddev, unsigned long timeout,
+			      bool force)
+{
+	struct md_thread *thread = mddev->thread;
+
+	if (!thread)
+		return;
+
+	if (force || thread->timeout < MAX_SCHEDULE_TIMEOUT)
+		thread->timeout = timeout;
+}
+
 /*
  * bitmap daemon -- periodically wakes up to clean bits and flush pages
  *			out to disk
  */
-
 void md_bitmap_daemon_work(struct mddev *mddev)
 {
 	struct bitmap *bitmap;
@@ -1246,7 +1257,7 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 
 	bitmap->daemon_lastrun = jiffies;
 	if (bitmap->allclean) {
-		mddev->thread->timeout = MAX_SCHEDULE_TIMEOUT;
+		mddev_set_timeout(mddev, MAX_SCHEDULE_TIMEOUT, true);
 		goto done;
 	}
 	bitmap->allclean = 1;
@@ -1343,8 +1354,7 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 
  done:
 	if (bitmap->allclean == 0)
-		mddev->thread->timeout =
-			mddev->bitmap_info.daemon_sleep;
+		mddev_set_timeout(mddev, mddev->bitmap_info.daemon_sleep, true);
 	mutex_unlock(&mddev->bitmap_info.mutex);
 }
 
@@ -1797,8 +1807,7 @@ void md_bitmap_destroy(struct mddev *mddev)
 	mddev->bitmap = NULL; /* disconnect from the md device */
 	spin_unlock(&mddev->lock);
 	mutex_unlock(&mddev->bitmap_info.mutex);
-	if (mddev->thread)
-		mddev->thread->timeout = MAX_SCHEDULE_TIMEOUT;
+	mddev_set_timeout(mddev, MAX_SCHEDULE_TIMEOUT, true);
 
 	md_bitmap_free(bitmap);
 }
@@ -1941,7 +1950,7 @@ int md_bitmap_load(struct mddev *mddev)
 	/* Kick recovery in case any bits were set */
 	set_bit(MD_RECOVERY_NEEDED, &bitmap->mddev->recovery);
 
-	mddev->thread->timeout = mddev->bitmap_info.daemon_sleep;
+	mddev_set_timeout(mddev, mddev->bitmap_info.daemon_sleep, true);
 	md_wakeup_thread(mddev->thread);
 
 	md_bitmap_update_sb(bitmap);
@@ -2446,17 +2455,11 @@ timeout_store(struct mddev *mddev, const char *buf, size_t len)
 		timeout = MAX_SCHEDULE_TIMEOUT-1;
 	if (timeout < 1)
 		timeout = 1;
-	mddev->bitmap_info.daemon_sleep = timeout;
-	if (mddev->thread) {
-		/* if thread->timeout is MAX_SCHEDULE_TIMEOUT, then
-		 * the bitmap is all clean and we don't need to
-		 * adjust the timeout right now
-		 */
-		if (mddev->thread->timeout < MAX_SCHEDULE_TIMEOUT)
-			mddev->thread->timeout = timeout;
-	}
 
+	mddev->bitmap_info.daemon_sleep = timeout;
+	mddev_set_timeout(mddev, timeout, false);
 	md_wakeup_thread(mddev->thread);
+
 	return len;
 }
 
-- 
2.39.2

