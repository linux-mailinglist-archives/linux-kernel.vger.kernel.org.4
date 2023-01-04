Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A24E65CF7E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 10:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbjADJYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 04:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjADJYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 04:24:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800521DC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 01:24:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 301C7B815C9
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 09:24:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6AD8C4339B
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 09:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672824266;
        bh=GvYqWw4SE9AcM8QrU4Qwt+om53eTrQ5s18qUblcdkWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mPszRvtkBs16pd6Wpj9MpuXjPIr2EmyWwDv6NMH2JPZ84xbQY0GrUEoAZiSWSlm4J
         NxevIKpmCiFK4l5Qe06ZBIarsxvmeG7oReGpXA2amo3i3pRYbD1p5ri6F7tvZ4v38v
         tK58zKlz5/L40f6J9VrgRucGIRTecXzNRDdgfoOGoIxfjdk8nAntphVsFKk73bwfV+
         v6pfMDO4uDq4+GZ7bflnAu0emOKYUlAqfBHyXGCKjU2iu5QpFUxs9iOMJc3jsdOxRN
         CY5alF37K7u+lSpvGlDRqBabvz94w51Y18l5pTdllf+60M98GAp6vdRCCRSeq5R34V
         AfT5rYNHWgSqw==
Received: by mail-ej1-f43.google.com with SMTP id vm8so74216229ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 01:24:26 -0800 (PST)
X-Gm-Message-State: AFqh2kqjI8Cf/T33r32R2Kk6xB7ipPe9vbBXM8CkA8FFKDeegjUaJDfh
        D5S9WU7+tAJqixSb7fXYPXUmGO/DlRYc1mzeMZ8=
X-Google-Smtp-Source: AMrXdXsFW2us9z5yyQvDN4SKkyjvd+/elktZohLGuvFc4Vz2/ctRKDH6MpNv1ejW9uoVH6PY8/KE4gpl5FlETL0waDA=
X-Received: by 2002:a17:907:1de4:b0:7c0:dab0:d722 with SMTP id
 og36-20020a1709071de400b007c0dab0d722mr2522829ejc.353.1672824264944; Wed, 04
 Jan 2023 01:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20230104074146.578485-1-uwu@icenowy.me> <20230104074146.578485-3-uwu@icenowy.me>
 <CAJF2gTSb4qEPHw8hy1ro+UMoyKQaoQESNGveSGLdPL=cXac8jQ@mail.gmail.com> <a2a8c7522b9b57f074d6962511b6d779cfd4b56b.camel@icenowy.me>
In-Reply-To: <a2a8c7522b9b57f074d6962511b6d779cfd4b56b.camel@icenowy.me>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 4 Jan 2023 17:24:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTO3jx8FqMVRmfgkjO02sCVx2SVbe-Sn1uKXojyn8RDaA@mail.gmail.com>
Message-ID: <CAJF2gTTO3jx8FqMVRmfgkjO02sCVx2SVbe-Sn1uKXojyn8RDaA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] riscv: use VA+PA variant of CMO macros for DMA synchorization
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Wed, Jan 4, 2023 at 4:59 PM Icenowy Zheng <uwu@icenowy.me> wrote:
>
> =E5=9C=A8 2023-01-04=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 16:50 +0800=EF=
=BC=8CGuo Ren=E5=86=99=E9=81=93=EF=BC=9A
> > On Wed, Jan 4, 2023 at 3:43 PM Icenowy Zheng <uwu@icenowy.me> wrote:
> > >
> > > DMA synchorization is done on PA and the VA is calculated from the
> > > PA.
> > >
> > > Use the alternative macro variant that takes both VA and PA as
> > > parameters, thus in case the ISA extension used support PA
> > > directly, the
> > > overhead for re-converting VA to PA can be omitted.
> > >
> > > Suggested-by: Guo Ren <guoren@kernel.org>
> > > Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> > > ---
> > >  arch/riscv/mm/dma-noncoherent.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-
> > > noncoherent.c
> > > index d919efab6eba..a751f4aece62 100644
> > > --- a/arch/riscv/mm/dma-noncoherent.c
> > > +++ b/arch/riscv/mm/dma-noncoherent.c
> > > @@ -19,13 +19,13 @@ void arch_sync_dma_for_device(phys_addr_t
> > > paddr, size_t size,
> > >
> > >         switch (dir) {
> > >         case DMA_TO_DEVICE:
> > > -               ALT_CMO_OP(clean, vaddr, size,
> > > riscv_cbom_block_size);
> > > +               ALT_CMO_OP_VPA(clean, vaddr, paddr, size,
> > > riscv_cbom_block_size);
> > ALT_CMO_OP -> ALT_CMO_OP_VPA, is the renaming necessary?
>
> I didn't rename the original ALT_CMO_OP, ALT_CMO_OP_VPA is something
> new.
The ##_VPA is really strange.

How about:
ALT_CMO_OP          -> ALT_CMO_OP_VA
ALT_CMO_OP_VPA -> ALT_CMO_OP

>
> >
> > Others:
> > Reviewed-by: Guo Ren <guoren@kernel.org>
> >
> > >                 break;
> > >         case DMA_FROM_DEVICE:
> > > -               ALT_CMO_OP(clean, vaddr, size,
> > > riscv_cbom_block_size);
> > > +               ALT_CMO_OP_VPA(clean, vaddr, paddr, size,
> > > riscv_cbom_block_size);
> > >                 break;
> > >         case DMA_BIDIRECTIONAL:
> > > -               ALT_CMO_OP(flush, vaddr, size,
> > > riscv_cbom_block_size);
> > > +               ALT_CMO_OP_VPA(flush, vaddr, paddr, size,
> > > riscv_cbom_block_size);
> > >                 break;
> > >         default:
> > >                 break;
> > > @@ -42,7 +42,7 @@ void arch_sync_dma_for_cpu(phys_addr_t paddr,
> > > size_t size,
> > >                 break;
> > >         case DMA_FROM_DEVICE:
> > >         case DMA_BIDIRECTIONAL:
> > > -               ALT_CMO_OP(flush, vaddr, size,
> > > riscv_cbom_block_size);
> > > +               ALT_CMO_OP_VPA(flush, vaddr, paddr, size,
> > > riscv_cbom_block_size);
> > >                 break;
> > >         default:
> > >                 break;
> > > --
> > > 2.38.1
> > >
> >
> >
>


--=20
Best Regards
 Guo Ren
