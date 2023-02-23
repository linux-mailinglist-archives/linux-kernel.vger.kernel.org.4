Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D4A6A0EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 18:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBWR6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 12:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBWR6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 12:58:12 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D8E2E812
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:58:10 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id e9so11607230ljn.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 09:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKgYnuqaN8yxJGre/0H4fb1zCcGeD2CAEWiF9ho0Iss=;
        b=Y4awIPmzfSQYWU9vvX39ElXpDttocv0/K6p/oMCpKkygiBhBe971EzSk386imkT181
         WNeMQCbtyxKqSbauXYN/WXzIgYe56FXYE7RxBiczvvkYVHxxvxnM5B0bypIHRGV4CEdi
         5Ts4paXPDGVDk3GOLNFp2vXq0R4wkPkv8bFZvLJwdSbeIgj6cLrz0IN8wSBOJUMUXh4Y
         /IK1uv6YQqBT+MDUp8GghCgCZfekwN36ljcsBYBXv1NLIbXJuJrwdBXYudlK8uDDC1qk
         1+l6sRMhla7PunhfMo2+TX6oL/h38pI9Y9DckNg1IfCafHF5RCvqauhT/s0JjTBwG3Pv
         CMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKgYnuqaN8yxJGre/0H4fb1zCcGeD2CAEWiF9ho0Iss=;
        b=KI3DX/XRzPlKTtvgev1G7iXiRPOtlgN9ut7IfAlo39zbftZEN+UbB5hY1y/hKNJYZB
         P9NDFHdzkT6KijmaonwjND1HVXLdqXlWZyqd2IsbiTmnOffsA8+MZm5x1LuaO9DpEaSk
         M2B1oZZ9VDINHBLZEsTZD3HslRGLhIX0becxmtKwhTElfIevpwnizCJIiS465q8HuUhU
         84pfrijseIizNuzrpcpG7X3uBE0wxpZSHvK1cy/eligqyxIrs20ILZt2GL7RU//HPM8W
         N9wMNfufWLFXGxbtgRwtCOK2FNX/e0Zt3VbmiuMLmXEJZ8osSPyi6ybzyTCQ6lLEqAcz
         mqrw==
X-Gm-Message-State: AO0yUKVdyy1E7ASdnar10vt67K1EYBiOLJQgZsgnoh92WUKSLi+bKyLJ
        xlZ/uPzS6i1KES/ytqwVVmPNOW6r+UHGGJwFfcc=
X-Google-Smtp-Source: AK7set8pJITniJkSjNtADh2QhZg0G/Ae5yny6uyB3wYbn0U+NqIP2TQu+iCsl//BBZuTx0lrr0ioLpG0J5r0E8/sSCo=
X-Received: by 2002:a05:651c:b9b:b0:295:945d:b382 with SMTP id
 bg27-20020a05651c0b9b00b00295945db382mr2448387ljb.4.1677175088015; Thu, 23
 Feb 2023 09:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20221111075902.798571-1-guoren@kernel.org> <CA+V-a8tbFhefuYF0UrGNrKZn6CpHEUhOvsf4GNmdLza0gWvf=w@mail.gmail.com>
In-Reply-To: <CA+V-a8tbFhefuYF0UrGNrKZn6CpHEUhOvsf4GNmdLza0gWvf=w@mail.gmail.com>
From:   Zong Li <zongbox@gmail.com>
Date:   Fri, 24 Feb 2023 01:57:55 +0800
Message-ID: <CA+ZOyah9dBzzkHyy6wxk+hok3K1YrR9h+VdA3aTW5+m9ne04SQ@mail.gmail.com>
Subject: Re: [PATCH V3] riscv: asid: Fixup stale TLB entry cause application crash
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     guoren@kernel.org, anup@brainfault.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu, alex@ghiti.fr, hch@lst.de,
        ajones@ventanamicro.com, gary@garyguo.net, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Zong Li <zong.li@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lad, Prabhakar <prabhakar.csengg@gmail.com> =E6=96=BC 2022=E5=B9=B412=E6=9C=
