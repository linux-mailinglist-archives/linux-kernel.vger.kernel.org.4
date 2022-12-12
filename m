Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288AB64A937
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 22:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiLLVJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 16:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbiLLVJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 16:09:40 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4A412AD2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:09:39 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id n15-20020a056e021baf00b0030387c2e1d3so6064317ili.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 13:09:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6WVbs5afi9Yvhbb4k9+VB2+HUVlxj/Ns9Egcuhgeejs=;
        b=kiZxX48v4RS2ozOqFaIsiMNxRoK5MyI3KrmZUCzSfvs+wA0JheUQMK47oq0Fwjk8x4
         gmTnys9EfwJjAy4vMsB7AeGFlkqmesycATlEPQMVyt/zpXxKQcLatloTQqnAV0Z9ciTd
         3CdlYAJ0wfbnDesZx0IkMq5sdoDKJpXBzfmaeuVfxLUemyadRhU6KzCgl4EVMLUxbqRD
         1hSn7VE41Un5yj/iY9HlLCJJjZ1nYMFguRiz2OqrJZM6USw3dCMV+bFd0/MtAPqM41ZM
         rHTemCEab2MY0IsdA5mgvJVpcWyhkNv9HgjgI+LP340fc937kYke4Ey0Y8hLIf/uHJdy
         r7FQ==
X-Gm-Message-State: ANoB5pnar826ujYbkYzKG4/HDdo2Q8enuD87sLcG3NBoQEwUerkxFX4E
        0c0gS5kluSKnE7GYidOXJLU34qvE4YLHTgE/8cQpkG8OJqwf
X-Google-Smtp-Source: AA0mqf49PX5oszTxREZzkh+B5ipk9aj+YB6zs2an7m0V7CHcnZuTSxJZSx73L1qHeWD8UkozuCuyZ7PfLfw+D8/NIaTs4oA1Tlun
MIME-Version: 1.0
X-Received: by 2002:a05:6638:372c:b0:38a:5ae5:d212 with SMTP id
 k44-20020a056638372c00b0038a5ae5d212mr6982637jav.257.1670879378443; Mon, 12
 Dec 2022 13:09:38 -0800 (PST)
Date:   Mon, 12 Dec 2022 13:09:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d09f4505efa7eb2c@google.com>
Subject: [syzbot] INFO: task hung in nbd_start_device_ioctl
From:   syzbot <syzbot+9df558a2e82f6f511bfb@syzkaller.appspotmail.com>
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=134d1af3880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=9df558a2e82f6f511bfb
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b387fb880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153b534d880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9df558a2e82f6f511bfb@syzkaller.appspotmail.com

INFO: task syz-executor270:3108 blocked for more than 143 seconds.
      Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor270 state:D stack:0     pid:3108  ppid:3107   flags:0x00000009
Call trace:
 __switch_to+0x180/0x298 arch/arm64/kernel/process.c:555
 context_switch kernel/sched/core.c:5209 [inline]
 __schedule+0x408/0x594 kernel/sched/core.c:6521
 schedule+0x64/0xa4 kernel/sched/core.c:6597
 schedule_timeout+0x64/0x1b4 kernel/time/timer.c:1911
 do_wait_for_common+0xf4/0x184 kernel/sched/completion.c:85
 __wait_for_common kernel/sched/completion.c:106 [inline]
 wait_for_common kernel/sched/completion.c:117 [inline]
 wait_for_completion+0x48/0x60 kernel/sched/completion.c:138
 __flush_workqueue+0x2b0/0x6dc kernel/workqueue.c:2861
 nbd_start_device_ioctl+0x1e4/0x2b8 drivers/block/nbd.c:1419
 __nbd_ioctl+0x16c/0x334 drivers/block/nbd.c:1481
 nbd_ioctl+0xec/0x13c drivers/block/nbd.c:1521
 blkdev_ioctl+0x24c/0x6d8 block/ioctl.c:614
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/11:
 #0: ffff80000d4a4768 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/12:
 #0: ffff80000d4a4db8 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/27:
 #0: ffff80000d4a4640 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:303
2 locks held by kworker/u5:0/46:
 #0: ffff0000c6236d38 ((wq_completion)nbd0-recv){+.+.}-{0:0}, at: process_one_work+0x270/0x504 kernel/workqueue.c:2262
 #1: ffff80000f703d80 ((work_completion)(&args->work)){+.+.}-{0:0}, at: process_one_work+0x29c/0x504 kernel/workqueue.c:2264
2 locks held by getty/2759:
 #0: ffff0000c8153898 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x28/0x58 drivers/tty/tty_ldisc.c:244
 #1: ffff80000f6be2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x19c/0x89c drivers/tty/n_tty.c:2177

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
