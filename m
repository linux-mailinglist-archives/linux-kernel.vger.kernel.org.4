Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6286A8005
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 11:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjCBKhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 05:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCBKhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 05:37:37 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2757D3B646
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 02:37:35 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q189so9483730pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 02:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2DvH5++MlDywKUnWf+1loQwzv2jg1mWmFa8pnuwjqdM=;
        b=CArXlKRa5bv3qRQell+oUvTIEi+MvMAR9T9N3YQpRL12m7q0/lh+DQRBYtazTeLamN
         q7z8p5r31Dfjqp3wg350PMMy+EN5mx2LMQ40lZHYsWL9Md8HmIvksmp9QzpRoPA6tXJw
         +OGzhmJ/UBcbM3aHt/WTCtQGywfYhiGNJ8gVrSfBJfGWxSOepjgSyz9gtcJm9q22UUGn
         0B3n1KjzjWM4PkN21PNaE/ZHxsDqkwVaud1pRpF2o52WavI8OYG5qh3oV9tB+GXGW0XJ
         g5ZG3VWgzvRIzScqpqhOF9zm4PaOgC1lWUkq/Cr+GMsLPGRXJl7duV3TIFKTvXQWIyvF
         gImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DvH5++MlDywKUnWf+1loQwzv2jg1mWmFa8pnuwjqdM=;
        b=syUZoOnAJ+menM1iwpMRTsFHv2mNYapk3gPFvMjP5GyZwnYZ43GNEuU43U0MFSRfDF
         t9tVMM/ar9Mq0uzwKuZHxk+u4Ym+spIyzTrxUEH8L7Kis/MVw1c2iCpN42Xhwr5RRvXm
         vky6bmI1nNmrwCtcOMmlyulmgkIkgAwlwL6lBswDvbJFNyq7u53neD5vajyWaPtmZ2Yu
         C+30mw2zWeLmi8tYLOR0VOPimM7fucshQlPKLysQtiXRJj0FR/je9zEai4SEul85krWe
         NhA9gi0zZYsS6YpgwFYnjkw04tG8dTM3MQdscRpWYc6VFpm/cujV0FnoaugZAgPCu8hW
         VZwA==
X-Gm-Message-State: AO0yUKUaSTZFr5lU9eBl1ln6AdIA76PeAktCAiksgie/r35fYdcWR7/U
        XzdZPrECw5P9MSPh8g2gESzV8+qBBBHV8kMhaQt1LQLOFPu13rDl
X-Google-Smtp-Source: AK7set97u0zAstt60brd/DEvp8rkt1vEK1Zs7cBKJ8KNFM0kwIC9D72SwDaTRtCCYH7xz1TcI3XO17bEKAKts14WXxE=
X-Received: by 2002:a63:b21b:0:b0:503:a8:2792 with SMTP id x27-20020a63b21b000000b0050300a82792mr3273725pge.5.1677753454377;
 Thu, 02 Mar 2023 02:37:34 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+vNU2SC_Q3RWdeO9-mKDYC_TK8_vzefvGz_++O8StJer_h3Q@mail.gmail.com>
In-Reply-To: <CAJ+vNU2SC_Q3RWdeO9-mKDYC_TK8_vzefvGz_++O8StJer_h3Q@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Mar 2023 11:36:58 +0100
Message-ID: <CAPDyKFq23_vCunapQ=OHFFGXs5a8_cr8w7hBUP=HQ5f2zaTBUg@mail.gmail.com>
Subject: Re: mmc: core: Disable card detect during shutdown
To:     Tim Harvey <tharvey@gateworks.com>,
        Robert Richter <rric@kernel.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Jan Glauber <jan.glauber@gmail.com>
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

+ Robert

On Thu, 2 Mar 2023 at 00:32, Tim Harvey <tharvey@gateworks.com> wrote:
>
> Greetings,
>
> I've encountered a hang on shutdown on octeontx (CN8030 SoC, THUNDERX
> architecture) that I bisected to commit 66c915d09b94 ("mmc: core:
> Disable card detect during shutdown").
>
> It looks like the OMP5 Pyra ran into this as well related to a
> malfunctioning driver [1]
>
> In the case of MMC_CAVIUM_THUNDERX the host controller supports
> multiple slots each having their own CMD signal but shared clk/data
> via the following dt:
>
> mmc@1,4 {
>         compatible = "cavium,thunder-8890-mmc";
>         reg = <0xc00 0x00 0x00 0x00 0x00>;
>         #address-cells = <0x01>;
>         #size-cells = <0x00>;
>         clocks = <0x0b>;
>
>         /* eMMC */
>         mmc-slot@0 {
>                 compatible = "mmc-slot";
>                 reg = <0>;
>                 vmmc-supply = <&mmc_supply_3v3>;
>                 max-frequency = <35000000>;
>                 no-1-8-v;
>                 bus-width = <8>;
>                 no-sdio;
>                 no-sd;
>                 mmc-ddr-3_3v;
>                 cap-mmc-highspeed;
>         };
>
>         /* microSD */
>         mmc-slot@1 {
>                 compatible = "mmc-slot";
>                 reg = <1>;
>                 vmmc-supply = <&mmc_supply_3v3>;
>                 max-frequency = <35000000>;
>                 no-1-8-v;
>                 broken-cd;
>                 bus-width = <4>;
>                 cap-sd-highspeed;
>         };
> };
>
> mmc_add_host is only called once for mmc0 and I can't see any printk

That looks wrong. There needs to be one mmc host registered per slot,
otherwise things will, for sure, not work.

I suggest you have a closer look to see what goes on in thunder_mmc_probe().

> debugging added to __mmc_stop_host (maybe because serial/console has
> been disabled by that point?).

The serial console should work fine at this point, at least on those
systems that I have tested this code with.

Perhaps you added the debug print too late in the function, if the
calls to disable_irq() or cancel_delayed_work_sync() are hanging?

>
> It appears that what causes this hang is the 'broken-cd' which enables
> the detect change polling on mmc1. I have the ability to flip the CMD
> signal routing thus making mmc0 the microSD and mmc1 the eMMC and when
> I do that there isn't an issue so I think what happens is in the case
> where mmc polling is enabled on mmc1 but not mmc0 (as above) the
> polling causes a hang after __mmc_stop_host() is called for mmc0.

The code in __mmc_stop_host() has been tested for both polling and
gpio card detections. That said, it looks to me that there is
something weird going on in the cavium mmc driver.

What makes this even tricker, is that it's uncommon and not
recommended to use more than one mmc slot per host instance.

>
> Any ideas?

I hope the above thoughts can point you in a direction to narrow down
this problem.

>
> Best Regards,
>
> Tim
>
> [1] https://lore.kernel.org/all/55A0788B-03E8-457E-B093-40FD93F1B9F3@goldelico.com/

Kind regards
Uffe
