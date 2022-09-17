Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EBD5BBA77
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 22:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIQUwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 16:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiIQUwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 16:52:40 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA852B243
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 13:52:38 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id x14-20020a056e021cae00b002f1d5aca8c6so16496674ill.5
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 13:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bfXbTKLbXHZLIP+W+CGghsYmmEe01ZlFPvP4RL9ydzU=;
        b=EaKYihSabSTsAWBj2XxE2fcQtTyvk8Hi7PHQXQyMqeS1sDzahRyG1ZPm90n6e820dh
         svRiqU+BDdTh72ZitY6Rb9BRrihZ0usgsEMvOm0cuBl4fuGzV9TeMQSjX4qOlwUaWqiO
         NfhIkbLg0dSlehJulZUINi2f6neYT6sUpzicUW4PQictJVTTlpmXUw07rsIAS4xAG+R3
         cm/AYW9dxAGoBEuCvpAwjfENGO+Ba2FWSU9Yg3sq3LeM9VQCVZsZ+t+VNvROAwbLenz/
         EQoPD+1YuR8Hhaqe3xqB8oaqjU1CzeiijPJy/ijubuX+2jn7o/dByKkVDMMes7yQ/Y/U
         8AcA==
X-Gm-Message-State: ACrzQf2dKdv2PBM9JFBNbPOOIgKPGHJRccGK4J/MB78v6kBTOMOGyoAM
        Py7gjab5QY6UEGtfANOYfps12Q4UZXI/xYH/yz54UHefP9F1
X-Google-Smtp-Source: AMsMyM4JZTW40HSumUKVXiAcjH7xMEjL+2oTdZgfKTKLgjpIx/EgK9vN5yRQuPGCrjGVqMlm1Ik1cdbe4Q/oDIm3iimnSXZTDZ64
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caf:b0:2f2:1639:63a0 with SMTP id
 x15-20020a056e021caf00b002f2163963a0mr4599491ill.5.1663447956659; Sat, 17 Sep
 2022 13:52:36 -0700 (PDT)
Date:   Sat, 17 Sep 2022 13:52:36 -0700
In-Reply-To: <000000000000f296b105e799d0d6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f273a05e8e5a8be@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in powermate_config_complete (4)
From:   syzbot <syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com>
To:     dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mailhol.vincent@wanadoo.fr,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    7eb2bf871454 usb: misc: usb3503: call clk_disable_unprepar..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=17c5ded8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c3701a9706c1806e
dashboard link: https://syzkaller.appspot.com/bug?extid=0434ac83f907a1dbdd1e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12137fbf080000

Downloadable assets:
disk image: https://storage.googleapis.com/41793befa693/disk-7eb2bf87.raw.xz
vmlinux: https://storage.googleapis.com/354080f0592d/vmlinux-7eb2bf87.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com

powermate 3-1:0.0: powermate_irq - usb_submit_urb failed with result: -19
powermate: config urb returned -71
==================================================================
BUG: KASAN: use-after-free in __lock_acquire+0x3ee7/0x56d0 kernel/locking/lockdep.c:4923
Read of size 8 at addr ffff88811c320858 by task ksoftirqd/0/13

