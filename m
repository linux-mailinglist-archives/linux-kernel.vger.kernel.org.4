Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAB07326FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241882AbjFPGBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241879AbjFPGBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:01:16 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA842D59
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:01:14 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-77b25d256aaso30141539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:01:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686895273; x=1689487273;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuhMsJImBWZkS4STwMps+fTTdmfKxPPAWibcumrJnTw=;
        b=R9xbKjdw/Yn3k7VYUBFjvbxKqStP5En/KNjbJWpK42HW2S+HsKoHCvWn1rf37kEWo8
         AX7pXWMLkHXB6bRXUw3UH71SB41Ue7hCD4tVQdkwHrbyZCNYY9LWn78Y1nH2NA5tXnom
         8xau72y+GG1nzrIYKau/JUNR8mtZ89Meo5AK2eVhd0I+xwn4qytvUmMro0Azd7Nl39cv
         3AA1t3gHJc9YarYvAbPH62oha3HNOgvRbnl51Yg4qAPEEx9t6njqlygRtg5wuTQ6p8Z3
         plRA23aFN7PpWOfvPdjFdHRBGs3vJ9v+0tqw3vdjX6l0dhkZEQi4PS4FHPGUxO+3SJy9
         MMJg==
X-Gm-Message-State: AC+VfDwLUYYJvaZdj9Xhy782yXAbFcRoZaGMGIhLiq95dVLW7oi8+CvA
        kwWmyvuSWOAri4GYKMIZJeU3WVDqMloxjxBnCcscljtztVcr
X-Google-Smtp-Source: ACHHUZ4Zv7gZoLXBlKgNdxHDzQ8VYsD70jvWV6omTecSakxDyWb6dBr3PyQwmIKbJrVqap1IXaBGA/2L7QhK6wJm5LN9+bX826tm
MIME-Version: 1.0
X-Received: by 2002:a92:d391:0:b0:341:da64:d82d with SMTP id
 o17-20020a92d391000000b00341da64d82dmr531139ilo.6.1686895273723; Thu, 15 Jun
 2023 23:01:13 -0700 (PDT)
Date:   Thu, 15 Jun 2023 23:01:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000905eba05fe38e9f2@google.com>
Subject: [syzbot] [iommu?] KASAN: slab-use-after-free Read in iommufd_access_unpin_pages
From:   syzbot <syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com>
To:     iommu@lists.linux.dev, jgg@ziepe.ca, joro@8bytes.org,
        kevin.tian@intel.com, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, syzkaller-bugs@googlegroups.com,
        will@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4c605260bc60 Merge tag 'x86_urgent_for_v6.4_rc6' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d07943280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
dashboard link: https://syzkaller.appspot.com/bug?extid=6c8d756f238a75fc3eb8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=158a29dd280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=167dd475280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9c4a756cb2ce/disk-4c605260.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/321df5350ca6/vmlinux-4c605260.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f117647a1dc2/bzImage-4c605260.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c8d756f238a75fc3eb8@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in iopt_area_last_iova drivers/iommu/iommufd/io_pagetable.h:88 [inline]
BUG: KASAN: slab-use-after-free in iopt_area_contig_done drivers/iommu/iommufd/io_pagetable.h:160 [inline]
BUG: KASAN: slab-use-after-free in iommufd_access_unpin_pages+0x363/0x370 drivers/iommu/iommufd/device.c:557
Read of size 8 at addr ffff888022286e20 by task syz-executor669/5771

CPU: 0 PID: 5771 Comm: syz-executor669 Not tainted 6.4.0-rc5-syzkaller-00313-g4c605260bc60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 iopt_area_last_iova drivers/iommu/iommufd/io_pagetable.h:88 [inline]
 iopt_area_contig_done drivers/iommu/iommufd/io_pagetable.h:160 [inline]
 iommufd_access_unpin_pages+0x363/0x370 drivers/iommu/iommufd/device.c:557
 iommufd_test_access_unmap+0x24b/0x390 drivers/iommu/iommufd/selftest.c:613
 iommufd_access_notify_unmap+0x24c/0x3a0 drivers/iommu/iommufd/device.c:520
 iopt_unmap_iova_range+0x4c4/0x5f0 drivers/iommu/iommufd/io_pagetable.c:497
 iopt_unmap_all+0x27/0x50 drivers/iommu/iommufd/io_pagetable.c:555
 iommufd_ioas_unmap+0x3d0/0x490 drivers/iommu/iommufd/ioas.c:300
 iommufd_fops_ioctl+0x317/0x4b0 drivers/iommu/iommufd/main.c:337
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fec1dae3b19
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fec1da74308 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fec1db6b438 RCX: 00007fec1dae3b19
RDX: 0000000020000100 RSI: 0000000000003b86 RDI: 0000000000000003
RBP: 00007fec1db6b430 R08: 00007fec1da74700 R09: 0000000000000000
R10: 00007fec1da74700 R11: 0000000000000246 R12: 00007fec1db6b43c
R13: 00007fec1db39074 R14: 6d6f692f7665642f R15: 0000000000022000
 </TASK>

Allocated by task 5770:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 iopt_alloc_area_pages+0x94/0x560 drivers/iommu/iommufd/io_pagetable.c:234
 iopt_map_pages drivers/iommu/iommufd/io_pagetable.c:339 [inline]
 iopt_map_user_pages+0x205/0x4e0 drivers/iommu/iommufd/io_pagetable.c:404
 iommufd_ioas_map+0x329/0x5f0 drivers/iommu/iommufd/ioas.c:222
 iommufd_fops_ioctl+0x317/0x4b0 drivers/iommu/iommufd/main.c:337
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 5770:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3786 [inline]
 __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3799
 iopt_abort_area drivers/iommu/iommufd/io_pagetable.c:292 [inline]
 iopt_unmap_iova_range+0x288/0x5f0 drivers/iommu/iommufd/io_pagetable.c:509
 iopt_unmap_all+0x27/0x50 drivers/iommu/iommufd/io_pagetable.c:555
 iommufd_ioas_unmap+0x3d0/0x490 drivers/iommu/iommufd/ioas.c:300
 iommufd_fops_ioctl+0x317/0x4b0 drivers/iommu/iommufd/main.c:337
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888022286e00
 which belongs to the cache kmalloc-cg-192 of size 192
The buggy address is located 32 bytes inside of
 freed 192-byte region [ffff888022286e00, ffff888022286ec0)

The buggy address belongs to the physical page:
page:ffffea000088a180 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x22286
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff88801244ddc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5725, tgid 5724 (syz-executor669), ts 62798621274, free_ts 62769254078
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
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3490
 kmalloc_trace+0x26/0xe0 mm/slab_common.c:1057
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 iopt_alloc_area_pages+0x94/0x560 drivers/iommu/iommufd/io_pagetable.c:234
 iopt_map_pages drivers/iommu/iommufd/io_pagetable.c:339 [inline]
 iopt_map_user_pages+0x205/0x4e0 drivers/iommu/iommufd/io_pagetable.c:404
 iommufd_ioas_map+0x329/0x5f0 drivers/iommu/iommufd/ioas.c:222
 iommufd_fops_ioctl+0x317/0x4b0 drivers/iommu/iommufd/main.c:337
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
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
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9b0/0x29b0 kernel/exit.c:861
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888022286d00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888022286d80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888022286e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                               ^
 ffff888022286e80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888022286f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
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
