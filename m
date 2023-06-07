Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85BE7725B28
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbjFGJ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239760AbjFGJ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:59:06 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61081BC0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:59:00 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-770222340cfso570671439f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686131940; x=1688723940;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nAtUlqqyNSQfK2vcFJTrG6EgxtQq5kMPK7n0iQSKk4=;
        b=Sn5AVNAkKzcrDFH8kPo5pLZ8gHx7cOxg775d4bgRsTtFuWzPGqX53VEMcl3YPD51S0
         4YF5FH4jSmY3Qj/g1Iz/0EMprs3j3SgmYaI2a7CMBn9o5SnXtE4s4P0a8maonZOe/Xxs
         NQyxID6CzkJfMW4+wWF0b8tbcGiPxe/LeMibeG0kR88XazUFkiwxBd8LUCFluT0uzKg9
         9AtxB7kiq5BREAQwPcAuqdCRIn5jn/WKVsSW2Fs16u11EhYLKsrBEHRPnQp0IUbu19aM
         r3FS8JFKPTYsZr95JWZsLEBDRcF2Vkk6ljiddO/FdRtr4wcYCxg8CAm3+BsySdGBy+Js
         19hQ==
X-Gm-Message-State: AC+VfDz5/vjeCIqwpEcr27jSmGKTh+gH3B12v/wUgWhdzpZJokeGE6oz
        V79n0tBhIkEiNvej8YIOSMK3MSLKy9QsNQa40qauEgO6vU0O
X-Google-Smtp-Source: ACHHUZ52Iaf7mMXCOBui7J4lzvOzb1wGdh0dnQFJtQC3L+pLvKQBKyWY926lUP90wUwOJLx5oNJlvzsXLhfmrmQzCYsHahEt9Eee
MIME-Version: 1.0
X-Received: by 2002:a02:94c4:0:b0:41a:dd1b:23ca with SMTP id
 x62-20020a0294c4000000b0041add1b23camr2175711jah.4.1686131939896; Wed, 07 Jun
 2023 02:58:59 -0700 (PDT)
Date:   Wed, 07 Jun 2023 02:58:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000052748d05fd872fb0@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in rfkill_unregister (3)
From:   syzbot <syzbot+bb540a4bbfb4ae3b425d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    eb0f1697d729 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17b656a5280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8860074b9a9d6c45
dashboard link: https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122665a3280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13dc1c59280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/034232da7cff/disk-eb0f1697.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b11411bec33e/vmlinux-eb0f1697.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a53c52e170dd/Image-eb0f1697.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb540a4bbfb4ae3b425d@syzkaller.appspotmail.com

