Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2835F9FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJJN75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJJN7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:59:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1730B7FA;
        Mon, 10 Oct 2022 06:59:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b2so25103609eja.6;
        Mon, 10 Oct 2022 06:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HclpZajJBvcaS2petPU7S046g6kuIpoJyWAhtDsfxkg=;
        b=o+W0oJzdg3tdjkFqY3rNUegk/H0RCDYkUXSGmwQnVq1oZgMlycZvBnSKslU0qOZwG/
         je/7wbDkb5d/Jm/5dSqVOggi1f+yS5EA+lK6Y2VaylnqPqHXMcXQ2/h0Gu62QsXYMf4c
         UqJ/OlKBPlA8gO+XvtQp2lgqDgITxmUfQkwgl8TQwp45T2rGuBbjKNfiNWJc8Kfo4xIY
         xpIOiViPkGOF6ltRlDkULsseOPIGWp7NV+5XOrp8AzDyr/4T97i2oc+LpwCDzXrmo2H1
         wrQIpvELdphczlfAKX7sba8wCUupaLezZEOYsaG6RQJaDs2bAk46KVA06yY1tlsTgLLn
         F3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HclpZajJBvcaS2petPU7S046g6kuIpoJyWAhtDsfxkg=;
        b=OftRGRnJdYWPvL/smioFP82qMmW+ggkAq36n8dwFGljzeTdmZz4nRy1hhdiTSMuIlT
         jUvwV6JHVNYbrfGwR6uufg0s0f7AmUGBDfDe3XZQruakZ7jYEf8v5m+rOj9SPS6Wbseq
         KqjBzmYLeppV/DLMYDrX5CkVj2tmC3AmJzJflELvEJrrKREFwKeRgc2kcMUnLLBTbQ4j
         9gZVk7MMhOIvKfjvA0LsG5/NsfPeXZG1z311TjaxtKtjCWiCcrMoeeEkdvFccmQUurup
         etO4+k/wogcuta2L41qD0HXnjX7RqK9yqFiROfPPi5rVsBGiETbTo8IdhxahRKixNuEI
         +liw==
X-Gm-Message-State: ACrzQf1XMkb+9AeShnOCIzH2g91euU2FphY7fTUW9I6XOAFuDgT6pRu+
        2TvuPM9+ncezlm+fRpZP3CRUmDDuHtBPBHdC1GE=
X-Google-Smtp-Source: AMsMyM7l6207dNZz3cbDzgOZFUJRiPyebJVrntD5gCwALxo4FD4Ef3DIyil0j9CUgUB1BV1Kgeuvm0u2ahfSvCFf9Co=
X-Received: by 2002:a17:907:2d06:b0:78d:50db:130e with SMTP id
 gs6-20020a1709072d0600b0078d50db130emr13767461ejc.371.1665410391144; Mon, 10
 Oct 2022 06:59:51 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Mon, 10 Oct 2022 21:59:15 +0800
Message-ID: <CAO4mrfeU0kTbu2FMJ0DSt_XaQj9yEd1w0eNCdAxkK3JnvqgqAA@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in start_motor
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Cc:     efremov@linux.com, linux-kernel@vger.kernel.org
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
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1uCdjFTp2Xv6bJKVrjgr7-TyTZaM3Veb5/view?usp=sharing
kernel config: https://drive.google.com/file/d/1lNwvovjLNrcuyFGrg05IoSmgO5jaKBBJ/view?usp=sharing

Unfortunately, I don't have any reproducer for this crash yet.

BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 10cc9b067 P4D 10cc9b067 PUD 10cc9c067 PMD 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 6765 Comm: kworker/u4:2 Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
Workqueue: floppy fd_timer_workfn
RIP: 0010:start_motor+0x4d/0x200 drivers/block/floppy.c:1905
Code: 0f b6 1d 76 8b 3d 06 4b 8d 04 a4 44 0f b6 3c c5 2d 8e 98 88 89
d9 48 8b 05 d8 9d 3d 06 83 e1 03 41 d3 e6 44 0f b6 e9 45 21 f7 <f6> 00
04 0f 85 fb 00 00 00 e8 35 14 db fe 49 83 fc 01 0f 87 24 01
RSP: 0018:ffffc90002253dd0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88810b2e0000 RSI: ffffffff825b026c RDI: ffffffff825b6710
RBP: ffffffff825b6710 R08: 0000000000000000 R09: 0000000000000001
R10: ffffc90002253e70 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000010 R15: 0000000000000010
FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000010cc9a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 floppy_ready+0x4c/0xc60 drivers/block/floppy.c:1932
 process_one_work+0x34e/0x810 kernel/workqueue.c:2297
 worker_thread+0x42/0x4c0 kernel/workqueue.c:2444
 kthread+0x178/0x1b0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: 0000000000000000
---[ end trace 5df88fd80b74c734 ]---
RIP: 0010:start_motor+0x4d/0x200 drivers/block/floppy.c:1905
Code: 0f b6 1d 76 8b 3d 06 4b 8d 04 a4 44 0f b6 3c c5 2d 8e 98 88 89
d9 48 8b 05 d8 9d 3d 06 83 e1 03 41 d3 e6 44 0f b6 e9 45 21 f7 <f6> 00
04 0f 85 fb 00 00 00 e8 35 14 db fe 49 83 fc 01 0f 87 24 01
RSP: 0018:ffffc90002253dd0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff88810b2e0000 RSI: ffffffff825b026c RDI: ffffffff825b6710
RBP: ffffffff825b6710 R08: 0000000000000000 R09: 0000000000000001
R10: ffffc90002253e70 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000010 R15: 0000000000000010
FS:  0000000000000000(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000010cc9a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0: 0f b6 1d 76 8b 3d 06 movzbl 0x63d8b76(%rip),%ebx        # 0x63d8b7d
   7: 4b 8d 04 a4          lea    (%r12,%r12,4),%rax
   b: 44 0f b6 3c c5 2d 8e movzbl -0x776771d3(,%rax,8),%r15d
  12: 98 88
  14: 89 d9                mov    %ebx,%ecx
  16: 48 8b 05 d8 9d 3d 06 mov    0x63d9dd8(%rip),%rax        # 0x63d9df5
  1d: 83 e1 03              and    $0x3,%ecx
  20: 41 d3 e6              shl    %cl,%r14d
  23: 44 0f b6 e9          movzbl %cl,%r13d
  27: 45 21 f7              and    %r14d,%r15d
* 2a: f6 00 04              testb  $0x4,(%rax) <-- trapping instruction
  2d: 0f 85 fb 00 00 00    jne    0x12e
  33: e8 35 14 db fe        callq  0xfedb146d
  38: 49 83 fc 01          cmp    $0x1,%r12
  3c: 0f                    .byte 0xf
  3d: 87 24 01              xchg   %esp,(%rcx,%rax,1)

Best,
Wei
