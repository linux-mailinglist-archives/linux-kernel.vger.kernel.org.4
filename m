Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDD8614456
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 06:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKAFjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 01:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiKAFjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 01:39:43 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6D9B86A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:39:39 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id j17-20020a5d93d1000000b006bcdc6b49cbso10255216ioo.22
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 22:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NfbRSaQd3tGiBfb6Xwbb5sXkBUnvBuSxNOS89/j/qJ0=;
        b=6HJqenU9gEixsiVoKTZ2zzwWL3WdFIr6BpYUmPYEG7NEgnuDu+qBJIFroROP+FbLii
         DsjxL+hnlYG98illW53Ih+p5uK6b7kDTB3dQBqod+0fXo6ZGjIMMBQ5N6WbYrF1EEk6V
         uOKMwjBD9AZvzFFMM9B+L1PjKk8YNVsI+euD/mU3vTu4iO78JYPwRcE8xjAEn/rN53p7
         wCbKO7JKcPms/p5IgFtYBRzhahoUKFkVvrz8Fcvq6V7S18Hl//290nFiX+k2O3z8m1W2
         VG7isE1N+umRNp9i7mERefYOwkRuPBA6U+eNMu2J2XmlUQkPY9crl7WDqgM+RWJ+4bvJ
         A7+g==
X-Gm-Message-State: ACrzQf2jqbGGBV+1Qi++hMPXrgmbff9yaeVKCu1xUBFp0M4KYdHpTDI6
        AvA4uuTXk2IPW9PZOFkV9dvymnB+zLBvgYfVK/Ksuj8wZOb0
X-Google-Smtp-Source: AMsMyM5o2lePe8F61+PqT8/pM3X+ZFdxNnXH5zmQ+ZCPsEPjc9coJ5ThgUtHLNLOomyYjMI5fpys04OLFNCtHN5FqcMMIT0aA86m
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2e8d:b0:6bd:543c:6fd7 with SMTP id
 m13-20020a0566022e8d00b006bd543c6fd7mr10118164iow.134.1667281178755; Mon, 31
 Oct 2022 22:39:38 -0700 (PDT)
