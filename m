Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C232D686BF3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbjBAQlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:41:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjBAQlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:41:23 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526E7C66C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 08:41:21 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id g1-20020a92cda1000000b0030c45d93884so11912015ild.16
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 08:41:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3v8KoAs3LtnVEpYTBT4bnz+/XFxMybdFtW8qmpI8xCg=;
        b=qFetDpZFgu5B8Bqc6/4aH23PqDMPJWiQYntePA25/vpM9sio2ofif53t7+Iz0ShpkM
         oFN7fuJgzJsLopVgsZnkhkm52vvy2QodHFJCXGTZjS99sllUPV5ALZj8ePaDZKJxDELw
         f4BQT26E6d/cv3aCLImoO3Oj72N6N159oeUh9mN7ZTozjjLAJfo33dPaIVoUtuwK/XSz
         Lqwt5o96rFAF0Bmv+r+CCceh7eUE48Ow/XsC0c1rCHBKGS/K3fdhIxK0S4l6ApzSJ3Z+
         W3sn30egvEdbWwg8Snk77XyAIwt4TvVssZSbi4X1kcgeeYWVUkf52Hj7DLK6Itcz20A8
         opIg==
X-Gm-Message-State: AO0yUKVrsNElK06wi0h4Sl7gzFqCWQTexM6bYVzt/2TFkPAXbY2OQVdk
        dO1mG4XroGMT5dnxM2llMGRudEWGtcMUx8UomEi9gbJcKpzE
X-Google-Smtp-Source: AK7set/ww8XEFrzlmjl7OKpuWiRX4jojrez6iTfuAjj6D7nybPSEunQKsevpPrQsVfLqBET9N9KUWvCq7m/Pw7wvX8kcYBsE8rKV
MIME-Version: 1.0
X-Received: by 2002:a02:a798:0:b0:3a1:336:ad86 with SMTP id
 e24-20020a02a798000000b003a10336ad86mr558251jaj.119.1675269680574; Wed, 01
 Feb 2023 08:41:20 -0800 (PST)
Date:   Wed, 01 Feb 2023 08:41:20 -0800
In-Reply-To: <20230119081633.3470-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036b91005f3a61ef6@google.com>
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
BUG: KASAN: use-after-free in io_fallback_req_func+0xc7/0x204 io_uring/io_uring.c:253
Read of size 8 at addr ffff8880271e8948 by task kworker/0:5/5578

CPU: 0 PID: 5578 Comm: kworker/0:5 Not tainted 6.2.0-rc3-next-20230112-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Workqueue: events io_fallback_req_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xc0/0xf0 mm/kasan/report.c:517
 io_fallback_req_func+0xc7/0x204 io_uring/io_uring.c:253
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
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
 __io_alloc_req_refill+0xcc/0x434 io_uring/io_uring.c:1068
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0xd/0xc2 io_uring/io_uring.c:2420
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3442
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 2822:
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
 io_req_caches_free+0x203/0x248 io_uring/io_uring.c:2750
 io_ring_exit_work+0x2e7/0xc80 io_uring/io_uring.c:2980
 process_one_work+0x9bf/0x1750 kernel/workqueue.c:2293
 worker_thread+0x669/0x1090 kernel/workqueue.c:2440
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff8880271e88c0
 which belongs to the cache io_kiocb of size 232
The buggy address is located 136 bytes inside of
 232-byte region [ffff8880271e88c0, ffff8880271e89a8)

The buggy address belongs to the physical page:
page:ffffea00009c7a00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x271e8
memcg:ffff888017b98f01
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888146255140 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff ffff888017b98f01
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5603, tgid 5602 (syz-executor.0), ts 91755579199, free_ts 91135623998
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
 __io_alloc_req_refill+0xcc/0x434 io_uring/io_uring.c:1068
 io_alloc_req_refill io_uring/io_uring.h:348 [inline]
 io_submit_sqes.cold+0xd/0xc2 io_uring/io_uring.c:2420
 __do_sys_io_uring_enter+0x9e4/0x2c10 io_uring/io_uring.c:3442
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
 ffff8880271e8800: fb fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc
 ffff8880271e8880: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
>ffff8880271e8900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                              ^
 ffff8880271e8980: fb fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc
 ffff8880271e8a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         0a093b28 Add linux-next specific files for 20230112
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11ffb3b3480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=835f3591019836d5
dashboard link: https://syzkaller.appspot.com/bug?extid=e29d28728f38190cecfc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15114c2e480000

