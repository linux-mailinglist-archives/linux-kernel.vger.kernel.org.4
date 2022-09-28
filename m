Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E90E5EE371
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbiI1Rst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiI1Rso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:48:44 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E948F686E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:48:43 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id f4-20020a056e020b4400b002f6681cca5bso10453198ilu.14
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=G+xLYFXY+UMRqDxP9CiGhw1NgJOuVxDOMXTlIhOGD6w=;
        b=p297PrYRAMMmBNpUCBiwZzINIz+qUl7LsjzjmBta4rs/qWy3QJi2BjTILHnn+u0TFj
         jPmhl5C11vKnolp9keGtcC8VBWrjBh9vVPZsx0MBu/r6tGurTztQZGDqlty0VVh7zwS6
         cY7eN1x8NmteRW9Wo5dYrEfyDH5stPxjRTI8kZzel/y+by9hcBaHdbEFILSNMEt501r+
         /iXJOHGP9QqjGjPenhfykcgkhT/e60ICi/jV44+PK1iDaj2PkmX7H+CHzw8VuGqSOSiT
         R7vhpPgzCUS8RZSoTlCK/IzG9imDvHQlr3yU9HWK3xKxqz5ZKdEjs7FpSkeAzvBNoMpV
         xmZA==
X-Gm-Message-State: ACrzQf2sgA04rMPqfv4RfX7+9+8uple9Cp+BWqy3pD4yvpZYBUskC+9/
        YcvFPwK9QL0RKzaozxWfs1Ax006XBgz4AHK2d6nyb6qy1V4N
X-Google-Smtp-Source: AMsMyM7vwpw7Qv2hL7XdbA6gpbFJxgv+tCbQD2U+57LFlCzK/qlBl7R9LykIlRwRsl0hd/0LmVAtbFVF6DwPdgRvarqoLt4LSdck
MIME-Version: 1.0
X-Received: by 2002:a05:6638:140e:b0:35a:7a8e:86e5 with SMTP id
 k14-20020a056638140e00b0035a7a8e86e5mr17781030jad.276.1664387322755; Wed, 28
 Sep 2022 10:48:42 -0700 (PDT)
Date:   Wed, 28 Sep 2022 10:48:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024407a05e9c05f3a@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in gsm_send
From:   syzbot <syzbot+b687fe9bf10db0839715@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
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

HEAD commit:    1a61b828566f Merge tag 'char-misc-6.0-rc7' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14353c4c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
dashboard link: https://syzkaller.appspot.com/bug?extid=b687fe9bf10db0839715
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16017360880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140e75ef080000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/367e34e7ff83/disk-1a61b828.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/91a2819fe451/vmlinux-1a61b828.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b687fe9bf10db0839715@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3606, name: syz-executor269
preempt_count: 101, expected: 0
RCU nest depth: 0, expected: 0
3 locks held by syz-executor269/3606:
 #0: ffff8880250eb098 (&tty->ldisc_sem){++++}-{0:0}, at: __tty_ldisc_lock drivers/tty/tty_ldisc.c:290 [inline]
 #0: ffff8880250eb098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_lock_pair_timeout drivers/tty/tty_ldisc.c:353 [inline]
 #0: ffff8880250eb098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_lock_pair drivers/tty/tty_ldisc.c:367 [inline]
 #0: ffff8880250eb098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_release+0x79/0x2a0 drivers/tty/tty_ldisc.c:775
 #1: ffff888017ac60b0 (&gsm->mutex){+.+.}-{3:3}, at: gsm_cleanup_mux+0xf5/0x800 drivers/tty/n_gsm.c:2446
 #2: ffffc900001f0d70 ((&dlci->t1)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:31 [inline]
 #2: ffffc900001f0d70 ((&dlci->t1)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x6b0 kernel/time/timer.c:1464
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 3606 Comm: syz-executor269 Not tainted 6.0.0-rc6-syzkaller-00309-g1a61b828566f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9892
 __mutex_lock_common kernel/locking/mutex.c:580 [inline]
 __mutex_lock+0x9f/0x1350 kernel/locking/mutex.c:747
 gsm_send.isra.0+0x3b5/0x7a0 drivers/tty/n_gsm.c:704
 gsm_command drivers/tty/n_gsm.c:768 [inline]
 gsm_dlci_begin_close+0x12e/0x210 drivers/tty/n_gsm.c:1892
 gsm_dlci_t1+0x186/0x450 drivers/tty/n_gsm.c:1816
 call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x1d3/0x9c6 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
