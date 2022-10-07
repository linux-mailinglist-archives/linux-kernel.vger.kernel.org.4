Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FF65F7DC0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJGTPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJGTOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:14:44 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A8E26D6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:14:36 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id a15-20020a6b660f000000b006a0d0794ad1so3791907ioc.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 12:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4APzCkPuF600r0PgqvgOnvCjhsuYAH/Jg4lyIp+ByI=;
        b=tahJqVZiuYC1PoaYzBi5JUQjrsBhNJEwUPk9wXAJXEP6nRlymu9U0Prg1Cw+/oF7Oo
         hHxiP18Zp1B4GoLfjB/Y8zbiPA1JqQ089xscBzieA6kydkHJt3+8rdkiaW9ko0IXXxyt
         lZxDsVsyhMBekfZ32k7UuYdbKLN7fBXbt8Qa1f3+Z5SU9CRrqDBDr/LZDxiZ28k5YCTs
         ZACMKu2ojpbBjhJz8bxoODMgRUAaME0XVnLVxPsJYOjzXWe2OH9u4QxnJ/C2mRi3YnqN
         OSgBT2kVg+5/fF2dNFp+vhHaGyCoLa+9a73pJRx6JWezD0e3r3jsHhj/gt190Mw/OeyE
         lO9w==
X-Gm-Message-State: ACrzQf2LcUnkcDibEhBWB+mTPPXyevRnza9sAywPoykR4kA8LBnGmlB4
        uA02Hb01v1TuiIDbeK1iT8rs0xh5nLUTWnvRsJGwb8UimD+o
X-Google-Smtp-Source: AMsMyM5/ZcDTdnJFZvYu9Ur+MDfNC36uSndF/XYziyAsQw+Nt0oTwPoDkSb95/OpySnJHxTAAttc8SgdNFRQC6Kqqnrw9KxRPKHW
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1644:b0:35a:5304:f19f with SMTP id
 a4-20020a056638164400b0035a5304f19fmr3512556jat.270.1665170075858; Fri, 07
 Oct 2022 12:14:35 -0700 (PDT)
Date:   Fri, 07 Oct 2022 12:14:35 -0700
In-Reply-To: <000000000000905ada05ea45e13c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dcbba905ea769e07@google.com>
Subject: Re: [syzbot] WARNING: nested lock was not taken in ntfs_fill_super
From:   syzbot <syzbot+b9bd2bf91ab68a2ab30c@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    4c86114194e6 Merge tag 'iomap-6.1-merge-1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=121dd3f4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9905c889cc4ad738
dashboard link: https://syzkaller.appspot.com/bug?extid=b9bd2bf91ab68a2ab30c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a62cc8880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bf7f1dcd539b/disk-4c861141.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c214481af743/vmlinux-4c861141.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a53514c0308a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b9bd2bf91ab68a2ab30c@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS' sector size (1024) and media sector size (512)
==================================
WARNING: Nested lock was not taken
6.0.0-syzkaller-06475-g4c86114194e6 #0 Not tainted
----------------------------------
syz-executor.0/3971 is trying to lock:
ffff8880721ddb70 (&sb->s_type->i_lock_key#33){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:349 [inline]
ffff8880721ddb70 (&sb->s_type->i_lock_key#33){+.+.}-{2:2}, at: _atomic_dec_and_lock+0x9d/0x110 lib/dec_and_lock.c:28

but this task is not holding:
general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 1 PID: 3971 Comm: syz-executor.0 Not tainted 6.0.0-syzkaller-06475-g4c86114194e6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:print_lock_nested_lock_not_held kernel/locking/lockdep.c:4885 [inline]
RIP: 0010:__lock_acquire+0x1112/0x1f60 kernel/locking/lockdep.c:5044
Code: 3c 30 00 48 8b 5c 24 70 74 12 48 89 df e8 96 42 73 00 49 be 00 00 00 00 00 fc ff df 48 8b 1b 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 6f 42 73 00 48 8b 33 45 31 f6 48
RSP: 0018:ffffc90004bef828 EFLAGS: 00010006
RAX: 0000000000000003 RBX: 0000000000000018 RCX: f3af2e06a081bf00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffff88807f6085e0 R08: ffffffff816af64d R09: ffffed1017364f13
R10: ffffed1017364f13 R11: 1ffff11017364f12 R12: ffff88807f608848
R13: bd0c5e3edb57b21a R14: dffffc0000000000 R15: ffff88807f608000
FS:  00007f4b59f80700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4b59f81000 CR3: 000000007a2ee000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5666
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:349 [inline]
 _atomic_dec_and_lock+0x9d/0x110 lib/dec_and_lock.c:28
 iput+0x85/0x760 fs/inode.c:1765
 ntfs_fill_super+0x3af3/0x42a0 fs/ntfs3/super.c:1190
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4b58e8bada
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4b59f7ff88 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f4b58e8bada
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f4b59f7ffe0
RBP: 00007f4b59f80020 R08: 00007f4b59f80020 R09: 0000000020000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f4b59f7ffe0 R15: 00000000200021c0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:print_lock_nested_lock_not_held kernel/locking/lockdep.c:4885 [inline]
RIP: 0010:__lock_acquire+0x1112/0x1f60 kernel/locking/lockdep.c:5044
Code: 3c 30 00 48 8b 5c 24 70 74 12 48 89 df e8 96 42 73 00 49 be 00 00 00 00 00 fc ff df 48 8b 1b 48 83 c3 18 48 89 d8 48 c1 e8 03 <42> 80 3c 30 00 74 08 48 89 df e8 6f 42 73 00 48 8b 33 45 31 f6 48
RSP: 0018:ffffc90004bef828 EFLAGS: 00010006
RAX: 0000000000000003 RBX: 0000000000000018 RCX: f3af2e06a081bf00
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: ffff88807f6085e0 R08: ffffffff816af64d R09: ffffed1017364f13
R10: ffffed1017364f13 R11: 1ffff11017364f12 R12: ffff88807f608848
R13: bd0c5e3edb57b21a R14: dffffc0000000000 R15: ffff88807f608000
FS:  00007f4b59f80700(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4b59f81000 CR3: 000000007a2ee000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	3c 30                	cmp    $0x30,%al
   2:	00 48 8b             	add    %cl,-0x75(%rax)
   5:	5c                   	pop    %rsp
   6:	24 70                	and    $0x70,%al
   8:	74 12                	je     0x1c
   a:	48 89 df             	mov    %rbx,%rdi
   d:	e8 96 42 73 00       	callq  0x7342a8
  12:	49 be 00 00 00 00 00 	movabs $0xdffffc0000000000,%r14
  19:	fc ff df
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 18          	add    $0x18,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 6f 42 73 00       	callq  0x7342a8
  39:	48 8b 33             	mov    (%rbx),%rsi
  3c:	45 31 f6             	xor    %r14d,%r14d
  3f:	48                   	rex.W

