Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B040661E981
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiKGDVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbiKGDVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:21:00 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB3D1178;
        Sun,  6 Nov 2022 19:18:32 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5Gds5vsKz4f4Qk1;
        Mon,  7 Nov 2022 11:18:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgBnfbgDeWhjLBJwAA--.9127S4;
        Mon, 07 Nov 2022 11:18:28 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ming.lei@redhat.com, Ye Bin <yebin10@huawei.com>,
        syzbot+746a4eece09f86bc39d7@syzkaller.appspotmail.com
Subject: [PATCH] block: fix crash in 'blk_mq_elv_switch_none'
Date:   Mon,  7 Nov 2022 11:39:56 +0800
Message-Id: <20221107033956.3276891-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgBnfbgDeWhjLBJwAA--.9127S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW3Cw15KF1UuFyxtrykGrg_yoW5Zry8pr
        47Jr4DGFW0gr17ZF48t3W7Jw1UJr9akF45Ww17ur1qyF1UCry7JF18KayUAr18Jr48JFZF
        qr1DX3W8tw1UGaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
        AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
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

Syzbot found the following issue:
general protection fault, probably for non-canonical address 0xdffffc000000001d: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000e8-0x00000000000000ef]
CPU: 0 PID: 5234 Comm: syz-executor931 Not tainted 6.1.0-rc3-next-20221102-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:__elevator_get block/elevator.h:94 [inline]
RIP: 0010:blk_mq_elv_switch_none block/blk-mq.c:4593 [inline]
RIP: 0010:__blk_mq_update_nr_hw_queues block/blk-mq.c:4658 [inline]
RIP: 0010:blk_mq_update_nr_hw_queues+0x304/0xe40 block/blk-mq.c:4709
RSP: 0018:ffffc90003cdfc08 EFLAGS: 00010206
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 000000000000001d RSI: 0000000000000002 RDI: 00000000000000e8
RBP: ffff88801dbd0000 R08: ffff888027c89398 R09: ffffffff8de2e517
R10: fffffbfff1bc5ca2 R11: 0000000000000000 R12: ffffc90003cdfc70
R13: ffff88801dbd0008 R14: ffff88801dbd03f8 R15: ffff888027c89380
FS:  0000555557259300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005d84c8 CR3: 000000007a7cb000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nbd_start_device+0x153/0xc30 drivers/block/nbd.c:1355
 nbd_start_device_ioctl drivers/block/nbd.c:1405 [inline]
 __nbd_ioctl drivers/block/nbd.c:1481 [inline]
 nbd_ioctl+0x5a1/0xbd0 drivers/block/nbd.c:1521
 blkdev_ioctl+0x36e/0x800 block/ioctl.c:614
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

As after dd6f7f17bf58 commit move '__elevator_get(qe->type)' before set
'qe->type', so will lead to access wild pointer.
To solve above issue get 'qe->type' after set 'qe->type'.

Reported-by: syzbot+746a4eece09f86bc39d7@syzkaller.appspotmail.com
Fixes:dd6f7f17bf58("block: add proper helpers for elevator_type module refcount management")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2757368dc83f..3173d621f1f7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4589,9 +4589,9 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 
 	INIT_LIST_HEAD(&qe->node);
 	qe->q = q;
+	qe->type = q->elevator->type;
 	/* keep a reference to the elevator module as we'll switch back */
 	__elevator_get(qe->type);
-	qe->type = q->elevator->type;
 	list_add(&qe->node, head);
 	elevator_disable(q);
 	mutex_unlock(&q->sysfs_lock);
-- 
2.31.1

