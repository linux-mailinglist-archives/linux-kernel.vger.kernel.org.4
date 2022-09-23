Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6135E7E03
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiIWPOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbiIWPNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:13:54 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2BB1397C3;
        Fri, 23 Sep 2022 08:13:52 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id v192so302344vkv.7;
        Fri, 23 Sep 2022 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=pEeS9XXtktUFOEJ9+KJC+5ph0boXvgPT+eYS7lZbj2E=;
        b=NGm4dHfSb7lkAToMdEUKFJY2yQ1pktoCZvqwAyJBYZ9Ph8UY4kiOoi0f/8YkhD2uVn
         Q/CXoX46p+ZjpgdSHCYS9LiJ2f3BKvwNr9M+KWSQKPUKVYWjSBiGkHVRqwNyXdh/Xph6
         OGTbB0An1r/G58tbDbDYnZ/NV9oSC5ju5YvB6VTPKFMyolYKADjgqO8B6lhkYUkHjT8i
         xKcSVKk1er86HxYzbULJITSCmvdkJn9n3y9l9NVrZLSiQTIXq8JMV0ynChoLXYdh/EnL
         CkFgsGTTMkARJ2uaCBV3pssJ6jU/JWZiDo8+/dKZWiRTOwWWNtRVP3ZSMaGca38ir8IG
         paNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=pEeS9XXtktUFOEJ9+KJC+5ph0boXvgPT+eYS7lZbj2E=;
        b=KHLtkxkpzGW2XmU0gQXNCMk8pN2ZhDodn/Nf0KVwJZ8uH+d3t+cYKHEtSJVQI/m3/C
         LhPiHQwLNfFKVVUuL9gk5JunDLlldzdazY7wTFdhkLLqD6rGLYNgGP/trpHDihho1LAZ
         DNh1UEXoszjY1AhJdP7V1n8BOMJhIfE11JDGsL1ngguSc2DQHzVyUo8XdsrA9MdgbJpF
         lTAWZVMwV0OTtPcK+VDjWd8NL0xQeQee60WkXIQzy7QHLTOMnLNNnlvLi7fwivhatJ5F
         MkpUocuMfoUGYCwey/Nb+e5XXzuW/N3ZKoGhZhmaZrSiHvfculNI1CSo6p6m7/PJUNTa
         fi1Q==
X-Gm-Message-State: ACrzQf1dBLEjdXxLGbgx4Tarb9p3Qtl9M+6MM3CoglEB2cV1UTuhuX+2
        wtNGfu6yRIg2WBryDGGJrTIaU5vu6YVy+V7c2PH9GP84dHOx4pQy
X-Google-Smtp-Source: AMsMyM6B70qCZspSvrk3v1pZj1oqjDta4UCuEUnB+XzTQfFirL0fb47TifHlyT34MvYgAiMH+YMA4ScqTDVTF69fvWw=
X-Received: by 2002:a05:6122:a02:b0:3a3:1672:171f with SMTP id
 2-20020a0561220a0200b003a31672171fmr3691084vkn.17.1663946030811; Fri, 23 Sep
 2022 08:13:50 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Fri, 23 Sep 2022 23:13:39 +0800
Message-ID: <CAB7eex+oUZ2Vfa1ZvTkXCYf94k_-6t1v4XzMaoMRaxhk+QCp3Q@mail.gmail.com>
Subject: KASAN: use-after-free Read in f_hidg_read
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, balbi@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When fuzzing the Linux kernel driver v6.0-rc4, the following crash was
triggered.

HEAD commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
git tree: upstream

kernel config: https://pastebin.com/raw/xtrgsXP3
C reproducer: https://pastebin.com/raw/NeCr7cX0
console output: https://pastebin.com/raw/4uH5CL2k

