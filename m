Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BA56BAC4D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjCOJkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjCOJkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:40:09 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5107046A8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:40:08 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id o32so16401564vsv.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678873207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OjGNv+mrNyH8c6lhNfbNFuFK8MzY9FX1DXYUqHuSxWw=;
        b=J2LhYJ7YvpbwJNXdqS+36pUrrSq52af2lf+JiUJB/V5cz7aUY+dhm9xaiuFbtGMUCA
         nr6SjUrkm4ouWIz/5VaSvt1KXbSdknTch51gmhMAVzfeFFkXp1YnjgeLmUWu+d5Ex+hm
         XYLu73IGm5k2faiK8ersCh6FWWvXDyBHePbtpvTdRIEIKcivBkq2LJleJhzN/vsez3Qx
         WJ1E+WydtKmYVp/+djZR1eHP4/aq/E2CTRLCXjVx6Ymf+PKesiDIECxGlCoFMiV7oEs9
         9DosRnAyTs72C2X4eLhCqMlno2pQTV9ZJVcw/78qckCRQi+7rCntLWNDJs1cQVsrtp8l
         aVpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678873207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjGNv+mrNyH8c6lhNfbNFuFK8MzY9FX1DXYUqHuSxWw=;
        b=lTZ9W5NCw4ErHwqEmW016l+uQ8H3iG6s6iXEoeAokhhSAMh3dJyevxg4QYJmvGrqjQ
         QEEv1XxeH3hHejtsjI+oXePfZHcp9skxzBpiraucKxmLXX3f96T20vi038mZH7YuRIBP
         DcFJYd584vXbfFqLl93/hq7GcYISfho/hNPx0JkhRP3PLGueUYrKWmmbT2B1QZom9ZcH
         pRD3u5N1dLyenvqc172oy/VPdmZPNcX06fyAZW3BkbtqDfGU1cQ3L/mXWm8TS/weVA2c
         Nq5NW7Xc5LQE1hAlPvuWBG2pr/0EBUFFwUc9phtAVGnU9VQVYsQqmawmoOIyRIbUUch/
         XrsQ==
X-Gm-Message-State: AO0yUKV3N8Ie7f0Q/gWe1aNSPu0MN6S/0uFz5/tShdx3jI901/mP/RC/
        AxReLi1YVZ5i9B0rYTqex83ORAoQA+F3oYwU72NwaQ==
X-Google-Smtp-Source: AK7set8N8ixv8+d1/PKQNLxUKnHCkNDa+28cGujUmgSiVkwjs0AlqH77L/dPjb6d7IugkpS6VP2ztL6zFQJPCyNJo1M=
X-Received: by 2002:a05:6102:3b15:b0:425:cd22:a14e with SMTP id
 x21-20020a0561023b1500b00425cd22a14emr467264vsu.2.1678873207453; Wed, 15 Mar
 2023 02:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230311111307.251123-1-krzysztof.kozlowski@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 15 Mar 2023 10:39:56 +0100
Message-ID: <CAMRc=Mc61nWCa-a6cG6Q2eVwyaS63VwO59W5tQ7gWigtJkafjA@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: ftgpio010: drop of_match_ptr for ID table
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mun Yew Tham <mun.yew.tham@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Nandor Han <nandor.han@ge.com>,
        Semi Malinen <semi.malinen@ge.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 12:13=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The driver can match only via the DT table so the table should be always
> used and the of_match_ptr does not have any sense (this also allows ACPI
> matching via PRP0001, even though it might not be relevant here).
>
>   drivers/gpio/gpio-ftgpio010.c:336:34: error: =E2=80=98ftgpio_gpio_of_ma=
tch=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/gpio/gpio-ftgpio010.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-ftgpio010.c b/drivers/gpio/gpio-ftgpio010.=
c
> index 2728672ef9f8..31e26072f6ae 100644
> --- a/drivers/gpio/gpio-ftgpio010.c
> +++ b/drivers/gpio/gpio-ftgpio010.c
> @@ -349,7 +349,7 @@ static const struct of_device_id ftgpio_gpio_of_match=
[] =3D {
>  static struct platform_driver ftgpio_gpio_driver =3D {
>         .driver =3D {
>                 .name           =3D "ftgpio010-gpio",
> -               .of_match_table =3D of_match_ptr(ftgpio_gpio_of_match),
> +               .of_match_table =3D ftgpio_gpio_of_match,
>         },
>         .probe =3D ftgpio_gpio_probe,
>         .remove =3D ftgpio_gpio_remove,
> --
> 2.34.1
>

Applied the series.

Bart
