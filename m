Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A877469E151
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjBUNbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbjBUNbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:31:42 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4E129146;
        Tue, 21 Feb 2023 05:31:40 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4PLgDQ2VZ6z4f3nTR;
        Tue, 21 Feb 2023 21:31:34 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgBnFCK2x_RjDVvKDg--.7628S4;
        Tue, 21 Feb 2023 21:31:36 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     song@kernel.org, xni@redhat.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH] md: fix null-ptr-deference in md_free_disk()
Date:   Tue, 21 Feb 2023 21:55:06 +0800
Message-Id: <20230221135506.296074-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBnFCK2x_RjDVvKDg--.7628S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw15AFykZw18Kr4kKw17ZFb_yoW8ZFW7pa
        yxWas8Kr48XrW5Kw47Xr109as5Xa1qyFy8Kryfur1fAa1Sk390q3WakF109F98GrWrAwn8
        W3WFqa90qF1DCw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

If md_run() failed after 'acitive_io' is initialized, then
percpu_ref_exit() is called in error path, however, later md_free_disk()
will call percpu_ref_exit() again, which lead to following
null-ptr-deference:

BUG: kernel NULL pointer dereference, address: 0000000000000038
Oops: 0000 [#1] PREEMPT SMP
CPU: 41 PID: 585 Comm: kworker/41:1 Not tainted 6.2.0-rc8-next-20230220 #1452
Workqueue: md_misc mddev_delayed_delete
RIP: 0010:free_percpu+0x110/0x630
Call Trace:
 <TASK>
 __percpu_ref_exit+0x44/0x70
 percpu_ref_exit+0x16/0x90
 md_free_disk+0x2f/0x80
 disk_release+0x101/0x180
 device_release+0x84/0x110
 kobject_put+0x12a/0x380
 kobject_put+0x160/0x380
 mddev_delayed_delete+0x19/0x30
 process_one_work+0x269/0x680
 worker_thread+0x266/0x640
 kthread+0x151/0x1b0
 ret_from_fork+0x1f/0x30

Since freeing mddev will exit 'active_io' unconditionally, fix the
problem by removing exiting 'active_io' from error path, this way
it will be delayed to free mddev.

Fixes: 72adae23a72c ("md: Change active_io to percpu")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 927a43db5dfb..77124679b3fd 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5851,7 +5851,7 @@ int md_run(struct mddev *mddev)
 	if (!bioset_initialized(&mddev->bio_set)) {
 		err = bioset_init(&mddev->bio_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
 		if (err)
-			goto exit_active_io;
+			return err;
 	}
 	if (!bioset_initialized(&mddev->sync_set)) {
 		err = bioset_init(&mddev->sync_set, BIO_POOL_SIZE, 0, BIOSET_NEED_BVECS);
@@ -6039,8 +6039,6 @@ int md_run(struct mddev *mddev)
 	bioset_exit(&mddev->sync_set);
 exit_bio_set:
 	bioset_exit(&mddev->bio_set);
-exit_active_io:
-	percpu_ref_exit(&mddev->active_io);
 	return err;
 }
 EXPORT_SYMBOL_GPL(md_run);
-- 
2.31.1

