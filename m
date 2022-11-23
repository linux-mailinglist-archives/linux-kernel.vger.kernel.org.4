Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 456F86369E9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239497AbiKWTch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbiKWTce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:32:34 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B820AE3B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:32:28 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id k21-20020a5e8915000000b006de391b332fso9398666ioj.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:32:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ieQT2+amnCPQkrT/b4MsUc2qUSHECxGcta2Tz8dlWww=;
        b=w9XoJ+tYlO2Si1AQ+RBKXjCWVTv45w++lBvjkRShKI3jCdJFxMau0HnD8odeefuf85
         +IJgXHi/lVsBisu+QNUBEzkFaiyN1pGXSZ0vB7NWjB5uIJywIgaV3LaWSjpUVApKWOrL
         6S84NV8LOTlV/AvGAFzJtv0UMh+f6B0MGg40XvZ+xJre1ITmyl+ncbnME89RT6q4Sm3X
         JCy14nw3ENw4YW4SU1eN3hQk1oyfAAh3/Ocwi/uey1SVK83p5Sl/4ikPqe2dX5W27trr
         2aYxiQIPx2MwNy8OOOSFUjCjn5A9szyLelUn91NI8TCNi17UY+obk44nPcxbhWzSodkw
         1wCQ==
X-Gm-Message-State: ANoB5pmQ7kfhj7Sr2T5/czOI+YGwoe/Cul1LlITZABBZT3pPb4XAraVx
        M1xEXRQYlgsi9HJ28fg83OpfIg/mGmWVnY+jrWp2hOXVPk/H
X-Google-Smtp-Source: AA0mqf79B8oIR5C8i+qvxuclMp0m4BMCwZ8MjtX7srTIIl9YOhTlnAzHr/jmrGrm/FnxYHO3493C9IhBFBtQNKm2bmqisOh47SbI
MIME-Version: 1.0
X-Received: by 2002:a02:6603:0:b0:375:9e02:b459 with SMTP id
 k3-20020a026603000000b003759e02b459mr13511512jac.30.1669231948027; Wed, 23
 Nov 2022 11:32:28 -0800 (PST)
Date:   Wed, 23 Nov 2022 11:32:28 -0800
In-Reply-To: <Y338pCjXlDT8Zu3z@elver.google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f620e05ee285958@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in task_work_run (2)
From:   syzbot <syzbot+9228d6098455bb209ec8@syzkaller.appspotmail.com>
To:     acme@kernel.org, dvyukov@google.com, elver@google.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: use-after-free Read in task_work_run

==================================================================
BUG: KASAN: use-after-free in task_work_run+0x1b0/0x270 kernel/task_work.c:178
Read of size 8 at addr ffff88807a0a2208 by task syz-executor.0/4187

CPU: 1 PID: 4187 Comm: syz-executor.0 Not tainted 6.1.0-rc2-syzkaller-00073-g88619e77b33d-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:395
 kasan_report+0xbb/0x1f0 mm/kasan/report.c:495
 task_work_run+0x1b0/0x270 kernel/task_work.c:178
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xb35/0x2a20 kernel/exit.c:820
 do_group_exit+0xd0/0x2a0 kernel/exit.c:950
 get_signal+0x21a1/0x2430 kernel/signal.c:2858
 arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:296
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fac4248b5a9
Code: Unable to access opcode bytes at 0x7fac4248b57f.
RSP: 002b:00007fac432bf218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 00007fac425abf88 RCX: 00007fac4248b5a9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007fac425abf8c
RBP: 00007fac425abf80 R08: 00007ffde2bb1080 R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 00007fac425abf8c
R13: 00007ffde2b9c48f R14: 00007fac432bf300 R15: 0000000000022000
 </TASK>

