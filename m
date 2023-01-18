Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F72C671EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjARN7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:59:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjARN6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:58:04 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B6A554B0C
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:33:06 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id mg12so10925143ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r/MdaMfGpngTvDj1TEFnHjyrcQTvG4jCt3QryBUQJFc=;
        b=ZZupgezhFoK3Ma5R4scdDL1xnc4rtd41/9W6aJRWZax9QBq3W0G3zCGVJW0U42iCYd
         4KvJbYbw4CQi67BClvaNwX37mzcqLlr0nmJnmb8jvbyaQXvQkAtNOap+C+bD8nXs+OR8
         3toqCE8yeR4NEL9Ne0r+XcH19jWXeAMlNKwv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r/MdaMfGpngTvDj1TEFnHjyrcQTvG4jCt3QryBUQJFc=;
        b=HLy/iC9X/UofbvMTVjkMhbYzDmlNJux2yA4/dgmCGHngKM1ZhHZDrmOMsO7TeJLJvW
         TgnZEgYmPTCWSad0UL13kJlz8wbHTCHHMG2+rCUNOsHpq2wMqWP0eqYDpgwx4sjIRSQk
         ISeTb3BTFQs1igMrtff0kqna6JaI0IR/6EDZIh7BKKNNFkA449k/gQxyNjfNP44CmnnD
         yiVUNf6yulEA0mDLj5vdGW+YZStaMC4jQ68lqIr7d9eGjWZ60rNqopqIWLBvlzOIwyXD
         4v9cGSWGOlI9fdOrvLqF1KaHL1XcYS6gRlbyVhPDx3+eM7NSfFV9VUp8/eV6B03Mriki
         AeEg==
X-Gm-Message-State: AFqh2kqiz8iZNyzCT5Bs8lYd/k3mIkRX+QFyTwO+8ebOEQb4A+Df/bl2
        pZyEH32F7BuPikyN3fe37LCF6c3fD1G3PFcXbbwqJQ==
X-Google-Smtp-Source: AMrXdXty6aY2Hc4VxG7Ode8zCbjODFHEqzOLgr86xygYZq3+W86ERvY0w5qF42m7zwo4OhQfVchNKrC1JPZn0ehrxtI=
X-Received: by 2002:a17:906:7109:b0:84d:1502:a8b4 with SMTP id
 x9-20020a170906710900b0084d1502a8b4mr553373ejj.295.1674048784788; Wed, 18 Jan
 2023 05:33:04 -0800 (PST)
MIME-Version: 1.0
References: <52861a84-0fe2-37f0-d66a-145f2ebe1d79@gmail.com>
 <20221214134620.3028726-1-peter.suti@streamunlimited.com> <c6863a3e-8855-50fe-25cb-0b38bc3a05e0@gmail.com>
 <CACMGZgZY4Zb+3vHUDAS0+3r55K4_J40dtbsTPTFZMd6duBikpQ@mail.gmail.com> <7c4aa0d2-d8e9-416b-b2ad-f5c3c8ea33de@gmail.com>
In-Reply-To: <7c4aa0d2-d8e9-416b-b2ad-f5c3c8ea33de@gmail.com>
From:   Peter Suti <peter.suti@streamunlimited.com>
Date:   Wed, 18 Jan 2023 14:32:53 +0100
Message-ID: <CACMGZgaS7z2YoViA3jV-gVBvASSq1maiGj_6hfrJQ3zr69esgQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: meson-gx: fix SDIO interrupt handling
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 10:27 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 09.01.2023 12:52, Peter Suti wrote:
> > On Wed, Dec 14, 2022 at 10:33 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>
> >> On 14.12.2022 14:46, Peter Suti wrote:
> >>>
> >>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> >>> index 6e5ea0213b47..7d3ee2f9a7f6 100644
> >>> --- a/drivers/mmc/host/meson-gx-mmc.c
> >>> +++ b/drivers/mmc/host/meson-gx-mmc.c
> >>> @@ -1023,6 +1023,22 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
> >>>       if (ret == IRQ_HANDLED)
> >>>               meson_mmc_request_done(host->mmc, cmd->mrq);
> >>>
> >>> +     /*
> >>> +     * Sometimes after we ack all raised interrupts,
> >>> +     * an IRQ_SDIO can still be pending, which can get lost.
> >>> +     *
> >>
> >> A reader may scratch his head here and wonder how the interrupt can get lost,
> >> and why adding a workaround instead of eliminating the root cause for losing
> >> the interrupt. If you can't provide an explanation why the root cause for
> >> losing the interrupt can't be fixed, presumably you would have to say that
> >> you're adding a workaround for a suspected silicon bug.
> > After talking to the manufacturer, we got the following explanation
> > for this situation:
>
> To which manufacturer did you talk, Marvell or Amlogic?

Amlogic

>
> > "wifi may have dat1 interrupt coming in, without this the dat1
> > interrupt would be missed"
>
> I don't understand this sentence. W/o the interrupt coming in
> the interrupt would be missed? Can you explain it?

So the "without this" part of that sentence referred to the patch.
Which means that without the patch, the interrupt can be missed.

>
> > Supposedly this is fixed in their codebase.
>
> Which codebase do you mean? A specific vendor driver? Or firmware?

The vendor driver from openlinux2.amlogic.com handles SDIO interrupts
a bit differently. It uses mmc_signal_sdio_irq()

>
> > Unfortunately we were not able to find out more and can't prepare a
> > patch with a proper explanation.
>
> The workaround is rather simple, so we should add it.
> It's just unfortunate that we have no idea about the root cause of the issue.

After doing a more long term stress test, it was revealed that this
patch is still not sufficient, but only masks the underlying problem
better. Reverting 066ecde fixes the issue fully for us (verified
overnight with iperf).
v1 and v2 also fix the issue, but v3 does not correct the bug when
WiFi is stressed for a longer time. And therefore it should not be
used.
Could you please give us some advice on how to investigate this further?
