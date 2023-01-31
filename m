Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEE1682133
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjAaBBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAaBBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:01:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58431234ED
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:01:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E75136136E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:01:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5999BC4339C
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675126905;
        bh=UzLnPrMPazHKF5FDmXMINfM3VNFjMKPOrqYfwtwTj7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SD6tpobxxKgAvp1lqtb8jRnMgJVqtu4q1SCYfwxOXEKjURAMeoQvIrK4g8DBgZdNv
         C7YUhTdL2mXMhkmpbannKrtGe0JveURi/Xfbv4ETOdJBtWZLJr9PzmnM22gza56Hmk
         Mk6ZEc1v9IzFAWDw1xedVjKNKU4Rmvw9RqHFBTOUhOkwAT6xJYWC5MC+2lQxhiVKW9
         1DBD17A3hvigDYXFMeuedrsGH99/ZFctxKF4OylW87JZaiMQSjCdRTDEiQC0cRyNun
         X2rZoTC1ZDM3yIvLWGxl6UGXP03Z2rODdnq71Ks4eHeR7sy+mSlMGTkWebIdBymWWO
         TQmmK4xPmLRfQ==
Received: by mail-ed1-f53.google.com with SMTP id m8so3668296edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:01:45 -0800 (PST)
X-Gm-Message-State: AFqh2kpsP/FO1Op/VEcDTZIZY98KKx3wCPf1uk4G+3KE6j+EEN7qrELo
        fPN2sEsGtjE5vlNmgoaWWL594+HYBTm6ljersSM=
X-Google-Smtp-Source: AMrXdXsKBr0pwRj+GCNipEffTOOdYppyqly6yTeuyDvdDNL4THtiq0Fi+XdDzD4UtO4POv+Cj0RFjiCXIppquHzDlwY=
X-Received: by 2002:a05:6402:110e:b0:47f:55c8:ace2 with SMTP id
 u14-20020a056402110e00b0047f55c8ace2mr8986600edv.63.1675126903561; Mon, 30
 Jan 2023 17:01:43 -0800 (PST)
MIME-Version: 1.0
References: <20230126161559.1467374-1-guoren@kernel.org> <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com> <87r0vc9h4g.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87r0vc9h4g.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 31 Jan 2023 09:01:31 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQZWO8Ubi60nHn-J-8czqBnsp1Kdyoim3uLNkjbYd-H8Q@mail.gmail.com>
Message-ID: <CAJF2gTQZWO8Ubi60nHn-J-8czqBnsp1Kdyoim3uLNkjbYd-H8Q@mail.gmail.com>
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

On Mon, Jan 30, 2023 at 11:28 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> w=
rote:
>
> Guo Ren <guoren@kernel.org> writes:
>
> >> In the serie of RISCV OPTPROBES [1], it patches a long-jump instructio=
ns pair
> >> AUIPC/JALR in kernel text, so in order to ensure other CPUs does not e=
xecute
> >> in the instructions that will be modified, it is still need to stop ot=
her CPUs
> >> via patch_text API, or you have any better solution to achieve the pur=
pose?
> >  - The stop_machine is an expensive way all architectures should
> > avoid, and you could keep that in your OPTPROBES implementation files
> > with static functions.
> >  - The stop_machine couldn't work with PREEMPTION, so your
> > implementation needs to work with !PREEMPTION.
>
> ...and stop_machine() with !PREEMPTION is broken as well, when you're
> replacing multiple instructions (see Mark's post at [1]). The
> stop_machine() dance might work when you're replacing *one* instruction,
> not multiple as in the RISC-V case. I'll expand on this in a comment in
> the OPTPROBES v6 series.
>
> >> >  static void __kprobes arch_prepare_simulate(struct kprobe *p)
> >> > @@ -114,16 +120,23 @@ void *alloc_insn_page(void)
> >> >  /* install breakpoint in text */
> >> >  void __kprobes arch_arm_kprobe(struct kprobe *p)
> >> >  {
> >> > -     if ((p->opcode & __INSN_LENGTH_MASK) =3D=3D __INSN_LENGTH_32)
> >> > -             patch_text(p->addr, __BUG_INSN_32);
> >> > -     else
> >> > -             patch_text(p->addr, __BUG_INSN_16);
> >> > +#ifdef CONFIG_RISCV_ISA_C
> >> > +     u32 opcode =3D __BUG_INSN_16;
> >> > +#else
> >> > +     u32 opcode =3D __BUG_INSN_32;
> >> > +#endif
> >> > +     patch_text_nosync(p->addr, &opcode, GET_INSN_LENGTH(opcode));
> >>
> >> Sounds good, but it will leave some RVI instruction truncated in kerne=
l text,
> >> i doubt kernel behavior depends on the rest of the truncated instructi=
on, well,
> >> it needs more strict testing to prove my concern :)
> > I do this on purpose, and it doesn't cause any problems. Don't worry;
> > IFU hw must enforce the fetch sequence, and there is no way to execute
> > broken instructions even in the speculative execution path.
>
> This is stretching reality a bit much. ARMv8, e.g., has a chapter in the
> Arm ARM [2] Appendix B "Concurrent modification and execution of
> instructions" (CMODX). *Some* instructions can be replaced concurrently,
> and others cannot without caution. Assuming that that all RISC-V
> implementations can, is a stretch. RISC-V hasn't even specified the
> behavior of CMODX (which is problematic).
Here we only use one sw/sh instruction to store a 32bit/16bit aligned eleme=
nt:

INSN_0 <- ebreak (16bit/32bit aligned)
INSN_1
INSN_2

The ebreak would cause an exception which implies a huge fence here.
No machine could give a speculative execution for the ebreak path.

>
> If anything it would be more likely that the existing
> "stop_machine()-to-replace-with-ebreak" works (again, replacing one
> instruction does not have the !PREEMPTION issues). Then again, no spec,
> so mostly guessing from my side. :-(
>
> Oh, but the existing "ebreak replace" might be broken like [3].
>
>
> Bj=C3=B6rn
>
>
> [1] https://lore.kernel.org/linux-riscv/Y7%2F6AtX5X0+5qF6Y@FVFF77S0Q05N/
> [2] https://developer.arm.com/documentation/ddi0487/latest
> [3] https://lore.kernel.org/linux-riscv/20230126170607.1489141-2-guoren@k=
ernel.org/



--=20
Best Regards
 Guo Ren
