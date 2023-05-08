Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EB56F9E3F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 05:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbjEHD34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 23:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEHD3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 23:29:53 -0400
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DB5A4
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 20:29:51 -0700 (PDT)
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-33539445684so35856285ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 20:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683516590; x=1686108590;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EIIWjHjPkybLwfLbVgxz6cqw/F5xYKjkBJFflkScd1c=;
        b=idbuItgPFrGxH7tVkAyeLrfvZygKASGXgCu6U9dp2OHzcFg6fHih7YzGvsYjeaMBc0
         m3qJZjmnQmJV1Wm/U0OOF6GAcd0Sh1P1eMKBVsTR6616UfZWlwP0zBDjYg3Ky1xz1yw1
         dKP3tlk+3zF8reyhb7qdah08IdqwoHLRlIZ8exbOYvOHiLynNZfc4ZByvgYsE1Dp2ytX
         dNJM6QEXmuGLL6l8+7YpcXKa36sm2mZsjVn22FoDU09sV2sWAHTZjQUtT5pTVr1tlCP3
         K7GjacHE2hn739d4Ksfi2SejEMGHe9NwdUZdCo4OkUKlI09L2SJiijMV2j0jBwUXXGtL
         pGFA==
X-Gm-Message-State: AC+VfDy+qoeNr1JTKcBsvkQsVNT0YhGl4H3BYKiFrCYcFWWZLlSXZbf2
        eyfFDkWV8frpRSbPw4aF64Tvg3tgzEVP2BG4zRUEdUIzn1Qn
X-Google-Smtp-Source: ACHHUZ7Yu0sBuUDWE49tOgau9MDVb48MDPdl2YmGtntp88/0G+TiQIYPT8kqHs31KF824EofJ0CE/bnTa323dnEAzU/N0gdwCeS3
MIME-Version: 1.0
X-Received: by 2002:a92:d5c8:0:b0:335:252b:4fc6 with SMTP id
 d8-20020a92d5c8000000b00335252b4fc6mr2434904ilq.2.1683516590442; Sun, 07 May
 2023 20:29:50 -0700 (PDT)
Date:   Sun, 07 May 2023 20:29:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058d15f05fb264013@google.com>
Subject: [syzbot] [usb?] memory leak in class_register
From:   syzbot <syzbot+8d1206181166fb03c3d0@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    89b7fd5d7f3c Merge tag 'pwm/for-6.4-rc1' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=174e9388280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a36b20e363d588f
dashboard link: https://syzkaller.appspot.com/bug?extid=8d1206181166fb03c3d0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1343c5c4280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13e7e5d2280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/85195bfc3f96/disk-89b7fd5d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d2f70e851a75/vmlinux-89b7fd5d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ab7d608fd71a/bzImage-89b7fd5d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d1206181166fb03c3d0@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888101354400 (size 512):
  comm "kworker/0:1", pid 8, jiffies 4294953824 (age 15.230s)
  hex dump (first 32 bytes):
    00 44 35 01 81 88 ff ff 00 44 35 01 81 88 ff ff  .D5......D5.....
    00 00 00 00 00 00 00 00 9d 2d 9b 85 ff ff ff ff  .........-......
  backtrace:
    [<ffffffff81545854>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff82b673e8>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff82b673e8>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff82b673e8>] class_register+0x28/0x140 drivers/base/class.c:186
    [<ffffffff82b67547>] class_create+0x47/0x90 drivers/base/class.c:270
    [<ffffffff831f9ad0>] init_usb_class drivers/usb/core/file.c:91 [inline]
    [<ffffffff831f9ad0>] usb_register_dev+0x290/0x3d0 drivers/usb/core/file.c:179
    [<ffffffff832d2014>] usblp_probe+0x4e4/0x750 drivers/usb/class/usblp.c:1208
    [<ffffffff831f59f9>] usb_probe_interface+0x179/0x3c0 drivers/usb/core/driver.c:396
    [<ffffffff82b64e5d>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82b64e5d>] really_probe+0x12d/0x430 drivers/base/dd.c:658
    [<ffffffff82b65221>] __driver_probe_device+0xc1/0x1a0 drivers/base/dd.c:800
    [<ffffffff82b6532a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:830
    [<ffffffff82b6551b>] __device_attach_driver+0xfb/0x150 drivers/base/dd.c:958
    [<ffffffff82b62271>] bus_for_each_drv+0xc1/0x110 drivers/base/bus.c:457
    [<ffffffff82b65a42>] __device_attach+0x102/0x2a0 drivers/base/dd.c:1030
    [<ffffffff82b639da>] bus_probe_device+0xca/0xd0 drivers/base/bus.c:532
    [<ffffffff82b5ffd3>] device_add+0x993/0xc60 drivers/base/core.c:3625
    [<ffffffff831f2ad9>] usb_set_configuration+0x9a9/0xc90 drivers/usb/core/message.c:2211
    [<ffffffff832053f1>] usb_generic_driver_probe+0xa1/0x100 drivers/usb/core/generic.c:238



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
