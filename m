Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D9F6BA7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 07:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjCOGTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 02:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjCOGTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 02:19:02 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007A01BADF;
        Tue, 14 Mar 2023 23:18:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pc0b35SVGz4f4PQs;
        Wed, 15 Mar 2023 14:18:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUyFNYxFklvvMEw--.20241S9;
        Wed, 15 Mar 2023 14:18:57 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     agk@redhat.com, snitzer@kernel.org, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH v2 5/5] md: protect md_thread with a new disk level spin lock
Date:   Wed, 15 Mar 2023 14:18:10 +0800
Message-Id: <20230315061810.653263-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230315061810.653263-1-yukuai1@huaweicloud.com>
References: <20230315061810.653263-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUyFNYxFklvvMEw--.20241S9
X-Coremail-Antispam: 1UD129KBjvJXoWxXFyUZF4UXr1xtr1Uuw48JFb_yoW5uF45pa
        yIqF9xAr4UZws8ZrnrGa4v93WYqw1vgayUJrW3u3WfA3WUG3yaqryY9Fy8ZFn8A3W3CFsx
        J3WrGayrurWDKr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
        v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTYUUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Our test reports a uaf for 'mddev->sync_thread':

T1                      T2
md_start_sync
 md_register_thread
			raid1d
			 md_check_recovery
			  md_reap_sync_thread
			   md_unregister_thread
			    kfree

 md_wakeup_thread
  wake_up
  ->sync_thread was freed

Currently, a global spinlock 'pers_lock' is borrowed to protect
'mddev->thread', this problem can be fixed likewise, however, there might
be similar problem for other md_thread, and I really don't like the idea to
borrow a global lock.

This patch use a disk level spinlock to protect md_thread in relevant apis.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 28 ++++++++++++----------------
 drivers/md/md.h |  1 +
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index ab9299187cfe..926285bece5d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -663,6 +663,7 @@ void mddev_init(struct mddev *mddev)
 	atomic_set(&mddev->active, 1);
 	atomic_set(&mddev->openers, 0);
 	spin_lock_init(&mddev->lock);
+	spin_lock_init(&mddev->thread_lock);
 	atomic_set(&mddev->flush_pending, 0);
 	init_waitqueue_head(&mddev->sb_wait);
 	init_waitqueue_head(&mddev->recovery_wait);
@@ -801,13 +802,8 @@ void mddev_unlock(struct mddev *mddev)
 	} else
 		mutex_unlock(&mddev->reconfig_mutex);
 
-	/* As we've dropped the mutex we need a spinlock to
-	 * make sure the thread doesn't disappear
-	 */
-	spin_lock(&pers_lock);
 	md_wakeup_thread(&mddev->thread, mddev);
 	wake_up(&mddev->sb_wait);
-	spin_unlock(&pers_lock);
 }
 EXPORT_SYMBOL_GPL(mddev_unlock);
 
@@ -7895,8 +7891,11 @@ static int md_thread(void *arg)
 
 void md_wakeup_thread(struct md_thread **threadp, struct mddev *mddev)
 {
-	struct md_thread *thread = *threadp;
+	struct md_thread *thread;
 
+	spin_lock_irq(&mddev->thread_lock);
+	thread = *threadp;
+	spin_unlock_irq(&mddev->thread_lock);
 	if (thread) {
 		pr_debug("md: waking up MD thread %s.\n", thread->tsk->comm);
 		set_bit(THREAD_WAKEUP, &thread->flags);
@@ -7929,7 +7928,9 @@ int md_register_thread(struct md_thread **threadp,
 		return err;
 	}
 
+	spin_lock_irq(&mddev->thread_lock);
 	*threadp = thread;
+	spin_unlock_irq(&mddev->thread_lock);
 	return 0;
 }
 EXPORT_SYMBOL(md_register_thread);
@@ -7938,18 +7939,13 @@ void md_unregister_thread(struct md_thread **threadp, struct mddev *mddev)
 {
 	struct md_thread *thread;
 
-	/*
-	 * Locking ensures that mddev_unlock does not wake_up a
-	 * non-existent thread
-	 */
-	spin_lock(&pers_lock);
+	spin_lock_irq(&mddev->thread_lock);
 	thread = *threadp;
-	if (!thread) {
-		spin_unlock(&pers_lock);
-		return;
-	}
 	*threadp = NULL;
-	spin_unlock(&pers_lock);
+	spin_unlock_irq(&mddev->thread_lock);
+
+	if (!thread)
+		return;
 
 	pr_debug("interrupting MD-thread pid %d\n", task_pid_nr(thread->tsk));
 	kthread_stop(thread->tsk);
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 8f4137ad2dde..ca182d21dd8d 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -367,6 +367,7 @@ struct mddev {
 	int				new_chunk_sectors;
 	int				reshape_backwards;
 
+	spinlock_t			thread_lock;
 	struct md_thread		*thread;	/* management thread */
 	struct md_thread		*sync_thread;	/* doing resync or reconstruct */
 
-- 
2.31.1