Basically, in the c reproducer, we use the gadget module to emulate
attaching a USB device(vendor id: 0x5ac, product id: 0x30a) and
executing some simple sequence of system calls.
To reproduce this crash, we utilize a third-party library to emulate
the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
Just clone this repository, install it, and compile the c
reproducer with ``` gcc crash.c -lusbgx -lconfig -o crash ``` will do
the trick.

I would appreciate it if you have any idea how to solve this bug.

The crash report is as follows:
==================================================================
BUG: KASAN: use-after-free in f_hidg_read+0xa7a/0xe20
drivers/usb/gadget/function/f_hid.c:399
Read of size 1 at addr ffff888027a49012 by task syz-executor.2/7951

CPU: 1 PID: 7951 Comm: syz-executor.2 Not tainted 6.0.0-rc4+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:317 [inline]
print_report.cold+0xe5/0x66d mm/kasan/report.c:433
kasan_report+0x8a/0x1b0 mm/kasan/report.c:495
f_hidg_read+0xa7a/0xe20 drivers/usb/gadget/function/f_hid.c:399
vfs_read+0x257/0x940 fs/read_write.c:468
ksys_read+0x127/0x250 fs/read_write.c:607
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe3038a80fd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe303f02bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 00007fe30399c340 RCX: 00007fe3038a80fd
RDX: 0000000000002020 RSI: 0000000020000a00 RDI: 0000000000000003
RBP: 00007fe30390b606 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe7356189f R14: 00007ffe73561a40 R15: 00007fe303f02d80
</TASK>

Allocated by task 7828:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
kasan_set_track mm/kasan/common.c:45 [inline]
set_alloc_info mm/kasan/common.c:437 [inline]
____kasan_kmalloc mm/kasan/common.c:516 [inline]
____kasan_kmalloc mm/kasan/common.c:475 [inline]
__kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
kasan_kmalloc include/linux/kasan.h:234 [inline]
kmem_cache_alloc_trace+0x19b/0x380 mm/slub.c:3284
kmalloc include/linux/slab.h:600 [inline]
kzalloc include/linux/slab.h:733 [inline]
hidg_alloc+0x49/0x620 drivers/usb/gadget/function/f_hid.c:1271
usb_get_function+0x54/0xc0 drivers/usb/gadget/functions.c:61
config_usb_cfg_link+0x1bf/0x3b0 drivers/usb/gadget/configfs.c:461
configfs_symlink+0x542/0x1100 fs/configfs/symlink.c:202
vfs_symlink fs/namei.c:4378 [inline]
vfs_symlink+0x579/0x8b0 fs/namei.c:4363
do_symlinkat+0x225/0x2a0 fs/namei.c:4407
__do_sys_symlink fs/namei.c:4429 [inline]
__se_sys_symlink fs/namei.c:4427 [inline]
__x64_sys_symlink+0x75/0x90 fs/namei.c:4427
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 7952:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
kasan_set_track+0x21/0x30 mm/kasan/common.c:45
kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
____kasan_slab_free mm/kasan/common.c:367 [inline]
____kasan_slab_free mm/kasan/common.c:329 [inline]
__kasan_slab_free+0x11d/0x1b0 mm/kasan/common.c:375
kasan_slab_free include/linux/kasan.h:200 [inline]
slab_free_hook mm/slub.c:1754 [inline]
slab_free_freelist_hook mm/slub.c:1780 [inline]
slab_free mm/slub.c:3534 [inline]
kfree+0xe9/0x650 mm/slub.c:4562
hidg_free+0x9c/0x110 drivers/usb/gadget/function/f_hid.c:1249
usb_put_function+0x34/0x50 drivers/usb/gadget/functions.c:87
config_usb_cfg_unlink+0x281/0x360 drivers/usb/gadget/configfs.c:500
configfs_unlink+0x3e2/0x830 fs/configfs/symlink.c:250
vfs_unlink+0x343/0x940 fs/namei.c:4229
do_unlinkat+0x3d5/0x660 fs/namei.c:4297
__do_sys_unlink fs/namei.c:4345 [inline]
__se_sys_unlink fs/namei.c:4343 [inline]
__x64_sys_unlink+0x3e/0x50 fs/namei.c:4343
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888027a49000
which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 18 bytes inside of
1024-byte region [ffff888027a49000, ffff888027a49400)

