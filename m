Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6174267F4C8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 05:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjA1EqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 23:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjA1EqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 23:46:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042787FA2B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 20:46:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F24560C64
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE00C4339B
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 04:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674881161;
        bh=b72hJUZfD18JHAyinbqmFHLojR6HKWp4OSsm8RTTCZU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Yw1qdWZco3FTIQiBF8v5C+CZr8LScneCD3blcxh1tl6DwFlPa43zwSaYL8QPv/jhN
         Nm46//YYgPd7UaNI3aCBp6LKegktIcbokqDvf/rg+KilZX2nTfCtB/dT2fZt1qTqgz
         t4RTONBpVZ3s3sXtOlVMCM6l1W+6a/DtyANOHz2/dbvyELHz7bRObpxMbiqC6itN73
         n6VGRnJzvfOdUsdZVYy1qpj89fmqyq8b0FquFnVU+u8yYfNBiE69hjzqHw/U22r9nH
         aV7VF1rapXNf13C1yoXL08TwnHJHJZrDoYnEHc/MT/Kx74KOPOqBlboT9omUiwA4oW
         s/kW71ro9WeyA==
Received: by mail-ej1-f45.google.com with SMTP id me3so18679735ejb.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 20:46:00 -0800 (PST)
X-Gm-Message-State: AFqh2krLwNQPtdMYfAVm4lk498s5LSWLmE6W9UiluFCTk0bb0tXyNuXK
        44ykHgUQgWduVg0cNv671Fgc/ENCe4+rPex/9rs=
X-Google-Smtp-Source: AMrXdXvXAv1ju57QDFLqaBIc0xQOuMcKiph+QdnojYSAyu6FeFFGGEgYv57RNN0jUdp8jpX6FZ2F9tnGHSgkGiRXTQM=
X-Received: by 2002:a17:906:5e09:b0:84d:4eae:d35b with SMTP id
 n9-20020a1709065e0900b0084d4eaed35bmr5165175eju.73.1674881159055; Fri, 27 Jan
 2023 20:45:59 -0800 (PST)
MIME-Version: 1.0
References: <20230126161559.1467374-1-guoren@kernel.org> <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
In-Reply-To: <0abbbdd4-6b85-9659-03ee-97c56a5b77c1@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 28 Jan 2023 12:45:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
Message-ID: <CAJF2gTS0s4X_uwLaEeSqKAyRmxCR2vxRuHhz7-SP2w4bBqzr+Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Optimize kprobe with accurate atomicity
To:     "liaochang (A)" <liaochang1@huawei.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com, mhiramat@kernel.org,
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

On Sat, Jan 28, 2023 at 11:53 AM liaochang (A) <liaochang1@huawei.com> wrot=
e:
>
> Hi, Guo Ren
>
> =E5=9C=A8 2023/1/27 0:15, guoren@kernel.org =E5=86=99=E9=81=93:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The previous implementation was based on the stop_matchine mechanism,
> > which reduced the speed of arm/disarm_kprobe. Using minimum ebreak
> > instruction would get accurate atomicity.
> >
> > This patch removes the patch_text of riscv, which is based on
> > stop_machine. Then riscv only reserved patch_text_nosync, and developer=
s
> > need to be more careful in dealing with patch_text atomicity.
>
> In the serie of RISCV OPTPROBES [1], it patches a long-jump instructions =
pair
> AUIPC/JALR in kernel text, so in order to ensure other CPUs does not exec=
ute
> in the instructions that will be modified, it is still need to stop other=
 CPUs
> via patch_text API, or you have any better solution to achieve the purpos=
e?
 - The stop_machine is an expensive way all architectures should
avoid, and you could keep that in your OPTPROBES implementation files
with static functions.
 - The stop_machine couldn't work with PREEMPTION, so your
implementation needs to work with !PREEMPTION.

>
> Thanks.
>
> >
> > When CONFIG_RISCV_ISA_C=3Dn, the ebreak could replace the whole
> > instruction. When CONFIG_RISCV_ISA_C=3Dy, the patch uses 16-bit length
> > c.ebreak instruction, which may occupy the first part of the 32-bit
> > instruction and leave half the rest of the broken instruction. Because
> > ebreak could detour the flow to skip it, leaving it in the kernel text
> > memory is okay.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/include/asm/patch.h     |  1 -
> >  arch/riscv/kernel/patch.c          | 33 ------------------------------
> >  arch/riscv/kernel/probes/kprobes.c | 29 ++++++++++++++++++--------
> >  3 files changed, 21 insertions(+), 42 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/pa=
tch.h
> > index 9a7d7346001e..2500782e6f5b 100644
> > --- a/arch/riscv/include/asm/patch.h
> > +++ b/arch/riscv/include/asm/patch.h
> > @@ -7,6 +7,5 @@
> >  #define _ASM_RISCV_PATCH_H
> >
> >  int patch_text_nosync(void *addr, const void *insns, size_t len);
> > -int patch_text(void *addr, u32 insn);
> >
> >  #endif /* _ASM_RISCV_PATCH_H */
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index 765004b60513..8bd51ed8b806 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -98,36 +98,3 @@ int patch_text_nosync(void *addr, const void *insns,=
 size_t len)
