Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C34613876
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiJaNyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiJaNy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:54:29 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8445F009
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:54:28 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id k6-20020a92c246000000b00300a1de59baso2676190ilo.23
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy0BqrfxXh9AmFKLXonEJ2kEwDj1bZkc3LbrZQE3PYc=;
        b=V6qQBgys1+xo7nz8AbTb0IzAhUzq8ImNKn0hmqVoxoJUVi9rn3D6OLRHzYovZ0nLYh
         A0w6bwnF29FjdAzyhpFlKtoMtS8OyDFjTh09/91POVH9ZkBHCpDDY28zlugAgbgGS/Ij
         UbcUb12vFxiqjIdLU0r0LvGx0XELLd5c/NPCjixXxiTcqaH53UJEcg3G9lZMVIdHCYC1
         982BL4mIREG5Cq0ynXhk6HymQpD1gpYZ8yZkPcNKoHJjBYw3I7I4ByTKxoYbExUnMgC4
         eKr0ev+PNtAFjIE+kqQ/0FSHvH3QBXLeeRLYADnF1y9M224jRE0BmzFwqJk5UewNrOgH
         nCOw==
X-Gm-Message-State: ACrzQf19OAXAXnLU77jwQ4l+6D605kyd4+UNs10RIoCUduGmwQU1FPfI
        nJGGt4Jdg+EkoEYNpPIMd8psNw1GCgI3eNK9FRyAy99yKUa+
X-Google-Smtp-Source: AMsMyM6yGtYUs9DOfAdcSu3r7ETxmyVSOL5JnwqwiTf62mIcEwy41oJ1aK/1/DKl97+DH/Wu9GJpPBGAAAff2r5/CBqPDU3VVtGz
MIME-Version: 1.0
X-Received: by 2002:a05:6638:134f:b0:372:8558:1e34 with SMTP id
 u15-20020a056638134f00b0037285581e34mr7375479jad.285.1667224468291; Mon, 31
 Oct 2022 06:54:28 -0700 (PDT)
Date:   Mon, 31 Oct 2022 06:54:28 -0700
In-Reply-To: <20221031071038.3704-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031856505ec54f237@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Write in dbgfs_rm_context_write
From:   syzbot <syzbot+6087eafb76a94c4ac9eb@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in dbgfs_rm_context_write

general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 4159 Comm: syz-executor.0 Not tainted 6.1.0-rc2-syzkaller-00078-g98555239e4c3-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:dbgfs_rm_context mm/damon/dbgfs.c:900 [inline]
RIP: 0010:dbgfs_rm_context_write+0x155/0x4c0 mm/damon/dbgfs.c:971
Code: a1 c1 a7 ff 45 85 e4 0f 85 ca 02 00 00 e8 c3 c4 a7 ff 48 8b 1d 5c 86 52 0f 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 1f 03 00 00 48 8b 2b 48 85 ed 0f 84 8e 02 00 00
RSP: 0018:ffffc9000596fcb0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000010 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff81d4d7bd RDI: 0000000000000005
RBP: 0000000020000040 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000008c07e R12: 0000000000000000
R13: ffff88806d41a000 R14: ffffc9000596fec8 R15: ffffffffffffffea
FS:  00007f469e46e700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f469d7a80c0 CR3: 000000007ebb7000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 full_proxy_write+0x118/0x180 fs/debugfs/file.c:236
 vfs_write+0x2d7/0xdd0 fs/read_write.c:582
 ksys_write+0x127/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f469d68b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f469e46e168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f469d7abf80 RCX: 00007f469d68b5a9
RDX: 0000000000000188 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007f469d6e67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffab8c608f R14: 00007f469e46e300 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dbgfs_rm_context mm/damon/dbgfs.c:900 [inline]
RIP: 0010:dbgfs_rm_context_write+0x155/0x4c0 mm/damon/dbgfs.c:971
Code: a1 c1 a7 ff 45 85 e4 0f 85 ca 02 00 00 e8 c3 c4 a7 ff 48 8b 1d 5c 86 52 0f 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85 1f 03 00 00 48 8b 2b 48 85 ed 0f 84 8e 02 00 00
RSP: 0018:ffffc9000596fcb0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000010 RCX: 0000000000000000
RDX: 0000000000000002 RSI: ffffffff81d4d7bd RDI: 0000000000000005
RBP: 0000000020000040 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000008c07e R12: 0000000000000000
R13: ffff88806d41a000 R14: ffffc9000596fec8 R15: ffffffffffffffea
FS:  00007f469e46e700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f469e44d718 CR3: 000000007ebb7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 4 bytes skipped:
   0:	45 85 e4             	test   %r12d,%r12d
   3:	0f 85 ca 02 00 00    	jne    0x2d3
   9:	e8 c3 c4 a7 ff       	callq  0xffa7c4d1
   e:	48 8b 1d 5c 86 52 0f 	mov    0xf52865c(%rip),%rbx        # 0xf528671
  15:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1c:	fc ff df
  1f:	48 89 da             	mov    %rbx,%rdx
  22:	48 c1 ea 03          	shr    $0x3,%rdx
* 26:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2a:	0f 85 1f 03 00 00    	jne    0x34f
  30:	48 8b 2b             	mov    (%rbx),%rbp
  33:	48 85 ed             	test   %rbp,%rbp
  36:	0f 84 8e 02 00 00    	je     0x2ca


Tested on:

commit:         98555239 Merge tag 'arc-6.1-fixes' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12222096880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=6087eafb76a94c4ac9eb
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15f025ce880000

