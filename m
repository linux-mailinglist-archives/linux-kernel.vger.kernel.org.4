Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F30F720F02
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 11:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjFCJnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 05:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFCJnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 05:43:06 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A374BE49
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 02:43:05 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-565a022ef06so34658297b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Jun 2023 02:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685785385; x=1688377385;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fq4R/ACxpSFMNUlOYBs9lWw1F9WTrn9MqOLWBnmUanM=;
        b=ECc8RYxnpejj5bhj460y+BK87IiIbDenfaXe1kxi9X9YtoMl/29tmH/3EnGH5VZWq0
         gDUoUtSZ1MmyBz2jsI8rvFzVUo6nUQHi05gyhRzkmZX6w8aI2GrbzgFkef/hqsrbVmRW
         kYBErFGG9CTmztYfUlYzJAt6BB1BzBDEp4IYxSG3gbXxJaVcKH+5Zs3TzqgFLraVFADe
         05KLp94CBbubH7mqrbvxP/1ahhQb/+H9fj9Hfa1pRqVgesc8SK9yXIPksIZtjbxxQYTi
         UXg6PktaFjBGiLHxb8kGuL9HNhAChSb//zF/4msIFz3SVFWBsBIgFn47set7l3BbNXf7
         5vGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685785385; x=1688377385;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fq4R/ACxpSFMNUlOYBs9lWw1F9WTrn9MqOLWBnmUanM=;
        b=OCJX03zztpRsxxad46hzJSke3LoSbevnXT6ezR5somagXcHW6m4dGfGEKLaTAGlxA2
         NhnRb6kYr1tdA2/ZFEWrQwlLAzFLz2cFw6IcBHVcfWxxtPT9AaQ7EkWHiPSZjhyK60ij
         b5j1SWlwEmu+dnusGVqwu/IYJqAkZiWRM1CtCeumy/WWWMXmslh8pImr2If4iN9ImdfI
         mkKLEVIdp0IKCTHlbqlvlT+5Vo6VMih994z2lAXTsZyN7EGvBJ4w9PLq4SL8295a3/Ig
         0fmi21z00bPZHTLAjDMvwjhdDxqRH2hrm9LWJ/krPHJ+FWVnQ+GRnvus+IGT9sAXuLsm
         QYhw==
X-Gm-Message-State: AC+VfDweuID9Z7jBH8lNIPC02nSuWuOHbcnPZrJdSYwusMPldRGubopw
        UsyNWyiMX/3O/uWY/i0uxhELACyP9rtFJElevic=
X-Google-Smtp-Source: ACHHUZ7kL2qT3dB+WOnHhaAeavA0y1c19LD8Iki7b8x7sPOjUSEDxzH9WEr3fIW+zVIImM8axUTmmpZx0g1ujGyPYnM=
X-Received: by 2002:a81:7c02:0:b0:569:44bf:8c0a with SMTP id
 x2-20020a817c02000000b0056944bf8c0amr3168902ywc.33.1685785384696; Sat, 03 Jun
 2023 02:43:04 -0700 (PDT)
MIME-Version: 1.0
From:   Palash Oswal <oswalpalash@gmail.com>
Date:   Sat, 3 Jun 2023 02:42:53 -0700
Message-ID: <CAGyP=7dN6DYyCQJHyJ_74eakHAJDT3Xk77nZ5r8+qUPLENeo2A@mail.gmail.com>
Subject: KASAN: stack-out-of-bounds Read in __remove_hrtimer
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I found the following issue using syzkaller with enriched corpus[1] on:
HEAD commit : 0bcc4025550403ae28d2984bddacafbca0a2f112
git tree: linux
C Reproducer : I do not have a C reproducer yet. I will update this
thread when I get one.
Kernel .config :
https://gist.github.com/oswalpalash/d9580b0bfce202b37445fa5fd426e41f

Link:
1. https://github.com/cmu-pasta/linux-kernel-enriched-corpus

Console log :
==================================================================
BUG: KASAN: stack-out-of-bounds in __remove_hrtimer+0x250/0x2a0
Read of size 1 at addr ffffc9000358fdd0 by task swapper/0/0

