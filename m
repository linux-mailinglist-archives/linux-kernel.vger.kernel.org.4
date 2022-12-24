Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F196559E8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 12:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiLXLUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 06:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiLXLUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 06:20:41 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FE16563
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 03:20:39 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id e9-20020a056e020b2900b003036757d5caso4022864ilu.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 03:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mUv0RwlyjdgUjh0+HYkzgr/rkjxvgJXSMOp/NGjbVGU=;
        b=dCmwIRteUzvRxTdsLlL6oQLD1jbxLEVfsx9Q6R1AVo4OXo4gT8K7j7OYOy6U7pdtpy
         z3CMMj9OyM/AF2qdY/kgTYIo0yHne+gn35mUMVHccUNQtC/CVD9jpOrDfivC7RjnGyDV
         c4mcgpYLd3K9vz11Pgl9trKAor+9scWUbZm3JmeGwzDZKHN5se3x3vfxh5cpiHZtFTyw
         /BpQh675u1hMqeCr8PJdhsTYxos3Yskza0RmLOqKa8KT/CHsxZQyhO6DWTBkuTaxic+J
         gc9dJGD/PDuN08w+AFZnCRZETfSmoUvWAwio1TYmkQGQ9yIqs6xwRzlLgk3/fFWZzIeA
         2Ztw==
X-Gm-Message-State: AFqh2krhBCu9jd3kFc1rMrLdUsIjNAaZXgS/Drlu1hXdzqA4flafDGt8
        GNzq9MYdupEMPI5y8T195fsE3EMBwTRxDP0LTrZXniASr6oQ
X-Google-Smtp-Source: AMrXdXs0zOZFycFBjQ12cz5afe1Cx96EvARpqsdFbLzaBjvWRWk3DBcXk58tBNBxpwCtgAexEQtI2ezwPxHCPOxPhNAxM1pB0gTY
MIME-Version: 1.0
X-Received: by 2002:a02:a488:0:b0:374:e77e:d3d8 with SMTP id
 d8-20020a02a488000000b00374e77ed3d8mr992174jam.103.1671880839225; Sat, 24 Dec
 2022 03:20:39 -0800 (PST)
Date:   Sat, 24 Dec 2022 03:20:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000087698205f0911707@google.com>
Subject: [syzbot] [f2fs?] possible deadlock in f2fs_do_map_lock
From:   syzbot <syzbot+b392b861663de30af8e0@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10f880e8480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=b392b861663de30af8e0
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b392b861663de30af8e0@syzkaller.appspotmail.com

F2FS-fs (loop5): invalid crc value
F2FS-fs (loop5): Found nat_bits in checkpoint
F2FS-fs (loop5): Mounted with checkpoint version = 48b305e4
======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0 Not tainted
------------------------------------------------------
syz-executor.5/8612 is trying to acquire lock:
ffff00011158a4e0 (&sbi->node_change){++++}-{3:3}, at: f2fs_do_map_lock+0x5c/0x88

