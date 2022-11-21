Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CF163277A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbiKUPMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:12:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232016AbiKUPLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:11:51 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50980C605E;
        Mon, 21 Nov 2022 07:05:32 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id n12so29132258eja.11;
        Mon, 21 Nov 2022 07:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wWhZetLzoF6gcK5d9FevmjjHGzzJj0g5KA7/YSULYJw=;
        b=J3TpuzGuwWYn4Q32NM9DhKchFU6LexFU8Wqpn5RJdnkgSfZhvDGiQX6+3yQ0mCb5bJ
         4Ca3Y7f43XxSMB9iUesDvHfwhCw6aMt5/crQCU86aQSRdW0cq/IEnYJK41sWfsjNsP5r
         A6YHhchhPjI7WgtZQWtcq0ej9ctUMxOBGO8EDz9gWnKe5tIXLSJ4OoB94QI+Z1zQNnfs
         Q09lrd9M8ETpRrIN05mBP/St8t3J+74hTuJzY7dU3inj+X3QwY68j/iy/9S735LrEe3G
         ydJyn3YJ06KcZeJ52xmq/LAKX7sUagtSjLc4pRbpT7B8MjI8t8rd0x8D7zLk5kbhNyqQ
         JjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wWhZetLzoF6gcK5d9FevmjjHGzzJj0g5KA7/YSULYJw=;
        b=0y1MyuXKFrzUXHjAu65qchTD46Ffysulxrw7APgR7jt5Bu63RCJUcfRqzpB/aOxfVY
         x0zVNuWzb7dsn2yGl2OAJwCypkZD/0mi1PwRnD3uZfsI+NBfv63u9vNsUjWhuKkaJbGH
         3HxwH0ce0VtGwAcSKGjngVizCyIKaltjVSSQcfeFcp3grGZzeqEFrIhxLe/gTo0dqlWa
         W6WHmbAdwWzh2VY5OKzNJlFK+SlwBYhWQ0DsOTWeqW+s4oG2tMEgORpLD98qaw8y9Z8l
         XIHRWBi7ib5AbGNSgHi5YAvGzjyqwY/k1Dm0RKgBCT+wA6crFt1t8iY/lY1Rcco0fTKx
         eDfA==
X-Gm-Message-State: ANoB5pkhUN/8ODyYwTLUcq/SEEfFsa12nlzLLI5dvF43bA9d04Su3vNw
        qnISbAaqCQpi++7eAQ52IwnrI85rx8VxIbxOvnU=
X-Google-Smtp-Source: AA0mqf6vMGgvbI3B2zrBeM0uqH2CvQ3nzlpQOPisZN9Jeg9ZJOpJA7J7g/QJF2emQ/QbfL5u4LwT/vueZ10vOVKQcBk=
X-Received: by 2002:a17:906:802:b0:7b5:6f12:f2c9 with SMTP id
 e2-20020a170906080200b007b56f12f2c9mr5862526ejd.739.1669043130704; Mon, 21
 Nov 2022 07:05:30 -0800 (PST)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Mon, 21 Nov 2022 23:04:55 +0800
Message-ID: <CAO4mrfdMauSM4Ee1Xw_c0s7wWB5sFsSK0CypXJO6eHeN7LNM8A@mail.gmail.com>
Subject: INFO: task hung in nbd_start_device_ioctl
To:     josef@toxicpanda.com, axboe@kernel.dk, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org, tj@kernel.org,
        jiangshanlai@gmail.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered.

HEAD commit: 094226ad94f4 Linux v6.1-rc5
git tree: upstream
compiler: clang 12.0.1
console output:
https://drive.google.com/file/d/15f5Of5MfU2zv-Kk71lgn5gMprC0hhE75/view?usp=share_link
syz reproducer:
https://drive.google.com/file/d/128ClGPSxby6Rc2IiL5dVkWUTbI8xXQjV/view?usp=share_link
C reproducer: https://drive.google.com/file/d/1965s5haTl1NQm6ShugukIVbyOih3pG0L/view?usp=share_link
kernel config: https://drive.google.com/file/d/1TdPsg_5Zon8S2hEFpLBWjb8Tnd2KA5WJ/view?usp=share_link

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

INFO: task syz-executor.0:10784 blocked for more than 143 seconds.
      Not tainted 6.1.0-rc5 #40
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:20792 pid:10784 ppid:6618   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0xbbd/0x1130 kernel/sched/core.c:6503
 schedule+0xcb/0x190 kernel/sched/core.c:6579
 schedule_timeout+0x98/0x2f0 kernel/time/timer.c:1911
 do_wait_for_common+0x3ea/0x560 kernel/sched/completion.c:85
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x46/0x60 kernel/sched/completion.c:138
 __flush_workqueue+0x75a/0x16a0 kernel/workqueue.c:2861
 nbd_start_device_ioctl+0x41f/0x600 drivers/block/nbd.c:1419
 __nbd_ioctl drivers/block/nbd.c:1481 [inline]
 nbd_ioctl+0x28c/0x5b0 drivers/block/nbd.c:1521
 blkdev_ioctl+0x3a6/0x770 block/ioctl.c:614
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0x90 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f389c28bded
RSP: 002b:00007f389d3a2c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f389c3abf80 RCX: 00007f389c28bded
RDX: 0000000000000000 RSI: 000000000000ab03 RDI: 0000000000000004
RBP: 00007f389c2f8ce0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f389c3abf80
R13: 00007ffd6fa63d3f R14: 00007ffd6fa63ee0 R15: 00007f389d3a2dc0
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8cd20d30 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at:
rcu_tasks_one_gp+0x30/0xbd0 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8cd21530 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3},
at: rcu_tasks_one_gp+0x30/0xbd0 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/22:
 #0: ffffffff8cd20b60 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
1 lock held by in:imklog/6512:
 #0: ffff888018cd2fe8 (&f->f_pos_lock){+.+.}-{3:3}, at:
__fdget_pos+0x23a/0x2d0 fs/file.c:1037
2 locks held by kworker/u3:2/6623:
 #0: ffff88801a58f938 ((wq_completion)nbd0-recv){+.+.}-{0:0}, at:
process_one_work+0x7bc/0x11a0
 #1: ffffc9000b42fd20 ((work_completion)(&args->work)){+.+.}-{0:0},
at: process_one_work+0x7fb/0x11a0 kernel/workqueue.c:2264

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 22 Comm: khungtaskd Not tainted 6.1.0-rc5 #40
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 nmi_cpu_backtrace+0x467/0x4f0 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x19c/0x3e0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xcf5/0xd40 kernel/hung_task.c:377
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Best,
Wei
