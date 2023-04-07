Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC76DB0C2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 18:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDGQhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 12:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjDGQhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 12:37:11 -0400
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB91BBDF1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 09:36:50 -0700 (PDT)
Received: by mail-il1-f205.google.com with SMTP id d11-20020a056e020c0b00b00326156e3a8bso22314945ile.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 09:36:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680885410; x=1683477410;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nplfd14bvjlVkVD4YGNhodAVpFm+bek0gQyvwM51NR0=;
        b=PQhhl/nNrZlacewTjl+irLO7uJ+INbaOiO5WGDODcwsUPTI4YG0WBZME5r6EieRPPg
         QG26FgHGpeE44+wU6hWLzLrXfGG/UMZlUkbwdwmEWJjEQw60wLxZroP9bid4q3gMwNLg
         TFDRWtwtyDFsnCpBh0sPr8t5KC/CJ45cFS4M8WL1dwBrxKaateDvpqfyXqlNnH3DIZPS
         d/zyAc9UhpiG2q5bdpOQ4QgMQm6TfEvxbCjwXAEU7rPk60AVaKvkwac+VJ93tB6OfWVj
         KE4PETHr8xeQdzc6S1XX2q2itljPqrLq9tUxNIf2/482JF3xNm4g3SBJFsi3o4yBgVIK
         28Bg==
X-Gm-Message-State: AAQBX9ctK/hLFAbuEJ94Mpu4BsHkwY4geGAe5Nv8sEK7m58S2Tvn/NuP
        UBAw3yUn/MaNDcuPidiNDznMRRyjL4JnIvilLJNsElN+Aro+
X-Google-Smtp-Source: AKy350Ypwj/ORNJEGLLCVhuTTM1jykqC3q048BwD2lOYvlDa+PTCUlHT9+a6a/qs4tbnzXfXtCHLEEOo+dBDrK9BkFUSaGqaExJz
MIME-Version: 1.0
X-Received: by 2002:a02:b105:0:b0:3f6:e3c2:d4bd with SMTP id
 r5-20020a02b105000000b003f6e3c2d4bdmr616460jah.0.1680885409999; Fri, 07 Apr
 2023 09:36:49 -0700 (PDT)
Date:   Fri, 07 Apr 2023 09:36:49 -0700
In-Reply-To: <000000000000c93feb05f87e24ad@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c573b305f8c1a189@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in mas_next_entry
From:   syzbot <syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.7 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_SBL_A autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    f2afccfefe7b Merge tag 'net-6.3-rc6-2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1642b49bc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3500b143c204867
dashboard link: https://syzkaller.appspot.com/bug?extid=a7c1ec5b1d71ceaa5186
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1033df79c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4c6e0baeb7c2/disk-f2afccfe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82431f1611cf/vmlinux-f2afccfe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/82e1059905ee/bzImage-f2afccfe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a7c1ec5b1d71ceaa5186@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in mas_safe_min lib/maple_tree.c:727 [inline]
BUG: KASAN: slab-use-after-free in mas_next_nentry lib/maple_tree.c:4664 [inline]
BUG: KASAN: slab-use-after-free in mas_next_entry+0x12b3/0x1690 lib/maple_tree.c:4760
Read of size 8 at addr ffff8880782e0440 by task syz-executor.3/5331

CPU: 0 PID: 5331 Comm: syz-executor.3 Not tainted 6.3.0-rc5-syzkaller-00137-gf2afccfefe7b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
 print_report mm/kasan/report.c:430 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:536
 mas_safe_min lib/maple_tree.c:727 [inline]
 mas_next_nentry lib/maple_tree.c:4664 [inline]
 mas_next_entry+0x12b3/0x1690 lib/maple_tree.c:4760
 mas_find+0x7d/0x200 lib/maple_tree.c:6025
 vma_find include/linux/mm.h:736 [inline]
 __do_sys_set_mempolicy_home_node+0x1ef/0x480 mm/mempolicy.c:1524
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f730dc8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f730ea05168 EFLAGS: 00000246 ORIG_RAX: 00000000000001c2
RAX: ffffffffffffffda RBX: 00007f730ddabf80 RCX: 00007f730dc8c169
RDX: 0000000000000000 RSI: 0000000000003000 RDI: 0000000020ffd000
RBP: 00007f730dce7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f730decfb1f R14: 00007f730ea05300 R15: 0000000000022000
 </TASK>

