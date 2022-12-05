Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42EC6426FB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbiLEKyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiLEKyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:54:45 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5FB192A5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:54:44 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id k21-20020a5e8915000000b006de391b332fso9438453ioj.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 02:54:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+m33asfuiIbtHGCOd5vafMunu1Eq4jlSsL/BLNeMeFU=;
        b=QvOsFwCMohwQheQR78OTsI+l6ECYnarTtoMa5kJKLzqTI7JY/zyeKoyKikz2PiDZts
         +GSs5B5Lu1U9tfHf5jFXmwRBs+Zvn41x6ds2MWmOp32R5tXRqxfTJgKKSk7B/5TfO79D
         YL0bal+ThG2+TE1BQHMbaeggRPYQIBCghb1mOJVDTj3EaerodKRF9cOocg3jM9RwqtOy
         PX4PXUs2JFeVYEAQWYQKZgDD/MZlbSj56nRfdYlPQKnxoMz7m/GAid10dCtIjuHCmYAx
         UOCoKQ5OWWM4KRRpV05iJs3cX21T+RvrMqSzk8PjhM0P10pHnlEuOe6HYnkyluX4SSzK
         EiJQ==
X-Gm-Message-State: ANoB5pkJ+y8HCIb6uTiW/rmu/LlTjHwV7l3liS/Ce0tcc2jnq+o2UojA
        dVzmayoLdjBHOORU6IbKWIkM803+9M9dTJi29DcoxelAlhCO
X-Google-Smtp-Source: AA0mqf4FEXN6vbrR7z1mOCUjOkrNtF5tTaDRPDIFb+HY5lvm52k8a7dk7KWKV6Xwk1Tfbjuhc8ql2ovW7CQC38y7m2axgAVzCGqr
MIME-Version: 1.0
X-Received: by 2002:a02:b38c:0:b0:389:b9a5:f14a with SMTP id
 p12-20020a02b38c000000b00389b9a5f14amr21176938jan.98.1670237683531; Mon, 05
 Dec 2022 02:54:43 -0800 (PST)
Date:   Mon, 05 Dec 2022 02:54:43 -0800
In-Reply-To: <000000000000d6fae905eb9bf51f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d1487305ef1283bc@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in mas_leaf_max_gap
From:   syzbot <syzbot+d915173f90391a04af27@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    9e46a7996732 Add linux-next specific files for 20221125
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1656ef7b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e19c740a0b2926
dashboard link: https://syzkaller.appspot.com/bug?extid=d915173f90391a04af27
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1050206d880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/758d818cf966/disk-9e46a799.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7c8696b40a5/vmlinux-9e46a799.xz
kernel image: https://storage.googleapis.com/syzbot-assets/810f9750b87f/bzImage-9e46a799.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d915173f90391a04af27@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in mas_leaf_max_gap+0x5b1/0x6a0 lib/maple_tree.c:1508
Read of size 8 at addr ffff88807b5d8100 by task syz-executor.1/5436

CPU: 0 PID: 5436 Comm: syz-executor.1 Not tainted 6.1.0-rc6-next-20221125-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:253 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:364
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:464
 mas_leaf_max_gap+0x5b1/0x6a0 lib/maple_tree.c:1508
 mas_max_gap lib/maple_tree.c:1569 [inline]
 mab_set_b_end lib/maple_tree.c:2648 [inline]
 mas_spanning_rebalance.isra.0+0x4714/0x60a0 lib/maple_tree.c:3038
 mas_wr_spanning_store.isra.0+0x5c8/0xfc0 lib/maple_tree.c:4045
 mas_wr_store_entry.isra.0+0xb3f/0xfd0 lib/maple_tree.c:4387
 mas_store_prealloc+0xb3/0x150 lib/maple_tree.c:5704
 do_mas_align_munmap+0xb54/0x1260 mm/mmap.c:2428
 do_mas_munmap+0x26e/0x2c0 mm/mmap.c:2502
 __vm_munmap+0x14f/0x290 mm/mmap.c:2779
 __do_sys_munmap mm/mmap.c:2804 [inline]
 __se_sys_munmap mm/mmap.c:2801 [inline]
 __x64_sys_munmap+0xd5/0x100 mm/mmap.c:2801
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4c0de8c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4c0ec22168 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 00007f4c0dfac120 RCX: 00007f4c0de8c0d9
RDX: 0000000000000000 RSI: 00007fffdf3a3000 RDI: 0000000020c5c000
RBP: 00007f4c0dee7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffb2d4d94f R14: 00007f4c0ec22300 R15: 0000000000022000
 </TASK>

