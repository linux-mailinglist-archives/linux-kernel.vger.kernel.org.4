Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF57747E05
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 09:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbjGEHP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 03:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGEHPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 03:15:55 -0400
Received: from mail-pg1-f205.google.com (mail-pg1-f205.google.com [209.85.215.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0011A1
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 00:15:54 -0700 (PDT)
Received: by mail-pg1-f205.google.com with SMTP id 41be03b00d2f7-55b2ab496ecso6111979a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 00:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688541353; x=1691133353;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WZ7+sWnWvrizFrJ5QFtNubkqy+1tbYZw1UlsRJ+947o=;
        b=cCXPLzqowNdGavKBF2UvpbML3sHdp6EDtwiMBofCLIyeal+o/D7tIHaeQM7EC+eX4u
         AvAePxvTKqRl2ps8oW33f1zyE7LXvYp+Mk6AFkxNwBTKtF/sKVkrMko0PHnn6C9+TDCN
         V+ppBJGCJWbDf2zwsORIAivf3EnCnzGsTMsDSvy8b0hMjONOSrH1J+e17puPaqIE0EvG
         RNETL67OgKcRjD7inLRtMaH3IXxowjxozlk9QyPHQWXySga35gnzoo+hRi9wPl/FQnD8
         5LuGvt5pQ2xY4d3gkJUt1GX90TlgxodO+dYww/vjvTVQXgLxhLC9IRwVEv8xrw4rqXPb
         W3kw==
X-Gm-Message-State: ABy/qLbnM9GNYqvRVCoguH0mBA0xK4BozUTPwtobtCZUEd5RmlGY746j
        TMMjZbqwz0E3iIr4IvcQJbDFHWIz91cabwhM8rQwPRk1iMRV
X-Google-Smtp-Source: APBJJlG31Dw+a4umbG/+PdjzfaV9vilsIQIsWOwB6cDTifYUWydZ4Ae2fqcIbJI1YPzq9R8fSOfTVptVOjQ8Ttz71V+LYne1cgMu
MIME-Version: 1.0
X-Received: by 2002:a63:4b0c:0:b0:553:8668:dc40 with SMTP id
 y12-20020a634b0c000000b005538668dc40mr8770642pga.6.1688541353764; Wed, 05 Jul
 2023 00:15:53 -0700 (PDT)
Date:   Wed, 05 Jul 2023 00:15:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000946c5905ffb82b43@google.com>
Subject: [syzbot] [net?] KASAN: slab-out-of-bounds Read in xfrm_state_walk
From:   syzbot <syzbot+3dc23bd4c9d524e84ecf@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, steffen.klassert@secunet.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3674fbf0451d Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1638c0c8a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9bf1936936ca698
dashboard link: https://syzkaller.appspot.com/bug?extid=3dc23bd4c9d524e84ecf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/42ed556782c3/disk-3674fbf0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1913e16e8565/vmlinux-3674fbf0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/469804b58a7c/bzImage-3674fbf0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3dc23bd4c9d524e84ecf@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in memcmp+0x1b6/0x1c0 lib/string.c:681
Read of size 8 at addr ffff888077e4fd20 by task syz-executor.1/8730

CPU: 1 PID: 8730 Comm: syz-executor.1 Not tainted 6.4.0-rc7-syzkaller-01944-g3674fbf0451d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 memcmp+0x1b6/0x1c0 lib/string.c:681
 memcmp include/linux/fortify-string.h:665 [inline]
 addr_match include/net/xfrm.h:841 [inline]
 __xfrm_state_filter_match net/xfrm/xfrm_state.c:2279 [inline]
 xfrm_state_walk+0x387/0xad0 net/xfrm/xfrm_state.c:2307
 xfrm_dump_sa+0x33d/0x4c0 net/xfrm/xfrm_user.c:1279
 netlink_dump+0x570/0xc50 net/netlink/af_netlink.c:2269
 __netlink_dump_start+0x6c0/0x9b0 net/netlink/af_netlink.c:2376
 netlink_dump_start include/linux/netlink.h:330 [inline]
 xfrm_user_rcv_msg+0x853/0xa50 net/xfrm/xfrm_user.c:3135
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2549
 xfrm_netlink_rcv+0x6f/0x90 net/xfrm/xfrm_user.c:3172
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 ____sys_sendmsg+0x733/0x920 net/socket.c:2493
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2547
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2576
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f90b1c8c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f90b07fe168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f90b1dabf80 RCX: 00007f90b1c8c389
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007f90b1cd7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffb5f563bf R14: 00007f90b07fe300 R15: 0000000000022000
 </TASK>

Allocated by task 8730:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc_node_track_caller+0x5f/0x1a0 mm/slab_common.c:986
 kmemdup+0x2c/0x60 mm/util.c:131
 kmemdup include/linux/fortify-string.h:702 [inline]
 xfrm_dump_sa+0x28a/0x4c0 net/xfrm/xfrm_user.c:1266
 netlink_dump+0x570/0xc50 net/netlink/af_netlink.c:2269
 __netlink_dump_start+0x6c0/0x9b0 net/netlink/af_netlink.c:2376
 netlink_dump_start include/linux/netlink.h:330 [inline]
 xfrm_user_rcv_msg+0x853/0xa50 net/xfrm/xfrm_user.c:3135
 netlink_rcv_skb+0x165/0x440 net/netlink/af_netlink.c:2549
 xfrm_netlink_rcv+0x6f/0x90 net/xfrm/xfrm_user.c:3172
 netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
 netlink_unicast+0x547/0x7f0 net/netlink/af_netlink.c:1365
 netlink_sendmsg+0x925/0xe30 net/netlink/af_netlink.c:1914
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 ____sys_sendmsg+0x733/0x920 net/socket.c:2493
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2547
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2576
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 kvfree_call_rcu+0x70/0xad0 kernel/rcu/tree.c:3332
 ip6addrlbl_net_exit+0xb1/0x180 net/ipv6/addrlabel.c:347
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:170
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:614
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 kvfree_call_rcu+0x70/0xad0 kernel/rcu/tree.c:3332
 ip6addrlbl_net_exit+0xb1/0x180 net/ipv6/addrlabel.c:347
 ops_exit_list+0xb0/0x170 net/core/net_namespace.c:170
 cleanup_net+0x4ee/0xb10 net/core/net_namespace.c:614
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff888077e4fd00
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 32 bytes inside of
 allocated 36-byte region [ffff888077e4fd00, ffff888077e4fd24)

The buggy address belongs to the physical page:
page:ffffea0001df93c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x77e4f
anon flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff888012441640 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_HARDWALL), pid 56, tgid 56 (kworker/u4:4), ts 309757851470, free_ts 309399709292
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0xf41/0x2c00 mm/page_alloc.c:3502
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3490
 __do_kmalloc_node mm/slab_common.c:965 [inline]
 __kmalloc+0x4e/0x190 mm/slab_common.c:979
 kmalloc include/linux/slab.h:563 [inline]
 batadv_tvlv_realloc_packet_buff net/batman-adv/tvlv.c:283 [inline]
 batadv_tvlv_container_ogm_append+0x13a/0x4d0 net/batman-adv/tvlv.c:324
 batadv_iv_ogm_schedule_buff+0x11aa/0x1520 net/batman-adv/bat_iv_ogm.c:812
 batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:868 [inline]
 batadv_iv_ogm_schedule net/batman-adv/bat_iv_ogm.c:861 [inline]
 batadv_iv_send_outstanding_bat_ogm_packet+0x333/0x960 net/batman-adv/bat_iv_ogm.c:1712
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2564
 free_unref_page+0x33/0x370 mm/page_alloc.c:2659
 bpf_ringbuf_free kernel/bpf/ringbuf.c:227 [inline]
 ringbuf_map_free+0xd7/0x130 kernel/bpf/ringbuf.c:236
 bpf_map_free_deferred+0x192/0x3e0 kernel/bpf/syscall.c:698
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff888077e4fc00: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
 ffff888077e4fc80: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff888077e4fd00: 00 00 00 00 04 fc fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff888077e4fd80: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
 ffff888077e4fe00: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
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
