Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C29462F3E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 12:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241618AbiKRLjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 06:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241514AbiKRLjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 06:39:44 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5218392097
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:39:43 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id f2-20020a5ec602000000b006dc67829888so2466017iok.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 03:39:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0JpVSl5tndpcXODTscRSqhEjx7kqlAtSew7RRFlv8A=;
        b=yATfz1Y9mEw/2PiGnZBk1eEXcA26XjjY7oYURHdxo7u5FuBw8hA/Cb/Z/Wju4VIHXw
         P9U+fy5Myae680Qh5gT+RPMuXFZSrWz3D32DnJyV2iNcHCGIZMrq88Ic47GBM5rniV7e
         4UAJZk/1ghZiqLfYVI9DDvpbnuidC4xdIZg1r99Nu/kSr9jl/Q0d9OCrwW5yreP/OhPc
         4JJ6FfTeCjVo4m7AG/EhdIJezlHzQOjcbkwCLiS7hFPRwUc/LoaCBzyE25eZSyormItH
         BTYq4Q37YvZc2jhnJpV+MBLdF14DE8Bix3oeCU+Y56OlizJ1Uk761M0a9MDayYwNja6S
         BsOA==
X-Gm-Message-State: ANoB5pnQub6vb+GCyY6Hqq+wfYqIJwslvYMWYc69VVpnnLh59BtJHJf2
        ntpG7rWEHSaftNkwqY83dZ9FRKzRANRt1RTX3dF49dElS4XG
X-Google-Smtp-Source: AA0mqf6cN9RmMEjwqkSmMQE/8ngqGt/W5C7JDBiN1zLH7hmfKSE/Drx+Sl1GOedDcwua1ToirfX1uoftuqKZ6dXPolcGzKwvYujv
MIME-Version: 1.0
X-Received: by 2002:a02:ccf0:0:b0:363:6320:4112 with SMTP id
 l16-20020a02ccf0000000b0036363204112mr2916605jaq.152.1668771582549; Fri, 18
 Nov 2022 03:39:42 -0800 (PST)
Date:   Fri, 18 Nov 2022 03:39:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063aad605edbd296e@google.com>
Subject: [syzbot] KASAN: use-after-free Read in notifier_call_chain
From:   syzbot <syzbot+106f9b687cd64ee70cd1@syzkaller.appspotmail.com>
To:     bigeasy@linutronix.de, bp@suse.de, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com, valentin.schneider@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f1244c81da13 Add linux-next specific files for 20220420
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=123262fcf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=77eb44eab99be599
dashboard link: https://syzkaller.appspot.com/bug?extid=106f9b687cd64ee70cd1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a31da2f00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11bd3a10f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+106f9b687cd64ee70cd1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in notifier_call_chain+0x1ee/0x200 kernel/notifier.c:72
Read of size 8 at addr ffff88807221d4e8 by task syz-executor742/3605

CPU: 0 PID: 3605 Comm: syz-executor742 Not tainted 5.18.0-rc3-next-20220420-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description.constprop.0.cold+0xeb/0x495 mm/kasan/report.c:313
 print_report mm/kasan/report.c:429 [inline]
 kasan_report.cold+0xf4/0x1c6 mm/kasan/report.c:491
 notifier_call_chain+0x1ee/0x200 kernel/notifier.c:72
 call_netdevice_notifiers_info+0x86/0x130 net/core/dev.c:1940
 call_netdevice_notifiers_extack net/core/dev.c:1981 [inline]
 call_netdevice_notifiers net/core/dev.c:1995 [inline]
 netdev_wait_allrefs_any net/core/dev.c:10165 [inline]
 netdev_run_todo+0xb90/0x10b0 net/core/dev.c:10277
 tun_detach drivers/net/tun.c:696 [inline]
 tun_chr_close+0xe0/0x180 drivers/net/tun.c:3445
 __fput+0x277/0x9d0 fs/file_table.c:317
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:37 [inline]
 do_exit+0xaff/0x2a00 kernel/exit.c:796
 do_group_exit+0xd2/0x2f0 kernel/exit.c:926
 __do_sys_exit_group kernel/exit.c:937 [inline]
 __se_sys_exit_group kernel/exit.c:935 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:935
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fa43b961159
Code: Unable to access opcode bytes at RIP 0x7fa43b96112f.
RSP: 002b:00007ffed29a23b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fa43b9dd410 RCX: 00007fa43b961159
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 0000000000000004
R10: 00007ffed29a21a6 R11: 0000000000000246 R12: 00007fa43b9dd410
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>

