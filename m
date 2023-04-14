Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32C76E2300
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 14:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjDNMTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 08:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjDNMTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:07 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F80DAF2F;
        Fri, 14 Apr 2023 05:18:59 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3B6DF1C0AB2; Fri, 14 Apr 2023 14:18:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681474737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=InXn1mnCQb60OaHGqR1PyiWllWN8NzscdCBFzBmsktY=;
        b=I/sjtYsvR/SFOkX263vbDHOipPmHh8JPI3BhualkCX2QOQmboW963ASrb46Q1DGtg2/Ixd
        2/2dXDL3VK5brk6cl9PXfk+lA5F7CfWnWWEMQVyt6c/7Mqjk5AtPnMpjToxt26MAOarh+i
        a6hox+6kLA3UM2pQnj/7wW9R61xdOCQ=
Date:   Fri, 14 Apr 2023 14:18:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v4 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel
 i2c LED driver
Message-ID: <ZDlEsNZ3pTlfxkAz@duo.ucw.cz>
References: <20230414055341.335456-1-andreas@kemnade.info>
 <20230414055341.335456-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="e+NFTEiMTvUPTd0l"
Content-Disposition: inline
In-Reply-To: <20230414055341.335456-3-andreas@kemnade.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e+NFTEiMTvUPTd0l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The device provides 6 channels which can be individually
> turned off and on but groups of two channels share a common brightness
> register.

Yeah, well.. Turn it into 3-channel controller with brightness or
6-channel on/off one... You can't really share brightness.

> +++ b/drivers/leds/Kconfig
> @@ -551,6 +551,17 @@ config LEDS_REGULATOR
>  	help
>  	  This option enables support for regulator driven LEDs.
> =20
> +config LEDS_BD2606MVV
> +	tristate "LED driver for BD2606MVV"
> +	depends on LEDS_CLASS
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	  This option enables support for BD2606MVV LED driver chips
> +	  accessed via the I2C bus. It supports setting brightness, with
> +	  the limitiation that there are groups of two channels sharing
> +	  a brightness setting, but not the on/off setting.
> +

This driver can be used as a module...


> +static int
> +bd2606mvv_brightness_set(struct led_classdev *led_cdev,
> +		      enum led_brightness brightness)
> +{
> +	struct bd2606mvv_led *led =3D ldev_to_led(led_cdev);
> +	struct bd2606mvv_priv *priv =3D led->priv;
> +	int err;
> +
> +	if (brightness =3D=3D 0)
> +		return regmap_update_bits(priv->regmap,
> +					  BD2606_REG_PWRCNT,
> +					  1 << led->led_no,
> +					  0);
> +
> +	/* shared brightness register */
> +	err =3D regmap_write(priv->regmap, led->led_no / 2,
> +			   brightness);
> +	if (err)
> +		return err;

Yeah. No.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--e+NFTEiMTvUPTd0l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZDlEsAAKCRAw5/Bqldv6
8gQFAJ9WM7mh4Jr1kPIoZ8X74ept2/NspACePZmDwS95kzF8F87gckGLo7aIjxM=
=mPPh
-----END PGP SIGNATURE-----

--e+NFTEiMTvUPTd0l--
