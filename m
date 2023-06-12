Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F3172C6DE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjFLOEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjFLOEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:04:38 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA761AC;
        Mon, 12 Jun 2023 07:04:38 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f9b8f1c2fdso29193681cf.2;
        Mon, 12 Jun 2023 07:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686578677; x=1689170677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Nqk7opXz56V7mIpqm5KsGyT1vRoRc3GpMXEUFtGyL8=;
        b=qM2YAKXVzfa2JaU+hOd5qfotCsKnAverw6L4epM9AS9ysVYswvh9HvnppUhzzBxjoU
         OcsZl4cEW9fgB/kc6IyqHN0mWij4ps37xol30hDagJE/VyrUKgEvvWNQFQhKLSTty9RS
         ChfTT3yp1DP1yrg34c05tKRfPcp5GtJxuPWpOs9wu+0z8XQ/Kqw0bFVRMIK/gYibPAtY
         XyItUrHqIqoYawupgLcCVCm+oUoh14WZtIdQQsEgOIpFHoS408rZH5XT/oakJDy0iDwS
         BH6dSVVyRONYDL4N+roBkjdLprotQVSFu+886KbZIBkrUDpSL9pl5WW9y5y4nrxTBzVA
         nWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686578677; x=1689170677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Nqk7opXz56V7mIpqm5KsGyT1vRoRc3GpMXEUFtGyL8=;
        b=jDZ7lSXfH7GHbUhlY6AGAOVXVq1rjtT6Sr1IaFoIj8nMYsMPc5p54rPHG1QkBfpgN/
         kSZQq7uqwFxG4rb+jfIuRN6OAXC48UpTbBUqfs4zvctfzEoMSMEDwDvK5xjZBhw71lC3
         a2NqKHWKOJcRgWOjmroePG3004POMeL+A9V/LoQcG4dFSpaOk/ohagtQ0ASkCb26z8mi
         L19JTIeIw72NUTOIwRaKpaWJTTNEcYiII/o5A8c8ZLvhfUsS98mJoVEJQpat8FSwcr6W
         ONFo41ph9Amf3XE/J0L2Sh/WdHHszAC4GIXvTtPGj/taskN8eExjaOt8aanAFjZJRJvC
         iCdw==
X-Gm-Message-State: AC+VfDwlPCdVZI4WPsRK1AbdJEJCqGoZhCeqCtiVW55jhY9W976OBO9I
        XbC9mUSLtFRlXwPA9XUyKf8uC39LSTRzPrgzPW8=
X-Google-Smtp-Source: ACHHUZ6CYvg10zoi9HIkb5vFNGGCLbHuRoSN1oR+9KoFwQC8JaYcEXHz6j+v+/QBdVrhCGleFWwCy3z8rKKcBsoqLb4=
X-Received: by 2002:a05:6214:e4d:b0:625:b849:f86 with SMTP id
 o13-20020a0562140e4d00b00625b8490f86mr8613739qvc.14.1686578677154; Mon, 12
 Jun 2023 07:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230612122926.107333-1-herve.codina@bootlin.com> <20230612122926.107333-4-herve.codina@bootlin.com>
In-Reply-To: <20230612122926.107333-4-herve.codina@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Jun 2023 17:04:01 +0300
Message-ID: <CAHp75VcwaHEzZxpGiVNtrDT=2kYqEiLOALUm_KFb+036XYO1wQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] iio: inkern: Check error explicitly in iio_channel_read_max()
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Mon, Jun 12, 2023 at 3:30=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> The current implementation returns the error code as part of the
> default switch case.
> This can lead to returning an incorrect positive value in case of
> iio_avail_type enum entries evolution.
>
> In order to avoid this case, be more strict in error checking.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/iio/inkern.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 872fd5c24147..f738db9a0c04 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -858,6 +858,9 @@ static int iio_channel_read_max(struct iio_channel *c=
han,
>                 val2 =3D &unused;
>
>         ret =3D iio_channel_read_avail(chan, &vals, type, &length, info);
> +       if (ret < 0)
> +               return ret;
> +
>         switch (ret) {
>         case IIO_AVAIL_RANGE:
>                 switch (*type) {
> @@ -888,7 +891,7 @@ static int iio_channel_read_max(struct iio_channel *c=
han,
>                 return 0;
>
>         default:
> -               return ret;
> +               return -EINVAL;
>         }
>  }
>
> --
> 2.40.1
>


--=20
With Best Regards,
Andy Shevchenko
