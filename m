Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F879614BE2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiKANi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiKANi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:38:26 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5D82BF;
        Tue,  1 Nov 2022 06:38:23 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id l9so9496640qkk.11;
        Tue, 01 Nov 2022 06:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+9k3LzVJhLHOoT31IHmRkr9T7Wq3FpXbHH08Qx0zJI=;
        b=hW3kqn5frCNP7gxKzAdzOtsJ9VgAwsuQTKx2Nz0m9VKva4jfVyoeKzcmCZzObepQUz
         X5koGoueEDyIwKUZUA7Ctyq2GOCqLrC3X2OHm1vFokePLGJk3qLAQZrdw0OQFqkt5uxA
         XeTicxUoyT/wYCydeOeKCkMAs5xGl/bJ68XjfxOokviuvWYNRjIJd1DPYlbwSlxI+3uM
         kWhIdbp/yHwoxYDCh+GKq6LMOUmuvra4zN/9JxBuUZXHYHtgxNWYovvncx4Uo6+QfSf9
         A/jKIn4na+pNnkzqY/AJCMI7WEvk+ELuOKvWW9NQjqZuu1QP9IAm80gL6r8+HWb5d7oN
         pDDQ==
X-Gm-Message-State: ACrzQf3k+UnZpEyb1VLvIiDhbno6Nu6Qz9HQsii4pAryw/wLuHkhZOdY
        KnVI3d6v5BZExflWbzsPQJ6M2KhQR4+zKQ==
X-Google-Smtp-Source: AMsMyM4fh7FUZrSTZ5WqarmfnQ/A6fUHwt0ZLP66ReAW4fmQ5Ggh2zPKG3E4WFIrckuwFHgIDoO2uA==
X-Received: by 2002:a05:620a:1438:b0:6fa:2196:20fd with SMTP id k24-20020a05620a143800b006fa219620fdmr9671701qkj.78.1667309901708;
        Tue, 01 Nov 2022 06:38:21 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id w128-20020a379486000000b006ce76811a07sm6511365qkd.75.2022.11.01.06.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 06:38:20 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-3321c2a8d4cso136323477b3.5;
        Tue, 01 Nov 2022 06:38:20 -0700 (PDT)
X-Received: by 2002:a81:12c8:0:b0:36a:bd6b:92fb with SMTP id
 191-20020a8112c8000000b0036abd6b92fbmr17487708yws.316.1667309900285; Tue, 01
 Nov 2022 06:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20221019220242.4746-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20221019220242.4746-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Nov 2022 14:38:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU6+qNQh2vFic89cnqDmUoyhrJTROCHPdoPguXAEnZMfA@mail.gmail.com>
Message-ID: <CAMuHMdU6+qNQh2vFic89cnqDmUoyhrJTROCHPdoPguXAEnZMfA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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

> --- a/arch/riscv/include/asm/errata_list.h
> +++ b/arch/riscv/include/asm/errata_list.h
> @@ -89,6 +89,7 @@ asm volatile(ALTERNATIVE(                                             \
>  #define ALT_THEAD_PMA(_val)
>  #endif
>
> +#ifdef CONFIG_ERRATA_THEAD_CMO
>  /*
>   * dcache.ipa rs1 (invalidate, physical address)
>   * | 31 - 25 | 24 - 20 | 19 - 15 | 14 - 12 | 11 - 7 | 6 - 0 |
> @@ -143,5 +144,6 @@ asm volatile(ALTERNATIVE_2(                                         \
>         : "a0")
>
>  #endif /* __ASSEMBLY__ */
> +#endif

FTR, the new #endif should be above the old #endif.

I noticed because after rebasing on top of commit 65e9fb081877a18c
("drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head
C9xx cores") in riscv/for-next, the build failed because the new
ALT_SBI_PMU_OVERFLOW() definition ended up inside both #endifs,
instead of between.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
