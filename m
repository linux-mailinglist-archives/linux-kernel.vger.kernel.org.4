Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED68A690C32
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjBIOva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjBIOv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:51:27 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9A15EA10
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:51:25 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id w5so3023315plg.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 06:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WgrBkIph/jwiixQwU37sRfxRXWlSvdzczRwmYx70sS4=;
        b=WaMY9P7mNb05w6GiSodo/CveTO2XR42pIKhsB9iwQIdLh3ueicdjJ3Ka2GSvC0IUpU
         vTvjXE49mUIwqs/h8ec5CGT5L7D3dgpjAAAHchun0uZ9Zh0+ZJBr66kyBuN3ghHmlQ6c
         z5pDEamlaTmxerDfTCaMewSmoWCpLtLesVUbV5ui2FlF5Pl6tjmU6EgmlpiO6aqt1AEL
         Qr9iqNDLC40Sh+BJSr35jUC9VE+0laJD/g8BFKt1NrAu1AAJ8cr8RZPZAWAeRevxTGJ3
         6ZcfwKmxlRL9VcIV3r4z3kIv7vkHMbkFM1zhGxW0NnSBF54jlJbCcwg2e6L4iGEdykCg
         IbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgrBkIph/jwiixQwU37sRfxRXWlSvdzczRwmYx70sS4=;
        b=IqUXj1AInk/+uVAHmu/20/1oEKDykWa2XyvTc2/J3fgfOnxx+ZikHOQ/jyHzodUzZM
         9A1aav+VLpO52F2fDgSfKupr/EO71Ca3d9JuvUwwUs7Q0N+oswKlpRKo3J0ocqGz2TMM
         Cb2Kz40Eohp7tCngPvIlQeCMEWPRQNaJnMWR7zY6LATJ2pLqlqJ5Q1D4Vff9WrAICkpM
         XM+Kwr/Z8Pv2fwoq+t3gsVcUuf1CCAmHCHw00wLlNT4+LtGwH5Z3LCn95rp8EYLNlxtY
         zWMulQXPPJftAGOWiO4ulJqkG+/ij9mTWFtmft7lk2dBkeDJKQxAbXukPm/RZ+hSPCzY
         wurw==
X-Gm-Message-State: AO0yUKX4XUTRnH3l3SNzkRwkcfQAm18XaI3cYG2eqr4qsvga0KB2i25m
        NQZg6ZDPSJ0BrmQLcqt6BGWdI8C+j4ehkom8IdRRcw==
X-Google-Smtp-Source: AK7set+/30YYhGlwN11LogLODt3RuDcUryTh1TjBFndJshB3McT3ir1tWBdsVsbnA7599MRkezDABWOckAtw0mY7UYI=
X-Received: by 2002:a17:90a:31a:b0:232:debf:eee9 with SMTP id
 26-20020a17090a031a00b00232debfeee9mr373595pje.32.1675954285074; Thu, 09 Feb
 2023 06:51:25 -0800 (PST)
MIME-Version: 1.0
References: <20221021073025.18831-1-wenchao.chen666@gmail.com>
 <22499ab9-340d-7059-b3ff-45342b0810cf@intel.com> <CA+Da2qyx7McYStMysPdK-DV9qiOnb9rvXYqqugxsbVgqqX59VQ@mail.gmail.com>
 <CAPDyKFq8JXO6q+_JFhSGWoVfSUEtowUX85kJpsVMa0jmEEjOiQ@mail.gmail.com> <CAPDyKFqg5GuJ=ChPgtVPnhJiNT3=XHXR_q3vwLUFj4ZXoQK5-A@mail.gmail.com>
In-Reply-To: <CAPDyKFqg5GuJ=ChPgtVPnhJiNT3=XHXR_q3vwLUFj4ZXoQK5-A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 9 Feb 2023 15:50:48 +0100
Message-ID: <CAPDyKFrtF32AvBKCbMESP7oFT2aBhbce0KA2zzXq+szQnShbww@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] mmc: block: Support Host to control FUA
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        axboe@kernel.dk, avri.altman@wdc.com, kch@nvidia.com,
        CLoehle@hyperstone.com, vincent.whitchurch@axis.com,
        bigeasy@linutronix.de, s.shtylyov@omp.ru,
        michael@allwinnertech.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, megoo.tang@gmail.com,
        lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022 at 13:04, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> [...]
>
> > >
> > > Considering the data integrity, we did a random power-down test, and
> > > the experimental results were good.
> > >
> > > FUA can only reduce data loss under abnormal conditions, but cannot
> > > prevent data loss under abnormal conditions.
> > >
> > > I think there should be a balance between FUA and NO FUA, but
> > > filesystems seem to favor FUA.
> > >
> > > FUA brings a drop in random write performance. If enough tests are
> > > done, NO FUA is acceptable.
> >
> > Testing this isn't entirely easy. It requires you to hook up
> > electrical switches to allow you to automate the powering on/off of
> > the platform(s). Then at each cycle, really make sure to stress test
> > the data integrity of the flash memory. Is that what the tests did -
> > or can you elaborate a bit on what was really tested?
> >
> > In any case, the performance impact boils down to how each eMMC/SD
> > card internally manages reliable writes vs regular writes. Some
> > vendors may treat them very similarly, while others do not.
> >
> > That said, trying to disable REQ_FUA from an mmc host driver is the
> > wrong approach, as also pointed out by Adrian above. These types of
> > decisions belong solely in the mmc core layer.
> >
> > Instead of what the $subject series proposes, I would rather suggest
> > we discuss (and test) whether it could make sense to disable REQ_FUA -
> > *if* the eMMC/SD card supports a write-back-cache (REQ_OP_FLUSH) too.
> > Hence, the mmc core could then announce only REQ_OP_FLUSH.
> >
>
> Below is a simple patch that does the above. We may not want to enable
> this for *all* eMMC/SD cards, but it works fine for testing and to
> continue the discussions here.
>
>
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Date: Fri, 11 Nov 2022 12:48:02 +0100
> Subject: [PATCH] mmc: core: Disable REQ_FUA if the card supports an internal
>  cache
>
> !!!! This is not for merge, but only for test and discussions!!!
>
> It has been reported that REQ_FUA can be costly on some eMMC devices. A
> potential option that could mitigate this problem, is to rely solely on
> REQ_OP_FLUSH instead, but that requires the eMMC/SD to support an internal
> cache. This is an attempt to try this out to see how it behaves.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  drivers/mmc/core/block.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index db6d8a099910..197e9f6cdaad 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -2494,15 +2494,15 @@ static struct mmc_blk_data
> *mmc_blk_alloc_req(struct mmc_card *card,
>                         md->flags |= MMC_BLK_CMD23;
>         }
>
> -       if (md->flags & MMC_BLK_CMD23 &&
> -           ((card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN) ||
> -            card->ext_csd.rel_sectors)) {
> +       if (mmc_cache_enabled(card->host)) {
> +               cache_enabled  = true;
> +       } else if (md->flags & MMC_BLK_CMD23 &&
> +                 (card->ext_csd.rel_param & EXT_CSD_WR_REL_PARAM_EN ||
> +                  card->ext_csd.rel_sectors)) {
>                 md->flags |= MMC_BLK_REL_WR;
>                 fua_enabled = true;
>                 cache_enabled = true;
>         }
> -       if (mmc_cache_enabled(card->host))
> -               cache_enabled  = true;
>
>         blk_queue_write_cache(md->queue.queue, cache_enabled, fua_enabled);
>
> --
> 2.34.1

Wenchao,

Did you manage to try the above patch to see if that could improve the
situation?

Kind regards
Uffe
