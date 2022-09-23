Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDF05E7F88
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiIWQSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiIWQRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:17:48 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0D914B84D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:17:01 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id e15-20020a5d8acf000000b006a3ed059e49so206321iot.14
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=SoVzgYeuNxgCDucUevNr4lMmVOJ0okmsV+g8bu6loOI=;
        b=X3oDONxS99zAXc3N+zNZdxVusIH3AMkgCehig/WX1N8XJnsx22jB1GHQyX8IhkSy+1
         259lQH8su+xyYhsPsduOYsuL6Bbg9jo/lpylCeZcSYJtQzWGBB5iAw+O7B+l0lz00QQ6
         5biKLp/dWMMq4cZzLyqavnIhFmrjzFPs9fU6ktx+lXBuBBxRKOV1KX1kWNwYIGRAYOGQ
         XLI6LTPEkc/gQSFdW37L0w7gAVUX9PmJI8Q3uaP87fpTddugSxKmg7RntkvgYEDOZ9KN
         4kKiSWS79o5kKz4w9zWPjoaJEgSKYKvwWaarAVNYvpg7H2kjn7dy+V0+s7Ou9SL4RtNV
         Fbpw==
X-Gm-Message-State: ACrzQf3zXhwt3Bzz6lrrKaKZzNmLVoXPOACgymTJhk2ryKVRJSPrBINP
        HrDy0vrdiFn0uHHfgETA0HJ/rFb0AZx8f83UGyQ5ATRpV2YZ
X-Google-Smtp-Source: AMsMyM7YkoKyXB4qh/JTdf+IYmWybzqi1/P7lYapqJc0Ji69FRYWsKpTURYilZWZ8wvf34O6iS6XPAevZDsthKsRarOS26pCqCKT
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1909:b0:2f6:acd5:7e9b with SMTP id
 w9-20020a056e02190900b002f6acd57e9bmr3987835ilu.190.1663949804905; Fri, 23
 Sep 2022 09:16:44 -0700 (PDT)
Date:   Fri, 23 Sep 2022 09:16:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bab2c05e95a81a3@google.com>
Subject: [syzbot] BUG: corrupted list in hci_conn_add_sysfs
From:   syzbot <syzbot+b30ccad4684cce846cef@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    16c9f284e746 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13a8f554880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15a770deac0c935a
dashboard link: https://syzkaller.appspot.com/bug?extid=b30ccad4684cce846cef
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1221ebac880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109c44df080000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd8978a3a764/disk-16c9f284.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/73ab1c321ad6/vmlinux-16c9f284.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b30ccad4684cce846cef@syzkaller.appspotmail.com

Bluetooth: hci0: failed to register connection device
list_add corruption. prev->next should be next (ffff0000c94de240), but was 623d4d4554535953. (prev=ffff0000c957fe68).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:32!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3060 Comm: kworker/u5:1 Not tainted 6.0.0-rc6-syzkaller-17739-g16c9f284e746 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Workqueue: hci0 hci_rx_work
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_add_valid+0xb4/0xb8 lib/list_debug.c:30
lr : __list_add_valid+0xb4/0xb8 lib/list_debug.c:30
sp : ffff8000126f3ad0
x29: ffff8000126f3ad0 x28: ffff0000c9208000 x27: 0000000000000000
x26: 0000000000000000 x25: ffff0000caae5014 x24: 0000000000000000
x23: ffff0000c94de240 x22: ffff0000c957fe68 x21: ffff0000c0c03e68
x20: ffff0000c0c03e60 x19: ffff0000c94de200 x18: 00000000000000c0
x17: 3034326564343963 x16: ffff80000db59158 x15: ffff0000c596b500
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c596b500
x11: ff808000081c30a4 x10: 0000000000000000 x9 : 007b181e3ceb7100
x8 : 007b181e3ceb7100 x7 : ffff8000081976e4 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefbecd0 x1 : 0000000100000001 x0 : 0000000000000075
Call trace:
 __list_add_valid+0xb4/0xb8 lib/list_debug.c:30
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 add_tail lib/klist.c:104 [inline]
 klist_add_tail+0x9c/0xd8 lib/klist.c:137
 device_add+0x7a8/0x958 drivers/base/core.c:3528
 hci_conn_add_sysfs+0x4c/0xf4 net/bluetooth/hci_sysfs.c:53
 le_conn_complete_evt+0x858/0xae0 net/bluetooth/hci_event.c:5917
 hci_le_conn_complete_evt+0x58/0xa4 net/bluetooth/hci_event.c:5966
 hci_le_meta_evt+0x1e4/0x230 net/bluetooth/hci_event.c:7110
 hci_event_func net/bluetooth/hci_event.c:7440 [inline]
 hci_event_packet+0x4e0/0x60c net/bluetooth/hci_event.c:7495
 hci_rx_work+0x1a4/0x2f4 net/bluetooth/hci_core.c:4007
 process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
 worker_thread+0x340/0x610 kernel/workqueue.c:2436
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20
Code: 91257400 aa0303e1 aa0803e3 94a78613 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
