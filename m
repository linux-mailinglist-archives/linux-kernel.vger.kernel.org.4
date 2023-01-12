Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D168D667273
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjALMm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjALMmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:42:40 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE77E49163
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:42:39 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id a7-20020a056e0208a700b0030ecfd5d4cdso1269819ilt.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PVvUb0LdeZUYYRIQvAoCQ/oKB8Q3RQMV5/lCCF06ObA=;
        b=2VIztrYVEas/WPEmrc0ZQJZpWfR/OYtvYLA/9Jhlf5PM8/I2YyrxhQabaDynvq22Df
         j4abRE+Q8kWoqy7pf2iiG40Ur9Um9k9UE+Tny6XzZ9uaYUsIgdN2HaEfiNhfeUMZT0md
         4N8FJDP9onr0SqdvN7duK2SI8YHIlUwCkGV6rJEB+ap1usqf4S2tBZXdE0DW4yA+jwQX
         9vJeSmx3Lz1obgjoy0Ocag59FfjLr6f1EtVADs8CutUL+k3ke53ddttoPOeSc4SZHPCL
         kdh6L1WqAFl+4M8CUs44LQGvLtpuar7UEpF5I4IoGZTI1gBfXqwZ60holbhaWNKYQFd/
         21yw==
X-Gm-Message-State: AFqh2kqQN8NakZJkbzeiZfWniooTHRbUJuU32y0iU79ts1E1bQMszdlc
        trkBINyP9DrLz1d8MP7zzXxL7mqsOKnGJwozcpSNVL7vX3MY
X-Google-Smtp-Source: AMrXdXs7cQGNA0vgVWoiSqAJebto3iR89tbt6dBf4QonVgj/HYjoHxUtf5dBz8m97XDDUb4UxxHR2CQuD3p7yJspJU6/YMk25nbS
MIME-Version: 1.0
X-Received: by 2002:a92:d102:0:b0:30c:47d0:7539 with SMTP id
 a2-20020a92d102000000b0030c47d07539mr6208089ilb.22.1673527359225; Thu, 12 Jan
 2023 04:42:39 -0800 (PST)
Date:   Thu, 12 Jan 2023 04:42:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4c9f105f2107386@google.com>
Subject: [syzbot] [jfs?] KASAN: slab-out-of-bounds Read in jfs_readdir
From:   syzbot <syzbot+f328fbf8718edb712341@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    e8f60cd7db24 Merge tag 'perf-tools-fixes-for-v6.2-2-2023-0..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13af86a1480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b6ecad960fc703e
dashboard link: https://syzkaller.appspot.com/bug?extid=f328fbf8718edb712341
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ab6a36480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11647bbe480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/783306915ec2/disk-e8f60cd7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2ff1bb24fb5d/vmlinux-e8f60cd7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/08e9c5fa68d4/bzImage-e8f60cd7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/90a9788dcb4a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f328fbf8718edb712341@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
==================================================================
BUG: KASAN: slab-out-of-bounds in jfs_readdir+0x375e/0x4230 fs/jfs/jfs_dtree.c:2889
Read of size 1 at addr ffff888075357f75 by task syz-executor300/5071

CPU: 1 PID: 5071 Comm: syz-executor300 Not tainted 6.2.0-rc3-syzkaller-00030-ge8f60cd7db24 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:306 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:417
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:517
 jfs_readdir+0x375e/0x4230 fs/jfs/jfs_dtree.c:2889
 iterate_dir+0x1fd/0x6f0 fs/readdir.c:67
 __do_sys_getdents64 fs/readdir.c:369 [inline]
 __se_sys_getdents64 fs/readdir.c:354 [inline]
 __x64_sys_getdents64+0x13e/0x2c0 fs/readdir.c:354
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fbeecd7b9a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed1b8d6f8 EFLAGS: 00000246 ORIG_RAX: 00000000000000d9
RAX: ffffffffffffffda RBX: 000000000000cdbe RCX: 00007fbeecd7b9a9
RDX: 00000000000000c5 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007ffed1b8d720 R09: 00007ffed1b8d720
R10: 0000000000005d45 R11: 0000000000000246 R12: 00007ffed1b8d71c
R13: 00007ffed1b8d750 R14: 00007ffed1b8d730 R15: 0000000000000004
 </TASK>

The buggy address belongs to the object at ffff888075356e58
 which belongs to the cache ext4_inode_cache of size 2440
The buggy address is located 1941 bytes to the right of
 2440-byte region [ffff888075356e58, ffff8880753577e0)

The buggy address belongs to the physical page:
page:ffffea0001d4d400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x75350
head:ffffea0001d4d400 order:3 compound_mapcount:0 subpages_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffff888018d9c140 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Reclaimable, gfp_mask 0xd2050(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_RECLAIMABLE), pid 5069, tgid 5069 (syz-executor300), ts 52178760853, free_ts 12054506429
 prep_new_page mm/page_alloc.c:2531 [inline]
 get_page_from_freelist+0x119c/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5549
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2286
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x350 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc_lru+0x4dc/0x760 mm/slub.c:3483
 alloc_inode_sb include/linux/fs.h:3119 [inline]
 ext4_alloc_inode+0x28/0x680 fs/ext4/super.c:1321
 alloc_inode+0x61/0x230 fs/inode.c:259
 new_inode_pseudo fs/inode.c:1018 [inline]
 new_inode+0x2b/0x280 fs/inode.c:1046
 __ext4_new_inode+0x399/0x57d0 fs/ext4/ialloc.c:959
 ext4_symlink+0x5ac/0xa00 fs/ext4/namei.c:3373
 vfs_symlink fs/namei.c:4401 [inline]
 vfs_symlink+0x369/0x5c0 fs/namei.c:4386
 do_symlinkat+0x250/0x2c0 fs/namei.c:4430
 __do_sys_symlink fs/namei.c:4452 [inline]
 __se_sys_symlink fs/namei.c:4450 [inline]
 __x64_sys_symlink+0x79/0x90 fs/namei.c:4450
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1446 [inline]
 free_pcp_prepare+0x65c/0xc00 mm/page_alloc.c:1496
 free_unref_page_prepare mm/page_alloc.c:3369 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3464
 free_contig_range+0xb5/0x180 mm/page_alloc.c:9485
 destroy_args+0xa8/0x64c mm/debug_vm_pgtable.c:998
 debug_vm_pgtable+0x28de/0x296f mm/debug_vm_pgtable.c:1318
 do_one_initcall+0x141/0x790 init/main.c:1306
 do_initcall_level init/main.c:1379 [inline]
 do_initcalls init/main.c:1395 [inline]
 do_basic_setup init/main.c:1414 [inline]
 kernel_init_freeable+0x6f9/0x782 init/main.c:1634
 kernel_init+0x1e/0x1d0 init/main.c:1522
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff888075357e00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888075357e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888075357f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                             ^
 ffff888075357f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888075358000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
