Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4983E74C45C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjGIN3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 09:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGIN33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:29:29 -0400
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B134DE8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 06:29:27 -0700 (PDT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-55c072efe78so3676709a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 06:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688909367; x=1691501367;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RxB3mQAGdnVsMuOx/4K2evVJF4o9mEe/XJ1F2csAEZo=;
        b=BS6ns0WJhW+ysjYxAin2qrkeaQXuBzq37jPRJMUvxhLzUAMTk9fXBFR8Am03HEpgiH
         pp1EUWHIUBbgAo52EJF3zCRVeVavujU60qVfIWPLzIRk2QGEciQywrP+NgbGDyK/YM/9
         7DOYXQag75FCifh93h8qINz2vLl24LnAEoguCwmV/ytiboxgNCO5nzDMHLZEn+VTtfn1
         bjeDHPBc5sqR7Ro4DOoOtvNtaxoQLuQjDeivylTElO1VfqOSZ1AfQR6mDCYSbu66iHVA
         PZg0vpJ/3SRWDmVmHem+0K+9BJEeMcPNarNi6yI+LXmCqX/NkuHE7aZuJE9G0W+CFRKo
         OgFg==
X-Gm-Message-State: ABy/qLYnelSNwCWpHXlkWhVmuAw87n3Iinr8seEvhNPeRV1HhplsL5oC
        kpbFKuy/jnnNEhaDVe732BiYgaArNHM0pRJL7PFmHnPGaiIB
X-Google-Smtp-Source: APBJJlFRjKJn9NP8ohUPXxF30SJ1xUE6RlecP9a8SPNiOz4+MqiI3E501FeKgRFGLpGPPTAEczgmg2c7/ycu6M7/BLNUavkTQawB
MIME-Version: 1.0
X-Received: by 2002:a17:903:2441:b0:1b8:a758:3020 with SMTP id
 l1-20020a170903244100b001b8a7583020mr10233359pls.12.1688909367221; Sun, 09
 Jul 2023 06:29:27 -0700 (PDT)
Date:   Sun, 09 Jul 2023 06:29:27 -0700
In-Reply-To: <20230709130059.1865-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e429cb06000ddaec@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-out-of-bounds Read in shrink_folio_list
From:   syzbot <syzbot+c19a171264b968bf389b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in shrink_folio_list

==================================================================
BUG: KASAN: slab-out-of-bounds in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-out-of-bounds in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-out-of-bounds in mapping_release_always include/linux/pagemap.h:279 [inline]
BUG: KASAN: slab-out-of-bounds in folio_needs_release mm/internal.h:187 [inline]
BUG: KASAN: slab-out-of-bounds in shrink_folio_list+0x2dbf/0x3e60 mm/vmscan.c:2067
Read of size 8 at addr ffff88802ba79521 by task syz-executor.0/5443

CPU: 1 PID: 5443 Comm: syz-executor.0 Not tainted 6.4.0-next-20230707-syzkaller-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/03/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:364
 print_report mm/kasan/report.c:475 [inline]
 kasan_report+0x11d/0x130 mm/kasan/report.c:588
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0xf0/0x190 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 mapping_release_always include/linux/pagemap.h:279 [inline]
 folio_needs_release mm/internal.h:187 [inline]
 shrink_folio_list+0x2dbf/0x3e60 mm/vmscan.c:2067
 reclaim_folio_list+0xd0/0x390 mm/vmscan.c:2801
 reclaim_pages+0x442/0x670 mm/vmscan.c:2837
 madvise_cold_or_pageout_pte_range+0x100e/0x1ee0 mm/madvise.c:533
 walk_pmd_range mm/pagewalk.c:140 [inline]
 walk_pud_range mm/pagewalk.c:218 [inline]
 walk_p4d_range mm/pagewalk.c:253 [inline]
 walk_pgd_range+0x9e7/0x1470 mm/pagewalk.c:290
 __walk_page_range+0x651/0x780 mm/pagewalk.c:392
 walk_page_range+0x311/0x4a0 mm/pagewalk.c:490
 madvise_pageout_page_range mm/madvise.c:591 [inline]
 madvise_pageout+0x2fe/0x560 mm/madvise.c:618
 madvise_vma_behavior+0x61a/0x21a0 mm/madvise.c:1039
 madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1268
 do_madvise.part.0+0x276/0x490 mm/madvise.c:1448
 do_madvise mm/madvise.c:1461 [inline]
 __do_sys_madvise mm/madvise.c:1461 [inline]
 __se_sys_madvise mm/madvise.c:1459 [inline]
 __x64_sys_madvise+0x117/0x150 mm/madvise.c:1459
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff6ee68c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff6ef3c3168 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007ff6ee7abf80 RCX: 00007ff6ee68c389
RDX: 0000000000000015 RSI: 0000000000600003 RDI: 0000000020000000
RBP: 00007ff6ee6d7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd8b088abf R14: 00007ff6ef3c3300 R15: 0000000000022000
 </TASK>

Allocated by task 5441:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3470 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x173/0x390 mm/slub.c:3494
 anon_vma_alloc mm/rmap.c:94 [inline]
 __anon_vma_prepare+0x2c6/0x580 mm/rmap.c:203
 anon_vma_prepare include/linux/rmap.h:159 [inline]
 do_cow_fault mm/memory.c:4573 [inline]
 do_fault mm/memory.c:4682 [inline]
 do_pte_missing mm/memory.c:3673 [inline]
 handle_pte_fault mm/memory.c:4949 [inline]
 __handle_mm_fault+0x304a/0x3dd0 mm/memory.c:5089
 handle_mm_fault+0x2a1/0x9e0 mm/memory.c:5254
 do_user_addr_fault+0x435/0x10a0 arch/x86/mm/fault.c:1415
 handle_page_fault arch/x86/mm/fault.c:1509 [inline]
 exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1565
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

The buggy address belongs to the object at ffff88802ba79440
 which belongs to the cache anon_vma of size 208
The buggy address is located 17 bytes to the right of
 allocated 208-byte region [ffff88802ba79440, ffff88802ba79510)

The buggy address belongs to the physical page:
page:ffffea0000ae9e40 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802ba79bb0 pfn:0x2ba79
memcg:ffff888067eec601
ksm flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff888014674140 ffffea0000aa3940 dead000000000003
raw: ffff88802ba79bb0 00000000800f0002 00000001ffffffff ffff888067eec601
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5428, tgid 5428 (dhcpcd-run-hook), ts 90527418963, free_ts 90445288205
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1569
 prep_new_page mm/page_alloc.c:1576 [inline]
 get_page_from_freelist+0xfd9/0x2c40 mm/page_alloc.c:3256
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4512
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1862 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:2009
 new_slab mm/slub.c:2062 [inline]
 ___slab_alloc+0xbc3/0x15d0 mm/slub.c:3215
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3314
 __slab_alloc_node mm/slub.c:3367 [inline]
 slab_alloc_node mm/slub.c:3460 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x371/0x390 mm/slub.c:3494
 anon_vma_alloc mm/rmap.c:94 [inline]
 __anon_vma_prepare+0x2c6/0x580 mm/rmap.c:203
 anon_vma_prepare include/linux/rmap.h:159 [inline]
 do_anonymous_page mm/memory.c:4112 [inline]
 do_pte_missing mm/memory.c:3671 [inline]
 handle_pte_fault mm/memory.c:4949 [inline]
 __handle_mm_fault+0x39e6/0x3dd0 mm/memory.c:5089
 handle_mm_fault+0x2a1/0x9e0 mm/memory.c:5254
 faultin_page mm/gup.c:952 [inline]
 __get_user_pages+0x4d3/0x10e0 mm/gup.c:1235
 __get_user_pages_locked mm/gup.c:1500 [inline]
 get_user_pages_remote+0x24f/0x980 mm/gup.c:2333
 get_arg_page+0x12c/0x470 fs/exec.c:225
 copy_string_kernel+0x1a3/0x260 fs/exec.c:643
 do_execveat_common+0x4df/0x8e0 fs/exec.c:1937
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1160 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2383
 free_unref_page+0x33/0x370 mm/page_alloc.c:2478
 vfree+0x180/0x7b0 mm/vmalloc.c:2842
 delayed_vfree_work+0x57/0x70 mm/vmalloc.c:2763
 process_one_work+0xa34/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2748
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff88802ba79400: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
 ffff88802ba79480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88802ba79500: 00 00 fc fc fc fc fc fc fc fc 00 00 00 00 00 00
                               ^
 ffff88802ba79580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802ba79600: 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00 00
==================================================================


Tested on:

commit:         123212f5 Add linux-next specific files for 20230707
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14985cf2a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15ec80b62f588543
dashboard link: https://syzkaller.appspot.com/bug?extid=c19a171264b968bf389b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1505da54a80000

