Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A526D2F15
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 10:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjDAIYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 04:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDAIYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 04:24:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6ABCC17
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 01:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EB6460B66
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 08:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C64D6C433D2;
        Sat,  1 Apr 2023 08:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680337444;
        bh=wGYQ+mAGLNPxieBcsLOZIEXwIRs3WVniw9ALyYS810g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0O6lm6FfuMuNB4MH0lEsGOome0YauSTGxJaz7QYNqBvh03Qr4nFWNIq7NeCo/X6j
         34t897Xs/B7mmNlrwqYLlQEhsWyBalJSjgq0iqH3WQq2t8SW5Y/hcXy6vaQ71ds6T8
         7xHwjmUiF2p5Y2Sfx60+0Wu+QAbYVioaQloOKk60=
Date:   Sat, 1 Apr 2023 10:24:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     syzbot <syzbot+41d665317c811d4d88aa@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in
 class_register
Message-ID: <ZCfqIBBvqBaEiuZi@kroah.com>
References: <00000000000062649c05f841e476@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000062649c05f841e476@google.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 01:12:51AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    198925fae644 Add linux-next specific files for 20230329
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17f9a03ec80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=91e70627549fd509
> dashboard link: https://syzkaller.appspot.com/bug?extid=41d665317c811d4d88aa
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=105d5a2ec80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ab4895c80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/53c685bee82f/disk-198925fa.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/45e82baa3bc5/vmlinux-198925fa.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7c31fbc6acb9/bzImage-198925fa.xz
> 
> The issue was bisected to:
> 
> commit dcfbb67e48a2becfce7990386e985b9c45098ee5
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Fri Mar 24 10:01:31 2023 +0000
> 
>     driver core: class: use lock_class_key already present in struct subsys_private
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=173f4ab9c80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14bf4ab9c80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10bf4ab9c80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+41d665317c811d4d88aa@syzkaller.appspotmail.com
> Fixes: dcfbb67e48a2 ("driver core: class: use lock_class_key already present in struct subsys_private")
> 
> usb 1-1: New USB device strings: Mfr=0, Product=106, SerialNumber=59
> usb 1-1: Product: syz
> usb 1-1: SerialNumber: syz
> hub 1-1:250.228: bad descriptor, ignoring hub
> hub: probe of 1-1:250.228 failed with error -5
> ==================================================================
> BUG: KASAN: slab-use-after-free in lockdep_register_key+0x396/0x410 kernel/locking/lockdep.c:1231
> Read of size 8 at addr ffff888020bbc360 by task kworker/1:2/2492
> 
> CPU: 1 PID: 2492 Comm: kworker/1:2 Not tainted 6.3.0-rc4-next-20230329-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
> Workqueue: usb_hub_wq hub_event
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
>  print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
>  print_report mm/kasan/report.c:462 [inline]
>  kasan_report+0x11c/0x130 mm/kasan/report.c:572
>  lockdep_register_key+0x396/0x410 kernel/locking/lockdep.c:1231
>  class_register+0xed/0x530 drivers/base/class.c:172
>  class_create+0x99/0x100 drivers/base/class.c:249
>  init_usb_class drivers/usb/core/file.c:91 [inline]
>  usb_register_dev+0x4e7/0x860 drivers/usb/core/file.c:179
>  usblp_probe+0xc91/0x16d0 drivers/usb/class/usblp.c:1208
>  usb_probe_interface+0x30f/0x960 drivers/usb/core/driver.c:396
>  call_driver_probe drivers/base/dd.c:579 [inline]
>  really_probe+0x240/0xca0 drivers/base/dd.c:658
>  __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:795
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:825
>  __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:953
>  bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
>  __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1025
>  bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
>  device_add+0x11c4/0x1c50 drivers/base/core.c:3611
>  usb_set_configuration+0x10ee/0x1af0 drivers/usb/core/message.c:2171
>  usb_generic_driver_probe+0xcf/0x130 drivers/usb/core/generic.c:238
>  usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
>  call_driver_probe drivers/base/dd.c:579 [inline]
>  really_probe+0x240/0xca0 drivers/base/dd.c:658
>  __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:795
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:825
>  __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:953
>  bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
>  __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1025
>  bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
>  device_add+0x11c4/0x1c50 drivers/base/core.c:3611
>  usb_new_device+0xcb2/0x19d0 drivers/usb/core/hub.c:2575
>  hub_port_connect drivers/usb/core/hub.c:5407 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
>  port_event drivers/usb/core/hub.c:5711 [inline]
>  hub_event+0x2d9e/0x4e40 drivers/usb/core/hub.c:5793
>  process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
>  process_scheduled_works kernel/workqueue.c:2468 [inline]
>  worker_thread+0x881/0x10c0 kernel/workqueue.c:2554
>  kthread+0x33e/0x440 kernel/kthread.c:379
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>  </TASK>
> 
> Allocated by task 2492:
>  kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>  ____kasan_kmalloc mm/kasan/common.c:333 [inline]
>  __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
>  kmalloc include/linux/slab.h:559 [inline]
>  kzalloc include/linux/slab.h:680 [inline]
>  class_register+0x55/0x530 drivers/base/class.c:165
>  class_create+0x99/0x100 drivers/base/class.c:249
>  init_usb_class drivers/usb/core/file.c:91 [inline]
>  usb_register_dev+0x4e7/0x860 drivers/usb/core/file.c:179
>  usblp_probe+0xc91/0x16d0 drivers/usb/class/usblp.c:1208
>  usb_probe_interface+0x30f/0x960 drivers/usb/core/driver.c:396
>  call_driver_probe drivers/base/dd.c:579 [inline]
>  really_probe+0x240/0xca0 drivers/base/dd.c:658
>  __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:795
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:825
>  __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:953
>  bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
>  __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1025
>  bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
>  device_add+0x11c4/0x1c50 drivers/base/core.c:3611
>  usb_set_configuration+0x10ee/0x1af0 drivers/usb/core/message.c:2171
>  usb_generic_driver_probe+0xcf/0x130 drivers/usb/core/generic.c:238
>  usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
>  call_driver_probe drivers/base/dd.c:579 [inline]
>  really_probe+0x240/0xca0 drivers/base/dd.c:658
>  __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:795
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:825
>  __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:953
>  bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
>  __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1025
>  bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
>  device_add+0x11c4/0x1c50 drivers/base/core.c:3611
>  usb_new_device+0xcb2/0x19d0 drivers/usb/core/hub.c:2575
>  hub_port_connect drivers/usb/core/hub.c:5407 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
>  port_event drivers/usb/core/hub.c:5711 [inline]
>  hub_event+0x2d9e/0x4e40 drivers/usb/core/hub.c:5793
>  process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
>  process_scheduled_works kernel/workqueue.c:2468 [inline]
>  worker_thread+0x881/0x10c0 kernel/workqueue.c:2554
>  kthread+0x33e/0x440 kernel/kthread.c:379
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> 
> Freed by task 2492:
>  kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
>  kasan_set_track+0x25/0x30 mm/kasan/common.c:52
>  kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
>  ____kasan_slab_free mm/kasan/common.c:236 [inline]
>  ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
>  kasan_slab_free include/linux/kasan.h:162 [inline]
>  slab_free_hook mm/slub.c:1781 [inline]
>  slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
>  slab_free mm/slub.c:3787 [inline]
>  __kmem_cache_free+0xaf/0x2d0 mm/slub.c:3800
>  kobject_cleanup lib/kobject.c:683 [inline]
>  kobject_release lib/kobject.c:714 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  kobject_put+0x1c2/0x4d0 lib/kobject.c:731
>  kset_unregister+0x64/0x80 lib/kobject.c:880
>  class_destroy+0x3c/0x50 drivers/base/class.c:273

Ah, I forgot to unregister the lock, let me go fix this up, nice find
bot!


