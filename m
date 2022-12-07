Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4662C645A4E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLGNB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLGNBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:01:52 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFD35133D;
        Wed,  7 Dec 2022 05:01:51 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id bn5so20840171ljb.2;
        Wed, 07 Dec 2022 05:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=58n9OnzkX+f+tALJ3x9hXjitd2F/uK0zQDu7nLFK8BM=;
        b=Wb7aJUSwSAqnww08AQep8NInEPaa3G9cUjc8sQqZCF2rSZLiFiCkbPvi90Q2W/JB50
         AkZ0elNUWOZAg6iyS7IFebYNSJCSfUVNBIpyGC09Wu/HfrXcsqaxszfmVUhIfIbdz+tG
         G+oCaum5ZcLDLT9G7P/Z0Agwbw7BLr4LKCvjVbpsts29SYIH+YuFthAG5XZtiKOgPS/P
         ZthMdAxkIZxycgbGnmvGTYQR3cEhqarrfoenHuJepkHLokhiBap+28SWnHwc7p6Shlxp
         nwxvkfNOpUxUFzKkXI8arTvSilK593jhVasK23lsIaSSOhsg/gGZL6ZmBnWC095w8U3Y
         noGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=58n9OnzkX+f+tALJ3x9hXjitd2F/uK0zQDu7nLFK8BM=;
        b=AIX2JyowqM1l8YEOax8X0uC/g/lloZEwk9L64AJfFeqmBWI2a411Oy7hNxEah0EHdS
         fnLMQrTvwoYn+xpHq1s3G/A1AdUgL9SQSdrCEo/72U5Dl/AOpMDqdJQfcC4KKHmnjPhp
         4cMBErd58yiyOYoesBvgRH3z63a7pD6twt2TNlA3ha67UGvsDb+jl0PM8GGAo1QI5FBr
         fPYWICOj8gyC/P9aZaQSaZyQkrQ29tf33cWtcqYBKRnjlZKDDJH2b9CGwbyjBGWc5SeT
         LCUO2hDYcpxl9vgZ+p06pgNgsVZkTOrQ9pRBVf6saC9jx9jqVAzZUZSMwWWyEhgK4bOe
         UPgQ==
X-Gm-Message-State: ANoB5pnnbVTeLLODKxw78frcFvk/DokvFeBFXeDn45zbW0mrhqRt9Rw5
        V+XwIUNiuNxKTihI1DPcKgToSzM/MAyeXi866nk=
X-Google-Smtp-Source: AA0mqf6Ide4+sp8VWwohGr/fTMvzoa8oN76VSzU4an/ivwpfuzoPSBg3rAh6NB3hKlkh7TXGWyqSO8u/qTTMSXywbfY=
X-Received: by 2002:a05:651c:c85:b0:278:f572:c9ac with SMTP id
 bz5-20020a05651c0c8500b00278f572c9acmr30906647ljb.73.1670418109344; Wed, 07
 Dec 2022 05:01:49 -0800 (PST)
MIME-Version: 1.0
References: <20221205085351.27566-1-tmaimon77@gmail.com> <20221205085351.27566-3-tmaimon77@gmail.com>
 <CAHp75VeAzgCUiH5Z1pVJ-4X29aCK44q907DRQXX75zS4oEhHHg@mail.gmail.com>
 <CAP6Zq1gi7-pA9wdO3=V9Uf0+pKPTHwWw66MfbYmOwodoXeRDqA@mail.gmail.com>
 <CAHp75VctiJvvk-6AWfQSU9psHvPeKECaCWPuKL9YQ_-Vt3GBGA@mail.gmail.com>
 <c200557f-c30a-62f9-287a-af804e818cf1@intel.com> <CAHp75VczbNpHPi-TBe81Ad=P=eXJZpAmkj=m4-apGF1e0uh5kg@mail.gmail.com>
 <CAHp75VemBiGUTspEYDe3hwA9pEzjNMQGY6_kUoVMJyCuEWgChw@mail.gmail.com> <c4e2a00c-d09e-95e2-eaf2-1de6b820ac6e@intel.com>
In-Reply-To: <c4e2a00c-d09e-95e2-eaf2-1de6b820ac6e@intel.com>
From:   Tomer Maimon <tmaimon77@gmail.com>
Date:   Wed, 7 Dec 2022 15:01:38 +0200
Message-ID: <CAP6Zq1h9XvH501e_nH9TkUCKPNOuH7dhOM8FrsUM=PYX4gt0qw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: sdhci-npcm: Add NPCM SDHCI driver
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        ulf.hansson@linaro.org, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com,
        skhan@linuxfoundation.org, davidgow@google.com,
        pbrobinson@gmail.com, gsomlo@gmail.com, briannorris@chromium.org,
        arnd@arndb.de, krakoczy@antmicro.com, openbmc@lists.ozlabs.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy and Adrian,

Thanks for your clarifications

