Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F9E682148
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjAaBKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjAaBKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:10:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160F92194C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:10:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EFC261355
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B66AC433D2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675127413;
        bh=onpyFW2B+Gj5kU4fpubsm41eLl07ahwfV/KCzovWuCM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JLX3QU5f6YyvUji+AsZZDgDFjL93k9MqyxII8YTOjFjg9xb7qQusUInU5OBUWf7Uu
         0mK51JzVBJgHZyPLpCYbVU7HsptcBbhQ6jMTTk22nzwL806mEeTkIt98D39v54yXv+
         +sLcniGZ5f3crLxq3qobHzYMiNH7fa1gL6l4sHG+ZCoz1yyJn71JkTKYaAeaXnGAs3
         kZptq0fewUUZZdUrjD3OuTsaKLzaIFPJYuY0x6Is68I3VfJLJFEz5I2bzWRmkbWPdq
         z1mwri75ZMYOyj+mjcg7vhjR51l5hgf3H83m4PDhrfxe7ZfghYMYIir5fVGMnADnyC
         OzZ9FgojgSoGA==
Received: by mail-ed1-f53.google.com with SMTP id be12so1647879edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:10:13 -0800 (PST)
X-Gm-Message-State: AFqh2krkqhgNTTKYQB7EXVw9kVYcOhZL7oYNFXnGtF8oTakEBkGtrDsj
        YXVn4GxN3KAJ7TshRpyeE0tzN2N9ZGY5b652XP4=
X-Google-Smtp-Source: AMrXdXsIBsel5Hml0GeDeoAvVHwBKmoYikSeM8cUxgU/ynijJ65Yr62SwxH+Ic34fjMwvakQ3EXbZiCwVVaf5q+hTIM=
X-Received: by 2002:aa7:dbd9:0:b0:49c:ea59:46b with SMTP id
 v25-20020aa7dbd9000000b0049cea59046bmr10186437edt.54.1675127411777; Mon, 30
 Jan 2023 17:10:11 -0800 (PST)
MIME-Version: 1.0
References: <20230126161559.1467374-1-guoren@kernel.org> <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
 <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
 <87r0vc9h4g.fsf@all.your.base.are.belong.to.us> <CAJF2gTQZWO8Ubi60nHn-J-8czqBnsp1Kdyoim3uLNkjbYd-H8Q@mail.gmail.com>
In-Reply-To: <CAJF2gTQZWO8Ubi60nHn-J-8czqBnsp1Kdyoim3uLNkjbYd-H8Q@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 31 Jan 2023 09:09:59 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSHQ7J1a-0tTzaLAHeUTqbco5OXJgGDZpgB-SLb+teL2A@mail.gmail.com>
Message-ID: <CAJF2gTSHQ7J1a-0tTzaLAHeUTqbco5OXJgGDZpgB-SLb+teL2A@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     "liaochang (A)" <liaochang1@huawei.com>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
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

On Tue, Jan 31, 2023 at 9:01 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Mon, Jan 30, 2023 at 11:28 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>=
 wrote:
> >
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
> >
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
> Here we only use one sw/sh instruction to store a 32bit/16bit aligned ele=
ment:
>
> INSN_0 <- ebreak (16bit/32bit aligned)
> INSN_1
> INSN_2
>
> The ebreak would cause an exception which implies a huge fence here.
> No machine could give a speculative execution for the ebreak path.

For ARMv7, ebreak is also safe:

---
Concurrent modification and execution of instructions

The ARMv7 architecture limits the set of instructions that can be
executed by one thread of execution as they are being modified by
another thread of execution without requiring explicit
synchronization.
...
The instructions to which this guarantee applies are:
In the Thumb instruction set
The 16-bit encodings of the B, NOP, BKPT, and SVC instructions.
...
In the ARM instruction set
The B, BL, NOP, BKPT, SVC, HVC, and SMC instructions.
---

>
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
>
>
>
> --
> Best Regards
>  Guo Ren



--=20
Best Regards
 Guo Ren
