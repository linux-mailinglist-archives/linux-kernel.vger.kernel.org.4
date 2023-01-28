Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8687A67F4E5
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 06:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbjA1FWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 00:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjA1FWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 00:22:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F227B42F
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 21:22:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FC8760B77
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 05:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E505EC433D2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 05:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674883352;
        bh=RgMQrIq5NCunPhbq4F3nIkigDBT67Aykecs1pXiv1fY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G2MaQ8rszqCkrtIMHTnh9aKMvZd0cCzbs/jE7osjLQDtWjUouZl3KlL3bNs3NBpHX
         Gveqzn2YlgWxIvxJphlvR55GYJqEqepMv+5ZaS+uFBx0QusfXT5DJkV1xUoXSB2R7B
         /l2ZczCa27VQQHoOJ8aNR0LpC7PCdL7YOMeP9cWqSXtQ56WRnnEA1Zqi41l2o2ksDR
         wUYAzi/WCuKXVlMUnKHOjcdHEBQi9qgS2S5xrA/SYQKHFEGzGwzxWVSGIIHQIvl0kC
         L0MliAU6vHhykJSxtvTUKUKnMOAuVy3psj+V0KRLkVEwvDLeZvx8xZRWb4+ww7/rr0
         cMo6evYEuq/iA==
Received: by mail-ej1-f41.google.com with SMTP id bk15so18760996ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 21:22:32 -0800 (PST)
X-Gm-Message-State: AO0yUKVzZQXHsGE+/6RJu0N9tUq2mRy+fCFc+lESWIpVOVmNNtf/b0Nu
        8BJD0VLl/rMBjplUpCyI9IpW3ihiZNBaOJsUtNw=
X-Google-Smtp-Source: AMrXdXt4YoYGWb/Ur+ZuHhtYhoizwU6XirUnmJjs9N4IBEmCOnkhA0wApzE8I/B+JvOG61y/mMSF8NnEvw5HcVHDFOc=
X-Received: by 2002:a17:906:770d:b0:877:e1ef:e49a with SMTP id
 q13-20020a170906770d00b00877e1efe49amr3688827ejm.147.1674883351139; Fri, 27
 Jan 2023 21:22:31 -0800 (PST)
MIME-Version: 1.0
References: <20230126130509.1418251-1-guoren@kernel.org> <0871074a-cafb-a172-f062-6ada6d2a3a41@huawei.com>
In-Reply-To: <0871074a-cafb-a172-f062-6ada6d2a3a41@huawei.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 28 Jan 2023 13:22:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTJgKt+UXeKA=AccDjZWGFvxBttOTkfoS=0SFNOwowHBg@mail.gmail.com>
Message-ID: <CAJF2gTTJgKt+UXeKA=AccDjZWGFvxBttOTkfoS=0SFNOwowHBg@mail.gmail.com>
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
>
> https://lore.kernel.org/lkml/20230127130541.1250865-11-chenguokai17@mails=
.ucas.ac.cn/
I have a question on your OPTKPROBE patch:
https://lore.kernel.org/lkml/20230127130541.1250865-10-chenguokai17@mails.u=
cas.ac.cn/

@@ -490,7 +573,14 @@ int arch_prepare_optimized_kprobe(struct
optimized_kprobe *op,
  * to detour buffer, ra is used to form JR jumping back from detour
  * buffer.
  */
- find_free_registers(orig, op, &rd, &ra);
+ if (used_reg =3D=3D ALL_REG_OCCUPIED) {
+ find_free_registers(orig, op, &rd, &ra);
+ } else {
+ /* Choose one unused caller-saved register. */
+ rd =3D ffz(used_reg);
+ ra =3D rd;
+ }
+
  if (rd =3D=3D 0 || ra =3D=3D 0) {
  ^^^^^^^^^^^^^^^^^^
After no opt_used_dst_reg & no free caller-saved register (Of cause,
it's very rare for no available tmp regs):

Why not try:

     0: REG_S  ra, -SZREG(sp)
     4: auipc  ra, ?
     8: jalr   ?(ra)
    12: REG_L  ra, -SZREG(sp)

Besides taking up more instruction slots, does it have other problems?

>
> So this boundary check is necessary no matter CONFIG_RISCV_ISA_C is enabl=
e or not, right?
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
