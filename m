Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129747215CF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 11:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjFDJVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 05:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjFDJVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 05:21:08 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EDCE3
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 02:21:05 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-77703efb26dso261338239f.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 02:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685870465; x=1688462465;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HDWJxnfDqOBuqzDH4am0m3hkIcc+wkoVRF7GoEFg+98=;
        b=Vid9Bp6Z1ubVn8GJAAacaYzt+f6GEEvHXsE3xPNgEBZrfa1At8qMNj/rS7RBmeE/Ed
         qp3ulRp05Hw2VjHss98FmhKD48UuuvVZMhrHKQiit0VzVW+eucnnu1w2qwiajH1Le5tf
         CetwzzTHSfSR+lFlo5D19ZBCQ7ZgAU+Nokhz1CaEUPnXYRcDTjeC6JS8pq0LN3EYw/59
         akROulD0Zv906mWGNRARjxr3QNpa65aJD8dkmeegc0AZ468ZT8kQnfhqnyNMKe02isi6
         fQhuCMIq1krPVRP4VcltagWu9KwGdqL0oZeY7soPXAUshn8BM0gIG6kgT2eZISeV22/b
         FzDQ==
X-Gm-Message-State: AC+VfDz7B24y4DKr78HnXq149Y/8Zlu1/ggZVYAuLtFuZLHvRXlS0JXD
        /+avE5Xo5R3zofkMSFk5Rgxy+xRFJes2KWBGAw0ee75DvOgq
X-Google-Smtp-Source: ACHHUZ7UUj40CODCUxL6gfgZP2Yfq8WP1+h5uQ18BeZrXn8vi3A4fnLrhlan4hXIdDDpF3Q7KHg7mwRoZrq+0QBpct7ZADEjHGUc
MIME-Version: 1.0
X-Received: by 2002:a92:db52:0:b0:335:908b:8f9 with SMTP id
 w18-20020a92db52000000b00335908b08f9mr5987486ilq.1.1685870465142; Sun, 04 Jun
 2023 02:21:05 -0700 (PDT)
