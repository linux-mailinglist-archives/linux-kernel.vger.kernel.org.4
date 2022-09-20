Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E05A5BE955
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiITOsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiITOrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:47:51 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EB558DCA;
        Tue, 20 Sep 2022 07:47:49 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id j7so3300972vsr.13;
        Tue, 20 Sep 2022 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=LpEjDZg51Wf76Rb2YCsesdZqUabDERVGxIi0E9K9Mmc=;
        b=fVkogPLlvQ+bTM63SV1V4058L/RNp8fDnW4P/cfUMGwvyN3y5LAtwAP+loMdbqSmTn
         tDqm7vdP2m8fomTy5PfWBNh6fNtKLJbLIoYIXWaq3elHgSh6bflYmCeg0/FDrcCW3jxA
         PYtmTNgd0JApzDGU+aUGgFePvTBYspwj4mOSYynHxTvnIhTpdSeXFs4uc0Yo4bfrwVg9
         vq8twPyXEpBLRLtgM34EnaACUPa80mVKjIBmszbn0VBU3aX1roZQqV/+R/g+QeM014+4
         eSZaa9aCV3EoFH1QK7sH+5pOVqzTIduDtWhR1w0RxFY8EclxKbUzG66eGW83D4pexHUl
         aAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=LpEjDZg51Wf76Rb2YCsesdZqUabDERVGxIi0E9K9Mmc=;
        b=QS+HJJT6GxzUIOHewRK/+BaD7v5Ij4FYXN+MT9joCoudQKug8if9neXi79rW291h0u
         CMWOKpOue4d9sJ+dcGZ6GxoKLuLfF7KYVaC6KBulynrvz2+19AibzuUuBQsSlxhlHCra
         Nv66KmyZ5k2OWJKc9m/lWV5XxU0JMf7ZQA1bybQSnBFeVySBJ0smk/vBkMXDgvUn/61g
         rwPeV3oszneRmtdQ5pUvphaD55I8gquToODw8/cRDDy0FznLoXPS7TkDNci4pkp2e9Xv
         LP0eBgbhhdNI8sx3ZBXXVMKnLpZvgrZBGX6EqH9MNz4T3wd1erCxNl7QaeFtxjgS8SjW
         qK+Q==
X-Gm-Message-State: ACrzQf11e0kZno7EfKY5nAUk261ENx0/pxMVhE/la/oSvm9Rif6JgOYM
        jHhDG5wP6z5ILrLN+1odpRrVu5YqxGPykfu7c1ruo+nIcYnSk4E6
X-Google-Smtp-Source: AMsMyM47jcj6SpDyulu0y1Fbr28/SIvLxvDOkteapJHbw3YRXNr9cES37L55SxXeZqey9xXC3zruORAKTnRYDMSa9SM=
X-Received: by 2002:a67:d90e:0:b0:398:b530:c457 with SMTP id
 t14-20020a67d90e000000b00398b530c457mr8572801vsj.81.1663685268794; Tue, 20
 Sep 2022 07:47:48 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Tue, 20 Sep 2022 22:47:37 +0800
Message-ID: <CAB7eexKhQeqgpMaZoT=JD2EMwn=qTw4sWzF7hdU9XDFVsz3ooA@mail.gmail.com>
Subject: KASAN: use-after-free Write in keyspan_close
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        johan@kernel.org, Greg KH <gregkh@linuxfoundation.org>
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

When fuzzing the Linux kernel driver v6.0-rc6, the following crash was
triggered.

HEAD commit: 521a547ced6477c54b4b0cc206000406c221b4d6
git tree: upstream

kernel config: https://pastebin.com/raw/hekxU61F
console output: https://pastebin.com/raw/gvADdA0t

Sorry for failing to extract the reproducer. But on other versions of
Linux, I also triggered this crash.

I would appreciate it if you have any idea how to solve this bug.

The crash report is as follows:
==================================================================
BUG: KASAN: use-after-free in keyspan_close+0x240/0x260
drivers/usb/serial/keyspan.c:1589
Write of size 4 at addr ffff88805a1e7104 by task syz-executor.5/27414

