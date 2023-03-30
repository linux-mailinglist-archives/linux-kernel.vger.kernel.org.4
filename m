Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154606D0112
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjC3KW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjC3KW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:22:27 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A1B72A7;
        Thu, 30 Mar 2023 03:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1680171745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VGHsFX//OaGQNkF65N1mnptJa5eabIq/GSa6LSUjVbg=;
        b=33l8t7HMuPIVgsJvevZRWWGlBxpXeIbbtIXK0HZABd6ySQ8ArDFD/R0Dguky78AIjAUxu5
        Y4NSZAPBIRjBdMF2LrEh8sdpJLJBc+jRvK2CFbiFdFIV/mgkiCxrZwPiZxY2D2tYB5lCX3
        qNBjK/sV5ERLdK5ugN5h2HwsezYlSVo=
Message-ID: <c210dddd41c55118d333af16d168436be0d77ccc.camel@crapouillou.net>
Subject: Re: [PATCH] iio: adc: ad7192: Change "shorted" channels to
 differential
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alisa Roman <alisa.roman@analog.com>
Date:   Thu, 30 Mar 2023 12:22:23 +0200
In-Reply-To: <20230330102100.17590-1-paul@crapouillou.net>
References: <20230330102100.17590-1-paul@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 30 mars 2023 =C3=A0 12:21 +0200, Paul Cercueil a =C3=A9crit=C2=A0:
> The AD7192 provides a specific channel configuration where both
> negative
> and positive inputs are connected to AIN2. This was represented in
> the
> ad7192 driver as a IIO channel with .channel =3D 2 and .extended_name
> set
> to "shorted".
>=20
> The problem with this approach, is that the driver provided two IIO
> channels with the identifier .channel =3D 2; one "shorted" and the
> other
> not. This goes against the IIO ABI, as a channel identifier should be
> unique.
>=20
> Address this issue by changing "shorted" channels to being
> differential
> instead, with channel 2 vs. itself, as we're actually measuring AIN2
> vs.
> itself.
>=20
> Note that the fix tag is for the commit that moved the driver out of
> staging. The bug existed before that, but backporting would become
> very
> complex further down and unlikely to happen.
>=20
> Fixes: b581f748cce0 ("staging: iio: adc: ad7192: move out of
> staging")

Forgot to Cc: stable@vger.kernel.org

D'oh.

-Paul

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Co-developed-by: Alisa Roman <alisa.roman@analog.com>
> Signed-off-by: Alisa Roman <alisa.roman@analog.com>
> ---
> =C2=A0drivers/iio/adc/ad7192.c | 8 ++------
> =C2=A01 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 55a6ab591016..99bb604b78c8 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -897,10 +897,6 @@ static const struct iio_info ad7195_info =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__AD719x_CHANNEL(_si, _ch=
annel1, -1, _address, NULL,
> IIO_VOLTAGE, \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
> =C2=A0
> -#define AD719x_SHORTED_CHANNEL(_si, _channel1, _address) \
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__AD719x_CHANNEL(_si, _channel=
1, -1, _address, "shorted",
> IIO_VOLTAGE, \
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0BIT(IIO_CHAN_INFO_SCALE), ad7192_calibsys_ext_info)
> -
> =C2=A0#define AD719x_TEMP_CHANNEL(_si, _address) \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__AD719x_CHANNEL(_si, 0, =
-1, _address, NULL, IIO_TEMP, 0,
> NULL)
> =C2=A0
> @@ -908,7 +904,7 @@ static const struct iio_chan_spec
> ad7192_channels[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_DIFF_CHANNEL(0, 1,=
 2, AD7192_CH_AIN1P_AIN2M),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_DIFF_CHANNEL(1, 3,=
 4, AD7192_CH_AIN3P_AIN4M),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_TEMP_CHANNEL(2, AD=
7192_CH_TEMP),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_SHORTED_CHANNEL(3, 2, A=
D7192_CH_AIN2P_AIN2M),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_DIFF_CHANNEL(3, 2, 2, A=
D7192_CH_AIN2P_AIN2M),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_CHANNEL(4, 1, AD71=
92_CH_AIN1),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_CHANNEL(5, 2, AD71=
92_CH_AIN2),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_CHANNEL(6, 3, AD71=
92_CH_AIN3),
> @@ -922,7 +918,7 @@ static const struct iio_chan_spec
> ad7193_channels[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_DIFF_CHANNEL(2, 5,=
 6, AD7193_CH_AIN5P_AIN6M),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_DIFF_CHANNEL(3, 7,=
 8, AD7193_CH_AIN7P_AIN8M),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_TEMP_CHANNEL(4, AD=
7193_CH_TEMP),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_SHORTED_CHANNEL(5, 2, A=
D7193_CH_AIN2P_AIN2M),
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_DIFF_CHANNEL(5, 2, 2, A=
D7193_CH_AIN2P_AIN2M),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_CHANNEL(6, 1, AD71=
93_CH_AIN1),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_CHANNEL(7, 2, AD71=
93_CH_AIN2),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AD719x_CHANNEL(8, 3, AD71=
93_CH_AIN3),

