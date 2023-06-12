Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC9372C86F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbjFLO16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbjFLO1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:27:34 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEFE3A9E;
        Mon, 12 Jun 2023 07:25:40 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-461b408594fso3052613e0c.1;
        Mon, 12 Jun 2023 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686579937; x=1689171937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J56F2gro6FOKUtNX+Ibu7D0wvtB+UfEnw2ffuy1QzrY=;
        b=arkO2SE+dA04/OqEpwC+/t34sNUjnTjowWGnkywgbZMY/0Q0Dh00G9lsJo2GWrsgl8
         neRIDZUsVSTPNZZ8xeOEIop8nRZBZFP1bft4o0oJmdsU4cqKpad32UYaMK9unhwmHH6T
         D/p1fHh70PFVfdLEM/BylHheaQlswtZhcRETVKLlUHUlCMF/g+xKEBaamGwZocOmHZHh
         6CnPvVVaNnQt+eYDSn2Fk34nDdYP9x/VKsvawFty0LL3y5SkvprO0spVJTDfKvTg5vrE
         Wy9YKgA2ZRH9vSg/bPPr5LuGRh3WISnN/CrTNwWkSzRQg7sHDG8SwTJgGY06Q67mNaJa
         eFUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579937; x=1689171937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J56F2gro6FOKUtNX+Ibu7D0wvtB+UfEnw2ffuy1QzrY=;
        b=hatf9q5S+RDZ2XNJYhckb8QNQFxgZPtJoYvK2jC2DXHPWdcafEqJT8kbTEMbsyAEdQ
         5GjX+wQsm4xqu3HeupEDuhQqywjnJFv51FdqW6FLOWRTmvzwSHIGuspwSb/YwWY9c1k4
         0/642M5ny9vxZAg+APSnLIy63aIhEeXml4cxLC6WI8fGEPHogThFHDGgyj82Hvoufgqu
         7g3PxpBxaX339vcDy6DGIA9Vfg6kse8s3kYjEQ6ycnuHg+EF21tCY8ma9UTEerO9Q4P6
         5qnZ/PR//NEqom32Xx6p/EkNpSVg+QpRVUZa7CfKPRDNe6P7jNN17g3oIOgOo3GCUD+h
         E0cw==
X-Gm-Message-State: AC+VfDwjxTR+/yfEnZ/CqI+wzHHM4okYqvYzvER+sadU48D2D7Y72o0Z
        KeBMMqQrF6sK0lScpMeaOMcOEgYLMrg6YOJu6sX44fLt7lgyqIes
X-Google-Smtp-Source: ACHHUZ4XPsRNUdUHh24YV26MKxBIyaOxt62KXPAlGGGGnwhH3uGcj+WHpwdzo7780i4kXoH2ZbqxqN7AJm7KJRpRqAo=
X-Received: by 2002:a05:6214:21eb:b0:629:37e6:d43c with SMTP id
 p11-20020a05621421eb00b0062937e6d43cmr12939727qvj.18.1686579381157; Mon, 12
 Jun 2023 07:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230612122926.107333-1-herve.codina@bootlin.com> <20230612122926.107333-10-herve.codina@bootlin.com>
In-Reply-To: <20230612122926.107333-10-herve.codina@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Jun 2023 17:15:45 +0300
Message-ID: <CAHp75VdL+e-BArbJheJVpgw+YRdj82iBL=6imeqjBXXwQrWDKQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] iio: inkern: Add a helper to query an available
 minimum raw value
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

On Mon, Jun 12, 2023 at 3:30=E2=80=AFPM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> A helper, iio_read_max_channel_raw() exists to read the available
> maximum raw value of a channel but nothing similar exists to read the
> available minimum raw value.
>
> This new helper, iio_read_min_channel_raw(), fills the hole and can be
> used for reading the available minimum raw value of a channel.
> It is fully based on the existing iio_read_max_channel_raw().

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/iio/inkern.c         | 63 ++++++++++++++++++++++++++++++++++++
>  include/linux/iio/consumer.h | 12 +++++++
>  2 files changed, 75 insertions(+)
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 4331e74191cf..4f383a5ef59f 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -909,6 +909,69 @@ int iio_read_max_channel_raw(struct iio_channel *cha=
n, int *val)
>  }
>  EXPORT_SYMBOL_GPL(iio_read_max_channel_raw);
>
> +static int iio_channel_read_min(struct iio_channel *chan,
> +                               int *val, int *val2, int *type,
> +                               enum iio_chan_info_enum info)
> +{
> +       const int *vals;
> +       int length;
> +       int ret;
> +
> +       ret =3D iio_channel_read_avail(chan, &vals, type, &length, info);
> +       if (ret < 0)
> +               return ret;
> +
> +       switch (ret) {
> +       case IIO_AVAIL_RANGE:
> +               switch (*type) {
> +               case IIO_VAL_INT:
> +                       *val =3D vals[0];
> +                       break;
> +               default:
> +                       *val =3D vals[0];
> +                       if (val2)
> +                               *val2 =3D vals[1];
> +               }
> +               return 0;
> +
> +       case IIO_AVAIL_LIST:
> +               if (length <=3D 0)
> +                       return -EINVAL;
> +               switch (*type) {
> +               case IIO_VAL_INT:
> +                       *val =3D min_array(vals, length);
> +                       break;
> +               default:
> +                       /* TODO: learn about min for other iio values */
> +                       return -EINVAL;
> +               }
> +               return 0;
> +
> +       default:
> +               return -EINVAL;
> +       }
> +}
> +
> +int iio_read_min_channel_raw(struct iio_channel *chan, int *val)
> +{
> +       struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(chan-=
>indio_dev);
> +       int ret;
> +       int type;
> +
> +       mutex_lock(&iio_dev_opaque->info_exist_lock);
> +       if (!chan->indio_dev->info) {
> +               ret =3D -ENODEV;
> +               goto err_unlock;
> +       }
> +
> +       ret =3D iio_channel_read_min(chan, val, NULL, &type, IIO_CHAN_INF=
O_RAW);
> +err_unlock:
> +       mutex_unlock(&iio_dev_opaque->info_exist_lock);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(iio_read_min_channel_raw);
> +
>  int iio_get_channel_type(struct iio_channel *chan, enum iio_chan_type *t=
ype)
>  {
>         struct iio_dev_opaque *iio_dev_opaque =3D to_iio_dev_opaque(chan-=
>indio_dev);
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index f536820b9cf2..e9910b41d48e 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -301,6 +301,18 @@ int iio_write_channel_raw(struct iio_channel *chan, =
int val);
>   */
>  int iio_read_max_channel_raw(struct iio_channel *chan, int *val);
>
> +/**
> + * iio_read_min_channel_raw() - read minimum available raw value from a =
given
> + *                             channel, i.e. the minimum possible value.
> + * @chan:              The channel being queried.
> + * @val:               Value read back.
> + *
> + * Note, if standard units are required, raw reads from iio channels
> + * need the offset (default 0) and scale (default 1) to be applied
> + * as (raw + offset) * scale.
> + */
> +int iio_read_min_channel_raw(struct iio_channel *chan, int *val);
> +
>  /**
>   * iio_read_avail_channel_raw() - read available raw values from a given=
 channel
>   * @chan:              The channel being queried.
> --
> 2.40.1
>


--=20
With Best Regards,
Andy Shevchenko
