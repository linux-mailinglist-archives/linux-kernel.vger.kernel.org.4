Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D1E6129CC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJ3KDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJ3KDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:03:19 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60DCD128
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:03:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id q9so22923000ejd.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aNwOWTPLK1ziE9pEMTwNk9z8pdqw4ROBThVhMZkcLjg=;
        b=XPjVqTzb96QwvDANy/LZKhsukgmKW93KKL3zDbH6jvmNqTOlNgUkk77n4tpt9eFlOK
         t+kGsa5AQDB6fAcQ7uul+CtZehBzqXZ0oHjsifxAXAsjBALb1pykOK0abqKEE+cMna5x
         W1BN8owzHQT7oZNrz5atehn3a+d0SGSBvhqRtJ2C9VxrMtrEy4kaRO9sPkL0JK9LDAQp
         wpJsKjeSEzDPniyPdqOEmpRPa4WlUQ4OtIPxTDixyRW1JKrZfc1mISxYsjTMfBnrZmab
         k9n0pcglGNQbi5DsPmCyj0mfw+lb3Zq8dCJ7uQ3+maLl15b2pi5tB3lREoT1OR+Til4d
         dO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aNwOWTPLK1ziE9pEMTwNk9z8pdqw4ROBThVhMZkcLjg=;
        b=f7y62+zHRNYFNT+l/N/49At2vC0q3NHnRS45LOn14/Nzhpe/+hj5qAGmFy97I+0KS/
         sUihohOfReJekCoGaVFEYOXxsJQYFZYKPtULpxfgek3kEiBorM60OddUjxihjXnOMBmX
         tyz2nuTdeXjJjj2Ltunw3MrC5vwvZFGDwbdFjGh/D9BWDQNheIQY3xpVbyg4+5sy+Fa+
         oAAL36/lUfovUEiLnQ+oPhnqxdf8Rzc5l+pAoez3NXDCul1/u80ViOYjIJYKs2ZU10ib
         L1A9QLnx+jfq9h1iYtx8EZohcOK7yIJuU+b6efVafAOtl3gHg+MHr5BekRZfR+rUVVO7
         xEPw==
X-Gm-Message-State: ACrzQf0NfnK3aOGfyjsRJftcvjh+OEYrZiLLpEAFM7xgQfULYjXiMfA1
        8FPko5/fpN9LzfEWcdJ9528aeBKNd9W5d5l4dyf4a+15bX4U2Q==
X-Google-Smtp-Source: AMsMyM4yOUhFUkWtq/b25kXQR3UBcUxagerbcKNGUHBWFe/4/TFZnDoj97nEFUJ1OuFJU8q4+qGug3wbUXdZOxbZ0s4=
X-Received: by 2002:a17:907:1041:b0:7ad:a3f8:a733 with SMTP id
 oy1-20020a170907104100b007ada3f8a733mr7298915ejb.739.1667124196209; Sun, 30
 Oct 2022 03:03:16 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 18:02:40 +0800
Message-ID: <CAO4mrfc6aCmrBRq=iqNguvQttFsPfa1BKgwVoEThvHBiRWvf9w@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in __task_pid_nr_ns
To:     christian@brauner.io, linux-kernel@vger.kernel.org
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

Recently when using our tool to fuzz kernel, the following crash was triggered:

HEAD commit: 64570fbc14f8 Linux 5.15-rc5
git tree: upstream
compiler: gcc 8.0.1
console output:
https://drive.google.com/file/d/1TvkFjO_yttSdzHIvGPGgqrmtOIqta6WR/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

