Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958BC74789F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 21:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjGDTUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 15:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjGDTUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 15:20:06 -0400
Received: from mail-pj1-f80.google.com (mail-pj1-f80.google.com [209.85.216.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D3110D9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 12:20:04 -0700 (PDT)
Received: by mail-pj1-f80.google.com with SMTP id 98e67ed59e1d1-2631fc29e8aso5780002a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 12:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688498404; x=1691090404;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8z37kh0jEmMsrs2uPjnY0ZT+diXbQGQ7dVapIGO4DM=;
        b=B/U7NyRKgXs9MIdekzIhYa59IbX7MvuJ5QD3EyqOxNmC24xsuLt5aUtK4Rj7zc/OxT
         cEBM9NUywNBdA4lvqOxrD++Eh0Xtor7exoZ+ewPheAzJfEQ77vlVVy7D0n6EJJPqoUXv
         0zQ9eXW6W10oi7vaNU+gYjZQX4+o/ffpo9ih43RjggUZ9Asm/4FB1/Gl+vbAHrrTKB2t
         m6cDb+HOkz+qYIKC4cESqgqUS2LXeZjDBaUZIppvyZnVTH2e4tpf1XvjEaB07nJH/mVS
         98cj/41fIM2zL0ZtoXFh3uHB5q1fvE+TlOocUJidSvtwe9RD93oshGYxrmX4mvRDOMQm
         Bq0w==
X-Gm-Message-State: ABy/qLbfqf+izJlY3rT+wMpotCMXO4GCM4qlMs8mAoVeuG8fXxIxEwUM
        QF5ZnyQ18ec/TftYDbjau8eBGhn8ASVb9HBRWukSm5KNkekd
X-Google-Smtp-Source: APBJJlG9YYe0A7uM8mB8AtPSgQnqfOQAVjw7tR+Ui/9RajSTtuAzEDx/fnnPxE4xrZz0oqnm3iM77B6HgcZzgD6885P6iTdubzsL
MIME-Version: 1.0
X-Received: by 2002:a17:90a:e001:b0:262:ffa8:f49d with SMTP id
 u1-20020a17090ae00100b00262ffa8f49dmr10469123pjy.9.1688498404107; Tue, 04 Jul
 2023 12:20:04 -0700 (PDT)
Date:   Tue, 04 Jul 2023 12:20:03 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094ac8b05ffae2bf2@google.com>
Subject: [syzbot] [modules?] general protection fault in sys_finit_module
From:   syzbot <syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
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

HEAD commit:    995b406c7e97 Merge tag 'csky-for-linus-6.5' of https://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13db8c0ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=71a52faf60231bc7
dashboard link: https://syzkaller.appspot.com/bug?extid=9e4e94a2689427009d35
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17d6670ca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103be50b280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d61d1dbcb956/disk-995b406c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f471061e6439/vmlinux-995b406c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9dcd428320a5/bzImage-995b406c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9e4e94a2689427009d35@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in idempotent kernel/module/main.c:3078 [inline]
BUG: KASAN: vmalloc-out-of-bounds in init_module_from_file kernel/module/main.c:3124 [inline]
BUG: KASAN: vmalloc-out-of-bounds in __do_sys_finit_module kernel/module/main.c:3171 [inline]
BUG: KASAN: vmalloc-out-of-bounds in __se_sys_finit_module+0x371/0x8d0 kernel/module/main.c:3154
Read of size 8 at addr ffffc90003b1fd60 by task syz-executor680/5015

CPU: 1 PID: 5015 Comm: syz-executor680 Not tainted 6.4.0-syzkaller-10098-g995b406c7e97 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:364 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:475
 kasan_report+0x175/0x1b0 mm/kasan/report.c:588
 idempotent kernel/module/main.c:3078 [inline]
 init_module_from_file kernel/module/main.c:3124 [inline]
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module+0x371/0x8d0 kernel/module/main.c:3154
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faed3af4ce9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcd8021778 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000000000000da09 RCX: 00007faed3af4ce9
RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007ffcd8021918 R09: 00007ffcd8021918
R10: 00007ffcd80211f0 R11: 0000000000000246 R12: 00007ffcd802178c
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Memory state around the buggy address:
 ffffc90003b1fc00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90003b1fc80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc90003b1fd00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                                                       ^
 ffffc90003b1fd80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc90003b1fe00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


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
