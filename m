Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A37655C7D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 07:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiLYGPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 01:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLYGPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 01:15:51 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB495FA7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 22:15:49 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id h26-20020a5e841a000000b006e408c1d2a1so3026575ioj.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 22:15:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wenFkqPjw7gK2ZhQV8BfuxTS0alFC3hXazndC6Vrpjc=;
        b=DpsaD7QWM20mzoH5v5mv0aSjPDd6gkwaWhXQMh4BLEMJnTZKhYbK1UBd515E3Y97bY
         LazpdYZEhgk+wNzVxGadqXR2EBTDyNt8Hn58/e/G+SsXR6DKxrQ7supWdKp25waPOEi1
         8T/7h/27xG6hG68f1ypLUyKrTbOscQyerebRAO0GRb27wPBhYMAvLzVr+hOci+FZoAOe
         +2YXgPjeEWjPjELjPWJqCLIPfCGcLu9HZ8cxH99owfcJAac45nm+kFCarfuqcTupLcP8
         gwBlhCRvNqNCQRPEgIPU8vTUvKw5YyQrbANY1+TAwEC/CPkcZTLY2SdUIZG+Ujdx9Z32
         ESTA==
X-Gm-Message-State: AFqh2kqh6UB9welOzlLzYkHKOTXId8Da/5otVo1fMdABSfV3Jb4C44Xa
        6jRF5nGS2hFKf1w0a7CcacQmpq79fyq+ZIzJ3w6kBBasz9tC
X-Google-Smtp-Source: AMrXdXv1hgcYvuabyXnF21iISGy08dSVNe7K2Jx4eHGTnsARNPqZqXhX9qXczInvHlcQfSI7CF+EuTOY5w4Tid8qwApKfJ2Q7Nhc
MIME-Version: 1.0
X-Received: by 2002:a02:6f04:0:b0:38a:8910:44c6 with SMTP id
 x4-20020a026f04000000b0038a891044c6mr1243643jab.251.1671948948234; Sat, 24
 Dec 2022 22:15:48 -0800 (PST)
Date:   Sat, 24 Dec 2022 22:15:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000246aa905f0a0f394@google.com>
Subject: [syzbot] [reiserfs?] INFO: task hung in __bread_gfp (4)
From:   syzbot <syzbot+9053a1cf1723c8bcce6c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bvanassche@acm.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, muchun.song@linux.dev,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yi.zhang@huawei.com, yijiangshan@kylinos.cn
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

HEAD commit:    e45fb347b630 Add linux-next specific files for 20221220
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10a3ff6f880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ae91cba504b4da8
dashboard link: https://syzkaller.appspot.com/bug?extid=9053a1cf1723c8bcce6c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a346e8480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c2914f880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1ae2b280f860/disk-e45fb347.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/253fc221144a/vmlinux-e45fb347.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e2695a52406f/bzImage-e45fb347.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9053a1cf1723c8bcce6c@syzkaller.appspotmail.com

INFO: task syz-executor106:5074 blocked for more than 143 seconds.
      Not tainted 6.1.0-next-20221220-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor106 state:D stack:25776 pid:5074  ppid:5073   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x2544/0x53f0 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 io_schedule+0xbe/0x130 kernel/sched/core.c:8811
 bit_wait_io+0x16/0xe0 kernel/sched/wait_bit.c:209
 __wait_on_bit+0x64/0x180 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0xd9/0x110 kernel/sched/wait_bit.c:64
 wait_on_bit_io include/linux/wait_bit.h:101 [inline]
 __wait_on_buffer fs/buffer.c:122 [inline]
 wait_on_buffer include/linux/buffer_head.h:388 [inline]
 __bread_slow fs/buffer.c:1178 [inline]
 __bread_gfp+0x29e/0x330 fs/buffer.c:1370
 sb_bread include/linux/buffer_head.h:341 [inline]
 read_super_block+0x83/0x930 fs/reiserfs/super.c:1604
 reiserfs_fill_super+0x75a/0x2e90 fs/reiserfs/super.c:1959
 mount_bdev+0x351/0x410 fs/super.c:1359
 legacy_get_tree+0x109/0x220 fs/fs_context.c:610
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1489
 do_new_mount fs/namespace.c:3145 [inline]
 path_mount+0x132a/0x1e20 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f11845f03d9
RSP: 002b:00007ffd28d7b748 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f11845f03d9
RDX: 00000000200003c0 RSI: 0000000020000380 RDI: 0000000020000340
RBP: 0000000000000000 R08: 0000000000000000 R09: 00007ffd28d7b8e8
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f11845af6f0
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8c791cf0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8c7919f0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8c792840 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x57/0x2c2 kernel/locking/lockdep.c:6494
2 locks held by getty/4754:
 #0: ffff88802783c098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015a02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2177
1 lock held by syz-executor106/5074:
 #0: ffff888079c100e0 (&type->s_umount_key#24/1){+.+.}-{3:3}, at: alloc_super+0x22e/0xb60 fs/super.c:228

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.1.0-next-20221220-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x24/0x18a lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x32f/0x3c0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xc75/0xfc0 kernel/hung_task.c:377
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 9 Comm: kworker/u4:0 Not tainted 6.1.0-next-20221220-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:__bitmap_and+0x182/0x210 lib/bitmap.c:252
Code: 48 89 eb 48 c1 ea 03 48 21 c3 48 b8 00 00 00 00 00 fc ff df 80 3c 02 00 75 6a 48 09 1c 24 49 89 1f e8 32 2e 79 fd 48 8b 1c 24 <31> ff 48 89 de e8 f4 2a 79 fd 48 85 db 0f 95 c0 48 83 c4 30 5b 5d
RSP: 0018:ffffc900000e7910 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff88813fe30000 RSI: ffffffff840826ae RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000000 R12: ffffffff8e72fad0
R13: 0000000000000000 R14: 0000000000000002 R15: ffff8880b983c6c8
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055cdf528d680 CR3: 000000000c48e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 bitmap_and include/linux/bitmap.h:325 [inline]
 cpumask_and include/linux/cpumask.h:525 [inline]
 smp_call_function_many_cond+0x778/0x1090 kernel/smp.c:927
 on_each_cpu_cond_mask+0x5a/0xa0 kernel/smp.c:1155
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:1772 [inline]
 text_poke_bp_batch+0x3f1/0x6b0 arch/x86/kernel/alternative.c:2016
 text_poke_flush arch/x86/kernel/alternative.c:2131 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2128 [inline]
 text_poke_finish+0x1a/0x30 arch/x86/kernel/alternative.c:2138
 arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x32f/0x410 kernel/jump_label.c:829
 static_key_disable_cpuslocked+0x156/0x1b0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate mm/kfence/core.c:804 [inline]
 toggle_allocation_gate+0x143/0x230 mm/kfence/core.c:791
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.148 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
