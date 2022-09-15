Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC5B5B9F42
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiIOP5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiIOP47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:56:59 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3515829CB5;
        Thu, 15 Sep 2022 08:56:58 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id c3so19773877vsc.6;
        Thu, 15 Sep 2022 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=Cpx6Ue6kcbAqAmm3o63GbqmR3hXAwmbhhjniKqsolTA=;
        b=djKR/ACyEjzELqWQdflGOLkjP5O4FnvHcpRNIr4KoX1OuD4cj/g4SIzeY1+K6h9Ubu
         311kad8AavjGl+Kd8/Bntc3wmciQKk7hZ/JFdzGGYMlsgbiTk4/PhNxmreFNN3RkYMGi
         cun7BlCa3isOp8qwbvdyhmpqRnjwTj+InJvAgaxAl9g+7yEJwTRbUq9iwj7r3yJRxL2I
         wB37J9NLGoBr4L1S/QO0PZM36wIfSDyEveW234ZNMC00RPRCX21MVHYBpJokdbYscBEc
         EvD3nZY723hAUx1nC5fBblTTGF8rO/EZvS2PaSOjBI5vtX9FACOcadng4a9nXQMqLAoR
         TfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Cpx6Ue6kcbAqAmm3o63GbqmR3hXAwmbhhjniKqsolTA=;
        b=2mnRD8b/Uqdk9jh0+j+Dy5qFcvC4YovUC84uEEtIlnOr8PaE2XWZBUlYKv4T2tEgpN
         wR2IvhKijFvyPgjSwnhqCWyjZwcHNWeUbzSwOpS6jto81cbs61sG41sXait7Uc1FSp8Q
         PVOkf0oO0YLdQa1UqwsdYjx8EEHo8RSg/iLBWQ8Hsda8GTwRabM3QvTEyPZGl19ypBhA
         BdNzJFyTo8Vo/onnL90+cSYBmgcB9d9y/3zxv5+I2dyfIhAJKmJcH1ii+b8yrCwoVdbZ
         EaRUgdWh3HyQ1thJV4PezWAed4L3+rG4iDQOlwO+qGRAYHtSr9XHrQxmGyYSehFaULOU
         Ya+g==
X-Gm-Message-State: ACrzQf3LR0cZ+D2MrYATchP/CJf21HrbYOQO35CoI8BTtJnEolexOv45
        r1zC/aXAhH8JjvtkV0EwhlZB5xgKLESEwCimrElOMuY/n8J7nyFe
X-Google-Smtp-Source: AMsMyM74hFhzbGA0aVl4xpDlCwWZw3Bz7cYs6qi2bNRHv+CdZ7ScK7xAoVccX9pDN2omzMCbW7fL0k5BEfNqOOsjyrY=
X-Received: by 2002:a67:8c43:0:b0:398:6815:d340 with SMTP id
 o64-20020a678c43000000b003986815d340mr410092vsd.42.1663257417326; Thu, 15 Sep
 2022 08:56:57 -0700 (PDT)
MIME-Version: 1.0
From:   Rondreis <linhaoguo86@gmail.com>
Date:   Thu, 15 Sep 2022 23:56:46 +0800
Message-ID: <CAB7eexKijKtCak4xh0JiyuQ0BmpryRLGm+_psrzjV+7KkKzA_g@mail.gmail.com>
Subject: BUG: unable to handle kernel paging request in scsi_device_unbusy
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
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
console output: https://pastebin.com/raw/T6bLnbiJ

Sorry I dont have any C reproducer on this bug, however, I would
appreciate it if you have any idea how to solve this bug.

The crash report is as follows:

