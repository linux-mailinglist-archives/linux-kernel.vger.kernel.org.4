Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E506096F1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 00:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJWWDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 18:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJWWDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 18:03:35 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C776C951
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 15:03:33 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id a8-20020a92c548000000b002f6440ff96bso7709044ilj.22
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 15:03:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SEBTrpeXkVsXvjjzgegY5RcjpLfMyyLXL7UFw1cR9Xs=;
        b=1sDayHE1hBc4oQYMpt8jVJzYB/xGExSfvPE6CMAtbS2Tjmc9r6V15jwtwL5xg7WmDR
         9CNqJVSesUwe3zb7yQDvXBbnr6JU80QLN5SjeIjEgmxgdavd/kkhFgZ+OhKt04lN3l9a
         qDSmUrqcvAgertZtDwDJxLgL9rEe+NrbxFPpeDAtGbyx1ydGobiKGO3OLkiiEFfaC9Ja
         hcKeoAZg6uT+MPYFzSObaGbK4ykbAeZQsCRnkuqaUWEOwuN+ucxm9FiWfTn3ZAFEfJDf
         QKY1VaW+B3di+/4Jyd0drQpZQwb9XRPPyRbgAgLP+Y2Sg39xs2htZlbKxNqZt+tdFHH6
         NVDQ==
X-Gm-Message-State: ACrzQf2lemX4zS1KS+FWy0zY/2AH6OI4I9UTQzl67i4z8Ae08UfiE4jy
        HM0hfvvPhocEev+490yvenBWo16BCS3GP7LGmBnfjIpwOmNZ
X-Google-Smtp-Source: AMsMyM4TdIRARwRk8PNp14qV0Vtw+/fyLT9bTYzhlp7kKcO5uPvFa3xsNnii1J0SdifIvF4JOrj87ikyFocxfqU9Nm+v9itSkgIO
MIME-Version: 1.0
X-Received: by 2002:a02:cc18:0:b0:374:507b:8c16 with SMTP id
 n24-20020a02cc18000000b00374507b8c16mr907052jap.296.1666562612824; Sun, 23
 Oct 2022 15:03:32 -0700 (PDT)
Date:   Sun, 23 Oct 2022 15:03:32 -0700
In-Reply-To: <0000000000000eda7a05ebae986e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000888f9a05ebbad8f3@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in hugetlb_fault
From:   syzbot <syzbot+1b27d7a2722eabc2c5d5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, llvm@lists.linux.dev, mike.kravetz@oracle.com,
        nathan@kernel.org, ndesaulniers@google.com,
        songmuchun@bytedance.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    4d48f589d294 Add linux-next specific files for 20221021
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=165e09b4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4b7d600a5739a6
dashboard link: https://syzkaller.appspot.com/bug?extid=1b27d7a2722eabc2c5d5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1546e96a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123eabd2880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0c86bd0b39a0/disk-4d48f589.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/074059d37f1f/vmlinux-4d48f589.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1b27d7a2722eabc2c5d5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read include/linux/instrumented.h:72 [inline]
BUG: KASAN: use-after-free in atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
BUG: KASAN: use-after-free in is_rwsem_reader_owned kernel/locking/rwsem.c:193 [inline]
BUG: KASAN: use-after-free in __down_read_common kernel/locking/rwsem.c:1262 [inline]
BUG: KASAN: use-after-free in __down_read_common kernel/locking/rwsem.c:1255 [inline]
BUG: KASAN: use-after-free in __down_read kernel/locking/rwsem.c:1269 [inline]
BUG: KASAN: use-after-free in down_read+0x1d3/0x450 kernel/locking/rwsem.c:1511
Read of size 8 at addr ffff88801263a508 by task syz-executor409/3698

CPU: 1 PID: 3698 Comm: syz-executor409 Not tainted 6.1.0-rc1-next-20221021-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:253 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:364
 kasan_report+0xbb/0x1f0 mm/kasan/report.c:464
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:72 [inline]
 atomic_long_read include/linux/atomic/atomic-instrumented.h:1265 [inline]
 is_rwsem_reader_owned kernel/locking/rwsem.c:193 [inline]
 __down_read_common kernel/locking/rwsem.c:1262 [inline]
 __down_read_common kernel/locking/rwsem.c:1255 [inline]
 __down_read kernel/locking/rwsem.c:1269 [inline]
 down_read+0x1d3/0x450 kernel/locking/rwsem.c:1511
 hugetlb_vma_lock_read mm/hugetlb.c:6889 [inline]
 hugetlb_fault+0x40a/0x2690 mm/hugetlb.c:5864
 follow_hugetlb_page+0x3f3/0x1700 mm/hugetlb.c:6374
 __get_user_pages+0x2be/0xee0 mm/gup.c:1081
 populate_vma_page_range+0x23d/0x320 mm/gup.c:1464
 __mm_populate+0x101/0x3a0 mm/gup.c:1578
 mm_populate include/linux/mm.h:2714 [inline]
 vm_mmap_pgoff+0x1fd/0x270 mm/util.c:525
 ksys_mmap_pgoff+0x1c3/0x5a0 mm/mmap.c:1458
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb24903a869
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb248fec2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fb24903a869
RDX: 0000000000000003 RSI: 0000000000b36000 RDI: 0000000020000000
RBP: 00007fb2490c23e8 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000068831 R11: 0000000000000246 R12: 00007fb2490c23e0
R13: 00007fb2490c23ec R14: 00007fb248fec400 R15: 0000000000022000
 </TASK>

