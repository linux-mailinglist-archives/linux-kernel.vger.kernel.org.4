Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA37566BE0D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjAPMo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjAPMoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:44:23 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70BF1E29C
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:44:21 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id a7-20020a056e0208a700b0030ecfd5d4cdso8882462ilt.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qonzGXwqn1RWK2nRKcaL7Mjf0pksOIEtRXMgpIWZ/1I=;
        b=h7gTnKffMELqAzgj8KJ9d3/clGAG820HXYHXd9LbnBKQCTyaCqgx132/ZSoVX5OmPq
         F5ZzpeFLYBYlNDPwj/uFfQbY7zE1OMtuYq7z37sU4KNu2SJRI0e9qxAS35NtzPoBM9vD
         3y0yk2clvFGp8zDSeqAuIvnnVb0v+TMC1lva3jzQLveDSLfrja3ghHAutWdO5S0IDgHV
         BZ7TznQujv7LvYTAVOeRXK1Y8+Aa3vHPZraTEv8fJLeQzxgFmyFGgOBCqfixh2tBNdlz
         6CSLxintY8ju4N3iM0Hkg0dG8aOteVi6+FHhfg+tOK5KRSig/aknCGVbjSGkLFLiaMCG
         q6lQ==
X-Gm-Message-State: AFqh2kosTL95ZoEEPWG4o2osl3oKTlLQbP54mb/u0zfPoBO5G+O9hVbV
        a/Q1UdsZAI3uezgbOBPgeb1NZ3txMNnHkhXeuqno3INf8AbJ
X-Google-Smtp-Source: AMrXdXsoEZEqcnUntcTU+d3d5DK73fbLftQEGkOjjkkQKT4x29oBKAaeNcPCpo44YK2u8K+ORE8G5I3nt+HzZPk92aAoAL8HK5g7
MIME-Version: 1.0
X-Received: by 2002:a6b:d10d:0:b0:6e2:bf4d:a58c with SMTP id
 l13-20020a6bd10d000000b006e2bf4da58cmr5666339iob.25.1673873061305; Mon, 16
 Jan 2023 04:44:21 -0800 (PST)
Date:   Mon, 16 Jan 2023 04:44:21 -0800
In-Reply-To: <20230116053340.1952-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037e89805f260f162@google.com>
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
KASAN: use-after-free Read in io_poll_remove_all_table

==================================================================
BUG: KASAN: use-after-free in io_poll_remove_all_table+0x161/0x2bd io_uring/poll.c:740
Read of size 8 at addr ffff888070848958 by task syz-executor.0/5603

CPU: 0 PID: 5603 Comm: syz-executor.0 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 io_poll_remove_all_table+0x161/0x2bd io_uring/poll.c:740
 io_poll_remove_all+0x2e/0x4b io_uring/poll.c:761
 io_ring_ctx_wait_and_kill+0x1a0/0x340 io_uring/io_uring.c:3024
 io_uring_release+0x46/0x4a io_uring/io_uring.c:3049
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
RIP: 0033:0x7efcf9a8c0c9
Code: Unable to access opcode bytes at 0x7efcf9a8c09f.
RSP: 002b:00007efcfa823168 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 00007efcf9babf80 RCX: 00007efcf9a8c0c9
RDX: 0000000000002020 RSI: 00000000200021c0 RDI: 0000000000000006
RBP: 00007efcf9ae7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdae1fefdf R14: 00007efcfa823300 R15: 0000000000022000
 </TASK>

Allocated by task 5603:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 kmem_cache_alloc_bulk+0x3aa/0x730 mm/slub.c:4033
 __io_alloc_req_refill+0xcc/0x40b io_uring/io_uring.c:1063
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2413
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3436
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5603:
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
 io_free_batch_list+0xdc/0x7d0 io_uring/io_uring.c:1466
 __io_submit_flush_completions+0x4ea/0x940 io_uring/io_uring.c:1501
 io_submit_flush_completions io_uring/io_uring.c:173 [inline]
 ctx_flush_and_put+0x13c/0x210 io_uring/io_uring.c:1145
 tctx_task_work+0x1af/0x530 io_uring/io_uring.c:1236
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 get_signal+0x1c7/0x24f0 kernel/signal.c:2635
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880708488c0
 which belongs to the cache io_kiocb of size 224
The buggy address is located 152 bytes inside of
 224-byte region [ffff8880708488c0, ffff8880708489a0)

The buggy address belongs to the physical page:
page:ffffea0001c21200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x70848
memcg:ffff888017e79781
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff8881463e0500 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff ffff888017e79781
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5603, tgid 5602 (syz-executor.0), ts 91825186400, free_ts 91803934935
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
 io_submit_sqes.cold+0x7c/0xc2 io_uring/io_uring.c:2413
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3436
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
 ffff888070848800: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
 ffff888070848880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff888070848900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff888070848980: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888070848a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15640391480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=175567ba480000

