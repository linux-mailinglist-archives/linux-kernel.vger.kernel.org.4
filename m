Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D2A68E611
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 03:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBHCbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 21:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBHCbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 21:31:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C60028850
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 18:31:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1D31B816D4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E15C433A7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675823470;
        bh=Y9lMRyPRRn0yFFMzq2pvuKeR6CIJGocopkbfjKdoa0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jNvpEVB+RpzOyUUdX1+61R/BjJBqkn1PEiY+WY/dA5KwqvJtFwtoWPiNvqxQn6+QL
         vKofiVxpBFvnVybRvOfnMBCX7cwBmYqkNiX38aynaRFN7xrrUFHMC0KAKnqB1Js3VB
         4kXwGhHaOhd+2/gtYF3/zGBVylp8I9ONEbUTHeWjVS4HIQrPvU9+WzExy+ObWwTW15
         BD1FKB/jb89IpmgmzIJrX1qTFrgxzC5Iil9jid2ZGSfa383+RAxOW0c6xWNElIpGNP
         nUsNhC7++zl0g6DD5Yh+3++ZVlb138lUzRa2V/t4elc4oPhyyFOgD7p425nrhuV8zi
         jgTlT2HwyVFUQ==
Received: by mail-ed1-f49.google.com with SMTP id fi26so18646465edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 18:31:10 -0800 (PST)
X-Gm-Message-State: AO0yUKVY2AGErm6j9F1xq4ODOMigcT59rJv5/lyllt9h+50DrzzGG+rs
        wPvTeZPISQT61Gpre587i1ImGR+ZwmCP8NWjHVQ=
X-Google-Smtp-Source: AK7set+0Uuwjsj9H7TlSVMbcni/4dDE2LXzJ3LO3cNA43R+ImOKYW52fzKXYZ7THWYaEIZeMjemrrfxl2ulPwMDBEsQ=
X-Received: by 2002:a50:935a:0:b0:4aa:a4d9:5ab3 with SMTP id
 n26-20020a50935a000000b004aaa4d95ab3mr1457470eda.65.1675823468486; Tue, 07
 Feb 2023 18:31:08 -0800 (PST)
MIME-Version: 1.0
References: <20230112090603.1295340-1-guoren@kernel.org> <c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com>
 <CAJF2gTQm11px3mqyrNk1SRiJZud1yeY2avK99UX9KetWAGe5BA@mail.gmail.com>
 <Y+DOyqehZvBJlb8N@FVFF77S0Q05N> <CAJF2gTQ6U1vH79Mu53eQ-GVaFx36C-hEt9Qf6=_vAkHfmgFh1Q@mail.gmail.com>
 <Y+IXB4xQ7ACQWC9U@FVFF77S0Q05N>
In-Reply-To: <Y+IXB4xQ7ACQWC9U@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 8 Feb 2023 10:30:56 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTrX+8wCm-g=L9+3BkCRrZ8SCUM2w1e5duq-+Bsa213mA@mail.gmail.com>
Message-ID: <CAJF2gTTrX+8wCm-g=L9+3BkCRrZ8SCUM2w1e5duq-+Bsa213mA@mail.gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thx for the thoughtful reply.

On Tue, Feb 7, 2023 at 5:17 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Tue, Feb 07, 2023 at 11:57:06AM +0800, Guo Ren wrote:
> > On Mon, Feb 6, 2023 at 5:56 PM Mark Rutland <mark.rutland@arm.com> wrote:
> > > The DYNAMIC_FTRACE_WITH_CALL_OPS patches should be in v6.3. They're currently
> > > queued in the arm64 tree in the for-next/ftrace branch:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/ftrace
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/
> > >
> > > ... and those *should* be in v6.3.
> > Glade to hear that. Great!
> >
> > >
> > > Patches to imeplement DIRECT_CALLS atop that are in review at the moment:
> > >
> > >   https://lore.kernel.org/linux-arm-kernel/20230201163420.1579014-1-revest@chromium.org/
> > Good reference. Thx for sharing.
> >
> > >
> > > ... and if riscv uses the CALL_OPS approach, I believe it can do much the same
> > > there.
> > >
> > > If riscv wants to do a single atomic patch to each patch-site (to avoid
> > > stop_machine()), then direct calls would always needs to bounce through the
> > > ftrace_caller trampoline (and acquire the direct call from the ftrace_ops), but
> > > that might not be as bad as it sounds -- from benchmarking on arm64, the bulk
> > > of the overhead seen with direct calls is when using the list_ops or having to
> > > do a hash lookup, and both of those are avoided with the CALL_OPS approach.
> > > Calling directly from the patch-site is a minor optimization relative to
> > > skipping that work.
> > Yes, CALL_OPS could solve the PREEMPTION & stop_machine problems. I
> > would follow up.
> >
> > The difference from arm64 is that RISC-V is 16bit/32bit mixed
> > instruction ISA, so we must keep ftrace_caller & ftrace_regs_caller in
> > 2048 aligned. Then:
>
> Where does the 2048-bit alignment requirement come from?
Sorry for the typo. It's one 2048 bytes for keeping two trampolines
(ftrace_caller & ftrace_regs_caller) in one aligned part.
Because the jalr has only +-2048 bytes offset range.

