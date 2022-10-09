Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313B45F8DC1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 21:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiJITpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 15:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiJITpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 15:45:40 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BE524095
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 12:45:39 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id n23-20020a056602341700b00689fc6dbfd6so6180445ioz.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 12:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NY6J7+ZoQ9YNPze9LvjYb45sHpSqAMG1TVEjteO01O8=;
        b=CViNfai33x7lB5DIRG4pR5/tAkeQHvyzIP8mwHi2Y1QzLFPp7kewTtQvgsvdb6fF2v
         qGZ+OpK3mUKBPnLf28mdhdXLs3rAKX1qOZ63TwR0RLZmQ4L7TDEk/O+it5U3l6hvh645
         9+DxwwOM1I//ySBTMNBgSuGPlL93JtoIerPzmxA0mSsex5qVEgIlXlpZPg17evSbSgNA
         exCFPZ8e6lUD482Y3a8zBjlemVvrcWoLOuJEbM5Zwwzl3tPMmiVqhtlu1wR3OL4hPpEG
         g1dKhtYONj3R0mImq/Srgl1IOrcsmYgm+YGVsfR0kmqnxpzYnCNWCDVhfDwqim8aqCbx
         yArA==
X-Gm-Message-State: ACrzQf1ZHAqlxWhadn64M0Nq69D1Vdjwv3LBpjr3bl2lfJJ9FCTDakNP
        i9ny020K/YLmUfMEV7SFjA35/hTjYp1k5/aBqJg3SOmpwEAU
X-Google-Smtp-Source: AMsMyM4N69PbUaKkPHJGc/0lM5xC6XAuZKCzF1DpacUob+thIjGhxOqPnsEMf+7nCe7WaM40VSvuWGa0eVH6ruXaoV4vevhdop26
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2510:b0:363:af16:bfcf with SMTP id
 v16-20020a056638251000b00363af16bfcfmr2278878jat.263.1665344738200; Sun, 09
 Oct 2022 12:45:38 -0700 (PDT)
Date:   Sun, 09 Oct 2022 12:45:38 -0700
In-Reply-To: <0000000000006a789905e9a67167@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c976e05ea9f491d@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in register_shrinker_prepared (2)
From:   syzbot <syzbot+ff796f04613b4c84ad89@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a6afa4199d3d Merge tag 'mailbox-v6.1' of git://git.linaro...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1796508a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2021a61197ebe02
dashboard link: https://syzkaller.appspot.com/bug?extid=ff796f04613b4c84ad89
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105ee158880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a7ea78880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4ab7841430f9/disk-a6afa419.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/85d7d196fbe9/vmlinux-a6afa419.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff796f04613b4c84ad89@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0xa5/0xb0 lib/list_debug.c:30
Read of size 8 at addr ffff8880262715c8 by task syz-executor161/5975

CPU: 0 PID: 5975 Comm: syz-executor161 Not tainted 6.0.0-syzkaller-09039-ga6afa4199d3d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 __list_add_valid+0xa5/0xb0 lib/list_debug.c:30
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 register_shrinker_prepared+0x37/0x120 mm/vmscan.c:684
 sget_fc+0x5e7/0x7c0 fs/super.c:581
 vfs_get_super fs/super.c:1163 [inline]
 get_tree_nodev+0x24/0x1d0 fs/super.c:1198
 mqueue_get_tree+0xee/0x130 ipc/mqueue.c:435
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 fc_mount+0x13/0xc0 fs/namespace.c:1043
 mq_create_mount ipc/mqueue.c:485 [inline]
 mq_init_ns+0x43e/0x630 ipc/mqueue.c:1701
 create_ipc_ns ipc/namespace.c:58 [inline]
 copy_ipcs+0x35e/0x5e0 ipc/namespace.c:94
 create_new_namespaces+0x210/0xb20 kernel/nsproxy.c:90
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x445/0x920 kernel/fork.c:3181
 __do_sys_unshare kernel/fork.c:3252 [inline]
 __se_sys_unshare kernel/fork.c:3250 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3250
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f878917a909
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f878912c318 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f87892023e8 RCX: 00007f878917a909
RDX: 00007f878912c700 RSI: 8c53bf579e072fbf RDI: 000000006c060000
RBP: 00007f87892023e0 R08: 00007f878912c700 R09: 0000000000000000
R10: 00007f878912c700 R11: 0000000000000246 R12: 00007f87892023ec
R13: 00007ffe4e8905ff R14: 00007f878912c400 R15: 0000000000022000
 </TASK>

