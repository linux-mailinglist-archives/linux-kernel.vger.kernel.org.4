Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD83A6A885A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCBSLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCBSLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:11:44 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBB03C7B6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 10:11:41 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id x6-20020a920606000000b0031784489cbeso127986ilg.17
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 10:11:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJ1HvKOCsyfFaw/s2rm+TqxkSv+zDGfPOVDPg1uHZws=;
        b=o6d0gkmAaOPiw4qJUL9JfsruSSBorWZ6e1m6KgqI4t5sCcEIECxQeYXKKLTjFrXy+s
         ahdArgLKANQ/N2kpovUkpEJyF1jGMI0FGv6CPr4XFst3CruaUpaLcruJDmmS8KaGrNh2
         NSHAxgSny50nAZJPxI+pEeHr5NrytNuIcGRUhsK8uvUULkD9dhN4s01+TwpAZr6uyZRu
         x2SSYOpCfN+fi9UMbolRNxF8psiohR5WquhuN0fu72NtguI/xqbdEpDnmdT28LC+aQTM
         Crwu54Q35oR8THEqVuLaK5X6gP3IjHcrwUPzSh5sh2pCQbTicFlx3VmeUqq8WFLADm7s
         4u5Q==
X-Gm-Message-State: AO0yUKWXueMAdr7avaIb6fPpHoQWSakT3JZkGuaNkepCD8T416/Alwf2
        2V8fy3WYcFabnhBdf8bKS4Ti7UxplMS3ultcGPXMTl6CV4YR
X-Google-Smtp-Source: AK7set+KKGVuJ/qHkjCEIZVP8I1hpvBrxLeVxW3px70/XuV+kO85nkNFalHuxoE2drSe/WWbPNXeRQBEONxZXEK4SdeXp4OhLw3J
MIME-Version: 1.0
X-Received: by 2002:a6b:6a05:0:b0:745:6b06:6736 with SMTP id
 x5-20020a6b6a05000000b007456b066736mr4777731iog.1.1677780700662; Thu, 02 Mar
 2023 10:11:40 -0800 (PST)
Date:   Thu, 02 Mar 2023 10:11:40 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ac91f005f5eec2e5@google.com>
Subject: [syzbot] [block?] INFO: task hung in blkdev_get_by_dev (5)
From:   syzbot <syzbot+6229476844294775319e@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ee3f96b16468 Merge tag 'nfsd-6.3-1' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d4237f480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cab35c936731a347
dashboard link: https://syzkaller.appspot.com/bug?extid=6229476844294775319e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=143ecd60c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16bb7498c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cc502d28340b/disk-ee3f96b1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bbcfd7d6898c/vmlinux-ee3f96b1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e9a1eddff73b/bzImage-ee3f96b1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6229476844294775319e@syzkaller.appspotmail.com

INFO: task syz-executor272:5173 blocked for more than 143 seconds.
      Not tainted 6.2.0-syzkaller-13115-gee3f96b16468 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor272 state:D stack:28152 pid:5173  ppid:5104   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0xcce/0x5b20 kernel/sched/core.c:6622
 schedule+0xde/0x1a0 kernel/sched/core.c:6698
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6757
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa3b/0x1350 kernel/locking/mutex.c:747
 blkdev_get_by_dev.part.0+0x9b/0xb80 block/bdev.c:735
 blkdev_get_by_dev+0x6f/0x90 block/bdev.c:778
 disk_scan_partitions+0x1dd/0x280 block/genhd.c:374
 blkdev_common_ioctl+0x649/0x1ba0 block/ioctl.c:531
 blkdev_ioctl+0x2c6/0x800 block/ioctl.c:610
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc19fcb55a9
RSP: 002b:00007fc19fc62308 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc19fd3a4c8 RCX: 00007fc19fcb55a9
RDX: 0000000000000000 RSI: 000000000000125f RDI: 0000000000000003
RBP: 00007fc19fd3a4c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fc19fd3a4cc
R13: 00007fc19fd071bc R14: 64626e2f7665642f R15: 0000000000022000
 </TASK>
