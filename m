Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CC26B5B91
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCKMXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjCKMXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:23:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69C36EB8F;
        Sat, 11 Mar 2023 04:23:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 940F8B8250B;
        Sat, 11 Mar 2023 12:23:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EBDC433EF;
        Sat, 11 Mar 2023 12:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678537418;
        bh=L91S9HZyOqMMbzdcfJ0iugW2srAW1m53foAJZJnP9os=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=c8GScsWWkmkQpVuRNExqXMu3YE8l3cLMWHYh2KBPP2sdhC9XFB1HQBuF2nXtkKKu0
         Aes1n6Q10s4Rr7GxrDu6hwFnUvthTLXU2YE8ADQ+a4F69b0hM0f2edJp9QfdRmiavw
         YmsRyzCkaKfDdYuUHNu7ulacM0tjIHFSXTOIzFg3zfUeyXWAq2v7XOL5F0EMIQMG15
         jFBPl0oDpCfwVzUyorgq+3OhVCf0tRWDrkXioqcMwvm0OtgPR7AnpiAMaONJK+2ctE
         QlxuhouoDiICmQfdYcexV5lP/P0MK/sInMH1/s9ZRCQwvlUjB5i1DT5U7Zr+9fygHK
         mBuYbkqEtusmw==
Date:   Sat, 11 Mar 2023 12:23:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: adc: rcar-gyroadc: mark OF related data as
 maybe unused
Message-ID: <20230311122342.7aa5e6ad@jic23-huawei>
In-Reply-To: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023 12:14:54 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
>=20
>   drivers/iio/adc/rcar-gyroadc.c:286:34: error: =E2=80=98rcar_gyroadc_chi=
ld_match=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Whilst in general I'd prefer to see these converted to generic fw propertie=
s, this
one is not trivial. So applied to the togreg branch of iio.git.

It would be nice if anyone has time to circle back to this and get rid of
the of specific stuff.

Jonathan


> ---
>  drivers/iio/adc/rcar-gyroadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroad=
c.c
> index 27d9e147b4b7..b8972f673c9d 100644
> --- a/drivers/iio/adc/rcar-gyroadc.c
> +++ b/drivers/iio/adc/rcar-gyroadc.c
> @@ -283,7 +283,7 @@ static const struct of_device_id rcar_gyroadc_match[]=
 =3D {
> =20
>  MODULE_DEVICE_TABLE(of, rcar_gyroadc_match);
> =20
> -static const struct of_device_id rcar_gyroadc_child_match[] =3D {
> +static const struct of_device_id rcar_gyroadc_child_match[] __maybe_unus=
ed =3D {
>  	/* Mode 1 ADCs */
>  	{
>  		.compatible	=3D "fujitsu,mb88101a",