Allocated by task 5969:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc mm/kasan/common.c:516 [inline]
 ____kasan_kmalloc mm/kasan/common.c:475 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
 kmalloc include/linux/slab.h:605 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 ops_init+0xfb/0x470 net/core/net_namespace.c:124
 setup_net+0x5d1/0xc50 net/core/net_namespace.c:325
 copy_net_ns+0x318/0x760 net/core/net_namespace.c:471
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x445/0x920 kernel/fork.c:3181
 __do_sys_unshare kernel/fork.c:3252 [inline]
 __se_sys_unshare kernel/fork.c:3250 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3250
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5969:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:367 [inline]
 ____kasan_slab_free+0x166/0x1c0 mm/kasan/common.c:329
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1759 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1785
 slab_free mm/slub.c:3539 [inline]
 kfree+0xe2/0x580 mm/slub.c:4567
 ops_init+0xcd/0x470 net/core/net_namespace.c:139
 setup_net+0x5d1/0xc50 net/core/net_namespace.c:325
 copy_net_ns+0x318/0x760 net/core/net_namespace.c:471
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x445/0x920 kernel/fork.c:3181
 __do_sys_unshare kernel/fork.c:3252 [inline]
 __se_sys_unshare kernel/fork.c:3250 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3250
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 insert_work+0x48/0x350 kernel/workqueue.c:1358
 __queue_work+0x625/0x1200 kernel/workqueue.c:1517
 queue_work_on+0xee/0x110 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 afs_queue_server_manager fs/afs/server.c:612 [inline]
 afs_purge_servers+0xea/0x340 fs/afs/server.c:626
 afs_net_exit+0x16d/0x320 fs/afs/main.c:157
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:162
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:594
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 insert_work+0x48/0x350 kernel/workqueue.c:1358
 __queue_work+0x625/0x1200 kernel/workqueue.c:1517
 queue_work_on+0xee/0x110 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 afs_queue_cell_manager+0x64/0xe0 fs/afs/cell.c:520
 afs_cell_purge+0x105/0x2b0 fs/afs/cell.c:946
 afs_net_exit+0x165/0x320 fs/afs/main.c:156
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:162
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:594
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff888026271000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1480 bytes inside of
 2048-byte region [ffff888026271000, ffff888026271800)

The buggy address belongs to the physical page:
page:ffffea0000989c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x26270
head:ffffea0000989c00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0001c6ba00 dead000000000002 ffff888011842000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3757, tgid 3755 (syz-executor161), ts 54893932773, free_ts 54834561262
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5549
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:1829 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1974
 new_slab mm/slub.c:2034 [inline]
 ___slab_alloc+0x84f/0xe80 mm/slub.c:3036
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3123
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmalloc+0x32b/0x340 mm/slub.c:4425
 kmalloc include/linux/slab.h:605 [inline]
 sk_prot_alloc+0x143/0x290 net/core/sock.c:2030
 sk_alloc+0x36/0x770 net/core/sock.c:2083
 __netlink_create+0x63/0x380 net/netlink/af_netlink.c:647
 __netlink_kernel_create+0x110/0x850 net/netlink/af_netlink.c:2045
 netlink_kernel_create include/linux/netlink.h:62 [inline]
 genl_pernet_init+0xa9/0x140 net/netlink/genetlink.c:1433
 ops_init+0xaf/0x470 net/core/net_namespace.c:134
 setup_net+0x5d1/0xc50 net/core/net_namespace.c:325
 copy_net_ns+0x318/0x760 net/core/net_namespace.c:471
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3476
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2553
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3248 [inline]
 kmem_cache_alloc_node+0x2b1/0x3f0 mm/slub.c:3298
 alloc_task_struct_node kernel/fork.c:172 [inline]
 dup_task_struct kernel/fork.c:969 [inline]
 copy_process+0x5c2/0x7090 kernel/fork.c:2085
 kernel_clone+0xe7/0xab0 kernel/fork.c:2671
 __do_sys_clone+0xba/0x100 kernel/fork.c:2805
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888026271480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888026271500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888026271580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff888026271600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888026271680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

