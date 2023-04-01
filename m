Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FC96D2F05
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 10:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjDAINC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 04:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbjDAIM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 04:12:56 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E52CDCC
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 01:12:52 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id l7-20020a0566022dc700b0074cc9aba965so14686694iow.11
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 01:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680336772; x=1682928772;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3x+3S/4mQfBz7B1mRBqTQUFRJ9MVYCieBns22m3M3UE=;
        b=MWUTpt45lEyjHmddte60ndArODoeXtIMzk8s1JzSiA4vQ5LMy/FJzAzRP5U1i5co/w
         PhbwUKuuQH3J4oiLXFgr/lKXgU1LO/4g051gU6sQ9/uW5K1ftiUs78ff1wlUxYrLGdNl
         Pggtbghz7XoPYoQxOR3KNssyPOATExFKLJ8nwc1L3wv1H3ZdgKKf2eT4T2hf2UAD5//8
         PqNwcRDzs6zECdZxAQUG0YM993NlsCH9nKZ/3TQ/YBdPNURFrV1ZYuo5HUjSfnxsrGk+
         iXh3u4fYU+8N+EhBesgE6gep7JQYULl5J/f+LNS669cyMRVeU2Lfw7idEc+xLA1W0qAI
         eABg==
X-Gm-Message-State: AAQBX9fYrsYmZVSVtxtfZBPKIhbc4FfMI3z/TUyQdZoaip2Cr7C467Tu
        iuxfFil8oUFkGw1HSozCb4bVoCFrhAcGPQ7gk0w00MjUtWYt
X-Google-Smtp-Source: AKy350Z6od4GO1ovUahNEUbd1XrSzboiAT4u3F6udFTASbFyiOo9M6qrKd1brUlBDEfvBvqF5B8tJCERnbDcsAkkoZzb3OZATYCo
MIME-Version: 1.0
X-Received: by 2002:a5d:974d:0:b0:752:c3a6:51e2 with SMTP id
 c13-20020a5d974d000000b00752c3a651e2mr4548647ioo.2.1680336771767; Sat, 01 Apr
 2023 01:12:51 -0700 (PDT)
Date:   Sat, 01 Apr 2023 01:12:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062649c05f841e476@google.com>
Subject: [syzbot] [kernel?] KASAN: slab-use-after-free Read in class_register
From:   syzbot <syzbot+41d665317c811d4d88aa@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    198925fae644 Add linux-next specific files for 20230329
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f9a03ec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91e70627549fd509
dashboard link: https://syzkaller.appspot.com/bug?extid=41d665317c811d4d88aa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105d5a2ec80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ab4895c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/53c685bee82f/disk-198925fa.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/45e82baa3bc5/vmlinux-198925fa.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7c31fbc6acb9/bzImage-198925fa.xz

The issue was bisected to:

commit dcfbb67e48a2becfce7990386e985b9c45098ee5
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Fri Mar 24 10:01:31 2023 +0000

    driver core: class: use lock_class_key already present in struct subsys_private

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=173f4ab9c80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14bf4ab9c80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10bf4ab9c80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41d665317c811d4d88aa@syzkaller.appspotmail.com
Fixes: dcfbb67e48a2 ("driver core: class: use lock_class_key already present in struct subsys_private")

usb 1-1: New USB device strings: Mfr=0, Product=106, SerialNumber=59
usb 1-1: Product: syz
usb 1-1: SerialNumber: syz
hub 1-1:250.228: bad descriptor, ignoring hub
hub: probe of 1-1:250.228 failed with error -5
==================================================================
BUG: KASAN: slab-use-after-free in lockdep_register_key+0x396/0x410 kernel/locking/lockdep.c:1231
Read of size 8 at addr ffff888020bbc360 by task kworker/1:2/2492

CPU: 1 PID: 2492 Comm: kworker/1:2 Not tainted 6.3.0-rc4-next-20230329-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 lockdep_register_key+0x396/0x410 kernel/locking/lockdep.c:1231
 class_register+0xed/0x530 drivers/base/class.c:172
 class_create+0x99/0x100 drivers/base/class.c:249
 init_usb_class drivers/usb/core/file.c:91 [inline]
 usb_register_dev+0x4e7/0x860 drivers/usb/core/file.c:179
 usblp_probe+0xc91/0x16d0 drivers/usb/class/usblp.c:1208
 usb_probe_interface+0x30f/0x960 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:795
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:825
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:953
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1025
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11c4/0x1c50 drivers/base/core.c:3611
 usb_set_configuration+0x10ee/0x1af0 drivers/usb/core/message.c:2171
 usb_generic_driver_probe+0xcf/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:795
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:825
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:953
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1025
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11c4/0x1c50 drivers/base/core.c:3611
 usb_new_device+0xcb2/0x19d0 drivers/usb/core/hub.c:2575
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x2d9e/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 process_scheduled_works kernel/workqueue.c:2468 [inline]
 worker_thread+0x881/0x10c0 kernel/workqueue.c:2554
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>