The buggy address belongs to the physical page:
page:ffffea00009e9200 refcount:1 mapcount:0 mapping:0000000000000000
index:0xffff888027a4d800 pfn:0x27a48
head:ffffea00009e9200 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea00009e5c08 ffffea0000ab0008 ffff888011c41dc0
raw: ffff888027a4d800 000000000010000d 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask
0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
pid 6450, tgid 6450 (syz-executor.0), ts 172570752202, free_ts
168197901202
set_page_owner include/linux/page_owner.h:31 [inline]
post_alloc_hook mm/page_alloc.c:2525 [inline]
prep_new_page+0x2c6/0x350 mm/page_alloc.c:2532
get_page_from_freelist+0xae9/0x3a80 mm/page_alloc.c:4283
__alloc_pages+0x321/0x710 mm/page_alloc.c:5515
alloc_pages+0x117/0x2f0 mm/mempolicy.c:2270
alloc_slab_page mm/slub.c:1824 [inline]
allocate_slab mm/slub.c:1969 [inline]
new_slab+0x246/0x3a0 mm/slub.c:2029
___slab_alloc+0xa50/0x1060 mm/slub.c:3031
__slab_alloc.isra.0+0x4d/0xa0 mm/slub.c:3118
slab_alloc_node mm/slub.c:3209 [inline]
__kmalloc_node+0x2ed/0x360 mm/slub.c:4468
kmalloc_node include/linux/slab.h:623 [inline]
kzalloc_node include/linux/slab.h:744 [inline]
qdisc_alloc+0xb9/0xc30 net/sched/sch_generic.c:938
qdisc_create_dflt+0x71/0x4a0 net/sched/sch_generic.c:997
attach_one_default_qdisc.constprop.0+0xc4/0x1a0 net/sched/sch_generic.c:1152
netdev_for_each_tx_queue include/linux/netdevice.h:2437 [inline]
attach_default_qdiscs net/sched/sch_generic.c:1170 [inline]
dev_activate+0x5a7/0xa10 net/sched/sch_generic.c:1229
__dev_open+0x32d/0x460 net/core/dev.c:1441
__dev_change_flags+0x500/0x650 net/core/dev.c:8556
dev_change_flags+0x93/0x170 net/core/dev.c:8627
do_setlink+0xacc/0x3ca0 net/core/rtnetlink.c:2780
page last free stack trace:
reset_page_owner include/linux/page_owner.h:24 [inline]
free_pages_prepare mm/page_alloc.c:1449 [inline]
free_pcp_prepare+0x5ab/0xd00 mm/page_alloc.c:1499
free_unref_page_prepare mm/page_alloc.c:3380 [inline]
free_unref_page+0x19/0x410 mm/page_alloc.c:3476
release_pages+0x386/0x16c0 mm/swap.c:978
tlb_batch_pages_flush mm/mmu_gather.c:58 [inline]
tlb_flush_mmu_free mm/mmu_gather.c:255 [inline]
tlb_flush_mmu+0xef/0x690 mm/mmu_gather.c:262
tlb_finish_mmu+0x93/0x3c0 mm/mmu_gather.c:353
unmap_region+0x27f/0x350 mm/mmap.c:2625
__do_munmap+0xafe/0x10c0 mm/mmap.c:2836
__vm_munmap+0xf7/0x230 mm/mmap.c:2859
__do_sys_munmap mm/mmap.c:2884 [inline]
__se_sys_munmap mm/mmap.c:2881 [inline]
__x64_sys_munmap+0x55/0x80 mm/mmap.c:2881
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
ffff888027a48f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff888027a48f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888027a49000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff888027a49080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff888027a49100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