Code: 74 24 10 e8 fa 1d dc f7 48 89 ef e8 82 9f dc f7 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 33 61 cf f7 65 8b 05 4c 17 7f 76 85 c0 74 0a 5b 5d c3 e8 50 28
RSP: 0018:ffffc90003aef950 EFLAGS: 00000206
RAX: 0000000000000006 RBX: 0000000000000200 RCX: 1ffffffff21265a6
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffff888011bee148 R08: 0000000000000001 R09: ffffffff908e5a0f
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88801bc424c0
R13: ffffc90003aef9e8 R14: ffff888011bee148 R15: 0000000000000000
 spin_unlock_irqrestore include/linux/spinlock.h:404 [inline]
 klist_next+0x288/0x510 lib/klist.c:401
 class_dev_iter_next drivers/base/class.c:311 [inline]
 class_find_device+0x174/0x2a0 drivers/base/class.c:415
 class_find_device_by_devt include/linux/device/class.h:167 [inline]
 device_destroy+0x79/0xd0 drivers/base/core.c:4299
 tty_unregister_device+0x7e/0x1b0 drivers/tty/tty_io.c:3299
 gsm_unregister_devices drivers/tty/n_gsm.c:564 [inline]
 gsm_cleanup_mux+0x5c1/0x800 drivers/tty/n_gsm.c:2465
 gsmld_close+0x41/0x210 drivers/tty/n_gsm.c:2907
 tty_ldisc_close+0x110/0x190 drivers/tty/tty_ldisc.c:456
 tty_ldisc_kill+0x94/0x150 drivers/tty/tty_ldisc.c:608
 tty_ldisc_release+0x1ef/0x2a0 drivers/tty/tty_ldisc.c:776
 tty_release_struct+0x20/0xe0 drivers/tty/tty_io.c:1694
 tty_release+0xc70/0x1200 drivers/tty/tty_io.c:1865
 __fput+0x277/0x9d0 fs/file_table.c:320
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xad5/0x29b0 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f642cb30f69
Code: Unable to access opcode bytes at RIP 0x7f642cb30f3f.
RSP: 002b:00007ffed5a9f4c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f642cba5330 RCX: 00007f642cb30f69
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000000
R10: 000000000000000e R11: 0000000000000246 R12: 00007f642cba5330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.0.0-rc6-syzkaller-00309-g1a61b828566f #0 Tainted: G        W         
-----------------------------
syz-executor269/3606 is trying to lock:
ffff888017ac6430 (&gsm->tx_mutex){+.+.}-{3:3}, at: gsm_send.isra.0+0x3b5/0x7a0 drivers/tty/n_gsm.c:704
other info that might help us debug this:
context-{2:2}
3 locks held by syz-executor269/3606:
 #0: ffff8880250eb098 (&tty->ldisc_sem){++++}-{0:0}, at: __tty_ldisc_lock drivers/tty/tty_ldisc.c:290 [inline]
 #0: ffff8880250eb098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_lock_pair_timeout drivers/tty/tty_ldisc.c:353 [inline]
 #0: ffff8880250eb098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_lock_pair drivers/tty/tty_ldisc.c:367 [inline]
 #0: ffff8880250eb098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_release+0x79/0x2a0 drivers/tty/tty_ldisc.c:775
 #1: ffff888017ac60b0 (&gsm->mutex){+.+.}-{3:3}, at: gsm_cleanup_mux+0xf5/0x800 drivers/tty/n_gsm.c:2446
 #2: ffffc900001f0d70 ((&dlci->t1)){+.-.}-{0:0}, at: lockdep_copy_map include/linux/lockdep.h:31 [inline]
 #2: ffffc900001f0d70 ((&dlci->t1)){+.-.}-{0:0}, at: call_timer_fn+0xd5/0x6b0 kernel/time/timer.c:1464
