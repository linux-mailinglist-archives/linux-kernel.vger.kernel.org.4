Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB93063E700
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 02:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLABR0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 20:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLABRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:17:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E5C97912
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:17:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBAC0B81DA6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:17:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900E6C433C1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 01:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669857441;
        bh=myVISEgQPICcTtw6geOyGVidGo/WDYOXviUTQMLOP4c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G3PsR0/4EeDPH3WAy/6mgWy+rvRCNXFds+Ne5nRpPKtruKay22w1K8zskBY006pRm
         opZ7R5m/MnJU1P+4Ew/ypFiajZeko/2MAyRmVukizVogoUSKgL5fAktAVWjjEdKrsE
         PADb5yJ5/ShnPyEjL5SNtfGYsunSCI2yvJAV9ea/5aO2LbbqS0D8jd5wFkLEIWMaoo
         gcpeDZ8JYjrTEuBoav335LAA+WvCzELndJQ/zF4u5g2V7dodU3WFeJA8lvLPlA+lzl
         Pzxnw4OlhLV+eXbJcrPSzzC9/DCn6iCenEpqJiC9KZNH4TIXKYUunDqzkTPJrXEtSe
         HbzQJQAtHnGUQ==
Received: by mail-ed1-f49.google.com with SMTP id e13so388537edj.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:17:21 -0800 (PST)
X-Gm-Message-State: ANoB5pnh25qYTYwlepwIMZ+u3+t9wQB4knQ2xFo6+Ed8BbpxBl/g7MKt
        wpvu/LFXgFDI8bcFQ5qddcOi1pNhVtUB1ZREFaI=
X-Google-Smtp-Source: AA0mqf6qW/O6MuNLq8Q3suQDIZ7MTPFUAbg0n/ut2l1kl8azfaMDA47Aj9YIvCarSXlRTn/0Tl1SYUL1HCja5jIvabE=
X-Received: by 2002:aa7:d912:0:b0:46b:2b37:ffa9 with SMTP id
 a18-20020aa7d912000000b0046b2b37ffa9mr15191818edr.79.1669857439770; Wed, 30
 Nov 2022 17:17:19 -0800 (PST)
MIME-Version: 1.0
References: <CAJF2gTQ0xuJo6uzB+8SudZOFiZ2_o1sLB=Hn5XuCw6g2tXUtkQ@mail.gmail.com>
 <mhng-72408cf8-cbde-489b-9042-379b5aa8624f@palmer-ri-x1c9>
In-Reply-To: <mhng-72408cf8-cbde-489b-9042-379b5aa8624f@palmer-ri-x1c9>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 1 Dec 2022 09:17:07 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ2=Ew76-=93WKAiLJzw+Wp4v7g=yyeeVZ5M5q88YsRLg@mail.gmail.com>
Message-ID: <CAJF2gTQ2=Ew76-=93WKAiLJzw+Wp4v7g=yyeeVZ5M5q88YsRLg@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: fix race when vmap stack overflow
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Andrea Parri <andrea@rivosinc.com>, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 12:54 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> On Tue, 29 Nov 2022 23:15:40 PST (-0800), guoren@kernel.org wrote:
> > The comment becomes better. Thx.
> >
> > On Wed, Nov 30, 2022 at 10:29 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> >>
> >> From: Jisheng Zhang <jszhang@kernel.org>
> >>
> >> Currently, when detecting vmap stack overflow, riscv firstly switches
> >> to the so called shadow stack, then use this shadow stack to call the
> >> get_overflow_stack() to get the overflow stack. However, there's
> >> a race here if two or more harts use the same shadow stack at the same
> >> time.
> >>
> >> To solve this race, we introduce spin_shadow_stack atomic var, which
> >> will be swap between its own address and 0 in atomic way, when the
> >> var is set, it means the shadow_stack is being used; when the var
> >> is cleared, it means the shadow_stack isn't being used.
> >>
> >> Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
> >> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> >> Suggested-by: Guo Ren <guoren@kernel.org>
> >> Reviewed-by: Guo Ren <guoren@kernel.org>
> >> Link: https://lore.kernel.org/r/20221030124517.2370-1-jszhang@kernel.org
> >> [Palmer: Add AQ to the swap, and also some comments.]
> >> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> >> ---
> >> Sorry to just re-spin this one without any warning, but I'd read patch a
> >> few times and every time I'd managed to convice myself there was a much
> >> simpler way of doing this.  By the time I'd figured out why that's not
> >> the case it seemed faster to just write the comments.
> >>
> >> I've stashed this, right on top of the offending commit, at
> >> palmer/riscv-fix_vmap_stack.
> >>
> >> Since v3:
> >>  - Add AQ to the swap.
> >>  - Add a bunch of comments.
> >>
> >> Since v2:
> >>  - use REG_AMOSWAP
> >>  - add comment to the purpose of smp_store_release()
> >>
> >> Since v1:
> >>  - use smp_store_release directly
> >>  - use unsigned int instead of atomic_t
> >> ---
> >>  arch/riscv/include/asm/asm.h |  1 +
> >>  arch/riscv/kernel/entry.S    | 13 +++++++++++++
> >>  arch/riscv/kernel/traps.c    | 18 ++++++++++++++++++
> >>  3 files changed, 32 insertions(+)
> >>
> >> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> >> index 618d7c5af1a2..e15a1c9f1cf8 100644
> >> --- a/arch/riscv/include/asm/asm.h
> >> +++ b/arch/riscv/include/asm/asm.h
> >> @@ -23,6 +23,7 @@
> >>  #define REG_L          __REG_SEL(ld, lw)
> >>  #define REG_S          __REG_SEL(sd, sw)
> >>  #define REG_SC         __REG_SEL(sc.d, sc.w)
> >> +#define REG_AMOSWAP_AQ __REG_SEL(amoswap.d.aq, amoswap.w.aq)
> > Below is the reason why I use the relax version here:
> > https://lore.kernel.org/all/CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=C+v+OL__GQam4A@mail.gmail.com/T/#u
>
> Sorry, I hadn't seen that one.  Adding Andrea.  IMO the acquire/release
> pair is necessary here, with just relaxed the stack stores inside the
> lock could show up on the next hart trying to use the stack.
Don't worry about relaxing amoswap, sp could give WAR & WAW
dependency. You could add acquire here, just for appearance.

