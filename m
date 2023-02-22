Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A4069ED98
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjBVDqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjBVDqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:46:38 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D8F2CC46;
        Tue, 21 Feb 2023 19:46:35 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PM2Bs3YJHz4f3wYF;
        Wed, 22 Feb 2023 11:46:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgA35CEVkPVjUibtDg--.64292S5;
        Wed, 22 Feb 2023 11:46:31 +0800 (CST)
From:   linan666@huaweicloud.com
To:     song@kernel.org, ncroxon@redhat.com, vmayatskikh@digitalocean.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        guoqing.jiang@linux.dev, logang@deltatee.com, axboe@kernel.dk,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com
Subject: [PATCH 1/2] md/raid10: fix taks hung in raid10d
Date:   Wed, 22 Feb 2023 12:09:59 +0800
Message-Id: <20230222041000.3341651-2-linan666@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230222041000.3341651-1-linan666@huaweicloud.com>
References: <20230222041000.3341651-1-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgA35CEVkPVjUibtDg--.64292S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1UtF1xurWrCr1xJw1UWrg_yoW5Aw4fp3
        yfGrn3Ary5Ga4ayF1DtF1DC34F93yfJFW3CFZ3W34xZ3WDZFZ3JFWDXFWY9ryDZr95Zay5
        XFZFy3yYkF47tFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPEb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64
        xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j
        6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2
        kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
        Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
        CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
        I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
        8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73
        UjIFyTuYvjxUc6wZUUUUU
X-CM-SenderInfo: polqt0awwwqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Nan <linan122@huawei.com>

commit fe630de009d0 ("md/raid10: avoid deadlock on recovery.") allowed
normal io and sync io to exist at the same time. Task hung will occur as
below:

T1                      T2		T3		T4
raid10d
 handle_read_error
  allow_barrier
   conf->nr_pending--
    -> 0
                        //submit sync io
                        raid10_sync_request
                         raise_barrier
			  ->will not be blocked
			  ...
			//submit to drivers
  raid10_read_request
   wait_barrier
    conf->nr_pending++
     -> 1
					//retry read fail
					raid10_end_read_request
					 reschedule_retry
					  add to retry_list
					  conf->nr_queued++
					   -> 1
							//sync io fail
							end_sync_read
							 __end_sync_read
							  reschedule_retry
							   add to retry_list
					                    conf->nr_queued++
							     -> 2
 ...
 handle_read_error
 get form retry_list
 conf->nr_queued--
  freeze_array
   wait nr_pending == nr_queued+1
        ->1	      ->2
   //task hung

retry read and sync io will be added to retry_list(nr_queued->2) if they
fails. raid10d() called handle_read_error() and hung in freeze_array().
nr_queued will not decrease because raid10d is blocked, nr_pending will
not increase because conf->barrier is not released.

Fix it by moving allow_barrier() after raid10_read_request().
raise_barrier() will wait for nr_waiting to become 0. Therefore, sync io
and regular io will not be issued at the same time.

We also removed the check of nr_queued. It can be 0 but don't need to be
blocked. MD_RECOVERY_RUNNING always is set after this patch, because all
sync io is waitting in raise_barrier(), remove it, too.

Fixes: fe630de009d0 ("md/raid10: avoid deadlock on recovery.")
Signed-off-by: Li Nan <linan122@huawei.com>
---
 drivers/md/raid10.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index 6c66357f92f5..db9ee3b637d6 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -995,11 +995,15 @@ static bool stop_waiting_barrier(struct r10conf *conf)
 	    (!bio_list_empty(&bio_list[0]) || !bio_list_empty(&bio_list[1])))
 		return true;
 
-	/* move on if recovery thread is blocked by us */
-	if (conf->mddev->thread->tsk == current &&
-	    test_bit(MD_RECOVERY_RUNNING, &conf->mddev->recovery) &&
-	    conf->nr_queued > 0)
+	/*
+	 * move on if io is issued from raid10d(), nr_pending is not released
+	 * from original io(see handle_read_error()). All raise barrier is
+	 * blocked until this io is done.
+	 */
+	if (conf->mddev->thread->tsk == current) {
+		WARN_ON_ONCE(atomic_read(&conf->nr_pending) == 0);
 		return true;
+	}
 
 	return false;
 }
@@ -2978,9 +2982,13 @@ static void handle_read_error(struct mddev *mddev, struct r10bio *r10_bio)
 		md_error(mddev, rdev);
 
 	rdev_dec_pending(rdev, mddev);
-	allow_barrier(conf);
 	r10_bio->state = 0;
 	raid10_read_request(mddev, r10_bio->master_bio, r10_bio);
+	/*
+	 * allow_barrier after re-submit to ensure no sync io
+	 * can be issued while regular io pending.
+	 */
+	allow_barrier(conf);
 }
 
 static void handle_write_completed(struct r10conf *conf, struct r10bio *r10_bio)
-- 
2.31.1

