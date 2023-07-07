Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D959774B46F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 17:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjGGPhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 11:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjGGPhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 11:37:04 -0400
Received: from mail-pf1-f208.google.com (mail-pf1-f208.google.com [209.85.210.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C5D1BF4
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 08:36:59 -0700 (PDT)
Received: by mail-pf1-f208.google.com with SMTP id d2e1a72fcca58-67c2f6fb908so2580516b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 08:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688744219; x=1691336219;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WMSWFp8IqdtzjWGGpav6HqhyMzA5tdJU+4Q1rqmerQs=;
        b=Ctom3ZDvwksU/jOhtMuIiBwVZvizVFwdeS9nO2zV+PM4oYr8Ixs//g2NApszjgtsPa
         bn1HlIufk0K8ga2LEcHt940Bv11477/cd8TDAQQBMMGe886KW/z5H02TbHhmHtCcMVee
         XEehNbyxq0nX8/BP347O4vlsfh+s06rWbGBp7RYawkIOIjK40v1P7cv2ts1aOCaH2Btr
         fhcBiGZEn2lY43W0sGsHZk4l/OjOJk3MY5JQAVAMgm2mKDDm8zT9ShriBTWbGWseSX9m
         4B5u2vRVu9oa9QI5BCTKn9vqzqdCUSwem3KtadefcclUMBopzJEAdk8yFDGjM5y6OBkV
         8PAw==
X-Gm-Message-State: ABy/qLblu4ERlPyclfsJkx0mjcYOFpKz2XJGy4CgakLVWCvH7f9k3AJz
        +I6m4FewXILbiLbdIuEfPH2jjQSEYIkB8gi6n6l8pcgug4e+
X-Google-Smtp-Source: APBJJlFDGMhIUSGN7txEvyL05VyRA+rXUexFGCmLSay5OiA5H71zqlUvE6PBri+pKGRgAyPTXv1Ao8OKaLLd1976xL/F3aDXXtmc
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:3902:b0:67d:41a8:3e19 with SMTP id
 fh2-20020a056a00390200b0067d41a83e19mr7579784pfb.3.1688744219328; Fri, 07 Jul
 2023 08:36:59 -0700 (PDT)
Date:   Fri, 07 Jul 2023 08:36:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004f463f05ffe76731@google.com>
Subject: [syzbot] [media?] [usb?] WARNING in smsusb_start_streaming
From:   syzbot <syzbot+a7c205f9c1168e2f1dcc@syzkaller.appspotmail.com>
To:     duoming@zju.edu.cn, hverkuil-cisco@xs4all.nl,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-usb@vger.kernel.org, mchehab@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d528014517f2 Revert ".gitignore: ignore *.cover and *.mbx"
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10953308a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d576750da57ebbb5
dashboard link: https://syzkaller.appspot.com/bug?extid=a7c205f9c1168e2f1dcc
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17dd0d94a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15ea4fa0a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/25611d498c84/disk-d5280145.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6cd9d0d55a7a/vmlinux-d5280145.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f0627705b54b/bzImage-d5280145.xz

The issue was bisected to:

commit ebad8e731c1c06adf04621d6fd327b860c0861b5
Author: Duoming Zhou <duoming@zju.edu.cn>
Date:   Mon Jan 23 02:04:38 2023 +0000

    media: usb: siano: Fix use after free bugs caused by do_submit_urb

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=172533e8a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14a533e8a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=10a533e8a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a7c205f9c1168e2f1dcc@syzkaller.appspotmail.com
Fixes: ebad8e731c1c ("media: usb: siano: Fix use after free bugs caused by do_submit_urb")

smsusb:smsusb_probe: board id=7, interface number 55
smsusb:smsusb_probe: board id=7, interface number 147
smsusb:smsusb_probe: board id=7, interface number 0
smsusb:siano_media_device_register: media controller created
smsusb:smsusb_start_streaming: smsusb_submit_urb(...) failed
------------[ cut here ]------------
WARNING: CPU: 0 PID: 917 at kernel/workqueue.c:3379 __flush_work+0x946/0xb60 kernel/workqueue.c:3379
Modules linked in:
CPU: 0 PID: 917 Comm: kworker/0:2 Not tainted 6.4.0-syzkaller-11478-gd528014517f2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: usb_hub_wq hub_event
RIP: 0010:__flush_work+0x946/0xb60 kernel/workqueue.c:3379
Code: 00 48 c7 c6 2b 36 54 81 48 c7 c7 00 27 9a 8c e8 c0 09 12 00 e9 6f fc ff ff e8 16 a9 30 00 0f 0b e9 63 fc ff ff e8 0a a9 30 00 <0f> 0b 45 31 ed e9 54 fc ff ff e8 6b d8 83 00 e9 3e fb ff ff e8 f1
RSP: 0018:ffffc900050aebf0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888071a480e8 RCX: 0000000000000000
RDX: ffff88801fc05940 RSI: ffffffff81543666 RDI: 0000000000000001
RBP: ffffc900050aed88 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 1ffffffff21ed137 R12: ffff888071a480e8
R13: 0000000000000001 R14: 0000000000000001 R15: ffff888071a48100
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564a82410ac8 CR3: 000000002c52c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __cancel_work_timer+0x3f9/0x570 kernel/workqueue.c:3473
 smsusb_stop_streaming drivers/media/usb/siano/smsusb.c:182 [inline]
 smsusb_start_streaming+0x33c/0x650 drivers/media/usb/siano/smsusb.c:199
 smsusb_init_device+0x7f7/0xd20 drivers/media/usb/siano/smsusb.c:476
 smsusb_probe+0x5b9/0x10b0 drivers/media/usb/siano/smsusb.c:567
 usb_probe_interface+0x30f/0x960 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4b0 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:828
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:956
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x112d/0x1a40 drivers/base/core.c:3625
 usb_set_configuration+0x1196/0x1bc0 drivers/usb/core/message.c:2211
 usb_generic_driver_probe+0xcf/0x130 drivers/usb/core/generic.c:238
 usb_probe_device+0xd8/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:579 [inline]
 really_probe+0x240/0xca0 drivers/base/dd.c:658
 __driver_probe_device+0x1df/0x4b0 drivers/base/dd.c:798
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:828
 __device_attach_driver+0x1d4/0x2e0 drivers/base/dd.c:956
 bus_for_each_drv+0x149/0x1d0 drivers/base/bus.c:457
 __device_attach+0x1e4/0x4b0 drivers/base/dd.c:1028
 bus_probe_device+0x17c/0x1c0 drivers/base/bus.c:532
 device_add+0x112d/0x1a40 drivers/base/core.c:3625
 usb_new_device+0xcb2/0x19d0 drivers/usb/core/hub.c:2590
 hub_port_connect drivers/usb/core/hub.c:5422 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5566 [inline]
 port_event drivers/usb/core/hub.c:5726 [inline]
 hub_event+0x2d9e/0x4e40 drivers/usb/core/hub.c:5808
 process_one_work+0xa34/0x16f0 kernel/workqueue.c:2597
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2748
 kthread+0x344/0x440 kernel/kthread.c:389
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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
