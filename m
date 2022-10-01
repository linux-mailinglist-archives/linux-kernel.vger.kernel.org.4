Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7591F5F1BE7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 12:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJAKzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 06:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJAKzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 06:55:41 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A5BDFEC;
        Sat,  1 Oct 2022 03:55:39 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f140so1070508pfa.1;
        Sat, 01 Oct 2022 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=QctanZFFhrxEoulmcY01RqvkbytIKxTXmKkiSOkB4Hk=;
        b=LMXnpCdbGrfT4RecsvcCwOvMQjUo8eZszx3xB5bzCdg0RgoK/iXwbhD2cRbcWE6/ee
         RkJiYnCDN991MLVQd2zGxuJvN06rMI48G2PqQD26T52haK45VOYg80qQZKMDVtXAU7kJ
         Mv/Evm2MFxcqa2mBOu42eJiM6u0EVrmoaoClrCNxSLBti8n7tDvc2SaBdN13iOgYfnJT
         zBRlpBwfxxWQkCheCzF6yTeMM3vGPChsmb86DxHM/Oo+VDumFH3B3X3MWaUogf7KkVAT
         Zgk+oKrlNg60gtEfDD4zlMr9OAHIgC1ffG530Tc3Yr8q2B2ffG3X40GjtGvraniT65Fb
         Fo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=QctanZFFhrxEoulmcY01RqvkbytIKxTXmKkiSOkB4Hk=;
        b=w6TYSAb8/67uGr47fViTzBAQA0RSPb70m57KIKazMCdcGvLol10EA+WUg7VIx8nTtu
         2uj6BeDH2V62jyJh9NTQlh5hPXmFCjYjv9nHAS8MwCYuJIKT9OpLU00WZqHzwTXgporT
         LWZIFLRb29UryoYWV+qXckQDt/XZDhEIGk3jeob2zzwsT0XXD5PXUytTo0Sh0QY+y8Ae
         RDCP0u0OCLCbXsKvBPt76LR7PNxwonKmIQ/z4A04i3u9IFIrCVXyS/zTHe5FeEkTlkwz
         d9n3b3baHJvthyTDDf/UN0O8ThkzRecsqzSJKkvjx9SMeBEVJ2DSvlhPKTJCS5bVrs8d
         GoFA==
X-Gm-Message-State: ACrzQf1j6p/Hs/2hQhnNJQud6HUPJvLcVu+8Tzi49Hv4YdonQd0nC8gE
        YTZ+VWEd7fFQHTpwHOvNU4t4OBXbtPhQ2+h+0F0=
X-Google-Smtp-Source: AMsMyM6j+/AnJpmHkFwJQUwtuv/0EA2IZRMlS9dYdmM8rLwbKdW2JIepRHupid5X82O8GnFLxqLqHq8hNP/2iqP297g=
X-Received: by 2002:a63:69ca:0:b0:43c:1ef6:ae9d with SMTP id
 e193-20020a6369ca000000b0043c1ef6ae9dmr11178740pgc.79.1664621738865; Sat, 01
 Oct 2022 03:55:38 -0700 (PDT)
MIME-Version: 1.0
From:   "Sabri N. Ferreiro" <snferreiro1@gmail.com>
Date:   Sat, 1 Oct 2022 18:55:27 +0800
Message-ID: <CAKG+3NSJde7Y23Y=6Uxw8o4-6BHE85bcpfBtPkhTpFA-V3xxJA@mail.gmail.com>
Subject: KASAN: use-after-free Read in roccat_disconnect
To:     erazor_de@users.sourceforge.net, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
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

hello,

When I used fuzz testing to test Linux kernel 6.0.0-rc6, the kernel
triggered the following error:
HEAD commit: 521a547ced6477c54b4b0cc206000406c221b4d6
git tree: upstream

kernel config: https://pastebin.com/raw/hekxU61F
console log: https://pastebin.com/raw/sxEn3CNp