Allocated by task 3698:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 __kasan_unpoison_range-0xf/0x10
 ____kasan_slab_free-0xf/0x1c0
 kmalloc include/linux/slab.h:582 [inline]
 hugetlb_vma_lock_alloc.part.0+0x3f/0x130 mm/hugetlb.c:6999
 hugetlb_vma_lock_alloc mm/hugetlb.c:6755 [inline]
 hugetlb_reserve_pages+0xa3f/0xe80 mm/hugetlb.c:6624
 hugetlbfs_file_mmap+0x40c/0x5c0 fs/hugetlbfs/inode.c:167
 call_mmap include/linux/fs.h:2196 [inline]
 mmap_region+0x6bf/0x1c00 mm/mmap.c:2625
 do_mmap+0x825/0xf50 mm/mmap.c:1412
 vm_mmap_pgoff+0x1ab/0x270 mm/util.c:520
 ksys_mmap_pgoff+0x1c3/0x5a0 mm/mmap.c:1458
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3699:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 __kasan_unpoison_range-0xf/0x10
 kasan_save_free_info+0x2a/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1750
 slab_free mm/slub.c:3666 [inline]
 __kmem_cache_free+0xab/0x3b0 mm/slub.c:3679
 hugetlb_vma_lock_release mm/hugetlb.c:6944 [inline]
 kref_put include/linux/kref.h:65 [inline]
 __hugetlb_vma_unlock_write_put mm/hugetlb.c:6959 [inline]
 __hugetlb_vma_unlock_write_free mm/hugetlb.c:6967 [inline]
 __unmap_hugepage_range_final+0x2ad/0x340 mm/hugetlb.c:5223
 unmap_single_vma+0x23d/0x2a0 mm/memory.c:1690
 zap_page_range+0x38a/0x520 mm/memory.c:1762
 madvise_dontneed_single_vma mm/madvise.c:793 [inline]
 madvise_dontneed_free mm/madvise.c:876 [inline]
 madvise_vma_behavior+0xee8/0x1c50 mm/madvise.c:1015
 madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1240
 do_madvise.part.0+0x24a/0x340 mm/madvise.c:1419
 do_madvise mm/madvise.c:1432 [inline]
 __do_sys_madvise mm/madvise.c:1432 [inline]
 __se_sys_madvise mm/madvise.c:1430 [inline]
 __x64_sys_madvise+0x113/0x150 mm/madvise.c:1430
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801263a500
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 8 bytes inside of
 192-byte region [ffff88801263a500, ffff88801263a5c0)

The buggy address belongs to the physical page:
page:ffffea0000498e80 refcount:1 mapcount:0 mapping:0000000000000000 index:0xdead000000000100 pfn:0x1263a
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888011841a00 dead000080100010 0000000000000000
raw: dead000000000100 dead000000000122 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 1916075750, free_ts 0
 prep_new_page mm/page_alloc.c:2538 [inline]
 get_page_from_freelist+0x10b5/0x2d50 mm/page_alloc.c:4287
 __alloc_pages+0x1c7/0x5a0 mm/page_alloc.c:5546
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2118
 alloc_pages+0x22f/0x270 mm/mempolicy.c:2280
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x213/0x300 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3185
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3284
 slab_alloc_node mm/slub.c:3369 [inline]
 __kmem_cache_alloc_node+0x191/0x3e0 mm/slub.c:3442
 kmalloc_trace+0x22/0x60 mm/slab_common.c:1046
 kmalloc include/linux/slab.h:582 [inline]
 kzalloc include/linux/slab.h:718 [inline]
 kset_create lib/kobject.c:937 [inline]
 kset_create_and_add+0x4b/0x1a0 lib/kobject.c:980
 devices_init+0x23/0xe1 drivers/base/core.c:3957
 driver_init+0x1b/0x48 drivers/base/init.c:26
 do_basic_setup init/main.c:1411 [inline]
 kernel_init_freeable+0x4e3/0x782 init/main.c:1634
 kernel_init+0x1a/0x1d0 init/main.c:1522
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88801263a400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801263a480: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801263a500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff88801263a580: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88801263a600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

