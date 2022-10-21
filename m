Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7EE606CE6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiJUBLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbiJUBLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:11:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DBB233980
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 18:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3066561D7E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AE14C43150
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666314696;
        bh=zj2R2EeuAoIlK9K+n2SHRBjvUH7ZW6esdrFQXcc7cGo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W+nbWPleYa3gGCafB/dPPTJTwwZRQ3Rgaw5ZF/e6QxmEIds6cP1O1m0xnfrc7DSci
         fjv8Ipun4cosyte1N1OZ/BMAEk1vgbuEK8RLnVkb71T61XXKShcqveIL+YXOkg/C85
         M9ySX+e2CBsdX3XGyvROfCBgHrNWNWzPxu28q94lr1YyxtC0kmo0coWNGyCE9ZIYIN
         dXi6GyUjf5ec+yIB2eOFt8RJQLNuYG8x69PnJ+3Ov1LV07+4+snLF2a5KfjokKW903
         Wz6GaViL3ywcOSvu1goZiaMHYgN7ZohLhjGH1sObFFzZfrg5kzW/EG1gYfBhCAkb8c
         xuY1C1mF7mydw==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-13aeccf12fbso1701672fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 18:11:36 -0700 (PDT)
X-Gm-Message-State: ACrzQf1lz2X4DMIhc47t9EO6uFnkLoXXIYuEXdif4DUcaIrEOuGEHsZD
        RIhqpVNZuQwfX/AS8zESznVYLmru+OJSNasnBm0=
X-Google-Smtp-Source: AMsMyM41rqetlYAfk04Uk64NiYfIAaeUDKaVUvjDO2wwlkmVIwyeXpVrBv3cP7g7+Gx+G9zIXVmNjKz3tu3FLRIlkqk=
X-Received: by 2002:a05:6871:b0d:b0:13b:b91:dc94 with SMTP id
 fq13-20020a0568710b0d00b0013b0b91dc94mr2649194oab.112.1666314695632; Thu, 20
 Oct 2022 18:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221019154727.2395-1-jszhang@kernel.org> <Y1HZFcBo21SQzXVj@andrea>
In-Reply-To: <Y1HZFcBo21SQzXVj@andrea>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 21 Oct 2022 09:11:23 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=C+v+OL__GQam4A@mail.gmail.com>
Message-ID: <CAJF2gTRAEX_jQ_w5H05dyafZzHq+P5j05TJ=C+v+OL__GQam4A@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix race when vmap stack overflow
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 7:26 AM Andrea Parri <parri.andrea@gmail.com> wrote:
>
> Hi Jisheng,
>
> On Wed, Oct 19, 2022 at 11:47:27PM +0800, Jisheng Zhang wrote:
> > Currently, when detecting vmap stack overflow, riscv firstly switches
> > to the so called shadow stack, then use this shadow stack to call the
> > get_overflow_stack() to get the overflow stack. However, there's
> > a race here if two or more harts use the same shadow stack at the same
> > time.
> >
> > To solve this race, we introduce spin_shadow_stack atomic var, which
> > will make the shadow stack usage serialized.
> >
> > Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Suggested-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/kernel/entry.S | 4 ++++
> >  arch/riscv/kernel/traps.c | 4 ++++
> >  2 files changed, 8 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> > index b9eda3fcbd6d..7b924b16792b 100644
> > --- a/arch/riscv/kernel/entry.S
> > +++ b/arch/riscv/kernel/entry.S
> > @@ -404,6 +404,10 @@ handle_syscall_trace_exit:
> >
> >  #ifdef CONFIG_VMAP_STACK
> >  handle_kernel_stack_overflow:
> > +1:   la sp, spin_shadow_stack
> > +     amoswap.w sp, sp, (sp)
> > +     bnez sp, 1b
> > +
> >       la sp, shadow_stack
> >       addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
> >
> > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > index f3e96d60a2ff..88a54947dffb 100644
> > --- a/arch/riscv/kernel/traps.c
> > +++ b/arch/riscv/kernel/traps.c
> > @@ -221,11 +221,15 @@ asmlinkage unsigned long get_overflow_stack(void)
> >               OVERFLOW_STACK_SIZE;
> >  }
> >
> > +atomic_t spin_shadow_stack;
> > +
> >  asmlinkage void handle_bad_stack(struct pt_regs *regs)
> >  {
> >       unsigned long tsk_stk = (unsigned long)current->stack;
> >       unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
> >
> > +     atomic_set_release(&spin_shadow_stack, 0);
> > +
>
> Have not really looked the details: should there be a matching acquire?

I use atomic_set_release here, because I need earlier memory
operations finished to make sure the sp is ready then set the spin
flag.

The following memory operations order is not important, because we
just care about sp value.

Also, we use relax amoswap before, because sp has naturelly
dependency. But giving them RCsc is okay here, because we don't care
about performance here.
eg:
 handle_kernel_stack_overflow:
+1:     la sp, spin_shadow_stack
+       amoswap.w.aqrl sp, sp, (sp)
+       bnez sp, 1b
+
....
+     smp_store_release(&spin_shadow_stack, 0);
+     smp_mb();

>
>   Andrea
>
>
> >       console_verbose();
> >
> >       pr_emerg("Insufficient stack space to handle exception!\n");
> > --
> > 2.37.2
> >



--
Best Regards
 Guo Ren
