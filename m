Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F1F6274D6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbiKNDL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbiKNDLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:11:52 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72509DFD9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:11:51 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id j20-20020a056e02219400b00300a22a7fe0so8512460ila.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plKmkDO4y+S3nTgLqqqXRWXSZPFO4qJ96/+1wRFN/hY=;
        b=it5Mjl2laROjtXIIDL3yDF5gNE5g0BIqRNfe4nVHUjMrdGFMMdeTpa9F6CsHZoSiEL
         88/JJ+lnFGfge1c4VgcAoMQqM7wnkZEhjklx83tCG3ZjvAHCjNO6OE0bM4KhBFTtRq+p
         3+nLnHMoRZhL5wGBQq7kcC3Zz8XNW05WemlLzdnecWxVagxsAG4WBEeEzQ/Z6RZWz6Os
         y1VJJejfZaHlkVv1BLNd65+v+H0N+gyR7QzgcUoBc4t9RGSpdnYNR/WrglKBvlkUx8Re
         rkIWnbN0CHLEoG7iY++9gwhyercquFWFWFszoTYoBbfOTSxOkFJUmNCd+NMxJs9HziW5
         hIwQ==
X-Gm-Message-State: ANoB5pmgyoaBPMFSp6wpcexxFZosJuD+pCcUmBjGKttJyuQ9hoxkQgg/
        NvsWOo3XnmuDJgxXoAO9N3Kp20npYxJIKzM2bthQmg49Uyoy
X-Google-Smtp-Source: AA0mqf6MNFAmcajyelXzm+ov3xiz/DmIj+TE0V1R2TkbYDEMi+lljbMlh6TJsR+yjiLliCXDFJZtFcQl3b/f1DaJWG347wFcKzk0
MIME-Version: 1.0
X-Received: by 2002:a5d:8751:0:b0:6d1:832:50a1 with SMTP id
 k17-20020a5d8751000000b006d1083250a1mr4714889iol.68.1668395510838; Sun, 13
 Nov 2022 19:11:50 -0800 (PST)
Date:   Sun, 13 Nov 2022 19:11:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4bef605ed65992d@google.com>
Subject: [syzbot] general protection fault in shm_close
From:   syzbot <syzbot+83b4134621b7c326d950@syzkaller.appspotmail.com>
To:     Liam.Howlett@Oracle.com, akpm@linux-foundation.org,
        alexander.mikhalitsyn@virtuozzo.com, linux-kernel@vger.kernel.org,
        manfred@colorfullife.com, mike.kravetz@oracle.com,
        syzkaller-bugs@googlegroups.com, willy@infradead.org
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

HEAD commit:    f8f60f322f06 Add linux-next specific files for 20221111
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15599bd5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85ba52c07cd97289
dashboard link: https://syzkaller.appspot.com/bug?extid=83b4134621b7c326d950
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a05e71880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11de4db9880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6008df424195/disk-f8f60f32.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/394340525f66/vmlinux-f8f60f32.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b13604a3343a/bzImage-f8f60f32.xz

The issue was bisected to:

commit 6a892ddb84e542931554f4ee9a528190003b23a0
Author: Mike Kravetz <mike.kravetz@oracle.com>
Date:   Thu Nov 10 00:21:50 2022 +0000

    ipc/shm: call underlying open/close vm_ops

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a0f199880000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a0f199880000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a0f199880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+83b4134621b7c326d950@syzkaller.appspotmail.com
Fixes: 6a892ddb84e5 ("ipc/shm: call underlying open/close vm_ops")

general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 PID: 5247 Comm: syz-executor310 Not tainted 6.1.0-rc4-next-20221111-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:shm_close+0xbf/0x740 ipc/shm.c:378
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 1c 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5d 18 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 db 05 00 00 48 8b 5b 08 48 85 db 74 0a e8 99 7c
RSP: 0018:ffffc90003e0fba0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83bf5016 RDI: 0000000000000008
RBP: ffff8880296a2d40 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000000000000 R12: ffff8880263fb1c0
R13: ffffffff8c7a97a0 R14: 0000000000000008 R15: ffffc90003e0fca0
FS:  0000555555992300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fde9cc15348 CR3: 0000000025865000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 shm_mmap+0x1c2/0x230 ipc/shm.c:604
 call_mmap include/linux/fs.h:2164 [inline]
 mmap_region+0x6bf/0x1dc0 mm/mmap.c:2625
 do_mmap+0x825/0xf50 mm/mmap.c:1412
 do_shmat+0xe33/0x10c0 ipc/shm.c:1661
 __do_sys_shmat ipc/shm.c:1697 [inline]
 __se_sys_shmat ipc/shm.c:1692 [inline]
 __x64_sys_shmat+0xcc/0x160 ipc/shm.c:1692
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fde9cba2cf9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff3ed491f8 EFLAGS: 00000246 ORIG_RAX: 000000000000001e
RAX: ffffffffffffffda RBX: 000000000000cfd6 RCX: 00007fde9cba2cf9
RDX: ffffffffffffcfff RSI: 0000000020000000 RDI: 0000000000000008
RBP: 0000000000000000 R08: 00007fff3ed49398 R09: 00007fff3ed49398
R10: 00007fff3ed48c70 R11: 0000000000000246 R12: 00007fff3ed4920c
R13: 431bde82d7b634db R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:shm_close+0xbf/0x740 ipc/shm.c:378
Code: 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 1c 06 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5d 18 48 8d 7b 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 db 05 00 00 48 8b 5b 08 48 85 db 74 0a e8 99 7c
RSP: 0018:ffffc90003e0fba0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffffffff83bf5016 RDI: 0000000000000008
RBP: ffff8880296a2d40 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000000000000 R12: ffff8880263fb1c0
R13: ffffffff8c7a97a0 R14: 0000000000000008 R15: ffffc90003e0fca0
FS:  0000555555992300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff3ed491d8 CR3: 0000000025865000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	48 89 fa             	mov    %rdi,%rdx
   3:	48 c1 ea 03          	shr    $0x3,%rdx
   7:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   b:	0f 85 1c 06 00 00    	jne    0x62d
  11:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  18:	fc ff df
  1b:	48 8b 5d 18          	mov    0x18(%rbp),%rbx
  1f:	48 8d 7b 08          	lea    0x8(%rbx),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 db 05 00 00    	jne    0x60f
  34:	48 8b 5b 08          	mov    0x8(%rbx),%rbx
  38:	48 85 db             	test   %rbx,%rbx
  3b:	74 0a                	je     0x47
  3d:	e8                   	.byte 0xe8
  3e:	99                   	cltd
  3f:	7c                   	.byte 0x7c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
