Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44D26AADC8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 02:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCEBvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 20:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCEBvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 20:51:52 -0500
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D5211EBB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 17:51:50 -0800 (PST)
Received: by mail-il1-f207.google.com with SMTP id h1-20020a92d841000000b0031b4d3294dfso2496510ilq.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 17:51:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iTziTqXdCyDEQVpm0FvaP+DeDKXthJOgseCF6qw6QTM=;
        b=vg13ZA7vT09vJ81fvTUcYzC43enMd5RMDWYabFuSNFRXL/K6EltDriyTpJ0updZkOH
         q6teXEr5acPDcIM8D40BE7em3qhDfapEY2nq7f5azmd55qFN78fT9FXr/yl+sUEhPMqM
         G0jX0DN2jhWzsurupGHNGFw+zJZ1CcFh1+zQQzd9WIVMGI4Zv8+hys0g7zevQmgWs5I+
         bUwK4wWn1qH5vMfrP7UVFi1aVB3abvh0IyJM92nb47EnYINWXFhKmh3IecMk1g66Tr3/
         P5Q8uzVs7h4VCjuTeAOekpztvvSKy8Wh9IYui3EIW8WyQn3GDOboaKlVY8BUNIDj2jKa
         6Wyw==
X-Gm-Message-State: AO0yUKWNfu9whHMHFPcj/YaTMowlC34VrApXYc4rNKJcpg75BFSCZlfO
        /G0CqjpGRZmHsfVjsPh4aKF3vvg+w24O2yDvAQ34V5TBrM0P
X-Google-Smtp-Source: AK7set9eY+uimcfB5XASasChAWE37naA3E2jdveMW/CvQnP6KcsQQucph8Ybt4o0c1TBDjun6M67fjvvPofq8FOt7cqFKMgZYDv4
MIME-Version: 1.0
X-Received: by 2002:a02:7310:0:b0:3ca:61cc:4bbc with SMTP id
 y16-20020a027310000000b003ca61cc4bbcmr3210777jab.2.1677981109813; Sat, 04 Mar
 2023 17:51:49 -0800 (PST)
Date:   Sat, 04 Mar 2023 17:51:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd8abb05f61d6bb2@google.com>
Subject: [syzbot] [mm?] possible deadlock in collapse_file
From:   syzbot <syzbot+534d1c3c0c08473dc853@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    1716a175592a Add linux-next specific files for 20230301
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1566c97f480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4da7f0aef5d2eb8
dashboard link: https://syzkaller.appspot.com/bug?extid=534d1c3c0c08473dc853
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f1717f480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130f6874c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0745b94b7a1b/disk-1716a175.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a0be79f3fd5/vmlinux-1716a175.xz
kernel image: https://storage.googleapis.com/syzbot-assets/438e9e5cf49a/bzImage-1716a175.xz

The issue was bisected to:

commit 3d7cb67369a08d4933713290acf458990a50b6f9
Author: Suren Baghdasaryan <surenb@google.com>
Date:   Mon Feb 27 17:36:28 2023 +0000

    x86/mm: try VMA lock-based page fault handling first

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10265502c80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12265502c80000
console output: https://syzkaller.appspot.com/x/log.txt?x=14265502c80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+534d1c3c0c08473dc853@syzkaller.appspotmail.com
Fixes: 3d7cb67369a0 ("x86/mm: try VMA lock-based page fault handling first")

======================================================
WARNING: possible circular locking dependency detected
6.2.0-next-20230301-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor115/5084 is trying to acquire lock:
ffff888078307a90 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_write include/linux/mm.h:678 [inline]
ffff888078307a90 (&vma->vm_lock->lock){++++}-{3:3}, at: retract_page_tables mm/khugepaged.c:1826 [inline]
ffff888078307a90 (&vma->vm_lock->lock){++++}-{3:3}, at: collapse_file+0x4fa5/0x5980 mm/khugepaged.c:2204

but task is already holding lock:
ffff88801f93efa8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: i_mmap_lock_write include/linux/fs.h:468 [inline]
ffff88801f93efa8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: retract_page_tables mm/khugepaged.c:1745 [inline]
ffff88801f93efa8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: collapse_file+0x3da6/0x5980 mm/khugepaged.c:2204

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&mapping->i_mmap_rwsem){++++}-{3:3}:
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       i_mmap_lock_write include/linux/fs.h:468 [inline]
       dma_resv_lockdep+0x26f/0x5f0 drivers/dma-buf/dma-resv.c:760
       do_one_initcall+0x141/0x7d0 init/main.c:1306
       do_initcall_level init/main.c:1379 [inline]
       do_initcalls init/main.c:1395 [inline]
       do_basic_setup init/main.c:1414 [inline]
       kernel_init_freeable+0x5ec/0x900 init/main.c:1634
       kernel_init+0x1e/0x2c0 init/main.c:1522
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #1 (fs_reclaim){+.+.}-{0:0}:
       __fs_reclaim_acquire mm/page_alloc.c:4647 [inline]
       fs_reclaim_acquire+0x11d/0x160 mm/page_alloc.c:4661
       might_alloc include/linux/sched/mm.h:299 [inline]
       prepare_alloc_pages+0x159/0x570 mm/page_alloc.c:5293
       __alloc_pages+0x149/0x5c0 mm/page_alloc.c:5511
       __folio_alloc+0x16/0x40 mm/page_alloc.c:5554
       vma_alloc_folio+0x155/0x850 mm/mempolicy.c:2244
       do_anonymous_page mm/memory.c:4062 [inline]
       handle_pte_fault mm/memory.c:4917 [inline]
       __handle_mm_fault+0x1857/0x3e70 mm/memory.c:5061
       handle_mm_fault+0x2c0/0x9c0 mm/memory.c:5207
       do_user_addr_fault+0x2c1/0x1210 arch/x86/mm/fault.c:1349
       handle_page_fault arch/x86/mm/fault.c:1534 [inline]
       exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

