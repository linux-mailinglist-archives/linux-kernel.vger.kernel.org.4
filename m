Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6FD693E19
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 07:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBMGQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 01:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBMGQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 01:16:43 -0500
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502B9B772
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 22:16:42 -0800 (PST)
Received: by mail-io1-f77.google.com with SMTP id y22-20020a5d94d6000000b007076e06ba3dso7861742ior.20
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 22:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wp8CIxY1zXj1d6cgL+AYTB2DywecM7uT8y1HZIN/3rg=;
        b=BfzLQvvuFjLkxgvRETzIdb9qKAF2P5gy0yx+Rz57V7SazchVXZS692e0Z8qhY1fM5e
         2Ej0qJrBbBhyovnjdAvzw+Zvqd6COIVionJ+VZVnRLzK0BEKJdC27wxNSgbSOVJLBIh2
         SB4BeYaNWo8TnJ+jw72lXj6bHLWwVsrkG5PFZE7tD35oS9uTCG8BH11GgkMzEoAFGvaM
         LiCOi5VP4HKE40PlwR4qB/Gv4MUJwlkmg5UHfnM7uDZdDNqq7LVpwlfGXTKl/JWc/Ggu
         09MwV+vwxlc8SkOaw7PYle7eBEbDAfJQuvEtrrBjZYpu4nSczG3KcsI8L71vQbFGyFRv
         pzdg==
X-Gm-Message-State: AO0yUKVwhibO5wMOuuW1E3BzYdwIL/GpZ1lM2Oa+0Qxnea3NCYEoIbuN
        RwKHgVUMfwz9S5r2UMlMc5topE8aqOTXv0GMotP6R5nbk9la
X-Google-Smtp-Source: AK7set8jA8dKXSvJUQhoKtmIFNhxPonujtIiqIOhqbxpjw3s5CnurBc0IVEsrvgx0E0Uu61eFJVL+jTwUPu5sZ3NoMLPIveflJuH
MIME-Version: 1.0
X-Received: by 2002:a02:a717:0:b0:3c3:2c2c:c6a8 with SMTP id
 k23-20020a02a717000000b003c32c2cc6a8mr8003483jam.47.1676269001630; Sun, 12
 Feb 2023 22:16:41 -0800 (PST)
Date:   Sun, 12 Feb 2023 22:16:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063e9fe05f48ecae9@google.com>
Subject: [syzbot] WARNING: suspicious RCU usage in mas_state_walk (2)
From:   syzbot <syzbot+a5ca677fb59b73010889@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    eaed33698e35 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=16ce767d480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606ed7eeab569393
dashboard link: https://syzkaller.appspot.com/bug?extid=a5ca677fb59b73010889
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11a53365480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119c47f3480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/39aaf563b17c/disk-eaed3369.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/83f46f733a0a/vmlinux-eaed3369.xz
kernel image: https://storage.googleapis.com/syzbot-assets/50dfdf867e68/Image-eaed3369.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a5ca677fb59b73010889@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.2.0-rc7-syzkaller-17891-geaed33698e35 #0 Not tainted
-----------------------------
lib/maple_tree.c:852 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
5 locks held by syz-executor154/5020:
 #0: ffff0000c672c460 (sb_writers#7){.+.+}-{0:0}, at: vfs_write+0x174/0x44c fs/read_write.c:580
 #1: ffff0000c9a67c88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x120/0x288 fs/kernfs/file.c:325
 #2: ffff0000c03954a0 (kn->active#42){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x128/0x288 fs/kernfs/file.c:326
 #3: ffff80000d4bc640 (ksm_thread_mutex){+.+.}-{3:3}, at: run_store+0x8c/0x608 mm/ksm.c:2951
 #4: ffff0000c6af9c48 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #4: ffff0000c6af9c48 (&mm->mmap_lock){++++}-{3:3}, at: unmerge_and_remove_all_rmap_items mm/ksm.c:990 [inline]
 #4: ffff0000c6af9c48 (&mm->mmap_lock){++++}-{3:3}, at: run_store+0x200/0x608 mm/ksm.c:2957

stack backtrace:
CPU: 0 PID: 5020 Comm: syz-executor154 Not tainted 6.2.0-rc7-syzkaller-17891-geaed33698e35 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
Call trace:
 dump_backtrace+0x1c8/0x1f4 arch/arm64/kernel/stacktrace.c:158
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:165
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 lockdep_rcu_suspicious+0x138/0x154 kernel/locking/lockdep.c:6597
 mas_root lib/maple_tree.c:852 [inline]
 mas_start lib/maple_tree.c:1357 [inline]
 mas_state_walk+0x1a4/0x200 lib/maple_tree.c:3838
 mas_walk+0x2c/0xc4 lib/maple_tree.c:5046
 mas_find+0x10c/0x13c lib/maple_tree.c:6012
 vma_find include/linux/mm.h:668 [inline]
 vma_next include/linux/mm.h:677 [inline]
 unmerge_and_remove_all_rmap_items mm/ksm.c:991 [inline]
 run_store+0x214/0x608 mm/ksm.c:2957
 kobj_attr_store+0x4c/0x70 lib/kobject.c:824
 sysfs_kf_write+0xf4/0x11c fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x1d8/0x288 fs/kernfs/file.c:334
 call_write_iter include/linux/fs.h:2189 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x2bc/0x44c fs/read_write.c:584
 ksys_write+0xb4/0x160 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __arm64_sys_write+0x24/0x34 fs/read_write.c:646
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x64/0x178 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0xbc/0x180 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x110 arch/arm64/kernel/syscall.c:193
 el0_svc+0x58/0x14c arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
