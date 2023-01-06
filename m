Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5668F6606F8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 20:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjAFTQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 14:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjAFTQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 14:16:53 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4061BC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:16:52 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id j3-20020a056e02154300b00304bc968ef1so1603592ilu.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 11:16:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EZ5VY6tdIbMSDaR0Xf93xL7xs0X1Eh1sLNVTDSkcDIM=;
        b=zLMhL1yDnXnBzgaryrRoorb/87TrI0bOZVKZL5YGn4vpOrbkNcKd6rGOVm6haXKcv6
         O9AMWfZUI1LJ1ABCGo7ZjinHTJ8mq0FyN4t8L/7QPx4jx94FQ92zjN4fl3Vn7rUrcYZS
         QE9zoJpXSGjX618wXfwnSVDQF22HKMuoiLwyRF/1S910mZ6Ss0dAS0WvpaLm6PutZ3Is
         9upOm2/ia+OVQHOfB7aWtS7sE4hYseLX9bCpoRSHH2N91KkrG8tKOL8sksYQVFkYrsas
         7Ae9w/PncPqKOxsQ/AV+hMlxeALs/FnemKY1RPWS3VqsToR+mpvfX1ENHXxJjcO5jwLz
         3XQQ==
X-Gm-Message-State: AFqh2krhrOgYqqFWvHDKGhHJqi7HY/0ADewzWCDKIFQIHNIcJSGwpnT/
        1E7EW2yqrMI2nniho7avH5JVk+70Uo1hWHClZeFfrbwNWwwy
X-Google-Smtp-Source: AMrXdXsW8bY/m0QgL7+gmVNdFQmp+h4vEqyR9cqu7PN7he8J2hB+Lg8TCb78M/O9OIfLdX/R2IxJUptY53YBMa/9BK4RZlOzLhKB
MIME-Version: 1.0
X-Received: by 2002:a92:c54f:0:b0:30b:b564:154e with SMTP id
 a15-20020a92c54f000000b0030bb564154emr5178841ilj.85.1673032611516; Fri, 06
 Jan 2023 11:16:51 -0800 (PST)
Date:   Fri, 06 Jan 2023 11:16:51 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081dba605f19d42dd@google.com>
Subject: [syzbot] [reiserfs?] kernel BUG in reiserfs_cut_from_item
From:   syzbot <syzbot+b2c969f18c4ab30419f9@syzkaller.appspotmail.com>
To:     jack@suse.cz, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        yijiangshan@kylinos.cn
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

HEAD commit:    88603b6dc419 Linux 6.2-rc2
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14fd0692480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
dashboard link: https://syzkaller.appspot.com/bug?extid=b2c969f18c4ab30419f9
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14edd048480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a5c50c480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a44a84e5e4e6/disk-88603b6d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df723f71c09d/vmlinux-88603b6d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3db040a6ceef/bzImage-88603b6d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2b27b4df465f/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b2c969f18c4ab30419f9@syzkaller.appspotmail.com

1:  ".."           1              2              0              2              (VISIBLE)
-------------------------------------------------------------------------------
| 5| *3.6* [2 6 0x0 SD], item_len 44, item_location 340, free_space(entry_count) 65535 |
	mode | size | nlinks | first direct | mtime
	0100000 |     24 |  1 | 0 | 1672687496
===================================================================
REISERFS panic (device loop0): PAP-5580 reiserfs_cut_from_item: item to convert does not exist ([2 6 0x1 IND])
------------[ cut here ]------------
kernel BUG at fs/reiserfs/prints.c:390!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 5065 Comm: syz-executor364 Not tainted 6.2.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__reiserfs_panic+0x12f/0x140 fs/reiserfs/prints.c:390
Code: c0 50 03 8b 48 0f 44 c8 48 0f 44 d8 48 c7 c7 80 51 03 8b 4c 89 fe 48 89 da 4d 89 f0 49 c7 c1 40 46 16 92 31 c0 e8 01 ec 82 08 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41
RSP: 0018:ffffc90003c0f140 EFLAGS: 00010246
RAX: 000000000000006e RBX: ffffffff8b0376e0 RCX: bc42c5d171a4b400
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003c0f230 R08: ffffffff816f2c9d R09: fffff52000781de1
R10: fffff52000781de1 R11: 1ffff92000781de0 R12: ffffffff8b037700
R13: ffffc90003c0f160 R14: ffffffff8cc71f98 R15: ffff888079d1a6a8
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f2c5ae6c40 CR3: 0000000021dc5000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 reiserfs_cut_from_item+0x219d/0x25b0 fs/reiserfs/stree.c:1729
 reiserfs_do_truncate+0x9d6/0x15a0 fs/reiserfs/stree.c:1973
 reiserfs_truncate_file+0x471/0x790 fs/reiserfs/inode.c:2310
 reiserfs_file_release+0x887/0xa30 fs/reiserfs/file.c:109
 __fput+0x3ba/0x880 fs/file_table.c:320
 task_work_run+0x243/0x300 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x644/0x2150 kernel/exit.c:867
 do_group_exit+0x1fd/0x2b0 kernel/exit.c:1012
 __do_sys_exit_group kernel/exit.c:1023 [inline]
 __se_sys_exit_group kernel/exit.c:1021 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:1021
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6be3efd489
Code: Unable to access opcode bytes at 0x7f6be3efd45f.
RSP: 002b:00007ffec10dfdd8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f6be3f72350 RCX: 00007f6be3efd489
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffc0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6be3f72350
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__reiserfs_panic+0x12f/0x140 fs/reiserfs/prints.c:390
Code: c0 50 03 8b 48 0f 44 c8 48 0f 44 d8 48 c7 c7 80 51 03 8b 4c 89 fe 48 89 da 4d 89 f0 49 c7 c1 40 46 16 92 31 c0 e8 01 ec 82 08 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41
RSP: 0018:ffffc90003c0f140 EFLAGS: 00010246
RAX: 000000000000006e RBX: ffffffff8b0376e0 RCX: bc42c5d171a4b400
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003c0f230 R08: ffffffff816f2c9d R09: fffff52000781de1
R10: fffff52000781de1 R11: 1ffff92000781de0 R12: ffffffff8b037700
R13: ffffc90003c0f160 R14: ffffffff8cc71f98 R15: ffff888079d1a6a8
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055f2c5ae6c40 CR3: 0000000021dc5000 CR4: 00000000003506e0
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
