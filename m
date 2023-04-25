Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441F36EE178
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjDYLzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjDYLzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:55:00 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A64C524C;
        Tue, 25 Apr 2023 04:54:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q5L5W4plCz4f42rc;
        Tue, 25 Apr 2023 19:54:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbF+v0dkGEZ+IA--.20559S5;
        Tue, 25 Apr 2023 19:54:40 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     logang@deltatee.com, axboe@kernel.dk, song@kernel.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: [PATCH -next v7 1/5] md: factor out a helper to wake up md_thread directly
Date:   Tue, 25 Apr 2023 19:52:52 +0800
Message-Id: <20230425115256.3663932-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230425115256.3663932-1-yukuai1@huaweicloud.com>
References: <20230425115256.3663932-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbF+v0dkGEZ+IA--.20559S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXFW8CF17JrW5Xr1kKF4xtFb_yoW5CFW3p3
        y8tF15Wr48AFZ8ZFZrJa4vka4rZr10qFy7try3Cw4rJw1rKw43tFyS9FyjyFyDAFyrAw45
        Zw15tFWruFZ2kr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
        xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
        6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
        Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
        Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
        IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU
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
index 8e344b4b3444..b4f482d69de3 100644
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

