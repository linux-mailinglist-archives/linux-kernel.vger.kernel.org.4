Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0CA372F8A3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243725AbjFNJEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243896AbjFNJEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:04:21 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17309135;
        Wed, 14 Jun 2023 02:04:21 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-62de5392c7bso14847736d6.2;
        Wed, 14 Jun 2023 02:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686733460; x=1689325460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lows68iQsXOSvm3HCxBnvL2yL2l/mCq00FeAR+8t4N4=;
        b=XrLh4RUT7vxzRzcNAAfxHLbxMbsshD54LNRR+9BVwGfk2AcfC7CcxZtmLMDhijHa+x
         HkG2z0ORB2TwtKabxSsuFCiv+cVLbPJbaCU61dRdXsOMXpaS7ArPJ9Xlk4aGEPpVv9Q9
         sF4959GFbmTMW41vSFLuDKAle3q59OcJ/A/AGTdKWnjwpO15JGL2ApIlBNUmo+kyhGJk
         Qo6vRgzWchSZmorOK8Hasc7Gqp1uYWk1mjduVeZ/YJlsVfyl6XUZds2Nsw/JL859SWnJ
         GVqRyUeCAiit2SgO7JBcGO0YQLgI1a1uIo/r72x+m0RUuUc6OGZzOMWEzfGBATaIq814
         ZGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686733460; x=1689325460;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lows68iQsXOSvm3HCxBnvL2yL2l/mCq00FeAR+8t4N4=;
        b=PhE803jyRgI2JzKkSCAdN0hl7C7Vw5MrH5Ggc4nWauntabLjOa3A0ZlcBNt/QWYXWN
         3e2L6k+PKJPfRGLPck8i2vDs6HbnQmKJMRr+5ln9jiA7MQjLNKzOZhiQUL0nGAhRzlxw
         TTryLtnohKfKwbktEkrBh1i2WqrQWPGhhZOO7k+73y+HCOZGtUweVkJvhiKyqAQiNaF3
         C8+beTl4JAeEjXLOAGOIpz0i/EMmrGg0d/BmIuryNIoC9RrpXBcw1TLvlwq0YpoM0Z8o
         5Pj9gMb/QI5UeZwTcjSgIrIft2Io6dl1AFVExPDp9OLIoU4Pz5mCBoPqFpsyxFhgOBMk
         9rtQ==
X-Gm-Message-State: AC+VfDwY2+o1jhrYujI/+KB1Uk0tDIXs9Om17a14LKJSaaGJhuYpBLUO
        z1NwdZzpESZ8BZhbABodRfvzwhYujAlGJR07Gzs=
X-Google-Smtp-Source: ACHHUZ6qHiDPNSQdUmUTcUjqhB8Brvn2gqwoahAZG3Sx/5liMGhOeqV+s50MChJilNV8p0/AhEMXyalK8pdNsqdv9zA=
X-Received: by 2002:ad4:5f0a:0:b0:623:855a:9226 with SMTP id
 fo10-20020ad45f0a000000b00623855a9226mr17488041qvb.23.1686733460117; Wed, 14
 Jun 2023 02:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230614074904.29085-1-herve.codina@bootlin.com> <20230614074904.29085-9-herve.codina@bootlin.com>
In-Reply-To: <20230614074904.29085-9-herve.codina@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Jun 2023 12:03:44 +0300
Message-ID: <CAHp75VcBcrFnQYC=2NJ4DpY5NgTP8PszXvx70EAzeEDRXs8Q+A@mail.gmail.com>
Subject: Re: [PATCH v4 08/13] iio: inkern: Use max_array() to get the maximum
 value from an array
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
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
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

On Wed, Jun 14, 2023 at 10:49=E2=80=AFAM Herve Codina <herve.codina@bootlin=
.com> wrote:
>
> Use max_array() to get the maximum value from an array instead of a
> custom local loop.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/iio/inkern.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 71d0424383b6..8bfd91f74101 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -5,6 +5,7 @@
>   */
>  #include <linux/err.h>
>  #include <linux/export.h>
> +#include <linux/minmax.h>
>  #include <linux/mutex.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
> @@ -875,11 +876,7 @@ static int iio_channel_read_max(struct iio_channel *=
chan,
>                         return -EINVAL;
>                 switch (*type) {
>                 case IIO_VAL_INT:
> -                       *val =3D vals[--length];
> -                       while (length) {
> -                               if (vals[--length] > *val)
> -                                       *val =3D vals[length];
> -                       }
> +                       *val =3D max_array(vals, length);
>                         break;
>                 default:
>                         /* FIXME: learn about max for other iio values */
> --
> 2.40.1
>


--=20
With Best Regards,
Andy Shevchenko
