Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE0074C188
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 10:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGIIIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 04:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGIIIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 04:08:00 -0400
Received: from mail-pl1-f207.google.com (mail-pl1-f207.google.com [209.85.214.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A60131
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 01:07:59 -0700 (PDT)
Received: by mail-pl1-f207.google.com with SMTP id d9443c01a7336-1b890ca6718so40590325ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 01:07:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688890079; x=1691482079;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nd3uSjNKuE7BWMfjfmt+wKYq5hLbp7/q30OF1Uv44do=;
        b=XMkrNjZ3XCUCK80pjkmb06jB6svqBkGj7a2SuYdmntUeGCUKZM0vV+lRbBEjTidyFo
         r6s74r+agfUSIzn8OkJL06i5SSemYGQtrOJ+KsP4oF2Kjxfsji7tKSlz0JFaDTcVMF2o
         9JoHMU/LCmAUanuLEAUh4p6dYaG8COSqfLiaF8GR0Ks1VGYpOfaL8Bz06FMu35KHLrVx
         mXTaDWZMq3NOr5+hpiqLJaQzc9hy9bd/aUF18SBQ/aKY1osLxTvzQUdm9K3toFXSx50R
         buvo4l4vfdf9d0RD+5a6GRP3BqbVYKEMe9txOMm+RdyzUwrURa/cMGnEDK9h/s+mWREX
         br5w==
X-Gm-Message-State: ABy/qLZWoQ07cbdJ61RxLPcLwoSFIA13eYWejxL2FcWFldol+qWFYZDu
        2SesBiooKxMgQsoe8qvqA2s3tyiRs4KYdQ8Gsfs5IQ002Wwz
X-Google-Smtp-Source: APBJJlHvtG6yW7gnsh0O+fH2j8v4XKhFwUYPFJEgZPdnZxHuMlqfwdNc6ZomHWvmNDj+aO633qoc8G73f3teVBeay/jCXuq7qmCO
MIME-Version: 1.0
X-Received: by 2002:a17:902:d312:b0:1b8:8b6e:6431 with SMTP id
 b18-20020a170902d31200b001b88b6e6431mr8349288plc.12.1688890078835; Sun, 09
 Jul 2023 01:07:58 -0700 (PDT)
Date:   Sun, 09 Jul 2023 01:07:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000036b9590600095d33@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in sco_conn_add
From:   syzbot <syzbot+37acd5d80d00d609d233@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3674fbf0451d Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13ab3f4f280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9bf1936936ca698
dashboard link: https://syzkaller.appspot.com/bug?extid=37acd5d80d00d609d233
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1049b4e2a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171aa228a80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/42ed556782c3/disk-3674fbf0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1913e16e8565/vmlinux-3674fbf0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/469804b58a7c/bzImage-3674fbf0.xz

The issue was bisected to:

commit 06149746e7203d5ffe2d6faf9799ee36203aa8b8
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Tue Apr 11 23:02:22 2023 +0000

    Bluetooth: hci_conn: Add support for linking multiple hcon

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=148e6b08a80000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=168e6b08a80000
console output: https://syzkaller.appspot.com/x/log.txt?x=128e6b08a80000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+37acd5d80d00d609d233@syzkaller.appspotmail.com
Fixes: 06149746e720 ("Bluetooth: hci_conn: Add support for linking multiple hcon")

RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f09bc777879
RDX: 0000000000000008 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000800000015
R10: 0000000000000000 R11: 0000000000000246 R12: 0000555555a6d2b8
R13: 00007ffe17db6850 R14: 0000000000000072 R15: 00007ffe17db6860
 </TASK>
general protection fault, probably for non-canonical address 0xdffffc000000013b: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000009d8-0x00000000000009df]
CPU: 1 PID: 5013 Comm: syz-executor238 Not tainted 6.4.0-rc7-syzkaller-01944-g3674fbf0451d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:sco_conn_add+0x2a/0x330 net/bluetooth/sco.c:127
Code: 41 57 41 56 41 55 49 89 fd 41 54 55 49 8d ad d8 09 00 00 53 e8 b7 f1 5a f8 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 8b 02 00 00 4d 8b a5 d8 09 00 00 4d 85 e4 74 13
RSP: 0018:ffffc90003a8fd50 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888028830000 RCX: 0000000000000000
RDX: 000000000000013b RSI: ffffffff892957a9 RDI: 0000000000000000
RBP: 00000000000009d8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8880203cf540 R15: ffff888028830010
FS:  0000555555a6d300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f09bc7db6e3 CR3: 0000000025e98000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 sco_connect net/bluetooth/sco.c:274 [inline]
 sco_sock_connect+0x321/0xae0 net/bluetooth/sco.c:610
 __sys_connect_file+0x153/0x1a0 net/socket.c:1991
 __sys_connect+0x165/0x1a0 net/socket.c:2008
 __do_sys_connect net/socket.c:2018 [inline]
 __se_sys_connect net/socket.c:2015 [inline]
 __x64_sys_connect+0x73/0xb0 net/socket.c:2015
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f09bc777879
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe17db67f8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f09bc777879
RDX: 0000000000000008 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 0000000000000003 R08: 0000000000000001 R09: 0000000800000015
R10: 0000000000000000 R11: 0000000000000246 R12: 0000555555a6d2b8
R13: 00007ffe17db6850 R14: 0000000000000072 R15: 00007ffe17db6860
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:sco_conn_add+0x2a/0x330 net/bluetooth/sco.c:127
Code: 41 57 41 56 41 55 49 89 fd 41 54 55 49 8d ad d8 09 00 00 53 e8 b7 f1 5a f8 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 8b 02 00 00 4d 8b a5 d8 09 00 00 4d 85 e4 74 13
RSP: 0018:ffffc90003a8fd50 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff888028830000 RCX: 0000000000000000
RDX: 000000000000013b RSI: ffffffff892957a9 RDI: 0000000000000000
RBP: 00000000000009d8 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000010 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8880203cf540 R15: ffff888028830010
FS:  0000555555a6d300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005653cab3d008 CR3: 0000000025e98000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	41 57                	push   %r15
   2:	41 56                	push   %r14
   4:	41 55                	push   %r13
   6:	49 89 fd             	mov    %rdi,%r13
   9:	41 54                	push   %r12
   b:	55                   	push   %rbp
   c:	49 8d ad d8 09 00 00 	lea    0x9d8(%r13),%rbp
  13:	53                   	push   %rbx
  14:	e8 b7 f1 5a f8       	callq  0xf85af1d0
  19:	48 89 ea             	mov    %rbp,%rdx
  1c:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  23:	fc ff df
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 8b 02 00 00    	jne    0x2bf
  34:	4d 8b a5 d8 09 00 00 	mov    0x9d8(%r13),%r12
  3b:	4d 85 e4             	test   %r12,%r12
  3e:	74 13                	je     0x53


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
