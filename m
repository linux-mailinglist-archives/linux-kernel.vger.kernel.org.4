Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976916E47CF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjDQMcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjDQMcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:32:14 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF6D40C8;
        Mon, 17 Apr 2023 05:31:54 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E58441C0AAC; Mon, 17 Apr 2023 14:22:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1681734138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TMSz1lAK35MpBVUGidPj7aPRPLhQxtWZ8osEdlLH4+I=;
        b=n7jAYTwnbWSKqJatEkhXvM+uj3RNwd5yZMMxFPzMGMwcVAns3ZEg76o9o5yjmNNWGMdVQC
        mi3qoED20xTPUnSr46I4ugZyyAIhF+EItPklUMDiOe5R1lrN+J7J0Ta9TLF+J/BGnZuIdz
        kGY1aZbWK+iAM375/jgC7/d4TwC9lLw=
Date:   Mon, 17 Apr 2023 14:22:18 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v5 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel
 i2c LED driver
Message-ID: <ZD05+hsRy14semza@duo.ucw.cz>
References: <20230416211550.903240-1-andreas@kemnade.info>
 <20230416211550.903240-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="CavukPz3qjkkik6i"
Content-Disposition: inline
In-Reply-To: <20230416211550.903240-3-andreas@kemnade.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CavukPz3qjkkik6i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The device provides 6 channels which can be individually
> turned off and on but groups of two channels share a common brightness
> register.
>=20
> Limitation: The GPIO to enable the device is not used yet.

(I'd expect some explanation how you dealt with the brigthness pairing
here. I can figure it out from the fcode, but... I guess you should
state it at the begining of driver in a comment at least.).

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

Add the usual note about modules here.

Rest looks ok.

With that fixed:

Acked-by: Pavel Machek <pavel@ucw.cz>

BR,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--CavukPz3qjkkik6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZD05+gAKCRAw5/Bqldv6
8szwAJwJ3gPBrUGUJrvKe/X53Q+8LFQapQCdGmCdEGSLf2q4zh/17voy5bfHfZg=
=AO+P
-----END PGP SIGNATURE-----

--CavukPz3qjkkik6i--