but task is already holding lock:
ffff00010db4bd90 (mapping.invalidate_lock#7){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
ffff00010db4bd90 (mapping.invalidate_lock#7){++++}-{3:3}, at: f2fs_vm_page_mkwrite+0x18c/0x9a4 fs/f2fs/file.c:104

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (mapping.invalidate_lock#7){++++}-{3:3}:
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1509
       filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
       filemap_fault+0x104/0x7fc mm/filemap.c:3127
       f2fs_filemap_fault+0x2c/0x54 fs/f2fs/file.c:44
       __do_fault+0x60/0x358 mm/memory.c:4202
       do_shared_fault mm/memory.c:4608 [inline]
       do_fault+0x23c/0x550 mm/memory.c:4686
       handle_pte_fault mm/memory.c:4954 [inline]
       __handle_mm_fault mm/memory.c:5096 [inline]
       handle_mm_fault+0x78c/0xa48 mm/memory.c:5217
       __do_page_fault arch/arm64/mm/fault.c:508 [inline]
       do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:608
       do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:691
       do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:827
       el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:367
       el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:427
       el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:579
       __arch_copy_to_user+0x104/0x234 arch/arm64/lib/copy_template.S:135
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #3 (&mm->mmap_lock){++++}-{3:3}:
       __might_fault+0x7c/0xb4 mm/memory.c:5645
       _copy_to_user include/linux/uaccess.h:143 [inline]
       copy_to_user include/linux/uaccess.h:169 [inline]
       f2fs_ioc_get_encryption_pwsalt fs/f2fs/file.c:2349 [inline]
       __f2fs_ioctl+0x3204/0x3318 fs/f2fs/file.c:4151
       f2fs_ioctl+0x74/0xbc fs/f2fs/file.c:4224
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

-> #2 (&sbi->sb_lock){++++}-{3:3}:
       down_write+0x5c/0x88 kernel/locking/rwsem.c:1562
       f2fs_down_write fs/f2fs/f2fs.h:2205 [inline]
       f2fs_handle_error+0x9c/0x17c fs/f2fs/super.c:3898
       f2fs_check_nid_range fs/f2fs/node.c:39 [inline]
       add_free_nid+0x4d8/0x50c fs/f2fs/node.c:2282
       scan_nat_page fs/f2fs/node.c:2384 [inline]
       __f2fs_build_free_nids fs/f2fs/node.c:2490 [inline]
       f2fs_build_free_nids+0x680/0x8f4 fs/f2fs/node.c:2528
       f2fs_build_node_manager+0x624/0x64c fs/f2fs/node.c:3313
       f2fs_fill_super+0x1470/0x1e90 fs/f2fs/super.c:4306
       mount_bdev+0x1b8/0x210 fs/super.c:1401
       f2fs_mount+0x44/0x58 fs/f2fs/super.c:4580
       legacy_get_tree+0x30/0x74 fs/fs_context.c:610
       vfs_get_tree+0x40/0x140 fs/super.c:1531
       do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
       path_mount+0x358/0x890 fs/namespace.c:3370
       do_mount fs/namespace.c:3383 [inline]
       __do_sys_mount fs/namespace.c:3591 [inline]
       __se_sys_mount fs/namespace.c:3568 [inline]
       __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #1 (&nm_i->nat_tree_lock){++++}-{3:3}:
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1509
       f2fs_down_read fs/f2fs/f2fs.h:2180 [inline]
       f2fs_get_node_info+0x74/0x458 fs/f2fs/node.c:560
       __write_node_page+0x244/0xfcc fs/f2fs/node.c:1613
       f2fs_sync_node_pages+0x888/0xdb0 fs/f2fs/node.c:2017
       block_operations+0x288/0x400 fs/f2fs/checkpoint.c:1270
       f2fs_write_checkpoint+0x210/0x568 fs/f2fs/checkpoint.c:1650
       kill_f2fs_super+0xec/0x194 fs/f2fs/super.c:4606
       deactivate_locked_super+0x70/0xe8 fs/super.c:332
       deactivate_super+0xd0/0xd4 fs/super.c:363
       cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
       __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
       task_work_run+0x100/0x148 kernel/task_work.c:179
       resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
       do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1132
       prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
       exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
       el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

-> #0 (&sbi->node_change){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1509
       f2fs_do_map_lock+0x5c/0x88
       f2fs_vm_page_mkwrite+0x324/0x9a4 fs/f2fs/file.c:116
       do_page_mkwrite+0x74/0x288 mm/memory.c:2977
       do_shared_fault mm/memory.c:4618 [inline]
       do_fault+0x274/0x550 mm/memory.c:4686
       handle_pte_fault mm/memory.c:4954 [inline]
       __handle_mm_fault mm/memory.c:5096 [inline]
       handle_mm_fault+0x78c/0xa48 mm/memory.c:5217
       __do_page_fault arch/arm64/mm/fault.c:508 [inline]
       do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:608
       do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:691
       do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:827
       el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:367
       el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:427
       el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:579
       __arch_copy_to_user+0x104/0x234 arch/arm64/lib/copy_template.S:135
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584

other info that might help us debug this:

Chain exists of:
  &sbi->node_change --> &mm->mmap_lock --> mapping.invalidate_lock#7

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(mapping.invalidate_lock#7);
                               lock(&mm->mmap_lock);
                               lock(mapping.invalidate_lock#7);
  lock(&sbi->node_change);

 *** DEADLOCK ***

3 locks held by syz-executor.5/8612:
 #0: ffff00010fb7cbc8 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock include/linux/mmap_lock.h:117 [inline]
 #0: ffff00010fb7cbc8 (&mm->mmap_lock){++++}-{3:3}, at: do_page_fault+0x3c8/0x79c arch/arm64/mm/fault.c:593
 #1: ffff00011c1c9558 (sb_pagefaults#3){.+.+}-{0:0}, at: sb_start_pagefault include/linux/fs.h:1930 [inline]
 #1: ffff00011c1c9558 (sb_pagefaults#3){.+.+}-{0:0}, at: f2fs_vm_page_mkwrite+0x160/0x9a4 fs/f2fs/file.c:99
 #2: ffff00010db4bd90 (mapping.invalidate_lock#7){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 #2: ffff00010db4bd90 (mapping.invalidate_lock#7){++++}-{3:3}, at: f2fs_vm_page_mkwrite+0x18c/0x9a4 fs/f2fs/file.c:104

stack backtrace:
CPU: 0 PID: 8612 Comm: syz-executor.5 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2055
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x1530/0x3084 kernel/locking/lockdep.c:5055
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 down_read+0x5c/0x78 kernel/locking/rwsem.c:1509
 f2fs_do_map_lock+0x5c/0x88
 f2fs_vm_page_mkwrite+0x324/0x9a4 fs/f2fs/file.c:116
 do_page_mkwrite+0x74/0x288 mm/memory.c:2977
 do_shared_fault mm/memory.c:4618 [inline]
 do_fault+0x274/0x550 mm/memory.c:4686
 handle_pte_fault mm/memory.c:4954 [inline]
 __handle_mm_fault mm/memory.c:5096 [inline]
 handle_mm_fault+0x78c/0xa48 mm/memory.c:5217
 __do_page_fault arch/arm64/mm/fault.c:508 [inline]
 do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:608
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:691
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:827
 el1_abort+0x3c/0x5c arch/arm64/kernel/entry-common.c:367
 el1h_64_sync_handler+0x60/0xac arch/arm64/kernel/entry-common.c:427
 el1h_64_sync+0x64/0x68 arch/arm64/kernel/entry.S:579
 __arch_copy_to_user+0x104/0x234 arch/arm64/lib/copy_template.S:135
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
