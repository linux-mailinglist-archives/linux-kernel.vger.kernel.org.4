Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC8A6A13B0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjBWXU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBWXU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:20:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB935D474
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:20:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 60004B81B5D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 23:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25833C433A0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 23:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677194448;
        bh=tEB6VWDnZi4Sto/dZjWVXxAeNLBAPRa7+m1XXZz9Fkk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oJ1keggLfITS5OXIT+WxMZk8tpmpGxsu1Z2CzCYjNai08yHLLrn7LLWcgyqaSzNH6
         UHEEwVt+lNAUk7gR/AG38xZ0FQvYeFNe85K9dEMwxiNF3snCcJTJN9QUWQ3yJW7dyI
         rXinm9XlvzOMaxxYwNDtdSRJg15JHg07FPFUg5iK4JHhTJweKLTP00gmSpl6+HKGTt
         r2FbhpPWtn92FVvN4WnnJ8J7Dn3/GlAMzlUr3DTOwH/Z03inChqxmttFy0DW1WyjIn
         OpGa4eCYNEfahsYCb2z7Os5LYuWFmC3ASUQwRb29KBJaN3pndd4eYmpLZYEStas8yE
         SaZ2HmBqvOaSQ==
Received: by mail-ed1-f48.google.com with SMTP id cy6so42765232edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:20:48 -0800 (PST)
X-Gm-Message-State: AO0yUKWoOINxFYMrubUvQrP/j+0vb8IUCIjH5CF3iz7DC3BejYo93fq+
        XzKEMMLcjWHdYxpFpl5oBSvyxp/u5hZ5wYbKv2Y=
X-Google-Smtp-Source: AK7set/qjcMqXrx+0LRDJ1LvPHLkzE2X6824hndpr9auznD2eJy3tOmZVaEIqe2PJzLqnLPyHgDnm37hgXmtOMaS4TM=
X-Received: by 2002:a17:906:5e5a:b0:877:747c:9745 with SMTP id
 b26-20020a1709065e5a00b00877747c9745mr10091800eju.8.1677194446235; Thu, 23
 Feb 2023 15:20:46 -0800 (PST)
MIME-Version: 1.0
References: <20221111075902.798571-1-guoren@kernel.org> <CA+V-a8tbFhefuYF0UrGNrKZn6CpHEUhOvsf4GNmdLza0gWvf=w@mail.gmail.com>
 <CA+ZOyah9dBzzkHyy6wxk+hok3K1YrR9h+VdA3aTW5+m9ne04SQ@mail.gmail.com>
In-Reply-To: <CA+ZOyah9dBzzkHyy6wxk+hok3K1YrR9h+VdA3aTW5+m9ne04SQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 24 Feb 2023 07:20:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQHe9aNU86FUBrz4Ljyg5vSWH2yV_=NM+Kynmc7G75wQg@mail.gmail.com>
Message-ID: <CAJF2gTQHe9aNU86FUBrz4Ljyg5vSWH2yV_=NM+Kynmc7G75wQg@mail.gmail.com>
Subject: Re: [PATCH V3] riscv: asid: Fixup stale TLB entry cause application crash
To:     Zong Li <zongbox@gmail.com>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu, alex@ghiti.fr, hch@lst.de,
        ajones@ventanamicro.com, gary@garyguo.net, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Zong Li <zong.li@sifive.com>
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

