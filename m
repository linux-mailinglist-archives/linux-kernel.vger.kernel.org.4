Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E1B654E3F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbiLWJSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbiLWJSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:18:37 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2094236D5F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:18:36 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id h11-20020a6b7a0b000000b006e0004fc167so1707976iom.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 01:18:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nY1Mvmq+MwB2kPt3Vxrhf30Nf2z4fkRSqQIF62smsX4=;
        b=Uo3pSOMEoCK/Z9M/8tiju6gZxb8d2Etw/vvRAaEfq9E8b8I6eH0V14/dpva3b5WCiz
         N3szS472MZl7yVQHzlHjpjQTA/V2b3UDjOPW5AyV2nPVrktnpj6uCJwV5wDDqzJHkXSn
         NJDmTE5hEbMMhkOhzrncaUn9grdikUxcL4gLyocYdtnlIenNbQT/+Eo9CCwkSXjeJ+5s
         f787UZQ2A4mC8RHsmEGYVJVZgz86cPaQOZHAtjChAlOQs9eeyKh1HGuHus/cSW1dKIhG
         vcVgIo0fIYeN8j1KNElZOl7fWzi7ZK4rPo3QDHAGFKAKkzJCJH9ZczPkPr8imDlc/vMU
         2YaQ==
X-Gm-Message-State: AFqh2koa9QEhu32L+bDpGWJkyywShCEzAp4L+02bfFqQV9L73EVjG11/
        /fMcn+W36HL5gz8vObLMFg+AWBmRRKBFzY634QxYFZJrUplZ
X-Google-Smtp-Source: AMrXdXuiJXqGtd8H99HyvnnFh8y2zLcno20eftzqM3gKqTAHxf2aEvHoK+xMQjfQWuOjhb1ETClkEda2R+TS4EtxxWv/S+9SUHMa
MIME-Version: 1.0
X-Received: by 2002:a02:85a5:0:b0:38a:518e:d230 with SMTP id
 d34-20020a0285a5000000b0038a518ed230mr757730jai.255.1671787115493; Fri, 23
 Dec 2022 01:18:35 -0800 (PST)
Date:   Fri, 23 Dec 2022 01:18:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000028be8705f07b458d@google.com>
Subject: [syzbot] kernel BUG in collapse_file (2)
From:   syzbot <syzbot+671b136929ae932761d5@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    f9ff5644bcc0 Merge tag 'hsi-for-6.2' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16aac7c7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=827916bd156c2ec6
dashboard link: https://syzkaller.appspot.com/bug?extid=671b136929ae932761d5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15def1bf880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11f301f7880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/65961cc3b839/disk-f9ff5644.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b5f01bcb2a34/vmlinux-f9ff5644.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9becc0a3f960/bzImage-f9ff5644.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+671b136929ae932761d5@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/khugepaged.c:1794!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5111 Comm: syz-executor300 Not tainted 6.1.0-syzkaller-13139-gf9ff5644bcc0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:collapse_file+0x3707/0x57d0 mm/khugepaged.c:1794
Code: ff 48 c7 c2 a0 0f 3a 8a be ce 00 00 00 48 c7 c7 00 10 3a 8a c6 05 f2 5f 68 0c 01 e8 1d 2e de 07 e9 8a e1 ff ff e8 09 6b ac ff <0f> 0b e8 02 6b ac ff 48 8b 7c 24 30 4c 89 fe e8 75 3b db 07 48 89
RSP: 0018:ffffc90003def810 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 00000000000002c0 RCX: 0000000000000000
RDX: ffff8880289c9d40 RSI: ffffffff81d4e5f7 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000006 R09: 00000000000002c0
R10: 00000000000002c1 R11: 0000000000000000 R12: 00000000000002c1
R13: 0000000000000043 R14: ffff88807e9d7ac0 R15: dffffc0000000000
FS:  00007f31c4a33700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f31c4b0e5a4 CR3: 000000001d68d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hpage_collapse_scan_file+0xdba/0x18e0 mm/khugepaged.c:2204
 madvise_collapse+0x523/0xb60 mm/khugepaged.c:2663
 madvise_vma_behavior+0x63d/0x2020 mm/madvise.c:1091
 madvise_walk_vmas+0x1c7/0x2b0 mm/madvise.c:1265
 do_madvise.part.0+0x24a/0x340 mm/madvise.c:1444
 do_madvise mm/madvise.c:1457 [inline]
 __do_sys_madvise mm/madvise.c:1457 [inline]
 __se_sys_madvise mm/madvise.c:1455 [inline]
 __x64_sys_madvise+0x117/0x150 mm/madvise.c:1455
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f31c4aaaee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 31 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f31c4a332f8 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 00007f31c4b2c498 RCX: 00007f31c4aaaee9
RDX: 0000000000000019 RSI: 000000000060005f RDI: 0000000020000000
RBP: 00007f31c4b2c490 R08: 0000000000000001 R09: 0000000000000034
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f31c4a33300
R13: 0000000000000001 R14: 00007f31c4a33400 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:collapse_file+0x3707/0x57d0 mm/khugepaged.c:1794
Code: ff 48 c7 c2 a0 0f 3a 8a be ce 00 00 00 48 c7 c7 00 10 3a 8a c6 05 f2 5f 68 0c 01 e8 1d 2e de 07 e9 8a e1 ff ff e8 09 6b ac ff <0f> 0b e8 02 6b ac ff 48 8b 7c 24 30 4c 89 fe e8 75 3b db 07 48 89
RSP: 0018:ffffc90003def810 EFLAGS: 00010093
RAX: 0000000000000000 RBX: 00000000000002c0 RCX: 0000000000000000
RDX: ffff8880289c9d40 RSI: ffffffff81d4e5f7 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000006 R09: 00000000000002c0
R10: 00000000000002c1 R11: 0000000000000000 R12: 00000000000002c1
R13: 0000000000000043 R14: ffff88807e9d7ac0 R15: dffffc0000000000
FS:  00007f31c4a33700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f31c4b0e5a4 CR3: 000000001d68d000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
