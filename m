Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBB9723CA9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjFFJMi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 6 Jun 2023 05:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjFFJMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:12:19 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73210109;
        Tue,  6 Jun 2023 02:12:18 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-bb131cd7c4aso5079199276.1;
        Tue, 06 Jun 2023 02:12:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686042737; x=1688634737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+0vZf4sZHrRYSSyyJCG/B7w9fRCzQCnK8geH62rIys=;
        b=FwImVrDiSVBQANbLm0hAHYnopHqJPxh/wCwjSp46Zegptd3UEkCuKmKbteP1tewvcY
         eYz2aRioiNMSyxB4NOva6p0hOLi97yrhNj+sjpGeCdSV03A/Xh+Fp4UxrobTHaj/87NG
         BwKbYG4ne2fBq1jr5WEI1/vjxxOm1m2XMjS4/llhB9lpx2Lgmwey3mnH8Z2ZVh1gAacX
         G4NrggEKJ8ZtEUstUmqkImf8B6pl1eE2fB0vjK+OU8DmzOr/O49lVsEKwEcLfpHp8lMV
         ll3LdDxKLnHcBcc2wo7ZntErQhkAoiu7ol+fIgBwTOqQjc6PreoHLOptk5++/vtw2mYh
         21WQ==
X-Gm-Message-State: AC+VfDzKUziE5Exdc2nkNKkfXl4UpyuOTNofMT3zTXb9W8U9KbmkWPVO
        X2YlsHLPa77sgt6sf37XlVtm/i6FDyV3Eg==
X-Google-Smtp-Source: ACHHUZ61EyzKVwKqO5mKTUirCtO75LMH+ISg8RCloqSTgVBNfwranCtzBi25B2ADNPv4MB/Nz+aNMw==
X-Received: by 2002:a81:8686:0:b0:565:d517:e714 with SMTP id w128-20020a818686000000b00565d517e714mr1318567ywf.25.1686042737377;
        Tue, 06 Jun 2023 02:12:17 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id t205-20020a8183d6000000b0055a416529bbsm3893447ywf.24.2023.06.06.02.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 02:12:17 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-565aa2cc428so53258617b3.1;
        Tue, 06 Jun 2023 02:12:17 -0700 (PDT)
X-Received: by 2002:a81:4e0f:0:b0:55a:6f26:4fbf with SMTP id
 c15-20020a814e0f000000b0055a6f264fbfmr1179758ywb.35.1686042736916; Tue, 06
 Jun 2023 02:12:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230522105257.562cb1ec@canb.auug.org.au> <ZGr6aB9uJVnyfJQ9@gondor.apana.org.au>
 <20230523103637.20175fbc@canb.auug.org.au> <ZGwmAp5RPqAjVMCg@gondor.apana.org.au>
In-Reply-To: <ZGwmAp5RPqAjVMCg@gondor.apana.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Jun 2023 11:12:05 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU5pBh8bk21Xrzk0Ocs7cAF+QTLn60uKOHa1z=TB6Lcuw@mail.gmail.com>
Message-ID: <CAMuHMdU5pBh8bk21Xrzk0Ocs7cAF+QTLn60uKOHa1z=TB6Lcuw@mail.gmail.com>
Subject: Re: [PATCH] crypto: starfive - Depend on AMBA_PL08X instead of
 selecting it
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linux Crypto List <linux-crypto@vger.kernel.org>,
        Huan Feng <huan.feng@starfivetech.com>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Tue, May 23, 2023 at 4:40 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, May 23, 2023 at 10:36:37AM +1000, Stephen Rothwell wrote:
> > That did not fix it :-(
>
> OK, this patch should fix it:
>
> ---8<---
> A platform option like AMBA should never be selected by a driver.
> Use a dependency instead.

FTR:

arch/arm/mach-s3c/Kconfig.s3c64xx=config S3C64XX_PL080
arch/arm/mach-s3c/Kconfig.s3c64xx-      def_bool DMADEVICES
arch/arm/mach-s3c/Kconfig.s3c64xx:      select AMBA_PL08X

>
> Also remove the depenency on DMADEVICES because the driver builds
> just fine without it.  Instead add a dependency on HAS_DMA for dma
> mapping support.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/drivers/crypto/starfive/Kconfig b/drivers/crypto/starfive/Kconfig
> index 908c162ba79a..59002abcc0ad 100644
> --- a/drivers/crypto/starfive/Kconfig
> +++ b/drivers/crypto/starfive/Kconfig
> @@ -4,14 +4,13 @@
>
>  config CRYPTO_DEV_JH7110
>         tristate "StarFive JH7110 cryptographic engine driver"
> -       depends on (SOC_STARFIVE || COMPILE_TEST) && DMADEVICES
> +       depends on SOC_STARFIVE || AMBA_PL08X || COMPILE_TEST
> +       depends on HAS_DMA
>         select CRYPTO_ENGINE
>         select CRYPTO_HMAC
>         select CRYPTO_SHA256
>         select CRYPTO_SHA512
>         select CRYPTO_SM3_GENERIC
> -       select ARM_AMBA
> -       select AMBA_PL08X
>         help
>           Support for StarFive JH7110 crypto hardware acceleration engine.
>           This module provides acceleration for public key algo,

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
