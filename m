Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1833E6E57B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjDRDHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjDRDHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:07:21 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062AA527C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:07:19 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-760ccc48b3bso113138839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681787238; x=1684379238;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JDT/+Os/xU79hVv9Q36BuZQke5hhOJ0qQu4XE2GffJQ=;
        b=WYqZzqX9QcXVEBAjLUJCLoqJXLvJveK966dlSI5PwfeMJQi57P4kiQdTqu5ud4EfnP
         jhX0tuKibMCuhoRfP3awHYHJZt/RYsIJ/I0K/Wdk9Y4hq35fFRW8+WsqqHGzm+yzOad2
         YnvU5T30HixP7dz4R8duy1I4FQG4gX/wL0KPjHxyitmJ9prQzcrsefVWM1lIJXnw+sKR
         WJAPRImmrviPQo28hZDkwaQykE4amupw3Ot50Z3mrUmgnUy366gTR6yI/Dh0UcpVdjcr
         rFNXmMAnRxs0GhWnyP6sHePGb88dQSacggKqPk6tUsNdGtky6ghwAcZR9uHB4TItVxj3
         5UXQ==
X-Gm-Message-State: AAQBX9eoas9H++lvglfRTF1fHn1V7t+LtwTU7lBu0LnSE8z9yrmG53i4
        LHoP/0mqkZ+xIRvBMKDoj/6cVnyFm/WODAhJbpsSNO8hhyer
X-Google-Smtp-Source: AKy350aVd70bV6Rzz9pe0Z/ZeAQotVQ+6fFVT9E2S9SQTV29jCiOJuHAev4Vfudk5vya5w09y0KXugoQTVBNQQMh0cMrKlJrJaYu
MIME-Version: 1.0
X-Received: by 2002:a6b:6519:0:b0:760:e308:1070 with SMTP id
 z25-20020a6b6519000000b00760e3081070mr620207iob.0.1681787238268; Mon, 17 Apr
 2023 20:07:18 -0700 (PDT)
Date:   Mon, 17 Apr 2023 20:07:18 -0700
In-Reply-To: <20230418022559.1197-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ecca4305f9939a79@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in mini_qdisc_pair_swap
From:   syzbot <syzbot+b53a9c0d1ea4ad62da8b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-use-after-free Write in mini_qdisc_pair_swap

==================================================================
BUG: KASAN: slab-use-after-free in mini_qdisc_pair_swap+0x1c2/0x1f0 net/sched/sch_generic.c:1573
Write of size 8 at addr ffff88806348a308 by task syz-executor.0/8529

CPU: 1 PID: 8529 Comm: syz-executor.0 Not tainted 6.3.0-rc3-syzkaller-00026-gfff5a5e7f528-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
 print_report mm/kasan/report.c:430 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:536
 mini_qdisc_pair_swap+0x1c2/0x1f0 net/sched/sch_generic.c:1573
 tcf_chain_head_change_item net/sched/cls_api.c:495 [inline]
 tcf_chain0_head_change.isra.0+0xb9/0x120 net/sched/cls_api.c:509
 tcf_chain_tp_insert net/sched/cls_api.c:1826 [inline]
 tcf_chain_tp_insert_unique net/sched/cls_api.c:1875 [inline]
 tc_new_tfilter+0x1d77/0x2200 net/sched/cls_api.c:2268
 rtnetlink_rcv_msg+0x996/0xd50 net/core/rtnetlink.c:6165
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2574
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1942
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 ____sys_sendmsg+0x334/0x900 net/socket.c:2501
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2555
 __sys_sendmmsg+0x18f/0x460 net/socket.c:2641
 __do_sys_sendmmsg net/socket.c:2670 [inline]
 __se_sys_sendmmsg net/socket.c:2667 [inline]
 __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ffaaee8c0f9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffaafc5e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007ffaaefac120 RCX: 00007ffaaee8c0f9
RDX: 040000000000009f RSI: 00000000200002c0 RDI: 0000000000000007
RBP: 00007ffaaeee7b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe97997fbf R14: 00007ffaafc5e300 R15: 0000000000022000
 </TASK>

