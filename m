Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE8C6174DD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 04:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiKCDVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 23:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKCDUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 23:20:52 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A6013F74;
        Wed,  2 Nov 2022 20:20:51 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id n186so743188oih.7;
        Wed, 02 Nov 2022 20:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9LEoUWJvpUFOWNZZSHLTT8Vj3FE8ZbDHe08yAKC0s8=;
        b=wJivIGi4u9AcDsQVrpKZgZWwy7gb6N/17rLjUiOrVJXHXtf7/jdPCAGwvHQlCFPuhX
         PihmDQ8jqs53U3JhKCVYMmEcg6fZ2DA1iX5+YKaMIL7WOez2JS3M35TWWhT+8Fx5KP4x
         1B4MA0WGb87ZYKxYsE+NJMMrfK7BvDIiH93eARjrAe4Hn/BcNZt1MtynkI+VByIHk/FY
         nbQHNRuB6LERhCJOgBM/I2wYaH9NrKrXciAVg164W5HpvQlqPYfLxj8Zle2RveNEEANb
         hSP2875WmyHbz/XNGNpK8ZptOvVjprPXZu8+yTKMnYnKqbMrSyHbJs+ZoMxsWK8olWuh
         S6oQ==
X-Gm-Message-State: ACrzQf2/JhGxUanNS9t8ue9EZkYDVx9lLB0Zo5a4un0i9hQl/bYHKRxx
        M4h/CH1s6sMRUY0KSIzS5g==
X-Google-Smtp-Source: AMsMyM4x9J/gNXs66sXJG0Hy26y6zYfJGYKLSTEOTu+BoRTCA1i0xSYSWxYDuz+zEQkxansG7DLxNA==
X-Received: by 2002:a05:6808:2082:b0:35a:224:983b with SMTP id s2-20020a056808208200b0035a0224983bmr11413143oiw.179.1667445651094;
        Wed, 02 Nov 2022 20:20:51 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c14-20020a4ad20e000000b004982f2d3c03sm5059059oos.25.2022.11.02.20.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 20:20:50 -0700 (PDT)
Received: (nullmailer pid 1058925 invoked by uid 1000);
        Thu, 03 Nov 2022 03:20:51 -0000
Date:   Wed, 2 Nov 2022 22:20:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
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
Subject: Re: [RFC PATCH v3 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
Message-ID: <20221103032051.GD459441-robh@kernel.org>
References: <20221019220242.4746-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221019220242.4746-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221021020500.GA2157489-robh@kernel.org>
 <CA+V-a8v0jEFj+XKAtyAaTBFmX3bObBZgGd6n1LB3OnTU_W002w@mail.gmail.com>
 <Y1Md4bMYJHI34HuJ@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1Md4bMYJHI34HuJ@spud>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 11:32:01PM +0100, Conor Dooley wrote:
> On Fri, Oct 21, 2022 at 11:05:40PM +0100, Lad, Prabhakar wrote:
> > Hi Rob,
> > 
> > Thank you for the review.
> > 
> > On Fri, Oct 21, 2022 at 3:05 AM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Oct 19, 2022 at 11:02:42PM +0100, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > On the AX45MP core, cache coherency is a specification option so it may
> > > > not be supported. In this case DMA will fail. As a workaround, firstly we
> > > > allocate a global dma coherent pool from which DMA allocations are taken
> > > > and marked as non-cacheable + bufferable using the PMA region as specified
> > > > in the device tree. Synchronization callbacks are implemented to
> > > > synchronize when doing DMA transactions.
> > > >
> > > > The Andes AX45MP core has a Programmable Physical Memory Attributes (PMA)
> > > > block that allows dynamic adjustment of memory attributes in the runtime.
> > > > It contains a configurable amount of PMA entries implemented as CSR
> > > > registers to control the attributes of memory locations in interest.
> > > >
> > > > Below are the memory attributes supported:
> > > > * Device, Non-bufferable
> > > > * Device, bufferable
> > > > * Memory, Non-cacheable, Non-bufferable
> > > > * Memory, Non-cacheable, Bufferable
> > > > * Memory, Write-back, No-allocate
> > > > * Memory, Write-back, Read-allocate
> > > > * Memory, Write-back, Write-allocate
> > > > * Memory, Write-back, Read and Write-allocate
> > > >
> > > > This patch adds support to configure the memory attributes of the memory
> > > > regions as passed from the l2 cache node and exposes the cache management
> > > > ops.
> > > >
> > > > More info about PMA (section 10.3):
> > > > http://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-5.0.0-Datasheet.pdf
> > > >
> > > > This feature is based on the work posted [0] by Vincent Chen
> > > > <vincentc@andestech.com> for the Andes AndeStart RISC-V CPU.
> > > >
> > > > [0] https://lore.kernel.org/lkml/1540982130-28248-1-git-send-email-vincentc@andestech.com/
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >  arch/riscv/include/asm/cacheflush.h    |   8 +
> > > >  arch/riscv/include/asm/errata_list.h   |   2 +
> > > >  arch/riscv/mm/dma-noncoherent.c        |  20 ++
> > > >  drivers/soc/renesas/Kconfig            |   5 +
> > > >  drivers/soc/renesas/Makefile           |   4 +
> > > >  drivers/soc/renesas/rzf/Kconfig        |   6 +
> > > >  drivers/soc/renesas/rzf/Makefile       |   3 +
> > > >  drivers/soc/renesas/rzf/ax45mp_cache.c | 431 +++++++++++++++++++++++++
> > >
> > > How many cache drivers do we have around now? I've seen a few bindings
> > > go by. I'm guessing it is time to stop putting the drivers in the
> > > drivers/soc/ dumping ground.
> > >
> > The main reason this driver is not in arch/riscv is that it has vendor
> > specific extensions. Due to this reason it was agreed during the LPC
> > that vendor specific extension should be maintained by SoC vendors and
> > was agreed that this can go into drivers/soc/renesas folder instead.
> 
> Does not in drivers/soc mean they need to go into arch/riscv?
> The outcome of the chat at the LPC BoF was more that the cache drivers
> themselves should not be be routed via the arch maintainers, no?

drivers/cache/ or something is what I'm suggesting starting. The first 
thing is probably making an inventory of how many we already have.

Rob
