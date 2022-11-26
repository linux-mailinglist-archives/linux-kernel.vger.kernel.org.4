Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A48639756
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 18:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKZRFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 12:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiKZRFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 12:05:32 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7E017A92
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 09:05:30 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id w16-20020a6b4a10000000b006a5454c789eso3165690iob.20
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 09:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRObnyWQ77FNc5nLTqMCtzarRGWF4vrwXp0aVC1ZsXM=;
        b=TWuV6nqAjAB8d0Ko0qqNbNjF55C1ea/fAzuhJSK00qrX7vastsUTLAX7BVURnpC99h
         IAL0/eckrus3B7zlvgp8oervr6W3nHMXnyyRICTC9KxfiToF7ibvRkFLWUdiuLdLkWyn
         UdsfyKcQ3oojlAcI0irq+3F+Hq3oJ5XFWQd7idfhQW8lOHIFq95O76XkrUsNtVFuMTkn
         bknLXD6iqJ9ZzshaWfs+7XKqS0jwbh1QmkNqC/fUsn0kHlGQzBtiGpNr05S1PMmbNZ44
         Z1feDn6EQMbcCmMUEYFt/UbvuXEcBzg5YcBM9fX8PncS+lS6S2M8Gt2s8+00qPbXdH1K
         Z+Jg==
X-Gm-Message-State: ANoB5plUtD0tPwBPCnWY/VoSDLDorOhmVdqDNdHQfYSl1Dit5ENerx2n
        PFm6IPj1re+oO46L8svMAxmSaKETebliGjGjpOKNeNLuQaIc
X-Google-Smtp-Source: AA0mqf4p0llG8pjr6D5/3po99s7mI54GOU1/c4eZvQCXXkL0eWSU6m9BKrvGZi2SOB9NITeI3//ouUY9tvjDxzeHpit6OI8ueeIQ
MIME-Version: 1.0
X-Received: by 2002:a02:cc6c:0:b0:374:4af4:8630 with SMTP id
 j12-20020a02cc6c000000b003744af48630mr19301712jaq.89.1669482330036; Sat, 26
 Nov 2022 09:05:30 -0800 (PST)
Date:   Sat, 26 Nov 2022 09:05:30 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d9e2405ee62a5a8@google.com>
Subject: [syzbot] possible deadlock in tty_port_default_wakeup
From:   syzbot <syzbot+2bd4a8abdc688d6abb1d@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, etremblay@distech-controls.com,
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

HEAD commit:    eb7081409f94 Linux 6.1-rc6
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12340efd880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5db36e7087dcccae
dashboard link: https://syzkaller.appspot.com/bug?extid=2bd4a8abdc688d6abb1d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2bd4a8abdc688d6abb1d@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc6-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.1/4131 is trying to acquire lock:
ffff88802c93a9d8 (&pool->lock){-.-.}-{2:2}, at: __queue_work+0x367/0x13b0 kernel/workqueue.c:1474