CPU: 0 PID: 13 Comm: ksoftirqd/0 Not tainted 6.0.0-rc4-syzkaller-00066-g7eb2bf871454 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 __lock_acquire+0x3ee7/0x56d0 kernel/locking/lockdep.c:4923
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 powermate_config_complete+0x79/0xb0 drivers/input/misc/powermate.c:202
 __usb_hcd_giveback_urb+0x2b0/0x5c0 drivers/usb/core/hcd.c:1671
 usb_hcd_giveback_urb+0x380/0x430 drivers/usb/core/hcd.c:1754
 dummy_timer+0x11ff/0x32c0 drivers/usb/gadget/udc/dummy_hcd.c:1988
 call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x1c0/0x9a9 kernel/softirq.c:571
 run_ksoftirqd kernel/softirq.c:934 [inline]
 run_ksoftirqd+0x2d/0x60 kernel/softirq.c:926
 smpboot_thread_fn+0x645/0x9c0 kernel/smpboot.c:164
 kthread+0x2ea/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Allocated by task 12:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc mm/kasan/common.c:516 [inline]
 __kasan_kmalloc+0x81/0xa0 mm/kasan/common.c:525
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 powermate_probe+0x24a/0x12a0 drivers/input/misc/powermate.c:323
 usb_probe_interface+0x30b/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1d0/0x2e0 drivers/base/dd.c:936
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbd5/0x1e90 drivers/base/core.c:3517
 usb_set_configuration+0x1019/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd4/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1d0/0x2e0 drivers/base/dd.c:936
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbd5/0x1e90 drivers/base/core.c:3517
 usb_new_device.cold+0x685/0x10ad drivers/usb/core/hub.c:2573
 hub_port_connect drivers/usb/core/hub.c:5353 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x26c7/0x4610 drivers/usb/core/hub.c:5735
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2ea/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Freed by task 4017:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:367 [inline]
 ____kasan_slab_free+0x14a/0x1b0 mm/kasan/common.c:329
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook mm/slub.c:1780 [inline]
 slab_free mm/slub.c:3534 [inline]
 kfree+0xca/0x5c0 mm/slub.c:4562
 powermate_disconnect+0x1ce/0x250 drivers/input/misc/powermate.c:432
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:550 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:542
 __device_release_driver drivers/base/dd.c:1249 [inline]
 device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1275
 bus_remove_device+0x2e3/0x590 drivers/base/bus.c:529
 device_del+0x4f3/0xc80 drivers/base/core.c:3704
 usb_disable_device+0x356/0x7a0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x259/0x6ed drivers/usb/core/hub.c:2235
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x1f86/0x4610 drivers/usb/core/hub.c:5735
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2ea/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff88811c320800
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 88 bytes inside of
 256-byte region [ffff88811c320800, ffff88811c320900)

The buggy address belongs to the physical page:
page:ffffea000470c800 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88811c320a00 pfn:0x11c320
head:ffffea000470c800 order:1 compound_mapcount:0 compound_pincount:0
flags: 0x200000000010200(slab|head|node=0|zone=2)
raw: 0200000000010200 ffffea0004630180 dead000000000002 ffff888100041b40
raw: ffff88811c320a00 000000008010000b 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 1179, tgid 1179 (udevd), ts 1649194346318, free_ts 1649184314294
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x11cc/0x2a20 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5515
 __alloc_pages_node include/linux/gfp.h:243 [inline]
 alloc_slab_page mm/slub.c:1826 [inline]
 allocate_slab+0x80/0x3d0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x7b4/0xda0 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 __kmalloc_node+0x12a/0x360 mm/slub.c:4468
 kmalloc_array_node include/linux/slab.h:695 [inline]
 kcalloc_node include/linux/slab.h:700 [inline]
 memcg_alloc_slab_cgroups+0x8b/0x140 mm/memcontrol.c:2830
 account_slab mm/slab.h:630 [inline]
 allocate_slab+0x2db/0x3d0 mm/slub.c:1985
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x7b4/0xda0 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
 kmem_cache_alloc_lru+0x4f5/0x6e0 mm/slub.c:3275
 alloc_inode_sb include/linux/fs.h:3103 [inline]
 alloc_inode+0x168/0x230 fs/inode.c:262
 iget_locked+0x1b7/0x6f0 fs/inode.c:1287
 kernfs_get_inode+0x47/0x520 fs/kernfs/inode.c:254
 kernfs_iop_lookup+0x1e5/0x320 fs/kernfs/dir.c:1153
 lookup_open.isra.0+0x76a/0x12a0 fs/namei.c:3391
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5d2/0xb80 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x420 mm/page_alloc.c:3476
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x78/0x80 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3243 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 kmem_cache_alloc_trace+0x2b3/0x3b0 mm/slub.c:3282
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 dev_new drivers/usb/gadget/legacy/raw_gadget.c:191 [inline]
 raw_open+0x87/0x500 drivers/usb/gadget/legacy/raw_gadget.c:385
 misc_open+0x376/0x4a0 drivers/char/misc.c:143
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x49c/0x1240 fs/open.c:878
 do_open fs/namei.c:3557 [inline]
 path_openat+0x1c92/0x28f0 fs/namei.c:3691
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1338
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88811c320700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88811c320780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88811c320800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                    ^
 ffff88811c320880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88811c320900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