usb 5-1: USB disconnect, device number 3
==================================================================
BUG: KASAN: use-after-free in roccat_disconnect+0x1e2/0x260
drivers/hid/hid-roccat.c:367
Read of size 4 at addr ffff8880212fa808 by task kworker/1:5/8721

CPU: 1 PID: 8721 Comm: kworker/1:5 Not tainted 5.18.0 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: usb_hub_wq hub_event
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:313 [inline]
print_report.cold+0xe5/0x659 mm/kasan/report.c:429
kasan_report+0x8a/0x1b0 mm/kasan/report.c:491
roccat_disconnect+0x1e2/0x260 drivers/hid/hid-roccat.c:367
ryos_remove_specials drivers/hid/hid-roccat-ryos.c:135 [inline]
ryos_remove+0x14f/0x190 drivers/hid/hid-roccat-ryos.c:175
hid_device_remove+0xbf/0x200 drivers/hid/hid-core.c:2623
device_remove+0xc8/0x170 drivers/base/dd.c:530
__device_release_driver drivers/base/dd.c:1200 [inline]
device_release_driver_internal+0x1a7/0x2f0 drivers/base/dd.c:1223
bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
device_del+0x5d2/0xe80 drivers/base/core.c:3592
hid_remove_device drivers/hid/hid-core.c:2792 [inline]
hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2811
usbhid_disconnect+0x9f/0xe0 drivers/hid/usbhid/hid-core.c:1451
usb_unbind_interface+0x1bd/0x890 drivers/usb/core/driver.c:458
device_remove drivers/base/dd.c:532 [inline]
device_remove+0x11f/0x170 drivers/base/dd.c:524
__device_release_driver drivers/base/dd.c:1200 [inline]
device_release_driver_internal+0x1a7/0x2f0 drivers/base/dd.c:1223
bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:529
device_del+0x5d2/0xe80 drivers/base/core.c:3592
usb_disable_device+0x219/0x610 drivers/usb/core/message.c:1419
usb_disconnect+0x28a/0x860 drivers/usb/core/hub.c:2228
hub_port_connect drivers/usb/core/hub.c:5207 [inline]
hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
port_event drivers/usb/core/hub.c:5665 [inline]
hub_event+0x1bb1/0x4170 drivers/usb/core/hub.c:5747
process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
worker_thread+0x623/0x1070 kernel/workqueue.c:2436
kthread+0x2e9/0x3a0 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
</TASK>

Allocated by task 169:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
kasan_set_track mm/kasan/common.c:45 [inline]
set_alloc_info mm/kasan/common.c:436 [inline]
____kasan_kmalloc mm/kasan/common.c:515 [inline]
____kasan_kmalloc mm/kasan/common.c:474 [inline]
__kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:524
kasan_kmalloc include/linux/kasan.h:234 [inline]
kmem_cache_alloc_trace+0x1f4/0x460 mm/slub.c:3258
kmalloc include/linux/slab.h:581 [inline]
kzalloc include/linux/slab.h:714 [inline]
roccat_connect+0x53/0x500 drivers/hid/hid-roccat.c:300
ryos_init_specials drivers/hid/hid-roccat-ryos.c:109 [inline]
ryos_probe+0x230/0x320 drivers/hid/hid-roccat-ryos.c:159
hid_device_probe+0x2bd/0x3f0 drivers/hid/hid-core.c:2594
call_driver_probe drivers/base/dd.c:542 [inline]
really_probe drivers/base/dd.c:621 [inline]
really_probe+0x23e/0xa00 drivers/base/dd.c:566
__driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
__device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
__device_attach+0x26d/0x3f0 drivers/base/dd.c:970
bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
device_add+0xc45/0x1d40 drivers/base/core.c:3405
hid_add_device drivers/hid/hid-core.c:2744 [inline]
hid_add_device+0x344/0x9d0 drivers/hid/hid-core.c:2693
usbhid_probe+0xb49/0x1040 drivers/hid/usbhid/hid-core.c:1424
usb_probe_interface+0x310/0x800 drivers/usb/core/driver.c:396
call_driver_probe drivers/base/dd.c:542 [inline]
really_probe drivers/base/dd.c:621 [inline]
really_probe+0x23e/0xa00 drivers/base/dd.c:566
__driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
__device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
__device_attach+0x26d/0x3f0 drivers/base/dd.c:970
bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
device_add+0xc45/0x1d40 drivers/base/core.c:3405
usb_set_configuration+0x1019/0x1900 drivers/usb/core/message.c:2170
usb_generic_driver_probe+0x9d/0xe0 drivers/usb/core/generic.c:238
usb_probe_device+0xd9/0x2a0 drivers/usb/core/driver.c:293
call_driver_probe drivers/base/dd.c:542 [inline]
really_probe drivers/base/dd.c:621 [inline]
really_probe+0x23e/0xa00 drivers/base/dd.c:566
__driver_probe_device+0x338/0x4d0 drivers/base/dd.c:752
driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:782
__device_attach_driver+0x20b/0x2f0 drivers/base/dd.c:899
bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
__device_attach+0x26d/0x3f0 drivers/base/dd.c:970
bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
device_add+0xc45/0x1d40 drivers/base/core.c:3405
usb_new_device.cold+0x4b8/0x10ca drivers/usb/core/hub.c:2566
hub_port_connect drivers/usb/core/hub.c:5363 [inline]
hub_port_connect_change drivers/usb/core/hub.c:5507 [inline]
port_event drivers/usb/core/hub.c:5665 [inline]
hub_event+0x231e/0x4170 drivers/usb/core/hub.c:5747
process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
worker_thread+0x623/0x1070 kernel/workqueue.c:2436
kthread+0x2e9/0x3a0 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298

