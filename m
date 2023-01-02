Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB2765B225
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 13:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjABMel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 07:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjABMej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 07:34:39 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8E5642F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 04:34:38 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id b13-20020a92c56d000000b0030c4d05f3e4so1841407ilj.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 04:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uSZIh3R9tmk2zXdNEc5WJ8qPxT/Kv5Jkd5qJTfpBQ3M=;
        b=W6c2V5X0GRlEyJB1PHUgyuiC2xLz1n7ulVeJQnti3hBh85Vlppg7HPSuehXgI5CRuL
         vpPQfI8y48zaX51nmwEWdtn8KD8mHgzeWbTmMZOWF0J3IiJi4hbRSumcI+bC4gX5VRSW
         EQDMR/uk/tejvfUmgvdhxJRQgXzLXHQcCBIfPRAF0HC7FE2oalY+IqIooVsDDsKUwenK
         ulzu+a3xACz+FWsrqyhYjdbRWuqsUh0M28EKD1s3ZI3Xv+BTCaIC4iwaeOd6+oTMGxQR
         5xNhA6iqR4YtYhQiWeIBWrDs2Ual3DEZX/hntxwET0xOsBmO35DAIZB1EzuD8numm+Zd
         e9bw==
X-Gm-Message-State: AFqh2koSqS04nqBtbHn5ooRuNqyyLKJrO9lG/RT5bkx33efzOl3j0+HG
        +Ht0kYs0Vm80kdZeV+j4m/TLAosLLmbvVmDRGkNxLrlKPXgT
X-Google-Smtp-Source: AMrXdXuDpa/nG6agDjje8/9RdpHOTcthB9Rxa58bTNiHwVH/eLFag0GP4QKSjGRqMZ/6JP9CQT27ar9aujKTJU1EJ7yF4DFbnCFX
MIME-Version: 1.0
X-Received: by 2002:a05:6638:36ed:b0:38a:9b1:d500 with SMTP id
 t45-20020a05663836ed00b0038a09b1d500mr2749054jau.252.1672662877342; Mon, 02
 Jan 2023 04:34:37 -0800 (PST)
Date:   Mon, 02 Jan 2023 04:34:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a213d505f1472cbe@google.com>
Subject: [syzbot] [ntfs?] kernel BUG in ntfs_truncate
From:   syzbot <syzbot+22e381af27f7921a2642@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
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

HEAD commit:    bff687b3dad6 Merge tag 'block-6.2-2022-12-29' of git://git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=127fe732480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=22e381af27f7921a2642
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175a9dbc480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1542c884480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b1982d688f97/disk-bff687b3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c7c5609f900d/vmlinux-bff687b3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee4e79832281/bzImage-bff687b3.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ab0785a427df/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+22e381af27f7921a2642@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs: volume version 3.1.
------------[ cut here ]------------
kernel BUG at fs/ntfs/inode.c:2536!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5076 Comm: syz-executor690 Not tainted 6.2.0-rc1-syzkaller-00068-gbff687b3dad6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:ntfs_truncate+0x269f/0x2720 fs/ntfs/inode.c:2536
Code: 20 80 e1 07 80 c1 03 38 c1 0f 8c c8 f8 ff ff 48 8b 7c 24 20 e8 72 f3 1a ff e9 b9 f8 ff ff e8 98 4b c5 fe 0f 0b e8 91 4b c5 fe <0f> 0b e8 8a 4b c5 fe 0f 0b e8 83 4b c5 fe 0f 0b e8 7c 4b c5 fe 0f
RSP: 0018:ffffc90003c8fae0 EFLAGS: 00010293
RAX: ffffffff82c68fdf RBX: 00000000ffffffe4 RCX: ffff888029970000
RDX: 0000000000000000 RSI: 00000000ffffffe4 RDI: 0000000000000000
RBP: ffff8880786b7380 R08: ffffffff82c670dd R09: ffffed100f0d6e7b
R10: ffffed100f0d6e7b R11: 1ffff1100f0d6e7a R12: dffffc0000000000
R13: ffff8880786b7380 R14: ffff8880786b7380 R15: 0000000000000000
FS:  0000555556955300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000028ee7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ntfs_truncate_vfs fs/ntfs/inode.c:2862 [inline]
 ntfs_setattr+0x2b9/0x3a0 fs/ntfs/inode.c:2914
 notify_change+0xe50/0x1100 fs/attr.c:482
 do_truncate+0x200/0x2f0 fs/open.c:65
 vfs_truncate+0x299/0x360 fs/open.c:111
 do_sys_truncate+0xcb/0x180 fs/open.c:134
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f61c4db3769
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc056b7c28 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f61c4db3769
RDX: 00007f61c4d71de3 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 00007f61c4d73000 R08: 000000000001f1cf R09: 0000000000000000
R10: 00007ffc056b7af0 R11: 0000000000000246 R12: 00007f61c4d73090
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ntfs_truncate+0x269f/0x2720 fs/ntfs/inode.c:2536
Code: 20 80 e1 07 80 c1 03 38 c1 0f 8c c8 f8 ff ff 48 8b 7c 24 20 e8 72 f3 1a ff e9 b9 f8 ff ff e8 98 4b c5 fe 0f 0b e8 91 4b c5 fe <0f> 0b e8 8a 4b c5 fe 0f 0b e8 83 4b c5 fe 0f 0b e8 7c 4b c5 fe 0f
RSP: 0018:ffffc90003c8fae0 EFLAGS: 00010293
RAX: ffffffff82c68fdf RBX: 00000000ffffffe4 RCX: ffff888029970000
RDX: 0000000000000000 RSI: 00000000ffffffe4 RDI: 0000000000000000
RBP: ffff8880786b7380 R08: ffffffff82c670dd R09: ffffed100f0d6e7b
R10: ffffed100f0d6e7b R11: 1ffff1100f0d6e7a R12: dffffc0000000000
R13: ffff8880786b7380 R14: ffff8880786b7380 R15: 0000000000000000
FS:  0000555556955300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000028ee7000 CR4: 00000000003506f0
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