CPU: 1 PID: 27414 Comm: syz-executor.5 Not tainted 6.0.0-rc4+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:317 [inline]
print_report.cold+0xe5/0x66d mm/kasan/report.c:433
kasan_report+0x8a/0x1b0 mm/kasan/report.c:495
keyspan_close+0x240/0x260 drivers/usb/serial/keyspan.c:1589
serial_port_shutdown+0x89/0x110 drivers/usb/serial/usb-serial.c:309
tty_port_shutdown+0x1ec/0x270 drivers/tty/tty_port.c:379
tty_port_hangup+0x103/0x170 drivers/tty/tty_port.c:407
__tty_hangup.part.0+0x65b/0x770 drivers/tty/tty_io.c:660
__tty_hangup drivers/tty/tty_io.c:592 [inline]
tty_vhangup drivers/tty/tty_io.c:707 [inline]
tty_ioctl+0x956/0x1430 drivers/tty/tty_io.c:2718
vfs_ioctl fs/ioctl.c:51 [inline]
__do_sys_ioctl fs/ioctl.c:870 [inline]
__se_sys_ioctl fs/ioctl.c:856 [inline]
__x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7ff1e4ca80fd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff1e5421bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ff1e4d9c4e0 RCX: 00007ff1e4ca80fd
RDX: 0000000000000000 RSI: 0000000000005437 RDI: 0000000000000003
RBP: 00007ff1e4d0b606 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffcf5e0c9f R14: 00007fffcf5e0e40 R15: 00007ff1e5421d80
</TASK>