Freed by task 12949:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
kasan_set_track+0x21/0x30 mm/kasan/common.c:45
kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
____kasan_slab_free mm/kasan/common.c:366 [inline]
____kasan_slab_free mm/kasan/common.c:328 [inline]
__kasan_slab_free+0x11d/0x190 mm/kasan/common.c:374
kasan_slab_free include/linux/kasan.h:200 [inline]
slab_free_hook mm/slub.c:1728 [inline]
slab_free_freelist_hook mm/slub.c:1754 [inline]
slab_free mm/slub.c:3510 [inline]
kfree+0xec/0x4b0 mm/slub.c:4552
roccat_release+0x365/0x450 drivers/hid/hid-roccat.c:229
__fput+0x277/0x9d0 fs/file_table.c:317
task_work_run+0xe0/0x1a0 kernel/task_work.c:164
exit_task_work include/linux/task_work.h:37 [inline]
do_exit+0xb16/0x2dc0 kernel/exit.c:795
do_group_exit+0xd2/0x2f0 kernel/exit.c:925
get_signal+0x2847/0x2880 kernel/signal.c:2864
arch_do_signal_or_restart+0x88/0x1b10 arch/x86/kernel/signal.c:867
exit_to_user_mode_loop kernel/entry/common.c:166 [inline]
exit_to_user_mode_prepare+0x174/0x260 kernel/entry/common.c:201
__syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:294
do_syscall_64+0x42/0x80 arch/x86/entry/common.c:86
entry_SYSCALL_64_after_hwframe+0x44/0xae

Last potentially related work creation:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
__kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
kvfree_call_rcu+0x74/0xab0 kernel/rcu/tree.c:3595
neigh_destroy+0x44d/0x5d0 net/core/neighbour.c:888
neigh_release include/net/neighbour.h:452 [inline]
neigh_cleanup_and_release+0x1fd/0x340 net/core/neighbour.c:103
neigh_periodic_work+0x60c/0x9c0 net/core/neighbour.c:970
process_one_work+0x9cc/0x1650 kernel/workqueue.c:2289
worker_thread+0x623/0x1070 kernel/workqueue.c:2436
kthread+0x2e9/0x3a0 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298

The buggy address belongs to the object at ffff8880212fa800
which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 8 bytes inside of
1024-byte region [ffff8880212fa800, ffff8880212fac00)

