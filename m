Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5C06F33AE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 18:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjEAQx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 12:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjEAQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 12:53:54 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDCE170C
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 09:53:45 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7636c775952so163032239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 09:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682960025; x=1685552025;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PVDSaAqcDVoccriZfuF9RqHckXIDHP12OaD+u5OhWos=;
        b=Rr7rcSkpBJctnuXkNaW+C5WFaVkZKAsHIAle6GcBa/j83g36wYNuYr7y0ucd0neEOX
         5wlZSeB97oOdRntusLSZ0FtPL4Ool7Aw07KN0CIa2PiUhVPqjUj9El9T5rNQsX2Ibi0f
         qqkLr7iyLy8xTb6bNzbpi24j4gn2mafga5t5+GDh1TOS97u3el/QlQPesoAjGRKt/+Q2
         h3ut9HWPLkA6sWN5AfLXSaIjLc99ENi0mEZBqHaC6cNusHMP7e5dmqQ6HI/9sVlIZkL3
         dSPZfwWaN/bmQnQS9jyvH3vC1/UAdUdlU/4Q0EvNtqf0oXdz2cpuGoknYBAgaL0+Cza/
         74qA==
X-Gm-Message-State: AC+VfDygikEfqJgnmseaxqB2/SN7SDONdKyBSvB42Jld2PEtI8TjUEh6
        bS+mjr80ACSdptuns0YWB4C3EEKJ+Fs3f5y2NJhKdaYTvxIS
X-Google-Smtp-Source: ACHHUZ5zC9Ja6Vo7HutDa0uUBKfakvCBScmraMBG7EcjiKYDc9sH58azPF9GcxfEqUxAakVtfDY1IR2auAfJFAIKjDCujWWRV9U6
MIME-Version: 1.0
X-Received: by 2002:a5d:958c:0:b0:74f:d943:f1cf with SMTP id
 a12-20020a5d958c000000b0074fd943f1cfmr6319037ioo.3.1682960025074; Mon, 01 May
 2023 09:53:45 -0700 (PDT)
Date:   Mon, 01 May 2023 09:53:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077472605faa4aad5@google.com>
Subject: [syzbot] [usb?] memory leak in class_create
From:   syzbot <syzbot+e7afd76ad060fa0d2605@syzkaller.appspotmail.com>
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

HEAD commit:    22b8cc3e78f5 Merge tag 'x86_mm_for_6.4' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16fc7958280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5046ebeca744dd40
dashboard link: https://syzkaller.appspot.com/bug?extid=e7afd76ad060fa0d2605
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1599a2b4280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14eb395fc80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3ad2088c196b/disk-22b8cc3e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/61919a5b89c6/vmlinux-22b8cc3e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a7adb5503ac8/bzImage-22b8cc3e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7afd76ad060fa0d2605@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810af67080 (size 96):
  comm "kworker/0:2", pid 4402, jiffies 4294950769 (age 14.190s)
  hex dump (first 32 bytes):
    bf 03 9b 85 ff ff ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff81544e14>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff82b65445>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff82b65445>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff82b65445>] class_create+0x25/0x90 drivers/base/class.c:261
    [<ffffffff831f7a80>] init_usb_class drivers/usb/core/file.c:91 [inline]
    [<ffffffff831f7a80>] usb_register_dev+0x290/0x3d0 drivers/usb/core/file.c:179
    [<ffffffff832cffc4>] usblp_probe+0x4e4/0x750 drivers/usb/class/usblp.c:1208
    [<ffffffff831f39a9>] usb_probe_interface+0x179/0x3c0 drivers/usb/core/driver.c:396
    [<ffffffff82b62d7d>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82b62d7d>] really_probe+0x12d/0x430 drivers/base/dd.c:658
    [<ffffffff82b63141>] __driver_probe_device+0xc1/0x1a0 drivers/base/dd.c:800
    [<ffffffff82b6324a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:830
    [<ffffffff82b6343b>] __device_attach_driver+0xfb/0x150 drivers/base/dd.c:958
    [<ffffffff82b60191>] bus_for_each_drv+0xc1/0x110 drivers/base/bus.c:457
    [<ffffffff82b63962>] __device_attach+0x102/0x2a0 drivers/base/dd.c:1030
    [<ffffffff82b618fa>] bus_probe_device+0xca/0xd0 drivers/base/bus.c:532
    [<ffffffff82b5def3>] device_add+0x993/0xc60 drivers/base/core.c:3625
    [<ffffffff831f0a89>] usb_set_configuration+0x9a9/0xc90 drivers/usb/core/message.c:2211
    [<ffffffff832033a1>] usb_generic_driver_probe+0xa1/0x100 drivers/usb/core/generic.c:238
    [<ffffffff831f3080>] usb_probe_device+0x60/0x140 drivers/usb/core/driver.c:293

BUG: memory leak
unreferenced object 0xffff8881051f1a00 (size 512):
  comm "kworker/0:2", pid 4402, jiffies 4294950769 (age 14.190s)
  hex dump (first 32 bytes):
    00 1a 1f 05 81 88 ff ff 00 1a 1f 05 81 88 ff ff  ................
    00 00 00 00 00 00 00 00 bf 03 9b 85 ff ff ff ff  ................
  backtrace:
    [<ffffffff81544e14>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1057
    [<ffffffff82b65308>] kmalloc include/linux/slab.h:559 [inline]
    [<ffffffff82b65308>] kzalloc include/linux/slab.h:680 [inline]
    [<ffffffff82b65308>] class_register+0x28/0x140 drivers/base/class.c:186
    [<ffffffff82b65467>] class_create+0x47/0x90 drivers/base/class.c:270
    [<ffffffff831f7a80>] init_usb_class drivers/usb/core/file.c:91 [inline]
    [<ffffffff831f7a80>] usb_register_dev+0x290/0x3d0 drivers/usb/core/file.c:179
    [<ffffffff832cffc4>] usblp_probe+0x4e4/0x750 drivers/usb/class/usblp.c:1208
    [<ffffffff831f39a9>] usb_probe_interface+0x179/0x3c0 drivers/usb/core/driver.c:396
    [<ffffffff82b62d7d>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82b62d7d>] really_probe+0x12d/0x430 drivers/base/dd.c:658
    [<ffffffff82b63141>] __driver_probe_device+0xc1/0x1a0 drivers/base/dd.c:800
    [<ffffffff82b6324a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:830
    [<ffffffff82b6343b>] __device_attach_driver+0xfb/0x150 drivers/base/dd.c:958
    [<ffffffff82b60191>] bus_for_each_drv+0xc1/0x110 drivers/base/bus.c:457
    [<ffffffff82b63962>] __device_attach+0x102/0x2a0 drivers/base/dd.c:1030
    [<ffffffff82b618fa>] bus_probe_device+0xca/0xd0 drivers/base/bus.c:532
    [<ffffffff82b5def3>] device_add+0x993/0xc60 drivers/base/core.c:3625
    [<ffffffff831f0a89>] usb_set_configuration+0x9a9/0xc90 drivers/usb/core/message.c:2211
    [<ffffffff832033a1>] usb_generic_driver_probe+0xa1/0x100 drivers/usb/core/generic.c:238



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
