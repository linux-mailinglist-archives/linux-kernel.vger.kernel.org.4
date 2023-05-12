Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6CF6FFF01
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 04:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239664AbjELCiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 22:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjELCiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 22:38:05 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35F210C6
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 19:38:03 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-763997ab8cdso1383197839f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 19:38:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683859083; x=1686451083;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6mqvjxLoa4rHNVpGPVS/SfycGbbBXHvMhFDxNvAM1VQ=;
        b=MIxNJ0OHoDYmNqExjzxUMuJRhupJ1zfJqF7/nRkk1eZ7Vs+zkm89eqBh8rmQCi2cjc
         Gj5M/MHl0uCLyFY6amyWPEZwLHt3/FrlXC0HT678X1XbFzEydxgbglUwF3ab/Qgfl64e
         KfTZE5UofW0rDUf2xji0m88vMS5oL8lCTBqPfCVBRKZLij/Mq4xnqYbRtsdfUjcddCup
         5wZzIH2UDLX9u1eVZtgfutoe3er8AMFZnCQ6yl8PnLbAOkfVKKUgdmwj9VfkUUJjHZ+I
         XDyhW08sgj7sknMjqLxsgN5fb9vRZyanKzOsxt9rf0OZO5Pcy8KzPWxmekBqkywhU/84
         Yx5g==
X-Gm-Message-State: AC+VfDw6BLNoTIs1KsCEP3gdHZHJYVrPnhSwxM9GXNk39rI6ONx202V9
        sSVZFr/2emzh2ifZdJSUvA4pPzaUoj5y33t6UEleStCjvqRk
X-Google-Smtp-Source: ACHHUZ4tFCy7JYrOHet0uHWxvnRtWJLAiNMJcmBmqU0D4u9jven5x2H7hHQ4qqso/VJ72m1H70g4HtpOF/ZZK9sSeIL1mS0PLli2
MIME-Version: 1.0
X-Received: by 2002:a5d:960e:0:b0:76c:74d8:a2d7 with SMTP id
 w14-20020a5d960e000000b0076c74d8a2d7mr3194789iol.4.1683859083249; Thu, 11 May
 2023 19:38:03 -0700 (PDT)
Date:   Thu, 11 May 2023 19:38:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008254fa05fb75fedd@google.com>
Subject: [syzbot] [usb?] WARNING in amradio_set_mute/usb_submit_urb
From:   syzbot <syzbot+347ac4ce4eeebbe8a129@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    14f8db1c0f9a Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17275338280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a837a8ba7e88bb45
dashboard link: https://syzkaller.appspot.com/bug?extid=347ac4ce4eeebbe8a129
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14a13424280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15b7c75c280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad6ce516eed3/disk-14f8db1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f38c2cc7667/vmlinux-14f8db1c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d795115eee39/Image-14f8db1c.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+347ac4ce4eeebbe8a129@syzkaller.appspotmail.com

