Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7934C5FC9AE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 19:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiJLRBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 13:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiJLRBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 13:01:03 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C0613F91
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:00:55 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id w16-20020a6b4a10000000b006a5454c789eso11845397iob.20
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 10:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/X48RrGcpCXpSiCfOqIUHZFRP+kCWH1TKoVCkcDfDrQ=;
        b=fTv+xonGkZU/5pWsaDb/6Xv/bdBjwgMXXnBNNUFfQa5XdLWSIkmp6wXBiZrkjs70uy
         X7uMn1OtZLpn2Ot7zVe87Qyqjly6yYoGs7MZzaF7V+iz7NczdlQZt8YuaQl9rf8dCEYQ
         L94xc5fWlDmDQkbRp37AwRt6fDaXGkGvoKeHJs5cwMtDjqYNmjs60tHDo+0psYKZMtHu
         Cl/feKtB4YR5YE2V9cjasJWwVAyz5BP+XgKbbId03bZsFu42xudgF0PfsWO3swNwnQzA
         ikSOGwsrw/Szp76M/Q3Lho+K9YLaZSRrxC7CUE3i9TyaQs3kstvkSCRsfQvDrbUObSCz
         ouTg==
X-Gm-Message-State: ACrzQf2Zk3BCwef1xn5sw1UFJJi07fGeCzPicOnva65oSZAY0fa5Hft/
        K9VwKha0p4UP+XBlBeLjIVSra13rGZmJ0+KPNOyQBjwEwT6B
X-Google-Smtp-Source: AMsMyM4H0/4VO7JmYxzm+5ZByL58xUbEhfiWL6YrckNDsCEGT4p/ZPcF7jv7eQ1RHUzUmmxjoUqdSeydxQkC8gcnvAD/yi8P8/a3
MIME-Version: 1.0
X-Received: by 2002:a05:6602:483:b0:68a:b5f2:a508 with SMTP id
 y3-20020a056602048300b0068ab5f2a508mr13586285iov.97.1665594055067; Wed, 12
 Oct 2022 10:00:55 -0700 (PDT)
Date:   Wed, 12 Oct 2022 10:00:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe10d805ead95567@google.com>
Subject: [syzbot] memory leak in kernfs_fop_open
From:   syzbot <syzbot+141cc7ede4844354c9c5@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org
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

