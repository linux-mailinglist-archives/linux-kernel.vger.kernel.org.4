Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053D26D7AD4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbjDELM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbjDELMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:12:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698A959C8
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:12:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l9-20020a17090a3f0900b0023d32684e7fso3529547pjc.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 04:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680693120;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Laa0BjxrcPuvlXhGTEpUMoP9S8FTOz+MCW7n96GOfPo=;
        b=nnPbeAd4YP3wStv0GybHN5o3kH/VNUw2DISbYeUhd4nGTFG8fThO+IIdd4vjFOS29Q
         /2N+m37vsFyCz0n9q8A3vALX1QV18jKw+hBQoObrrv7SXvGmefK8mC58PjOBhGdwPcPu
         aKepwQXVo0xF38ee+HrYVY9QIcShX8xG3FexoF3KH2y5Q0AE9pIivsi4vKc+HsuMGNUV
         pS3GTrs37pgRghpRoeRJa89JRs4VTBQegBUr+Tds5OuKF9SCxA53bDgWTOJcyuGmrx2p
         flWJQCd5KhmhWazL/PQHW8mgbw7Z4KUQIgV0ti4os4zKuBOHBz7EyW0HmCWDsmRoGBlz
         kO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680693120;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Laa0BjxrcPuvlXhGTEpUMoP9S8FTOz+MCW7n96GOfPo=;
        b=6sbqkHO8bluWyoSWp0KBseKqT++LOl/hhFcmZncS0nPKud53rcDMW7Njmc+0qy3qaQ
         SyXoEysLehCPfJRZhrH7QwNsQ9TcTnfQfBAnxVNpCMFKxDWIZuohx3/fmLxOc6KJSHXd
         SAgcMOG9+54RCejU5vF4C5CUzCkFVYCgKpqmY9OV2i9T+VuOjB4cHeoHsx2QJPRMhLjH
         BNmUnMRNwv0bK1cX2lxXIfVs2Pgmz4II4/pq9WItZWMKCANkL3Wd6tQMrDJNn549eQd/
         1nErvvA7XP8KMat2Am8hVqNuUxQVxIOTf1OJB4rlTPpXRzpze6FP47n2QZE8vlMQMN1w
         Er5A==
X-Gm-Message-State: AAQBX9chXHw8yEuoHoANatI0DxiqtdgHoPoF/6tiOTO9y66ZtSnVLSgJ
        jN4IrsbqVdYV2bwjzcyKjkg=
X-Google-Smtp-Source: AKy350Yd5EG8yIivOsVu2eoMkgA1kv/ktmzPMrLNfsYNvzD7uXpj5exrVyXDM+skLI3UAfSeMnagag==
X-Received: by 2002:a17:902:f552:b0:19c:ff5d:1fd2 with SMTP id h18-20020a170902f55200b0019cff5d1fd2mr2369950plf.8.1680693119535;
        Wed, 05 Apr 2023 04:11:59 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id j10-20020a17090276ca00b0019c3296844csm9846769plt.301.2023.04.05.04.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:11:59 -0700 (PDT)
Date:   Wed, 5 Apr 2023 20:11:55 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: KASAN: use-after-free Read in snd_pcm_plug_read_transfer
Message-ID: <ZC1XewbJjZBEKDo5@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We observed an issue "KASAN: use-after-free Read in snd_pcm_plug_read_transfer".

Unfortunately, we have not found a reproducer for the crash. We will
inform you if we have any update on this crash.

Detailed crash information is attached below.

Best regards,
Dae R. Jeong

-----
- Kernel version:
6.0-rc7

- Crash report:
==================================================================
BUG: KASAN: use-after-free in snd_pcm_plug_read_transfer+0x2e6/0x4e0 sound/core/oss/pcm_plugin.c:653
Read of size 8 at addr ffff88801fb82e60 by task syz-executor.0/3194

