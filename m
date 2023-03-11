Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCF56B5B9F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjCKM0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjCKM0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:26:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651F112A174;
        Sat, 11 Mar 2023 04:26:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AFEDB8253E;
        Sat, 11 Mar 2023 12:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE51C433D2;
        Sat, 11 Mar 2023 12:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678537575;
        bh=WWEV/AZi/4gJ0zJ5miocQqBDwokZqVtnROaY+HCBbUU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oy/+drkgmf7r3XPIVGhDWrBahGw1IeIzGDH2ZdJ87DkRPHkGvhmT83EkdA58IaJFB
         BK/NhE61ECOWrm43m1R406zZZ5QONFKgF8ptze7MV629Lp16mNiUmUnsdrwrktA2lg
         e4Sdn52cPkiu+Ccg4u16S6O1zE4C65Lhr5tQ3CfRpCO13chi9MaFbiYNlGbQpkxT2+
         SpRnDkAYRGIRcNmO5tj37RKWzt6oOrno3u/Rk7/P+Nv/F0BDsn15Ri7/Aj9DawUZq9
         p+uAspOKwOLa5kR7CdV3Kc3rULJcqYC8+du7nKfjjg7W2dfO7UvwzqoZFe+JoGJ50T
         YRiT8YBU5gzmw==
Date:   Sat, 11 Mar 2023 12:26:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: light: max44009: add missing OF device
 matching
Message-ID: <20230311122619.2d8bfaf5@jic23-huawei>
In-Reply-To: <20230311111457.251475-3-krzysztof.kozlowski@linaro.org>
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
        <20230311111457.251475-3-krzysztof.kozlowski@linaro.org>
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

On Sat, 11 Mar 2023 12:14:56 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> The driver currently matches only via i2c_device_id, but also has
> of_device_id table:
>=20
>   drivers/iio/light/max44009.c:545:34: error: =E2=80=98max44009_of_match=
=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>=20
> Fixes: 6aef699a7d7e ("iio: light: add driver for MAX44009")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Don't use of_match_ptr() unless you are absolutely sure no other firmware
route will make use of the of_match_table.

In this particular case ACPI using PRP0001 is broken by that macro.

So good to set the of_match_table, but make sure to always set it
and hence you don't need the __maybe_unused.

Jonathan

> ---
>  drivers/iio/light/max44009.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/iio/light/max44009.c b/drivers/iio/light/max44009.c
> index 3dadace09fe2..274e0b679ca2 100644
> --- a/drivers/iio/light/max44009.c
> +++ b/drivers/iio/light/max44009.c
> @@ -527,6 +527,12 @@ static int max44009_probe(struct i2c_client *client)
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
> =20
> +static const struct of_device_id max44009_of_match[] __maybe_unused =3D {
> +	{ .compatible =3D "maxim,max44009" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, max44009_of_match);
> +
>  static const struct i2c_device_id max44009_id[] =3D {
>  	{ "max44009", 0 },
>  	{ }
> @@ -536,18 +542,13 @@ MODULE_DEVICE_TABLE(i2c, max44009_id);
>  static struct i2c_driver max44009_driver =3D {
>  	.driver =3D {
>  		.name =3D MAX44009_DRV_NAME,
> +		.of_match_table =3D of_match_ptr(max44009_of_match),
>  	},
>  	.probe_new =3D max44009_probe,
>  	.id_table =3D max44009_id,
>  };
>  module_i2c_driver(max44009_driver);
> =20
> -static const struct of_device_id max44009_of_match[] =3D {
> -	{ .compatible =3D "maxim,max44009" },
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(of, max44009_of_match);
> -
>  MODULE_AUTHOR("Robert Eshleman <bobbyeshleman@gmail.com>");
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("MAX44009 ambient light sensor driver");

