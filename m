Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF915F894B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 06:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiJIECn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 00:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiJIECh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 00:02:37 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EB02CC8F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 21:02:36 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id z4-20020a921a44000000b002f8da436b83so6489266ill.19
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 21:02:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MjonKB7Cox5ddbxvLzkC7WeBgWTjD7oc5peAzW7M//0=;
        b=JNuNF2fRIyDi7iuS3ERg2qRslYMKWZOS6JFYS6+QgNIhIdacKDq2VpYE6FZelDn5oT
         h+ZHprLCeDLp45VAa0beY3l3NpNoC+gVojC9ShkVE24JH1cxL1HeoD9QCv93bPFMnRHv
         T8kBqVEv9Cx+nPU0WNwuhkBRbkZ4AVCh8SihCNNhbfhGC97UhzkGfXARLacvQWA177/q
         qcIdgbDRk25W/y5lcaNctFSmfAZFNEGACvIpYUFGt9vclija8bMG5k8tZw1N8kwGfEZv
         Mdzu/djWvOPHiJp2eIH4rIx0P5gg2+zHS98/IwbMLyiVO+O97qFS1OaQgNAliFEyOW5x
         geaQ==
X-Gm-Message-State: ACrzQf3x1RUFFxYsOz9v/6db20maP/4ff+JzPJ8cvCaqNUWVLOJCTCBI
        qBPk1utEJwnH/9r6UfVGgsn1NiIAk8cGt8UGSETxWgMrvZTD
X-Google-Smtp-Source: AMsMyM4ai8nRbdvuC9lMSdBEk8gN3El0esCdsNUGDQALcz/rheywJVKMIM5Pic1ueQtM9WMLIaxFE4s44iEVDlQ83buxEo7zzEKl
MIME-Version: 1.0
X-Received: by 2002:a92:c8d0:0:b0:2f9:a4b6:3856 with SMTP id
 c16-20020a92c8d0000000b002f9a4b63856mr5993044ilq.231.1665288154847; Sat, 08
 Oct 2022 21:02:34 -0700 (PDT)
Date:   Sat, 08 Oct 2022 21:02:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb1e9405ea921c80@google.com>
Subject: [syzbot] possible deadlock in __queue_work (3)
From:   syzbot <syzbot+4f8fc6e7d55c70fcd959@syzkaller.appspotmail.com>
To:     andy.shevchenko@gmail.com, etremblay@distech-controls.com,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        u.kleine-koenig@pengutronix.de, wander@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    0326074ff465 Merge tag 'net-next-6.1' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b815b8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=74aee1ba981d846
dashboard link: https://syzkaller.appspot.com/bug?extid=4f8fc6e7d55c70fcd959
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4f8fc6e7d55c70fcd959@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.0.0-syzkaller-02734-g0326074ff465 #0 Not tainted
------------------------------------------------------
kworker/3:18/4289 is trying to acquire lock:
ffff88802c839898 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x216/0x1200 kernel/workqueue.c:1462