INFO: task syz-executor410:6034 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc3-syzkaller-geb0f1697d729 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor410 state:D stack:0     pid:6034  ppid:5996   flags:0x0000000c
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0x1368/0x23b8 kernel/sched/core.c:6669
 schedule+0xc4/0x170 kernel/sched/core.c:6745
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6804
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 rfkill_unregister+0xb8/0x210 net/rfkill/core.c:1130
 nfc_unregister_device+0x98/0x290 net/nfc/core.c:1167
 nci_unregister_device+0x1dc/0x21c net/nfc/nci/core.c:1303
 virtual_ncidev_close+0x5c/0xa0 drivers/nfc/virtual_ncidev.c:163
 __fput+0x30c/0x7bc fs/file_table.c:321
 ____fput+0x20/0x30 fs/file_table.c:349
 task_work_run+0x230/0x2e0 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x63c/0x1f58 kernel/exit.c:871
 do_group_exit+0x194/0x22c kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __wake_up_parent+0x0/0x60 kernel/exit.c:1030
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
INFO: task syz-executor410:6057 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc3-syzkaller-geb0f1697d729 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor410 state:D stack:0     pid:6057  ppid:5997   flags:0x00000009
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0x1368/0x23b8 kernel/sched/core.c:6669
 schedule+0xc4/0x170 kernel/sched/core.c:6745
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6804
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 device_lock include/linux/device.h:837 [inline]
 nfc_dev_down net/nfc/core.c:143 [inline]
 nfc_rfkill_set_block+0x50/0x2d0 net/nfc/core.c:179
 rfkill_set_block+0x18c/0x37c net/rfkill/core.c:345
 rfkill_fop_write+0x578/0x734 net/rfkill/core.c:1286
 vfs_write+0x2a0/0x918 fs/read_write.c:582
 ksys_write+0x15c/0x26c fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:646
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
INFO: task syz-executor410:6061 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc3-syzkaller-geb0f1697d729 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor410 state:D stack:0     pid:6061  ppid:5992   flags:0x00000009
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0x1368/0x23b8 kernel/sched/core.c:6669
 schedule+0xc4/0x170 kernel/sched/core.c:6745
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6804
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 rfkill_register+0x44/0x7a4 net/rfkill/core.c:1057
 nfc_register_device+0x148/0x310 net/nfc/core.c:1132
 nci_register_device+0x6ac/0x7c4 net/nfc/nci/core.c:1257
 virtual_ncidev_open+0x13c/0x1bc drivers/nfc/virtual_ncidev.c:148
 misc_open+0x2f0/0x368 drivers/char/misc.c:165
 chrdev_open+0x3e8/0x4fc fs/char_dev.c:414
 do_dentry_open+0x724/0xf90 fs/open.c:920
 vfs_open+0x7c/0x90 fs/open.c:1051
 do_open fs/namei.c:3636 [inline]
 path_openat+0x1f2c/0x27f8 fs/namei.c:3791
 do_filp_open+0x1bc/0x3cc fs/namei.c:3818
 do_sys_openat2+0x128/0x3d8 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1383
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
INFO: task syz-executor410:6066 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc3-syzkaller-geb0f1697d729 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor410 state:D stack:0     pid:6066  ppid:5994   flags:0x00000001
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0x1368/0x23b8 kernel/sched/core.c:6669
 schedule+0xc4/0x170 kernel/sched/core.c:6745
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6804
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 misc_open+0x6c/0x368 drivers/char/misc.c:129
 chrdev_open+0x3e8/0x4fc fs/char_dev.c:414
 do_dentry_open+0x724/0xf90 fs/open.c:920
 vfs_open+0x7c/0x90 fs/open.c:1051
 do_open fs/namei.c:3636 [inline]
 path_openat+0x1f2c/0x27f8 fs/namei.c:3791
 do_filp_open+0x1bc/0x3cc fs/namei.c:3818
 do_sys_openat2+0x128/0x3d8 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1383
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
INFO: task syz-executor410:6071 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc3-syzkaller-geb0f1697d729 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor410 state:D stack:0     pid:6071  ppid:5995   flags:0x00000001
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0x1368/0x23b8 kernel/sched/core.c:6669
 schedule+0xc4/0x170 kernel/sched/core.c:6745
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6804
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 misc_open+0x6c/0x368 drivers/char/misc.c:129
 chrdev_open+0x3e8/0x4fc fs/char_dev.c:414
 do_dentry_open+0x724/0xf90 fs/open.c:920
 vfs_open+0x7c/0x90 fs/open.c:1051
 do_open fs/namei.c:3636 [inline]
 path_openat+0x1f2c/0x27f8 fs/namei.c:3791
 do_filp_open+0x1bc/0x3cc fs/namei.c:3818
 do_sys_openat2+0x128/0x3d8 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1383
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591
INFO: task kworker/1:9:6072 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc3-syzkaller-geb0f1697d729 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:9     state:D stack:0     pid:6072  ppid:2      flags:0x00000008
Workqueue: events rfkill_global_led_trigger_worker
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0x1368/0x23b8 kernel/sched/core.c:6669
 schedule+0xc4/0x170 kernel/sched/core.c:6745
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6804
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 rfkill_global_led_trigger_worker+0x30/0xe4 net/rfkill/core.c:181
 process_one_work+0x788/0x12d4 kernel/workqueue.c:2405
 worker_thread+0x8e0/0xfe8 kernel/workqueue.c:2552
 kthread+0x288/0x310 kernel/kthread.c:379
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:853
INFO: task syz-executor410:6076 blocked for more than 143 seconds.
      Not tainted 6.4.0-rc3-syzkaller-geb0f1697d729 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor410 state:D stack:0     pid:6076  ppid:5991   flags:0x00000001
