Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE7773B0A1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 08:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjFWGRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 02:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjFWGRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 02:17:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A8C189;
        Thu, 22 Jun 2023 23:17:00 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-988a2715b8cso260762866b.0;
        Thu, 22 Jun 2023 23:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1687501019; x=1690093019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTzRTBwuHpC7/hhWw9l446CStpPhNQn+H0m14KUu0h8=;
        b=VhM2vnJgCLaRCOzs0kOlroNdVzfrTvRkeuZIBNxezHdrD5f8hVG2zJtCjk15wJDIu9
         E3xJORLjKw5yGUvWyEnyfHARLXnT+RXT5MPD/hpvgYdNSlMXCzFv8ZPW6MiO+xY2hsF8
         nP2ScAqRqHyyJDKZzc/ikUla4De9zOcOpGIC33KJEu9csebDnzuh2nenlz25Fqw+PDFU
         xDLuzmYKVuZgGXKpj3lLeR3HW4Ob67rVKC2+2LRyAedaLqVXsA6DoqxxDdOw0l4Dn1sh
         YyKOHTFzUwvur5wsCqj1P3sXGmMA9wYIUEitkcaS3RoZxhVvuxeEFCYdKJJJVL+ARIHS
         t8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687501019; x=1690093019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTzRTBwuHpC7/hhWw9l446CStpPhNQn+H0m14KUu0h8=;
        b=Iomv6ZuJPXjezL8d72iwuL+3tQ4AvPNQyyzVyuynCJSEY+I8wtVQ/u1qintDMKckNl
         cQF0LIk6WcdtPjckTiYaha9VnXNm5SLwnrP2+0rVu47yKo7D9nRqayK+N3aeHBwiJ7a1
         Bq5gA1SlU2PME4D9wzaRr4Pf/YrERQXluPPqLnNi6ifdPIC2VgLw2p5fcdram4CMpd1w
         Jt9Hs8vzXP0arfh47vTQ+KTH41eBVfRL24P3EBzAj5W5U8lHcY3gSrCi3hW643znzpZj
         GK+0eNcB5EMv0DOhg0eGtutTLnD+XI3WyPracsg0By9a+e6Te+Qvk/PO/w106YOLoZgW
         4W9g==
X-Gm-Message-State: AC+VfDy3zSOPBkBPBtePky3L3uL/OBFhNG+r9Gd1Z1EcXhxBHsuMsPUv
        E76hi5jxtfsv8P5iqjWGLOWq2GNVSRu5k51pLevNHgkcc90=
X-Google-Smtp-Source: ACHHUZ7/k41yx67lWIal2QXf8cBmr9dIrsOBDzFQcnBkJqFbQY3pmpiYMLIDfCUFTJ2f2iU93/paSGzeBcAK9TsqaNg=
X-Received: by 2002:a17:907:3e83:b0:987:fe18:1c58 with SMTP id
 hs3-20020a1709073e8300b00987fe181c58mr15265725ejc.35.1687501018686; Thu, 22
 Jun 2023 23:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230623022334.791026-1-gnstark@sberdevices.ru> <20230623022334.791026-7-gnstark@sberdevices.ru>
In-Reply-To: <20230623022334.791026-7-gnstark@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 23 Jun 2023 08:16:47 +0200
Message-ID: <CAFBinCBv993Xv_wk9fE-U0Tw2mzTB1z22Tj6x8Uy1rRw_dztng@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] meson saradc: support reading from channel7 mux inputs
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        andriy.shevchenko@linux.intel.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George,

On Fri, Jun 23, 2023 at 4:23=E2=80=AFAM George Stark <gnstark@sberdevices.r=
u> wrote:
[...]
> Meson saradc channel 7 is connected to muxer that can switch channel
I think that this should read: ... is connected to a mux that ...

[...]
>  static const struct iio_chan_spec meson_sar_adc_iio_channels[] =3D {
> @@ -245,6 +280,11 @@ static const struct iio_chan_spec meson_sar_adc_iio_=
channels[] =3D {
>         MESON_SAR_ADC_CHAN(INDEX_CHAN_6),
>         MESON_SAR_ADC_CHAN(INDEX_CHAN_7),
>         IIO_CHAN_SOFT_TIMESTAMP(INDEX_CHAN_SOFT_TIMESTAMP),
> +       MESON_SAR_ADC_MUX(INDEX_MUX_0_VSS, 0),
> +       MESON_SAR_ADC_MUX(INDEX_MUX_1_VDD_DIV4, 1),
> +       MESON_SAR_ADC_MUX(INDEX_MUX_2_VDD_DIV2, 2),
> +       MESON_SAR_ADC_MUX(INDEX_MUX_3_VDD_MUL3_DIV4, 3),
> +       MESON_SAR_ADC_MUX(INDEX_MUX_4_VDD, 4),
>         MESON_SAR_ADC_TEMP_CHAN(), /* must be the last item */
I haven't had the chance to run these patches yet but: I think they
are breaking the temperature sensor readings on Meson8/8b/8m2 boards.
See arch/arm/boot/dts/meson.dtsi where the temperature channel is
being referenced:
  io-channels =3D <&saradc 8>

With this series (this patch and I think also patch 3/6 "meson saradc:
unite iio channel array definitions") the numbering of the temperature
sensor channel changes.

To make things worse: in theory we can use meson_saradc to read the
SoC temperature sensor on GXBB, GXL and GXM boards (possibly on AXG as
well but I can't recall from the top of my head) instead of going
through SCPI.
I have experimented with this in the past but never got it to work.
Doing so in the future could lead to another channel index change,
depending on how we decide to go forward now.

There's two that I can think of:
- update meson.dtsi to use the new channel numbering (I don't expect
many 32-bit SoC users out there using new kernel + old .dtbs, but it's
impossible to say for sure)
- or keep the driver backwards compatible (that involves re-adding the
channel tables)

What do you think?


Best regards,
Martin
