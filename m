Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAA4612964
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 10:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiJ3JX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 05:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJ3JX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 05:23:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F611B493
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:23:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a13so13688207edj.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 02:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dsaPQKJIjkzEpcZYPccqUAmf38fJImiea6L7GkmZ21k=;
        b=EEhwfLxYCJ9+SaYgZ7HVnmBdpL1MmMv6DriApyuJobv19OxOnFEYg/l0DXqx7HU/CM
         1F3S0VxblnPlgtJceEMrhLp3MBY8hTrJSbi16WBUzlIyXqPDWBrKZ3tUNQMAQX1thj4u
         SX01dCm57L/TQSB3Aacs5UBvqq3DJlH+L5NoqrIwU1A/KYLzIdV/xHI6OBQ7ks9yhExu
         GmlLL/x5xVX6p/NM2yaasd58ij38GfS9HVY2xNtzQUq/P5Xz+IrCipJWR/q1rGweHMpr
         YqcbH6I1Ip5aG8fOMsh35a6z69u2kyZq615oq45hvAc/KxNjsoHbpVQi4nXDcnyekwsX
         agdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dsaPQKJIjkzEpcZYPccqUAmf38fJImiea6L7GkmZ21k=;
        b=h+nB7XNeqyvJIJs/mGaPq2UjaXb5nNU/KOyC5o5qVIfiazV2JJXTsHBMh/nEoLKkB3
         crE7du1moxzBswPPzAz0GprOn891sqUaDLM0jriFCxO33eBCn9WDcckQ+ANxfMM5eyHQ
         gmZrrD0dwydwGyzeTisoKE1bb5KYCKAwSsWZ9l3amalGMifpU8n87k3f1GhVNU30qdTU
         EkBlAXkQfoZqEn85l81Vo+fDqw9aQJL2xfizWxfhgVh+z5N+QSJFuaoXlJdvta23J5Ib
         ncw3eJeEq2iCpyRIQ5uJXVb/tD1uTU3ZlXF2IS7Wk1V91Ftj77PJcaV5Vewyp5y1Xp8u
         gZ5w==
X-Gm-Message-State: ACrzQf13MpFId1QiszsMr1StF02MjtmtwXVt66eHl3K+8A5kjbRgLtbM
        2qXhMOAQv2//jc0szngXCKBgVOEC6C3a9V7uSGmTJWChP2Y=
X-Google-Smtp-Source: AMsMyM6AZ+BnTKj592Wf0lJ8e1fdTjVIyvDj9M8+tfgC+lnwpNrF4DR6cId5/CUZMapEvbxoxxEZoPii5tKHQ++ugCo=
X-Received: by 2002:a05:6402:204d:b0:463:153d:6790 with SMTP id
 bc13-20020a056402204d00b00463153d6790mr4870667edb.293.1667121833569; Sun, 30
 Oct 2022 02:23:53 -0700 (PDT)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Sun, 30 Oct 2022 17:23:17 +0800
Message-ID: <CAO4mrffA2tTwCKQ-objUH7BJ2GjSXaJdi=pq0vtqjicx8eH7wA@mail.gmail.com>
Subject: BUG: unable to handle kernel NULL pointer dereference in debug_check_no_obj_freed
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
https://drive.google.com/file/d/1AdHbN-IWDhcwHKqvdfNnePbFeJkAllIB/view?usp=share_link
kernel config: https://drive.google.com/file/d/1uDOeEYgJDcLiSOrx9W8v2bqZ6uOA_55t/view?usp=share_link

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