Date:   Sun, 04 Jun 2023 02:21:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000365bc405fd4a4ee3@google.com>
Subject: [syzbot] [mm?] [usb?] memory leak in new_inode (2)
From:   syzbot <syzbot+ea01ee90cdba474c187b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    afead42fdfca Merge tag 'perf-tools-fixes-for-v6.4-2-2023-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13acfcd1280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=21fde9f7601f218f
dashboard link: https://syzkaller.appspot.com/bug?extid=ea01ee90cdba474c187b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15160fb9280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b5acaa3b8518/disk-afead42f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/041db64527a2/vmlinux-afead42f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cd4f6f1744e4/bzImage-afead42f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ea01ee90cdba474c187b@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810a5cd958 (size 776):
  comm "syslogd", pid 4424, jiffies 4294938531 (age 1177.910s)
  hex dump (first 32 bytes):
    00 00 00 00 01 00 00 00 00 00 20 00 00 00 00 00  .......... .....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8152a817>] alloc_inode_sb include/linux/fs.h:2705 [inline]
    [<ffffffff8152a817>] shmem_alloc_inode+0x27/0x50 mm/shmem.c:3907
    [<ffffffff8168f979>] alloc_inode+0x29/0x110 fs/inode.c:260
    [<ffffffff8168fa87>] new_inode_pseudo fs/inode.c:1018 [inline]
    [<ffffffff8168fa87>] new_inode+0x27/0xf0 fs/inode.c:1046
    [<ffffffff8152b944>] shmem_get_inode+0xd4/0x560 mm/shmem.c:2370
    [<ffffffff8152bf12>] shmem_mknod+0x42/0x150 mm/shmem.c:2942
    [<ffffffff81676fd5>] lookup_open fs/namei.c:3492 [inline]
    [<ffffffff81676fd5>] open_last_lookups fs/namei.c:3560 [inline]
    [<ffffffff81676fd5>] path_openat+0x1725/0x1b10 fs/namei.c:3788
    [<ffffffff81679175>] do_filp_open+0xc5/0x1b0 fs/namei.c:3818
    [<ffffffff81653dbd>] do_sys_openat2+0xed/0x260 fs/open.c:1356
    [<ffffffff81654863>] do_sys_open fs/open.c:1372 [inline]
    [<ffffffff81654863>] __do_sys_openat fs/open.c:1388 [inline]
    [<ffffffff81654863>] __se_sys_openat fs/open.c:1383 [inline]
    [<ffffffff81654863>] __x64_sys_openat+0x83/0xe0 fs/open.c:1383
    [<ffffffff84a15749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a15749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888109473080 (size 32):
  comm "syslogd", pid 4424, jiffies 4294938531 (age 1177.910s)
  hex dump (first 32 bytes):
    18 db 5c 0a 81 88 ff ff b0 65 2d 82 ff ff ff ff  ..\......e-.....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff822d7cae>] kmem_cache_zalloc include/linux/slab.h:670 [inline]
    [<ffffffff822d7cae>] lsm_inode_alloc security/security.c:632 [inline]
    [<ffffffff822d7cae>] security_inode_alloc+0x2e/0xb0 security/security.c:1479
    [<ffffffff8168cfa8>] inode_init_always+0x1f8/0x240 fs/inode.c:231
    [<ffffffff8168f996>] alloc_inode+0x46/0x110 fs/inode.c:267
    [<ffffffff8168fa87>] new_inode_pseudo fs/inode.c:1018 [inline]
    [<ffffffff8168fa87>] new_inode+0x27/0xf0 fs/inode.c:1046
    [<ffffffff8152b944>] shmem_get_inode+0xd4/0x560 mm/shmem.c:2370
    [<ffffffff8152bf12>] shmem_mknod+0x42/0x150 mm/shmem.c:2942
    [<ffffffff81676fd5>] lookup_open fs/namei.c:3492 [inline]
    [<ffffffff81676fd5>] open_last_lookups fs/namei.c:3560 [inline]
    [<ffffffff81676fd5>] path_openat+0x1725/0x1b10 fs/namei.c:3788
    [<ffffffff81679175>] do_filp_open+0xc5/0x1b0 fs/namei.c:3818
    [<ffffffff81653dbd>] do_sys_openat2+0xed/0x260 fs/open.c:1356
    [<ffffffff81654863>] do_sys_open fs/open.c:1372 [inline]
    [<ffffffff81654863>] __do_sys_openat fs/open.c:1388 [inline]
    [<ffffffff81654863>] __se_sys_openat fs/open.c:1383 [inline]
    [<ffffffff81654863>] __x64_sys_openat+0x83/0xe0 fs/open.c:1383
    [<ffffffff84a15749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a15749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810e027d80 (size 576):
  comm "syslogd", pid 4424, jiffies 4294939014 (age 1173.100s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 80 30 47 09 81 88 ff ff  .........0G.....
  backtrace:
    [<ffffffff84a0a6d6>] xas_alloc+0xf6/0x120 lib/xarray.c:377
    [<ffffffff84a0d10d>] xas_expand lib/xarray.c:584 [inline]
    [<ffffffff84a0d10d>] xas_create+0x13d/0x800 lib/xarray.c:655
    [<ffffffff84a0dbcb>] xas_store+0x7b/0xbd0 lib/xarray.c:789
    [<ffffffff8152ce89>] shmem_add_to_page_cache+0x2c9/0x500 mm/shmem.c:735
    [<ffffffff81530785>] shmem_get_folio_gfp+0x3a5/0xcf0 mm/shmem.c:1978
    [<ffffffff81531ba8>] shmem_get_folio mm/shmem.c:2079 [inline]
    [<ffffffff81531ba8>] shmem_write_begin+0x88/0x1a0 mm/shmem.c:2573
    [<ffffffff814eefb3>] generic_perform_write+0x103/0x2b0 mm/filemap.c:3923
    [<ffffffff814f3bd3>] __generic_file_write_iter+0x173/0x290 mm/filemap.c:4051
    [<ffffffff814f3d72>] generic_file_write_iter+0x82/0x160 mm/filemap.c:4083
    [<ffffffff81658e33>] call_write_iter include/linux/fs.h:1868 [inline]
    [<ffffffff81658e33>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff81658e33>] vfs_write+0x413/0x530 fs/read_write.c:584
    [<ffffffff81659191>] ksys_write+0xa1/0x160 fs/read_write.c:637
    [<ffffffff84a15749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a15749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888103efe280 (size 128):
  comm "syz-execprog", pid 5049, jiffies 4295044860 (age 114.650s)
  hex dump (first 32 bytes):
    f0 7b 88 0d 81 88 ff ff 70 7d 6e 81 ff ff ff ff  .{......p}n.....
    00 eb 6d 0a 81 88 ff ff 98 e2 ef 03 81 88 ff ff  ..m.............
  backtrace:
    [<ffffffff816ea897>] kmem_cache_zalloc include/linux/slab.h:670 [inline]
    [<ffffffff816ea897>] ep_insert fs/eventpoll.c:1504 [inline]
    [<ffffffff816ea897>] do_epoll_ctl+0x5c7/0x1220 fs/eventpoll.c:2223
    [<ffffffff816eb57a>] __do_sys_epoll_ctl fs/eventpoll.c:2280 [inline]
    [<ffffffff816eb57a>] __se_sys_epoll_ctl fs/eventpoll.c:2271 [inline]
    [<ffffffff816eb57a>] __x64_sys_epoll_ctl+0x8a/0xd0 fs/eventpoll.c:2271
    [<ffffffff84a15749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a15749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff8881052da600 (size 128):
  comm "syz-execprog", pid 5049, jiffies 4295044862 (age 114.630s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff812b4e5a>] alloc_pid+0x6a/0x550 kernel/pid.c:180
    [<ffffffff81277c3b>] copy_process+0x18fb/0x26c0 kernel/fork.c:2526
    [<ffffffff81278b87>] kernel_clone+0xf7/0x610 kernel/fork.c:2918
    [<ffffffff8127911c>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3061
    [<ffffffff84a15749>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84a15749>] do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



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
