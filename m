Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899C466DAF0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbjAQK1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbjAQK04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:26:56 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529762ED7F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:26:52 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id s12-20020a056e021a0c00b0030efd0ed890so3901028ild.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=06T1vl54lAZuVMBbzUV7FY6XKJgLq5iaKZfvALwZhcA=;
        b=yyTdS99TatRM8FMwXabpOvdpv/7noiftF+uIAITluaOxgpFHoL7dpW0vON47qrqIrP
         4Q3NgOlvZ5VDIBQzQkIbzHAi4t6nR/Kq027JarTqSPfCetACzJADSEbDoyHtpl4qgv9A
         HdOR9xbSgISecNU7QdV4b5Kl+F40sr39kSeU46kfcTS44m0PcKqFPYSZvY1id1T8HXCz
         QZC9gnwwor6RORJY67k2WQOKUjyO9lf+VkyhvRSBeP2NbvGfHXPNi/WMibWKJcvKQPHt
         tppQaXTFZRXCNac6pGJxH/t1IWGGd3Zttcsd/n/x/ySRD07YQPjRsYTlZke+6e7Auu0U
         z0Cg==
X-Gm-Message-State: AFqh2koiVMnB+ouYLunOVDpsrrJR7E7AI42iE7LSD0Ge5LslrJmCQv7u
        8j47h3k1epHWHT83crumc42qP1A3q9kKr2nKeto0wh7bmKU5
X-Google-Smtp-Source: AMrXdXuuOnACt3l10ysPKVDqo4fzE8RfeLoAH0AYVjk4cDk4L+byfMPKQ5N3dFZhBVdLvlxXCUuR9N31TTe4jcz5CMDkg//zqabJ
MIME-Version: 1.0
X-Received: by 2002:a92:c98f:0:b0:30f:b7f:1aee with SMTP id
 y15-20020a92c98f000000b0030f0b7f1aeemr257311iln.221.1673951211619; Tue, 17
 Jan 2023 02:26:51 -0800 (PST)
Date:   Tue, 17 Jan 2023 02:26:51 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000570e0305f273235d@google.com>
Subject: [syzbot] [gfs2?] BUG: sleeping function called from invalid context
 in gfs2_glock_wait
From:   syzbot <syzbot+cdb448c6e82c20d7960c@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
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

syzbot found the following issue on:

HEAD commit:    d532dd102151 Merge tag 'for-6.2-rc4-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c88b2c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3574635786f74ca
dashboard link: https://syzkaller.appspot.com/bug?extid=cdb448c6e82c20d7960c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a30e7e480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164a8ab1480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a644dc38be2c/disk-d532dd10.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30e89b0598f8/vmlinux-d532dd10.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5bb4bab3f67d/bzImage-d532dd10.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/89f4e64444ce/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cdb448c6e82c20d7960c@syzkaller.appspotmail.com