Allocated by task 4187:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7e/0x80 mm/kasan/common.c:325
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 kmem_cache_alloc_node+0x2fc/0x400 mm/slub.c:3443
 perf_event_alloc.part.0+0x69/0x3bc0 kernel/events/core.c:11627
 perf_event_alloc kernel/events/core.c:12176 [inline]
 __do_sys_perf_event_open+0x4ae/0x32d0 kernel/events/core.c:12274
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 4190:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2a/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 kmem_cache_free+0xea/0x5b0 mm/slub.c:3683
 rcu_do_batch kernel/rcu/tree.c:2250 [inline]
 rcu_core+0x81f/0x1980 kernel/rcu/tree.c:2510
 __do_softirq+0x1f7/0xad8 kernel/softirq.c:571

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:481
 call_rcu+0x99/0x820 kernel/rcu/tree.c:2798
 put_event kernel/events/core.c:5097 [inline]
 perf_event_release_kernel+0x6f2/0x940 kernel/events/core.c:5212
 perf_release+0x33/0x40 kernel/events/core.c:5222
 __fput+0x27c/0xa90 fs/file_table.c:320
 task_work_run+0x16b/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:296
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:481
 task_work_add+0x7b/0x2c0 kernel/task_work.c:48
 event_sched_out+0xe35/0x1190 kernel/events/core.c:2294
 __perf_remove_from_context+0x87/0xc40 kernel/events/core.c:2359
 event_function+0x29e/0x3e0 kernel/events/core.c:254
 remote_function kernel/events/core.c:92 [inline]
 remote_function+0x11e/0x1a0 kernel/events/core.c:72
 __flush_smp_call_function_queue+0x205/0x9a0 kernel/smp.c:630
 __sysvec_call_function_single+0xca/0x4d0 arch/x86/kernel/smp.c:248
 sysvec_call_function_single+0x40/0xc0 arch/x86/kernel/smp.c:243
 asm_sysvec_call_function_single+0x16/0x20 arch/x86/include/asm/idtentry.h:657

The buggy address belongs to the object at ffff88807a0a1db0
 which belongs to the cache perf_event of size 1392
The buggy address is located 1112 bytes inside of
 1392-byte region [ffff88807a0a1db0, ffff88807a0a2320)

The buggy address belongs to the physical page:
page:ffffea0001e82800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7a0a0
head:ffffea0001e82800 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000122 ffff8880118c23c0
raw: 0000000000000000 0000000080150015 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 4164, tgid 4163 (syz-executor.0), ts 81241255075, free_ts 81180758193
 prep_new_page mm/page_alloc.c:2538 [inline]
 get_page_from_freelist+0x10b5/0x2d50 mm/page_alloc.c:4287
 __alloc_pages+0x1c7/0x5a0 mm/page_alloc.c:5554
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x213/0x300 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3180
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3279
 slab_alloc_node mm/slub.c:3364 [inline]
 kmem_cache_alloc_node+0x189/0x400 mm/slub.c:3443
 perf_event_alloc.part.0+0x69/0x3bc0 kernel/events/core.c:11627
 perf_event_alloc kernel/events/core.c:12176 [inline]
 __do_sys_perf_event_open+0x4ae/0x32d0 kernel/events/core.c:12274
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1458 [inline]
 free_pcp_prepare+0x65c/0xd90 mm/page_alloc.c:1508
 free_unref_page_prepare mm/page_alloc.c:3386 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3482
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2586
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x62/0x80 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 slab_alloc mm/slub.c:3406 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3413 [inline]
 kmem_cache_alloc+0x2ac/0x3c0 mm/slub.c:3422
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
 getname_flags+0x9a/0xe0 include/linux/audit.h:320
 vfs_fstatat+0x73/0xb0 fs/stat.c:266
 __do_sys_newfstatat+0x94/0x120 fs/stat.c:437
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807a0a2100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807a0a2180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807a0a2200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88807a0a2280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807a0a2300: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         88619e77 net: stmmac: rk3588: Allow multiple gmac cont..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=127408e5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=9228d6098455bb209ec8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147a9dfd880000

