Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DA3750BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjGLPFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjGLPFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:05:09 -0400
Received: from mail-oa1-f78.google.com (mail-oa1-f78.google.com [209.85.160.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CE21BDA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:05:05 -0700 (PDT)
Received: by mail-oa1-f78.google.com with SMTP id 586e51a60fabf-1b07f55975bso1488219fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:05:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689174304; x=1691766304;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m94uNVGmc3E0yBEqPvT1uJfZAtrvKe9dapVrNuSbByc=;
        b=a9MLlkToXCU0KNJa+mvtMZcqmBtVgtIFSSV2N/DPEGTjhn2ATPuuA5QHx+ZS78/c4M
         P1HK7Enu9to3TtV+osBjSo7a3X3yRxwbzq2nniUS2nXV6H0Hz9RKlBtxULMebboFPS6W
         L7dN78qXx1LTdOTXUPU+tN0tCvvx7FM6OZbHjQ+nGNOVUbv9Z1u7Kb6Lld3BBRZT8U1d
         jxYJEqxvYTOmC+PR3Bh2hbUqiOaYVWLzeC73xLel0jF6MRSSirypwaSgP2wFDasPbk9u
         1HoIAIVbhpbCscd/8DtT2EdobmcBW5axrN91PVLMCUMP5XQgKuOrL0HVP4A3RaeRBZeK
         X/SA==
X-Gm-Message-State: ABy/qLb/MyaReItPZS8xCa1NKFGGVmiBu0U4MWjxANRw1JHmHLBhYQSH
        eogVfxOxAE4jx/J2R89A5+F3U0oiHXT9KiSK5+NJGErm4pMK
X-Google-Smtp-Source: APBJJlE6T4mKAFfXv9J5kh533uZw7yg1Mbm6bvYZirhGaKSi+0a2yNsJa1xutVhKpvYIqxMqZPLHddPeicgsgBG5OrRP2aA+x8U5
MIME-Version: 1.0
X-Received: by 2002:a05:6870:ee16:b0:1b0:4e46:7f13 with SMTP id
 ga22-20020a056870ee1600b001b04e467f13mr3474579oab.2.1689174304068; Wed, 12
 Jul 2023 08:05:04 -0700 (PDT)
Date:   Wed, 12 Jul 2023 08:05:04 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005b9d6e06004b8aa0@google.com>
Subject: [syzbot] [staging?] [usb?] memory leak in _r8712_init_xmit_priv
From:   syzbot <syzbot+cf71097ffb6755df8251@syzkaller.appspotmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
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

HEAD commit:    8689f4f2ea56 Merge tag 'mmc-v6.5-2' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ac3fa0a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=832b404e095b70c0
dashboard link: https://syzkaller.appspot.com/bug?extid=cf71097ffb6755df8251
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16f26d02a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14482e54a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/31f0c2383fbf/disk-8689f4f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/98c44efd609e/vmlinux-8689f4f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bbd75026af9a/bzImage-8689f4f2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf71097ffb6755df8251@syzkaller.appspotmail.com

executing program
BUG: memory leak
unreferenced object 0xffff88810a4db000 (size 4096):
  comm "kworker/0:3", pid 4752, jiffies 4294941496 (age 19.480s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8154bfa4>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
    [<ffffffff83c3bf41>] kmalloc include/linux/slab.h:582 [inline]
    [<ffffffff83c3bf41>] _r8712_init_xmit_priv+0x2b1/0x660 drivers/staging/rtl8712/rtl871x_xmit.c:131
    [<ffffffff83c36b86>] r8712_init_drv_sw+0xc6/0x260 drivers/staging/rtl8712/os_intfs.c:311
    [<ffffffff83c35766>] r871xu_drv_init+0x1f6/0x9d0 drivers/staging/rtl8712/usb_intf.c:386
    [<ffffffff83237329>] usb_probe_interface+0x179/0x3c0 drivers/usb/core/driver.c:396
    [<ffffffff82ba039d>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82ba039d>] really_probe+0x12d/0x430 drivers/base/dd.c:658
    [<ffffffff82ba0761>] __driver_probe_device+0xc1/0x1a0 drivers/base/dd.c:798
    [<ffffffff82ba086a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:828
    [<ffffffff82ba0a5b>] __device_attach_driver+0xfb/0x150 drivers/base/dd.c:956
    [<ffffffff82b9d7b1>] bus_for_each_drv+0xc1/0x110 drivers/base/bus.c:457
    [<ffffffff82ba0f82>] __device_attach+0x102/0x2a0 drivers/base/dd.c:1028
    [<ffffffff82b9ef1a>] bus_probe_device+0xca/0xd0 drivers/base/bus.c:532
    [<ffffffff82b9b513>] device_add+0x993/0xc60 drivers/base/core.c:3625
    [<ffffffff83234409>] usb_set_configuration+0x9a9/0xc90 drivers/usb/core/message.c:2211
    [<ffffffff83246ed1>] usb_generic_driver_probe+0xa1/0x100 drivers/usb/core/generic.c:238
    [<ffffffff83236a00>] usb_probe_device+0x60/0x140 drivers/usb/core/driver.c:293

BUG: memory leak
unreferenced object 0xffff88810a4de000 (size 4096):
  comm "kworker/0:3", pid 4752, jiffies 4294941496 (age 19.480s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8154bfa4>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
    [<ffffffff83c3bf41>] kmalloc include/linux/slab.h:582 [inline]
    [<ffffffff83c3bf41>] _r8712_init_xmit_priv+0x2b1/0x660 drivers/staging/rtl8712/rtl871x_xmit.c:131
    [<ffffffff83c36b86>] r8712_init_drv_sw+0xc6/0x260 drivers/staging/rtl8712/os_intfs.c:311
    [<ffffffff83c35766>] r871xu_drv_init+0x1f6/0x9d0 drivers/staging/rtl8712/usb_intf.c:386
    [<ffffffff83237329>] usb_probe_interface+0x179/0x3c0 drivers/usb/core/driver.c:396
    [<ffffffff82ba039d>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82ba039d>] really_probe+0x12d/0x430 drivers/base/dd.c:658
    [<ffffffff82ba0761>] __driver_probe_device+0xc1/0x1a0 drivers/base/dd.c:798
    [<ffffffff82ba086a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:828
    [<ffffffff82ba0a5b>] __device_attach_driver+0xfb/0x150 drivers/base/dd.c:956
    [<ffffffff82b9d7b1>] bus_for_each_drv+0xc1/0x110 drivers/base/bus.c:457
    [<ffffffff82ba0f82>] __device_attach+0x102/0x2a0 drivers/base/dd.c:1028
    [<ffffffff82b9ef1a>] bus_probe_device+0xca/0xd0 drivers/base/bus.c:532
    [<ffffffff82b9b513>] device_add+0x993/0xc60 drivers/base/core.c:3625
    [<ffffffff83234409>] usb_set_configuration+0x9a9/0xc90 drivers/usb/core/message.c:2211
    [<ffffffff83246ed1>] usb_generic_driver_probe+0xa1/0x100 drivers/usb/core/generic.c:238
    [<ffffffff83236a00>] usb_probe_device+0x60/0x140 drivers/usb/core/driver.c:293

BUG: memory leak
unreferenced object 0xffff88810a4d9000 (size 4096):
  comm "kworker/0:3", pid 4752, jiffies 4294941496 (age 19.480s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff8154bfa4>] kmalloc_trace+0x24/0x90 mm/slab_common.c:1076
    [<ffffffff83c3bf41>] kmalloc include/linux/slab.h:582 [inline]
    [<ffffffff83c3bf41>] _r8712_init_xmit_priv+0x2b1/0x660 drivers/staging/rtl8712/rtl871x_xmit.c:131
    [<ffffffff83c36b86>] r8712_init_drv_sw+0xc6/0x260 drivers/staging/rtl8712/os_intfs.c:311
    [<ffffffff83c35766>] r871xu_drv_init+0x1f6/0x9d0 drivers/staging/rtl8712/usb_intf.c:386
    [<ffffffff83237329>] usb_probe_interface+0x179/0x3c0 drivers/usb/core/driver.c:396
    [<ffffffff82ba039d>] call_driver_probe drivers/base/dd.c:579 [inline]
    [<ffffffff82ba039d>] really_probe+0x12d/0x430 drivers/base/dd.c:658
    [<ffffffff82ba0761>] __driver_probe_device+0xc1/0x1a0 drivers/base/dd.c:798
    [<ffffffff82ba086a>] driver_probe_device+0x2a/0x120 drivers/base/dd.c:828
    [<ffffffff82ba0a5b>] __device_attach_driver+0xfb/0x150 drivers/base/dd.c:956
    [<ffffffff82b9d7b1>] bus_for_each_drv+0xc1/0x110 drivers/base/bus.c:457
    [<ffffffff82ba0f82>] __device_attach+0x102/0x2a0 drivers/base/dd.c:1028
    [<ffffffff82b9ef1a>] bus_probe_device+0xca/0xd0 drivers/base/bus.c:532
    [<ffffffff82b9b513>] device_add+0x993/0xc60 drivers/base/core.c:3625
    [<ffffffff83234409>] usb_set_configuration+0x9a9/0xc90 drivers/usb/core/message.c:2211
    [<ffffffff83246ed1>] usb_generic_driver_probe+0xa1/0x100 drivers/usb/core/generic.c:238
    [<ffffffff83236a00>] usb_probe_device+0x60/0x140 drivers/usb/core/driver.c:293



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
