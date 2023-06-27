Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3DC740202
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjF0RU0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Jun 2023 13:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjF0RUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:20:24 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B65198;
        Tue, 27 Jun 2023 10:20:23 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-570284c7e61so52181587b3.1;
        Tue, 27 Jun 2023 10:20:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687886422; x=1690478422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=we44SmO7mtsdbPqwEUGs/5m3S42M0ZPz1W2IALKFOrI=;
        b=PuTzqYQNGyV9EDRNgMNrWQJEUX4K98nUKRMkdnji/c8b+SEIhnbsAFY9g9P8H3N0df
         FDpWqupci0f/Ar/ewMhrbDdCcnMAVy6Ej0Pyym0WmDLeFCSG4KWhjf10eOJ/D65UmJq6
         1XC6vH+UWsvOGjbOjOx/9Knx32tZB7ntbD0SLm376+Y/H2mZoDhewqPW3v7PeJLV20+v
         BWkpn7RVZHvr9p6Jic521lnR1yF66q+ZFmpKMsLz7svbw5J3/uP4ZqoeP+zws+ej8/oc
         Par9dg48h1xfCFzNquPxUr5yTv3xLsOePsMuPT6Z4xPkq8CmCuMpSi276MyehzaDFP2I
         x1ew==
X-Gm-Message-State: AC+VfDwh6p0wwudVDNbHuzEGgih2oba9U/5FR1c8ilHoq9xCxlEE4/C2
        VT2cDdFeiP+XjSaVPAgzA4WizsH/wXI1uP78
X-Google-Smtp-Source: ACHHUZ6wewllzRH48EmvkoG89o5K0oUHe0FOy1quWsvNv2z2ZQfyLyjVZp8PFu/+jMtSqmWyh7CXpw==
X-Received: by 2002:a81:6f54:0:b0:570:8856:5dbc with SMTP id k81-20020a816f54000000b0057088565dbcmr31372303ywc.41.1687886421982;
        Tue, 27 Jun 2023 10:20:21 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id m5-20020a819e05000000b00568a207aaedsm1865118ywj.68.2023.06.27.10.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 10:20:21 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-be30cbe88b3so4700827276.1;
        Tue, 27 Jun 2023 10:20:21 -0700 (PDT)
X-Received: by 2002:a25:d207:0:b0:ba8:2e05:3e9c with SMTP id
 j7-20020a25d207000000b00ba82e053e9cmr29434011ybg.24.1687886421253; Tue, 27
 Jun 2023 10:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230329202148.71107-1-dennis@kernel.org> <ZCTOMVjW+pnZVGsQ@snowbird>
In-Reply-To: <ZCTOMVjW+pnZVGsQ@snowbird>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Jun 2023 19:20:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVK2zPnyB9s0uYwoKj0xspa0CRzqPjhrj-YFqVNdXxEkg@mail.gmail.com>
Message-ID: <CAMuHMdVK2zPnyB9s0uYwoKj0xspa0CRzqPjhrj-YFqVNdXxEkg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: inline the first mmc_scan() on mmc_start_host()
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
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

Hi Dennis,

On Thu, Mar 30, 2023 at 1:48 AM Dennis Zhou <dennis@kernel.org> wrote:
> When using dm-verity with a data partition on an emmc device, dm-verity
> races with the discovery of attached emmc devices. This is because mmc's
> probing code sets up the host data structure then a work item is
> scheduled to do discovery afterwards. To prevent this race on init,
> let's inline the first call to detection, __mm_scan(), and let
> subsequent detect calls be handled via the workqueue.
>
> Signed-off-by: Dennis Zhou <dennis@kernel.org>

Thanks for your patch, which is now commit 2cc83bf7d41113d9 ("mmc:
core: Allow mmc_start_host() synchronously detect a card") in
linux-next/master mmc/next next-20230614 next-20230615 next-20230616

I have bisected the following failure on Renesas Salvator-XS with R-Car H3
ES2.0 to the above commit:

    renesas_sdhi_internal_dmac ee140000.mmc: timeout waiting for
hardware interrupt (CMD0)
    renesas_sdhi_internal_dmac ee140000.mmc: timeout waiting for
hardware interrupt (CMD1)
    renesas_sdhi_internal_dmac ee140000.mmc: timeout waiting for
hardware interrupt (CMD0)
    renesas_sdhi_internal_dmac ee140000.mmc: timeout waiting for
hardware interrupt (CMD1)
    mmc0: Failed to initialize a non-removable card

Reverting the commit fixes the issue for me.

> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2185,10 +2185,8 @@ int mmc_card_alternative_gpt_sector(struct mmc_card *card, sector_t *gpt_sector)
>  }
>  EXPORT_SYMBOL(mmc_card_alternative_gpt_sector);
>
> -void mmc_rescan(struct work_struct *work)
> +static void __mmc_rescan(struct mmc_host *host)
>  {
> -       struct mmc_host *host =
> -               container_of(work, struct mmc_host, detect.work);
>         int i;
>
>         if (host->rescan_disable)
> @@ -2249,6 +2247,14 @@ void mmc_rescan(struct work_struct *work)
>                 mmc_schedule_delayed_work(&host->detect, HZ);
>  }
>
> +void mmc_rescan(struct work_struct *work)
> +{
> +       struct mmc_host *host =
> +               container_of(work, struct mmc_host, detect.work);
> +
> +       __mmc_rescan(host);
> +}
> +
>  void mmc_start_host(struct mmc_host *host)
>  {
>         host->f_init = max(min(freqs[0], host->f_max), host->f_min);
> @@ -2261,7 +2267,8 @@ void mmc_start_host(struct mmc_host *host)
>         }
>
>         mmc_gpiod_request_cd_irq(host);
> -       _mmc_detect_change(host, 0, false);
> +       host->detect_change = 1;
> +       __mmc_rescan(host);
>  }
>
>  void __mmc_stop_host(struct mmc_host *host)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
