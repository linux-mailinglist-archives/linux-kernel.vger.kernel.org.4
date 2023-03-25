Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E011F6C91A5
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 00:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjCYXCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 19:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYXCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 19:02:49 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0869BAF39
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 16:02:48 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id d3-20020a056e02050300b00317999dcfb1so3496121ils.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 16:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679785367;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lR0SdRkmZ0uDrNHR1DU/gQI3jGgMYeMI0xS6Q4BLbPY=;
        b=n/wm26QxqElmO/1jRrzrF9Rq5hsZUC7+f3kV39NxO5wrLldmmgj2G3oLs4/YjU+z6J
         48VGfP+To++KULXMjdW4lQROv3443bmuue+IMzFCH5Q4pe/xYihTVrb+S1Bkj5JjtDJj
         oZ9BLocCMhu03BRNGHGkHtjTBdzupAXDzRXLO27jqBXa9Cv8Q9u7eUE7MNHT6MUhe1tE
         eK10cP98Hed146s8Ex2Fg5/FyZsWiqlWnj0I6mL6/3aHeYdFKNtqX8Kf8rVEZbKmWeVT
         4EEzu78M/L5mJHUn91CH58X+/8P9Dp+7GsDMTzz8CFgpgXuBkUrAhS7UO71Za43LHrbv
         kmMQ==
X-Gm-Message-State: AAQBX9ecObHAcGkQo8yqmV8vtnGglZ7A+pTpO+hKSlKn+/YPPFJFak6b
        VGKqy/DXzA3n/IIX5wKYwACqTMGmCNhonTkneh1JuKsAZ0GQ
X-Google-Smtp-Source: AKy350YJfrOIY/ifM8DECBZw90bBxqihALYm9LbENURIiOiC54cbYpZgMieMGbfTqNVaQj5wuBjjB1cxApr8nyPf0THs7gU0FgNi
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a26:b0:30f:6172:b11f with SMTP id
 g6-20020a056e021a2600b0030f6172b11fmr3957047ile.4.1679785367267; Sat, 25 Mar
 2023 16:02:47 -0700 (PDT)
Date:   Sat, 25 Mar 2023 16:02:47 -0700
In-Reply-To: <000000000000b21f0a05e9ec310d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d74d205f7c1821f@google.com>
Subject: Re: [syzbot] [serial?] possible deadlock in tty_port_tty_get
From:   syzbot <syzbot+223c7461c58c58a4cb10@syzkaller.appspotmail.com>
To:     andy.shevchenko@gmail.com, etremblay@distech-controls.com,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        u.kleine-koenig@pengutronix.de, wander@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    65aca32efdcb Merge tag 'mm-hotfixes-stable-2023-03-24-17-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b21b0ec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ef27c4ff127cda5
dashboard link: https://syzkaller.appspot.com/bug?extid=223c7461c58c58a4cb10
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1591ba51c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ac6789c80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+223c7461c58c58a4cb10@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.3.0-rc3-syzkaller-00317-g65aca32efdcb #0 Not tainted
------------------------------------------------------
syz-executor930/5168 is trying to acquire lock:
ffffffff8c8e11e8 (zonelist_update_seq.seqcount){...-}-{0:0}, at: __alloc_pages+0x408/0x4a0 mm/page_alloc.c:5605

but task is already holding lock:
ffff888014325958 (&port->lock){-...}-{2:2}, at: tty_insert_flip_string_and_push_buffer+0x2f/0x160 drivers/tty/tty_buffer.c:628

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&port->lock){-...}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
       tty_port_tty_get+0x21/0xf0 drivers/tty/tty_port.c:327
       tty_port_default_wakeup+0x15/0x40 drivers/tty/tty_port.c:68
       serial8250_tx_chars+0x53e/0xdf0 drivers/tty/serial/8250/8250_port.c:1865
       serial8250_handle_irq.part.0+0x460/0x870 drivers/tty/serial/8250/8250_port.c:1955
       serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1928 [inline]
       serial8250_default_handle_irq+0xb6/0x230 drivers/tty/serial/8250/8250_port.c:1975
       serial8250_interrupt+0xfc/0x200 drivers/tty/serial/8250/8250_core.c:127
       __handle_irq_event_percpu+0x22b/0x730 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0xab/0x1e0 kernel/irq/handle.c:210
       handle_edge_irq+0x263/0xd00 kernel/irq/chip.c:819
       generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
       handle_irq arch/x86/kernel/irq.c:231 [inline]
       __common_interrupt+0xa1/0x220 arch/x86/kernel/irq.c:250
       common_interrupt+0xa8/0xd0 arch/x86/kernel/irq.c:240
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:636
       native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
       arch_safe_halt arch/x86/include/asm/irqflags.h:86 [inline]
       default_idle+0xf/0x20 arch/x86/kernel/process.c:703
       default_idle_call+0x67/0xa0 kernel/sched/idle.c:97
       cpuidle_idle_call kernel/sched/idle.c:170 [inline]
       do_idle+0x31e/0x3e0 kernel/sched/idle.c:282
       cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:379
       start_secondary+0x221/0x2b0 arch/x86/kernel/smpboot.c:264
       secondary_startup_64_no_verify+0xce/0xdb

