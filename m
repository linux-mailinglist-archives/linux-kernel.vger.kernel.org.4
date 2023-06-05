Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C637225E8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjFEMcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjFEMc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:32:26 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B361730;
        Mon,  5 Jun 2023 05:30:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QZXxt4yYlz4f3jqY;
        Mon,  5 Jun 2023 20:30:26 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgCX_7Jj1X1kzPn7Kw--.1730S4;
        Mon, 05 Jun 2023 20:30:27 +0800 (CST)
From:   Zhong Jinghua <zhongjinghua@huaweicloud.com>
To:     axboe@kernel.dk, kay.sievers@vrfy.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huawei.com, yi.zhang@huawei.com, yukuai3@huawei.com,
        yangerkun@huawei.com
Subject: [PATCH -next] loop: Add parm check in loop_control_ioctl
Date:   Mon,  5 Jun 2023 20:28:38 +0800
Message-Id: <20230605122838.2148878-1-zhongjinghua@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCX_7Jj1X1kzPn7Kw--.1730S4
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1rAFy3Xr15Xw4kZF4rGrg_yoW5GrW3pF
        W8Ga45ta4DKF4xuFWjq34kZF98C3WIyayfuFy2ywsY9rZxAryav3yY9Fy5Za1DtFW3JFWr
        ZFnrJ340k3WUCr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WF
        yUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: x2kr0wpmlqwxtxd6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhong Jinghua <zhongjinghua@huawei.com>

We found that in loop_control_ioctl, the kernel panic can be easily caused:

1. syscall(__NR_ioctl, r[1], 0x4c80, 0x80000200000ul);
Create a loop device 0x80000200000ul.
In fact, in the code, it is used as the first_minor number, and the
first_minor number is 0.
So the created loop device number is 7:0.

2. syscall(__NR_ioctl, r[2], 0x4c80, 0ul);
Create a loop device 0x0ul.
Since the 7:0 device has been created in 1, add_disk will fail because
the major and first_minor numbers are consistent.

3. syscall(__NR_ioctl, r[5], 0x4c81, 0ul);
Delete the device that failed to create, the kernel panics.

Panic like below:
BUG: KASAN: null-ptr-deref in device_del+0xb3/0x840 drivers/base/core.c:3107
Call Trace:
 kill_device drivers/base/core.c:3079 [inline]
 device_del+0xb3/0x840 drivers/base/core.c:3107
 del_gendisk+0x463/0x5f0 block/genhd.c:971
 loop_remove drivers/block/loop.c:2190 [inline]
 loop_control_ioctl drivers/block/loop.c:2289 [inline]

The stack like below:
Create loop device:
loop_control_ioctl
  loop_add
    add_disk
      device_add_disk
        bdi_register
          bdi_register_va
            device_create
              device_create_groups_vargs
                device_add
                  kfree(dev->p);
                    dev->p = NULL;

Remove loop device:
loop_control_ioctl
  loop_remove
    del_gendisk
      device_del
        kill_device
          if (dev->p->dead) // p is null

Fix it by adding a check for parm.

Fixes: 770fe30a46a1 ("loop: add management interface for on-demand device allocation")
Signed-off-by: Zhong Jinghua <zhongjinghua@huawei.com>
---
 drivers/block/loop.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 76b96c42f417..60f2a31c4a24 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2084,6 +2084,17 @@ static int loop_add(struct loop_device **l, int i)
 	struct gendisk *disk;
 	int err;
 
+	/*
+	 * i << part_shift is actually used as the first_minor.
+	 * So here should avoid i << part_shift overflow.
+	 * And, MKDEV() expect that the max bits of
+	 * first_minor is 20.
+	 */
+	if (i > 0 && i > MINORMASK >> part_shift) {
+		err = -EINVAL;
+		goto out;
+	}
+
 	err = -ENOMEM;
 	lo = kzalloc(sizeof(*lo), GFP_KERNEL);
 	if (!lo)
@@ -2097,7 +2108,8 @@ static int loop_add(struct loop_device **l, int i)
 		if (err == -ENOSPC)
 			err = -EEXIST;
 	} else {
-		err = idr_alloc(&loop_index_idr, lo, 0, 0, GFP_KERNEL);
+		err = idr_alloc(&loop_index_idr, lo, 0,
+				(MINORMASK >> part_shift) + 1, GFP_KERNEL);
 	}
 	if (err < 0)
 		goto out_free_dev;
-- 
2.31.1

