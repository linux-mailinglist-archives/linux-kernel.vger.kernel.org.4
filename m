Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56456E0C8C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjDMLdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjDMLd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:33:29 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0130DE;
        Thu, 13 Apr 2023 04:33:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PxyBT1KdHz4f4nX3;
        Thu, 13 Apr 2023 19:33:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgCH77KA6DdkC6FCHQ--.33135S5;
        Thu, 13 Apr 2023 19:33:22 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     dm-devel@redhat.com, song@kernel.org, logang@deltatee.com
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v6 1/5] md: factor out a helper to wake up md_thread directly
Date:   Thu, 13 Apr 2023 19:32:13 +0800
Message-Id: <20230413113217.1934353-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230413113217.1934353-1-yukuai1@huaweicloud.com>
References: <20230413113217.1934353-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77KA6DdkC6FCHQ--.33135S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW8CF17JrW5Xr1kKF4xtFb_yoW5CFW3p3
        y8tF15Wr48ZFZxZFZrJa4DCa4rZr10qFy7try7Cw4rJw1rKw43tFyS9FyjyFyDAFyrAw45
        Zw15tFWrurZ2kr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9q14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I2
        62IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcV
        AFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG
        0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjfU5SoXUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

md_wakeup_thread() can't wakeup md_thread->tsk if md_thread->run is
still in progress, and in some cases md_thread->tsk need to be woke up
directly, like md_set_readonly() and do_md_stop().

Commit 9dfbdafda3b3 ("md: unlock mddev before reap sync_thread in
action_store") introduce a new scenario where unregister sync_thread is
not protected by 'reconfig_mutex', this can cause null-ptr-deference in
theroy:

t1: md_set_readonly		t2: action_store
				md_unregister_thread
				// 'reconfig_mutex' is not held
// 'reconfig_mutex' is held by caller
if (mddev->sync_thread)
				 thread = *threadp
				 *threadp = NULL
 wake_up_process(mddev->sync_thread->tsk)
 // null-ptr-deference

This patch factor out a helper to wake up md_thread directly, so that
'sync_thread' won't be accessed multiple times from the reader side. And
perhaps this helper will be used later to fix action_store().

This patch also prepare to protect md_thread with rcu.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9bc05f451d42..e3c30500bd15 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -92,6 +92,7 @@ static struct workqueue_struct *md_rdev_misc_wq;
 static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this);
 static void mddev_detach(struct mddev *mddev);
+static void md_wakeup_thread_directly(struct md_thread *thread);
 
 enum md_ro_state {
 	MD_RDWR,
@@ -6269,10 +6270,12 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 	}
 	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-	if (mddev->sync_thread)
-		/* Thread might be blocked waiting for metadata update
-		 * which will now never happen */
-		wake_up_process(mddev->sync_thread->tsk);
+
+	/*
+	 * Thread might be blocked waiting for metadata update which will now
+	 * never happen
+	 */
+	md_wakeup_thread_directly(mddev->sync_thread);
 
 	if (mddev->external && test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
 		return -EBUSY;
@@ -6333,10 +6336,12 @@ static int do_md_stop(struct mddev *mddev, int mode,
 	}
 	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-	if (mddev->sync_thread)
-		/* Thread might be blocked waiting for metadata update
-		 * which will now never happen */
-		wake_up_process(mddev->sync_thread->tsk);
+
+	/*
+	 * Thread might be blocked waiting for metadata update which will now
+	 * never happen
+	 */
+	md_wakeup_thread_directly(mddev->sync_thread);
 
 	mddev_unlock(mddev);
 	wait_event(resync_wait, (mddev->sync_thread == NULL &&
@@ -7886,6 +7891,12 @@ static int md_thread(void *arg)
 	return 0;
 }
 
+static void md_wakeup_thread_directly(struct md_thread *thread)
+{
+	if (thread)
+		wake_up_process(thread->tsk);
+}
+
 void md_wakeup_thread(struct md_thread *thread)
 {
 	if (thread) {
-- 
2.39.2

