Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FC57361AA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 04:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjFTCzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 22:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFTCzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 22:55:49 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D78119
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 19:55:48 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7775a282e25so368624439f.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 19:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687229747; x=1689821747;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQGTF8OFuI9OtpfQ6Dw54yy20SbitUZRpRB5cOTPgYs=;
        b=Fb7ofwT3b9iqcDYZpK4zvIWxLT/5lgvg78Kji/gG8HySoH8e7LSQZfapD5mHlv2n7A
         NSIcfab1wjKMjpq/8kmBYb+R+bE6vCK0aG2W+NZVjQ0ekOeHIHrKOKTIW+zmXGuQIvLM
         v5hO27VBTq/pwh8nMVPSoKOE0lUO0hQaqhQJxVGRg9lhwaVNO+Qlwb6xXcK8mJWprtCy
         OcU4ocgB3qwxz4TVxOclcj9YDcm3YYAWk3Qh1lMqxqN3LhN2EePP8OvUzgzk8oJ2VnA3
         utLOeS3begQvlxYPAsVPiK6N+2J7Sosg2kTOZJ7CWaUh0SFhLVifhI5tiT/MoALyw/wx
         UL9Q==
X-Gm-Message-State: AC+VfDwPHXpYr902lg033MZCWsZC4WuTtCOJJ74WssOteGPv4kNUlhrD
        5ySGce5zgGixdSllmECvVqaQ13qb1dhVp8WcWBtRIw19FhEs
X-Google-Smtp-Source: ACHHUZ4YsB+M17ZFmtEklcnEnM3B0W8Rm/drVONxcKZOq2/dpBfVZEd0k6hHx9tOu7KmWjKMLipIsGQa/ertH3n9L5EKet+9k1Dd
MIME-Version: 1.0
X-Received: by 2002:a5e:8515:0:b0:77b:26ad:ab1b with SMTP id
 i21-20020a5e8515000000b0077b26adab1bmr3351268ioj.4.1687229747492; Mon, 19 Jun
 2023 19:55:47 -0700 (PDT)
Date:   Mon, 19 Jun 2023 19:55:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0ffe505fe86c9ca@google.com>
Subject: [syzbot] [usb?] KASAN: slab-out-of-bounds Read in read_descriptors (3)
From:   syzbot <syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1581445b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac246111fb601aec
dashboard link: https://syzkaller.appspot.com/bug?extid=18996170f8096c6174d0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d23487280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16613ed3280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/30922ad38c58/disk-40f71e7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3bd12e7503b8/vmlinux-40f71e7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1dcd340b18d4/bzImage-40f71e7c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18996170f8096c6174d0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in read_descriptors+0x263/0x280 drivers/usb/core/sysfs.c:883
Read of size 8 at addr ffff88801e78b8c8 by task udevd/5011

CPU: 0 PID: 5011 Comm: udevd Not tainted 6.4.0-rc6-syzkaller-00195-g40f71e7cd3c6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 read_descriptors+0x263/0x280 drivers/usb/core/sysfs.c:883
 sysfs_kf_bin_read+0x19a/0x270 fs/sysfs/file.c:97
 kernfs_file_read_iter fs/kernfs/file.c:251 [inline]
 kernfs_fop_read_iter+0x387/0x690 fs/kernfs/file.c:280
 call_read_iter include/linux/fs.h:1862 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x4b1/0x8a0 fs/read_write.c:470
 ksys_read+0x12b/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f07c7916b6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffdf34973d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f07c7916b6a
RDX: 0000000000010011 RSI: 00007ffdf3497407 RDI: 0000000000000008
RBP: 0000000000000008 R08: 0000000000000003 R09: f4f13e10193fbafe
R10: 0000000000000000 R11: 0000000000000246 R12: 000055be37470e10
R13: 00007ffdf34a7ae8 R14: 00007ffdf34a8138 R15: 00007ffdf3497407
 </TASK>

Allocated by task 758:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc+0x5e/0x190 mm/slab_common.c:979
 kmalloc include/linux/slab.h:563 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 usb_get_configuration+0x1f7/0x5170 drivers/usb/core/config.c:887
 usb_enumerate_device drivers/usb/core/hub.c:2407 [inline]
 usb_new_device+0x12b0/0x19d0 drivers/usb/core/hub.c:2545
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x2d9e/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff88801e78b8c0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 8-byte region [ffff88801e78b8c0, ffff88801e78b8c8)

The buggy address belongs to the physical page:
page:ffffea000079e2c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1e78b
anon flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000000200 ffff888012441280 0000000000000000 dead000000000001
raw: 0000000000000000 0000000000660066 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 8298345549, free_ts 8292702290
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0xf41/0x2c00 mm/page_alloc.c:3502
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2112
 alloc_pages+0x233/0x270 mm/mempolicy.c:2274
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3490
 __do_kmalloc_node mm/slab_common.c:965 [inline]
 __kmalloc_node_track_caller+0x4f/0x1a0 mm/slab_common.c:986
 kstrdup+0x3f/0x70 mm/util.c:62
 kstrdup_const+0x57/0x80 mm/util.c:85
 kvasprintf_const+0x10c/0x190 lib/kasprintf.c:48
 kobject_set_name_vargs+0x5a/0x150 lib/kobject.c:267
 dev_set_name+0xbf/0xf0 drivers/base/core.c:3429
 tty_register_device_attr+0x301/0x7d0 drivers/tty/tty_io.c:3243
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1302 [inline]
 free_unref_page_prepare+0x62e/0xcb0 mm/page_alloc.c:2564
 free_unref_page+0x33/0x370 mm/page_alloc.c:2659
 vfree+0x180/0x7e0 mm/vmalloc.c:2798
 delayed_vfree_work+0x57/0x70 mm/vmalloc.c:2719
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff88801e78b780: 00 fc fc fc fc fa fc fc fc fc fa fc fc fc fc fa
 ffff88801e78b800: fc fc fc fc 00 fc fc fc fc fa fc fc fc fc fa fc
>ffff88801e78b880: fc fc fc fa fc fc fc fc 00 fc fc fc fc 00 fc fc
                                              ^
 ffff88801e78b900: fc fc 00 fc fc fc fc fa fc fc fc fc 00 fc fc fc
 ffff88801e78b980: fc 00 fc fc fc fc fa fc fc fc fc 00 fc fc fc fc
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
