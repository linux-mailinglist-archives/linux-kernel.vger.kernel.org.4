Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76286267F0
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 09:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234774AbiKLIHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 03:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiKLIG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 03:06:57 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65FA13E20;
        Sat, 12 Nov 2022 00:06:50 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N8SpC1zZ6z4f3tq2;
        Sat, 12 Nov 2022 16:06:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP1 (Coremail) with SMTP id cCh0CgD37awUVG9j5vZ7AQ--.43224S4;
        Sat, 12 Nov 2022 16:06:46 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ming.lei@redhat.com, Ye Bin <yebin10@huawei.com>
Subject: [PATCH -next] blk-mq: fix warning when unregister mq sysfs
Date:   Sat, 12 Nov 2022 16:28:13 +0800
Message-Id: <20221112082813.704873-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgD37awUVG9j5vZ7AQ--.43224S4
X-Coremail-Antispam: 1UD129KBjvJXoWxZF17KrW7GF4xurW3Kw1xZrb_yoW5urW8pr
        43Gw47CrWvgr1UZF4UAan8Xry5Ka1kA3W8ZryfXr1rt3Wjkry5Jr18JFyUJFWkJrZ7Cr4I
        qF4DXw4rtr15WaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

There's issue as follows when do fault injection test:
------------[ cut here ]------------
kernfs: can not remove 'nr_tags', no directory
WARNING: CPU: 8 PID: 2308 at fs/kernfs/dir.c:1635 kernfs_remove_by_name_ns+0xdd/0x100
Modules linked in: null_blk(-)
CPU: 8 PID: 2308 Comm: rmmod Not tainted 6.1.0-rc4-next-20221111+ #131
RIP: 0010:kernfs_remove_by_name_ns+0xdd/0x100
RSP: 0018:ffff88812149fbc8 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffffffffb8137508 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffffb6b49ae0 RDI: ffffed1024293f6b
RBP: ffffffffb8137600 R08: 0000000000000001 R09: ffffed1024293f3d
R10: ffff88812149f9e7 R11: ffffed1024293f3c R12: 0000000000000000
R13: ffffffffb6b2d2a0 R14: ffffffffb6b2d1e0 R15: ffff88822f7f14b8
FS:  00007f97eacb9740(0000) GS:ffff8883ace00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f97e9b72b81 CR3: 000000022fbda000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 remove_files.isra.0+0x6c/0x170
 sysfs_remove_group+0x9b/0x180
 sysfs_remove_groups+0x4f/0xa0
 __kobject_del+0x7d/0x1d0
 kobject_del+0x32/0x50
 blk_mq_sysfs_unregister.cold+0x8/0xd
 blk_unregister_queue+0xed/0x260
 del_gendisk+0x27e/0x900
 null_del_dev.part.0+0x166/0x510 [null_blk]
 null_destroy_dev+0x37/0x5c [null_blk]
 null_exit+0x4c/0x9d [null_blk]
 __do_sys_delete_module.isra.0+0x2f3/0x520
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
 </TASK>

Fault injection context as follows:
 kobject_add
 blk_mq_register_hctx
 blk_mq_sysfs_register
 blk_register_queue
 device_add_disk
 null_add_dev.part.0 [null_blk]

As 'blk_mq_sysfs_register' may failed, but when unregister mq sysfs don't
judge sysfs if registered. 'blk_mq_sysfs_register' also didn't handle
error correctly.
To solve above issue, if sysfs is unregstered just exit.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 block/blk-mq-sysfs.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-sysfs.c b/block/blk-mq-sysfs.c
index 93997d297d42..0cda0a729f3c 100644
--- a/block/blk-mq-sysfs.c
+++ b/block/blk-mq-sysfs.c
@@ -185,7 +185,7 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
 {
 	struct request_queue *q = hctx->queue;
 	struct blk_mq_ctx *ctx;
-	int i, ret;
+	int i, j, ret;
 
 	if (!hctx->nr_ctx)
 		return 0;
@@ -197,9 +197,16 @@ static int blk_mq_register_hctx(struct blk_mq_hw_ctx *hctx)
 	hctx_for_each_ctx(hctx, ctx, i) {
 		ret = kobject_add(&ctx->kobj, &hctx->kobj, "cpu%u", ctx->cpu);
 		if (ret)
-			break;
+			goto out;
 	}
 
+	return 0;
+out:
+	hctx_for_each_ctx(hctx, ctx, j) {
+		if (j < i)
+			kobject_del(&ctx->kobj);
+	}
+	kobject_del(&hctx->kobj);
 	return ret;
 }
 
@@ -278,6 +285,8 @@ void blk_mq_sysfs_unregister(struct gendisk *disk)
 	struct blk_mq_hw_ctx *hctx;
 	unsigned long i;
 
+	if (!q->mq_sysfs_init_done)
+		return;
 	lockdep_assert_held(&q->sysfs_dir_lock);
 
 	queue_for_each_hw_ctx(q, hctx, i)
-- 
2.31.1