usb 1-1: New USB device found, idVendor=07ca, idProduct=b800, bcdDevice=b9.c5
usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 0 PID: 2016 at drivers/usb/core/urb.c:505 usb_submit_urb+0xa44/0x1588 drivers/usb/core/urb.c:504
Modules linked in:
CPU: 0 PID: 2016 Comm: kworker/0:2 Not tainted 6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Workqueue: usb_hub_wq hub_event
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : usb_submit_urb+0xa44/0x1588 drivers/usb/core/urb.c:504
lr : usb_submit_urb+0xa44/0x1588 drivers/usb/core/urb.c:504
sp : ffff800024726740
x29: ffff800024726780 x28: 0000000000000001 x27: ffff8000138dd388
x26: ffff0000c6ef2c00 x25: ffff0000d4abe000 x24: 0000000000000008
x23: ffff8000138e3c00 x22: dfff800000000000 x21: 0000000000000002
x20: 0000000000000c00 x19: ffff0000cf47bc00 x18: ffff800024725c60
x17: 0000000000000000 x16: ffff80001236e294 x15: 0000000000000002
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000001
x11: 0000000000000000 x10: 0000000000000000 x9 : b47e7648083a6600
x8 : b47e7648083a6600 x7 : 0000000000000001 x6 : 0000000000000001
x5 : ffff800024726038 x4 : ffff800015e4ccc0 x3 : ffff800008584230
x2 : 0000000000000001 x1 : 0000000100000000 x0 : 0000000000000000
Call trace:
 usb_submit_urb+0xa44/0x1588 drivers/usb/core/urb.c:504
 usb_start_wait_urb+0xec/0x414 drivers/usb/core/message.c:58
 usb_bulk_msg+0x2ec/0x3ec drivers/usb/core/message.c:387
 amradio_send_cmd drivers/media/radio/radio-mr800.c:150 [inline]
 amradio_set_mute+0x1d4/0x428 drivers/media/radio/radio-mr800.c:182
 usb_amradio_init drivers/media/radio/radio-mr800.c:411 [inline]
 usb_amradio_probe+0x388/0x6f8 drivers/media/radio/radio-mr800.c:554
 usb_probe_interface+0x500/0x984 drivers/usb/core/driver.c:396
 really_probe+0x394/0xa7c drivers/base/dd.c:631
 __driver_probe_device+0x1bc/0x3f8 drivers/base/dd.c:768
 driver_probe_device+0x78/0x330 drivers/base/dd.c:798
 __device_attach_driver+0x2a8/0x4f4 drivers/base/dd.c:926
 bus_for_each_drv+0x228/0x2bc drivers/base/bus.c:457
 __device_attach+0x2b4/0x434 drivers/base/dd.c:998
 device_initial_probe+0x24/0x34 drivers/base/dd.c:1047
 bus_probe_device+0x178/0x240 drivers/base/bus.c:532
 device_add+0xabc/0xf58 drivers/base/core.c:3589
 usb_set_configuration+0x15a4/0x1b1c drivers/usb/core/message.c:2171
 usb_generic_driver_probe+0x8c/0x148 drivers/usb/core/generic.c:238
 usb_probe_device+0x120/0x25c drivers/usb/core/driver.c:293
 really_probe+0x394/0xa7c drivers/base/dd.c:631
 __driver_probe_device+0x1bc/0x3f8 drivers/base/dd.c:768
 driver_probe_device+0x78/0x330 drivers/base/dd.c:798
 __device_attach_driver+0x2a8/0x4f4 drivers/base/dd.c:926
 bus_for_each_drv+0x228/0x2bc drivers/base/bus.c:457
 __device_attach+0x2b4/0x434 drivers/base/dd.c:998
 device_initial_probe+0x24/0x34 drivers/base/dd.c:1047
 bus_probe_device+0x178/0x240 drivers/base/bus.c:532
 device_add+0xabc/0xf58 drivers/base/core.c:3589
 usb_new_device+0x904/0x142c drivers/usb/core/hub.c:2575
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x25e4/0x474c drivers/usb/core/hub.c:5793
 process_one_work+0x788/0x12d4 kernel/workqueue.c:2390
 worker_thread+0x8e0/0xfe8 kernel/workqueue.c:2537
 kthread+0x250/0x2d8 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:870
irq event stamp: 156472
hardirqs last  enabled at (156471): [<ffff8000083416f0>] __up_console_sem+0x60/0xb4 kernel/printk/printk.c:345
hardirqs last disabled at (156472): [<ffff800012369e90>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (154114): [<ffff800008020c1c>] softirq_handle_end kernel/softirq.c:414 [inline]
softirqs last  enabled at (154114): [<ffff800008020c1c>] __do_softirq+0xac0/0xd54 kernel/softirq.c:600
softirqs last disabled at (154103): [<ffff80000802a658>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:80
---[ end trace 0000000000000000 ]---
 (null): radio-mr800 - initialization failed
radio-mr800: probe of 1-1:6.199 failed with error -71
usbhid 1-1:6.199: couldn't find an input interrupt endpoint


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