=8823=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:54=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hi Guo,
>
> Thank you for the patch.
>
> On Fri, Nov 11, 2022 at 8:00 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > After use_asid_allocator is enabled, the userspace application will
> > crash by stale TLB entries. Because only using cpumask_clear_cpu withou=
t
> > local_flush_tlb_all couldn't guarantee CPU's TLB entries were fresh.
> > Then set_mm_asid would cause the user space application to get a stale
> > value by stale TLB entry, but set_mm_noasid is okay.
> >
> > Here is the symptom of the bug:
> > unhandled signal 11 code 0x1 (coredump)
> >    0x0000003fd6d22524 <+4>:     auipc   s0,0x70
> >    0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92490
> > =3D> 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
> > (gdb) i r s0
> > s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
> > (gdb) x /2x 0x3fd6d92490
> > 0x3fd6d92490:   0xd80ac8a8      0x0000003f
> > The core dump file shows that register s0 is wrong, but the value in
> > memory is correct. Because 'ld s0, -148(s0)' used a stale mapping entry
> > in TLB and got a wrong result from an incorrect physical address.
> >
> > When the task ran on CPU0, which loaded/speculative-loaded the value of
> > address(0x3fd6d92490), then the first version of the mapping entry was
> > PTWed into CPU0's TLB.
> > When the task switched from CPU0 to CPU1 (No local_tlb_flush_all here b=
y
> > asid), it happened to write a value on the address (0x3fd6d92490). It
> > caused do_page_fault -> wp_page_copy -> ptep_clear_flush ->
> > ptep_get_and_clear & flush_tlb_page.
> > The flush_tlb_page used mm_cpumask(mm) to determine which CPUs need TLB
> > flush, but CPU0 had cleared the CPU0's mm_cpumask in the previous
> > switch_mm. So we only flushed the CPU1 TLB and set the second version
> > mapping of the PTE. When the task switched from CPU1 to CPU0 again, CPU=
0
> > still used a stale TLB mapping entry which contained a wrong target
> > physical address. It raised a bug when the task happened to read that
> > value.
> >
> >    CPU0                               CPU1
> >    - switch 'task' in
> >    - read addr (Fill stale mapping
> >      entry into TLB)
> >    - switch 'task' out (no tlb_flush)
> >                                       - switch 'task' in (no tlb_flush)
> >                                       - write addr cause pagefault
> >                                         do_page_fault() (change to
> >                                         new addr mapping)
> >                                           wp_page_copy()
> >                                             ptep_clear_flush()
> >                                               ptep_get_and_clear()
> >                                               & flush_tlb_page()
> >                                         write new value into addr
> >                                       - switch 'task' out (no tlb_flush=
)
> >    - switch 'task' in (no tlb_flush)
> >    - read addr again (Use stale
> >      mapping entry in TLB)
> >      get wrong value from old phyical
> >      addr, BUG!
> >
> > The solution is to keep all CPUs' footmarks of cpumask(mm) in switch_mm=
,
> > which could guarantee to invalidate all stale TLB entries during TLB
> > flush.
> >
> > Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Anup Patel <apatel@ventanamicro.com>
> > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > ---
> > Changes in v3:
> >  - Move set/clear cpumask(mm) into set_mm (Make code more pretty
> >    with Andrew's advice)
> >  - Optimize comment description
> >
> > Changes in v2:
> >  - Fixup nommu compile problem (Thx Conor, Also Reported-by: kernel
> >    test robot <lkp@intel.com>)
> >  - Keep cpumask_clear_cpu for noasid
> > ---
> >  arch/riscv/mm/context.c | 30 ++++++++++++++++++++----------
> >  1 file changed, 20 insertions(+), 10 deletions(-)
> >
> As reported on the patch [0] I was seeing consistent failures on the
> RZ/Five SoC while running bonnie++ utility. After applying this patch
> on top of Palmer's for-next branch (eb67d239f3aa) I am no longer
> seeing this issue.
>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> [0] https://patchwork.kernel.org/project/linux-riscv/patch/20220829205219=
.283543-1-geomatsi@gmail.com/
>

Hi all,
I got the same situation (i.e. unhandle signal 11) on our internal
multi-core system, I tried the patch[0] & [1], but it still doesn't
work, I guess there are still some potential problems. After applying
this patch, the situation disappeared, I took some time to look at
other arches' implementations, such as arc, they don't clear the
mm_cpumask due to the similar issue. I can't say which approach might
be better, but I'd like to point out that this patch works to me.
Thanks.

Tested-by: Zong Li <zong.li@sifive.com>

[0] https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomatsi@gm=
ail.com/
[1] https://lore.kernel.org/linux-riscv/20230129211818.686557-1-geomatsi@gm=
ail.com/

> Cheers,
> Prabhakar
>
> > diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> > index 7acbfbd14557..0f784e3d307b 100644
> > --- a/arch/riscv/mm/context.c
> > +++ b/arch/riscv/mm/context.c
> > @@ -205,12 +205,24 @@ static void set_mm_noasid(struct mm_struct *mm)
> >         local_flush_tlb_all();
> >  }
> >
> > -static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
> > +static inline void set_mm(struct mm_struct *prev,
> > +                         struct mm_struct *next, unsigned int cpu)
> >  {
> > -       if (static_branch_unlikely(&use_asid_allocator))
> > -               set_mm_asid(mm, cpu);
> > -       else
> > -               set_mm_noasid(mm);
> > +       /*
> > +        * The mm_cpumask indicates which harts' TLBs contain the virtu=
al
> > +        * address mapping of the mm. Compared to noasid, using asid
> > +        * can't guarantee that stale TLB entries are invalidated becau=
se
> > +        * the asid mechanism wouldn't flush TLB for every switch_mm fo=
r
> > +        * performance. So when using asid, keep all CPUs footmarks in
> > +        * cpumask() until mm reset.
> > +        */
> > +       cpumask_set_cpu(cpu, mm_cpumask(next));
> > +       if (static_branch_unlikely(&use_asid_allocator)) {
> > +               set_mm_asid(next, cpu);
> > +       } else {
> > +               cpumask_clear_cpu(cpu, mm_cpumask(prev));
> > +               set_mm_noasid(next);
> > +       }
> >  }
> >
> >  static int __init asids_init(void)
> > @@ -264,7 +276,8 @@ static int __init asids_init(void)
> >  }
> >  early_initcall(asids_init);
> >  #else
> > -static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
> > +static inline void set_mm(struct mm_struct *prev,
> > +                         struct mm_struct *next, unsigned int cpu)
> >  {
> >         /* Nothing to do here when there is no MMU */
> >  }
> > @@ -317,10 +330,7 @@ void switch_mm(struct mm_struct *prev, struct mm_s=
truct *next,
> >          */
> >         cpu =3D smp_processor_id();
> >
> > -       cpumask_clear_cpu(cpu, mm_cpumask(prev));
> > -       cpumask_set_cpu(cpu, mm_cpumask(next));
> > -
> > -       set_mm(next, cpu);
> > +       set_mm(prev, next, cpu);
> >
> >         flush_icache_deferred(next, cpu);
> >  }
> > --
> > 2.36.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
