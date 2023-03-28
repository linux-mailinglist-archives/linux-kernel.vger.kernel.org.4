Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B286CBB6A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjC1Jof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjC1JoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:44:22 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DBB5BA5;
        Tue, 28 Mar 2023 02:44:20 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pm4Wz3pNkz4f3wYm;
        Tue, 28 Mar 2023 17:44:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgCnUiDvtiJkYufTFg--.25586S4;
        Tue, 28 Mar 2023 17:44:16 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     xni@redhat.com, song@kernel.org, logang@deltatee.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next] md: fix regression for null-ptr-deference in __md_stop()
Date:   Tue, 28 Mar 2023 17:44:00 +0800
Message-Id: <20230328094400.1448955-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgCnUiDvtiJkYufTFg--.25586S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGFykAFyUJF48KFy5WrW7urg_yoW5AF17pF
        WxKF98Gr4kX3yxt3yUAF1kua43Xa48JFZ2ya9xCryrA3ZI9rWDu3WUur1UZFWUCr97t3ZI
        qw48ZFZrWas0kwUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
        JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Commit 3e453522593d ("md: Free resources in __md_stop") tried to fix
null-ptr-deference for 'active_io' by moving percpu_ref_exit() to
__md_stop(), however, the commit also moving 'writes_pending' to
__md_stop(), and this will cause mdadm tests broken:

BUG: kernel NULL pointer dereference, address: 0000000000000038
Oops: 0000 [#1] PREEMPT SMP
CPU: 15 PID: 17830 Comm: mdadm Not tainted 6.3.0-rc3-next-20230324-00009-g520d37
RIP: 0010:free_percpu+0x465/0x670
Call Trace:
 <TASK>
 __percpu_ref_exit+0x48/0x70
 percpu_ref_exit+0x1a/0x90
 __md_stop+0xe9/0x170
 do_md_stop+0x1e1/0x7b0
 md_ioctl+0x90c/0x1aa0
 blkdev_ioctl+0x19b/0x400
 vfs_ioctl+0x20/0x50
 __x64_sys_ioctl+0xba/0xe0
 do_syscall_64+0x6c/0xe0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

And the problem can be reporduced 100% by following test:

mdadm -CR /dev/md0 -l1 -n1 /dev/sda --force
echo inactive > /sys/block/md0/md/array_state
echo read-auto  > /sys/block/md0/md/array_state
echo inactive > /sys/block/md0/md/array_state

Root cause:

// start raid
raid1_run
 mddev_init_writes_pending
  percpu_ref_init

// inactive raid
array_state_store
 do_md_stop
  __md_stop
   percpu_ref_exit

// start raid again
array_state_store
 do_md_run
  raid1_run
   mddev_init_writes_pending
    if (mddev->writes_pending.percpu_count_ptr)
    // won't reinit

// inactive raid again
...
percpu_ref_exit
-> null-ptr-deference

Before the commit, 'writes_pending' is exited when mddev is freed, and
it's safe to restart raid because mddev_init_writes_pending() already make
sure that 'writes_pending' will only be initialized once.

Fix the prblem by moving 'writes_pending' back, it's a litter hard to find
the relationship between alloc memory and free memory, however, code
changes is much less and we lived with this for a long time already.

Fixes: 3e453522593d ("md: Free resources in __md_stop")

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 161231e01faa..06f262050400 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6265,7 +6265,6 @@ static void __md_stop(struct mddev *mddev)
 	module_put(pers->owner);
 	clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 
-	percpu_ref_exit(&mddev->writes_pending);
 	percpu_ref_exit(&mddev->active_io);
 	bioset_exit(&mddev->bio_set);
 	bioset_exit(&mddev->sync_set);
@@ -6278,6 +6277,7 @@ void md_stop(struct mddev *mddev)
 	 */
 	__md_stop_writes(mddev);
 	__md_stop(mddev);
+	percpu_ref_exit(&mddev->writes_pending);
 }
 
 EXPORT_SYMBOL_GPL(md_stop);
@@ -7848,6 +7848,7 @@ static void md_free_disk(struct gendisk *disk)
 {
 	struct mddev *mddev = disk->private_data;
 
+	percpu_ref_exit(&mddev->writes_pending);
 	mddev_free(mddev);
 }
 
-- 
2.39.2

