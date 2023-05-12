Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E43370041F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbjELJmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240537AbjELJl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:41:27 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4214C106D3;
        Fri, 12 May 2023 02:41:06 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7576deacbd6so379275185a.3;
        Fri, 12 May 2023 02:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683884464; x=1686476464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgvI1wBQwWPAHGVgPMl1t4Eh+AyHOlrQwlKzTs1KGuU=;
        b=lqoAOFDFj2u5/n0ai2w3ScJeW4r/DBqFUliw7qxLsjG0PFIFzNU1BwY0io0X0OF3q0
         bo9Z4hx2DFNuUG4n691BU+R8M1cClttiFXnPIJMM2Ruh5qx1Yjx8BDSPhFoUlnMEIds5
         pZCETnymGjt4NQT499rNSrwqoIp9pqjbC9CHcjIzbjE9an+jA2KM1DHyRVhmzwN8th0m
         ipgH4SKJwNLaPYgke4IgbekzxC6zxyweeOwc1Ignd7xlw8QDPC+sYQwyzWhPlgZ3884I
         rFCJl312cuhfpRYIltuJoAmxAZV7CDL+lFUKvZ0yHh091cegtOdPCPGZoT0a1FG4NeSa
         MP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683884464; x=1686476464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgvI1wBQwWPAHGVgPMl1t4Eh+AyHOlrQwlKzTs1KGuU=;
        b=RnEjOCqNbVuTrAmpeuw/8g5d8615ewIFLmv1/wxOiFu7kwbrSPnkeOztDwU3dLPCZZ
         PMtJpuC2Penz9OfWEhnp2cejKHoiS/ZI1QaYz3NlOtRrA2fBT3rBVe4bd8XSeKsT1he/
         gvThYa1W2ZsKX9CImm95McsP+Ti7l0ZnRHBzqd37hZiZL1bcD6WVqQDcLfgXKYfJCBuE
         gtzJXfSZm1vNHI9kavG5BVppfXrvqMaHFuiRqmXBhwfPOV0Frwmd4cR/edqYiWd7AQWF
         Tfb5T21BZNFhG+xZVnYIboL0xWxioZyCfScSgpcSbt6gJNobEu9QiSPFJhcHk8cNS9ur
         SVnA==
X-Gm-Message-State: AC+VfDyy3KAlNBB+9yYCxovXcuVvVCn47z5tm3qsqyVYBEnJ5IHSoBTk
        bqAtdWB0Bd5hXDW76gybUqPKJJ6jubCIhw7L0HGpRepCu5QHeA==
X-Google-Smtp-Source: ACHHUZ5TSfhEDu1ZptfN3JyfXg4mv/nwO25G2/wAajLx3nsF0Zk2TzQP3B29yebA2rMPXVnZK7OXK4IZGaGce7/fHJo=
X-Received: by 2002:a05:6214:628:b0:621:42c8:9bdd with SMTP id
 a8-20020a056214062800b0062142c89bddmr17598245qvx.29.1683884464669; Fri, 12
 May 2023 02:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230426071045.20753-1-zhuyinbo@loongson.cn> <20230426071045.20753-3-zhuyinbo@loongson.cn>
 <ZFkPZhF8QqScXAmH@surfacebook> <ZFnOZptCM7JDFTQz@finisterre.sirena.org.uk>
 <CAHp75VcqQR0fFdkWG2QgXG0+SnKDs6_Zze6GMt+pHHEdE+8hkg@mail.gmail.com> <f03977b9-884c-93a1-d1cf-81e6fcf51dfc@loongson.cn>
In-Reply-To: <f03977b9-884c-93a1-d1cf-81e6fcf51dfc@loongson.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 12 May 2023 12:40:28 +0300
Message-ID: <CAHp75VeUiR_V0P6QhhqKGcoJKHviCC8wJZf+3KVBtWj+4q-=ig@mail.gmail.com>
Subject: Re: [PATCH v9 2/2] spi: loongson: add bus driver for the loongson spi controller
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

On Fri, May 12, 2023 at 11:12=E2=80=AFAM zhuyinbo <zhuyinbo@loongson.cn> wr=
ote:
> =E5=9C=A8 2023/5/10 =E4=B8=8B=E5=8D=883:03, Andy Shevchenko =E5=86=99=E9=
=81=93:

...

> so, I think it is better
> to confiure clk and mode separately.

Agree, but at the same time you can split the conditional bodies to
the separate functions. In this case the indentation of each of them
can be decreased.

...

> > Also the check can be modified to have less indented code:
> >
> >         if (hz && loongson_spi->hz =3D=3D hz)
> >            return 0;
> >
> >         if (!((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK))
> >            return 0;
>
> The setting register about clk and mode was the same SPCR register, so
> only the clk and mode don't need to be updated in the same, then return
> 0, so the code seems to be as follows. But setting clk and mode
> separately doesn't require follows judgement.
>
>          if ((hz && loongson_spi->hz =3D=3D hz) &&
>              !((spi->mode ^ loongson_spi->mode) & SPI_MODE_X_MASK))
>                  return 0;

Correct, sorry for the mistake I made.

--=20
With Best Regards,
Andy Shevchenko
