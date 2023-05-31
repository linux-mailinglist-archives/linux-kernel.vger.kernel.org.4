Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912E07177A0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjEaHRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjEaHRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:17:04 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9754CEE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:17:01 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-770222340cfso712724339f.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685517421; x=1688109421;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PK5dR/6cD4YPGCq8YgMTD9K9fOKLXozTYz5JKJ25ApI=;
        b=QteKD/9hYH9EfhyKQB1fH456s2A/m45WoYC92tSNil0T5Ohbt/raeasJGUKT2SCTkf
         ESj+lYun+/hNhjww7Uw7rGnJff316EmHyLkjiRk/Mwoh6AOpyrlvYVWtOBpxUHMRzVmt
         UG4H9+jmDFcTlrXzL9fPnGeMv7ODlQHq7onOqNdlTie76tx03SwntAYk1CGdXBqP9zfK
         UiCyX17aPQv92WMByPtLHSuqSbJLP4Al8vGhaLztYmMUemeApTkNkan0Rm3lIvWzbP+i
         W/nvutvu/NVgme3Qe10Ptoe8fiV/2aOY/FdLDUG28EKEnuVnDHLR+JGp8Q+KzqtVCjZy
         88aA==
X-Gm-Message-State: AC+VfDwlf7ifzRiI/v6kypbzuZCfF9JIOfNWCxzaMqhBRSGhtjdy2Sge
        olsgdIpMdp1dtWbtGYlJ2FFXVQ/7WPA+kOrFpqZDcj7NDbZW
X-Google-Smtp-Source: ACHHUZ5Di1MnDtfPZcaoJtP0jhr+X3FJKwvu+120ohe9fXVwQLTDSC4Z/cyDjZbQTzziFyFrg6kKRFQpqNCmq2vFfZP2jlcDPM7B
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4203:b0:766:6741:8856 with SMTP id
 cb3-20020a056602420300b0076667418856mr2055100iob.4.1685517420988; Wed, 31 May
 2023 00:17:00 -0700 (PDT)
Date:   Wed, 31 May 2023 00:17:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000024123505fcf81bda@google.com>
Subject: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_prev_nentry
From:   syzbot <syzbot+f3728183b2f78d0d40f6@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    91a304340a22 Merge tag 'gpio-fixes-for-v6.4-rc4' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13244ec1280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=64baed516d970baf
dashboard link: https://syzkaller.appspot.com/bug?extid=f3728183b2f78d0d40f6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12a3ad4d280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a3baec566894/disk-91a30434.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/deff6917d289/vmlinux-91a30434.xz
kernel image: https://storage.googleapis.com/syzbot-assets/15d604397fc3/bzImage-91a30434.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f3728183b2f78d0d40f6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in mas_safe_min lib/maple_tree.c:734 [inline]
BUG: KASAN: slab-use-after-free in mas_prev_nentry+0x18f5/0x1a00 lib/maple_tree.c:4888
Read of size 8 at addr ffff88802054c618 by task syz-executor.5/27952

CPU: 1 PID: 27952 Comm: syz-executor.5 Not tainted 6.4.0-rc3-syzkaller-00226-g91a304340a22 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/16/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 mas_safe_min lib/maple_tree.c:734 [inline]
 mas_prev_nentry+0x18f5/0x1a00 lib/maple_tree.c:4888
 mas_prev_entry lib/maple_tree.c:4914 [inline]
 mas_prev_entry lib/maple_tree.c:4903 [inline]
 mas_prev+0x124/0x720 lib/maple_tree.c:5999
 find_mergeable_anon_vma+0x16b/0x870 mm/mmap.c:1137
 __anon_vma_prepare+0x7d/0x580 mm/rmap.c:200
 anon_vma_prepare include/linux/rmap.h:159 [inline]
 do_anonymous_page mm/memory.c:4083 [inline]
 do_pte_missing mm/memory.c:3645 [inline]
 handle_pte_fault mm/memory.c:4947 [inline]
 __handle_mm_fault+0x34ed/0x41c0 mm/memory.c:5089
 handle_mm_fault+0x2af/0x9f0 mm/memory.c:5243
 faultin_page mm/gup.c:925 [inline]
 __get_user_pages+0x60a/0x10e0 mm/gup.c:1147
 populate_vma_page_range+0x2df/0x420 mm/gup.c:1543
 __mm_populate+0x105/0x3b0 mm/gup.c:1652
 mm_populate include/linux/mm.h:3153 [inline]
 vm_mmap_pgoff+0x2c2/0x3b0 mm/util.c:548
 ksys_mmap_pgoff+0x7d/0x5a0 mm/mmap.c:1440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f209948c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f209a116168 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007f20995abf80 RCX: 00007f209948c169
RDX: 0000000000000002 RSI: 0000000000001000 RDI: 0000000020002000
RBP: 00007f20994e7ca1 R08: ffffffffffffffff R09: 0000000000000000
R10: 840000000000a132 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffd380b1af R14: 00007f209a116300 R15: 0000000000022000
 </TASK>

