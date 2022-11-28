Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9701F63A60D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiK1KX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiK1KXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:23:51 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E4D1A81B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:23:47 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id a14-20020a6b660e000000b006bd37975cdfso5624225ioc.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NobAw+FI5C8ULf/Y4Ui7fBPT64uhSipLoJa02tBgo6w=;
        b=hwY4sw0PdnSPH0D68KuqUm52dKB8Es2zPvyPjgpZKEOl4e/jJQAArCPAWt4tnn5OoU
         zCNzUzlmm0yknL6AEJDSyV8rSpBn9DwGoLn9E3yOEMy5z2UziRgsnsZvImcDkW30+vVv
         ufeA3hGttCjC7jvu56DL5XjNlzD3fxwq9w42w+dtuTyX9cVWhAgOJjSsJCSOjmAaDc7K
         SH8e94u8QgrrVDuVwcOMzb7GOw5c0rUZy1aQT0Q6pUnKjyq/vkG0IbxX0EmlN+vhJGAr
         yZnuDScgcwLb9yQVs544VBzBZCZyfQK6ssWmQmG3xMLAAqfGl+dSMV/r2nNN+FsEIYLD
         um6w==
X-Gm-Message-State: ANoB5pk+ncQ7oU+p9TgoiRha22kWm4I6M99Tunq6uMA0BXiJphbcXeeo
        yMv4YxO1clII4efgS4Pt/2eLF7shBztmQSg+UOJWQWIdAKZi
X-Google-Smtp-Source: AA0mqf4q82h5u4p7M9JpZmf8yostPPR0v00Z1sWBDTOj2UMlZRBmJ58XVJx36gq0C2LTe7Y34B4QfwYkzwhvSooCAYj0epoKt1QT
MIME-Version: 1.0
X-Received: by 2002:a02:7409:0:b0:375:4727:8625 with SMTP id
 o9-20020a027409000000b0037547278625mr14738013jac.300.1669631027186; Mon, 28
 Nov 2022 02:23:47 -0800 (PST)
Date:   Mon, 28 Nov 2022 02:23:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000048102d05ee8544e5@google.com>
Subject: [syzbot] linux-next boot error: WARNING: refcount bug in dvb_register_device
From:   syzbot <syzbot+fce48a3dd3368645bd6c@syzkaller.appspotmail.com>
To:     colin.i.king@gmail.com, keitasuzuki.park@sslab.ics.keio.ac.jp,
        linma@zju.edu.cn, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-next@vger.kernel.org,
        mchehab@kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    15f2f20ccbf2 Add linux-next specific files for 20221128
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=114a14ad880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=50be0d6c9da3be9d
dashboard link: https://syzkaller.appspot.com/bug?extid=fce48a3dd3368645bd6c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0bcd04c8e812/disk-15f2f20c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/23f3cf3f818e/vmlinux-15f2f20c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9111cdf112e7/bzImage-15f2f20c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fce48a3dd3368645bd6c@syzkaller.appspotmail.com

