Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295A4720282
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 15:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjFBND0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 09:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFBNDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 09:03:25 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EE01AB;
        Fri,  2 Jun 2023 06:03:24 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6261367d2f1so18403086d6.3;
        Fri, 02 Jun 2023 06:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685711003; x=1688303003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmAYzj4TVS8G4kAy4ewMFZCKNd6Q/Glo48aZ4gYHigw=;
        b=HHrc6oa9YKDr2I5o+sSBEjwy3Ls7OV070GoaRUfPUNjCHVEeqSt1o+Idl3PT1Pwxa3
         a9pqj7TyTKkbjNwCokKvgFxm7DcoJrV+1bcbt+uGbXRTMAwbBQiqxV7zb+SG7xJAgVVB
         tFJfzknMRrjkmD09lx1SPQVmVgnzx4Gud+6/TgWcKgldQIVZQKpTtFfR2WOWxmD+d4Ko
         9rrdJVwK34h0WlTA6TCds36FBzj4YZ7WLuhN+b2OSfz7FeKosDBLw4BCAapUzwrS5r9y
         dmjpxzU8rZSKOMpC5YaPVzqifYEneRFMxd3ozV5589jE086s1B/Nr9NW5AvnK/gEci/L
         FQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685711003; x=1688303003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmAYzj4TVS8G4kAy4ewMFZCKNd6Q/Glo48aZ4gYHigw=;
        b=F9ZaPgriVOxWeYXb0kUmcq01PDhVFwrmdze21CfZdaABVROqyXGXom5s8TUi344dti
         /OkVjAmqzY9Zq0vQAgE4z7jygOTCiwbHubCKZ0gp+k2J+4LUnB8wIvVJwWQfI0QpMJrS
         VWeCvYsJTcuzm8QAP0NQyX5YKJ/PpCGC+S++iPVjSdFftmzLfe6CVKK5W+3HZd567V9y
         5cWo3HGDuAnhJO9GZ1LSa6gAsPl+Up9msSZ7XDH/I2HOi2zGXfd+8Dv9XFbF7nc5tPfM
         nQ32DJKxHvBOE92Ejpgb85N2sFZdrAxvjWgJy4N0c6hImHNAultqqeByrhiewsBgjXrh
         l+9A==
X-Gm-Message-State: AC+VfDyA1cNj1POZVm3OelHB9nQ3LZgR+cRMGJDHw4oNAfr7WrGyxyK+
        VVXSrFEAqKv4wBWt7OHH3bZl9NPKAMNkgRi2z90=
X-Google-Smtp-Source: ACHHUZ7G91yEcHCmh+JlOFf21PmDb1tvy27KzWOAYjldVj0a5ew+/R2r4VpVwXi2gC0rTL8uLA+S66YzrRRR/V+68JU=
X-Received: by 2002:a05:6214:caa:b0:600:5dbc:c31a with SMTP id
 s10-20020a0562140caa00b006005dbcc31amr13216663qvs.7.1685711003146; Fri, 02
 Jun 2023 06:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230602073300.7536-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20230602073300.7536-1-jiasheng@iscas.ac.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Jun 2023 16:02:47 +0300
Message-ID: <CAHp75Vdfvt-jxesWOgki+wV0QdVLidSVc6J+Fcm6dU4pxZYfPg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: ath79: Add missing check for platform_get_irq
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     albeu@free.fr, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 2, 2023 at 10:33=E2=80=AFAM Jiasheng Jiang <jiasheng@iscas.ac.c=
n> wrote:
>
> Add the missing check for platform_get_irq and return error code
> if it fails.

The template for function references is func().
Otherwise looks fine to me
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
>
> v1 -> v2:
>
> 1. Return "girq->parents[0]" instead of "-ENODEV".
> ---
>  drivers/gpio/gpio-ath79.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-ath79.c b/drivers/gpio/gpio-ath79.c
> index aa0a954b8392..31ce2d5c6ba0 100644
> --- a/drivers/gpio/gpio-ath79.c
> +++ b/drivers/gpio/gpio-ath79.c
> @@ -286,6 +286,8 @@ static int ath79_gpio_probe(struct platform_device *p=
dev)
>                 if (!girq->parents)
>                         return -ENOMEM;
>                 girq->parents[0] =3D platform_get_irq(pdev, 0);
> +               if (girq->parents[0] < 0)
> +                       return girq->parents[0];
>                 girq->default_type =3D IRQ_TYPE_NONE;
>                 girq->handler =3D handle_simple_irq;
>         }
> --
> 2.25.1
>


--=20
With Best Regards,
Andy Shevchenko
