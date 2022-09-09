Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245915B315F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiIIIK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIIIKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:10:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF85E5C9F0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 01:10:23 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id w8so1365386lft.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 01:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vZD+gMtJr5SdrYBTfgqz2rRaCIKo/6GRB7Drz3aUesE=;
        b=Pj3YOuMGkiXSpfOjSnO+KXpjdE28hS1iM3EoxzMDozvIthzzWYTZNsCgNNMOBVOxZI
         x0nzdtbtnTWcQWEAjQ6t/Bdgd/ceOQOrw3+6yt0Ir5Sn8uKIE25N2GT1H59e96TAYYTM
         weBjUmYAlW5dtgwgzIg9g+EvWfh1fQ76pKNfQ0u+0dnxjd1muWB6bc2rCKYqyUI2umWY
         fME4X+2sFAT5ChqMMX0p5icC69W1gPBxfglb2VVFpnEq7jWAOZYe47WgB/eeOtY+uhSe
         rDKYoiOHNJ1UoMwZY3Vnv5nOsjjBcPmWIXNom3hVdWPGB42CgstSytU9lygnUgC7tQAk
         dqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vZD+gMtJr5SdrYBTfgqz2rRaCIKo/6GRB7Drz3aUesE=;
        b=RBKJ8yXpgFt1CNUk3RaxP4UMQpHf52FdE68ywtaUTQLRBwBd4EU6AsPR8NNfBeXCPc
         8HygLHhwblZ8fajdtIaT8xoIpKAOFah90cPdYSg/UhWZwz5kfHkVNlhO04byaWdTx6Wp
         wXuUxUHTtks+6FFY0Eq+7tQVg1uqcSbWxnhFjfqZ95xW2JvbQT4nXDHj0TWQ+ReMUot8
         Y1ECBwJKlGvB7cfsceDxFrAwZho8d0JkDpFPJMKMcYbuyg3eogGyaJj9Y+8pOWU1J+ly
         JCspe2oTKF4tYRhfiqlgo7SLHWTLWuvziB9kK4Db0n8fa5EWp3AOu6d4ORLH6MOn4m/T
         rHsw==
X-Gm-Message-State: ACgBeo39Uen+lqseh0wB2hlUrfZ/Bbab04ZSqcBt6rxAE2A5OviaD8CM
        FOixTCQ6qKuVju9Jw8eLAkb9SgKmaxuoQBLggSvn0Q==
X-Google-Smtp-Source: AA6agR69LoysOIZEWgWOLuREJRHdaOc5MXE/9NDBKz8yuTyIoKzrUuaTovANov7dc3gNTGz2aXhLOy0Aav34Ihx9UlE=
X-Received: by 2002:a19:6505:0:b0:497:9225:4e90 with SMTP id
 z5-20020a196505000000b0049792254e90mr3893587lfb.497.1662711022062; Fri, 09
 Sep 2022 01:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220830044642.566769-1-apatel@ventanamicro.com> <20220830044642.566769-2-apatel@ventanamicro.com>
In-Reply-To: <20220830044642.566769-2-apatel@ventanamicro.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 9 Sep 2022 13:40:10 +0530
Message-ID: <CAK9=C2VXsc4oBK5MxjAQnH5eX-wGbt0cb59Uc=z5xeLRY+j7sg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for
 systems with Svpbmt
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On Tue, Aug 30, 2022 at 10:17 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> Currently, all flavors of ioremap_xyz() function maps to the generic
> ioremap() which means any ioremap_xyz() call will always map the
> target memory as IO using _PAGE_IOREMAP page attributes. This breaks
> ioremap_cache() and ioremap_wc() on systems with Svpbmt because memory
> remapped using ioremap_cache() and ioremap_wc() will use _PAGE_IOREMAP
> page attributes.
>
> To address above (just like other architectures), we implement RISC-V
> specific ioremap_cache() and ioremap_wc() which maps memory using page
> attributes as defined by the Svpbmt specification.
>
> Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
> Co-developed-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>

Can you please consider this patch for Linux-6.0-rc5 ?

Regards,
Anup

> ---
>  arch/riscv/include/asm/io.h      | 10 ++++++++++
>  arch/riscv/include/asm/pgtable.h |  2 ++
>  2 files changed, 12 insertions(+)
>
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 69605a474270..07ac63999575 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -133,6 +133,16 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
>  #define outsq(addr, buffer, count) __outsq((void __iomem *)addr, buffer, count)
>  #endif
>
> +#ifdef CONFIG_MMU
> +#define ioremap_wc(addr, size)         \
> +       ioremap_prot((addr), (size), _PAGE_IOREMAP_WC)
> +#endif
> +
>  #include <asm-generic/io.h>
>
> +#ifdef CONFIG_MMU
> +#define ioremap_cache(addr, size)      \
> +       ioremap_prot((addr), (size), _PAGE_KERNEL)
> +#endif
> +
>  #endif /* _ASM_RISCV_IO_H */
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 7ec936910a96..346b7c1a3eeb 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -182,6 +182,8 @@ extern struct pt_alloc_ops pt_ops __initdata;
>  #define PAGE_TABLE             __pgprot(_PAGE_TABLE)
>
>  #define _PAGE_IOREMAP  ((_PAGE_KERNEL & ~_PAGE_MTMASK) | _PAGE_IO)
> +#define _PAGE_IOREMAP_WC       ((_PAGE_KERNEL & ~_PAGE_MTMASK) | \
> +                                _PAGE_NOCACHE)
>  #define PAGE_KERNEL_IO         __pgprot(_PAGE_IOREMAP)
>
>  extern pgd_t swapper_pg_dir[];
> --
> 2.34.1
>
