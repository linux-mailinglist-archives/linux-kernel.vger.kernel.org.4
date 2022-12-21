Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A946539DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 00:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiLUXjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 18:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLUXjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 18:39:51 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7995913F24
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 15:39:50 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id i7-20020a056e021b0700b003033a763270so174174ilv.19
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 15:39:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uHpvaUfrEU++wP4ELFI7Hl+4NNhuPCye2i9zyl2wNwo=;
        b=iE8Iv5utB6iaxam+o67ngmuYilqMMVzpVD60BZyEyZSqPzdisvidC6feMyMD3gV27I
         bqxK3mi+XEk8D+a5cLfmqVSVpxwj17QqC9UOCJONrouY6l7OapJ+KvmvAMf0BuHSmmYg
         P8ZU++FtkIkiUBbpPbyhL/fP2aX5xUM3QU5D8SAFH6h0W2DHLc39uh2nupNkKPoFFDxo
         gW7NDVpTYPnYQyoFwV2VUng1TJisExktQBcJKcgtMaeu/cF6963vRqosnuPeJ1R2dp/h
         IaQKb/BRCRtiGyniBCZTZB6wxfufwhtgjPoU4agFcCo9pXrqhEYtInXGvK1yoo77d4G6
         Wo9w==
X-Gm-Message-State: AFqh2kqCQFn4Sv3cNQWTUEsOaUDEbb5nIm4CUctE1/45iV0wLMku6XoT
        WGRGv6/ljjG41k/AHmwv1eRFxBnsUnRkBpBpyA7tQ0NSGb1S
X-Google-Smtp-Source: AMrXdXtvuMV4FGVZm95j4ClgTRkpm8iUgtN64NLN0HWzuzwbRmmo2aiBzS+5s2QEZ/yB89JOCrKiToqpxSgpJrsVGFXDhg3SYuIa
MIME-Version: 1.0
X-Received: by 2002:a6b:4a04:0:b0:6ed:1e9c:f64 with SMTP id
 w4-20020a6b4a04000000b006ed1e9c0f64mr302789iob.11.1671665989839; Wed, 21 Dec
 2022 15:39:49 -0800 (PST)
Date:   Wed, 21 Dec 2022 15:39:49 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081f1a405f05f111f@google.com>
Subject: [syzbot] [reiserfs?] kernel BUG in reiserfs_update_sd_size
From:   syzbot <syzbot+7d78ccda251bc1bdbaed@syzkaller.appspotmail.com>
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

HEAD commit:    77856d911a8c Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=112c5f1b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f967143badd2fa39
dashboard link: https://syzkaller.appspot.com/bug?extid=7d78ccda251bc1bdbaed
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167d9af7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13d01e1f880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b424d9203f5/disk-77856d91.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/47fd68051834/vmlinux-77856d91.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d3091f087a86/bzImage-77856d91.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/4a056ff389fd/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7d78ccda251bc1bdbaed@syzkaller.appspotmail.com

REISERFS (device loop0): Using r5 hash to sort names
REISERFS panic (device loop0): vs-13065 update_stat_data: key [1 2 0x0 DIRECT], found item *3.6* [1 2 0x0 DIRECT], item_len 44, item_location 4052, free_space(entry_count) 0
------------[ cut here ]------------
kernel BUG at fs/reiserfs/prints.c:390!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5067 Comm: syz-executor406 Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__reiserfs_panic+0x12f/0x140 fs/reiserfs/prints.c:390
Code: 80 4d 03 8b 48 0f 44 c8 48 0f 44 d8 48 c7 c7 40 4e 03 8b 4c 89 fe 48 89 da 4d 89 f0 49 c7 c1 40 d6 15 92 31 c0 e8 41 3e 72 08 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41
RSP: 0018:ffffc90003b1f560 EFLAGS: 00010246
RAX: 00000000000000ad RBX: ffffffff8b02f3a0 RCX: 13eb6dc0ca851900
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003b1f650 R08: ffffffff816f29ad R09: fffff52000763e25
R10: fffff52000763e25 R11: 1ffff92000763e24 R12: ffffffff8b02f3c0
R13: ffffc90003b1f580 R14: ffffffff8cc6e3d9 R15: ffff88802b39a6a8
FS:  0000555555d45300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd11fff5a70 CR3: 000000007d5eb000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 update_stat_data fs/reiserfs/inode.c:1424 [inline]
 reiserfs_update_sd_size+0xfc6/0x10a0 fs/reiserfs/inode.c:1497
 reiserfs_update_sd fs/reiserfs/reiserfs.h:3099 [inline]
 reiserfs_mkdir+0x723/0x8c0 fs/reiserfs/namei.c:877
 xattr_mkdir fs/reiserfs/xattr.c:76 [inline]
 create_privroot fs/reiserfs/xattr.c:882 [inline]
 reiserfs_xattr_init+0x34b/0x730 fs/reiserfs/xattr.c:1005
 reiserfs_fill_super+0x20b5/0x24a0 fs/reiserfs/super.c:2175
 mount_bdev+0x26c/0x3a0 fs/super.c:1359
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f13e308daea
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe033aa0a8 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f13e308daea
RDX: 0000000020000000 RSI: 0000000020000040 RDI: 00007ffe033aa0c0
RBP: 00007ffe033aa0c0 R08: 00007ffe033aa100 R09: 0000000000001105
R10: 0000000000208000 R11: 0000000000000286 R12: 0000000000000004
R13: 0000555555d452c0 R14: 0000000000208000 R15: 00007ffe033aa100
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__reiserfs_panic+0x12f/0x140 fs/reiserfs/prints.c:390
Code: 80 4d 03 8b 48 0f 44 c8 48 0f 44 d8 48 c7 c7 40 4e 03 8b 4c 89 fe 48 89 da 4d 89 f0 49 c7 c1 40 d6 15 92 31 c0 e8 41 3e 72 08 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41
RSP: 0018:ffffc90003b1f560 EFLAGS: 00010246
RAX: 00000000000000ad RBX: ffffffff8b02f3a0 RCX: 13eb6dc0ca851900
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003b1f650 R08: ffffffff816f29ad R09: fffff52000763e25
R10: fffff52000763e25 R11: 1ffff92000763e24 R12: ffffffff8b02f3c0
R13: ffffc90003b1f580 R14: ffffffff8cc6e3d9 R15: ffff88802b39a6a8
FS:  0000555555d45300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ce843f1078 CR3: 000000007d5eb000 CR4: 00000000003506e0
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