-> #0 (&vma->vm_lock->lock){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3098 [inline]
       check_prevs_add kernel/locking/lockdep.c:3217 [inline]
       validate_chain kernel/locking/lockdep.c:3832 [inline]
       __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
       lock_acquire.part.0+0x11a/0x370 kernel/locking/lockdep.c:5669
       down_write+0x92/0x200 kernel/locking/rwsem.c:1573
       vma_start_write include/linux/mm.h:678 [inline]
       retract_page_tables mm/khugepaged.c:1826 [inline]
       collapse_file+0x4fa5/0x5980 mm/khugepaged.c:2204
       hpage_collapse_scan_file+0xcd3/0x1680 mm/khugepaged.c:2358
       madvise_collapse+0x53b/0xca0 mm/khugepaged.c:2818
       madvise_vma_behavior+0x649/0x20e0 mm/madvise.c:1086
       madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1260
       do_madvise.part.0+0x31c/0x470 mm/madvise.c:1439
       do_madvise mm/madvise.c:1452 [inline]
       __do_sys_madvise mm/madvise.c:1452 [inline]
       __se_sys_madvise mm/madvise.c:1450 [inline]
       __x64_sys_madvise+0x117/0x150 mm/madvise.c:1450
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &vma->vm_lock->lock --> fs_reclaim --> &mapping->i_mmap_rwsem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mapping->i_mmap_rwsem);
                               lock(fs_reclaim);
                               lock(&mapping->i_mmap_rwsem);
  lock(&vma->vm_lock->lock);

 *** DEADLOCK ***

2 locks held by syz-executor115/5084:
 #0: ffff88801f93efa8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: i_mmap_lock_write include/linux/fs.h:468 [inline]
 #0: ffff88801f93efa8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: retract_page_tables mm/khugepaged.c:1745 [inline]
 #0: ffff88801f93efa8 (&mapping->i_mmap_rwsem){++++}-{3:3}, at: collapse_file+0x3da6/0x5980 mm/khugepaged.c:2204
 #1: ffff88807b06f098 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_trylock include/linux/mmap_lock.h:120 [inline]
 #1: ffff88807b06f098 (&mm->mmap_lock){++++}-{3:3}, at: retract_page_tables mm/khugepaged.c:1797 [inline]
 #1: ffff88807b06f098 (&mm->mmap_lock){++++}-{3:3}, at: collapse_file+0x4667/0x5980 mm/khugepaged.c:2204

stack backtrace:
CPU: 0 PID: 5084 Comm: syz-executor115 Not tainted 6.2.0-next-20230301-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/16/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3098 [inline]
 check_prevs_add kernel/locking/lockdep.c:3217 [inline]
 validate_chain kernel/locking/lockdep.c:3832 [inline]
 __lock_acquire+0x2ec7/0x5d40 kernel/locking/lockdep.c:5056
 lock_acquire.part.0+0x11a/0x370 kernel/locking/lockdep.c:5669
 down_write+0x92/0x200 kernel/locking/rwsem.c:1573
 vma_start_write include/linux/mm.h:678 [inline]
 retract_page_tables mm/khugepaged.c:1826 [inline]
 collapse_file+0x4fa5/0x5980 mm/khugepaged.c:2204
 hpage_collapse_scan_file+0xcd3/0x1680 mm/khugepaged.c:2358
 madvise_collapse+0x53b/0xca0 mm/khugepaged.c:2818
 madvise_vma_behavior+0x649/0x20e0 mm/madvise.c:1086
 madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1260
 do_madvise.part.0+0x31c/0x470 mm/madvise.c:1439
 do_madvise mm/madvise.c:1452 [inline]
 __do_sys_madvise mm/madvise.c:1452 [inline]
 __se_sys_madvise mm/madvise.c:1450 [inline]
 __x64_sys_madvise+0x117/0x150 mm/madvise.c:1450
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fcffa4a4b29
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe20f24e68 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcffa4a4b29
RDX: 0000000000000019 RSI: 0000000000600003 RDI: 0000000020000000
RBP: 00007fcffa468cd0 R08: 0000000000000000 R09: 0000000000000000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
