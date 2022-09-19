Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07DE5BCC1C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiISMqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiISMq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:46:27 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC52A947
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:46:26 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id b15so8695087vkp.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=UrBfut9T8kgQS7wNZRUyz/ed0FiYcdAPQ5fPd/GdYxk=;
        b=SOl13AnfW5omHfAnxMPsd1UBUFfapdc1w9lUAo50iqS7EDVSZV8tbbUGoXU7tlsJS1
         z0RsEFLUqeWKzinDWqlJyYk/IFNxpR9sjYBmVCnAfSQ9NFTDx6WgMl6+zXnad5ZhHAOn
         icdqCGYv1kpQADPjcTMzhwEof0ujcnVykQMlxivTCPFdE687ATgEdsL41avOL8CSMQwk
         ckPBGyOOCaNBsRrA29qHVNw3hAKwz1eLUm+LBz0xLcMS+NwQ0rE7AkOfmSwydleYgtDN
         YVhLrODZ48u9juUpiHXfRDi5+WscMVQeezTlPzPwP9nY2OCTkcUGIl5aT5t0OD9Sb3TG
         1PZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=UrBfut9T8kgQS7wNZRUyz/ed0FiYcdAPQ5fPd/GdYxk=;
        b=tVfyQVbQyL9JjRKRZ6CCObYGEpQ8wt5pppKiUOQllxzTamqL9SArwFOH9Tiwplrfku
         MVd5XB4HuY67xLY5jFbdg0Vi+L9b59X64bQXzSt/baCcMMwazQZHkjnmUHe54ErabYWg
         UdUTwFuVkr6FsIYNDFTwUDn5HOHk2Bf7FgzlnlGZcREL8f/Rhm8ccSoFIcYjCiS8OzxS
         gfmPoIA/DqLItiYxVEcwN7p+2TEQRa426Hw5YpZkihzsIWyGxkp4D9ZrXjs5n/OesoIF
         mOGjH5RLC3fp/rixFaKfyK2DJJepi8GS3ir4hAkjk0S7ZI7cpeMeBpfyzW7VdshsRlDe
         KhEg==
X-Gm-Message-State: ACrzQf0BZTyFgZLVrxLPVf5XkmNCZvoSJop6a+HqdrwESVGEjSbVYPkh
        j0EWyOdnCII9F/B0BDV2d3KpVy4tc3B6P/YINOA=
X-Google-Smtp-Source: AMsMyM4QMfAx2dgtYUmfGBDvXpvDPZ+brPW+DCffLHFsNiCjoXPcH1QbskD5z7VaOb78FdT+EVQi3tSGF3+Yz7O34aU=
X-Received: by 2002:a1f:26d8:0:b0:39e:e116:59b8 with SMTP id
 m207-20020a1f26d8000000b0039ee11659b8mr5909909vkm.36.1663591584872; Mon, 19
 Sep 2022 05:46:24 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Mon, 19 Sep 2022 20:46:13 +0800
Message-ID: <CAB7eexJP7w1B0mVgDF0dQ+gWor7UdkiwPczmL7pn91xx8xpzOA@mail.gmail.com>
Subject: possible deadlock in snd_rawmidi_free
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
console output: https://pastebin.com/raw/9tabWDtu

Sorry for failing to extract the reproducer, and the crash occurred at
the moment of disconnecting the midi device. On other versions of
Linux, I also triggered this crash.

I would appreciate it if you have any idea how to solve this bug.

