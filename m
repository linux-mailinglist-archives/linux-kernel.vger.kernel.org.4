Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F819682D32
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjAaNCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjAaNCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:02:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC1F4E530
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:01:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB72E614FF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334C2C433EF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675170116;
        bh=/VAKhl7zagtIgdjGwqlGupC5IRrBl2jrcRFqxAjRHxM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=icpG5ITbtsUgk6GynG1F4oNBYCig/WOimDgmxqS85xlBvdXstlGnNKYDjqCDsTWfl
         kZSk+YIobQjBInIPaTFJBe6N877NIWtUujbzUr4SxrKCd5AVw5/U9xy8b+B+ppyWui
         O/CtkoLl0gnIPGeUuaIXZfXRJ4L9ZVzEPCQCjbZfN3WHajNz0ZSnT6z1z30D13ODDl
         U3q40QuYc2J/K3DJRNKeCf8/7Jca2+XLZd5pCE9DEa6uok2F6pdy5dzlFCD9BLsBkY
         5AqHO4akzhKcmnAlVtzZlJ1WJ4h/4/YFYt333jVzYa5Y5NUnsRaPMTbOFAP691M7aJ
         cBZv6CAw82tow==
Received: by mail-ej1-f42.google.com with SMTP id qw12so25452488ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:01:56 -0800 (PST)
X-Gm-Message-State: AO0yUKW3Va/aMDmmw6juF1EipqqpCcq74R1Yl+D2MFf78NuVQXG1kEZS
        v6jgi1R/ZYlhOgKE0fOtbRSPlYa1tpReB0j+nyc=
X-Google-Smtp-Source: AK7set8ZY0Pqh013WZoEM81qvg3+qc7Ap0ePYEZL/lKJHhaYQoLaEJC43/Cqck8HNJYNwQwTD+CbB9Bkdbqu8QiYtXY=
X-Received: by 2002:a17:906:14cf:b0:878:69e5:b797 with SMTP id
 y15-20020a17090614cf00b0087869e5b797mr4325487ejc.228.1675170114368; Tue, 31
 Jan 2023 05:01:54 -0800 (PST)
MIME-Version: 1.0
References: <20230126130509.1418251-1-guoren@kernel.org> <878rhig9zj.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <878rhig9zj.fsf@all.your.base.are.belong.to.us>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 31 Jan 2023 21:01:42 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSnb4cvcXFvgkesgjuPOiZbcp4GZ2qJas4VWn68Pfsb9A@mail.gmail.com>
Message-ID: <CAJF2gTSnb4cvcXFvgkesgjuPOiZbcp4GZ2qJas4VWn68Pfsb9A@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Fixup kernel panic when probing an illegal position
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com, mhiramat@kernel.org,
        conor.dooley@microchip.com, penberg@kernel.org,
        mark.rutland@arm.com, liaochang <liaochang1@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
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

On Tue, Jan 31, 2023 at 8:32 PM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> wr=
ote:
>
> guoren@kernel.org writes:
>
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The kernel would panic when probed for an illegal position. eg:
> >
> > (CONFIG_RISCV_ISA_C=3Dn)
> >
> > echo 'p:hello kernel_clone+0x16 a0=3D%a0' >> kprobe_events
> > echo 1 > events/kprobes/hello/enable
> > cat trace
> >
> > Kernel panic - not syncing: stack-protector: Kernel stack
> > is corrupted in: __do_sys_newfstatat+0xb8/0xb8
> > CPU: 0 PID: 111 Comm: sh Not tainted
> > 6.2.0-rc1-00027-g2d398fe49a4d #490
> > Hardware name: riscv-virtio,qemu (DT)
> > Call Trace:
> > [<ffffffff80007268>] dump_backtrace+0x38/0x48
> > [<ffffffff80c5e83c>] show_stack+0x50/0x68
> > [<ffffffff80c6da28>] dump_stack_lvl+0x60/0x84
> > [<ffffffff80c6da6c>] dump_stack+0x20/0x30
> > [<ffffffff80c5ecf4>] panic+0x160/0x374
> > [<ffffffff80c6db94>] generic_handle_arch_irq+0x0/0xa8
> > [<ffffffff802deeb0>] sys_newstat+0x0/0x30
> > [<ffffffff800158c0>] sys_clone+0x20/0x30
> > [<ffffffff800039e8>] ret_from_syscall+0x0/0x4
> > ---[ end Kernel panic - not syncing: stack-protector:
> > Kernel stack is corrupted in: __do_sys_newfstatat+0xb8/0xb8 ]---
> >
> > That is because the kprobe's ebreak instruction broke the kernel's
> > original code. The user should guarantee the correction of the probe
> > position, but it couldn't make the kernel panic.
> >
> > This patch adds arch_check_kprobe in arch_prepare_kprobe to prevent an
> > illegal position (Such as the middle of an instruction).
>
> Nice!
>
> @liaochang Will you remove your patch from the OPTPROBE series?
>
> > Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/kernel/probes/kprobes.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/pro=
bes/kprobes.c
> > index f21592d20306..475989f06d6d 100644
> > --- a/arch/riscv/kernel/probes/kprobes.c
> > +++ b/arch/riscv/kernel/probes/kprobes.c
> > @@ -48,6 +48,21 @@ static void __kprobes arch_simulate_insn(struct kpro=
be *p, struct pt_regs *regs)
> >       post_kprobe_handler(p, kcb, regs);
> >  }
> >
> > +static bool __kprobes arch_check_kprobe(struct kprobe *p)
> > +{
> > +     unsigned long tmp  =3D (unsigned long)p->addr - p->offset;
> > +     unsigned long addr =3D (unsigned long)p->addr;
> > +
> > +     while (tmp <=3D addr) {
> > +             if (tmp =3D=3D addr)
> > +                     return true;
> > +
> > +             tmp +=3D GET_INSN_LENGTH(*(kprobe_opcode_t *)tmp);
>
> kprobe_opcode_t is u32; This can trigger a misaligned load, right?
>
> > +     }
> > +
> > +     return false;
> > +}
> > +
> >  int __kprobes arch_prepare_kprobe(struct kprobe *p)
> >  {
> >       unsigned long probe_addr =3D (unsigned long)p->addr;
> > @@ -55,6 +70,9 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
> >       if (probe_addr & 0x1)
> >               return -EILSEQ;
> >
> > +     if (!arch_check_kprobe(p))
> > +             return -EILSEQ;
> > +
> >       /* copy instruction */
> >       p->opcode =3D *p->addr;
>
> Not related to your patch, but this can also trigger a misaligned load.
Yes, it would trigger a misaligned load.

What's the problem of that?

>
>
> Bj=C3=B6rn



--=20
Best Regards
 Guo Ren