Allocated by task 2492:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kmalloc include/linux/slab.h:559 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 class_register+0x55/0x530 drivers/base/class.c:165
 class_create+0x99/0x100 drivers/base/class.c:249
 init_usb_class drivers/usb/core/file.c:91 [inline]
 usb_register_dev+0x4e7/0x860 drivers/usb/core/file.c:179
 usblp_probe+0xc91/0x16d0 drivers/usb/class/usblp.c:1208
 usb_probe_interface+0x30f/0x960 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:795
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:825
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:953
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1025
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11c4/0x1c50 drivers/base/core.c:3611
 usb_set_configuration+0x10ee/0x1af0 drivers/usb/core/message.c:2171
 usb_generic_driver_probe+0xcf/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:795
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:825
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:953
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1025
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x11c4/0x1c50 drivers/base/core.c:3611
 usb_new_device+0xcb2/0x19d0 drivers/usb/core/hub.c:2575
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x2d9e/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 process_scheduled_works kernel/workqueue.c:2468 [inline]
 worker_thread+0x881/0x10c0 kernel/workqueue.c:2554
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Freed by task 2492:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
 kobject_cleanup lib/kobject.c:683 [inline]
 kobject_release lib/kobject.c:714 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1c2/0x4d0 lib/kobject.c:731
 kset_unregister+0x64/0x80 lib/kobject.c:880
 class_destroy+0x3c/0x50 drivers/base/class.c:273
 release_usb_class drivers/usb/core/file.c:108 [inline]
 kref_put include/linux/kref.h:65 [inline]
 destroy_usb_class drivers/usb/core/file.c:116 [inline]
 usb_deregister_dev+0x274/0x320 drivers/usb/core/file.c:245
 usblp_disconnect+0x4a/0x330 drivers/usb/class/usblp.c:1396
 usb_unbind_interface+0x1dc/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1267 [inline]
 device_release_driver_internal+0x443/0x610 drivers/base/dd.c:1290
 bus_remove_device+0x22c/0x420 drivers/base/bus.c:574
 device_del+0x48a/0xb80 drivers/base/core.c:3797
 usb_disable_device+0x35a/0x7b0 drivers/usb/core/message.c:1420
 usb_disconnect+0x2db/0x8a0 drivers/usb/core/hub.c:2238
 hub_port_connect drivers/usb/core/hub.c:5246 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x1fbf/0x4e40 drivers/usb/core/hub.c:5793
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 process_scheduled_works kernel/workqueue.c:2468 [inline]
 worker_thread+0x881/0x10c0 kernel/workqueue.c:2554
 kthread+0x33e/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

The buggy address belongs to the object at ffff888020bbc000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 864 bytes inside of
 freed 1024-byte region [ffff888020bbc000, ffff888020bbc400)

The buggy address belongs to the physical page:
page:ffffea000082ee00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x20bb8
head:ffffea000082ee00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012441dc0 ffffea0001dcf600 dead000000000002
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2000(__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 46, tgid 46 (kworker/u4:3), ts 9746960068, free_ts 0
 prep_new_page mm/page_alloc.c:1729 [inline]
 get_page_from_freelist+0xf75/0x2aa0 mm/page_alloc.c:3493
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4759
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_slab_page mm/slub.c:1853 [inline]
 allocate_slab+0xa7/0x380 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3491
 kmalloc_node_trace+0x21/0xd0 mm/slab_common.c:1070
 kmalloc_node include/linux/slab.h:575 [inline]
 kzalloc_node include/linux/slab.h:691 [inline]
 blk_mq_alloc_hctx block/blk-mq.c:3628 [inline]
 blk_mq_alloc_and_init_hctx+0x6bc/0x11d0 block/blk-mq.c:4105
 blk_mq_realloc_hw_ctxs+0x47d/0x5e0 block/blk-mq.c:4138
 blk_mq_init_allocated_queue+0x299/0x1280 block/blk-mq.c:4191
 blk_mq_init_queue_data block/blk-mq.c:4010 [inline]
 blk_mq_init_queue+0x88/0xf0 block/blk-mq.c:4020
 scsi_alloc_sdev+0x852/0xd60 drivers/scsi/scsi_scan.c:335
 scsi_probe_and_add_lun+0x1506/0x2670 drivers/scsi/scsi_scan.c:1187
 __scsi_scan_target+0x249/0xe50 drivers/scsi/scsi_scan.c:1673
 scsi_scan_channel drivers/scsi/scsi_scan.c:1761 [inline]
 scsi_scan_channel+0x148/0x1e0 drivers/scsi/scsi_scan.c:1737
 scsi_scan_host_selected+0x2e3/0x3f0 drivers/scsi/scsi_scan.c:1790
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888020bbc200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888020bbc280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888020bbc300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff888020bbc380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888020bbc400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
