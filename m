Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24CA726277
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235653AbjFGOMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235390AbjFGOMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:12:41 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273291BD6;
        Wed,  7 Jun 2023 07:12:39 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-75d54faa03eso499443385a.1;
        Wed, 07 Jun 2023 07:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686147158; x=1688739158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0wEcp0FyXSoLy2vtZ9JTDGz03q0z6MYcd4FX8LSnA0=;
        b=E9R7O5XsSRybn8qr4S0ORUKY8zeqTvj8KiPUeJ7evqPUeGr4vQBrV0NBTtN0RGk2wx
         gWRe4wqRaXewsp8InU6DqZBUGeWB9xuT8jx/zCWcY5FTeT3uVBOY6vylZg/sk7xJBHbE
         iNz/EPfmWz2ppf4aGtr/8EGQYkawBxR1A0/ohT2G+0oWIu4WnKGREdICU2vP0uoRRcy7
         38NIrBX/FL2arhNoPHT5eUawQbzCDSDsS7OUbb+CDUEJS0vvb37x7cEZERxWOGEpltRt
         iCes1snoUwCYZ9HA9kOY/PS3PcH9vmUj49s16AVaOZV/go8AkvlvwTaLkeUpwAROfGkV
         VOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686147158; x=1688739158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0wEcp0FyXSoLy2vtZ9JTDGz03q0z6MYcd4FX8LSnA0=;
        b=RQgvbszV3FjL9xlTvgUWWVWCNM2jTvzU65Hp4E1VXlhtd8IgSBWXO5JtGeyWOTqTDB
         eM3Aoicn90M1h0CfciMvsfouEmuAfn+VFY3NDTHVd0Z9syBeNjBaWLyXG4PjdcL0Rtfv
         RlfwZNk7PeUhWqEfq6c3Y7zMdjQ+RJqoJAsiAotEd50BY7/rBfs/PISlwNyJ/2fdBvIk
         opuYAn5NCX5g5vC8if/LA/F/pQx/aMqh6AAjBzUuog85h9o/3EcRMvHF442247cYTSFZ
         rD3K+bB4W4jDUB1AQ/qd66d9D3pA9m5KOGI2XeVbEVcxsmf1iUBHNPRUSS1pqz5aX75o
         uAPQ==
X-Gm-Message-State: AC+VfDyEdgErg9tbYoGMxVb6bczDc1lOjGtN1xV51iC9aIf6Aj5VEQuw
        sOb3kyiB+RdH1ULPTfSONVuRy52GH8QRmDILA4avAGa2b3I=
X-Google-Smtp-Source: ACHHUZ6wjaLOSlAIFymssVW5VtjFm1g6Ii3QQ9G/Xf8pBqUJob0EQgcLIxbmqLndMy93o64J12so1UlRleY8kjMRhXQ=
X-Received: by 2002:a05:6214:212e:b0:623:690c:3ce6 with SMTP id
 r14-20020a056214212e00b00623690c3ce6mr3804849qvc.32.1686147158030; Wed, 07
 Jun 2023 07:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230607081803.778223-1-jiawenwu@trustnetic.com>
In-Reply-To: <20230607081803.778223-1-jiawenwu@trustnetic.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Jun 2023 17:12:01 +0300
Message-ID: <CAHp75Vdbq3uHOyrfT-KFYRSj6v+s9GgOQjQ9a8mGn-4HSCpB9Q@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: Fix GPIO chip IRQ initialization restriction
To:     Jiawen Wu <jiawenwu@trustnetic.com>,
        Michael Walle <michael@walle.cc>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        shreeya.patel@collabora.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Michael

On Wed, Jun 7, 2023 at 11:20=E2=80=AFAM Jiawen Wu <jiawenwu@trustnetic.com>=
 wrote:
>
> In case of gpio-regmap, IRQ chip is added by regmap-irq and associated wi=
th
> GPIO chip by gpiochip_irqchip_add_domain(). The initialization flag was n=
ot
> added in gpiochip_irqchip_add_domain(), causing gpiochip_to_irq() to retu=
rn
> -EPROBE_DEFER.

Makes sense to me.
FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

But it would be nice to hear from Michael about this.

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


--=20
With Best Regards,
Andy Shevchenko
