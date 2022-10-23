Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E6E6091A9
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 09:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJWHaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 03:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJWH3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 03:29:51 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1234821804
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 00:29:45 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id x6-20020a056e021bc600b002fc96f780e7so6811613ilv.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 00:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GJJ0cuFnIzxgKH5KhJ1QGFpWpnqGP8Nd81azvNSCJbE=;
        b=eQZz33/kprZaakhTPisfVNDlxc7RuMSlzTga74mr0YSxJOs3r6UgH74XqYbuJa/wnL
         NYe4vtBpV+HVQbad4AQYreZ9Jf5t0EuRws53Q2gd82HSDIR/wSiVeszHMTiKhjiDDQSS
         G5HlalAqjEPeWm0vYEEx6uWyvDIJaxtRWSFMNEm+VZsCiBKk4RGkITCYhaNJ0JRgKQ36
         5KSHjwy0peaO2Cl+Yqin1jFo4ArqH6/sUHigLa91VGF3ih+Uu+biXDYdSJ29G87niCwM
         fRi0a+sEIgoK1saNiBWfHWPXqrxKfI7MVMfs12uJ/RnXtMx14Bh0fKE0QtW9HskInym3
         ocbQ==
X-Gm-Message-State: ACrzQf2569s8K8YX+oPMAi5K7h72smM/f74MVU2LUP50y8I9uZAaG03d
        qo+qqxJU5iLhSX4tRpvptblOH4JSjKwwHcwv5FJfgBixvH8c
X-Google-Smtp-Source: AMsMyM53qYUw7BQptBKyhOt/mmlz/oxLu/9YIasK4g2VL7DoY8zKA8YVdLzYjmjMWH92oSQUDir8LkFRGp9vCuCYUnvvm7f14Fvu
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160a:b0:2f9:8a30:c3af with SMTP id
 t10-20020a056e02160a00b002f98a30c3afmr18970189ilu.11.1666510185020; Sun, 23
 Oct 2022 00:29:45 -0700 (PDT)
Date:   Sun, 23 Oct 2022 00:29:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097c20205ebaea3d6@google.com>
Subject: [syzbot] general protection fault in nilfs_palloc_commit_free_entry
From:   syzbot <syzbot+ebe05ee8e98f755f61d0@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    440b7895c990 Merge tag 'mm-hotfixes-stable-2022-10-20' of ..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17d3b33c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=afc317c0f52ce670
dashboard link: https://syzkaller.appspot.com/bug?extid=ebe05ee8e98f755f61d0
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15d81572880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=162b0a36880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/105038975fc9/disk-440b7895.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/edd7302c8fc8/vmlinux-440b7895.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/6a01cad872ec/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebe05ee8e98f755f61d0@syzkaller.appspotmail.com

NILFS (loop0): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 3613 Comm: segctord Not tainted 6.1.0-rc1-syzkaller-00158-g440b7895c990 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:nilfs_palloc_commit_free_entry+0xd2/0x570 fs/nilfs2/alloc.c:608
Code: 08 4c 89 f8 48 c1 e8 03 48 89 44 24 18 42 80 3c 20 00 74 08 4c 89 ff e8 4c 36 8b fe 49 8b 2f 48 83 c5 10 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 2f 36 8b fe 48 8b 45 00 48 89 44
RSP: 0018:ffffc90003d8f280 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 1ffff1100e5b4044 RCX: 0000000000002000
RDX: 0000000000001801 RSI: 000000000000000a RDI: 000000000000003d
RBP: 0000000000000010 R08: ffffffff835085a5 R09: ffffed100e093a2a
R10: ffffed100e093a2a R11: 1ffff1100e093a29 R12: dffffc0000000000
R13: 0000000000002000 R14: ffff888072da0222 R15: ffff88802435cba0
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa887c6b1d0 CR3: 000000000c88e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_dat_commit_update+0x25/0x40 fs/nilfs2/dat.c:236
 nilfs_btree_commit_update_v+0x91/0x420 fs/nilfs2/btree.c:1940
 nilfs_btree_commit_propagate_v fs/nilfs2/btree.c:2016 [inline]
 nilfs_btree_propagate_v fs/nilfs2/btree.c:2046 [inline]
 nilfs_btree_propagate+0x972/0xe10 fs/nilfs2/btree.c:2088
 nilfs_bmap_propagate+0x6d/0x120 fs/nilfs2/bmap.c:337
 nilfs_collect_file_data+0x49/0xc0 fs/nilfs2/segment.c:568
 nilfs_segctor_apply_buffers+0x192/0x380 fs/nilfs2/segment.c:1018
 nilfs_segctor_scan_file+0x842/0xaf0 fs/nilfs2/segment.c:1067
 nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1197 [inline]
 nilfs_segctor_collect fs/nilfs2/segment.c:1503 [inline]
 nilfs_segctor_do_construct+0x1d2c/0x6f80 fs/nilfs2/segment.c:2045
 nilfs_segctor_construct+0x143/0x8d0 fs/nilfs2/segment.c:2379
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2487 [inline]
 nilfs_segctor_thread+0x59e/0x11c0 fs/nilfs2/segment.c:2570
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:nilfs_palloc_commit_free_entry+0xd2/0x570 fs/nilfs2/alloc.c:608
Code: 08 4c 89 f8 48 c1 e8 03 48 89 44 24 18 42 80 3c 20 00 74 08 4c 89 ff e8 4c 36 8b fe 49 8b 2f 48 83 c5 10 48 89 e8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 ef e8 2f 36 8b fe 48 8b 45 00 48 89 44
RSP: 0018:ffffc90003d8f280 EFLAGS: 00010202
RAX: 0000000000000002 RBX: 1ffff1100e5b4044 RCX: 0000000000002000
RDX: 0000000000001801 RSI: 000000000000000a RDI: 000000000000003d
RBP: 0000000000000010 R08: ffffffff835085a5 R09: ffffed100e093a2a
R10: ffffed100e093a2a R11: 1ffff1100e093a29 R12: dffffc0000000000
R13: 0000000000002000 R14: ffff888072da0222 R15: ffff88802435cba0
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa887c6b1d0 CR3: 000000000c88e000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 4c 89 f8          	or     %cl,-0x8(%rcx,%rcx,4)
   4:	48 c1 e8 03          	shr    $0x3,%rax
   8:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
   d:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  12:	74 08                	je     0x1c
  14:	4c 89 ff             	mov    %r15,%rdi
  17:	e8 4c 36 8b fe       	callq  0xfe8b3668
  1c:	49 8b 2f             	mov    (%r15),%rbp
  1f:	48 83 c5 10          	add    $0x10,%rbp
  23:	48 89 e8             	mov    %rbp,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 ef             	mov    %rbp,%rdi
  34:	e8 2f 36 8b fe       	callq  0xfe8b3668
  39:	48 8b 45 00          	mov    0x0(%rbp),%rax
  3d:	48                   	rex.W
  3e:	89                   	.byte 0x89
  3f:	44                   	rex.R


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
