Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5733671976
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjARKpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjARKmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:42:50 -0500
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.232.28.96])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 1365B2E0C7;
        Wed, 18 Jan 2023 01:46:53 -0800 (PST)
Received: from ubuntu.localdomain (unknown [106.117.76.92])
        by mail-app2 (Coremail) with SMTP id by_KCgBXXSH3v8dj8gr_CQ--.6318S2;
        Wed, 18 Jan 2023 17:46:40 +0800 (CST)
From:   Duoming Zhou <duoming@zju.edu.cn>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] media: usb: siano: Fix use after free bugs caused by do_submit_urb
Date:   Wed, 18 Jan 2023 17:46:30 +0800
Message-Id: <20230118094630.22141-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: by_KCgBXXSH3v8dj8gr_CQ--.6318S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJr13Kw1fGr1Dtr13Zw18Zrb_yoWkGFy5pF
        n3GrZ0krW8try7Ar4jyF18tw17GrZFy3W7tr40yw1xX3W29w45Xry8K3yjgr1UGr45AFy7
        JF98JrWxtryqkaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkS14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r4f
        MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
        0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
        wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
        W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
        cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUeWrWUUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAgoTAVZdtdRROQAbsD
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are UAF bugs caused by do_submit_urb(). One of the KASan reports
is shown below:

