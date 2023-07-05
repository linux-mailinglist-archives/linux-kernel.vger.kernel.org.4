Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB99748473
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 14:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjGEMx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 08:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbjGEMxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:53:55 -0400
Received: from mail-pl1-f205.google.com (mail-pl1-f205.google.com [209.85.214.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA6CDA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 05:53:54 -0700 (PDT)
Received: by mail-pl1-f205.google.com with SMTP id d9443c01a7336-1b8a4e947a1so8966065ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 05:53:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688561634; x=1691153634;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iq+8TpxEHiTomBKOeW+5QxZuXjnYw6FM69rru1Is8Mw=;
        b=SGgKMDPJcUJ52LhqbMpeBP72NYNuNM7LADk0IxndO9ZJIMUl1E+LE9j6dJjyGSSMQ8
         RJr3LCbgz90Gx4n4BEsLAoSTjaw7HK05RdPlMW2t8xWBCNzD89QbYLNeZh6d0UzeHhVS
         X4vapUKRFLLmjhv0VnOxR4tIKL6pa8VYTSzP8pS1DxKhnAu+b+l2aaTHrVioAnZnkoLM
         lbjQT4xWAbVkZbFnObycpa70Ot3Tj4v/321i68JZIFvnyaV/l6QJchgg4RZqEYNF77S1
         vaALFJwIFJWoDc/Pg8H8i2UR7Z/yjrO/I8WnKTt6soLUIvDDq6EP1LBoYHNaPEC3kzrm
         uWGA==
X-Gm-Message-State: ABy/qLbU9rEfDUc/BmzJ8geVVSjLLk/B6Qq1XFqFRVhHtoaxr+12ATaN
        LdjHMpD9hWMeMZy2KlHSOfVUAAaXC5cXKzjoJgbVhHFRSAW/
X-Google-Smtp-Source: APBJJlGe7KI03KEPVhWSwq2PoQUmcREB9w7Iy7ebAYt94qwy+CK/WLF8stcYUP8kEGM3yaGUu3VPoHMwmvEdR8SBUxjFqrPK+4m/
MIME-Version: 1.0
X-Received: by 2002:a17:903:2149:b0:1b6:a2e4:c8f8 with SMTP id
 s9-20020a170903214900b001b6a2e4c8f8mr1311886ple.2.1688561634307; Wed, 05 Jul
 2023 05:53:54 -0700 (PDT)
Date:   Wed, 05 Jul 2023 05:53:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064f39a05ffbce427@google.com>
Subject: [syzbot] [usb?] KMSAN: uninit-value in smsc95xx_eeprom_confirm_not_busy
From:   syzbot <syzbot+2c97a98a5ba9ea9c23bd@syzkaller.appspotmail.com>
To:     UNGLinuxDriver@microchip.com, davem@davemloft.net,
        edumazet@google.com, glider@google.com, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        steve.glendinning@shawell.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    257152fe29be string: use __builtin_memcpy() in strlcpy/str..
git tree:       https://github.com/google/kmsan.git master
console+strace: https://syzkaller.appspot.com/x/log.txt?x=156aa484a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d16a560a6e6eb097
dashboard link: https://syzkaller.appspot.com/bug?extid=2c97a98a5ba9ea9c23bd
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15433d14a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12528ac8a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8e2711366405/disk-257152fe.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cec15df7e485/vmlinux-257152fe.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f212903d5649/bzImage-257152fe.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2c97a98a5ba9ea9c23bd@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in smsc95xx_eeprom_confirm_not_busy+0x1eb/0x360 drivers/net/usb/smsc95xx.c:348
 smsc95xx_eeprom_confirm_not_busy+0x1eb/0x360 drivers/net/usb/smsc95xx.c:348
 smsc95xx_read_eeprom+0x59/0x670 drivers/net/usb/smsc95xx.c:367
 smsc95xx_init_mac_address drivers/net/usb/smsc95xx.c:816 [inline]
 smsc95xx_bind+0x6d8/0x22e0 drivers/net/usb/smsc95xx.c:1128
 usbnet_probe+0x1011/0x3f20 drivers/net/usb/usbnet.c:1750
 usb_probe_interface+0xc75/0x1210 drivers/usb/core/driver.c:396
 really_probe+0x506/0xf40 drivers/base/dd.c:658
 __driver_probe_device+0x2a7/0x5d0 drivers/base/dd.c:800
 driver_probe_device+0x72/0x7b0 drivers/base/dd.c:830
 __device_attach_driver+0x55a/0x8f0 drivers/base/dd.c:958
 bus_for_each_drv+0x3ff/0x620 drivers/base/bus.c:457
 __device_attach+0x3bd/0x640 drivers/base/dd.c:1030
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1079
 bus_probe_device+0x3d8/0x5a0 drivers/base/bus.c:532
 device_add+0x1b6a/0x24b0 drivers/base/core.c:3625
 usb_set_configuration+0x31c9/0x38c0 drivers/usb/core/message.c:2211
 usb_generic_driver_probe+0x109/0x2a0 drivers/usb/core/generic.c:238
 usb_probe_device+0x290/0x4a0 drivers/usb/core/driver.c:293
 really_probe+0x506/0xf40 drivers/base/dd.c:658
 __driver_probe_device+0x2a7/0x5d0 drivers/base/dd.c:800
 driver_probe_device+0x72/0x7b0 drivers/base/dd.c:830
 __device_attach_driver+0x55a/0x8f0 drivers/base/dd.c:958
 bus_for_each_drv+0x3ff/0x620 drivers/base/bus.c:457
 __device_attach+0x3bd/0x640 drivers/base/dd.c:1030
 device_initial_probe+0x32/0x40 drivers/base/dd.c:1079
 bus_probe_device+0x3d8/0x5a0 drivers/base/bus.c:532
 device_add+0x1b6a/0x24b0 drivers/base/core.c:3625
 usb_new_device+0x15f6/0x22f0 drivers/usb/core/hub.c:2575
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5551 [inline]
 port_event drivers/usb/core/hub.c:5711 [inline]
 hub_event+0x577b/0x78a0 drivers/usb/core/hub.c:5793
 process_one_work+0xb0d/0x1410 kernel/workqueue.c:2408
 worker_thread+0x107e/0x1d60 kernel/workqueue.c:2555
 kthread+0x3e8/0x540 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Local variable buf.i created at:
 smsc95xx_read_reg drivers/net/usb/smsc95xx.c:90 [inline]
 smsc95xx_eeprom_confirm_not_busy+0x92/0x360 drivers/net/usb/smsc95xx.c:342
 smsc95xx_read_eeprom+0x59/0x670 drivers/net/usb/smsc95xx.c:367

CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.4.0-syzkaller-g257152fe29be #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: usb_hub_wq hub_event
=====================================================


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
