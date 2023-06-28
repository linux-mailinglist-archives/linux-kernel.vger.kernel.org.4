Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AD5740D23
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbjF1JeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:34:17 -0400
Received: from mail-oa1-f79.google.com ([209.85.160.79]:49362 "EHLO
        mail-oa1-f79.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbjF1J3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:29:53 -0400
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-19ee42cbc89so4821475fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 02:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687944593; x=1690536593;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9dMY6YcIlrE3sJMTzfK2UKqNaC09qMUm825ErXZUR8=;
        b=AAk39xqojxC3DBX+tXfHdzzoYKsgGMmUcMmtkm+XBLwWIWcNR1qiP0VC6tfnhSplc8
         9F6IKr1k5O6NWnruGTbceJiWO751/oUgz+0hYQesv3xDwTbMOr15EJzo7i3SAbWjVhYf
         PHrOpAiUPcxE1zyVzm7jlmgTx/RFUMszZKxgKbpq0Pr9fnqLxYV/IJE5BvEB+NwpoVdD
         vz8dsx/VSojVlIlQlvNpNDEWnTTvVL4bs21u5wPlCxHEBdmsILLHNpcJ453PbfOub5YT
         68x0PkDrxWStsLPrkpYyiRTdIDNqkqHVB9KSGO3phRhIS7NNBj5Hphib8wM1S4KR9AHf
         vtIg==
X-Gm-Message-State: AC+VfDzPh84WdTStBNtwfLldIyNGnTIcA9Cz6p4oFQINixcSrvoF/KCS
        UZ+MA2LfobtbI7ympioV1RmVEfNyxxhHTy5gOKpdH5BmF0c5
X-Google-Smtp-Source: ACHHUZ4lr9VNLciAwFNJ8sPT7XFB0q7VnfZnpr98kyi+ddowVEcHfZMFvXHCynxtGSbYKcwl6rEuj8xzS6J7F/zIu+D0NxcamFHh
MIME-Version: 1.0
X-Received: by 2002:a05:6870:6387:b0:1b0:8d7:6e54 with SMTP id
 t7-20020a056870638700b001b008d76e54mr4947774oap.5.1687944593005; Wed, 28 Jun
 2023 02:29:53 -0700 (PDT)
Date:   Wed, 28 Jun 2023 02:29:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dde2fb05ff2d39c6@google.com>
Subject: [syzbot] [kernel?] upstream test error: UBSAN: array-index-out-of-bounds
 in alloc_pid
From:   syzbot <syzbot+522a57d8d5a0f7ac5c6c@syzkaller.appspotmail.com>
To:     brauner@kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6aeadf7896bf Merge tag 'docs-arm64-move' of git://git.lwn...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12cea2c7280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=652d39e0420afbb8
dashboard link: https://syzkaller.appspot.com/bug?extid=522a57d8d5a0f7ac5c6c
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3887d048a41c/disk-6aeadf78.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b25a7d5f9034/vmlinux-6aeadf78.xz
kernel image: https://storage.googleapis.com/syzbot-assets/96457fbed62d/bzImage-6aeadf78.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+522a57d8d5a0f7ac5c6c@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in kernel/pid.c:244:3
index 1 is out of range for type 'struct upid[1]'
CPU: 1 PID: 4996 Comm: syz-executor.0 Not tainted 6.4.0-syzkaller-01761-g6aeadf7896bf #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 alloc_pid+0x405/0xc40 kernel/pid.c:244
 copy_process+0x1f2f/0x4350 kernel/fork.c:2523
 kernel_clone+0x222/0x800 kernel/fork.c:2915
 __do_sys_clone kernel/fork.c:3058 [inline]
 __se_sys_clone kernel/fork.c:3042 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:3042
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f30e5e89fab
Code: ed 0f 85 60 01 00 00 64 4c 8b 0c 25 10 00 00 00 45 31 c0 4d 8d 91 d0 02 00 00 31 d2 31 f6 bf 11 00 20 01 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 89 00 00 00 41 89 c5 85 c0 0f 85 90 00 00
RSP: 002b:00007ffe72312890 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 00007ffe72312ee8 RCX: 00007f30e5e89fab
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000000 R08: 0000000000000000 R09: 000055555643c400
R10: 000055555643c6d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe72312980 R14: 00007f30e5fac9d8 R15: 000000000000000c
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
