Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD60600309
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 21:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJPTwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 15:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbiJPTwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 15:52:44 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA16243175
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 12:52:42 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id r12-20020a92cd8c000000b002f9f5baaeeaso7717368ilb.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 12:52:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ta4IbepbqarXQ6hRMOj4Zwrb4lJcoW6roeTr4EiTCMM=;
        b=pcO15uLrvDS5FfaSaXmWb0FnBm2Pf9tpMhuMEEQp8zgKbzDBqHW2sPdKFfmeuuXyo/
         pA4tTZHR8WJqiJcBvfEwvkGeRWuUqj48QYh6/RaKfB3pk+eDboSp6SQt9qSwyA8c9kCr
         ZcBeWKk1e5alrcjmEchgmODZu8tq2NodPDTj9ZpTcZa+W+Ae9L2ZC0neGi8BR4fSa6X7
         KodBge6R4QVmV4gqOu6pjSU6uY2V76x5ljtkkkLmsLhUaa2RI/WgHP3H7S+V+TTsSrIE
         EhPyzxidUJc/UllUFphzfZBx1m1N6AifFAzgIfX0jzIDuSexDYdhA0plHKKXsRL45n0L
         T3vw==
X-Gm-Message-State: ACrzQf3M+7u+xNOW09wkDspO96QCDChO1IB5O7IqQ0kVMru7s/DJ+cas
        ht+dA9HXKaTXSITW7r0dHn7HaEhWuOabUF+/2DpW51EWWoF9
X-Google-Smtp-Source: AMsMyM54OwXdudrwPBdUNWp3wYSdeF8moxzUS/sHwLIGpsFF8JYQMqReD/dIzluO49Tyu2BFug8lCUqE2UydOJkj0VkgBxYPmqpQ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:148a:b0:6bc:d563:611c with SMTP id
 a10-20020a056602148a00b006bcd563611cmr3119183iow.35.1665949962106; Sun, 16
 Oct 2022 12:52:42 -0700 (PDT)