CPU: 2 PID: 3194 Comm: syz-executor.0 Not tainted 6.0.0-rc7-00167-g92162e4a9862 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1cf/0x2b7 lib/dump_stack.c:106
 print_address_description+0x21/0x470 mm/kasan/report.c:317
 print_report+0x108/0x1f0 mm/kasan/report.c:433
 kasan_report+0xe5/0x110 mm/kasan/report.c:495
 snd_pcm_plug_read_transfer+0x2e6/0x4e0 sound/core/oss/pcm_plugin.c:653
 snd_pcm_oss_read2 sound/core/oss/pcm_oss.c:1493 [inline]
 snd_pcm_oss_read1+0x7a0/0x1130 sound/core/oss/pcm_oss.c:1531
 vfs_read+0x31e/0xd30 fs/read_write.c:468
 ksys_read+0x182/0x2c0 fs/read_write.c:607
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x4725fd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3e600f5be8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000582928 RCX: 00000000004725fd
RDX: 0000000000000016 RSI: 0000000020000140 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000582930
R13: 0000000000582934 R14: 00007fff5bd8fb10 R15: 00007f3e600f5d80
 </TASK>

Allocated by task 3193:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc+0xcd/0x100 mm/kasan/common.c:516
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 __kmalloc+0x31e/0x490 mm/slub.c:4429
 kmalloc include/linux/slab.h:605 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 snd_pcm_plugin_build+0x5e/0x560 sound/core/oss/pcm_plugin.c:164
 snd_pcm_plugin_build_rate+0x22d/0x720 sound/core/oss/rate.c:324
 snd_pcm_plug_format_plugins+0xb5f/0x1b80 sound/core/oss/pcm_plugin.c:478
 snd_pcm_oss_change_params_locked+0x2c06/0x4e20 sound/core/oss/pcm_oss.c:986
 snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1116 [inline]
 snd_pcm_oss_get_active_substream+0x244/0x2b0 sound/core/oss/pcm_oss.c:1133
 snd_pcm_oss_get_rate sound/core/oss/pcm_oss.c:1790 [inline]
 snd_pcm_oss_set_rate sound/core/oss/pcm_oss.c:1782 [inline]
 snd_pcm_oss_ioctl+0x217b/0x4190 sound/core/oss/pcm_oss.c:2638
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0x110/0x180 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 3195:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:45
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free+0x134/0x1c0 mm/kasan/common.c:367
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1759 [inline]
 slab_free_freelist_hook+0x278/0x370 mm/slub.c:1785
 slab_free mm/slub.c:3539 [inline]
 kfree+0x108/0x460 mm/slub.c:4567
 snd_pcm_plugin_free+0xd1/0xe0 sound/core/oss/pcm_plugin.c:199
 snd_pcm_oss_plugin_clear sound/core/oss/pcm_oss.c:547 [inline]
 snd_pcm_oss_release_buffers sound/core/oss/pcm_oss.c:852 [inline]
 snd_pcm_oss_change_params_locked+0x11d9/0x4e20 sound/core/oss/pcm_oss.c:1096
 snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1116 [inline]
 snd_pcm_oss_make_ready sound/core/oss/pcm_oss.c:1175 [inline]
 snd_pcm_oss_set_trigger+0x45f/0xf70 sound/core/oss/pcm_oss.c:2092
 snd_pcm_oss_poll+0x810/0xab0 sound/core/oss/pcm_oss.c:2878
 vfs_poll include/linux/poll.h:88 [inline]
 p9_fd_poll net/9p/trans_fd.c:233 [inline]
 p9_conn_create+0x52f/0x700 net/9p/trans_fd.c:598
 p9_fd_create+0x3e0/0x4c0 net/9p/trans_fd.c:1077
 p9_client_create+0x916/0x11d0 net/9p/client.c:966
 v9fs_session_init+0x223/0x1cf0 fs/9p/v9fs.c:408
 v9fs_mount+0xdd/0xe90 fs/9p/vfs_super.c:126
 legacy_get_tree+0x135/0x1f0 fs/fs_context.c:610
 vfs_get_tree+0xa5/0x310 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1b37/0x3090 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x313/0x3d0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:348
 insert_work+0x54/0x400 kernel/workqueue.c:1358
 __queue_work+0xa95/0xe00 kernel/workqueue.c:1517
 queue_work_on+0x12c/0x210 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 call_usermodehelper_exec+0x298/0x4b0 kernel/umh.c:435
 kobject_uevent_env+0x1571/0x1990 lib/kobject_uevent.c:618
 kobject_synth_uevent+0x3ed/0x980 lib/kobject_uevent.c:208
 uevent_store+0x20/0x60 drivers/base/core.c:2509
 kernfs_fop_write_iter+0x450/0x600 fs/kernfs/file.c:354
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x848/0xd90 fs/read_write.c:578
 ksys_write+0x182/0x2c0 fs/read_write.c:631
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xac/0xc0 mm/kasan/generic.c:348
 insert_work+0x54/0x400 kernel/workqueue.c:1358
 __queue_work+0xa95/0xe00 kernel/workqueue.c:1517
 queue_work_on+0x12c/0x210 kernel/workqueue.c:1545
 queue_work include/linux/workqueue.h:503 [inline]
 call_usermodehelper_exec+0x298/0x4b0 kernel/umh.c:435
 kobject_uevent_env+0x1571/0x1990 lib/kobject_uevent.c:618
 device_add+0x1339/0x1b60 drivers/base/core.c:3498
 usb_new_device+0xd9d/0x1bb0 drivers/usb/core/hub.c:2573
 hub_port_connect+0x1243/0x2dd0 drivers/usb/core/hub.c:5353
 hub_port_connect_change+0x696/0xd40 drivers/usb/core/hub.c:5497
 port_event+0xaca/0x12b0 drivers/usb/core/hub.c:5653
 hub_event+0x511/0xed0 drivers/usb/core/hub.c:5735
 process_one_work+0x83f/0x11a0 kernel/workqueue.c:2289
 worker_thread+0xa6c/0x1290 kernel/workqueue.c:2436
 kthread+0x28a/0x320 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff88801fb82e00
 which belongs to the cache kmalloc-192 of size 192
