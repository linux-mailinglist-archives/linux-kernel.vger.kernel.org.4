Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D87648E12
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 11:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiLJKEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 05:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiLJKEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 05:04:52 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7FD1929F;
        Sat, 10 Dec 2022 02:04:50 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NTk5R66wZz4f3mSf;
        Sat, 10 Dec 2022 18:04:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgB3jrm9WZRjUP3SBw--.988S4;
        Sat, 10 Dec 2022 18:04:47 +0800 (CST)
From:   Yu Kuai <yukuai1@huaweicloud.com>
To:     jack@suse.cz, paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yukuai1@huaweicloud.com, yi.zhang@huawei.com
Subject: [PATCH] block, bfq: fix possible uaf for 'bfqq->bic'
Date:   Sat, 10 Dec 2022 18:25:37 +0800
Message-Id: <20221210102537.655670-1-yukuai1@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgB3jrm9WZRjUP3SBw--.988S4
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw18XF18XFWfGryDWw13CFg_yoW3Aw4rpr
        sI9ayxCr48JryUZr47Ar48KF18JFZxA3W7JrWIkr1xXa45Zw4YyFyUtF1UWry8Gr4rAa47
        WFn8GrWUtr1Dt3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

Our test report a uaf for 'bfqq->bic' in 5.10:

==================================================================
BUG: KASAN: use-after-free in bfq_select_queue+0x378/0xa30
Read of size 8 at addr ffff88810efb42d8 by task fsstress/2318352

CPU: 6 PID: 2318352 Comm: fsstress Kdump: loaded Not tainted 5.10.0-60.18.0.50.h602.kasan.eulerosv2r11.x86_64 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-20220320_160524-szxrtosci10000 04/01/2014
Call Trace:
 dump_stack+0x9c/0xd3
 print_address_description.constprop.0+0x19/0x170
 ? bfq_select_queue+0x378/0xa30
 __kasan_report.cold+0x6c/0x84
 ? bfq_select_queue+0x378/0xa30
 kasan_report+0x3a/0x50
 bfq_select_queue+0x378/0xa30
 ? bfq_bfqq_expire+0x6c0/0x6c0
 ? bfq_mark_bfqq_busy+0x1f/0x30
 ? _raw_spin_lock_irq+0x7b/0xd0
 __bfq_dispatch_request+0x1c4/0x220
 bfq_dispatch_request+0xe8/0x130
 __blk_mq_do_dispatch_sched+0x3f4/0x560
 ? blk_mq_sched_mark_restart_hctx+0x50/0x50
 ? bfq_init_rq+0x128/0x940
 ? pvclock_clocksource_read+0xf6/0x1d0
 blk_mq_do_dispatch_sched+0x62/0xb0
 __blk_mq_sched_dispatch_requests+0x215/0x2a0
 ? blk_mq_do_dispatch_ctx+0x3a0/0x3a0
 ? bfq_insert_request+0x193/0x3f0
 blk_mq_sched_dispatch_requests+0x8f/0xd0
 __blk_mq_run_hw_queue+0x98/0x180
 __blk_mq_delay_run_hw_queue+0x22b/0x240
 ? bfq_asymmetric_scenario+0x160/0x160
 blk_mq_run_hw_queue+0xe3/0x190
 ? bfq_insert_request+0x3f0/0x3f0
 blk_mq_sched_insert_requests+0x107/0x200
 blk_mq_flush_plug_list+0x26e/0x3c0
 ? blk_mq_insert_requests+0x250/0x250
 ? blk_check_plugged+0x190/0x190
 blk_finish_plug+0x63/0x90
 __iomap_dio_rw+0x7b5/0x910
 ? iomap_dio_actor+0x150/0x150
 ? userns_put+0x70/0x70
 ? userns_put+0x70/0x70
 ? avc_has_perm_noaudit+0x1d0/0x1d0
 ? down_read+0xd5/0x1a0
 ? down_read_killable+0x1b0/0x1b0
 ? from_kgid+0xa0/0xa0
 iomap_dio_rw+0x36/0x80
 ext4_dio_read_iter+0x146/0x190 [ext4]
 ext4_file_read_iter+0x1e2/0x230 [ext4]
 new_sync_read+0x29f/0x400
 ? default_llseek+0x160/0x160
 ? find_isec_ns+0x8d/0x2e0
 ? avc_policy_seqno+0x27/0x40
 ? selinux_file_permission+0x34/0x180
 ? security_file_permission+0x135/0x2b0
 vfs_read+0x24e/0x2d0
 ksys_read+0xd5/0x1b0
 ? __ia32_sys_pread64+0x160/0x160
 ? __audit_syscall_entry+0x1cc/0x220
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x61/0xc6
RIP: 0033:0x7ff05f96fe62
Code: c0 e9 b2 fe ff ff 50 48 8d 3d 12 04 0c 00 e8 b5 fe 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
RSP: 002b:00007fffd30c0ff8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00000000000000a5 RCX: 00007ff05f96fe62
RDX: 000000000001d000 RSI: 0000000001ffc000 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000002019000 R09: 0000000000000000
R10: 00007ff05fa65290 R11: 0000000000000246 R12: 0000000000131800
R13: 000000000001d000 R14: 0000000000000000 R15: 0000000001ffc000