Then the "auipc   t1, ftrace(_regs)_caller" is fixed.

>
> Note that I'm assuming you will *always* go through a common ftrace_caller
> trampoline (even for direct calls), with the trampoline responsible for
> recovering the direct trampoline (or ops->func) from the ops pointer.
>
> That would only require 64-bit alignment on 64-bit (or 32-bit alignment on
> 32-bit) to keep the literal naturally-aligned; the rest of the instructions
> wouldn't require additional alignment.
>
> For example, I would expect that (for 64-bit) you'd use:
>
>   # place 2 NOPs *immediately before* the function, and 3 NOPs at the start
>   -fpatchable-function-entry=5,2
>
>   # Align the function to 8-bytes
>   -falign=functions=8
>
> ... and your trampoline in each function could be initialized to:
>
>   # Note: aligned to 8 bytes
>   addr-08               // Literal (first 32-bits)      // set to ftrace_nop_ops
>   addr-04               // Literal (last 32-bits)       // set to ftrace_nop_ops
>   addr+00       func:   mv      t0, ra
>   addr+04               auipc   t1, ftrace_caller
>   addr+08               nop
>
> ... and when enabled can be set to:
>
>   # Note: aligned to 8 bytes
>   addr-08               // Literal (first 32-bits)      // patched to ops ptr
>   addr-04               // Literal (last 32-bits)       // patched to ops ptr
>   addr+00       func:   mv      t0, ra
We needn't "mv t0, ra" here because our "jalr" could work with t0 and
won't affect ra. Let's do it in the trampoline code, and then we can
save another word here.
>   addr+04               auipc   t1, ftrace_caller
>   addr+08               jalr    ftrace_caller(t1)

Here is the call-site:
   # Note: aligned to 8 bytes
   addr-08               // Literal (first 32-bits)      // patched to ops ptr
   addr-04               // Literal (last 32-bits)       // patched to ops ptr
   addr+00               auipc   t0, ftrace_caller
   addr+04               jalr    ftrace_caller(t0)

>
> Note: this *only* requires patching the literal and NOP<->JALR; the MV and
> AUIPC aren't harmful and can always be there. This way, you won't need to use
> stop_machine().
Yes, simplest nop is better than c.j. I confused.

>
> With that, the ftrace_caller trampoline can recover the `ops` pointer at a
> negative offset from `ra`, and can recover the instrumented function's return
> address in `t0`. Using the `ops` pointer, it can figure out whether to branch
> to a direct trampoline or whether to save/restore the regs around invoking
> ops->func.
>
> For 32-bit it would be exactly the same, except you'd only need a single nop
> before the function, and the offset would be -0x10.
Yes, we reduced another 4 bytes & a smaller alignment for better code
size when 32-bit.
   # Note: aligned to 4 bytes
   addr-04               // Literal (last 32-bits)       // patched to ops ptr
   addr+00               auipc   t0, ftrace_caller
   addr+04               jalr    ftrace_caller(t0)
>
> That's what arm64 does; the only difference is that riscv would *always* need
> to go via the trampoline in order to make direct calls.
We need one more trampoline here beside ftrace_caller &
ftrace_regs_caller: It's "direct_caller".

addr+04         nop -> direct_caller/ftrace_caller/ftrace_regs_caller

>
> Thanks,
> Mark.



-- 
Best Regards
 Guo Ren
