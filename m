Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160CD644826
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbiLFPiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbiLFPiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:38:07 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 473E1DFB9
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:38:05 -0800 (PST)
Received: (qmail 656488 invoked by uid 1000); 6 Dec 2022 10:38:04 -0500
Date:   Tue, 6 Dec 2022 10:38:04 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oliver Neukum <oneukum@suse.com>,
        syzbot <syzbot+712fd0e60dda3ba34642@syzkaller.appspotmail.com>
Cc:     WeitaoWang-oc@zhaoxin.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, khalid.masum.92@gmail.com,
        kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in __usb_hcd_giveback_urb (2)
Message-ID: <Y49h3MX8iXEO/na+@rowland.harvard.edu>
References: <0000000000002fc8dc05ef267a9f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002fc8dc05ef267a9f@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver:

This looks like a bug in the anchor API.

On Tue, Dec 06, 2022 at 02:43:41AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ef4d3ea40565 afs: Fix server->active leak in afs_put_server
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=100b244d880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8e7e79f8a1e34200
> dashboard link: https://syzkaller.appspot.com/bug?extid=712fd0e60dda3ba34642
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ef790e7777cd/disk-ef4d3ea4.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2ed3c6bc9230/vmlinux-ef4d3ea4.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/f1dbd004fa88/bzImage-ef4d3ea4.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+712fd0e60dda3ba34642@syzkaller.appspotmail.com
> 
> xpad 3-1:179.65: xpad_irq_in - usb_submit_urb failed with result -19
> xpad 3-1:179.65: xpad_irq_out - usb_submit_urb failed with result -19
> ==================================================================
> BUG: KASAN: use-after-free in register_lock_class+0x8d2/0x9b0 kernel/locking/lockdep.c:1338
> Read of size 1 at addr ffff88807a58b091 by task kworker/u4:3/46
> 
> CPU: 0 PID: 46 Comm: kworker/u4:3 Not tainted 6.1.0-rc7-syzkaller-00103-gef4d3ea40565 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> Workqueue: bat_events batadv_nc_worker
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
>  print_address_description+0x74/0x340 mm/kasan/report.c:284
>  print_report+0x107/0x220 mm/kasan/report.c:395
>  kasan_report+0x139/0x170 mm/kasan/report.c:495
>  register_lock_class+0x8d2/0x9b0 kernel/locking/lockdep.c:1338
>  __lock_acquire+0xe4/0x1f60 kernel/locking/lockdep.c:4934
>  lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5668
>  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>  _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
>  __wake_up_common_lock kernel/sched/wait.c:136 [inline]
>  __wake_up+0xf8/0x1c0 kernel/sched/wait.c:156
>  __usb_hcd_giveback_urb+0x3a0/0x530 drivers/usb/core/hcd.c:1674

This is the call to usb_anchor_resume_wakeups().  The call is made after 
the completion handler callback.  Evidently the xpad driver deallocated 
the anchor during that time window.  This can happen if the driver is 
just waiting for its last URB to complete before freeing all its memory.

I don't know what the best solution is.  It may be necessary to refcount 
anchors somehow.

Alan Stern

> Allocated by task 3741:
>  kasan_save_stack mm/kasan/common.c:45 [inline]
>  kasan_set_track+0x4c/0x70 mm/kasan/common.c:52
>  ____kasan_kmalloc mm/kasan/common.c:371 [inline]
>  __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
>  kmalloc include/linux/slab.h:553 [inline]
>  kzalloc include/linux/slab.h:689 [inline]
>  xpad_probe+0x3de/0x1b70 drivers/input/joystick/xpad.c:1954
>  usb_probe_interface+0x66e/0xb60 drivers/usb/core/driver.c:396
>  call_driver_probe+0x96/0x250
>  really_probe+0x24c/0x9f0 drivers/base/dd.c:639
>  __driver_probe_device+0x1f4/0x3f0 drivers/base/dd.c:778
>  driver_probe_device+0x50/0x240 drivers/base/dd.c:808
>  __device_attach_driver+0x272/0x3c0 drivers/base/dd.c:936
>  bus_for_each_drv+0x18a/0x210 drivers/base/bus.c:427
>  __device_attach+0x372/0x5a0 drivers/base/dd.c:1008
>  bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:487
>  device_add+0xb20/0xf90 drivers/base/core.c:3517
>  usb_set_configuration+0x1a5f/0x20e0 drivers/usb/core/message.c:2170
>  usb_generic_driver_probe+0x83/0x140 drivers/usb/core/generic.c:238
>  usb_probe_device+0x131/0x260 drivers/usb/core/driver.c:293
>  call_driver_probe+0x96/0x250
>  really_probe+0x24c/0x9f0 drivers/base/dd.c:639
>  __driver_probe_device+0x1f4/0x3f0 drivers/base/dd.c:778
>  driver_probe_device+0x50/0x240 drivers/base/dd.c:808
>  __device_attach_driver+0x272/0x3c0 drivers/base/dd.c:936
>  bus_for_each_drv+0x18a/0x210 drivers/base/bus.c:427
>  __device_attach+0x372/0x5a0 drivers/base/dd.c:1008
>  bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:487
>  device_add+0xb20/0xf90 drivers/base/core.c:3517
>  usb_new_device+0xbc2/0x18b0 drivers/usb/core/hub.c:2573
>  hub_port_connect+0x103b/0x2910 drivers/usb/core/hub.c:5353
>  hub_port_connect_change+0x619/0xbe0 drivers/usb/core/hub.c:5497
>  port_event+0xec6/0x13b0 drivers/usb/core/hub.c:5653
>  hub_event+0x5c1/0xd80 drivers/usb/core/hub.c:5735
>  process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
>  worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
>  kthread+0x266/0x300 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
> 
> Freed by task 3709:
>  kasan_save_stack mm/kasan/common.c:45 [inline]
>  kasan_set_track+0x4c/0x70 mm/kasan/common.c:52
>  kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:511
>  ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
>  kasan_slab_free include/linux/kasan.h:177 [inline]
>  slab_free_hook mm/slub.c:1724 [inline]
>  slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1750
>  slab_free mm/slub.c:3661 [inline]
>  __kmem_cache_free+0x71/0x110 mm/slub.c:3674
>  xpad_disconnect+0x332/0x450 drivers/input/joystick/xpad.c:2135
>  usb_unbind_interface+0x1f2/0x860 drivers/usb/core/driver.c:458
>  device_remove drivers/base/dd.c:550 [inline]
>  __device_release_driver drivers/base/dd.c:1249 [inline]
>  device_release_driver_internal+0x5bc/0x8a0 drivers/base/dd.c:1275
>  bus_remove_device+0x2fd/0x410 drivers/base/bus.c:529
>  device_del+0x6ec/0xbe0 drivers/base/core.c:3704
>  usb_disable_device+0x3dd/0x820 drivers/usb/core/message.c:1419
>  usb_disconnect+0x346/0x890 drivers/usb/core/hub.c:2235
>  hub_port_connect+0x296/0x2910 drivers/usb/core/hub.c:5197
>  hub_port_connect_change+0x619/0xbe0 drivers/usb/core/hub.c:5497
>  port_event+0xec6/0x13b0 drivers/usb/core/hub.c:5653
>  hub_event+0x5c1/0xd80 drivers/usb/core/hub.c:5735
>  process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
>  worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
>  kthread+0x266/0x300 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
