Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F338624EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiKKAVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiKKAVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:21:44 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE1C60EB5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:21:42 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id be26-20020a056602379a00b006dd80a0ba1cso2190146iob.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:21:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qFjiEcHc5hk2bc+C1nL1+XaOhmC8v8oKdudkNiloEHw=;
        b=CuRRje9bcehrYE2BndEousYKrp1ZMDFLX1YNS6EB8iZvREkK36i5xn0xmX5Lbgu7T+
         n8mKYcin30T7RrAn+YIcYr2n890u/bg2gmJhHtMLYJPIdWnwTT9Ty/enfs0bN860vQp4
         Fco4pqhmarecHmVhqFvT9+GqvWmjMWGFQwTrYy21HJHhSOm3VlRH6TviWKzymc91gsGl
         VvzRIELc6o0+HE9UdWtKU/nSWvQd00gPjP8IVmSGi7gIINej0SatXFAms2mylMaB51Ao
         Rj3F7XwpG1aWSRo9FQauv6JfAqJClU4tVnoJAmOMbj3LexZ5jeQpRPWjHcjUzthK3ziQ
         oJQA==
X-Gm-Message-State: ANoB5pmkgW8zhfVdNU6sLniO8NZaS0P6HGQsDJMWt+htwqN9YpVmJGhy
        Rs02HFioYHfqcD5gJovWiOO0fi3cxOrjXwHlU56EdsOEd6p9
X-Google-Smtp-Source: AA0mqf5dDtIZ8cqm/xr3DzN7RTLhn+g60LjEAjRplluaW3kzMOvs9LfdnQFF7gIb9BXW1RQl4SZ/x1Ut9C4ERNoOnxImLNuhmpZF
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1146:b0:302:38f2:3f99 with SMTP id
 o6-20020a056e02114600b0030238f23f99mr1038798ill.271.1668126102075; Thu, 10
 Nov 2022 16:21:42 -0800 (PST)
Date:   Thu, 10 Nov 2022 16:21:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1401205ed26df57@google.com>
Subject: [syzbot] INFO: task hung in lookup_slow (3)
From:   syzbot <syzbot+7cfc6a4f6b025f710423@syzkaller.appspotmail.com>
To:     brauner@kernel.org, broonie@kernel.org, catalin.marinas@arm.com,
        ebiederm@xmission.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
        mark.rutland@arm.com, scott@os.amperecomputing.com,
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17ed890e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=7cfc6a4f6b025f710423
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bb4cc6880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119a912e880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7cfc6a4f6b025f710423@syzkaller.appspotmail.com

INFO: task syslogd:2546 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syslogd         state:D stack:    0 pid: 2546 ppid:     1 flags:0x00000000
Call trace:
 __switch_to+0x180/0x298 arch/arm64/kernel/process.c:557
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0x414/0x5a0 kernel/sched/core.c:6494
 schedule+0x64/0xa4 kernel/sched/core.c:6570
 rwsem_down_read_slowpath+0x228/0x444 kernel/locking/rwsem.c:1087
 __down_read_common+0x48/0x154 kernel/locking/rwsem.c:1252
 __down_read kernel/locking/rwsem.c:1261 [inline]
 down_read+0x68/0x78 kernel/locking/rwsem.c:1501
 inode_lock_shared include/linux/fs.h:766 [inline]
 lookup_slow+0x34/0x68 fs/namei.c:1701
 walk_component fs/namei.c:1993 [inline]
 link_path_walk+0x474/0x628 fs/namei.c:2320
 path_openat+0xb8/0x11c4 fs/namei.c:3687
 do_filp_open+0xdc/0x1b8 fs/namei.c:3718
 do_sys_openat2+0xb8/0x22c fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_openat fs/open.c:1345 [inline]
 __se_sys_openat fs/open.c:1340 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1340
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
INFO: task syz-executor428:3073 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor428 state:D stack:    0 pid: 3073 ppid:  3071 flags:0x00000000
Call trace:
 __switch_to+0x180/0x298 arch/arm64/kernel/process.c:557
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0x414/0x5a0 kernel/sched/core.c:6494
 schedule+0x64/0xa4 kernel/sched/core.c:6570
 rwsem_down_read_slowpath+0x228/0x444 kernel/locking/rwsem.c:1087
 __down_read_common+0x48/0x154 kernel/locking/rwsem.c:1252
 __down_read kernel/locking/rwsem.c:1261 [inline]
 down_read+0x68/0x78 kernel/locking/rwsem.c:1501
 inode_lock_shared include/linux/fs.h:766 [inline]
 lookup_slow+0x34/0x68 fs/namei.c:1701
 walk_component fs/namei.c:1993 [inline]
 link_path_walk+0x474/0x628 fs/namei.c:2320
 path_openat+0xb8/0x11c4 fs/namei.c:3687
 do_filp_open+0xdc/0x1b8 fs/namei.c:3718
 do_sys_openat2+0xb8/0x22c fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_openat fs/open.c:1345 [inline]
 __se_sys_openat fs/open.c:1340 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1340
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
INFO: task syz-executor428:3075 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor428 state:D stack:    0 pid: 3075 ppid:  3073 flags:0x00000001
Call trace:
 __switch_to+0x180/0x298 arch/arm64/kernel/process.c:557
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0x414/0x5a0 kernel/sched/core.c:6494
 schedule+0x64/0xa4 kernel/sched/core.c:6570
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6629
 __mutex_lock_common+0x788/0xca8 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 fuse_lock_inode+0x50/0x70 fs/fuse/inode.c:468
 fuse_lookup+0x74/0x274 fs/fuse/dir.c:432
 __lookup_slow+0x14c/0x204 fs/namei.c:1685
 lookup_slow+0x44/0x68 fs/namei.c:1702
 walk_component fs/namei.c:1993 [inline]
 link_path_walk+0x474/0x628 fs/namei.c:2320
 path_openat+0xb8/0x11c4 fs/namei.c:3687
 do_filp_open+0xdc/0x1b8 fs/namei.c:3718
 do_sys_openat2+0xb8/0x22c fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_openat fs/open.c:1345 [inline]
 __se_sys_openat fs/open.c:1340 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1340
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
INFO: task syz-executor428:3077 blocked for more than 143 seconds.
      Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor428 state:D stack:    0 pid: 3077 ppid:  3073 flags:0x00000001
