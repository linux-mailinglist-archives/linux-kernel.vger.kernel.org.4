Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AA672F89C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 11:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbjFNJDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 05:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbjFNJDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 05:03:35 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169D81BDB;
        Wed, 14 Jun 2023 02:03:34 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-62dee8362b8so14246366d6.2;
        Wed, 14 Jun 2023 02:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686733413; x=1689325413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDK3MtavhJ0jc2b3czgJlDdUH3DaBksRE0QNj22csxA=;
        b=p40DY8X68mMMSWH7Na3IbMci2T/wHM1fKkXD2sWO//syp2d1yF7L5RE8aH0vU+FrOq
         Zo9oBHbKT3PmXCwrhMf9BAPfX3sRI+36+HRBtuu36drPIfSEcAdF6WZbhcSrjNjNKnNu
         xdioIu9o98eVYz1qbrIqR8KuAq7lwgp9cvjCCBC6sK1b0eMnsJJ9Hwypy6WfwI3PKnEA
         CSEWZhGqTcCtStAM/yQO8oMye3tows9ykJWP6cZumoDqXVm9M9UATXAADCFUQPvlhpJt
         aR+3Pqn14iOPgicXjqKbVzJ3iVHMLuCuhDxY9Hhl8G9k1dNohPzWH6CPHX6gKDx77Yma
         lbVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686733413; x=1689325413;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDK3MtavhJ0jc2b3czgJlDdUH3DaBksRE0QNj22csxA=;
        b=KzrmASq0OadWwStAm/5zLJSUTQ+22X+W3a23brisfigtUNZVnmkgWHRDdKW57LnOLp
         lizEmKOpnZn/IPAFkMLjABAsfLdcdqi1w8dvJhdIgIWx3754oNTewql1ylrGczQjFaPV
         Hi0opnDqo+kHJqnv3+HBrQBEbv9RglbtLPFYiIXu/67fIOgkH0RxEokYjhOZ/G7WajJf
         nFPoKHpKMNpWU7I/srUOT9cgEkxJPydcDQvRtcVLQUIKlEo0gsoMVaj5uM7TgXEmgNIh
         HCqr7c10n10mo9vpEIFxKuIkrqCKPgcgghC2lZpV6WsT/fbrOpoX1Sc+49LU7qFUmRFx
         62lw==
X-Gm-Message-State: AC+VfDyn/pI9oV2Xg4bF3P63XyRrgjJOZ0j/7N1sJYHLmNCJcolDx6Hg
        otryeiLqTL1G5YyTzptJofuQwB8RHRfLmjdowao=
X-Google-Smtp-Source: ACHHUZ5bkfEjM3AcaOuo5Gno79KcyMddDSjkjdBXFLGx1NPVfqe242XBa8ULTPvF0YTkS+HS3HMoif6acSrEcNQRQhU=
X-Received: by 2002:a05:6214:c87:b0:62d:ecdb:ae17 with SMTP id
 r7-20020a0562140c8700b0062decdbae17mr8847887qvr.48.1686733413056; Wed, 14 Jun
 2023 02:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230614074904.29085-1-herve.codina@bootlin.com> <20230614074904.29085-8-herve.codina@bootlin.com>
In-Reply-To: <20230614074904.29085-8-herve.codina@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Jun 2023 12:02:57 +0300
Message-ID: <CAHp75Vcur=H_2mBm5Ztuvd7Jnvmr6+tvCbEkFtmaVLsEjXr8NQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/13] minmax: Introduce {min,max}_array()
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
> Introduce min_array() (resp max_array()) in order to get the
> minimal (resp maximum) of values present in an array.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
See a remark below.

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  include/linux/minmax.h | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> index 396df1121bff..2cd0d34ce921 100644
> --- a/include/linux/minmax.h
> +++ b/include/linux/minmax.h
> @@ -133,6 +133,42 @@
>   */
>  #define max_t(type, x, y)      __careful_cmp((type)(x), (type)(y), >)
>
> +/*
> + * Do not check the array parameter using __must_be_array().
> + * In the following legit use-case where the "array" passed is a simple =
pointer,
> + * __must_be_array() will return a failure.
> + * --- 8< ---
> + * int *buff
> + * ...
> + * min =3D min_array(buff, nb_items);
> + * --- 8< ---
> + */
> +#define __minmax_array(op, array, len) ({                      \
> +       typeof(array) __array =3D (array);                        \
> +       typeof(len) __len =3D (len);                              \
> +       typeof(__array[0] + 0) __element =3D __array[--__len];    \

Do we need the ' + 0' part?

> +       while (__len--)                                         \
> +               __element =3D op(__element, __array[__len]);      \
> +       __element; })
> +
> +/**
> + * min_array - return minimum of values present in an array
> + * @array: array
> + * @len: array length
> + *
> + * Note that @len must not be zero (empty array).
> + */
> +#define min_array(array, len) __minmax_array(min, array, len)
> +
> +/**
> + * max_array - return maximum of values present in an array
> + * @array: array
> + * @len: array length
> + *
> + * Note that @len must not be zero (empty array).
> + */
> +#define max_array(array, len) __minmax_array(max, array, len)
> +
>  /**
>   * clamp_t - return a value clamped to a given range using a given type
>   * @type: the type of variable to use
> --
> 2.40.1
>


--=20
With Best Regards,
Andy Shevchenko