but task is already holding lock:
ffff888000932528 (&tty->write_wait){-.-.}-{2:2}, at: __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:136

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&tty->write_wait){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
       __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:136
       tty_port_default_wakeup+0x26/0x40 drivers/tty/tty_port.c:71
       serial8250_tx_chars+0x4f6/0xd90 drivers/tty/serial/8250/8250_port.c:1851
       serial8250_handle_irq.part.0+0x440/0x820 drivers/tty/serial/8250/8250_port.c:1938
       serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1911 [inline]
       serial8250_default_handle_irq+0xb2/0x220 drivers/tty/serial/8250/8250_port.c:1958
       serial8250_interrupt+0xf8/0x200 drivers/tty/serial/8250/8250_core.c:126
       __handle_irq_event_percpu+0x227/0x870 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0xa7/0x1e0 kernel/irq/handle.c:210
       handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:819
       generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
       handle_irq arch/x86/kernel/irq.c:231 [inline]
       __common_interrupt+0x9d/0x210 arch/x86/kernel/irq.c:250
       common_interrupt+0xa4/0xc0 arch/x86/kernel/irq.c:240
       asm_common_interrupt+0x22/0x40 arch/x86/include/asm/idtentry.h:640
       native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
       arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
       default_idle+0xb/0x10 arch/x86/kernel/process.c:730
       default_idle_call+0x80/0xc0 kernel/sched/idle.c:109
       cpuidle_idle_call kernel/sched/idle.c:191 [inline]
       do_idle+0x401/0x590 kernel/sched/idle.c:303
       cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
       start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:262
       secondary_startup_64_no_verify+0xce/0xdb

-> #3 (&port_lock_key){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
       serial8250_console_write+0x975/0xfe0 drivers/tty/serial/8250/8250_port.c:3380
       call_console_driver kernel/printk/printk.c:1945 [inline]
       console_emit_next_record.constprop.0+0x3de/0x840 kernel/printk/printk.c:2732
       console_flush_all kernel/printk/printk.c:2794 [inline]
       console_unlock+0x37a/0x5a0 kernel/printk/printk.c:2861
       vprintk_emit+0x1b9/0x5f0 kernel/printk/printk.c:2271
       vprintk+0x80/0x90 kernel/printk/printk_safe.c:50
       _printk+0xba/0xed kernel/printk/printk.c:2292
       register_console kernel/printk/printk.c:3212 [inline]
       register_console+0x482/0x840 kernel/printk/printk.c:3104
       univ8250_console_init+0x3a/0x46 drivers/tty/serial/8250/8250_core.c:681
       console_init+0x3b7/0x57e kernel/printk/printk.c:3308
       start_kernel+0x2fa/0x48f init/main.c:1066
       secondary_startup_64_no_verify+0xce/0xdb

-> #2 (console_owner){....}-{0:0}:
       console_lock_spinning_enable kernel/printk/printk.c:1808 [inline]
       console_emit_next_record.constprop.0+0x2dd/0x840 kernel/printk/printk.c:2729
       console_flush_all kernel/printk/printk.c:2794 [inline]
       console_unlock+0x37a/0x5a0 kernel/printk/printk.c:2861
       vprintk_emit+0x1b9/0x5f0 kernel/printk/printk.c:2271
       vprintk+0x80/0x90 kernel/printk/printk_safe.c:50
       _printk+0xba/0xed kernel/printk/printk.c:2292
       build_zonelists.cold+0xe5/0x11f mm/page_alloc.c:6471
       __build_all_zonelists+0x122/0x180 mm/page_alloc.c:6584
       build_all_zonelists_init+0x2f/0x104 mm/page_alloc.c:6609
       build_all_zonelists+0x11f/0x140 mm/page_alloc.c:6642
       start_kernel+0xb9/0x48f init/main.c:960
       secondary_startup_64_no_verify+0xce/0xdb

-> #1 (zonelist_update_seq.seqcount){...-}-{0:0}:
       seqcount_lockdep_reader_access include/linux/seqlock.h:102 [inline]
       read_seqbegin include/linux/seqlock.h:836 [inline]
       zonelist_iter_begin mm/page_alloc.c:4722 [inline]
       __alloc_pages_slowpath.constprop.0+0x1a5/0x2300 mm/page_alloc.c:5044
       __alloc_pages+0x43d/0x510 mm/page_alloc.c:5562
       __alloc_pages_node include/linux/gfp.h:243 [inline]
       kmem_getpages mm/slab.c:1363 [inline]
       cache_grow_begin+0x75/0x360 mm/slab.c:2569
       cache_alloc_refill+0x27f/0x380 mm/slab.c:2942
       ____cache_alloc mm/slab.c:3018 [inline]
       ____cache_alloc mm/slab.c:3001 [inline]
       __do_cache_alloc mm/slab.c:3246 [inline]
       slab_alloc mm/slab.c:3287 [inline]
       __kmem_cache_alloc_lru mm/slab.c:3471 [inline]
       kmem_cache_alloc+0x433/0x520 mm/slab.c:3491
       kmem_cache_zalloc include/linux/slab.h:723 [inline]
       fill_pool+0x264/0x5c0 lib/debugobjects.c:168
       __debug_object_init+0x7a/0xd10 lib/debugobjects.c:562
       debug_object_init lib/debugobjects.c:617 [inline]
       debug_object_activate+0x32c/0x3e0 lib/debugobjects.c:703
       debug_work_activate kernel/workqueue.c:510 [inline]
       __queue_work+0x614/0x1200 kernel/workqueue.c:1516
       queue_work_on+0xee/0x110 kernel/workqueue.c:1545
       queue_work include/linux/workqueue.h:503 [inline]
       schedule_work include/linux/workqueue.h:564 [inline]
       key_put.part.0+0x95/0xd0 security/keys/key.c:653
       key_put+0x1b/0x30 security/keys/key.c:649
       put_cred_rcu+0x19a/0x520 kernel/cred.c:118
       rcu_do_batch kernel/rcu/tree.c:2248 [inline]
       rcu_core+0x7b5/0x1890 kernel/rcu/tree.c:2508
       __do_softirq+0x1d0/0x9c8 kernel/softirq.c:571
       invoke_softirq kernel/softirq.c:445 [inline]
       __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
       irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
       sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1107
       asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
       jbd2_journal_write_revoke_records+0x7cc/0xb20 fs/jbd2/revoke.c:548
       jbd2_journal_commit_transaction+0x13cc/0x6a30 fs/jbd2/commit.c:587
       kjournald2+0x1d0/0x930 fs/jbd2/journal.c:210
       kthread+0x2e4/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

-> #0 (&pool->lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5666 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x216/0x1200 kernel/workqueue.c:1462
       queue_work_on+0xee/0x110 kernel/workqueue.c:1545
       queue_work include/linux/workqueue.h:503 [inline]
       schedule_work include/linux/workqueue.h:564 [inline]
       p9_pollwake+0xbd/0x1c0 net/9p/trans_fd.c:535
       __wake_up_common+0x147/0x650 kernel/sched/wait.c:107
       __wake_up_common_lock+0xd0/0x130 kernel/sched/wait.c:137
       tty_write_unlock drivers/tty/tty_io.c:945 [inline]
       do_tty_write drivers/tty/tty_io.c:1049 [inline]
       file_tty_write.constprop.0+0x54c/0x8f0 drivers/tty/tty_io.c:1095
       __kernel_write_iter+0x25e/0x730 fs/read_write.c:517
       __kernel_write fs/read_write.c:537 [inline]
       kernel_write fs/read_write.c:558 [inline]
       kernel_write+0x1bd/0x630 fs/read_write.c:548
       p9_fd_write net/9p/trans_fd.c:429 [inline]
       p9_write_work+0x25e/0xce0 net/9p/trans_fd.c:480
       process_one_work+0x991/0x1610 kernel/workqueue.c:2289
       worker_thread+0x665/0x1080 kernel/workqueue.c:2436
       kthread+0x2e4/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

other info that might help us debug this:

Chain exists of:
  &pool->lock --> &port_lock_key --> &tty->write_wait

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&tty->write_wait);
                               lock(&port_lock_key);
                               lock(&tty->write_wait);
  lock(&pool->lock);

 *** DEADLOCK ***

