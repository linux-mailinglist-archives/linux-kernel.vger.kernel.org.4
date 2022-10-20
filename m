Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25DAC605839
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiJTHRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiJTHRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:17:05 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4069165C8A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:16:28 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id 75-20020a6b144e000000b006bbed69b669so16099296iou.21
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BWlaFQ4FhqkHpsEZ03PZ275QJlP+3S330nZnxTIs85M=;
        b=mbd7lEy63BZ9/rjf1XUPJK9intKRUyeO1Yp+EWcEeUbV3eACOZHtQrGmo03dKapXAb
         szLUkEV5hSKKb3FrMWL/XIj8iZOIsOshUET7k1PCXqGUm6RHN+y7M6Ufkkr61+E6wllo
         ooN+3n/p2JqOhiUGA7tMzzn9SnLSrADt1JGQD6R0Us/HqzwmKGQNCP3A1F+Pz+MilKjh
         Pf1R/3N+khkCr1shLbhP9bEVcK+fCX9lGpW1Sboyp4kuhfOeQuWY36KNRobpwn0DwbUi
         fzeKDMffu+ew0Wi9AB1VvuxXw71I1Zf0Xp5OppvgDAGvKFmnyZAurWjdPamvz/jXOOKc
         662A==
X-Gm-Message-State: ACrzQf3h5hCPmtcee0+DrLDtqY1o4+B1B9LyFnUR8YRxHCMqDm8dkGS2
        hrollOiqmYHiPu1uR5uN5+A/XFXtKf8qnzft+/Wq4NBJ+SxH
X-Google-Smtp-Source: AMsMyM5+i9BHq3Xk3l6v3n3beuBLFk74sc86fkaYG/fmjvc2v8d/U8aW55nX9ltoAPCp2Y1qGHKq2ibeWIOvMrrmSaczesvvzyLA
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ec:b0:2fa:9024:b513 with SMTP id
 l12-20020a056e0212ec00b002fa9024b513mr8704193iln.120.1666250140908; Thu, 20
 Oct 2022 00:15:40 -0700 (PDT)
Date:   Thu, 20 Oct 2022 00:15:40 -0700
In-Reply-To: <0000000000003a95ce05cd867417@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c183f505eb721745@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in kernfs_next_descendant_post
 (2)
From:   syzbot <syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1449d53c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
dashboard link: https://syzkaller.appspot.com/bug?extid=6bc35f3913193fe7f0d3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e01c72880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1128908c880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6c791937c012/disk-55be6084.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cb21a2879b4c/vmlinux-55be6084.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com

usb 1-1: Direct firmware load for ueagle-atm/eagleI.fw failed with error -2
usb 1-1: Falling back to sysfs fallback for: ueagle-atm/eagleI.fw
==================================================================
BUG: KASAN: use-after-free in kernfs_type include/linux/kernfs.h:337 [inline]
BUG: KASAN: use-after-free in kernfs_leftmost_descendant fs/kernfs/dir.c:1262 [inline]
BUG: KASAN: use-after-free in kernfs_next_descendant_post+0x22a/0x2f0 fs/kernfs/dir.c:1293
Read of size 2 at addr ffff88814591c180 by task kworker/0:2/140

