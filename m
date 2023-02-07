Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5439D68CDCD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjBGD55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjBGD5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:57:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C4112F36
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 19:57:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 76C20B815FB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F156C433A1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675742240;
        bh=gfrSEM6FqIcih32oz0b3Jr8BoEyPxdBS2OKVwHu9Lx8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mgmgy992NrZvI7x3Me+xsG7Sm2kxOx6hmWj2v4ajI5bMIF21DYYRe3n7it/RTnSsO
         99fCSokQ1UEQWzonE9t/N4xjZHdY9slsGLCTqmCi6Lo8rze7Btl+fQx9h5c15CC3oO
         xxRaIatqWmyXkAmhkKxnbvnCe4qxpaQXPV0v5LF4x9paztcNhXKeIc6A76GD9yYrCq
         QQwCQ02rsGaKR6SNY237Bbcth8T0akpcMfEOiCFnopvPfbg8qQzfPuUcnrUEjx78AZ
         IRH/+Zue83QmzlRkiUK8lua62bjU4pAu8GHAsOnPzhKPmOoOMFsYktwKCP2AtbunfI
         N8Cu5IFc9O38w==
Received: by mail-ed1-f41.google.com with SMTP id m8so13781182edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 19:57:20 -0800 (PST)
X-Gm-Message-State: AO0yUKWkfF9lHraqUhIh11+xpwtTFKlqKLCDajp5kawXG6CiqIS5b4Ei
        tqfDQ1i89cV1j1i7GFnL7ylOlHtGso9ZcaRVt+w=
X-Google-Smtp-Source: AK7set9KId0Co4+X+skS0YHQha4R6FcQtquMM1wX/KJJmtszQX9x667h5d99E3QN5awQiM5EEjOtQNXF5wIMtw6lkTE=
X-Received: by 2002:a50:8a84:0:b0:4aa:a4f1:3edc with SMTP id
 j4-20020a508a84000000b004aaa4f13edcmr188173edj.7.1675742238362; Mon, 06 Feb
 2023 19:57:18 -0800 (PST)
MIME-Version: 1.0
References: <20230112090603.1295340-1-guoren@kernel.org> <c68bac83-5c88-80b1-bac9-e1fd4ea8f07e@yadro.com>
 <CAJF2gTQm11px3mqyrNk1SRiJZud1yeY2avK99UX9KetWAGe5BA@mail.gmail.com> <Y+DOyqehZvBJlb8N@FVFF77S0Q05N>
In-Reply-To: <Y+DOyqehZvBJlb8N@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 7 Feb 2023 11:57:06 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ6U1vH79Mu53eQ-GVaFx36C-hEt9Qf6=_vAkHfmgFh1Q@mail.gmail.com>
Message-ID: <CAJF2gTQ6U1vH79Mu53eQ-GVaFx36C-hEt9Qf6=_vAkHfmgFh1Q@mail.gmail.com>
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

On Mon, Feb 6, 2023 at 5:56 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Sat, Feb 04, 2023 at 02:40:52PM +0800, Guo Ren wrote:
> > On Mon, Jan 16, 2023 at 11:02 PM Evgenii Shatokhin
> > <e.shatokhin@yadro.com> wrote:
> > >
> > > Hi,
> > >
> > > On 12.01.2023 12:05, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > The previous ftrace detour implementation fc76b8b8011 ("riscv: Using
> > > > PATCHABLE_FUNCTION_ENTRY instead of MCOUNT") contain three problems.
> > > >
> > > >   - The most horrible bug is preemption panic which found by Andy [1].
> > > >     Let's disable preemption for ftrace first, and Andy could continue
> > > >     the ftrace preemption work.
> > >
> > > It seems, the patches #2-#7 of this series do not require "riscv:
> > > ftrace: Fixup panic by disabling preemption" and can be used without it.
> > >
> > > How about moving that patch out of the series and processing it separately?
> > Okay.
> >
> > >
> > > As it was pointed out in the discussion of that patch, some other
> > > solution to non-atomic changes of the prologue might be needed anyway.
> > I think you mean Mark Rutland's DYNAMIC_FTRACE_WITH_CALL_OPS. But that
> > still needs to be ready. Let's disable PREEMPT for ftrace first.
>
> FWIW, taking the patch to disable FTRACE with PREEMPT for now makes sense to
> me, too.
Thx, you agree with that.

>
> The DYNAMIC_FTRACE_WITH_CALL_OPS patches should be in v6.3. They're currently
> queued in the arm64 tree in the for-next/ftrace branch:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/ftrace
>   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/
>
> ... and those *should* be in v6.3.
Glade to hear that. Great!

>
> Patches to imeplement DIRECT_CALLS atop that are in review at the moment:
>
>   https://lore.kernel.org/linux-arm-kernel/20230201163420.1579014-1-revest@chromium.org/
Good reference. Thx for sharing.

>
> ... and if riscv uses the CALL_OPS approach, I believe it can do much the same
> there.
>
> If riscv wants to do a single atomic patch to each patch-site (to avoid
> stop_machine()), then direct calls would always needs to bounce through the
> ftrace_caller trampoline (and acquire the direct call from the ftrace_ops), but
> that might not be as bad as it sounds -- from benchmarking on arm64, the bulk
> of the overhead seen with direct calls is when using the list_ops or having to
> do a hash lookup, and both of those are avoided with the CALL_OPS approach.
> Calling directly from the patch-site is a minor optimization relative to
> skipping that work.
Yes, CALL_OPS could solve the PREEMPTION & stop_machine problems. I
would follow up.

The difference from arm64 is that RISC-V is 16bit/32bit mixed
instruction ISA, so we must keep ftrace_caller & ftrace_regs_caller in
2048 aligned. Then:
FTRACE_UPDATE_MAKE_CALL:
  * addr+00:          NOP // Literal (first 32 bits)
  * addr+04:          NOP // Literal (last 32 bits)
  * addr+08: func: auipc t0, ? // All trampolines are in the 2048
aligned place, so this point won't be changed.
  * addr+12:          jalr ?(t0) // For different trampolines:
ftrace_regs_caller, ftrace_caller

FTRACE_UPDATE_MAKE_NOP:
  * addr+00:          NOP // Literal (first 32 bits)
  * addr+04:          NOP // Literal (last 32 bits)
  * addr+08: func: c.j     // jump to addr + 16 and skip broken insn & jalr
  * addr+10:          xxx   // last half & broken insn of auipc t0, ?
  * addr+12:          jalr ?(t0) // To be patched to jalr ?<t0> ()
  * addr+16: func body

Right? (The call site would be increased from 64bit to 128bit ahead of func.)

>
> Thanks,
> Mark.




--
Best Regards
 Guo Ren
