Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A9065AA2D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 15:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjAAOfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 09:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAAOfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 09:35:41 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE675273B
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 06:35:39 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id e9-20020a056e020b2900b003036757d5caso16403744ilu.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 06:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WMm/K8xaIHVk0Lz2o7NVjkuPcVl3Ys6u1ZK/wrNVBYI=;
        b=oFRTo6UkwYy7t6vCd8uBdWveJ7sKqSOrRRGW2edNxIoCj70fgZy59ixoRVN/oyQWS9
         XoJLEeZu1jw6SFlfrH6RDFFiqPHpkvWJlzIRYg7jOCIkMyQISennsJ/TaL4/f0BvlE4r
         aCZwzFFTdrHeeTsKtfGOC06QKyV3Sd4jGaH73MwBBMorb5DJFgSZytsj40yX1sWge1LW
         RZNIU/jr29o+m7GxkcjaLI/d4xwUAn+iaJJl4t/aLGAI8CBG/EUZMm4cX/FCtr2y5pJL
         R33/CzoqtG7H1pznh6ga0YhrarZpyIyvpDbyvm5URq0ZCpDlR3omnbWrQyElxF0hTYrF
         59SA==
X-Gm-Message-State: AFqh2kp2XtvrYzRtUHRH8n0f49hr6hoiuCSB3jXDteAC8cF29Je6PAR6
        pLkwtcYVM+i7Yz06NCp+R7zgBFCg1cJRunWvY7Hz4gCHK0Zv
X-Google-Smtp-Source: AMrXdXs3vx7CJq6joliBi/ZMK1u5twozAS3sa5yWt4evrMay92GHf6vTLPyn9HKdeVEmGrucNk1eDqA5rrE3Zpm/5f6tw5Knwr5X
MIME-Version: 1.0
X-Received: by 2002:a02:9641:0:b0:375:bdba:52b with SMTP id
 c59-20020a029641000000b00375bdba052bmr3618289jai.271.1672583739073; Sun, 01
 Jan 2023 06:35:39 -0800 (PST)
Date:   Sun, 01 Jan 2023 06:35:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fea9505f134bf4d@google.com>
Subject: [syzbot] [reiserfs?] general protection fault in direct2indirect
From:   syzbot <syzbot+e69a9406662c63f12e24@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
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

HEAD commit:    1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13690f08480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=e69a9406662c63f12e24
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112c5f40480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1360b86c480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d8c5072480f/disk-1b929c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46687f1395db/vmlinux-1b929c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26f1afa5ec00/bzImage-1b929c02.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3ddbc376b1d3/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e69a9406662c63f12e24@syzkaller.appspotmail.com

REISERFS (device loop0): Using r5 hash to sort names
REISERFS (device loop0): using 3.5.x disk format
REISERFS (device loop0): Created .reiserfs_priv - reserved for xattr storage.
REISERFS warning: reiserfs-5093 is_leaf: item entry count seems wrong *3.5*[2 1 0(1) DIR], item_len 35, item_location 4029, free_space(entry_count) 2
REISERFS error (device loop0): vs-5150 search_by_key: invalid format found in block 549. Fsck?
REISERFS (device loop0): Remounting filesystem read-only
general protection fault, probably for non-canonical address 0xdffffc0000000005: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 0 PID: 5068 Comm: syz-executor435 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:reiserfs_node_data fs/reiserfs/reiserfs.h:2184 [inline]
RIP: 0010:item_head fs/reiserfs/reiserfs.h:2200 [inline]
RIP: 0010:tp_item_head fs/reiserfs/reiserfs.h:2226 [inline]
RIP: 0010:direct2indirect+0x916/0x17c0 fs/reiserfs/tail_conversion.c:119
Code: 48 8b 04 24 4a 8d 5c 38 10 48 89 d8 48 c1 e8 03 0f b6 04 10 84 c0 0f 85 43 03 00 00 48 63 1b 49 83 c6 28 4c 89 f0 48 c1 e8 03 <80> 3c 10 00 74 12 4c 89 f7 e8 8c 8a b2 ff 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003c7f100 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000000 RCX: ffff888021c93a80
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000008
RBP: ffffc90003c7f270 R08: ffffffff822ef83e R09: ffffffff822e1c5d
R10: 0000000000000002 R11: ffff888021c93a80 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000028 R15: 0000000000000010
FS:  0000555555b8a3c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000208 CR3: 000000002a8a2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 reiserfs_get_block+0x4c9a/0x5180 fs/reiserfs/inode.c:949
 __block_write_begin_int+0x54c/0x1a80 fs/buffer.c:1991
 reiserfs_write_begin+0x247/0x510 fs/reiserfs/inode.c:2775
 generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3772
 __generic_file_write_iter+0x176/0x400 mm/filemap.c:3900
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3932
 call_write_iter include/linux/fs.h:2186 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f709ad71ed9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd885a00d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007ffd885a00e8 RCX: 00007f709ad71ed9
RDX: 00000000175d900f RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00007ffd885a00e0 R08: 00007ffd885a00e0 R09: 00007f709ad2f490
R10: 00007ffd885a00e0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:reiserfs_node_data fs/reiserfs/reiserfs.h:2184 [inline]
RIP: 0010:item_head fs/reiserfs/reiserfs.h:2200 [inline]
RIP: 0010:tp_item_head fs/reiserfs/reiserfs.h:2226 [inline]
RIP: 0010:direct2indirect+0x916/0x17c0 fs/reiserfs/tail_conversion.c:119
Code: 48 8b 04 24 4a 8d 5c 38 10 48 89 d8 48 c1 e8 03 0f b6 04 10 84 c0 0f 85 43 03 00 00 48 63 1b 49 83 c6 28 4c 89 f0 48 c1 e8 03 <80> 3c 10 00 74 12 4c 89 f7 e8 8c 8a b2 ff 48 ba 00 00 00 00 00 fc
RSP: 0018:ffffc90003c7f100 EFLAGS: 00010206
RAX: 0000000000000005 RBX: 0000000000000000 RCX: ffff888021c93a80
RDX: dffffc0000000000 RSI: 0000000000000001 RDI: 0000000000000008
RBP: ffffc90003c7f270 R08: ffffffff822ef83e R09: ffffffff822e1c5d
R10: 0000000000000002 R11: ffff888021c93a80 R12: 0000000000000001
R13: 0000000000000000 R14: 0000000000000028 R15: 0000000000000010
FS:  0000555555b8a3c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000208 CR3: 000000002a8a2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 8b 04 24          	mov    (%rsp),%rax
   4:	4a 8d 5c 38 10       	lea    0x10(%rax,%r15,1),%rbx
   9:	48 89 d8             	mov    %rbx,%rax
   c:	48 c1 e8 03          	shr    $0x3,%rax
  10:	0f b6 04 10          	movzbl (%rax,%rdx,1),%eax
  14:	84 c0                	test   %al,%al
  16:	0f 85 43 03 00 00    	jne    0x35f
  1c:	48 63 1b             	movslq (%rbx),%rbx
  1f:	49 83 c6 28          	add    $0x28,%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	80 3c 10 00          	cmpb   $0x0,(%rax,%rdx,1) <-- trapping instruction
  2e:	74 12                	je     0x42
  30:	4c 89 f7             	mov    %r14,%rdi
  33:	e8 8c 8a b2 ff       	callq  0xffb28ac4
  38:	48                   	rex.W
  39:	ba 00 00 00 00       	mov    $0x0,%edx
  3e:	00 fc                	add    %bh,%ah


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
