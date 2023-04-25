Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5A46EE179
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbjDYLzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjDYLzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:55:01 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CBC422A;
        Tue, 25 Apr 2023 04:54:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q5L5X6ypwz4f4QHP;
        Tue, 25 Apr 2023 19:54:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbF+v0dkGEZ+IA--.20559S8;
        Tue, 25 Apr 2023 19:54:42 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     logang@deltatee.com, axboe@kernel.dk, song@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v7 4/5] md/bitmap: factor out a helper to set timeout
Date:   Tue, 25 Apr 2023 19:52:55 +0800
Message-Id: <20230425115256.3663932-5-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425115256.3663932-1-yukuai1@huaweicloud.com>
References: <20230425115256.3663932-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbF+v0dkGEZ+IA--.20559S8
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1xXrWfJryrKF4UKw18Grg_yoWrXFyUp3
        y7Kas0yF48XrWfXw4xJa4kCF1rXr1vqFsrtryxX34rCwn5Gws3tFyrWa4Dt3WDC34rAFs0
        q3W5Gr48CFyUWr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPY14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
        4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkU
        UUUU=
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
index 06b980f71a6b..9e9fccc772e1 100644
--- a/drivers/md/md-bitmap.c
+++ b/drivers/md/md-bitmap.c
@@ -1241,11 +1241,22 @@ static bitmap_counter_t *md_bitmap_get_counter(struct bitmap_counts *bitmap,
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
@@ -1269,7 +1280,7 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 
 	bitmap->daemon_lastrun = jiffies;
 	if (bitmap->allclean) {
-		mddev->thread->timeout = MAX_SCHEDULE_TIMEOUT;
+		mddev_set_timeout(mddev, MAX_SCHEDULE_TIMEOUT, true);
 		goto done;
 	}
 	bitmap->allclean = 1;
@@ -1366,8 +1377,7 @@ void md_bitmap_daemon_work(struct mddev *mddev)
 
  done:
 	if (bitmap->allclean == 0)
-		mddev->thread->timeout =
-			mddev->bitmap_info.daemon_sleep;
+		mddev_set_timeout(mddev, mddev->bitmap_info.daemon_sleep, true);
 	mutex_unlock(&mddev->bitmap_info.mutex);
 }
 
@@ -1820,8 +1830,7 @@ void md_bitmap_destroy(struct mddev *mddev)
 	mddev->bitmap = NULL; /* disconnect from the md device */
 	spin_unlock(&mddev->lock);
 	mutex_unlock(&mddev->bitmap_info.mutex);
-	if (mddev->thread)
-		mddev->thread->timeout = MAX_SCHEDULE_TIMEOUT;
+	mddev_set_timeout(mddev, MAX_SCHEDULE_TIMEOUT, true);
 
 	md_bitmap_free(bitmap);
 }
@@ -1964,7 +1973,7 @@ int md_bitmap_load(struct mddev *mddev)
 	/* Kick recovery in case any bits were set */
 	set_bit(MD_RECOVERY_NEEDED, &bitmap->mddev->recovery);
 
-	mddev->thread->timeout = mddev->bitmap_info.daemon_sleep;
+	mddev_set_timeout(mddev, mddev->bitmap_info.daemon_sleep, true);
 	md_wakeup_thread(mddev->thread);
 
 	md_bitmap_update_sb(bitmap);
@@ -2469,17 +2478,11 @@ timeout_store(struct mddev *mddev, const char *buf, size_t len)
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

