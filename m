Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CBB6399DB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 10:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiK0JzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 04:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiK0JzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 04:55:23 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BF412760;
        Sun, 27 Nov 2022 01:55:21 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id l2so4964056qtq.11;
        Sun, 27 Nov 2022 01:55:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/lRJw3Gs/dFweLCVLuIgos8ablOI2qBTJVe/3vTcrU=;
        b=BTkSMIlD5lD3ZbnfiMATJDoG5jJXcSOvRxTeYzffskdwIygLy1uA+XE9NmLYjwMK49
         9XKKfTBsEOjUCQSPhdYG9sIFia2NPP30n/GQ8qaNZgyoqIqwIkMTbXnQSiZ3sYtc+9fu
         KZ0B3xkZ7eLpL84S0R2ldLif75qiBTglVO7GuOpyrHQwlqKh6fArTh4PP0OEkUW6eCoR
         XTsOYo/RqF3/BHMTXm7VMPODRqKX/ceA7CcsBotlCl1l7iqW0bT3gJvZoxARq+bfBKOF
         Hg753X1iBU7/FfZJSZ6kzhFTBbSywLRPBhiqI1xHwMmNpik9yn+YdzRgOTdaWCLEFBXP
         Rp3g==
X-Gm-Message-State: ANoB5pn9Fr73KUTVQAH8UYeB9QMlb9jZe0YZR3QI4/oEplbmDBMwSyo9
        9xdo35oTZ0xEwKgjhB8nRzUT5vXLZyzB1A==
X-Google-Smtp-Source: AA0mqf4T/nhr8ZGy2ehWS/7wryA+JgB2ugtouWdo7t2seYn/U4ECDoGawjw6OgCqsYO35+Vm4VCvqA==
X-Received: by 2002:a05:622a:514e:b0:3a5:2988:c67c with SMTP id ew14-20020a05622a514e00b003a52988c67cmr31107413qtb.487.1669542920790;
        Sun, 27 Nov 2022 01:55:20 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id z1-20020ac84541000000b003a530a32f67sm5044802qtn.65.2022.11.27.01.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 01:55:20 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id y83so9941836yby.12;
        Sun, 27 Nov 2022 01:55:19 -0800 (PST)
X-Received: by 2002:a5b:24b:0:b0:6ca:3b11:8d76 with SMTP id
 g11-20020a5b024b000000b006ca3b118d76mr25273660ybp.202.1669542919298; Sun, 27
 Nov 2022 01:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20221124172207.153718-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221124172207.153718-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <bf8e33fd-a752-d5d5-859e-14302d069f2d@sholland.org> <CA+V-a8sz4i_wenTyA5tVTVB8dQWLmuXCf3CGYOPC+C07GJ8WTw@mail.gmail.com>
In-Reply-To: <CA+V-a8sz4i_wenTyA5tVTVB8dQWLmuXCf3CGYOPC+C07GJ8WTw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 27 Nov 2022 10:55:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWQO_usrJwmVYDx6o-CpzmotVZLt176eKbqLzY-GXiDng@mail.gmail.com>
Message-ID: <CAMuHMdWQO_usrJwmVYDx6o-CpzmotVZLt176eKbqLzY-GXiDng@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] soc: renesas: Add L2 cache management for RZ/Five SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Sat, Nov 26, 2022 at 10:10 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Fri, Nov 25, 2022 at 7:43 PM Samuel Holland <samuel@sholland.org> wrote:
> > On 11/24/22 11:22, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > On the AX45MP core, cache coherency is a specification option so it may
> > > not be supported. In this case DMA will fail. As a workaround, firstly we
> > > allocate a global dma coherent pool from which DMA allocations are taken
> > > and marked as non-cacheable + bufferable using the PMA region as specified
> > > in the device tree. Synchronization callbacks are implemented to
> > > synchronize when doing DMA transactions.
> > >
> > > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > > block that allows dynamic adjustment of memory attributes in the runtime.
> > > It contains a configurable amount of PMA entries implemented as CSR
> > > registers to control the attributes of memory locations in interest.
> > >
> > > Below are the memory attributes supported:
> > > * Device, Non-bufferable
> > > * Device, bufferable
> > > * Memory, Non-cacheable, Non-bufferable
> > > * Memory, Non-cacheable, Bufferable
> > > * Memory, Write-back, No-allocate
> > > * Memory, Write-back, Read-allocate
> > > * Memory, Write-back, Write-allocate
> > > * Memory, Write-back, Read and Write-allocate
> > >
> > > This patch adds support to configure the memory attributes of the memory
> > > regions as passed from the l2 cache node and exposes the cache management
> > > ops.
> >
> > Forgive my ignorance, but why do you need both a DMA pool and explicit
> > cache maintenance? Wouldn't the purpose of marking a memory region as
> > permanently non-cacheable be to avoid cache maintenance? And likewise,
> > if you are doing cache maintenance anyway, why does it matter if/how the
> > memory is cacheable?
> >
> "Memory, Non-cacheable, Bufferable" raises an AXI signal for
> transactions hence needing SW implementation for cache maintenance.
>
> > > More info about PMA (section 10.3):
> > > Link: http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

> > > +static int ax45mp_configure_pma_regions(struct device_node *np)
> > > +{
> > > +     const char *propname = "andestech,pma-regions";
> > > +     u32 start, size, flags;
> > > +     unsigned int entry_id;
> > > +     unsigned int i;
> > > +     int count;
> > > +     int ret;
> > > +
> > > +     count = of_property_count_elems_of_size(np, propname, sizeof(u32) * 3);
> > > +     if (count < 0)
> > > +             return count;
> > > +
> > > +     if (count > AX45MP_MAX_PMA_REGIONS)
> > > +             return -EINVAL;
> > > +
> > > +     for (i = 0, entry_id = 0 ; entry_id < count ; i += 3, entry_id++) {
> > > +             of_property_read_u32_index(np, propname, i, &start);
> > > +             of_property_read_u32_index(np, propname, i + 1, &size);
> > > +             of_property_read_u32_index(np, propname, i + 2, &flags);
> > > +             ret = ax45mp_sbi_set_pma(start, size, flags, entry_id);
> > > +             if (!ret)
> > > +                     pr_err("Failed to setup PMA region 0x%x - 0x%x flags: 0x%x",
> > > +                            start, start + size, flags);
> > > +     }
> > > +
> > > +     return 0;
> > > +}
> >
> > If firmware support is required to set up these PMA regions, why is
> > Linux doing this at all? The firmware has access to the devicetree as
> > well. It can set this up before entering S-mode, and then you don't need
> > to expose this capability via an SBI extension. In fact, firmware could
> > generate the reserved-memory node based on these regions at runtime (or
> > vice versa).
> >
> That's a good point. I'll do some research on this and get back.
>
> Btw are there any existing examples where the firmware adds DT nodes?

/memory, reserved-memory, optee on ARM, RPC status on R-Car Gen3/4, ...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
