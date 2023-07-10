Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2380274CEBD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjGJHmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjGJHmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:42:46 -0400
Received: from mail-pj1-f78.google.com (mail-pj1-f78.google.com [209.85.216.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21212E1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:42:45 -0700 (PDT)
Received: by mail-pj1-f78.google.com with SMTP id 98e67ed59e1d1-262cf62e9b4so7093454a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974964; x=1691566964;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYHyR0it/t9PAbQvImJLlqrZ8JkqGrdy2JASNux9z+w=;
        b=fyisabvH0W1bPcyLqHlYrpm9nkyNGnTOnC/XV7JOzX43f6xAUZcozVLQMI764rBhVM
         VIamuW6jCdAkCiZy9KyiLq5ex5fBTu1RtsNo7St/dBwSHt3fWuvFfKqQjPZa6zV0+gq/
         oCjjwv7G84C7qIsOx5sd6pIrwuWz0tNDxaqNJaEhPU/TIRYuqD8DRJec7Zgmk2DgtzqP
         zdsuPwxCJyuWbhDtHBtZtMNlD02A3sXHPpzRccs0EyLrRPDvl/BoqyJ0dpke5oWoGmzd
         Yjq72ixqE2k/Rmx0HMaCGkOZcUZElCPb/ptMD9diMNvfCJnYnfri3elS31VBdd8bHvmm
         mGvg==
X-Gm-Message-State: ABy/qLY9I6zWctK+e4Id8Io0QA8XzL77tdpQeyqNi2oR/mDRcDkVwhnn
        S1znj4kap/Mv37vYmknQlEB6KuqUqFgRfvA2IQlEXISYSjZk
X-Google-Smtp-Source: APBJJlHRHJaA56Fx6T9V9EJNh6ykKkpotNnVtVcvaK85qHxZHxIxf3wHJrDw6mVWtsTRw6rssUuFlPkxfTEh87kW5CX4l7IqLRTS
MIME-Version: 1.0
X-Received: by 2002:a17:90a:a785:b0:263:95f5:e163 with SMTP id
 f5-20020a17090aa78500b0026395f5e163mr10128031pjq.2.1688974964675; Mon, 10 Jul
 2023 00:42:44 -0700 (PDT)
Date:   Mon, 10 Jul 2023 00:42:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cde41a06001d20f8@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in move_to_new_folio
From:   syzbot <syzbot+009d9721acf40a64eab9@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    03275585cabd afs: Fix accidental truncation when storing d..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a74308a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=656155ea96f6ea1d
dashboard link: https://syzkaller.appspot.com/bug?extid=009d9721acf40a64eab9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-03275585.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d7fbd69351b6/vmlinux-03275585.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca0f98a100ed/bzImage-03275585.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+009d9721acf40a64eab9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in move_to_new_folio+0x64a/0x6e0 mm/migrate.c:957
Read of size 8 at addr ffff88803374aee8 by task kcompactd0/44

CPU: 1 PID: 44 Comm: kcompactd0 Not tainted 6.4.0-syzkaller-11472-g03275585cabd #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:364
 print_report mm/kasan/report.c:475 [inline]
 kasan_report+0x11d/0x130 mm/kasan/report.c:588
 move_to_new_folio+0x64a/0x6e0 mm/migrate.c:957
 migrate_folio_move mm/migrate.c:1272 [inline]
 migrate_pages_batch+0x1bcf/0x2cc0 mm/migrate.c:1757
 migrate_pages_sync mm/migrate.c:1823 [inline]
 migrate_pages+0x1962/0x2490 mm/migrate.c:1927
 compact_zone+0x18d1/0x3bc0 mm/compaction.c:2484
 proactive_compact_node+0x103/0x1b0 mm/compaction.c:2749
 kcompactd+0x837/0xcc0 mm/compaction.c:3069
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 4548:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slab.c:3237 [inline]
 slab_alloc mm/slab.c:3246 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3423 [inline]
 kmem_cache_alloc+0x14e/0x3f0 mm/slab.c:3432
 gfs2_glock_get+0x203/0x1320 fs/gfs2/glock.c:1167
 gfs2_inode_lookup+0x258/0x8a0 fs/gfs2/inode.c:135
 gfs2_dir_search+0x213/0x2d0 fs/gfs2/dir.c:1664
 gfs2_lookupi+0x481/0x640 fs/gfs2/inode.c:332
 gfs2_jindex_hold fs/gfs2/ops_fstype.c:608 [inline]
 init_journal fs/gfs2/ops_fstype.c:750 [inline]
 init_inodes+0x768/0x2b60 fs/gfs2/ops_fstype.c:885
 gfs2_fill_super+0x1a26/0x2aa0 fs/gfs2/ops_fstype.c:1248
 get_tree_bdev+0x43e/0x7d0 fs/super.c:1318
 gfs2_get_tree+0x4e/0x270 fs/gfs2/ops_fstype.c:1333
 vfs_get_tree+0x8d/0x350 fs/super.c:1519
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x136e/0x1e70 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x78/0x80 mm/kasan/generic.c:491
 __call_rcu_common.constprop.0+0x99/0x7e0 kernel/rcu/tree.c:2649
 gfs2_glock_free+0x6f3/0x10f0 fs/gfs2/glock.c:177
 gfs2_glock_put+0x33/0x40 fs/gfs2/glock.c:307
 gfs2_glock_put_eventually fs/gfs2/super.c:1278 [inline]
 gfs2_evict_inode+0x5cd/0x1c60 fs/gfs2/super.c:1560
 evict+0x2ed/0x6b0 fs/inode.c:665
 iput_final fs/inode.c:1789 [inline]
 iput.part.0+0x50a/0x740 fs/inode.c:1815
 iput+0x5c/0x80 fs/inode.c:1805
 gfs2_jindex_free+0x391/0x560 fs/gfs2/super.c:75
 init_journal fs/gfs2/ops_fstype.c:867 [inline]
 init_inodes+0x1202/0x2b60 fs/gfs2/ops_fstype.c:885
 gfs2_fill_super+0x1a26/0x2aa0 fs/gfs2/ops_fstype.c:1248
 get_tree_bdev+0x43e/0x7d0 fs/super.c:1318
 gfs2_get_tree+0x4e/0x270 fs/gfs2/ops_fstype.c:1333
 vfs_get_tree+0x8d/0x350 fs/super.c:1519
 do_new_mount fs/namespace.c:3335 [inline]
 path_mount+0x136e/0x1e70 fs/namespace.c:3662
 do_mount fs/namespace.c:3675 [inline]
 __do_sys_mount fs/namespace.c:3884 [inline]
 __se_sys_mount fs/namespace.c:3861 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3861
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0x78/0x80 mm/kasan/generic.c:491
 insert_work+0x48/0x360 kernel/workqueue.c:1553
 __queue_work+0x625/0x1120 kernel/workqueue.c:1714
 __queue_delayed_work+0x1c8/0x270 kernel/workqueue.c:1864
 queue_delayed_work_on+0x109/0x120 kernel/workqueue.c:1900
 queue_delayed_work include/linux/workqueue.h:521 [inline]
 __gfs2_glock_queue_work+0x2a/0xb0 fs/gfs2/glock.c:252
 gfs2_glock_queue_work fs/gfs2/glock.c:266 [inline]
 do_xmote+0x98b/0xd70 fs/gfs2/glock.c:801
 run_queue+0x3cf/0x660 fs/gfs2/glock.c:844
 glock_work_func+0xc2/0x3b0 fs/gfs2/glock.c:1076
 process_one_work+0xa34/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2748
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff88803374aa90
 which belongs to the cache gfs2_glock(aspace) of size 1224
The buggy address is located 1112 bytes inside of
 freed 1224-byte region [ffff88803374aa90, ffff88803374af58)

The buggy address belongs to the physical page:
page:ffffea0000cdd280 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88803374affd pfn:0x3374a
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0x1()
raw: 00fff00000000200 ffff888105198800 ffffea0000ba3050 ffffea0000cba510
raw: ffff88803374affd ffff88803374a000 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x342040(__GFP_IO|__GFP_NOWARN|__GFP_COMP|__GFP_HARDWALL|__GFP_THISNODE), pid 4244, tgid 4243 (syz-executor.2), ts 2200319898346, free_ts 2200315160610
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0xfed/0x2d30 mm/page_alloc.c:3221
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4477
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 kmem_getpages mm/slab.c:1356 [inline]
 cache_grow_begin+0x9b/0x3b0 mm/slab.c:2550
 cache_alloc_refill+0x289/0x3a0 mm/slab.c:2923
 ____cache_alloc mm/slab.c:2999 [inline]
 ____cache_alloc mm/slab.c:2982 [inline]
 __do_cache_alloc mm/slab.c:3182 [inline]
 slab_alloc_node mm/slab.c:3230 [inline]
 slab_alloc mm/slab.c:3246 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3423 [inline]
 kmem_cache_alloc+0x397/0x3f0 mm/slab.c:3432
 gfs2_glock_get+0x203/0x1320 fs/gfs2/glock.c:1167
 gfs2_inode_lookup+0x258/0x8a0 fs/gfs2/inode.c:135
 gfs2_dir_search+0x213/0x2d0 fs/gfs2/dir.c:1664
 gfs2_lookupi+0x481/0x640 fs/gfs2/inode.c:332
 gfs2_lookup_simple+0x9d/0xe0 fs/gfs2/inode.c:273
 init_inodes+0x129e/0x2b60 fs/gfs2/ops_fstype.c:891
 gfs2_fill_super+0x1a26/0x2aa0 fs/gfs2/ops_fstype.c:1248
 get_tree_bdev+0x43e/0x7d0 fs/super.c:1318
 gfs2_get_tree+0x4e/0x270 fs/gfs2/ops_fstype.c:1333
 vfs_get_tree+0x8d/0x350 fs/super.c:1519
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1161 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2348
 free_unref_page_list+0xe3/0xa70 mm/page_alloc.c:2489
 release_pages+0xcd8/0x1380 mm/swap.c:1042
 __folio_batch_release+0x77/0xe0 mm/swap.c:1062
 folio_batch_release include/linux/pagevec.h:83 [inline]
 truncate_inode_pages_range+0x2ec/0xf10 mm/truncate.c:372
 inode_go_inval+0x385/0x420 fs/gfs2/glops.c:380
 do_xmote+0x73d/0xd70 fs/gfs2/glock.c:733
 run_queue+0x3cf/0x660 fs/gfs2/glock.c:844
 glock_work_func+0xc2/0x3b0 fs/gfs2/glock.c:1076
 process_one_work+0xa34/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2748
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff88803374ad80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88803374ae00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88803374ae80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88803374af00: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
 ffff88803374af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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
