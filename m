Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B17612C84
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 20:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJ3T5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 15:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ3T5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 15:57:45 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D8D62CC
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 12:57:44 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id l14-20020a056e021c0e00b00300770134f9so8424603ilh.16
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 12:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHMA8Gg/iwPKiBOOxfPFJUkB1J0BiNO9Syw0vRpXZrk=;
        b=Z04Q2DZ5iF4+f2OIufHT9qtxZqlx76ILpdr7cdZNx3hUvFMCGdw9SshwHfMZM/Txd/
         /fFAiI7EYnHpE9Qf8aHrNsWn5Q3SwRkExjUYNCOaxILkERhEJEu2nmt849bCFuN1CLPC
         zLgJspFF2Mf2HkHUEZgKgygzaHaXpBKSMCCi/obNbI1b7N4+0VqdA3wdZGLblUmZv5SH
         LkTYhKgXbK2WXKB/tu8wCi1Ez/O8x3sCEh92qMi2yKnO2ti5Wdstpr51f6aAVg4toqAb
         BAN91Yi4sjSmElHV5XRcWGpXKwhEzGxhzlfX3KuY4iuInj7zEabDNvdM4IKDmxG4dfTG
         /r5Q==
X-Gm-Message-State: ACrzQf2gieHB5yohGz4tQ/+mtul3iunkiREKfewS4ar23z+u0MP38xKa
        +OOpYTiUu+aw+AJwN8AC9+GTuwlKufB+k4mtF6lkPZ965ZZ9
X-Google-Smtp-Source: AMsMyM5JIVKPNBaPy7qlhXEPPXuac75zXNR2kZVCXu/zETbpHgLyF0DHWCbXlq1TNJnGQV5l6NU6gWG8gHjvXIJaA/JNt4d93htY
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3c1:b0:6a4:16a0:984b with SMTP id
 g1-20020a05660203c100b006a416a0984bmr4798321iov.125.1667159863894; Sun, 30
 Oct 2022 12:57:43 -0700 (PDT)
Date:   Sun, 30 Oct 2022 12:57:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078a84b05ec45e73b@google.com>
Subject: [syzbot] general protection fault in mpol_parse_str
From:   syzbot <syzbot+a7f196a1dbf5e2c70568@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    4d48f589d294 Add linux-next specific files for 20221021
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=165e12da880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4b7d600a5739a6
dashboard link: https://syzkaller.appspot.com/bug?extid=a7f196a1dbf5e2c70568
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f10ff6880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=145f1ff2880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0c86bd0b39a0/disk-4d48f589.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/074059d37f1f/vmlinux-4d48f589.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a7f196a1dbf5e2c70568@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 3609 Comm: syz-executor110 Not tainted 6.1.0-rc1-next-20221021-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:strchr+0x17/0xa0 lib/string.c:329
Code: 48 89 34 24 e8 5a 37 82 f8 48 8b 34 24 eb 9a 0f 1f 40 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc90003c3fad0 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: 1ffff92000787f77 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000000000000003a RDI: 0000000000000000
RBP: 1ffff92000787f62 R08: 0000000000000005 R09: 0000000000000009
R10: 0000000000000003 R11: 000000000008c001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88807e7e3b90 R15: dffffc0000000000
FS:  0000555557488300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001000 CR3: 00000000268e7000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 mpol_parse_str+0x79/0xa90 mm/mempolicy.c:2992
 shmem_parse_one+0x7d8/0xa60 mm/shmem.c:3508
 vfs_parse_fs_param fs/fs_context.c:148 [inline]
 vfs_parse_fs_param+0x1f9/0x3c0 fs/fs_context.c:129
 vfs_parse_fs_string+0xdb/0x170 fs/fs_context.c:191
 shmem_parse_options+0x15f/0x240 mm/shmem.c:3570
 do_new_mount fs/namespace.c:3036 [inline]
 path_mount+0x12de/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f34b3ddeb19
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdebbcaee8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f34b3ddeb19
RDX: 0000000020000080 RSI: 0000000020000040 RDI: 0000000000000000
RBP: 00007f34b3da2cc0 R08: 0000000020000100 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f34b3da2d50
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:strchr+0x17/0xa0 lib/string.c:329
Code: 48 89 34 24 e8 5a 37 82 f8 48 8b 34 24 eb 9a 0f 1f 40 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 55 48 c1 ea 03 53 48 83 ec 10 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 04 84 c0 75 51 0f b6 07 89
RSP: 0018:ffffc90003c3fad0 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: 1ffff92000787f77 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 000000000000003a RDI: 0000000000000000
RBP: 1ffff92000787f62 R08: 0000000000000005 R09: 0000000000000009
R10: 0000000000000003 R11: 000000000008c001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff88807e7e3b90 R15: dffffc0000000000
FS:  0000555557488300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f34b3e51270 CR3: 00000000268e7000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 34 24          	mov    %rsi,(%rsp)
   4:	e8 5a 37 82 f8       	callq  0xf8823763
   9:	48 8b 34 24          	mov    (%rsp),%rsi
   d:	eb 9a                	jmp    0xffffffa9
   f:	0f 1f 40 00          	nopl   0x0(%rax)
  13:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  1a:	fc ff df
  1d:	48 89 fa             	mov    %rdi,%rdx
  20:	55                   	push   %rbp
  21:	48 c1 ea 03          	shr    $0x3,%rdx
  25:	53                   	push   %rbx
  26:	48 83 ec 10          	sub    $0x10,%rsp
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	48 89 fa             	mov    %rdi,%rdx
  31:	83 e2 07             	and    $0x7,%edx
  34:	38 d0                	cmp    %dl,%al
  36:	7f 04                	jg     0x3c
  38:	84 c0                	test   %al,%al
  3a:	75 51                	jne    0x8d
  3c:	0f b6 07             	movzbl (%rdi),%eax
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
