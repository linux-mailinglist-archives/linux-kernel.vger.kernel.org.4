Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D4869D802
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 02:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjBUBbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 20:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjBUBbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 20:31:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA16F212BA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:30:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5676660F63
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C4CC433EF
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676943057;
        bh=g+C3+KM0lb+qdx4B+wH/mE5N9+DQmnKIvrTIb2t8Bz4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dm2VjDM8MJxLhwFt2t0/Bp2ST7AgqgEnhGyTv6a0eCN/H+EBQMvy/y8cBVlUwjvc3
         FMFTZDn2r8fHeitCF+Prcy4wi3VPwGBdO/m3pfbYsw7lGDd6G8CLganfwPk/DVicWQ
         vs4AobY9reKQJPVQAJ2fB2Xc4wmGMWkQUcNgbUrat6grie4+AA8eWxw/3BhQ55lDy1
         ntuYdpIlNaL/cejBp9ggdajLuGGnYE63FXDXnwVmJrcAcUShUa85RKUs3WvhbFctaD
         eyxfRMGwMvpt9749lhl1ULii48AGnnRGNfVKt3qDwwasatrn/3RfdZanNc9gsyYlGJ
         dIFpIMQqfMszw==
Received: by mail-ed1-f43.google.com with SMTP id ec43so10651895edb.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:30:57 -0800 (PST)
X-Gm-Message-State: AO0yUKXOR0NUoZ7galuiY9+1isbgsfE8WagEcT5kSMJ9IawErBRsXDXZ
        PB5oRRWSXug3uq/YHfp63XigjVjDsAToknNkG9A=
X-Google-Smtp-Source: AK7set940J9K2gxAYeDdkE9or/jljaOFOKUp0vZfyIlw9CxDUVM3+723k9rKkwcQOT0Ae9QnzTR5w34bQZr9McHG3ac=
X-Received: by 2002:a50:aa8b:0:b0:4ad:7439:cecb with SMTP id
 q11-20020a50aa8b000000b004ad7439cecbmr1129926edc.7.1676943055937; Mon, 20 Feb
 2023 17:30:55 -0800 (PST)
MIME-Version: 1.0
References: <20230126161559.1467374-1-guoren@kernel.org> <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us> <Y9fm+6LPXgtDSma/@FVFF77S0Q05N>
 <CAJF2gTRgze_owuWvJjnrPpBNs8+GY-km7wvHU4EuJzarQc+BPQ@mail.gmail.com>
 <Y9juYX8Bt1Z55lv0@FVFF77S0Q05N> <20230217002351.112635f4fb35f84002666d29@kernel.org>
In-Reply-To: <20230217002351.112635f4fb35f84002666d29@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 21 Feb 2023 09:30:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTt5n8Ur4sRSDWppE2JtYtuEF2jEDC_mCBOVkripgkj6A@mail.gmail.com>
Message-ID: <CAJF2gTTt5n8Ur4sRSDWppE2JtYtuEF2jEDC_mCBOVkripgkj6A@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, conor.dooley@microchip.com,
        penberg@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:23 PM Masami Hiramatsu <mhiramat@kernel.org> wro=
te:
>
> Hi,
>
> Sorry I missed this thread.
>
> On Tue, 31 Jan 2023 10:33:05 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
>
> > On Tue, Jan 31, 2023 at 09:48:29AM +0800, Guo Ren wrote:
> > > On Mon, Jan 30, 2023 at 11:49 PM Mark Rutland <mark.rutland@arm.com> =
wrote:
> > > >
> > > > Hi Bjorn,
> > > >
> > > > On Mon, Jan 30, 2023 at 04:28:15PM +0100, Bj=C3=B6rn T=C3=B6pel wro=
te:
> > > > > Guo Ren <guoren@kernel.org> writes:
> > > > >
> > > > > >> In the serie of RISCV OPTPROBES [1], it patches a long-jump in=
structions pair
> > > > > >> AUIPC/JALR in kernel text, so in order to ensure other CPUs do=
es not execute
> > > > > >> in the instructions that will be modified, it is still need to=
 stop other CPUs
> > > > > >> via patch_text API, or you have any better solution to achieve=
 the purpose?
> > > > > >  - The stop_machine is an expensive way all architectures shoul=
d
> > > > > > avoid, and you could keep that in your OPTPROBES implementation=
 files
> > > > > > with static functions.
> > > > > >  - The stop_machine couldn't work with PREEMPTION, so your
> > > > > > implementation needs to work with !PREEMPTION.
> > > > >
> > > > > ...and stop_machine() with !PREEMPTION is broken as well, when yo=
u're
> > > > > replacing multiple instructions (see Mark's post at [1]). The
> > > > > stop_machine() dance might work when you're replacing *one* instr=
uction,
> > > > > not multiple as in the RISC-V case. I'll expand on this in a comm=
ent in
> > > > > the OPTPROBES v6 series.
> > > >
> > > > Just to clarify, my comments in [1] were assuming that stop_machine=
() was not
> > > > used, in which case there is a problem with or without PREEMPTION.
> > > >
> > > > I believe that when using stop_machine(), the !PREEMPTION case is f=
ine, since
> > > > stop_machine() schedules work rather than running work in IRQ conte=
xt on the
> > > > back of an IPI, so no CPUs should be mid-sequnce during the patchin=
g, and it's
> > > > not possible for there to be threads which are preempted mid-sequen=
ce.
> > > >
> > > > That all said, IIUC optprobes is going to disappear once fprobe is =
ready
> > > > everywhere, so that might be moot.
> > > The optprobes could be in the middle of a function, but fprobe must b=
e
> > > the entry of a function, right?
> > >
> > > Does your fprobe here mean: ?
> > >
> > > The Linux kernel configuration item CONFIG_FPROBE:
> > >
> > > prompt: Kernel Function Probe (fprobe)
> > > type: bool
> > > depends on: ( CONFIG_FUNCTION_TRACER ) && (
> > > CONFIG_DYNAMIC_FTRACE_WITH_REGS ) && ( CONFIG_HAVE_RETHOOK )
> > > defined in kernel/trace/Kconfig
> >
> > Yes.
> >
> > Masami, Steve, and I had a chat at the tracing summit late last year (w=
hich
> > unfortunately, was not recorded), and what we'd like to do is get each
> > architecture to have FPROBE (and FTRACE_WITH_ARGS), at which point OPTP=
ROBE
> > and KRETPROBE become redundant and could be removed.
>
> No, the fprobe will replace the KRETPROBE but not OPTPROBE. The OPTPROBE
> is completely different one. Fprobe is used only for function entry, but
> optprobe is applied to the function body.
>
> >
> > i.e. we'd keep KPROBES as a "you can trace any instruction" feature, bu=
t in the
> > few cases where OPTPROBES can make things fater by using FTRACE, you sh=
ould
> > just use that directly via FPROBE.
>
> I think what you are saying is KPROBE_ON_FTRACE, and that will be replace=
d by
> FPROBES.
I'm sorry, I'm not sure how FPROBES could replace KPROBE_ON_FTRACE? Do
you have some discussion on it?

>
> Thank you,
>
> >
> > Thanks,
> > Mark.
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>



--=20
Best Regards
 Guo Ren
