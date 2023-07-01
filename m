Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4BD744802
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 10:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjGAITX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 04:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjGAISa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 04:18:30 -0400
Received: from mail-pl1-f208.google.com (mail-pl1-f208.google.com [209.85.214.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA5A1731
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 01:18:12 -0700 (PDT)
Received: by mail-pl1-f208.google.com with SMTP id d9443c01a7336-1b855dc0f0cso26179675ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 01:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688199492; x=1690791492;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kl2x0AU2cVQ7FABz0Ni0VamxuimXbmE6PGKzfnhMtgg=;
        b=Pr74lbxInNLPqB90zWSBtgsLEpNQS4okGbaaaAtpmpq+9AFjUz9NV2eGtpnpdTC9Cy
         iTjHLTj/1Ogp5nh1WpltnhWV3F0+EqIUGkmDxxh4PYHYULgeaKxidJ6CTn9JU2rwHdTK
         BRG3DF06GdX9/C34AMOgIi+vCoFgZU+DD/iGyGz9V6l7NrYraJQb/QkVW8RkFzozmvlh
         tppy3uIPt0SW9As2reG/2oWihQXTt6D3b2SQpnTxMXiEaty9sAuNCwIDi1RcCpyNRzzp
         zje0d57A6mIxfKhOAi/t39Psm0vA057/eIY8dnjNX+pBoWIdd8ERMJUx13xCYCYTA5DW
         X5Jg==
X-Gm-Message-State: ABy/qLatFWrGJa4h0WMqYa6TrDk9tT8Zh9V+/mikvzDIef38TBzDy8xz
        xeeBXCKVGZPtfNuIuvYXf9CrzrZY+Vosx8S5TIpy5PUAodxH
X-Google-Smtp-Source: APBJJlGccHk7QEpk/UvKZCBy/s3KpeQDJmQrdgCA3vn/un1ZtCcypYiO4dbHyGYlRoL5PUrPtJ7Q65nSoscavg0DxZX/aY2bdtbU
MIME-Version: 1.0
X-Received: by 2002:a17:903:905:b0:1ae:531f:366a with SMTP id
 ll5-20020a170903090500b001ae531f366amr2974798plb.5.1688199492420; Sat, 01 Jul
 2023 01:18:12 -0700 (PDT)
Date:   Sat, 01 Jul 2023 01:18:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e4cc105ff68937b@google.com>
Subject: [syzbot] [modules?] KASAN: invalid-access Read in init_module_from_file
From:   syzbot <syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, chris@chrisdown.name,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        llvm@lists.linux.dev, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    533925cb7604 Merge tag 'riscv-for-linus-6.5-mw1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=151dba0ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=998aa1e85d118b55
dashboard link: https://syzkaller.appspot.com/bug?extid=e3705186451a87fd93b8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a4eb98a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ec1a6f280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03caccccf2c4/disk-533925cb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2fc5ec527ecb/vmlinux-533925cb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1c17e9d79ab7/bzImage-533925cb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e3705186451a87fd93b8@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000038-0x000000000000003f]
CPU: 1 PID: 5014 Comm: syz-executor823 Not tainted 6.4.0-syzkaller-08881-g533925cb7604 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:idempotent kernel/module/main.c:3078 [inline]
RIP: 0010:init_module_from_file+0x1c1/0x6a0 kernel/module/main.c:3124
Code: 0f 84 c0 01 00 00 e8 7e ee 12 00 4d 89 e7 49 83 ef 08 74 61 e8 70 ee 12 00 4c 89 fa 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 59 04 00 00 4d 3b 2f 0f 84 ae 00 00 00 e8 47 ee
RSP: 0018:ffffc900033ffd28 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 000000000000002e RCX: 0000000000000000
RDX: 0000000000000007 RSI: ffffffff8170eaa0 RDI: ffffc9000336fe28
RBP: ffff88807adaa280 R08: 0000000000000001 R09: fffff5200067ff97
R10: 0000000000000003 R11: 0000000000000001 R12: ffffc9000336fe28
R13: ffff8880752b54c0 R14: ffffffff91f19290 R15: 000000000000003e
FS:  0000555556cec3c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000073bff000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __do_sys_finit_module kernel/module/main.c:3171 [inline]
 __se_sys_finit_module kernel/module/main.c:3154 [inline]
 __x64_sys_finit_module+0xfd/0x190 kernel/module/main.c:3154
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4b273fcfa9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd7aa7c1f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000000000018ef9 RCX: 00007f4b273fcfa9
RDX: 0000000000000002 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd7aa7c2ac
R13: 00007ffd7aa7c2e0 R14: 00007ffd7aa7c2c0 R15: 000000000000000a
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:idempotent kernel/module/main.c:3078 [inline]
RIP: 0010:init_module_from_file+0x1c1/0x6a0 kernel/module/main.c:3124
Code: 0f 84 c0 01 00 00 e8 7e ee 12 00 4d 89 e7 49 83 ef 08 74 61 e8 70 ee 12 00 4c 89 fa 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 59 04 00 00 4d 3b 2f 0f 84 ae 00 00 00 e8 47 ee
RSP: 0018:ffffc900033ffd28 EFLAGS: 00010203
RAX: dffffc0000000000 RBX: 000000000000002e RCX: 0000000000000000
RDX: 0000000000000007 RSI: ffffffff8170eaa0 RDI: ffffc9000336fe28
RBP: ffff88807adaa280 R08: 0000000000000001 R09: fffff5200067ff97
R10: 0000000000000003 R11: 0000000000000001 R12: ffffc9000336fe28
R13: ffff8880752b54c0 R14: ffffffff91f19290 R15: 000000000000003e
FS:  0000555556cec3c0(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000073bff000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	0f 84 c0 01 00 00    	je     0x1c6
   6:	e8 7e ee 12 00       	callq  0x12ee89
   b:	4d 89 e7             	mov    %r12,%r15
   e:	49 83 ef 08          	sub    $0x8,%r15
  12:	74 61                	je     0x75
  14:	e8 70 ee 12 00       	callq  0x12ee89
  19:	4c 89 fa             	mov    %r15,%rdx
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 59 04 00 00    	jne    0x48d
  34:	4d 3b 2f             	cmp    (%r15),%r13
  37:	0f 84 ae 00 00 00    	je     0xeb
  3d:	e8                   	.byte 0xe8
  3e:	47 ee                	rex.RXB out %al,(%dx)


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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
