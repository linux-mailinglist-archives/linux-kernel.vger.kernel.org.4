Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3768E5C03F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiIUQUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiIUQUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:20:03 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1DFABF22
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:03:51 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id b201-20020a6bb2d2000000b006a15be04a84so3316096iof.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=dA2pAc0/Ga1TN2s8dx7HSgcZdFPNY9uqqbqo8YzufOU=;
        b=PJ63SQa4M2UQtN7KS9/LN4Qe7pBfkakJSwgw8HFWhd8/g/VHd9ydMulflGPrpZuIWN
         O/F7mcH6Jwr+AaccuIfuscyajhNAO+8Ab9naSOEYRdvOtl4znWTZFlrQsSc0M1JvFJqm
         Lc5Ce+6nVqGJT6KH6Wumup6rhbxTaPUDc7Jzq9DRdALoU4EK48n6X39+kKbwrKEZnaWW
         ianK61dS5TMdh5omFLDJ6SJSlHld9RwfuDXw1H35Gr5mRshvYRQZ+wZRDFzHHX0AqydE
         zE22x3bKf3saTBnW51f4qi8CcQESoFsQ+e3JBSVmgep2GPDHW057W9zxbkxFZqsE+MqG
         SuuA==
X-Gm-Message-State: ACrzQf3K3Q6G1pF/8w++vcXtY1NgXqMtmGiHLw8Bj/YhQtbP+iif79Zx
        lcptLO4cw61ffy+Tm5mhTnBdQD1LL1uj1VKoyk671FRMiJnP
X-Google-Smtp-Source: AMsMyM428qQLFwXfXs+ZUrA4zJnw/1VK9hvEAK4rH63foF4DjHq7uzOTh8u7xiRrwd6SHNaBwuhFVBYceWh42mG7TjqvVg0rPhY0
MIME-Version: 1.0
X-Received: by 2002:a92:cb4b:0:b0:2f5:79f9:9d0c with SMTP id
 f11-20020a92cb4b000000b002f579f99d0cmr7662971ilq.73.1663776161100; Wed, 21
 Sep 2022 09:02:41 -0700 (PDT)
Date:   Wed, 21 Sep 2022 09:02:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000117bf405e9321346@google.com>
Subject: [syzbot] KASAN: use-after-free Read in nilfs_mdt_destroy
From:   syzbot <syzbot+3974efaf68c77533b42d@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a335366bad13 Merge tag 'gpio-fixes-for-v6.0-rc6' of git://..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13af94f8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98a30118ec9215e9
dashboard link: https://syzkaller.appspot.com/bug?extid=3974efaf68c77533b42d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e17937080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1570a75d080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3974efaf68c77533b42d@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in nilfs_mdt_destroy+0x6f/0x80 fs/nilfs2/mdt.c:497
Read of size 8 at addr ffff888020124498 by task syz-executor134/3740

CPU: 0 PID: 3740 Comm: syz-executor134 Not tainted 6.0.0-rc5-syzkaller-00094-ga335366bad13 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 nilfs_mdt_destroy+0x6f/0x80 fs/nilfs2/mdt.c:497
 nilfs_free_inode+0x3e/0x60 fs/nilfs2/super.c:168
 i_callback fs/inode.c:249 [inline]
 alloc_inode+0x13b/0x230 fs/inode.c:274
 new_inode_pseudo fs/inode.c:1019 [inline]
 new_inode+0x27/0x270 fs/inode.c:1047
 nilfs_new_inode+0xca/0x830 fs/nilfs2/inode.c:334
 nilfs_create fs/nilfs2/namei.c:85 [inline]
 nilfs_create+0xfe/0x300 fs/nilfs2/namei.c:75
 vfs_create fs/namei.c:3115 [inline]
 vfs_create+0x3e9/0x670 fs/namei.c:3101
 do_mknodat+0x3d9/0x530 fs/namei.c:3942
 __do_sys_mknodat fs/namei.c:3970 [inline]
 __se_sys_mknodat fs/namei.c:3967 [inline]
 __x64_sys_mknodat+0xaa/0xe0 fs/namei.c:3967
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f2443bec549
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdd9390cc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000103
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f2443bec549
RDX: 0000000000000000 RSI: 0000000020000040 RDI: 0000000000000005
RBP: 00007ffdd9390cf0 R08: 0000000000000001 R09: 00007ffdd9390d00
R10: 0000000000000103 R11: 0000000000000246 R12: 0000000000000003
R13: 00007ffdd9390d30 R14: 00007ffdd9390d10 R15: 0000000000000009
 </TASK>

Allocated by task 3621:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc mm/kasan/common.c:516 [inline]
 ____kasan_kmalloc mm/kasan/common.c:475 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
 kmalloc include/linux/slab.h:605 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 nilfs_mdt_init+0x2c/0x1e0 fs/nilfs2/mdt.c:451
 nilfs_sufile_read+0x191/0x5a0 fs/nilfs2/sufile.c:1183
 nilfs_load_super_root fs/nilfs2/the_nilfs.c:130 [inline]
 load_nilfs+0x671/0x1330 fs/nilfs2/the_nilfs.c:269
 nilfs_fill_super fs/nilfs2/super.c:1059 [inline]
 nilfs_mount+0xa9a/0xfb0 fs/nilfs2/super.c:1317
 legacy_get_tree+0x105/0x220 fs/fs_context.c:610
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888020124400
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 152 bytes inside of
 256-byte region [ffff888020124400, ffff888020124500)

The buggy address belongs to the physical page:
page:ffffea0000804900 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888020124a00 pfn:0x20124
head:ffffea0000804900 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea0001ff2508 ffff888011840708 ffff888011841b40
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 7456347523, free_ts 0
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5515
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2103
 alloc_pages+0x22f/0x270 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x7f1/0xe10 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmalloc+0x32b/0x340 mm/slub.c:4420
 kmalloc include/linux/slab.h:605 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 rh_call_control drivers/usb/core/hcd.c:514 [inline]
 rh_urb_enqueue drivers/usb/core/hcd.c:848 [inline]
 usb_hcd_submit_urb+0x661/0x2220 drivers/usb/core/hcd.c:1552
 usb_submit_urb+0x86d/0x1880 drivers/usb/core/urb.c:594
 usb_start_wait_urb+0x101/0x4b0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 usb_get_string+0xbe/0x1b0 drivers/usb/core/message.c:843
 usb_string_sub+0xfa/0x3d0 drivers/usb/core/message.c:882
 usb_string+0x2fb/0x530 drivers/usb/core/message.c:987
 usb_cache_string+0x82/0x140 drivers/usb/core/message.c:1029
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888020124380: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888020124400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888020124480: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
                            ^
 ffff888020124500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888020124580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
