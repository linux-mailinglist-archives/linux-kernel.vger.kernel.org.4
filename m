Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3E874D95B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 16:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjGJOzM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 10:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGJOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:55:10 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4B9C4;
        Mon, 10 Jul 2023 07:55:09 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-57026f4bccaso56864307b3.2;
        Mon, 10 Jul 2023 07:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689000909; x=1691592909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQQZF/DJEpnbM7efbsGJQo+4ik3HQAyQCDHp0Tr88ls=;
        b=X4aLOX/01pRtKRReGbAMFz1TDkcYPCB11diQN3+YrfZ6FnEj+ntNa7Xq3Jy0dkVdGt
         yv8I1Urc67nprYWHq18SfBaXyoNeEZTmOeFxRklOYpl/MnfwT3u7Ahxxfs+vFjxqgjY9
         ewTJSOyjB4llPII7lRAA+UCdETzKvSgsUhrc9Qnm2OJPlY3Udq4p4irSykPcKXYA/xmi
         TG463HE7ivyV0hvhHm4nrZmcrvI9ieWCxOugn+t0Q2H12nk5H74NqNku7/rMK8IV1zX3
         /XkFPN7BHeyEH0j82Egvc2+XibpCHcWn+o0h/Z+luh9YyjLZ4yta1EC54hsCAOv0u8Wd
         WHKQ==
X-Gm-Message-State: ABy/qLaTEpzBX2ap9kSUp3pJ6mMHBJStCwruMqs5sDjfN3yC1S//XG84
        lnSbHRh4UjccM2hojcxLRLP32WMRZgC+UA==
X-Google-Smtp-Source: APBJJlHNUX6+cZbVDjNJXQh7PI6PaYsZGJQ/EQ7GJroEJNcscMcFoCL7651viRy33hOal1iV/yte3Q==
X-Received: by 2002:a81:d24e:0:b0:57a:75b8:b790 with SMTP id m14-20020a81d24e000000b0057a75b8b790mr6013514ywl.29.1689000908908;
        Mon, 10 Jul 2023 07:55:08 -0700 (PDT)
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com. [209.85.219.175])
        by smtp.gmail.com with ESMTPSA id s7-20020a815e07000000b0056d443372f0sm3109243ywb.119.2023.07.10.07.55.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 07:55:08 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-bfe6ea01ff5so5659553276.3;
        Mon, 10 Jul 2023 07:55:08 -0700 (PDT)
X-Received: by 2002:a25:71c6:0:b0:c92:5f07:2d2c with SMTP id
 m189-20020a2571c6000000b00c925f072d2cmr267189ybc.12.1689000908544; Mon, 10
 Jul 2023 07:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230710140825.47793-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20230710140825.47793-1-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 16:54:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXr4CmupM9vadidHdyv0ShOhR2yYCCxeDt70d1rPUXBdg@mail.gmail.com>
Message-ID: <CAMuHMdXr4CmupM9vadidHdyv0ShOhR2yYCCxeDt70d1rPUXBdg@mail.gmail.com>
Subject: Re: [PATCH RFT] mmc: renesas_sdhi: register irqs before registering controller
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On Mon, Jul 10, 2023 at 4:10 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> IRQs should be ready to serve when we call mmc_add_host() via
> tmio_mmc_host_probe(). To achieve that, ensure that all irqs are masked
> before registering the handlers.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

> Based on 6.5-rc1 with bf54dec9e953 ("Revert "mmc: Revert "mmc: core:
> Allow mmc_start_host() synchronously detect a card") reverted. That base
> alone shows the regression. This patch works fine on a Salvator-X with a
> M3-W. I'll test more boards. Yet, I send it out so people can tests with
> boards I don't have.

I guess bf54dec9e953 is your local commit that reverts commit
fa700d73494abbd3 ("mmc: Revert "mmc: core: Allow mmc_start_host()
synchronously detect a card"") in v6.5-rc1?

> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -1004,10 +1004,11 @@ int renesas_sdhi_probe(struct platform_device *pdev,
>                 host->ops.start_signal_voltage_switch =
>                         renesas_sdhi_start_signal_voltage_switch;
>                 host->sdcard_irq_setbit_mask = TMIO_STAT_ALWAYS_SET_27;
> -               host->sdcard_irq_mask_all = TMIO_MASK_ALL_RCAR2;
>                 host->reset = renesas_sdhi_reset;
>         }
>
> +       host->sdcard_irq_mask_all = TMIO_MMC_MIN_RCAR2 ? TMIO_MASK_ALL_RCAR2 : TMIO_MASK_ALL;

The condition above is always true. I assume you wanted to test
"mmc_data->flags & TMIO_MMC_MIN_RCAR2" instead?

> +
>         /* Orginally registers were 16 bit apart, could be 32 or 64 nowadays */
>         if (!host->bus_shift && resource_size(res) > 0x100) /* old way to determine the shift */
>                 host->bus_shift = 1;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
