Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B607194DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 09:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbjFAH7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 03:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjFAH6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 03:58:42 -0400
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93567E79
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 00:53:20 -0700 (PDT)
Received: by mail-vk1-xa32.google.com with SMTP id 71dfb90a1353d-457080dc902so72381e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 00:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1685605999; x=1688197999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCxhoS108AwfreLzkgxhTjrpQCT4ek+5l6IBuFSI3MQ=;
        b=JRYZ02V7xhdRKz7/Vz2BZ3rlqGb23P8UZ9JyYYxtLW+kXsizIcyeaIRagJdmEhcETb
         mTNX+cgpoOvDyqV0qD6puZ+qyxlOdSOo7OdXPB/lw1h/7wuUTrun/h54bux1ax0k5KMv
         pgxt3O2CECC+dV91SO2Hyq+PdzIN+MdnsftfUee7jDeB5m/kUTMIKT9nGfTbksk2T90w
         g3o8R8k6yA0V34uezgFAeb/La4pBG47lKOzEP5+CucF8WnkprF9ajrnh9WKmX+5aiGbk
         YY2iTko96OKjbrdM+N1uPiI2qFEnkBf38UpJZxyd47V1b+V3M6K4u1wBMZ2+vQQ7383P
         DzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685605999; x=1688197999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KCxhoS108AwfreLzkgxhTjrpQCT4ek+5l6IBuFSI3MQ=;
        b=ft2FgtrvIbon/GTdXZ+zwma/q7xB6TnjojaHKWaf7/MmzgHCXJXdC/73GeTBxuoVHm
         dkN/rtqOalHhiVFpUf8JVhCw9asgGd0JaHZJe/I7GlcVf5NfuJqiqloV+WoPJIFllIHF
         aCAG4ATAhdx8AGraBxYAfhqPtn5BN7c1E60nltrW2/qwxPPqnIRWg4zxDxsDlXTGy/D4
         2tipUwY6etfF78Fs0fhZxj8XDKKF3cKblMnA7C5ugGgWF6jUD3pznRA/KnMEMBon5Z+R
         lkPdViFTUTmMSIFThOeRXGxrN3G/mEfh0g3qf4NI+wrtQBbzXsITH/Rtwc8H6/dcGlLF
         PeNg==
X-Gm-Message-State: AC+VfDyVsRG85jDR5s/29JMFlp/Ccf6tNNTqDs6fHSkSvWnGbfX6hyec
        batfODTiXc9BUvGMZENuvSnQzbBLhZs2GmEcvYPE8w==
X-Google-Smtp-Source: ACHHUZ4CrAjd+3JtPRgyfLpu46NuxpRV4JLnat66UJPM6onO/U0Qc1fBNkQyobFAd0jCCnGzRUQ5Cw2shBwvytHhXTk=
X-Received: by 2002:a1f:3f83:0:b0:456:f9e5:5bcf with SMTP id
 m125-20020a1f3f83000000b00456f9e55bcfmr446575vka.6.1685605999670; Thu, 01 Jun
 2023 00:53:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230529221446.87785-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230529221446.87785-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 1 Jun 2023 09:53:08 +0200
Message-ID: <CAMRc=Mfj_hWcpTXWdTTPNQ0zdPSTysdKg0Yq8aLLUR7AsA+S=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Kill unused GPIOF_EXPORT and Co
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>
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

