Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBD45FAEA3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJKIor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJKIon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:44:43 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414CAD43
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 01:44:37 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id j8-20020a056e02154800b002fc89e9ebeeso624218ilu.16
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 01:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hBEtGeKtcCelNZVlvp6tEpKNUuHHbyga0BY4qs7ORjY=;
        b=pL33U3nOLh3sLyOYDhvv6Sn95bdxsPw7Ehia2POONvNPYqdhmTaSuVQXx55vQj1Oy5
         LkhlZSPQR/ux8OdWUQhqoshunDS4bD4ZUZ+PNex2l0bp/WutqoFalD2ZHeOLHQU562kt
         k6r5UBS26NwkvW8g+TmQr+0iwzgz/BFaxEt91czUOxLZhCShkvGqOhfSoOQl88faJD72
         EYS/1DyNA3lzMyTsL38XXumRih0PGhAPr3jZz5mknimIvVNeTbMTQX+cHN6B8icpgGT5
         /4eqs1xZ6ZupbTA56vPA4J8xIt5BSgCDBnIkabVYoWq2xsJKZKhnWZ7qZKSV+u4PQ1Pq
         WRGQ==
X-Gm-Message-State: ACrzQf074VCtprbkEV6ExDBLOuoWr+VVLubow4JVxmZZ1klIwJl9rE2G
        K34mT6JdNOm68Y0lWUif7bE5x/l58y8HV1alpMEIejFf5IUI
X-Google-Smtp-Source: AMsMyM57yquYgeLyPfUH8+QkbA/aoJbmgDnTIRyMa+6UTahIUr34rTstHspCAli7qB5e8iwqNtK/NNrQsW0Zd21CboP7kewQN4KM
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1919:b0:363:b88d:e02b with SMTP id
 p25-20020a056638191900b00363b88de02bmr5130645jal.154.1665477876625; Tue, 11
 Oct 2022 01:44:36 -0700 (PDT)
Date:   Tue, 11 Oct 2022 01:44:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037b96205eabe49b5@google.com>
Subject: [syzbot] KASAN: use-after-free Read in move_expired_inodes (2)
From:   syzbot <syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com>
To:     hirofumi@mail.parknet.co.jp, linux-kernel@vger.kernel.org,
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

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17449852880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=6ba92bd00d5093f7e371
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1724028a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17419234880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/770c6ffb625c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6ba92bd00d5093f7e371@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in inode_dirtied_after fs/fs-writeback.c:1335 [inline]
BUG: KASAN: use-after-free in move_expired_inodes+0x186/0x8e0 fs/fs-writeback.c:1367
Read of size 8 at addr ffff8880720e15a8 by task kworker/u4:1/12

CPU: 1 PID: 12 Comm: kworker/u4:1 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Workqueue: writeback wb_workfn (flush-7:0)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:317
 print_report+0x108/0x1f0 mm/kasan/report.c:433
 kasan_report+0xc3/0xf0 mm/kasan/report.c:495
 inode_dirtied_after fs/fs-writeback.c:1335 [inline]
 move_expired_inodes+0x186/0x8e0 fs/fs-writeback.c:1367
 queue_io+0x250/0x400 fs/fs-writeback.c:1427
 wb_writeback+0x3d3/0x7b0 fs/fs-writeback.c:2042
 wb_do_writeback fs/fs-writeback.c:2187 [inline]
 wb_workfn+0x3cb/0xef0 fs/fs-writeback.c:2227
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Allocated by task 3608:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 __kasan_slab_alloc+0xa3/0xd0 mm/kasan/common.c:470
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3248 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
 kmem_cache_alloc_lru+0x175/0x2d0 mm/slub.c:3280
 alloc_inode_sb include/linux/fs.h:3107 [inline]
 fat_alloc_inode+0x25/0xc0 fs/fat/inode.c:750
 alloc_inode fs/inode.c:259 [inline]
 new_inode_pseudo+0x61/0x1d0 fs/inode.c:1018
 new_inode+0x25/0x1d0 fs/inode.c:1046
 fat_build_inode+0x1e8/0x3e0 fs/fat/inode.c:603
 vfat_create+0x240/0x3a0 fs/fat/namei_vfat.c:776
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12d0/0x2df0 fs/namei.c:3688
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 0:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:45
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free+0xd8/0x120 mm/kasan/common.c:367
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1759 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1785
 slab_free mm/slub.c:3539 [inline]
 kmem_cache_free+0x95/0x1d0 mm/slub.c:3556
 rcu_do_batch kernel/rcu/tree.c:2248 [inline]
 rcu_core+0x981/0x1610 kernel/rcu/tree.c:2508
 __do_softirq+0x277/0x738 kernel/softirq.c:571

