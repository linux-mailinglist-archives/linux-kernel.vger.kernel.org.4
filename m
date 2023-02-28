Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E386A51B0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 04:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjB1DM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 22:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjB1DMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 22:12:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4991BE5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 19:12:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3211B80DE6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D7CC433B4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 03:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677553969;
        bh=WVoOuBSqkuUcTwMzE5agO6n8iIKOwe3a3xasoVAv+8s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i9j9qlKox1WP180fOC0hJoWpeU6LhNUeG27vtSVPSH9ijl6BXD6r6Ft4sqjRhFgbq
         NQ89LcNaDzVuH/OCf81J4zOuj/aKw6IzF++EY5H5VF25+MuTtm06YWPNm8D0+B+d6x
         237dhbOoDm8yhTXUg++0X2JuiYfzof6GcmW/8xLXKrIf4/1k0TFoEpDNpkl0pifVPt
         0/cYmWpUgmru9LlmPIaT8E54Ir78ugXWkqcDiJ6uKTTWspM0MofOUJif+7zgU15dN0
         iEL9rdIejVfFP12kpHp1710dHD23f5WOFZqn9TYtLeM8xXWmorER1pZA2J7i6jrnGg
         0gQ09VsylWwyA==
Received: by mail-ed1-f49.google.com with SMTP id cy6so34333651edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 19:12:49 -0800 (PST)
X-Gm-Message-State: AO0yUKU/7ZsM9iYKqYvBkcZgTjvjdKmGkJtexjA7ZRb3ZFL9+Q3s0wfF
        ltGGq71xJJUp7Tpury5+d4eDUqdGqgcz7AITW3M=
X-Google-Smtp-Source: AK7set/hWsM0vBN2woVOf5RpxNOnDgrvDq4hr+GEY8njRMSy0fbK7PegCQ8TIyWheh70pq+OPqSJ3QP0rzbj7x9zhHY=
X-Received: by 2002:a17:906:1453:b0:8b1:7ac3:85cd with SMTP id
 q19-20020a170906145300b008b17ac385cdmr438574ejc.8.1677553967580; Mon, 27 Feb
 2023 19:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20221111075902.798571-1-guoren@kernel.org> <CA+V-a8tbFhefuYF0UrGNrKZn6CpHEUhOvsf4GNmdLza0gWvf=w@mail.gmail.com>
 <CA+ZOyah9dBzzkHyy6wxk+hok3K1YrR9h+VdA3aTW5+m9ne04SQ@mail.gmail.com>
 <Y/phgGFWMf/4WRSS@curiosity> <CAJF2gTRirf6woe_phDMM84Yy9TGyzhc+767qK0qvNQNaNLmUGA@mail.gmail.com>
 <20230227224024.182c8cad.gary@garyguo.net>
In-Reply-To: <20230227224024.182c8cad.gary@garyguo.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 28 Feb 2023 11:12:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTW1iSCXSbEpsGf416M3pWy+3TQ9Ox98sAteDtZ1CeedQ@mail.gmail.com>
Message-ID: <CAJF2gTTW1iSCXSbEpsGf416M3pWy+3TQ9Ox98sAteDtZ1CeedQ@mail.gmail.com>
Subject: Re: [PATCH V3] riscv: asid: Fixup stale TLB entry cause application crash
To:     Gary Guo <gary@garyguo.net>
Cc:     Sergey Matyukevich <geomatsi@gmail.com>,
        Zong Li <zongbox@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>, anup@brainfault.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu, alex@ghiti.fr, hch@lst.de,
        ajones@ventanamicro.com, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Zong Li <zong.li@sifive.com>
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

