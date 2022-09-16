Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 415195BACCC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 13:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiIPLxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 07:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiIPLx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 07:53:28 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DCFA2DAC;
        Fri, 16 Sep 2022 04:53:27 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 129so22424174vsi.10;
        Fri, 16 Sep 2022 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=jypwAuf3SiEfuvTa4hEt7gyoSATygt2PvS1K0NEyREY=;
        b=hS37cU/e59NFkCZBmgumA9Z2dMpWKzOnpbZFHxo+DqGzRB3duy609E7uVG5clNIf/3
         6xYgu3+yUX0Dr71RjTQ04FcPXN63B7iRHVU3rJhT4rnYxbJJgui3cLf7Bv/vB8+55VMX
         7IOpeNwZVW+7lNlIQz8mj3An2IqxFX0mrZUNqwTM8LRkxgpUHPgx/dVEI9GyINJsYYGZ
         kiAos1U7mSSpvU+lvCzNDywIhmSA2Tc8HaLfA30pLPQMuNmH3uMYQ7LF0QkserYRmQ1b
         riEnQViM5B56OYP6RDEGNjlCObUY5Ui8FQsxmQvMwoBoPSV+ER5tBBols0JdS3rNw+Eu
         uR9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=jypwAuf3SiEfuvTa4hEt7gyoSATygt2PvS1K0NEyREY=;
        b=Q4qhSkBvuAJqkSA6xFMX90AJv1GnbF8JecdNWHeP4TVFXObAh3+WnBtCDR7q7Ci3ku
         5J6k3WJQVQK/vaMxjfJioKPW976sPRXtT2xJxwK2N5kZ6t5qM8KpqU0gOPSGQq9J1JIx
         1Afn/0Eu0FcqNZ191vYck+DgkUZcEIBMMGxrjh4q4YTlNy1G7Dxpunbl7U7BzcTuqdQH
         2/I38ZtrZTyO/zGeRwNj5fuB5SP0mp7UKfRQZJFrzO/DBTG6HpdIEqHiZHleuouBI03x
         YUIsBsjdPed+afd904NVUezbpJMUSat6kh65l3tuw8HcbgyVk9rjgJap7FR2AjQMjbBM
         Gr8g==
X-Gm-Message-State: ACrzQf2RsxJdyu8vrmDAzqJ4aZfbRRFYvOPXa1Ou1VVmz7HK0i9VMZy/
        +BN8QvAupu1i6NEwuhUxvIg4TnS6XIVCWs3WI+5tVpVyN24Pmg==
X-Google-Smtp-Source: AMsMyM6XUSQoW7MP1517H29mgxMTfknLnlK8bvCv2pRqQoz9GCjWZBEDnArJrtVgfy7hhmiZYRFdYNe4xKeiqz9qT08=
X-Received: by 2002:a67:8c43:0:b0:398:6815:d340 with SMTP id
 o64-20020a678c43000000b003986815d340mr1942498vsd.42.1663329206250; Fri, 16
 Sep 2022 04:53:26 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Fri, 16 Sep 2022 19:53:15 +0800
Message-ID: <CAB7eex+cTEmaUMrShcSk9_Ve3yAsmMN3a77NuO37TUEL3pVgOQ@mail.gmail.com>
Subject: KASAN: use-after-free Read in dummy_timer
To:     rdunlap@infradead.org, ira.weiny@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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
C reproducer: https://pastebin.com/raw/72y5dCXx
console output: https://pastebin.com/raw/MDQWXdya

Basically, in the c reproducer, we use the gadget module to emulate
attaching a USB device(vendor id: 0x2040, product id: 0xc000, with the
net function) and executing some simple sequence of system calls.
To reproduce this crash, we utilize a third-party library to emulate
the attaching process: https://github.com/linux-usb-gadgets/libusbgx.
Just clone this repository, install it, and compile the c
reproducer with ``` gcc crash.c -lusbgx -lconfig -o crash ``` will do
the trick.

I would appreciate it if you have any idea how to solve this bug.

The crash report is as follows:
BUG: KASAN: use-after-free in dummy_timer+0x2aa4/0x33d0
drivers/usb/gadget/udc/dummy_hcd.c:1844
Read of size 4 at addr ffff88802a558274 by task syz-fuzzer/6413

