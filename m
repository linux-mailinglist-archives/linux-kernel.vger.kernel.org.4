Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E7E748F00
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjGEUh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGEUhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:37:54 -0400
Received: from mail-pf1-f207.google.com (mail-pf1-f207.google.com [209.85.210.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538DF19A3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 13:37:53 -0700 (PDT)
Received: by mail-pf1-f207.google.com with SMTP id d2e1a72fcca58-666ecb21f16so107776b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 13:37:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688589473; x=1691181473;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9XLjkf8Ikb/Rx4SZu/rmBOTBowd8bPT1mCgve+haets=;
        b=K4npuYVXQDUAFOT1hCIX16OxhLWmUB4JILZo9Ez0aMLkxpohtUx8e3JSFbwaG7AVB/
         jaVGB8owzFrLflxnYk8ZqK79Ih9SLb1wqZnMS0wmZYJlGPu7P4je7BDOPlqiqnFQfM43
         rVnKy/vgeBerdapQHfHOhZ4GPTeE6/zzRQEqMf3vnEsf5d5qta4WfO6RR9MEY1T5+dXm
         G1j3pAJAg1mwKtZGmv4Gb+uWLty6wNgjkG0Dm9teYoFsWphOOwpUTKssUWqgThm+Uxy3
         vFTezwM9v+UOqA2IjfjqdfFwjTu/p4rzDuXJ8LW/2Pc0fRAShCCJgCJlDt5deFRHO0mI
         R+nQ==
X-Gm-Message-State: ABy/qLZhTVkKaOKnfHodaEfpn1ueDSYFRT9r0629MDUQIwnTT6Goc4cq
        B+In3sCUZtgKnj2xV5jyQ6m4iCwtXqVKuxcXUAafAH/maTbn
X-Google-Smtp-Source: APBJJlH0P+oE4qXXd4ST8GMu3SMM1UTJRDnFbONZzlcOl5ebvG/U1ruHsI4qH4pgLVFiIBjLm1Aa+Z5HVNBx2nRJ6DZSqWwufNVh
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:1404:b0:682:5630:4b11 with SMTP id
 l4-20020a056a00140400b0068256304b11mr46075pfu.0.1688589472848; Wed, 05 Jul
 2023 13:37:52 -0700 (PDT)
Date:   Wed, 05 Jul 2023 13:37:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b35ea205ffc35fe1@google.com>
Subject: [syzbot] [mm?] kernel BUG in validate_mm (2)
From:   syzbot <syzbot+70b97abe3e253d1c3f8e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179c302ca80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f5e1158c5b2f83bb
dashboard link: https://syzkaller.appspot.com/bug?extid=70b97abe3e253d1c3f8e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1511d490a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130e5cfb280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/07a995e5618a/disk-a901a356.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad2efb29f1e0/vmlinux-a901a356.xz
kernel image: https://storage.googleapis.com/syzbot-assets/74fa7ac85d25/bzImage-a901a356.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/77e05f49bdce/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+70b97abe3e253d1c3f8e@syzkaller.appspotmail.com

start_code 7f8413e4b000 end_code 7f8413ee5b31 start_data 7f8413f13e50 end_data 7f8413f193b0
start_brk 5555561bf000 brk 5555561e1000 start_stack 7fffb37e2480
arg_start 7fffb37e2efb arg_end 7fffb37e2f14 env_start 7fffb37e2f14 env_end 7fffb37e2fdf
binfmt ffffffff8cba2c20 flags 7fd
ioctx_table 0000000000000000
owner ffff88802a200000 exe_file ffff88802a0d0a00
notifier_subscriptions 0000000000000000
numa_next_scan 4294941906 numa_scan_offset 0 numa_scan_seq 0
tlb_flush_pending 0
def_flags: 0x0()
------------[ cut here ]------------
kernel BUG at mm/mmap.c:340!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 6821 Comm: syz-executor191 Not tainted 6.4.0-syzkaller-10173-ga901a3568fd2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
RIP: 0010:validate_mm+0x3a0/0x470 mm/mmap.c:340
Code: 24 48 e8 93 39 fb ff e9 fc fd ff ff e8 09 e1 be ff 44 89 fa 89 ee 48 c7 c7 a0 d3 78 8a e8 88 89 a2 ff 48 89 df e8 a0 17 fb ff <0f> 0b e8 e9 e0 be ff 48 8b 7c 24 18 e8 8f 17 fb ff c6 05 34 fa cd
RSP: 0018:ffffc9000c297aa0 EFLAGS: 00010282
RAX: 000000000000032f RBX: ffff888078fa0000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8169097c RDI: 0000000000000005
RBP: 0000000000000013 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 00007fffb37f9000
R13: 0000000000000000 R14: 00007fffb37fafff R15: 0000000000000012
FS:  00007f8413e41700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f840b9ff718 CR3: 000000001bb00000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 do_vmi_align_munmap+0x1199/0x1680 mm/mmap.c:2561
 do_vmi_munmap+0x266/0x430 mm/mmap.c:2619
 __vm_munmap+0x137/0x380 mm/mmap.c:2899
 __do_sys_munmap mm/mmap.c:2916 [inline]
 __se_sys_munmap mm/mmap.c:2913 [inline]
 __x64_sys_munmap+0x62/0x80 mm/mmap.c:2913
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8413e94f97
Code: 00 00 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb 85 66 2e 0f 1f 84 00 00 00 00 00 90 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8413e41168 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f8413e94f97
RDX: 0000000000010000 RSI: 0000000000010000 RDI: 00007f840ba00000
RBP: 00007f840ba00000 R08: 0000000000000000 R09: 000000000000028b
R10: 0000000000010000 R11: 0000000000000246 R12: 00007f8413e416b8
R13: 00007f8413e41180 R14: 00007f8413e411c0 R15: 00007f8413f196e8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:validate_mm+0x3a0/0x470 mm/mmap.c:340
Code: 24 48 e8 93 39 fb ff e9 fc fd ff ff e8 09 e1 be ff 44 89 fa 89 ee 48 c7 c7 a0 d3 78 8a e8 88 89 a2 ff 48 89 df e8 a0 17 fb ff <0f> 0b e8 e9 e0 be ff 48 8b 7c 24 18 e8 8f 17 fb ff c6 05 34 fa cd
RSP: 0018:ffffc9000c297aa0 EFLAGS: 00010282
RAX: 000000000000032f RBX: ffff888078fa0000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8169097c RDI: 0000000000000005
RBP: 0000000000000013 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 00007fffb37f9000
R13: 0000000000000000 R14: 00007fffb37fafff R15: 0000000000000012
FS:  00007f8413e41700(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffb37e2238 CR3: 000000001bb00000 CR4: 0000000000350ee0


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
