Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E82766B4CE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 00:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbjAOXnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 18:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbjAOXnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 18:43:20 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4271C1285E
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 15:43:19 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id h24-20020a056e021d9800b0030be8a5dd68so20048237ila.13
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 15:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HDq10GkQCrZCMlw48Z9HEVRK85mYiTbrQ1XYsQKfOQ=;
        b=h3Fh+eTjT0/xHLdHQkwd8KnImPJxohiJeQP66jya0NyFvJPzGvQHWsJi4GBLB5Oh3W
         a07ehE97G48ZK2NI3RAnWNGi23CnyuffqV0qoVN1qeOv2GbEpciGk6qN8Bggt9WTR601
         EsdcGbqmAKOnfWTI+XGNGHudpX9nIHMorGV4c4ypjsHfjuXx+ft+Sr0fcFA8CuF74JJX
         /Kaj3WNZ5WSeMiLyeJ7jqAArSxG1X6L01wVQItb1rbLykZukriWQgNFNBHVU//5GSZc+
         sfnKvy/BIR5qY9BOnB6wEH7CaBrHRGjM3F4hx7BObtPDve8B8TcTCFyK4DZQ3RGuoD8A
         P5Tg==
X-Gm-Message-State: AFqh2ko2KALQnMJlxtJrQUSccZgI1cEdnCOh+Lo+uvwNEP1FN5P81fCE
        yG7WG1+DNhTzVLxApEq6OxPUHy0zCBkfj6cQmeRoFFCPERh7
X-Google-Smtp-Source: AMrXdXsBfQOMkCLOf7Ut+CaVnrrXx9o31FtH4E/nLBEiFOdXAMeKi4H/p9aoPQN3cV1LnaXdUBQG9xsAFL8o0UlAdrV07ofWP1rE
MIME-Version: 1.0
X-Received: by 2002:a5d:9915:0:b0:6eb:68df:5d59 with SMTP id
 x21-20020a5d9915000000b006eb68df5d59mr8000001iol.166.1673826198568; Sun, 15
 Jan 2023 15:43:18 -0800 (PST)
Date:   Sun, 15 Jan 2023 15:43:18 -0800
In-Reply-To: <20230115232650.1752-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fb473605f25607c5@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in snd_pcm_post_stop
From:   syzbot <syzbot+e29d28728f38190cecfc@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in io_fallback_req_func

==================================================================
BUG: KASAN: use-after-free in io_fallback_req_func+0xce/0x2fd io_uring/io_uring.c:251
Read of size 8 at addr ffff88807ed29948 by task kworker/1:4/5593

CPU: 1 PID: 5593 Comm: kworker/1:4 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: events io_fallback_req_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 io_fallback_req_func+0xce/0x2fd io_uring/io_uring.c:251
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 process_scheduled_works kernel/workqueue.c:2356 [inline]
 worker_thread+0x807/0x1090 kernel/workqueue.c:2445
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 5603:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 kmem_cache_alloc_bulk+0x3aa/0x730 mm/slub.c:4033
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1068
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2421
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3443
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 1170:
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
 io_req_caches_free+0x1a9/0x1e6 io_uring/io_uring.c:2751
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2981
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff88807ed298c0
 which belongs to the cache io_kiocb of size 224
The buggy address is located 136 bytes inside of
 224-byte region [ffff88807ed298c0, ffff88807ed299a0)

The buggy address belongs to the physical page:
page:ffffea0001fb4a40 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7ed29
memcg:ffff8880290cd081
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff8881462e6280 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff ffff8880290cd081
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5603, tgid 5602 (syz-executor.0), ts 89380836523, free_ts 88705663139
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
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1068
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2421
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3443
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page_list+0x176/0xcd0 mm/page_alloc.c:3528
 release_pages+0xcb1/0x1330 mm/swap.c:1072
 tlb_batch_pages_flush+0xa8/0x1a0 mm/mmu_gather.c:97
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu mm/mmu_gather.c:299 [inline]
 tlb_finish_mmu+0x14b/0x7e0 mm/mmu_gather.c:391
 exit_mmap+0x202/0x7c0 mm/mmap.c:3100
 __mmput+0x128/0x4c0 kernel/fork.c:1212
 mmput+0x60/0x70 kernel/fork.c:1234
 exit_mm kernel/exit.c:563 [inline]
 do_exit+0x9ac/0x2a90 kernel/exit.c:854
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1012
 __do_sys_exit_group kernel/exit.c:1023 [inline]
 __se_sys_exit_group kernel/exit.c:1021 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1021
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807ed29800: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff88807ed29880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff88807ed29900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff88807ed29980: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807ed29a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=172d8f86480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16fabd5e480000