-> #2 (&port_lock_key
){-...}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
       serial8250_console_write+0x4ba/0x1010 drivers/tty/serial/8250/8250_port.c:3401
       console_emit_next_record kernel/printk/printk.c:2886 [inline]
       console_flush_all+0x49c/0xcc0 kernel/printk/printk.c:2942
       console_unlock+0xb8/0x1f0 kernel/printk/printk.c:3016
       vprintk_emit+0x1bd/0x600 kernel/printk/printk.c:2316
       vprintk+0x84/0xa0 kernel/printk/printk_safe.c:50
       _printk+0xbf/0xf0 kernel/printk/printk.c:2337
       register_console+0x7ef/0x10e0 kernel/printk/printk.c:3467
       univ8250_console_init+0x38/0x50 drivers/tty/serial/8250/8250_core.c:688
       console_init+0xba/0x5c0 kernel/printk/printk.c:3610
       start_kernel+0x273/0x4d0 init/main.c:1081
       secondary_startup_64_no_verify+0xce/0xdb

-> #1 (console_owner){....}-{0:0}:
       console_lock_spinning_enable kernel/printk/printk.c:1867 [inline]
       console_emit_next_record kernel/printk/printk.c:2880 [inline]
       console_flush_all+0x472/0xcc0 kernel/printk/printk.c:2942
       console_unlock+0xb8/0x1f0 kernel/printk/printk.c:3016
       vprintk_emit+0x1bd/0x600 kernel/printk/printk.c:2316
       vprintk+0x84/0xa0 kernel/printk/printk_safe.c:50
       _printk+0xbf/0xf0 kernel/printk/printk.c:2337
       build_zonelists+0x357/0x560 mm/page_alloc.c:6543
       __build_all_zonelists+0x122/0x180 mm/page_alloc.c:6656
       build_all_zonelists_init+0x1c/0x190 mm/page_alloc.c:6681
       build_all_zonelists+0x4a/0x150 mm/page_alloc.c:6714
       start_kernel+0xb7/0x4d0 init/main.c:975
       secondary_startup_64_no_verify+0xce/0xdb

-> #0 (zonelist_update_seq.seqcount){...-}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire kernel/locking/lockdep.c:5669 [inline]
       lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
       seqcount_lockdep_reader_access include/linux/seqlock.h:102 [inline]
       read_seqbegin include/linux/seqlock.h:836 [inline]
       zonelist_iter_begin mm/page_alloc.c:4765 [inline]
       __alloc_pages_slowpath.constprop.0+0x15a/0x2170 mm/page_alloc.c:5086
       __alloc_pages+0x408/0x4a0 mm/page_alloc.c:5605
       __alloc_pages_node include/linux/gfp.h:237 [inline]
       kmem_getpages mm/slab.c:1360 [inline]
       cache_grow_begin+0x9b/0x3b0 mm/slab.c:2570
       cache_alloc_refill+0x27f/0x380 mm/slab.c:2943
       ____cache_alloc mm/slab.c:3019 [inline]
       ____cache_alloc mm/slab.c:3002 [inline]
       __do_cache_alloc mm/slab.c:3202 [inline]
       slab_alloc_node mm/slab.c:3250 [inline]
       __kmem_cache_alloc_node+0x360/0x3f0 mm/slab.c:3541
       __do_kmalloc_node mm/slab_common.c:966 [inline]
       __kmalloc+0x4e/0x190 mm/slab_common.c:980
       kmalloc include/linux/slab.h:584 [inline]
       tty_buffer_alloc+0x275/0x2f0 drivers/tty/tty_buffer.c:180
       __tty_buffer_request_room+0x15b/0x2d0 drivers/tty/tty_buffer.c:278
       tty_insert_flip_string_fixed_flag+0x90/0x250 drivers/tty/tty_buffer.c:327
       tty_insert_flip_string include/linux/tty_flip.h:41 [inline]
       tty_insert_flip_string_and_push_buffer+0x42/0x160 drivers/tty/tty_buffer.c:629
       pty_write+0xda/0x100 drivers/tty/pty.c:118
       ppp_async_push+0x5cb/0x1660 drivers/net/ppp/ppp_async.c:670
       ppp_async_send+0xe2/0x110 drivers/net/ppp/ppp_async.c:638
       __ppp_channel_push+0xe3/0x230 drivers/net/ppp/ppp_generic.c:2150
       ppp_channel_push+0x1c2/0x250 drivers/net/ppp/ppp_generic.c:2177
       ppp_write+0x22b/0x2d0 drivers/net/ppp/ppp_generic.c:523
       do_loop_readv_writev fs/read_write.c:759 [inline]
       do_loop_readv_writev fs/read_write.c:743 [inline]
       do_iter_write+0x4ef/0x700 fs/read_write.c:863
       vfs_writev+0x1aa/0x670 fs/read_write.c:934
       do_pwritev fs/read_write.c:1031 [inline]
       __do_sys_pwritev fs/read_write.c:1078 [inline]
       __se_sys_pwritev fs/read_write.c:1073 [inline]
       __x64_sys_pwritev+0x22f/0x310 fs/read_write.c:1073
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  zonelist_update_seq.seqcount --> &port_lock_key --> &port->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&port->lock);
                               lock(&port_lock_key);
                               lock(&port->lock);
  lock(zonelist_update_seq.seqcount);

 *** DEADLOCK ***