Allocated by task 9889:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
kasan_set_track mm/kasan/common.c:45 [inline]
set_alloc_info mm/kasan/common.c:437 [inline]
____kasan_kmalloc mm/kasan/common.c:516 [inline]
____kasan_kmalloc mm/kasan/common.c:475 [inline]
__kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
kasan_kmalloc include/linux/kasan.h:234 [inline]
kmem_cache_alloc_trace+0x19b/0x380 mm/slub.c:3284
kmalloc include/linux/slab.h:600 [inline]
kzalloc include/linux/slab.h:733 [inline]
keyspan_port_probe+0xbe/0xe40 drivers/usb/serial/keyspan.c:2886
usb_serial_device_probe+0xfe/0x3d0 drivers/usb/serial/bus.c:47
call_driver_probe drivers/base/dd.c:560 [inline]
really_probe+0x249/0xa90 drivers/base/dd.c:639
__driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
__device_attach_driver+0x1da/0x2d0 drivers/base/dd.c:936
bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
__device_attach+0x283/0x480 drivers/base/dd.c:1008
bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
device_add+0xc96/0x1da0 drivers/base/core.c:3517
usb_serial_probe.cold+0x163f/0x291e drivers/usb/serial/usb-serial.c:1152
usb_probe_interface+0x361/0x800 drivers/usb/core/driver.c:396
call_driver_probe drivers/base/dd.c:560 [inline]
really_probe+0x249/0xa90 drivers/base/dd.c:639
__driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
__device_attach_driver+0x1da/0x2d0 drivers/base/dd.c:936
bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
__device_attach+0x283/0x480 drivers/base/dd.c:1008
bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
device_add+0xc96/0x1da0 drivers/base/core.c:3517
usb_set_configuration+0x1014/0x1900 drivers/usb/core/message.c:2170
usb_generic_driver_probe+0x9d/0xe0 drivers/usb/core/generic.c:238
usb_probe_device+0xd4/0x2a0 drivers/usb/core/driver.c:293
call_driver_probe drivers/base/dd.c:560 [inline]
really_probe+0x249/0xa90 drivers/base/dd.c:639
__driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
__device_attach_driver+0x1da/0x2d0 drivers/base/dd.c:936
bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
__device_attach+0x283/0x480 drivers/base/dd.c:1008
bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
device_add+0xc96/0x1da0 drivers/base/core.c:3517
usb_new_device.cold+0x69d/0x10ef drivers/usb/core/hub.c:2573
hub_port_connect drivers/usb/core/hub.c:5353 [inline]
hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
port_event drivers/usb/core/hub.c:5653 [inline]
hub_event+0x23bd/0x4260 drivers/usb/core/hub.c:5735
process_one_work+0x9c7/0x1650 kernel/workqueue.c:2289
worker_thread+0x623/0x1070 kernel/workqueue.c:2436
kthread+0x2e9/0x3a0 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Freed by task 9889:
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
usb_serial_device_remove+0x13f/0x1a0 drivers/usb/serial/bus.c:97
device_remove+0xc8/0x170 drivers/base/dd.c:548
__device_release_driver drivers/base/dd.c:1249 [inline]
device_release_driver_internal+0x1a7/0x360 drivers/base/dd.c:1275
bus_remove_device+0x2e3/0x590 drivers/base/bus.c:529
device_del+0x5d2/0xe80 drivers/base/core.c:3704
usb_serial_disconnect+0x23e/0x3b0 drivers/usb/serial/usb-serial.c:1205
usb_unbind_interface+0x1bd/0x890 drivers/usb/core/driver.c:458
device_remove drivers/base/dd.c:550 [inline]
device_remove+0x11f/0x170 drivers/base/dd.c:542
__device_release_driver drivers/base/dd.c:1249 [inline]
device_release_driver_internal+0x1a7/0x360 drivers/base/dd.c:1275
bus_remove_device+0x2e3/0x590 drivers/base/bus.c:529
device_del+0x5d2/0xe80 drivers/base/core.c:3704
usb_disable_device+0x214/0x600 drivers/usb/core/message.c:1419
usb_disconnect+0x285/0x860 drivers/usb/core/hub.c:2235
hub_port_connect drivers/usb/core/hub.c:5197 [inline]
hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
port_event drivers/usb/core/hub.c:5653 [inline]
hub_event+0x1c1b/0x4260 drivers/usb/core/hub.c:5735
process_one_work+0x9c7/0x1650 kernel/workqueue.c:2289
worker_thread+0x623/0x1070 kernel/workqueue.c:2436
kthread+0x2e9/0x3a0 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Last potentially related work creation:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
__kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
insert_work+0x4a/0x390 kernel/workqueue.c:1358
__queue_work+0x4d4/0x1200 kernel/workqueue.c:1517
queue_work_on+0xee/0x110 kernel/workqueue.c:1545
queue_work include/linux/workqueue.h:503 [inline]
call_usermodehelper_exec+0x1cc/0x490 kernel/umh.c:435
kobject_uevent_env+0xf14/0x1640 lib/kobject_uevent.c:618
kset_register+0x49/0x60 lib/kobject.c:849
__class_register+0x20b/0x4a0 drivers/base/class.c:188
__class_create+0xca/0x140 drivers/base/class.c:242
ghid_setup+0x71/0x150 drivers/usb/gadget/function/f_hid.c:1322
hidg_alloc_inst+0x179/0x250 drivers/usb/gadget/function/f_hid.c:1217
try_get_usb_function_instance+0x122/0x1e0 drivers/usb/gadget/functions.c:28
usb_get_function_instance+0x13/0xa0 drivers/usb/gadget/functions.c:44
function_make+0x105/0x3e0 drivers/usb/gadget/configfs.c:617
configfs_mkdir+0x46a/0xb90 fs/configfs/dir.c:1327
vfs_mkdir+0x69f/0xa30 fs/namei.c:4013
do_mkdirat+0x249/0x2c0 fs/namei.c:4038
__do_sys_mkdir fs/namei.c:4058 [inline]
__se_sys_mkdir fs/namei.c:4056 [inline]
__x64_sys_mkdir+0x61/0x80 fs/namei.c:4056
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
__kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
insert_work+0x4a/0x390 kernel/workqueue.c:1358
__queue_work+0x4d4/0x1200 kernel/workqueue.c:1517
queue_work_on+0xee/0x110 kernel/workqueue.c:1545
queue_work include/linux/workqueue.h:503 [inline]
call_usermodehelper_exec+0x1cc/0x490 kernel/umh.c:435
kobject_uevent_env+0xf14/0x1640 lib/kobject_uevent.c:618
netdev_queue_add_kobject net/core/net-sysfs.c:1677 [inline]
netdev_queue_update_kobjects+0x3ba/0x4d0 net/core/net-sysfs.c:1718
register_queue_kobjects net/core/net-sysfs.c:1779 [inline]
netdev_register_kobject+0x333/0x400 net/core/net-sysfs.c:2019
register_netdevice+0xbe9/0x1370 net/core/dev.c:10070
__ip_tunnel_create+0x398/0x580 net/ipv4/ip_tunnel.c:267
ip_tunnel_init_net+0x32c/0xa40 net/ipv4/ip_tunnel.c:1073
ops_init+0xaf/0x420 net/core/net_namespace.c:135
setup_net+0x415/0xa40 net/core/net_namespace.c:326
copy_net_ns+0x2d9/0x660 net/core/net_namespace.c:472
create_new_namespaces.isra.0+0x3cb/0xae0 kernel/nsproxy.c:110
unshare_nsproxy_namespaces+0xc8/0x1f0 kernel/nsproxy.c:227
ksys_unshare+0x450/0x920 kernel/fork.c:3183
__do_sys_unshare kernel/fork.c:3254 [inline]
__se_sys_unshare kernel/fork.c:3252 [inline]
__x64_sys_unshare+0x2d/0x40 kernel/fork.c:3252
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88805a1e7100
which belongs to the cache kmalloc-192 of size 192
The buggy address is located 4 bytes inside of
192-byte region [ffff88805a1e7100, ffff88805a1e71c0)

