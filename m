Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94425BBDE5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 15:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiIRNB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 09:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiIRNBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 09:01:25 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C711C106
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 06:01:23 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id m65so27346709vsc.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=cFGEqgmd85UhOqcHiC5mKuE2N5k3xnMp3j3A0pc3MnU=;
        b=FH5mjsxjFXWrdz8aSF+6rAAveJ3QPG4thXx2tjE7bVlbGyFt1bb/tRD4XfJVJsZJ7+
         ymR3knUpSiOOAxbCVZD4N8wkvG+2rDBWmWoxfbWmclxBDAXpB4WQ9FtvE+w0niUjG2qM
         TyAsCTIvhwiCkQkmXjy4lPB9z3XoTQ16cD5RU5v1NjHXcg8mfkg7LmcL6YrHoJwT8XqP
         M7Wy7D8kZ7kuvmhHY35rLzva6PahqTTLrWfkdP5oMPcPW5UmH+tg+2hPvvoKsUakAKal
         PMoIHLUt3CvQ9hJuRAmd5NDazHBWapYeDaV8UmEfijU+F3xiEDIrhXqMmiaTAXJ7/dal
         UZ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=cFGEqgmd85UhOqcHiC5mKuE2N5k3xnMp3j3A0pc3MnU=;
        b=7ghaCfrSVnz4Ol2EKPQaCaJkP6nVQ4j5ZYLVx0puZbaEI97jc8gR5iRR040dHy2/AY
         oA6zlw2pTakN2XiufdYDmZUiIaVJAl9uYFnDMObdzoNbLgF/7zH/ATTnLz+6sU3d0qlm
         G7x6pB2CzvLEF5LRq5mpiz9kYiY2B1D6GBWrdxd2jotqohdFPar9RNKHe+Ga7VAeiB6/
         AEUkoOz5cfyMfG9AnFuQVTPIw/SUPxT/ibgn7M1VyHs9SEvUgd4D0dF5rYXbrvTvmubk
         kQeGLLTJKpliYNwduowbDc0lKggJ4oHCvw8Je3nw0SiJalk+7PWKBe+NcC6ZVjuJQBpL
         W4oA==
X-Gm-Message-State: ACrzQf1eDCvKg0tfxApZYpitxospNdnwj6kkpjFRgHwJ4kfcLt3k1RmA
        8/xqjgqLK8H3ZQh8vMQw0EHw/+8YvKgv3iVtBWyNxn0aCzI=
X-Google-Smtp-Source: AMsMyM6icEQ0BpAXK4KopjDBLuvUaPoRi5J8AFeD4W0ymEnp2MFOqUOJ11XutxVr2YLfJP5A0NmYkgrE3fDPu3XrnPI=
X-Received: by 2002:a67:be16:0:b0:398:c2e4:e01f with SMTP id
 x22-20020a67be16000000b00398c2e4e01fmr4559365vsq.33.1663506082574; Sun, 18
 Sep 2022 06:01:22 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Sun, 18 Sep 2022 21:01:11 +0800
Message-ID: <CAB7eexL1zBnB636hwS27d-LdPYZ_R1-5fJS_h=ZbCWYU=UPWJg@mail.gmail.com>
Subject: KASAN: invalid-free in snd_card_new
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

When fuzzing the Linux kernel driver v6.0-rc4, the following crash was
triggered.

HEAD commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
git tree: upstream

kernel config: https://pastebin.com/raw/xtrgsXP3
C reproducer: https://pastebin.com/raw/w2sdQWYj
console output: https://pastebin.com/raw/Yyf7zw2d

Basically, in the c reproducer, we use the gadget module to emulate
attaching a USB device(vendor id: 0x1bc7, product id: 0x1206, with the
midi function) and executing some simple sequence of system calls.
To reproduce this crash, we utilize a third-party library to emulate
the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
Just clone this repository, install it, and compile the c
reproducer with ``` gcc crash.c -lusbgx -lconfig -o crash ``` will do
the trick.

I would appreciate it if you have any idea how to solve this bug.

The crash report is as follows:

==================================================================
BUG: KASAN: double-free in snd_card_new+0xf9/0x130 sound/core/init.c:182

