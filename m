Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D0962DE70
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240554AbiKQOlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbiKQOki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:40:38 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6315DBA4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:38:48 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bj12so5435392ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wljf+GOpACKcVehQ7hmzv1XcoP3kAZP3bt/nUIQRBPA=;
        b=YAG3PBDMWrZ+AC+zKfhh4Lf5hNy46134AN4Ck7CkS+0ODJ6V+vQbD39LgNe+nv0+1G
         kT7TioGW3fMW7uXNYqLifPntlVZrQbfR/O+EFZOri5dKwjQEUIG3N7GBhvnOcqaINDP8
         vIyGotxIbcfiSOdm8hobdO9qnQSSNCuNbVwbnFClx2U030CuUuXnOuvc6jkb+DIiARao
         nzkPH0F0tuaquw8Pllq9NU3yap1fgdG0nsCB54OWh+/W20jiR0QYX9xB/t1pS6nl1h3Z
         UaUZ5UiGNuGsUk5kSGQr26qCF8GfWP5u8xtex0cuOD2fCjuZbO2k69WZ26oy7H9RYSP2
         N0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wljf+GOpACKcVehQ7hmzv1XcoP3kAZP3bt/nUIQRBPA=;
        b=6RBKoBwre7PgFW3FYMzmJlKzLqAcWtYhNkRedLayvFHL+oFdSFWt+hITf1tFwx3yXr
         J24Q6JFvnC7MEc32BELEFeX0AREfXrrrNx5vm2Jar+WJJVKw4B3LI4jMwfJNwpgF/SzZ
         5UkG5Tb5IRlX9QHcC7Yf/9ODAPBh2aYj11JGBwtKyUOYYo0OxA9ZLFCICaetnwhoC3+p
         876jMDIHTRGZvsTvDD7/x9z7/ksZrztca/1w/UJahSFnl3wGCO6wUyJLV7KURn9sEzPd
         KrR33Xkrl4KEKL5nCrfF+jCzdkelZJXhZjuu6DcvmYfXv8qOlCxDpPPqjZ7J/ZLpfFpb
         02oA==
X-Gm-Message-State: ANoB5pkykRYTcXfCsFB0hAVRgLJEpkV+BLMfGUNLokrdn3ebDso3Q+NE
        UVSfF8aEeDgm9LSns7sGP4gi6PngJUu/feoYlHR21oFpFI0=
X-Google-Smtp-Source: AA0mqf45VzwRePVmgXK7+Txg2y4Fa9iDFndMyxsC9Dsn3EIWysKtnfFwjzkLdx4o5UPvR7dQvr8P3uoyV74ClLnuc6E=
X-Received: by 2002:a17:906:a2d9:b0:7ad:d250:b8fb with SMTP id
 by25-20020a170906a2d900b007add250b8fbmr2239873ejb.739.1668695927379; Thu, 17
 Nov 2022 06:38:47 -0800 (PST)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Thu, 17 Nov 2022 22:38:13 +0800
Message-ID: <CAO4mrffT8wbtjSR9gEwcdK8TZTK6g0TiS7vgSqbAFVRf=Romag@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in posix_get_monotonic_timespec
To:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linux Developer,

Recently when using our tool to fuzz kernel, the following crash was triggered.

HEAD commit: d418a331631b v6.1.0-rc5
git tree: kmsan
compiler: gcc 8.4.0
console output:
https://drive.google.com/file/d/1F6xY7LF5H9Lki9m769N_9ickBdGwaXIo/view?usp=share_link
kernel config: https://drive.google.com/file/d/1qltDw7jrn7_DnXvhf7MgsxO08nqGSCDe/view?usp=share_link

Unfortunately, I didn't have a reproducer for this bug.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

