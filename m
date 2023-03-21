Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D4D6C379D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCURED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjCUREA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:04:00 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091251E1FD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:03:55 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id f15-20020a05660215cf00b00752dd002fd1so7990647iow.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418235;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2QB/JLyschWN1RNDfVkDwwNUTUpPwkV1rFd89UbZI9k=;
        b=yKPTijaGPwcnB6cthNTT0JaOVzyeJIBzARj4xTwj5gB9JrCOXCXctkmeI8UmM4B/h+
         lM2S5lE1LxwMZb7JhUY8QciTvJ2My8bKRimIrMxCOJZxJ3m6kVW97P3VEKJn32e6XqGs
         1nGc6/H5t2RK4uppBQKv+8xKL8f3FO4Iolp0oGjeRb2XtZBCS6BqfFCk4MOXlhQ3LAdy
         3Nhofu7Z1x702XnVCpiqkWrwtcyfubW50jEaHxjSWy/g6bmItpVzdt2UiE3RNaz5HwWZ
         tLREkx4Qi8nQkcS5l08RuU80QIg/2pdLPZWvnwJZr9SR4fzM/r+C1pvhNqn7jHkFCuiI
         SPVw==
X-Gm-Message-State: AO0yUKVyQaHEIFIdHUeuFQNlrrWX4pYDTHq85zYJ14BV//92bx5OULEv
        SzXQiwWZD4+p7l9uZjvA+EMR4ET42eIjthvzVoJAmbUHE4XF
X-Google-Smtp-Source: AK7set8ERmiGsq22zEnIE8/ZlKHEtIrVFT7xEnDOhRZRRE4uIH9terhS/8dY+3IyTKw/a2RfW3g+4Mqxc7X2R5cH8rJmm3A4M9jy
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:c74:b0:317:9096:e80f with SMTP id
 f20-20020a056e020c7400b003179096e80fmr1314698ilj.4.1679418235206; Tue, 21 Mar
 2023 10:03:55 -0700 (PDT)
Date:   Tue, 21 Mar 2023 10:03:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000056cdc905f76c0733@google.com>
Subject: [syzbot] [xfs?] BUG: sleeping function called from invalid context in vm_map_ram
From:   syzbot <syzbot+6d9043ea38ed2b9ef000@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, lstoakes@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    73f2c2a7e1d2 Add linux-next specific files for 20230320
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11ad6e1cc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f22105589e896af1
dashboard link: https://syzkaller.appspot.com/bug?extid=6d9043ea38ed2b9ef000
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d199bac80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159c7281c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2e4e105e18cf/disk-73f2c2a7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/08d761112297/vmlinux-73f2c2a7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b39e3e871ce/bzImage-73f2c2a7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/662e0db5efdd/mount_0.gz

The issue was bisected to:

commit 8f4977bdd77ee3dce8af81488231e7535695f889
Author: Lorenzo Stoakes <lstoakes@gmail.com>
Date:   Sun Mar 19 07:09:31 2023 +0000

    mm: vmalloc: use rwsem, mutex for vmap_area_lock and vmap_block->lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16c9956ec80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15c9956ec80000
console output: https://syzkaller.appspot.com/x/log.txt?x=11c9956ec80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d9043ea38ed2b9ef000@syzkaller.appspotmail.com
Fixes: 8f4977bdd77e ("mm: vmalloc: use rwsem, mutex for vmap_area_lock and vmap_block->lock")

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 41, name: kworker/u4:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u4:2/41:
 #0: ffff8880234fc938 ((wq_completion)xfs_iwalk-5100){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880234fc938 ((wq_completion)xfs_iwalk-5100){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880234fc938 ((wq_completion)xfs_iwalk-5100){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880234fc938 ((wq_completion)xfs_iwalk-5100){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:643 [inline]
 #0: ffff8880234fc938 ((wq_completion)xfs_iwalk-5100){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:670 [inline]
 #0: ffff8880234fc938 ((wq_completion)xfs_iwalk-5100){+.+.}-{0:0}, at: process_one_work+0x883/0x15e0 kernel/workqueue.c:2376
 #1: ffffc90000b27db0 ((work_completion)(&pwork->work)){+.+.}-{0:0}, at: process_one_work+0x8b7/0x15e0 kernel/workqueue.c:2380
 #2: ffffffff8c796440 (rcu_read_lock){....}-{1:2}, at: vb_alloc mm/vmalloc.c:2090 [inline]
 #2: ffffffff8c796440 (rcu_read_lock){....}-{1:2}, at: vm_map_ram+0x7a/0xcf0 mm/vmalloc.c:2290
