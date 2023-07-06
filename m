Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1A674A5CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjGFVQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGFVQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:16:40 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5A6B2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 14:16:38 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-992f15c36fcso150566666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688678195; x=1691270195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSqkWwImnB4/tT82n7a07m0rVEFuEASlgb/xLJ5s/v4=;
        b=dciEL14CoNqgy0XvKZaeGcEAL1W1DNKg7bQ1usZ0N/miY3r5SJ/vXMXIW7JVmlnVfJ
         I5vxpKloI1HStUPzADtCXYGzAsdAIxgEcclC0ud2h5/qPokxlZrgQDBIlEaK0IWWiyIn
         dy62Wo7wG4M8W8q0Kn+CELSLk5GXjs6sMSm7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688678195; x=1691270195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSqkWwImnB4/tT82n7a07m0rVEFuEASlgb/xLJ5s/v4=;
        b=IwwGTISy993pJ4HwJvYxX6r98qG46ndKh6D04fZTNVXA+yiRlce6diWFScbM2gmSM5
         09sxvIxgYCdojgPTcfi9O4WkHbhVcQAMY73zIau3sUb19/JqL+BXQ3gTODMFB3opuvC8
         fzWnQ/FQ0QMiPz8OGqX8P8obYGM69Ddgyi41w23dprSQ+E3acllVOAwnsMAzUTa7jpOk
         X43MaQA9CR7EN2P6i4pLc/5Kd0piDUTjn4HcEvfeL/fQ0XJf97mX2GO0+zyQYaKgh8vZ
         tIgFD8B4rMdvJV69G0iI+TwqJ4D31lWJsDEh40ETdzy3lF17mjmC8XcGgU3I0krASd6F
         JWnA==
X-Gm-Message-State: ABy/qLZjFHYpPSZKAkfcikYIXC9sxbvbtjbtdU+gRprpJm1A0AaWSel3
        f1a2gBKGyITdqLSOCiK37V/RVa5TXodkM8SFEudVUWuy
X-Google-Smtp-Source: APBJJlFUBijx0K0N4Xt1ZASuNwpEpzhQlguDBqCjAFaSUSqAjs/ARKcuHR4lszhQCNh4S87lsUlvcA==
X-Received: by 2002:a17:906:33d0:b0:992:b3a3:81f9 with SMTP id w16-20020a17090633d000b00992b3a381f9mr1037145eja.71.1688678195349;
        Thu, 06 Jul 2023 14:16:35 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id x15-20020a1709065acf00b00992316f0690sm1273910ejs.74.2023.07.06.14.16.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 14:16:35 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-516500163b2so1123a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 14:16:34 -0700 (PDT)
X-Received: by 2002:a50:ab56:0:b0:51a:2012:5b34 with SMTP id
 t22-20020a50ab56000000b0051a20125b34mr29571edc.4.1688678194287; Thu, 06 Jul
 2023 14:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org> <20230703-fix-boe-tv101wum-nl6-v3-4-bd6e9432c755@linaro.org>
In-Reply-To: <20230703-fix-boe-tv101wum-nl6-v3-4-bd6e9432c755@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 6 Jul 2023 14:16:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UvobraoZELdLmCmuu1u1RpFbzEuobyWRuCn45n1b4-XA@mail.gmail.com>
Message-ID: <CAD=FV=UvobraoZELdLmCmuu1u1RpFbzEuobyWRuCn45n1b4-XA@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/panel: ili9882t: Break out function for
 switching page
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 3, 2023 at 6:22=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> The ILI9882t has similarities with other Ilitek panels, such
> as the characteristic internal page switching code that uses
> the model number (0x98, 0x82) as parameter.
>
> We can clearly abstract out the page switching sequence from
> the initialization code.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/gpu/drm/panel/panel-ilitek-ili9882t.c | 54 ++++++++++++++++++---=
------
>  1 file changed, 37 insertions(+), 17 deletions(-)

This is nice, thanks!


> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili9882t.c
> index 20f3cc37fa83..c1a0f10fbaf7 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
> @@ -55,13 +55,33 @@ struct ili9882t {
>         struct gpio_desc *enable_gpio;
>  };
>
> +/* ILI9882-specific commands, add new commands as you decode them */
> +#define ILI9882T_DCS_SWITCH_PAGE       0xFF
> +
> +static int ili9882t_switch_page(struct mipi_dsi_device *dsi, u8 page)
> +{
> +       u8 switch_cmd[] =3D {0x98, 0x82, 0x00};
> +       int ret;
> +
> +       switch_cmd[2] =3D page;
> +
> +       ret =3D mipi_dsi_dcs_write(dsi, ILI9882T_DCS_SWITCH_PAGE, switch_=
cmd, 3);

nit: Instead of "3", "ARRAY_SIZE(switch_cmd)" would be more documenting.


> +       if (ret) {
> +               dev_err(&dsi->dev,
> +                       "error switching panel controller page (%d)\n", r=
et);
> +               return ret;
> +       }
> +
> +       return 0;

This is a static function and you don't check the error code anywhere.
Why bother returning it?

...although in patch #1 I'm suggesting adding to the core the ability
to have a "sequence of sequences". If that makes sense then perhaps
the code below that uses this will be short enough that it won't look
bad to error check each call?


>  static int starry_ili9882t_init(struct mipi_dsi_device *dsi)
>  {
>         int ret;
>
>         msleep(5);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x01);
> +       ili9882t_switch_page(dsi, 0x01);
>         mipi_dsi_dcs_write_seq(dsi, 0x00, 0x42);
>         mipi_dsi_dcs_write_seq(dsi, 0x01, 0x11);
>         mipi_dsi_dcs_write_seq(dsi, 0x02, 0x00);
> @@ -192,7 +212,7 @@ static int starry_ili9882t_init(struct mipi_dsi_devic=
e *dsi)
>         mipi_dsi_dcs_write_seq(dsi, 0x8B, 0x07);
>         mipi_dsi_dcs_write_seq(dsi, 0x8C, 0x07);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x02);
> +       ili9882t_switch_page(dsi, 0x02);
>         mipi_dsi_dcs_write_seq(dsi, 0x29, 0x3A);
>         mipi_dsi_dcs_write_seq(dsi, 0x2A, 0x3B);
>
> @@ -211,12 +231,12 @@ static int starry_ili9882t_init(struct mipi_dsi_dev=
ice *dsi)
>         mipi_dsi_dcs_write_seq(dsi, 0x5E, 0x40);
>         mipi_dsi_dcs_write_seq(dsi, 0x84, 0x00);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x03);
> +       ili9882t_switch_page(dsi, 0x03);
>         mipi_dsi_dcs_write_seq(dsi, 0x20, 0x01);
>         mipi_dsi_dcs_write_seq(dsi, 0x21, 0x3C);
>         mipi_dsi_dcs_write_seq(dsi, 0x22, 0xFA);
>
> -       mipi_dsi_dcs_write_seq(dsi, 0xFF, 0x98, 0x82, 0x0A);
> +       ili9882t_switch_page(dsi, 0x0a);

Super nitty: Even though Linux in general has hex constants in
lowercase, this driver seems to consistently use uppercase. You've
introduced a few inconsistencies here (and a few more below). Can you
make this consistent? Maybe do the upper-to-lower conversion as part
of your efforts to break the driver out?

-Doug
