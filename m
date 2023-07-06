Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844F674930A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 03:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjGFBXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 21:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjGFBW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:22:58 -0400
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536C21994
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 18:22:57 -0700 (PDT)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-66a44bf4651so213686b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 18:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688606577; x=1691198577;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vSgrqI1tjKK+SLtvqTTC2c0aEEq21oDHin1+SMO6l4k=;
        b=RDVB/Cfv9ZjbQffq27vDDAqC8Xn38KS7x9KQJlBFOeD4V5NubW5J9E7fz+t1+wXC1K
         j94Fk3GqMz+PTjs5PdFAQgxnfYPZbLcfc0LdC/kAWnEq2K7yZtCrq4gOp6FcutTFaTHS
         j7ytkX3L4wYINqa+a0TJ46jQ13Hs939eLYkuFA7CT1j1Ac0c4TRn6KvbzVG8RF2ywvZj
         8cjZCRvisRfRlpnkfW4ttBaS7PJQU1CIPvosZkQIkyiwK2FWoTVcbeC0cbNWQo5Ry7YT
         TuU5SXcFfZztjk5YVgT+LB8ZrNIJuZapsPYxhAo+aj+P8G5hCdJsguHuEHDvb7KDaBna
         63GQ==
X-Gm-Message-State: ABy/qLb/qds1BeIdrUEIaJe/7u2fSNrmBblbooUskxuu2YDhwK07162p
        mCSKwcEPEMT+YKatFQ2b0Osyi9gxoCaMnrzsJxoOh7dHme8c
X-Google-Smtp-Source: APBJJlEWyE4rK+pNbs4GF/eQajyh1zUUnT+TTk5cMlr2Cyw3UDgmFNVzXVAPTK+V6q9hGSYexl+RD+cseeKUpvzOR8/ldYJv3rKS
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:39a6:b0:676:20f8:be57 with SMTP id
 fi38-20020a056a0039a600b0067620f8be57mr1043341pfb.0.1688606576836; Wed, 05
 Jul 2023 18:22:56 -0700 (PDT)
Date:   Wed, 05 Jul 2023 18:22:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d884205ffc75b9a@google.com>
Subject: [syzbot] [mm?] KASAN: slab-out-of-bounds Read in mt_validate_nulls
From:   syzbot <syzbot+609e63261638ff3d5436@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=116a6d68a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7406f415f386e786
dashboard link: https://syzkaller.appspot.com/bug?extid=609e63261638ff3d5436
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10342968a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d4cf70a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/119fd918f733/disk-a901a356.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/79f9ac119639/vmlinux-a901a356.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8bd8662e2869/bzImage-a901a356.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/183577244af6/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+609e63261638ff3d5436@syzkaller.appspotmail.com

R10: 0000000000002000 R11: 0000000000000246 R12: 00007fb71e6c96b8
R13: 00007fb71e6c9180 R14: 00007fb71e6c91c0 R15: 00007fb71e7a16e8
 </TASK>
==================================================================
BUG: KASAN: slab-out-of-bounds in mt_slot lib/maple_tree.c:816 [inline]
BUG: KASAN: slab-out-of-bounds in mas_slot lib/maple_tree.c:849 [inline]
BUG: KASAN: slab-out-of-bounds in mt_validate_nulls+0xc04/0xd10 lib/maple_tree.c:7172
Read of size 8 at addr ffff8880770ab100 by task syz-executor263/7002

CPU: 0 PID: 7002 Comm: syz-executor263 Not tainted 6.4.0-syzkaller-10173-ga901a3568fd2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:364
 print_report mm/kasan/report.c:475 [inline]
 kasan_report+0x11d/0x130 mm/kasan/report.c:588
 mt_slot lib/maple_tree.c:816 [inline]
 mas_slot lib/maple_tree.c:849 [inline]
 mt_validate_nulls+0xc04/0xd10 lib/maple_tree.c:7172
 mt_validate+0x17e3/0x4370 lib/maple_tree.c:7227
 validate_mm+0x9d/0x470 mm/mmap.c:300
 do_vmi_align_munmap+0x1199/0x1680 mm/mmap.c:2561
 do_vmi_munmap+0x266/0x430 mm/mmap.c:2619
 __vm_munmap+0x137/0x380 mm/mmap.c:2899
 __do_sys_munmap mm/mmap.c:2916 [inline]
 __se_sys_munmap mm/mmap.c:2913 [inline]
 __x64_sys_munmap+0x62/0x80 mm/mmap.c:2913
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb71e71cef7
Code: 00 00 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb 85 66 2e 0f 1f 84 00 00 00 00 00 90 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb71e6c9168 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fb71e71cef7
RDX: 0000000000002000 RSI: 0000000000002000 RDI: 00007fb716288000
RBP: 00007fb716288000 R08: 0000000000000000 R09: 0000000000000176
R10: 0000000000002000 R11: 0000000000000246 R12: 00007fb71e6c96b8
R13: 00007fb71e6c9180 R14: 00007fb71e6c91c0 R15: 00007fb71e7a16e8
 </TASK>

