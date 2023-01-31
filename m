Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEF4682185
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjAaBss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjAaBsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:48:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027A027D51
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:48:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D11FB818C2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1C2C433EF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675129723;
        bh=K/yjW5Nk+aszNLr45x2MctvZq4mHC7XfhLAHpxR9Iyw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JEqiA6CKjGCWt72BlyrT7IuQAgV1yG8HkFcs+fchVfhK/HrvjOv8k0+A73mffzJXf
         aETCY+VnRSjmlJEjB6rckHGQh9H+nGnU5lMvDHyQMzQCpasi0kWDFZ1JkVzWP254gg
         9nwiuW/vA5gV5pyKeQbZZoFBr83pO4n55V2bgNnhC5zRZ9hiAY7o5NOmEV+d1LV8Ij
         aAc7sKvSlTQm6T1j4xvdF95G4zfgBg6CwpQP1pIypm7u/DG20o6U0rsM8XoSUzva5L
         83EVu1kKs8MnvShzd6qq18c38fHEjL0H29ZF1IDiwgxSxmtbPaW/8mmBeIWTgqPsSZ
         dy7uHOunhnzTQ==
Received: by mail-ed1-f52.google.com with SMTP id cw4so7840669edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:48:43 -0800 (PST)
X-Gm-Message-State: AO0yUKUDfFrDrJ8fPlZHF+w9te+Rsfe8POsqIDao3Cxjk2vtuEBlRvej
        TbjoTBie21q+Nq75RF/kNexMYiSlYVT4qJo+pS0=
X-Google-Smtp-Source: AK7set86ZLrbSDX6C8yFFLgbGhZwssXS3Isjcf+A2euqyYBysQ7/UnXRcMOITEhGoE6uyALpI2oj7zA3pHnkV3M5qPY=
X-Received: by 2002:a05:6402:291:b0:4a2:1776:631b with SMTP id
 l17-20020a056402029100b004a21776631bmr3407030edv.30.1675129721469; Mon, 30
 Jan 2023 17:48:41 -0800 (PST)
MIME-Version: 1.0
References: <20230126161559.1467374-1-guoren@kernel.org> <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us> <Y9fm+6LPXgtDSma/@FVFF77S0Q05N>
In-Reply-To: <Y9fm+6LPXgtDSma/@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 31 Jan 2023 09:48:29 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRgze_owuWvJjnrPpBNs8+GY-km7wvHU4EuJzarQc+BPQ@mail.gmail.com>
Message-ID: <CAJF2gTRgze_owuWvJjnrPpBNs8+GY-km7wvHU4EuJzarQc+BPQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
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

On Mon, Jan 30, 2023 at 11:49 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Bjorn,
>
> On Mon, Jan 30, 2023 at 04:28:15PM +0100, Bj=C3=B6rn T=C3=B6pel wrote:
> > Guo Ren <guoren@kernel.org> writes:
> >
> > >> In the serie of RISCV OPTPROBES [1], it patches a long-jump instruct=
ions pair
> > >> AUIPC/JALR in kernel text, so in order to ensure other CPUs does not=
 execute
> > >> in the instructions that will be modified, it is still need to stop =
other CPUs
> > >> via patch_text API, or you have any better solution to achieve the p=
urpose?
> > >  - The stop_machine is an expensive way all architectures should
> > > avoid, and you could keep that in your OPTPROBES implementation files
> > > with static functions.
> > >  - The stop_machine couldn't work with PREEMPTION, so your
> > > implementation needs to work with !PREEMPTION.
> >
> > ...and stop_machine() with !PREEMPTION is broken as well, when you're
> > replacing multiple instructions (see Mark's post at [1]). The
> > stop_machine() dance might work when you're replacing *one* instruction=
,
> > not multiple as in the RISC-V case. I'll expand on this in a comment in
> > the OPTPROBES v6 series.
>
> Just to clarify, my comments in [1] were assuming that stop_machine() was=
 not
> used, in which case there is a problem with or without PREEMPTION.
>
> I believe that when using stop_machine(), the !PREEMPTION case is fine, s=
ince
> stop_machine() schedules work rather than running work in IRQ context on =
the
> back of an IPI, so no CPUs should be mid-sequnce during the patching, and=
 it's
> not possible for there to be threads which are preempted mid-sequence.
>
> That all said, IIUC optprobes is going to disappear once fprobe is ready
> everywhere, so that might be moot.
The optprobes could be in the middle of a function, but fprobe must be
the entry of a function, right?

Does your fprobe here mean: ?

The Linux kernel configuration item CONFIG_FPROBE:

prompt: Kernel Function Probe (fprobe)
type: bool
depends on: ( CONFIG_FUNCTION_TRACER ) && (
CONFIG_DYNAMIC_FTRACE_WITH_REGS ) && ( CONFIG_HAVE_RETHOOK )
defined in kernel/trace/Kconfig


>
> Thanks,
> Mark.
>
> > >> >  static void __kprobes arch_prepare_simulate(struct kprobe *p)
> > >> > @@ -114,16 +120,23 @@ void *alloc_insn_page(void)
> > >> >  /* install breakpoint in text */
> > >> >  void __kprobes arch_arm_kprobe(struct kprobe *p)
> > >> >  {
> > >> > -     if ((p->opcode & __INSN_LENGTH_MASK) =3D=3D __INSN_LENGTH_32=
)
> > >> > -             patch_text(p->addr, __BUG_INSN_32);
> > >> > -     else
> > >> > -             patch_text(p->addr, __BUG_INSN_16);
> > >> > +#ifdef CONFIG_RISCV_ISA_C
> > >> > +     u32 opcode =3D __BUG_INSN_16;
> > >> > +#else
> > >> > +     u32 opcode =3D __BUG_INSN_32;
> > >> > +#endif
> > >> > +     patch_text_nosync(p->addr, &opcode, GET_INSN_LENGTH(opcode))=
;
> > >>
> > >> Sounds good, but it will leave some RVI instruction truncated in ker=
nel text,
> > >> i doubt kernel behavior depends on the rest of the truncated instruc=
tion, well,
> > >> it needs more strict testing to prove my concern :)
> > > I do this on purpose, and it doesn't cause any problems. Don't worry;
> > > IFU hw must enforce the fetch sequence, and there is no way to execut=
e
> > > broken instructions even in the speculative execution path.
> >
> > This is stretching reality a bit much. ARMv8, e.g., has a chapter in th=
e
> > Arm ARM [2] Appendix B "Concurrent modification and execution of
> > instructions" (CMODX). *Some* instructions can be replaced concurrently=
,
> > and others cannot without caution. Assuming that that all RISC-V
> > implementations can, is a stretch. RISC-V hasn't even specified the
> > behavior of CMODX (which is problematic).
> >
> > If anything it would be more likely that the existing
> > "stop_machine()-to-replace-with-ebreak" works (again, replacing one
> > instruction does not have the !PREEMPTION issues). Then again, no spec,
> > so mostly guessing from my side. :-(
> >
> > Oh, but the existing "ebreak replace" might be broken like [3].
> >
> >
> > Bj=C3=B6rn
> >
> >
> > [1] https://lore.kernel.org/linux-riscv/Y7%2F6AtX5X0+5qF6Y@FVFF77S0Q05N=
/
> > [2] https://developer.arm.com/documentation/ddi0487/latest
> > [3] https://lore.kernel.org/linux-riscv/20230126170607.1489141-2-guoren=
@kernel.org/



--=20
Best Regards
 Guo Ren