BUG: unable to handle page fault for address: ffffed104565bc78
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 7ffd0067 P4D 7ffd0067 PUD 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 12256 Comm: usb-storage Not tainted 6.0.0-rc4+ #20
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:85 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0xe0/0x190 mm/kasan/generic.c:189
Code: 80 38 00 74 ee 49 89 c0 b8 01 00 00 00 4d 85 c0 75 57 5b 5d 41
5c c3 4d 85 c9 74 71 49 01 d9 eb 09 48 83 c0 01 4c 39 c8 74 63 <80> 38
00 74 f2 eb d4 41 bc 08 00 00 00 45 29 c4 49 89 d8 4d 8d 0c
RSP: 0018:ffffc90018cbfd30 EFLAGS: 00010282
RAX: ffffed104565bc78 RBX: ffffed104565bc78 RCX: ffffffff84ab8eaa
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff88822b2de3c0
RBP: ffffed104565bc79 R08: ffffffff84ab8e81 R09: ffffed104565bc79
R10: ffff88822b2de3c7 R11: ffffed104565bc78 R12: 000000000000003f
R13: ffff88806620b120 R14: 00000000ffffffff R15: ffff88806620b1f4
FS:  0000000000000000(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed104565bc78 CR3: 0000000056ea7000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 instrument_atomic_write include/linux/instrumented.h:86 [inline]
 set_bit include/asm-generic/bitops/instrumented-atomic.h:28 [inline]
 sbitmap_deferred_clear_bit include/linux/sbitmap.h:327 [inline]
 sbitmap_put include/linux/sbitmap.h:336 [inline]
 scsi_device_unbusy+0x1aa/0x380 drivers/scsi/scsi_lib.c:301
 scsi_finish_command+0x86/0x530 drivers/scsi/scsi.c:166
 scsi_complete+0x126/0x260 drivers/scsi/scsi_lib.c:1438
 blk_mq_complete_request_direct include/linux/blk-mq.h:814 [inline]
 scsi_done_internal+0x1de/0x490 drivers/scsi/scsi_lib.c:1627
 usb_stor_control_thread+0x72c/0x960 drivers/usb/storage/usb.c:420
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Modules linked in:
CR2: ffffed104565bc78
---[ end trace 0000000000000000 ]---
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:85 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:102 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:128 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:159 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0xe0/0x190 mm/kasan/generic.c:189
Code: 80 38 00 74 ee 49 89 c0 b8 01 00 00 00 4d 85 c0 75 57 5b 5d 41
5c c3 4d 85 c9 74 71 49 01 d9 eb 09 48 83 c0 01 4c 39 c8 74 63 <80> 38
00 74 f2 eb d4 41 bc 08 00 00 00 45 29 c4 49 89 d8 4d 8d 0c
RSP: 0018:ffffc90018cbfd30 EFLAGS: 00010282
RAX: ffffed104565bc78 RBX: ffffed104565bc78 RCX: ffffffff84ab8eaa
RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff88822b2de3c0
RBP: ffffed104565bc79 R08: ffffffff84ab8e81 R09: ffffed104565bc79
R10: ffff88822b2de3c7 R11: ffffed104565bc78 R12: 000000000000003f
R13: ffff88806620b120 R14: 00000000ffffffff R15: ffff88806620b1f4
FS:  0000000000000000(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffed104565bc78 CR3: 0000000056ea7000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0: 80 38 00              cmpb   $0x0,(%rax)
   3: 74 ee                je     0xfffffff3
   5: 49 89 c0              mov    %rax,%r8
   8: b8 01 00 00 00        mov    $0x1,%eax
   d: 4d 85 c0              test   %r8,%r8
  10: 75 57                jne    0x69
  12: 5b                    pop    %rbx
  13: 5d                    pop    %rbp
  14: 41 5c                pop    %r12
  16: c3                    retq
  17: 4d 85 c9              test   %r9,%r9
  1a: 74 71                je     0x8d
  1c: 49 01 d9              add    %rbx,%r9
  1f: eb 09                jmp    0x2a
  21: 48 83 c0 01          add    $0x1,%rax
  25: 4c 39 c8              cmp    %r9,%rax
  28: 74 63                je     0x8d
* 2a: 80 38 00              cmpb   $0x0,(%rax) <-- trapping instruction
  2d: 74 f2                je     0x21
  2f: eb d4                jmp    0x5
  31: 41 bc 08 00 00 00    mov    $0x8,%r12d
  37: 45 29 c4              sub    %r8d,%r12d
  3a: 49 89 d8              mov    %rbx,%r8
  3d: 4d                    rex.WRB
  3e: 8d                    .byte 0x8d
  3f: 0c                    .byte 0xc
