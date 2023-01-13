Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D39668F48
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbjAMHdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbjAMHdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:33:08 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A09C1F2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:30:49 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id b24-20020a056602219800b006e2bf9902cbso12785514iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:30:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Jn2IjgZdXm/96r6RmphfrZAhetnN7SR5hazoCfKvYo=;
        b=XTC/TH+wbEhBG+/lpjAwFYWJRqFyA20rsCKxZoY+nRTO7z85xPGHftekRFY69UmaFs
         ss7kic6K8gD5DVEjnLKOUTjnoTb9jjtwn6XCt4KFlLBndLSvOLa6R5t/WkDToP6uSNQp
         gHZibfxJVnVw8D2KcLhrUKxSFJUNyK0w+XtGOBePIgnzImpjYq0C77xHLSf8IpVy0HNp
         x/KyzNK9EEvcPLGA9eGfKobVXuwqsJPC8hU2fHIgUyenk7rH0yJlzA4UG5iopeZUjCl1
         s2SB0/Opa6w03ToXppEOC82SnUkxB/ONqRgN+b8wVen1iskUjAlAv0R99iIsCW+BC6Uc
         d4XQ==
X-Gm-Message-State: AFqh2krYXZCwONvsvBrSAUijqd3XNBBmt7/9wEe3etqa1MJLuQPfJrKF
        t9oG75tKW1qR/5SLPQCX9a+ikkIOYZYP1Xiqixvu/sm2Za+a
X-Google-Smtp-Source: AMrXdXu1i4g0+NR+5NEcNu8wWWUy8SwoV90a88ao+uzXce6tzeqTVw23nD2X3DGGa8jrzAm8gBlSBJ7A/AMeUox8qf+tkqgYjyPB
MIME-Version: 1.0
X-Received: by 2002:a5d:9297:0:b0:6fa:3c6a:f9a6 with SMTP id
 s23-20020a5d9297000000b006fa3c6af9a6mr5170096iom.184.1673595048751; Thu, 12
 Jan 2023 23:30:48 -0800 (PST)
Date:   Thu, 12 Jan 2023 23:30:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060fb5d05f2203601@google.com>
Subject: [syzbot] KASAN: use-after-free Read in snd_pcm_post_stop
From:   syzbot <syzbot+e29d28728f38190cecfc@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
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

HEAD commit:    0a093b2893c7 Add linux-next specific files for 20230112
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=123b545e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17530902480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1206692c480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8111a570d6cb/disk-0a093b28.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecc135b7fc9a/vmlinux-0a093b28.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca8d73b446ea/bzImage-0a093b28.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e29d28728f38190cecfc@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in __wake_up_common+0x637/0x650 kernel/sched/wait.c:100
Read of size 8 at addr ffff88801eb938f0 by task syz-executor234/5078

CPU: 0 PID: 5078 Comm: syz-executor234 Not tainted 6.2.0-rc3-next-20230112-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 __wake_up_common+0x637/0x650 kernel/sched/wait.c:100
 __wake_up_common_lock+0xd4/0x140 kernel/sched/wait.c:138
 snd_pcm_post_stop+0x91/0x1f0 sound/core/pcm_native.c:1522
 snd_pcm_action_single+0xf4/0x130 sound/core/pcm_native.c:1283
 snd_pcm_action+0x6e/0x90 sound/core/pcm_native.c:1364
 snd_pcm_stop sound/core/pcm_native.c:1543 [inline]
 snd_pcm_drop+0x165/0x2b0 sound/core/pcm_native.c:2227
 snd_pcm_kernel_ioctl+0x243/0x2e0 sound/core/pcm_native.c:3456
 snd_pcm_oss_sync+0x230/0x810 sound/core/oss/pcm_oss.c:1746
 snd_pcm_oss_release+0x27a/0x300 sound/core/oss/pcm_oss.c:2590
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xb17/0x2a90 kernel/exit.c:867
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1012
 get_signal+0x225f/0x24f0 kernel/signal.c:2859
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f864105c209
Code: Unable to access opcode bytes at 0x7f864105c1df.
RSP: 002b:00007fff6e56b898 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 0000000000000004 RCX: 00007f864105c209
RDX: 0000000000002020 RSI: 00000000200021c0 RDI: 0000000000000006
RBP: 0000000000000000 R08: 00007fff6e56ba38 R09: 00007fff6e56ba38
R10: 000000000000000d R11: 0000000000000246 R12: 00007f864101f800
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 5078:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 kmem_cache_alloc_bulk+0x3aa/0x730 mm/slub.c:4033
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1062
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2407
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3429
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 1002:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 kmem_cache_free+0xec/0x4e0 mm/slub.c:3809
 io_req_caches_free+0x1a9/0x1e6 io_uring/io_uring.c:2737
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2967
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff88801eb938c0
 which belongs to the cache io_kiocb of size 216
The buggy address is located 48 bytes inside of
 216-byte region [ffff88801eb938c0, ffff88801eb93998)

The buggy address belongs to the physical page:
page:ffffea00007ae4c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eb93
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff88801bc32dc0 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5078, tgid 5078 (syz-executor234), ts 58909389529, free_ts 58908987546
 prep_new_page mm/page_alloc.c:2549 [inline]
 get_page_from_freelist+0x11bb/0x2d50 mm/page_alloc.c:4324
 __alloc_pages+0x1cb/0x5c0 mm/page_alloc.c:5590
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2281
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __kmem_cache_alloc_bulk mm/slub.c:3951 [inline]
 kmem_cache_alloc_bulk+0x23d/0x730 mm/slub.c:4026
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1062
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2407
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3429
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3482
 skb_free_frag include/linux/skbuff.h:3193 [inline]
 skb_free_head+0x96/0x110 net/core/skbuff.c:818
 skb_release_data+0x5f4/0x870 net/core/skbuff.c:849
 skb_release_all net/core/skbuff.c:914 [inline]
 __kfree_skb+0x4f/0x70 net/core/skbuff.c:928
 tcp_rcv_established+0x15fd/0x2270 net/ipv4/tcp_input.c:5927
 tcp_v4_do_rcv+0x663/0x9d0 net/ipv4/tcp_ipv4.c:1721
 tcp_v4_rcv+0x2eab/0x3280 net/ipv4/tcp_ipv4.c:2142
 ip_protocol_deliver_rcu+0x9f/0x480 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x2ec/0x4f0 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:302 [inline]
 NF_HOOK include/linux/netfilter.h:296 [inline]
 ip_local_deliver+0x1ae/0x200 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:454 [inline]
 ip_sublist_rcv_finish+0x9a/0x2c0 net/ipv4/ip_input.c:580
 ip_list_rcv_finish.constprop.0+0x4f9/0x6c0 net/ipv4/ip_input.c:630
 ip_sublist_rcv net/ipv4/ip_input.c:638 [inline]
 ip_list_rcv+0x347/0x4a0 net/ipv4/ip_input.c:673
 __netif_receive_skb_list_ptype net/core/dev.c:5525 [inline]
 __netif_receive_skb_list_core+0x548/0x8f0 net/core/dev.c:5573
 __netif_receive_skb_list net/core/dev.c:5625 [inline]
 netif_receive_skb_list_internal+0x75f/0xdc0 net/core/dev.c:5716

Memory state around the buggy address:
 ffff88801eb93780: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801eb93800: fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
>ffff88801eb93880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                             ^
 ffff88801eb93900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801eb93980: fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
