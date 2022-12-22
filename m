Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9725E653E43
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 11:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbiLVK14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 05:27:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiLVK1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 05:27:53 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8237510576
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:27:51 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id a10-20020a056e02180a00b0030bc09c6b94so890183ilv.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 02:27:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5HTIk+zLHUJHm6DydAui0axcG/OhmJp0BU+jpk6xqyA=;
        b=JH2SBGgWpn4UCDLBKcA/KKYyES3Zr93pDVj5JmxXLAP3TPdV5o70xVnlrNUoLNXRJQ
         qM4dYupDHrv/YYUEENtMTIJUlZdbCE+RRvg9Y97QwsdFD1EAgPyARAbrSFq/njIL7W+g
         dGCg3vv3a2Zve5Pu5wRqkoqM3dNXwqsarBMaq2CpqvORfHGTNLTmlu4qwDjN7H6xkvfv
         c6p4RWXEl0XBTo3s7X3UiTUsfRbKJXSKpM5PnHMr+EC0azFu5+2NnaltxOTFIsfxmQ60
         DTqhWcnWhUfNfExZNG5eN0hkbqe9KibKlvRGhNHuYbiWQiSfJFP/FnerDyG7Vm5Pbkfe
         uDYg==
X-Gm-Message-State: AFqh2kqavezcrxZq4/KKNGE4hcDL435bLxu8VTQ1BwFdKFPf5Bs0LpuS
        KHLDajbhY3PezsRL1PfgN22UDAvzF6+j9hN54yfXwf4zH4Sb
X-Google-Smtp-Source: AMrXdXs0+ZcI1FZ4fAjD3AHxHK3b14KKfNTVkQbC4YkmhGNSNNfgCkmPH354UiQpL9dWLNj9lXMtYz5to1DNNei4Bx68d2VKecjY
MIME-Version: 1.0
X-Received: by 2002:a02:c723:0:b0:375:3f45:dc94 with SMTP id
 h3-20020a02c723000000b003753f45dc94mr432432jao.144.1671704870902; Thu, 22 Dec
 2022 02:27:50 -0800 (PST)
Date:   Thu, 22 Dec 2022 02:27:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ffe48405f0681eea@google.com>
Subject: [syzbot] [reiserfs?] memory leak in journal_init
From:   syzbot <syzbot+38daa8d09e2bde63614c@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, axboe@kernel.dk, bvanassche@acm.org,
        jlayton@kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org, yi.zhang@huawei.com
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

HEAD commit:    f9ff5644bcc0 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=168fd1f0480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea51bad86b095bab
dashboard link: https://syzkaller.appspot.com/bug?extid=38daa8d09e2bde63614c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1427ed10480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1340b05f880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5afa364baa22/disk-f9ff5644.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eceb2cb98557/vmlinux-f9ff5644.xz
kernel image: https://storage.googleapis.com/syzbot-assets/974bb6f9809b/bzImage-f9ff5644.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/395742fd36dd/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38daa8d09e2bde63614c@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810c37aa80 (size 192):
  comm "syz-executor428", pid 5076, jiffies 4294957825 (age 12.820s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 04 00 00 00 00 00 00 00  ................
    01 00 00 00 00 00 00 00 01 00 00 00 03 00 00 00  ................
  backtrace:
    [<ffffffff814f8270>] kmalloc_trace+0x20/0x90 mm/slab_common.c:1062
    [<ffffffff8178f011>] kmalloc include/linux/slab.h:580 [inline]
    [<ffffffff8178f011>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff8178f011>] alloc_journal_list+0x21/0xc0 fs/reiserfs/journal.c:2571
    [<ffffffff8179311f>] journal_list_init fs/reiserfs/journal.c:2585 [inline]
    [<ffffffff8179311f>] journal_init+0x7bf/0x1fc0 fs/reiserfs/journal.c:2840
    [<ffffffff8177e93f>] reiserfs_fill_super+0x61f/0x15d0 fs/reiserfs/super.c:2022
    [<ffffffff8160e263>] mount_bdev+0x223/0x260 fs/super.c:1359
    [<ffffffff8167270b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
    [<ffffffff8160bde8>] vfs_get_tree+0x28/0x100 fs/super.c:1489
    [<ffffffff8164fc87>] do_new_mount fs/namespace.c:3145 [inline]
    [<ffffffff8164fc87>] path_mount+0xc37/0x10d0 fs/namespace.c:3475
    [<ffffffff816508be>] do_mount fs/namespace.c:3488 [inline]
    [<ffffffff816508be>] __do_sys_mount fs/namespace.c:3697 [inline]
    [<ffffffff816508be>] __se_sys_mount fs/namespace.c:3674 [inline]
    [<ffffffff816508be>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3674
    [<ffffffff8489f645>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff8489f645>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84a00087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
