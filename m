Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410E35B42C6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiIIXGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiIIXG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:06:27 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090B4112124
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:06:22 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id q83so551518iod.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 16:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=x3D73fEahJ1vsor3fu6c0GZk1cx40QnYDrmVJwVsaoE=;
        b=f7H9iuglsvMM0b0mJ1W53sO00MvVxFzwLRltCwyISk+1Vk60nXGxNc0kDYYv1g0qjD
         Jz15ChLbasPvJEZ9YxPYtSi6/bZDSzi8Oim1Ah0fxhTZYmWpY6YWSd+f82U7wW+esVpr
         XSlqPMiorvk6YXK6n2O7RjqbVH4xmTJPBh3RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=x3D73fEahJ1vsor3fu6c0GZk1cx40QnYDrmVJwVsaoE=;
        b=UpzYjGCm/zPLc2UQSPvLO5U6crpxfnOyfFG4sWfw3WfYmNgG1pzYilrvrR6QW/hehB
         br4hX28HdRKaM13s6l6sUYwzHQpPXENDl7N01hp0HG8basvgpkEPxquyLRW3/g6kunkp
         Yg5AuUNp9bSaLZRiJ451FgeJw2ngzlNhH+3fQGR1kq9yAmLmhcoQIPykKEjzxiq6G7Wo
         1xa/vrOGHbvXgUtrojnrt7v2D0GvBV8iw0dI+Fimix57pwgn76Sf3SwjQ3/ibwL/MP7O
         qK5xgBd29eA9bmri7q3mzKmvShlyg0gpOpGMpZbyPRla+oQxy70GWvsJIhgg8ROddYjf
         Ldvg==
X-Gm-Message-State: ACgBeo0zSBWKudgGFTus3Jwmst18Sbe7xH6hW/FtVNGFOkKCgHIHRl+Y
        uab3+6gSanVOn3EuI5yyw6IWhwD8lIUuRHO5jY0L
X-Google-Smtp-Source: AA6agR6HedAotImtAxAzysgY5GyUVDtrqtvdm3/Yl1uAf/Xo1QtDltOee4pG43CEzGd2+fxHfATzZxFMRHbjlGQF3HA=
X-Received: by 2002:a6b:cf09:0:b0:68b:8602:e487 with SMTP id
 o9-20020a6bcf09000000b0068b8602e487mr7052597ioa.127.1662764781284; Fri, 09
 Sep 2022 16:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220906102154.32526-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <67f0651e-3c6e-5ff6-0913-6b193b581764@microchip.com>
In-Reply-To: <67f0651e-3c6e-5ff6-0913-6b193b581764@microchip.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Fri, 9 Sep 2022 16:06:10 -0700
Message-ID: <CAOnJCUKU8dpuDo2a8z-Xm6Hop9-=CcWwBgnBLpGT=LeSSOM_Wg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] AX45MP: Add support to non-coherent DMA
To:     Conor.Dooley@microchip.com
Cc:     prabhakar.mahadev-lad.rj@bp.renesas.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, atishp@rivosinc.com,
        apatel@ventanamicro.com, geert+renesas@glider.be,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, prabhakar.csengg@gmail.com,
        biju.das.jz@bp.renesas.com, heiko@sntech.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 2:45 PM <Conor.Dooley@microchip.com> wrote:
>
> Hey,
>
> I had a quick run through this today so if there's discussion
> about this next week I at least will have some idea of what I
> am talking about...
>
> (I ended up not doing a quick run...)
>
> On 06/09/2022 11:21, Lad Prabhakar wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >
> > Hi All,
> >
> > On the Andes AX45MP core, cache coherency is a specification option so =
it
> > may not be supported. In this case DMA will fail. To get around with th=
is
> > issue this patch series  does the below:
>
> You say "may not be supported" - is it or is it not supported by the
> core on your SoC? Do some of the cheaper SKUs not support it?
>
> From what Biju has said, you need non-coherent DMA for your eMMC, USB
> and ethernet controllers to work? To me, that seems like something that
> would be quite important to point out here..
>
>
> > Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > block that allows dynamic adjustment of memory attributes in the runtim=
e.
> > It contains a configurable amount of PMA entries implemented as CSR
> > registers to control the attributes of memory locations in interest. PM=
A
> > regions are passed from the cpu core node which are configured as
> > non-cacheable and non-bufferable with the SBI call.
> >
> >         ax45mp: cpu@0 {
> >                 compatible =3D "andestech,ax45mp", "riscv";
> >                 device_type =3D "cpu";
> >                 ....
> >                 pma-regions =3D <0x0 0x00000000 0x0 0x14000000>,
> >                               <0x0 0x20000000 0x0 0x10000000>,
> >                               <0x0 0x58000000 0x0 0x08000000>;
> >                 ....
> >         };
> >
> > We provide callbacks to synchronize specific content between memory and
> > cache. We allocate a global DMA coherent pool (which is marked as
> > non-cached using PMA) so that DMA memory allocations happens from this
> > pool and we implement the below callbacks:
> >
> > - arch_sync_dma_for_device()
> > - arch_sync_dma_for_cpu()
>
> These two already exist in arch/riscv/mm/dma-noncoherent.c using the
> alternatives mechanism.
>
> > - arch_dma_alloc()
> > - arch_dma_free()
> >
> > Below are the configs that are enabled:
> >
> > - DMA_GLOBAL_POOL
> > - ARCH_HAS_SYNC_DMA_FOR_CPU
> > - ARCH_HAS_SYNC_DMA_FOR_DEVICE
>
> For these two see:
> arch/riscv/Kconfig & RISCV_DMA_NONCOHERENT
>
> >
> >         l2cache: cache-controller@13400000 {
> >                 compatible =3D "andestech,ax45mp-cache", "cache";
> >                 cache-size =3D <0x40000>;
> >                 cache-line-size =3D <64>;
> >                 cache-sets =3D <1024>;
> >                 cache-unified;
> >                 reg =3D <0x0 0x13400000 0x0 0x100000>;
> >         };
> >
> > Due to the above approach custom SBI calls have been implemented. The
> > above implementation is in preparation for adding support for Renesas
> > RZ/Five SoC which uses the AX45MP core. As with the above approach the
> > kernel image might not be generic so that it can be used on other
> > platforms, so sending it as an RFC (without DT binding patches).
> >
> > OpenSBI implementation isn't upstreamed yet, public repo for access is
> > available at [0].
>
> When you say "isn't upstreamed yet", what is the actual status? Where in
> the process are you or have you not started that yet? Does openSBI even
> allow custom extensions to be upstreamed?
>
> >
> > [0] https://github.com/renesas-rz/rz_opensbi/tree/work/OpenSBI-PMA
> >
> > Cheers,
> > Prabhakar
> >
> > Lad Prabhakar (2):
> >   riscv: vendors: andes: Add support to configure the PMA regions
> >   riscv: vendors: andes: Add support for non-cohernet dma
> >
>
> Anyway, a couple of drive-by comments, having made the wild assumption
> that this can be accepted upstream.
>
> >  arch/riscv/Kbuild                             |   2 +
> >  arch/riscv/include/asm/sbi.h                  |   1 +
> >  arch/riscv/vendors/Makefile                   |   3 +
> >  arch/riscv/vendors/andes/Makefile             |   4 +
> >  arch/riscv/vendors/andes/ax45mp_cache.c       | 296 ++++++++++++++++++
>
> Surely this should be in drivers/soc/andestech, just like the SiFive L2
> controller is in drivers/soc/sifive rather in a subdirectory of the
> arch?
>
> >  arch/riscv/vendors/andes/ax45mp_nocache_dma.c |  65 ++++
>
> This looks like it should be implemented as errata/alternatives just
> like the non-coherent stuff on the D1 is done.
>
> >  arch/riscv/vendors/andes/include/proc.h       |   9 +
>
> And I think this would fall away if implemented as errata/alternatives.
>
> >  arch/riscv/vendors/andes/include/sbi.h        |  27 ++
> >  arch/riscv/vendors/andes/ax45mp.c             |  93 ++++++
>
> idk where this would go though, if it is even something that is
> acceptable, given the policy I linked the other day from:
> https://www.kernel.org/doc/html/latest/riscv/patch-acceptance.html#submit=
-checklist-addendum
>
> There is SiFive specific errata but it is implemented using mimpid etc
> rather than compatible/dt. As I said in my initial mails, I am quite
> interested in vendor SBI extensions in the kernel. If you did check out
> the link I sent, our stuff is a world away from yours - it's isolated to
> a driver where we are using SBI ECALLs to communicate with other harts
> which are running something other than Linux in AMP configurations.
> Pretty much we can do everything we want to do without touching a
> single line of code in arch/riscv, so although the statement in that doc
> applies to both of us here it does not apply evenly :s
>
> It's all a bit unclear to me what the story is here, because obviously
> you are doing things that Zicbo* is meant to do (just like the D1), but
> your hardware's design and initial tapeout predates the existance of
> Zicbom. Makes me start to wonder, what happens for <insert idea> that
> eventually becomes an extension? Where does the line get draw for "you
> did something that is not a ratified extension, therefore you are not
> permitted upstream"? A line obviously does have to be drawn *somewhere*
> and the easiest place to draw that line is "non ratified extensions are
> a no-go". But then again, why allow the D1 but not you?
>
> Obviously this is not a runner for someone not using an FPGA or similar,
> but the InterHart Communication IP that we are using the SBI ECALLs for
> is a fabric core, so we (in theory) could re-write it so that instead of
> using an ECALL which routes communication via the e51 "monitor" core we
> _could_ write directly to the registers of the IHC block. There's clear
> security/isolation benefits for doing things via an ECALL which is why
> that method was chosen but if we opened for the direct writes/reads the
> driver would be upstream acceptable...
>
> Don't get me wrong, I completely understand why a policy of not allowing
> extensions that have not been ratified makes sense - *but* at the same
> time if touching arch code is not required it does not feel very much
> different to me than adding a driver for a fabric core in the first
> place. I mentioned this sort of thing a while back on IRC and Jess made
> the point that similar sorts of things are done by some of the Qualcomm
> for their remoteproc as we would be doing for ours with the IHC. In your
> case, if all of your ECALLs are in drivers/soc - the maintainership
> burden for any churn would be on you/Geert etc rather than on the RISC-V
> maintainer.
>
> TL;DR of that is maybe a more nuanced policy of "no non-ratified
> extensions that touch arch/riscv" could be a possibility but I would
> completely understand if a "what's sauce for the goose is sauce for the
> gander" approach was taken here and a blanket ban remains in place.
>
> As I have said a bunch of times, this is all just my 2 cents etc and I
> am as much of a punter here as you are... but maybe since I am in the
> same sort of boat I at least have a fleshed out opinion. =C2=AF\_()_/=C2=
=AF
>
> Hopefully either Palmer can weigh in here or we do get a BoF & the
> chance to have a chat about this sort of thing & maybe have a more
> nuanced policy - or at the very least something that makes it clearer
> that vendor extensions are a complete no-go upstream.
>

RISC-V BoF is scheduled on Wednesday.

https://lpc.events/event/16/contributions/1389/

> Conor.
>
> >  9 files changed, 500 insertions(+)
> >  create mode 100644 arch/riscv/vendors/Makefile
> >  create mode 100644 arch/riscv/vendors/andes/Makefile
> >  create mode 100644 arch/riscv/vendors/andes/ax45mp.c
> >  create mode 100644 arch/riscv/vendors/andes/ax45mp_cache.c
> >  create mode 100644 arch/riscv/vendors/andes/ax45mp_nocache_dma.c
> >  create mode 100644 arch/riscv/vendors/andes/include/proc.h
> >  create mode 100644 arch/riscv/vendors/andes/include/sbi.h
> >
> > --
> > 2.25.1
> >
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



--=20
Regards,
Atish