BUG: kernel NULL pointer dereference, address: 0000000000000038
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 2981 Comm: systemd-journal Not tainted 5.15.0-rc5 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:debug_check_no_obj_freed+0xa0/0x1e0
Code: 03 4c 8d a3 48 7e 2f 89 4c 89 e7 45 31 ff e8 57 db 61 02 48 89
c6 48 c7 c0 40 7e 2f 89 4c 8b 2c 18 4d 85 ed 74 70 41 83 c7 01 <4d> 8b
4d 18 4c 39 4c 24 20 4d 8b 45 00 77 52 4c 3b 4c 24 10 73 4b
RSP: 0000:ffffc900007c7a90 EFLAGS: 00010002
RAX: ffffffff892f7e40 RBX: 0000000000016890 RCX: 00000000ffffbe79
RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffffffff8930e6d8
RBP: ffff888105359000 R08: 0000000000000020 R09: 0000000000000000
R10: ffffffff8930e6f0 R11: 0000000000000000 R12: ffffffff8930e6d8
R13: 0000000000000020 R14: 0000000000000000 R15: 000000000000000e
FS:  0000000000000000(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000038 CR3: 000000000628a000 CR4: 00000000003506e0
Call Trace:
 slab_free_freelist_hook+0xcc/0x160
 kmem_cache_free+0x8f/0x490
 unlink_anon_vmas+0x200/0x2e0
 free_pgtables+0x163/0x1b0
 exit_mmap+0x104/0x320
 mmput+0xc8/0x1e0
 do_exit+0x527/0x1430
 do_group_exit+0x6f/0x120
 get_signal+0x260/0x1520
 arch_do_signal_or_restart+0xa9/0x870
 exit_to_user_mode_prepare+0x138/0x280
 irqentry_exit_to_user_mode+0x5/0x40
 exc_page_fault+0x4a4/0x1130
 asm_exc_page_fault+0x1e/0x30
RIP: 0033:0x7f9422a41200
Code: Unable to access opcode bytes at RIP 0x7f9422a411d6.
RSP: 002b:00007fffa498a478 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 0000564bd2afeaf0 RCX: 0000564bd2afeaf0
RDX: 0000000000000800 RSI: 0000564bd2afeb2d RDI: 0000000000000013
RBP: 0000000000000011 R08: 0000000000000008 R09: 00007fffa49a60f0
R10: 000000000008b2fc R11: 0000000000000202 R12: 0000564bd2aff370
R13: 00007fffa498a5a8 R14: 0000564bd2631958 R15: 000d715db535b416
Modules linked in:
CR2: 0000000000000038
---[ end trace d79df620a6156371 ]---
RIP: 0010:debug_check_no_obj_freed+0xa0/0x1e0
Code: 03 4c 8d a3 48 7e 2f 89 4c 89 e7 45 31 ff e8 57 db 61 02 48 89
c6 48 c7 c0 40 7e 2f 89 4c 8b 2c 18 4d 85 ed 74 70 41 83 c7 01 <4d> 8b
4d 18 4c 39 4c 24 20 4d 8b 45 00 77 52 4c 3b 4c 24 10 73 4b
RSP: 0000:ffffc900007c7a90 EFLAGS: 00010002
RAX: ffffffff892f7e40 RBX: 0000000000016890 RCX: 00000000ffffbe79
RDX: 0000000000000001 RSI: 0000000000000246 RDI: ffffffff8930e6d8
RBP: ffff888105359000 R08: 0000000000000020 R09: 0000000000000000
R10: ffffffff8930e6f0 R11: 0000000000000000 R12: ffffffff8930e6d8
R13: 0000000000000020 R14: 0000000000000000 R15: 000000000000000e
FS:  0000000000000000(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000038 CR3: 000000000628a000 CR4: 00000000003506e0
----------------
Code disassembly (best guess):
   0: 03 4c 8d a3          add    -0x5d(%rbp,%rcx,4),%ecx
   4: 48 7e 2f              rex.W jle 0x36
   7: 89 4c 89 e7          mov    %ecx,-0x19(%rcx,%rcx,4)
   b: 45 31 ff              xor    %r15d,%r15d
   e: e8 57 db 61 02        callq  0x261db6a
  13: 48 89 c6              mov    %rax,%rsi
  16: 48 c7 c0 40 7e 2f 89 mov    $0xffffffff892f7e40,%rax
  1d: 4c 8b 2c 18          mov    (%rax,%rbx,1),%r13
  21: 4d 85 ed              test   %r13,%r13
  24: 74 70                je     0x96
  26: 41 83 c7 01          add    $0x1,%r15d
* 2a: 4d 8b 4d 18          mov    0x18(%r13),%r9 <-- trapping instruction
  2e: 4c 39 4c 24 20        cmp    %r9,0x20(%rsp)
  33: 4d 8b 45 00          mov    0x0(%r13),%r8
  37: 77 52                ja     0x8b
  39: 4c 3b 4c 24 10        cmp    0x10(%rsp),%r9
  3e: 73 4b                jae    0x8b

Best,
Wei
