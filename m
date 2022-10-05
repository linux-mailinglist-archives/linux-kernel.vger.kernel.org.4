Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D2B5F5652
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJEOXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiJEOXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:23:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC83786FA;
        Wed,  5 Oct 2022 07:23:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97B68B81BEF;
        Wed,  5 Oct 2022 14:23:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB7EC433C1;
        Wed,  5 Oct 2022 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664979814;
        bh=WFaYi+X3bwztuZypZNGHha7U7CNiw0AMJpnPHzXpFJ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X6P1+ilsTVaYaESYTCbKcfVD/ZBr0JiVSV8A0kBpux8OIUbZhcCbAC3XttnPwEGYr
         sIGNEHtLbjjMRj9DDqY7PEF4nKOuHdq7kyxfjo/xsInvA+HUdZHe3FMTsHROVFWKms
         fbAfere5gNLL1ACirQm9YDHA4bRw3+SHp/Mkapf/6f7V8sAuHL7oDNEaEkB6qul/pT
         Cx/jFckJB3rTnRysbcdiGfUvja32NB1ccF7OJNyzyAAKRogcpsWKiEedx9mBTy8d0W
         Id0x4lMOhleqENi5HN2sxqI4nOqKczbJP3vYAyVFs7bvhDIzYaWXJayGf3BHVTlTSB
         dQ6dzWj6vDyyA==
Received: by mail-oi1-f178.google.com with SMTP id w127so3159299oiw.8;
        Wed, 05 Oct 2022 07:23:34 -0700 (PDT)
X-Gm-Message-State: ACrzQf2D9WEQyxTtYvIbApEewngZ5B9KtXWjBqXMjk/SzVqRfFS5mozP
        7xJqPcRtJ9D+2qpckOmIAVdnavOefV2uFttxxGo=
X-Google-Smtp-Source: AMsMyM5V+IXDM3tjlKjKLDlYZALnWctuGFs1B162NHLsEjt/VmV8U+oCRfhZJoy8o8aONZZ/gJ6Z967ZWbeH+tGHt08=
X-Received: by 2002:aca:6155:0:b0:353:e740:ce01 with SMTP id
 v82-20020aca6155000000b00353e740ce01mr2320511oib.19.1664979813453; Wed, 05
 Oct 2022 07:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAJF2gTQuSX9idEyNmGRwpAsSP8V=+QKQ7UAp28T-seM8rbkwOA@mail.gmail.com> <CA+V-a8smkDmQbz76sTA5XfUm7bkY4Ee-L5xYW+-xRWkE1TYiAw@mail.gmail.com>
In-Reply-To: <CA+V-a8smkDmQbz76sTA5XfUm7bkY4Ee-L5xYW+-xRWkE1TYiAw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 5 Oct 2022 22:23:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ4G-j3p_pHvVQ82R2DFQZq70xgE3ZhoRkxiSzrHnU2og@mail.gmail.com>
Message-ID: <CAJF2gTQ4G-j3p_pHvVQ82R2DFQZq70xgE3ZhoRkxiSzrHnU2og@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Philipp Tomsich <philipp.tomsich@vrull.eu>,
        Nathan Chancellor <nathan@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 8:54 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> Hi Guo,
>
> On Wed, Oct 5, 2022 at 2:29 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Tue, Oct 4, 2022 at 6:32 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > >
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
> > Seems Svpbmt's PMA, IO, and NC wouldn't fit your requirements, could
> > give a map list of the types of Svpbmt? And give out what you needed,
> > but Svpbmt can't.
> >
> Sorry I didn't get what you meant here, could you please elaborate.
I know there is no pbmt in AX45MP, I am just curious how many physical
memory attributes you would use in linux? It seems only one type used
in the series:
cpu_nocache_area_set -> sbi_ecall(SBI_EXT_ANDES,
SBI_EXT_ANDES_SET_PMA, offset, vaddr, size, entry_id, 0, 0);

I'm not sure how you make emmc/usb/gmac's dma ctrl desc work around
without pbmt when they don't have cache coherency protocol. Do you
need to inject dma_sync for desc synchronization? What's the effect of
dynamic PMA in the patch series?

Thx.

>
> > Here is the Linux dma type to Svpbmt map:
> > PMA -> Normal
> > IO -> ioremap, pgprot_noncached
> > NC -> pgprot_writecombine
> >
> > How about AX45MP?
> >
> Svpbmt extension is not supported on AX45MP (reported by
> riscv_isa_extension_available())
>
> Cheers,
> Prabhakar



-- 
Best Regards
 Guo Ren
