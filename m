Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8B7682636
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjAaIPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjAaIPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:15:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC663A863
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:15:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D40A16143F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A18EC4339B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675152914;
        bh=wD1NznNfV503vLx09ETXd05uvQ9jLt3NCSE2JyBwyA4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uC/oeESi2aZ2jQhcB83bEps8ryzPuntR/dJTM+EXP9dlLNsttKUSOiENVSPHpNLz1
         L51cjg11TSo+0TEa7XwAlXi6u9UBQwpmrVz4vQz88UxkXGRN1Tb7rXHHOVb4V7a+c6
         PYZpg5edxFBTkcn4v7vnv6HsuvHkZVVGpoX+ae4GeyJgJ6/MwbIkz4nTsY7Bb5Za2b
         YTbKNB/kgcEwmTN92mgWzxxJInn8O972Axj6cPsYZ4HHncQpsKadzEVABkmtnmvIqw
         +8ohfswyitnNudJD5g1EaTlwFCz9QogG+Ze6QqOgXTYp8Eh4ECwNrsU6ERWCbcVr+w
         deQnCifatoHMw==
Received: by mail-ej1-f45.google.com with SMTP id ud5so39264244ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:15:14 -0800 (PST)
X-Gm-Message-State: AO0yUKUP3DElZolW2eTIScQZ3GLLyZWBoPiRhHXFMWFjudEsgzg2EGGw
        2NHtgU43/hRm6hkdZ1Qw9h1aDg1YlWvdsJ08qEs=
X-Google-Smtp-Source: AK7set9r/X+j/Luoht27IephzJVMDnLH8X6uylPqj/MkoZXHgCuEwARpobIh/RTwX4q6Sx+4LpYYcrIf5XBGM/cPrEM=
X-Received: by 2002:a17:907:2155:b0:884:c19c:7c6 with SMTP id
 rk21-20020a170907215500b00884c19c07c6mr2277552ejb.120.1675152912320; Tue, 31
 Jan 2023 00:15:12 -0800 (PST)
MIME-Version: 1.0
References: <20230126161559.1467374-1-guoren@kernel.org> <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us> <CAJF2gTQZWO8Ubi60nHn-J-8czqBnsp1Kdyoim3uLNkjbYd-H8Q@mail.gmail.com>
 <87ilgntdef.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87ilgntdef.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 31 Jan 2023 16:15:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTaartwjVdmtmsm1FqmYVuAq5_nGYU5zc6nkdTtCm200A@mail.gmail.com>
Message-ID: <CAJF2gTTaartwjVdmtmsm1FqmYVuAq5_nGYU5zc6nkdTtCm200A@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, linux-riscv@lists.infradead.org,
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

On Tue, Jan 31, 2023 at 2:40 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wr=
ote:
>
> Guo Ren <guoren@kernel.org> writes:
>
> > On Mon, Jan 30, 2023 at 11:28 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.or=
g> wrote:
> >>
> >> Guo Ren <guoren@kernel.org> writes:
> >>
> >> >> In the serie of RISCV OPTPROBES [1], it patches a long-jump instruc=
tions pair
> >> >> AUIPC/JALR in kernel text, so in order to ensure other CPUs does no=
t execute
> >> >> in the instructions that will be modified, it is still need to stop=
 other CPUs
> >> >> via patch_text API, or you have any better solution to achieve the =
purpose?
> >> >  - The stop_machine is an expensive way all architectures should
> >> > avoid, and you could keep that in your OPTPROBES implementation file=
s
> >> > with static functions.
> >> >  - The stop_machine couldn't work with PREEMPTION, so your
> >> > implementation needs to work with !PREEMPTION.
> >>
> >> ...and stop_machine() with !PREEMPTION is broken as well, when you're
> >> replacing multiple instructions (see Mark's post at [1]). The
> >> stop_machine() dance might work when you're replacing *one* instructio=
n,
> >> not multiple as in the RISC-V case. I'll expand on this in a comment i=
n
> >> the OPTPROBES v6 series.
> >>
> >> >> >  static void __kprobes arch_prepare_simulate(struct kprobe *p)
> >> >> > @@ -114,16 +120,23 @@ void *alloc_insn_page(void)
> >> >> >  /* install breakpoint in text */
> >> >> >  void __kprobes arch_arm_kprobe(struct kprobe *p)
> >> >> >  {
> >> >> > -     if ((p->opcode & __INSN_LENGTH_MASK) =3D=3D __INSN_LENGTH_3=
2)
> >> >> > -             patch_text(p->addr, __BUG_INSN_32);
> >> >> > -     else
> >> >> > -             patch_text(p->addr, __BUG_INSN_16);
> >> >> > +#ifdef CONFIG_RISCV_ISA_C
> >> >> > +     u32 opcode =3D __BUG_INSN_16;
> >> >> > +#else
> >> >> > +     u32 opcode =3D __BUG_INSN_32;
> >> >> > +#endif
> >> >> > +     patch_text_nosync(p->addr, &opcode, GET_INSN_LENGTH(opcode)=
);
> >> >>
> >> >> Sounds good, but it will leave some RVI instruction truncated in ke=
rnel text,
> >> >> i doubt kernel behavior depends on the rest of the truncated instru=
ction, well,
> >> >> it needs more strict testing to prove my concern :)
> >> > I do this on purpose, and it doesn't cause any problems. Don't worry=
;
> >> > IFU hw must enforce the fetch sequence, and there is no way to execu=
te
> >> > broken instructions even in the speculative execution path.
> >>
> >> This is stretching reality a bit much. ARMv8, e.g., has a chapter in t=
he
> >> Arm ARM [2] Appendix B "Concurrent modification and execution of
> >> instructions" (CMODX). *Some* instructions can be replaced concurrentl=
y,
> >> and others cannot without caution. Assuming that that all RISC-V
> >> implementations can, is a stretch. RISC-V hasn't even specified the
> >> behavior of CMODX (which is problematic).
> > Here we only use one sw/sh instruction to store a 32bit/16bit aligned e=
lement:
> >
> > INSN_0 <- ebreak (16bit/32bit aligned)
> > INSN_1
> > INSN_2
> >
> > The ebreak would cause an exception which implies a huge fence here.
> > No machine could give a speculative execution for the ebreak path.
>
> It's the concurrent modification that I was referring to (removing
> stop_machine()). You're saying "it'll always work", I'm saying "I'm not
> so sure". :-) E.g., writing c.ebreak on an 32b insn. Can you say that
Software must ensure write c.ebreak on the head of an 32b insn.

That means IFU only see:
 - c.ebreak + broken/illegal insn.
or
 - origin insn

Even in the worst case, such as IFU fetches instructions one by one:
If the IFU gets the origin insn, it will skip the broken/illegal insn.
If the IFU gets the c.ebreak + broken/illegal insn, then an ebreak
exception is raised.

Because c.ebreak would raise an exception, I don't see any problem.


> will work on all RISC-V implementations? Do you have examples of
> hardware where it will work?
For the c.ebreak, it's natural. It's hard to make hardware
implementation get problems here.

>
>
> Bj=C3=B6rn



--=20
Best Regards
 Guo Ren
