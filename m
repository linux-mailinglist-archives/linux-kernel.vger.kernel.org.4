Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8715F72E59B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242678AbjFMOXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242738AbjFMOW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:22:57 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE7819A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:22:55 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-783f17f0a00so435743241.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686666173; x=1689258173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gWIF6WfXGGLV7wV95q+Bs7ONpfkMQ74yIFAAdWgckU=;
        b=a/BBVjmaMQ4W6Uh57UzU2yX7l6o8M8VmaUrobFylrp2Lj1e8Zk4i1JsD2rhJGFOGj7
         LxDaeAiMscWxru8mlDYV+lxikYRK9FwFcFn8f+TTir+jo+Qie32VNdKSUx8pDD+ZKUb8
         dN9/VheT2T5upyliDSFeUcOABFpv242h0NutbQBIyyfuyYPSvqSpQgxvPcMU6lWLbkL9
         gBJ9VH0NT1H8dBe5UP+rm7EakoA5vVCJ1Xf5GshvGP3rnuzEPcWtoKxMkwvpNOtmvYMR
         oosmUI7srWEIx77rEfNqbHTwIl6ltzIjWmI1kK4Yj7PZAgT01zkcszpmUt76ZeuVqzr7
         qY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686666173; x=1689258173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gWIF6WfXGGLV7wV95q+Bs7ONpfkMQ74yIFAAdWgckU=;
        b=P34lm4cPChgjbiiKzn4UW47GEdvCdk88PEAEKATIpfQgqIRd3Zh9G0yNaetdZ5WLlV
         /0MHc6eT3tVjv2TjRRoUy9I3NOqhPYMvSRUwcwiBATQJcWNCV8gZ/noA0i+b4EcSfmHb
         wfbWkfGpL1HXtksYWDXDyADvmi4xYxHXQ+Bsi0NCZMMUfBEJWsS1lbDxCt+PXMOje+x6
         GdWL2UmsfcncJ4bw44ftJKWmI1bFV3YOmPpnghz67olnVPMVFHX5bWR8UCHxxd6ATtaM
         O01/8tbsHeCYpc7kboBN8bRKrrYOW03pmchOl/gUXrEQeExKqiSdJhd/FcxndGdni5Jv
         QlRQ==
X-Gm-Message-State: AC+VfDy3kXllOvr0431lpy+Vqdrg9JQ81TbKkWAujeJ6y+1t3QvRXUvZ
        Sw5H8jYvUP9jIdXhh8m78m3vgMbXNRdBoP1d4UMXJw==
X-Google-Smtp-Source: ACHHUZ5vP+V+IYfx+6K3RQdpyB8TtZRAxKeKOoDh1dO34vqqR5jmKqETRZ2YfFdpKic4CFmIUYOgjxbDQldWhsZkLD8=
X-Received: by 2002:a05:6102:408:b0:430:e0:ac2e with SMTP id
 d8-20020a056102040800b0043000e0ac2emr5618052vsq.15.1686666172953; Tue, 13 Jun
 2023 07:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230606031159.38246-1-jiasheng@iscas.ac.cn>
In-Reply-To: <20230606031159.38246-1-jiasheng@iscas.ac.cn>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 13 Jun 2023 16:22:42 +0200
Message-ID: <CAMRc=McoDu4jsy4pWnu=T1+q_FfnYa8bfqWb39ZZXM_YmaGpXw@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: sifive: Add missing check for platform_get_irq
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     andy.shevchenko@gmail.com, oe-kbuild-all@lists.linux.dev,
        linus.walleij@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-gpio@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Jun 6, 2023 at 5:12=E2=80=AFAM Jiasheng Jiang <jiasheng@iscas.ac.cn=
> wrote:
>
> Add the missing check for platform_get_irq() and return error code
> if it fails.
> The returned error code will be dealed with in
> builtin_platform_driver(sifive_gpio_driver) and the driver will not
> be registered.
>
> Fixes: f52d6d8b43e5 ("gpio: sifive: To get gpio irq offset from device tr=
ee data")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
>
> v2 -> v3:
>
> 1. Check before assigning values.
>
> v1 -> v2:
>
> 1. Return "girq->parents[0]" instead of "-ENODEV".
> ---
>  drivers/gpio/gpio-sifive.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
> index 98939cd4a71e..745e5f67254e 100644
> --- a/drivers/gpio/gpio-sifive.c
> +++ b/drivers/gpio/gpio-sifive.c
> @@ -221,8 +221,12 @@ static int sifive_gpio_probe(struct platform_device =
*pdev)
>                 return -ENODEV;
>         }
>
> -       for (i =3D 0; i < ngpio; i++)
> -               chip->irq_number[i] =3D platform_get_irq(pdev, i);
> +       for (i =3D 0; i < ngpio; i++) {
> +               ret =3D platform_get_irq(pdev, i);
> +               if (ret < 0)
> +                       return ret;
> +               chip->irq_number[i] =3D ret;
> +       }
>
>         ret =3D bgpio_init(&chip->gc, dev, 4,
>                          chip->base + SIFIVE_GPIO_INPUT_VAL,
> --
> 2.25.1
>

Applied, thanks!

Bart