4 locks held by syz-executor930/5168:
 #0: ffff888000630a48 (&pch->upl){.+..}-{2:2}, at: ppp_channel_push+0x28/0x250 drivers/net/ppp/ppp_generic.c:2171
 #1: ffff8880006309e0 (&pch->downl){+...}-{2:2}, at: spin_lock include/linux/spinlock.h:350 [inline]
 #1: ffff8880006309e0 (&pch->downl){+...}-{2:2}, at: __ppp_channel_push+0x2a/0x230 drivers/net/ppp/ppp_generic.c:2146
 #2: ffff8880283b8030 (&ap->xmit_lock){+...}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:355 [inline]
 #2: ffff8880283b8030 (&ap->xmit_lock){+...}-{2:2}, at: ppp_async_push+0xb2/0x1660 drivers/net/ppp/ppp_async.c:663
 #3: ffff888014325958 (&port->lock){-...}-{2:2}, at: tty_insert_flip_string_and_push_buffer+0x2f/0x160 drivers/tty/tty_buffer.c:628

stack backtrace:
CPU: 0 PID: 5168 Comm: syz-executor930 Not tainted 6.3.0-rc3-syzkaller-00317-g65aca32efdcb #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3098 [inline]
 check_prevs_add kernel/locking/lockdep.c:3217 [inline]
 validate_chain kernel/locking/lockdep.c:3832 [inline]
 __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
 lock_acquire kernel/locking/lockdep.c:5669 [inline]
 lock_acquire+0x1af/0x520 kernel/locking/lockdep.c:5634
 seqcount_lockdep_reader_access include/linux/seqlock.h:102 [inline]
 read_seqbegin include/linux/seqlock.h:836 [inline]
 zonelist_iter_begin mm/page_alloc.c:4765 [inline]
 __alloc_pages_slowpath.constprop.0+0x15a/0x2170 mm/page_alloc.c:5086
 __alloc_pages+0x408/0x4a0 mm/page_alloc.c:5605
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 kmem_getpages mm/slab.c:1360 [inline]
 cache_grow_begin+0x9b/0x3b0 mm/slab.c:2570
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2943
 ____cache_alloc mm/slab.c:3019 [inline]
 ____cache_alloc mm/slab.c:3002 [inline]
 __do_cache_alloc mm/slab.c:3202 [inline]
 slab_alloc_node mm/slab.c:3250 [inline]
 __kmem_cache_alloc_node+0x360/0x3f0 mm/slab.c:3541
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc+0x4e/0x190 mm/slab_common.c:980
 kmalloc include/linux/slab.h:584 [inline]
 tty_buffer_alloc+0x275/0x2f0 drivers/tty/tty_buffer.c:180
 __tty_buffer_request_room+0x15b/0x2d0 drivers/tty/tty_buffer.c:278
 tty_insert_flip_string_fixed_flag+0x90/0x250 drivers/tty/tty_buffer.c:327
 tty_insert_flip_string include/linux/tty_flip.h:41 [inline]
 tty_insert_flip_string_and_push_buffer+0x42/0x160 drivers/tty/tty_buffer.c:629
 pty_write+0xda/0x100 drivers/tty/pty.c:118
 ppp_async_push+0x5cb/0x1660 drivers/net/ppp/ppp_async.c:670
 ppp_async_send+0xe2/0x110 drivers/net/ppp/ppp_async.c:638
 __ppp_channel_push+0xe3/0x230 drivers/net/ppp/ppp_generic.c:2150
 ppp_channel_push+0x1c2/0x250 drivers/net/ppp/ppp_generic.c:2177
 ppp_write+0x22b/0x2d0 drivers/net/ppp/ppp_generic.c:523
 do_loop_readv_writev fs/read_write.c:759 [inline]
 do_loop_readv_writev fs/read_write.c:743 [inline]
 do_iter_write+0x4ef/0x700 fs/read_write.c:863
 vfs_writev+0x1aa/0x670 fs/read_write.c:934
 do_pwritev fs/read_write.c:1031 [inline]
 __do_sys_pwritev fs/read_write.c:1078 [inline]
 __se_sys_pwritev fs/read_write.c:1073 [inline]
 __x64_sys_pwritev+0x22f/0x310 fs/read_write.c:1073
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f76be0b97d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffcac24418 EFLAGS: 00000246 ORIG_RAX: 0000000000000128
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f76be0b97d9
RDX: 0000000000000003 RSI: 0000000020000380 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000004 R09: 000000000000000d
R10: 00000000000000f1 R11: 0000000000000246 R12: 00007fffcac24430
R13: 00000000000f4240 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

