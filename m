Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47914604606
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJSMyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233700AbiJSMyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:54:17 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7496981126
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:37:22 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id be13so12222470lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oYN264dQZ8nr4oIPkUkzpYJVPgC0y1gnv/lMRuwW2jE=;
        b=Zs+cwTqRv3wsVXoxiS5bQeSD4Ce0xvVSTIvcUm9QZfLJ6SO7YHqwWqJl7Wa3DL8RSS
         n0dr67t6CBQYCtayX/KqWHUsphREEIFbvqVBOPVOR4NDt38eP9kFQl2HZfpracREfht7
         /5vDDtMutFZkiduO0IzNJiyoYc6EUb0kbUUljaBE1PGsub9WyyTmHlhANP2BLCa+PYfN
         X7tiAi1wEKlI2BAGfTyr9lk9fwPNjV3NyDvs3Xc0nl0EoygfBEK5w3+kyFUvNgg5GjLU
         xlJj6sSfYx0BEzmbcv+Iy1pK/dM6NjzNGqlRxOZCNXlTAbVhvf+ax5j6XljeAiCMYxKP
         17Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oYN264dQZ8nr4oIPkUkzpYJVPgC0y1gnv/lMRuwW2jE=;
        b=t0nd04X9d0uEW0Y3NceoncamvHz73rR96tb30xbwcPAmYQOq7XAGQzIXITDvXVFQlg
         sKijGqT/jgi838rJg7kYuZxC9Puo8od32JKH6Bhpjwf/rcKgC4U2TOFw5k6zKdXwstHJ
         3UXYh7+/FWykA5808gUNDZnwmGx4HEyz7abU/Vw1+sLkFP/ohEg1UpITmjSKbeFpUO3W
         /rzOK74MRPH1Fwttk9t678KdOr0OgmtqTdsTpxvVCuB7EDc3q7XEIdMTQsM3q6BXZ96Q
         3XiJOkODT9E/4ZDjdIhqLkjMLENBVjEHQVVaM0xAoQsfxR3ZynyFRucQKGS/I/W80fVs
         AV3w==
X-Gm-Message-State: ACrzQf0jrdREm90pXlmhesgn0kYeO1gkRyU0w9kIY4TH+SoHT8f/9QuZ
        ZQ3CQbN8Cc1atdsjfOzwrt2DrDzLh/vbZsuRf7es2g==
X-Google-Smtp-Source: AMsMyM7UvBrzfcI2OROYmcF46yFodZk+wafe/oMoaM36W8zJIRnc+d014b4NTSf4EGFljsmbsmPxXQuSk5WiM266SlU=
X-Received: by 2002:a05:6512:31c9:b0:4a2:5349:7103 with SMTP id
 j9-20020a05651231c900b004a253497103mr2734896lfe.497.1666182975312; Wed, 19
 Oct 2022 05:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20221019121622.179024-1-apatel@ventanamicro.com>
 <20221019121622.179024-2-apatel@ventanamicro.com> <5869751.lOV4Wx5bFT@phil>
In-Reply-To: <5869751.lOV4Wx5bFT@phil>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 19 Oct 2022 18:06:04 +0530
Message-ID: <CAK9=C2WZ4m=6JOeP6t+7FK-Jr5bp7+cjKLCApa9nuHFBFZwOTw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] RISC-V: Fix compilation without RISCV_ISA_ZICBOM
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Jones <ajones@ventanamicro.com>,
        kernel test robot <lkp@intel.com>,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 6:01 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Anup,
>
> Am Mittwoch, 19. Oktober 2022, 14:16:19 CEST schrieb Anup Patel:
> > From: Andrew Jones <ajones@ventanamicro.com>
> >
> > riscv_cbom_block_size and riscv_init_cbom_blocksize() should always
> > be available and riscv_init_cbom_blocksize() should always be
> > invoked, even when compiling without RISCV_ISA_ZICBOM enabled. This
> > is because disabling RISCV_ISA_ZICBOM means "don't use zicbom
> > instructions in the kernel" not "pretend there isn't zicbom, even
> > when there is". When zicbom is available, whether the kernel enables
> > its use with RISCV_ISA_ZICBOM or not, KVM will offer it to guests.
> > Ensure we can build KVM and that the block size is initialized even
> > when compiling without RISCV_ISA_ZICBOM.
>
> either I'm way very low on coffee or something is strange here :-) .
>
> I can fully grasp the need to init the cbom blocksize for guests, even when
> the main kernel isn't using it, but below in the patch itself it is still:

The Guest might have pass-through access to a device which is not
cache-coherent whereas Host might have all devices cache-coherent.

