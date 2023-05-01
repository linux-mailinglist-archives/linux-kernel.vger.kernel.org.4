Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0754C6F30CD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 14:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjEAMRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 08:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjEAMRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 08:17:06 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDE1172C
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 05:16:38 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-76353eb51acso363141439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 05:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682943397; x=1685535397;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hp9usz4v8y7HYTY6MaChD/r9nuXp/yFsxFwdNrK5PNo=;
        b=SYgaZ//8wppasKmF9cm2jE8OyEEUQD6gignUkFyJvFC1ZZVFyFpySfgnKdbjPLNH0R
         C7S9nTRN0bqYzh3nPh4O9W68WYAyAaDV0yRhvWBaNOPYQnGumxKvjO+sUwt1lmN+7eLp
         DGQC0Zy/Q8r5i/q94zZvpEfPqgIMdVup8As4aRp9yrT+4uv+Gxm2SegsEI3IU4AiGa17
         5m6dzxU7B5pZDTttrqWpDoAwUSLpiArw0oUyYEmW6FvbTZt2q66YK/j5v2BFIc6PpPwg
         5DJT5uaLiGJaJ4I7vECK4TItl4JbLSfWuZwK4RY+/bBq7Wj3UPgdyT2i9natLIawMlLC
         bRSw==
X-Gm-Message-State: AC+VfDwOJWS9JsYvquC/k6o3oTbwuEEJSrYD+j0nci18cXh4BZ4yvOHs
        PFDGGsHpZhu53JUh2UWmCaTSjY5j7tr/FywW4jNAqeQvFQ6U
X-Google-Smtp-Source: ACHHUZ6OdfnUInoCC66LRMnNQdrc125vnmH1/rC+/w+BeCyK4x32u1VIMkIPKi1PKj7RDK31qFM0LHCeHXkkTvnB1j68PJdpGduc
MIME-Version: 1.0
X-Received: by 2002:a5d:854c:0:b0:759:25eb:210d with SMTP id
 b12-20020a5d854c000000b0075925eb210dmr6121707ios.0.1682943397404; Mon, 01 May
 2023 05:16:37 -0700 (PDT)
Date:   Mon, 01 May 2023 05:16:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000612d5a05faa0cb50@google.com>
Subject: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer
 dereference in tty_write_room
From:   syzbot <syzbot+4e24c3e417773c914ee4@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    58390c8ce1bd Merge tag 'iommu-updates-v6.4' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14940678280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
dashboard link: https://syzkaller.appspot.com/bug?extid=4e24c3e417773c914ee4
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=156158c8280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2386db8aa870/disk-58390c8c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/32326e242a13/vmlinux-58390c8c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fe1f90f3d186/bzImage-58390c8c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4e24c3e417773c914ee4@syzkaller.appspotmail.com

ieee802154 phy0 wpan0: encryption failed: -22
ieee802154 phy1 wpan1: encryption failed: -22
==================================================================
BUG: KASAN: slab-use-after-free in tty_write_room+0x35/0x80 drivers/tty/tty_ioctl.c:80
Read of size 8 at addr ffff88807eb7d018 by task aoe_tx0/1216

CPU: 0 PID: 1216 Comm: aoe_tx0 Not tainted 6.3.0-syzkaller-12049-g58390c8ce1bd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:462
 kasan_report+0x176/0x1b0 mm/kasan/report.c:572
 tty_write_room+0x35/0x80 drivers/tty/tty_ioctl.c:80
 handle_tx+0x164/0x620 drivers/net/caif/caif_serial.c:226
 __netdev_start_xmit include/linux/netdevice.h:4915 [inline]
 netdev_start_xmit include/linux/netdevice.h:4929 [inline]
 xmit_one net/core/dev.c:3578 [inline]
 dev_hard_start_xmit+0x241/0x750 net/core/dev.c:3594
 __dev_queue_xmit+0x19b9/0x38b0 net/core/dev.c:4244
 dev_queue_xmit include/linux/netdevice.h:3085 [inline]
 tx+0x6a/0x110 drivers/block/aoe/aoenet.c:63
 kthread+0x238/0x440 drivers/block/aoe/aoecmd.c:1229
 kthread+0x2b8/0x350 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 5196:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 alloc_tty_struct+0xa9/0x7a0 drivers/tty/tty_io.c:3090
 tty_init_dev+0x5b/0x4b0 drivers/tty/tty_io.c:1408
 ptmx_open+0xda/0x2b0 drivers/tty/pty.c:824
 chrdev_open+0x54e/0x630 fs/char_dev.c:414
 do_dentry_open+0x7f9/0x10f0 fs/open.c:920
 do_open fs/namei.c:3636 [inline]
 path_openat+0x27b3/0x3170 fs/namei.c:3791
 do_filp_open+0x234/0x490 fs/namei.c:3818
 do_sys_openat2+0x13f/0x500 fs/open.c:1356
 do_sys_open fs/open.c:1372 [inline]
 __do_sys_openat fs/open.c:1388 [inline]
 __se_sys_openat fs/open.c:1383 [inline]
 __x64_sys_openat+0x247/0x290 fs/open.c:1383
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5079:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook mm/slub.c:1807 [inline]
 slab_free mm/slub.c:3786 [inline]
 __kmem_cache_free+0x264/0x3c0 mm/slub.c:3799
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2405
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2552
 kthread+0x2b8/0x350 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Last potentially related work creation:
 kasan_save_stack+0x3f/0x60 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb0/0xc0 mm/kasan/generic.c:491
 insert_work+0x54/0x3d0 kernel/workqueue.c:1365
 __queue_work+0xb37/0xf10 kernel/workqueue.c:1526
 queue_work_on+0x14f/0x250 kernel/workqueue.c:1554
 tty_release_struct+0xbc/0xe0 drivers/tty/tty_io.c:1700
 tty_release+0xcff/0x12b0 drivers/tty/tty_io.c:1860
 __fput+0x3b7/0x890 fs/file_table.c:321
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xd9/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88807eb7d000
 which belongs to the cache kmalloc-cg-2k of size 2048
