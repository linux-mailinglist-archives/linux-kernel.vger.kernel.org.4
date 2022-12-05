Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE264642228
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 05:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231528AbiLEECC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 23:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiLEEBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 23:01:47 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513A4101E8
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 20:01:45 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id l22-20020a05660227d600b006dfa191ca8aso9200020ios.20
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 20:01:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5Si85HD6PALuv+sHxLEJMKdSZzF+UMWiq0Gxr7AHts=;
        b=UR9LuTmPloVwa0EcdH0Sh6QWeX6XXr8su0h7Sr6SaHh285suLs6aV/9ov5Poke5ozX
         q2FsjHo6OXxGxOFYioddpVNWMEc3B9VW0pBdV4eLLQGRBd8dopgCWLXeeGqKlRafp1XT
         v7lOsgx4g+dyrFjFR926rEyMqMoIMZ3il9KCgEwy6t5n/g8bGp1gdVgQYmf3PSwxhCb+
         6V5zP8bYw/dmIxNVwx07aBDffD1ys5LnlKKo3xOjwnJQuEz8o3Rh+KgndUZBBMcs7fJM
         swgwrJFEHLndHcG6tiQIXnghE25UkCdMnAya+jG57AZ1uX83uhI+Od/8eVXlQUyvZVY0
         W8Lg==
X-Gm-Message-State: ANoB5pnBr5aQyFfPf2oTFB1buT7vzAyRiz1BEtL6qLLiCqwb+G/fMTD4
        +Z0qMI18GC7XGrqUBwCzngB/axC5rtGCaDxhGvN5+rB5IGO+
X-Google-Smtp-Source: AA0mqf75wRYZ89oFDAcgiNnCnee8Ogw06k2DrgFDdpMMhp1fC64vxKn/AVDpltc838wgFc5vqOwBHk6XsZQmzoIrqOmn4A/HZtXo
MIME-Version: 1.0
X-Received: by 2002:a02:298b:0:b0:35b:4296:ce78 with SMTP id
 p133-20020a02298b000000b0035b4296ce78mr31561133jap.317.1670212904675; Sun, 04
 Dec 2022 20:01:44 -0800 (PST)
Date:   Sun, 04 Dec 2022 20:01:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1f8d005ef0cbed8@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Read in indx_insert_into_buffer
From:   syzbot <syzbot+d882d57193079e379309@syzkaller.appspotmail.com>
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

HEAD commit:    c2bf05db6c78 Merge tag 'i2c-for-6.1-rc8' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13e92bd5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=d882d57193079e379309
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15b4ffad880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1521b5e3880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4476d2eff1ae/disk-c2bf05db.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0f4a704ffc14/vmlinux-c2bf05db.xz
kernel image: https://storage.googleapis.com/syzbot-assets/dfb09481a98b/bzImage-c2bf05db.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4d8d6c8c32f9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d882d57193079e379309@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS' sector size (4096) and media sector size (512)
==================================================================
BUG: KASAN: slab-out-of-bounds in indx_insert_into_buffer+0xaa3/0x13b0 fs/ntfs3/index.c:1755
Read of size 17168 at addr ffff8880255e06c0 by task syz-executor308/3630

CPU: 1 PID: 3630 Comm: syz-executor308 Not tainted 6.1.0-rc7-syzkaller-00200-gc2bf05db6c78 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 kasan_check_range+0x2a7/0x2e0 mm/kasan/generic.c:189
 memmove+0x25/0x60 mm/kasan/shadow.c:54
 indx_insert_into_buffer+0xaa3/0x13b0 fs/ntfs3/index.c:1755
 indx_insert_entry+0x446/0x6b0 fs/ntfs3/index.c:1863
 ntfs_create_inode+0x1d3f/0x35c0 fs/ntfs3/inode.c:1548
 ntfs_create+0x3e/0x60 fs/ntfs3/namei.c:100
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12d0/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1396
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe9f5b03789
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd28ea598 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe9f5b03789
RDX: 0000000000000073 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 00007fe9f5ac3020 R08: 000000000001f186 R09: 0000000000000000
R10: 00007ffcd28ea460 R11: 0000000000000246 R12: 00007fe9f5ac30b0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 3630:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slab_common.c:955 [inline]
 __kmalloc+0xaf/0x1a0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 indx_read+0x29a/0x880 fs/ntfs3/index.c:978
 indx_find+0x491/0xb20 fs/ntfs3/index.c:1080
 indx_insert_entry+0x49a/0x6b0 fs/ntfs3/index.c:1838
 ntfs_create_inode+0x1d3f/0x35c0 fs/ntfs3/inode.c:1548
 ntfs_create+0x3e/0x60 fs/ntfs3/namei.c:100
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12d0/0x2df0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1396
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880255e0000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 1728 bytes inside of
 4096-byte region [ffff8880255e0000, ffff8880255e1000)

The buggy address belongs to the physical page:
page:ffffea0000957800 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x255e0
head:ffffea0000957800 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888012842140
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 14, tgid 14 (kworker/0:1), ts 9102026779, free_ts 0
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 alloc_slab_page+0xbd/0x190 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x782/0xe20 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x252/0x310 mm/slub.c:3437
 kmalloc_trace+0x26/0x60 mm/slab_common.c:1045
 kmalloc include/linux/slab.h:553 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 kobject_uevent_env+0x33a/0x8e0 lib/kobject_uevent.c:524
 device_add+0xa56/0xf90 drivers/base/core.c:3498
 input_register_device+0xa68/0x1270 drivers/input/input.c:2379
 psmouse_connect+0xb70/0x14c0 drivers/input/mouse/psmouse-base.c:1634
 serio_connect_driver drivers/input/serio/serio.c:44 [inline]
 serio_driver_probe+0x76/0x90 drivers/input/serio/serio.c:775
 call_driver_probe+0x96/0x250
 really_probe+0x24c/0x9f0 drivers/base/dd.c:639
 __driver_probe_device+0x1f4/0x3f0 drivers/base/dd.c:778
 driver_probe_device+0x50/0x240 drivers/base/dd.c:808
page_owner free stack trace missing

Memory state around the buggy address:
 ffff8880255e0f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880255e0f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880255e1000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff8880255e1080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880255e1100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