CPU: 0 PID: 0 Comm: swapper/0 Not tainted
6.3.0-rc6-pasta-00035-g0bcc40255504 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.13.0-1ubuntu1.1 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl+0xd9/0x150
 print_address_description.constprop.0+0x2c/0x3c0
 kasan_report+0x11c/0x130
 __remove_hrtimer+0x250/0x2a0
 __hrtimer_run_queues+0x4e0/0xbe0
 hrtimer_interrupt+0x320/0x7b0
 __sysvec_apic_timer_interrupt+0x14a/0x430
 sysvec_apic_timer_interrupt+0x92/0xc0
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20
RIP: 0010:default_idle+0xf/0x20
Code: 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 76 ff
ff ff cc cc cc cc f3 0f 1e fa eb 07 0f 00 2d 13 38 49 00 fb f4 <fa> c3
66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 65
RSP: 0018:ffffffff8c407e30 EFLAGS: 00000202
RAX: 000000000033b773 RBX: 0000000000000000 RCX: ffffffff89fd3ef5
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff8c495800 R08: 0000000000000001 R09: ffff888063a36cab
R10: ffffed100c746d95 R11: 0000000000000000 R12: fffffbfff1892b00
R13: 0000000000000000 R14: ffffffff8e769510 R15: 0000000000000000
 default_idle_call+0x67/0xa0

do_idle+0x31e/0x3e0

                                                             [31/73]
 cpu_startup_entry+0x18/0x20
 rest_init+0x16d/0x2b0
 arch_call_rest_init+0x13/0x30
 start_kernel+0x35a/0x4d0
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>

The buggy address belongs to the virtual mapping at
 [ffffc90003588000, ffffc90003591000) created by:
 kernel_clone+0xeb/0x890

The buggy address belongs to the physical page:
page:ffffea0004a0fa00 refcount:1 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x1283e8
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000000000 0000000000000000 dead000000000122 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask
0x2dc2(GFP_KERNEL|__GFP_HIGHMEM|__GFP_NOWARN|__GFP_ZERO), pid 8032,
tgid 8032 (syz-executor.1), ts 75313358350, free_ts 0
 get_page_from_freelist+0x1190/0x2e20
 __alloc_pages+0x1cb/0x4a0
 alloc_pages+0x1aa/0x270
 __vmalloc_node_range+0xb1c/0x14a0
 copy_process+0x1320/0x7590
 kernel_clone+0xeb/0x890
 __do_sys_clone+0xba/0x100
 do_syscall_64+0x39/0xb0
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
page_owner free stack trace missing

Memory state around the buggy address:
 ffffc9000358fc80: f3 f3 f3 00 f1 f1 f1 00 00 f2 f2 00 00 00 f3 f3
 ffffc9000358fd00: f3 f3 f3 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00
>ffffc9000358fd80: f3 f3 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00
                                                 ^
 ffffc9000358fe00: f3 f3 00 00 00 00 00 00 00 00 00 00 f3 f3 f3 f3
 ffffc9000358fe80: f3 00 00 00 00 00 00 00 00 00 00 00 f3 f3 f3 f3
==================================================================
----------------
Code disassembly (best guess):
   0:   89 07                   mov    %eax,(%rdi)
   2:   49 c7 c0 08 00 00 00    mov    $0x8,%r8
   9:   4d 29 c8                sub    %r9,%r8
   c:   4c 01 c7                add    %r8,%rdi
   f:   4c 29 c2                sub    %r8,%rdx
  12:   e9 76 ff ff ff          jmpq   0xffffff8d
  17:   cc                      int3
  18:   cc                      int3
  19:   cc                      int3
  1a:   cc                      int3
  1b:   f3 0f 1e fa             endbr64
  1f:   eb 07                   jmp    0x28
  21:   0f 00 2d 13 38 49 00    verw   0x493813(%rip)        # 0x49383b
  28:   fb                      sti
  29:   f4                      hlt
* 2a:   fa                      cli <-- trapping instruction
  2b:   c3                      retq
  2c:   66 66 2e 0f 1f 84 00    data16 nopw %cs:0x0(%rax,%rax,1)
  33:   00 00 00 00
  37:   0f 1f 40 00             nopl   0x0(%rax)
  3b:   f3 0f 1e fa             endbr64
  3f:   65                      gs