>
> >>  #define REG_ASM                __REG_SEL(.dword, .word)
> >>  #define SZREG          __REG_SEL(8, 4)
> >>  #define LGREG          __REG_SEL(3, 2)
> >> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> >> index 98f502654edd..5fdb6ba09600 100644
> >> --- a/arch/riscv/kernel/entry.S
> >> +++ b/arch/riscv/kernel/entry.S
> >> @@ -387,6 +387,19 @@ handle_syscall_trace_exit:
> >>
> >>  #ifdef CONFIG_VMAP_STACK
> >>  handle_kernel_stack_overflow:
> >> +       /*
> >> +        * Takes the psuedo-spinlock for the shadow stack, in case multiple
> >> +        * harts are concurrently overflowing their kernel stacks.  We could
> >> +        * store any value here, but since we're overflowing the kernel stack
> >> +        * already we only have SP to use as a scratch register.  So we just
> >> +        * swap in the address of the spinlock, as that's definately non-zero.
> >> +        *
> >> +        * Pairs with a store_release in handle_bad_stack().
> >> +        */
> >> +1:     la sp, spin_shadow_stack
> >> +       REG_AMOSWAP_AQ sp, sp, (sp)
> >> +       bnez sp, 1b
> >> +
> >>         la sp, shadow_stack
> >>         addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
> >>
> >> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> >> index bb6a450f0ecc..be54ccea8c47 100644
> >> --- a/arch/riscv/kernel/traps.c
> >> +++ b/arch/riscv/kernel/traps.c
> >> @@ -213,11 +213,29 @@ asmlinkage unsigned long get_overflow_stack(void)
> >>                 OVERFLOW_STACK_SIZE;
> >>  }
> >>
> >> +/*
> >> + * A pseudo spinlock to protect the shadow stack from being used by multiple
> >> + * harts concurrently.  This isn't a real spinlock because the lock side must
> >> + * be taken without a valid stack and only a single register, it's only taken
> >> + * while in the process of panicing anyway so the performance and error
> >> + * checking a proper spinlock gives us doesn't matter.
> >> + */
> >> +unsigned long spin_shadow_stack;
> >> +
> >>  asmlinkage void handle_bad_stack(struct pt_regs *regs)
> >>  {
> >>         unsigned long tsk_stk = (unsigned long)current->stack;
> >>         unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
> >>
> >> +       /*
> >> +        * We're done with the shadow stack by this point, as we're on the
> >> +        * overflow stack.  Tell any other concurrent overflowing harts that
> >> +        * they can proceed with panicing by releasing the pseudo-spinlock.
> >> +        *
> >> +        * This pairs with an amoswap.aq in handle_kernel_stack_overflow.
> >> +        */
> >> +       smp_store_release(&spin_shadow_stack, 0);
> >> +
> >>         console_verbose();
> >>
> >>         pr_emerg("Insufficient stack space to handle exception!\n");
> >> --
> >> 2.38.1
> >>



-- 
Best Regards
 Guo Ren
