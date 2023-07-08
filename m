Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D25774BD72
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 14:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjGHMa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 08:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjGHMa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 08:30:56 -0400
Received: from mail-pg1-f208.google.com (mail-pg1-f208.google.com [209.85.215.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAAC172B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 05:30:54 -0700 (PDT)
Received: by mail-pg1-f208.google.com with SMTP id 41be03b00d2f7-53b9eb7bda0so3308172a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 05:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688819453; x=1691411453;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wcJhsa4rjQZtF6LqIZDcb4BN7mqpvMNxCAmkIRBATO4=;
        b=UeS8IvGVVL4Esfjsds0pT+ZgGHs3MHZY+Vu3a9V+ha+UAwg0MSowMfH/vQ2sHWgxqn
         gZK9DWcjCsa+4aliKt9f7AbgSSBYM3JxXyaz8yRfm/Xg9J/USAAzhDX4mgcn9G+p0dqD
         p2S6SMRrzyaeZShT1+vB8yxtyHHaBo38OYNlZm2TRzDibxXmmXL0X3iQ1QFaNAghPPyH
         A+Gvk8CYdxZ2mLN5r+hiVx71GycH6V/oc0GqPH0rGOaOWLVPOtWcK70U5MUfKZiUdKLJ
         Ik5/KmYlwSlnhJ+Ehrt6iDirl2u2AJFWFwAPAD1ku/QmaTg5YUgssa5G0wfiHQtNceqp
         NE7Q==
X-Gm-Message-State: ABy/qLbEjoOWkcbXs7bUH+N9IyQMpjSSIw7lqvbJLd7qykJ44bhQEh2w
        15AL8AG/BL580CKIxweiz2v9PuXKVRS7+VvE9ARVsf581Q/G
X-Google-Smtp-Source: APBJJlEUddym+XPEotY+FTWOf9YevWKHITuhtvQSlg9VdJb2xHCMGsqVFT7F38vpEC/LT71lmA2h3XXOGjHy2wBrGVEy/JJ9Ibkk
MIME-Version: 1.0
X-Received: by 2002:a63:344a:0:b0:557:33c6:603a with SMTP id
 b71-20020a63344a000000b0055733c6603amr5581628pga.7.1688819453665; Sat, 08 Jul
 2023 05:30:53 -0700 (PDT)
Date:   Sat, 08 Jul 2023 05:30:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a02a4205fff8eb92@google.com>
Subject: [syzbot] [pvrusb2?] [usb?] KASAN: slab-use-after-free Read in pvr2_context_set_notify
From:   syzbot <syzbot+621409285c4156a009b3@syzkaller.appspotmail.com>
To:     isely@pobox.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        mchehab@kernel.org, pvrusb2@isely.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    24be4d0b46bb arch/arm64/mm/fault: Fix undeclared variable ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=11383b04a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f9122dc1c4589f4c
dashboard link: https://syzkaller.appspot.com/bug?extid=621409285c4156a009b3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e2e43ca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109a3a90a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b64cbb1118f1/disk-24be4d0b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/568048c1dd0d/vmlinux-24be4d0b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/84ac264152e7/bzImage-24be4d0b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+621409285c4156a009b3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
Read of size 4 at addr ffff88810eb986d8 by task kworker/0:0/7

CPU: 0 PID: 7 Comm: kworker/0:0 Not tainted 6.4.0-syzkaller-11311-g24be4d0b46bb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: usb_hub_wq hub_event

Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:364
 print_report mm/kasan/report.c:475 [inline]
 kasan_report+0x11d/0x130 mm/kasan/report.c:588
 pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
 pvr_disconnect+0x80/0xf0 drivers/media/usb/pvrusb2/pvrusb2-main.c:79
 usb_unbind_interface+0x1dc/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1270 [inline]
 device_release_driver_internal+0x443/0x610 drivers/base/dd.c:1293
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x399/0xa30 drivers/base/core.c:3814
 usb_disable_device+0x360/0x7b0 drivers/usb/core/message.c:1420
 usb_disconnect+0x2db/0x8a0 drivers/usb/core/hub.c:2253
 hub_port_connect drivers/usb/core/hub.c:5261 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5566 [inline]
 port_event drivers/usb/core/hub.c:5726 [inline]
 hub_event+0x2073/0x4ed0 drivers/usb/core/hub.c:5808
 process_one_work+0xa34/0x16f0 kernel/workqueue.c:2597
 process_scheduled_works kernel/workqueue.c:2664 [inline]
 worker_thread+0x881/0x10c0 kernel/workqueue.c:2750
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 7:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0x7b/0x90 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:579 [inline]
 kzalloc include/linux/slab.h:700 [inline]
 pvr2_context_create+0x53/0x2a0 drivers/media/usb/pvrusb2/pvrusb2-context.c:207
 pvr_probe+0x25/0xe0 drivers/media/usb/pvrusb2/pvrusb2-main.c:54
 usb_probe_interface+0x30f/0x960 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4b0 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:828
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:956
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x112d/0x1a40 drivers/base/core.c:3625
 usb_set_configuration+0x1196/0x1bc0 drivers/usb/core/message.c:2211
 usb_generic_driver_probe+0xcf/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4b0 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:828
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:956
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x112d/0x1a40 drivers/base/core.c:3625
 usb_new_device+0xcb2/0x19d0 drivers/usb/core/hub.c:2590
 hub_port_connect drivers/usb/core/hub.c:5422 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5566 [inline]
 port_event drivers/usb/core/hub.c:5726 [inline]
 hub_event+0x2e3d/0x4ed0 drivers/usb/core/hub.c:5808
 process_one_work+0xa34/0x16f0 kernel/workqueue.c:2597
 process_scheduled_works kernel/workqueue.c:2664 [inline]
 worker_thread+0x881/0x10c0 kernel/workqueue.c:2750
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Freed by task 892:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2b/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x144/0x1b0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1792 [inline]
 slab_free_freelist_hook mm/slub.c:1818 [inline]
 slab_free mm/slub.c:3801 [inline]
 __kmem_cache_free+0xa1/0x350 mm/slub.c:3814
 pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:137 [inline]
 pvr2_context_thread_func+0x664/0x8e0 drivers/media/usb/pvrusb2/pvrusb2-context.c:158
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff88810eb98600
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 216 bytes inside of
 freed 256-byte region [ffff88810eb98600, ffff88810eb98700)

The buggy address belongs to the physical page:
page:ffffea00043ae600 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10eb98
head:ffffea00043ae600 order:1 entire_mapcount:0 nr_pages_mapped:0 pincount:0
anon flags: 0x200000000010200(slab|head|node=0|zone=2)
page_type: 0xffffffff()
raw: 0200000000010200 ffff888100041b40 ffffea00043ae300 0000000000000003
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 1, tgid 1 (swapper/0), ts 7338785555, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1570
 prep_new_page mm/page_alloc.c:1577 [inline]
 get_page_from_freelist+0x13d5/0x2cb0 mm/page_alloc.c:3221
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4477
 alloc_page_interleave+0x1e/0x1e0 mm/mempolicy.c:2112
 alloc_pages+0x233/0x270 mm/mempolicy.c:2274
 alloc_slab_page mm/slub.c:1862 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:2009
 new_slab mm/slub.c:2062 [inline]
 ___slab_alloc+0xbc3/0x15d0 mm/slub.c:3215
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3314
 __slab_alloc_node mm/slub.c:3367 [inline]
 slab_alloc_node mm/slub.c:3460 [inline]
 __kmem_cache_alloc_node+0x2c3/0x300 mm/slub.c:3509
 __do_kmalloc_node mm/slab_common.c:984 [inline]
 __kmalloc_node_track_caller+0x4f/0x1a0 mm/slab_common.c:1005
 __do_krealloc mm/slab_common.c:1373 [inline]
 krealloc+0x5e/0xf0 mm/slab_common.c:1406
 add_sysfs_param+0xca/0x960 kernel/params.c:652
 kernel_add_sysfs_param kernel/params.c:813 [inline]
 param_sysfs_builtin kernel/params.c:852 [inline]
 param_sysfs_builtin_init+0x241/0x440 kernel/params.c:986
 do_one_initcall+0x105/0x630 init/main.c:1232
 do_initcall_level init/main.c:1294 [inline]
 do_initcalls init/main.c:1310 [inline]
 do_basic_setup init/main.c:1329 [inline]
 kernel_init_freeable+0x649/0xb90 init/main.c:1546
 kernel_init+0x1e/0x2c0 init/main.c:1437
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88810eb98580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88810eb98600: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88810eb98680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88810eb98700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88810eb98780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
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
