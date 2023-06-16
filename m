Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5A173268E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbjFPFTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbjFPFTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:19:12 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40630294E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:19:10 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-77ade29e1easo28187539f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686892749; x=1689484749;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ySAhRrPH4UiQ0829ONIJ39ZvetYIG76OqcC8MyYo+jk=;
        b=c7ZXijadmjx6JieM/wtu2KgaPRY6teOZQdOzarpVmcllVajOSdaKDDJC2KYDPuPBcQ
         jmwo1d8tnB3terzlMSVzFCMlXnhU/qvEsYhoBREYvUY+se2fB1wW6i6giQnlXaR5VYHP
         /oNNWq2yLjwXYl1sKa25yD/vJxkUylGuzL+hvCnJjZshxUiN2th0mee6zVFVolD0VWY3
         1A0hR8ArlKEu/jDHx12GPmDICxQ/KOz9f6aHD2iie6+EGhfJm4GS8j3f/x4QY2eSs7/o
         svZ15JIJnLwiVnzuv+M7eAwLPH9rBOpMzf7g6qIkC0r1UJfyMx/9LzFbWXYhuR5DYndE
         CJPA==
X-Gm-Message-State: AC+VfDz3UE579Qv9fB3mmQfk50neS2y1O59RKDQ5WKGKubxFVGnvLzZH
        7ni6d7dHiHpLEp0g8WZSUShxdVOy6RXIi+l1xG93ub5z/20l
X-Google-Smtp-Source: ACHHUZ7QPWfFGSqh39SUkK24lZWaJjn7tGlLbRZK1JNMkLxU9+ZGaz2MydIAfb6chk6gOUtC5tJY3b1g+5+sDb3ebX3lZMyi9F8M
MIME-Version: 1.0
X-Received: by 2002:a5e:8c11:0:b0:76c:6610:9d6c with SMTP id
 n17-20020a5e8c11000000b0076c66109d6cmr475691ioj.0.1686892749601; Thu, 15 Jun
 2023 22:19:09 -0700 (PDT)
Date:   Thu, 15 Jun 2023 22:19:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d40fc05fe385332@google.com>
Subject: [syzbot] [iommu?] KASAN: slab-use-after-free Read in iopt_unmap_iova_range
From:   syzbot <syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=103c6a63280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c980bfe8b399968
dashboard link: https://syzkaller.appspot.com/bug?extid=1ad12d16afca0e7d2dde
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9c4a756cb2ce/disk-4c605260.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/321df5350ca6/vmlinux-4c605260.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f117647a1dc2/bzImage-4c605260.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in iopt_unmap_iova_range+0x5ba/0x5f0 drivers/iommu/iommufd/io_pagetable.c:499
Read of size 4 at addr ffff888075996184 by task syz-executor.2/31160

CPU: 1 PID: 31160 Comm: syz-executor.2 Not tainted 6.4.0-rc5-syzkaller-00313-g4c605260bc60 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 iopt_unmap_iova_range+0x5ba/0x5f0 drivers/iommu/iommufd/io_pagetable.c:499
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
RIP: 0033:0x7f0812c8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0813914168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0812dabf80 RCX: 00007f0812c8c169
RDX: 0000000020000100 RSI: 0000000000003b86 RDI: 0000000000000005
RBP: 00007f0812ce7ca1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0812ecfb1f R14: 00007f0813914300 R15: 0000000000022000
 </TASK>

Allocated by task 31160:
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

Freed by task 31161:
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

The buggy address belongs to the object at ffff888075996100
 which belongs to the cache kmalloc-cg-192 of size 192
The buggy address is located 132 bytes inside of
 freed 192-byte region [ffff888075996100, ffff8880759961c0)

The buggy address belongs to the physical page:
page:ffffea0001d66580 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x75996
memcg:ffff88801f1c2701
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff88801244ddc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff ffff88801f1c2701
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 31157, tgid 31154 (syz-executor.0), ts 1984547323469, free_ts 1983933451331
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
 iommufd_test_alloc_access drivers/iommu/iommufd/selftest.c:680 [inline]
 iommufd_test_create_access drivers/iommu/iommufd/selftest.c:710 [inline]
 iommufd_test+0x1328/0x2c20 drivers/iommu/iommufd/selftest.c:961
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
 get_signal+0x2318/0x25b0 kernel/signal.c:2876
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff888075996080: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888075996100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888075996180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                   ^
 ffff888075996200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888075996280: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
