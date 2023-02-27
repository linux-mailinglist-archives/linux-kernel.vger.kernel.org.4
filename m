Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B446A4569
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjB0O7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjB0O7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:59:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DEA1CF4A;
        Mon, 27 Feb 2023 06:59:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A773C60DFD;
        Mon, 27 Feb 2023 14:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0232FC433EF;
        Mon, 27 Feb 2023 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677509943;
        bh=Qd7KuEgfZnLJE7sF6cQgd6N1JrAhH9cKK4jfvtXKGoY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FlaKjmz6cHh4W2oJP6X4w0imrBSj08evyX4PYTdT/TFFV5XENYryt7AzAVnbC8gpC
         cOJODxjiO8XjFOfSp2qHqw+dCMyUVVZ7wSAXbgrfVt9nE87WUB/c8smvq1ipZURbjO
         ODPRN3Qeovb3I7oPyH0H2gasfCnwyuCXFrSLfCis/XM9cfqNmCBEHulZl/RKX5H3td
         fdN3vJxOA5A3ga6+c6ufwTZn62sVCtjVF/1S5E2HS29dtCva68lHSejnWXJO2E2xUr
         CKgQgTws+LD80cRCwjSA7Z5o8xUXMVUK8OXnuLN+9TML9QIF3jHR0fiaO4PGktjUbc
         Ro4eUgUHEyi9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7CBD25C0165; Mon, 27 Feb 2023 06:59:02 -0800 (PST)
Date:   Mon, 27 Feb 2023 06:59:02 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        Sanan Hasanov <sanan.hasanov@knights.ucf.edu>,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, contact@pgazz.com
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in rcu_core
Message-ID: <20230227145902.GD2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAABZP2z+Hk_w7nAhhyhJA9zidQViibMUO_xYianfm3xcG1QQwQ@mail.gmail.com>
 <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D59B7575-FAB1-4446-BBA9-DF5EAA1B5DCA@joelfernandes.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 08:15:26AM -0500, Joel Fernandes wrote:
> 
> 
> > On Feb 27, 2023, at 3:03 AM, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> > 
> > ﻿Hi
> > 
> >> On Mon, Feb 27, 2023 at 2:30 PM Sanan Hasanov
> >> <sanan.hasanov@knights.ucf.edu> wrote:
> >> 
> >> Good day, dear maintainers,
> >> 
> >> We found a bug using a modified kernel configuration file used by syzbot.
> >> 
> >> We enhanced the coverage of the configuration file using our tool, klocalizer.
> >> 
> >> Kernel Branch: 6.2.0-next-20230221
> >> Kernel config: https://drive.google.com/file/d/1QKAQV11zjOwISifUc-skRBoTo3EXhutY/view?usp=share_link
> >> C Reproducer: Unfortunately, there is no reproducer yet.
> 
> Sanan/Zhoui,
> Could you also provide the full kernel dmesg? Could you enable CONFIG_DEBUG_INFO_DWARF5 and provide the vmlinux after the crash?
> 
> More comments below:
> 
> >> 
> >> BUG: kernel NULL pointer dereference, address: 0000000000000000
> >> #PF: supervisor instruction fetch in kernel mode
> >> #PF: error_code(0x0010) - not-present page
> >> PGD 53756067 P4D 53756067 PUD 0
> >> Oops: 0010 [#1] PREEMPT SMP KASAN
> >> CPU: 7 PID: 0 Comm: swapper/7 Not tainted 6.2.0-next-20230221 #1
> >> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> >> RIP: 0010:0x0
> >> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> >> RSP: 0018:ffffc900003f8e48 EFLAGS: 00010246
> >> RAX: 0000000000000000 RBX: ffff888100833900 RCX: 00000000b9582f6c
> >> RDX: 1ffff11020106853 RSI: ffffffff816b2769 RDI: ffff888043f64708
> >> RBP: 000000000000000c R08: 0000000000000000 R09: ffffffff900b895f
> >> R10: fffffbfff201712b R11: 000000000008e001 R12: dffffc0000000000
> >> R13: ffffc900003f8ec8 R14: ffff888043f64708 R15: 000000000000000b
> >> FS:  0000000000000000(0000) GS:ffff888119f80000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: ffffffffffffffd6 CR3: 0000000054e64000 CR4: 0000000000350ee0
> >> Call Trace:
> >> <IRQ>
> >> rcu_core+0x85d/0x1960
> >> __do_softirq+0x2e5/0xae2
> >> __irq_exit_rcu+0x11d/0x190
> >> irq_exit_rcu+0x9/0x20
> >> sysvec_apic_timer_interrupt+0x97/0xc0
> >> </IRQ>
> >> <TASK>
> >> asm_sysvec_apic_timer_interrupt+0x1a/0x20
> >> RIP: 0010:default_idle+0xf/0x20
> >> Code: 89 07 49 c7 c0 08 00 00 00 4d 29 c8 4c 01 c7 4c 29 c2 e9 76 ff ff ff cc cc cc cc f3 0f 1e fa eb 07 0f 00 2d e3 8a 34 00 fb f4 <fa> c3 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 65
> >> RSP: 0018:ffffc9000017fe00 EFLAGS: 00000202
> >> RAX: 0000000000dfbea1 RBX: dffffc0000000000 RCX: ffffffff89b1da9c
> >> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> >> RBP: 0000000000000007 R08: 0000000000000001 R09: ffff888119fb6c23
> >> R10: ffffed10233f6d84 R11: dffffc0000000000 R12: 0000000000000003
> >> R13: ffff888100833900 R14: ffffffff8e112850 R15: 0000000000000000
> >> default_idle_call+0x67/0xa0
> >> do_idle+0x361/0x440
> >> cpu_startup_entry+0x18/0x20
> >> start_secondary+0x256/0x300
> >> secondary_startup_64_no_verify+0xce/0xdb
> >> </TASK>
> >> Modules linked in:
> >> CR2: 0000000000000000
> >> ---[ end trace 0000000000000000 ]---
> >> RIP: 0010:0x0
> >> Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> 
> I have seen this exact signature when the processor tries to execute a function that has a NULL address. That causes IP to goto 0 and the exception. Sounds like something corrupted rcu_head (Just a guess).

Quite possibly!  If so, then building with CONFIG_DEBUG_OBJECTS_RCU_HEAD=y
might be helpful.

Once a reproducer is foud, of course...

							Thanx, Paul

> >> RSP: 0018:ffffc900003f8e48 EFLAGS: 00010246
> >> 
> >> RAX: 0000000000000000 RBX: ffff888100833900 RCX: 00000000b9582f6c
> >> RDX: 1ffff11020106853 RSI: ffffffff816b2769 RDI: ffff888043f64708
> >> RBP: 000000000000000c R08: 0000000000000000 R09: ffffffff900b895f
> >> R10: fffffbfff201712b R11: 000000000008e001 R12: dffffc0000000000
> >> R13: ffffc900003f8ec8 R14: ffff888043f64708 R15: 000000000000000b
> >> FS:  0000000000000000(0000) GS:ffff888119f80000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: ffffffffffffffd6 CR3: 0000000054e64000 CR4: 0000000000350ee0
> >> ----------------
> >> Code disassembly (best guess):
> >>   0:   89 07                   mov    %eax,(%rdi)
> >>   2:   49 c7 c0 08 00 00 00    mov    $0x8,%r8
> >>   9:   4d 29 c8                sub    %r9,%r8
> >>   c:   4c 01 c7                add    %r8,%rdi
> >>   f:   4c 29 c2                sub    %r8,%rdx
> >>  12:   e9 76 ff ff ff          jmp    0xffffff8d
> >>  17:   cc                      int3
> >>  18:   cc                      int3
> >>  19:   cc                      int3
> >>  1a:   cc                      int3
> >>  1b:   f3 0f 1e fa             endbr64
> >>  1f:   eb 07                   jmp    0x28
> >>  21:   0f 00 2d e3 8a 34 00    verw   0x348ae3(%rip)        # 0x348b0b
> >>  28:   fb                      sti
> >>  29:   f4                      hlt
> >> * 2a:   fa                      cli <-- trapping instruction
> 
> This probably happened before the crash and it is likely unrelated IMO. cli just means interrupts were enabled, the actual problem happened after softirq fired (likely at the tail end of the interrupt).
> 
> Thanks,
> 
>  - Joel 
> 
> 
> >>  2b:   c3                      ret
> >>  2c:   66 66 2e 0f 1f 84 00    data16 cs nopw 0x0(%rax,%rax,1)
> >>  33:   00 00 00 00
> >>  37:   0f 1f 40 00             nopl   0x0(%rax)
> >>  3b:   f3 0f 1e fa             endbr64
> >>  3f:   65                      gs
> >> 