CPU: 0 PID: 140 Comm: kworker/0:2 Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Workqueue: events request_firmware_work_func
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 kernfs_type include/linux/kernfs.h:337 [inline]
 kernfs_leftmost_descendant fs/kernfs/dir.c:1262 [inline]
 kernfs_next_descendant_post+0x22a/0x2f0 fs/kernfs/dir.c:1293
 kernfs_activate fs/kernfs/dir.c:1344 [inline]
 kernfs_add_one+0x38d/0x4e0 fs/kernfs/dir.c:776
 kernfs_create_dir_ns+0x18b/0x220 fs/kernfs/dir.c:1021
 sysfs_create_dir_ns+0x127/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x2c9/0x8f0 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:410
 class_dir_create_and_add drivers/base/core.c:3054 [inline]
 get_device_parent+0x3d7/0x590 drivers/base/core.c:3109
 device_add+0x2aa/0x1e90 drivers/base/core.c:3438
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:82 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:158 [inline]
 firmware_fallback_sysfs+0x2d5/0xba0 drivers/base/firmware_loader/fallback.c:234
 _request_firmware+0xbca/0x1190 drivers/base/firmware_loader/main.c:856
 request_firmware_work_func+0xdd/0x230 drivers/base/firmware_loader/main.c:1105
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Allocated by task 140:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 __kasan_slab_alloc+0x90/0xc0 mm/kasan/common.c:470
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3248 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
 kmem_cache_alloc+0x267/0x3b0 mm/slub.c:3273
 kmem_cache_zalloc include/linux/slab.h:723 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:603
 kernfs_new_node fs/kernfs/dir.c:665 [inline]
 kernfs_create_dir_ns+0x9c/0x220 fs/kernfs/dir.c:1011
 sysfs_create_dir_ns+0x127/0x290 fs/sysfs/dir.c:59
 create_dir lib/kobject.c:63 [inline]
 kobject_add_internal+0x2c9/0x8f0 lib/kobject.c:223
 kobject_add_varg lib/kobject.c:358 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:410
 class_dir_create_and_add drivers/base/core.c:3054 [inline]
 get_device_parent+0x3d7/0x590 drivers/base/core.c:3109
 device_add+0x2aa/0x1e90 drivers/base/core.c:3438
 fw_load_sysfs_fallback drivers/base/firmware_loader/fallback.c:82 [inline]
 fw_load_from_user_helper drivers/base/firmware_loader/fallback.c:158 [inline]
 firmware_fallback_sysfs+0x2d5/0xba0 drivers/base/firmware_loader/fallback.c:234
 _request_firmware+0xbca/0x1190 drivers/base/firmware_loader/main.c:856
 request_firmware_work_func+0xdd/0x230 drivers/base/firmware_loader/main.c:1105
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Freed by task 2933:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:367 [inline]
 ____kasan_slab_free+0x166/0x1c0 mm/kasan/common.c:329
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1759 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1785
 slab_free mm/slub.c:3539 [inline]
 kmem_cache_free+0xeb/0x5b0 mm/slub.c:3556
 kernfs_put.part.0+0x2c4/0x540 fs/kernfs/dir.c:557
 kernfs_put+0x42/0x50 fs/kernfs/dir.c:531
 __kernfs_remove+0x463/0x600 fs/kernfs/dir.c:1443
 kernfs_remove+0x77/0xa0 fs/kernfs/dir.c:1463
 sysfs_remove_dir+0xc1/0x100 fs/sysfs/dir.c:101
 __kobject_del+0xe2/0x1f0 lib/kobject.c:588
 kobject_del lib/kobject.c:611 [inline]
 kobject_del+0x3c/0x60 lib/kobject.c:603
 device_del+0x81c/0xc80 drivers/base/core.c:3715
 usb_disconnect.cold+0x49b/0x6ed drivers/usb/core/hub.c:2261
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x1f86/0x45e0 drivers/usb/core/hub.c:5735
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 process_scheduled_works kernel/workqueue.c:2352 [inline]
 worker_thread+0x854/0x1080 kernel/workqueue.c:2438
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff88814591c0e8
 which belongs to the cache kernfs_node_cache of size 168
The buggy address is located 152 bytes inside of
 168-byte region [ffff88814591c0e8, ffff88814591c190)

The buggy address belongs to the physical page:
page:ffffea0005164700 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x14591c
flags: 0x57ff00000000200(slab|node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000000200 0000000000000000 dead000000000001 ffff8880119dbb40
raw: 0000000000000000 0000000080110011 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 1, tgid 1 (swapper/0), ts 1564996231, free_ts 0
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5549
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2103
 alloc_pages+0x22f/0x270 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:1829 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1974
 new_slab mm/slub.c:2034 [inline]
 ___slab_alloc+0x84f/0xe80 mm/slub.c:3036
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3123
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3263 [inline]
 kmem_cache_alloc+0x38c/0x3b0 mm/slub.c:3273
 kmem_cache_zalloc include/linux/slab.h:723 [inline]
 __kernfs_new_node+0xd4/0x8b0 fs/kernfs/dir.c:603
 kernfs_new_node+0x93/0x120 fs/kernfs/dir.c:665
 __kernfs_create_file+0x51/0x350 fs/kernfs/file.c:1043
 sysfs_add_file_mode_ns+0x20f/0x3f0 fs/sysfs/file.c:294
 create_files fs/sysfs/group.c:64 [inline]
 internal_create_group+0x322/0xb10 fs/sysfs/group.c:148
 kernel_add_sysfs_param kernel/params.c:814 [inline]
 param_sysfs_builtin kernel/params.c:851 [inline]
 param_sysfs_init+0x342/0x43b kernel/params.c:970
 do_one_initcall+0xfe/0x650 init/main.c:1296
 do_initcall_level init/main.c:1369 [inline]
 do_initcalls init/main.c:1385 [inline]
 do_basic_setup init/main.c:1404 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1623
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88814591c080: fb fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb
 ffff88814591c100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88814591c180: fb fb fc fc fc fc fc fc fc fc fa fb fb fb fb fb
                   ^
 ffff88814591c200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
 ffff88814591c280: fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb
==================================================================

