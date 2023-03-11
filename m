Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8478F6B5BA7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjCKM2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjCKM2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:28:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2714E6A04A;
        Sat, 11 Mar 2023 04:28:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FC9660B2B;
        Sat, 11 Mar 2023 12:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EA7C433D2;
        Sat, 11 Mar 2023 12:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678537709;
        bh=D2mybpZz5PmhmuGyRejIVsx4IMdbFcJrqX+NzKNLRUw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gxu3+BwOTGlxGxV/ITtRawojP2nR0EylrWZhmXQ6d9YLzFkRtslnIoaMxL/KZF9Rk
         3H1n1oUepJ0jGq4alM84577NfDBP7yilf5Sw4LjiXAviRUNrqYgVy+7GZc9fGQYOMB
         W9Gq35q+BH6gsT4z+dAtgp4PDiN+9Pgypah6C0PAJH1ocR8HJEjsqoa1/9uSI67Pa2
         lMQ3oawkSaRaGtdNHitktgvvIw8W9gyGez5tS0dfCR6QNYqGOI6vs05abE1NS35V0G
         WNIdNkk7dSbodqcVwsBC+GjZafHt+oNVNeNCsKnIBFGhmyvtp5dnbiwHTVHPcME/hY
         eN4Wv+JljuLwQ==
Date:   Sat, 11 Mar 2023 12:28:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Robert Eshleman <bobbyeshleman@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: proximity: sx9500: Mark ACPI and OF related
 data as maybe unused
Message-ID: <20230311122833.03b5a3d7@jic23-huawei>
In-Reply-To: <20230311111457.251475-4-krzysztof.kozlowski@linaro.org>
References: <20230311111457.251475-1-krzysztof.kozlowski@linaro.org>
        <20230311111457.251475-4-krzysztof.kozlowski@linaro.org>
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

On Sat, 11 Mar 2023 12:14:57 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making
> certain data unused:
>=20
>   drivers/iio/proximity/sx9500.c:1039:34: error: =E2=80=98sx9500_of_match=
=E2=80=99 defined but not used [-Werror=3Dunused-const-variable=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hi Krysztof

Thanks for looking at these warnings.=20

Drop the protection macros instead.  The tables are trivial in size and
the of_match_ptr() breaks some ways this driver can be used.
ACPI_PTR() isn't as bad, but is pretty much pointless given this size of
the array.=20

Jonathan


> ---
>  drivers/iio/proximity/sx9500.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx950=
0.c
> index 8794e75e5bf9..840db1953998 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -1036,13 +1036,13 @@ static const struct acpi_device_id sx9500_acpi_ma=
tch[] =3D {
>  };
>  MODULE_DEVICE_TABLE(acpi, sx9500_acpi_match);
> =20
> -static const struct of_device_id sx9500_of_match[] =3D {
> +static const struct of_device_id sx9500_of_match[] __maybe_unused =3D {
>  	{ .compatible =3D "semtech,sx9500", },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, sx9500_of_match);
> =20
> -static const struct i2c_device_id sx9500_id[] =3D {
> +static const struct i2c_device_id sx9500_id[] __maybe_unused =3D {
>  	{"sx9500", 0},
>  	{ },
>  };

