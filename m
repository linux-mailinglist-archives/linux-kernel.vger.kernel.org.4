Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A0A6363CB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiKWPds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:33:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238580AbiKWPdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:33:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472D22E694
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 07:33:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2F9061D97
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 15:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D521CC433D6;
        Wed, 23 Nov 2022 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669217621;
        bh=L+7mmGSwYmB27FnIUdnUXABjZk7v8plFfYZee6on5P4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jcp4scnFf95K8fs7MLYgfmNNGjNYl+47x/Tc5/QwKp2DvUvXiuyW/Ej0T+tZRLv1y
         hfLbkffrtAH+IGaDnrwl86ysgWUrvtXoyjqNXb8miTGIVw3o4Oko7lFnJ5HOe5kb1F
         olMoa2OyFK/GXyfJ34U2Y45ST1My6Yj9AA5HA8MBf5Kuyy2Y929aP2b8a2yxbtbcGs
         gaxhBrQ5uQsXyrhCDbiTl/gwJASvqyrKoR4I+SyfIUJ/02CrWaZmtvUoqDXkDm8tKx
         3dJ6I+6rBtKArHE66wu9+PxgtSuytS9YXCpNfr0/4Jm27AlOQkpzl+n6jDCS31weg3
         k1/Is6TlrGIUw==
Date:   Wed, 23 Nov 2022 23:23:51 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] riscv: fix race when vmap stack overflow
Message-ID: <Y347B0x4VUNOd6V7@xhacker>
References: <20221030124517.2370-1-jszhang@kernel.org>
 <CAJF2gTRPECoPFHXKZZ8bRc27YSYv7z4xkYh+hTmfzmZg8=2Ejg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJF2gTRPECoPFHXKZZ8bRc27YSYv7z4xkYh+hTmfzmZg8=2Ejg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 09:23:51PM +0800, Guo Ren wrote:
> Reviewed-by: Guo Ren <guoren@kernel.org>
> 

Gentle ping? This patch is still missing in mainline.

> On Sun, Oct 30, 2022 at 8:54 PM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > Currently, when detecting vmap stack overflow, riscv firstly switches
> > to the so called shadow stack, then use this shadow stack to call the
> > get_overflow_stack() to get the overflow stack. However, there's
> > a race here if two or more harts use the same shadow stack at the same
> > time.
> >
> > To solve this race, we introduce spin_shadow_stack atomic var, which
> > will be swap between its own address and 0 in atomic way, when the
> > var is set, it means the shadow_stack is being used; when the var
> > is cleared, it means the shadow_stack isn't being used.
> >
> > Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Suggested-by: Guo Ren <guoren@kernel.org>
> > ---
> > Since v2:
> >  - use REG_AMOSWAP
> >  - add comment to the purpose of smp_store_release()
> >
> > Since v1:
> >  - use smp_store_release directly
> >  - use unsigned int instead of atomic_t
> >
> >
> >  arch/riscv/include/asm/asm.h | 1 +
> >  arch/riscv/kernel/entry.S    | 4 ++++
> >  arch/riscv/kernel/traps.c    | 9 +++++++++
> >  3 files changed, 14 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> > index 1b471ff73178..acf563072b8b 100644
> > --- a/arch/riscv/include/asm/asm.h
> > +++ b/arch/riscv/include/asm/asm.h
> > @@ -23,6 +23,7 @@
> >  #define REG_L          __REG_SEL(ld, lw)
> >  #define REG_S          __REG_SEL(sd, sw)
> >  #define REG_SC         __REG_SEL(sc.d, sc.w)
> > +#define REG_AMOSWAP    __REG_SEL(amoswap.d, amoswap.w)
> >  #define REG_ASM                __REG_SEL(.dword, .word)
> >  #define SZREG          __REG_SEL(8, 4)
> >  #define LGREG          __REG_SEL(3, 2)
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index b9eda3fcbd6d..ea6b78dac739 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -404,6 +404,10 @@ handle_syscall_trace_exit:
> >
> >  #ifdef CONFIG_VMAP_STACK
> >  handle_kernel_stack_overflow:
> > +1:     la sp, spin_shadow_stack
> > +       REG_AMOSWAP sp, sp, (sp)
> > +       bnez sp, 1b
> > +
> >         la sp, shadow_stack
> >         addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
> >
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index f3e96d60a2ff..dea47f329708 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -221,11 +221,20 @@ asmlinkage unsigned long get_overflow_stack(void)
> >                 OVERFLOW_STACK_SIZE;
> >  }
> >
> > +unsigned long spin_shadow_stack;
> > +
> >  asmlinkage void handle_bad_stack(struct pt_regs *regs)
> >  {
> >         unsigned long tsk_stk = (unsigned long)current->stack;
> >         unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
> >
> > +       /*
> > +        * to ensure spin flag is set after the sp is used in entry.S:
> > +        * //load per-cpu overflow stack.
> > +        * REG_L sp, -8(sp)
> > +        */
> > +       smp_store_release(&spin_shadow_stack, 0);
> > +
> >         console_verbose();
> >
> >         pr_emerg("Insufficient stack space to handle exception!\n");
> > --
> > 2.37.2
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