CPU: 1 PID: 7476 Comm: syz-executor.2 Not tainted 6.0.0-rc4+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0xe5/0x66d mm/kasan/report.c:433
 kasan_report_invalid_free+0x5b/0x160 mm/kasan/report.c:462
 ____kasan_slab_free mm/kasan/common.c:356 [inline]
 __kasan_slab_free+0x179/0x1b0 mm/kasan/common.c:375
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook mm/slub.c:1780 [inline]
 slab_free mm/slub.c:3534 [inline]
 kfree+0xe9/0x650 mm/slub.c:4562
 snd_card_new+0xf9/0x130 sound/core/init.c:182
 snd_usb_audio_create sound/usb/card.c:621 [inline]
 usb_audio_probe+0x162a/0x2f10 sound/usb/card.c:797
 usb_probe_interface+0x361/0x800 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xa90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1da/0x2d0 drivers/base/dd.c:936
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x283/0x480 drivers/base/dd.c:1008
 proc_ioctl drivers/usb/core/devio.c:2356 [inline]
 proc_ioctl+0x5b4/0x6e0 drivers/usb/core/devio.c:2307
 proc_ioctl_default drivers/usb/core/devio.c:2391 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2747 [inline]
 usbdev_ioctl+0x29a3/0x3340 drivers/usb/core/devio.c:2807
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0dda8a80fd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0ddaf63bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f0dda99c340 RCX: 00007f0dda8a80fd
RDX: 0000000020000900 RSI: 00000000c0105512 RDI: 0000000000000003
RBP: 00007f0ddaf63c50 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000000d
R13: 00007ffeb548e29f R14: 00007ffeb548e440 R15: 00007f0ddaf63d80
 </TASK>

Allocated by task 7476:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc mm/kasan/common.c:516 [inline]
 ____kasan_kmalloc mm/kasan/common.c:475 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 __kmalloc+0x1da/0x3f0 mm/slub.c:4424
 kmalloc include/linux/slab.h:605 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 snd_card_new+0x78/0x130 sound/core/init.c:176
 snd_usb_audio_create sound/usb/card.c:621 [inline]
 usb_audio_probe+0x162a/0x2f10 sound/usb/card.c:797
 usb_probe_interface+0x361/0x800 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xa90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1da/0x2d0 drivers/base/dd.c:936
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x283/0x480 drivers/base/dd.c:1008
 proc_ioctl drivers/usb/core/devio.c:2356 [inline]
 proc_ioctl+0x5b4/0x6e0 drivers/usb/core/devio.c:2307
 proc_ioctl_default drivers/usb/core/devio.c:2391 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2747 [inline]
 usbdev_ioctl+0x29a3/0x3340 drivers/usb/core/devio.c:2807
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 7476:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:367 [inline]
 ____kasan_slab_free mm/kasan/common.c:329 [inline]
 __kasan_slab_free+0x11d/0x1b0 mm/kasan/common.c:375
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook mm/slub.c:1780 [inline]
 slab_free mm/slub.c:3534 [inline]
 kfree+0xe9/0x650 mm/slub.c:4562
 snd_card_do_free sound/core/init.c:605 [inline]
 release_card_device+0x1af/0x200 sound/core/init.c:145
 device_release+0x9f/0x240 drivers/base/core.c:2330
 kobject_cleanup lib/kobject.c:673 [inline]
 kobject_release lib/kobject.c:704 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1be/0x4c0 lib/kobject.c:721
 put_device+0x1b/0x30 drivers/base/core.c:3624
 snd_card_init+0x973/0xbd0 sound/core/init.c:367
 snd_card_new+0xa1/0x130 sound/core/init.c:180
 snd_usb_audio_create sound/usb/card.c:621 [inline]
 usb_audio_probe+0x162a/0x2f10 sound/usb/card.c:797
 usb_probe_interface+0x361/0x800 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xa90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1da/0x2d0 drivers/base/dd.c:936
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x283/0x480 drivers/base/dd.c:1008
 proc_ioctl drivers/usb/core/devio.c:2356 [inline]
 proc_ioctl+0x5b4/0x6e0 drivers/usb/core/devio.c:2307
 proc_ioctl_default drivers/usb/core/devio.c:2391 [inline]
 usbdev_do_ioctl drivers/usb/core/devio.c:2747 [inline]
 usbdev_ioctl+0x29a3/0x3340 drivers/usb/core/devio.c:2807
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888041f54000
 which belongs to the cache kmalloc-8k of size 8192