INFO: task syz-executor272:5174 blocked for more than 143 seconds.
      Not tainted 6.2.0-syzkaller-13115-gee3f96b16468 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor272 state:D stack:28632 pid:5174  ppid:5104   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0xcce/0x5b20 kernel/sched/core.c:6622
 schedule+0xde/0x1a0 kernel/sched/core.c:6698
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6757
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa3b/0x1350 kernel/locking/mutex.c:747
 blkdev_put+0xc0/0x770 block/bdev.c:833
 blkdev_close+0x68/0x80 block/fops.c:507
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 get_signal+0x1c7/0x25b0 kernel/signal.c:2635
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc19fcb55a9
RSP: 002b:00007fc19fc41308 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: 0000000000000000 RBX: 00007fc19fd3a4d8 RCX: 00007fc19fcb55a9
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000006
RBP: 00007fc19fd3a4d0 R08: 00007fc19fc41700 R09: 0000000000000000
R10: 00007fc19fc41700 R11: 0000000000000246 R12: 00007fc19fd3a4dc
R13: 00007fc19fd071bc R14: 64626e2f7665642f R15: 0000000000022000
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8c794e70 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:510
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8c794b70 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:510
1 lock held by khungtaskd/28:
 #0: ffffffff8c7959c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6495
2 locks held by getty/4757:
 #0: ffff88802792d098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015c02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2177
1 lock held by udevd/5109:
 #0: ffff88801e6c64c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x9b/0xb80 block/bdev.c:735
1 lock held by syz-executor272/5173:
 #0: ffff88801e6c64c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev.part.0+0x9b/0xb80 block/bdev.c:735
1 lock held by syz-executor272/5174:
 #0: ffff88801e6c64c8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_put+0xc0/0x770 block/bdev.c:833

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.2.0-syzkaller-13115-gee3f96b16468 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x316/0x3e0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x33f/0x460 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xe94/0x11e0 kernel/hung_task.c:379
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 9 Comm: kworker/u4:0 Not tainted 6.2.0-syzkaller-13115-gee3f96b16468 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:__sanitizer_cov_trace_const_cmp8+0x8/0x20 kernel/kcov.c:310
Code: 00 00 f3 0f 1e fa 48 8b 0c 24 89 f2 89 fe bf 05 00 00 00 e9 9a fe ff ff 66 2e 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 48 8b 0c 24 <48> 89 f2 48 89 fe bf 07 00 00 00 e9 78 fe ff ff 0f 1f 84 00 00 00
RSP: 0018:ffffc900000e7998 EFLAGS: 00000202
RAX: dffffc0000000000 RBX: 0000000012467007 RCX: ffffffff81c2e957
RDX: 1ffff1100248cb55 RSI: 0000000012467007 RDI: 0000000000000000
RBP: 00002aaaaaaab000 R08: 0000000000000007 R09: 0000000000000080
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000012467067
R13: ffffc900000e7a40 R14: ffff888012465aa8 R15: ffff888012468000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055edea9b5c20 CR3: 000000000c571000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 __get_locked_pte+0x67/0x270 mm/memory.c:1783
 get_locked_pte include/linux/mm.h:2448 [inline]
 __text_poke+0x1b3/0x8e0 arch/x86/kernel/alternative.c:1584
 text_poke arch/x86/kernel/alternative.c:1669 [inline]
 text_poke_bp_batch+0x3af/0x770 arch/x86/kernel/alternative.c:1992
 text_poke_flush arch/x86/kernel/alternative.c:2161 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:2158 [inline]
 text_poke_finish+0x1a/0x30 arch/x86/kernel/alternative.c:2168
 arch_jump_label_transform_apply+0x17/0x30 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x32f/0x410 kernel/jump_label.c:829
 static_key_disable_cpuslocked+0x156/0x1b0 kernel/jump_label.c:235
 static_key_disable+0x1a/0x20 kernel/jump_label.c:243
 toggle_allocation_gate mm/kfence/core.c:804 [inline]
 toggle_allocation_gate+0x143/0x230 mm/kfence/core.c:791
 process_one_work+0x9bf/0x1820 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