[   36.403605] BUG: KASAN: use-after-free in worker_thread+0x4a2/0x890
[   36.406105] Read of size 8 at addr ffff8880059600e8 by task kworker/0:2/49
[   36.408316]
[   36.408867] CPU: 0 PID: 49 Comm: kworker/0:2 Not tainted 6.2.0-rc3-15798-g5a41237ad1d4-dir8
[   36.411696] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g15584
[   36.416157] Workqueue:  0x0 (events)
[   36.417654] Call Trace:
[   36.418546]  <TASK>
[   36.419320]  dump_stack_lvl+0x96/0xd0
[   36.420522]  print_address_description+0x75/0x350
[   36.421992]  print_report+0x11b/0x250
[   36.423174]  ? _raw_spin_lock_irqsave+0x87/0xd0
[   36.424806]  ? __virt_addr_valid+0xcf/0x170
[   36.426069]  ? worker_thread+0x4a2/0x890
[   36.427355]  kasan_report+0x131/0x160
[   36.428556]  ? worker_thread+0x4a2/0x890
[   36.430053]  worker_thread+0x4a2/0x890
[   36.431297]  ? worker_clr_flags+0x90/0x90
[   36.432479]  kthread+0x166/0x190
[   36.433493]  ? kthread_blkcg+0x50/0x50
[   36.434669]  ret_from_fork+0x22/0x30
[   36.435923]  </TASK>
[   36.436684]
[   36.437215] Allocated by task 24:
[   36.438289]  kasan_set_track+0x50/0x80
[   36.439436]  __kasan_kmalloc+0x89/0xa0
[   36.440566]  smsusb_probe+0x374/0xc90
[   36.441920]  usb_probe_interface+0x2d1/0x4c0
[   36.443253]  really_probe+0x1d5/0x580
[   36.444539]  __driver_probe_device+0xe3/0x130
[   36.446085]  driver_probe_device+0x49/0x220
[   36.447423]  __device_attach_driver+0x19e/0x1b0
[   36.448931]  bus_for_each_drv+0xcb/0x110
[   36.450217]  __device_attach+0x132/0x1f0
[   36.451470]  bus_probe_device+0x59/0xf0
[   36.452563]  device_add+0x4ec/0x7b0
[   36.453830]  usb_set_configuration+0xc63/0xe10
[   36.455230]  usb_generic_driver_probe+0x3b/0x80
[   36.456166] printk: console [ttyGS0] disabled
[   36.456569]  usb_probe_device+0x90/0x110
[   36.459523]  really_probe+0x1d5/0x580
[   36.461027]  __driver_probe_device+0xe3/0x130
[   36.462465]  driver_probe_device+0x49/0x220
[   36.463847]  __device_attach_driver+0x19e/0x1b0
[   36.465229]  bus_for_each_drv+0xcb/0x110
[   36.466466]  __device_attach+0x132/0x1f0
[   36.467799]  bus_probe_device+0x59/0xf0
[   36.469010]  device_add+0x4ec/0x7b0
[   36.470125]  usb_new_device+0x863/0xa00
[   36.471374]  hub_event+0x18c7/0x2220
[   36.472746]  process_one_work+0x34c/0x5b0
[   36.474041]  worker_thread+0x4b7/0x890
[   36.475216]  kthread+0x166/0x190
[   36.476267]  ret_from_fork+0x22/0x30
[   36.477447]
[   36.478160] Freed by task 24:
[   36.479239]  kasan_set_track+0x50/0x80
[   36.480512]  kasan_save_free_info+0x2b/0x40
[   36.481808]  ____kasan_slab_free+0x122/0x1a0
[   36.483173]  __kmem_cache_free+0xc4/0x200
[   36.484563]  smsusb_term_device+0xcd/0xf0
[   36.485896]  smsusb_probe+0xc85/0xc90
[   36.486976]  usb_probe_interface+0x2d1/0x4c0
[   36.488303]  really_probe+0x1d5/0x580
[   36.489498]  __driver_probe_device+0xe3/0x130
[   36.491140]  driver_probe_device+0x49/0x220
[   36.492475]  __device_attach_driver+0x19e/0x1b0
[   36.493988]  bus_for_each_drv+0xcb/0x110
[   36.495171]  __device_attach+0x132/0x1f0
[   36.496617]  bus_probe_device+0x59/0xf0
[   36.497875]  device_add+0x4ec/0x7b0
[   36.498972]  usb_set_configuration+0xc63/0xe10
[   36.500264]  usb_generic_driver_probe+0x3b/0x80
[   36.501740]  usb_probe_device+0x90/0x110
[   36.503084]  really_probe+0x1d5/0x580
[   36.504241]  __driver_probe_device+0xe3/0x130
[   36.505548]  driver_probe_device+0x49/0x220
[   36.506766]  __device_attach_driver+0x19e/0x1b0
[   36.508368]  bus_for_each_drv+0xcb/0x110
[   36.509646]  __device_attach+0x132/0x1f0
[   36.510911]  bus_probe_device+0x59/0xf0
[   36.512103]  device_add+0x4ec/0x7b0
[   36.513215]  usb_new_device+0x863/0xa00
[   36.514736]  hub_event+0x18c7/0x2220
[   36.516130]  process_one_work+0x34c/0x5b0
[   36.517396]  worker_thread+0x4b7/0x890
[   36.518591]  kthread+0x166/0x190
[   36.519599]  ret_from_fork+0x22/0x30
[   36.520851]
[   36.521405] Last potentially related work creation:
[   36.523143]  kasan_save_stack+0x3f/0x60
[   36.524275]  kasan_record_aux_stack_noalloc+0x9d/0xb0
[   36.525831]  insert_work+0x25/0x130
[   36.527039]  __queue_work+0x4d4/0x620
[   36.528236]  queue_work_on+0x72/0xb0
[   36.529344]  __usb_hcd_giveback_urb+0x13f/0x1b0
[   36.530819]  dummy_timer+0x350/0x1a40
[   36.532149]  call_timer_fn+0x2c/0x190
[   36.533567]  expire_timers+0x69/0x1f0
[   36.534736]  __run_timers+0x289/0x2d0
[   36.535841]  run_timer_softirq+0x2d/0x60
[   36.537110]  __do_softirq+0x116/0x380
[   36.538377]
[   36.538950] Second to last potentially related work creation:
[   36.540855]  kasan_save_stack+0x3f/0x60
[   36.542084]  kasan_record_aux_stack_noalloc+0x9d/0xb0
[   36.543592]  insert_work+0x25/0x130
[   36.544891]  __queue_work+0x4d4/0x620
[   36.546168]  queue_work_on+0x72/0xb0
[   36.547328]  __usb_hcd_giveback_urb+0x13f/0x1b0
[   36.548805]  dummy_timer+0x350/0x1a40
[   36.550116]  call_timer_fn+0x2c/0x190
[   36.551570]  expire_timers+0x69/0x1f0
[   36.552762]  __run_timers+0x289/0x2d0
[   36.553916]  run_timer_softirq+0x2d/0x60
[   36.555118]  __do_softirq+0x116/0x380
[   36.556239]
[   36.556807] The buggy address belongs to the object at ffff888005960000
[   36.556807]  which belongs to the cache kmalloc-4k of size 4096
[   36.560652] The buggy address is located 232 bytes inside of
[   36.560652]  4096-byte region [ffff888005960000, ffff888005961000)
[   36.564791]
[   36.565355] The buggy address belongs to the physical page:
[   36.567212] page:000000004f0a0731 refcount:1 mapcount:0 mapping:0000000000000000 index:0x00
[   36.570534] head:000000004f0a0731 order:3 compound_mapcount:0 subpages_mapcount:0 compound0
[   36.573717] flags: 0x100000000010200(slab|head|node=0|zone=1)
[   36.575481] raw: 0100000000010200 ffff888001042140 dead000000000122 0000000000000000
[   36.577842] raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
[   36.580175] page dumped because: kasan: bad access detected
[   36.581994]
[   36.582548] Memory state around the buggy address:
[   36.583983]  ffff88800595ff80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   36.586240]  ffff888005960000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   36.588884] >ffff888005960080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   36.591071]                                                           ^
[   36.593295]  ffff888005960100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   36.595705]  ffff888005960180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   36.598026] ==================================================================
[   36.600224] Disabling lock debugging due to kernel taint
[   36.602681] general protection fault, probably for non-canonical address 0x43600a000000060I
[   36.607129] CPU: 0 PID: 49 Comm: kworker/0:2 Tainted: G    B              6.2.0-rc3-15798-8
[   36.611115] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g15584
[   36.615026] Workqueue: events do_submit_urb
[   36.616290] RIP: 0010:_raw_spin_lock_irqsave+0x8a/0xd0
[   36.618107] Code: 24 00 00 00 00 48 89 df be 04 00 00 00 e8 9e b5 c6 fe 48 89 ef be 04 00 5
[   36.623522] RSP: 0018:ffff888004b6fcf0 EFLAGS: 00010046
[   36.625072] RAX: 0000000000000000 RBX: 043600a000000060 RCX: ffffffff9fc0e0d7
[   36.627206] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffff888004b6fcf0
[   36.629813] RBP: ffff888004b6fcf0 R08: dffffc0000000000 R09: ffffed100096df9f
[   36.631974] R10: dfffe9100096dfa0 R11: 1ffff1100096df9e R12: ffff888005960020
[   36.634285] R13: ffff8880059600f0 R14: 0000000000000246 R15: 0000000000000001
[   36.636438] FS:  0000000000000000(0000) GS:ffff88806d600000(0000) knlGS:0000000000000000
[   36.639092] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.640951] CR2: 00007f07476819a3 CR3: 0000000004a34000 CR4: 00000000000006f0
[   36.643411] Call Trace:
[   36.644215]  <TASK>
[   36.644902]  smscore_getbuffer+0x3e/0x1e0
[   36.646147]  do_submit_urb+0x4f/0x190
[   36.647449]  process_one_work+0x34c/0x5b0
[   36.648777]  worker_thread+0x4b7/0x890
[   36.649984]  ? worker_clr_flags+0x90/0x90
[   36.651166]  kthread+0x166/0x190
[   36.652151]  ? kthread_blkcg+0x50/0x50
[   36.653547]  ret_from_fork+0x22/0x30
[   36.655051]  </TASK>
[   36.655733] Modules linked in:
[   36.656787] ---[ end trace 0000000000000000 ]---
[   36.658328] RIP: 0010:_raw_spin_lock_irqsave+0x8a/0xd0
[   36.660045] Code: 24 00 00 00 00 48 89 df be 04 00 00 00 e8 9e b5 c6 fe 48 89 ef be 04 00 5
[   36.665730] RSP: 0018:ffff888004b6fcf0 EFLAGS: 00010046
[   36.667448] RAX: 0000000000000000 RBX: 043600a000000060 RCX: ffffffff9fc0e0d7
[   36.669675] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffff888004b6fcf0
[   36.672645] RBP: ffff888004b6fcf0 R08: dffffc0000000000 R09: ffffed100096df9f
[   36.674921] R10: dfffe9100096dfa0 R11: 1ffff1100096df9e R12: ffff888005960020
[   36.677034] R13: ffff8880059600f0 R14: 0000000000000246 R15: 0000000000000001
[   36.679184] FS:  0000000000000000(0000) GS:ffff88806d600000(0000) knlGS:0000000000000000
[   36.681655] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.683383] CR2: 00007f07476819a3 CR3: 0000000004a34000 CR4: 00000000000006f0
[   36.685733] Kernel panic - not syncing: Fatal exception
[   36.688585] Kernel Offset: 0x1d400000 from 0xffffffff81000000 (relocation range: 0xfffffff)
[   36.692199] ---[ end Kernel panic - not syncing: Fatal exception ]---

