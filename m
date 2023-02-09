Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4749F68FCA4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 02:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjBIBbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 20:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBIBbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 20:31:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B246821A07
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 17:31:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CFACB81E4C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C1D1C433EF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 01:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675906299;
        bh=aYaN7NXRw0ihNR+IL/yGz5yH+5GqO6mxr4X8PdaZnj4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=siGYUNOg2wrrXSZ4e95rNkJJfbu3Y45ev3m1v06eXF4jB44fcEoNegj1Vahw5OtL0
         xEqprlwErEqer0L5H+PRK5Ipsywpt5kKjiqnZyluXb9K8JRSTr6cxgBsBHaWEUFovZ
         vp5VGB2020uFgHy6epXWOSZbhS4jkaOAAqicDfK5mQ8+9LlmtW4RqDo7YKLdMJDV0t
         TPLmU0pn4IMZTlCZB7EtUSLuvaioTGYPD6CksXAJdLaU4+vsFJ3V04wc17D57caxl1
         kRnKJs+4qllWRk5Ce44ERNI/n+jbVbWevgWdGdb1gtXfIYDotHULQOWCyxXsq9wNRo
         0tT0ea3H6U6JA==
Received: by mail-ej1-f47.google.com with SMTP id jg8so2159681ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 17:31:38 -0800 (PST)
X-Gm-Message-State: AO0yUKW7JhhykEASCCIUCl2ae45H2UODP0Ba635V/9pfZSfHJlZb5nGe
        +TU65eMMIgXQyv8K8Ry3TeQfTjJKLAPcsSz1K0w=
X-Google-Smtp-Source: AK7set+qmRqoasUpDzhPwymmA1qkI+3NCkGEKe2NpeNzkWqJwSssQ9kHsZ/YyzGRyn8zv9Q3ixAdPd1Gnp+qH9itwMw=
X-Received: by 2002:a17:906:3e04:b0:884:c19c:7c6 with SMTP id
 k4-20020a1709063e0400b00884c19c07c6mr1991658eji.120.1675906297178; Wed, 08
 Feb 2023 17:31:37 -0800 (PST)
MIME-Version: 1.0
References: <20230112090603.1295340-1-guoren@kernel.org> <c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com>
 <CAJF2gTQm11px3mqyrNk1SRiJZud1yeY2avK99UX9KetWAGe5BA@mail.gmail.com>
 <Y+DOyqehZvBJlb8N@FVFF77S0Q05N> <CAJF2gTQ6U1vH79Mu53eQ-GVaFx36C-hEt9Qf6=_vAkHfmgFh1Q@mail.gmail.com>
 <Y+IXB4xQ7ACQWC9U@FVFF77S0Q05N> <CAJF2gTTrX+8wCm-g=L9+3BkCRrZ8SCUM2w1e5duq-+Bsa213mA@mail.gmail.com>
 <Y+O1qY453BnhqgQZ@FVFF77S0Q05N.cambridge.arm.com>
In-Reply-To: <Y+O1qY453BnhqgQZ@FVFF77S0Q05N.cambridge.arm.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 9 Feb 2023 09:31:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT_aMBx3mPnzWWqj6uGM75yT_62x+_wZ4HkWd7BqEzvug@mail.gmail.com>
Message-ID: <CAJF2gTT_aMBx3mPnzWWqj6uGM75yT_62x+_wZ4HkWd7BqEzvug@mail.gmail.com>
Subject: Re: [PATCH -next V7 0/7] riscv: Optimize function trace
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Evgenii Shatokhin <e.shatokhin@yadro.com>, suagrfillet@gmail.com,
        andy.chiu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023 at 10:46 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Wed, Feb 08, 2023 at 10:30:56AM +0800, Guo Ren wrote:
