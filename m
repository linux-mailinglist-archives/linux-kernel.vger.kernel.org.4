Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD96652DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiLUIPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiLUIOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:14:44 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A7218A6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:14:41 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id z200-20020a6bc9d1000000b006e003aecf04so6564481iof.16
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2hEJ8Vk6VhQOriMSNYFRk+JxhG+wzUPG7jT8fXgKkE8=;
        b=W+kMVIc4NFPhd81Wq2c/oXI3WIVNkBcNkAele0yLdZyhcGXLHmbQtUEQhxL8gaBziQ
         wurEJz/d9eHGhGp5CdskaItGzr8xgo/cPaZ2SS15Iat0oPB202LjP3ZbzeZnCWhB3SGx
         W10hDLFHkoC+LhimV9OBlEOHtHzwPoP4hon+MYRShP/LHZnifZmMPHfGsGbfcdtJvvoj
         Wb2xT4Lz1yS6n6TrDal/GcUZQxTlD0qwuf4I7vbTlrBsNb6gFV55MbZAUQnX1k1rTdB/
         v9CnjmTzMZCJ+WK1uS5UfdPBgTctwFO7a342mw0G177uhgub+GbrTUUg0b2UiN8PR1tZ
         ZEXA==
X-Gm-Message-State: AFqh2kp1E4O6EE++FGi6JWWkQ2AAIX5jlfnAKv+JNc7Wr/+waFlJ/nuH
        j+9UZmRwlfcNnWoUhxGXVYKBO0QY56I5Z1x/LivMeQdM4IVA
X-Google-Smtp-Source: AMrXdXtdWgdKvU1CaLXqSSAfcqDlmj8XaqKpGKVARlB4yc+WwNxMTe5oJ0SDneW8H0vVf0ptipRB9dJIwN7+WKW+kxB0bUXuev2O
MIME-Version: 1.0
X-Received: by 2002:a02:c728:0:b0:399:6200:63dc with SMTP id
 h8-20020a02c728000000b00399620063dcmr54730jao.194.1671610481289; Wed, 21 Dec
 2022 00:14:41 -0800 (PST)
Date:   Wed, 21 Dec 2022 00:14:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0af6305f05224d8@google.com>
Subject: [syzbot] [ntfs3?] general protection fault in ntfs_security_init
From:   syzbot <syzbot+f1a57e2f7ecadf4fe2cd@syzkaller.appspotmail.com>
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

Hello,

syzbot found the following issue on:

HEAD commit:    e45fb347b630 Add linux-next specific files for 20221220
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11ebe9d7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ae91cba504b4da8
dashboard link: https://syzkaller.appspot.com/bug?extid=f1a57e2f7ecadf4fe2cd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11079eb3880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c68630480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1ae2b280f860/disk-e45fb347.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/253fc221144a/vmlinux-e45fb347.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e2695a52406f/bzImage-e45fb347.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/03bbfbf19079/mount_3.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f1a57e2f7ecadf4fe2cd@syzkaller.appspotmail.com

memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=5070 'syz-executor189'
loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS' sector size (4096) and media sector size (512)
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5070 Comm: syz-executor189 Not tainted 6.1.0-next-20221220-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:ntfs_security_init+0x26e/0xad0 fs/ntfs3/fsntfs.c:1879
Code: 44 24 08 83 f8 1f 0f 86 a4 06 00 00 e8 1b 52 d1 fe 49 01 ec e8 13 52 d1 fe 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 14 02 4c 89 e0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 0f
RSP: 0018:ffffc90003b9fa78 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88807612a000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82b002cd RDI: 0000000000000005
RBP: ffff8880791aa160 R08: 0000000000000005 R09: 000000000000001f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8880735744b0 R14: ffffc90003b9fad0 R15: ffff88807612a460
FS:  000055555681e3c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c0 CR3: 000000007cd11000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ntfs_fill_super+0x3398/0x3ab0 fs/ntfs3/super.c:1287
 get_tree_bdev+0x444/0x760 fs/super.c:1282
 vfs_get_tree+0x8d/0x2f0 fs/super.c:1489
 do_new_mount fs/namespace.c:3145 [inline]
 path_mount+0x132a/0x1e20 fs/namespace.c:3475
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount fs/namespace.c:3674 [inline]
 __x64_sys_mount+0x283/0x300 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f6957d4530a
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc02858c98 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007f6957d4530a
RDX: 000000002001f180 RSI: 000000002001f1c0 RDI: 00007ffc02858cb0
RBP: 00007ffc02858cb0 R08: 00007ffc02858cf0 R09: 000000000001f164
R10: 0000000000000000 R11: 0000000000000286 R12: 0000000000000005
R13: 000055555681e380 R14: 0000000000000000 R15: 00007ffc02858cf0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ntfs_security_init+0x26e/0xad0 fs/ntfs3/fsntfs.c:1879
Code: 44 24 08 83 f8 1f 0f 86 a4 06 00 00 e8 1b 52 d1 fe 49 01 ec e8 13 52 d1 fe 4c 89 e2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 14 02 4c 89 e0 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 0f
RSP: 0018:ffffc90003b9fa78 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff88807612a000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff82b002cd RDI: 0000000000000005
RBP: ffff8880791aa160 R08: 0000000000000005 R09: 000000000000001f
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8880735744b0 R14: ffffc90003b9fad0 R15: ffff88807612a460
FS:  000055555681e3c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c0 CR3: 000000007cd11000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	44 24 08             	rex.R and $0x8,%al
   3:	83 f8 1f             	cmp    $0x1f,%eax
   6:	0f 86 a4 06 00 00    	jbe    0x6b0
   c:	e8 1b 52 d1 fe       	callq  0xfed1522c
  11:	49 01 ec             	add    %rbp,%r12
  14:	e8 13 52 d1 fe       	callq  0xfed1522c
  19:	4c 89 e2             	mov    %r12,%rdx
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2e:	4c 89 e0             	mov    %r12,%rax
  31:	83 e0 07             	and    $0x7,%eax
  34:	83 c0 03             	add    $0x3,%eax
  37:	38 d0                	cmp    %dl,%al
  39:	7c 08                	jl     0x43
  3b:	84 d2                	test   %dl,%dl
  3d:	0f                   	.byte 0xf
  3e:	85 0f                	test   %ecx,(%rdi)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
