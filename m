Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C6A64142A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 05:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbiLCE5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 23:57:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiLCE5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 23:57:48 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA56F13E9D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 20:57:45 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id l16-20020a056e02067000b0030325bbd570so7374426ilt.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 20:57:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0S0xzjG6q1zYpDUMw/kYkv0+u+pWo8bq+lKkqvI8AVc=;
        b=Ff1Ur4EFvfO164wu12Nafko3ruAiQaBN+YyTloUucRyxPm7M6Bwp6yx6lq/mrVguib
         FzB+rxnW3FndfGj+mUzAMZM2h+/ISkr7lWPgLyva6Equ0j1Pu9qHdIDAUqfPVHyoCaTX
         O51tu11cpMqTQEcLd9xGBH1F1m0MlfuHvHwxAR9Cvn/wsyZ9u1CCqpMrL9Xg6FdSSQxE
         PXq7xJ3KPXU7x3BQ8r0S1RpEXXxEGNcJXTeL+fay74xDMgTNcCnDiFQcteiPeujG9MhU
         fHjVwra3e37AV/DKzWmnubOTXCbPLwHtgnCP1kbnNUJeY17/IVn60TmDORKWWNIhHz3g
         80Vg==
X-Gm-Message-State: ANoB5pkBRk4OxV9omsdW42zPHSi9Mi9blByntHpoB768OggsUUfS5cE7
        x3PMT0wAzBvb4c/DXYbg7zGqQuu4FspY3nxPC1t1Pl6VkIWh
X-Google-Smtp-Source: AA0mqf6C987UeQ0ejli51Epva5N296LEtLsxCwS+JvZf3Niu59pCvgBfKJdfWfSTSUV7Y6ymefUhFS60J9uFTSsYVPymxagpmxTH
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d17:b0:302:9392:5a01 with SMTP id
 i23-20020a056e021d1700b0030293925a01mr25678421ila.268.1670043465205; Fri, 02
 Dec 2022 20:57:45 -0800 (PST)
Date:   Fri, 02 Dec 2022 20:57:45 -0800
In-Reply-To: <00000000000035aab005ec690a00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080ce7a05eee54bf9@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in gsm_cleanup_mux
From:   syzbot <syzbot+893c55305230e719a203@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    a4412fdd49dc error-injection: Add prompt for function erro..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1323ec29880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cc4b2e0a8e8a8366
dashboard link: https://syzkaller.appspot.com/bug?extid=893c55305230e719a203
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12b1ca83880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1023c5e3880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5ed30eeb21a0/disk-a4412fdd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/db67a8a7ac7c/vmlinux-a4412fdd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8ee62d01893d/bzImage-a4412fdd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+893c55305230e719a203@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in gsm_cleanup_mux+0x785/0x800 drivers/tty/n_gsm.c:2491
Read of size 4 at addr ffff88802179600c by task syz-executor417/3673

CPU: 0 PID: 3673 Comm: syz-executor417 Not tainted 6.1.0-rc7-syzkaller-00123-ga4412fdd49dc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:395
 kasan_report+0xbf/0x1f0 mm/kasan/report.c:495
 gsm_cleanup_mux+0x785/0x800 drivers/tty/n_gsm.c:2491
 gsm_config drivers/tty/n_gsm.c:2754 [inline]
 gsmld_ioctl+0x533/0x1060 drivers/tty/n_gsm.c:3117
 tty_ioctl+0x7eb/0x1660 drivers/tty/tty_io.c:2780
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3dad9cbc79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3dad95c318 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f3dada534d8 RCX: 00007f3dad9cbc79
RDX: 0000000020000040 RSI: 00000000404c4701 RDI: 0000000000000005
RBP: 00007f3dada534d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3dada2107c
R13: 00007fff3c20a04f R14: 00007f3dad95c400 R15: 0000000000022000
 </TASK>

Allocated by task 3672:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa5/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:553 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 gsm_dlci_alloc+0x46/0x480 drivers/tty/n_gsm.c:2064
 gsm_activate_mux drivers/tty/n_gsm.c:2538 [inline]
 gsm_config drivers/tty/n_gsm.c:2778 [inline]
 gsmld_ioctl+0x800/0x1060 drivers/tty/n_gsm.c:3117
 tty_ioctl+0x7eb/0x1660 drivers/tty/tty_io.c:2780
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3672:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 __kmem_cache_free+0xaf/0x3b0 mm/slub.c:3674
 tty_port_destructor drivers/tty/tty_port.c:296 [inline]
 kref_put include/linux/kref.h:65 [inline]
 tty_port_put+0x15c/0x1c0 drivers/tty/tty_port.c:311
 dlci_put drivers/tty/n_gsm.c:2120 [inline]
 gsm_dlci_release drivers/tty/n_gsm.c:2153 [inline]
 gsm_cleanup_mux+0x2f6/0x800 drivers/tty/n_gsm.c:2512
 gsm_config drivers/tty/n_gsm.c:2754 [inline]
 gsmld_ioctl+0x533/0x1060 drivers/tty/n_gsm.c:3117
 tty_ioctl+0x7eb/0x1660 drivers/tty/tty_io.c:2780
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:481
 call_rcu+0x9d/0x820 kernel/rcu/tree.c:2798
 netlink_release+0xf0f/0x1dd0 net/netlink/af_netlink.c:815
 __sock_release+0xcd/0x280 net/socket.c:650
 sock_close+0x1c/0x20 net/socket.c:1365
 __fput+0x27c/0xa90 fs/file_table.c:320
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:481
 call_rcu+0x9d/0x820 kernel/rcu/tree.c:2798
 netlink_release+0xf0f/0x1dd0 net/netlink/af_netlink.c:815
 __sock_release+0xcd/0x280 net/socket.c:650
 sock_close+0x1c/0x20 net/socket.c:1365
 __fput+0x27c/0xa90 fs/file_table.c:320
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888021796000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 12 bytes inside of
 2048-byte region [ffff888021796000, ffff888021796800)

The buggy address belongs to the physical page:
page:ffffea000085e400 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x21790
head:ffffea000085e400 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea000060b200 dead000000000002 ffff888012042000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 9, tgid 9 (kworker/u4:0), ts 8642632567, free_ts 0
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x10b5/0x2d50 mm/page_alloc.c:4291
 __alloc_pages+0x1cb/0x5b0 mm/page_alloc.c:5558
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x213/0x300 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3180
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3279
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x199/0x3e0 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc+0x4a/0xd0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 scsi_alloc_target+0x132/0xc60 drivers/scsi/scsi_scan.c:504
 __scsi_scan_target+0x13a/0xdb0 drivers/scsi/scsi_scan.c:1648
 scsi_scan_channel drivers/scsi/scsi_scan.c:1753 [inline]
 scsi_scan_channel+0x148/0x1e0 drivers/scsi/scsi_scan.c:1729
 scsi_scan_host_selected+0x2e3/0x3b0 drivers/scsi/scsi_scan.c:1782
 do_scsi_scan_host+0x1e8/0x260 drivers/scsi/scsi_scan.c:1921
 do_scan_async+0x42/0x500 drivers/scsi/scsi_scan.c:1931
 async_run_entry_fn+0x9c/0x530 kernel/async.c:127
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888021795f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888021795f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888021796000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888021796080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888021796100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

