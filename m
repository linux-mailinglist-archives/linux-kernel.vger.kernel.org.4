Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D245F2514
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 20:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiJBS4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 14:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiJBS4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 14:56:43 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A338357FE
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 11:56:40 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id o2-20020a6b5a02000000b006ad1ff1dbd6so387225iob.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 11:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=xiWdMDELiF+JnAzjzXKmcwyYPMVW08sJ4DWmwAsHbpM=;
        b=wDTshtOltYMKB2AADFl8IH9IWgrc4qyMK+wWDBNDjuWeEeM9iuqhXF1N07VK1ucX06
         RXP22iqZn1Wht4O9jWWOmNNKdkrjshO5V/02D3hjxmSCBm8ZBxv0Iwqqp2EhstL/+uUZ
         mItb0y0qnC3UuoZv7GV+asD6+2uWLfBBoI+dJaObs+WAenV1hfgKzFSnoph1kpRaBl4h
         krfdL4OkgZrTt6Vv8nHBm5nJgFcIArrmCwEe5exxa71SLMMrMe4X0L+dNDO5FxB9/WDR
         DrBWGUgwz0GDo2U0BnX4UjABYKulMon1ic/fdMoghsKu6IiWmEMMJS0ltJ3c1b1kAmyE
         cUbg==
X-Gm-Message-State: ACrzQf13Rou/Nj0umpuf19z2U48rx0urGx+B+EPeG9lNQxqTUp0lAzTy
        BB1s98XpE3Iv/G3jsYOGBiGCcbNIw97QB0Sis4mtWm8Msh5H
X-Google-Smtp-Source: AMsMyM7tGZdiWFcoqzv+8TSI11itBAIYe2vSvTRoIyX931syH6WrVr31mQkXykfnnf9xtXaFFf5rZrTZEwnnDr/6GxgzRV9NDJbf
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1311:b0:6a5:1b2f:e340 with SMTP id
 h17-20020a056602131100b006a51b2fe340mr7282860iov.66.1664736999620; Sun, 02
 Oct 2022 11:56:39 -0700 (PDT)
Date:   Sun, 02 Oct 2022 11:56:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081c7c405ea11c907@google.com>
Subject: [syzbot] general protection fault in jfs_flush_journal
From:   syzbot <syzbot+194bfe3476f96782c0b6@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    b357fd1c2afc Merge tag 'usb-6.0-final' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12bffb70880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1047ec68880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10409722880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c3f38889d41b/disk-b357fd1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8b4dacf1eadb/vmlinux-b357fd1c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+194bfe3476f96782c0b6@syzkaller.appspotmail.com

ERROR: (device loop4): diRead: i_ino != di_number
general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 0 PID: 3626 Comm: syz-executor291 Not tainted 6.0.0-rc7-syzkaller-00239-gb357fd1c2afc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:write_special_inodes fs/jfs/jfs_logmgr.c:208 [inline]
RIP: 0010:jfs_flush_journal+0x7e7/0xec0 fs/jfs/jfs_logmgr.c:1573
Code: b1 fe 49 8d 5f f0 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 17 d5 d9 fe 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 fa d4 d9 fe 48 8b 3b e8 f2 f3 b1
RSP: 0018:ffffc900039af9e0 EFLAGS: 00010206

RAX: 0000000000000006 RBX: 0000000000000030 RCX: 29e26a118b04f100
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900039afb10 R08: ffffffff81b29a43 R09: ffffc900039af930
R10: fffff52000735f29 R11: 1ffff92000735f26 R12: 1ffff92000735f48
R13: dffffc0000000000 R14: ffff8880246d3800 R15: ffff88801e196038
FS:  0000555557105300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd2b406000 CR3: 0000000073f69000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 jfs_umount+0xf3/0x370 fs/jfs/jfs_umount.c:58
 jfs_fill_super+0x911/0xc50 fs/jfs/super.c:600
 mount_bdev+0x26c/0x3a0 fs/super.c:1400
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8daf79e56a
Code: 48 c7 c2 c0 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 a8 00 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd2b4051a8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8daf79e56a
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007ffd2b4051c0
RBP: 00007ffd2b4051c0 R08: 00007ffd2b405200 R09: 0000000000000002
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000000000004
R13: 00007ffd2b405200 R14: 0000000000000357 R15: 0000000020005228
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:write_special_inodes fs/jfs/jfs_logmgr.c:208 [inline]
RIP: 0010:jfs_flush_journal+0x7e7/0xec0 fs/jfs/jfs_logmgr.c:1573
Code: b1 fe 49 8d 5f f0 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 17 d5 d9 fe 48 8b 1b 48 83 c3 30 48 89 d8 48 c1 e8 03 <42> 80 3c 28 00 74 08 48 89 df e8 fa d4 d9 fe 48 8b 3b e8 f2 f3 b1
RSP: 0018:ffffc900039af9e0 EFLAGS: 00010206
RAX: 0000000000000006 RBX: 0000000000000030 RCX: 29e26a118b04f100
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900039afb10 R08: ffffffff81b29a43 R09: ffffc900039af930
R10: fffff52000735f29 R11: 1ffff92000735f26 R12: 1ffff92000735f48
R13: dffffc0000000000 R14: ffff8880246d3800 R15: ffff88801e196038
FS:  0000555557105300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8daf7afa10 CR3: 0000000073f69000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	b1 fe                	mov    $0xfe,%cl
   2:	49 8d 5f f0          	lea    -0x10(%r15),%rbx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 17 d5 d9 fe       	callq  0xfed9d533
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 30          	add    $0x30,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 fa d4 d9 fe       	callq  0xfed9d533
  39:	48 8b 3b             	mov    (%rbx),%rdi
  3c:	e8                   	.byte 0xe8
  3d:	f2                   	repnz
  3e:	f3                   	repz
  3f:	b1                   	.byte 0xb1


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
