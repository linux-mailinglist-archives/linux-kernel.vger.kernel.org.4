Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595FE5EAF21
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiIZSGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiIZSFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:05:17 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0848B23BEA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:49:42 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id h17-20020a056e021d9100b002f81bc83425so4303559ila.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=lkY54m7HExAfUv0/k1lxM2GOpeOmlu6Ta4QwIq94Yww=;
        b=SRLaUXyUdtoK/z+idHlwiuuMU0HSCGlNCHPJxCI4y803GEKkNO68+F+gS1GQ/ppVR4
         Xq11GzLhQs9AObl0EocfIbgNJ9n0bQ+pkZxa8sMO04/lZvaRgduFUb99mpPzSmGHVtno
         m5jXJwecgsDFOg4ItF1ZUOSYzISgxZB7bMy1RMAsfXX+tW70l0pGxWSrK7KkKuWG0m8H
         oYdnUvlBw3aX1tNumpi9/SrgHU5eoSpH+8xkgkSxHtOEgXouad9ptCUdyoV9xey3XgcW
         DN/4egtLZrYMIozA7ANiEpJb0hNKGwYPPcpqQJe4C1usDGJ9m9waWjETaUnnETW6+bxk
         CNPw==
X-Gm-Message-State: ACrzQf1h1SEafbWwyREookTjFXoN1NL4JlCpuTcYb5hfMZlG7qvK5kiT
        FRp3yfOKGWwQ+4A6FWMNmAsI9EVp7gp3SsFEHqettZaEUqbD
X-Google-Smtp-Source: AMsMyM7YTBXxWq/CQitk58VQ+NrHU9kKFuCEPuLeY/ZsAbL7dQN1lPmYJb6pY5zrThe/dn/k4PA5LrZnGoqe+suhLH7rOpkw37JT
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1686:b0:35a:2566:6786 with SMTP id
 f6-20020a056638168600b0035a25666786mr12316143jat.180.1664214582157; Mon, 26
 Sep 2022 10:49:42 -0700 (PDT)
Date:   Mon, 26 Sep 2022 10:49:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ffefd405e998269c@google.com>
Subject: [syzbot] KASAN: slab-out-of-bounds Write in udf_write_aext
From:   syzbot <syzbot+908340a8367281960537@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f76349cf4145 Linux 6.0-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=124e0988880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=755695d26ad09807
dashboard link: https://syzkaller.appspot.com/bug?extid=908340a8367281960537
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d07804880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163bf540880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+908340a8367281960537@syzkaller.appspotmail.com

UDF-fs: Scanning with blocksize 2048 failed
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/09/12 12:00 (1000)
==================================================================
BUG: KASAN: slab-out-of-bounds in udf_write_aext+0x8bc/0x8f0 fs/udf/inode.c:2103
Write of size 4 at addr ffff88801f549ff8 by task syz-executor371/3605

CPU: 1 PID: 3605 Comm: syz-executor371 Not tainted 6.0.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 udf_write_aext+0x8bc/0x8f0 fs/udf/inode.c:2103
 udf_add_entry+0xd03/0x2ac0 fs/udf/namei.c:482
 udf_mkdir+0x145/0x650 fs/udf/namei.c:681
 vfs_mkdir+0x489/0x740 fs/namei.c:4013
 do_mkdirat+0x28c/0x310 fs/namei.c:4038
 __do_sys_mkdir fs/namei.c:4058 [inline]
 __se_sys_mkdir fs/namei.c:4056 [inline]
 __x64_sys_mkdir+0xf2/0x140 fs/namei.c:4056
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1eeb96d239
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd9f964d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1eeb96d239
RDX: 00007f1eeb92b733 RSI: 0000000000000000 RDI: 0000000020000580
RBP: 00007f1eeb92ca00 R08: 0000000000000000 R09: 0000000000000000
R10: 00007fffd9f963a0 R11: 0000000000000246 R12: 00007f1eeb92ca90
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 3234:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc mm/kasan/common.c:516 [inline]
 ____kasan_kmalloc mm/kasan/common.c:475 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
 kmalloc include/linux/slab.h:605 [inline]
 tomoyo_realpath_from_path+0xc3/0x620 security/tomoyo/realpath.c:254
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x21b/0x400 security/tomoyo/file.c:822
 security_inode_getattr+0xcf/0x140 security/security.c:1345
 vfs_getattr fs/stat.c:157 [inline]
 vfs_statx+0x16a/0x390 fs/stat.c:232
 vfs_fstatat+0x8c/0xb0 fs/stat.c:255
 __do_sys_newfstatat+0x91/0x110 fs/stat.c:425
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3234:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:367 [inline]
 ____kasan_slab_free+0x166/0x1c0 mm/kasan/common.c:329
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1759 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1785
 slab_free mm/slub.c:3539 [inline]
 kfree+0xe2/0x580 mm/slub.c:4567
 tomoyo_realpath_from_path+0x191/0x620 security/tomoyo/realpath.c:291
 tomoyo_get_realpath security/tomoyo/file.c:151 [inline]
 tomoyo_path_perm+0x21b/0x400 security/tomoyo/file.c:822
 security_inode_getattr+0xcf/0x140 security/security.c:1345
 vfs_getattr fs/stat.c:157 [inline]
 vfs_statx+0x16a/0x390 fs/stat.c:232
 vfs_fstatat+0x8c/0xb0 fs/stat.c:255
 __do_sys_newfstatat+0x91/0x110 fs/stat.c:425
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88801f548000
 which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 4088 bytes to the right of
 4096-byte region [ffff88801f548000, ffff88801f549000)

The buggy address belongs to the physical page:
page:ffffea00007d5200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1f548
head:ffffea00007d5200 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888011842140
raw: 0000000000000000 0000000080040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2982, tgid 2982 (udevd), ts 19873192355, free_ts 19693244655
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5515
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:1829 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1974
 new_slab mm/slub.c:2034 [inline]
 ___slab_alloc+0x7f1/0xe10 mm/slub.c:3036
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3123
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 kmem_cache_alloc_trace+0x323/0x3e0 mm/slub.c:3287
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 uevent_show+0x159/0x380 drivers/base/core.c:2487
 dev_attr_show+0x4b/0x90 drivers/base/core.c:2195
 sysfs_kf_seq_show+0x219/0x3d0 fs/sysfs/file.c:59
 kernfs_seq_show+0x169/0x1e0 fs/kernfs/file.c:217
 seq_read_iter+0x4f5/0x1280 fs/seq_file.c:230
 kernfs_fop_read_iter+0x523/0x710 fs/kernfs/file.c:299
 call_read_iter include/linux/fs.h:2181 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x67d/0x930 fs/read_write.c:470
 ksys_read+0x127/0x250 fs/read_write.c:607
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3476
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2553
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3248 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
 kmem_cache_alloc+0x267/0x3b0 mm/slub.c:3273
 getname_flags.part.0+0x50/0x4f0 fs/namei.c:139
 getname_flags+0x9a/0xe0 include/linux/audit.h:320
 user_path_at_empty+0x2b/0x60 fs/namei.c:2875
 user_path_at include/linux/namei.h:57 [inline]
 do_fchmodat+0x92/0x140 fs/open.c:643
 __do_sys_chmod fs/open.c:663 [inline]
 __se_sys_chmod fs/open.c:661 [inline]
 __x64_sys_chmod+0x58/0x80 fs/open.c:661
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88801f549e80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801f549f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88801f549f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                                ^
 ffff88801f54a000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88801f54a080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