but task is already holding lock:
ffff88801b767528 (&tty->write_wait){-.-.}-{2:2}, at: __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:136

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&tty->write_wait){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
       __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:136
       tty_port_default_wakeup+0x2a/0x40 drivers/tty/tty_port.c:71
       serial8250_tx_chars+0x503/0xdb0 drivers/tty/serial/8250/8250_port.c:1859
       serial8250_handle_irq.part.0+0x460/0x870 drivers/tty/serial/8250/8250_port.c:1949
       serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1922 [inline]
       serial8250_default_handle_irq+0xb6/0x230 drivers/tty/serial/8250/8250_port.c:1969
       serial8250_interrupt+0xfc/0x200 drivers/tty/serial/8250/8250_core.c:126
       __handle_irq_event_percpu+0x264/0x970 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
       handle_edge_irq+0x263/0xd00 kernel/irq/chip.c:819
       generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
       handle_irq arch/x86/kernel/irq.c:231 [inline]
       __common_interrupt+0xa1/0x210 arch/x86/kernel/irq.c:250
       common_interrupt+0xa8/0xd0 arch/x86/kernel/irq.c:240
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:640
       native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
       arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
       default_idle+0xf/0x10 arch/x86/kernel/process.c:730
       default_idle_call+0x84/0xc0 kernel/sched/idle.c:109
       cpuidle_idle_call kernel/sched/idle.c:191 [inline]
       do_idle+0x410/0x590 kernel/sched/idle.c:303
       cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:400
       start_secondary+0x256/0x300 arch/x86/kernel/smpboot.c:262
       secondary_startup_64_no_verify+0xce/0xdb

-> #3 (&port_lock_key){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
       serial8250_console_write+0x4ba/0x1010 drivers/tty/serial/8250/8250_port.c:3395
       call_console_driver kernel/printk/printk.c:1942 [inline]
       console_emit_next_record.constprop.0+0x3de/0x840 kernel/printk/printk.c:2731
       console_flush_all kernel/printk/printk.c:2793 [inline]
       console_unlock+0x3c2/0x600 kernel/printk/printk.c:2860
       vprintk_emit+0x1bd/0x600 kernel/printk/printk.c:2268
       vprintk+0x84/0xa0 kernel/printk/printk_safe.c:50
       _printk+0xbe/0xf1 kernel/printk/printk.c:2289
       register_console kernel/printk/printk.c:3208 [inline]
       register_console+0x45e/0x820 kernel/printk/printk.c:3103
       univ8250_console_init+0x3e/0x4a drivers/tty/serial/8250/8250_core.c:687
       console_init+0x3bb/0x582 kernel/printk/printk.c:3298
       start_kernel+0x303/0x498 init/main.c:1073
       secondary_startup_64_no_verify+0xce/0xdb

-> #2 (console_owner){..-.}-{0:0}:
       console_lock_spinning_enable kernel/printk/printk.c:1805 [inline]
       console_emit_next_record.constprop.0+0x2dd/0x840 kernel/printk/printk.c:2728
       console_flush_all kernel/printk/printk.c:2793 [inline]
       console_unlock+0x3c2/0x600 kernel/printk/printk.c:2860
       vprintk_emit+0x1bd/0x600 kernel/printk/printk.c:2268
       vprintk+0x84/0xa0 kernel/printk/printk_safe.c:50
       _printk+0xbe/0xf1 kernel/printk/printk.c:2289
       build_zonelists.cold+0xe5/0x11f mm/page_alloc.c:6503
       __build_all_zonelists+0x122/0x180 mm/page_alloc.c:6616
       build_all_zonelists_init+0x35/0x12f mm/page_alloc.c:6641
       build_all_zonelists+0x123/0x140 mm/page_alloc.c:6674
       start_kernel+0xbd/0x498 init/main.c:967
       secondary_startup_64_no_verify+0xce/0xdb

-> #1 (zonelist_update_seq.seqcount){...-}-{0:0}:
       seqcount_lockdep_reader_access include/linux/seqlock.h:102 [inline]
       read_seqbegin include/linux/seqlock.h:836 [inline]
       zonelist_iter_begin mm/page_alloc.c:4727 [inline]
       __alloc_pages_slowpath.constprop.0+0x1ae/0x23d0 mm/page_alloc.c:5049
       __alloc_pages+0x4aa/0x5b0 mm/page_alloc.c:5568
       __alloc_pages_node include/linux/gfp.h:223 [inline]
       kmem_getpages mm/slab.c:1363 [inline]
       cache_grow_begin+0x75/0x360 mm/slab.c:2570
       cache_alloc_refill+0x27f/0x380 mm/slab.c:2943
       ____cache_alloc mm/slab.c:3019 [inline]
       ____cache_alloc mm/slab.c:3002 [inline]
       __do_cache_alloc mm/slab.c:3202 [inline]
       slab_alloc_node mm/slab.c:3250 [inline]
       slab_alloc mm/slab.c:3265 [inline]
       __kmem_cache_alloc_lru mm/slab.c:3442 [inline]
       kmem_cache_alloc+0x364/0x460 mm/slab.c:3461
       kmem_cache_zalloc include/linux/slab.h:679 [inline]
       fill_pool+0x264/0x5c0 lib/debugobjects.c:168
       __debug_object_init+0x7a/0xd10 lib/debugobjects.c:562
       debug_object_init lib/debugobjects.c:617 [inline]
       debug_object_activate+0x330/0x3e0 lib/debugobjects.c:703
       debug_work_activate kernel/workqueue.c:510 [inline]
       __queue_work+0x682/0x13b0 kernel/workqueue.c:1516
       queue_work_on+0xf2/0x110 kernel/workqueue.c:1545
       queue_work include/linux/workqueue.h:503 [inline]
       schedule_work include/linux/workqueue.h:564 [inline]
       wireless_send_event+0x6de/0xc40 net/wireless/wext-core.c:635
       __cfg80211_ibss_joined+0x41d/0x540 net/wireless/ibss.c:56
       cfg80211_process_wdev_events+0x391/0x5e0 net/wireless/util.c:986
       cfg80211_process_rdev_events+0x9f/0x130 net/wireless/util.c:1012
       cfg80211_event_work+0x2b/0x40 net/wireless/core.c:328
       process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
       worker_thread+0x669/0x1090 kernel/workqueue.c:2436
       kthread+0x2e8/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

-> #0 (&pool->lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
       lock_acquire kernel/locking/lockdep.c:5668 [inline]
       lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       __queue_work+0x367/0x13b0 kernel/workqueue.c:1474
       queue_work_on+0xf2/0x110 kernel/workqueue.c:1545
       queue_work include/linux/workqueue.h:503 [inline]
       schedule_work include/linux/workqueue.h:564 [inline]
       p9_pollwake+0xc1/0x1d0 net/9p/trans_fd.c:538
       __wake_up_common+0x147/0x650 kernel/sched/wait.c:107
       __wake_up_common_lock+0xd0/0x130 kernel/sched/wait.c:137
       tty_ldisc_lock+0x59/0xb0 drivers/tty/tty_ldisc.c:312
       tty_set_ldisc+0x92/0x680 drivers/tty/tty_ldisc.c:530
       tiocsetd drivers/tty/tty_io.c:2426 [inline]
       tty_ioctl+0x655/0x1660 drivers/tty/tty_io.c:2707
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl fs/ioctl.c:856 [inline]
       __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

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

3 locks held by syz-executor.1/4131:
 #0: ffff88801b7671c0 (&tty->legacy_mutex){+.+.}-{3:3}, at: tty_set_ldisc+0x85/0x680 drivers/tty/tty_ldisc.c:529
 #1: ffff88801b767528 (&tty->write_wait){-.-.}-{2:2}, at: __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:136
 #2: ffffffff8c58ce40 (rcu_read_lock){....}-{1:2}, at: __queue_work+0xca/0x13b0 kernel/workqueue.c:1437

stack backtrace:
CPU: 3 PID: 4131 Comm: syz-executor.1 Not tainted 6.1.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 __queue_work+0x367/0x13b0 kernel/workqueue.c:1474
 queue_work_on+0xf2/0x110 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 schedule_work include/linux/workqueue.h:564 [inline]
 p9_pollwake+0xc1/0x1d0 net/9p/trans_fd.c:538
 __wake_up_common+0x147/0x650 kernel/sched/wait.c:107
 __wake_up_common_lock+0xd0/0x130 kernel/sched/wait.c:137
 tty_ldisc_lock+0x59/0xb0 drivers/tty/tty_ldisc.c:312
 tty_set_ldisc+0x92/0x680 drivers/tty/tty_ldisc.c:530
 tiocsetd drivers/tty/tty_io.c:2426 [inline]
 tty_ioctl+0x655/0x1660 drivers/tty/tty_io.c:2707
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7eff5728c189
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007eff58003168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007eff573ac050 RCX: 00007eff5728c189
RDX: 0000000020000000 RSI: 0000000000005423 RDI: 0000000000000005
RBP: 00007eff572e7b01 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff20cbb7cf R14: 00007eff58003300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