The buggy address is located 24 bytes inside of
 freed 2048-byte region [ffff88807eb7d000, ffff88807eb7d800)

The buggy address belongs to the physical page:
page:ffffea0001fade00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7eb78
head:ffffea0001fade00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88802c081481
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff88801244f3c0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000080008 00000001ffffffff ffff88802c081481
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5194, tgid 5193 (syz-executor.0), ts 131832049084, free_ts 131262644214
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x1e6/0x210 mm/page_alloc.c:1722
 prep_new_page mm/page_alloc.c:1729 [inline]
 get_page_from_freelist+0x321c/0x33a0 mm/page_alloc.c:3493
 __alloc_pages+0x255/0x670 mm/page_alloc.c:4759
 alloc_slab_page+0x6a/0x160 mm/slub.c:1851
 allocate_slab mm/slub.c:1998 [inline]
 new_slab+0x84/0x2f0 mm/slub.c:2051
 ___slab_alloc+0xa85/0x10a0 mm/slub.c:3192
 __slab_alloc mm/slub.c:3291 [inline]
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 __kmem_cache_alloc_node+0x1b8/0x290 mm/slub.c:3490
 __do_kmalloc_node mm/slab_common.c:965 [inline]
 __kmalloc_node_track_caller+0xa5/0x230 mm/slab_common.c:986
 kmemdup+0x2a/0x60 mm/util.c:131
 neigh_sysctl_register+0xb4/0x4d0 net/core/neighbour.c:3783
 devinet_sysctl_register+0x9d/0x1a0 net/ipv4/devinet.c:2627
 inetdev_init+0x291/0x4c0 net/ipv4/devinet.c:286
 inetdev_event+0x342/0x1580 net/ipv4/devinet.c:1538
 notifier_call_chain+0x18c/0x3a0 kernel/notifier.c:93
 call_netdevice_notifiers_info net/core/dev.c:1935 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:1973 [inline]
 call_netdevice_notifiers+0x149/0x1c0 net/core/dev.c:1987
 register_netdevice+0x1349/0x1790 net/core/dev.c:10118
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x903/0xa30 mm/page_alloc.c:2555
 free_unref_page+0x37/0x3f0 mm/page_alloc.c:2650
 discard_slab mm/slub.c:2097 [inline]
 __unfreeze_partials+0x1b1/0x1f0 mm/slub.c:2636
 put_cpu_partial+0x116/0x180 mm/slub.c:2712
 qlist_free_all+0x22/0x60 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x14b/0x160 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x23/0x70 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook+0x68/0x3a0 mm/slab.h:711
 slab_alloc_node mm/slub.c:3451 [inline]
 __kmem_cache_alloc_node+0x14c/0x290 mm/slub.c:3490
 __do_kmalloc_node mm/slab_common.c:965 [inline]
 __kmalloc_node+0xa7/0x230 mm/slab_common.c:973
 kmalloc_node include/linux/slab.h:579 [inline]
 kvmalloc_node+0x72/0x180 mm/util.c:604
 kvmalloc include/linux/slab.h:697 [inline]
 kvzalloc include/linux/slab.h:705 [inline]
 bucket_table_alloc lib/rhashtable.c:184 [inline]
 rhashtable_rehash_alloc+0x9e/0x280 lib/rhashtable.c:363
 rht_deferred_worker+0x491/0x2080 lib/rhashtable.c:423
 process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2405
 worker_thread+0xa63/0x1210 kernel/workqueue.c:2552
 kthread+0x2b8/0x350 kernel/kthread.c:379

Memory state around the buggy address:
 ffff88807eb7cf00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807eb7cf80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88807eb7d000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88807eb7d080: fb fb fb f


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
