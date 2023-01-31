Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1BD68265E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjAaIbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjAaIbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:31:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594A145F71
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:31:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 18439B819A4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6067C4339C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675153870;
        bh=J/q/Y3zb+IglsouU8fsWGPAsHeUL2+ei6t6E56LXfrQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cpMXWDhU2kyMz/qUfbbb6iz0QKwlGA5I7IGgu10/XDoZmuGynZVQ4WMuSZELFcgnE
         mAxWw+26gWAPBMaNUM4pwYq9c9MIuZXeR2C3c+e/wkmrI8KQxH0hySYf5r+/X+9x/o
         yWXI64f591cSJ7XBeiVAOQCVYd/MCrInzm/vgrqTardk/7PTVL5GqFzyS8yMgFiLHG
         SE8dSz4f2I7viVDxClri4HZQSpTZ/nGsnv5CKUpvUzOYl7sOMCbTJBBm+EvvZczwZj
         NkAG/erCQ/nBtgCMOhpWkRF9JWJmEatcw6z0xxYEgK77dQEvVQ0PjfKYfGe+ublbV8
         gjoOwAdfbTgfA==
Received: by mail-ej1-f47.google.com with SMTP id ud5so39370103ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:31:10 -0800 (PST)
X-Gm-Message-State: AO0yUKVXzcBPU+MR7GmRv5jxbrfKR5+m9rJvjMCtAtYUpWDq3dpXAgg8
        yL7ufe0wGE4IacOEPv2lIDv4Ds70LF5UCccTsLY=
X-Google-Smtp-Source: AK7set88WiPiLLf0VHmR41OtrcA136x6n1Dq4j+rY0Rn43UvU5aKhFAzeivOYzR1DDWwOQAZ61j6gkPacHbuMs2PZfA=
X-Received: by 2002:a17:906:c41a:b0:87b:d510:77a8 with SMTP id
 u26-20020a170906c41a00b0087bd51077a8mr3958147ejz.235.1675153868975; Tue, 31
 Jan 2023 00:31:08 -0800 (PST)
MIME-Version: 1.0
References: <20230126161559.1467374-1-guoren@kernel.org> <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us> <Y9fm+6LPXgtDSma/@FVFF77S0Q05N>
 <CAJF2gTRgze_owuWvJjnrPpBNs8+GY-km7wvHU4EuJzarQc+BPQ@mail.gmail.com> <87a61z2n55.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87a61z2n55.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 31 Jan 2023 16:30:56 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ7ZfF7JdpxP8O6RZSvPrUqk79geXuyQLweu6U15XjAzA@mail.gmail.com>
Message-ID: <CAJF2gTQ7ZfF7JdpxP8O6RZSvPrUqk79geXuyQLweu6U15XjAzA@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 3:12 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wr=
ote:
>
> Guo Ren <guoren@kernel.org> writes:
>
> > On Mon, Jan 30, 2023 at 11:49 PM Mark Rutland <mark.rutland@arm.com> wr=
ote:
> >>
> >> Hi Bjorn,
> >>
> >> On Mon, Jan 30, 2023 at 04:28:15PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> >> > Guo Ren <guoren@kernel.org> writes:
> >> >
> >> > >> In the serie of RISCV OPTPROBES [1], it patches a long-jump instr=
uctions pair
> >> > >> AUIPC/JALR in kernel text, so in order to ensure other CPUs does =
not execute
> >> > >> in the instructions that will be modified, it is still need to st=
op other CPUs
> >> > >> via patch_text API, or you have any better solution to achieve th=
e purpose?
> >> > >  - The stop_machine is an expensive way all architectures should
> >> > > avoid, and you could keep that in your OPTPROBES implementation fi=
les
> >> > > with static functions.
> >> > >  - The stop_machine couldn't work with PREEMPTION, so your
> >> > > implementation needs to work with !PREEMPTION.
> >> >
> >> > ...and stop_machine() with !PREEMPTION is broken as well, when you'r=
e
> >> > replacing multiple instructions (see Mark's post at [1]). The
> >> > stop_machine() dance might work when you're replacing *one* instruct=
ion,
> >> > not multiple as in the RISC-V case. I'll expand on this in a comment=
 in
> >> > the OPTPROBES v6 series.
> >>
> >> Just to clarify, my comments in [1] were assuming that stop_machine() =
was not
> >> used, in which case there is a problem with or without PREEMPTION.
> >>
> >> I believe that when using stop_machine(), the !PREEMPTION case is fine=
, since
> >> stop_machine() schedules work rather than running work in IRQ context =
on the
> >> back of an IPI, so no CPUs should be mid-sequnce during the patching, =
and it's
> >> not possible for there to be threads which are preempted mid-sequence.
> >>
> >> That all said, IIUC optprobes is going to disappear once fprobe is rea=
dy
> >> everywhere, so that might be moot.
> > The optprobes could be in the middle of a function, but fprobe must be
> > the entry of a function, right?
> >
> > Does your fprobe here mean: ?
> >
> > The Linux kernel configuration item CONFIG_FPROBE:
> >
> > prompt: Kernel Function Probe (fprobe)
> > type: bool
> > depends on: ( CONFIG_FUNCTION_TRACER ) && (
> > CONFIG_DYNAMIC_FTRACE_WITH_REGS ) && ( CONFIG_HAVE_RETHOOK )
> > defined in kernel/trace/Kconfig
>
> See the cover of [1]. It's about direct calls for BPF tracing (and more)
> on Arm, and you're completly right, that it's *not* related to optprobes
> at all.
>
> [1] https://lore.kernel.org/all/20221108220651.24492-1-revest@chromium.or=
g/
Thx for sharing :)

--=20
Best Regards
 Guo Ren
