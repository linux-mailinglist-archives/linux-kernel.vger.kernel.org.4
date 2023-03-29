Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819116CEBEF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjC2OnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjC2Om7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:42:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAD772A4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:40:30 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso11612323wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 07:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1680100829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y3ixFB+QbvxNuTUQ+9uGUyxwBpcWsdgUOQuT9hmx8Eo=;
        b=ZzeMNASizro0DCX9uwISypPThwqsFl+cZwUJb8YUGxhfjqQ8/SxCcOk4qmwsNlo7M0
         Qz1+Y8FmONI+a4poP0M1zVB2a/cEzzF7AtV1P5lvNYmDErZSNxXnqTcaA8GhSzfcVihx
         58mjP5NpqgHxxd64VKl2DGbMalfctzr89HlxdyTxyq/1sEGjBmnuHkSWh030Dx4VS3yg
         s4vwc5NymraZRVuMhF4zS7TaOHTnhLyDO3zH+FvtLKu65GRLqns/Q3aI4Ot51yb5xa4r
         PmVfoG/WLHCUJS6abadujM0+aaT7LdWwsyVIPuZIIjjEZSYVYurISPrR4rt0nP3J77zc
         TDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680100829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3ixFB+QbvxNuTUQ+9uGUyxwBpcWsdgUOQuT9hmx8Eo=;
        b=JYQoD/p42oPihDTeC+AZvVHGICJrsz4ZS+BcgTGLe+BqOmaKWYWHwXv2nnfHH3peml
         Vcuic4760yw+PKoNnJukveJDX7mjMK/0mpyuysq1wPZ2O29uX8fAPm1b34rv45scaeJ1
         YDpKF2/L4Egpz5cGGlRsDshjhErFmUD1VScSQQS17OEu+RXD+0lZqI0cd+wQcBoq91MX
         kfrmA4dc9IuYHwKhioWq7nVTzQnlTrTh0/uUaYPNCC53PzamZlxc1InLyRQXSMcZt8NJ
         77SZ+kA1Bl8TV/mEFUqzrJ1dJ+/y8wFKhwE/q/734s3nVMpWZmPoDiobLtJihObk6IMR
         RwKg==
X-Gm-Message-State: AO0yUKXJhujDLJLCzRExTtzwb4IInrQuoJJUN4Rt6JiTFrFhSo0caCkH
        s+J6Q0gnU//qTYyGPG+HI3VMFLyq4oGV6u9E9GkZyA==
X-Google-Smtp-Source: AK7set/r5FDsIfVCcTouvt4BuewvjeXCoqh4AN0X/5B2UlHmX8Zjsb8G5Xepj+i2tfuaC8Pr0yg3CQAFxmFa2VYAUTc=
X-Received: by 2002:a1c:7714:0:b0:3ee:3e07:5d35 with SMTP id
 t20-20020a1c7714000000b003ee3e075d35mr4552357wmi.3.1680100828896; Wed, 29 Mar
 2023 07:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230329081932.79831-1-alexghiti@rivosinc.com>
 <20230329081932.79831-4-alexghiti@rivosinc.com> <381c2753-cbcc-40a0-bcb2-67d18e367822@spud>
In-Reply-To: <381c2753-cbcc-40a0-bcb2-67d18e367822@spud>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Wed, 29 Mar 2023 16:40:18 +0200
Message-ID: <CAHVXubhVGR1vjqFVv1vuDGDMSiG0JBpKtRZnzgzpa9VBK+BuNw@mail.gmail.com>
Subject: Re: [PATCH -fixes v2 3/3] riscv: No need to relocate the dtb as it
 lies in the fixmap region
To:     Conor Dooley <conor@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 3:56=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, Mar 29, 2023 at 10:19:32AM +0200, Alexandre Ghiti wrote:
> > We used to access the dtb via its linear mapping address but now that t=
he
> > dtb early mapping was moved in the fixmap region, we can keep using thi=
s
> > address since it is present in swapper_pg_dir, and remove the dtb
> > relocation.
> >
> > Note that the relocation was wrong anyway since early_memremap() is
> > restricted to 256K whereas the maximum fdt size is 2MB.
>
> So, should this be marked as a fix, and backported along with 1/3?

Hmmm the whole series should be backported, it does not make sense to
move the dtb mapping and keep accessing it using its linear mapping
address since it could fail for the exact reason the relocation was
implemented in the first place and the relocation is wrong.

Maybe we should simply add a "Cc: stable@vger.kernel.org" on all the patche=
s?

> Either way,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
>
> And from v1 (although I didn't actually send it for idk what reason):
> Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks!

>
> Thanks,
> Conor.
>
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/mm/init.c | 21 ++-------------------
> >  1 file changed, 2 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index fb78d6bbabae..0f14f4a8d179 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -249,25 +249,8 @@ static void __init setup_bootmem(void)
> >        * early_init_fdt_reserve_self() since __pa() does
> >        * not work for DTB pointers that are fixmap addresses
> >        */
> > -     if (!IS_ENABLED(CONFIG_BUILTIN_DTB)) {
> > -             /*
> > -              * In case the DTB is not located in a memory region we w=
on't
> > -              * be able to locate it later on via the linear mapping a=
nd
> > -              * get a segfault when accessing it via __va(dtb_early_pa=
).
> > -              * To avoid this situation copy DTB to a memory region.
> > -              * Note that memblock_phys_alloc will also reserve DTB re=
gion.
> > -              */
> > -             if (!memblock_is_memory(dtb_early_pa)) {
> > -                     size_t fdt_size =3D fdt_totalsize(dtb_early_va);
> > -                     phys_addr_t new_dtb_early_pa =3D memblock_phys_al=
loc(fdt_size, PAGE_SIZE);
> > -                     void *new_dtb_early_va =3D early_memremap(new_dtb=
_early_pa, fdt_size);
> > -
> > -                     memcpy(new_dtb_early_va, dtb_early_va, fdt_size);
> > -                     early_memunmap(new_dtb_early_va, fdt_size);
> > -                     _dtb_early_pa =3D new_dtb_early_pa;
> > -             } else
> > -                     memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_=
early_va));
> > -     }
> > +     if (!IS_ENABLED(CONFIG_BUILTIN_DTB))
> > +             memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va=
));
> >
> >       dma_contiguous_reserve(dma32_phys_limit);
> >       if (IS_ENABLED(CONFIG_64BIT))
> > --
> > 2.37.2
> >
