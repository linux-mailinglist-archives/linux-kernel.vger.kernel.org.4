Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28A6A2E2C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 05:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjBZE1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 23:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjBZE1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 23:27:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A914240D6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:25:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 885DDB80B6B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40632C433AC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 04:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677385494;
        bh=SQRaHRoFcjqD2VwS9dDEc4c/R2iaIeSWSNuOZcUnT20=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PMDjej0b4zpCNvTdAzYNBCUFIttLzpB6yLqCl951wKW/nKhkXtxqF0DonptqvcxMD
         TmZVorDeGnQ7MS8K6kFke+85uK8YX40t4rw2iT8l5NDARxKnyyPaNoGw2CDIkMD8d1
         7f8KPqxD1cXpfENByE3xbC7xF5LwPY0x8i9rwO9Cvx1tS/gLZ0Xrb/g0au6CjoxM5G
         JOfU4rrntEJeKBPX8rbxF2qhYb7KXqQAGG8QF/BlBfJ8YN1ZEw48oCm6dE3nGAZecp
         H/2AkkMPS13m5jxURY11TyAw4lPZre/msN/laAACKso8NKldSV9ehoMZEKWL+aUqpR
         rm5iiu7ufh/eA==
Received: by mail-ed1-f52.google.com with SMTP id s26so12791778edw.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 20:24:54 -0800 (PST)
X-Gm-Message-State: AO0yUKVDTh91DhNog8po4RmIiLQMzT8htaVM93lgksYuozVAOLHxbnok
        S9zVEhR9l+ySrZi1rVVPDKOMBtIP9kqvdwjK/K0=
X-Google-Smtp-Source: AK7set/8aUHfUTy9IBiGS6OvxpxzHC7szdPXEkssAtoM5tLijJkPayeE6RKv29X6SGLGzTe1At6aFmfzs/2giBNSSyQ=
X-Received: by 2002:a50:8a93:0:b0:4ad:7439:cec3 with SMTP id
 j19-20020a508a93000000b004ad7439cec3mr9621514edj.7.1677385492215; Sat, 25 Feb
 2023 20:24:52 -0800 (PST)
MIME-Version: 1.0
References: <20221111075902.798571-1-guoren@kernel.org> <CA+V-a8tbFhefuYF0UrGNrKZn6CpHEUhOvsf4GNmdLza0gWvf=w@mail.gmail.com>
 <CA+ZOyah9dBzzkHyy6wxk+hok3K1YrR9h+VdA3aTW5+m9ne04SQ@mail.gmail.com> <Y/phgGFWMf/4WRSS@curiosity>
In-Reply-To: <Y/phgGFWMf/4WRSS@curiosity>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 25 Feb 2023 23:24:40 -0500
X-Gmail-Original-Message-ID: <CAJF2gTRirf6woe_phDMM84Yy9TGyzhc+767qK0qvNQNaNLmUGA@mail.gmail.com>
Message-ID: <CAJF2gTRirf6woe_phDMM84Yy9TGyzhc+767qK0qvNQNaNLmUGA@mail.gmail.com>
Subject: Re: [PATCH V3] riscv: asid: Fixup stale TLB entry cause application crash
To:     Sergey Matyukevich <geomatsi@gmail.com>
Cc:     Zong Li <zongbox@gmail.com>, Guo Ren <guoren@linux.alibaba.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu, alex@ghiti.fr, hch@lst.de,
        ajones@ventanamicro.com, gary@garyguo.net, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
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

On Sat, Feb 25, 2023 at 2:29=E2=80=AFPM Sergey Matyukevich <geomatsi@gmail.=
com> wrote:
>
> On Fri, Feb 24, 2023 at 01:57:55AM +0800, Zong Li wrote:
> > Lad, Prabhakar <prabhakar.csengg@gmail.com> =E6=96=BC 2022=E5=B9=B412=
=E6=9C=8823=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:54=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > >
> > > Hi Guo,
> > >
> > > Thank you for the patch.
> > >
> > > On Fri, Nov 11, 2022 at 8:00 AM <guoren@kernel.org> wrote:
> > > >
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > After use_asid_allocator is enabled, the userspace application will
> > > > crash by stale TLB entries. Because only using cpumask_clear_cpu wi=
thout
> > > > local_flush_tlb_all couldn't guarantee CPU's TLB entries were fresh=
.
> > > > Then set_mm_asid would cause the user space application to get a st=
ale
> > > > value by stale TLB entry, but set_mm_noasid is okay.
> > > >
> > > > Here is the symptom of the bug:
> > > > unhandled signal 11 code 0x1 (coredump)
> > > >    0x0000003fd6d22524 <+4>:     auipc   s0,0x70
> > > >    0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92490
> > > > =3D> 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
> > > > (gdb) i r s0
> > > > s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
> > > > (gdb) x /2x 0x3fd6d92490
> > > > 0x3fd6d92490:   0xd80ac8a8      0x0000003f
> > > > The core dump file shows that register s0 is wrong, but the value i=
n
> > > > memory is correct. Because 'ld s0, -148(s0)' used a stale mapping e=
ntry
> > > > in TLB and got a wrong result from an incorrect physical address.
> > > >
> > > > When the task ran on CPU0, which loaded/speculative-loaded the valu=
e of
> > > > address(0x3fd6d92490), then the first version of the mapping entry =
was
> > > > PTWed into CPU0's TLB.
> > > > When the task switched from CPU0 to CPU1 (No local_tlb_flush_all he=
re by
> > > > asid), it happened to write a value on the address (0x3fd6d92490). =
It
> > > > caused do_page_fault -> wp_page_copy -> ptep_clear_flush ->
> > > > ptep_get_and_clear & flush_tlb_page.
> > > > The flush_tlb_page used mm_cpumask(mm) to determine which CPUs need=
 TLB