Call trace:
 __switch_to+0x320/0x754 arch/arm64/kernel/process.c:556
 context_switch kernel/sched/core.c:5343 [inline]
 __schedule+0x1368/0x23b8 kernel/sched/core.c:6669
 schedule+0xc4/0x170 kernel/sched/core.c:6745
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6804
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:799
 misc_open+0x6c/0x368 drivers/char/misc.c:129
 chrdev_open+0x3e8/0x4fc fs/char_dev.c:414
 do_dentry_open+0x724/0xf90 fs/open.c:920
 vfs_open+0x7c/0x90 fs/open.c:1051
 do_open fs/namei.c:3636 [inline]
 path_openat+0x1f2c/0x27f8 fs/namei.c:3791
 do_filp_open+0x1bc/0x3cc fs/namei.c:3818
 do_sys_openat2+0x128/0x3d8 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __arm64_sys_openat+0x1f0/0x240 fs/open.c:1383
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x258 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x15c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/13:
 #0: ffff800016091050 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x44/0xcf4 kernel/rcu/tasks.h:518
1 lock held by rcu_tasks_trace/14:
 #0: ffff800016091410 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x44/0xcf4 kernel/rcu/tasks.h:518
1 lock held by khungtaskd/28:
 #0: ffff800016090e80 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0xc/0x44 include/linux/rcupdate.h:326
2 locks held by getty/5732:
 #0: ffff0000cfe85098 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff80001ae102f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x414/0x1210 drivers/tty/n_tty.c:2176
2 locks held by syz-executor410/6034:
 #0: ffff0000c9cad100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:837 [inline]
 #0: ffff0000c9cad100 (&dev->mutex){....}-{3:3}, at: nfc_unregister_device+0x6c/0x290 net/nfc/core.c:1165
 #1: ffff800018a57008 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_unregister+0xb8/0x210 net/rfkill/core.c:1130
2 locks held by syz-executor410/6057:
 #0: ffff800018a57008 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_fop_write+0x234/0x734 net/rfkill/core.c:1278
 #1: ffff0000c9cad100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:837 [inline]
 #1: ffff0000c9cad100 (&dev->mutex){....}-{3:3}, at: nfc_dev_down net/nfc/core.c:143 [inline]
 #1: ffff0000c9cad100 (&dev->mutex){....}-{3:3}, at: nfc_rfkill_set_block+0x50/0x2d0 net/nfc/core.c:179
3 locks held by syz-executor410/6061:
 #0: ffff800017499f48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x6c/0x368 drivers/char/misc.c:129
 #1: ffff0000dcd19100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:837 [inline]
 #1: ffff0000dcd19100 (&dev->mutex){....}-{3:3}, at: nfc_register_device+0xb4/0x310 net/nfc/core.c:1128
 #2: ffff800018a57008 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_register+0x44/0x7a4 net/rfkill/core.c:1057
1 lock held by syz-executor410/6066:
 #0: ffff800017499f48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x6c/0x368 drivers/char/misc.c:129
1 lock held by syz-executor410/6071:
 #0: ffff800017499f48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x6c/0x368 drivers/char/misc.c:129
3 locks held by kworker/1:9/6072:
 #0: ffff0000c0020d38 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x664/0x12d4 kernel/workqueue.c:2378
 #1: ffff80001f037c20 ((work_completion)(&rfkill_global_led_trigger_work)){+.+.}-{0:0}, at: process_one_work+0x6a8/0x12d4 kernel/workqueue.c:2380
 #2: ffff800018a57008 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_global_led_trigger_worker+0x30/0xe4 net/rfkill/core.c:181
1 lock held by syz-executor410/6076:
 #0: ffff800017499f48 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x6c/0x368 drivers/char/misc.c:129

=============================================



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
