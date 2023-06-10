Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5F972AB12
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 13:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbjFJLIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 07:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjFJLIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 07:08:00 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A243596
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 04:07:58 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-33b7a468d14so25268455ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 04:07:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686395277; x=1688987277;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j7wne0R8J3TTQe3FsyClrEj4Vd33QJhSyI4mQ69bZzY=;
        b=iNfzCbhM04eH18NffqrGU2N9LxHkSmhaAgn5futEZws23hl++ijcYd7QdLfrh/iQTY
         yQpke+EYPzPuRtBEa03GD5WnxJ8w2v2QtRRf2VbU5F6dviCi/ucqR0TnpuWIL8DZ0I/Z
         lV4lnA3TruRE6i6IBBkloD6oU+dSiOmBDdaG6QxTII/QhaYnb2FhNcRhhs0n6CgVC06N
         lm1GNnISf/ksaIDIQium6gYyhhXi8dEBB6E5jLxwS75DFMGqajP5BDlB9MWUw1Huy14R
         lxbb+ee3sh8ZuoznfSHOR0xA5gf61Gr4iFw+dlj5a0HiOgxG6WIDA6m1Q2H7UJBCKWYZ
         kgow==
X-Gm-Message-State: AC+VfDwJnatt3ICi/InYop1K0WSnTPsnOXbTwSSOgQrMB1CWw+tqFOTX
        qQU/bNJmf9OV0Uo+lAFSYv0/w5j992alyAsJZ3QyFV0fJ5j/
X-Google-Smtp-Source: ACHHUZ5a/xq6D5SQmQw1Fe2onTgw8ok2zvj6NdElvFhTPFtdsYNBTJ/OEW+VrrDjgqzBKyCmTg8bUVJrZElEpdT6lnrYQrbSkv0z
MIME-Version: 1.0
X-Received: by 2002:a92:d246:0:b0:310:9fc1:a92b with SMTP id
 v6-20020a92d246000000b003109fc1a92bmr1959380ilg.0.1686395277561; Sat, 10 Jun
 2023 04:07:57 -0700 (PDT)
Date:   Sat, 10 Jun 2023 04:07:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078585805fdc47f34@google.com>
Subject: [syzbot] [cgroups?] possible deadlock in freezer_css_online
From:   syzbot <syzbot+387de8f7ae917a47dc5e@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, hannes@cmpxchg.org,
        linux-kernel@vger.kernel.org, lizefan.x@bytedance.com,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f8dba31b0a82 Merge tag 'asym-keys-fix-for-linus-v6.4-rc5' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12464b7d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=befacc9fbc9cd0ac
dashboard link: https://syzkaller.appspot.com/bug?extid=387de8f7ae917a47dc5e
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-f8dba31b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7059eda5ac77/vmlinux-f8dba31b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/25f8cdcaad99/Image-f8dba31b.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+387de8f7ae917a47dc5e@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.4.0-rc5-syzkaller-00002-gf8dba31b0a82 #0 Not tainted
------------------------------------------------------
syz-executor.1/11374 is trying to acquire lock:
ffff80000e31c1b0 (cpu_hotplug_lock){++++}-{0:0}, at: cpus_read_lock+0x10/0x1c kernel/cpu.c:310