Last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xaf/0xc0 mm/kasan/generic.c:348
 call_rcu+0x163/0x970 kernel/rcu/tree.c:2796
 __dentry_kill+0x3b1/0x5b0 fs/dcache.c:607
 dentry_kill+0xbb/0x290
 dput+0x1f3/0x410 fs/dcache.c:913
 __fput+0x5e4/0x880 fs/file_table.c:328
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 ptrace_notify+0x29a/0x340 kernel/signal.c:2354
 ptrace_report_syscall include/linux/ptrace.h:420 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:482 [inline]
 syscall_exit_work+0x8c/0xe0 kernel/entry/common.c:249
 syscall_exit_to_user_mode_prepare+0x63/0xc0 kernel/entry/common.c:276
 __syscall_exit_to_user_mode_work kernel/entry/common.c:281 [inline]
 syscall_exit_to_user_mode+0xa/0x60 kernel/entry/common.c:294
 do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880720e12f0
 which belongs to the cache fat_inode_cache of size 1488
The buggy address is located 696 bytes inside of
 1488-byte region [ffff8880720e12f0, ffff8880720e18c0)

The buggy address belongs to the physical page:
page:ffffea0001c83800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x720e0
head:ffffea0001c83800 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888146460140
raw: 0000000000000000 0000000080140014 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE), pid 3608, tgid 3608 (syz-executor144), ts 35396569179, free_ts 10664127500
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 alloc_slab_page+0x70/0xf0 mm/slub.c:1829
 allocate_slab+0x5e/0x520 mm/slub.c:1974
 new_slab mm/slub.c:2034 [inline]
 ___slab_alloc+0x3ee/0xc40 mm/slub.c:3036
 __slab_alloc mm/slub.c:3123 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
 kmem_cache_alloc_lru+0x225/0x2d0 mm/slub.c:3280
 alloc_inode_sb include/linux/fs.h:3107 [inline]
 fat_alloc_inode+0x25/0xc0 fs/fat/inode.c:750
 alloc_inode fs/inode.c:259 [inline]
 new_inode_pseudo+0x61/0x1d0 fs/inode.c:1018
 new_inode+0x25/0x1d0 fs/inode.c:1046
 fat_fill_super+0x3278/0x4b00 fs/fat/inode.c:1847
 mount_bdev+0x26c/0x3a0 fs/super.c:1400
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3476
 free_contig_range+0xa3/0x160 mm/page_alloc.c:9457
 destroy_args+0xfe/0x91d mm/debug_vm_pgtable.c:1031
 debug_vm_pgtable+0x43e/0x497 mm/debug_vm_pgtable.c:1354
 do_one_initcall+0x1c9/0x400 init/main.c:1296
 do_initcall_level+0x168/0x218 init/main.c:1369
 do_initcalls+0x4b/0x8c init/main.c:1385
 kernel_init_freeable+0x3f1/0x57b init/main.c:1623
 kernel_init+0x19/0x2b0 init/main.c:1512
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffff8880720e1480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880720e1500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880720e1580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                  ^
 ffff8880720e1600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880720e1680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