CPU: 0 PID: 41 Comm: kworker/u4:2 Not tainted 6.3.0-rc3-next-20230320-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: xfs_iwalk-5100 xfs_pwork_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 __might_resched+0x358/0x580 kernel/sched/core.c:10059
 __mutex_lock_common kernel/locking/mutex.c:580 [inline]
 __mutex_lock+0x9f/0x1350 kernel/locking/mutex.c:747
 vb_alloc mm/vmalloc.c:2105 [inline]
 vm_map_ram+0x13d/0xcf0 mm/vmalloc.c:2290
 _xfs_buf_map_pages+0x158/0x3a0 fs/xfs/xfs_buf.c:441
 xfs_buf_get_map+0x1cb8/0x2fd0 fs/xfs/xfs_buf.c:719
 xfs_buf_read_map+0xce/0xb10 fs/xfs/xfs_buf.c:811
 xfs_buf_readahead_map+0x8c/0xc0 fs/xfs/xfs_buf.c:889
 xfs_buf_readahead fs/xfs/xfs_buf.h:262 [inline]
 xfs_btree_reada_bufs+0x170/0x1e0 fs/xfs/libxfs/xfs_btree.c:926
 xfs_iwalk_ichunk_ra+0x2a1/0x3e0 fs/xfs/xfs_iwalk.c:114
 xfs_iwalk_ag+0x607/0x930 fs/xfs/xfs_iwalk.c:455
 xfs_iwalk_ag_work+0x14a/0x1c0 fs/xfs/xfs_iwalk.c:624
 xfs_pwork_work+0x7f/0x160 fs/xfs/xfs_pwork.c:47
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.3.0-rc3-next-20230320-syzkaller #0 Tainted: G        W         
-----------------------------
kworker/u4:2/41 is trying to lock:
ffff88801d967468 (&vb->lock){+.+.}-{3:3}, at: vb_alloc mm/vmalloc.c:2105 [inline]
ffff88801d967468 (&vb->lock){+.+.}-{3:3}, at: vm_map_ram+0x13d/0xcf0 mm/vmalloc.c:2290
other info that might help us debug this:
context-{4:4}
3 locks held by kworker/u4:2/41:
 #0: ffff8880234fc938 ((wq_completion)xfs_iwalk-5100){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8880234fc938 ((wq_completion)xfs_iwalk-5100){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff8880234fc938 ((wq_completion)xfs_iwalk-5100){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff8880234fc938 ((wq_completion)xfs_iwalk-5100){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:643 [inline]
 #0: ffff8880234fc938 ((wq_completion)xfs_iwalk-5100){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:670 [inline]
 #0: ffff8880234fc938 ((wq_completion)xfs_iwalk-5100){+.+.}-{0:0}, at: process_one_work+0x883/0x15e0 kernel/workqueue.c:2376
 #1: ffffc90000b27db0 ((work_completion)(&pwork->work)){+.+.}-{0:0}, at: process_one_work+0x8b7/0x15e0 kernel/workqueue.c:2380
 #2: ffffffff8c796440 (rcu_read_lock){....}-{1:2}, at: vb_alloc mm/vmalloc.c:2090 [inline]
 #2: ffffffff8c796440 (rcu_read_lock){....}-{1:2}, at: vm_map_ram+0x7a/0xcf0 mm/vmalloc.c:2290
