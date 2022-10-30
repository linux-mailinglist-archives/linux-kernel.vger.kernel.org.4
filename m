Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6806129FC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJ3KQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ3KQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:16:49 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF82DF6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:16:48 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 21so13746833edv.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oqvjIZ3RLdZwVQVylZgrS34KDUxQ1uiOI/8R+HEhQh8=;
        b=bFmgI374FfmfCY/gOsO9JqN7ybHIQecReu3i+dpR+sIxUETGXViaVxvFqcvgNV9Uiz
         lnmCiADWOukCUGnOvSYBTf4QnNQK/DPwwnLQBIG3VQ4HB8yOPyJ9DSanZDsB6Pj3fpVV
         Dil8UJN39sOJQfem9nddkjKmq4+2uOyyNVA0MSwUkWWhbIkJnCsgBL7XEgpHzEX7VgGN
         PPrf8qirB977m8TYV4h5triQk/uUff7rzPOfVXOHtxp2kMg4Yhn8pnpZKJMMLp72T6Q7
         OCVY5brkCPWIt38bxJKGNDboUWiGhnfNMZFs4YzEcbZ5jEy9xuKGaf1YwtrPkaMYonhW
         Jicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oqvjIZ3RLdZwVQVylZgrS34KDUxQ1uiOI/8R+HEhQh8=;
        b=jI+mCJzSufdPE/lXC9p7sPOvC6ND9V0loNbhi3S84IGdpzq+lb9/nDo2vDQd76dHZc
         GqMDlrfe0yq5Lr2owexULNGlsM8tJ89lVlSXjttZHGItulgtyAfE2myRq8CN21j19MGO
         vzbLZ7Oq/QVUfWAfZTmcH15+Vs2u2sPRfzJYrrE1IfH+7HbCKSU+ANrKZa2H+iyy/pBG
         W3a6Ds7dPzPxTz9UslmvVo2jSo6JCanLYp4Am9Hx3mEfGqmW5rnskQdSQqzOkrPn6OfH
         ZIZhAxUYrKSgBRUSgeoE4hioms3rOZ/3+lKuxLG/tQ6g86xgXd+ZH8z8/rZ3+FyLXy4C
         DNpQ==
X-Gm-Message-State: ACrzQf1xEWVzC427iz0hUQwQ2bLeRw/l89yjI+3YDhDJJCv96fX5LUu5
        k8t9IydQsDw1Zs1Mnxcjh2/9w7FnJB69v6YOgQQ/EYQVNnUnlQ==
X-Google-Smtp-Source: AMsMyM6041aRbNP10CXMk5Chi0VfO/fR1FeCj8CUZOEn6JUbjOyGk3QOQTObmmXxjZdw/1AWCmMC2wyCBqQNOuyXi3M=
X-Received: by 2002:a05:6402:10c2:b0:45c:3c87:721f with SMTP id
 p2-20020a05640210c200b0045c3c87721fmr8399369edu.251.1667125006910; Sun, 30
 Oct 2022 03:16:46 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 18:16:11 +0800
Message-ID: <CAO4mrfeJQi5K3R1RfXnZ+K81koj-Tq_bp+J4K7mqXPJdEfSu9Q@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in stack_depot_save
To:     linux-kernel@vger.kernel.org
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
https://drive.google.com/file/d/1tiImsOLsgUyTS1wPbI1psiX7HtBTNhj9/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