HEAD commit:    e8bc52cb8df8 Merge tag 'driver-core-6.1-rc1' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15adbd1c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d97b00ebbd65d751
dashboard link: https://syzkaller.appspot.com/bug?extid=141cc7ede4844354c9c5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=127fb348880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=140790e8880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c383c6221def/disk-e8bc52cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/212eadb7e8f5/vmlinux-e8bc52cb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+141cc7ede4844354c9c5@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810bfdeb80 (size 96):
  comm "udevd", pid 2966, jiffies 4294946369 (age 13.650s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff816f6911>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff816f6911>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff816f6911>] kernfs_get_open_node fs/kernfs/file.c:568 [inline]
    [<ffffffff816f6911>] kernfs_fop_open+0x4f1/0x5b0 fs/kernfs/file.c:736
    [<ffffffff815d909f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815ff9b6>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815ff9b6>] path_openat+0x1756/0x1be0 fs/namei.c:3691
    [<ffffffff816026e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3718
    [<ffffffff815dca0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815dd45f>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815dd45f>] __do_sys_openat fs/open.c:1342 [inline]
    [<ffffffff815dd45f>] __se_sys_openat fs/open.c:1337 [inline]
    [<ffffffff815dd45f>] __x64_sys_openat+0x7f/0xe0 fs/open.c:1337
    [<ffffffff845fc895>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845fc895>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810bfdeb00 (size 96):
  comm "udevd", pid 3607, jiffies 4294946461 (age 12.730s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff816f6911>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff816f6911>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff816f6911>] kernfs_get_open_node fs/kernfs/file.c:568 [inline]
    [<ffffffff816f6911>] kernfs_fop_open+0x4f1/0x5b0 fs/kernfs/file.c:736
    [<ffffffff815d909f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815ff9b6>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815ff9b6>] path_openat+0x1756/0x1be0 fs/namei.c:3691
    [<ffffffff816026e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3718
    [<ffffffff815dca0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815dd45f>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815dd45f>] __do_sys_openat fs/open.c:1342 [inline]
    [<ffffffff815dd45f>] __se_sys_openat fs/open.c:1337 [inline]
    [<ffffffff815dd45f>] __x64_sys_openat+0x7f/0xe0 fs/open.c:1337
    [<ffffffff845fc895>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845fc895>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810bfdea80 (size 96):
  comm "udevd", pid 3607, jiffies 4294946461 (age 12.730s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff816f6911>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff816f6911>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff816f6911>] kernfs_get_open_node fs/kernfs/file.c:568 [inline]
    [<ffffffff816f6911>] kernfs_fop_open+0x4f1/0x5b0 fs/kernfs/file.c:736
    [<ffffffff815d909f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815ff9b6>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815ff9b6>] path_openat+0x1756/0x1be0 fs/namei.c:3691
    [<ffffffff816026e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3718
    [<ffffffff815dca0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815dd45f>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815dd45f>] __do_sys_openat fs/open.c:1342 [inline]
    [<ffffffff815dd45f>] __se_sys_openat fs/open.c:1337 [inline]
    [<ffffffff815dd45f>] __x64_sys_openat+0x7f/0xe0 fs/open.c:1337
    [<ffffffff845fc895>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845fc895>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810bfdea00 (size 96):
  comm "udevd", pid 3607, jiffies 4294946461 (age 12.740s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff816f6911>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff816f6911>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff816f6911>] kernfs_get_open_node fs/kernfs/file.c:568 [inline]
    [<ffffffff816f6911>] kernfs_fop_open+0x4f1/0x5b0 fs/kernfs/file.c:736
    [<ffffffff815d909f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815ff9b6>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815ff9b6>] path_openat+0x1756/0x1be0 fs/namei.c:3691
    [<ffffffff816026e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3718
    [<ffffffff815dca0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815dd45f>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815dd45f>] __do_sys_openat fs/open.c:1342 [inline]
    [<ffffffff815dd45f>] __se_sys_openat fs/open.c:1337 [inline]
    [<ffffffff815dd45f>] __x64_sys_openat+0x7f/0xe0 fs/open.c:1337
    [<ffffffff845fc895>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845fc895>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88810bfde980 (size 96):
  comm "udevd", pid 3607, jiffies 4294946461 (age 12.740s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff816f6911>] kmalloc include/linux/slab.h:600 [inline]
    [<ffffffff816f6911>] kzalloc include/linux/slab.h:733 [inline]
    [<ffffffff816f6911>] kernfs_get_open_node fs/kernfs/file.c:568 [inline]
    [<ffffffff816f6911>] kernfs_fop_open+0x4f1/0x5b0 fs/kernfs/file.c:736
    [<ffffffff815d909f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
    [<ffffffff815ff9b6>] do_open fs/namei.c:3557 [inline]
    [<ffffffff815ff9b6>] path_openat+0x1756/0x1be0 fs/namei.c:3691
    [<ffffffff816026e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3718
    [<ffffffff815dca0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
    [<ffffffff815dd45f>] do_sys_open fs/open.c:1326 [inline]
    [<ffffffff815dd45f>] __do_sys_openat fs/open.c:1342 [inline]
    [<ffffffff815dd45f>] __se_sys_openat fs/open.c:1337 [inline]
    [<ffffffff815dd45f>] __x64_sys_openat+0x7f/0xe0 fs/open.c:1337
    [<ffffffff845fc895>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845fc895>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

[  104.674978][ 


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
