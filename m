Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFEF70F146
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240415AbjEXInb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbjEXInN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:43:13 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B851919D;
        Wed, 24 May 2023 01:43:11 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-623a5f60355so6301176d6.1;
        Wed, 24 May 2023 01:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684917791; x=1687509791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgfYShv53HpjHHRw+ArokaNBeybP0UvtNJ8o997RSQM=;
        b=AzjEIm4TO1QVqvekB8nTxH1xq9Tb4sM/6DB9+IrtR9Z+MW03Sl3KSgsEgF9HxK9K6X
         phbQneEYRqPKb6mqgN9QEFkxRzn020gKxlX6AKjj0UKiRoMxCo1gnwsGsBdgvgZPaBFV
         2vaZVCvSodcv9oeqDwV6IgNZ8SZhqMfrq0+WiOL6Vu5uI58pNdfvIBGDRsWwx1Rvnt1R
         CvRJ//qxHHtl3m53srPZzyYh95VLYlWUlUgcRBZA+xCtHnBGfNY2dbwOsiIvhEsivtDf
         6UlmNopc40obhe57Dme76bjeDi2jmuJlAes//huA6v212nRcHqbprcd5J8rACuSDLEDD
         aYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684917791; x=1687509791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgfYShv53HpjHHRw+ArokaNBeybP0UvtNJ8o997RSQM=;
        b=J3yH6kgnpIy6HYWq57lEf7k1FOiUDnAOaiWN+GkuxO/SMb73plxLQncAPuWDwxDlHg
         4rk6VoXH/MxJDiQvliU3BfwJfmWY16pXYZFxDEGvroWrkIlR615uy4V9cAqxLMTWlk1Z
         uwNoD2dXzFG98s9MwEZjDzGOXDW2KzjxrkGF/iqEg7mwOSTVcymxZt3lZCmo2Pq/ghEA
         bTlT2rQKo0Pp2j84lnhmExUNfq1KmqDwZD+3fqktRnSVYpsOaO1HvW1NA1g4bhrS+Dz9
         +xKSBPq4xW6jfKLZuGwzMnCqUSEjJvFc6Y5ZG9DKDaPW5TO4MT1D2AxyzSisWoKGPpyq
         2S5g==
X-Gm-Message-State: AC+VfDzk0VTtXscPwF5Ehhu1Cgg23bkQgR1v03D45hKu+375XKbf3MsU
        eWV5n8/XT7tVML3llf8B6nfiC9H0Nbt6aYGEROksAHzN1h4=
X-Google-Smtp-Source: ACHHUZ5m403hTwmbJR+4NSe1ebr6QaAIjFQ0rfPRWHg7sBGAb4fjpV/QHU45z1pqblk1ohafaV/4QZlFzQLwNMA0kHE=
X-Received: by 2002:a05:6214:e65:b0:625:aa49:c347 with SMTP id
 jz5-20020a0562140e6500b00625aa49c347mr852059qvb.59.1684917790757; Wed, 24 May
 2023 01:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230522071030.5193-1-zhuyinbo@loongson.cn> <20230522071030.5193-3-zhuyinbo@loongson.cn>
 <ZGy3b7ZfNwWoGDTu@surfacebook> <35b0500c-d7fe-6479-eeff-d45bbf9a9426@loongson.cn>
In-Reply-To: <35b0500c-d7fe-6479-eeff-d45bbf9a9426@loongson.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 24 May 2023 11:42:34 +0300
Message-ID: <CAHp75VdHPFDAd4iHdX5jXCM-tq0ZbFJDjvF9GCR_n7HVtd+obg@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] spi: loongson: add bus driver for the loongson
 spi controller
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
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

On Wed, May 24, 2023 at 10:52=E2=80=AFAM zhuyinbo <zhuyinbo@loongson.cn> wr=
ote:
> =E5=9C=A8 2023/5/23 =E4=B8=8B=E5=8D=888:54, andy.shevchenko@gmail.com =E5=
=86=99=E9=81=93:
> > Mon, May 22, 2023 at 03:10:30PM +0800, Yinbo Zhu kirjoitti:

...

