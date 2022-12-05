Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8A464224D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 05:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiLEEeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 23:34:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiLEEer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 23:34:47 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE3B64EA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 20:34:45 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id a11-20020a92c54b000000b003034a80704fso4771508ilj.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 20:34:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcFrvjYpY9w3oBH5VMBrbCN5cG4DGtca+C+V9MNGNBY=;
        b=AKtIF2u9OpJ6KaV65sO/SX9pNHqGve5DDlOzFIDEza3vM3VyLm4OpE+ZdojKewuPTd
         LAtKaqgA8GhtU23HUR1nz5aV5xqnKwMV9djHvK7gve+J64ZYZ76hJrR4PA8+SS3kl6dJ
         y1V9QVhYI0z2A9v96QaDvMKdq+Y9BVSpCUNV5kx3KUhb/5LCztuHDyR5rd0zVsOqA33y
         rEQGC0gIpwhjOSsWV26jZslIwKnlGm0KqB1rdtgMs/ceOmH6vLqidD3JGechARvfUfC7
         KhvDyQ8wyerFoX6pQGkE5+fS15Vp8J8nU8c1ps+QhhexoJrQpIkLhbuJwZ8oyQ8Df7vc
         aiiw==
X-Gm-Message-State: ANoB5plcQf6Ct0B+AtiSnTX6iCTy95HRMdH1WxWes8zUvuLZXAQozdS5
        wUPpxLPXf9I5w9zbufeHhr3d1OvTHQBJy4jB4ODkaOhO9JnW
X-Google-Smtp-Source: AA0mqf7iyVepFf9uvSqFu+Czqel85Bx9rIZHqrT9xKNbJkXJrxGVTRza++ig5vx166ELXQ5StTz/hrZ9soFSQWNPcWfAbfhn3byU
MIME-Version: 1.0
X-Received: by 2002:a5d:804e:0:b0:6dc:30bd:ed8f with SMTP id
 b14-20020a5d804e000000b006dc30bded8fmr30399822ior.130.1670214884451; Sun, 04
 Dec 2022 20:34:44 -0800 (PST)
Date:   Sun, 04 Dec 2022 20:34:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e2efc305ef0d341f@google.com>
Subject: [syzbot] memory leak in fbcon_set_font (2)
From:   syzbot <syzbot+25bdb7b1703639abd498@syzkaller.appspotmail.com>
To:     daniel@ffwll.ch, deller@gmx.de, dri-devel@lists.freedesktop.org,
        geert+renesas@glider.be, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sam@ravnborg.org,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c2bf05db6c78 Merge tag 'i2c-for-6.1-rc8' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171883d5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=979161df0e247659
dashboard link: https://syzkaller.appspot.com/bug?extid=25bdb7b1703639abd498
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14fff84d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135806a7880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63cd45bf1d68/disk-c2bf05db.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bafbfb42c660/vmlinux-c2bf05db.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9f803a721cfc/bzImage-c2bf05db.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+25bdb7b1703639abd498@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888111648000 (size 18448):
  comm "syz-executor148", pid 3653, jiffies 4294970435 (age 13.520s)
  hex dump (first 32 bytes):
    85 44 7e c7 00 00 00 00 00 48 00 00 00 00 00 00  .D~......H......
    92 30 86 d2 8c 38 30 9e e7 a3 05 00 9f 09 33 bb  .0...80.......3.
  backtrace:
    [<ffffffff814ee6d3>] __do_kmalloc_node mm/slab_common.c:943 [inline]
    [<ffffffff814ee6d3>] __kmalloc+0xb3/0x120 mm/slab_common.c:968
    [<ffffffff8250c359>] kmalloc include/linux/slab.h:558 [inline]
    [<ffffffff8250c359>] fbcon_set_font+0x1a9/0x470 drivers/video/fbdev/core/fbcon.c:2508
    [<ffffffff8262cd59>] con_font_set drivers/tty/vt/vt.c:4667 [inline]
    [<ffffffff8262cd59>] con_font_op+0x3a9/0x600 drivers/tty/vt/vt.c:4713
    [<ffffffff82618e3d>] vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
    [<ffffffff82618e3d>] vt_ioctl+0x14fd/0x1a80 drivers/tty/vt/vt_ioctl.c:752
    [<ffffffff825fdaf5>] tty_ioctl+0x6d5/0xbe0 drivers/tty/tty_io.c:2771
    [<ffffffff816200bc>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816200bc>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff816200bc>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff816200bc>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:856
    [<ffffffff8485c5e5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8485c5e5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff888110b18000 (size 18448):
  comm "syz-executor148", pid 3655, jiffies 4294971001 (age 7.860s)
  hex dump (first 32 bytes):
    85 44 7e c7 00 00 00 00 00 48 00 00 00 00 00 00  .D~......H......
    92 30 86 d2 8c 38 30 9e e7 a3 05 00 9f 09 33 bb  .0...80.......3.
  backtrace:
    [<ffffffff814ee6d3>] __do_kmalloc_node mm/slab_common.c:943 [inline]
    [<ffffffff814ee6d3>] __kmalloc+0xb3/0x120 mm/slab_common.c:968
    [<ffffffff8250c359>] kmalloc include/linux/slab.h:558 [inline]
    [<ffffffff8250c359>] fbcon_set_font+0x1a9/0x470 drivers/video/fbdev/core/fbcon.c:2508
    [<ffffffff8262cd59>] con_font_set drivers/tty/vt/vt.c:4667 [inline]
    [<ffffffff8262cd59>] con_font_op+0x3a9/0x600 drivers/tty/vt/vt.c:4713
    [<ffffffff82618e3d>] vt_k_ioctl drivers/tty/vt/vt_ioctl.c:474 [inline]
    [<ffffffff82618e3d>] vt_ioctl+0x14fd/0x1a80 drivers/tty/vt/vt_ioctl.c:752
    [<ffffffff825fdaf5>] tty_ioctl+0x6d5/0xbe0 drivers/tty/tty_io.c:2771
    [<ffffffff816200bc>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff816200bc>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff816200bc>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff816200bc>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:856
    [<ffffffff8485c5e5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8485c5e5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory
write to /proc/sys/kernel/hung_task_check_interval_secs failed: No such file or directory
write to /proc/sys/kernel/softlockup_all_cpu_backtrace failed: No such file or directory


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
