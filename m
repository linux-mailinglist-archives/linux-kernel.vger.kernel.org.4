Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CD572DE14
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbjFMJpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbjFMJpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:45:40 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7612210DC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:45:39 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-43d10b0bf6cso329991137.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1686649538; x=1689241538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNzEy8MVZ8x+tq8g5HpTGHyfMbdsero480OR63gtbqs=;
        b=JqovgFXbuPli7l7dXgrvY2uK2toI88NT4EQUXx9xL277TDuDVuUsigZAlZym0kP1Gw
         +Vkj3qFPQJLzYF01DNdbp/er3p7k41SuJbOh3djnkhtLbRYwUUEn0XtjZkEMlgGXyXvs
         VG58Thb3QgKI+nNf0ESL9uzb49wcH63/TM03m3rCC6ah5eNsyZlPwsWIx0P4WbY9j5Qx
         4T42NAx9ZyQhi1MTO+XnvaEIoBNST+XdJi968DSnAGkvAV++cHij8m98UJ4kL9Jjb3Tw
         EmDkK4ftX07oljM16Nx1tC5scU9XmZBblhuBbBL+Adw/W3mNJ7XwexFexxjI32gne4xo
         86pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686649538; x=1689241538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNzEy8MVZ8x+tq8g5HpTGHyfMbdsero480OR63gtbqs=;
        b=aifQ2NxH/bl7F7qsOqSOv+SdFg9RXGgNv/GarP4NK58/5yzoB9GfXebI9qdA4XWc/b
         9wwzj07Sa2bXBjTR3Yc3WEkpXQXPEuWXpX2NIh0VwzpwxgzyruHbRjpO/Kfm6zhWCVh2
         61k3FCeMVAxXfhKaxUjpPNCGHhHZBjQDzyk5nV0h7obdJtUfUO4vnKEeyjhwuULojWpn
         GtWDF9ub6s8PXdROP5Tuqs+SSsj4sKrUL/QVMgdvpe5Sjgu9yt/n3cjhsZGr/myxhX7E
         UH8/Oza3JXJMBg04RNu6jsjjxcCrSHCdX3PNgE7JN46tsZ6374zGK1Nyg64I3d/T3iWS
         P2KQ==
X-Gm-Message-State: AC+VfDz27RKolYD2mI47k+sq2aSjBFsra+q5NwjohGY/Nr/DuP7RPxnC
        jN1NERM045smWTqYECErK2CtTnOkRa1dbTZHOwIEYyt8VIH9osFO
X-Google-Smtp-Source: ACHHUZ5BClJpHM+qfOHUCII/gtseIclhD5cLFyAvfZbs1pkdUKkye/6TFiKstlGZMdsqAlWSwJlGQlKreUgG3xlQcuQ=
X-Received: by 2002:a67:fd52:0:b0:43c:8c56:14a9 with SMTP id
 g18-20020a67fd52000000b0043c8c5614a9mr5882483vsr.9.1686649538668; Tue, 13 Jun
 2023 02:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230609121649.88147-1-minhuadotchen@gmail.com>
In-Reply-To: <20230609121649.88147-1-minhuadotchen@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 13 Jun 2023 11:45:27 +0200
Message-ID: <CAMRc=Md9utfFY3Uimnn7XTiHma7GBBmKLPAc9Y735Mxt1McBWw@mail.gmail.com>
Subject: Re: [PATCH] gpio: davinci: make davinci_gpio_dev_pm_ops static
To:     Min-Hua Chen <minhuadotchen@gmail.com>
Cc:     Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 9, 2023 at 2:16=E2=80=AFPM Min-Hua Chen <minhuadotchen@gmail.co=
m> wrote:
>
> This patch fixes the following sprse warnings:
>
> drivers/gpio/gpio-davinci.c:695:1: sparse: warning: symbol 'davinci_gpio_=
dev_pm_ops' was not declared. Should it be static?
>
> No functional change intended.
>
> Signed-off-by: Min-Hua Chen <minhuadotchen@gmail.com>
> ---
>  drivers/gpio/gpio-davinci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
> index aaaf61dc2632..1aed3ace0240 100644
> --- a/drivers/gpio/gpio-davinci.c
> +++ b/drivers/gpio/gpio-davinci.c
> @@ -692,7 +692,7 @@ static int davinci_gpio_resume(struct device *dev)
>         return 0;
>  }
>
> -DEFINE_SIMPLE_DEV_PM_OPS(davinci_gpio_dev_pm_ops, davinci_gpio_suspend,
> +static DEFINE_SIMPLE_DEV_PM_OPS(davinci_gpio_dev_pm_ops, davinci_gpio_su=
spend,
>                          davinci_gpio_resume);
>
>  static const struct of_device_id davinci_gpio_ids[] =3D {
> --
> 2.34.1
>

Applied, thanks!

Bart