> > > > flush, but CPU0 had cleared the CPU0's mm_cpumask in the previous
> > > > switch_mm. So we only flushed the CPU1 TLB and set the second versi=
on
> > > > mapping of the PTE. When the task switched from CPU1 to CPU0 again,=
 CPU0
> > > > still used a stale TLB mapping entry which contained a wrong target
> > > > physical address. It raised a bug when the task happened to read th=
at
> > > > value.
> > > >
> > > >    CPU0                               CPU1
> > > >    - switch 'task' in
> > > >    - read addr (Fill stale mapping
> > > >      entry into TLB)
> > > >    - switch 'task' out (no tlb_flush)
> > > >                                       - switch 'task' in (no tlb_fl=
ush)
> > > >                                       - write addr cause pagefault
> > > >                                         do_page_fault() (change to
> > > >                                         new addr mapping)
> > > >                                           wp_page_copy()
> > > >                                             ptep_clear_flush()
> > > >                                               ptep_get_and_clear()
> > > >                                               & flush_tlb_page()
> > > >                                         write new value into addr
> > > >                                       - switch 'task' out (no tlb_f=
lush)
> > > >    - switch 'task' in (no tlb_flush)
> > > >    - read addr again (Use stale
> > > >      mapping entry in TLB)
> > > >      get wrong value from old phyical
> > > >      addr, BUG!
> > > >
> > > > The solution is to keep all CPUs' footmarks of cpumask(mm) in switc=
h_mm,
> > > > which could guarantee to invalidate all stale TLB entries during TL=
B
> > > > flush.
> > > >
> > > > Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > Cc: Anup Patel <apatel@ventanamicro.com>
> > > > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > > > ---
> > > > Changes in v3:
> > > >  - Move set/clear cpumask(mm) into set_mm (Make code more pretty
> > > >    with Andrew's advice)
> > > >  - Optimize comment description
> > > >
> > > > Changes in v2:
> > > >  - Fixup nommu compile problem (Thx Conor, Also Reported-by: kernel
> > > >    test robot <lkp@intel.com>)
> > > >  - Keep cpumask_clear_cpu for noasid
> > > > ---
> > > >  arch/riscv/mm/context.c | 30 ++++++++++++++++++++----------
> > > >  1 file changed, 20 insertions(+), 10 deletions(-)
> > > >
> > > As reported on the patch [0] I was seeing consistent failures on the
> > > RZ/Five SoC while running bonnie++ utility. After applying this patch
> > > on top of Palmer's for-next branch (eb67d239f3aa) I am no longer
> > > seeing this issue.
> > >
> > > Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > [0] https://patchwork.kernel.org/project/linux-riscv/patch/2022082920=
5219.283543-1-geomatsi@gmail.com/
> > >
> >
> > Hi all,
> > I got the same situation (i.e. unhandle signal 11) on our internal
> > multi-core system, I tried the patch[0] & [1], but it still doesn't
> > work, I guess there are still some potential problems. After applying
> > this patch, the situation disappeared, I took some time to look at
> > other arches' implementations, such as arc, they don't clear the
> > mm_cpumask due to the similar issue. I can't say which approach might
> > be better, but I'd like to point out that this patch works to me.
> > Thanks.
> >
> > Tested-by: Zong Li <zong.li@sifive.com>
> >
> > [0] https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomats=
i@gmail.com/
> > [1] https://lore.kernel.org/linux-riscv/20230129211818.686557-1-geomats=
i@gmail.com/
>
> Thanks for the report! By the way, could you please share some
> information about the reproducing workload ?
>
> Initial idea was to reduce the number of TLB flushes by deferring (and
> possibly avoiding) some of them. But we have already bug reports from
> two different vendors, so apparently something is overlooked here.
> Lets switch to 'aggrregating' mm_cpumask approach suggested by Guo Ren.
>
> @Guo Ren, do you mind if I re-send your v3 patch together with the
> remaining reverts of my changes ?
Okay, thx for taking care. Let's make it work around first and then improve=
 it.

Actually, the current riscv asid is from arm64 with hardware broadcast
requirements. Maybe we need to consider x86 per-cpu asid pool way.

>
> Regards,
> Sergey



--=20
Best Regards
 Guo Ren
