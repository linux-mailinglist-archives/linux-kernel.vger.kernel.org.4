Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714A2659602
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 08:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbiL3H6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 02:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiL3H6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 02:58:36 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8792A2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:58:35 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a10-20020a056e02180a00b0030bc09c6b94so12910151ilv.6
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 23:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uimzBc7Na7MrmXstHYGwNZkwPVzMTt9V7F5FAmAQDYw=;
        b=bCgrAGTue80u4Cvw94U+Q6otdvMXJn1Hn+Gu7GrntKYLz7VnHlyHWyz3VWdXDYKz3/
         thcaadH1D0tAyHxZJFPmztyokpIqiMAyyUtvI3/8lqtdo3Qa/7kX7Xw5b3GF75QkB08S
         VjlSOb8Tldt6SwmBthZ7kYnajm+0b/LV3VruhCJ5xtTP9Gis1rjJMOy5zKpqDjzM/XzT
         QkZROxKNtoKMrpyICN+ODkwlOAM07Uu4JDU9uRHC4BVx82+QZ5t760Uk+jftJGwQBh0M
         KFMuNPEmYMl/FvKvFUVv8LYAf3EXKLTRqNqtXfm82qTwMITF78Wr1sPXwlL/zCoMyOAM
         gSNA==
X-Gm-Message-State: AFqh2kq7IFnG42X5b12iFmMbaKmJYg3AUkuivUtGSFSdHyzpx0asMM78
        kvCNhJHPu8ClLEhgX5C9B/6F+KTMMdwx+a1YBdheaO35ApFB
X-Google-Smtp-Source: AMrXdXv5hbq7qlP9ofsg2sdYEgzb+YhHgDmzb2NsPGRV0QYTjSTgUWajNGGwkpAJWwJgw6wJFl8TxGK5FSjr/WaEizEGBF2fnsls
MIME-Version: 1.0
X-Received: by 2002:a92:d1c4:0:b0:30c:2649:4e9a with SMTP id
 u4-20020a92d1c4000000b0030c26494e9amr482288ilg.198.1672387114923; Thu, 29 Dec
 2022 23:58:34 -0800 (PST)
Date:   Thu, 29 Dec 2022 23:58:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e981e105f106f7b5@google.com>
Subject: [syzbot] [ext4?] WARNING in mb_find_extent
From:   syzbot <syzbot+68223fe9f6c95ad43bed@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
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

HEAD commit:    1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10e2d1ff880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=68223fe9f6c95ad43bed
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144dc560480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149409ff880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d8c5072480f/disk-1b929c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46687f1395db/vmlinux-1b929c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26f1afa5ec00/bzImage-1b929c02.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d3fc2e524cb8/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+68223fe9f6c95ad43bed@syzkaller.appspotmail.com

EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!
EXT4-fs (loop0): orphan cleanup on readonly fs
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5067 at fs/ext4/mballoc.c:1869 mb_find_extent+0x8a1/0xe30
Modules linked in:
CPU: 1 PID: 5067 Comm: syz-executor307 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:mb_find_extent+0x8a1/0xe30 fs/ext4/mballoc.c:1869
Code: 3c 30 00 74 08 48 89 ef e8 3c 2c a1 ff 48 8b 6d 00 48 89 ef 48 89 de e8 8d 86 4b ff 48 39 dd 0f 83 2e 01 00 00 e8 3f 84 4b ff <0f> 0b 48 8b 44 24 70 42 80 3c 30 00 74 08 4c 89 ef e8 09 2c a1 ff
RSP: 0018:ffffc90003c9e098 EFLAGS: 00010293
RAX: ffffffff82405731 RBX: 0000000000000041 RCX: ffff8880783457c0
RDX: 0000000000000000 RSI: 0000000000000041 RDI: 0000000000000040
RBP: 0000000000000040 R08: ffffffff82405723 R09: ffffed10053c9402
R10: ffffed10053c9402 R11: 1ffff110053c9401 R12: 0000000000000000
R13: ffffc90003c9e538 R14: dffffc0000000000 R15: ffffc90003c9e2cc
FS:  0000555556665300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056312f6796f8 CR3: 0000000022437000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_mb_complex_scan_group+0x353/0x1100 fs/ext4/mballoc.c:2307
 ext4_mb_regular_allocator+0x1533/0x3860 fs/ext4/mballoc.c:2735
 ext4_mb_new_blocks+0xddf/0x3db0 fs/ext4/mballoc.c:5605
 ext4_ext_map_blocks+0x1868/0x6880 fs/ext4/extents.c:4286
 ext4_map_blocks+0xa49/0x1cc0 fs/ext4/inode.c:651
 ext4_getblk+0x1b9/0x770 fs/ext4/inode.c:864
 ext4_bread+0x2a/0x170 fs/ext4/inode.c:920
 ext4_quota_write+0x225/0x570 fs/ext4/super.c:7105
 write_blk fs/quota/quota_tree.c:64 [inline]
 get_free_dqblk+0x34a/0x6d0 fs/quota/quota_tree.c:130
 do_insert_tree+0x26b/0x1aa0 fs/quota/quota_tree.c:340
 do_insert_tree+0x722/0x1aa0 fs/quota/quota_tree.c:375
 do_insert_tree+0x722/0x1aa0 fs/quota/quota_tree.c:375
 do_insert_tree+0x722/0x1aa0 fs/quota/quota_tree.c:375
 dq_insert_tree fs/quota/quota_tree.c:401 [inline]
 qtree_write_dquot+0x3b6/0x530 fs/quota/quota_tree.c:420
 v2_write_dquot+0x11b/0x190 fs/quota/quota_v2.c:358
 dquot_acquire+0x348/0x670 fs/quota/dquot.c:444
 ext4_acquire_dquot+0x2dc/0x400 fs/ext4/super.c:6740
 dqget+0x999/0xdc0 fs/quota/dquot.c:914
 __dquot_initialize+0x3d0/0xcf0 fs/quota/dquot.c:1492
 ext4_process_orphan+0x57/0x2d0 fs/ext4/orphan.c:329
 ext4_orphan_cleanup+0xb60/0x1340 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5516 [inline]
 ext4_fill_super+0x81cd/0x8700 fs/ext4/super.c:5644
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f019e01bc1a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdd7fabed8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f019e01bc1a
RDX: 0000000020000040 RSI: 0000000020000500 RDI: 00007ffdd7fabee0
RBP: 00007ffdd7fabee0 R08: 00007ffdd7fabf20 R09: 0000000000002dd1
R10: 0000000000000047 R11: 0000000000000206 R12: 0000000000000004
R13: 00005555566652c0 R14: 00007ffdd7fabf20 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