stack backtrace:
CPU: 0 PID: 41 Comm: kworker/u4:2 Tainted: G        W          6.3.0-rc3-next-20230320-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: xfs_iwalk-5100 xfs_pwork_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4724 [inline]
 check_wait_context kernel/locking/lockdep.c:4785 [inline]
 __lock_acquire+0x159e/0x5df0 kernel/locking/lockdep.c:5024
 lock_acquire.part.0+0x11c/0x370 kernel/locking/lockdep.c:5691
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
 vb_alloc mm/vmalloc.c:2105 [inline]
 vm_map_ram+0x13d/0xcf0 mm/vmalloc.c:2290
 _xfs_buf_map_pages+0x158/0x3a0 fs/xfs/xfs_buf.c:441
 xfs_buf_get_map+0x1cb8/0x2fd0 fs/xfs/xfs_buf.c:719
 xfs_buf_read_map+0xce/0xb10 fs/xfs/xfs_buf.c:811
 xfs_buf_readahead_map+0x8c/0xc0 fs/xfs/xfs_buf.c:889
 xfs_buf_readahead fs/xfs/xfs_buf.h:262 [inline]
 xfs_btree_reada_bufs+0x170/0x1e0 fs/xfs/libxfs/xfs_btree.c:926
 xfs_iwalk_ichunk_ra+0x2a1/0x3e0 fs/xfs/xfs_iwalk.c:114
 xfs_iwalk_ag+0x607/0x930 fs/xfs/xfs_iwalk.c:455
 xfs_iwalk_ag_work+0x14a/0x1c0 fs/xfs/xfs_iwalk.c:624
 xfs_pwork_work+0x7f/0x160 fs/xfs/xfs_pwork.c:47
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 41, name: kworker/u4:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
CPU: 1 PID: 41 Comm: kworker/u4:2 Tainted: G        W          6.3.0-rc3-next-20230320-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: xfs_iwalk-5163 xfs_pwork_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 __might_resched+0x358/0x580 kernel/sched/core.c:10059
 __mutex_lock_common kernel/locking/mutex.c:580 [inline]
 __mutex_lock+0x9f/0x1350 kernel/locking/mutex.c:747
 vb_alloc mm/vmalloc.c:2105 [inline]
 vm_map_ram+0x13d/0xcf0 mm/vmalloc.c:2290
 _xfs_buf_map_pages+0x158/0x3a0 fs/xfs/xfs_buf.c:441
 xfs_buf_get_map+0x1cb8/0x2fd0 fs/xfs/xfs_buf.c:719
 xfs_buf_read_map+0xce/0xb10 fs/xfs/xfs_buf.c:811
 xfs_buf_readahead_map+0x8c/0xc0 fs/xfs/xfs_buf.c:889
 xfs_buf_readahead fs/xfs/xfs_buf.h:262 [inline]
 xfs_btree_reada_bufs+0x170/0x1e0 fs/xfs/libxfs/xfs_btree.c:926
 xfs_iwalk_ichunk_ra+0x2a1/0x3e0 fs/xfs/xfs_iwalk.c:114
 xfs_iwalk_ag+0x607/0x930 fs/xfs/xfs_iwalk.c:455
 xfs_iwalk_ag_work+0x14a/0x1c0 fs/xfs/xfs_iwalk.c:624
 xfs_pwork_work+0x7f/0x160 fs/xfs/xfs_pwork.c:47
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 41, name: kworker/u4:2
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
CPU: 1 PID: 41 Comm: kworker/u4:2 Tainted: G        W          6.3.0-rc3-next-20230320-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: xfs_iwalk-5298 xfs_pwork_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 __might_resched+0x358/0x580 kernel/sched/core.c:10059
 __mutex_lock_common kernel/locking/mutex.c:580 [inline]
 __mutex_lock+0x9f/0x1350 kernel/locking/mutex.c:747
 vb_alloc mm/vmalloc.c:2105 [inline]
 vm_map_ram+0x13d/0xcf0 mm/vmalloc.c:2290
 _xfs_buf_map_pages+0x158/0x3a0 fs/xfs/xfs_buf.c:441
 xfs_buf_get_map+0x1cb8/0x2fd0 fs/xfs/xfs_buf.c:719
 xfs_buf_read_map+0xce/0xb10 fs/xfs/xfs_buf.c:811
 xfs_buf_readahead_map+0x8c/0xc0 fs/xfs/xfs_buf.c:889
 xfs_buf_readahead fs/xfs/xfs_buf.h:262 [inline]
 xfs_btree_reada_bufs+0x170/0x1e0 fs/xfs/libxfs/xfs_btree.c:926
 xfs_iwalk_ichunk_ra+0x2a1/0x3e0 fs/xfs/xfs_iwalk.c:114
 xfs_iwalk_ag+0x607/0x930 fs/xfs/xfs_iwalk.c:455
 xfs_iwalk_ag_work+0x14a/0x1c0 fs/xfs/xfs_iwalk.c:624
 xfs_pwork_work+0x7f/0x160 fs/xfs/xfs_pwork.c:47
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