On Tue, Feb 28, 2023 at 6:40=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On Sat, 25 Feb 2023 23:24:40 -0500
> Guo Ren <guoren@kernel.org> wrote:
>
> > On Sat, Feb 25, 2023 at 2:29=E2=80=AFPM Sergey Matyukevich <geomatsi@gm=
ail.com> wrote:
> > >
> > > On Fri, Feb 24, 2023 at 01:57:55AM +0800, Zong Li wrote:
> > > > Lad, Prabhakar <prabhakar.csengg@gmail.com> =E6=96=BC 2022=E5=B9=B4=
12=E6=9C=8823=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:54=E5=AF=AB=
=E9=81=93=EF=BC=9A
> > > > >
> > > > > Hi Guo,
> > > > >
> > > > > Thank you for the patch.
> > > > >
> > > > > On Fri, Nov 11, 2022 at 8:00 AM <guoren@kernel.org> wrote:
> > > > > >
> > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > >
> > > > > > After use_asid_allocator is enabled, the userspace application =
will
> > > > > > crash by stale TLB entries. Because only using cpumask_clear_cp=
u without
> > > > > > local_flush_tlb_all couldn't guarantee CPU's TLB entries were f=
resh.
> > > > > > Then set_mm_asid would cause the user space application to get =
a stale
> > > > > > value by stale TLB entry, but set_mm_noasid is okay.
> > > > > >
> > > > > > Here is the symptom of the bug:
> > > > > > unhandled signal 11 code 0x1 (coredump)
> > > > > >    0x0000003fd6d22524 <+4>:     auipc   s0,0x70
> > > > > >    0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92=
490
> > > > > > =3D> 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
> > > > > > (gdb) i r s0
> > > > > > s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
> > > > > > (gdb) x /2x 0x3fd6d92490
> > > > > > 0x3fd6d92490:   0xd80ac8a8      0x0000003f
> > > > > > The core dump file shows that register s0 is wrong, but the val=
ue in
> > > > > > memory is correct. Because 'ld s0, -148(s0)' used a stale mappi=
ng entry
> > > > > > in TLB and got a wrong result from an incorrect physical addres=
s.
> > > > > >
> > > > > > When the task ran on CPU0, which loaded/speculative-loaded the =
value of
> > > > > > address(0x3fd6d92490), then the first version of the mapping en=
try was
> > > > > > PTWed into CPU0's TLB.
> > > > > > When the task switched from CPU0 to CPU1 (No local_tlb_flush_al=
l here by
> > > > > > asid), it happened to write a value on the address (0x3fd6d9249=
0). It
> > > > > > caused do_page_fault -> wp_page_copy -> ptep_clear_flush ->
> > > > > > ptep_get_and_clear & flush_tlb_page.
> > > > > > The flush_tlb_page used mm_cpumask(mm) to determine which CPUs =
need TLB
> > > > > > flush, but CPU0 had cleared the CPU0's mm_cpumask in the previo=
us
> > > > > > switch_mm. So we only flushed the CPU1 TLB and set the second v=
ersion
> > > > > > mapping of the PTE. When the task switched from CPU1 to CPU0 ag=
ain, CPU0
> > > > > > still used a stale TLB mapping entry which contained a wrong ta=
rget
> > > > > > physical address. It raised a bug when the task happened to rea=
d that
> > > > > > value.
> > > > > >
> > > > > >    CPU0                               CPU1
> > > > > >    - switch 'task' in
> > > > > >    - read addr (Fill stale mapping
> > > > > >      entry into TLB)
> > > > > >    - switch 'task' out (no tlb_flush)
> > > > > >                                       - switch 'task' in (no tl=
b_flush)
> > > > > >                                       - write addr cause pagefa=
ult
> > > > > >                                         do_page_fault() (change=
 to
> > > > > >                                         new addr mapping)
> > > > > >                                           wp_page_copy()
> > > > > >                                             ptep_clear_flush()
> > > > > >                                               ptep_get_and_clea=
r()
> > > > > >                                               & flush_tlb_page(=
)
> > > > > >                                         write new value into ad=
dr
> > > > > >                                       - switch 'task' out (no t=
lb_flush)
> > > > > >    - switch 'task' in (no tlb_flush)
> > > > > >    - read addr again (Use stale
> > > > > >      mapping entry in TLB)
> > > > > >      get wrong value from old phyical
> > > > > >      addr, BUG!
> > > > > >
> > > > > > The solution is to keep all CPUs' footmarks of cpumask(mm) in s=
witch_mm,
> > > > > > which could guarantee to invalidate all stale TLB entries durin=
g TLB
> > > > > > flush.
> > > > > >
> > > > > > Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
> > > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > > Cc: Anup Patel <apatel@ventanamicro.com>
> > > > > > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > > > > > ---
> > > > > > Changes in v3:
> > > > > >  - Move set/clear cpumask(mm) into set_mm (Make code more prett=
y
> > > > > >    with Andrew's advice)
> > > > > >  - Optimize comment description
> > > > > >
> > > > > > Changes in v2:
> > > > > >  - Fixup nommu compile problem (Thx Conor, Also Reported-by: ke=
rnel
> > > > > >    test robot <lkp@intel.com>)
> > > > > >  - Keep cpumask_clear_cpu for noasid
> > > > > > ---
> > > > > >  arch/riscv/mm/context.c | 30 ++++++++++++++++++++----------
> > > > > >  1 file changed, 20 insertions(+), 10 deletions(-)
> > > > > >
> > > > > As reported on the patch [0] I was seeing consistent failures on =
the
> > > > > RZ/Five SoC while running bonnie++ utility. After applying this p=
atch
> > > > > on top of Palmer's for-next branch (eb67d239f3aa) I am no longer
> > > > > seeing this issue.
> > > > >
> > > > > Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
> > > > >
> > > > > [0] https://patchwork.kernel.org/project/linux-riscv/patch/202208=
29205219.283543-1-geomatsi@gmail.com/
> > > > >
> > > >
> > > > Hi all,
> > > > I got the same situation (i.e. unhandle signal 11) on our internal
> > > > multi-core system, I tried the patch[0] & [1], but it still doesn't
> > > > work, I guess there are still some potential problems. After applyi=
ng
> > > > this patch, the situation disappeared, I took some time to look at
> > > > other arches' implementations, such as arc, they don't clear the
> > > > mm_cpumask due to the similar issue. I can't say which approach mig=
ht
> > > > be better, but I'd like to point out that this patch works to me.
> > > > Thanks.
> > > >
> > > > Tested-by: Zong Li <zong.li@sifive.com>
> > > >
> > > > [0] https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geo=
matsi@gmail.com/
> > > > [1] https://lore.kernel.org/linux-riscv/20230129211818.686557-1-geo=
matsi@gmail.com/
> > >
> > > Thanks for the report! By the way, could you please share some
> > > information about the reproducing workload ?
> > >
> > > Initial idea was to reduce the number of TLB flushes by deferring (an=
d
> > > possibly avoiding) some of them. But we have already bug reports from
> > > two different vendors, so apparently something is overlooked here.
> > > Lets switch to 'aggrregating' mm_cpumask approach suggested by Guo Re=
n.
> > >
> > > @Guo Ren, do you mind if I re-send your v3 patch together with the
> > > remaining reverts of my changes ?
> > Okay, thx for taking care. Let's make it work around first and then imp=
rove it.
> >
> > Actually, the current riscv asid is from arm64 with hardware broadcast
> > requirements. Maybe we need to consider x86 per-cpu asid pool way.
>
> It should be noted that the spec expects supervisor software to
> use a consistent meaning of non-zero ASIDs across different harts.
>
> Also, a vendor could implement efficient hardware broadcasting ASID
> invalidation with a custom instruction and expose it via SBI.
I agree with you; actually, our XuanTie supports hardware broadcasting
invalidation, and we expect SBI style.

The x86 style would be another choice for the future, and the riscv
would combine different TLB maintenance styles into one Linux
architecture.

----

Please let me give out an outline of the current riscv state:

1. Current Linux riscv uses unified ASIDs design, which comes from arm
hw broadcast one. Some riscv vendors (XuanTie) could also support TLB
hw broadcast.

2. The riscv spec doesn't suggest hw broadcast because it's unsuitable
for large-scale systems. So x86 style would be another choice for the
future Linux riscv.

Correct? Welcome feedback.

>
> Best,
> Gary



--=20
Best Regards
 Guo Ren
