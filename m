Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041BC665C5B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbjAKNWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjAKNWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:22:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0672632
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:22:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E57861C4E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9B7C433EF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673443342;
        bh=WqpP15dPBJRpIKvrusU6JyT5rkDM538Zoeb9APxP3Vc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OkSqsAVkgsvAIhCaXvhWIuLPVf9jc2hJYv80GiHsi3/SlPvjvOh6rUIcW0W68jhzI
         BHs6uSHZloBNrCFCbUGpWRDGhT3A5BZlh8LGzgCsc2Dof7eXznlcvpyNDenudFLwGn
         rv/4PIpMRcG1tWTMxAzNCyLN9Cc5yHab8SehOC6Sgr2QkaJSxrNjM5cie+ibrP8pAO
         sAf7Ck3dNyN6tgO9kfBkuZSr3umpqtyCmc6YqEbHAZD81tQqc6/n/xwKj5/JbkhCSn
         srb2O4NfceSbRC8QDpmoYNZEz0JH7IO+vxgY7/ddW5HSe/hchAptcrFJ6qL3KfJt0l
         Okf9KAOu9Kogg==
Received: by mail-ed1-f54.google.com with SMTP id m21so22307827edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:22:22 -0800 (PST)
X-Gm-Message-State: AFqh2kpbDX6VI4nZ409CD1LqW9g3zMm8SmFid6eq27cm+QMjDB/AyOyB
        0MEMZWaO/3sAvhxu6uiEsZ1RALxzRF6DPBJqYgM=
X-Google-Smtp-Source: AMrXdXtS26Yr3ozZ4stDJwuSTJl5cHPl3A84rtoZBgUd1+9pSn2HAMtOpAKid8uCnEz8FrI5A7nOoQoDKoNa2QavWa4=
X-Received: by 2002:a05:6402:785:b0:497:37db:303a with SMTP id
 d5-20020a056402078500b0049737db303amr1754019edy.117.1673443341085; Wed, 11
 Jan 2023 05:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20230107133549.4192639-1-guoren@kernel.org> <20230107133549.4192639-2-guoren@kernel.org>
 <Y7xMvAJXjHaus0Bm@FVFF77S0Q05N>
In-Reply-To: <Y7xMvAJXjHaus0Bm@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 11 Jan 2023 21:22:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRzS0hBdqBUNbijvKKx3Kf_mY55XSkUyPJsfOK8p15_Mw@mail.gmail.com>
Message-ID: <CAJF2gTRzS0hBdqBUNbijvKKx3Kf_mY55XSkUyPJsfOK8p15_Mw@mail.gmail.com>
Subject: Re: [PATCH -next V6 1/7] riscv: ftrace: Fixup panic by disabling preemption
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        e.shatokhin@yadro.com, linux-riscv@lists.infradead.org,
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

On Tue, Jan 10, 2023 at 1:20 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Sat, Jan 07, 2023 at 08:35:43AM -0500, guoren@kernel.org wrote:
> > From: Andy Chiu <andy.chiu@sifive.com>
> >
> > In RISCV, we must use an AUIPC + JALR pair to encode an immediate,
> > forming a jump that jumps to an address over 4K. This may cause errors
> > if we want to enable kernel preemption and remove dependency from
> > patching code with stop_machine(). For example, if a task was switched
> > out on auipc. And, if we changed the ftrace function before it was
> > switched back, then it would jump to an address that has updated 11:0
> > bits mixing with previous XLEN:12 part.
> >
> > p: patched area performed by dynamic ftrace
> > ftrace_prologue:
> > p|      REG_S   ra, -SZREG(sp)
> > p|      auipc   ra, 0x? ------------> preempted
> >                                       ...
> >                               change ftrace function
> >                                       ...
> > p|      jalr    -?(ra) <------------- switched back
> > p|      REG_L   ra, -SZREG(sp)
> > func:
> >       xxx
> >       ret
>
> What happens on SMP but not !PREEMPTION; can't a CPU be in the middle of this
> while you're patching the sequence?
Yes, when PREEMPTION, a timer interrupt between auipc & jalr may cause
context_switch. And riscv uses stop_machine for patch_text. Then, we
may modify auipc part, but only execute the jalr part when return.

>
> Do you have any guarantee as to the atomicity and ordering of instruction
> fetches?
Not yet. If the region is short, we could use nop + jalr pair instead.
Only one jalr instruction makes the entry atomicity.

There are already several proposed solutions:
1. Make stop_machine guarantee all CPU out of preemption point.
2. Expand -fpatchable-function-entry from 4 to 24, and make detour
codes atomicity.
3. We want to propose a solution to make auipc by hardware mask_irq.
For more details, see:
https://www.youtube.com/watch?v=4JkkkXuEvCw


>
> Thanks,
> Mark.
>
> >
> > Fixes: afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
> > Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index e2b656043abf..ee0d39b26794 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -138,7 +138,7 @@ config RISCV
> >       select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> >       select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> >       select HAVE_FUNCTION_GRAPH_TRACER
> > -     select HAVE_FUNCTION_TRACER if !XIP_KERNEL
> > +     select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
> >
> >  config ARCH_MMAP_RND_BITS_MIN
> >       default 18 if 64BIT
> > --
> > 2.36.1
> >



--
Best Regards
 Guo Ren
