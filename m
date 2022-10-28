Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B64E611E3F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 01:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJ1Xpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 19:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiJ1Xpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 19:45:35 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A1374DCA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:45:33 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d6-20020a056e02214600b002fa23a188ebso6105530ilv.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 16:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H60CO/7ESD8qYAR25JqKtv1QA/7SsWIOSgVv3mhXfqY=;
        b=2SvJoHhIwEzfM/L3keQWqL2U9MnAO+crtLhCQFWwsHVY+OSqTLD44Gt/kZMA60GSnV
         b+iuo/kH532yhJ7m/xbK/ZgP7H8M81Rk5xPm/KsWS6Jjhk8DahNForZHoy0HP2I6gHLv
         6Bc5vdaYl4uvLSbr6MFS+z+tnpkMYTHVBoIxOFer354+kvtbqggsXcy0qeT6Y14u1Hyi
         /rAYZ/Go5NPkLbv1lsScO08nDRWkUURYSteXzGcXfciZwmYW8RwZJ1m4CuAZqIf+9jfP
         uhF4G3b41ewBxuWSUyTQH/Hc/Yekcg47sgujpxHBUlA3gU3kD2DtAjxAevtjSITSnmfO
         sI7g==
X-Gm-Message-State: ACrzQf3tc1VEIbWnGVtcBsnSBh9HgbH6bChyGhgvtfJag8DF/xXF+Y3g
        bqgbZ7mF9A7DGcP3KRZtgKEmeuYUBUqHj6MZeHy8JbVNS8Ul
X-Google-Smtp-Source: AMsMyM4JWcj4ZzNZUcc9Ft4kLvCmNODOGL0M5AXbM8q37wEto5tD876N2CZkKPqPI+DRndw565l6Pg9wlWRJ2vQdCoWA3e9RLLhr
MIME-Version: 1.0
X-Received: by 2002:a05:6638:380f:b0:363:cb7f:4fb8 with SMTP id
 i15-20020a056638380f00b00363cb7f4fb8mr981737jav.227.1667000733222; Fri, 28
 Oct 2022 16:45:33 -0700 (PDT)
Date:   Fri, 28 Oct 2022 16:45:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008b529305ec20dacc@google.com>
Subject: [syzbot] kernel BUG in dnotify_free_mark
From:   syzbot <syzbot+06cc05ddc896f12b7ec5@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
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

HEAD commit:    247f34f7b803 Linux 6.1-rc2
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=157f594a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=06cc05ddc896f12b7ec5
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15585936880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ec85ba880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a5f39164dea4/disk-247f34f7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8d1b92f5a01f/vmlinux-247f34f7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/1a4d2943796c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+06cc05ddc896f12b7ec5@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at fs/notify/dnotify/dnotify.c:136!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 56 Comm: kworker/u4:4 Not tainted 6.1.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Workqueue: events_unbound fsnotify_mark_destroy_workfn
RIP: 0010:dnotify_free_mark+0x53/0x60 fs/notify/dnotify/dnotify.c:136
Code: 48 89 df e8 ff b3 dd ff 48 83 3b 00 75 17 e8 e4 bc 89 ff 48 8b 3d 4d ce 0f 0c 4c 89 f6 5b 41 5e e9 a2 de dc ff e8 cd bc 89 ff <0f> 0b cc cc cc cc cc cc cc cc cc cc cc 55 41 57 41 56 41 55 41 54
RSP: 0018:ffffc90001577b68 EFLAGS: 00010293
RAX: ffffffff81fe1253 RBX: ffff888075d2b080 RCX: ffff888018d40000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888075d2b000
RBP: ffffc90001577c30 R08: dffffc0000000000 R09: fffffbfff2325fe4
R10: fffffbfff2325fe4 R11: 1ffffffff2325fe3 R12: ffff888145e77800
R13: ffffc90001577bc0 R14: ffff888075d2b000 R15: ffff888075d2b000
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f127cdcaa38 CR3: 000000001dd46000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fsnotify_final_mark_destroy fs/notify/mark.c:278 [inline]
 fsnotify_mark_destroy_workfn+0x2cc/0x340 fs/notify/mark.c:902
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dnotify_free_mark+0x53/0x60 fs/notify/dnotify/dnotify.c:136
Code: 48 89 df e8 ff b3 dd ff 48 83 3b 00 75 17 e8 e4 bc 89 ff 48 8b 3d 4d ce 0f 0c 4c 89 f6 5b 41 5e e9 a2 de dc ff e8 cd bc 89 ff <0f> 0b cc cc cc cc cc cc cc cc cc cc cc 55 41 57 41 56 41 55 41 54
RSP: 0018:ffffc90001577b68 EFLAGS: 00010293
RAX: ffffffff81fe1253 RBX: ffff888075d2b080 RCX: ffff888018d40000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888075d2b000
RBP: ffffc90001577c30 R08: dffffc0000000000 R09


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