On Fri, Feb 24, 2023 at 1:58 AM Zong Li <zongbox@gmail.com> wrote:
>
> Lad, Prabhakar <prabhakar.csengg@gmail.com> =E6=96=BC 2022=E5=B9=B412=E6=
=9C=8823=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:54=E5=AF=AB=E9=81=
=93=EF=BC=9A
> >
> > Hi Guo,
> >
> > Thank you for the patch.
> >
> > On Fri, Nov 11, 2022 at 8:00 AM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > After use_asid_allocator is enabled, the userspace application will
> > > crash by stale TLB entries. Because only using cpumask_clear_cpu with=
out
> > > local_flush_tlb_all couldn't guarantee CPU's TLB entries were fresh.
> > > Then set_mm_asid would cause the user space application to get a stal=
e
> > > value by stale TLB entry, but set_mm_noasid is okay.
> > >
> > > Here is the symptom of the bug:
> > > unhandled signal 11 code 0x1 (coredump)
> > >    0x0000003fd6d22524 <+4>:     auipc   s0,0x70
> > >    0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92490
> > > =3D> 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
> > > (gdb) i r s0
> > > s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
> > > (gdb) x /2x 0x3fd6d92490
> > > 0x3fd6d92490:   0xd80ac8a8      0x0000003f
> > > The core dump file shows that register s0 is wrong, but the value in
> > > memory is correct. Because 'ld s0, -148(s0)' used a stale mapping ent=
ry
> > > in TLB and got a wrong result from an incorrect physical address.
> > >
> > > When the task ran on CPU0, which loaded/speculative-loaded the value =
of
> > > address(0x3fd6d92490), then the first version of the mapping entry wa=
s
> > > PTWed into CPU0's TLB.
> > > When the task switched from CPU0 to CPU1 (No local_tlb_flush_all here=
 by
> > > asid), it happened to write a value on the address (0x3fd6d92490). It
> > > caused do_page_fault -> wp_page_copy -> ptep_clear_flush ->
> > > ptep_get_and_clear & flush_tlb_page.
> > > The flush_tlb_page used mm_cpumask(mm) to determine which CPUs need T=
LB
> > > flush, but CPU0 had cleared the CPU0's mm_cpumask in the previous
> > > switch_mm. So we only flushed the CPU1 TLB and set the second version
> > > mapping of the PTE. When the task switched from CPU1 to CPU0 again, C=
PU0
> > > still used a stale TLB mapping entry which contained a wrong target
> > > physical address. It raised a bug when the task happened to read that
> > > value.
> > >
> > >    CPU0                               CPU1
> > >    - switch 'task' in
> > >    - read addr (Fill stale mapping
> > >      entry into TLB)
> > >    - switch 'task' out (no tlb_flush)
> > >                                       - switch 'task' in (no tlb_flus=
h)
> > >                                       - write addr cause pagefault
> > >                                         do_page_fault() (change to
> > >                                         new addr mapping)
> > >                                           wp_page_copy()
> > >                                             ptep_clear_flush()
> > >                                               ptep_get_and_clear()
> > >                                               & flush_tlb_page()
> > >                                         write new value into addr
> > >                                       - switch 'task' out (no tlb_flu=
sh)
> > >    - switch 'task' in (no tlb_flush)
> > >    - read addr again (Use stale
> > >      mapping entry in TLB)
> > >      get wrong value from old phyical
> > >      addr, BUG!
> > >
> > > The solution is to keep all CPUs' footmarks of cpumask(mm) in switch_=
mm,
> > > which could guarantee to invalidate all stale TLB entries during TLB
> > > flush.
> > >
> > > Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > Cc: Anup Patel <apatel@ventanamicro.com>
> > > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > > ---
> > > Changes in v3:
> > >  - Move set/clear cpumask(mm) into set_mm (Make code more pretty
> > >    with Andrew's advice)
> > >  - Optimize comment description
> > >
> > > Changes in v2:
> > >  - Fixup nommu compile problem (Thx Conor, Also Reported-by: kernel
> > >    test robot <lkp@intel.com>)
> > >  - Keep cpumask_clear_cpu for noasid
> > > ---
> > >  arch/riscv/mm/context.c | 30 ++++++++++++++++++++----------
> > >  1 file changed, 20 insertions(+), 10 deletions(-)
> > >
> > As reported on the patch [0] I was seeing consistent failures on the
> > RZ/Five SoC while running bonnie++ utility. After applying this patch
> > on top of Palmer's for-next branch (eb67d239f3aa) I am no longer
> > seeing this issue.
> >
> > Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > [0] https://patchwork.kernel.org/project/linux-riscv/patch/202208292052=
19.283543-1-geomatsi@gmail.com/
> >
>
> Hi all,
> I got the same situation (i.e. unhandle signal 11) on our internal
> multi-core system, I tried the patch[0] & [1], but it still doesn't
> work, I guess there are still some potential problems. After applying
> this patch, the situation disappeared, I took some time to look at
> other arches' implementations, such as arc, they don't clear the
> mm_cpumask due to the similar issue. I can't say which approach might
> be better, but I'd like to point out that this patch works to me.
> Thanks.
Thx for the report.

I think the patch is simpler and more direct to the problem than the
current fixup approach. Although the maintainer thought it was a
temporary solution.

This patch has been tested in our production environment for huge
amounts of thousand of hours. You can trust it :)

