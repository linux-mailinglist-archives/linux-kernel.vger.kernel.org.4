Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B516F5BAD97
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiIPMrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiIPMra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:47:30 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E7AA99DA;
        Fri, 16 Sep 2022 05:47:29 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id b5so154999vkb.3;
        Fri, 16 Sep 2022 05:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=Gqcp56X10z/uuWxUuy7ee+H/hHO0+VNNsCrULLVFC8w=;
        b=V5e6lTwmgb77AVXiM849C5ery4OlkKt5akPxr2qyv+OFkAUkueP8n9Ib/UAuhF25m9
         EE53PxnKfnNshJyjAm5aiq7g/Z7NJiV5BoeRSBWakVxQbFDtBYKJnrJNMRodLog1t11q
         uzot35ZIvqRByX2gPENGgdKfSVdLxUr1CYJ96TxbGfw6RKUhgLc99woYY9qFP4v10CPj
         DPDP3V8IEVnilJhLNi4sdzYPTIp2FGy8UM9Ri9PNkprRWtFYxfG88LA9F5y9QVQXjShV
         gM3mEjYQn8jHjoVyBveu/LOqoN+d/IbMu/VtaXvnKiSeFrlX//83VL0JlC5NmJX577Np
         beHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Gqcp56X10z/uuWxUuy7ee+H/hHO0+VNNsCrULLVFC8w=;
        b=7xkXZotjmbKX1QgQrvxHRvRFn/OFJS7h/BiEuS9poGTrRFGUpHgNRlk/Tn/Bz5ZhZr
         sU+QuT8OlP6JSOjkdcENt3d7o7kZkw1CaDwbyt8Q+kAGKNEJDlwF2iK3mEDsk7379TZi
         MXfdb3HOjGCPAcrV1cStDi29FPvKRWYKTW7FeQIeeLFyNhhjqQDvY9be4c9FfYzHu5lh
         +7XKlwGCPK9JlrRNgwsNkHF135Jwgjo8vDEQ7hYavIPiiaK7Dzkm9x/BWcCL+4Hz1S9N
         L2MO2hbuQg/0KQiZSdaXy8H2S1fSpQyvUh5MFLz+nidAQYbVGiTeTqhVO5ezB3Hkl6sK
         lesw==
X-Gm-Message-State: ACrzQf1qRHcP5PUJVX4g0K8UxXMINfAYCIYTtL/PZgiJMlHzLmgTrLs6
        05o9odsWaydNupid9cNIHalcoVeKDezs10Dodu4IE9Fip9UxLQ==
X-Google-Smtp-Source: AMsMyM7z61na/395ABWuKVVqIrklVRdwSoaIzGRAfdi7DlMjQlGcxTH7SNj0DJ4SVInsyCw86MyuZ2FRML1Ok0blCy0=
X-Received: by 2002:a1f:ac16:0:b0:3a3:258:3442 with SMTP id
 v22-20020a1fac16000000b003a302583442mr1779089vke.2.1663332448124; Fri, 16 Sep
 2022 05:47:28 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Fri, 16 Sep 2022 20:47:17 +0800
Message-ID: <CAB7eexJLw1dAjzFCOp4UzW7h4Vv-NLtUcy6Q+4kk7eOP69w+gw@mail.gmail.com>
Subject: general protection fault in gs_start_io
To:     balbi@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hello,

When fuzzing the Linux kernel driver v6.0-rc4, the following crash was
triggered.

HEAD commit: 7e18e42e4b280c85b76967a9106a13ca61c16179
git tree: upstream

kernel config: https://pastebin.com/raw/xtrgsXP3
console output: https://pastebin.com/raw/Mm6mVaYt

Basically, in the c reproducer, we use the gadget module to emulate
attaching a USB device and executing some simple sequence of system
calls.

Sorry I do not have c reproducer for this bug, but I would so
appreciate it if you have any idea how to solve this bug.

The crash report is as follows:

