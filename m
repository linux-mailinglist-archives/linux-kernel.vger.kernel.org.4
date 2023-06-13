Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ABE72E33B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 14:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbjFMMlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 08:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjFMMlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 08:41:15 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9B312A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:41:14 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-76d846a4b85so385658241.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 05:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686660073; x=1689252073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWJOTGLymbDQlUSAs58B7ENxx1uRHhF/it2ySbN2jk0=;
        b=3LIY4mjmBQVmCsYj6CY7ZRKYKXF+viQMoTBUIpDoWuAAvszPCM8R+cKm2aTetU9HZB
         dyFvoz1VJXHREzdOGYYZ8sExVEtQg7RN1oxTrXci03Zp4jEDPL+aI2wmW3rFK8hm+1/4
         TfA5RMh2PumKn2Uz4NWUSfjaZbxGpI8qI6OGjSJHr74bcU6k1jG7yZv+Zfe8n4b+2q55
         +X3w+7nEOIVG9DlirCZCRJYGeMz1gZZ7tLkzYSr7WcGzkM3C0oco+NG3epxXTHMk2J0P
         lgB1cNw0WXzwzbUIYtdE5mU9CqbDZi3Wg3cg2XOz6HGFRCSczUc/EXH9hqS44wqE5VAX
         p0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686660073; x=1689252073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWJOTGLymbDQlUSAs58B7ENxx1uRHhF/it2ySbN2jk0=;
        b=VooF/9FJFSIGmgZXFbZkc/lIvkAGAGD/Jy+3d2EnNIFlxpteR/XYvqhyJQOcCZwLhc
         hqVT5vwQySQpwJ5XnOiIDip37/3hamNoQdGOUmhbWVximYKsu4BpicN6NUWSawUNd19h
         3Yl2gcOieGhZio4mRctAM9ZfeNzDKD538g60IKQ8R3kUs16yhd3c4pME//MTq8WexOdx
         tzEh/ZVYcQGLRhrmZtPckyhEo2x8P/rgXH9d/E1MohqRTDcKDrH2oNEgiqUk2MB6vjeo
         4CgzW24/NOAv+AMDh86d+hCjdS2ZunSfqScSwgTKJMGtwHylR2NKHZo8vq/rJK2W9ZJR
         8amA==
X-Gm-Message-State: AC+VfDyOdi1WeTnounoQyMMYgVvGYZJxPQbbghJtPCJcFtmkyZPWOvNj
        DyCZNkJOA9Dn0aj0n6VZzD8bNbWIXrsypwEX4nCHGA==
X-Google-Smtp-Source: ACHHUZ5q5N2uMo9uVe4NxB4a8cePYTi0SR1YsIgL+uUBG+s/kuNE16NepfqwinchlLZ5ThFRdfg+OSTLUAQQ4WtTe5k=
X-Received: by 2002:a05:6102:1359:b0:439:3c15:da5b with SMTP id
 j25-20020a056102135900b004393c15da5bmr4763983vsl.17.1686660073315; Tue, 13
 Jun 2023 05:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230607081803.778223-1-jiawenwu@trustnetic.com>
In-Reply-To: <20230607081803.778223-1-jiawenwu@trustnetic.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 13 Jun 2023 14:41:02 +0200
Message-ID: <CAMRc=Me8x9ytsg6RRrC93oh+q3Qqn4N92gjvQM=ARGO2=f-pgg@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Fix GPIO chip IRQ initialization restriction
To:     Jiawen Wu <jiawenwu@trustnetic.com>
Cc:     linus.walleij@linaro.org, shreeya.patel@collabora.com,
        andy.shevchenko@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 10:20=E2=80=AFAM Jiawen Wu <jiawenwu@trustnetic.com>=
 wrote:
>
> In case of gpio-regmap, IRQ chip is added by regmap-irq and associated wi=
th
> GPIO chip by gpiochip_irqchip_add_domain(). The initialization flag was n=
ot
> added in gpiochip_irqchip_add_domain(), causing gpiochip_to_irq() to retu=
rn
> -EPROBE_DEFER.
>
> Fixes: 5467801f1fcb ("gpio: Restrict usage of GPIO chip irq members befor=
e initialization")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
> v1 -> v2:
> - add compiler barrier
> ---
>  drivers/gpio/gpiolib.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index a7220e04a93e..9ecf93cbd801 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1792,6 +1792,14 @@ int gpiochip_irqchip_add_domain(struct gpio_chip *=
gc,
>         gc->to_irq =3D gpiochip_to_irq;
>         gc->irq.domain =3D domain;
>
> +       /*
> +        * Using barrier() here to prevent compiler from reordering
> +        * gc->irq.initialized before adding irqdomain.
> +        */
> +       barrier();
> +
> +       gc->irq.initialized =3D true;
> +
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_domain);
> --
> 2.27.0
>

Applied, thanks!

Bart
