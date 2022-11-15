Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE9062A05E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiKOR3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiKOR3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:29:45 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9336022B11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:29:44 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id a14-20020a921a0e000000b003016bfa7e50so11557317ila.16
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 09:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BulR63DY1c4Z0HSjOpsmh3pXNcG0KiO1E2IgjhxX4Gc=;
        b=b3d2w5wzSPth0drceqxkB7X4fTKVoMwKzFBqQq+r3hJXei98S33xZh7noH+3Bo+cFd
         5Kq7GyRPFtRR8W7dUIm2OyrFUT/5jNxeW/1ncYsxIaz2+IsSGToKXCTnspo3U7uQXknC
         Vo9N501r41bqSJtg7OokrT0kYuRJVJrSAQuLrD/4W5dTFz7uKxZZnW+aSmWdppHV/sZH
         bE/iGoJiLA0g34uNbYjATPyyYCzVVrjgKNtFz/W/DMVbCG+tgV84OFPBmq0wv+sMQazb
         F4peqpZJt4DjKCCLyiRgOUOewsnkXYRknDBrd/gICyHpd4cSU3TXInjW7waiuZP0Hrk0
         tPZA==
X-Gm-Message-State: ANoB5pnlzU4w4bkQpdalUfXhcavWjRvSeSeIi1+t7u6Qag6m5eNzrERP
        lmOl/YNYa+nnjIOCbjz2ZGmR35gIJciIaf9L0RSfZBEu3/WL
X-Google-Smtp-Source: AA0mqf7lOa1M1cUt6a9YXP5RuGRcq9Y4LmRMggIiugxZrXyzw9l7Ub6/xxmlRfSnFwUcbJ1iSYx/uL/cPHB/bHD3EpHSHVNz3t0Q
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c03:b0:2fa:52cd:80eb with SMTP id
 l3-20020a056e021c0300b002fa52cd80ebmr8891162ilh.236.1668533383971; Tue, 15
 Nov 2022 09:29:43 -0800 (PST)
Date:   Tue, 15 Nov 2022 09:29:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5c9be05ed85b31b@google.com>
Subject: [syzbot] KASAN: use-after-free Read in netdev_core_pick_tx
From:   syzbot <syzbot+10a7a8ca6e94600110ec@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, justin@coraid.com, linux-block@vger.kernel.org,
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

HEAD commit:    42226c989789 Linux 5.18-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13edd495f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d84df8e1a4c4d5a4
dashboard link: https://syzkaller.appspot.com/bug?extid=10a7a8ca6e94600110ec
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11ed1369f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166b22cef00000

Bisection is inconclusive: the issue happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14305359f00000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16305359f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12305359f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10a7a8ca6e94600110ec@syzkaller.appspotmail.com

ieee802154 phy1 wpan1: encryption failed: -22
xfrm0 selects TX queue 0, but real number of TX queues is 0
==================================================================
BUG: KASAN: use-after-free in netdev_get_tx_queue include/linux/netdevice.h:2367 [inline]
BUG: KASAN: use-after-free in netdev_core_pick_tx+0x1ba/0x2f0 net/core/dev.c:4061
Read of size 8 at addr ffff8880802f4440 by task aoe_tx0/1226

CPU: 1 PID: 1226 Comm: aoe_tx0 Not tainted 5.18.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:313
 print_report+0xf4/0x210 mm/kasan/report.c:429
 kasan_report+0xfb/0x130 mm/kasan/report.c:491
 netdev_get_tx_queue include/linux/netdevice.h:2367 [inline]
 netdev_core_pick_tx+0x1ba/0x2f0 net/core/dev.c:4061
 __dev_queue_xmit+0x8bd/0x3640 net/core/dev.c:4136
 tx+0x6f/0x110 drivers/block/aoe/aoenet.c:63
 kthread+0x241/0x450 drivers/block/aoe/aoecmd.c:1229
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30
 </TASK>

