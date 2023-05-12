Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929976FFEB1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 03:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239840AbjELB7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 21:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239750AbjELB67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 21:58:59 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FAD6199;
        Thu, 11 May 2023 18:58:56 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QHX4D1WCHz4f3mJf;
        Fri, 12 May 2023 09:58:52 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbFYnV1kbjQOJQ--.16243S9;
        Fri, 12 May 2023 09:58:53 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     logang@deltatee.com, reddunur@online.de, jovetoo@gmail.com,
        dgilmour76@gmail.com, song@kernel.org
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next 5/5] md/raid5: fix a deadlock in the case that reshape is interrupted
Date:   Fri, 12 May 2023 09:56:10 +0800
Message-Id: <20230512015610.821290-6-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512015610.821290-1-yukuai1@huaweicloud.com>
References: <20230512015610.821290-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbFYnV1kbjQOJQ--.16243S9
X-Coremail-Antispam: 1UD129KBjvJXoW3Gr4rCryxtFWxuw4DAr4UXFb_yoW7Kw15pa
        92kFn0vr4jqF9xKFWDta1kWa4F9397KrW3ta9xJw18Aw43Jr48A3W3WF45XF1UAa48J3yY
        qF1rt34Dur4jga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPF14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
        kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
        z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
        4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
        3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
        IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
        M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
        kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
        14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
        kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
        wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
        W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOBTY
        UUUUU
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

If reshape is in progress and io across reshape_position is issued, such
io will wait for reshape to make progress(see details in the case that
make_stripe_request() return STRIPE_SCHEDULE_AND_RETRY).

It has been reported several times that if system reboot while growing
raid5 to raid6, array assemble will hang infinitely([1, 2]). This is
because following deadlock is triggered:

1) a normal io is waiting for reshape to progress, this io can be from
   system-udevd or mdadm.
2) while assemble, mdadm tries to suspend the array, hence
   'reconfig_mutex' is held and mddev_suspend() must wait for normal io
   to be done.
3) daemon thread can't start reshape because 'reconfig_mutex' can't be
   held.

1) and 3) is unbreakable because they're foundation design. In order to
break 2), following is possible solutions that I can think of:

a) Let mddev_suspend() fail is not a good option, because this will
   break many scenarios since mddev_suspend() doesn't fail before.
b) Fail the io that is waiting for reshape to make progress from
   mddev_suspend().
c) Return false for the io that is waiting for reshape to make
   progress from raid5_make_request(), and these io will wait for
   suspend to be done in md_handle_request(), where 'active_io' is
   not grabbed.

c) sounds better than b), however, b) is used because it's easy and
straightforward, and it's verified that mdadm can assemble in this case.
On the other hand, c) breaks the logic that mddev_suspend() will wait
for submitted io to be completely handled.

Fix the problem by checking reshape in mddev_suspend(), if reshape can't
make progress and there are still some io waiting for reshape, fail
those io.

Reported-by: Jove <jovetoo@gmail.com>
[1] https://lore.kernel.org/all/CAFig2csUV2QiomUhj_t3dPOgV300dbQ6XtM9ygKPdXJFSH__Nw@mail.gmail.com/
Reported-by: David Gilmour <dgilmour76@gmail.com>
[2] https://lore.kernel.org/all/CAO2ABipzbw6QL5eNa44CQHjiVa-LTvS696Mh9QaTw+qsUKFUCw@mail.gmail.com/
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c    |  1 +
 drivers/md/raid5.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 1ef81421e131..e2bef5bb00f2 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9133,6 +9133,7 @@ void md_do_sync(struct md_thread *thread)
 	spin_unlock(&mddev->lock);
 
 	wake_up(&resync_wait);
+	wake_up(&mddev->sb_wait);
 	md_wakeup_thread(mddev->thread);
 	return;
 }
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index bd3b535c0739..7e2bbcfef325 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -5966,6 +5966,19 @@ static int add_all_stripe_bios(struct r5conf *conf,
 	return ret;
 }
 
+static bool reshape_inprogress(struct mddev *mddev)
+{
+	return test_bit(MD_RECOVERY_RESHAPE, &mddev->recovery) &&
+	       test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) &&
+	       !test_bit(MD_RECOVERY_DONE, &mddev->recovery) &&
+	       !test_bit(MD_RECOVERY_INTR, &mddev->recovery);
+}
+
+static bool reshape_disabled(struct mddev *mddev)
+{
+	return is_md_suspended(mddev) || !md_is_rdwr(mddev);
+}
+
 static enum stripe_result make_stripe_request(struct mddev *mddev,
 		struct r5conf *conf, struct stripe_request_ctx *ctx,
 		sector_t logical_sector, struct bio *bi)
@@ -5997,7 +6010,8 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 			if (ahead_of_reshape(mddev, logical_sector,
 					     conf->reshape_safe)) {
 				spin_unlock_irq(&conf->device_lock);
-				return STRIPE_SCHEDULE_AND_RETRY;
+				ret = STRIPE_SCHEDULE_AND_RETRY;
+				goto out;
 			}
 		}
 		spin_unlock_irq(&conf->device_lock);
@@ -6076,6 +6090,15 @@ static enum stripe_result make_stripe_request(struct mddev *mddev,
 
 out_release:
 	raid5_release_stripe(sh);
+out:
+	if (ret == STRIPE_SCHEDULE_AND_RETRY && !reshape_inprogress(mddev) &&
+	    reshape_disabled(mddev)) {
+		bi->bi_status = BLK_STS_IOERR;
+		ret = STRIPE_FAIL;
+		pr_err("md/raid456:%s: io failed across reshape position while reshape can't make progress.\n",
+		       mdname(mddev));
+	}
+
 	return ret;
 }
 
@@ -9045,6 +9068,22 @@ static int raid5_start(struct mddev *mddev)
 	return r5l_start(conf->log);
 }
 
+static void raid5_prepare_suspend(struct mddev *mddev)
+{
+	struct r5conf *conf = mddev->private;
+
+	wait_event(mddev->sb_wait, !reshape_inprogress(mddev) ||
+				    percpu_ref_is_zero(&mddev->active_io));
+	if (percpu_ref_is_zero(&mddev->active_io))
+		return;
+
+	/*
+	 * Reshape is not in progress, and array is suspended, io that is
+	 * waiting for reshpape can never be done.
+	 */
+	wake_up(&conf->wait_for_overlap);
+}
+
 static struct md_personality raid6_personality =
 {
 	.name		= "raid6",
@@ -9065,6 +9104,7 @@ static struct md_personality raid6_personality =
 	.check_reshape	= raid6_check_reshape,
 	.start_reshape  = raid5_start_reshape,
 	.finish_reshape = raid5_finish_reshape,
+	.prepare_suspend = raid5_prepare_suspend,
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid6_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
@@ -9089,6 +9129,7 @@ static struct md_personality raid5_personality =
 	.check_reshape	= raid5_check_reshape,
 	.start_reshape  = raid5_start_reshape,
 	.finish_reshape = raid5_finish_reshape,
+	.prepare_suspend = raid5_prepare_suspend,
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid5_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
@@ -9114,6 +9155,7 @@ static struct md_personality raid4_personality =
 	.check_reshape	= raid5_check_reshape,
 	.start_reshape  = raid5_start_reshape,
 	.finish_reshape = raid5_finish_reshape,
+	.prepare_suspend = raid5_prepare_suspend,
 	.quiesce	= raid5_quiesce,
 	.takeover	= raid4_takeover,
 	.change_consistency_policy = raid5_change_consistency_policy,
-- 
2.39.2

