Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3F46F48C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233582AbjEBRCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjEBRCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:02:54 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B571B5
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 10:02:52 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-766588051b3so262194639f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 10:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683046972; x=1685638972;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JJeaFtmH2fk9RUSUQnpnmtuaWPMFGX7ILZ2hXmErup0=;
        b=XL7P/wAK6yNYt1luRIsDOZMjQpVZ43FSWGlaV22F0LgVfmzxNOs9iJ23tr4u14IKoD
         xmnWMr7WRoO8UqkeS1Ju6/Sg631eVNK82Ol2qyhAwHsFO/mSl2hxjPPKJ943WHFCCRat
         JpG+4C5JdI5A8hl3LZu5tJvwUanJCvjP6lbFIaw8kVdWHbsL/iN4yznYdz0nptHZYaWy
         XBdlx2wJutsepBt18kY60ABiJGmYIleMTkCxlQurMQjenEqtRRqlW+E7dTnEhDqP5tVb
         6ZIakM5nrKadbQlkURJiJCKL4HXumJQ8MYYhNRaG3LsNGQ/+K3dD0d7Gr1ItRIpKpWQD
         Psow==
X-Gm-Message-State: AC+VfDwyA7UB/s6gMJB8ZCEmMZRnEqbZFhHhtgbMiAo8teXz4+LU5aQC
        OHhoS67eLLdEhgagnc2zkQmAAOav4jqdzZTxoaLdqbuZYx0+
X-Google-Smtp-Source: ACHHUZ44Xi8uqVv1GswyRuEPF5SjG73sx8Ar1qjUDZ1SBIKmbxN67uTmq5hmw0ckxetT/UH57A5GEVZWUQZWNcVCUjijJ3+8gO6R
MIME-Version: 1.0
X-Received: by 2002:a6b:a0a:0:b0:763:5ea0:f95b with SMTP id
 z10-20020a6b0a0a000000b007635ea0f95bmr8465839ioi.4.1683046971709; Tue, 02 May
 2023 10:02:51 -0700 (PDT)
Date:   Tue, 02 May 2023 10:02:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3a0f805fab8e8e6@google.com>
Subject: [syzbot] [kernel?] WARNING in track_pfn_remap
From:   syzbot <syzbot+1e407db5a3bf19236f09@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de, buddy.zhang@biscuitos.cn,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    92e815cf07ed Add linux-next specific files for 20230428
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12fd3e1c280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8c8ae4d47d23592
dashboard link: https://syzkaller.appspot.com/bug?extid=1e407db5a3bf19236f09
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=150cb844280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fc570c280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c9e94856e6c9/disk-92e815cf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4c1c05a548a7/vmlinux-92e815cf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2a1bff6a133b/bzImage-92e815cf.xz

The issue was bisected to:

commit 4406ea87ff2003e2c233c208ca7e23d90f6a6fba
Author: buddy.zhang <buddy.zhang@biscuitos.cn>
Date:   Sun Mar 19 03:37:50 2023 +0000

    mm: keep memory type same on DEVMEM Page-Fault

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10479a30280000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12479a30280000
console output: https://syzkaller.appspot.com/x/log.txt?x=14479a30280000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1e407db5a3bf19236f09@syzkaller.appspotmail.com
Fixes: 4406ea87ff20 ("mm: keep memory type same on DEVMEM Page-Fault")

binder: 5004:5004 ioctl c0306201 20001480 returned -14
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5004 at include/linux/mmap_lock.h:71 mmap_assert_write_locked include/linux/mmap_lock.h:71 [inline]
WARNING: CPU: 0 PID: 5004 at include/linux/mmap_lock.h:71 __is_vma_write_locked include/linux/mm.h:708 [inline]
WARNING: CPU: 0 PID: 5004 at include/linux/mmap_lock.h:71 vma_start_write include/linux/mm.h:722 [inline]
WARNING: CPU: 0 PID: 5004 at include/linux/mmap_lock.h:71 vm_flags_set include/linux/mm.h:819 [inline]
WARNING: CPU: 0 PID: 5004 at include/linux/mmap_lock.h:71 track_pfn_remap+0x3f4/0x4c0 arch/x86/mm/pat/memtype.c:1002
Modules linked in:
CPU: 0 PID: 5004 Comm: syz-executor151 Not tainted 6.3.0-next-20230428-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
RIP: 0010:mmap_assert_write_locked include/linux/mmap_lock.h:71 [inline]
RIP: 0010:__is_vma_write_locked include/linux/mm.h:708 [inline]
RIP: 0010:vma_start_write include/linux/mm.h:722 [inline]
RIP: 0010:vm_flags_set include/linux/mm.h:819 [inline]
RIP: 0010:track_pfn_remap+0x3f4/0x4c0 arch/x86/mm/pat/memtype.c:1002
Code: 9c 49 00 49 8d bc 24 68 01 00 00 31 f6 e8 e4 38 d4 08 31 ff 89 c3 89 c6 e8 a9 98 49 00 85 db 0f 85 31 fe ff ff e8 7c 9c 49 00 <0f> 0b e9 25 fe ff ff e8 70 9c 49 00 4c 89 e7 e8 68 0d 85 00 0f 0b
RSP: 0018:ffffc90003b7f590 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88802597bb80 RSI: ffffffff813ab144 RDI: 0000000000000005
RBP: ffff88802a296500 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000000000b R12: ffff88807de14800
R13: 0000000000000000 R14: ffff88802a296510 R15: 0000000000001000
FS:  0000555555981300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000749ae000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vm_insert_page+0x4a8/0x840 mm/memory.c:2020
 binder_update_page_range+0x2f7/0x1680 drivers/android/binder_alloc.c:260
 binder_alloc_new_buf_locked drivers/android/binder_alloc.c:487 [inline]
 binder_alloc_new_buf+0xd83/0x1d80 drivers/android/binder_alloc.c:571
 binder_transaction+0x242e/0x9800 drivers/android/binder.c:3207
 binder_thread_write drivers/android/binder.c:3991 [inline]
 binder_ioctl_write_read drivers/android/binder.c:5047 [inline]
 binder_ioctl+0x336f/0x9390 drivers/android/binder.c:5333
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x197/0x210 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc185f2d3c9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 11 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdbd426028 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fc185f2d3c9
RDX: 0000000020000100 RSI: 00000000c0306201 RDI: 0000000000000004
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000006 R11: 0000000000000246 R12: 00007ffdbd426070
R13: 00007ffdbd426060 R14: 00007ffdbd426050 R15: 0000000000000000
 </TASK>


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
