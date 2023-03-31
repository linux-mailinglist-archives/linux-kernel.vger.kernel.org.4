Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2777D6D189B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCaHba convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 03:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCaHb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:31:27 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B0CB44E;
        Fri, 31 Mar 2023 00:31:26 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-536af432ee5so400839157b3.0;
        Fri, 31 Mar 2023 00:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680247885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUd21DqN56tUJJauxzkykeUBegNuegGhlGwWCjC09Bs=;
        b=XUsOuEyYJ4pdt/iyo2h3i4Vk9Ewxll9E+PmZPbwSKJxXFh/enZObs4zaeqvYZyqtvB
         Y271wzwBiLPA53lLUue8cLKora/KZE4EhF3oi6KOhbihln/CoHjCUxpBguNYUM6fIWlB
         E5KNFClAX7W8M5GBtLepyY7x+FKRE4kJZHfmXFr2Cet0+oHgkSNgfkgBjyutbsiMwPz7
         JLIq6FaS/lCiKUsxxrB4nhqG1P76+VF5M7tXYrfMFkUpsTS4EmvVvwP46hymSMLgv+0H
         +oWP+wsAzmj4EUu1z//6lIOUVyBzCSZpgv1Ow4ypQlR4o05YtsiRlrvJ7GL9JUabZ1Vm
         EwKw==
X-Gm-Message-State: AAQBX9cXBjLl40lvBD331JGUfSIXnUd4d0/sFS/4mze9l0KrXccQM7v+
        5mNOCtOFKFXizga6StzSOv8/mhmqQITM2CSM
X-Google-Smtp-Source: AKy350Y9tjv6c27rnNvCUslBs8mc1G4k6/FF9mARBwAX5wjTJk/yrBTxteLNouqngBMwIJW2pXyYwA==
X-Received: by 2002:a0d:d6d1:0:b0:53c:8a40:330f with SMTP id y200-20020a0dd6d1000000b0053c8a40330fmr27236603ywd.22.1680247885503;
        Fri, 31 Mar 2023 00:31:25 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id 188-20020a8114c5000000b00545a081848esm377380ywu.30.2023.03.31.00.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 00:31:25 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-545cb3c9898so324939957b3.7;
        Fri, 31 Mar 2023 00:31:25 -0700 (PDT)
X-Received: by 2002:a81:b65f:0:b0:545:611c:8d19 with SMTP id
 h31-20020a81b65f000000b00545611c8d19mr13248405ywk.4.1680247884888; Fri, 31
 Mar 2023 00:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230330204217.47666-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230330204217.47666-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 31 Mar 2023 09:31:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVseMfkQw5OnTM4CxW9BUCZ0pVZP6px67h8VPah0x3QAA@mail.gmail.com>
Message-ID: <CAMuHMdVseMfkQw5OnTM4CxW9BUCZ0pVZP6px67h8VPah0x3QAA@mail.gmail.com>
Subject: Re: [PATCH v7 1/6] riscv: mm: dma-noncoherent: Switch using function
 pointers for cache management
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Heiko Stuebner <heiko@sntech.de>, Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thanks for your patch!

On Thu, Mar 30, 2023 at 10:42 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Currently, selecting which CMOs to use on a given platform is done using
> and ALTERNATIVE_X() macro. This was manageable when there were just two

the ALTERNATIVE_X()

> CMO implementations, but now that there are more and more platforms coming
> needing custom CMOs, the use of the ALTERNATIVE_X() macro is unmanageable.
>
> To avoid such issues this patch switches to use of function pointers

"the use" or "using"

> instead of ALTERNATIVE_X() macro for cache management (the only drawback

the ALTERNATIVE_X()

> being performance over the previous approach).
>
> void (*clean_range)(unsigned long addr, unsigned long size);
> void (*inv_range)(unsigned long addr, unsigned long size);
> void (*flush_range)(unsigned long addr, unsigned long size);
>
> The above function pointers are provided to be overridden for platforms
> needing CMO.
>
> Convert ZICBOM and T-HEAD CMO to use function pointers.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c

> +#ifdef CONFIG_ERRATA_THEAD_CMO

> +static void thead_register_cmo_ops(void)
> +{
> +       riscv_noncoherent_register_cache_ops(&thead_cmo_ops);
> +}
> +#else
> +static void thead_register_cmo_ops(void) {}
> +#endif

> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c

> @@ -75,3 +83,12 @@ void riscv_noncoherent_supported(void)
>              "Non-coherent DMA support enabled without a block size\n");
>         noncoherent_supported = true;
>  }
> +
> +void riscv_noncoherent_register_cache_ops(const struct riscv_cache_ops *ops)
> +{
> +       if (!ops)
> +               return;

This is never true.
I guess originally you wanted to call riscv_noncoherent_register_cache_ops()
unconditionally from common code, instead of the various *register_cmo_ops()?
But that would have required something like

#ifdef CONFIG_ERRATA_THEAD_CMO
#define THEAD_CMO_OPS_PTR   (&thead_cmo_ops)
#else
#define THEAD_CMO_OPS_PTR   NULL
#endif

Or can we come up with some macro like pm_ptr(), but that also takes
care of the "&", so we can do "#define thead_cmo_ops NULL"?

> +
> +       noncoherent_cache_ops = *ops;
> +}
> +EXPORT_SYMBOL_GPL(riscv_noncoherent_register_cache_ops);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