CPU: 0 PID: 6413 Comm: syz-fuzzer Not tainted 6.0.0-rc4+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
<IRQ>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
print_address_description mm/kasan/report.c:317 [inline]
print_report.cold+0xe5/0x66d mm/kasan/report.c:433
kasan_report+0x8a/0x1b0 mm/kasan/report.c:495
dummy_timer+0x2aa4/0x33d0 drivers/usb/gadget/udc/dummy_hcd.c:1844
call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
expire_timers kernel/time/timer.c:1519 [inline]
__run_timers.part.0+0x69c/0xad0 kernel/time/timer.c:1790
__run_timers kernel/time/timer.c:1768 [inline]
run_timer_softirq+0xb6/0x1d0 kernel/time/timer.c:1803
__do_softirq+0x1d0/0x908 kernel/softirq.c:571
invoke_softirq kernel/softirq.c:445 [inline]
__irq_exit_rcu kernel/softirq.c:650 [inline]
irq_exit_rcu+0xf2/0x130 kernel/softirq.c:662
sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1106
</IRQ>
<TASK>
asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:tomoyo_check_path_acl security/tomoyo/file.c:260 [inline]
RIP: 0010:tomoyo_check_path_acl+0xbe/0x150 security/tomoyo/file.c:252
Code: 31 ed d3 fb 83 e3 01 89 de e8 fe 85 c1 fd 85 db 75 13 e8 95 84
c1 fd 44 89 e8 48 83 c4 08 5b 5d 41 5c 41 5d c3 e8 82 84 c1 fd <48> 8d
7d 18 48 b8 00 00 00 00 00 fc ff df 49 8d 74 24 20 48 89 fa
RSP: 0018:ffffc9000226f978 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff888041f9ba80
RDX: 0000000000000000 RSI: ffff888041f9ba80 RDI: 0000000000000002
RBP: ffffc9000226fad0 R08: ffffffff83b963ae R09: 0000000000000000
R10: 0000000000000005 R11: fffffbfff1d34742 R12: ffff8880484ab900
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
tomoyo_check_acl+0x13c/0x440 security/tomoyo/domain.c:175
tomoyo_path_permission security/tomoyo/file.c:586 [inline]
tomoyo_path_permission+0x1ff/0x3a0 security/tomoyo/file.c:573
tomoyo_path_perm+0x2fc/0x420 security/tomoyo/file.c:838
security_inode_getattr+0xcf/0x140 security/security.c:1345
vfs_getattr+0x22/0x60 fs/stat.c:157
vfs_statx+0x170/0x360 fs/stat.c:232
vfs_fstatat+0x8c/0xb0 fs/stat.c:255
__do_sys_newfstatat+0x91/0x110 fs/stat.c:425
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x49d60a
Code: e8 1b 98 fc ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 4c
8b 54 24 28 4c 8b 44 24 30 4c 8b 4c 24 38 48 8b 44 24 08 0f 05 <48> 3d
01 f0 ff ff 76 20 48 c7 44 24 40 ff ff ff ff 48 c7 44 24 48
RSP: 002b:000000c002c25d20 EFLAGS: 00000206 ORIG_RAX: 0000000000000106
RAX: ffffffffffffffda RBX: 000000c000022500 RCX: 000000000049d60a
RDX: 000000c001a98928 RSI: 000000c0019e92b0 RDI: ffffffffffffff9c
RBP: 000000c002c25db0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 000000c002f6b860 R15: 000000000000012b
</TASK>

Allocated by task 2959:
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
smsusb_init_device+0xb2/0xaf8 drivers/media/usb/siano/smsusb.c:395
smsusb_probe+0xd42/0xddf drivers/media/usb/siano/smsusb.c:566
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

Freed by task 2959:
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
smsusb_term_device+0xd1/0x160 drivers/media/usb/siano/smsusb.c:350
smsusb_init_device+0xa76/0xaf8 drivers/media/usb/siano/smsusb.c:487
smsusb_probe+0xd42/0xddf drivers/media/usb/siano/smsusb.c:566
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

Last potentially related work creation:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
__kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
insert_work+0x4a/0x390 kernel/workqueue.c:1358
__queue_work+0x4d4/0x1200 kernel/workqueue.c:1517
queue_work_on+0xee/0x110 kernel/workqueue.c:1545
queue_work include/linux/workqueue.h:503 [inline]
schedule_work include/linux/workqueue.h:564 [inline]
smsusb_onresponse+0x58f/0x780 drivers/media/usb/siano/smsusb.c:147
__usb_hcd_giveback_urb+0x2c2/0x5a0 drivers/usb/core/hcd.c:1671
usb_hcd_giveback_urb+0x380/0x430 drivers/usb/core/hcd.c:1754
dummy_timer+0x1263/0x33d0 drivers/usb/gadget/udc/dummy_hcd.c:1988
call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
expire_timers kernel/time/timer.c:1519 [inline]
__run_timers.part.0+0x69c/0xad0 kernel/time/timer.c:1790
__run_timers kernel/time/timer.c:1768 [inline]
run_timer_softirq+0xb6/0x1d0 kernel/time/timer.c:1803
__do_softirq+0x1d0/0x908 kernel/softirq.c:571

