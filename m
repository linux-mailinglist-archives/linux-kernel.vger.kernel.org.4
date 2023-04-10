Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3893B6DC655
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 13:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjDJLhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 07:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjDJLg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 07:36:59 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7503349D6;
        Mon, 10 Apr 2023 04:36:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pw6Pw45L9z4f3mVh;
        Mon, 10 Apr 2023 19:36:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgAHvbDT9DNk0tNvHA--.50875S5;
        Mon, 10 Apr 2023 19:36:54 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     logang@deltatee.com, song@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next v5 1/6] md: pass a md_thread pointer to md_register_thread()
Date:   Mon, 10 Apr 2023 19:35:54 +0800
Message-Id: <20230410113559.1610455-2-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230410113559.1610455-1-yukuai1@huaweicloud.com>
References: <20230410113559.1610455-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHvbDT9DNk0tNvHA--.50875S5
X-Coremail-Antispam: 1UD129KBjvJXoW3JFy3uFykCryfGF15KF1ftFb_yoWfAry8pa
        yxWFyavr48ArW3ZrWDAa4Dua45uw10gFWjyry3C34fA3ZxK3y3JFyY9FyUJryDAa4rAF43
        tw15KFW8uF4kKr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9m14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUqAp5UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Prepare to protect md_thread with rcu, there are no functional changes.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md-cluster.c   | 11 +++++------
 drivers/md/md-multipath.c |  6 +++---
 drivers/md/md.c           | 27 ++++++++++++++-------------
 drivers/md/md.h           |  7 +++----
 drivers/md/raid1.c        |  5 ++---
 drivers/md/raid10.c       | 15 ++++++---------
 drivers/md/raid5-cache.c  |  5 ++---
 drivers/md/raid5.c        | 15 ++++++---------
 8 files changed, 41 insertions(+), 50 deletions(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 10e0c5381d01..c19e29cb73bf 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -362,9 +362,8 @@ static void __recover_slot(struct mddev *mddev, int slot)
 
 	set_bit(slot, &cinfo->recovery_map);
 	if (!cinfo->recovery_thread) {
-		cinfo->recovery_thread = md_register_thread(recover_bitmaps,
-				mddev, "recover");
-		if (!cinfo->recovery_thread) {
+		if (md_register_thread(&cinfo->recovery_thread, recover_bitmaps,
+				       mddev, "recover")) {
 			pr_warn("md-cluster: Could not create recovery thread\n");
 			return;
 		}
@@ -888,9 +887,9 @@ static int join(struct mddev *mddev, int nodes)
 		goto err;
 	}
 	/* Initiate the communication resources */
-	ret = -ENOMEM;
-	cinfo->recv_thread = md_register_thread(recv_daemon, mddev, "cluster_recv");
-	if (!cinfo->recv_thread) {
+	ret = md_register_thread(&cinfo->recv_thread, recv_daemon, mddev,
+				 "cluster_recv");
+	if (ret) {
 		pr_err("md-cluster: cannot allocate memory for recv_thread!\n");
 		goto err;
 	}
diff --git a/drivers/md/md-multipath.c b/drivers/md/md-multipath.c
index 66edf5e72bd6..ceec9e4b2a60 100644
--- a/drivers/md/md-multipath.c
+++ b/drivers/md/md-multipath.c
@@ -400,9 +400,9 @@ static int multipath_run (struct mddev *mddev)
 	if (ret)
 		goto out_free_conf;
 
-	mddev->thread = md_register_thread(multipathd, mddev,
-					   "multipath");
-	if (!mddev->thread)
+	ret = md_register_thread(&mddev->thread, multipathd, mddev,
+				 "multipath");
+	if (ret)
 		goto out_free_conf;
 
 	pr_info("multipath: array %s active with %d out of %d IO paths\n",
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 9bc05f451d42..1459c2cfb0dd 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7896,29 +7896,32 @@ void md_wakeup_thread(struct md_thread *thread)
 }
 EXPORT_SYMBOL(md_wakeup_thread);
 
-struct md_thread *md_register_thread(void (*run) (struct md_thread *),
-		struct mddev *mddev, const char *name)
+int md_register_thread(struct md_thread **threadp,
+		       void (*run)(struct md_thread *),
+		       struct mddev *mddev, const char *name)
 {
 	struct md_thread *thread;
 
 	thread = kzalloc(sizeof(struct md_thread), GFP_KERNEL);
 	if (!thread)
-		return NULL;
+		return -ENOMEM;
 
 	init_waitqueue_head(&thread->wqueue);
 
 	thread->run = run;
 	thread->mddev = mddev;
 	thread->timeout = MAX_SCHEDULE_TIMEOUT;
-	thread->tsk = kthread_run(md_thread, thread,
-				  "%s_%s",
-				  mdname(thread->mddev),
-				  name);
+	thread->tsk = kthread_run(md_thread, thread, "%s_%s",
+				  mdname(thread->mddev), name);
 	if (IS_ERR(thread->tsk)) {
+		int err = PTR_ERR(thread->tsk);
+
 		kfree(thread);
-		return NULL;
+		return err;
 	}
-	return thread;
+
+	*threadp = thread;
+	return 0;
 }
 EXPORT_SYMBOL(md_register_thread);
 
@@ -9199,10 +9202,8 @@ static void md_start_sync(struct work_struct *ws)
 {
 	struct mddev *mddev = container_of(ws, struct mddev, del_work);
 
-	mddev->sync_thread = md_register_thread(md_do_sync,
-						mddev,
-						"resync");
-	if (!mddev->sync_thread) {
+	if (md_register_thread(&mddev->sync_thread, md_do_sync, mddev,
+			       "resync")) {
 		pr_warn("%s: could not start resync thread...\n",
 			mdname(mddev));
 		/* leave the spares where they are, it shouldn't hurt */
diff --git a/drivers/md/md.h b/drivers/md/md.h
index e148e3c83b0d..7af45b8432e9 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -730,10 +730,9 @@ extern int register_md_cluster_operations(struct md_cluster_operations *ops,
 extern int unregister_md_cluster_operations(void);
 extern int md_setup_cluster(struct mddev *mddev, int nodes);
 extern void md_cluster_stop(struct mddev *mddev);
-extern struct md_thread *md_register_thread(
-	void (*run)(struct md_thread *thread),
-	struct mddev *mddev,
-	const char *name);
+extern int md_register_thread(struct md_thread **threadp,
+			      void (*run)(struct md_thread *thread),
+			      struct mddev *mddev, const char *name);
 extern void md_unregister_thread(struct md_thread **threadp);
 extern void md_wakeup_thread(struct md_thread *thread);
 extern void md_check_recovery(struct mddev *mddev);
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 68a9e2d9985b..1217c1db0a40 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -3083,9 +3083,8 @@ static struct r1conf *setup_conf(struct mddev *mddev)
 		}
 	}
 
-	err = -ENOMEM;
-	conf->thread = md_register_thread(raid1d, mddev, "raid1");
-	if (!conf->thread)
+	err = md_register_thread(&conf->thread, raid1d, mddev, "raid1");
+	if (err)
 		goto abort;
 
 	return conf;
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 6c66357f92f5..0171ba4f19b0 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -4077,9 +4077,8 @@ static struct r10conf *setup_conf(struct mddev *mddev)
 	init_waitqueue_head(&conf->wait_barrier);
 	atomic_set(&conf->nr_pending, 0);
 
-	err = -ENOMEM;
-	conf->thread = md_register_thread(raid10d, mddev, "raid10");
-	if (!conf->thread)
+	err = md_register_thread(&conf->thread, raid10d, mddev, "raid10");
+	if (err)
 		goto out;
 
 	conf->mddev = mddev;
@@ -4273,9 +4272,8 @@ static int raid10_run(struct mddev *mddev)
 		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 		set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
 		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
-		mddev->sync_thread = md_register_thread(md_do_sync, mddev,
-							"reshape");
-		if (!mddev->sync_thread)
+		if (md_register_thread(&mddev->sync_thread, md_do_sync, mddev,
+				       "reshape"))
 			goto out_free_conf;
 	}
 
@@ -4686,9 +4684,8 @@ static int raid10_start_reshape(struct mddev *mddev)
 	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
 	set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
 
-	mddev->sync_thread = md_register_thread(md_do_sync, mddev,
-						"reshape");
-	if (!mddev->sync_thread) {
+	if (md_register_thread(&mddev->sync_thread, md_do_sync, mddev,
+			       "reshape")) {
 		ret = -EAGAIN;
 		goto abort;
 	}
diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 46182b955aef..0464d4d551fc 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -3121,9 +3121,8 @@ int r5l_init_log(struct r5conf *conf, struct md_rdev *rdev)
 	spin_lock_init(&log->tree_lock);
 	INIT_RADIX_TREE(&log->big_stripe_tree, GFP_NOWAIT | __GFP_NOWARN);
 
-	log->reclaim_thread = md_register_thread(r5l_reclaim_thread,
-						 log->rdev->mddev, "reclaim");
-	if (!log->reclaim_thread)
+	if (md_register_thread(&log->reclaim_thread, r5l_reclaim_thread,
+			       log->rdev->mddev, "reclaim"))
 		goto reclaim_thread;
 	log->reclaim_thread->timeout = R5C_RECLAIM_WAKEUP_INTERVAL;
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 7b820b81d8c2..04b1093195d0 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -7665,11 +7665,10 @@ static struct r5conf *setup_conf(struct mddev *mddev)
 	}
 
 	sprintf(pers_name, "raid%d", mddev->new_level);
-	conf->thread = md_register_thread(raid5d, mddev, pers_name);
-	if (!conf->thread) {
+	ret = md_register_thread(&conf->thread, raid5d, mddev, pers_name);
+	if (ret) {
 		pr_warn("md/raid:%s: couldn't allocate thread.\n",
 			mdname(mddev));
-		ret = -ENOMEM;
 		goto abort;
 	}
 
@@ -7989,9 +7988,8 @@ static int raid5_run(struct mddev *mddev)
 		clear_bit(MD_RECOVERY_CHECK, &mddev->recovery);
 		set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
 		set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
-		mddev->sync_thread = md_register_thread(md_do_sync, mddev,
-							"reshape");
-		if (!mddev->sync_thread)
+		if (md_register_thread(&mddev->sync_thread, md_do_sync, mddev,
+				       "reshape"))
 			goto abort;
 	}
 
@@ -8567,9 +8565,8 @@ static int raid5_start_reshape(struct mddev *mddev)
 	clear_bit(MD_RECOVERY_DONE, &mddev->recovery);
 	set_bit(MD_RECOVERY_RESHAPE, &mddev->recovery);
 	set_bit(MD_RECOVERY_RUNNING, &mddev->recovery);
-	mddev->sync_thread = md_register_thread(md_do_sync, mddev,
-						"reshape");
-	if (!mddev->sync_thread) {
+	if (md_register_thread(&mddev->sync_thread, md_do_sync, mddev,
+			       "reshape")) {
 		mddev->recovery = 0;
 		spin_lock_irq(&conf->device_lock);
 		write_seqcount_begin(&conf->gen_lock);
-- 
2.39.2

