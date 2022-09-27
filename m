Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E455EC1CA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiI0LqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiI0Lp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:45:59 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048F589938
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:45:57 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i13-20020a056e02152d00b002f58aea654fso7383605ilu.20
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=vhfRj5cfImAqnaaVb4toEoogu+WJpKJkl9q0t+Jwvo0=;
        b=oJcKWIZzC3mPo4/Il6COOnRpsMzxSkbpnx1lfkUoocTx9LZjO/Vt9qoHQKSu4UhACA
         BlAEvi8hVHobKvBJRNIKEEkCPoyrnC4KKriEGiVjGygplpvEBIjZTMH5/PIRGO5uqLA4
         jifKuPuZ96JVQQAzpdunMaxAdW7vHfntIHlq2Gu0kH3yxbxgYCgS+s6MkHVamOedKSKW
         +fO9+8Egza7pOtcoBZt3DxmG0mKkpoG7qqwIb6W/OEEuYkREEQztTCYP3t9x8DXtEQfH
         SbglBAiKjUO5wk9bo4WH+if90WnBs4CL/BFgQLlyQYW2fRzmkDtWnlXzAfCMS467pMmu
         qcww==
X-Gm-Message-State: ACrzQf0qK9jyYA88InNbkClWNk4SF43B+9BLRNRaWr90B38eTuYjPSvI
        QxEcSyvr+3OAfFjvV7Dm4SofdCkQm7j+5gFqdHJOXFM6Phfr
X-Google-Smtp-Source: AMsMyM7AJXfTxn91qt6n6CvLO1vhK95u+enG8LaC90ANcKcvZO2KpOOtp+iP3sZ0DFkbPTgu1F++w8t1Fptybhy14v6wY6GxbaC7
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2189:b0:2f1:92d4:6b22 with SMTP id
 j9-20020a056e02218900b002f192d46b22mr11305086ila.210.1664279156400; Tue, 27
 Sep 2022 04:45:56 -0700 (PDT)
Date:   Tue, 27 Sep 2022 04:45:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eca83705e9a72fb9@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in ntfs_trim_fs
From:   syzbot <syzbot+b892240eac461e488d51@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f76349cf4145 Linux 6.0-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1603d3ef080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=b892240eac461e488d51
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133c8540880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11b74870880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b892240eac461e488d51@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8189
ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
ntfs3: loop0: Mark volume as dirty due to NTFS errors
==================================================================
BUG: KASAN: slab-out-of-bounds in ntfs_trim_fs+0x710/0x9e0 fs/ntfs3/bitmap.c:1434
Read of size 2 at addr ffff888017dbf34a by task syz-executor214/3606

CPU: 1 PID: 3606 Comm: syz-executor214 Not tainted 6.0.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:317
 print_report+0x108/0x1f0 mm/kasan/report.c:433
 kasan_report+0xc3/0xf0 mm/kasan/report.c:495
 ntfs_trim_fs+0x710/0x9e0 fs/ntfs3/bitmap.c:1434
 ntfs_ioctl_fitrim fs/ntfs3/file.c:40 [inline]
 ntfs_ioctl+0x2d4/0x3a0 fs/ntfs3/file.c:57
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3be74131b9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffce9b80db8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3be7458f70 RCX: 00007f3be74131b9
RDX: 0000000020000000 RSI: 00000000c0185879 RDI: 0000000000000003
RBP: 00007f3be7458ca8 R08: 0000000000000000 R09: 0000000000000000
R10: 00007f3be73d29f4 R11: 0000000000000246 R12: 00007f3be7458a80
R13: 00007f3be7458798 R14: 00030030454c4946 R15: 0000000000000000
 </TASK>