Allocated by task 7002:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3470 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x16c/0x380 mm/slub.c:3494
 mt_alloc_one lib/maple_tree.c:159 [inline]
 mas_alloc_nodes+0x4ec/0x8b0 lib/maple_tree.c:1282
 mas_node_count_gfp+0x106/0x140 lib/maple_tree.c:1362
 mas_node_count lib/maple_tree.c:1376 [inline]
 mas_wr_node_store+0xa64/0x1170 lib/maple_tree.c:4100
 mas_wr_modify+0x28b/0x10d0 lib/maple_tree.c:4346
 mas_wr_store_entry.isra.0+0x495/0x1030 lib/maple_tree.c:4390
 mas_store_gfp+0xce/0x1f0 lib/maple_tree.c:5506
 vma_iter_clear_gfp mm/mmap.c:162 [inline]
 do_vmi_align_munmap+0xd02/0x1680 mm/mmap.c:2538
 do_vmi_munmap+0x266/0x430 mm/mmap.c:2619
 __vm_munmap+0x137/0x380 mm/mmap.c:2899
 __do_sys_munmap mm/mmap.c:2916 [inline]
 __se_sys_munmap mm/mmap.c:2913 [inline]
 __x64_sys_munmap+0x62/0x80 mm/mmap.c:2913
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb9/0xd0 mm/kasan/generic.c:491
 __call_rcu_common.constprop.0+0x99/0x7e0 kernel/rcu/tree.c:2649
 ma_free_rcu lib/maple_tree.c:189 [inline]
 mas_free lib/maple_tree.c:1344 [inline]
 mas_replace+0x98c/0xfa0 lib/maple_tree.c:1785
 mas_wr_node_store+0xcab/0x1170 lib/maple_tree.c:4151
 mas_wr_modify+0x28b/0x10d0 lib/maple_tree.c:4346
 mas_wr_store_entry.isra.0+0x495/0x1030 lib/maple_tree.c:4390
 mas_store_prealloc+0xb3/0x270 lib/maple_tree.c:5529
 mmap_region+0x91c/0x2570 mm/mmap.c:2811
 do_mmap+0x850/0xee0 mm/mmap.c:1362
 vm_mmap_pgoff+0x1a2/0x3b0 mm/util.c:543
 ksys_mmap_pgoff+0x7d/0x5b0 mm/mmap.c:1408
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xb9/0xd0 mm/kasan/generic.c:491
 __call_rcu_common.constprop.0+0x99/0x7e0 kernel/rcu/tree.c:2649
 ma_free_rcu lib/maple_tree.c:189 [inline]
 mas_free lib/maple_tree.c:1344 [inline]
 mas_replace+0x98c/0xfa0 lib/maple_tree.c:1785
 mas_wr_node_store+0xcab/0x1170 lib/maple_tree.c:4151
 mas_wr_modify+0x28b/0x10d0 lib/maple_tree.c:4346
 mas_wr_store_entry.isra.0+0x495/0x1030 lib/maple_tree.c:4390
 mas_store_prealloc+0xb3/0x270 lib/maple_tree.c:5529
 vma_complete+0x8fd/0xdc0 mm/mmap.c:553
 __split_vma+0x53b/0x830 mm/mmap.c:2381
 split_vma+0xc6/0x110 mm/mmap.c:2409
 mprotect_fixup+0x891/0xbd0 mm/mprotect.c:643
 do_mprotect_pkey+0x883/0xd40 mm/mprotect.c:817
 __do_sys_mprotect mm/mprotect.c:838 [inline]
 __se_sys_mprotect mm/mprotect.c:835 [inline]
 __x64_sys_mprotect+0x78/0xb0 mm/mprotect.c:835
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880770ab000
 which belongs to the cache maple_node of size 256
The buggy address is located 0 bytes to the right of
 allocated 256-byte region [ffff8880770ab000, ffff8880770ab100)

The buggy address belongs to the physical page:
page:ffffea0001dc2a80 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x770aa
head:ffffea0001dc2a80 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff88801324d000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 4689, tgid 4689 (dhcpcd-run-hook), ts 21566309288, free_ts 20023594773
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0xfed/0x2d30 mm/page_alloc.c:3221
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4477
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1862 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:2009
 new_slab mm/slub.c:2062 [inline]
 ___slab_alloc+0xbc3/0x15d0 mm/slub.c:3215
 __kmem_cache_alloc_bulk mm/slub.c:3966 [inline]
 kmem_cache_alloc_bulk+0x270/0x860 mm/slub.c:4041
 mt_alloc_bulk lib/maple_tree.c:164 [inline]
 mas_alloc_nodes+0x341/0x8b0 lib/maple_tree.c:1304
 mas_node_count_gfp+0x106/0x140 lib/maple_tree.c:1362
 mas_node_count lib/maple_tree.c:1376 [inline]
 mas_expected_entries+0x117/0x200 lib/maple_tree.c:5656
 vma_iter_bulk_alloc include/linux/mm.h:898 [inline]
 dup_mmap+0x4e4/0x19b0 kernel/fork.c:681
 dup_mm kernel/fork.c:1688 [inline]
 copy_mm kernel/fork.c:1737 [inline]
 copy_process+0x6663/0x75c0 kernel/fork.c:2503
 kernel_clone+0xeb/0x890 kernel/fork.c:2911
 __do_sys_clone+0xba/0x100 kernel/fork.c:3054
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1161 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2348
 free_unref_page+0x33/0x370 mm/page_alloc.c:2443
 qlink_free mm/kasan/quarantine.c:166 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:185
 kasan_quarantine_reduce+0x195/0x220 mm/kasan/quarantine.c:292
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:750 [inline]
 slab_alloc_node mm/slub.c:3470 [inline]
 slab_alloc mm/slub.c:3478 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3485 [inline]
 kmem_cache_alloc+0x16c/0x380 mm/slub.c:3494
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:140
 getname_flags+0x9e/0xe0 include/linux/audit.h:319
 user_path_at_empty+0x2f/0x60 fs/namei.c:2906
 do_readlinkat+0xcd/0x2f0 fs/stat.c:477
 __do_sys_readlink fs/stat.c:510 [inline]
 __se_sys_readlink fs/stat.c:507 [inline]
 __x64_sys_readlink+0x78/0xb0 fs/stat.c:507
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff8880770ab000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880770ab080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880770ab100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff8880770ab180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880770ab200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
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