Allocated by task 27951:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:711 [inline]
 kmem_cache_alloc_bulk+0x424/0x860 mm/slub.c:4033
 mt_alloc_bulk lib/maple_tree.c:164 [inline]
 mas_alloc_nodes+0x332/0x880 lib/maple_tree.c:1309
 mas_node_count_gfp lib/maple_tree.c:1367 [inline]
 mas_preallocate+0x1bb/0x360 lib/maple_tree.c:5775
 vma_iter_prealloc mm/internal.h:1029 [inline]
 __split_vma+0x1b7/0x830 mm/mmap.c:2253
 split_vma+0xc6/0x110 mm/mmap.c:2318
 mprotect_fixup+0x90e/0xbd0 mm/mprotect.c:692
 do_mprotect_pkey+0x87f/0xd50 mm/mprotect.c:860
 __do_sys_mprotect mm/mprotect.c:881 [inline]
 __se_sys_mprotect mm/mprotect.c:878 [inline]
 __x64_sys_mprotect+0x78/0xb0 mm/mprotect.c:878
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 15:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3786 [inline]
 kmem_cache_free+0xe9/0x480 mm/slub.c:3808
 rcu_do_batch kernel/rcu/tree.c:2115 [inline]
 rcu_core+0x806/0x1ad0 kernel/rcu/tree.c:2377
 __do_softirq+0x1d4/0x905 kernel/softirq.c:571

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 __call_rcu_common.constprop.0+0x99/0x7e0 kernel/rcu/tree.c:2627
 ma_free_rcu lib/maple_tree.c:189 [inline]
 mas_free lib/maple_tree.c:1349 [inline]
 mas_replace+0x80b/0x12c0 lib/maple_tree.c:1788
 mas_wr_node_store+0x106b/0x1670 lib/maple_tree.c:4200
 mas_wr_modify+0x2cf/0x16d0 lib/maple_tree.c:4394
 mas_wr_store_entry.isra.0+0x4fb/0x1090 lib/maple_tree.c:4439
 mas_store_prealloc+0xb3/0x150 lib/maple_tree.c:5758
 expand_downwards+0x98a/0xdc0 mm/mmap.c:2096
 do_user_addr_fault+0x93e/0x1210 arch/x86/mm/fault.c:1412
 handle_page_fault arch/x86/mm/fault.c:1534 [inline]
 exc_page_fault+0x98/0x170 arch/x86/mm/fault.c:1590
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 __call_rcu_common.constprop.0+0x99/0x7e0 kernel/rcu/tree.c:2627
 ma_free_rcu lib/maple_tree.c:189 [inline]
 mas_free lib/maple_tree.c:1349 [inline]
 mas_replace+0x80b/0x12c0 lib/maple_tree.c:1788
 mas_wr_node_store+0x106b/0x1670 lib/maple_tree.c:4200
 mas_wr_modify+0x2cf/0x16d0 lib/maple_tree.c:4394
 mas_wr_store_entry.isra.0+0x4fb/0x1090 lib/maple_tree.c:4439
 mas_store_gfp+0xce/0x1f0 lib/maple_tree.c:5735
 vma_iter_clear_gfp mm/mmap.c:162 [inline]
 do_vmi_align_munmap+0xc1c/0x1580 mm/mmap.c:2451
 do_vmi_munmap+0x26e/0x2c0 mm/mmap.c:2530
 mmap_region+0x1f0/0x28d0 mm/mmap.c:2578
 do_mmap+0x831/0xf60 mm/mmap.c:1394
 vm_mmap_pgoff+0x1a2/0x3b0 mm/util.c:543
 ksys_mmap_pgoff+0x7d/0x5a0 mm/mmap.c:1440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88802054c600
 which belongs to the cache maple_node of size 256
The buggy address is located 24 bytes inside of
 freed 256-byte region [ffff88802054c600, ffff88802054c700)

The buggy address belongs to the physical page:
page:ffffea0000815300 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2054c
head:ffffea0000815300 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012e4d000 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 26530, tgid 26529 (syz-executor.2), ts 330845588771, free_ts 289803768600
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0xf41/0x2c00 mm/page_alloc.c:3502
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
 __kmem_cache_alloc_bulk mm/slub.c:3951 [inline]
 kmem_cache_alloc_bulk+0x270/0x860 mm/slub.c:4026
 mt_alloc_bulk lib/maple_tree.c:164 [inline]
 mas_alloc_nodes+0x332/0x880 lib/maple_tree.c:1309
 mas_node_count_gfp lib/maple_tree.c:1367 [inline]
 mas_preallocate+0x1bb/0x360 lib/maple_tree.c:5775
 vma_iter_prealloc mm/internal.h:1029 [inline]
 mmap_region+0x84c/0x28d0 mm/mmap.c:2711
 do_mmap+0x831/0xf60 mm/mmap.c:1394
 vm_mmap_pgoff+0x1a2/0x3b0 mm/util.c:543
 ksys_mmap_pgoff+0x7d/0x5a0 mm/mmap.c:1440
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2564
 free_unref_page_list+0xe3/0xa70 mm/page_alloc.c:2705
 release_pages+0xcd8/0x1380 mm/swap.c:1042
 tlb_batch_pages_flush+0xa8/0x1a0 mm/mmu_gather.c:97
 tlb_flush_mmu_free mm/mmu_gather.c:292 [inline]
 tlb_flush_mmu mm/mmu_gather.c:299 [inline]
 tlb_finish_mmu+0x14b/0x7e0 mm/mmu_gather.c:391
 exit_mmap+0x2b2/0x930 mm/mmap.c:3123
 __mmput+0x128/0x4c0 kernel/fork.c:1351
 mmput+0x60/0x70 kernel/fork.c:1373
 exit_mm kernel/exit.c:564 [inline]
 do_exit+0x9d7/0x2960 kernel/exit.c:858
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
 get_signal+0x2315/0x25b0 kernel/signal.c:2874
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88802054c500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802054c580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88802054c600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                            ^
 ffff88802054c680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88802054c700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