Allocated by task 3606:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc+0xcd/0x100 mm/kasan/common.c:516
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 __kmalloc+0x226/0x370 mm/slub.c:4429
 kmalloc_array include/linux/slab.h:640 [inline]
 kcalloc include/linux/slab.h:671 [inline]
 wnd_init+0x1db/0x310 fs/ntfs3/bitmap.c:664
 ntfs_fill_super+0x310a/0x42a0 fs/ntfs3/super.c:1118
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888017dbf348
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 2 bytes inside of
 8-byte region [ffff888017dbf348, ffff888017dbf350)

The buggy address belongs to the physical page:
page:ffffea00005f6fc0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x17dbf
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 0000000000000000 dead000000000001 ffff888012041280
raw: 0000000000000000 0000000080660066 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 2553057939, free_ts 2469761197
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5515
 alloc_page_interleave+0x22/0x1c0 mm/mempolicy.c:2103
 alloc_slab_page+0x70/0xf0 mm/slub.c:1829
 allocate_slab+0x5e/0x520 mm/slub.c:1974
 new_slab mm/slub.c:2034 [inline]
 ___slab_alloc+0x3ee/0xc40 mm/slub.c:3036
 __slab_alloc mm/slub.c:3123 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmalloc+0x2bd/0x370 mm/slub.c:4425
 kmalloc include/linux/slab.h:605 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 acpi_os_allocate_zeroed include/acpi/platform/aclinuxex.h:57 [inline]
 acpi_ns_internalize_name+0x14f/0x26c drivers/acpi/acpica/nsutils.c:331
 acpi_ns_get_node_unlocked+0x13b/0x2ed drivers/acpi/acpica/nsutils.c:666
 acpi_ns_get_node+0x4f/0x66 drivers/acpi/acpica/nsutils.c:726
 acpi_get_handle+0x1c3/0x284 drivers/acpi/acpica/nsxfname.c:98
 acpi_has_method+0x7a/0xc0 drivers/acpi/utils.c:591
 acpi_bay_match+0x71/0x1e0 drivers/acpi/scan.c:1168
 acpi_set_pnp_ids drivers/acpi/scan.c:1377 [inline]
 acpi_init_device_object+0x1ba7/0x2fb0 drivers/acpi/scan.c:1774
 acpi_add_single_object+0xea/0x1280 drivers/acpi/scan.c:1824
 acpi_bus_check_add+0x2c8/0x980 drivers/acpi/scan.c:2084
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3476
 qlist_free_all mm/kasan/quarantine.c:187 [inline]
 kasan_quarantine_remove_cache+0x1ab/0x1d0 mm/kasan/quarantine.c:402
 kmem_cache_shrink+0x9/0x20 mm/slab_common.c:517
 acpi_os_purge_cache+0x11/0x20 drivers/acpi/osl.c:1580
 acpi_purge_cached_objects+0x8b/0xb8 drivers/acpi/acpica/utxface.c:239
 acpi_initialize_objects+0x2a/0x96 drivers/acpi/acpica/utxfinit.c:250
 acpi_bus_init+0xd3/0xa67 drivers/acpi/bus.c:1320
 acpi_init+0xd2/0x222 drivers/acpi/bus.c:1408
 do_one_initcall+0x1b9/0x3e0 init/main.c:1296
 do_initcall_level+0x168/0x218 init/main.c:1369
 do_initcalls+0x4b/0x8c init/main.c:1385
 kernel_init_freeable+0x3f1/0x57b init/main.c:1623
 kernel_init+0x19/0x2b0 init/main.c:1512
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffff888017dbf200: fc fa fc fc fc fc fa fc fc fc fc fa fc fc fc fc
 ffff888017dbf280: 00 fc fc fc fc fa fc fc fc fc fa fc fc fc fc 00
>ffff888017dbf300: fc fc fc fc 02 fc fc fc fc 02 fc fc fc fc fa fc
                                              ^
 ffff888017dbf380: fc fc fc 00 fc fc fc fc 00 fc fc fc fc 05 fc fc
 ffff888017dbf400: fc fc fb fc fc fc fc 00 fc fc fc fc 00 fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
