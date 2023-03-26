Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553226C9359
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 11:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjCZJT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 05:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjCZJT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 05:19:26 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7383140EE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 02:19:24 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id n9-20020a056e02100900b00325c9240af7so3947674ilj.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 02:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679822363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2AeJ0TQ3waeu6zi2mYKiIUv97gR3C9uwDWPvs81Zdzk=;
        b=goNzlWtDqus826hKmlgXRB+9A1HQXQb1uAjoIBPxBiEd79eD+jvManupOL48+kq1oV
         2LC8cKSFUkQhVzGiLEKEcGBL/zAvKshKClObw8CJ6mgzIQAiijHgodfF7qLTobL6G3rG
         Oq6KVBS7uhac4jkNf/jG7Vqbej2yrggHc23HvgPZwEwh798cofQ6ZkTBOix4LlPGbu15
         1NOk4ndkGGQ1EUCe/t2tsNBxyc2A29C0LLvGPDmTwoo9cQIxpOXLTfh8Pu3QwVWwa+MY
         aRu+0GrEyWFp9p32A4yXrhV2osxvUYuHpo0IdrhZPznWtH8xSpBh4JAQgq9aG36Ei4OF
         J7gg==
X-Gm-Message-State: AO0yUKXeP1J3oCHr4KLZY+MM/EfLfzPtzfOHcRbh2G8Ku9q0sASzeaGF
        Y4xOml0iqb20bDc4UwS0lmpgiu7soDBXjsKuwFaGYWXVqwro
X-Google-Smtp-Source: AK7set9NG5TWx2MeHNx7Ivf+BUIoQ8rGcgCadvhDVmPltEfybvl0EGh5e01JgmOjVMmHaU1TWZwwCm7sAwGLGkYXUxChqPPHXQs2
MIME-Version: 1.0
X-Received: by 2002:a02:234a:0:b0:406:6e3e:b9d0 with SMTP id
 u71-20020a02234a000000b004066e3eb9d0mr3095535jau.3.1679822363774; Sun, 26 Mar
 2023 02:19:23 -0700 (PDT)
Date:   Sun, 26 Mar 2023 02:19:23 -0700
In-Reply-To: <20230326072242.2228-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047561e05f7ca1fcd@google.com>
Subject: Re: [syzbot] [f2fs?] INFO: task hung in f2fs_balance_fs
From:   syzbot <syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in f2fs_balance_fs

INFO: task kworker/u4:6:3759 blocked for more than 143 seconds.
      Not tainted 6.3.0-rc3-syzkaller-00322-g4bdec23f971b-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:6    state:D stack:22904 pid:3759  ppid:2      flags:0x00004000
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5304 [inline]
 __schedule+0xc91/0x5770 kernel/sched/core.c:6622
 schedule+0xde/0x1a0 kernel/sched/core.c:6698
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6757
 rwsem_down_write_slowpath+0x3e2/0x1220 kernel/locking/rwsem.c:1178
 __down_write_common kernel/locking/rwsem.c:1306 [inline]
 __down_write kernel/locking/rwsem.c:1315 [inline]
 down_write+0x1d2/0x200 kernel/locking/rwsem.c:1574
 f2fs_down_write fs/f2fs/f2fs.h:2207 [inline]
 f2fs_balance_fs+0x54e/0x6c0 fs/f2fs/segment.c:427
 f2fs_write_inode+0x582/0xe00 fs/f2fs/inode.c:760
 write_inode fs/fs-writeback.c:1453 [inline]
 __writeback_single_inode+0x9f8/0xdc0 fs/fs-writeback.c:1665
 writeback_sb_inodes+0x54d/0xe70 fs/fs-writeback.c:1891
 __writeback_inodes_wb+0xc6/0x280 fs/fs-writeback.c:1962
 wb_writeback+0x7e9/0xa50 fs/fs-writeback.c:2067
 wb_check_old_data_flush fs/fs-writeback.c:2167 [inline]
 wb_do_writeback fs/fs-writeback.c:2220 [inline]
 wb_workfn+0x765/0xfc0 fs/fs-writeback.c:2248
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u4:1/11:
 #0: ffff8880b983c298 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2f/0x120 kernel/sched/core.c:539
 #1: ffffc90000107da8 ((work_completion)(&(&kfence_timer)->work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x15c0 kernel/workqueue.c:2365
 #2: ffffffff8c6409f0 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_disable+0x12/0x20 kernel/jump_label.c:242
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8c794b70 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:510
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8c794870 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:510
1 lock held by khungtaskd/27:
 #0: ffffffff8c7956c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6495
4 locks held by kworker/u4:6/3759:
 #0: ffff88801731c938 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801731c938 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801731c938 ((wq_completion)writeback){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88801731c938 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:639 [inline]
 #0: ffff88801731c938 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:666 [inline]
 #0: ffff88801731c938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x87a/0x15c0 kernel/workqueue.c:2361
 #1: ffffc9000f017da8 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x15c0 kernel/workqueue.c:2365
 #2: ffff8880758ec0e0 (&type->s_umount_key#50){.+.+}-{3:3}, at: trylock_super+0x21/0x110 fs/super.c:414
 #3: ffff88801ddb52a8 (&sbi->gc_lock){+.+.}-{3:3}, at: f2fs_down_write fs/f2fs/f2fs.h:2207 [inline]
 #3: ffff88801ddb52a8 (&sbi->gc_lock){+.+.}-{3:3}, at: f2fs_balance_fs+0x54e/0x6c0 fs/f2fs/segment.c:427
1 lock held by syslogd/4423:
2 locks held by getty/4752:
 #0: ffff88802be94098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015a02f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2177
2 locks held by syz-executor.0/5646:
3 locks held by syz-executor.0/6726:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 27 Comm: khungtaskd Not tainted 6.3.0-rc3-syzkaller-00322-g4bdec23f971b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x29c/0x350 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x2a4/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xe16/0x1090 kernel/hung_task.c:379
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 6728 Comm: syz-executor.0 Not tainted 6.3.0-rc3-syzkaller-00322-g4bdec23f971b-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
RIP: 0033:0x7f29b98291cc
Code: 01 c2 49 3b 55 08 77 56 8d 55 ff 85 ed 74 35 0f 1f 80 00 00 00 00 48 39 c1 77 1c 49 8b 75 00 49 89 c1 49 29 c9 46 0f b6 0c 0e <45> 84 c9 74 08 44 88 0c 06 49 8b 45 10 48 83 c0 01 49 89 45 10 83
RSP: 002b:00007f29ba575600 EFLAGS: 00000216
RAX: 00000000026526b0 RBX: 00007f29ba575660 RCX: 0000000000000001
RDX: 00000000000000ed RSI: 00007f29b07ff000 RDI: 00007f29ba575700
RBP: 0000000000000102 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 00007f29ba575670 R12: 00007f29ba575670
R13: 00007f29ba575700 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f29ba576700 GS:  0000000000000000


Tested on:

commit:         4bdec23f Merge tag 'hwmon-for-v6.3-rc4' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11af0adec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea09b0836073ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107b0cd5c80000