gfs2: fsid=syz:syz.0: found 1 quota changes
syz-executor390: attempt to access beyond end of device
loop0: rw=1, sector=131324, nr_sectors = 4 limit=32768
gfs2: fsid=syz:syz.0: Error 10 writing to journal, jid=0
gfs2: fsid=syz:syz.0: fatal: I/O error(s)
gfs2: fsid=syz:syz.0: about to withdraw this file system
BUG: sleeping function called from invalid context at fs/gfs2/glock.c:1316
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5053, name: syz-executor390
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
4 locks held by syz-executor390/5053:
 #0: ffff88807a14c0e0 (&type->s_umount_key#47){+.+.}-{3:3}, at: deactivate_super+0x96/0xd0 fs/super.c:362
 #1: ffff888023a48b70 (&sdp->sd_quota_sync_mutex){+.+.}-{3:3}, at: gfs2_quota_sync+0x9b/0x8b0 fs/gfs2/quota.c:1302
 #2: ffff888023a49058 (&sdp->sd_log_flush_lock){++++}-{3:3}, at: gfs2_log_flush+0xe7/0x26a0 fs/gfs2/log.c:1034
 #3: ffff888023a48e80 (&sdp->sd_log_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:350 [inline]
 #3: ffff888023a48e80 (&sdp->sd_log_lock){+.+.}-{2:2}, at: gfs2_log_lock fs/gfs2/log.h:32 [inline]
 #3: ffff888023a48e80 (&sdp->sd_log_lock){+.+.}-{2:2}, at: gfs2_flush_revokes+0x4e/0x80 fs/gfs2/log.c:805
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 5053 Comm: syz-executor390 Not tainted 6.2.0-rc4-syzkaller-00009-gd532dd102151 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2d0 lib/dump_stack.c:106
 __might_resched+0x538/0x6a0 kernel/sched/core.c:10036
 gfs2_glock_wait+0x52/0x2a0 fs/gfs2/glock.c:1316
 gfs2_glock_nq_init fs/gfs2/glock.h:262 [inline]
 gfs2_freeze_lock+0x5f/0xc0 fs/gfs2/util.c:107
 signal_our_withdraw fs/gfs2/util.c:160 [inline]
 gfs2_withdraw+0x5ab/0x14e0 fs/gfs2/util.c:351
 gfs2_ail1_empty+0x8c9/0x950 fs/gfs2/log.c:368
 gfs2_flush_revokes+0x59/0x80 fs/gfs2/log.c:806
 revoke_lo_before_commit+0x2b/0xcf0 fs/gfs2/lops.c:869
 lops_before_commit fs/gfs2/lops.h:40 [inline]
 gfs2_log_flush+0xc8e/0x26a0 fs/gfs2/log.c:1093
 do_sync+0xa4c/0xc90 fs/gfs2/quota.c:975
 gfs2_quota_sync+0x3da/0x8b0 fs/gfs2/quota.c:1318
 gfs2_sync_fs+0x49/0xb0 fs/gfs2/super.c:650
 sync_filesystem+0xe8/0x220 fs/sync.c:56
 generic_shutdown_super+0x6b/0x310 fs/super.c:474
 kill_block_super+0x79/0xd0 fs/super.c:1386
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1291
 task_work_run+0x243/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x644/0x2150 kernel/exit.c:867
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:1012
 __do_sys_exit_group kernel/exit.c:1023 [inline]
 __se_sys_exit_group kernel/exit.c:1021 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:1021
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8d53bb09c9
Code: Unable to access opcode bytes at 0x7f8d53bb099f.
RSP: 002b:00007ffda1438d78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f8d53c45330 RCX: 00007f8d53bb09c9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 000000000001f6db
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8d53c45330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.2.0-rc4-syzkaller-00009-gd532dd102151 #0 Tainted: G        W         
-----------------------------
syz-executor390/5053 is trying to lock:
ffff888019021c88 (&wq->mutex){+.+.}-{3:3}, at: __flush_workqueue+0x1b7/0x16a0 kernel/workqueue.c:2812
other info that might help us debug this:
context-{4:4}
4 locks held by syz-executor390/5053:
 #0: ffff88807a14c0e0 (&type->s_umount_key#47){+.+.}-{3:3}, at: deactivate_super+0x96/0xd0 fs/super.c:362
 #1: ffff888023a48b70 (&sdp->sd_quota_sync_mutex){+.+.}-{3:3}, at: gfs2_quota_sync+0x9b/0x8b0 fs/gfs2/quota.c:1302
 #2: ffff888023a49058 (&sdp->sd_log_flush_lock){++++}-{3:3}, at: gfs2_log_flush+0xe7/0x26a0 fs/gfs2/log.c:1034
 #3: ffff888023a48e80 (&sdp->sd_log_lock){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:350 [inline]
 #3: ffff888023a48e80 (&sdp->sd_log_lock){+.+.}-{2:2}, at: gfs2_log_lock fs/gfs2/log.h:32 [inline]
 #3: ffff888023a48e80 (&sdp->sd_log_lock){+.+.}-{2:2}, at: gfs2_flush_revokes+0x4e/0x80 fs/gfs2/log.c:805
stack backtrace:
CPU: 0 PID: 5053 Comm: syz-executor390 Tainted: G        W          6.2.0-rc4-syzkaller-00009-gd532dd102151 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2d0 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4707 [inline]
 check_wait_context kernel/locking/lockdep.c:4768 [inline]
 __lock_acquire+0x14f2/0x1f60 kernel/locking/lockdep.c:5005
 lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5668
 __mutex_lock_common+0x1de/0x26c0 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 __flush_workqueue+0x1b7/0x16a0 kernel/workqueue.c:2812
 gfs2_make_fs_ro+0xd1/0x630 fs/gfs2/super.c:532
 signal_our_withdraw fs/gfs2/util.c:166 [inline]
 gfs2_withdraw+0x5e8/0x14e0 fs/gfs2/util.c:351
 gfs2_ail1_empty+0x8c9/0x950 fs/gfs2/log.c:368
 gfs2_flush_revokes+0x59/0x80 fs/gfs2/log.c:806
 revoke_lo_before_commit+0x2b/0xcf0 fs/gfs2/lops.c:869
 lops_before_commit fs/gfs2/lops.h:40 [inline]
 gfs2_log_flush+0xc8e/0x26a0 fs/gfs2/log.c:1093
 do_sync+0xa4c/0xc90 fs/gfs2/quota.c:975
 gfs2_quota_sync+0x3da/0x8b0 fs/gfs2/quota.c:1318
 gfs2_sync_fs+0x49/0xb0 fs/gfs2/super.c:650
 sync_filesystem+0xe8/0x220 fs/sync.c:56
 generic_shutdown_super+0x6b/0x310 fs/super.c:474
 kill_block_super+0x79/0xd0 fs/super.c:1386
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 cleanup_mnt+0x494/0x520 fs/namespace.c:1291
 task_work_run+0x243/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x644/0x2150 kernel/exit.c:867
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:1012
 __do_sys_exit_group kernel/exit.c:1023 [inline]
 __se_sys_exit_group kernel/exit.c:1021 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:1021
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8d53bb09c9
Code: Unable to access opcode bytes at 0x7f8d53bb099f.
RSP: 002b:00007ffda1438d78 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f8d53c45330 RCX: 00007f8d53bb09c9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 000000000001f6db
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8d53c45330
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
BUG: scheduling while atomic: syz-executor390/5053/0x00000002
INFO: lockdep is turned off.
Modules linked in:
Preemption disabled at:
[<0000000000000000>] 0x0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