>
> Tested-by: Zong Li <zong.li@sifive.com>


>
> [0] https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomatsi@=
gmail.com/
> [1] https://lore.kernel.org/linux-riscv/20230129211818.686557-1-geomatsi@=
gmail.com/
>
> > Cheers,
> > Prabhakar
> >
> > > diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> > > index 7acbfbd14557..0f784e3d307b 100644
> > > --- a/arch/riscv/mm/context.c
> > > +++ b/arch/riscv/mm/context.c
> > > @@ -205,12 +205,24 @@ static void set_mm_noasid(struct mm_struct *mm)
> > >         local_flush_tlb_all();
> > >  }
> > >
> > > -static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
> > > +static inline void set_mm(struct mm_struct *prev,
> > > +                         struct mm_struct *next, unsigned int cpu)
> > >  {
> > > -       if (static_branch_unlikely(&use_asid_allocator))
> > > -               set_mm_asid(mm, cpu);
> > > -       else
> > > -               set_mm_noasid(mm);
> > > +       /*
> > > +        * The mm_cpumask indicates which harts' TLBs contain the vir=
tual
> > > +        * address mapping of the mm. Compared to noasid, using asid
> > > +        * can't guarantee that stale TLB entries are invalidated bec=
ause
> > > +        * the asid mechanism wouldn't flush TLB for every switch_mm =
for
> > > +        * performance. So when using asid, keep all CPUs footmarks i=
n
> > > +        * cpumask() until mm reset.
> > > +        */
> > > +       cpumask_set_cpu(cpu, mm_cpumask(next));
> > > +       if (static_branch_unlikely(&use_asid_allocator)) {
> > > +               set_mm_asid(next, cpu);
> > > +       } else {
> > > +               cpumask_clear_cpu(cpu, mm_cpumask(prev));
> > > +               set_mm_noasid(next);
> > > +       }
> > >  }
> > >
> > >  static int __init asids_init(void)
> > > @@ -264,7 +276,8 @@ static int __init asids_init(void)
> > >  }
> > >  early_initcall(asids_init);
> > >  #else
> > > -static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
> > > +static inline void set_mm(struct mm_struct *prev,
> > > +                         struct mm_struct *next, unsigned int cpu)
> > >  {
> > >         /* Nothing to do here when there is no MMU */
> > >  }
> > > @@ -317,10 +330,7 @@ void switch_mm(struct mm_struct *prev, struct mm=
_struct *next,
> > >          */
> > >         cpu =3D smp_processor_id();
> > >
> > > -       cpumask_clear_cpu(cpu, mm_cpumask(prev));
> > > -       cpumask_set_cpu(cpu, mm_cpumask(next));
> > > -
> > > -       set_mm(next, cpu);
> > > +       set_mm(prev, next, cpu);
> > >
> > >         flush_icache_deferred(next, cpu);
> > >  }
> > > --
> > > 2.36.1
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Best Regards
 Guo Ren
