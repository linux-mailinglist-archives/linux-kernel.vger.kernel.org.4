Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC6A735AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjFSPNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjFSPNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:13:10 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0878ECF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:13:06 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77e41268d40so61928739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 08:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687187585; x=1689779585;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jyFVmqBaL9tzP6gZC0ApVM37V8GWLqlm9xlh6ygkQU=;
        b=ft/Idg4RlJxeekd7wri6Odbljhyw7NdlneCB+3f+YibvANnAWJJEINkUtHpXSIgpSE
         UVR4SAD4lR7Cn6smOYldSC7PS1dB2kxV0p3u3HG5JYXdppVczFEW5tQmzI1Eq0rwhtOQ
         LZWDqAFfgEUqpMXZyb+W5jLa1qnn9ERyGfdilvnht55AjHZBueG6J7Zam2674QcYLq6w
         rEaairNgtRln//C7DqHzoMBh1dxcM5GmHsZMVgzo1oxflOI5VT9dTvwXNYOYymS4xtQv
         dbIX4RfP1Kfnp1p2huXxh3mfnfchVWZxs+FDJrDCAlgOVngLSte2uRNXyRDmTtV+8/4b
         kCUg==
X-Gm-Message-State: AC+VfDyQJxjWL+h4S9Q+gHY4tUACe1cB5PzpcvyT5w3G2Db+DZgYbCEZ
        teskLlnbVMqs+hglhV4vLLUz5tE+Ar2YMC5AW9E8UdaLYn+d
X-Google-Smtp-Source: ACHHUZ7yw5ANpziOmZmSbPy7KA/egmV63Cgms/IuPaFbmIKctqoz2Q6kGgS/ufVLDNgwmxvn3SExn6TPMs6M42QsoRWI8dR08laZ
MIME-Version: 1.0
X-Received: by 2002:a02:b041:0:b0:426:792a:ec72 with SMTP id
 q1-20020a02b041000000b00426792aec72mr569307jah.0.1687187585322; Mon, 19 Jun
 2023 08:13:05 -0700 (PDT)
Date:   Mon, 19 Jun 2023 08:13:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1536a05fe7cf8d7@google.com>
Subject: [syzbot] [mm?] linux-next boot error: kernel BUG in do_vmi_align_munmap
From:   syzbot <syzbot+733c8795eb2aa33f16ea@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    47045630bc40 Add linux-next specific files for 20230619
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1234edd3280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4d4487f51524098
dashboard link: https://syzkaller.appspot.com/bug?extid=733c8795eb2aa33f16ea
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/25b62e9481a2/disk-47045630.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f91ca35f7434/vmlinux-47045630.xz
kernel image: https://storage.googleapis.com/syzbot-assets/91d5ca09f47f/bzImage-47045630.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+733c8795eb2aa33f16ea@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/mmap.c:2439!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 4836 Comm: dhcpcd Not tainted 6.4.0-rc7-next-20230619-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:do_vmi_align_munmap+0xb11/0x15f0 mm/mmap.c:2439
Code: 48 89 c3 e8 91 04 be ff 4c 89 ee 4c 89 e7 e8 f6 ca 44 08 48 85 c0 49 89 c6 74 11 e8 79 04 be ff 4c 39 f3 74 c6 e8 6f 04 be ff <0f> 0b 44 8b 7c 24 34 4c 63 74 24 60 4c 8b 64 24 70 e8 59 04 be ff
RSP: 0018:ffffc9000383fb98 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88802a2e7900 RCX: 0000000000000000
RDX: ffff888076a68000 RSI: ffffffff81c65fd1 RDI: ffffc9000383fe80
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffc9000383fe70
R13: 00007f7c240c1fff R14: ffff88802a2e7500 R15: ffffc9000383fca0
FS:  00007f7c240c2740(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7c24293b90 CR3: 000000002bd4c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 do_vmi_munmap+0x26e/0x2c0 mm/mmap.c:2543
 __vm_munmap+0x137/0x3b0 mm/mmap.c:2825
 __do_sys_munmap mm/mmap.c:2850 [inline]
 __se_sys_munmap mm/mmap.c:2847 [inline]
 __x64_sys_munmap+0x62/0x80 mm/mmap.c:2847
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7c24293b97
Code: b8 09 00 00 00 0f 05 48 3d 00 f0 ff ff 76 0c f7 d8 89 05 dc 46 01 00 48 83 c8 ff c3 0f 1f 80 00 00 00 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8d 0d b9 46 01 00 f7 d8 89 01 48 83
RSP: 002b:00007ffc3b8cb328 EFLAGS: 00000206 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 000055a934fd0e30 RCX: 00007f7c24293b97
RDX: 00007ffc3b8cb270 RSI: 0000000000004030 RDI: 00007f7c240bd000
RBP: 00007ffc3b8cb420 R08: 00007ffc3b8cb270 R09: 00007ffc3b8cb350
R10: 00007ffc3b8cb2b0 R11: 0000000000000206 R12: 00007f7c242a7000
R13: 0000000000000000 R14: 000055a934fd0e30 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:do_vmi_align_munmap+0xb11/0x15f0 mm/mmap.c:2439
Code: 48 89 c3 e8 91 04 be ff 4c 89 ee 4c 89 e7 e8 f6 ca 44 08 48 85 c0 49 89 c6 74 11 e8 79 04 be ff 4c 39 f3 74 c6 e8 6f 04 be ff <0f> 0b 44 8b 7c 24 34 4c 63 74 24 60 4c 8b 64 24 70 e8 59 04 be ff
RSP: 0018:ffffc9000383fb98 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88802a2e7900 RCX: 0000000000000000
RDX: ffff888076a68000 RSI: ffffffff81c65fd1 RDI: ffffc9000383fe80
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffffc9000383fe70
R13: 00007f7c240c1fff R14: ffff88802a2e7500 R15: ffffc9000383fca0
FS:  00007f7c240c2740(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7c24293b90 CR3: 000000002bd4c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
