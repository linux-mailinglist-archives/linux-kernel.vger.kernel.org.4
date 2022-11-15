Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A32629FB4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiKOQ4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:56:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiKOQ4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:56:46 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDAA26559
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:56:43 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id d19-20020a056e020c1300b00300b5a12c44so11490694ile.15
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cVM3y5wrY7D4Otkxo6Krvby13I+no6VdysKhhtySP90=;
        b=0EQydmgQflWD1JJoRi8O6sh89LyGXrnLobrxjax6aH/TstjwPZ4KObX6kx+LLIrzOg
         kPo6QcTXWULnNaup+O/X5hK+TqjgbBbFunC5JpP6rMH6mp6zbjn9egT0jcFXFuH7hj1/
         639/HlTxkDdBsqDRv/zkPd+Xwf51FMxsKZqNWfaT7iS5iiHvZ7fWED6zjZwt8MkT3O8h
         ri1pFQSkxLVLOLtwnIuVIVHBK5t1hC0aJmS8Y9oV9EYhk3Mv02TBtgL7N66bnVWx8ddG
         zpW3T6V78KWNOzwmf5pO3UsyC6e1e3w3oRuQWQWEf0JJjvkWgFNxn9wjw2AuitH7SX4q
         l9UQ==
X-Gm-Message-State: ANoB5pmChp/94S7NxIBSq5Hmp8DKHIEpoqwfZ+xSRGAnAs2+afSFGRCE
        f+GHWc7W9qC9jiMRrwgDSIZ0GaNGPk/DRomIs20f+Pjcvv2V
X-Google-Smtp-Source: AA0mqf7T40ER3cJ+wsn53K+euYxN2oee/b3ZET3ueAnBXt5e/Jl5afc1GH+4i5FPcCAgM67NbtDeXF21DQtMbWhd5ndnlyySK6kn
MIME-Version: 1.0
X-Received: by 2002:a5d:8b0b:0:b0:6d9:f687:d19d with SMTP id
 k11-20020a5d8b0b000000b006d9f687d19dmr8272791ion.160.1668531403199; Tue, 15
 Nov 2022 08:56:43 -0800 (PST)
Date:   Tue, 15 Nov 2022 08:56:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000959f6b05ed853d12@google.com>
Subject: [syzbot] INFO: task hung in nfc_rfkill_set_block
From:   syzbot <syzbot+3e3c2f8ca188e30b1427@syzkaller.appspotmail.com>
To:     brauner@kernel.org, broonie@kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        madvenka@linux.microsoft.com, scott@os.amperecomputing.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org
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

HEAD commit:    9e4ce762f0e7 Merge branches 'for-next/acpi', 'for-next/asm..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16248b85880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20ffacc1ce1c99b5
dashboard link: https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10b0df56880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150b39a5880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a70eb29add74/disk-9e4ce762.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/769d096516a8/vmlinux-9e4ce762.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9309615f51d5/Image-9e4ce762.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3e3c2f8ca188e30b1427@syzkaller.appspotmail.com

INFO: task kworker/0:0:7 blocked for more than 143 seconds.
      Not tainted 6.1.0-rc5-syzkaller-32254-g9e4ce762f0e7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:0     pid:7     ppid:2      flags:0x00000008
Workqueue: events rfkill_sync_work
Call trace:
 __switch_to+0x180/0x298 arch/arm64/kernel/process.c:553
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0x408/0x594 kernel/sched/core.c:6503
 schedule+0x64/0xa4 kernel/sched/core.c:6579
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6638
 __mutex_lock_common+0x788/0xca8 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 device_lock include/linux/device.h:835 [inline]
 nfc_dev_down net/nfc/core.c:143 [inline]
 nfc_rfkill_set_block+0x3c/0x170 net/nfc/core.c:179
 rfkill_set_block+0xb4/0x1f8 net/rfkill/core.c:345
 rfkill_sync_work+0x64/0x80 net/rfkill/core.c:1042
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
INFO: task kworker/0:16:4591 blocked for more than 143 seconds.
      Not tainted 6.1.0-rc5-syzkaller-32254-g9e4ce762f0e7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:16    state:D stack:0     pid:4591  ppid:2      flags:0x00000008