BUG: unable to handle page fault for address: 0000000200000081
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 15145 Comm: systemd-udevd Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:__task_pid_nr_ns+0xc3/0x310
Code: 1b e8 c1 94 08 00 31 ff 41 89 c5 89 c6 e8 45 1a 13 00 45 85 ed
0f 84 d0 00 00 00 e8 37 19 13 00 48 85 db 74 23 e8 2d 19 13 00 <41> 8b
84 24 80 00 00 00 44 8b 6b 04 41 89 c6 89 c7 44 89 ee e8 94
RSP: 0018:ffffc900037bbf08 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88811486d400 RCX: ffff888104839b80
RDX: 0000000000000000 RSI: ffff888104839b80 RDI: 0000000000000002
RBP: ffffc900037bbf28 R08: ffffffff812a5a33 R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000001 R12: 0000000200000001
R13: 0000000000000001 R14: ffff88800ab84200 R15: 0000000000000000
FS:  00007f09bf51c8c0(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000200000081 CR3: 0000000014217000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __do_sys_getpid+0x1a/0x20
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f09be36cf17
Code: ff ff ff 48 8b 4d a0 0f b7 51 fe 48 8b 4d a8 66 89 54 08 fe e9
1a ff ff ff 66 2e 0f 1f 84 00 00 00 00 00 b8 27 00 00 00 0f 05 <c3> 0f
1f 84 00 00 00 00 00 b8 6e 00 00 00 0f 05 c3 0f 1f 84 00 00
RSP: 002b:00007ffd28a87fe8 EFLAGS: 00000282 ORIG_RAX: 0000000000000027
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f09be36cf17
RDX: 00000136b6f159e4 RSI: 00002928bb089855 RDI: 000055e10338c4f7
RBP: 00000136b6f159e4 R08: 000000000000c0c0 R09: 0000000000000030
R10: 0000000000000000 R11: 0000000000000282 R12: 000055e10338c4f5
R13: 8421084210842109 R14: 00000000000800c2 R15: 00007f09be41d540
Modules linked in:
CR2: 0000000200000081
---[ end trace 0e559acc68de055e ]---
RIP: 0010:__task_pid_nr_ns+0xc3/0x310
Code: 1b e8 c1 94 08 00 31 ff 41 89 c5 89 c6 e8 45 1a 13 00 45 85 ed
0f 84 d0 00 00 00 e8 37 19 13 00 48 85 db 74 23 e8 2d 19 13 00 <41> 8b
84 24 80 00 00 00 44 8b 6b 04 41 89 c6 89 c7 44 89 ee e8 94
RSP: 0018:ffffc900037bbf08 EFLAGS: 00010246

RAX: 0000000000000000 RBX: ffff88811486d400 RCX: ffff888104839b80
RDX: 0000000000000000 RSI: ffff888104839b80 RDI: 0000000000000002
RBP: ffffc900037bbf28 R08: ffffffff812a5a33 R09: 0000000000000000
R10: 0000000000000005 R11: 0000000000000001 R12: 0000000200000001
R13: 0000000000000001 R14: ffff88800ab84200 R15: 0000000000000000
FS:  00007f09bf51c8c0(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000200000081 CR3: 0000000014217000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 1b e8                sbb    %eax,%ebp
   2: c1 94 08 00 31 ff 41 rcll   $0x89,0x41ff3100(%rax,%rcx,1)
   9: 89
   a: c5 89 c6 e8 45        vshufpd $0x45,%xmm0,%xmm14,%xmm5
   f: 1a 13                sbb    (%rbx),%dl
  11: 00 45 85              add    %al,-0x7b(%rbp)
  14: ed                    in     (%dx),%eax
  15: 0f 84 d0 00 00 00    je     0xeb
  1b: e8 37 19 13 00        callq  0x131957
  20: 48 85 db              test   %rbx,%rbx
  23: 74 23                je     0x48
  25: e8 2d 19 13 00        callq  0x131957
* 2a: 41 8b 84 24 80 00 00 mov    0x80(%r12),%eax <-- trapping instruction
  31: 00
  32: 44 8b 6b 04          mov    0x4(%rbx),%r13d
  36: 41 89 c6              mov    %eax,%r14d
  39: 89 c7                mov    %eax,%edi
  3b: 44 89 ee              mov    %r13d,%esi
  3e: e8                    .byte 0xe8
  3f: 94                    xchg   %eax,%esp

Best,
Wei
