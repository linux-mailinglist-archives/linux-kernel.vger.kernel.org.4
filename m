Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEB764FDE0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 07:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiLRGGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 01:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiLRGGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 01:06:37 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77713BA7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 22:06:36 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id l16-20020a056e02067000b0030325bbd570so4686761ilt.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 22:06:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Uz3tpoXWnk3wtaFyoshLnyTP3M2IAZ5ZTF37JzGmOc=;
        b=01M7vwUXdDoVG1wSvaA9Q56N90xwo8ben0guy9Dm6gCdyuMFeoHb5CDMsozUws9IX+
         Lpir1676znZWiGE+yNu/UOpuBK7bCtfsmG9GqudqOL5/W2Cc/wDhhlv9X6+3e5rc7lbw
         ENhmfaxEYtdq5Uf04RDlqM1XPaY47rZ8h7LL0Fy8v4tc/3DPbnL3dFx5BRITQlmzJcPe
         pbEQoTk/Cu2HraQv04Y1I4RrGyfpBhBLUu3ZHBOUK6LxvmrEypN/FrZBqbFOGfBKgkIh
         eljpvLjdiERGhMUfLHdlU8ste/OCWyEUr9ELD2lUiFk0C3qC08SFkOrGX4i3iNcgB4HY
         7rcA==
X-Gm-Message-State: ANoB5pmWj57RWILwTr5kY2dmoWF1HGhK/JvJjzX2qG4ALlnPrBlMkf47
        sQglv2I3EW4lUFhpOgWWzNPcGCrGDpe3A1fFM55IUVL21Xq0
X-Google-Smtp-Source: AA0mqf6X6mF7Pgksu7yBjgVao2CLP+mLQAhsIZWm/lOlGDx/1k03PjNSM3A4wDrGx4OiTdbXdELn+y7wtAv/+nSHdL6iV47eRjY/
MIME-Version: 1.0
X-Received: by 2002:a5e:8c10:0:b0:6e3:102d:4826 with SMTP id
 n16-20020a5e8c10000000b006e3102d4826mr1737919ioj.123.1671343595848; Sat, 17
 Dec 2022 22:06:35 -0800 (PST)
Date:   Sat, 17 Dec 2022 22:06:35 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000540fc405f01401bf@google.com>
Subject: [syzbot] general protection fault in __xfs_free_extent
From:   syzbot <syzbot+bfbc1eecdfb9b10e5792@syzkaller.appspotmail.com>
To:     dchinner@redhat.com, djwong@kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
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

HEAD commit:    02bf43c7b7f7 Merge tag 'fs.xattr.simple.rework.rbtree.rwlo..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1009ecd0480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c59170b68d26a55
dashboard link: https://syzkaller.appspot.com/bug?extid=bfbc1eecdfb9b10e5792
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1798429d880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=161b948f880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/45f211dceffb/disk-02bf43c7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd0c63aa3713/vmlinux-02bf43c7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/734647e04fd0/bzImage-02bf43c7.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/bd0897600624/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bfbc1eecdfb9b10e5792@syzkaller.appspotmail.com

XFS (loop0): Quotacheck: Done.
general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 3630 Comm: syz-executor203 Not tainted 6.1.0-syzkaller-03295-g02bf43c7b7f7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:xfs_free_extent_fix_freelist fs/xfs/libxfs/xfs_alloc.c:3358 [inline]
RIP: 0010:__xfs_free_extent+0x1f5/0x600 fs/xfs/libxfs/xfs_alloc.c:3407
Code: 00 74 05 e8 bd 96 cc fe 4c 89 ac 24 88 00 00 00 4c 89 7c 24 08 49 8d 5f 08 48 89 d8 48 c1 e8 03 49 bf 00 00 00 00 00 fc ff df <42> 8a 04 38 84 c0 0f 85 02 03 00 00 44 8b 23 4c 8d b4 24 80 00 00
RSP: 0018:ffffc90003d9f580 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: 0000000000000000
RDX: 0000000000000080 RSI: 0000000000000000 RDI: ffffc90003d9f608
RBP: ffffc90003d9f730 R08: dffffc0000000000 R09: ffffc90003d9f610
R10: fffff520007b3ed2 R11: 1ffff920007b3ec2 R12: 1ffff1100e8a82bf
R13: ffff888022c3e000 R14: dffffc0000000000 R15: dffffc0000000000
FS:  0000555555e1a300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9470a976a8 CR3: 000000007dad7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 xfs_free_extent fs/xfs/libxfs/xfs_alloc.h:147 [inline]
 xfs_ag_extend_space+0x365/0x5a0 fs/xfs/libxfs/xfs_ag.c:985
 xfs_growfs_data_private fs/xfs/xfs_fsops.c:151 [inline]
 xfs_growfs_data+0x959/0x10e0 fs/xfs/xfs_fsops.c:294
 xfs_file_ioctl+0xf7f/0x1320 fs/xfs/xfs_ioctl.c:2068
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f23555938c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc24b23568 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f23555938c9
RDX: 0000000020000200 RSI: 000000004010586e RDI: 0000000000000004
RBP: 00007f2355553160 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000095cb R11: 0000000000000246 R12: 00007f23555531f0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:xfs_free_extent_fix_freelist fs/xfs/libxfs/xfs_alloc.c:3358 [inline]
RIP: 0010:__xfs_free_extent+0x1f5/0x600 fs/xfs/libxfs/xfs_alloc.c:3407
Code: 00 74 05 e8 bd 96 cc fe 4c 89 ac 24 88 00 00 00 4c 89 7c 24 08 49 8d 5f 08 48 89 d8 48 c1 e8 03 49 bf 00 00 00 00 00 fc ff df <42> 8a 04 38 84 c0 0f 85 02 03 00 00 44 8b 23 4c 8d b4 24 80 00 00
RSP: 0018:ffffc90003d9f580 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000008 RCX: 0000000000000000
RDX: 0000000000000080 RSI: 0000000000000000 RDI: ffffc90003d9f608
RBP: ffffc90003d9f730 R08: dffffc0000000000 R09: ffffc90003d9f610
R10: fffff520007b3ed2 R11: 1ffff920007b3ec2 R12: 1ffff1100e8a82bf
R13: ffff888022c3e000 R14: dffffc0000000000 R15: dffffc0000000000
FS:  0000555555e1a300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9470a976a8 CR3: 000000007dad7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 74 05 e8          	add    %dh,-0x18(%rbp,%rax,1)
   4:	bd 96 cc fe 4c       	mov    $0x4cfecc96,%ebp
   9:	89 ac 24 88 00 00 00 	mov    %ebp,0x88(%rsp)
  10:	4c 89 7c 24 08       	mov    %r15,0x8(%rsp)
  15:	49 8d 5f 08          	lea    0x8(%r15),%rbx
  19:	48 89 d8             	mov    %rbx,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  27:	fc ff df
* 2a:	42 8a 04 38          	mov    (%rax,%r15,1),%al <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	0f 85 02 03 00 00    	jne    0x338
  36:	44 8b 23             	mov    (%rbx),%r12d
  39:	4c                   	rex.WR
  3a:	8d                   	.byte 0x8d
  3b:	b4 24                	mov    $0x24,%ah
  3d:	80 00 00             	addb   $0x0,(%rax)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