>
> +#ifdef CONFIG_RISCV_ISA_ZICBOM
> +void riscv_init_cbom_blocksize(void)
> +{
> [...]
>
> so the init_cbom_blocksize function is still inside a RISCV_ISA_ZICBOM
> ifdef?

Argh, I mixed changes from my previous patch and Drew's patch.

I will quickly send v4. Thanks for catching.

Regards,
Anup

>
>
> Heiko
>
>
> >
> > Fixes: 8f7e001e0325 ("RISC-V: Clean up the Zicbom block size probing")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/mm/cacheflush.c      | 41 +++++++++++++++++++++++++++++++++
> >  arch/riscv/mm/dma-noncoherent.c | 41 ---------------------------------
> >  2 files changed, 41 insertions(+), 41 deletions(-)
> >
> > diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> > index 6cb7d96ad9c7..f318b2553612 100644
> > --- a/arch/riscv/mm/cacheflush.c
> > +++ b/arch/riscv/mm/cacheflush.c
> > @@ -3,6 +3,8 @@
> >   * Copyright (C) 2017 SiFive
> >   */
> >
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> >  #include <asm/cacheflush.h>
> >
> >  #ifdef CONFIG_SMP
> > @@ -86,3 +88,42 @@ void flush_icache_pte(pte_t pte)
> >               flush_icache_all();
> >  }
> >  #endif /* CONFIG_MMU */
> > +
> > +unsigned int riscv_cbom_block_size;
> > +EXPORT_SYMBOL_GPL(riscv_cbom_block_size);
> > +
> > +#ifdef CONFIG_RISCV_ISA_ZICBOM
> > +void riscv_init_cbom_blocksize(void)
> > +{
> > +     struct device_node *node;
> > +     unsigned long cbom_hartid;
> > +     u32 val, probed_block_size;
> > +     int ret;
> > +
> > +     probed_block_size = 0;
> > +     for_each_of_cpu_node(node) {
> > +             unsigned long hartid;
> > +
> > +             ret = riscv_of_processor_hartid(node, &hartid);
> > +             if (ret)
> > +                     continue;
> > +
> > +             /* set block-size for cbom extension if available */
> > +             ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
> > +             if (ret)
> > +                     continue;
> > +
> > +             if (!probed_block_size) {
> > +                     probed_block_size = val;
> > +                     cbom_hartid = hartid;
> > +             } else {
> > +                     if (probed_block_size != val)
> > +                             pr_warn("cbom-block-size mismatched between harts %lu and %lu\n",
> > +                                     cbom_hartid, hartid);
> > +             }
> > +     }
> > +
> > +     if (probed_block_size)
> > +             riscv_cbom_block_size = probed_block_size;
> > +}
> > +#endif
> > diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> > index b0add983530a..d919efab6eba 100644
> > --- a/arch/riscv/mm/dma-noncoherent.c
> > +++ b/arch/riscv/mm/dma-noncoherent.c
> > @@ -8,13 +8,8 @@
> >  #include <linux/dma-direct.h>
> >  #include <linux/dma-map-ops.h>
> >  #include <linux/mm.h>
> > -#include <linux/of.h>
> > -#include <linux/of_device.h>
> >  #include <asm/cacheflush.h>
> >
> > -unsigned int riscv_cbom_block_size;
> > -EXPORT_SYMBOL_GPL(riscv_cbom_block_size);
> > -
> >  static bool noncoherent_supported;
> >
> >  void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
> > @@ -77,42 +72,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
> >       dev->dma_coherent = coherent;
> >  }
> >
> > -#ifdef CONFIG_RISCV_ISA_ZICBOM
> > -void riscv_init_cbom_blocksize(void)
> > -{
> > -     struct device_node *node;
> > -     unsigned long cbom_hartid;
> > -     u32 val, probed_block_size;
> > -     int ret;
> > -
> > -     probed_block_size = 0;
> > -     for_each_of_cpu_node(node) {
> > -             unsigned long hartid;
> > -
> > -             ret = riscv_of_processor_hartid(node, &hartid);
> > -             if (ret)
> > -                     continue;
> > -
> > -             /* set block-size for cbom extension if available */
> > -             ret = of_property_read_u32(node, "riscv,cbom-block-size", &val);
> > -             if (ret)
> > -                     continue;
> > -
> > -             if (!probed_block_size) {
> > -                     probed_block_size = val;
> > -                     cbom_hartid = hartid;
> > -             } else {
> > -                     if (probed_block_size != val)
> > -                             pr_warn("cbom-block-size mismatched between harts %lu and %lu\n",
> > -                                     cbom_hartid, hartid);
> > -             }
> > -     }
> > -
> > -     if (probed_block_size)
> > -             riscv_cbom_block_size = probed_block_size;
> > -}
> > -#endif
> > -
> >  void riscv_noncoherent_supported(void)
> >  {
> >       WARN(!riscv_cbom_block_size,
> >
>
>
>
>