general protection fault, probably for non-canonical address
0xdffffc000000001c: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000000e0-0x00000000000000e7]
CPU: 0 PID: 17757 Comm: syz-executor.4 Not tainted 6.0.0-rc4+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:gs_start_io+0x24d/0x2c0 drivers/usb/gadget/function/u_serial.c:571
Code: 03 80 3c 02 00 0f 85 85 00 00 00 48 8b 9b d8 03 00 00 48 b8 00
00 00 00 00 fc ff df 48 8d bb e0 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c
02 00 75 59 48 8b bb e0 00 00 00 41 bc fb ff ff ff 48 8b 54
RSP: 0018:ffffc90018f07838 EFLAGS: 00010012
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88801a2f3a80
RDX: 000000000000001c RSI: ffff88801a2f3a80 RDI: 00000000000000e0
RBP: ffff88801387e3d8 R08: ffffffff85d97033 R09: fffffbfff1d34743
R10: ffffffff8e9a3a17 R11: fffffbfff1d34742 R12: 0000000000000000
R13: ffff888047e78158 R14: ffff88801387e3f0 R15: ffff88801387e404
FS: 00007f2212ea8700(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c004475000 CR3: 000000006746a000 CR4: 0000000000350ef0
Call Trace:
<TASK>
gs_open+0x253/0x540 drivers/usb/gadget/function/u_serial.c:638
tty_open+0x2e5/0xc30 drivers/tty/tty_io.c:2150
chrdev_open+0x219/0x5c0 fs/char_dev.c:414
do_dentry_open+0x4a4/0x13a0 fs/open.c:878
do_open fs/namei.c:3557 [inline]
path_openat+0x1c1f/0x2840 fs/namei.c:3691
do_filp_open+0x1ca/0x2a0 fs/namei.c:3718
trace_clock_x86_tsc+0x10/0x10
do_sys_open+0xc3/0x140 fs/open.c:1327
do_syscall_x64 arch/x86/entry/common.c:50 [inline]
do_syscall_64+0x35/0x80 arch/x86/entry/common.c:80
entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f22126a80fd
Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2212ea7bf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f221279c340 RCX: 00007f22126a80fd
RDX: 0000000000004000 RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 00007f221270b606 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd1cb1673f R14: 00007ffd1cb168e0 R15: 00007f2212ea7d80
</TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:gs_start_io+0x24d/0x2c0 drivers/usb/gadget/function/u_serial.c:571
Code: 03 80 3c 02 00 0f 85 85 00 00 00 48 8b 9b d8 03 00 00 48 b8 00
00 00 00 00 fc ff df 48 8d bb e0 00 00 00 48 89 fa 48 c1 ea 03 <80> 3c
02 00 75 59 48 8b bb e0 00 00 00 41 bc fb ff ff ff 48 8b 54
RSP: 0018:ffffc90018f07838 EFLAGS: 00010012
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffff88801a2f3a80
RDX: 000000000000001c RSI: ffff88801a2f3a80 RDI: 00000000000000e0
RBP: ffff88801387e3d8 R08: ffffffff85d97033 R09: fffffbfff1d34743
R10: ffffffff8e9a3a17 R11: fffffbfff1d34742 R12: 0000000000000000
R13: ffff888047e78158 R14: ffff88801387e3f0 R15: ffff88801387e404
FS: 00007f2212ea8700(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c004475000 CR3: 000000006746a000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
0: 03 80 3c 02 00 0f add 0xf00023c(%rax),%eax
6: 85 85 00 00 00 48 test %eax,0x48000000(%rbp)
c: 8b 9b d8 03 00 00 mov 0x3d8(%rbx),%ebx
12: 48 b8 00 00 00 00 00 movabs $0xdffffc0000000000,%rax
19: fc ff df
1c: 48 8d bb e0 00 00 00 lea 0xe0(%rbx),%rdi
23: 48 89 fa mov %rdi,%rdx
26: 48 c1 ea 03 shr $0x3,%rdx
* 2a: 80 3c 02 00 cmpb $0x0,(%rdx,%rax,1) <-- trapping instruction
2e: 75 59 jne 0x89
30: 48 8b bb e0 00 00 00 mov 0xe0(%rbx),%rdi
37: 41 bc fb ff ff ff mov $0xfffffffb,%r12d
3d: 48 rex.W
3e: 8b .byte 0x8b
3f: 54 push %rsp
