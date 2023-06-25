Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7DC73D143
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 16:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjFYODs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 10:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFYODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 10:03:45 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06F01B1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:03:43 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-345958a02a5so5130035ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 07:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687701823; x=1690293823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WcGr/9Q8VTbEE418cxyBjwHw6pHIq0Xt9AoTZh9Zuc=;
        b=dcBCKTnVOv6X8MoHJMDIHY0audbur4YrZKqYYmBmzql6BsiXa3FK4T4PCOd6P73TKr
         UL/FNs364WVl7236P2kbvktZApD+u1PK7Av81oJWXOSLGmlmjEOB8nLwr7c+TF6XZwJT
         fzAMY7AzmxmGsU+KrRNu0RfiVt42OFlYR6BQM1bdaA6NM0qUvEvXkSX0ZILXXT6GDBEr
         oHCKWFvxLJHUa8xgSkiwXiSW5Fk/axbqPn9DwuJfYV2icsrBFYlo7nwGqwOmNdasgyei
         76ZMuF711c5VraV/vyJXTz5HuHflkqmhEDbOWRGF9edW1v7whuOo15ooftMW46rNAsOv
         ovrg==
X-Gm-Message-State: AC+VfDz1ewaGZr3Zwc1oQ8iOhpBWZUitgpCb9qF9Y2ClSMTsKPyy+8U1
        E2+nTlQz+1ywvdH1jr+qiqgVls6DTgO/ZV/YEfl2RSozYzSL
X-Google-Smtp-Source: ACHHUZ53ZW3/3lvvptsyuSF0/HrDU//snthFZeh6Go4+AkM2bJNq4TjDf/VmD8oKu3y5LfuMmOGYlW/f/2/yOLYrzcWX4d71L/Ea
MIME-Version: 1.0
X-Received: by 2002:a92:c9cf:0:b0:344:5211:8ef4 with SMTP id
 k15-20020a92c9cf000000b0034452118ef4mr2403178ilq.6.1687701823281; Sun, 25 Jun
 2023 07:03:43 -0700 (PDT)
Date:   Sun, 25 Jun 2023 07:03:43 -0700
In-Reply-To: <0000000000001d40fc05fe385332@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a9e20505fef4b35a@google.com>
Subject: Re: [syzbot] [iommu?] KASAN: slab-use-after-free Read in iopt_unmap_iova_range
From:   syzbot <syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com>
To:     iommu@lists.linux.dev, jgg@nvidia.com, jgg@ziepe.ca,
        joro@8bytes.org, kevin.tian@intel.com,
        linux-kernel@vger.kernel.org, lixiao.yang@intel.com,
        mjrosato@linux.ibm.com, nicolinc@nvidia.com, robin.murphy@arm.com,
        syzkaller-bugs@googlegroups.com, will@kernel.org,
        yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    a92b7d26c743 Merge tag 'drm-fixes-2023-06-23' of git://ano..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1642c4c7280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=1ad12d16afca0e7d2dde
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d77fb0a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11cb8093280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/732ee8ad13ec/disk-a92b7d26.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/26b49ff43e67/vmlinux-a92b7d26.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2749c666f682/bzImage-a92b7d26.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1ad12d16afca0e7d2dde@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in iopt_unmap_iova_range+0x5ba/0x5f0 drivers/iommu/iommufd/io_pagetable.c:499
Read of size 4 at addr ffff88807683c184 by task syz-executor144/5064

CPU: 0 PID: 5064 Comm: syz-executor144 Not tainted 6.4.0-rc7-syzkaller-00226-ga92b7d26c743 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
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
RIP: 0033:0x7f5a36a77bc9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5a36a29308 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f5a36aff428 RCX: 00007f5a36a77bc9
RDX: 00000000200001c0 RSI: 0000000000003b86 RDI: 0000000000000003
RBP: 00007f5a36aff420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5a36aff42c
R13: 00007f5a36acd064 R14: 6d6f692f7665642f R15: 0000000000022000
 </TASK>

Allocated by task 5064:
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

Freed by task 5065:
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

The buggy address belongs to the object at ffff88807683c100
 which belongs to the cache kmalloc-cg-192 of size 192
The buggy address is located 132 bytes inside of
 freed 192-byte region [ffff88807683c100, ffff88807683c1c0)

The buggy address belongs to the physical page:
page:ffffea0001da0f00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7683c
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff88801244ddc0 dead000000000122 0000000000000000
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 5064, tgid 5063 (syz-executor144), ts 60389083823, free_ts 60371796624
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
 exit_mmap+0x2b2/0x930 mm/mmap.c:3120
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
 ffff88807683c080: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
 ffff88807683c100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807683c180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                   ^
 ffff88807683c200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807683c280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
