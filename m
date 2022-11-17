Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C77662D0E2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiKQBz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbiKQBz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:55:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90267654EE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:55:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 164A862060
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7407EC43145
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668650155;
        bh=S0DqzMJHKbSmIvt1FFR0xECdHab+RFIBJvJI8T2w/Tc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FILurbRxsifye76/ouoCgqE7Q7XsXu0jtZEqYQ/blOGZe4iwAE3DAcdHkSvQ9iTkL
         J+Dbz0uXB0i5AyaWIhZFlcwW8vf5pllQzyN7ilIkK/rGmQC2j0gnaQ/NrtygqtjfBD
         wgiV7Cvax0Wuy3SyfU/BvMX6gUxwIm9xylwzkBY6ofi6M8S+E1oV9mAIf0gYm8PlkG
         tQw0zq+XN6fV/PuOg0cgbYn6CECMxB0ocfC5Hu1r1cyvQNsAlDH8yk4RvdLtLM7TZo
         rw1eZktny/4nGr+mdpI/Br3vTqPc+ngDalg4s2/DLlG3ACQ54ijwjuvM2R3wg0yBrx
         pA/JXm8Ng8RNg==
Received: by mail-ej1-f54.google.com with SMTP id ft34so1500347ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:55:55 -0800 (PST)
X-Gm-Message-State: ANoB5pkE+N+a5lIZlnZvGwKsZMCgRwxJXztqH04h8KNQiwKofeg4lYFW
        AHHlDa2YNzAee49XG1qYgNf2/mnYhj1Z1oMSUhk=
X-Google-Smtp-Source: AA0mqf4FmoJXxKh1bucmvcCygXSBfBAcHJDD3FKzWJIRyNGTgEkiXem5V5rtshJXRD2fvl9OMRrUskOJMWYJgOlU844=
X-Received: by 2002:a17:907:cf84:b0:78d:4795:ff1f with SMTP id
 ux4-20020a170907cf8400b0078d4795ff1fmr424058ejc.331.1668650153644; Wed, 16
 Nov 2022 17:55:53 -0800 (PST)
MIME-Version: 1.0
References: <20221116031305.286634-1-suagrfillet@gmail.com>
 <20221116031305.286634-3-suagrfillet@gmail.com> <20221116084540.aslzynq4bmar6f46@kamzik>