stack backtrace:
CPU: 1 PID: 3606 Comm: syz-executor269 Tainted: G        W          6.0.0-rc6-syzkaller-00309-g1a61b828566f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4705 [inline]
 check_wait_context kernel/locking/lockdep.c:4766 [inline]
 __lock_acquire.cold+0x322/0x3a7 kernel/locking/lockdep.c:5003
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x12f/0x1350 kernel/locking/mutex.c:747
 gsm_send.isra.0+0x3b5/0x7a0 drivers/tty/n_gsm.c:704
 gsm_command drivers/tty/n_gsm.c:768 [inline]
 gsm_dlci_begin_close+0x12e/0x210 drivers/tty/n_gsm.c:1892
 gsm_dlci_t1+0x186/0x450 drivers/tty/n_gsm.c:1816
 call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x1d3/0x9c6 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:194
Code: 74 24 10 e8 fa 1d dc f7 48 89 ef e8 82 9f dc f7 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 33 61 cf f7 65 8b 05 4c 17 7f 76 85 c0 74 0a 5b 5d c3 e8 50 28
RSP: 0018:ffffc90003aef950 EFLAGS: 00000206
RAX: 0000000000000006 RBX: 0000000000000200 RCX: 1ffffffff21265a6
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffff888011bee148 R08: 0000000000000001 R09: ffffffff908e5a0f
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88801bc424c0
R13: ffffc90003aef9e8 R14: ffff888011bee148 R15: 0000000000000000
 spin_unlock_irqrestore include/linux/spinlock.h:404 [inline]
 klist_next+0x288/0x510 lib/klist.c:401
 class_dev_iter_next drivers/base/class.c:311 [inline]
 class_find_device+0x174/0x2a0 drivers/base/class.c:415
 class_find_device_by_devt include/linux/device/class.h:167 [inline]
 device_destroy+0x79/0xd0 drivers/base/core.c:4299
 tty_unregister_device+0x7e/0x1b0 drivers/tty/tty_io.c:3299
 gsm_unregister_devices drivers/tty/n_gsm.c:564 [inline]
 gsm_cleanup_mux+0x5c1/0x800 drivers/tty/n_gsm.c:2465
 gsmld_close+0x41/0x210 drivers/tty/n_gsm.c:2907
 tty_ldisc_close+0x110/0x190 drivers/tty/tty_ldisc.c:456
 tty_ldisc_kill+0x94/0x150 drivers/tty/tty_ldisc.c:608
 tty_ldisc_release+0x1ef/0x2a0 drivers/tty/tty_ldisc.c:776
 tty_release_struct+0x20/0xe0 drivers/tty/tty_io.c:1694
 tty_release+0xc70/0x1200 drivers/tty/tty_io.c:1865
 __fput+0x277/0x9d0 fs/file_table.c:320
 task_work_run+0xdd/0x1a0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xad5/0x29b0 kernel/exit.c:795
 do_group_exit+0xd2/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f642cb30f69
Code: Unable to access opcode bytes at RIP 0x7f642cb30f3f.
RSP: 002b:00007ffed5a9f4c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f642cba5330 RCX: 00007f642cb30f69
RDX: 000000
----------------
Code disassembly (best guess):
   0:	74 24                	je     0x26
   2:	10 e8                	adc    %ch,%al
   4:	fa                   	cli
   5:	1d dc f7 48 89       	sbb    $0x8948f7dc,%eax
   a:	ef                   	out    %eax,(%dx)
   b:	e8 82 9f dc f7       	callq  0xf7dc9f92
  10:	81 e3 00 02 00 00    	and    $0x200,%ebx
  16:	75 25                	jne    0x3d
  18:	9c                   	pushfq
  19:	58                   	pop    %rax
  1a:	f6 c4 02             	test   $0x2,%ah
  1d:	75 2d                	jne    0x4c
  1f:	48 85 db             	test   %rbx,%rbx
  22:	74 01                	je     0x25
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 33 61 cf f7       	callq  0xf7cf6162 <-- trapping instruction
  2f:	65 8b 05 4c 17 7f 76 	mov    %gs:0x767f174c(%rip),%eax        # 0x767f1782
  36:	85 c0                	test   %eax,%eax
  38:	74 0a                	je     0x44
  3a:	5b                   	pop    %rbx
  3b:	5d                   	pop    %rbp
  3c:	c3                   	retq
  3d:	e8                   	.byte 0xe8
  3e:	50                   	push   %rax
  3f:	28                   	.byte 0x28


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
