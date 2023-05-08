Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82356FA9F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbjEHK5L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 May 2023 06:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbjEHK4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:56:42 -0400
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888C43157F;
        Mon,  8 May 2023 03:55:42 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-55a2cb9788dso63753777b3.2;
        Mon, 08 May 2023 03:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683543341; x=1686135341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXVuozGjMiMrWrjFu+9+evbmgi0blgVrHrZxBs8JQ6Y=;
        b=OIKb6Fmmqc5E0y418umAhcu50WRuPv2pK/9I9uGszd+O+b7u5w6sJqRQZV/NZQrjQo
         cMIvNbUe7FrFrTw6idbQQZTIXDFUIuCsuZRc3xs3/wcoyB2yweS2X9akLLpx9zTk2Mca
         +c927eof0zDmKV27objm+i/M/IVAqvY/ep8PB3TVL55uPXu4IqD02KKAxnuhinuDNZeM
         Dz9iJMK60EdOIi/oXLDcaKo7sY2jo/PAxx1IfMsStnU+5/zo/pDIgC0hy1Ob+uzzI+of
         1FMttsqyE9e5km28974KSywqXeo+eCtzdYOVjcxMYVJ65Mn/pz/fGOcXxySPCJOMQWyR
         9TOw==
X-Gm-Message-State: AC+VfDzeB/fIBYmjOtEmlHQEMLwg4ZoNuHW/MBVJ/+WWyxSMkOnvWrlO
        drisJINJV3lLG3b1vtf56D2l7eP12IVDSg==
X-Google-Smtp-Source: ACHHUZ48DOf4liGxzXgh47S0pFjMdqBh2oF9xYeueImJ7FgSnlCPdwlCmeNb9nk5W+2yKSa1aERFhQ==
X-Received: by 2002:a81:9e01:0:b0:55a:9b89:4eff with SMTP id m1-20020a819e01000000b0055a9b894effmr10493076ywj.13.1683543341406;
        Mon, 08 May 2023 03:55:41 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id q188-20020a8180c5000000b0054f9e7fed7asm2413053ywf.137.2023.05.08.03.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 03:55:40 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-559e317eef1so64016527b3.0;
        Mon, 08 May 2023 03:55:40 -0700 (PDT)
X-Received: by 2002:a81:d510:0:b0:559:fad8:322f with SMTP id
 i16-20020a81d510000000b00559fad8322fmr11658525ywj.24.1683543339883; Mon, 08
 May 2023 03:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230506141703.65605-1-contact@artur-rojek.eu> <20230506141703.65605-3-contact@artur-rojek.eu>
In-Reply-To: <20230506141703.65605-3-contact@artur-rojek.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 May 2023 12:55:28 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV4hDULr43_4Z=Q9EHEvbzGStMRY45d4Ja1ixqSvMd2Cg@mail.gmail.com>
Message-ID: <CAMuHMdV4hDULr43_4Z=Q9EHEvbzGStMRY45d4Ja1ixqSvMd2Cg@mail.gmail.com>
Subject: Re: [PATCH 2/2] sh: dma: Correct the number of DMA channels in SH7709
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, May 6, 2023 at 4:22 PM Artur Rojek <contact@artur-rojek.eu> wrote:
> According to the PM, the DMAC found in SH7709 features only 4 channels.
>
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/sh/drivers/dma/Kconfig
> +++ b/arch/sh/drivers/dma/Kconfig
> @@ -28,8 +28,9 @@ config SH_DMA_API
>  config NR_ONCHIP_DMA_CHANNELS
>         int
>         depends on SH_DMA
> -       default "4" if CPU_SUBTYPE_SH7750  || CPU_SUBTYPE_SH7751  || \
> -                      CPU_SUBTYPE_SH7750S || CPU_SUBTYPE_SH7091
> +       default "4" if CPU_SUBTYPE_SH7709 || CPU_SUBTYPE_SH7750  || \
> +                      CPU_SUBTYPE_SH7751 || CPU_SUBTYPE_SH7750S || \
> +                      CPU_SUBTYPE_SH7091
>         default "8" if CPU_SUBTYPE_SH7750R || CPU_SUBTYPE_SH7751R || \
>                        CPU_SUBTYPE_SH7760
>         default "12" if CPU_SUBTYPE_SH7723 || CPU_SUBTYPE_SH7780  || \
> @@ -37,8 +38,9 @@ config NR_ONCHIP_DMA_CHANNELS
>         default "6"
>         help
>           This allows you to specify the number of channels that the on-chip
> -         DMAC supports. This will be 4 for SH7750/SH7751/Sh7750S/SH7091 and 8 for the

Might be a good opportunity to s/Sh7750S/SH7750S/

> -         SH7750R/SH7751R/SH7760, 12 for the SH7723/SH7780/SH7785/SH7724, default is 6.
> +         DMAC supports. This will be 4 for SH7709/SH7750/SH7751/Sh7750S/SH7091
> +         and 8 for the SH7750R/SH7751R/SH7760, 12 for the SH7723/SH7780/SH7785/SH7724,

... and sort the list for SoCs with 12 channels.

> +         default is 6.
>
>  config SH_DMABRG
>         bool "SH7760 DMABRG support"

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
