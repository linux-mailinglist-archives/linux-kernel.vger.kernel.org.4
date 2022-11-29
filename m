Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D5A63BBED
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiK2Inq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiK2Inj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:43:39 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D11140B8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:43:38 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id 13-20020a056e0216cd00b003023e8b7d03so11414558ilx.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PQYp7T3qGKrHPqWa7bIOY8HJgmomp6B6XJxOxmE+5Zw=;
        b=fBzI+gJ32RinLiD3Ex6tQCGqK8ZQIixmwDrUW9pch16cShuxovc+j5WdfjWkGH6Op9
         4oF5j2sMhfno8zPkb5+aK/wlYnvH/1/Kdwi0rcuyTnLm8+HbyE6IOUYC5ovrBTLro8Jt
         twoUtFPdjadiPWLqNUgPCeiKYoV97+sN1HjEw+TaPHOc1LAgpqBFFG7c5+JZnrW1RyMR
         Vj5k7vexR7C+s136SkZyHes/9C+W7zVCzS0P6JjyEu1bbJ8itDQaff1DgZdNi/GLNQAR
         Vc/mwZZZOnXtV87X/9uMcynJB+o01P+EJNZa6g6xP81KjIZCxVAZvK5WFuSlsoqtj09j
         Xdng==
X-Gm-Message-State: ANoB5pklbwlAdKxjTUPc7zvljhiW6C5+oIRY6YfAwvD1fdcr9QjVScYJ
        e2ZqtCjEV1meuN/GkHD9x6mtt5hzniowhYf4phXHcPcVNklD
X-Google-Smtp-Source: AA0mqf4c1b9Gmszb6TTLmBIA5PbtJ8KYsBDgvDc++WWfxaEjuIrtRQiXL/9cOM3uCSz4gbl6cdWGQFeHoJzBkBKREN5b5K/5gI4q
MIME-Version: 1.0
X-Received: by 2002:a6b:e714:0:b0:6df:7332:70f0 with SMTP id
 b20-20020a6be714000000b006df733270f0mr6256440ioh.154.1669711418042; Tue, 29
 Nov 2022 00:43:38 -0800 (PST)
Date:   Tue, 29 Nov 2022 00:43:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f32fb905ee97fbaa@google.com>
Subject: [syzbot] general protection fault in mark_buffer_dirty_inode (2)
From:   syzbot <syzbot+b7fc73213bc2361ab650@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    b7b275e60bcd Linux 6.1-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15a9db8d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=b7fc73213bc2361ab650
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a020bd880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15559d55880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/525233126d34/disk-b7b275e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e8299bf41400/vmlinux-b7b275e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eebf691dbf6f/bzImage-b7b275e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c0423b92def1/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7fc73213bc2361ab650@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 3644 Comm: syz-executor122 Not tainted 6.1.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:mark_buffer_dirty_inode+0x4c/0x300 fs/buffer.c:573
Code: ff 48 83 c5 30 48 89 e8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 ef e8 b3 a3 e0 ff 4c 8b 75 00 49 8d 6d 10 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 95 a3 e0 ff 48 8b 6d 00 48 83 c5
RSP: 0018:ffffc90003c3f828 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000001 RCX: ffff8880721dba80
RDX: 0000000000000000 RSI: ffff88806fe487c0 RDI: 0000000000000000
RBP: 0000000000000010 R08: ffffffff82fd8a56 R09: fffffbfff1cebe0e
R10: fffffbfff1cebe0e R11: 1ffffffff1cebe0d R12: dffffc0000000000
R13: 0000000000000000 R14: ffff88806fe489e8 R15: dffffc0000000000
FS:  00007fa7d8d3e700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa7d080fe00 CR3: 000000006f5bb000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_rename+0xc12/0x15f0 fs/udf/namei.c:1190
 vfs_rename+0xd53/0x1130 fs/namei.c:4779
 do_renameat2+0xb53/0x1370 fs/namei.c:4930
 __do_sys_rename fs/namei.c:4976 [inline]
 __se_sys_rename fs/namei.c:4974 [inline]
 __x64_sys_rename+0x82/0x90 fs/namei.c:4974
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa7d8db7589
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa7d8d3e208 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007fa7d8e3d7b8 RCX: 00007fa7d8db7589
RDX: 00007fa7d8d3e700 RSI: 0000000020000100 RDI: 0000000020000040
RBP: 00007fa7d8e3d7b0 R08: 00007fa7d8d3e700 R09: 0000000000000000
R10: 00007fa7d8d3e700 R11: 0000000000000246 R12: 00007fa7d8e3d7bc
R13: 00007ffeefe6a0ff R14: 00007fa7d8d3e300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mark_buffer_dirty_inode+0x4c/0x300 fs/buffer.c:573
Code: ff 48 83 c5 30 48 89 e8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 ef e8 b3 a3 e0 ff 4c 8b 75 00 49 8d 6d 10 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 95 a3 e0 ff 48 8b 6d 00 48 83 c5
RSP: 0018:ffffc90003c3f828 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 0000000000000001 RCX: ffff8880721dba80
RDX: 0000000000000000 RSI: ffff88806fe487c0 RDI: 0000000000000000
RBP: 0000000000000010 R08: ffffffff82fd8a56 R09: fffffbfff1cebe0e
R10: fffffbfff1cebe0e R11: 1ffffffff1cebe0d R12: dffffc0000000000
R13: 0000000000000000 R14: ffff88806fe489e8 R15: dffffc0000000000
FS:  00007fa7d8d3e700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056211c4d4e58 CR3: 000000006f5bb000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	48 83 c5 30          	add    $0x30,%rbp
   4:	48 89 e8             	mov    %rbp,%rax
   7:	48 c1 e8 03          	shr    $0x3,%rax
   b:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  10:	74 08                	je     0x1a
  12:	48 89 ef             	mov    %rbp,%rdi
  15:	e8 b3 a3 e0 ff       	callq  0xffe0a3cd
  1a:	4c 8b 75 00          	mov    0x0(%rbp),%r14
  1e:	49 8d 6d 10          	lea    0x10(%r13),%rbp
  22:	48 89 e8             	mov    %rbp,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	48 89 ef             	mov    %rbp,%rdi
  33:	e8 95 a3 e0 ff       	callq  0xffe0a3cd
  38:	48 8b 6d 00          	mov    0x0(%rbp),%rbp
  3c:	48                   	rex.W
  3d:	83                   	.byte 0x83
  3e:	c5                   	.byte 0xc5


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