usbcore: registered new interface driver sonixj
usbcore: registered new interface driver spca500
usbcore: registered new interface driver spca501
usbcore: registered new interface driver spca505
usbcore: registered new interface driver spca506
usbcore: registered new interface driver spca508
usbcore: registered new interface driver spca561
usbcore: registered new interface driver spca1528
usbcore: registered new interface driver sq905
usbcore: registered new interface driver sq905c
usbcore: registered new interface driver sq930x
usbcore: registered new interface driver sunplus
usbcore: registered new interface driver stk014
usbcore: registered new interface driver stk1135
usbcore: registered new interface driver stv0680
usbcore: registered new interface driver t613
usbcore: registered new interface driver gspca_topro
usbcore: registered new interface driver touptek
usbcore: registered new interface driver tv8532
usbcore: registered new interface driver vc032x
usbcore: registered new interface driver vicam
usbcore: registered new interface driver xirlink-cit
usbcore: registered new interface driver gspca_zc3xx
usbcore: registered new interface driver ALi m5602
usbcore: registered new interface driver STV06xx
usbcore: registered new interface driver gspca_gl860
usbcore: registered new interface driver hackrf
usbcore: registered new interface driver msi2500
usbcore: registered new interface driver Philips webcam
usbcore: registered new interface driver uvcvideo
au0828: au0828 driver loaded
usbcore: registered new interface driver au0828
usbcore: registered new interface driver cx231xx
usbcore: registered new interface driver em28xx
em28xx: Registered (Em28xx v4l2 Extension) extension
em28xx: Registered (Em28xx Audio Extension) extension
em28xx: Registered (Em28xx dvb Extension) extension
em28xx: Registered (Em28xx Input Extension) extension
usbcore: registered new interface driver go7007
usbcore: registered new interface driver go7007-loader
usbcore: registered new interface driver hdpvr
usbcore: registered new interface driver pvrusb2
pvrusb2: V4L in-tree version:Hauppauge WinTV-PVR-USB2 MPEG2 Encoder/Tuner
pvrusb2: Debug mask is 31 (0x1f)
usbcore: registered new interface driver stk1160
usbcore: registered new interface driver usbtv
dvbdev: DVB: registering new adapter (dvb_vidtv_bridge)
i2c i2c-0: DVB: registering adapter 0 frontend 0 (Dummy demod for DVB-T/T2/C/S/S2)...
------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 1 at lib/refcount.c:25 refcount_warn_saturate+0x17c/0x1f0 lib/refcount.c:25
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc6-next-20221128-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:refcount_warn_saturate+0x17c/0x1f0 lib/refcount.c:25
Code: 0a 31 ff 89 de e8 64 54 75 fd 84 db 0f 85 2e ff ff ff e8 e7 57 75 fd 48 c7 c7 60 4c a6 8a c6 05 bf 49 51 0a 01 e8 5c 83 b4 05 <0f> 0b e9 0f ff ff ff e8 c8 57 75 fd 0f b6 1d a9 49 51 0a 31 ff 89
RSP: 0000:ffffc900000678d0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88813ff58000 RSI: ffffffff81660e7c RDI: fffff5200000cf0c
RBP: ffff888022a45010 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88823ffff000 CR3: 000000000c48e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:199 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 kref_get include/linux/kref.h:45 [inline]
 dvb_device_get drivers/media/dvb-core/dvbdev.c:585 [inline]
 dvb_register_device+0xe83/0x16e0 drivers/media/dvb-core/dvbdev.c:517
 dvb_register_frontend+0x58f/0x8c0 drivers/media/dvb-core/dvb_frontend.c:3044
 vidtv_bridge_dvb_init drivers/media/test-drivers/vidtv/vidtv_bridge.c:430 [inline]
 vidtv_bridge_probe+0x450/0x9f0 drivers/media/test-drivers/vidtv/vidtv_bridge.c:502
 platform_probe+0x100/0x1f0 drivers/base/platform.c:1400
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __driver_attach+0x271/0x570 drivers/base/dd.c:1194
 bus_for_each_dev+0x14b/0x1d0 drivers/base/bus.c:301
 bus_add_driver+0x4cd/0x640 drivers/base/bus.c:618
 driver_register+0x224/0x3a0 drivers/base/driver.c:246
 vidtv_bridge_init+0x3b/0x68 drivers/media/test-drivers/vidtv/vidtv_bridge.c:594
 do_one_initcall+0x141/0x790 init/main.c:1306
 do_initcall_level init/main.c:1379 [inline]
 do_initcalls init/main.c:1395 [inline]
 do_basic_setup init/main.c:1414 [inline]
 kernel_init_freeable+0x6f9/0x782 init/main.c:1634
 kernel_init+0x1e/0x1d0 init/main.c:1522
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
