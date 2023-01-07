Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7856611FB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 23:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjAGWLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 17:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjAGWL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 17:11:28 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9918919C12;
        Sat,  7 Jan 2023 14:11:24 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id 4so629300qky.12;
        Sat, 07 Jan 2023 14:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gwxE7Q9iHOTdeXe9x0xc4tBxUf+n7UexqnsTO4hvkXM=;
        b=ZbAbVUr3Lpgd9HbMzmrplqDRU7F9ZmhdS/WOWnrm5QsA3ZHS8H/q8AXtl2apXFcB2i
         4fH94d8P3kMe47oEKid2CHFmkhKfp52TKQp9r/M9WgUGgB3me5MnXNrJu5G31xOOCQ9W
         SL47eG/cvrJ4InF8P+G+QAkxgehYitj3zhkIrs+Ke9F8OtjYk17GHueH4S2cTQ/vK425
         WsLs9JEOS+sQmzjuxS5BdE3OeaL5kyIFtd1By6S/SFvh7Sl5eki59VTItoqlTwO7mR8V
         upPvg7+XN8W7vTxMy4Z/j0WTt871+if9bcSmJcmdYQimwNYvE9/RTEKaQ/KyT89wxo8W
         guIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gwxE7Q9iHOTdeXe9x0xc4tBxUf+n7UexqnsTO4hvkXM=;
        b=24WvVmap8ThanIVN4zA3zd1gdc0pdyZPBvP/lO3eO+9xz5ezwyHjMBqJyc4b2x1EAc
         7y0TNHSAQlIYeEY06umf+kLqCyJOft6PZIJQDyFKwmpfPzhMkdlfSaMcztdQ7nWD/k1N
         xWx0piuYJc8hyl2phDX3GPUQGjMFZ4jmlyQzOn2Mc3idDwIfx57c/Jgl7h9Cn2g1RoUO
         VbJ4sGXbLqWs1xVvS6Huej7yr07RU6o+plVLIZYlSbNysDXhHV+YCq97AggoWXYCNU/u
         MC3SqEz6i6dRFR6QcQR+ePR5SLKjtJoMKbMvKQekE+AlQd8OWzChbJEUy/mY8HYThlWq
         pQsQ==
X-Gm-Message-State: AFqh2komNA8rjlVmJItNQPm93FXY0/ICoHI3z34tzuR836qAuT1oP4bH
        VWsMVlEGwQAvijEG5/HFMAzzAZkF3jDRrTUwkWM=
X-Google-Smtp-Source: AMrXdXsGq9t66hmuzI/M0mMAcEzSLxsW8Tlr4bV9dcdBHyP4rLAzUQIyzj0Vr1yYjXpyUg4Z+9UmgY50jq6QXOeTXD8=
X-Received: by 2002:ae9:e8d1:0:b0:702:257f:74fc with SMTP id
 a200-20020ae9e8d1000000b00702257f74fcmr2323663qkg.519.1673129483571; Sat, 07
 Jan 2023 14:11:23 -0800 (PST)
MIME-Version: 1.0
References: <20230106185526.260163-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20230106185526.260163-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <6f7d06ef-d74d-4dfc-9b77-6ae83e0d7816@app.fastmail.com>
In-Reply-To: <6f7d06ef-d74d-4dfc-9b77-6ae83e0d7816@app.fastmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 7 Jan 2023 22:10:56 +0000
Message-ID: <CA+V-a8uF1s+dwKC_+apL+CBiHN8w_J0n_G2dqsgiAUZVEibfqg@mail.gmail.com>
Subject: Re: [RFC PATCH v6 1/6] riscv: mm: dma-noncoherent: Switch using
 function pointers for cache management
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "Conor.Dooley" <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        guoren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Tsukasa OI <research_trasio@irq.a4lg.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for the review.