The buggy address belongs to the physical page:
page:ffffea000084be00 refcount:1 mapcount:0 mapping:0000000000000000
index:0xffff8880212fd800 pfn:0x212f8
head:ffffea000084be00 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea000157c208 ffffea0000a31808 ffff888011842dc0
raw: ffff8880212fd800 000000000010000a 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask
0xd2a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC),
pid 6476, tgid 6476 (sshd), ts 228227651432, free_ts 228226202812
set_page_owner include/linux/page_owner.h:31 [inline]
post_alloc_hook mm/page_alloc.c:2434 [inline]
prep_new_page+0x297/0x330 mm/page_alloc.c:2441
get_page_from_freelist+0x210e/0x3ab0 mm/page_alloc.c:4182
__alloc_pages+0x30c/0x6e0 mm/page_alloc.c:5408
alloc_pages+0x119/0x250 mm/mempolicy.c:2272
alloc_slab_page mm/slub.c:1799 [inline]
allocate_slab mm/slub.c:1944 [inline]
new_slab+0x2a9/0x3f0 mm/slub.c:2004
___slab_alloc+0xc62/0x1080 mm/slub.c:3005
__slab_alloc.isra.0+0x4d/0xa0 mm/slub.c:3092
slab_alloc_node mm/slub.c:3183 [inline]
__kmalloc_node_track_caller+0x321/0x440 mm/slub.c:4947
kmalloc_reserve+0x32/0xd0 net/core/skbuff.c:354
__alloc_skb+0x11f/0x370 net/core/skbuff.c:426
alloc_skb include/linux/skbuff.h:1300 [inline]
__tcp_send_ack.part.0+0x67/0x770 net/ipv4/tcp_output.c:3945
__tcp_send_ack net/ipv4/tcp_output.c:3977 [inline]
tcp_send_ack+0x7d/0xa0 net/ipv4/tcp_output.c:3977
tcp_cleanup_rbuf+0x229/0x5a0 net/ipv4/tcp.c:1589
tcp_recvmsg_locked+0x73e/0x2020 net/ipv4/tcp.c:2544
tcp_recvmsg+0x12b/0x590 net/ipv4/tcp.c:2574
inet_recvmsg+0x11b/0x5d0 net/ipv4/af_inet.c:850
page last free stack trace:
reset_page_owner include/linux/page_owner.h:24 [inline]
free_pages_prepare mm/page_alloc.c:1356 [inline]
free_pcp_prepare+0x51f/0xd00 mm/page_alloc.c:1406
free_unref_page_prepare mm/page_alloc.c:3328 [inline]
free_unref_page+0x19/0x5b0 mm/page_alloc.c:3423
skb_free_frag include/linux/skbuff.h:3135 [inline]
skb_free_head+0x96/0x110 net/core/skbuff.c:653
skb_release_data+0x677/0x810 net/core/skbuff.c:677
skb_release_all+0x46/0x60 net/core/skbuff.c:742
__kfree_skb+0x11/0x20 net/core/skbuff.c:756
tcp_eat_recv_skb+0x219/0x2c0 net/ipv4/tcp.c:1619
tcp_recvmsg_locked+0x1045/0x2020 net/ipv4/tcp.c:2528
tcp_recvmsg+0x12b/0x590 net/ipv4/tcp.c:2574
inet_recvmsg+0x11b/0x5d0 net/ipv4/af_inet.c:850
sock_recvmsg_nosec net/socket.c:948 [inline]
sock_recvmsg net/socket.c:966 [inline]
sock_recvmsg+0xca/0x110 net/socket.c:962
sock_read_iter+0x2b8/0x3b0 net/socket.c:1039
call_read_iter include/linux/fs.h:2044 [inline]
new_sync_read+0x50e/0x600 fs/read_write.c:401
vfs_read+0x495/0x5d0 fs/read_write.c:482
ksys_read+0x1e8/0x250 fs/read_write.c:620
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80

Memory state around the buggy address:
ffff8880212fa700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
ffff8880212fa780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880212fa800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff8880212fa880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff8880212fa900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