Allocated by task 5436:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x82/0x90 mm/kasan/common.c:330
 kasan_slab_alloc include/linux/kasan.h:202 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 kmem_cache_alloc_bulk+0x3fd/0x850 mm/slub.c:3889
 mt_alloc_bulk lib/maple_tree.c:157 [inline]
 mas_alloc_nodes+0x309/0x810 lib/maple_tree.c:1256
 mas_node_count_gfp lib/maple_tree.c:1315 [inline]
 mas_preallocate+0x1bb/0x360 lib/maple_tree.c:5722
 do_mas_align_munmap+0x129/0x1260 mm/mmap.c:2314
 do_mas_munmap+0x26e/0x2c0 mm/mmap.c:2502
 __vm_munmap+0x14f/0x290 mm/mmap.c:2779
 __do_sys_munmap mm/mmap.c:2804 [inline]
 __se_sys_munmap mm/mmap.c:2801 [inline]
 __x64_sys_munmap+0xd5/0x100 mm/mmap.c:2801
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88807b5d8000
 which belongs to the cache maple_node of size 256
The buggy address is located 0 bytes to the right of
 256-byte region [ffff88807b5d8000, ffff88807b5d8100)

The buggy address belongs to the physical page:
page:ffffea0001ed7600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7b5d8
head:ffffea0001ed7600 order:1 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff8880124cd000 ffffea0000768300 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5001, tgid 5001 (dhcpcd-run-hook), ts 35284488309, free_ts 32325472910
 prep_new_page mm/page_alloc.c:2541 [inline]
 get_page_from_freelist+0x119c/0x2cd0 mm/page_alloc.c:4293
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5551
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1833 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1980
 new_slab mm/slub.c:2033 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3211
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3310
 slab_alloc_node mm/slub.c:3395 [inline]
 slab_alloc mm/slub.c:3441 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3448 [inline]
 kmem_cache_alloc+0x378/0x430 mm/slub.c:3457
 mt_alloc_one lib/maple_tree.c:152 [inline]
 mas_alloc_nodes+0x429/0x810 lib/maple_tree.c:1231
 mas_node_count_gfp lib/maple_tree.c:1315 [inline]
 mas_preallocate+0x1bb/0x360 lib/maple_tree.c:5722
 mmap_region+0x770/0x1dd0 mm/mmap.c:2683
 do_mmap+0x831/0xf60 mm/mmap.c:1412
 vm_mmap_pgoff+0x1af/0x280 mm/util.c:520
 ksys_mmap_pgoff+0x41f/0x5a0 mm/mmap.c:1458
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1448 [inline]
 free_pcp_prepare+0x65c/0xc00 mm/page_alloc.c:1498
 free_unref_page_prepare mm/page_alloc.c:3379 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3474
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2617
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x66/0x90 mm/kasan/common.c:307
 kasan_slab_alloc include/linux/kasan.h:202 [inline]
 slab_post_alloc_hook mm/slab.h:761 [inline]
 slab_alloc_node mm/slub.c:3433 [inline]
 slab_alloc mm/slub.c:3441 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3448 [inline]
 kmem_cache_alloc+0x1e3/0x430 mm/slub.c:3457
 vm_area_alloc+0x20/0x100 kernel/fork.c:458
 mmap_region+0x44c/0x1dd0 mm/mmap.c:2605
 do_mmap+0x831/0xf60 mm/mmap.c:1412
 vm_mmap_pgoff+0x1af/0x280 mm/util.c:520
 ksys_mmap_pgoff+0x7d/0x5a0 mm/mmap.c:1458
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807b5d8000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807b5d8080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88807b5d8100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff88807b5d8180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807b5d8200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================