Allocated by task 8524:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc_node+0x61/0x1a0 mm/slab_common.c:974
 kmalloc_node include/linux/slab.h:610 [inline]
 kzalloc_node include/linux/slab.h:731 [inline]
 qdisc_alloc+0xb0/0xb30 net/sched/sch_generic.c:938
 qdisc_create+0xce/0x1040 net/sched/sch_api.c:1244
 tc_modify_qdisc+0x488/0x1a40 net/sched/sch_api.c:1680
 rtnetlink_rcv_msg+0x43d/0xd50 net/core/rtnetlink.c:6174
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2574
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1942
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 ____sys_sendmsg+0x334/0x900 net/socket.c:2501
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2555
 __sys_sendmmsg+0x18f/0x460 net/socket.c:2641
 __do_sys_sendmmsg net/socket.c:2670 [inline]
 __se_sys_sendmmsg net/socket.c:2667 [inline]
 __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 21:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
 rcu_do_batch kernel/rcu/tree.c:2112 [inline]
 rcu_core+0x814/0x1960 kernel/rcu/tree.c:2372
 __do_softirq+0x1d4/0x905 kernel/softirq.c:571

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 __call_rcu_common.constprop.0+0x99/0x7e0 kernel/rcu/tree.c:2622
 qdisc_put_unlocked+0x73/0x90 net/sched/sch_generic.c:1097
 tcf_block_release+0x86/0x90 net/sched/cls_api.c:1362
 tc_new_tfilter+0xa2b/0x2200 net/sched/cls_api.c:2333
 rtnetlink_rcv_msg+0x996/0xd50 net/core/rtnetlink.c:6165
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2574
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1942
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 ____sys_sendmsg+0x334/0x900 net/socket.c:2501
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2555
 __sys_sendmmsg+0x18f/0x460 net/socket.c:2641
 __do_sys_sendmmsg net/socket.c:2670 [inline]
 __se_sys_sendmmsg net/socket.c:2667 [inline]
 __x64_sys_sendmmsg+0x9d/0x100 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 __call_rcu_common.constprop.0+0x99/0x7e0 kernel/rcu/tree.c:2622
 rhashtable_rehash_table lib/rhashtable.c:348 [inline]
 rht_deferred_worker+0xb24/0x1ce0 lib/rhashtable.c:432
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff88806348a000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 776 bytes inside of
 freed 1024-byte region [ffff88806348a000, ffff88806348a400)

The buggy address belongs to the physical page:
page:ffffea00018d2200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x63488
head:ffffea00018d2200 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888012441dc0 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 8117, tgid 8111 (syz-executor.3), ts 126042830210, free_ts 15956815362
 prep_new_page mm/page_alloc.c:2552 [inline]
 get_page_from_freelist+0x1190/0x2e20 mm/page_alloc.c:4325
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:5591
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3491
 kmalloc_trace+0x26/0xe0 mm/slab_common.c:1061
 kmalloc include/linux/slab.h:580 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 fl_init+0x45/0x2c0 net/sched/cls_flower.c:351
 tcf_proto_create net/sched/cls_api.c:398 [inline]
 tc_new_tfilter+0xecf/0x2200 net/sched/cls_api.c:2260
 rtnetlink_rcv_msg+0x996/0xd50 net/core/rtnetlink.c:6165
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2574
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1942
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 ____sys_sendmsg+0x334/0x900 net/socket.c:2501
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare+0x5d5/0xa50 mm/page_alloc.c:1503
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3482
 free_contig_range+0xb5/0x180 mm/page_alloc.c:9531
 destroy_args+0x6c4/0x920 mm/debug_vm_pgtable.c:1023
 debug_vm_pgtable+0x242a/0x4640 mm/debug_vm_pgtable.c:1403
 do_one_initcall+0x102/0x540 init/main.c:1310
 do_initcall_level init/main.c:1383 [inline]
 do_initcalls init/main.c:1399 [inline]
 do_basic_setup init/main.c:1418 [inline]
 kernel_init_freeable+0x696/0xc00 init/main.c:1638
 kernel_init+0x1e/0x2c0 init/main.c:1526
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff88806348a200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806348a280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88806348a300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88806348a380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88806348a400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         fff5a5e7 Merge tag 'for-linus' of git://git.armlinux.o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10cf71c0280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea09b0836073ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=b53a9c0d1ea4ad62da8b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16fa5f23c80000