> >       return ret;
> >  }
> >  NOKPROBE_SYMBOL(patch_text_nosync);
> > -
> > -static int patch_text_cb(void *data)
> > -{
> > -     struct patch_insn *patch =3D data;
> > -     int ret =3D 0;
> > -
> > -     if (atomic_inc_return(&patch->cpu_count) =3D=3D num_online_cpus()=
) {
> > -             ret =3D
> > -                 patch_text_nosync(patch->addr, &patch->insn,
> > -                                         GET_INSN_LENGTH(patch->insn))=
;
> > -             atomic_inc(&patch->cpu_count);
> > -     } else {
> > -             while (atomic_read(&patch->cpu_count) <=3D num_online_cpu=
s())
> > -                     cpu_relax();
> > -             smp_mb();
> > -     }
> > -
> > -     return ret;
> > -}
> > -NOKPROBE_SYMBOL(patch_text_cb);
> > -
> > -int patch_text(void *addr, u32 insn)
> > -{
> > -     struct patch_insn patch =3D {
> > -             .addr =3D addr,
> > -             .insn =3D insn,
> > -             .cpu_count =3D ATOMIC_INIT(0),
> > -     };
> > -
> > -     return stop_machine_cpuslocked(patch_text_cb,
> > -                                    &patch, cpu_online_mask);
> > -}
> > -NOKPROBE_SYMBOL(patch_text);
> > diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/pro=
bes/kprobes.c
> > index 475989f06d6d..27f8960c321c 100644
> > --- a/arch/riscv/kernel/probes/kprobes.c
> > +++ b/arch/riscv/kernel/probes/kprobes.c
> > @@ -24,12 +24,18 @@ post_kprobe_handler(struct kprobe *, struct kprobe_=
ctlblk *, struct pt_regs *);
> >  static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
> >  {
> >       unsigned long offset =3D GET_INSN_LENGTH(p->opcode);
> > +#ifdef CONFIG_RISCV_ISA_C
> > +     u32 opcode =3D __BUG_INSN_16;
> > +#else
> > +     u32 opcode =3D __BUG_INSN_32;
> > +#endif
> >
> >       p->ainsn.api.restore =3D (unsigned long)p->addr + offset;
> >
> > -     patch_text(p->ainsn.api.insn, p->opcode);
> > -     patch_text((void *)((unsigned long)(p->ainsn.api.insn) + offset),
> > -                __BUG_INSN_32);
> > +     patch_text_nosync(p->ainsn.api.insn, &p->opcode, offset);
> > +     patch_text_nosync((void *)((unsigned long)(p->ainsn.api.insn) + o=
ffset),
> > +                       &opcode, GET_INSN_LENGTH(opcode));
> > +
>
> I have submit a similar optimization for patching single-step slot [2].
> And it is indeed safe to use compact breakpoint in single-step slot no ma=
tter
> what type of patched instruction is.
Keep the same c.ebreak style in CONFIG_RISCV_ISA_C. It's my design principl=
e.

>
> Thanks.
>
> >  }
> >
> >  static void __kprobes arch_prepare_simulate(struct kprobe *p)
> > @@ -114,16 +120,23 @@ void *alloc_insn_page(void)
> >  /* install breakpoint in text */
> >  void __kprobes arch_arm_kprobe(struct kprobe *p)
> >  {
> > -     if ((p->opcode & __INSN_LENGTH_MASK) =3D=3D __INSN_LENGTH_32)
> > -             patch_text(p->addr, __BUG_INSN_32);
> > -     else
> > -             patch_text(p->addr, __BUG_INSN_16);
> > +#ifdef CONFIG_RISCV_ISA_C
> > +     u32 opcode =3D __BUG_INSN_16;
> > +#else
> > +     u32 opcode =3D __BUG_INSN_32;
> > +#endif
> > +     patch_text_nosync(p->addr, &opcode, GET_INSN_LENGTH(opcode));
>
> Sounds good, but it will leave some RVI instruction truncated in kernel t=
ext,
> i doubt kernel behavior depends on the rest of the truncated instruction,=
 well,
> it needs more strict testing to prove my concern :)
I do this on purpose, and it doesn't cause any problems. Don't worry;
IFU hw must enforce the fetch sequence, and there is no way to execute
broken instructions even in the speculative execution path.

>
> >  }
> >
> >  /* remove breakpoint from text */
> >  void __kprobes arch_disarm_kprobe(struct kprobe *p)
> >  {
> > -     patch_text(p->addr, p->opcode);
> > +#ifdef CONFIG_RISCV_ISA_C
> > +     u32 opcode =3D __BUG_INSN_16;
> > +#else
> > +     u32 opcode =3D __BUG_INSN_32;
> > +#endif
> > +     patch_text_nosync(p->addr, &p->opcode, GET_INSN_LENGTH(opcode));
> >  }
> >
> >  void __kprobes arch_remove_kprobe(struct kprobe *p)
>
> [1] - https://lore.kernel.org/lkml/20230127130541.1250865-9-chenguokai17@=
mails.ucas.ac.cn/
> [2] - https://lore.kernel.org/lkml/20220927022435.129965-1-liaochang1@hua=
wei.com/T/
>
> --
> BR,
> Liao, Chang



--=20
Best Regards
 Guo Ren
