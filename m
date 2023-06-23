Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B4473BA4B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjFWOgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFWOgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:36:46 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DBF122
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:36:44 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-76998d984b0so45302539f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531004; x=1690123004;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BPJBUiwFpdoZ7Bry7AP+alEey2lFLJLHxoPG3eAFiE=;
        b=OommXc4B8tf10vJ+csuDy3UeICPAMWzMM9W9LEXrqevSYwDWdEhRsBz3XkrB3N1YIB
         geDNczhYJBL2+zINCcFLi2rSgctMxF2TaVpvcNNcEDx7EXhzrjEWAzjqrQtSVxUpMtEK
         Cb5D2nmBpU/2k5989Bf2MGsZ3NaUMAGq3BYaBhxto59DYJLc/HkS21V8JX1k34HIQuKR
         r/br+oL2F74Focp5qsQmW+T0NgUe3cUOrVSr+qNZ5q08tuIwsZQbThLSsG2XTuUuwv9g
         IaRb6Imoc0yLF7kNKzYAfjK03AUPqn4o0fOhPU3HhIEhoc8E+xjli1arLio16XVOh21A
         aOjQ==
X-Gm-Message-State: AC+VfDy8FPDpiii1sas4kFXvAX85qvfm7Bv4Un1OPEBIADboMmnub/mD
        uPv0gLQSvY10+D6h8zDWbi2rHC3Pm5j4C0L0V3E3ywCA8iTr
X-Google-Smtp-Source: ACHHUZ5kuj5oj7s883gyENP1mt5AJ/EftciZqZO/wM2/USxBBGsSZ+s697iT0su7hivUNU99FdXtmTJcv4mtRc3moWx1pwzGivIB
MIME-Version: 1.0
X-Received: by 2002:a02:95c8:0:b0:40f:d35a:56e4 with SMTP id
 b66-20020a0295c8000000b0040fd35a56e4mr7691173jai.4.1687531004159; Fri, 23 Jun
 2023 07:36:44 -0700 (PDT)
Date:   Fri, 23 Jun 2023 07:36:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ced8905fecceeba@google.com>
Subject: [syzbot] [crypto?] general protection fault in shash_async_update
From:   syzbot <syzbot+0bc501b7bf9e1bc09958@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    26a4dd839eeb selftests: net: vxlan: Fix selftest regressio..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=169f932d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=0bc501b7bf9e1bc09958
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13f71275280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11081055280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b8b1725013b/disk-26a4dd83.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b9906d975821/vmlinux-26a4dd83.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b968b241eeb1/bzImage-26a4dd83.xz

The issue was bisected to:

commit c662b043cdca89bf0f03fc37251000ac69a3a548
Author: David Howells <dhowells@redhat.com>
Date:   Tue Jun 6 13:08:56 2023 +0000

    crypto: af_alg/hash: Support MSG_SPLICE_PAGES

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1023cfdf280000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1223cfdf280000
console output: https://syzkaller.appspot.com/x/log.txt?x=1423cfdf280000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0bc501b7bf9e1bc09958@syzkaller.appspotmail.com
Fixes: c662b043cdca ("crypto: af_alg/hash: Support MSG_SPLICE_PAGES")

general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 0 PID: 5005 Comm: syz-executor418 Not tainted 6.4.0-rc5-syzkaller-01111-g26a4dd839eeb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
RIP: 0010:crypto_shash_alg include/crypto/hash.h:827 [inline]
RIP: 0010:crypto_shash_update crypto/shash.c:124 [inline]
RIP: 0010:shash_ahash_update crypto/shash.c:306 [inline]
RIP: 0010:shash_async_update+0x130/0x210 crypto/shash.c:314
Code: 36 0c a5 fd 48 8b 44 24 08 48 8b 6c 24 48 80 38 00 0f 85 c3 00 00 00 48 8b 04 24 4c 8b 68 50 49 8d 7d 20 48 89 fa 48 c1 ea 03 <80> 3c 1a 00 0f 85 bd 00 00 00 4d 8b 75 20 49 8d 7e 2c 48 89 fa 48
RSP: 0018:ffffc90003a1f968 EFLAGS: 00010202
RAX: ffff8880206b02a8 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffffffff83df3a1a RDI: 0000000000000020
RBP: ffff888072b43240 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000dc0 R11: 0000000000000009 R12: 0000000000000dc0
R13: 0000000000000000 R14: 1ffff110040d605f R15: ffff8880206b02f8
FS:  0000555557028300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4ef51f2304 CR3: 000000001328b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 crypto_ahash_update include/crypto/hash.h:608 [inline]
 hash_sendmsg+0x434/0xde0 crypto/algif_hash.c:139
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 ____sys_sendmsg+0x733/0x920 net/socket.c:2493
 ___sys_sendmsg+0x110/0x1b0 net/socket.c:2547
 __sys_sendmsg+0xf7/0x1c0 net/socket.c:2576
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f71e8ca1c89
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffebca0c5d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f71e8ca1c89
RDX: 0000000000000000 RSI: 0000000020000300 RDI: 0000000000000004
RBP: 00007f71e8c65e30 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f71e8c65ec0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:crypto_shash_alg include/crypto/hash.h:827 [inline]
RIP: 0010:crypto_shash_update crypto/shash.c:124 [inline]
RIP: 0010:shash_ahash_update crypto/shash.c:306 [inline]
RIP: 0010:shash_async_update+0x130/0x210 crypto/shash.c:314
Code: 36 0c a5 fd 48 8b 44 24 08 48 8b 6c 24 48 80 38 00 0f 85 c3 00 00 00 48 8b 04 24 4c 8b 68 50 49 8d 7d 20 48 89 fa 48 c1 ea 03 <80> 3c 1a 00 0f 85 bd 00 00 00 4d 8b 75 20 49 8d 7e 2c 48 89 fa 48
RSP: 0018:ffffc90003a1f968 EFLAGS: 00010202
RAX: ffff8880206b02a8 RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000004 RSI: ffffffff83df3a1a RDI: 0000000000000020
RBP: ffff888072b43240 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000dc0 R11: 0000000000000009 R12: 0000000000000dc0
R13: 0000000000000000 R14: 1ffff110040d605f R15: ffff8880206b02f8
FS:  0000555557028300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffebcaca020 CR3: 000000001328b000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	36 0c a5             	ss or  $0xa5,%al
   3:	fd                   	std
   4:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
   9:	48 8b 6c 24 48       	mov    0x48(%rsp),%rbp
   e:	80 38 00             	cmpb   $0x0,(%rax)
  11:	0f 85 c3 00 00 00    	jne    0xda
  17:	48 8b 04 24          	mov    (%rsp),%rax
  1b:	4c 8b 68 50          	mov    0x50(%rax),%r13
  1f:	49 8d 7d 20          	lea    0x20(%r13),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 1a 00          	cmpb   $0x0,(%rdx,%rbx,1) <-- trapping instruction
  2e:	0f 85 bd 00 00 00    	jne    0xf1
  34:	4d 8b 75 20          	mov    0x20(%r13),%r14
  38:	49 8d 7e 2c          	lea    0x2c(%r14),%rdi
  3c:	48 89 fa             	mov    %rdi,%rdx
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
