Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7D62F001
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbiKRIry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241276AbiKRIra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:47:30 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BF213E84
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:46:25 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id f3so4459178pgc.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O4o2lpMlk9nMfsW2UbDxsnQVEI8k+iF2dcDvZUBBRXk=;
        b=rWqF8mvWeDHZf+4YtTcHg25bwDhGlBZWJzEqQtZgAqZe2EfN8k08xEH9FU0YL8Zofs
         FJGCOTy16LAUeBUyziYPlFZmQ5LQBgCt4pLTikMnTkIeg17EGhOE9yD1tQcBdPIooO5L
         7vlbvTaYV3DNS3BkAxiRd/66hL/WshSCKxSibfDdFhMwsWBy4xWE1RqIEzCcsxVlKN4Z
         BNRcbJy60LQRqwYNTzqnPh2jC5iz4PSxWP1eayPHrfB+G95c4MIG6cgoq1OElUSI0it/
         k5u6BbSzeHAi2+D5tQFB9EhqTh+NIf9sSabyBX4b/cbH/r8GZk5q18jmi4SuhIEr1gpl
         v/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O4o2lpMlk9nMfsW2UbDxsnQVEI8k+iF2dcDvZUBBRXk=;
        b=ksHol2rcK5R68qaXwno2+UKeo7pWk1pSLWCxkNbw+ET7nzJFOj6WGeuHXEj1pIslA0
         E464KZeRKhMXTI76Wc4xhz9LWg9m9legkGcMFfcKJSknN77A8/4lAmBBdqpNTtjbyD4a
         MRVpVJC5+oxOmMUH6GpZetDFbm+doTTxPcnG2nhwYXOIdLMcJ1tkYNewcG0LP9Yb7Qyg
         5IyrllvrAMtIOXO7OCRvWnpwoJUtemXkZQzlUvIDR4f7e9cUDTUEqmsWv0cR2aIqux6L
         S4I7J6Oo9kI45g9sbA7wARcDpg8x4yH1aUqDmUEjtVRzce9+w3iYpykbRXm+e+PJ86W8
         ErBQ==
X-Gm-Message-State: ANoB5plhc0N27p/nXLyNBRZa0Su3WjoVvR9PRuhfjoh45uThOXLxUiOy
        nomrtEu++nBZ4oWPq7WpKbRFlbrI6K3UiVCrLSCRJw==
X-Google-Smtp-Source: AA0mqf4axdzUGsd3ztrxougeoe8WIqqIteJIKbLXPG7ewSDBk4rpwXnQ0D4JyF7rDvn81OBS60MR/MU/f0Va1WqbCX4=
X-Received: by 2002:a63:4285:0:b0:477:15c8:cd8a with SMTP id
 p127-20020a634285000000b0047715c8cd8amr4354532pga.595.1668761184769; Fri, 18
 Nov 2022 00:46:24 -0800 (PST)
MIME-Version: 1.0
References: <20221108045300.2084671-1-lis8215@gmail.com> <20221108045300.2084671-2-lis8215@gmail.com>
In-Reply-To: <20221108045300.2084671-2-lis8215@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Nov 2022 09:45:48 +0100
Message-ID: <CAPDyKFrMqCL1-faBadVP3xB-5qiCYsyRUuOHbFZuOWfLdCXwig@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: jz4740: Don't change parent clock rate for some SoCs
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 at 05:53, Siarhei Volkau <lis8215@gmail.com> wrote:
>
> Some SoCs have one clock divider for all MMC units, thus changing one
> affects others as well. This leads to random hangs and memory
> corruptions, observed on the JZ4755 based device with two MMC slots
> used at the same time.

Urgh, that sounds like broken HW to me.

The MMC blocks could share a parent clock (that would need a fixed
rate for it to be applied), assuming there is a separate gate/divider
available per block. But there isn't'?

>
> List of SoCs affected includes: JZ4725b, JZ4755, JZ4760 and JZ4760b.
> However, the MMC driver doesn't distinguish JZ4760 and JZ4770
> which shall remain its behavior. For the JZ4755 is sufficient to
> use JZ4725b's binding. JZ4750 is outside of the patch.
>
> The MMC core has its own clock divisor, rather coarse but suitable well,
> and it shall keep the role of tuning clock for the MMC host in that
> case.

The mmc core doesn't have a clock divisor, but it does control the bus
clock frequency through the ->set_ios() host ops. It needs to do that,
to be able to conform to the (e)MMC, SD and SDIO specifications.

Can you please try to elaborate on the above, so I can better
understand your point?

>
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>

Kind regards
Uffe

> ---
>  drivers/mmc/host/jz4740_mmc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
> index dc2db9c18..d390ff31d 100644
> --- a/drivers/mmc/host/jz4740_mmc.c
> +++ b/drivers/mmc/host/jz4740_mmc.c
> @@ -114,6 +114,7 @@ enum jz4740_mmc_version {
>         JZ_MMC_JZ4740,
>         JZ_MMC_JZ4725B,
>         JZ_MMC_JZ4760,
> +       JZ_MMC_JZ4770,
>         JZ_MMC_JZ4780,
>         JZ_MMC_X1000,
>  };
> @@ -887,7 +888,13 @@ static int jz4740_mmc_set_clock_rate(struct jz4740_mmc_host *host, int rate)
>         int real_rate;
>
>         jz4740_mmc_clock_disable(host);
> -       clk_set_rate(host->clk, host->mmc->f_max);
> +
> +       /*
> +        * Changing rate on these SoCs affects other MMC units too.
> +        * Make sure the rate is configured properly by the CGU driver.
> +        */
> +       if (host->version != JZ_MMC_JZ4725B && host->version != JZ_MMC_JZ4760)
> +               clk_set_rate(host->clk, host->mmc->f_max);
>
>         real_rate = clk_get_rate(host->clk);
>
> @@ -992,6 +999,7 @@ static const struct of_device_id jz4740_mmc_of_match[] = {
>         { .compatible = "ingenic,jz4740-mmc", .data = (void *) JZ_MMC_JZ4740 },
>         { .compatible = "ingenic,jz4725b-mmc", .data = (void *)JZ_MMC_JZ4725B },
>         { .compatible = "ingenic,jz4760-mmc", .data = (void *) JZ_MMC_JZ4760 },
> +       { .compatible = "ingenic,jz4770-mmc", .data = (void *) JZ_MMC_JZ4770 },
>         { .compatible = "ingenic,jz4775-mmc", .data = (void *) JZ_MMC_JZ4780 },
>         { .compatible = "ingenic,jz4780-mmc", .data = (void *) JZ_MMC_JZ4780 },
>         { .compatible = "ingenic,x1000-mmc", .data = (void *) JZ_MMC_X1000 },
> --
> 2.36.1
>