BUG: kernel NULL pointer dereference, address: 0000000000000028
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 13792 Comm: systemd Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:stack_depot_save+0x136/0x520
Code: ff ff 0f 00 4c 8d 34 c8 4d 8b 2e 4d 85 ed 0f 84 b4 00 00 00 8d
75 ff 48 c1 e6 03 eb 0d 4d 8b 6d 00 4d 85 ed 0f 84 9e 00 00 00 <41> 39
5d 08 75 ed 41 3b 6d 0c 75 e7 49 8b 04 24 49 39 45 18 75 dd
RSP: 0018:ffffc9000abeb0b0 EFLAGS: 00010206
RAX: ffff88813d000000 RBX: 00000000d05577a2 RCX: 00000000000577a2
RDX: 0000000000012c50 RSI: 0000000000000078 RDI: 00000000f0f1e45b
RBP: 0000000000000010 R08: 00000000b6dd3736 R09: ffffffff86c43dd4
R10: ffffffff86c43dd0 R11: 0000000000000000 R12: ffffc9000abeb120
R13: 0000000000000020 R14: ffff88813d2bbd10 R15: 0000000000000000
FS:  00007f721246a500(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000028 CR3: 000000010886f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 save_stack+0xa2/0xe0
 __set_page_owner+0x45/0x100
 prep_new_page+0xbd/0x100
 get_page_from_freelist+0x12fc/0x17e0
 __alloc_pages+0x1c8/0x420
 alloc_pages+0xbf/0x160
 new_slab+0x309/0x4c0
 ___slab_alloc.part.92+0x7b7/0xfc0
 __slab_alloc.isra.93+0x4f/0xa0
 kmem_cache_alloc+0x2f8/0x310
 alloc_buffer_head+0x1d/0xb0
 alloc_page_buffers+0x1df/0x4a0
 create_empty_buffers+0x26/0x450
 ext4_block_write_begin+0x938/0xc60
 ext4_da_write_begin+0x24f/0x5d0
 generic_perform_write+0x15d/0x290
 ext4_buffered_write_iter+0xc9/0x1d0
 ext4_file_write_iter+0xb1/0xbb0
 __kernel_write+0x22f/0x4c0
 __dump_emit+0xaf/0xf0
 dump_emit+0x107/0x1a0
 dump_user_range+0x5a/0x1f0
 elf_core_dump+0x1804/0x1aa0
 do_coredump+0x10da/0x1bf0
 get_signal+0xa5d/0x1520
 arch_do_signal_or_restart+0xa9/0x870
 exit_to_user_mode_prepare+0x138/0x280
 syscall_exit_to_user_mode+0x19/0x60
 do_syscall_64+0x40/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f721098c317
Code: 44 00 00 48 8b 15 81 5b 36 00 f7 d8 64 89 02 b8 ff ff ff ff c3
66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 3e 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 51 5b 36 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe5d132438 EFLAGS: 00000213 ORIG_RAX: 000000000000003e
RAX: 0000000000000000 RBX: 00007ffe5d1324e0 RCX: 00007f721098c317
RDX: 00007f7210a350d7 RSI: 000000000000000b RDI: 00000000000035e0
RBP: 000000000000000b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000213 R12: 0000000000000000
R13: 0000000000000000 R14: 0000557657079838 R15: 00007ffe5d1333d0
Modules linked in:
CR2: 0000000000000028
---[ end trace c2c81c11bafb869c ]---
RIP: 0010:stack_depot_save+0x136/0x520
Code: ff ff 0f 00 4c 8d 34 c8 4d 8b 2e 4d 85 ed 0f 84 b4 00 00 00 8d
75 ff 48 c1 e6 03 eb 0d 4d 8b 6d 00 4d 85 ed 0f 84 9e 00 00 00 <41> 39
5d 08 75 ed 41 3b 6d 0c 75 e7 49 8b 04 24 49 39 45 18 75 dd
RSP: 0018:ffffc9000abeb0b0 EFLAGS: 00010206
RAX: ffff88813d000000 RBX: 00000000d05577a2 RCX: 00000000000577a2
RDX: 0000000000012c50 RSI: 0000000000000078 RDI: 00000000f0f1e45b
RBP: 0000000000000010 R08: 00000000b6dd3736 R09: ffffffff86c43dd4
R10: ffffffff86c43dd0 R11: 0000000000000000 R12: ffffc9000abeb120
R13: 0000000000000020 R14: ffff88813d2bbd10 R15: 0000000000000000
FS:  00007f721246a500(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000028 CR3: 000000010886f000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0: ff 0f                decl   (%rdi)
   2: 00 4c 8d 34          add    %cl,0x34(%rbp,%rcx,4)
   6: c8 4d 8b 2e          enterq $0x8b4d,$0x2e
   a: 4d 85 ed              test   %r13,%r13
   d: 0f 84 b4 00 00 00    je     0xc7
  13: 8d 75 ff              lea    -0x1(%rbp),%esi
  16: 48 c1 e6 03          shl    $0x3,%rsi
  1a: eb 0d                jmp    0x29
  1c: 4d 8b 6d 00          mov    0x0(%r13),%r13
  20: 4d 85 ed              test   %r13,%r13
  23: 0f 84 9e 00 00 00    je     0xc7
* 29: 41 39 5d 08          cmp    %ebx,0x8(%r13) <-- trapping instruction
  2d: 75 ed                jne    0x1c
  2f: 41 3b 6d 0c          cmp    0xc(%r13),%ebp
  33: 75 e7                jne    0x1c
  35: 49 8b 04 24          mov    (%r12),%rax
  39: 49 39 45 18          cmp    %rax,0x18(%r13)
  3d: 75 dd                jne    0x1c

Best,
Wei
