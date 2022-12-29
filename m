Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C31658AD1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 10:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiL2JQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 04:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiL2JPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 04:15:48 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6D0CEF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:15:46 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id x8-20020a056e021ca800b0030c075dc55dso5308485ill.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 01:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SvwkSZilI5co9gDjUjofEghtJYB0KnJtl9xawM3dSOk=;
        b=t1f/mGrG6o3e6BWLGfjUmpWdk1ySYWRQSjM6u2NpIr/8FOL9yxzjTcebv5lLgmpmfR
         PMozXFYgQLYUxgRCmDL3fna1B2kE6cTgqeMpJYW/p1YVV/f1VTe52FwjAvYKVwTa5T7g
         UgmU883ZSeur9mMCQzbsLQ9xUUH2iTqzHBbjZNZqkieX7XeARlA26X88Q9IGiR+uF82n
         4CZaJz+F95luCkPKcfcT2HHSYd1fxer7lFvar7b7727nNqOOumUWBcdskwHQKvWuy8qg
         iZT551rXfSA31aAtvllPX8kcKR2lFQQ7A1uU+WbM0WAWptPNrXecUoh79pjvrNBofbG6
         3Azg==
X-Gm-Message-State: AFqh2koX6NjZL/eeq9GRqtwcJFgjJrBAgUP6ClzDKvpMGEs4M76WydvA
        5sy2ytSno2o9C4BbYg3Wg3vN/zRkwbknmCyJnWXNUwgnxbx0
X-Google-Smtp-Source: AMrXdXuksufhHhrldjrRKng8lFCcZBnVO4toj84uVGCODGs3JuKoXZ66IKRo9g41GW/X8jdchfY2XTSwE7id3dYWIYcc0lgHu413
MIME-Version: 1.0
X-Received: by 2002:a02:5b0a:0:b0:38a:70d0:5264 with SMTP id
 g10-20020a025b0a000000b0038a70d05264mr2464584jab.11.1672305346126; Thu, 29
 Dec 2022 01:15:46 -0800 (PST)
Date:   Thu, 29 Dec 2022 01:15:46 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ca8c205f0f3ee00@google.com>
Subject: [syzbot] [xfs?] KASAN: use-after-free Read in xfs_btree_lookup_get_block
From:   syzbot <syzbot+7e9494b8b399902e994e@syzkaller.appspotmail.com>
To:     dchinner@redhat.com, djwong@kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
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

HEAD commit:    1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=105a88b0480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=7e9494b8b399902e994e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172ff2e4480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11715ea8480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d8c5072480f/disk-1b929c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46687f1395db/vmlinux-1b929c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26f1afa5ec00/bzImage-1b929c02.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/eadafd7a22a3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7e9494b8b399902e994e@syzkaller.appspotmail.com

XFS (loop0): Mounting V5 Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791
XFS (loop0): Torn write (CRC failure) detected at log block 0x180. Truncating head block from 0x200.
XFS (loop0): Starting recovery (logdev: internal)
==================================================================
BUG: KASAN: slab-out-of-bounds in xfs_btree_lookup_get_block+0x15c/0x6d0 fs/xfs/libxfs/xfs_btree.c:1813
Read of size 8 at addr ffff88807e89f258 by task syz-executor132/5074

CPU: 0 PID: 5074 Comm: syz-executor132 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:306
 print_report+0x107/0x1f0 mm/kasan/report.c:417
 kasan_report+0xcd/0x100 mm/kasan/report.c:517
 xfs_btree_lookup_get_block+0x15c/0x6d0 fs/xfs/libxfs/xfs_btree.c:1813
 xfs_btree_lookup+0x346/0x12c0 fs/xfs/libxfs/xfs_btree.c:1913
 xfs_btree_simple_query_range+0xde/0x6a0 fs/xfs/libxfs/xfs_btree.c:4713
 xfs_btree_query_range+0x2db/0x380 fs/xfs/libxfs/xfs_btree.c:4953
 xfs_refcount_recover_cow_leftovers+0x2d1/0xa60 fs/xfs/libxfs/xfs_refcount.c:1946
 xfs_reflink_recover_cow+0xab/0x1b0 fs/xfs/xfs_reflink.c:930
 xlog_recover_finish+0x824/0x920 fs/xfs/xfs_log_recover.c:3493
 xfs_log_mount_finish+0x1ec/0x3d0 fs/xfs/xfs_log.c:829
 xfs_mountfs+0x146a/0x1ef0 fs/xfs/xfs_mount.c:933
 xfs_fs_fill_super+0xf95/0x11f0 fs/xfs/xfs_super.c:1666
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f89fa3f4aca
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd5fb5ef8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00646975756f6e2c RCX: 00007f89fa3f4aca
RDX: 0000000020000100 RSI: 0000000020009640 RDI: 00007fffd5fb5f10
RBP: 00007fffd5fb5f10 R08: 00007fffd5fb5f50 R09: 000000000000970d
R10: 0000000000200800 R11: 0000000000000206 R12: 0000000000000004
R13: 0000555556c6b2c0 R14: 0000000000200800 R15: 00007fffd5fb5f50
 </TASK>

The buggy address belongs to the object at ffff88807e89f210
 which belongs to the cache xfs_refcbt_cur of size 200
The buggy address is located 72 bytes inside of
 200-byte region [ffff88807e89f210, ffff88807e89f2d8)

The buggy address belongs to the physical page:
page:ffffea0001fa27c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7e89f
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff88801aa88dc0 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800f000f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c40(GFP_NOFS|__GFP_NOWARN|__GFP_NORETRY), pid 5074, tgid 5074 (syz-executor132), ts 52983376728, free_ts 44253031630
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 alloc_slab_page+0xbd/0x190 mm/slub.c:1851
 allocate_slab+0x5e/0x3c0 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3193
 __slab_alloc mm/slub.c:3292 [inline]
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x268/0x350 mm/slub.c:3476
 kmem_cache_zalloc include/linux/slab.h:710 [inline]
 xfs_btree_alloc_cursor fs/xfs/libxfs/xfs_btree.h:592 [inline]
 xfs_refcountbt_init_common fs/xfs/libxfs/xfs_refcount_btree.c:336 [inline]
 xfs_refcountbt_init_cursor+0x84/0x330 fs/xfs/libxfs/xfs_refcount_btree.c:363
 xfs_refcount_recover_cow_leftovers+0x213/0xa60 fs/xfs/libxfs/xfs_refcount.c:1939
 xfs_reflink_recover_cow+0xab/0x1b0 fs/xfs/xfs_reflink.c:930
 xlog_recover_finish+0x824/0x920 fs/xfs/xfs_log_recover.c:3493
 xfs_log_mount_finish+0x1ec/0x3d0 fs/xfs/xfs_log.c:829
 xfs_mountfs+0x146a/0x1ef0 fs/xfs/xfs_mount.c:933
 xfs_fs_fill_super+0xf95/0x11f0 fs/xfs/xfs_super.c:1666
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x751/0x780 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page+0x19/0x4c0 mm/page_alloc.c:3464
 pipe_buf_release include/linux/pipe_fs_i.h:183 [inline]
 pipe_read+0x718/0x1340 fs/pipe.c:324
 call_read_iter include/linux/fs.h:2180 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7ac/0xbf0 fs/read_write.c:470
 ksys_read+0x177/0x2a0 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807e89f100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807e89f180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807e89f200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                    ^
 ffff88807e89f280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807e89f300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