Call trace:
 __switch_to+0x180/0x298 arch/arm64/kernel/process.c:557
 context_switch kernel/sched/core.c:5182 [inline]
 __schedule+0x414/0x5a0 kernel/sched/core.c:6494
 schedule+0x64/0xa4 kernel/sched/core.c:6570
 rwsem_down_write_slowpath+0x258/0x468 kernel/locking/rwsem.c:1182
 __down_write_common kernel/locking/rwsem.c:1297 [inline]
 __down_write kernel/locking/rwsem.c:1306 [inline]
 down_write_nested+0x90/0xd8 kernel/locking/rwsem.c:1663
 inode_lock_nested include/linux/fs.h:791 [inline]
 fuse_reverse_inval_entry+0x58/0x3c4 fs/fuse/dir.c:1167
 fuse_dev_do_write+0x1208/0x1544 fs/fuse/dev.c:1872
 fuse_dev_write+0x78/0xc0 fs/fuse/dev.c:1956
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x2dc/0x46c fs/read_write.c:578
 ksys_write+0xb4/0x160 fs/read_write.c:631
 __do_sys_write fs/read_write.c:643 [inline]
 __se_sys_write fs/read_write.c:640 [inline]
 __arm64_sys_write+0x24/0x34 fs/read_write.c:640
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/11:
 #0: ffff80000d433568 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/12:
 #0: ffff80000d433bb8 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x3c/0x450 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/27:
 #0: ffff80000d433440 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:279
1 lock held by syslogd/2546:
 #0: ffff0000c9e48150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff0000c9e48150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: lookup_slow+0x34/0x68 fs/namei.c:1701
2 locks held by udevd/2561:
 #0: ffff0000c9e48150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff0000c9e48150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: lookup_slow+0x34/0x68 fs/namei.c:1701
 #1: ffff0000c9e485b8 (&fi->mutex){+.+.}-{3:3}, at: fuse_lock_inode+0x50/0x70 fs/fuse/inode.c:468
2 locks held by getty/2711:
 #0: ffff0000c62cb898 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x28/0x58 drivers/tty/tty_ldisc.c:244
 #1: ffff80000f6162f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x19c/0x89c drivers/tty/n_tty.c:2177
1 lock held by syz-executor428/3073:
 #0: ffff0000c9e48150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff0000c9e48150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: lookup_slow+0x34/0x68 fs/namei.c:1701
2 locks held by syz-executor428/3075:
 #0: ffff0000c9e48150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: inode_lock_shared include/linux/fs.h:766 [inline]
 #0: ffff0000c9e48150 (&type->i_mutex_dir_key#6){++++}-{3:3}, at: lookup_slow+0x34/0x68 fs/namei.c:1701
 #1: ffff0000c9e485b8 (&fi->mutex){+.+.}-{3:3}, at: fuse_lock_inode+0x50/0x70 fs/fuse/inode.c:468
2 locks held by syz-executor428/3077:
 #0: ffff0000ca1f2738 (&fc->killsb){.+.+}-{3:3}, at: fuse_notify_delete fs/fuse/dev.c:1547 [inline]
 #0: ffff0000ca1f2738 (&fc->killsb){.+.+}-{3:3}, at: fuse_notify fs/fuse/dev.c:1797 [inline]
 #0: ffff0000ca1f2738 (&fc->killsb){.+.+}-{3:3}, at: fuse_dev_do_write+0x11f8/0x1544 fs/fuse/dev.c:1872
 #1: ffff0000c9e48150 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:791 [inline]
 #1: ffff0000c9e48150 (&type->i_mutex_dir_key#6/1){+.+.}-{3:3}, at: fuse_reverse_inval_entry+0x58/0x3c4 fs/fuse/dir.c:1167

=============================================



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