The buggy address is located 96 bytes inside of
 192-byte region [ffff88801fb82e00, ffff88801fb82ec0)

The buggy address belongs to the physical page:
page:ffffea00007ee080 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1fb82
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0000503380 dead000000000002 ffff888013442a00
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12c00(GFP_NOIO|__GFP_NOWARN|__GFP_NORETRY), pid 949, tgid 949 (kworker/0:2), ts 20844494854, free_ts 20409160136
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x800/0xc10 mm/page_alloc.c:4283
 __alloc_pages+0x2f0/0x650 mm/page_alloc.c:5549
 alloc_slab_page mm/slub.c:1829 [inline]
 allocate_slab+0x1eb/0xc00 mm/slub.c:1974
 new_slab mm/slub.c:2034 [inline]
 ___slab_alloc+0x581/0xff0 mm/slub.c:3036
 __slab_alloc mm/slub.c:3123 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmalloc+0x3cb/0x490 mm/slub.c:4425
 kmalloc include/linux/slab.h:605 [inline]
 usb_alloc_urb+0x38/0x180 drivers/usb/core/urb.c:74
 usb_internal_control_msg drivers/usb/core/message.c:95 [inline]
 usb_control_msg+0x1bd/0x590 drivers/usb/core/message.c:153
 get_port_status drivers/usb/core/hub.c:581 [inline]
 hub_ext_port_status+0x12d/0x780 drivers/usb/core/hub.c:598
 usb_hub_port_status drivers/usb/core/hub.c:620 [inline]
 hub_activate+0x917/0x2060 drivers/usb/core/hub.c:1130
 process_one_work+0x83f/0x11a0 kernel/workqueue.c:2289
 worker_thread+0xa6c/0x1290 kernel/workqueue.c:2436
 kthread+0x28a/0x320 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x76d/0x890 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x8a/0x880 mm/page_alloc.c:3476
 __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:114 [inline]
 tlb_remove_table_rcu+0x9b/0x120 mm/mmu_gather.c:169
 rcu_do_batch kernel/rcu/tree.c:2245 [inline]
 rcu_core+0x9bb/0x1680 kernel/rcu/tree.c:2505
 __do_softirq+0x372/0x783 kernel/softirq.c:571

Memory state around the buggy address:
 ffff88801fb82d00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801fb82d80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff88801fb82e00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                       ^
 ffff88801fb82e80: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff88801fb82f00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