On Fri, Jan 6, 2023 at 10:31 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jan 6, 2023, at 19:55, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > The current implementation of CMO was handled using the ALTERNATIVE_X()
> > macro; this was manageable when there were a limited number of platforms
> > using this. Now that we are having more and more platforms coming through
> > with the CMO the use of the ALTERNATIVE_X() macro becomes unmanageable.
> >
> > To avoid such issues this patch switches to use of function pointers
> > instead of ALTERNATIVE_X() macro for cache management (the only draw being
> > performance over the previous approach).
> >
> > void (*clean_range)(unsigned long addr, unsigned long size);
> > void (*inv_range)(unsigned long addr, unsigned long size);
> > void (*flush_range)(unsigned long addr, unsigned long size);
> >
> > The above function pointers are provided to be overridden where platforms
> > using standard approach and for platforms who want handle the operation
> > based on the operation the below function pointer is provided:
> >
> > void (*riscv_dma_noncoherent_cmo_ops)(void *vaddr, size_t size,
> >                                       enum dma_data_direction dir,
> >                                       enum dma_noncoherent_ops ops);
> >
> > In the current patch we have moved the ZICBOM and T-Head CMO to use
> > function pointers.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> This looks like a nice improvement! I have a few suggestions
> for improvements, but no objections here.
>
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> > index fac5742d1c1e..826b2ba3e61e 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> ...
> > @@ -44,6 +106,15 @@ static bool errata_probe_cmo(unsigned int stage,
> >
> >       riscv_cbom_block_size = L1_CACHE_BYTES;
> >       riscv_noncoherent_supported();
> > +
> > +     memset(&thead_cmo_ops, 0x0, sizeof(thead_cmo_ops));
> > +     if (IS_ENABLED(CONFIG_ERRATA_THEAD_CMO)) {
> > +             thead_cmo_ops.clean_range = &thead_cmo_clean_range;
> > +             thead_cmo_ops.inv_range = &thead_cmo_inval_range;
> > +             thead_cmo_ops.flush_range = &thead_cmo_flush_range;
> > +             riscv_noncoherent_register_cache_ops(&thead_cmo_ops);
> > +     }
>
> The implementation here looks reasonable, just wonder whether
> the classification as an 'errata' makes sense. I would probably
> consider this a 'driver' at this point, but that's just
> a question of personal preference.
>
zicbom is a CPU feature that doesn't have any DT node and hence no
driver and similarly for T-HEAD SoC. Also the arch_setup_dma_ops()
happens quite early before driver probing due to which we get WARN()
messages during bootup hence I have implemented it as errata; as
errata patching happens quite early.

> For the operations structure, I think a 'static const struct
> riscv_cache_ops' is more intuitive than assigning the
> members individually.
OK.

> > +
> > +enum dma_noncoherent_ops {
> > +     NON_COHERENT_SYNC_DMA_FOR_DEVICE = 0,
> > +     NON_COHERENT_SYNC_DMA_FOR_CPU,
> > +     NON_COHERENT_DMA_PREP,
> > +     NON_COHERENT_DMA_PMEM,
> > +};
> > +
> > +/*
> > + * struct riscv_cache_ops - Structure for CMO function pointers
> > + * @clean_range: Function pointer for clean cache
> > + * @inv_range: Function pointer for invalidate cache
> > + * @flush_range: Function pointer for flushing the cache
> > + * @riscv_dma_noncoherent_cmo_ops: Function pointer for platforms who
> > want
> > + *  to handle CMO themselves. If this function pointer is set rest of
> > the
> > + *  function pointers will be NULL.
> > + */
> > +struct riscv_cache_ops {
> > +     void (*clean_range)(unsigned long addr, unsigned long size);
> > +     void (*inv_range)(unsigned long addr, unsigned long size);
> > +     void (*flush_range)(unsigned long addr, unsigned long size);
> > +     void (*riscv_dma_noncoherent_cmo_ops)(void *vaddr, size_t size,
> > +                                           enum dma_data_direction dir,
> > +                                           enum dma_noncoherent_ops ops);
> > +};
>
> I don't quite see how the fourth operation is used here.
> Are there cache controllers that need something beyond
> clean/inv/flush?
>
This is for platforms that dont follow standard cache operations (like
done in patch 5/6) and there drivers decide on the operations
depending on the ops and dir.

> > +
> > +#else
> > +
> > +static void riscv_noncoherent_register_cache_ops(struct
> > riscv_cache_ops *ops) {}
> > +
> > +static inline void riscv_dma_noncoherent_clean(void *vaddr, size_t
> > size) {}
> > +
> > +static inline void riscv_dma_noncoherent_flush(void *vaddr, size_t
> > size) {}
> > +
> > +static inline void riscv_dma_noncoherent_inval(void *vaddr, size_t
> > size) {}
>
> I think you can drop the #else path here: if there is no
> noncoherent DMA, then nothing should ever call these
> functions, right?
>
Yes it shouldn't be called.

> > +
> > +#ifdef CONFIG_RISCV_ISA_ZICBOM
> ...
> > +struct riscv_cache_ops zicbom_cmo_ops = {
> > +     .clean_range = &zicbom_cmo_clean_range,
> > +     .inv_range = &zicbom_cmo_inval_range,
> > +     .flush_range = &zicbom_cmo_flush_range,
> > +};
> > +#else
> > +struct riscv_cache_ops zicbom_cmo_ops = {
> > +     .clean_range = NULL,
> > +     .inv_range = NULL,
> > +     .flush_range = NULL,
> > +     .riscv_dma_noncoherent_cmo_ops = NULL,
> > +};
> > +#endif
> > +EXPORT_SYMBOL(zicbom_cmo_ops);
>
> Same here: If the ZICBOM ISA is disabled, nothing should
> reference zicbom_cmo_ops.
OK.

Cheers,
Prabhakar
