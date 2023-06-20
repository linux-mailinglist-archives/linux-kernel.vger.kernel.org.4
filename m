Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECFD7376B2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjFTVev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFTVes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:34:48 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636D1170D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:34:47 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-77da0200928so463934239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:34:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687296886; x=1689888886;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C8h56+Nw3PHyDQJJw90SrezeFvT6bY7SsQPlbTisbW4=;
        b=bEEfnaa4yq2KazHi0JiAaBl/9oM6cVdFmXQTi4we/SaowkHyYvmhaTHwYJyrUNR++I
         PkN4djFwl/fzzL0+yjctdklc6//443/U/C6vL0Rr6+UqPUljSW6ZBNpuuqr8i1tMTTdz
         tYz/TfU2kwpSa+KrFJaZdezD00qEO3SFDfl1zz/gYw7vte/8s+uYuJBgUzBjD6yFVAzD
         mRAdbLPPxsKZLfuud+7Hlwt0dvIpHsdx6qKCcJ1QEv6OarKRVOfe87PU0gxWdfo9gKnQ
         tZhoNmw/yAD0hmMfRC1dgovaJDgkw3G4mcvpCux+Nc1W604mnyZaAzaJNJM2St3GFCDE
         uAfg==
X-Gm-Message-State: AC+VfDzCkiHA/g6dKtMgmdNCohEIwOoqjoJA99dUAI9pqvkm9xA+woTh
        tJ1D86eqE1NZImDD35ws252BOVGhO7b+l0i2pggWN5RAE7Hy
X-Google-Smtp-Source: ACHHUZ7s5BWFtaXX+GD4lynOIab5pCHEzcyo6r3PEcvVeW2mggSZKq9Ayak/l8gDoBuo3aw7MHc/f0YbOeEtl0xtF8xd1vExtr95
MIME-Version: 1.0
X-Received: by 2002:a02:95a3:0:b0:41d:9cf2:f41d with SMTP id
 b32-20020a0295a3000000b0041d9cf2f41dmr4280642jai.0.1687296886770; Tue, 20 Jun
 2023 14:34:46 -0700 (PDT)
Date:   Tue, 20 Jun 2023 14:34:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091164305fe966bdd@google.com>
Subject: [syzbot] [btrfs?] WARNING in emit_fiemap_extent
From:   syzbot <syzbot+9992306148b06272f3bb@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=166d2acf280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e
dashboard link: https://syzkaller.appspot.com/bug?extid=9992306148b06272f3bb
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10c65e87280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1094a78b280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2dc89d5fee38/disk-40f71e7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0ced5a475218/vmlinux-40f71e7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d543a4f69684/bzImage-40f71e7c.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7cde8d2312ae/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9992306148b06272f3bb@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5351 at fs/btrfs/extent_io.c:2824 emit_fiemap_extent+0xee/0x410
Modules linked in:
CPU: 1 PID: 5351 Comm: syz-executor148 Not tainted 6.4.0-rc6-syzkaller-00195-g40f71e7cd3c6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:emit_fiemap_extent+0xee/0x410 fs/btrfs/extent_io.c:2824
Code: d8 24 52 fe 49 8b 45 00 48 89 04 24 48 8b 4c 24 28 48 8d 2c 08 48 89 ef 4c 89 f6 e8 3c 4f fa fd 4c 39 f5 76 1b e8 22 4d fa fd <0f> 0b bd ea ff ff ff e9 25 02 00 00 e8 11 4d fa fd e9 97 01 00 00
RSP: 0018:ffffc90004b7f4a8 EFLAGS: 00010293
RAX: ffffffff8391327e RBX: ffffc90004b7f8e0 RCX: ffff88807658bb80
RDX: 0000000000000000 RSI: 00000000000b3000 RDI: 0000000000101000
RBP: 0000000000101000 R08: ffffffff83913274 R09: 0000000000000800
R10: ffffc90004b7f478 R11: dffffc0000000001 R12: 1ffff9200096ff1f
R13: ffffc90004b7f8f0 R14: 00000000000b3000 R15: 1ffff9200096ff1e
FS:  00007f2063529700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055dbf02d3668 CR3: 0000000079ce7000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fiemap_process_hole+0xa27/0xaf0 fs/btrfs/extent_io.c:3104
 extent_fiemap+0xe7d/0x1fc0
 btrfs_fiemap+0x178/0x1e0 fs/btrfs/inode.c:7802
 ioctl_fiemap fs/ioctl.c:219 [inline]
 do_vfs_ioctl+0x19ba/0x2b10 fs/ioctl.c:810
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl+0x81/0x160 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f206a99eae9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 a1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f20635292f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f206aa287f0 RCX: 00007f206a99eae9
RDX: 00000000200012c0 RSI: 00000000c020660b RDI: 0000000000000004
RBP: 00007f206a9f5290 R08: 00007f2063529700 R09: 0000000000000000
R10: 00007f2063529700 R11: 0000000000000246 R12: 5f65646f6e696f6e
R13: 0032656c69662f2e R14: 8000000000000001 R15: 00007f206aa287f8
 </TASK>


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
