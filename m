Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77634654F55
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiLWKus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbiLWKuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:50:44 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD4C119
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:50:41 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id b77-20020a6bb250000000b006e4ec8b2364so1784654iof.20
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 02:50:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUb/p1GCG1vPuy3vNLmwWyASY52A8QrAnJMyAJ6mfeQ=;
        b=mlZaXd1d6lY9OG7C5HzPyKQWbMjMQU2mfPIVmNru+Mymd4mH39GIMZ5ChI83DJY3WD
         2XNFBWLqUYX3b7T/cfjV9yTXecGpN6GhE2P+1EgLmATVovE5hoaIaMZp5r9Hgl4lXU6i
         AMcmWCBcHbLb3vm3iXfpqbt57R4QQJDmJTMj5qG66JEZ/DhEvDy7Pl7dhh2SlWvf+ZEH
         9jDPR5r0eeMmkfEpB6fgRNWW7lJ/v8ll+o9mgyKDAzXlRECPdBCE7s9Q78e+pJTc9hhR
         00F82479Xq7V2LFySe8L6/hXvQehYSOfUJnduxgGQ6Gw2cdk+4RWTon/tT3u38aikU5E
         1OMA==
X-Gm-Message-State: AFqh2kou5BAlikylO9aAsyEXs1aw1wO1emJ3l8kT45Omp1Y9IPmWT9l3
        dbpg5IE8cpdyZl8n7uvuWCeE7TMJ2PmbB3X85OJeKiCAV6xN
X-Google-Smtp-Source: AMrXdXtui5Qm3jwLDSDeRV9TfHoxdibgJGNZk3O6TvwYnxsZuwb/2tJHrRDZmC9eb/8+SiLqUhy0jUd9Sve0vjMosErz0v6TFpKl
MIME-Version: 1.0
X-Received: by 2002:a05:6638:41a3:b0:38a:7676:20ce with SMTP id
 az35-20020a05663841a300b0038a767620cemr803000jab.34.1671792640665; Fri, 23
 Dec 2022 02:50:40 -0800 (PST)
Date:   Fri, 23 Dec 2022 02:50:40 -0800
In-Reply-To: <00000000000032654605ef9c1846@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c321405f07c8e00@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in do_page_mkwrite
From:   syzbot <syzbot+ff866d16791d4984b3c7@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    8395ae05cb5a Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14e189f8480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
dashboard link: https://syzkaller.appspot.com/bug?extid=ff866d16791d4984b3c7
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1282218c480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148aa0a8480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/801dbf77dd1d/disk-8395ae05.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a057f4aa500/vmlinux-8395ae05.xz
kernel image: https://storage.googleapis.com/syzbot-assets/70a630e3d523/bzImage-8395ae05.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1b64a5dd0f67/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff866d16791d4984b3c7@syzkaller.appspotmail.com

WARNING: possible circular locking dependency detected
6.1.0-syzkaller-14446-g8395ae05cb5a #0 Not tainted
------------------------------------------------------
syz-executor409/5148 is trying to acquire lock:
ffff888017eac090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27

but task is already holding lock:
ffff88802081e558 (sb_pagefaults){.+.+}-{0:0}, at: do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2947

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sb_pagefaults){.+.+}-{0:0}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1811 [inline]
       sb_start_pagefault include/linux/fs.h:1915 [inline]
       filemap_page_mkwrite+0x15c/0x7a0 mm/filemap.c:3439
       do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2947
       wp_page_shared+0x15e/0x380 mm/memory.c:3295
       handle_pte_fault mm/memory.c:4949 [inline]
       __handle_mm_fault mm/memory.c:5073 [inline]
       handle_mm_fault+0x1b79/0x26b0 mm/memory.c:5219
       do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
       handle_page_fault arch/x86/mm/fault.c:1519 [inline]
       exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
       asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __might_fault+0xb2/0x110 mm/memory.c:5647
       reiserfs_ioctl+0x11c/0x340 fs/reiserfs/ioctl.c:96
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:870 [inline]
       __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&sbi->lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27
       reiserfs_dirty_inode+0xdf/0x230 fs/reiserfs/super.c:704
       __mark_inode_dirty+0x1e7/0x600 fs/fs-writeback.c:2419
       generic_update_time fs/inode.c:1859 [inline]
       inode_update_time fs/inode.c:1872 [inline]
       __file_update_time fs/inode.c:2057 [inline]
       file_update_time+0x551/0x5d0 fs/inode.c:2088
       filemap_page_mkwrite+0x248/0x7a0 mm/filemap.c:3440
       do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2947
       wp_page_shared+0x15e/0x380 mm/memory.c:3295
       handle_pte_fault mm/memory.c:4949 [inline]
       __handle_mm_fault mm/memory.c:5073 [inline]
       handle_mm_fault+0x1b79/0x26b0 mm/memory.c:5219
       do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
       handle_page_fault arch/x86/mm/fault.c:1519 [inline]
       exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
       asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570

other info that might help us debug this:

Chain exists of:
  &sbi->lock --> &mm->mmap_lock --> sb_pagefaults

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_pagefaults);
                               lock(&mm->mmap_lock);
                               lock(sb_pagefaults);
  lock(&sbi->lock);

 *** DEADLOCK ***

2 locks held by syz-executor409/5148:
 #0: ffff88801d47c758 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:136 [inline]
 #0: ffff88801d47c758 (&mm->mmap_lock){++++}-{3:3}, at: do_user_addr_fault+0x2e2/0xcb0 arch/x86/mm/fault.c:1369
 #1: ffff88802081e558 (sb_pagefaults){.+.+}-{0:0}, at: do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2947

stack backtrace:
CPU: 0 PID: 5148 Comm: syz-executor409 Not tainted 6.1.0-syzkaller-14446-g8395ae05cb5a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x77/0xd0 fs/reiserfs/lock.c:27
 reiserfs_dirty_inode+0xdf/0x230 fs/reiserfs/super.c:704
 __mark_inode_dirty+0x1e7/0x600 fs/fs-writeback.c:2419
 generic_update_time fs/inode.c:1859 [inline]
 inode_update_time fs/inode.c:1872 [inline]
 __file_update_time fs/inode.c:2057 [inline]
 file_update_time+0x551/0x5d0 fs/inode.c:2088
 filemap_page_mkwrite+0x248/0x7a0 mm/filemap.c:3440
 do_page_mkwrite+0x19e/0x5e0 mm/memory.c:2947
 wp_page_shared+0x15e/0x380 mm/memory.c:3295
 handle_pte_fault mm/memory.c:4949 [inline]
 __handle_mm_fault mm/memory.c:5073 [inline]
 handle_mm_fault+0x1b79/0x26b0 mm/memory.c:5219
 do_user_addr_fault+0x69b/0xcb0 arch/x86/mm/fault.c:1428
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x7a/0x110 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7f61a34e95a0
Code: 00 e8 14 26 04 00 48 8b 35 bd 5b 0b 00 31 c9 31 c0 ba 01 76 08 80 bf 10 00 00 00 e8 fa 25 04 00 b8 98 00 00 20 b9 20 00 00 00 <c7> 04 25 80 00 00 20 08 00 00 00 66 c7 04 25 84 00 00 20 20 01 48
RSP: 002b:00007ffd03dae660 EFLAGS: 00010286
RAX: 0000000020000098 RBX: 000000000000f4c9 RCX: 0000000000000020
RDX: 0000000000000000 RSI: 0000000080087601 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd03dae68c
R13: 00007ffd03dae6c0 R14: 00007ffd03dae6a0 R15: 0000000000000006
 </TASK>

