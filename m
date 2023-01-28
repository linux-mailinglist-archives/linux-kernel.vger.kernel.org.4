Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D734167F465
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 04:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbjA1Dq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 22:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA1DqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 22:46:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79058367F6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 19:46:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10C3861DAF
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 03:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7033CC433A8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 03:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674877583;
        bh=xrplkrP1iTni6a9kqOD2wQ3fO257Ty75EuSm7HvQc6k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s3LzPLrnhuV5M5DjsZ+xYFNPevepPT6Ag7EToRdrvKksO7eaieAvPNIL7Ab1CnAD0
         3LL2GkafcW3D95fEmN+la8E3c0Fvn0ZWNYeIRxzlkcjn2ddSnpAkCmnmJlRXSs9Pac
         S8QMlwhDbDyQBQgeTrgsuuHfkxpRDP//h5MaJqz1ocXYqbOADFeyl7KjxgBwyVkbBo
         uds6G+LGviB6OPS3MoKBV4vos4Z4wRF1wr+nobfAVROlDAVLd4+EhCH+kViKFEyp7V
         8qEzRdnQ1xwhKd1aDDWg9hTZYjIBOuLs0oR7cxIZ4gsEGBXzKYfnHHfOX3nGwFnnwW
         RofTyDalS9IwQ==
Received: by mail-ej1-f48.google.com with SMTP id gs13so7801603ejc.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 19:46:23 -0800 (PST)
X-Gm-Message-State: AO0yUKXU7jJF/BQ8g1pISgAYJeqE9W1G9MWFC0mbtCUUmO8VDoe0PhdJ
        bzdBPrq/9LYL6DtW8oYTpZqUQEkDwP0UAdOLTBM=
X-Google-Smtp-Source: AK7set/8/jg1gn5SG5eUmuwfc9eUNjiyDY+MDcbKa+l0SngJGrrgdO+trrxofpt5EpDt6xLwTuw87/kT8yRev9nEHq8=
X-Received: by 2002:a17:906:ad94:b0:878:6d44:ac21 with SMTP id
 la20-20020a170906ad9400b008786d44ac21mr2019096ejb.195.1674877581484; Fri, 27
 Jan 2023 19:46:21 -0800 (PST)
MIME-Version: 1.0
References: <20230126130509.1418251-1-guoren@kernel.org> <0871074a-cafb-a172-f062-6ada6d2a3a41@huawei.com>
In-Reply-To: <0871074a-cafb-a172-f062-6ada6d2a3a41@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 28 Jan 2023 11:46:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTd9V6PKu6_ip21HbXWgN6X-epw8yc_s6XonssStFNdEQ@mail.gmail.com>
Message-ID: <CAJF2gTTd9V6PKu6_ip21HbXWgN6X-epw8yc_s6XonssStFNdEQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: kprobe: Fixup kernel panic when probing an illegal position
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

On Sat, Jan 28, 2023 at 10:55 AM liaochang (A) <liaochang1@huawei.com> wrot=
e:
>
>
>
> =E5=9C=A8 2023/1/26 21:05, guoren@kernel.org =E5=86=99=E9=81=93:
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
> >
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
> > +     }
> > +
> > +     return false;
> > +}
>
> LGTM.
>
> I have submit a patch to fix the same problem, found at:
Oh, I missed that patch. Our goal is the same.

But it would be best if you reused p->offset, not
kallsyms_lookup_size_offset, the p->addr added by _kprobe_addr
(kernel/kprobes.c), not just kallsyms_lookup_size_offset. Sure, it
works around for the current riscv, but that's not correct.

>
> https://lore.kernel.org/lkml/20230127130541.1250865-11-chenguokai17@mails=
.ucas.ac.cn/
>
> So this boundary check is necessary no matter CONFIG_RISCV_ISA_C is enabl=
e or not, right?
Yes, my panic example in the commit log is based on the
!CONFIG_RISCV_ISA_C, you couldn't miss that.

>
>
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
> >
>
> --
> BR,
> Liao, Chang



--=20
Best Regards
 Guo Ren
