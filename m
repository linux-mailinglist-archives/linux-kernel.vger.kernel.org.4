Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8474765CE31
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 09:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjADIWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 03:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbjADIVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 03:21:49 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEC419297
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 00:21:48 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id y24-20020a5ec818000000b006e2c0847835so9404151iol.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 00:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXbR2+fKvKsdvVQtEdbtQLGQsbd8QtK8TTQZTG1eVD4=;
        b=BZn4iv2vKPGQXNhonMezFKVSEiutOVG5N++CO6+KhY2Z66pLKtANuHkVl9zLoRnpKJ
         Q0+dnfgFHZgBj4xzuXvvr/uEbKY9UB3kmXPqF4eXBwUC3H+uyuG8JoOig+sYPtaVciJv
         UvMKJEHTpOBqUHlkQIDVFr2UECPPKq0BV0Xw24SUvdNWHXqm1Xx0pyUvmlUBXn3oM/lK
         2F9gMUL0iqLELyLOh4R6Zh7SS/tKdsTyjZYzOD6jPfz4ghAxAVfhTx+eE7+SweAzF3ws
         jvzUIQ/RLq7CqdBC2iIJD9m+NXJMZtDZDwkdh8LvvsQ1faKC7j2TcecRC2wsgC25DRgk
         XvVQ==
X-Gm-Message-State: AFqh2ko3iN8vjDLMv397S5PCqEqcGrt+lMPDcCM0PkJHayRuhRoNm7zJ
        iS7ju/yayWhqj/GoZQk5Prbx1NNNWIO6ustV5F8urtf4PeWN
X-Google-Smtp-Source: AMrXdXur0gZLwICjYKlb0OIBgeIISg4XDscytUChdO4BUs3blpMKxuGg1xU/LSq/RegTHJUB/Bvro9kdboTpdqyUsn98QkWPkwyx
MIME-Version: 1.0
X-Received: by 2002:a05:6638:627:b0:38a:cb77:d5e7 with SMTP id
 h7-20020a056638062700b0038acb77d5e7mr3441846jar.39.1672820507453; Wed, 04 Jan
 2023 00:21:47 -0800 (PST)
Date:   Wed, 04 Jan 2023 00:21:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001eae4605f16be009@google.com>
Subject: [syzbot] [reiserfs?] kernel BUG in balance_leaf
From:   syzbot <syzbot+6a0877ace12bfad107fc@syzkaller.appspotmail.com>
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=156f88b8480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9babfdc3dd4772d0
dashboard link: https://syzkaller.appspot.com/bug?extid=6a0877ace12bfad107fc
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12bdb82a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=108acc94480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a44a84e5e4e6/disk-88603b6d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df723f71c09d/vmlinux-88603b6d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3db040a6ceef/bzImage-88603b6d.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5c2f508ccf3c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a0877ace12bfad107fc@syzkaller.appspotmail.com

REISERFS (device loop0): Using r5 hash to sort names
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
REISERFS panic (device loop0): vs-12195 balance_leaf: CFR not initialized
------------[ cut here ]------------
kernel BUG at fs/reiserfs/prints.c:390!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5070 Comm: syz-executor245 Not tainted 6.2.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__reiserfs_panic+0x12f/0x140 fs/reiserfs/prints.c:390
Code: c0 50 03 8b 48 0f 44 c8 48 0f 44 d8 48 c7 c7 80 51 03 8b 4c 89 fe 48 89 da 4d 89 f0 49 c7 c1 40 46 16 92 31 c0 e8 01 ec 82 08 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41
RSP: 0018:ffffc90003d5e7e0 EFLAGS: 00010246
RAX: 0000000000000049 RBX: ffffffff8b02e520 RCX: 37780e38b943e200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003d5e8d0 R08: ffffffff816f2c9d R09: fffff520007abcb5
R10: fffff520007abcb5 R11: 1ffff920007abcb4 R12: ffffffff8b02e540
R13: ffffc90003d5e800 R14: ffffffff8cc70ec0 R15: ffff888028b806a8
FS:  00007fd74c6aa700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd744689718 CR3: 0000000079f45000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 balance_leaf+0x109eb/0x123a0 fs/reiserfs/do_balan.c:1439
 do_balance+0x2d6/0x8d0 fs/reiserfs/do_balan.c:1888
 reiserfs_insert_item+0xb54/0xcb0 fs/reiserfs/stree.c:2261
 reiserfs_new_inode+0x11c7/0x1cd0 fs/reiserfs/inode.c:2054
 reiserfs_create+0x3a6/0x660 fs/reiserfs/namei.c:668
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12ac/0x2dd0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd74c6fe559
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd74c6aa2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fd74c7847a0 RCX: 00007fd74c6fe559
RDX: 0000000000000241 RSI: 0000000020000000 RDI: 00000000ffffff9c
RBP: 00007fd74c7512b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fd74c7511b8
R13: 0030656c69662f2e R14: 7366726573696572 R15: 00007fd74c7847a8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__reiserfs_panic+0x12f/0x140 fs/reiserfs/prints.c:390
Code: c0 50 03 8b 48 0f 44 c8 48 0f 44 d8 48 c7 c7 80 51 03 8b 4c 89 fe 48 89 da 4d 89 f0 49 c7 c1 40 46 16 92 31 c0 e8 01 ec 82 08 <0f> 0b 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 89 e5 41
RSP: 0018:ffffc90003d5e7e0 EFLAGS: 00010246
RAX: 0000000000000049 RBX: ffffffff8b02e520 RCX: 37780e38b943e200
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003d5e8d0 R08: ffffffff816f2c9d R09: fffff520007abcb5
R10: fffff520007abcb5 R11: 1ffff920007abcb4 R12: ffffffff8b02e540
R13: ffffc90003d5e800 R14: ffffffff8cc70ec0 R15: ffff888028b806a8
FS:  00007fd74c6aa700(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd744689718 CR3: 0000000079f45000 CR4: 00000000003506f0
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