Date:   Sun, 16 Oct 2022 12:52:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b47d6605eb2c330b@google.com>
Subject: [syzbot] upstream test error: WARNING in __blk_mq_delay_run_hw_queue
From:   syzbot <syzbot+3f2983906ae3bf133273@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b7cef0d21c37 Merge tag 'for-linus-6.1-rc1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16be8b1c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1afcdebc9f567885
dashboard link: https://syzkaller.appspot.com/bug?extid=3f2983906ae3bf133273
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3f2983906ae3bf133273@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 51 at include/linux/cpumask.h:110 cpumask_check include/linux/cpumask.h:117 [inline]
WARNING: CPU: 1 PID: 51 at include/linux/cpumask.h:110 cpumask_test_cpu include/linux/cpumask.h:441 [inline]
WARNING: CPU: 1 PID: 51 at include/linux/cpumask.h:110 cpu_online include/linux/cpumask.h:1027 [inline]
WARNING: CPU: 1 PID: 51 at include/linux/cpumask.h:110 blk_mq_hctx_next_cpu block/blk-mq.c:2144 [inline]
WARNING: CPU: 1 PID: 51 at include/linux/cpumask.h:110 __blk_mq_delay_run_hw_queue+0x490/0x664 block/blk-mq.c:2185
Modules linked in:
CPU: 1 PID: 51 Comm: kworker/u4:3 Tainted: G        W          6.0.0-syzkaller-12155-gb7cef0d21c37 #0
Hardware name: linux,dummy-virt (DT)
Workqueue: writeback wb_workfn (flush-253:0)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : cpu_max_bits_warn include/linux/cpumask.h:110 [inline]
pc : cpumask_check include/linux/cpumask.h:117 [inline]
pc : cpumask_next_and include/linux/cpumask.h:233 [inline]
pc : blk_mq_hctx_next_cpu block/blk-mq.c:2133 [inline]
pc : __blk_mq_delay_run_hw_queue+0x490/0x664 block/blk-mq.c:2185
lr : blk_mq_run_hw_queue+0x1f0/0x2d4 block/blk-mq.c:2228
sp : ffff800010f362a0
x29: ffff800010f362a0 x28: ffff000011661134 x27: ffff80000de5c000
x26: ffff000011661130 x25: 0000000000000000 x24: 1fffe000022cc226
x23: fffffbffefff6100 x22: 0000000000000000 x21: 0000000000000002
x20: 0000000000000000 x19: ffff000011661000 x18: ffff00006a9eabc0
x17: 00000000000014b8 x16: 00000000f1f1f1f1 x15: 0000000000000002
x14: 1ffff000021e6c32 x13: 0000000000000000 x12: ffff6000022cc209
x11: 1fffe000022cc208 x10: ffff6000022cc208 x9 : dfff800000000000
x8 : ffff000011661047 x7 : ffff80000de5cb68 x6 : ffff80000de5cd50
x5 : 1fffe000022cc226 x4 : 0000000000000004 x3 : 1fffe000020e05d7
x2 : 0000000000000002 x1 : 0000000000000000 x0 : 0000000000000003
Call trace:
 cpumask_check include/linux/cpumask.h:117 [inline]
 cpumask_test_cpu include/linux/cpumask.h:441 [inline]
 cpu_online include/linux/cpumask.h:1027 [inline]
 blk_mq_hctx_next_cpu block/blk-mq.c:2144 [inline]
 __blk_mq_delay_run_hw_queue+0x490/0x664 block/blk-mq.c:2185
 blk_mq_run_hw_queue+0x1f0/0x2d4 block/blk-mq.c:2228
 blk_mq_sched_insert_requests+0x200/0x870 block/blk-mq-sched.c:493
 blk_mq_dispatch_plug_list block/blk-mq.c:2688 [inline]
 blk_mq_flush_plug_list+0x2a8/0xd00 block/blk-mq.c:2730
 __blk_flush_plug+0x74/0x160 block/blk-core.c:1138
 blk_flush_plug include/linux/blkdev.h:1027 [inline]
 io_schedule_prepare kernel/sched/core.c:8692 [inline]
 io_schedule+0xa8/0x114 kernel/sched/core.c:8722
 bit_wait_io+0x18/0xbc kernel/sched/wait_bit.c:209
 __wait_on_bit_lock+0x134/0x240 kernel/sched/wait_bit.c:90
 out_of_line_wait_on_bit_lock+0xd0/0x110 kernel/sched/wait_bit.c:117
 wait_on_bit_lock_io include/linux/wait_bit.h:208 [inline]
 __lock_buffer+0x5c/0x90 fs/buffer.c:69
 lock_buffer include/linux/buffer_head.h:397 [inline]
 do_get_write_access+0x3b4/0x10a4 fs/jbd2/transaction.c:991
 jbd2_journal_get_write_access+0xec/0x15c fs/jbd2/transaction.c:1242
 __ext4_journal_get_write_access+0x150/0x3f0 fs/ext4/ext4_jbd2.c:235
 ext4_mb_mark_diskspace_used+0x198/0xfbc fs/ext4/mballoc.c:3766
 ext4_mb_new_blocks+0xcb0/0x47c0 fs/ext4/mballoc.c:5629
 ext4_ext_map_blocks+0x1ac4/0x5610 fs/ext4/extents.c:4287
 ext4_map_blocks+0x4fc/0x1250 fs/ext4/inode.c:645
 mpage_map_one_extent fs/ext4/inode.c:2413 [inline]
 mpage_map_and_submit_extent fs/ext4/inode.c:2466 [inline]
 ext4_writepages+0x1440/0x2b20 fs/ext4/inode.c:2834
 do_writepages+0x140/0x4c0 mm/page-writeback.c:2469
 __writeback_single_inode+0x140/0x18e4 fs/fs-writeback.c:1587
 writeback_sb_inodes+0x3d0/0xd10 fs/fs-writeback.c:1870
 __writeback_inodes_wb+0xb8/0x1f0 fs/fs-writeback.c:1941
 wb_writeback+0x9d4/0xef4 fs/fs-writeback.c:2046
 wb_check_old_data_flush fs/fs-writeback.c:2146 [inline]
 wb_do_writeback fs/fs-writeback.c:2199 [inline]
 wb_workfn+0x7ac/0x1514 fs/fs-writeback.c:2227
 process_one_work+0x780/0x184c kernel/workqueue.c:2289
 worker_thread+0x3cc/0xc40 kernel/workqueue.c:2436
 kthread+0x23c/0x2a0 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
irq event stamp: 114780
hardirqs last  enabled at (114779): [<ffff80000c913df0>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (114779): [<ffff80000c913df0>] _raw_spin_unlock_irqrestore+0x90/0xc0 kernel/locking/spinlock.c:194
hardirqs last disabled at (114780): [<ffff80000c8f21d4>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:404
softirqs last  enabled at (114768): [<ffff8000080109d4>] _stext+0x9d4/0x107c
softirqs last disabled at (114761): [<ffff800008019cb0>] ____do_softirq+0x10/0x20 arch/arm64/kernel/irq.c:79
---[ end trace 0000000000000000 ]---
netdevsim netdevsim0 netdevsim3 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
device hsr_slave_0 left promiscuous mode
device hsr_slave_1 left promiscuous mode
device veth1_macvtap left promiscuous mode
device veth0_macvtap left promiscuous mode
device veth1_vlan left promiscuous mode
device veth0_vlan left promiscuous mode
bond0 (unregistering): (slave bond_slave_1): Releasing backup interface
bond0 (unregistering): (slave bond_slave_0): Releasing backup interface
bond0 (unregistering): Released all slaves


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