5 locks held by kworker/3:18/4289:
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888011867d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x87a/0x1610 kernel/workqueue.c:2260
 #1: ffffc9000201fda8 ((work_completion)(&m->wq)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x1610 kernel/workqueue.c:2264
 #2: ffff888000932098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #3: ffff888000932528 (&tty->write_wait){-.-.}-{2:2}, at: __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:136
 #4: ffffffff8bf83940 (rcu_read_lock){....}-{1:2}, at: __queue_work+0xca/0x1200 kernel/workqueue.c:1437

stack backtrace:
CPU: 3 PID: 4289 Comm: kworker/3:18 Not tainted 6.0.0-syzkaller-02734-g0326074ff465 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: events p9_write_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 __queue_work+0x216/0x1200 kernel/workqueue.c:1462
 queue_work_on+0xee/0x110 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 schedule_work include/linux/workqueue.h:564 [inline]
 p9_pollwake+0xbd/0x1c0 net/9p/trans_fd.c:535
 __wake_up_common+0x147/0x650 kernel/sched/wait.c:107
 __wake_up_common_lock+0xd0/0x130 kernel/sched/wait.c:137
 tty_write_unlock drivers/tty/tty_io.c:945 [inline]
 do_tty_write drivers/tty/tty_io.c:1049 [inline]
 file_tty_write.constprop.0+0x54c/0x8f0 drivers/tty/tty_io.c:1095
 __kernel_write_iter+0x25e/0x730 fs/read_write.c:517
 __kernel_write fs/read_write.c:537 [inline]
 kernel_write fs/read_write.c:558 [inline]
 kernel_write+0x1bd/0x630 fs/read_write.c:548
 p9_fd_write net/9p/trans_fd.c:429 [inline]
 p9_write_work+0x25e/0xce0 net/9p/trans_fd.c:480
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
