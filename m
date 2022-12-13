Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F122064B663
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiLMNgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbiLMNgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:36:40 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7481419C38
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:36:39 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id s1-20020a056e021a0100b003026adad6a9so7493005ild.18
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 05:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0YRwHAXNZ50GNWF2AK2coFpr1Tq8FUiG/h0+/L+UhI=;
        b=O9siSQdIQu1PI3IX2eCCArxp8Iz4ai/CupXkZQAssTilDH5+ttshN/+viEprkhimmM
         Wp/ONbJhpjRFcMLYSdRQZ3fispaGtebsf6XETye/BjVbZU99dD1IhPsu9eAp+UTWnWkV
         PoSpket+fUd5ZlfJbEM4zN9ZFv4Ue4C4adysXE5/+H3IpVNoAyaqPcz+8cz6VVC6Sp1q
         j/TcUhFAnazbEHcEb8ezC1Nhlw0mD/+TgixDSnstCet9/u/IOLpgY0w4mOxRk8c95kl7
         lIBnQ5N66lRS8SCPnYYpOBhlvcXFx9lUR2sHZAdFu7pPNZgFSweEw7+i1oFiSKQRbfnO
         gh/w==
X-Gm-Message-State: ANoB5pnIkqdussa1GtZexPLy6agfwHwpyZwnOzLtxqGA/tt7dBqRY4UR
        As7aI7oKNnIU95KffXEffJFpn8ALwvE18gHKtL97JdUctNPy
X-Google-Smtp-Source: AA0mqf5h6cRF83tWEtYROGmLv5BMziYxszyo/HW8rorNHVYLLRNEmyTP5N1OgA+k5b+adYHWn8elJhqsqa3gRDA8kXM8n5kEB6Ih
MIME-Version: 1.0
X-Received: by 2002:a92:ca8d:0:b0:302:de10:7ae1 with SMTP id
 t13-20020a92ca8d000000b00302de107ae1mr35537013ilo.15.1670938598794; Tue, 13
 Dec 2022 05:36:38 -0800 (PST)
Date:   Tue, 13 Dec 2022 05:36:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009f6b9c05efb5b59c@google.com>
Subject: [syzbot] KASAN: use-after-free Write in gadgetfs_kill_sb
From:   syzbot <syzbot+33d7ad66d65044b93f16@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, hbh25y@gmail.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mingo@kernel.org, rdunlap@infradead.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    830b3c68c1fb Linux 6.1
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=137401b7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a194ed4fc682723
dashboard link: https://syzkaller.appspot.com/bug?extid=33d7ad66d65044b93f16
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=176d36b7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109371b7880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/955d55d85d6c/disk-830b3c68.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7ef0e1f6a0c3/vmlinux-830b3c68.xz
kernel image: https://storage.googleapis.com/syzbot-assets/27601eb5ff0b/bzImage-830b3c68.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+33d7ad66d65044b93f16@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:102 [inline]
BUG: KASAN: use-after-free in atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:176 [inline]
BUG: KASAN: use-after-free in __refcount_sub_and_test include/linux/refcount.h:272 [inline]
BUG: KASAN: use-after-free in __refcount_dec_and_test include/linux/refcount.h:315 [inline]
BUG: KASAN: use-after-free in refcount_dec_and_test include/linux/refcount.h:333 [inline]
BUG: KASAN: use-after-free in put_dev drivers/usb/gadget/legacy/inode.c:159 [inline]
BUG: KASAN: use-after-free in gadgetfs_kill_sb+0x33/0x100 drivers/usb/gadget/legacy/inode.c:2086
Write of size 4 at addr ffff8880276d7840 by task syz-executor126/18689

CPU: 0 PID: 18689 Comm: syz-executor126 Not tainted 6.1.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x1f0 mm/kasan/report.c:395
 kasan_report+0xcd/0x100 mm/kasan/report.c:495
 kasan_check_range+0x2a7/0x2e0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:102 [inline]
 atomic_fetch_sub_release include/linux/atomic/atomic-instrumented.h:176 [inline]
 __refcount_sub_and_test include/linux/refcount.h:272 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 put_dev drivers/usb/gadget/legacy/inode.c:159 [inline]
 gadgetfs_kill_sb+0x33/0x100 drivers/usb/gadget/legacy/inode.c:2086
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 vfs_get_super fs/super.c:1190 [inline]
 get_tree_single+0xd0/0x160 fs/super.c:1207
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 vfs_fsconfig_locked fs/fsopen.c:232 [inline]
 __do_sys_fsconfig fs/fsopen.c:439 [inline]
 __se_sys_fsconfig+0xbc0/0x1060 fs/fsopen.c:314
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f1ce0ecbdf9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0005e5f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
RAX: ffffffffffffffda RBX: 00000000000f4240 RCX: 00007f1ce0ecbdf9
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000206b5
R13: 00007fff0005e60c R14: 00007fff0005e620 R15: 00007fff0005e610
 </TASK>

