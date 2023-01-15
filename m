Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F29366AFD9
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 09:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjAOIGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 03:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjAOIGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 03:06:18 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4943F90
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 00:06:17 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id c11-20020a056e020bcb00b0030be9d07d63so18889128ilu.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 00:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AV55ToH4cnwN1BsiWq5Reun4X9hiTnUtDGVar3LmmI=;
        b=u72r6Y4rosQeDt5gLKlv5a8rxMAtu9a0u9GHrS98YRnWGIDc7m+4KQ8NBxBiSq1uuT
         /jfJlzhiogNiZ2WXeja85J64v6BeshYhw7AiLqGbkWflVClQIV/GGENGG0UeRniUVQt0
         Heq6zCwsIJ/2KWfSkOyM1K0swGPlYCRvJzkmvu+8J0lXMdbp524WaySmbZoOLEwcM7QH
         p09TZfuEE1gY0j2xbewNq4TmTvzc0d+f66XrJ715gjuU++6HfgIe06Emo2LRyFwbJrKQ
         OP32M1pOZBBotUt3u8ABAb4Wv3HVRGZo4qzMCY0omXtW0ZzjxAeeYJlvhGh6gwromN90
         fbMw==
X-Gm-Message-State: AFqh2kqvd0a7S7n9suYrsEiEkMqgvDZRtH8sL/YUu5c/61x2SzqtuL8r
        xDIuAoEeC3sIW/AurLjCPniI9nlyQGDChedsO6zMUUAtssjz
X-Google-Smtp-Source: AMrXdXs40qDAMCw9PIODDnk+XEjrOkIuicAjQ2pXnGgjfu4PQDVihxaGHmC5gGJBUiw9Q6SCszLXkEho8UWab6l6UWqE+tw4JGG3
MIME-Version: 1.0
X-Received: by 2002:a6b:d80c:0:b0:704:5916:5290 with SMTP id
 y12-20020a6bd80c000000b0070459165290mr1807809iob.10.1673769976617; Sun, 15
 Jan 2023 00:06:16 -0800 (PST)
Date:   Sun, 15 Jan 2023 00:06:16 -0800
In-Reply-To: <20230115074631.1541-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e4620105f248f04d@google.com>
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
KASAN: use-after-free Read in io_fallback_tw

==================================================================
BUG: KASAN: use-after-free in io_fallback_tw+0x6d/0x119 io_uring/io_uring.c:1253
Read of size 8 at addr ffff888029b7c948 by task syz-executor.0/5601

CPU: 1 PID: 5601 Comm: syz-executor.0 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 io_fallback_tw+0x6d/0x119 io_uring/io_uring.c:1253
 tctx_task_work.cold+0xf/0x2c io_uring/io_uring.c:1223
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
RIP: 0033:0x7f9fa6c8c0c9
Code: Unable to access opcode bytes at 0x7f9fa6c8c09f.
RSP: 002b:00007f9fa7a98168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 00007f9fa6dabf80 RCX: 00007f9fa6c8c0c9
RDX: 0000000000002020 RSI: 00000000200021c0 RDI: 0000000000000006
RBP: 00007f9fa6ce7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdca0565bf R14: 00007f9fa7a98300 R15: 0000000000022000
 </TASK>

Allocated by task 5601:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 kmem_cache_alloc_bulk+0x3aa/0x730 mm/slub.c:4033
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1064
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2412
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3434
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 33:
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
 io_req_caches_free+0x1a9/0x1e6 io_uring/io_uring.c:2742
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2972
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff888029b7c8c0
 which belongs to the cache io_kiocb of size 224
The buggy address is located 136 bytes inside of
 224-byte region [ffff888029b7c8c0, ffff888029b7c9a0)

The buggy address belongs to the physical page:
page:ffffea0000a6df00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x29b7c
memcg:ffff88801de69981
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888146395500 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff ffff88801de69981
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5601, tgid 5600 (syz-executor.0), ts 79202512513, free_ts 51400073995
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
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1064
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2412
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3434
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1451 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1501
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3482
 __vunmap+0x7fe/0xc00 mm/vmalloc.c:2746
 __vfree+0x3c/0xd0 mm/vmalloc.c:2794
 vfree+0x5e/0x90 mm/vmalloc.c:2825
 kcov_put kernel/kcov.c:428 [inline]
 kcov_put+0x26/0x40 kernel/kcov.c:424
 kcov_close+0x10/0x20 kernel/kcov.c:524
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

Memory state around the buggy address:
 ffff888029b7c800: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 ffff888029b7c880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888029b7c900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff888029b7c980: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888029b7ca00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14412b16480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15c09ea6480000