The crash report is as follows:

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc4+ #20 Not tainted
------------------------------------------------------
kworker/1:7/10868 is trying to acquire lock:
ffffffff8e289108 (register_mutex#5){+.+.}-{3:3}, at:
snd_rawmidi_free+0x7a/0x190 sound/core/rawmidi.c:1902

but task is already holding lock:
ffffffff8e274048 (sound_oss_mutex){+.+.}-{3:3}, at:
snd_unregister_oss_device+0x97/0x290 sound/core/sound_oss.c:159

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (sound_oss_mutex){+.+.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5666 [inline]
       lock_acquire+0x1ab/0x580 kernel/locking/lockdep.c:5631
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x14f/0x1f50 kernel/locking/mutex.c:747
       snd_unregister_oss_device+0x97/0x290 sound/core/sound_oss.c:159
       snd_rawmidi_dev_disconnect+0x418/0x650 sound/core/rawmidi.c:2043
       __snd_device_disconnect.part.0+0x5b/0xc0 sound/core/device.c:63
       __snd_device_disconnect sound/core/device.c:61 [inline]
       snd_device_disconnect_all+0x9b/0xf0 sound/core/device.c:215
       snd_card_disconnect+0x306/0x740 sound/core/init.c:530
       snd_card_free_when_closed+0x13/0x50 sound/core/init.c:622
       f_midi_unbind+0x60/0x120 drivers/usb/gadget/function/f_midi.c:1335
       purge_configs_funcs+0x281/0x4e0 drivers/usb/gadget/configfs.c:1274
       configfs_composite_bind+0xbd3/0x11c0 drivers/usb/gadget/configfs.c:1426
       gadget_bind_driver+0x285/0x860 drivers/usb/gadget/udc/core.c:1495
       call_driver_probe drivers/base/dd.c:560 [inline]
       really_probe+0x249/0xa90 drivers/base/dd.c:639
       __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
       driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
       __driver_attach+0x1e6/0x420 drivers/base/dd.c:1190
       bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
       bus_add_driver+0x4c9/0x640 drivers/base/bus.c:618
       driver_register+0x1c4/0x330 drivers/base/driver.c:240
       usb_gadget_register_driver_owner+0xfb/0x1e0
drivers/usb/gadget/udc/core.c:1560
       gadget_dev_desc_UDC_store+0x184/0x220 drivers/usb/gadget/configfs.c:299
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x2ea/0x480 fs/configfs/file.c:229
       call_write_iter include/linux/fs.h:2187 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x9ca/0xd90 fs/read_write.c:578
       ksys_write+0x127/0x250 fs/read_write.c:631
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&rmidi->open_mutex){+.+.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5666 [inline]
       lock_acquire+0x1ab/0x580 kernel/locking/lockdep.c:5631
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x14f/0x1f50 kernel/locking/mutex.c:747
       snd_rawmidi_dev_disconnect+0x60/0x650 sound/core/rawmidi.c:2028
       __snd_device_disconnect.part.0+0x5b/0xc0 sound/core/device.c:63
       __snd_device_disconnect sound/core/device.c:61 [inline]
       snd_device_disconnect_all+0x9b/0xf0 sound/core/device.c:215
       snd_card_disconnect+0x306/0x740 sound/core/init.c:530
       snd_card_free_when_closed+0x13/0x50 sound/core/init.c:622
       f_midi_unbind+0x60/0x120 drivers/usb/gadget/function/f_midi.c:1335
       purge_configs_funcs+0x281/0x4e0 drivers/usb/gadget/configfs.c:1274
       configfs_composite_bind+0xbd3/0x11c0 drivers/usb/gadget/configfs.c:1426
       gadget_bind_driver+0x285/0x860 drivers/usb/gadget/udc/core.c:1495
       call_driver_probe drivers/base/dd.c:560 [inline]
       really_probe+0x249/0xa90 drivers/base/dd.c:639
       __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
       driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
       __driver_attach+0x1e6/0x420 drivers/base/dd.c:1190
       bus_for_each_dev+0x147/0x1d0 drivers/base/bus.c:301
       bus_add_driver+0x4c9/0x640 drivers/base/bus.c:618
       driver_register+0x1c4/0x330 drivers/base/driver.c:240
       usb_gadget_register_driver_owner+0xfb/0x1e0
drivers/usb/gadget/udc/core.c:1560
       gadget_dev_desc_UDC_store+0x184/0x220 drivers/usb/gadget/configfs.c:299
       flush_write_buffer fs/configfs/file.c:207 [inline]
       configfs_write_iter+0x2ea/0x480 fs/configfs/file.c:229
       call_write_iter include/linux/fs.h:2187 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x9ca/0xd90 fs/read_write.c:578
       ksys_write+0x127/0x250 fs/read_write.c:631
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (register_mutex#5){+.+.}-{3:3}:
       check_prev_add+0x165/0x2520 kernel/locking/lockdep.c:3095
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2df7/0x5830 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5666 [inline]
       lock_acquire+0x1ab/0x580 kernel/locking/lockdep.c:5631
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x14f/0x1f50 kernel/locking/mutex.c:747
       snd_rawmidi_free+0x7a/0x190 sound/core/rawmidi.c:1902
       __snd_device_free+0x19f/0x230 sound/core/device.c:76
       snd_device_free_all+0xef/0x210 sound/core/device.c:233
       snd_card_do_free sound/core/init.c:591 [inline]
       release_card_device+0x70/0x200 sound/core/init.c:145
       device_release+0x9f/0x240 drivers/base/core.c:2330
       kobject_cleanup lib/kobject.c:673 [inline]
       kobject_release lib/kobject.c:704 [inline]
       kref_put include/linux/kref.h:65 [inline]
       kobject_put+0x1be/0x4c0 lib/kobject.c:721
       put_device+0x1b/0x30 drivers/base/core.c:3624
       klist_next+0x254/0x4a0 lib/klist.c:404
       class_dev_iter_next+0x83/0xc0 drivers/base/class.c:311
       class_find_device+0x144/0x220 drivers/base/class.c:415
       class_find_device_by_devt include/linux/device/class.h:167 [inline]
       device_destroy+0x79/0xd0 drivers/base/core.c:4299
       sound_remove_unit+0x13f/0x1f0 sound/sound_core.c:305
       snd_unregister_oss_device+0xe8/0x290 sound/core/sound_oss.c:165
       snd_mixer_oss_notify_handler+0x282/0x360 sound/core/oss/mixer_oss.c:1417
       snd_card_disconnect+0x2f9/0x740 sound/core/init.c:526
       usb_audio_disconnect+0x335/0x800 sound/usb/card.c:930
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

other info that might help us debug this:

Chain exists of:
  register_mutex#5 --> &rmidi->open_mutex --> sound_oss_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sound_oss_mutex);
                               lock(&rmidi->open_mutex);
                               lock(sound_oss_mutex);
  lock(register_mutex#5);

 *** DEADLOCK ***

7 locks held by kworker/1:7/10868:
 #0: ffff88801452b938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801452b938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801452b938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
atomic_long_set include/linux/atomic/atomic-instrumented.h:1280
[inline]
 #0: ffff88801452b938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff88801452b938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff88801452b938 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at:
process_one_work+0x8b0/0x1650 kernel/workqueue.c:2260
 #1: ffffc90018367db0 ((work_completion)(&hub->events)){+.+.}-{0:0},
at: process_one_work+0x8e4/0x1650 kernel/workqueue.c:2264
 #2: ffff8880164d2190 (&dev->mutex){....}-{3:3}, at: device_lock
include/linux/device.h:835 [inline]
 #2: ffff8880164d2190 (&dev->mutex){....}-{3:3}, at:
hub_event+0x1bc/0x4260 drivers/usb/core/hub.c:5681
 #3: ffff888047497190 (&dev->mutex){....}-{3:3}, at: device_lock
include/linux/device.h:835 [inline]
 #3: ffff888047497190 (&dev->mutex){....}-{3:3}, at:
usb_disconnect+0x95/0x860 drivers/usb/core/hub.c:2226
 #4: ffff888047493118 (&dev->mutex){....}-{3:3}, at:
device_release_driver_internal+0x23/0x360 drivers/base/dd.c:1272
 #5: ffffffff8e2e7f68 (register_mutex#7){+.+.}-{3:3}, at:
usb_audio_disconnect+0xe3/0x800 sound/usb/card.c:919
 #6: ffffffff8e274048 (sound_oss_mutex){+.+.}-{3:3}, at:
snd_unregister_oss_device+0x97/0x290 sound/core/sound_oss.c:159

stack backtrace:
CPU: 1 PID: 10868 Comm: kworker/1:7 Not tainted 6.0.0-rc4+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x26b/0x310 kernel/locking/lockdep.c:2175
 check_prev_add+0x165/0x2520 kernel/locking/lockdep.c:3095
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x2df7/0x5830 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x580 kernel/locking/lockdep.c:5631
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x14f/0x1f50 kernel/locking/mutex.c:747
 snd_rawmidi_free+0x7a/0x190 sound/core/rawmidi.c:1902
 __snd_device_free+0x19f/0x230 sound/core/device.c:76
 snd_device_free_all+0xef/0x210 sound/core/device.c:233
 snd_card_do_free sound/core/init.c:591 [inline]
 release_card_device+0x70/0x200 sound/core/init.c:145
 device_release+0x9f/0x240 drivers/base/core.c:2330
 kobject_cleanup lib/kobject.c:673 [inline]
 kobject_release lib/kobject.c:704 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x1be/0x4c0 lib/kobject.c:721
 put_device+0x1b/0x30 drivers/base/core.c:3624
 klist_next+0x254/0x4a0 lib/klist.c:404
 class_dev_iter_next+0x83/0xc0 drivers/base/class.c:311
 class_find_device+0x144/0x220 drivers/base/class.c:415
 class_find_device_by_devt include/linux/device/class.h:167 [inline]
 device_destroy+0x79/0xd0 drivers/base/core.c:4299
 sound_remove_unit+0x13f/0x1f0 sound/sound_core.c:305
 snd_unregister_oss_device+0xe8/0x290 sound/core/sound_oss.c:165
 snd_mixer_oss_notify_handler+0x282/0x360 sound/core/oss/mixer_oss.c:1417
 snd_card_disconnect+0x2f9/0x740 sound/core/init.c:526
 usb_audio_disconnect+0x335/0x800 sound/usb/card.c:930
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
 </TASK>
