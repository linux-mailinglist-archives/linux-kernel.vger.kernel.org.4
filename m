Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EAF67116A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 03:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjARC7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 21:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjARC7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 21:59:17 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16ED94FC30
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:59:16 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id w24-20020a5d8458000000b00704bf40efecso3705668ior.21
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:59:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F2C5KVQj3v7in+ZETo5Nvo/3HeVwiJYVA0UpOu/fZ5U=;
        b=n5N7LoOC+Q34GK2Qg7TByfOnPA0P6HNC0/Qf3zit2oaWMUBxRYybPp+LOIx6INb7QZ
         7trDsQa47TmV3EDDLyRVGNq0XMY+Fpe6PmnKmAqdFEX0wUmoWzkFBSdY5n6yaHlbcJ3I
         zVuv3oWVixjrC9cMBkAnfj0hfxXnmuwnsXIBR77bNeJI58BNMdSM5T1ajCwSw8ZGjUos
         3goWm2XFX6LzqyTH4JQZTeuBnESGYYK42oNv0YauPdBDGM31ZoWnOv+kmkzkONBqqehd
         qlOs0ylnLzZpF3X4ZdvObggup/wixpad4Df9pwbvLN50uT8cv0CObwqwu2WWp5G/Ez10
         u/2A==
X-Gm-Message-State: AFqh2kowGnNmSYrw1DfBi8MJfa5e19zQJlIASlk8Y5bX95WTqw13jAm9
        6zDdTWNlRto44rHqJX14/UujWl32B3TW259jtIvkkPdOI9Ru
X-Google-Smtp-Source: AMrXdXsRPAJhz/zJN0sssZd1/IsMe7h4OLxVgXJsMpFy8KETzUOnuA42c3CWePd963EO1HaInRvZNSiksyo+Eo7vfU4ZjauXWQKm
MIME-Version: 1.0
X-Received: by 2002:a02:c013:0:b0:3a4:366b:33a6 with SMTP id
 y19-20020a02c013000000b003a4366b33a6mr530654jai.0.1674010755399; Tue, 17 Jan
 2023 18:59:15 -0800 (PST)
Date:   Tue, 17 Jan 2023 18:59:15 -0800
In-Reply-To: <20230118023942.2716-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d079c05f2810010@google.com>
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
KASAN: use-after-free Read in tctx_task_work

==================================================================
BUG: KASAN: use-after-free in io_fallback_tw io_uring/io_uring.c:1252 [inline]
BUG: KASAN: use-after-free in tctx_task_work.cold+0x10a/0x11d io_uring/io_uring.c:1222
Read of size 8 at addr ffff888024f00948 by task syz-executor.0/5598

CPU: 1 PID: 5598 Comm: syz-executor.0 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 io_fallback_tw io_uring/io_uring.c:1252 [inline]
 tctx_task_work.cold+0x10a/0x11d io_uring/io_uring.c:1222
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
RIP: 0033:0x7ff84e88c0c9
Code: Unable to access opcode bytes at 0x7ff84e88c09f.
RSP: 002b:00007ff84f57d168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 00007ff84e9abf80 RCX: 00007ff84e88c0c9
RDX: 0000000000002020 RSI: 00000000200021c0 RDI: 0000000000000006
RBP: 00007ff84e8e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd739e0c8f R14: 00007ff84f57d300 R15: 0000000000022000
 </TASK>

Allocated by task 5598:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 kmem_cache_alloc_bulk+0x3aa/0x730 mm/slub.c:4033
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1063
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2409
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3433
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 9:
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
 io_req_caches_free+0x1c4/0x201 io_uring/io_uring.c:2741
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2971
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff888024f008c0
 which belongs to the cache io_kiocb of size 224
The buggy address is located 136 bytes inside of
 224-byte region [ffff888024f008c0, ffff888024f009a0)

The buggy address belongs to the physical page:
page:ffffea000093c000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x24f00
memcg:ffff88801264c781
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff88814614c640 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff ffff88801264c781
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5598, tgid 5597 (syz-executor.0), ts 86881423641, free_ts 86232019510
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
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1063
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2409
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3433
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
 ffff888024f00800: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888024f00880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888024f00900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff888024f00980: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888024f00a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11d23496480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11b23c41480000