The buggy address is located 0 bytes inside of
 8192-byte region [ffff888041f54000, ffff888041f56000)

The buggy address belongs to the physical page:
page:ffffea000107d400 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x41f50
head:ffffea000107d400 order:3 compound_mapcount:0 compound_pincount:0
flags: 0x4fff00000010200(slab|head|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000010200 ffffea0001092200 dead000000000004 ffff888011c42280
raw: 0000000000000000 0000000080020002 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask
0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
pid 1, tgid 1 (swapper/0), ts 14941420612, free_ts 14728973666
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook mm/page_alloc.c:2525 [inline]
 prep_new_page+0x2c6/0x350 mm/page_alloc.c:2532
 get_page_from_freelist+0xae9/0x3a80 mm/page_alloc.c:4283
 __alloc_pages+0x321/0x710 mm/page_alloc.c:5515
 alloc_page_interleave+0x1e/0x250 mm/mempolicy.c:2103
 alloc_pages+0x25f/0x2f0 mm/mempolicy.c:2265
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab mm/slub.c:1969 [inline]
 new_slab+0x246/0x3a0 mm/slub.c:2029
 ___slab_alloc+0xa50/0x1060 mm/slub.c:3031
 __slab_alloc.isra.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmalloc+0x388/0x3f0 mm/slub.c:4420
 kmalloc_array include/linux/slab.h:640 [inline]
 fb_show_logo_line drivers/video/fbdev/core/fbmem.c:491 [inline]
 fb_show_logo+0x1398/0x23c0 drivers/video/fbdev/core/fbmem.c:695
 fbcon_switch+0xef7/0x12a0 drivers/video/fbdev/core/fbcon.c:2183
 redraw_screen+0x2b9/0x740 drivers/tty/vt/vt.c:1021
 con2fb_init_display drivers/video/fbdev/core/fbcon.c:806 [inline]
 set_con2fb_map+0x798/0xec0 drivers/video/fbdev/core/fbcon.c:865
 do_fb_registered drivers/video/fbdev/core/fbcon.c:3012 [inline]
 fbcon_fb_registered+0x208/0x460 drivers/video/fbdev/core/fbcon.c:3028
 do_register_framebuffer drivers/video/fbdev/core/fbmem.c:1696 [inline]
 register_framebuffer+0x545/0x910 drivers/video/fbdev/core/fbmem.c:1865
 __drm_fb_helper_initial_config_and_unlock+0xdc6/0x1350
drivers/gpu/drm/drm_fb_helper.c:1910
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5ab/0xd00 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x410 mm/page_alloc.c:3476
 __unfreeze_partials+0x3f3/0x410 mm/slub.c:2548
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x13d/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0xa2/0xc0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook+0x4d/0x4f0 mm/slab.h:727
 slab_alloc_node mm/slub.c:3243 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3258 [inline]
 kmem_cache_alloc+0x151/0x360 mm/slub.c:3268
 ptlock_alloc mm/memory.c:5774 [inline]
 ptlock_init include/linux/mm.h:2261 [inline]
 pmd_ptlock_init include/linux/mm.h:2347 [inline]
 pgtable_pmd_page_ctor include/linux/mm.h:2383 [inline]
 pmd_alloc_one include/asm-generic/pgalloc.h:129 [inline]
 __pmd_alloc+0xbf/0x5b0 mm/memory.c:5225
 pmd_alloc include/linux/mm.h:2211 [inline]
 __handle_mm_fault+0x856/0x2e00 mm/memory.c:5013
 handle_mm_fault+0x322/0xa80 mm/memory.c:5151
 faultin_page mm/gup.c:990 [inline]
 __get_user_pages+0x5be/0x1250 mm/gup.c:1219
 __get_user_pages_locked mm/gup.c:1423 [inline]
 __get_user_pages_remote mm/gup.c:2133 [inline]
 __get_user_pages_remote+0x196/0x810 mm/gup.c:2109
 get_user_pages_remote+0x80/0xc0 mm/gup.c:2206
 get_arg_page+0xe4/0x2a0 fs/exec.c:222
 copy_string_kernel+0x16d/0x4f0 fs/exec.c:639

Memory state around the buggy address:
 ffff888041f53f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888041f53f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888041f54000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff888041f54080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888041f54100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