BUG: kernel NULL pointer dereference, address: 0000000000000050
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 1a089067 P4D 1a089067 PUD 1a08a067 PMD 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 6355 Comm: syz-executor.1 Not tainted
6.1.0-rc5-63183-gd418a331631b #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
Ubuntu-1.8.2-1ubuntu1 04/01/2014
RIP: 0010:timespec64_add include/linux/time64.h:73 [inline]
RIP: 0010:timens_add_monotonic include/linux/time_namespace.h:69 [inline]
RIP: 0010:posix_get_monotonic_timespec+0x40/0x80 kernel/time/posix-timers.c:200
Code: 89 45 f0 31 c0 e8 a0 ce 05 00 48 89 df e8 98 5c ff ff 48 8d 7d
e0 65 48 8b 04 25 c0 ad 01 00 48 8b 80 d8 07 00 00 48 8b 40 30 <48> 8b
50 30 48 8b 70 28 48 03 53 08 48 03 33 e8 9c 89 fe ff 48 8b
RSP: 0018:ffff88800e0d7ed0 EFLAGS: 00010282
RAX: 0000000000000020 RBX: ffff88800e0d7f00 RCX: ffff888042696480
RDX: 0000000000000000 RSI: ffff888042696480 RDI: ffff88800e0d7ed0
RBP: ffff88800e0d7ef0 R08: ffffffff8124f51a R09: 000000003b9ac9ff
R10: 0000000000000007 R11: 0000000008fa7c6f R12: 0000000000000001
R13: 00007fff9e567f20 R14: 0000000000000000 R15: 0000000000000000
FS:  00000000021ab940(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000050 CR3: 000000001a088000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __do_sys_clock_gettime kernel/time/posix-timers.c:1101 [inline]
 __se_sys_clock_gettime kernel/time/posix-timers.c:1091 [inline]
 __x64_sys_clock_gettime+0x97/0x140 kernel/time/posix-timers.c:1091
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x461b5a
Code: 25 18 00 00 00 00 74 01 f0 48 0f b1 3d 0f 9b 25 01 48 39 c2 75
da f3 c3 0f 1f 84 00 00 00 00 00 48 63 ff b8 e4 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 06 f3 c3 0f 1f 40 00 48 c7 c2 d4 ff ff ff f7
RSP: 002b:00007fff9e567f18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e4
RAX: ffffffffffffffda RBX: 0000000000002ee0 RCX: 0000000000461b5a
RDX: 0000000000002ee0 RSI: 00007fff9e567f20 RDI: 0000000000000001
RBP: 0000000000031cfb R08: 0000000000000000 R09: 00000000021ab940
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000c2a
R13: 0000000000000001 R14: 0000000000000032 R15: 0000000000031cf4
 </TASK>
Modules linked in:
CR2: 0000000000000050
---[ end trace 0000000000000000 ]---
RIP: 0010:timespec64_add include/linux/time64.h:73 [inline]
RIP: 0010:timens_add_monotonic include/linux/time_namespace.h:69 [inline]
RIP: 0010:posix_get_monotonic_timespec+0x40/0x80 kernel/time/posix-timers.c:200
Code: 89 45 f0 31 c0 e8 a0 ce 05 00 48 89 df e8 98 5c ff ff 48 8d 7d
e0 65 48 8b 04 25 c0 ad 01 00 48 8b 80 d8 07 00 00 48 8b 40 30 <48> 8b
50 30 48 8b 70 28 48 03 53 08 48 03 33 e8 9c 89 fe ff 48 8b
RSP: 0018:ffff88800e0d7ed0 EFLAGS: 00010282
RAX: 0000000000000020 RBX: ffff88800e0d7f00 RCX: ffff888042696480
RDX: 0000000000000000 RSI: ffff888042696480 RDI: ffff88800e0d7ed0
RBP: ffff88800e0d7ef0 R08: ffffffff8124f51a R09: 000000003b9ac9ff
R10: 0000000000000007 R11: 0000000008fa7c6f R12: 0000000000000001
R13: 00007fff9e567f20 R14: 0000000000000000 R15: 0000000000000000
FS:  00000000021ab940(0000) GS:ffff88807ec00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000050 CR3: 000000001a088000 CR4: 00000000003526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 89 45 f0              mov    %eax,-0x10(%rbp)
   3: 31 c0                xor    %eax,%eax
   5: e8 a0 ce 05 00        callq  0x5ceaa
   a: 48 89 df              mov    %rbx,%rdi
   d: e8 98 5c ff ff        callq  0xffff5caa
  12: 48 8d 7d e0          lea    -0x20(%rbp),%rdi
  16: 65 48 8b 04 25 c0 ad mov    %gs:0x1adc0,%rax
  1d: 01 00
  1f: 48 8b 80 d8 07 00 00 mov    0x7d8(%rax),%rax
  26: 48 8b 40 30          mov    0x30(%rax),%rax
* 2a: 48 8b 50 30          mov    0x30(%rax),%rdx <-- trapping instruction
  2e: 48 8b 70 28          mov    0x28(%rax),%rsi
  32: 48 03 53 08          add    0x8(%rbx),%rdx
  36: 48 03 33              add    (%rbx),%rsi
  39: e8 9c 89 fe ff        callq  0xfffe89da
  3e: 48                    rex.W
  3f: 8b                    .byte 0x8b

Best,
Wei
