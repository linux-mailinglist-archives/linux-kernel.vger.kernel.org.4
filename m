Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D2065D008
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbjADJ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjADJ4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:56:24 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250271A3A9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:56:23 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id j3-20020a056e02154300b00304bc968ef1so20744708ilu.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 01:56:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yf6jjqECoTwh2VqoqH5FszSSMHtwJ3LiZ+0DzS2wqys=;
        b=i6NTJhqv+Vep92RH4ki8pwB04e4Z4IuyVdBDiQqYLYmkljC5QEhteMVREWhCvBlgIj
         2Rymx8hwYZ9pl2DPRLh7wiqPBjkQXz+AkIU1s7iSn+d54vdwflhvMEJxGK0M+t7oRE+Z
         MMCo7PGE1KQM6wm/KQGTePoTdFQ2R/Yh4M6/o1d59qFE3pQSrGcuoYmKIKv7DWzwpBED
         E4ByP27gBT7uFQXE+kGNG/1QdwHEahkmb9LuOTbuNFN9RSc8on7O9sful+TGQreUl6ub
         BIgt7WKznTHIuyYjtLT40OJN6PSMUqxsTj4kMfP25CP5/8NZCFaAIbq2JJEKeJPAH0Wu
         Y7bQ==
X-Gm-Message-State: AFqh2ko8bv5kJxAiFiwwD9O44U07z2U0VhdqNdNxynzPRiI4Seyx8/XA
        snqDyGdKQISZGm6Eysb81sdObDS/zx8lXVGdPVXhGdQbj8nB
X-Google-Smtp-Source: AMrXdXvPiXQPUOuEabkkHZISADUxifmsaK8ZjC0ezzDS5eKeZiaZPyCKtQlBP2Auj+qRKXRGquQNcP2p7U6rgvrUM7U1mr18+dKt
MIME-Version: 1.0
X-Received: by 2002:a05:6602:150:b0:6b7:b0f0:f393 with SMTP id
 v16-20020a056602015000b006b7b0f0f393mr3312884iot.200.1672826182449; Wed, 04
 Jan 2023 01:56:22 -0800 (PST)
Date:   Wed, 04 Jan 2023 01:56:22 -0800
In-Reply-To: <20230104090737.4157-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000603e5705f16d32a7@google.com>
Subject: Re: [syzbot] INFO: task hung in nbd_start_device_ioctl
From:   syzbot <syzbot+9df558a2e82f6f511bfb@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in nbd_start_device_ioctl

INFO: task syz-executor.0:5958 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc2-syzkaller-00127-g69b41ac87e4a #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:0     pid:5958  ppid:4867   flags:0x00000009
Call trace:
 __switch_to+0x180/0x298 arch/arm64/kernel/process.c:555
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x438/0x5a0 kernel/sched/core.c:6555
 schedule+0x64/0xa4 kernel/sched/core.c:6631
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6690
 __mutex_lock_common+0x788/0xca8 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 nbd_start_device_ioctl+0x1f0/0x2b8 drivers/block/nbd.c:1421
 __nbd_ioctl+0x16c/0x334 drivers/block/nbd.c:1482
 nbd_ioctl+0xec/0x13c drivers/block/nbd.c:1522
 blkdev_ioctl+0x24c/0x6d8 block/ioctl.c:616
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
INFO: task syz-executor.0:5959 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc2-syzkaller-00127-g69b41ac87e4a #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:0     pid:5959  ppid:4867   flags:0x00000001
Call trace:
 __switch_to+0x180/0x298 arch/arm64/kernel/process.c:555
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x438/0x5a0 kernel/sched/core.c:6555
 schedule+0x64/0xa4 kernel/sched/core.c:6631
 blk_mq_freeze_queue_wait+0x94/0xf4 block/blk-mq.c:180
 blk_freeze_queue+0x94/0xa8 block/blk-mq.c:207
 blk_mq_freeze_queue+0x20/0x30 block/blk-mq.c:216
 nbd_add_socket+0x78/0x27c drivers/block/nbd.c:1122
 __nbd_ioctl+0x80/0x334 drivers/block/nbd.c:1465
 nbd_ioctl+0xec/0x13c drivers/block/nbd.c:1522
 blkdev_ioctl+0x24c/0x6d8 block/ioctl.c:616
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
 #0: ffff80000d635648 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/12:
 #0: ffff80000d635c98 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/27:
 #0: ffff80000d635520 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:324
2 locks held by getty/4074:
 #0: ffff0000c546c898 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x28/0x58 drivers/tty/tty_ldisc.c:244
 #1: ffff80000f8462f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x19c/0x89c drivers/tty/n_tty.c:2177
1 lock held by udevd/4866:
 #0: ffff0000c424ccc8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xfc/0x2fc block/bdev.c:813
1 lock held by syz-executor.0/5958:
 #0: ffff0000c5eec5a0 (&nbd->config_lock){+.+.}-{3:3}, at: nbd_start_device_ioctl+0x1f0/0x2b8 drivers/block/nbd.c:1421
1 lock held by syz-executor.0/5959:
 #0: ffff0000c5eec5a0 (&nbd->config_lock){+.+.}-{3:3}, at: nbd_ioctl+0x70/0x13c drivers/block/nbd.c:1515
1 lock held by syz-executor293/5981:
 #0: ffff0000c424ccc8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xfc/0x2fc block/bdev.c:813
1 lock held by syz-executor293/5982:
 #0: ffff0000c424ccc8 (&disk->open_mutex){+.+.}-{3:3}, at: blkdev_get_by_dev+0xfc/0x2fc block/bdev.c:813

=============================================



Tested on:

commit:         69b41ac8 Merge tag 'for-6.2-rc2-tag' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=102810aa480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=970a539d6092d0
dashboard link: https://syzkaller.appspot.com/bug?extid=9df558a2e82f6f511bfb
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Note: no patches were applied.