Allocated by task 5335:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 kmem_cache_alloc_bulk+0x424/0x860 mm/slub.c:4034
 mt_alloc_bulk lib/maple_tree.c:164 [inline]
 mas_alloc_nodes+0x276/0x8a0 lib/maple_tree.c:1263
 mas_node_count_gfp lib/maple_tree.c:1318 [inline]
 mas_preallocate+0x1bb/0x360 lib/maple_tree.c:5717
 vma_iter_prealloc mm/internal.h:972 [inline]
 __split_vma+0x1b7/0x810 mm/mmap.c:2177
 do_vmi_align_munmap+0x34a/0xf60 mm/mmap.c:2320
 do_vmi_munmap+0x26e/0x2c0 mm/mmap.c:2452
 mmap_region+0x1ee/0x2620 mm/mmap.c:2500
 do_mmap+0x831/0xf60 mm/mmap.c:1364
 vm_mmap_pgoff+0x1af/0x280 mm/util.c:542
 ksys_mmap_pgoff+0x41f/0x5a0 mm/mmap.c:1410
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5331:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 kmem_cache_free_bulk.part.0+0x20c/0x680 mm/slub.c:3905
 mt_free_bulk lib/maple_tree.c:169 [inline]
 mas_destroy+0x3e0/0x650 lib/maple_tree.c:5771
 mas_store_prealloc+0xf0/0x150 lib/maple_tree.c:5702
 vma_iter_store mm/internal.h:1013 [inline]
 vma_complete+0xad9/0x1170 mm/mmap.c:572
 __split_vma+0x523/0x810 mm/mmap.c:2214
 split_vma+0xc6/0x110 mm/mmap.c:2242
 mbind_range+0x4d2/0x760 mm/mempolicy.c:829
 __do_sys_set_mempolicy_home_node+0x323/0x480 mm/mempolicy.c:1546
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880782e0400
 which belongs to the cache maple_node of size 256
The buggy address is located 64 bytes inside of
 freed 256-byte region [ffff8880782e0400, ffff8880782e0500)

The buggy address belongs to the physical page:
page:ffffea0001e0b800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x782e0
head:ffffea0001e0b800 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff8880124cd000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5335, tgid 5329 (syz-executor.3), ts 114724293643, free_ts 114618496841
 prep_new_page mm/page_alloc.c:2553 [inline]
 get_page_from_freelist+0x1190/0x2e20 mm/page_alloc.c:4326
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:5592
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __kmem_cache_alloc_bulk mm/slub.c:3952 [inline]
 kmem_cache_alloc_bulk+0x270/0x860 mm/slub.c:4027
 mt_alloc_bulk lib/maple_tree.c:164 [inline]
 mas_alloc_nodes+0x276/0x8a0 lib/maple_tree.c:1263
 mas_node_count_gfp lib/maple_tree.c:1318 [inline]
 mas_preallocate+0x1bb/0x360 lib/maple_tree.c:5717
 vma_iter_prealloc mm/internal.h:972 [inline]
 __split_vma+0x1b7/0x810 mm/mmap.c:2177
 do_vmi_align_munmap+0x34a/0xf60 mm/mmap.c:2320
 do_vmi_munmap+0x26e/0x2c0 mm/mmap.c:2452
 mmap_region+0x1ee/0x2620 mm/mmap.c:2500
 do_mmap+0x831/0xf60 mm/mmap.c:1364
 vm_mmap_pgoff+0x1af/0x280 mm/util.c:542
 ksys_mmap_pgoff+0x41f/0x5a0 mm/mmap.c:1410
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1454 [inline]
 free_pcp_prepare+0x5d5/0xa50 mm/page_alloc.c:1504
 free_unref_page_prepare mm/page_alloc.c:3388 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3483
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x192/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x17c/0x3b0 mm/slub.c:3476
 __mpol_dup+0x76/0x390 mm/mempolicy.c:2407
 mpol_dup include/linux/mempolicy.h:88 [inline]
 vma_replace_policy mm/mempolicy.c:773 [inline]
 mbind_range+0x132/0x760 mm/mempolicy.c:839
 __do_sys_set_mempolicy_home_node+0x323/0x480 mm/mempolicy.c:1546
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff8880782e0300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880782e0380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880782e0400: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff8880782e0480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880782e0500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

