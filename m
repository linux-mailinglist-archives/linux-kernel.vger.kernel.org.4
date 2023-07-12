Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0636C7508C7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjGLMw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjGLMwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:52:55 -0400
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F18F1984
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:52:53 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6b8a9860ba3so7535406a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689166372; x=1691758372;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1V4z/Vswotro/VzHGCMeSdk+NTVdWdvbvSiVrh+SJc0=;
        b=VF/Hyl6hl7VI0fjBTr65KBC4QRLeP83bczOBNc3+hiOuEN4iqbPIetbwseF4FSwwWP
         h2Rehr0NG5Ax4qe5m65HQ2uf7B3vzo6UuQDbp4hohg0xYKv0TUfKpc+xhXdPqPeqd5tZ
         hfTGYdqETiFTkWwD2M4jOWWuPxr9jjqZuNfLLLC955tOasNtk6NgyL6r5DxZXkaG2Jwn
         Ddsor/8RMe3zlZsld2uoxrD+J+J9U/WvxoJqLKDkWu5gEbrFaUVPsPF/36xGH0b0Ud+r
         t0/fWvZVJE59gW+amyR2IFbXZHpK+wy7z8DvNkzSdr02fn9BN0rUzSyObFAUswGrU/8h
         stTQ==
X-Gm-Message-State: ABy/qLaVIV/I+j7jiKRPReIWr0QAKStkFu76I1NdwQuuKTelLntwCW5e
        qb+hG+cAlQitHE3id9dffZUKKHkFQcqig91AJu9bqZ2qqLRT
X-Google-Smtp-Source: APBJJlHGd7HlxecPxSlbDYhQtqGdt4W8rnFkS3fUR7i0HrW/13UjwkqacALwK8JlyW+xCK5BcqnkXrP65Dztt0ABBgR3UfBlwmuU
MIME-Version: 1.0
X-Received: by 2002:a9d:7a86:0:b0:6b9:208b:c91a with SMTP id
 l6-20020a9d7a86000000b006b9208bc91amr4632052otn.5.1689166372498; Wed, 12 Jul
 2023 05:52:52 -0700 (PDT)
Date:   Wed, 12 Jul 2023 05:52:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000997319060049b1e4@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in cfg80211_event_work (2)
From:   syzbot <syzbot+85f0eb24e10cec9b8a10@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    123212f53f3e Add linux-next specific files for 20230707
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12442688a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15ec80b62f588543
dashboard link: https://syzkaller.appspot.com/bug?extid=85f0eb24e10cec9b8a10
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1049ee88a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b31cbca80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/098f7ee2237c/disk-123212f5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88defebbfc49/vmlinux-123212f5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d5e9343ec16a/bzImage-123212f5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85f0eb24e10cec9b8a10@syzkaller.appspotmail.com

INFO: task kworker/u4:0:10 blocked for more than 143 seconds.
      Not tainted 6.4.0-next-20230707-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u4:0    state:D
 stack:25000 pid:10    ppid:2      flags:0x00004000
Workqueue: cfg80211 cfg80211_event_work

Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5380 [inline]
 __schedule+0xc9a/0x5880 kernel/sched/core.c:6709
 schedule+0xde/0x1a0 kernel/sched/core.c:6785
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6844
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa3b/0x1350 kernel/locking/mutex.c:747
 wiphy_lock include/net/cfg80211.h:5773 [inline]
 cfg80211_event_work+0x1f/0x40 net/wireless/core.c:332
 process_one_work+0xa34/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2748
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u4:0/10:
 #0: 
ffff888016688938
 (
(wq_completion)cfg80211){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:20 [inline]
(wq_completion)cfg80211){+.+.}-{0:0}, at: raw_atomic64_set include/linux/atomic/atomic-arch-fallback.h:2608 [inline]
(wq_completion)cfg80211){+.+.}-{0:0}, at: raw_atomic_long_set include/linux/atomic/atomic-long.h:79 [inline]
(wq_completion)cfg80211){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:3196 [inline]
(wq_completion)cfg80211){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:675 [inline]
(wq_completion)cfg80211){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:702 [inline]
(wq_completion)cfg80211){+.+.}-{0:0}, at: process_one_work+0x8fd/0x16f0 kernel/workqueue.c:2567
 #1: ffffc900000f7db0 ((work_completion)(&rdev->event_work)){+.+.}-{0:0}, at: process_one_work+0x930/0x16f0 kernel/workqueue.c:2571
 #2: ffff88807dc48768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:5773 [inline]
 #2: ffff88807dc48768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: cfg80211_event_work+0x1f/0x40 net/wireless/core.c:332
1 lock held by rcu_tasks_kthre/13:
 #0: 
ffffffff8c9a3db0 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:522
1 lock held by rcu_tasks_trace/14:
 #0: ffffffff8c9a3ab0 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x31/0xd80 kernel/rcu/tasks.h:522
1 lock held by khungtaskd/28:
 #0: ffffffff8c9a49c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x340 kernel/locking/lockdep.c:6615
2 locks held by getty/4776:
 #0: 
ffff8880287e2098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900015872f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xf08/0x13f0 drivers/tty/n_tty.c:2187
8 locks held by kworker/0:0/5070:

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 28 Comm: khungtaskd Not tainted 6.4.0-next-20230707-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x29c/0x350 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x2a4/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:222 [inline]
 watchdog+0xe16/0x1090 kernel/hung_task.c:379
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5070 Comm: kworker/0:0 Not tainted 6.4.0-next-20230707-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Workqueue: events cfg80211_wiphy_work
RIP: 0010:arch_static_branch arch/x86/include/asm/jump_label.h:27 [inline]
RIP: 0010:static_key_false include/linux/jump_label.h:207 [inline]
RIP: 0010:trace_irq_enable.constprop.0+0x2/0x100 include/trace/events/preemptirq.h:40
Code: 00 75 0b 48 83 ec 80 5b 5d 41 5c 41 5d c3 e8 45 74 94 08 0f 1f 44 00 00 f3 0f 1e fa c3 66 66 2e 0f 1f 84 00 00 00 00 00 55 53 <66> 90 65 8b 1d b1 2b 78 7e 83 fb 07 0f 87 cb 00 00 00 89 db be 08
RSP: 0018:ffffc90000007d4SeaBIOS (version 1.8.2-google)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
