Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864C474C1A0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 11:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjGIJDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 05:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGIJDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 05:03:30 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547971A7
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 02:03:29 -0700 (PDT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-5428d1915acso4568086a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 02:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688893409; x=1691485409;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiRcbMuIY3ugUXUfmQNQlNZzNRF41xEd8WHWk19KwVQ=;
        b=f1sa9DFgAk4s1PaKhsXsBiJVSEVSCUWlTVq1GPnb1Cidvp8J5g63BJ3gXl2zYCF5yS
         C4pRmWcZOdF4DK0hPsOqLjrTPbtha3y8Hq0VE/zD5rHqlNBMriOZFevL6q/KIklYxFrh
         4N9933wfabHPqTHpVP/6xjapjVhyBdHckACKpLR3nEDdc4jvlrwe0F/JKAiRK7MIrz6R
         bGs0LCwbjkdDmTNxmQq3kIE1OCKfq7HqdfoOdJYxoPyE9BqpdD+gvkok6lnfGnRQ4M9L
         LKUQgSxzPVHHz7MUdIF9xMcYQTVko4n+0ZYu837Usfm3OhLeyiRae9Kv4gXLV9mrtkaA
         asDQ==
X-Gm-Message-State: ABy/qLY1HbeterTzzFnSqqkmqc4I1+WzexGM7P/ewCFxnjV8W0AAltLy
        zL1uTRN1lACkKiEivaNYcGExZQsQNqqXeDJ9Mv+4oTDEqaXA
X-Google-Smtp-Source: APBJJlFzTn6pIv8KfGpiduiGu7qaVWGHQuqZ57eKx0cn9CXsB4DUgmbUPVtTzqknkN6EVfPy8/JmJc5YpQxjKg0acTaCK6P8TArc
MIME-Version: 1.0
X-Received: by 2002:a63:6d0a:0:b0:55c:aa9:794 with SMTP id i10-20020a636d0a000000b0055c0aa90794mr5500237pgc.6.1688893408898;
 Sun, 09 Jul 2023 02:03:28 -0700 (PDT)
Date:   Sun, 09 Jul 2023 02:03:28 -0700
In-Reply-To: <20230709085002.1681-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b3755f06000a233c@google.com>
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
Read of size 8 at addr ffff8880157b3c91 by task syz-executor.0/5445

CPU: 0 PID: 5445 Comm: syz-executor.0 Not tainted 6.4.0-next-20230707-syzkaller-dirty #0
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
RIP: 0033:0x7f38c8a8c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f38c9790168 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007f38c8babf80 RCX: 00007f38c8a8c389
RDX: 0000000000000015 RSI: 0000000000600003 RDI: 0000000020000000
RBP: 00007f38c8ad7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd5dde0fbf R14: 00007f38c9790300 R15: 0000000000022000
 </TASK>

Allocated by task 5368:
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
 do_anonymous_page mm/memory.c:4112 [inline]
 do_pte_missing mm/memory.c:3671 [inline]
 handle_pte_fault mm/memory.c:4949 [inline]
 __handle_mm_fault+0x39e6/0x3dd0 mm/memory.c:5089
 handle_mm_fault+0x2a1/0x9e0 mm/memory.c:5254
 do_user_addr_fault+0x435/0x10a0 arch/x86/mm/fault.c:1415
 handle_page_fault arch/x86/mm/fault.c:1509 [inline]
 exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1565
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

The buggy address belongs to the object at ffff8880157b3bb0
 which belongs to the cache anon_vma of size 208
The buggy address is located 17 bytes to the right of
 allocated 208-byte region [ffff8880157b3bb0, ffff8880157b3c80)

The buggy address belongs to the physical page:
page:ffffea000055ecc0 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff8880157b3110 pfn:0x157b3
memcg:ffff88801ba5b401
ksm flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff888014674140 ffffea0001ce4b40 dead000000000003
raw: ffff8880157b3110 00000000800f0009 00000001ffffffff ffff88801ba5b401
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 5296, tgid 5296 (dhcpcd-run-hook), ts 81876191202, free_ts 81861098399
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
 anon_vma_fork+0xe2/0x630 mm/rmap.c:361
 dup_mmap+0xc0f/0x14b0 kernel/fork.c:734
 dup_mm kernel/fork.c:1696 [inline]
 copy_mm kernel/fork.c:1745 [inline]
 copy_process+0x6663/0x75c0 kernel/fork.c:2511
 kernel_clone+0xeb/0x890 kernel/fork.c:2919
 __do_sys_clone+0xba/0x100 kernel/fork.c:3062
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1160 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2383
 free_unref_page+0x33/0x370 mm/page_alloc.c:2478
 __unfreeze_partials+0x1fe/0x220 mm/slub.c:2647
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x195/0x220 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:762 [inline]
 slab_alloc_node mm/slub.c:3470 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x173/0x390 mm/slub.c:3494
 vm_area_dup+0x21/0x230 kernel/fork.c:500
 __split_vma+0x199/0x810 mm/mmap.c:2339
 do_vmi_align_munmap+0x3f3/0x10e0 mm/mmap.c:2477
 do_vmi_munmap+0x266/0x300 mm/mmap.c:2619
 mmap_region+0x1fb/0x20a0 mm/mmap.c:2669
 do_mmap+0x837/0xea0 mm/mmap.c:1362
 vm_mmap_pgoff+0x1b1/0x280 mm/util.c:543
 ksys_mmap_pgoff+0x42b/0x5b0 mm/mmap.c:1408
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80

Memory state around the buggy address:
 ffff8880157b3b80: fc fc fc fc fc fc 00 00 00 00 00 00 00 00 00 00
 ffff8880157b3c00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880157b3c80: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
                         ^
 ffff8880157b3d00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880157b3d80: 00 00 fc fc fc fc fc fc fc fc 00 00 00 00 00 00
==================================================================


Tested on:

commit:         123212f5 Add linux-next specific files for 20230707
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=135a15f8a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15ec80b62f588543
dashboard link: https://syzkaller.appspot.com/bug?extid=c19a171264b968bf389b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13a4666aa80000