In-Reply-To: <20221116084540.aslzynq4bmar6f46@kamzik>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 17 Nov 2022 09:55:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSBdum6UwVkVq37mrH_GKssSMBCRAWKXKs31B3R3ypKpg@mail.gmail.com>
Message-ID: <CAJF2gTSBdum6UwVkVq37mrH_GKssSMBCRAWKXKs31B3R3ypKpg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] riscv/ftrace: SAVE_ALL supports lightweight save
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Song Shuai <suagrfillet@gmail.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 4:45 PM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Wed, Nov 16, 2022 at 11:13:04AM +0800, Song Shuai wrote:
> > In order to make the function graph use ftrace directly, ftrace_caller
> > should be adjusted to save the necessary regs against the pt_regs layout
> > so it can call ftrace_graph_func reasonably.
> >
> > SAVE_ALL now saves all the regs according to the pt_regs struct. Here
> > introduces a lightweight option for SAVE_ALL to save only the necessary
> > regs for ftrace_caller.
> >
> > For convenience, the original argument setup for the tracing function in
> > ftrace_[regs]_caller is killed and appended to the tail of SAVE_ALL.
> >
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > ---
> >  arch/riscv/kernel/mcount-dyn.S | 110 +++++++++++++++++++++++++++------
> >  1 file changed, 92 insertions(+), 18 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> > index d171eca623b6..2f0a280bd7a0 100644
> > --- a/arch/riscv/kernel/mcount-dyn.S
> > +++ b/arch/riscv/kernel/mcount-dyn.S
> > @@ -56,7 +56,51 @@
> >       .endm
> >
> >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > -     .macro SAVE_ALL
> > +
> > +/**
> > +* SAVE_ALL - save regs against the pt_regs struct
> > +*
> > +* @all: tell if saving all the regs
>
> I find it odd to have a macro name that includes 'ALL' in it
> to require a parameter 'all' to be set in order to actually save
> all. I suggest renaming the macro to something like SAVE_REGS.
SAVE_ABI_REGS <arg>
arg = 0 -> SAVE_ABI in pt_regs
arg = 1 -> SAVE_REGS

SAVE_ABI_REGS keeps the pt_regs layout and needs more stack space than SAVE_ABI.

>
> > +*
> > +* If all is set, all the regs will be saved, otherwise only ABI
> > +* related regs (a0-a7,epc,ra and optional s0) will be saved.
> > +*
> > +* For convenience the argument setup for tracing function is appended here.
> > +* Especially $sp is passed as the 4th argument of the tracing function.
> > +*
> > +* After the stack is established,
> > +*
> > +* 0(sp) stores the PC of the traced function which can be accessed
> > +* by &(fregs)->regs->epc in tracing function. Note that the real
> > +* function entry address should be computed with -FENTRY_RA_OFFSET.
> > +*
> > +* 8(sp) stores the function return address (i.e. parent IP) that
> > +* can be accessed by &(fregs)->regs->ra in tracing function.
> > +*
> > +* The other regs are saved at the respective localtion and accessed
> > +* by the respective pt_regs member.
> > +*
> > +* Here is the layout of stack for your reference.
> > +*
> > +*
> > +*                    =========
> > +*                    |  pip  |
> > +* PT_SIZE_ON_STACK  ->  =========
> > +*                    + ..... +
> > +*                    + t3-t6 +
> > +*                    + s2-s11+
> > +*                    + a0-a7 + --++++-> ftrace_caller saved
> > +*                    + s1    +   +
> > +*                    + s0    + --+
> > +*                    + t0-t2 +   +
> > +*                    + tp    +   +
> > +*                    + gp    +   +
> > +*                    + sp    +   +
> > +*                    + ra    + --+ // parent IP
> > +*            sp  ->  + epc   + --+ // PC of the traced function
> > +*                    +++++++++
> > +**/
> > +     .macro SAVE_ALL, all=0
> >       addi    sp, sp, -SZREG
> >       addi    sp, sp, -PT_SIZE_ON_STACK
> >
> > @@ -67,14 +111,8 @@
> >       REG_S x1,  PT_RA(sp)
> >       REG_L x1,  PT_EPC(sp)
> >
> > -     REG_S x2,  PT_SP(sp)
> > -     REG_S x3,  PT_GP(sp)
> > -     REG_S x4,  PT_TP(sp)
> > -     REG_S x5,  PT_T0(sp)
> > -     REG_S x6,  PT_T1(sp)
> > -     REG_S x7,  PT_T2(sp)
> > -     REG_S x8,  PT_S0(sp)
> > -     REG_S x9,  PT_S1(sp)
> > +     /* always save the ABI regs */
> > +
> >       REG_S x10, PT_A0(sp)
> >       REG_S x11, PT_A1(sp)
> >       REG_S x12, PT_A2(sp)
> > @@ -83,6 +121,18 @@
> >       REG_S x15, PT_A5(sp)
> >       REG_S x16, PT_A6(sp)
> >       REG_S x17, PT_A7(sp)
> > +
> > +     /* save leftover regs for ftrace_regs_caller*/
> > +
> > +     .if \all == 1
> > +     REG_S x2,  PT_SP(sp)
> > +     REG_S x3,  PT_GP(sp)
> > +     REG_S x4,  PT_TP(sp)
> > +     REG_S x5,  PT_T0(sp)
> > +     REG_S x6,  PT_T1(sp)
> > +     REG_S x7,  PT_T2(sp)
> > +     REG_S x8,  PT_S0(sp)
> > +     REG_S x9,  PT_S1(sp)
> >       REG_S x18, PT_S2(sp)
> >       REG_S x19, PT_S3(sp)
> >       REG_S x20, PT_S4(sp)
> > @@ -97,22 +147,31 @@
> >       REG_S x29, PT_T4(sp)
> >       REG_S x30, PT_T5(sp)
> >       REG_S x31, PT_T6(sp)
> > +     .else
> > +
> > +     /* save s0 for ftrace_caller if FP_TEST defined */
> > +
> > +#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
> > +     REG_S x8,  PT_S0(sp)
> > +#endif
> > +     .endif
> > +
> > +     /* setup 4 args for tracing functions  */
> > +
> > +     addi    a0, ra, -FENTRY_RA_OFFSET // ip
> > +     la      a1, function_trace_op
> > +     REG_L   a2, 0(a1)               // op
> > +     REG_L   a1, PT_SIZE_ON_STACK(sp) // parent_ip
> > +     mv      a3, sp                  // fregs
>
> Please line up the comments.
>
> >       .endm
> >
> > -     .macro RESTORE_ALL
> > +     .macro RESTORE_ALL, all=0
> >       REG_L x1,  PT_RA(sp)
> >       addi    sp, sp, PT_SIZE_ON_STACK
> >       REG_S x1,  (sp)
> >       addi    sp, sp, -PT_SIZE_ON_STACK
> >       REG_L x1,  PT_EPC(sp)
> > -     REG_L x2,  PT_SP(sp)
> > -     REG_L x3,  PT_GP(sp)
> > -     REG_L x4,  PT_TP(sp)
> > -     REG_L x5,  PT_T0(sp)
> > -     REG_L x6,  PT_T1(sp)
> > -     REG_L x7,  PT_T2(sp)
> > -     REG_L x8,  PT_S0(sp)
> > -     REG_L x9,  PT_S1(sp)
> > +
> >       REG_L x10, PT_A0(sp)
> >       REG_L x11, PT_A1(sp)
> >       REG_L x12, PT_A2(sp)
> > @@ -121,6 +180,16 @@
> >       REG_L x15, PT_A5(sp)
> >       REG_L x16, PT_A6(sp)
> >       REG_L x17, PT_A7(sp)
> > +
> > +     .if \all == 1
> > +     REG_L x2,  PT_SP(sp)
> > +     REG_L x3,  PT_GP(sp)
> > +     REG_L x4,  PT_TP(sp)
> > +     REG_L x5,  PT_T0(sp)
> > +     REG_L x6,  PT_T1(sp)
> > +     REG_L x7,  PT_T2(sp)
> > +     REG_L x8,  PT_S0(sp)
> > +     REG_L x9,  PT_S1(sp)
> >       REG_L x18, PT_S2(sp)
> >       REG_L x19, PT_S3(sp)
> >       REG_L x20, PT_S4(sp)
> > @@ -136,6 +205,11 @@
> >       REG_L x30, PT_T5(sp)
> >       REG_L x31, PT_T6(sp)
> >
> > +     .else
> > +#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
> > +     REG_L x8,  PT_S0(sp)
> > +#endif
> > +     .endif
> >       addi    sp, sp, PT_SIZE_ON_STACK
> >       addi    sp, sp, SZREG
> >       .endm
> > --
> > 2.20.1
> >
> >
>
> Thanks,
> drew



-- 
Best Regards
 Guo Ren