Second to last potentially related work creation:
kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
__kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
insert_work+0x4a/0x390 kernel/workqueue.c:1358
__queue_work+0x4d4/0x1200 kernel/workqueue.c:1517
queue_work_on+0xee/0x110 kernel/workqueue.c:1545
queue_work include/linux/workqueue.h:503 [inline]
schedule_work include/linux/workqueue.h:564 [inline]
smsusb_onresponse+0x58f/0x780 drivers/media/usb/siano/smsusb.c:147
__usb_hcd_giveback_urb+0x2c2/0x5a0 drivers/usb/core/hcd.c:1671
usb_hcd_giveback_urb+0x380/0x430 drivers/usb/core/hcd.c:1754
dummy_timer+0x1263/0x33d0 drivers/usb/gadget/udc/dummy_hcd.c:1988
call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
expire_timers kernel/time/timer.c:1519 [inline]
__run_timers.part.0+0x69c/0xad0 kernel/time/timer.c:1790
__run_timers kernel/time/timer.c:1768 [inline]
run_timer_softirq+0xb6/0x1d0 kernel/time/timer.c:1803
__do_softirq+0x1d0/0x908 kernel/softirq.c:571

The buggy address belongs to the object at ffff88802a558000
which belongs to the cache kmalloc-4k of size 4096
The buggy address is located 628 bytes inside of
4096-byte region [ffff88802a558000, ffff88802a559000)

The buggy address belongs to the physical page:
page:ffffea0000a95600 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x2a558
head:ffffea0000a95600 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888011c42140
raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask
0x1d2a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL),
pid 150, tgid 150 (kworker/0:2), ts 346929849238, free_ts 346865690650
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
__kmalloc_node_track_caller+0x2ec/0x370 mm/slub.c:4955
kmalloc_reserve+0x32/0xd0 net/core/skbuff.c:358
__alloc_skb+0x11a/0x320 net/core/skbuff.c:430
alloc_skb include/linux/skbuff.h:1257 [inline]
nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:742 [inline]
nsim_dev_trap_report drivers/net/netdevsim/dev.c:799 [inline]
nsim_dev_trap_report_work+0x2ba/0xc40 drivers/net/netdevsim/dev.c:844
process_one_work+0x9c7/0x1650 kernel/workqueue.c:2289
worker_thread+0x623/0x1070 kernel/workqueue.c:2436
kthread+0x2e9/0x3a0 kernel/kthread.c:376
ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
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
getname_flags fs/namei.c:139 [inline]
getname_flags+0xd2/0x5b0 fs/namei.c:129
vfs_fstatat+0x73/0xb0 fs/stat.c:254
vfs_stat include/linux/fs.h:3278 [inline]
__do_sys_newstat+0x88/0x110 fs/stat.c:398
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
ffff88802a558100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88802a558180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88802a558200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
^
ffff88802a558280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
ffff88802a558300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
0: 31 ed xor %ebp,%ebp
2: d3 fb sar %cl,%ebx
4: 83 e3 01 and $0x1,%ebx
7: 89 de mov %ebx,%esi
9: e8 fe 85 c1 fd callq 0xfdc1860c
e: 85 db test %ebx,%ebx
10: 75 13 jne 0x25
12: e8 95 84 c1 fd callq 0xfdc184ac
17: 44 89 e8 mov %r13d,%eax
1a: 48 83 c4 08 add $0x8,%rsp
1e: 5b pop %rbx
1f: 5d pop %rbp
20: 41 5c pop %r12
22: 41 5d pop %r13
24: c3 retq
25: e8 82 84 c1 fd callq 0xfdc184ac
* 2a: 48 8d 7d 18 lea 0x18(%rbp),%rdi <-- trapping instruction
2e: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
35: fc ff df
38: 49 8d 74 24 20 lea 0x20(%r12),%rsi
3d: 48 89 fa mov %rdi,%rdx
