Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C558673BC47
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjFWQDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjFWQDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:03:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01D1270D;
        Fri, 23 Jun 2023 09:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58F8C61A9F;
        Fri, 23 Jun 2023 16:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA79C433CB;
        Fri, 23 Jun 2023 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687536210;
        bh=rJAiY7DvRusfqKQ/9tX+7NJbcDf3hYdW67SlVu6b8Ps=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GUX+/5uQvg6Bg8M8YCLrvmARyhXRLswbU8k3dv9nbRrPpFW661aFVon7eaBwwbbPA
         z1CnV7sztvuCj19ZOEE/A0zElh24Lts+gtFjNjmrRDG+Jc0jOWdiVdyPsBjPIk7h3f
         Yz21LOC+pJXIDgGrP/xRVYkMFq3RO0Dhr/5XXfNPus1nej7ow5xt8gBeuYB0ZkcnbC
         GxMtQrTXFWMOw3O5Dehd0Qgziy24xTMRGPBQvtjdJTIIFWfI+T3cj0uNqofHSuQaMD
         kL5LGaHq1dAjehM2A1Jy8bIQMwpulI3vU+2hr2JuYy3bZZ+Fn/lwC+9YuaXOlhYTv8
         ntCp/57bxACEQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4f96da99965so1036935e87.1;
        Fri, 23 Jun 2023 09:03:30 -0700 (PDT)
X-Gm-Message-State: AC+VfDxydiPehohwm8wXTafxqWF0fn3yy3EGGo+Ay80FDKqmIZhZYgE4
        iOUJyIsRgvKw4QxGAdtsyZJIUlnQL0lu66pEvQg=
X-Google-Smtp-Source: ACHHUZ7PLoQP8phTP8/WxALdhKuPT/UQWgdoR/LtQuoyLK6qpHOlqVvniIj8rDnEDu9b7l837IWIHuIOelrRoml6wU4=
X-Received: by 2002:ac2:499e:0:b0:4f8:6f40:4776 with SMTP id
 f30-20020ac2499e000000b004f86f404776mr10070198lfl.46.1687536208757; Fri, 23
 Jun 2023 09:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230623134351.1898379-1-kernel@xen0n.name> <20230623134351.1898379-5-kernel@xen0n.name>
In-Reply-To: <20230623134351.1898379-5-kernel@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 24 Jun 2023 00:03:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6=yLvVdyOCdjFWrUe_MbG6PymTn5=o2rQOrpXLzcvhdQ@mail.gmail.com>
Message-ID: <CAAhV-H6=yLvVdyOCdjFWrUe_MbG6PymTn5=o2rQOrpXLzcvhdQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] LoongArch: Make {read,write}_fcsr compatible with LLVM/Clang
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     WANG Rui <wangrui@loongson.cn>, Xi Ruoyao <xry111@xry111.site>,
        loongarch@lists.linux.dev, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Xuerui,

On Fri, Jun 23, 2023 at 9:44=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wro=
te:
>
> From: WANG Xuerui <git@xen0n.name>
>
> LLVM/Clang does not see FCSRs as GPRs, so make use of compiler
> built-ins instead for better maintainability with less code.
>
> The existing version cannot be wholly removed though, because the
> built-ins, while available on GCC too, is predicated TARGET_HARD_FLOAT,
> which means soft-float code cannot make use of them.
>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> ---
>  arch/loongarch/include/asm/loongarch.h | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/incl=
ude/asm/loongarch.h
> index ac83e60c60d1..eedc313b5241 100644
> --- a/arch/loongarch/include/asm/loongarch.h
> +++ b/arch/loongarch/include/asm/loongarch.h
> @@ -1445,12 +1445,6 @@ __BUILD_CSR_OP(tlbidx)
>  #define EXCCODE_INT_START      64
>  #define EXCCODE_INT_END                (EXCCODE_INT_START + EXCCODE_INT_=
NUM - 1)
>
> -/* FPU register names */
> -#define LOONGARCH_FCSR0        $r0
> -#define LOONGARCH_FCSR1        $r1
> -#define LOONGARCH_FCSR2        $r2
> -#define LOONGARCH_FCSR3        $r3
> -
>  /* FPU Status Register Values */
>  #define FPU_CSR_RSVD   0xe0e0fce0
>
> @@ -1487,6 +1481,18 @@ __BUILD_CSR_OP(tlbidx)
>  #define FPU_CSR_RU     0x200   /* towards +Infinity */
>  #define FPU_CSR_RD     0x300   /* towards -Infinity */
>
> +#ifdef CONFIG_CC_IS_CLANG
> +#define LOONGARCH_FCSR0        0
> +#define LOONGARCH_FCSR1        1
> +#define LOONGARCH_FCSR2        2
> +#define LOONGARCH_FCSR3        3
> +#define read_fcsr(source)      __movfcsr2gr(source)
> +#define write_fcsr(dest, val)  __movgr2fcsr(dest, val)
> +#else /* CONFIG_CC_IS_CLANG */
> +#define LOONGARCH_FCSR0        $r0
> +#define LOONGARCH_FCSR1        $r1
> +#define LOONGARCH_FCSR2        $r2
> +#define LOONGARCH_FCSR3        $r3
>  #define read_fcsr(source)      \
>  ({     \
>         unsigned int __res;     \
Now the latest binutils also supports $fcsr, so I suggest to always
use inline asm, and change CONFIG_CC_IS_CLANG to
CONFIG_AS_HAS_FCSR_CLASS. And of course, Patch3 and Patch4 can be
merged then.

Huacai

> @@ -1503,5 +1509,6 @@ do {      \
>         "       movgr2fcsr      "__stringify(dest)", %0 \n"     \
>         : : "r" (val)); \
>  } while (0)
> +#endif /* CONFIG_CC_IS_CLANG */
>
>  #endif /* _ASM_LOONGARCH_H */
> --
> 2.40.0
>
