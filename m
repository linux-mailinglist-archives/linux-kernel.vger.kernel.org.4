Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE7A71698D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjE3Qby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjE3Qb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:31:27 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C72A180
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:30:57 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f5021faa16so2710134e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685464251; x=1688056251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dcWzOSDdDMsKZsoBkaN9THPCf/sY5/j/iNNge3pn9DM=;
        b=PAvv4eEcjomQIziSjKISkeFjcaM8bw2Cvt8O8Di39XulEe4tGDYa19ZifiYrMjLSwm
         x9t/MZLhg8mMRIuAx+f4y2AVfXDKj2o2WeHrn7ykVWftTANPOXyGyNRtZAnq1Y7i9EEI
         rQ/TKQlEPY1ERTmYOaqC9fyOFEZ0r1X+lS3tr9S+kugFULk5EiJdSrKW0iAQyOO2WHI3
         lA5IoM3Y/LfpvVqyZavH3MFbjJLbi0tu+aNYqoVB49bKPlKc6lBQz750yam20+BK8KGh
         Ahw/nNgm7uUXuEGk/7araBzzq6tXJwJtN1fOfmv8QmHTOV2SCdkrI2TRuXnul8BQo8Yw
         kr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685464251; x=1688056251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dcWzOSDdDMsKZsoBkaN9THPCf/sY5/j/iNNge3pn9DM=;
        b=fa3acPN1kAP1c1J3qAkwutLyc5CkrXQyYJR5vDPdIp2a22hpcW6Q80u6NPfYPDyfhx
         +PUzK81ui5nZvKrkRwRQj1sW1SxhD7hoPl1/eFHyqd74FRSaRDdD6K2viOFJkJZe4tbS
         UCMKX+4vim614PkqV3oP4kY8TFTAzYjYGUOQT19gZZf/TGqDDPNsgsKr8AswCT15hCSg
         wnB3LPgERA+vn9qfqHFG+ijitB+KNG0iKluBMr4QRqYH8qrvV9o6t3V1zmE4+WNPgki6
         nBmNOZnkcjcG/NgrjDAR+jTYbVJXslHz/qsdwvXV5IVMo6sTSv1XngQ803/cqdIeSQpm
         gNuw==
X-Gm-Message-State: AC+VfDwU4YJc5Z3F1xbVDsFoiy4pDRJIdTUwy0qk4hVDiCBTNCDfhdMK
        Uv77bAD/9qxHOu2I/wBc9DIL0FJgEi0rdNiDwHwGlA==
X-Google-Smtp-Source: ACHHUZ48j4CTfutqy/48alHu0v+2BBwmvJtW8lx+Mk2Gi/WsVCOUmAS/c7SsVF23Cw5swC1SKumSRYNJEnYeVaiRC7w=
X-Received: by 2002:a2e:3e07:0:b0:2ad:ce08:7a33 with SMTP id
 l7-20020a2e3e07000000b002adce087a33mr1215492lja.22.1685464251616; Tue, 30 May
 2023 09:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230530162034.4004-1-sensor1010@163.com>
In-Reply-To: <20230530162034.4004-1-sensor1010@163.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 30 May 2023 18:30:39 +0200
Message-ID: <CAMRc=MctKb=LUu+um=9ZTH-51keBczdpY_EiPVYN+kbWJzdrTQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/gpio : Remove redundant clearing of IRQ_TYPE_SENSE_MASK
To:     Lizhe <sensor1010@163.com>
Cc:     andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, linux@armlinux.org.uk,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 6:21=E2=80=AFPM Lizhe <sensor1010@163.com> wrote:
>
> Before executing microchip_sgpio_irq_set_type(),
> type has already been cleared IRQ_TYPE_SENSE_MASK, see __irq_set_trigger(=
).
>
> Signed-off-by: Lizhe <sensor1010@163.com>
> ---
>  arch/arm/plat-orion/gpio.c | 1 -
>  drivers/gpio/gpio-mvebu.c  | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/arch/arm/plat-orion/gpio.c b/arch/arm/plat-orion/gpio.c
> index 595e9cb33c1d..863fa497b1a2 100644
> --- a/arch/arm/plat-orion/gpio.c
> +++ b/arch/arm/plat-orion/gpio.c
> @@ -364,7 +364,6 @@ static int gpio_irq_set_type(struct irq_data *d, u32 =
type)
>                 return -EINVAL;
>         }
>
> -       type &=3D IRQ_TYPE_SENSE_MASK;
>         if (type =3D=3D IRQ_TYPE_NONE)
>                 return -EINVAL;
>

What have you not understood about splitting this into two patches?

Bart

> diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
> index a68f682aec01..34fd007b0308 100644
> --- a/drivers/gpio/gpio-mvebu.c
> +++ b/drivers/gpio/gpio-mvebu.c
> @@ -505,7 +505,6 @@ static int mvebu_gpio_irq_set_type(struct irq_data *d=
, unsigned int type)
>         if ((u & BIT(pin)) =3D=3D 0)
>                 return -EINVAL;
>
> -       type &=3D IRQ_TYPE_SENSE_MASK;
>         if (type =3D=3D IRQ_TYPE_NONE)
>                 return -EINVAL;
>
> --
> 2.34.1
>
