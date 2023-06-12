Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C047D72C70D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 16:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237082AbjFLOLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 10:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbjFLOL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 10:11:28 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDBF10F2;
        Mon, 12 Jun 2023 07:11:17 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-75f07dee22cso162172485a.2;
        Mon, 12 Jun 2023 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686579076; x=1689171076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJQ+L6XrHRjNmHJu0KSlBODFfH7Ghg6JGFmz6a5x+ks=;
        b=ZUc6sxNRBAQ8xbX6AppejPyNMJJ9vsAbCmSZXAXJ+9uk+Ut11Ci70gGfKeCF6IdCYT
         0Npc6f438t0uTZnI96FsJGIPUr95LlFSa7BTMGsXKqAPr/uS1Gd0FExFSCuCQESBowVo
         UHu6ECTAF+m1SBtTZXBI/1yAUv9v6izlKf+yjVPKh/IzhBhQzv27yLbTGfoSSUcGyXPy
         BwfM8c3AbVWzckrG/d9VGxLDN5Tqj8OgcS8NktKVgeIJq9GaLzTzZNSeUPep/JBkJmo9
         cxUfmKHtDmA4HfbwfbZdAkmDSCfoZPeuXwkRNY9YARnk/VloxLigmPyPw0y9qBjNCk7G
         Xhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686579076; x=1689171076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJQ+L6XrHRjNmHJu0KSlBODFfH7Ghg6JGFmz6a5x+ks=;
        b=en7g3xAJ10IxtAUC9G/A1JhQgp56hO7pb2iAgittW5eHX6eeOxtHR5gXZaUwtow1yG
         u6AI1g5ZaifnvhkFFvbJfA/Iy4SiOHqP6CSVr1wAij6okbfTprc91z0JH1N2mazU2jwf
         tkwQAD6Go+Cm3SUiU6S2XZw5W+1GpolxO2BaKy9QNXql27o91pE8orITi9N75Ef+2LbS
         JEf4UnGK2L48iblPMTJ0K7F+Y5hMASbHyzqSl93P2vzNgW3x8v2P7GmHgqYDMDwV6z/X
         W9wdmTMVUMSvFbqlpWJVDi2drFNrvKmswL5G2GojzlGEhPTDF7+bcKj2OLx8fATGdMxo
         rlyA==
X-Gm-Message-State: AC+VfDwKJwkI56UTsKQLeM/WeokesCaSl8AiUvif1UkzVuHpKU1XnmXl
        lPfhz8Efo7Adp86vqPt8K+ayu4TJwByzoYEXZNs=
X-Google-Smtp-Source: ACHHUZ6XGswSinQMLW4VOPw+M6UjTIW5TYmForv0/8aMKQbhebyUxQ8+nfu1DnD/XddolUzFXKXLi6r/lySzLnim53A=
X-Received: by 2002:a05:6214:2268:b0:623:9218:58e5 with SMTP id
 gs8-20020a056214226800b00623921858e5mr11664934qvb.39.1686579076245; Mon, 12
 Jun 2023 07:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230612122926.107333-1-herve.codina@bootlin.com> <20230612122926.107333-7-herve.codina@bootlin.com>
In-Reply-To: <20230612122926.107333-7-herve.codina@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 12 Jun 2023 17:10:40 +0300
Message-ID: <CAHp75Vf2dmAS9VD-pgyZwVopVCFy8yFjhPWEj8sym=pfE7uxSA@mail.gmail.com>
Subject: Re: [PATCH v3 06/12] minmax: Introduce {min,max}_array()
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
> Introduce min_array() (resp max_array()) in order to get the
> minimal (resp maximum) of values present in an array.

Some comments below, after addressing them,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  include/linux/minmax.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> index 396df1121bff..37a211f22404 100644
> --- a/include/linux/minmax.h
> +++ b/include/linux/minmax.h
> @@ -133,6 +133,32 @@
>   */
>  #define max_t(type, x, y)      __careful_cmp((type)(x), (type)(y), >)
>
> +#define __minmax_array(op, array, len) ({                      \

Maybe it's my MUA, maybe the code contains spaces, can you switch to
TABs if it's the case?

> +       typeof(array) __array =3D (array);                        \

We have __must_be_array()

You will need to fix the inclusions in minmax.h at the same time, it needs
linux/build_bug.h (which includes compiler.h needed for __UNIQUE_ID()
and for the above mentioned one).

> +       typeof(len) __len =3D (len);                              \
> +       typeof(*__array + 0) __element =3D __array[--__len];      \

After above, this can be written as __array[0].

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

--=20
With Best Regards,
Andy Shevchenko
