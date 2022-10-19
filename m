Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45497604CD2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiJSQLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiJSQLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:11:13 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90FE18DA85
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:11:11 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bs14so22815201ljb.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 09:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cTLtxH/9tdJ3MnfIXYFHnaBNfFAm0kUtsej9gwtGuyE=;
        b=F2oQw+wag08kfGzWVJaKgb49QMe1rpOTgK6Nol5ulhaVyYhJcvpCcNT4350XIn6DSj
         Bs6uM73Q+TxoED54v7UguROyJYkRGSZGM2VGzU1aSFAoezfkG1AnrtxClx7DQ35G1h5d
         caB5E9v1wOG/SGm1vAerSS1b5BEDgho6tBqs2V5DQF/1dOOnXeIHVcLIJUMMPLlj2AIi
         vedFbUqxu4uIM/IWy9qY4ADJvQRiHxAxOtLU0AUKVcXOYReDU1RWerQH/OkyzAipl6Az
         v+Qkq8HfJdx/NT9YbEuxU894EYsRjee4FcSy1HGilzbrBIlIgMKQK99b0jwSb90iSjSj
         SwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cTLtxH/9tdJ3MnfIXYFHnaBNfFAm0kUtsej9gwtGuyE=;
        b=FkTxvhKdDehBYz7cTeiVgyJlu5GYz0C5QDXQcOArnpTlLbpoen8ddCn6y6rEmIq1IJ
         UvNAJX/egC/MEauQKE4pfNawOvqJNmownGjVgebh4Ddowy1qh+QY+owrrUtGYFKCHGM0
         vv8HsTcAWfyWlxNYXeT16LzskSxu9bDyrH7tD5qaOQ7ygiLXnSmnZkY5seKEZtcmTfsY
         5rpb3Ry2LPwusvoefDqqygKzpjy8/MmBPm8ur6pKq5F56SCrZGI8YM/t5IlNPgXBWgB4
         qw4+YaugEiD8WU4opL23mhzDUeesCr/kB8weoG2K5+LxHasyZsqhNp9nyI4X1yWhC51c
         FKvg==
X-Gm-Message-State: ACrzQf3b9DbnqKcbmbk4XCHdxGpsvf4niE3tO3yf+X2WjdoeVfdsx+oF
        OtDd/Sx4/f3mj/3QRNhwsIJ9tPAA+qmN/TV8p4OolQ==
X-Google-Smtp-Source: AMsMyM6N32QgZOyAH5TjUIjT2Lt4GP4WkBfbS6QjelNxdiiyxMTZ4TmiyTvPurhIkBzVUc7k17LE6fMazS3tXsald9U=
X-Received: by 2002:a2e:7808:0:b0:26f:c0c2:8a3e with SMTP id
 t8-20020a2e7808000000b0026fc0c28a3emr2976131ljc.260.1666195867358; Wed, 19
 Oct 2022 09:11:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221019131128.237026-1-apatel@ventanamicro.com>
 <20221019131128.237026-3-apatel@ventanamicro.com> <13122510.uLZWGnKmhe@phil>
In-Reply-To: <13122510.uLZWGnKmhe@phil>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 19 Oct 2022 21:40:56 +0530
Message-ID: <CAK9=C2WaoqAaVa2fo9E7cGXMy-MKpj-xLN6LoMHyq_g1psGLUQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for
 systems with Svpbmt
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 7:49 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Mittwoch, 19. Oktober 2022, 15:11:26 CEST schrieb Anup Patel:
> > Currently, all flavors of ioremap_xyz() function maps to the generic
> > ioremap() which means any ioremap_xyz() call will always map the
> > target memory as IO using _PAGE_IOREMAP page attributes. This breaks
> > ioremap_cache() and ioremap_wc() on systems with Svpbmt because memory
> > remapped using ioremap_cache() and ioremap_wc() will use _PAGE_IOREMAP
> > page attributes.
> >
> > To address above (just like other architectures), we implement RISC-V
> > specific ioremap_cache() and ioremap_wc() which maps memory using page
> > attributes as defined by the Svpbmt specification.
> >
> > Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
> > Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>
> Wasn't there discussion around those functions in general in v2?

Yes, there was discussion about a few drivers using ioremap_xyz()
which is discouraged and drivers should use memremap().

We still need the arch specific ioremap_xyz() functions/macros
added by this patch because these are required by the generic
kernel memremap() implementation (refer, kernel/iomem.c).

>
> In any case, the patch doesn't break anything on qemu and d1, so
>
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Regards,
Anup

>
>
> > ---
> >  arch/riscv/include/asm/io.h      | 10 ++++++++++
> >  arch/riscv/include/asm/pgtable.h |  2 ++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> > index 92080a227937..92a31e543388 100644
> > --- a/arch/riscv/include/asm/io.h
> > +++ b/arch/riscv/include/asm/io.h
> > @@ -133,6 +133,16 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
> >  #define outsq(addr, buffer, count) __outsq(PCI_IOBASE + (addr), buffer, count)
> >  #endif
> >
> > +#ifdef CONFIG_MMU
> > +#define ioremap_wc(addr, size)               \
> > +     ioremap_prot((addr), (size), _PAGE_IOREMAP_WC)
> > +#endif
> > +
> >  #include <asm-generic/io.h>
> >
> > +#ifdef CONFIG_MMU
> > +#define ioremap_cache(addr, size)    \
> > +     ioremap_prot((addr), (size), _PAGE_KERNEL)
> > +#endif
> > +
> >  #endif /* _ASM_RISCV_IO_H */
> > diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> > index 7ec936910a96..346b7c1a3eeb 100644
> > --- a/arch/riscv/include/asm/pgtable.h
> > +++ b/arch/riscv/include/asm/pgtable.h
> > @@ -182,6 +182,8 @@ extern struct pt_alloc_ops pt_ops __initdata;
> >  #define PAGE_TABLE           __pgprot(_PAGE_TABLE)
> >
> >  #define _PAGE_IOREMAP        ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
> > +#define _PAGE_IOREMAP_WC     ((_PAGE_KERNEL & ~_PAGE_MTMASK) | \
> > +                              _PAGE_NOCACHE)
> >  #define PAGE_KERNEL_IO               __pgprot(_PAGE_IOREMAP)
> >
> >  extern pgd_t swapper_pg_dir[];
> >
>
>
>
>
