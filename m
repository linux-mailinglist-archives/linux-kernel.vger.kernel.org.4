Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 593A273385B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjFPSwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjFPSwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:52:20 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D02D2962
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:52:19 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-76c6c1b16d2so81925839f.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686941538; x=1689533538;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jkNKm4d+xEP4UEqOCzmeH2YNPxY5o0tfyzYgnlA0BP0=;
        b=DgxcwzLendiKRiJ4PHMVowYUKq3Hnh6AE1U30b76+btsSUq9d86FaaWXfPBqkKKWmO
         ZK99B4qYpPsrFC06pHwYS3qLi1xDWYmeuA681yK6+CI3D9VOWIyGHuofpBGiHR/jPOz3
         yifQmlpPCjxSlFGNgWuROYRObGpuiGhN17R89g2myxIqMnlFgYeUgs55eHwCTkVR00vq
         OmSTrZ7yytpTtGz//yRkJHIorsjLYFUf4X2yWiJliWreHxp30KkeP9dTHlzxh+JLEuiS
         hljZy+TqVV+DkAmDZpNqUqK2olsMphHMdcjS0433RJfdfjW8edYRZVNNj2BxSuFW5xOI
         bWvg==
X-Gm-Message-State: AC+VfDw2+c3S/Pk9Om/FMEnUqlDOUFtfkm4MVvvqNdnRb2NtJXBmEaj3
        ar0An3koyqTl4rkHY4t/1pfk32OPI5UE43lML4qDsW9+wiLLzQhcGw==
X-Google-Smtp-Source: ACHHUZ61/AFUHXrWQHtPeewt9iOOZt8Wluvk8aFxxb3GHa2BQUaMo/5/92JOIs2CtGv3qf3XN8BgG/SipIIn3pGMGdWKJKOWoG4K
MIME-Version: 1.0
X-Received: by 2002:a02:b114:0:b0:423:1273:ae33 with SMTP id
 r20-20020a02b114000000b004231273ae33mr3025jah.1.1686941538674; Fri, 16 Jun
 2023 11:52:18 -0700 (PDT)
Date:   Fri, 16 Jun 2023 11:52:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b6ab405fe43af4a@google.com>
Subject: [syzbot] [kernel?] possible deadlock in exit_itimers
From:   syzbot <syzbot+5fd924f4cd9dc1c7828c@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
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

HEAD commit:    f7efed9f38f8 Add linux-next specific files for 20230616
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=124a65f7280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60b1a32485a77c16
dashboard link: https://syzkaller.appspot.com/bug?extid=5fd924f4cd9dc1c7828c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1401d8ef280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=176b45cf280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95bcbee03439/disk-f7efed9f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6fd295caa4de/vmlinux-f7efed9f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69c038a34b5f/bzImage-f7efed9f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5fd924f4cd9dc1c7828c@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.4.0-rc6-next-20230616-syzkaller #0 Not tainted
--------------------------------------------
syz-executor196/6178 is trying to acquire lock:
ffff88801eccb640 (&new_timer->it_lock){-.-.}-{2:2}, at: itimer_delete kernel/time/posix-timers.c:1049 [inline]
ffff88801eccb640 (&new_timer->it_lock){-.-.}-{2:2}, at: exit_itimers+0x2ac/0x540 kernel/time/posix-timers.c:1109

but task is already holding lock:
ffff88801eccb640 (&new_timer->it_lock){-.-.}-{2:2}, at: __lock_timer+0x1cc/0x4d0 kernel/time/posix-timers.c:595

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&new_timer->it_lock);
  lock(&new_timer->it_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

1 lock held by syz-executor196/6178:
 #0: ffff88801eccb640 (&new_timer->it_lock){-.-.}-{2:2}, at: __lock_timer+0x1cc/0x4d0 kernel/time/posix-timers.c:595

stack backtrace:
CPU: 1 PID: 6178 Comm: syz-executor196 Not tainted 6.4.0-rc6-next-20230616-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3070 [inline]
 validate_chain kernel/locking/lockdep.c:3863 [inline]
 __lock_acquire+0x2a33/0x5e20 kernel/locking/lockdep.c:5144
 lock_acquire.part.0+0x11c/0x370 kernel/locking/lockdep.c:5761
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x3d/0x60 kernel/locking/spinlock.c:162
 itimer_delete kernel/time/posix-timers.c:1049 [inline]
 exit_itimers+0x2ac/0x540 kernel/time/posix-timers.c:1109
 do_exit+0x630/0x2a30 kernel/exit.c:848
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5dc8cc4dd9
Code: 00 49 c7 c0 b8 ff ff ff be e7 00 00 00 ba 3c 00 00 00 eb 12 0f 1f 44 00 00 89 d0 0f 05 48 3d 00 f0 ff ff 77 1c f4 89 f0 0f 05 <48> 3d 00 f0 ff ff 76 e7 f7 d8 64 41 89 00 eb df 0f 1f 80 00 00 00
RSP: 002b:00007ffe0c959208 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f5dc8d4f210 RCX: 00007f5dc8cc4dd9
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffffffffffb8 R09: 00007f5dc8d151cf
R10: 00007ffe0c959290 R11: 0000000000000246 R12: 00007f5dc8d4f210
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>


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