Date:   Mon, 31 Oct 2022 22:39:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006686e905ec622691@google.com>
Subject: [syzbot] memory leak in gsmld_ioctl
From:   syzbot <syzbot+6e3e8f30f269f5028e5d@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14f684ee880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e0c1dbca40c1f1d
dashboard link: https://syzkaller.appspot.com/bug?extid=6e3e8f30f269f5028e5d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c41d22880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1357247a880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cf67b1049a03/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3f2fbf5dbb8c/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7ff8681ade50/bzImage-b229b6ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e3e8f30f269f5028e5d@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810ec09400 (size 1024):
  comm "syz-executor252", pid 3630, jiffies 4294960211 (age 24.300s)
  hex dump (first 32 bytes):
    00 bc c0 0e 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814cfe70>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1046
    [<ffffffff826196b7>] kmalloc include/linux/slab.h:576 [inline]
    [<ffffffff826196b7>] kzalloc include/linux/slab.h:712 [inline]
    [<ffffffff826196b7>] gsm_dlci_alloc+0x27/0x180 drivers/tty/n_gsm.c:2060
    [<ffffffff8261ea0b>] gsm_activate_mux drivers/tty/n_gsm.c:2534 [inline]
    [<ffffffff8261ea0b>] gsm_config drivers/tty/n_gsm.c:2776 [inline]
    [<ffffffff8261ea0b>] gsmld_ioctl+0x45b/0x750 drivers/tty/n_gsm.c:3113
    [<ffffffff826063f3>] tty_ioctl+0x733/0xbe0 drivers/tty/tty_io.c:2780
    [<ffffffff81602b2c>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81602b2c>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff81602b2c>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff81602b2c>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:856
    [<ffffffff84608025>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84608025>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810ec09400 (size 1024):
  comm "syz-executor252", pid 3630, jiffies 4294960211 (age 25.470s)
  hex dump (first 32 bytes):
    00 bc c0 0e 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814cfe70>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1046
    [<ffffffff826196b7>] kmalloc include/linux/slab.h:576 [inline]
    [<ffffffff826196b7>] kzalloc include/linux/slab.h:712 [inline]
    [<ffffffff826196b7>] gsm_dlci_alloc+0x27/0x180 drivers/tty/n_gsm.c:2060
    [<ffffffff8261ea0b>] gsm_activate_mux drivers/tty/n_gsm.c:2534 [inline]
    [<ffffffff8261ea0b>] gsm_config drivers/tty/n_gsm.c:2776 [inline]
    [<ffffffff8261ea0b>] gsmld_ioctl+0x45b/0x750 drivers/tty/n_gsm.c:3113
    [<ffffffff826063f3>] tty_ioctl+0x733/0xbe0 drivers/tty/tty_io.c:2780
    [<ffffffff81602b2c>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81602b2c>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff81602b2c>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff81602b2c>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:856
    [<ffffffff84608025>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84608025>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810ec09400 (size 1024):
  comm "syz-executor252", pid 3630, jiffies 4294960211 (age 28.890s)
  hex dump (first 32 bytes):
    00 bc c0 0e 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814cfe70>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1046
    [<ffffffff826196b7>] kmalloc include/linux/slab.h:576 [inline]
    [<ffffffff826196b7>] kzalloc include/linux/slab.h:712 [inline]
    [<ffffffff826196b7>] gsm_dlci_alloc+0x27/0x180 drivers/tty/n_gsm.c:2060
    [<ffffffff8261ea0b>] gsm_activate_mux drivers/tty/n_gsm.c:2534 [inline]
    [<ffffffff8261ea0b>] gsm_config drivers/tty/n_gsm.c:2776 [inline]
    [<ffffffff8261ea0b>] gsmld_ioctl+0x45b/0x750 drivers/tty/n_gsm.c:3113
    [<ffffffff826063f3>] tty_ioctl+0x733/0xbe0 drivers/tty/tty_io.c:2780
    [<ffffffff81602b2c>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81602b2c>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff81602b2c>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff81602b2c>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:856
    [<ffffffff84608025>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84608025>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810ec09400 (size 1024):
  comm "syz-executor252", pid 3630, jiffies 4294960211 (age 28.920s)
  hex dump (first 32 bytes):
    00 bc c0 0e 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814cfe70>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1046
    [<ffffffff826196b7>] kmalloc include/linux/slab.h:576 [inline]
    [<ffffffff826196b7>] kzalloc include/linux/slab.h:712 [inline]
    [<ffffffff826196b7>] gsm_dlci_alloc+0x27/0x180 drivers/tty/n_gsm.c:2060
    [<ffffffff8261ea0b>] gsm_activate_mux drivers/tty/n_gsm.c:2534 [inline]
    [<ffffffff8261ea0b>] gsm_config drivers/tty/n_gsm.c:2776 [inline]
    [<ffffffff8261ea0b>] gsmld_ioctl+0x45b/0x750 drivers/tty/n_gsm.c:3113
    [<ffffffff826063f3>] tty_ioctl+0x733/0xbe0 drivers/tty/tty_io.c:2780
    [<ffffffff81602b2c>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81602b2c>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff81602b2c>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff81602b2c>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:856
    [<ffffffff84608025>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84608025>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810ec09400 (size 1024):
  comm "syz-executor252", pid 3630, jiffies 4294960211 (age 28.960s)
  hex dump (first 32 bytes):
    00 bc c0 0e 81 88 ff ff 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814cfe70>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1046
    [<ffffffff826196b7>] kmalloc include/linux/slab.h:576 [inline]
    [<ffffffff826196b7>] kzalloc include/linux/slab.h:712 [inline]
    [<ffffffff826196b7>] gsm_dlci_alloc+0x27/0x180 drivers/tty/n_gsm.c:2060
    [<ffffffff8261ea0b>] gsm_activate_mux drivers/tty/n_gsm.c:2534 [inline]
    [<ffffffff8261ea0b>] gsm_config drivers/tty/n_gsm.c:2776 [inline]
    [<ffffffff8261ea0b>] gsmld_ioctl+0x45b/0x750 drivers/tty/n_gsm.c:3113
    [<ffffffff826063f3>] tty_ioctl+0x733/0xbe0 drivers/tty/tty_io.c:2780
    [<ffffffff81602b2c>] vfs_ioctl fs/ioctl.c:51 [inline]
    [<ffffffff81602b2c>] __do_sys_ioctl fs/ioctl.c:870 [inline]
    [<ffffffff81602b2c>] __se_sys_ioctl fs/ioctl.c:856 [inline]
    [<ffffffff81602b2c>] __x64_sys_ioctl+0xfc/0x140 fs/ioctl.c:856
    [<ffffffff84608025>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84608025>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

executing program
executing program
executing program


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