When the siano device is plugged in, it may call the following functions
to initialize the device.

smsusb_probe()-->smsusb_init_device()-->smscore_start_device().

When smscore_start_device() gets failed, the function smsusb_term_device()
will be called and smsusb_device_t will be deallocated. Although we use
usb_kill_urb() in smsusb_stop_streaming() to cancel transfer requests
and wait for them to finish, the worker threads that are scheduled by
smsusb_onresponse() may be still running. As a result, the UAF bugs
could happen.

We add cancel_work_sync() in smsusb_stop_streaming() in order that the
worker threads could finish before the smsusb_device_t is deallocated.

Fixes: dd47fbd40e6e ("[media] smsusb: don't sleep while atomic")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/media/usb/siano/smsusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/usb/siano/smsusb.c b/drivers/media/usb/siano/smsusb.c
index fe9c7b3a950..6f443c542c6 100644
--- a/drivers/media/usb/siano/smsusb.c
+++ b/drivers/media/usb/siano/smsusb.c
@@ -179,6 +179,7 @@ static void smsusb_stop_streaming(struct smsusb_device_t *dev)
 
 	for (i = 0; i < MAX_URBS; i++) {
 		usb_kill_urb(&dev->surbs[i].urb);
+		cancel_work_sync(&dev->surbs[i].wq);
 
 		if (dev->surbs[i].cb) {
 			smscore_putbuffer(dev->coredev, dev->surbs[i].cb);
-- 
2.17.1