The buggy address belongs to the physical page:
page:ffffea00016879c0 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x5a1e7
flags: 0x4fff00000000200(slab|node=1|zone=1|lastcpupid=0x7ff)
raw: 04fff00000000200 0000000000000000 dead000000000001 ffff888011c41a00
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 6450, tgid 6450
(syz-executor.1), ts 146447587150, free_ts 146293511182
set_page_owner include/linux/page_owner.h:31 [inline]
post_alloc_hook mm/page_alloc.c:2525 [inline]
prep_new_page+0x2c6/0x350 mm/page_alloc.c:2532
get_page_from_freelist+0xae9/0x3a80 mm/page_alloc.c:4283
__alloc_pages+0x321/0x710 mm/page_alloc.c:5515
alloc_pages+0x117/0x2f0 mm/mempolicy.c:2270
alloc_slab_page mm/slub.c:1824 [inline]
allocate_slab mm/slub.c:1969 [inline]
new_slab+0x246/0x3a0 mm/slub.c:2029
___slab_alloc+0xa50/0x1060 mm/slub.c:3031
__slab_alloc.isra.0+0x4d/0xa0 mm/slub.c:3118
slab_alloc_node mm/slub.c:3209 [inline]
slab_alloc mm/slub.c:3251 [inline]
kmem_cache_alloc_trace+0x35b/0x380 mm/slub.c:3282
kmalloc include/linux/slab.h:600 [inline]
kzalloc include/linux/slab.h:733 [inline]
call_usermodehelper_setup+0x97/0x340 kernel/umh.c:365
kobject_uevent_env+0xef5/0x1640 lib/kobject_uevent.c:614
netdev_queue_add_kobject net/core/net-sysfs.c:1677 [inline]
netdev_queue_update_kobjects+0x3ba/0x4d0 net/core/net-sysfs.c:1718
register_queue_kobjects net/core/net-sysfs.c:1779 [inline]
netdev_register_kobject+0x333/0x400 net/core/net-sysfs.c:2019
register_netdevice+0xbe9/0x1370 net/core/dev.c:10070
veth_newlink+0x4d6/0x9a0 drivers/net/veth.c:1795
rtnl_newlink_create net/core/rtnetlink.c:3363 [inline]
__rtnl_newlink+0xfbc/0x16f0 net/core/rtnetlink.c:3580
rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3593
page last free stack trace:
reset_page_owner include/linux/page_owner.h:24 [inline]
free_pages_prepare mm/page_alloc.c:1449 [inline]
free_pcp_prepare+0x5ab/0xd00 mm/page_alloc.c:1499
free_unref_page_prepare mm/page_alloc.c:3380 [inline]
free_unref_page+0x19/0x410 mm/page_alloc.c:3476
__vunmap+0x6ff/0xaa0 mm/vmalloc.c:2696
free_work+0x58/0x70 mm/vmalloc.c:97
process_one_work+0x9c7/0x1650 kernel/workqueue.c:2289
worker_thread+0x623/0x1070 kernel/workqueue.c:2436
kthread+0x2e9/0x3a0 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
ffff88805a1e7000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
ffff88805a1e7080: 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff88805a1e7100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff88805a1e7180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
ffff88805a1e7200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================
