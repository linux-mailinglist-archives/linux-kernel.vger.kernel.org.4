Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D52B72468E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbjFFOme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238340AbjFFOmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:42:19 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4756E1FE0;
        Tue,  6 Jun 2023 07:40:16 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6260e8a1424so43329276d6.2;
        Tue, 06 Jun 2023 07:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686062379; x=1688654379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lvZ4XsTsTufzOmDccsqLlYK7JaxQyIdNHpPkr+8WCVU=;
        b=dbsKKzlSqCxKNp0/8WqjVhH0METcILEAuzsthzhm/cPsREUocAj7XviIGDyr3X0a/R
         3mwLkv0bs09MK66ezSojrCwgtaGqClR/TWa4ba8m+VdPuaJsG4a48TreBWjRqKRDb78g
         dWWAHowWoODwiV983zWmKsrqLxWsKOwS3PEr831YQX00EhiHGYdz7Q7BjLJ9D6g0tSX8
         smWJGLG09JprEpKEN1AE0oAmIk2XO2t8DLOSyNDb9jVvZrqbbnecERzh6rMDawRxJ5jf
         047Hn+K5ixMP8ou6gMxuBqiODDshPfYOqfM7WUSJ0G/tODZIZA5Ry8w4ijazb/U1eS9H
         cI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686062379; x=1688654379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lvZ4XsTsTufzOmDccsqLlYK7JaxQyIdNHpPkr+8WCVU=;
        b=ZTv5emT4vZ7u0hrUdNQRtNjj+su37t7WXcTK/h5X7YApJIlui86pz8KwB1TpGNmh5N
         MnDfUTTLmAhT4y+cwCIgIUjaa1DUtmbgassPVRjcA87nJXl2N1mo6HpCrdQSO1b7ZwQk
         UVTU99DJbM1r0u4SuKo2CBivtOir7jX5rRgfxp4Q9SUjbMB5R4wQ/pkuAljC5Nk2fdrp
         vBqwrGvohX2phDrgt1mSZXWu5qFbWZLBuMF91LhiWX6faZP3zfx+r/0hamSL/YQNdluG
         8KwwuCL4gCN5QSHpOH28S1A10F04KgPb6KY80EYYs9K9QQZd33aToN+1y1UEwwsy3aFo
         7Q5Q==
X-Gm-Message-State: AC+VfDwzJPWdBSjm+RwBeHkjVYXRm+fztyjC38pPyaWzXSoCTSE4G0A2
        XJn8ZPBR/C/hRnAOqPxe7d6wgbmO3iw3caNgHBU=
X-Google-Smtp-Source: ACHHUZ7oc/MKr57w4wxuuavVhcIsODwhsyxixYvZ2V/E5O5qvmNSSbMjRVQoesIRP/0hf+v6UteQHJdPwgPVkoddCsc=
X-Received: by 2002:a05:6214:401:b0:626:2870:7dee with SMTP id
 z1-20020a056214040100b0062628707deemr2664588qvx.42.1686062378686; Tue, 06 Jun
 2023 07:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <1685277277-12209-1-git-send-email-wellslutw@gmail.com> <9ace5c4c-5e17-4207-5a02-6a47ba0aee22@web.de>
In-Reply-To: <9ace5c4c-5e17-4207-5a02-6a47ba0aee22@web.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 6 Jun 2023 17:39:02 +0300
Message-ID: <CAHp75VeMKtHfVVtH+xGSYrt+SSVgVkhCs29jVqfnnoihvhSj4w@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: sunplus: Delete an unnecessary check before
 kfree() in sppctl_dt_node_to_map()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     kernel-janitors@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Dvorkin Dmitry <dvorkin@tibbo.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wells Lu <wellslutw@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr,
        Wells Lu <wells.lu@sunplus.com>
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

On Tue, Jun 6, 2023 at 4:26=E2=80=AFPM Markus Elfring <Markus.Elfring@web.d=
e> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 6 Jun 2023 15:00:18 +0200

You need to utilize what MAINTAINERS file has.

> It can be known that the function =E2=80=9Ckfree=E2=80=9D performs a null=
 pointer check
> for its input parameter.
> It is therefore not needed to repeat such a check before its call.
>
> Thus remove a redundant pointer check.

Seems reasonable to me.
FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/pinctrl/sunplus/sppctl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/sunplus/sppctl.c b/drivers/pinctrl/sunplus/s=
ppctl.c
> index e91ce5b5d559..150996949ede 100644
> --- a/drivers/pinctrl/sunplus/sppctl.c
> +++ b/drivers/pinctrl/sunplus/sppctl.c
> @@ -971,8 +971,7 @@ static int sppctl_dt_node_to_map(struct pinctrl_dev *=
pctldev, struct device_node
>
>  sppctl_map_err:
>         for (i =3D 0; i < (*num_maps); i++)
> -               if (((*map)[i].type =3D=3D PIN_MAP_TYPE_CONFIGS_PIN) &&
> -                   (*map)[i].data.configs.configs)
> +               if ((*map)[i].type =3D=3D PIN_MAP_TYPE_CONFIGS_PIN)
>                         kfree((*map)[i].data.configs.configs);
>         kfree(*map);
>         of_node_put(parent);
> --
> 2.40.1
>


--=20
With Best Regards,
Andy Shevchenko
