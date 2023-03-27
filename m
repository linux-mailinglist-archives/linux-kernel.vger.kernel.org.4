Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34446CA349
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjC0MPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjC0MOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:14:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D74E3C29
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:14:39 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x3so35166889edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112; t=1679919278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zV7l9gwzS8uQDvU8ghGXWk1DwKUvHBE9MrpysU0Lhqw=;
        b=cCLCI0wMW6IRrmquuFwWgV0/AtgncU+z6G0YwRGCKcPihYxqfjtEUP9PZFwIrsmigW
         VtZxXoT3CsK5aVgrLkaFP04/rxndWu5A0D+zj2F/oXxRRqjL/9qL3tUwo4qqjxrboSLC
         hAhmnuNeQTYq5qv17YcKG32fYUexBlRjb1vDJI/bxNPFOIot+Xi95OHKx0W/+W0zm+Js
         UDYjhTCiiuhDCL2kWG2AMsnUOOVd/pgT15aMbQP7fuvK7zWzVONVaNdSmZPmNBYpplzk
         KmoKrfdQVBQg82RyQiyYtLhIZ5C2/y3PhA327LsJxffMNrzKHZlte7+NcO8wTOpj1h3+
         a+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679919278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zV7l9gwzS8uQDvU8ghGXWk1DwKUvHBE9MrpysU0Lhqw=;
        b=M42CZuIryNT2U9GZgJvkqj7Zq8aSOhH37n9SaVX3jsT8AxkyZ17ECZ6JvxtUnMxDd3
         Mi0WWQV+mOdeIMzSX1xiT/pviQeKutN4GfQfYihTxOHMVnbZTApdnaqtExNjdAKOOWsB
         Rn6DNd+LS5lavvc3ue/4AVbOlps/r4cO+4rfd3p2F+zTQAwU/dAayngEu4w+ZCOFcN2Z
         zLpM/vU3p+76QKYYKJ2xuQ7m+LjPW0HTTLr7DaWWcKe71LGK5oS5CXaf6e2pe4xitiQy
         5KfBH4bL3XxZftpCk0B3sIZSS37Oi3UbN6Awx6Vo/nFx2pqIrMGqvgLdVUhz3HZEsWnH
         BvBw==
X-Gm-Message-State: AAQBX9cgpxSl0Aa7hia0p4Pvd0gZS25dSnNEyse1matbjqLfzrsNaMEl
        FmERfxsDYMKkTYerkbc9O71S45r26i4jBud28qGXAA==
X-Google-Smtp-Source: AKy350YoU2vC7aokDmLDWrPj3cpvgmucjwtQQi8VTcpal+Pl/zZwRYz8X50BsBIvSx7RUVyUkJ/fyLGgiTzEnTe0gn0=
X-Received: by 2002:a50:9fef:0:b0:4fc:2096:b15c with SMTP id
 c102-20020a509fef000000b004fc2096b15cmr5975228edf.1.1679919277773; Mon, 27
 Mar 2023 05:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230324155421.271544-1-alexghiti@rivosinc.com> <20230324155421.271544-3-alexghiti@rivosinc.com>
In-Reply-To: <20230324155421.271544-3-alexghiti@rivosinc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 27 Mar 2023 17:44:26 +0530
Message-ID: <CAAhSdy3fMm5gVASMqfs7qMdUp7omZG5tKSeDCxvDA1YALPDiTA@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] riscv: Move the linear mapping creation in its own function
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 9:26=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> No change intended, it just splits the linear mapping creation from
> setup_vm_final: this prepares for upcoming additions to the linear
> mapping creation.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Reviewed-by: Anup Patel <anup@brainfault.org>
Tested-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/riscv/mm/init.c | 42 ++++++++++++++++++++++++++++--------------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index cc558d94559a..3b37d8606920 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -1086,16 +1086,25 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
>         pt_ops_set_fixmap();
>  }
>
> -static void __init setup_vm_final(void)
> +static void __init create_linear_mapping_range(phys_addr_t start,
> +                                              phys_addr_t end)
>  {
> +       phys_addr_t pa;
>         uintptr_t va, map_size;
> -       phys_addr_t pa, start, end;
> -       u64 i;
>
> -       /* Setup swapper PGD for fixmap */
> -       create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
> -                          __pa_symbol(fixmap_pgd_next),
> -                          PGDIR_SIZE, PAGE_TABLE);
> +       for (pa =3D start; pa < end; pa +=3D map_size) {
> +               va =3D (uintptr_t)__va(pa);
> +               map_size =3D best_map_size(pa, end - pa);
> +
> +               create_pgd_mapping(swapper_pg_dir, va, pa, map_size,
> +                                  pgprot_from_va(va));
> +       }
> +}
> +
> +static void __init create_linear_mapping_page_table(void)
> +{
> +       phys_addr_t start, end;
> +       u64 i;
>
>         /* Map all memory banks in the linear mapping */
>         for_each_mem_range(i, &start, &end) {
> @@ -1107,14 +1116,19 @@ static void __init setup_vm_final(void)
>                 if (end >=3D __pa(PAGE_OFFSET) + memory_limit)
>                         end =3D __pa(PAGE_OFFSET) + memory_limit;
>
> -               for (pa =3D start; pa < end; pa +=3D map_size) {
> -                       va =3D (uintptr_t)__va(pa);
> -                       map_size =3D best_map_size(pa, end - pa);
> -
> -                       create_pgd_mapping(swapper_pg_dir, va, pa, map_si=
ze,
> -                                          pgprot_from_va(va));
> -               }
> +               create_linear_mapping_range(start, end);
>         }
> +}
> +
> +static void __init setup_vm_final(void)
> +{
> +       /* Setup swapper PGD for fixmap */
> +       create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
> +                          __pa_symbol(fixmap_pgd_next),
> +                          PGDIR_SIZE, PAGE_TABLE);
> +
> +       /* Map the linear mapping */
> +       create_linear_mapping_page_table();
>
>         /* Map the kernel */
>         if (IS_ENABLED(CONFIG_64BIT))
> --
> 2.37.2
>
