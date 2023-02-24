Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EFA6A170D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 08:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBXH0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 02:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjBXHZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 02:25:59 -0500
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD7F5EEDF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 23:25:53 -0800 (PST)
Received: by mail-io1-f78.google.com with SMTP id z5-20020a6b5c05000000b007447572f3f8so7692914ioh.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 23:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=13ZPUloYEvdQxbJ02OlHlYBlVfQKqarZGRElgDtSV3Y=;
        b=wUFlDp2vJBM4mRt2DcrCjCo75Luj5hSoRwArUmqvlgi2G2XbRdIUiN2tIMJzuZ+YrL
         s4ErM9x5vc+pTVnzKE0O+ifA2Tr60V0kzaiIpkqRJ9OgWzU0CuvTP04F6zI1u2sE50J7
         iAZbdd+Ygc+0LlOYqZ9vi0fz1hTwtGr25hy8TVrgYzVxCtdT3Bsyk0kALZwFyzrrx2NQ
         ZUzV1xVmhm4CuDi1kyT2wZta65LTnd4MJk7dHhybuBpBqsE9OFc8PL2889uEGaJQvQeo
         dlnkAf+U+O38AHtS9psqBh6NIZTh2xk9TDMa9zFjUE/9pekVhtTw9DjbQtocOpXBbdbo
         2TEQ==
X-Gm-Message-State: AO0yUKVxGpH/Mu8ty4QxUb1pL8zkjNYfOjuL5LSPAmoGEN084anuj3Td
        AsQaOCvZfpJz3gjo0H6coZttkKU4+DmZEcwVDKxlFEjmmiyf
X-Google-Smtp-Source: AK7set8/wVhN5vLN9i64rHqdzUpgXR69U//u9Dn+IB7mW0AtYBWP5xJVUQxWzojyDiTeuYvk/L8Ru7tnNUEKidgdanwu2OLNfa4D
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4819:b0:3e9:4d91:5c9c with SMTP id
 cp25-20020a056638481900b003e94d915c9cmr671886jab.1.1677223553024; Thu, 23 Feb
 2023 23:25:53 -0800 (PST)
Date:   Thu, 23 Feb 2023 23:25:53 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016493d05f56d0aae@google.com>
Subject: [syzbot] [block?] WARNING in blkdev_put (2)
From:   syzbot <syzbot+2bcc0d79e548c4f62a59@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
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

HEAD commit:    d2af0fa4bfa4 Add linux-next specific files for 20230220
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=170d2ef0c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=594e1a56901fd35d
dashboard link: https://syzkaller.appspot.com/bug?extid=2bcc0d79e548c4f62a59
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1227e837480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122d8ca0c80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/83b78c113e8e/disk-d2af0fa4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d59f9b2c9091/vmlinux-d2af0fa4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2726c16c1d3b/bzImage-d2af0fa4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2bcc0d79e548c4f62a59@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5080 at block/bdev.c:845 blkdev_put+0x6ca/0x770 block/bdev.c:845
Modules linked in:
CPU: 1 PID: 5080 Comm: syz-executor158 Not tainted 6.2.0-rc8-next-20230220-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
RIP: 0010:blkdev_put+0x6ca/0x770 block/bdev.c:845
Code: 48 8b 3c 24 e8 b7 7c da fd e9 99 fa ff ff e8 8d 7c da fd e9 cf fb ff ff 4c 89 ff e8 80 7c da fd e9 80 fd ff ff e8 e6 ea 88 fd <0f> 0b e9 ef fc ff ff e8 8a 7c da fd e9 f3 fa ff ff 48 8b 3c 24 e8
RSP: 0018:ffffc90003cefc88 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff888144c49600 RCX: 0000000000000000
RDX: ffff88807c2f8000 RSI: ffffffff83fbb8da RDI: 0000000000000005
RBP: ffff888146bc0000 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000000 R12: 00000000484e009f
R13: ffff888144c49628 R14: ffff888146bc0460 R15: ffff888144c49ab8
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb645428948 CR3: 000000000c571000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 blkdev_close+0x68/0x80 block/fops.c:507
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xb42/0x2b60 kernel/exit.c:869
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1019
 __do_sys_exit_group kernel/exit.c:1030 [inline]
 __se_sys_exit_group kernel/exit.c:1028 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1028
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fb6453e4639
Code: Unable to access opcode bytes at 0x7fb6453e460f.
RSP: 002b:00007ffcfacb3ec8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007fb645458270 RCX: 00007fb6453e4639
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb645458270
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