On Tue, May 30, 2023 at 12:14=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> There is no use of the GPIOF_EXPORT in the kernel. Kill it for good.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> v2: added tag (Linus)
>  Documentation/driver-api/gpio/legacy.rst                    | 3 ---
>  Documentation/translations/zh_CN/driver-api/gpio/legacy.rst | 3 ---
>  Documentation/translations/zh_TW/gpio.txt                   | 3 ---
>  drivers/gpio/gpiolib-legacy.c                               | 6 ------
>  include/linux/gpio.h                                        | 5 -----
>  5 files changed, 20 deletions(-)
>
> diff --git a/Documentation/driver-api/gpio/legacy.rst b/Documentation/dri=
ver-api/gpio/legacy.rst
> index 78372853c6d4..c5f98a78499f 100644
> --- a/Documentation/driver-api/gpio/legacy.rst
> +++ b/Documentation/driver-api/gpio/legacy.rst
> @@ -322,9 +322,6 @@ where 'flags' is currently defined to specify the fol=
lowing properties:
>         * GPIOF_OPEN_DRAIN      - gpio pin is open drain type.
>         * GPIOF_OPEN_SOURCE     - gpio pin is open source type.
>
> -       * GPIOF_EXPORT_DIR_FIXED        - export gpio to sysfs, keep dire=
ction
> -       * GPIOF_EXPORT_DIR_CHANGEABLE   - also export, allow changing dir=
ection
> -
>  since GPIOF_INIT_* are only valid when configured as output, so group va=
lid
>  combinations as:
>
> diff --git a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst =
b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
> index 84ce2322fdba..8720970393fb 100644
> --- a/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
> +++ b/Documentation/translations/zh_CN/driver-api/gpio/legacy.rst
> @@ -297,9 +297,6 @@ gpio_request()=E5=89=8D=E5=B0=86=E8=BF=99=E7=B1=BB=E7=
=BB=86=E8=8A=82=E9=85=8D=E7=BD=AE=E5=A5=BD=EF=BC=8C=E4=BE=8B=E5=A6=82=E4=BD=
=BF=E7=94=A8=E5=BC=95=E8=84=9A=E6=8E=A7=E5=88=B6=E5=AD=90=E7=B3=BB=E7=BB=9F=
=E7=9A=84
>         * GPIOF_OPEN_DRAIN      - gpio=E5=BC=95=E8=84=9A=E4=B8=BA=E5=BC=
=80=E6=BC=8F=E4=BF=A1=E5=8F=B7
>         * GPIOF_OPEN_SOURCE     - gpio=E5=BC=95=E8=84=9A=E4=B8=BA=E6=BA=
=90=E6=9E=81=E5=BC=80=E8=B7=AF=E4=BF=A1=E5=8F=B7
>
> -       * GPIOF_EXPORT_DIR_FIXED        - =E5=B0=86 gpio =E5=AF=BC=E5=87=
=BA=E5=88=B0 sysfs=EF=BC=8C=E5=B9=B6=E4=BF=9D=E6=8C=81=E6=96=B9=E5=90=91
> -       * GPIOF_EXPORT_DIR_CHANGEABLE   - =E5=90=8C=E6=A0=B7=E6=98=AF=E5=
=AF=BC=E5=87=BA, =E4=BD=86=E5=85=81=E8=AE=B8=E6=94=B9=E5=8F=98=E6=96=B9=E5=
=90=91
> -
>  =E5=9B=A0=E4=B8=BA GPIOF_INIT_* =E4=BB=85=E6=9C=89=E5=9C=A8=E9=85=8D=E7=
=BD=AE=E4=B8=BA=E8=BE=93=E5=87=BA=E7=9A=84=E6=97=B6=E5=80=99=E6=89=8D=E5=AD=
=98=E5=9C=A8,=E6=89=80=E4=BB=A5=E6=9C=89=E6=95=88=E7=9A=84=E7=BB=84=E5=90=
=88=E4=B8=BA:
>
>         * GPIOF_IN              - =E9=85=8D=E7=BD=AE=E4=B8=BA=E8=BE=93=E5=
=85=A5
> diff --git a/Documentation/translations/zh_TW/gpio.txt b/Documentation/tr=
anslations/zh_TW/gpio.txt
> index 62e560ffe628..e0b96d897fa7 100644
> --- a/Documentation/translations/zh_TW/gpio.txt
> +++ b/Documentation/translations/zh_TW/gpio.txt
> @@ -303,9 +303,6 @@ gpio_request()=E5=89=8D=E5=B0=87=E9=80=99=E9=A1=9E=E7=
=B4=B0=E7=AF=80=E9=85=8D=E7=BD=AE=E5=A5=BD=EF=BC=8C=E4=BE=8B=E5=A6=82=E4=BD=
=BF=E7=94=A8 pinctrl =E5=AD=90=E7=B3=BB=E7=B5=B1=E7=9A=84=E6=98=A0
>         * GPIOF_OPEN_DRAIN      - gpio=E5=BC=95=E8=85=B3=E7=88=B2=E9=96=
=8B=E6=BC=8F=E4=BF=A1=E8=99=9F
>         * GPIOF_OPEN_SOURCE     - gpio=E5=BC=95=E8=85=B3=E7=88=B2=E6=BA=
=90=E6=A5=B5=E9=96=8B=E8=B7=AF=E4=BF=A1=E8=99=9F
>
> -       * GPIOF_EXPORT_DIR_FIXED        - =E5=B0=87 gpio =E5=B0=8E=E5=87=
=BA=E5=88=B0 sysfs=EF=BC=8C=E4=B8=A6=E4=BF=9D=E6=8C=81=E6=96=B9=E5=90=91
> -       * GPIOF_EXPORT_DIR_CHANGEABLE   - =E5=90=8C=E6=A8=A3=E6=98=AF=E5=
=B0=8E=E5=87=BA, =E4=BD=86=E5=85=81=E8=A8=B1=E6=94=B9=E8=AE=8A=E6=96=B9=E5=
=90=91
> -
>  =E5=9B=A0=E7=88=B2 GPIOF_INIT_* =E5=83=85=E6=9C=89=E5=9C=A8=E9=85=8D=E7=
=BD=AE=E7=88=B2=E8=BC=B8=E5=87=BA=E7=9A=84=E6=99=82=E5=80=99=E6=89=8D=E5=AD=
=98=E5=9C=A8,=E6=89=80=E4=BB=A5=E6=9C=89=E6=95=88=E7=9A=84=E7=B5=84=E5=90=
=88=E7=88=B2:
>
>         * GPIOF_IN              - =E9=85=8D=E7=BD=AE=E7=88=B2=E8=BC=B8=E5=
=85=A5
> diff --git a/drivers/gpio/gpiolib-legacy.c b/drivers/gpio/gpiolib-legacy.=
c
> index 028f7f504209..969f737012f6 100644
> --- a/drivers/gpio/gpiolib-legacy.c
> +++ b/drivers/gpio/gpiolib-legacy.c
> @@ -50,12 +50,6 @@ int gpio_request_one(unsigned gpio, unsigned long flag=
s, const char *label)
>         if (err)
>                 goto free_gpio;
>
> -       if (flags & GPIOF_EXPORT) {
> -               err =3D gpiod_export(desc, flags & GPIOF_EXPORT_CHANGEABL=
E);
> -               if (err)
> -                       goto free_gpio;
> -       }
> -
>         return 0;
>
>   free_gpio:
> diff --git a/include/linux/gpio.h b/include/linux/gpio.h
> index 8528353e073b..86963a00b018 100644
> --- a/include/linux/gpio.h
> +++ b/include/linux/gpio.h
> @@ -38,11 +38,6 @@ struct device;
>  /* Gpio pin is open source */
>  #define GPIOF_OPEN_SOURCE      (1 << 4)
>
> -#define GPIOF_EXPORT           (1 << 5)
> -#define GPIOF_EXPORT_CHANGEABLE        (1 << 6)
> -#define GPIOF_EXPORT_DIR_FIXED (GPIOF_EXPORT)
> -#define GPIOF_EXPORT_DIR_CHANGEABLE (GPIOF_EXPORT | GPIOF_EXPORT_CHANGEA=
BLE)
> -
>  /**
>   * struct gpio - a structure describing a GPIO with configuration
>   * @gpio:      the GPIO number
> --
> 2.40.0.1.gaa8946217a0b
>

Both applied, thanks!

Bart
