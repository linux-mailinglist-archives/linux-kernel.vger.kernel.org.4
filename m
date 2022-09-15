Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9915B9427
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 08:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiIOGKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 02:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIOGKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:10:04 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315B32F3BC;
        Wed, 14 Sep 2022 23:10:02 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 29so25408772edv.2;
        Wed, 14 Sep 2022 23:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cgYFRJEiWz2DCeE0iZ8g5m7PtW7eeNXYx8ZiXt8v8LY=;
        b=FWaU9jMCQDnxMNSr3cKEKctnJKoQoHWZIkcNSSxMnIgsC13M2lRJbGN/LFoOLbETOV
         jxSzLnDtA0YXvwFgEUjrugE/y+FImDDLSEBislSeKFL9MZvHYQwRglPLHSNeLCYxl1uo
         oTbZZmJHuUdBJHMF1Vtqay4/CT5Q+E7I1RnWbEuEAbiRsw8HRtBkM/NmarHjDh+4ElwR
         AqCZPyIO+0KkiWs+b1rCg8oR3EWpjzYiEHvR+0vXDOAypC4voWaKte+qbboDj2e0iBBN
         JPDR3XqbWcjmfDjM0o/aFGqIXKyNEOvO7w7VZiVjGCBN3uU7HCNsKnNqzHAPb0U05T4L
         rHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cgYFRJEiWz2DCeE0iZ8g5m7PtW7eeNXYx8ZiXt8v8LY=;
        b=dVshoJC0ldp/9bFhKCr0Qvvnm64Yu0O1OkyEE3qPS1l7hlgOMklVV+0OTAWMXw+aZF
         z4Ua85Vs11EYh43SpFCdTc8GAVYfo7f+E1QNQVL0S/031QTaz//U1S+vlSw/gP5q0kCy
         /cnRp7byE+vj9ZqMAHCStOY9dRBf/2kOMncN4HsF23eW+653LT6pLqLZDkGe8yqgXiQi
         DkkNuTiEgPz9wYKLVmQtwQU25lUBoch6uTdATCFugNS8BlHTo7/1wY2/BnC7P4S8Ntrh
         0anLIHRGg/SJElzlBdxA9POOMgd8jR9LgY1BqyIRGlYsv1zH08nlhm84rxou/SvuIi09
         cJ9A==
X-Gm-Message-State: ACgBeo2XWjLZ31uH3YIAypskK/8VBVMmMKfv/59nBGr3FbaXTrNodIH1
        9AYLIW7FVJAyPc8dEIxUQlljO0Mx1D4M+Qq4u4RhSFh4L8G56Q==
X-Google-Smtp-Source: AA6agR7qgfUiRfxhTH2EWBCNBCSmyhcTXEfW3DvrV/i99+ZeQeehjUqlN22QsJe+0BAvtH0PRLoNuPjdgkwgwzSCyBU=
X-Received: by 2002:a05:6402:51c6:b0:451:6379:81cb with SMTP id
 r6-20020a05640251c600b00451637981cbmr19535254edd.372.1663222200694; Wed, 14
 Sep 2022 23:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220914051842.69776-1-dzm91@hust.edu.cn> <87zgf2l879.wl-maz@kernel.org>
In-Reply-To: <87zgf2l879.wl-maz@kernel.org>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 15 Sep 2022 14:08:10 +0800
Message-ID: <CAD-N9QUjonxCM44Y=9cvcYsyAWOTL7pKEE=c4==zh-pSYboooQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: tpmx86: fix uninitialized variable girq
To:     Marc Zyngier <maz@kernel.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 3:36 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 14 Sep 2022 06:18:42 +0100,
> Dongliang Mu <dzm91@hust.edu.cn> wrote:
> >
> > From: Dongliang Mu <mudongliangabcd@gmail.com>
> >
> > The commit 924610607f19 ("gpio: tpmx86: Move PM device over to
> > irq domain") adds a dereference of girq that may be uninitialized.
> >
> > Fix this by initializing girq and checking irq before invoking
> > irq_domain_set_pm_device.
> >
> > Fixes: 924610607f19 ("gpio: tpmx86: Move PM device over to irq domain")
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/gpio/gpio-tqmx86.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpio/gpio-tqmx86.c b/drivers/gpio/gpio-tqmx86.c
> > index fa4bc7481f9a..bdef182c11c2 100644
> > --- a/drivers/gpio/gpio-tqmx86.c
> > +++ b/drivers/gpio/gpio-tqmx86.c
> > @@ -231,7 +231,7 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
> >       struct device *dev = &pdev->dev;
> >       struct tqmx86_gpio_data *gpio;
> >       struct gpio_chip *chip;
> > -     struct gpio_irq_chip *girq;
> > +     struct gpio_irq_chip *girq = NULL;
> >       void __iomem *io_base;
> >       struct resource *res;
> >       int ret, irq;
> > @@ -315,7 +315,9 @@ static int tqmx86_gpio_probe(struct platform_device *pdev)
> >               goto out_pm_dis;
> >       }
> >
> > -     irq_domain_set_pm_device(girq->domain, dev);
> > +     if (girq) {
> > +             irq_domain_set_pm_device(girq->domain, dev);
> > +     }
> >
> >       dev_info(dev, "GPIO functionality initialized with %d pins\n",
> >                chip->ngpio);
>
> I wonder if a better fix wouldn't be to directly hoist the
> irq_domain_set_pm_device() call into the 'if (irq > 0)' block.

If irq_domain_set_pm_device has no dependency on
devm_gpiochip_add_data, we can directly move irq_domain_set_pm_device
to the if block.

>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
