Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FA074C11A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 07:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjGIFdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 01:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjGIFdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 01:33:42 -0400
Received: from mail-pj1-f78.google.com (mail-pj1-f78.google.com [209.85.216.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99EC812A
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 22:33:40 -0700 (PDT)
Received: by mail-pj1-f78.google.com with SMTP id 98e67ed59e1d1-262c488c1d3so3805939a91.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 22:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688880820; x=1691472820;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QFIFz/VfYaiGDd3grxiPcUHMlA08TfdikiLFYzzmBak=;
        b=CPMFmkVe86Y1vt46DzSyioqmF5iGO5Myu5IOMfuwR6QOfCrt2xJNB+GNP1k/owYqcv
         nM4zzrXvAc7ECj0IR86XT29xeBFA5C0BADXVJBRA0OFs2mebzvrrbdjUgnjN1VXBN7s2
         6DP58JrJuIC0cQhgRZWzt5tmTaEW+GhAGQ/GnhL4QmGe9uu1YAXsfg/iz+L3k+4K6doY
         8FPwPU24suiz2H9aTqgT2d4k/bvLfGjLFkkSub+FMK50BOCCKNShE0ksqd/s3yjfthUb
         HveOlp4kAVzji9hvAGgB7arNWYd6hLQeFk+zKJDxSjlbtqdDFQO1P0XYET0W2LJXhU0T
         0q4g==
X-Gm-Message-State: ABy/qLZprgdjk/jZEljRYYH8IksjHhwbLyzQyoPocuLHKg0HbffQ/vQv
        4hx/+2F8JmisTGccnoKfxwOi+zTBOTnNmHD7sSbv72raQQyG
X-Google-Smtp-Source: APBJJlE3VrQbK07TFCKG2X0sF/V0CHCXocYaUQv+5tNe3bvViGoF5sKd9q0maEOlUgO5i+z306TKFFkqtRGV2+1htXWp/zdgJR7R
MIME-Version: 1.0
X-Received: by 2002:a17:90a:d911:b0:262:ef07:f30a with SMTP id
 c17-20020a17090ad91100b00262ef07f30amr8139742pjv.7.1688880820099; Sat, 08 Jul
 2023 22:33:40 -0700 (PDT)
Date:   Sat, 08 Jul 2023 22:33:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000599fea0600073558@google.com>
Subject: [syzbot] [mm?] KASAN: slab-out-of-bounds Read in shrink_folio_list
From:   syzbot <syzbot+c19a171264b968bf389b@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

syzbot found the following issue on:

HEAD commit:    123212f53f3e Add linux-next specific files for 20230707
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1542771ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15ec80b62f588543
dashboard link: https://syzkaller.appspot.com/bug?extid=c19a171264b968bf389b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1284666aa80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b142bca80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/098f7ee2237c/disk-123212f5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88defebbfc49/vmlinux-123212f5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d5e9343ec16a/bzImage-123212f5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c19a171264b968bf389b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: slab-out-of-bounds in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: slab-out-of-bounds in mapping_release_always include/linux/pagemap.h:279 [inline]
BUG: KASAN: slab-out-of-bounds in folio_needs_release mm/internal.h:187 [inline]
BUG: KASAN: slab-out-of-bounds in shrink_folio_list+0x2dbf/0x3e60 mm/vmscan.c:2067
Read of size 8 at addr ffff888078d2bda1 by task syz-executor321/5029

CPU: 1 PID: 5029 Comm: syz-executor321 Not tainted 6.4.0-next-20230707-syzkaller #0
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
RIP: 0033:0x7f0290b79c29
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe42da7dc8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007f0290be7ed0 RCX: 00007f0290b79c29
RDX: 0000000000000015 RSI: 0000000000600003 RDI: 0000000020000000
RBP: 00007ffe42da7dd8 R08: 00007f0290be7e40 R09: 00007f0290be7e40
R10: 00007ffe42da7840 R11: 0000000000000246 R12: 00007ffe42da7de0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 5019:
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
 anon_vma_fork+0xe2/0x630 mm/rmap.c:361
 dup_mmap+0xc0f/0x14b0 kernel/fork.c:732
 dup_mm kernel/fork.c:1694 [inline]
 copy_mm kernel/fork.c:1743 [inline]
 copy_process+0x6663/0x75c0 kernel/fork.c:2509
 kernel_clone+0xeb/0x890 kernel/fork.c:2917
 __do_sys_clone+0xba/0x100 kernel/fork.c:3060
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888078d2bcc0
 which belongs to the cache anon_vma of size 208
The buggy address is located 17 bytes to the right of
 allocated 208-byte region [ffff888078d2bcc0, ffff888078d2bd90)

The buggy address belongs to the physical page:
page:ffffea0001e34ac0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x78d2b
ksm flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff888014674140 ffffea0000ad6100 dead000000000003
raw: 0000000000000000 00000000800f000f 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 4694, tgid 4694 (dhcpcd), ts 64749636388, free_ts 46253751886
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
 dup_mmap+0xc0f/0x14b0 kernel/fork.c:732
 dup_mm kernel/fork.c:1694 [inline]
 copy_mm kernel/fork.c:1743 [inline]
 copy_process+0x6663/0x75c0 kernel/fork.c:2509
 kernel_clone+0xeb/0x890 kernel/fork.c:2917
 __do_sys_clone+0xba/0x100 kernel/fork.c:3060
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
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:140
 getname_flags+0x9e/0xe0 include/linux/audit.h:319
 vfs_fstatat+0x77/0xb0 fs/stat.c:275
 __do_sys_newfstatat+0x8a/0x110 fs/stat.c:446
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888078d2bc80: fc fc fc fc fc fc fc fc 00 00 00 00 00 00 00 00
 ffff888078d2bd00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888078d2bd80: 00 00 fc fc fc fc fc fc fc fc 00 00 00 00 00 00
                               ^
 ffff888078d2be00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888078d2be80: 00 00 00 00 fc fc fc fc fc fc fc fc 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
