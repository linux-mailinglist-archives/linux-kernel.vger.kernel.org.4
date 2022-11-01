Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB99614AFC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 13:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiKAMnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 08:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiKAMm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 08:42:57 -0400
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9623C1A398;
        Tue,  1 Nov 2022 05:42:56 -0700 (PDT)
Received: by mail-qt1-f174.google.com with SMTP id hh9so9142449qtb.13;
        Tue, 01 Nov 2022 05:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0fFJpKnrZNPTgCViuBGtje3WfufZWacdfGu7IT0h8cY=;
        b=QLWyR2z3MS8d2bamFI+FDzz8WikKf9JjHnmbplmBjsYhVfTACCN7oGbWeoCMhQZOO+
         NqJKZyIZv6+/DmhA40Ad2OfC040CeB4p1I7xJ2LBESG81NSH+bv0Cpjt2VY6hil/JNxa
         58l+AEhRcmASg9ws85FFEHBQorBQhS3eoNXOUz7OOphBWPckXENSf7CP/bHAuZUtQIPX
         DMs6kUj348mW3/2xjLDviF04tidGK9rctxos4AlJl57HHCAorm61H+IH/PP03K1BL7wT
         dwVWdwofF77Fks+5ymd8VOBrZBL1ViVm1l8g707U7tjU6OHDEHz9WOAZBgk/xRBosWDg
         X/tg==
X-Gm-Message-State: ACrzQf1++sc1OqNAk71sBVM/cKIQVIkvvVxWtHpZsTeYNsZOpBv6cGPA
        CXsNOcCpie+Qf1SQnG5g3mzpCllUCpt3Ug==
X-Google-Smtp-Source: AMsMyM5XKcP9JQPJZgXdDBthbcPqneE/y5YqbK4TUztjqj3abTFqaR0nVd+I/au+F6PiwJK9k/iByQ==
X-Received: by 2002:a05:622a:100f:b0:39c:f1b9:6104 with SMTP id d15-20020a05622a100f00b0039cf1b96104mr14671681qte.500.1667306575345;
        Tue, 01 Nov 2022 05:42:55 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id h4-20020a05620a284400b006b615cd8c13sm6408064qkp.106.2022.11.01.05.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 05:42:54 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id y72so17132184yby.13;
        Tue, 01 Nov 2022 05:42:53 -0700 (PDT)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr4839144ybc.89.1667306573183; Tue, 01 Nov
 2022 05:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221019220242.4746-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221019220242.4746-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Nov 2022 13:42:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXqh=wQaTYTuQ8vq__=2jvqRx1i9fpQsVPKpBJrBOy1Hw@mail.gmail.com>
Message-ID: <CAMuHMdXqh=wQaTYTuQ8vq__=2jvqRx1i9fpQsVPKpBJrBOy1Hw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.co>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Thu, Oct 20, 2022 at 12:02 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> On the AX45MP core, cache coherency is a specification option so it may
> not be supported. In this case DMA will fail. As a workaround, firstly we
> allocate a global dma coherent pool from which DMA allocations are taken
> and marked as non-cacheable + bufferable using the PMA region as specified
> in the device tree. Synchronization callbacks are implemented to
> synchronize when doing DMA transactions.
>
> The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> block that allows dynamic adjustment of memory attributes in the runtime.
> It contains a configurable amount of PMA entries implemented as CSR
> registers to control the attributes of memory locations in interest.
>
> Below are the memory attributes supported:
> * Device, Non-bufferable
> * Device, bufferable
> * Memory, Non-cacheable, Non-bufferable
> * Memory, Non-cacheable, Bufferable
> * Memory, Write-back, No-allocate
> * Memory, Write-back, Read-allocate
> * Memory, Write-back, Write-allocate
> * Memory, Write-back, Read and Write-allocate
>
> This patch adds support to configure the memory attributes of the memory
> regions as passed from the l2 cache node and exposes the cache management
> ops.
>
> More info about PMA (section 10.3):
> http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
>
> This feature is based on the work posted [0] by Vincent Chen
> <vincentc@andestech.com> for the Andes AndeStart RISC-V CPU.
>
> [0] https://lore.kernel.org/lkml/1540982130-28248-1-git-send-email-vincentc@andestech.com/
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -24,13 +24,25 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
>
>         switch (dir) {
>         case DMA_TO_DEVICE:
> +#ifdef CONFIG_ERRATA_THEAD_CMO
>                 ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
> +#elif CONFIG_AX45MP_L2_CACHE

"#elif defined(CONFIG_AX45MP_L2_CACHE)" (everywhere)

Else it may fail with:

    error: "CONFIG_AX45MP_L2_CACHE" is not defined, evaluates to 0
[-Werror=undef]


> +               ALT_CMO_OP(ax45mp_cpu_dma_wb_range, vaddr, size, 0x0);
> +#endif

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