On Mon, 5 Dec 2022 at 16:33, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 5/12/22 16:17, Andy Shevchenko wrote:
> > On Mon, Dec 5, 2022 at 4:14 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >>
> >> On Mon, Dec 5, 2022 at 3:41 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>> On 5/12/22 15:25, Andy Shevchenko wrote:
> >>>> On Mon, Dec 5, 2022 at 1:20 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
> >>>>> On Mon, 5 Dec 2022 at 12:54, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >>>>>> On Mon, Dec 5, 2022 at 10:54 AM Tomer Maimon <tmaimon77@gmail.com> wrote:
> >>
> >> ...
> >>
> >>>>>>> +       pltfm_host->clk = devm_clk_get_optional(&pdev->dev, NULL);
> >>>>>>
> >>>>>> You can't mix devm with non-devm in this way.
> >>>>> Can you explain what you mean You can't mix devm with non-devm in this
> >>>>> way, where is the mix?
> >>>>> In version 1 used devm_clk_get, is it problematic?
> >>>>
> >>>> devm_ is problematic in your case.
> >>>> TL;DR: you need to use clk_get_optional() and clk_put().
> >>>
> >>> devm_ calls exactly those, so what is the issue?
> >>
> >> The issue is the error path or removal stage where it may or may be
> >> not problematic. To be on the safe side, the best approach is to make
> >> sure that allocated resources are being deallocated in the reversed
> >> order. That said, the
> >>
> >> 1. call non-devm_func()
> >> 2. call devm_func()
> >>
> >> is wrong strictly speaking.
> >
> > To elaborate more, the
> >
> > 1. call all devm_func()
> > 2. call only non-devm_func()
> >
> > is the correct order.
>
> 1. WRT pltfm_host->clk, that is what is happening
> 2. WRT other resources that is simply not always possible because not every resource is wrapped by devm_
> e.g. mmc_alloc_host() / mmc_free_host()
I little confused about what to decide, should I use only
non-devm_func because mmc_alloc_host() / mmc_free_host() is not
warrped with devm_?
>
> >
> > Hence in this case the driver can be worked around easily (by
> > shuffling the order in ->probe() to call devm_ first), but as I said
> > looking into implementation of the _unregister() I'm pretty sure that
> > clock management should be in sdhci-pltfm, rather than in all callers
> > who won't need the full customization.
> >
> > Hope this helps to understand my point.
> >
> >>>> Your ->remove() callback doesn't free resources in the reversed order
> >>>> which may or, by luck, may not be the case of all possible crashes,
> >>>> UAFs, races, etc during removal stage. All the same for error path in
> >>>> ->probe().
> >>
> >> I also pointed out above what would be the outcome of neglecting this rule.
> >>
> >>>>>>> +       if (IS_ERR(pltfm_host->clk))
> >>>>>>> +               return PTR_ERR(pltfm_host->clk);
> >>>>>>> +
> >>>>>>> +       ret = clk_prepare_enable(pltfm_host->clk);
> >>>>>>> +       if (ret)
> >>>>>>> +               return ret;
> >>>>>>> +
> >>>>>>> +       caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> >>>>>>> +       if (caps & SDHCI_CAN_DO_8BIT)
> >>>>>>> +               host->mmc->caps |= MMC_CAP_8_BIT_DATA;
> >>>>>>> +
> >>>>>>> +       ret = mmc_of_parse(host->mmc);
> >>>>>>> +       if (ret)
> >>>>>>> +               goto err_sdhci_add;
> >>>>>>> +
> >>>>>>> +       ret = sdhci_add_host(host);
> >>>>>>> +       if (ret)
> >>>>>>> +               goto err_sdhci_add;
> >>>>>>
> >>>>>> Why can't you use sdhci_pltfm_register()?
> >>>>> two things are missing in sdhci_pltfm_register
> >>>>> 1. clock.
> >>>>
> >>>> Taking into account the implementation of the corresponding
> >>>> _unregister() I would add the clock handling to the _register() one.
> >>>> Perhaps via a new member of the platform data that supplies the name
> >>>> and index of the clock and hence all clk_get_optional() / clk_put will
> >>>> be moved there.
Do you mean to add it to sdhci_pltfm_register function? if yes I
believe it will take some time to modify sdhci_pltfm_register
I prefer not to use sdhci_pltfm_register.
> >>>>
> >>>>> 2. Adding SDHCI_CAN_DO_8BIT capability according the eMMC capabilities.
> >>>>
> >>>> All the same, why can't platform data be utilised for this?
> >>>>
> >>>>>>> +       return 0;
> >>>>>>> +
> >>>>>>> +err_sdhci_add:
> >>>>>>> +       clk_disable_unprepare(pltfm_host->clk);
> >>>>>>> +       sdhci_pltfm_free(pdev);
> >>>>>>> +       return ret;
> >>>>>>> +}
> >>
> >>
> >> --
> >> With Best Regards,
> >> Andy Shevchenko
> >
> >
> >
>

Best regards,

Tomer
