Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022DE5BCB7E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiISMJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiISMJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:09:30 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9DC2EF2B;
        Mon, 19 Sep 2022 05:08:40 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id s13so21625185qvq.10;
        Mon, 19 Sep 2022 05:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KS/gxblUALJXLFXXmMQoAb2wgZY09QTOGXemesGVN1o=;
        b=qqfBkY0ByNNm6YUMLdPXsHEMt1QQcpn5kN3QRlr3Mv2HbouuYJiOTD5Tm9/UiF4ULN
         C2MywjgvJHMMj7V5XwiGkqk9blR0s1XMgzWJFANI1W/3OAnoM5aiAbGdpHgxf1EXWNAc
         yvlS3QS0aDH42UDEBsWV1SpAdL1dtBSsfT/O3zi6lzuklQD5dqGrM5tfzLHkRD3dqKhO
         VNMyduA7XvQbASqdtl9HxwTID8XagX9c2af8wU434UU9ZspRmzcnVRBLxUcbiXAxHxAi
         YS6zrQ7juOIX6TvakkEatnvD7Ncs+0KF/zMrt6LAz7bCCSwEtuVD55QpOXGCuKBSBkNR
         g5GQ==
X-Gm-Message-State: ACrzQf2BY69ly8G+rdHxUzLaWtnAxG52QCmYgHiSLeGW71/JVK91xWms
        Rp6UY7mSV7puTDzdBdEwxjGEQNygTt+lmg==
X-Google-Smtp-Source: AMsMyM52kwv8gd9LYscUE17imUST2alXy1YuecMQArRSrBUCrLBlvA8jasaTIK9gSiBcxdWLjYQezg==
X-Received: by 2002:a05:6214:501b:b0:4a8:821d:5e68 with SMTP id jo27-20020a056214501b00b004a8821d5e68mr15161077qvb.23.1663589313476;
        Mon, 19 Sep 2022 05:08:33 -0700 (PDT)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id f3-20020ac84703000000b0035ba4e53500sm135640qtp.56.2022.09.19.05.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 05:08:33 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id b136so42204574yba.2;
        Mon, 19 Sep 2022 05:08:32 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr13157467ybl.604.1663589312639; Mon, 19
 Sep 2022 05:08:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220919115839.151442-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20220919115839.151442-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Sep 2022 14:08:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUaSLMtffr=7w7thY2T_5DvktUZOZaJ5vcuaLhJdtwN_A@mail.gmail.com>
Message-ID: <CAMuHMdUaSLMtffr=7w7thY2T_5DvktUZOZaJ5vcuaLhJdtwN_A@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a07g043: Hide WDT2 clock and reset
 entries for RZ/Five
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Mon, Sep 19, 2022 at 2:00 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Make the clock and reset entries for WDT2 only visible for RZ/G2UL (ARM64)
> as the RZ/Five SoC doesn't have the WDT2 channel.
>
> While at it, add the WDT2 clocks to r9a07g043_crit_mod_clks[] list as WDT
> CH2 is specifically to check the operation of Cortex-M33 CPU on the RZ/G2UL
> SoC and we dont want to turn off the clocks of WDT2 if it isn't enabled by
> Cortex-A55.
>
> Fixes: 95d48d270305 ("clk: renesas: r9a07g043: Add support for RZ/Five SoC")
> Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/clk/renesas/r9a07g043-cpg.c
> +++ b/drivers/clk/renesas/r9a07g043-cpg.c
> @@ -158,10 +158,12 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
>                                 0x548, 0),
>         DEF_MOD("wdt0_clk",     R9A07G043_WDT0_CLK, R9A07G043_OSCCLK,
>                                 0x548, 1),
> +#ifdef CONFIG_ARM64
>         DEF_MOD("wdt2_pclk",    R9A07G043_WDT2_PCLK, R9A07G043_CLK_P0,
>                                 0x548, 4),
>         DEF_MOD("wdt2_clk",     R9A07G043_WDT2_CLK, R9A07G043_OSCCLK,
>                                 0x548, 5),
> +#endif

Please move these into the existing section for arm64.

>         DEF_MOD("spi_clk2",     R9A07G043_SPI_CLK2, R9A07G043_CLK_SPI1,
>                                 0x550, 0),
>         DEF_MOD("spi_clk",      R9A07G043_SPI_CLK, R9A07G043_CLK_SPI0,
> @@ -269,7 +271,9 @@ static struct rzg2l_reset r9a07g043_resets[] = {
>         DEF_RST(R9A07G043_OSTM1_PRESETZ, 0x834, 1),
>         DEF_RST(R9A07G043_OSTM2_PRESETZ, 0x834, 2),
>         DEF_RST(R9A07G043_WDT0_PRESETN, 0x848, 0),
> +#ifdef CONFIG_ARM64
>         DEF_RST(R9A07G043_WDT2_PRESETN, 0x848, 2),
> +#endif

Likewise.

>         DEF_RST(R9A07G043_SPI_RST, 0x850, 0),
>         DEF_RST(R9A07G043_SDHI0_IXRST, 0x854, 0),
>         DEF_RST(R9A07G043_SDHI1_IXRST, 0x854, 1),


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