Allocated by task 12330:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 ____kasan_kmalloc+0xdc/0x110 mm/kasan/common.c:515
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 __kmalloc_node+0x262/0x400 mm/slub.c:4462
 kmalloc_node include/linux/slab.h:604 [inline]
 kvmalloc_node+0x6e/0x160 mm/util.c:580
 kvmalloc include/linux/slab.h:731 [inline]
 kvzalloc include/linux/slab.h:739 [inline]
 alloc_netdev_mqs+0x85/0xe10 net/core/dev.c:10491
 rtnl_create_link+0x2db/0x9e0 net/core/rtnetlink.c:3204
 __rtnl_newlink net/core/rtnetlink.c:3473 [inline]
 rtnl_newlink+0x13b7/0x2070 net/core/rtnetlink.c:3531
 rtnetlink_rcv_msg+0x92f/0xe80 net/core/rtnetlink.c:5993
 netlink_rcv_skb+0x1f0/0x460 net/netlink/af_netlink.c:2502
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7e7/0x9c0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x9b3/0xcd0 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:705 [inline]
 sock_sendmsg net/socket.c:725 [inline]
 ____sys_sendmsg+0x597/0x8e0 net/socket.c:2413
 ___sys_sendmsg net/socket.c:2467 [inline]
 __sys_sendmsg+0x27e/0x370 net/socket.c:2496
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 12330:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:45
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free+0xd8/0x110 mm/kasan/common.c:366
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1728 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1754
 slab_free mm/slub.c:3510 [inline]
 kfree+0xc6/0x210 mm/slub.c:4552
 device_release+0x98/0x1c0
 kobject_cleanup+0x235/0x470 lib/kobject.c:673
 netdev_run_todo+0xf7c/0x1070 net/core/dev.c:10274
 rtnl_unlock net/core/rtnetlink.c:112 [inline]
 rtnetlink_rcv_msg+0x936/0xe80 net/core/rtnetlink.c:5994
 netlink_rcv_skb+0x1f0/0x460 net/netlink/af_netlink.c:2502
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7e7/0x9c0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x9b3/0xcd0 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:705 [inline]
 sock_sendmsg net/socket.c:725 [inline]
 ____sys_sendmsg+0x597/0x8e0 net/socket.c:2413
 ___sys_sendmsg net/socket.c:2467 [inline]
 __sys_sendmsg+0x27e/0x370 net/socket.c:2496
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

The buggy address belongs to the object at ffff8880802f4000
 which belongs to the cache kmalloc-cg-4k of size 4096
The buggy address is located 1088 bytes inside of
 4096-byte region [ffff8880802f4000, ffff8880802f5000)

The buggy address belongs to the physical page:
page:ffffea000200bc00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x802f0
head:ffffea000200bc00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff88801144c280
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3660, tgid 3660 (udevd), ts 992725721470, free_ts 992688446020
 prep_new_page mm/page_alloc.c:2441 [inline]
 get_page_from_freelist+0x72e/0x7a0 mm/page_alloc.c:4182
 __alloc_pages+0x26c/0x5f0 mm/page_alloc.c:5408
 alloc_slab_page+0x70/0xf0 mm/slub.c:1799
 allocate_slab+0x5e/0x560 mm/slub.c:1944
 new_slab mm/slub.c:2004 [inline]
 ___slab_alloc+0x41e/0xcd0 mm/slub.c:3005
 __slab_alloc mm/slub.c:3092 [inline]
 slab_alloc_node mm/slub.c:3183 [inline]
 __kmalloc_node+0x2c0/0x400 mm/slub.c:4458
 kmalloc_node include/linux/slab.h:604 [inline]
 kvmalloc_node+0x6e/0x160 mm/util.c:580
 kvmalloc include/linux/slab.h:731 [inline]
 seq_buf_alloc fs/seq_file.c:38 [inline]
 seq_read_iter+0x1f6/0xd30 fs/seq_file.c:210
 call_read_iter include/linux/fs.h:2044 [inline]
 new_sync_read fs/read_write.c:401 [inline]
 vfs_read+0xa01/0xd10 fs/read_write.c:482
 ksys_read+0x19b/0x2c0 fs/read_write.c:620
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1356 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1406
 free_unref_page_prepare mm/page_alloc.c:3328 [inline]
 free_unref_page+0x7d/0x390 mm/page_alloc.c:3423
 free_slab mm/slub.c:2043 [inline]
 discard_slab mm/slub.c:2049 [inline]
 __unfreeze_partials+0x1ab/0x200 mm/slub.c:2523
 put_cpu_partial+0x116/0x180 mm/slub.c:2599
 do_slab_free mm/slub.c:3498 [inline]
 ___cache_free+0x118/0x1a0 mm/slub.c:3517
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:176
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:283
 __kasan_slab_alloc+0x2f/0xe0 mm/kasan/common.c:446
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:749 [inline]
 slab_alloc_node mm/slub.c:3217 [inline]
 kmem_cache_alloc_node+0x1cd/0x340 mm/slub.c:3267
 __alloc_skb+0xd2/0x590 net/core/skbuff.c:414
 alloc_skb include/linux/skbuff.h:1300 [inline]
 nlmsg_new include/net/netlink.h:953 [inline]
 rtmsg_ifinfo_build_skb+0x81/0x180 net/core/rtnetlink.c:3844
 rtmsg_ifinfo_event net/core/rtnetlink.c:3880 [inline]
 rtnetlink_event+0xea/0x1b0 net/core/rtnetlink.c:6044
 notifier_call_chain kernel/notifier.c:84 [inline]
 raw_notifier_call_chain+0xe7/0x170 kernel/notifier.c:392
 call_netdevice_notifiers_info net/core/dev.c:1938 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:1976 [inline]
 call_netdevice_notifiers+0x14e/0x1d0 net/core/dev.c:1990
 bond_set_dev_addr+0xd4/0x170 drivers/net/bonding/bond_main.c:931
 bond_enslave+0xab9/0x3f20 drivers/net/bonding/bond_main.c:1888

Memory state around the buggy address:
 ffff8880802f4300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880802f4380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff8880802f4400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff8880802f4480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880802f4500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