Allocated by task 2318348:
 kasan_save_stack+0x1b/0x40
 __kasan_kmalloc.constprop.0+0xb5/0xe0
 kmem_cache_alloc_node+0x15d/0x480
 ioc_create_icq+0x68/0x2e0
 blk_mq_sched_assign_ioc+0xbc/0xd0
 blk_mq_rq_ctx_init+0x4b0/0x600
 __blk_mq_alloc_request+0x21f/0x2e0
 blk_mq_submit_bio+0x27a/0xd60
 __submit_bio_noacct_mq+0x10b/0x270
 submit_bio_noacct+0x13d/0x150
 submit_bio+0xbf/0x280
 iomap_dio_submit_bio+0x155/0x180
 iomap_dio_bio_actor+0x2f0/0x770
 iomap_dio_actor+0xd9/0x150
 iomap_apply+0x1d2/0x4f0
 __iomap_dio_rw+0x43a/0x910
 iomap_dio_rw+0x36/0x80
 ext4_dio_write_iter+0x46f/0x730 [ext4]
 ext4_file_write_iter+0xd8/0x100 [ext4]
 new_sync_write+0x2ac/0x3a0
 vfs_write+0x365/0x430
 ksys_write+0xd5/0x1b0
 do_syscall_64+0x33/0x40
 entry_SYSCALL_64_after_hwframe+0x61/0xc6

Freed by task 2320929:
 kasan_save_stack+0x1b/0x40
 kasan_set_track+0x1c/0x30
 kasan_set_free_info+0x20/0x40
 __kasan_slab_free+0x151/0x180
 kmem_cache_free+0x9e/0x540
 rcu_do_batch+0x292/0x700
 rcu_core+0x270/0x2d0
 __do_softirq+0xfd/0x402

Last call_rcu():
 kasan_save_stack+0x1b/0x40
 kasan_record_aux_stack+0xa8/0xf0
 __call_rcu+0xa4/0x3a0
 ioc_release_fn+0x45/0x120
 process_one_work+0x3c5/0x730
 worker_thread+0x93/0x650
 kthread+0x1ba/0x210
 ret_from_fork+0x22/0x30

Second to last call_rcu():
 kasan_save_stack+0x1b/0x40
 kasan_record_aux_stack+0xa8/0xf0
 __call_rcu+0xa4/0x3a0
 ioc_release_fn+0x45/0x120
 process_one_work+0x3c5/0x730
 worker_thread+0x93/0x650
 kthread+0x1ba/0x210
 ret_from_fork+0x22/0x30

The buggy address belongs to the object at ffff88810efb42a0
 which belongs to the cache bfq_io_cq of size 160
The buggy address is located 56 bytes inside of
 160-byte region [ffff88810efb42a0, ffff88810efb4340)
The buggy address belongs to the page:
page:00000000a519c14c refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88810efb4000 pfn:0x10efb4
head:00000000a519c14c order:1 compound_mapcount:0
flags: 0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
raw: 0017ffffc0010200 0000000000000000 dead000000000122 ffff8881407c8600
raw: ffff88810efb4000 000000008024001a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88810efb4180: fc fc fc fc fc fc fc fc fb fb fb fb fb fb fb fb
 ffff88810efb4200: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>ffff88810efb4280: fc fc fc fc fa fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88810efb4300: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88810efb4380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
================================================================== 

Commit 3bc5e683c67d ("bfq: Split shared queues on move between cgroups")
changes that move process to a new cgroup will allocate a new bfqq to
use, however, the old bfqq and new bfqq can point to the same bic:

1) Initial state, two process with io in the same cgroup.

Process 1       Process 2
 (BIC1)          (BIC2)
  |  Λ            |  Λ
  |  |            |  |
  V  |            V  |
  bfqq1           bfqq2

2) bfqq1 is merged to bfqq2.

Process 1       Process 2（cg1)
 (BIC1)          (BIC2)
  |               |
   \-------------\|
                  V
  bfqq1           bfqq2(coop)

3) Process 1 exit, then issue new io(denoce IOA) from Process 2.

 (BIC2)
  |  Λ
  |  |
  V  |
  bfqq2(coop)

4) Before IOA is completed, move Process 2 to another cgroup and issue io.

Process 2
 (BIC2)
   Λ
   |\--------------\
   |                V
  bfqq2           bfqq3

Now that BIC2 points to bfqq3, while bfqq2 and bfqq3 both point to BIC2.
If all the requests are completed, and Process 2 exit, BIC2 will be
freed while there is no guarantee that bfqq2 will be freed before BIC2.

Fix the problem by clearing bfqq->bic if process references is decreased
to zero, since that they are not related anymore.

Fixes: 3bc5e683c67d ("bfq: Split shared queues on move between cgroups")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 block/bfq-iosched.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a72304c728fc..6eada99d1b34 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -3036,6 +3036,14 @@ void bfq_release_process_ref(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 
 	bfq_reassign_last_bfqq(bfqq, NULL);
 
+	/*
+	 * __bfq_bic_change_cgroup() just reset bic->bfqq so that a new bfqq
+	 * will be created to handle new io, while old bfqq will stay around
+	 * until all the requests are completed. It's unsafe to keep bfqq->bic
+	 * since they are not related anymore.
+	 */
+	if (bfqq_process_refs(bfqq) == 1)
+		bfqq->bic = NULL;
 	bfq_put_queue(bfqq);
 }
 
-- 
2.31.1