> > Hi Mark,
> >
> > Thx for the thoughtful reply.
> >
> > On Tue, Feb 7, 2023 at 5:17 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > Note that I'm assuming you will *always* go through a common ftrace_caller
> > > trampoline (even for direct calls), with the trampoline responsible for
> > > recovering the direct trampoline (or ops->func) from the ops pointer.
> > >
> > > That would only require 64-bit alignment on 64-bit (or 32-bit alignment on
> > > 32-bit) to keep the literal naturally-aligned; the rest of the instructions
> > > wouldn't require additional alignment.
> > >
> > > For example, I would expect that (for 64-bit) you'd use:
> > >
> > >   # place 2 NOPs *immediately before* the function, and 3 NOPs at the start
> > >   -fpatchable-function-entry=5,2
> > >
> > >   # Align the function to 8-bytes
> > >   -falign=functions=8
> > >
> > > ... and your trampoline in each function could be initialized to:
> > >
> > >   # Note: aligned to 8 bytes
> > >   addr-08               // Literal (first 32-bits)      // set to ftrace_nop_ops
> > >   addr-04               // Literal (last 32-bits)       // set to ftrace_nop_ops
> > >   addr+00       func:   mv      t0, ra
> > >   addr+04               auipc   t1, ftrace_caller
> > >   addr+08               nop
> > >
> > > ... and when enabled can be set to:
> > >
> > >   # Note: aligned to 8 bytes
> > >   addr-08               // Literal (first 32-bits)      // patched to ops ptr
> > >   addr-04               // Literal (last 32-bits)       // patched to ops ptr
> > >   addr+00       func:   mv      t0, ra
> > We needn't "mv t0, ra" here because our "jalr" could work with t0 and
> > won't affect ra. Let's do it in the trampoline code, and then we can
> > save another word here.
>
> Ah; I thought JALR always clobbered ra? Or can that specify the register to
> save the link address to?
Yes, that's the feature of riscv :) We could use any register to save
the link address.

>
> I'm not that familiar with riscv asm, so I've probably just got that wrong.
>
> > >   addr+04               auipc   t1, ftrace_caller
> > >   addr+08               jalr    ftrace_caller(t1)
> >
> > Here is the call-site:
> >    # Note: aligned to 8 bytes
> >    addr-08               // Literal (first 32-bits)      // patched to ops ptr
> >    addr-04               // Literal (last 32-bits)       // patched to ops ptr
> >    addr+00               auipc   t0, ftrace_caller
> >    addr+04               jalr    ftrace_caller(t0)
Sorry, it should be:
         addr+04               jalr    t0, ftrace_caller(t0)

>
> I'm a bit confused there; I thought that the `symbol(reg)` addressing mode was
> generating additional bits that the AUPIC didn't -- have I got that wrong?
>
> What specifies which register the JALR will write the link address to?
According to the spec, auipc t1,0x0 should write PC + 0x0<<12 (which
is equal to PC) to t1 and then jalr t0, (t0)0 jumps to the address
stored in t0 + 0x0 and stores the return address to t0.

That means auipc defines xxx << 12 bits, jalr defines lowest 12 bits.

>
> > > Note: this *only* requires patching the literal and NOP<->JALR; the MV and
> > > AUIPC aren't harmful and can always be there. This way, you won't need to use
> > > stop_machine().
> > Yes, simplest nop is better than c.j. I confused.
> >
> > >
> > > With that, the ftrace_caller trampoline can recover the `ops` pointer at a
> > > negative offset from `ra`, and can recover the instrumented function's return
> > > address in `t0`. Using the `ops` pointer, it can figure out whether to branch
> > > to a direct trampoline or whether to save/restore the regs around invoking
> > > ops->func.
> > >
> > > For 32-bit it would be exactly the same, except you'd only need a single nop
> > > before the function, and the offset would be -0x10.
> > Yes, we reduced another 4 bytes & a smaller alignment for better code
> > size when 32-bit.
> >    # Note: aligned to 4 bytes
> >    addr-04               // Literal (last 32-bits)       // patched to ops ptr
> >    addr+00               auipc   t0, ftrace_caller
> >    addr+04               jalr    ftrace_caller(t0)
addr+04               jalr    t0, ftrace_caller(t0)

> > >
>
> > > That's what arm64 does; the only difference is that riscv would *always* need
> > > to go via the trampoline in order to make direct calls.
> > We need one more trampoline here beside ftrace_caller &
> > ftrace_regs_caller: It's "direct_caller".
> >
> > addr+04         nop -> direct_caller/ftrace_caller/ftrace_regs_caller
>
> I'd strongly recommend that you instead implement FTRACE_WITH_ARGS and
> deprecate FTRACE_WITH_REGS, like arm64 has done, then you only need a single
> ftrace_caller, as I mentioned above. That way there's no risk that you need to
> patch the AUIPC after initialization.
>
> The arm64 FTRACE_WITH_ARGS conversion is in mainline, and arm64's
> FTRACE_WITH_CALL_OPS is based upon that. Florent's DIRECT_CALLS patches add the
> direct call logic to the same ftrace_caller trampoline.
Thx for the suggestion of only keeping the ftrace_caller idea, but
it's another topic.

What I want to point out:
If we keep "auipc (addr+00)" fixed, we could use the different
trampolines at "jalr (addr+0x4)" (All of them must be in one 2k
aligned area).

>
> Thanks,
> Mark.



-- 
Best Regards
 Guo Ren
