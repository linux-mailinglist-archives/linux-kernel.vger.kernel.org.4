Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C135F79A7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJGOVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJGOVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:21:44 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7558BE2CB
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 07:21:43 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id j20-20020a6b3114000000b006a3211a0ff0so3267563ioa.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 07:21:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=frvybTJNui5FAH0831/mOJhUNVx4u0DmjWVnH7ERIFw=;
        b=2bA4DrEHQgKAMwUkoWYKNDFm7kGhojR1yN0GJcYi4uqgorLmdJ77wsiEpABuLZGRDt
         1QTF6EVlrMDgHeJEzgfM9uVNfDT5oaGIK9UtThlYN09uwmRokCf+YuRStpfYZDDC8aRP
         VRAWAlBBPAgkFYWNjmnDaaUys+Uvpy7I4daOlhsjaYiP+n19yJ9dmHVeLAdydCPLjj/V
         uX9cudx7NSz62eS2vu7Ws4NCY1eJn1Vg069fY8m5oU0z5dHApYDqSXkaKLnO0rsFMXzX
         jHNXl1OUppVGtOFnhPQIuZvpMTN+eQPfNrF2KCuTfBXdDWq0/Y2iF/93Oc3wLtpXJnCh
         Vp7Q==
X-Gm-Message-State: ACrzQf1kEyMWAyLi2RJwISX+YrZRf6WAy6mQj6qM4+fjvRDt5ZFsoRSQ
        roG/uKNK22uNKZNM1wrIvh6U1Jb5Ogax37/0m4oFo4LPbjbq
X-Google-Smtp-Source: AMsMyM5NMVUgGFwmjfD0oDcjkMaAlkbYjWQjU8R/KaCLLb0L0d1g5+UWldfl6P/yl2bqC7ZP1cDtfJENcrMaG7bSXs+/08yoP+UE
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3791:b0:6a2:f312:a26a with SMTP id
 be17-20020a056602379100b006a2f312a26amr2357683iob.83.1665152503036; Fri, 07
 Oct 2022 07:21:43 -0700 (PDT)
Date:   Fri, 07 Oct 2022 07:21:43 -0700
In-Reply-To: <0000000000006a789905e9a67167@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070c45205ea728759@google.com>
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

HEAD commit:    ffb39098bf87 Merge tag 'linux-kselftest-kunit-6.1-rc1' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1183721a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4de111f81d6bee57
dashboard link: https://syzkaller.appspot.com/bug?extid=ff796f04613b4c84ad89
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1694d842880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e32a2f9d1ae7/disk-ffb39098.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/35e85ab79689/vmlinux-ffb39098.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff796f04613b4c84ad89@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __list_add_valid+0xa5/0xb0 lib/list_debug.c:30
Read of size 8 at addr ffff8880793fe5c8 by task syz-executor.1/4191

CPU: 1 PID: 4191 Comm: syz-executor.1 Not tainted 6.0.0-syzkaller-06205-gffb39098bf87 #0
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
RIP: 0033:0x7f7dfe68a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7dfdddd168 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f7dfe7ac2c0 RCX: 00007f7dfe68a5a9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 000000006c060000
RBP: 00007f7dfe6e5580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7dfecdfb1f R14: 00007f7dfdddd300 R15: 0000000000022000
 </TASK>

Allocated by task 4187:
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

Freed by task 4187:
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

The buggy address belongs to the object at ffff8880793fe000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 1480 bytes inside of
 2048-byte region [ffff8880793fe000, ffff8880793fe800)

The buggy address belongs to the physical page:
page:ffffea0001e4fe00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x793f8
head:ffffea0001e4fe00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff888011842000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 4194, tgid 4172 (syz-executor.1), ts 468583017791, free_ts 468503068379
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
 netlink_create+0x3ad/0x5e0 net/netlink/af_netlink.c:710
 __sock_create+0x355/0x790 net/socket.c:1515
 sock_create net/socket.c:1566 [inline]
 __sys_socket_create net/socket.c:1603 [inline]
 __sys_socket_create net/socket.c:1588 [inline]
 __sys_socket+0x12f/0x240 net/socket.c:1636
 __do_sys_socket net/socket.c:1649 [inline]
 __se_sys_socket net/socket.c:1647 [inline]
 __x64_sys_socket+0x6f/0xb0 net/socket.c:1647
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
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
 slab_alloc mm/slub.c:3256 [inline]
 kmem_cache_alloc_trace+0x2c0/0x3e0 mm/slub.c:3287
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 kobject_uevent_env+0x230/0x1640 lib/kobject_uevent.c:524
 __kobject_del+0x160/0x1f0 lib/kobject.c:585
 kobject_cleanup lib/kobject.c:664 [inline]
 kobject_release lib/kobject.c:704 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x2ed/0x4c0 lib/kobject.c:721
 net_rx_queue_update_kobjects+0x3f3/0x510 net/core/net-sysfs.c:1128
 remove_queue_kobjects net/core/net-sysfs.c:1829 [inline]
 netdev_unregister_kobject+0x158/0x280 net/core/net-sysfs.c:1983
 unregister_netdevice_many+0xe3a/0x1980 net/core/dev.c:10870
 ip_tunnel_delete_nets+0x39f/0x5b0 net/ipv4/ip_tunnel.c:1126
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:167
 setup_net+0x7fb/0xc50 net/core/net_namespace.c:348

Memory state around the buggy address:
 ffff8880793fe480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880793fe500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880793fe580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff8880793fe600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880793fe680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

