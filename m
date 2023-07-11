Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F027E74EC02
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 12:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjGKKwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 06:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjGKKwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 06:52:09 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52231E49
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:52:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc59de0e2so57292045e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 03:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689072727; x=1691664727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1PdMizM80C3ZI8rblEgvVMyPGq6EddPu4QPQ4ja35g=;
        b=u9OCUAqgxqoO71TrPr/ab1c4ktAGG42chSTWX2bXgly1ZqQ/DoLJJOb0dbXh5LNU8J
         xKcUNyD/dtZSeBcrGlbbqwzhuLkF2c5KyuzsHNO4+8G360nMrm1GQxKkDTV9ue3i/Jzn
         mahw/QKd1GGTyhH7ODvCCeAY33VViShF+8OSosFGxgXfFwM/JJzSQAgxXDgIm8Br0jHK
         imvUDI7c5Z/oXy/vt5ElX8pB3R0vi/r9NIcPJPJJCgupZI+BkPU67nFWHNUjUXW6r+PF
         5p4GSNOjp26G+4MHblcj+eVAdN8OuA06uNf9DfAIhxss3ZoF3i1EgDWktFrqaMI2vTCN
         +rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689072727; x=1691664727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1PdMizM80C3ZI8rblEgvVMyPGq6EddPu4QPQ4ja35g=;
        b=NtF/hG5/CZfknl6BXTKxcMS4oZIWS+Q1y3oLrKzXM8pEKJOfmLynOLzL2vXb7PGxE4
         kPmnriSA/QPCRLhNe9J/ROw0lj9J+MXYU9JOuEcvgsHvCnd0gbNOt5VcnBEIcTWWO2gf
         htcI41p4euBevSQbgVnZzRuUawddAoYww0NXcVFuk+KzV7VfhlW43GXHIuDjEdcyATpS
         uioM9r0GzSsDZPukITI8zyGO9OtCgNKR2jD9os8jqygJcBfmjnR7CIxtNjD5CyXFTSv0
         odBe7qA2w3qtwkzpxYyZw7TjKMqFab3Zj1hvUPiJZ0MemcDMLYqT2CfOXlnxjdfqm9QB
         eD0A==
X-Gm-Message-State: ABy/qLaAQ7uxwOYkWUsSNyvCpFLfaZAlnDHnHm2HuIHQiqtRfQaf+fak
        lO8o4++Ym4ysmqfNP7wlksBVmXewkI1uYAtJCUuCAg==
X-Google-Smtp-Source: APBJJlGpdVefawHmCXphduQKsmic0iBz7dS012j6apOKODRTQOukmx93N03K5S1INpevsq04JQqhq9PJyPHkvzwBelg=
X-Received: by 2002:a5d:684c:0:b0:314:4915:689 with SMTP id
 o12-20020a5d684c000000b0031449150689mr15212682wrw.34.1689072726749; Tue, 11
 Jul 2023 03:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230704121837.248976-1-alexghiti@rivosinc.com> <mhng-c5a71036-061e-4704-bcdf-2b23cab36908@palmer-ri-x1c9a>
In-Reply-To: <mhng-c5a71036-061e-4704-bcdf-2b23cab36908@palmer-ri-x1c9a>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 11 Jul 2023 12:51:56 +0200
Message-ID: <CAHVXubiU7XUSDmJ1YuUX85kLtMO=Y00fYYHuepc2=d3oG8Aq4g@mail.gmail.com>
Subject: Re: [PATCH] riscv: Start of DRAM should at least be aligned on PMD
 size for the direct mapping
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        suagrfillet@gmail.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry for the delay!)

On Thu, Jul 6, 2023 at 7:05=E2=80=AFPM Palmer Dabbelt <palmer@dabbelt.com> =
wrote:
>
> On Tue, 04 Jul 2023 05:18:37 PDT (-0700), alexghiti@rivosinc.com wrote:
> > So that we do not end up mapping the whole linear mapping using 4K
> > pages, which is slow at boot time, and also very likely at runtime.
> >
> > So make sure we align the start of DRAM on a PMD boundary.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/mm/init.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 4fa420faa780..4a43ec275c6d 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -214,8 +214,13 @@ static void __init setup_bootmem(void)
> >       memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
> >
> >       phys_ram_end =3D memblock_end_of_DRAM();
> > +
> > +     /*
> > +      * Make sure we align the start of the memory on a PMD boundary s=
o that
> > +      * at worst, we map the linear mapping with PMD mappings.
> > +      */
> >       if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> > -             phys_ram_base =3D memblock_start_of_DRAM();
> > +             phys_ram_base =3D memblock_start_of_DRAM() & PMD_MASK;
>
> This rounds down, which IIUC will result in mappings outside what
> memblock detected as the start af DRAM.  I'd expect that to cause bad
> behavior somewhere.

Actually we are not mapping this new region as it is not present in
the memblock regions, we are just re-aligning the virtual and physical
address: phys_ram_base is only used for the virtual to physical
translations.

>
> Shouldn't we be rounding up?

Doing so would remove memory from the memory map, but I'm not sure
this is correct, we could remove memory that contains "something" that
needs to be accessed using the linear mapping (ACPI tables? DT?).

More testing is welcome as I can be wrong of course.

Thanks,

Alex


>
> >
> >       /*
> >        * In 64-bit, any use of __va/__pa before this point is wrong as =
we
