Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7A167FCDD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 06:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbjA2Fge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 00:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjA2Fgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 00:36:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEF9212AC
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 21:36:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A41D0B80AFB
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 05:36:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A61C433A1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 05:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674970587;
        bh=1k2qDlcK6BCTK6Je2WmnvYm8YTayJKyRpCuL6fDRpBM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e2xfuLKiJubRDuv8PmqPNURoUQPW5YqakpIbWHG+SrHCEYLQwiIwa0zIelA9f9Ot8
         em6NiF6aFqeUAmceQ3Q5g5VCqGR6Nr5xnILJbFZBFuiMiz+xNPEWDOiBEyzT5vCf6Y
         DdXNoD+D7ZJ/bJzsIeYwohwcOH5NZNCle4eYWsWSTnJjWeLRze+sFSRHBiiQ42/fMf
         ASMgnXdq7BNK+idG3R7ghAEJ2uulQHmZxmBlcfo+X4YpsobbQLmjupWCSsQANvzyMS
         aPV66zlv7eKjLNB3NXML5lrd9RPfg8BT+GhC4AjLIVjXVJBphgiqcXCVodjotz3sBF
         8ZoN0rl5eMZng==
Received: by mail-ed1-f42.google.com with SMTP id z11so8145648ede.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 21:36:27 -0800 (PST)
X-Gm-Message-State: AFqh2koS2rua6BuiBoP+cNIkOFV3Oui8i+qh7VaQyQcURZjIy8DkIvV6
        3KSAF1c1ujhiZiTfdXSFDiSnV0gJz3nLn4z6mzg=
X-Google-Smtp-Source: AMrXdXvWaW6GPvsXxgfilQRz68gJh7S1klwYt5YMDMwBMZ5zunD/NbFDRZOl/BIvUqrcPcxcw8nFC/385uf+bMg1xAA=
X-Received: by 2002:aa7:dbd9:0:b0:49c:ea59:46b with SMTP id
 v25-20020aa7dbd9000000b0049cea59046bmr8180006edt.54.1674970585503; Sat, 28
 Jan 2023 21:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20230107133549.4192639-1-guoren@kernel.org> <20230107133549.4192639-2-guoren@kernel.org>
 <Y7xMvAJXjHaus0Bm@FVFF77S0Q05N> <CAJF2gTRzS0hBdqBUNbijvKKx3Kf_mY55XSkUyPJsfOK8p15_Mw@mail.gmail.com>
 <Y7/3hoFjS49yy52W@FVFF77S0Q05N> <CAJF2gTQXRt-mmuA=kKKdQojgLG-eQm6PqTuwf0ccw4cdYdbYfQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQXRt-mmuA=kKKdQojgLG-eQm6PqTuwf0ccw4cdYdbYfQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 29 Jan 2023 13:36:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQBhVc1gU3PmN7Rt6qcNoDBi58fEGm9LuiHea4vSN3oXw@mail.gmail.com>
Message-ID: <CAJF2gTQBhVc1gU3PmN7Rt6qcNoDBi58fEGm9LuiHea4vSN3oXw@mail.gmail.com>
Subject: Re: [PATCH -next V6 1/7] riscv: ftrace: Fixup panic by disabling preemption
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de, rostedt@goodmis.org,
        mhiramat@kernel.org, jolsa@redhat.com, bp@suse.de,
        jpoimboe@kernel.org, suagrfillet@gmail.com, andy.chiu@sifive.com,
        e.shatokhin@yadro.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 6:00 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Jan 12, 2023 at 8:05 PM Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Wed, Jan 11, 2023 at 09:22:09PM +0800, Guo Ren wrote:
> > > On Tue, Jan 10, 2023 at 1:20 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > >
> > > > On Sat, Jan 07, 2023 at 08:35:43AM -0500, guoren@kernel.org wrote:
> > > > > From: Andy Chiu <andy.chiu@sifive.com>
> > > > >
> > > > > In RISCV, we must use an AUIPC + JALR pair to encode an immediate,
> > > > > forming a jump that jumps to an address over 4K. This may cause errors
> > > > > if we want to enable kernel preemption and remove dependency from
> > > > > patching code with stop_machine(). For example, if a task was switched
> > > > > out on auipc. And, if we changed the ftrace function before it was
> > > > > switched back, then it would jump to an address that has updated 11:0
> > > > > bits mixing with previous XLEN:12 part.
> > > > >
> > > > > p: patched area performed by dynamic ftrace
> > > > > ftrace_prologue:
> > > > > p|      REG_S   ra, -SZREG(sp)
> > > > > p|      auipc   ra, 0x? ------------> preempted
> > > > >                                       ...
> > > > >                               change ftrace function
> > > > >                                       ...
> > > > > p|      jalr    -?(ra) <------------- switched back
> > > > > p|      REG_L   ra, -SZREG(sp)
> > > > > func:
> > > > >       xxx
> > > > >       ret
> > > >
> > > > What happens on SMP but not !PREEMPTION; can't a CPU be in the middle of this
> > > > while you're patching the sequence?
> > > Yes, when PREEMPTION, a timer interrupt between auipc & jalr may cause
> > > context_switch. And riscv uses stop_machine for patch_text. Then, we
> > > may modify auipc part, but only execute the jalr part when return.
> >
> > Please re-read my question; "!PREEMPTION" means "NOT PREEMPTION".
> >
> > Ignore preeemption entirely and assume two CPUs X and Y are running code
> > concurrently. Assume CPU X is in the ftrace prologue, and CPU Y is patching
> > that prologue while CPU X is executing it.
> >
> > Is that prevented somehow? If not, what happens in that case?
> >
> > At the very least you can have exactly the same case as on a preemptible kernel
> > (and in a VM, the hypervisor can preempt the guest ata arbitrary times),
> > becuase CPU X could end up executing a mixture of the old and new instructions.
> >
> > More generally, if you don't have strong rules about concurrent modification
> > and execution of instructions, it may not be safe to modify and instruction as
> > it is being executed (e.g. if the CPU's instruction fetches aren't atomic).
> >
> > > > Do you have any guarantee as to the atomicity and ordering of instruction
> > > > fetches?
> > > Not yet. If the region is short, we could use nop + jalr pair instead.
> >
> > Ok, so as above I do not understand how this is safe. Maybe I am missing
> > something, but if you don't have a guarantee as to ordering I don't see how you
> > can safely patch this even if you have atomicity of each instruction update.
> >
> > Note that if you don't have atomicity of instruction fetches you *cannot*
> > safely concurrently modify and execute instructions.
> >
> > > Only one jalr instruction makes the entry atomicity.
> >
> > I'll have to take your word for that.
> >
> > As above, I don't think this sequence is safe regardless.
> >
> > > There are already several proposed solutions:
> > > 1. Make stop_machine guarantee all CPU out of preemption point.
> > > 2. Expand -fpatchable-function-entry from 4 to 24, and make detour
> > > codes atomicity.
> > > 3. We want to propose a solution to make auipc by hardware mask_irq.
> > > For more details, see:
> > > https://www.youtube.com/watch?v=4JkkkXuEvCw
> >
> > Ignoring things which require HW changes, you could consider doing something
> > like what I'm doing for arm64 with DYNAMIC_FTRACE_WITH_CALL_OPS:
> >
> >   https://lore.kernel.org/lkml/20230109135828.879136-1-mark.rutland@arm.com/
> The idea of DYNAMIC_FTRACE_WITH_CALL_OPS (Using data load/store +
> indirect jump instead of auipc+jalr) is similar to Andy's solution
> (See youtube link, last page of ppt). But the key problem is you also
> expand the size of the prologue of the function. 64BIT is already
> expensive, and we can't afford more of it. I would change to seek a
> new atomic auipc+jalr ISA extension to solve this problem.
The atomicity here means:
 - auipc + jalr won't be interrupted
 - auipc + jalr should be aligned by 64bit, then one sd instruction
could update them in atomic.


>
> DYNAMIC_FTRACE_WITH_CALL_OPS  would speed up ftrace_(regs)_caller
> (Mostly for kernel debug), but it won't help
> DYNAMIC_FTRACE_WITH_DIRECT_CALLS. So I do not so care about the
> ftrace_(regs)_caller performance gain.
>
> >
> > ... which would replace the address generation with a load, which can be
> > atomic, and would give you a number of other benefits (e.g. avoiding branch
> > range limitations, performance benefits as in the cover letter).
> >
> > Thanks,
> > Mark.
>
>
>
> --
> Best Regards
>  Guo Ren



-- 
Best Regards
 Guo Ren