Allocated by task 18687:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:553 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 dev_new drivers/usb/gadget/legacy/inode.c:170 [inline]
 gadgetfs_fill_super+0x2f9/0x8a0 drivers/usb/gadget/legacy/inode.c:2041
 vfs_get_super fs/super.c:1169 [inline]
 get_tree_single+0xb4/0x160 fs/super.c:1207
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 vfs_fsconfig_locked fs/fsopen.c:232 [inline]
 __do_sys_fsconfig fs/fsopen.c:439 [inline]
 __se_sys_fsconfig+0xbc0/0x1060 fs/fsopen.c:314
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 18687:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 __kmem_cache_free+0x71/0x110 mm/slub.c:3674
 put_dev drivers/usb/gadget/legacy/inode.c:163 [inline]
 gadgetfs_kill_sb+0x8a/0x100 drivers/usb/gadget/legacy/inode.c:2086
 deactivate_locked_super+0xa7/0xf0 fs/super.c:332
 put_fs_context+0x90/0x7a0 fs/fs_context.c:465
 fscontext_release+0x61/0x80 fs/fsopen.c:73
 __fput+0x3ba/0x880 fs/file_table.c:320
 task_work_run+0x243/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x664/0x2070 kernel/exit.c:820
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:950
 __do_sys_exit_group kernel/exit.c:961 [inline]
 __se_sys_exit_group kernel/exit.c:959 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:959
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880276d7800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 64 bytes inside of
 1024-byte region [ffff8880276d7800, ffff8880276d7c00)

The buggy address belongs to the physical page:
page:ffffea00009db400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x276d0
head:ffffea00009db400 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 dead000000000100 dead000000000122 ffff888012841dc0
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3626, tgid 3626 (sshd), ts 64243807059, free_ts 64103482939
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
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc_node_track_caller+0x9c/0x190 mm/slab_common.c:975
 kmalloc_reserve net/core/skbuff.c:437 [inline]
 __alloc_skb+0x112/0x2b0 net/core/skbuff.c:509
 alloc_skb_fclone include/linux/skbuff.h:1317 [inline]
 tcp_stream_alloc_skb+0x3c/0x300 net/ipv4/tcp.c:862
 tcp_sendmsg_locked+0xd70/0x40d0 net/ipv4/tcp.c:1325
 tcp_sendmsg+0x2c/0x40 net/ipv4/tcp.c:1483
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg net/socket.c:734 [inline]
 sock_write_iter+0x3d4/0x540 net/socket.c:1108
 call_write_iter include/linux/fs.h:2199 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3483
 free_slab mm/slub.c:2031 [inline]
 discard_slab mm/slub.c:2037 [inline]
 __unfreeze_partials+0x1ab/0x200 mm/slub.c:2586
 put_cpu_partial+0x106/0x170 mm/slub.c:2662
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x1f/0x70 mm/kasan/common.c:302
 kasan_slab_alloc include/linux/kasan.h:201 [inline]
 slab_post_alloc_hook mm/slab.h:737 [inline]
 slab_alloc_node mm/slub.c:3398 [inline]
 kmem_cache_alloc_node+0x1ca/0x340 mm/slub.c:3443
 __alloc_skb+0xcf/0x2b0 net/core/skbuff.c:497
 alloc_skb_fclone include/linux/skbuff.h:1317 [inline]
 tcp_stream_alloc_skb+0x3c/0x300 net/ipv4/tcp.c:862
 tcp_sendmsg_locked+0xd70/0x40d0 net/ipv4/tcp.c:1325
 tcp_sendmsg+0x2c/0x40 net/ipv4/tcp.c:1483
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg net/socket.c:734 [inline]
 sock_write_iter+0x3d4/0x540 net/socket.c:1108
 call_write_iter include/linux/fs.h:2199 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80

Memory state around the buggy address:
 ffff8880276d7700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880276d7780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880276d7800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                           ^
 ffff8880276d7880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880276d7900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