but task is already holding lock:
ffff80000e4c0da8 (freezer_mutex){+.+.}-{3:3}, at: freezer_css_online+0x4c/0x178 kernel/cgroup/legacy_freezer.c:111

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (freezer_mutex){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x124/0x830 kernel/locking/mutex.c:747
       mutex_lock_nested+0x24/0x30 kernel/locking/mutex.c:799
       freezer_change_state kernel/cgroup/legacy_freezer.c:389 [inline]
       freezer_write+0x84/0x640 kernel/cgroup/legacy_freezer.c:429
       cgroup_file_write+0x218/0x5b4 kernel/cgroup/cgroup.c:4071
       kernfs_fop_write_iter+0x264/0x3c4 fs/kernfs/file.c:334
       call_write_iter include/linux/fs.h:1868 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x4cc/0x748 fs/read_write.c:584
       ksys_write+0xec/0x1d0 fs/read_write.c:637
       __do_sys_write fs/read_write.c:649 [inline]
       __se_sys_write fs/read_write.c:646 [inline]
       __arm64_sys_write+0x6c/0x9c fs/read_write.c:646
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x6c/0x260 arch/arm64/kernel/syscall.c:52
       el0_svc_common.constprop.0+0xc4/0x254 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x50/0x124 arch/arm64/kernel/syscall.c:193
       el0_svc+0x4c/0x130 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

-> #0 (cpu_hotplug_lock){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3113 [inline]
       check_prevs_add kernel/locking/lockdep.c:3232 [inline]
       validate_chain kernel/locking/lockdep.c:3847 [inline]
       __lock_acquire+0x27c4/0x5270 kernel/locking/lockdep.c:5088
       lock_acquire kernel/locking/lockdep.c:5705 [inline]
       lock_acquire+0x478/0x7c0 kernel/locking/lockdep.c:5670
       percpu_down_read.constprop.0+0x58/0x1f0 include/linux/percpu-rwsem.h:51
       cpus_read_lock+0x10/0x1c kernel/cpu.c:310
       static_key_slow_inc+0x18/0x50 kernel/jump_label.c:185
       freezer_css_online+0xe4/0x178 kernel/cgroup/legacy_freezer.c:117
       online_css+0x90/0x260 kernel/cgroup/cgroup.c:5491
       css_create kernel/cgroup/cgroup.c:5562 [inline]
       cgroup_apply_control_enable+0x48c/0x960 kernel/cgroup/cgroup.c:3249
       cgroup_mkdir+0x4b0/0xdf0 kernel/cgroup/cgroup.c:5758
       kernfs_iop_mkdir+0x104/0x184 fs/kernfs/dir.c:1219
       vfs_mkdir+0x1a8/0x370 fs/namei.c:4115
       do_mkdirat+0x20c/0x24c fs/namei.c:4138
       __do_sys_mkdirat fs/namei.c:4153 [inline]
       __se_sys_mkdirat fs/namei.c:4151 [inline]
       __arm64_sys_mkdirat+0xdc/0x138 fs/namei.c:4151
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall+0x6c/0x260 arch/arm64/kernel/syscall.c:52
       el0_svc_common.constprop.0+0xc4/0x254 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x50/0x124 arch/arm64/kernel/syscall.c:193
       el0_svc+0x4c/0x130 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(freezer_mutex);
                               lock(cpu_hotplug_lock);
                               lock(freezer_mutex);
  rlock(cpu_hotplug_lock);

 *** DEADLOCK ***

4 locks held by syz-executor.1/11374:
 #0: ffff0000143f8460 (sb_writers#10){.+.+}-{0:0}, at: __sb_start_write include/linux/fs.h:1494 [inline]
 #0: ffff0000143f8460 (sb_writers#10){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1569 [inline]
 #0: ffff0000143f8460 (sb_writers#10){.+.+}-{0:0}, at: mnt_want_write+0x3c/0xb0 fs/namespace.c:394
 #1: ffff00000f0733f0 (&type->i_mutex_dir_key#7/1){+.+.}-{3:3}, at: inode_lock_nested include/linux/fs.h:810 [inline]
 #1: ffff00000f0733f0 (&type->i_mutex_dir_key#7/1){+.+.}-{3:3}, at: filename_create+0x150/0x348 fs/namei.c:3884
 #2: ffff80000e4b0fa8 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_lock include/linux/cgroup.h:370 [inline]
 #2: ffff80000e4b0fa8 (cgroup_mutex){+.+.}-{3:3}, at: cgroup_kn_lock_live+0xe0/0x578 kernel/cgroup/cgroup.c:1683
 #3: ffff80000e4c0da8 (freezer_mutex){+.+.}-{3:3}, at: freezer_css_online+0x4c/0x178 kernel/cgroup/legacy_freezer.c:111

stack backtrace:
CPU: 0 PID: 11374 Comm: syz-executor.1 Not tainted 6.4.0-rc5-syzkaller-00002-gf8dba31b0a82 #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x9c/0x11c arch/arm64/kernel/stacktrace.c:233
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x74/0xd4 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_circular_bug+0x400/0x704 kernel/locking/lockdep.c:2066
 check_noncircular+0x26c/0x2e0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3113 [inline]
 check_prevs_add kernel/locking/lockdep.c:3232 [inline]
 validate_chain kernel/locking/lockdep.c:3847 [inline]
 __lock_acquire+0x27c4/0x5270 kernel/locking/lockdep.c:5088
 lock_acquire kernel/locking/lockdep.c:5705 [inline]
 lock_acquire+0x478/0x7c0 kernel/locking/lockdep.c:5670
 percpu_down_read.constprop.0+0x58/0x1f0 include/linux/percpu-rwsem.h:51
 cpus_read_lock+0x10/0x1c kernel/cpu.c:310
 static_key_slow_inc+0x18/0x50 kernel/jump_label.c:185
 freezer_css_online+0xe4/0x178 kernel/cgroup/legacy_freezer.c:117
 online_css+0x90/0x260 kernel/cgroup/cgroup.c:5491
 css_create kernel/cgroup/cgroup.c:5562 [inline]
 cgroup_apply_control_enable+0x48c/0x960 kernel/cgroup/cgroup.c:3249
 cgroup_mkdir+0x4b0/0xdf0 kernel/cgroup/cgroup.c:5758
 kernfs_iop_mkdir+0x104/0x184 fs/kernfs/dir.c:1219
 vfs_mkdir+0x1a8/0x370 fs/namei.c:4115
 do_mkdirat+0x20c/0x24c fs/namei.c:4138
 __do_sys_mkdirat fs/namei.c:4153 [inline]
 __se_sys_mkdirat fs/namei.c:4151 [inline]
 __arm64_sys_mkdirat+0xdc/0x138 fs/namei.c:4151
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x6c/0x260 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0xc4/0x254 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x50/0x124 arch/arm64/kernel/syscall.c:193
 el0_svc+0x4c/0x130 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0xb8/0xbc arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