> >> +static int loongson_spi_update_state(struct loongson_spi *loongson_sp=
i,
> >> +                            struct spi_device *spi, struct spi_transf=
er *t)
> >> +{
> >> +    unsigned int hz;
> >> +
> >> +    if (t)
> >> +            hz =3D t->speed_hz;
> >
> > And if t is NULL? hz will be uninitialized. Don't you get a compiler wa=
rning?
> > (Always test your code with `make W=3D1 ...`)
>
> I always use `make W=3D1` and I don't find any warning, but that what you
> said was right and I will initial hz.

Note, if hz =3D=3D 0 when t =3D=3D NULL, you can unify that check with the =
below.

> >> +    if (hz && loongson_spi->hz !=3D hz)

Something like

  if (t && _spi->hz !=3D t->speed_hz)
    ...(..., t->speed_hz);

In such a case you won't need a temporary variable.

> >> +            loongson_spi_set_clk(loongson_spi, hz);
> >> +
> >> +    if ((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK)
> >> +            loongson_spi_set_mode(loongson_spi, spi);
> >> +
> >> +    return 0;
> >> +}

...

> > Why do you use deprecated naming? Can you use spi_controller* instead o=
f
> > spi_master* in all cases?
>
> It seems was a personal code style issue and I don't find the
> differences between spi_controller and spi_master, Using spi_controller*
> is also acceptable to me and I will use spi_controller* instead of
> spi_master* in all cases.

Read this section (#4) in full
https://kernel.org/doc/html/latest/process/coding-style.html#naming

...

> >> +    clk =3D devm_clk_get_optional(dev, NULL);
> >> +    if (!IS_ERR(clk))
> >> +            spi->clk_rate =3D clk_get_rate(clk);
> >
> >> +    else
> >
> > Redundant. Just check for the error first as it's very usual pattern in=
 the
> > Linux kernel.
>
> Like below ?
>
>          clk =3D devm_clk_get_optional(dev, NULL);
> -       if (!IS_ERR(clk))
> -               spi->clk_rate =3D clk_get_rate(clk);
> -       else
> +       if (IS_ERR(clk))
>                  return dev_err_probe(dev, PTR_ERR(clk), "unable to get
> clock\n");
>
> +       spi->clk_rate =3D clk_get_rate(clk);

Yes.

>          loongson_spi_reginit(spi);

> >> +            return dev_err_probe(dev, PTR_ERR(clk), "unable to get cl=
ock\n");

...

> >> +    ret =3D loongson_spi_init_master(dev, reg_base);
> >> +    if (ret)
> >> +            return dev_err_probe(dev, ret, "failed to initialize mast=
er\n");
> >> +
> >> +    return ret;
> >
> >       return 0;
>
> It seems was more appropriate that initialize ret then return ret.
> Do you think so ?

What do you mean and how does it help here?


...

> >> +#include <linux/spi/spi.h>
> >
> > This neither.
>
> That other .c file seems to need it and I will move it to other .c
> code file.

Yes, please do.

...

> >> +#define     LOONGSON_SPI_SPCR_REG   0x00
> >> +#define     LOONGSON_SPI_SPSR_REG   0x01
> >> +#define     LOONGSON_SPI_FIFO_REG   0x02
> >> +#define     LOONGSON_SPI_SPER_REG   0x03
> >> +#define     LOONGSON_SPI_PARA_REG   0x04
> >> +#define     LOONGSON_SPI_SFCS_REG   0x05
> >> +#define     LOONGSON_SPI_TIMI_REG   0x06
> >
> > Where is this used outside of the main driver?
>
> These definitions are only used in core.c

Then the obvious question, why are they located in *.h?

...

> >> +/* Bits definition for Loongson SPI register */
> >> +#define     LOONGSON_SPI_PARA_MEM_EN        BIT(0)
> >> +#define     LOONGSON_SPI_SPCR_CPHA  BIT(2)
> >> +#define     LOONGSON_SPI_SPCR_CPOL  BIT(3)
> >> +#define     LOONGSON_SPI_SPCR_SPE   BIT(6)
> >> +#define     LOONGSON_SPI_SPSR_WCOL  BIT(6)
> >> +#define     LOONGSON_SPI_SPSR_SPIF  BIT(7)

Similar question here.

--=20
With Best Regards,
Andy Shevchenko