Workqueue: events rfkill_global_led_trigger_worker
Call trace:
 __switch_to+0x180/0x298 arch/arm64/kernel/process.c:553
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0x408/0x594 kernel/sched/core.c:6503
 schedule+0x64/0xa4 kernel/sched/core.c:6579
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6638
 __mutex_lock_common+0x788/0xca8 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 rfkill_global_led_trigger_worker+0x28/0xcc net/rfkill/core.c:181
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:863
INFO: task syz-executor592:21127 blocked for more than 143 seconds.
      Not tainted 6.1.0-rc5-syzkaller-32254-g9e4ce762f0e7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor592 state:D stack:0     pid:21127 ppid:3132   flags:0x0000000c
Call trace:
 __switch_to+0x180/0x298 arch/arm64/kernel/process.c:553
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0x408/0x594 kernel/sched/core.c:6503
 schedule+0x64/0xa4 kernel/sched/core.c:6579
 schedule_timeout+0x64/0x1b4 kernel/time/timer.c:1911
 do_wait_for_common+0xf4/0x184 kernel/sched/completion.c:85
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x48/0x60 kernel/sched/completion.c:138
 __flush_work+0xd4/0x144 kernel/workqueue.c:3073
 __cancel_work_timer+0x1c4/0x2ac kernel/workqueue.c:3160
 cancel_work_sync+0x24/0x38 kernel/workqueue.c:3196
 rfkill_unregister+0x4c/0xec net/rfkill/core.c:1124
 nfc_unregister_device+0x84/0x190 net/nfc/core.c:1167
 nci_unregister_device+0xc4/0x100 net/nfc/nci/core.c:1302
 virtual_ncidev_close+0x70/0xb0 drivers/nfc/virtual_ncidev.c:166
 __fput+0x198/0x3e4 fs/file_table.c:320
 ____fput+0x20/0x30 fs/file_table.c:348
 task_work_run+0x100/0x148 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x2dc/0xcac kernel/exit.c:820
 __arm64_sys_exit_group+0x0/0x18 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __wake_up_parent+0x0/0x40 kernel/exit.c:959
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

Showing all locks held in the system:
4 locks held by kworker/0:0/7:
 #0: ffff0000c0010738 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x270/0x504 kernel/workqueue.c:2262
 #1: ffff80000f2c3d80 ((work_completion)(&rfkill->sync_work)){+.+.}-{0:0}, at: process_one_work+0x29c/0x504 kernel/workqueue.c:2264
 #2: ffff80000d956080 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_sync_work+0x34/0x80 net/rfkill/core.c:1040
 #3: ffff0000caf73900 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #3: ffff0000caf73900 (&dev->mutex){....}-{3:3}, at: nfc_dev_down net/nfc/core.c:143 [inline]
 #3: ffff0000caf73900 (&dev->mutex){....}-{3:3}, at: nfc_rfkill_set_block+0x3c/0x170 net/nfc/core.c:179
1 lock held by rcu_tasks_kthre/11:
 #0: ffff80000d4d4768 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/12:
 #0: ffff80000d4d4db8 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/27:
 #0: ffff80000d4d4640 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:303
2 locks held by getty/2760:
 #0: ffff0000c7b92098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x28/0x58 drivers/tty/tty_ldisc.c:244
 #1: ffff80000f6ee2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x19c/0x89c drivers/tty/n_tty.c:2177
3 locks held by kworker/0:16/4591:
 #0: ffff0000c0010738 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x270/0x504 kernel/workqueue.c:2262
 #1: ffff800013f4bd80 ((work_completion)(&rfkill_global_led_trigger_work)){+.+.}-{0:0}, at: process_one_work+0x29c/0x504 kernel/workqueue.c:2264
 #2: ffff80000d956080 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_global_led_trigger_worker+0x28/0xcc net/rfkill/core.c:181
1 lock held by syz-executor592/21127:
 #0: ffff0000caf73900 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:835 [inline]
 #0: ffff0000caf73900 (&dev->mutex){....}-{3:3}, at: nfc_unregister_device+0x70/0x190 net/nfc/core.c:1165

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