Allocated by task 3605:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:436 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:469
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3216 [inline]
 slab_alloc mm/slub.c:3224 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3231 [inline]
 kmem_cache_alloc+0x204/0x3b0 mm/slub.c:3241
 kmem_cache_zalloc include/linux/slab.h:711 [inline]
 net_alloc net/core/net_namespace.c:403 [inline]
 copy_net_ns+0x125/0x760 net/core/net_namespace.c:458
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x445/0x920 kernel/fork.c:3139
 __do_sys_unshare kernel/fork.c:3210 [inline]
 __se_sys_unshare kernel/fork.c:3208 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3208
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Freed by task 50:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:366 [inline]
 ____kasan_slab_free+0x166/0x1a0 mm/kasan/common.c:328
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1729 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1755
 slab_free mm/slub.c:3509 [inline]
 kmem_cache_free+0xdd/0x5a0 mm/slub.c:3526
 net_free net/core/net_namespace.c:432 [inline]
 net_free net/core/net_namespace.c:428 [inline]
 cleanup_net+0x8ba/0xb00 net/core/net_namespace.c:615
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298

The buggy address belongs to the object at ffff88807221d280
 which belongs to the cache net_namespace of size 6784
The buggy address is located 616 bytes inside of
 6784-byte region [ffff88807221d280, ffff88807221ed00)

The buggy address belongs to the physical page:
page:ffffea0001c88600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x72218
head:ffffea0001c88600 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff8881400073c0
raw: 0000000000000000 0000000080040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3602, tgid 3602 (syz-executor742), ts 75811913155, free_ts 69877050433
 prep_new_page mm/page_alloc.c:2394 [inline]
 get_page_from_freelist+0xba2/0x3e00 mm/page_alloc.c:4144
 __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5365
 alloc_pages+0x1aa/0x310 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1799 [inline]
 allocate_slab+0x26c/0x3c0 mm/slub.c:1944
 new_slab mm/slub.c:2004 [inline]
 ___slab_alloc+0x985/0xd90 mm/slub.c:3004
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3091
 slab_alloc_node mm/slub.c:3182 [inline]
 slab_alloc mm/slub.c:3224 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3231 [inline]
 kmem_cache_alloc+0x360/0x3b0 mm/slub.c:3241
 kmem_cache_zalloc include/linux/slab.h:711 [inline]
 net_alloc net/core/net_namespace.c:403 [inline]
 copy_net_ns+0x125/0x760 net/core/net_namespace.c:458
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x445/0x920 kernel/fork.c:3139
 __do_sys_unshare kernel/fork.c:3210 [inline]
 __se_sys_unshare kernel/fork.c:3208 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3208
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1309 [inline]
 free_pcp_prepare+0x549/0xd20 mm/page_alloc.c:1359
 free_unref_page_prepare mm/page_alloc.c:3290 [inline]
 free_unref_page+0x19/0x6a0 mm/page_alloc.c:3385
 __put_page+0x17d/0x280 mm/swap.c:127
 folio_put include/linux/mm.h:1202 [inline]
 put_page include/linux/mm.h:1235 [inline]
 __skb_frag_unref include/linux/skbuff.h:3367 [inline]
 skb_release_data+0x513/0x810 net/core/skbuff.c:672
 skb_release_all net/core/skbuff.c:742 [inline]
 __kfree_skb+0x46/0x60 net/core/skbuff.c:756
 __sk_defer_free_flush net/ipv4/tcp.c:1601 [inline]
 sk_defer_free_flush include/net/tcp.h:1385 [inline]
 tcp_recvmsg+0x1b9/0x600 net/ipv4/tcp.c:2574
 inet_recvmsg+0x115/0x5e0 net/ipv4/af_inet.c:850
 sock_recvmsg_nosec net/socket.c:948 [inline]
 sock_recvmsg net/socket.c:966 [inline]
 sock_recvmsg net/socket.c:962 [inline]
 sock_read_iter+0x336/0x470 net/socket.c:1039
 call_read_iter include/linux/fs.h:2053 [inline]
 new_sync_read+0x4f9/0x5f0 fs/read_write.c:401
 vfs_read+0x492/0x5d0 fs/read_write.c:482
 ksys_read+0x1e8/0x250 fs/read_write.c:620
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Memory state around the buggy address:
 ffff88807221d380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807221d400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807221d480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                          ^
 ffff88807221d500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807221d580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
