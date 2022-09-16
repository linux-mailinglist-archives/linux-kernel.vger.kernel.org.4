Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293865BA496
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIPCZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 22:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiIPCZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:25:13 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC29031ED6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 19:25:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a3so21332144lfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 19:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=3g1pfChMrPCGzoHDLIuvi7goXUtH2xCwrvM79pUzgzI=;
        b=UexWPpGvsEPgSXmhTRD96BEdU4Hf13I3c8OciXhz/Sa3MFOgO521TrTUbeY0UuMgZp
         XnSOlcg/cSLXpo/XQ+Ie5yi/r7bZC+mM9oOlfL2/60EOcI0DnDtxq58FsDKkeQa5AkBB
         4khgpj3XcbQTW6IApIy2gCVgMFsxhL2VgyX4jpNd2eqHd22VbEX3BQHLRCA9D39R+2ux
         aUHDYeI0mRxvBCw2Hae2frsvx6o5NeDkyTfZkNoU2nXmNmd95CPVgzVFOVWruCMazfCw
         0VPrObFG/Ws9LzrH7odPWBTAl0VF7sGqo9FYkqX7Tuiv0CzAAMW4bFi9BdSCm9+bVCbB
         hGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=3g1pfChMrPCGzoHDLIuvi7goXUtH2xCwrvM79pUzgzI=;
        b=HiBfu3Xqn4lxFpKIH3ybCOJF5qh+aXHOktObmB2Yh6ZFSAN/dGykcJKuAOmKmvtYRA
         fRErTM8Xcog70ZaVBBvrdCJTIz7AKIJJ23aHG8H8MHNOiOMQ6FHv1bhDZO4r2hSZXoBz
         XrlkiO8EGJ8FQh70kXmiKvhZZDwgjmgE6flN4+812gHysr4MSYOLzTGhdKsfBrdgM7cB
         k+8YwfSo8LsZrJOeserROXVH1bZeVfvkIgwidOzOiNZcyTNYqfmX4+GLYKQBK4g63OlG
         CZ7CqRMR+L0TO+YOad8cs9NIfzwpTiwWwAcXgHEiCQeQDDF+YY9qZSrE1csW954jOFDz
         e7yQ==
X-Gm-Message-State: ACrzQf2Iqoleskx7m3/snjHH8/LH2+3b5H9St/Z39/XoPxFXOjLv0z1/
        SaJjRGymb6iI+PoXARJB+rvQnHeEiYq579eTy/Mcgjc1c/w=
X-Google-Smtp-Source: AMsMyM42n1q8iE4ZmVyKUgfz7ioTW4GZ7ESC6v+9tbZSKZ7yah0eBdk7Dhde71sBFjrXQ4ud6gbmk83C3a1tNDyopw0=
X-Received: by 2002:a05:6512:401f:b0:49e:ea65:cd49 with SMTP id
 br31-20020a056512401f00b0049eea65cd49mr877570lfb.419.1663295109005; Thu, 15
 Sep 2022 19:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220830044642.566769-1-apatel@ventanamicro.com> <20220830044642.566769-2-apatel@ventanamicro.com>
In-Reply-To: <20220830044642.566769-2-apatel@ventanamicro.com>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Fri, 16 Sep 2022 07:54:55 +0530
Message-ID: <CAK9=C2WkqVgg58sKyDEMWue_vL8Pz7bCfERuaW_4DGnYTpcSMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] RISC-V: Fix ioremap_cache() and ioremap_wc() for
 systems with Svpbmt
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
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

This is a crucial RC fix. Can you please take this ?

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
