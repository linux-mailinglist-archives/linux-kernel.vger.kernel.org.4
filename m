Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1837E742484
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 12:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjF2K5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 06:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232174AbjF2K4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 06:56:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA133591
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 03:56:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 428B76151F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:56:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1FCC433C0;
        Thu, 29 Jun 2023 10:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688036174;
        bh=SsHrd0a3xX9lEFW/D91waJ2yGupj0If+hXa08iyds88=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJPT6SimAVLOSHLWyLfu2C7DNtd/C/0d6uycUVAVI3vaW9zorMPRVOPRsZbfXN0gQ
         kQapHh0LR/Pez1DnBA5VfsDmdcYl00bLFkqkv+szIojKHp4dRJl77SnYH+8aibNLuF
         WwiiHJL1QyYp6VSjQq4WgXE20V7veuR27kCFtLfV/+HQ4oBI99zLXXb0845MNnv5Bf
         B28LiUz8NkryaBjNsmqy3BxOzwQaaQ+D5eFSZlI/q3CxwJaCLVzOEv2d0rxaAdBo10
         XhJvvBU72YvVTauEPWhiSWh6diejT9TcsRmSN3bdb9ThVm10oMbfZVJ73JHCvdx+hz
         yZXiLEynL1zjw==
Date:   Thu, 29 Jun 2023 11:56:10 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 2/3] ASoC: rt5677: Use device_get_match_data()
Message-ID: <33d3ba54-e391-454f-942c-67f498711078@sirena.org.uk>
References: <20230629104603.88612-1-andriy.shevchenko@linux.intel.com>
 <20230629104603.88612-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ITgdYOOT/qXXKL5O"
Content-Disposition: inline
In-Reply-To: <20230629104603.88612-3-andriy.shevchenko@linux.intel.com>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ITgdYOOT/qXXKL5O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2023 at 01:46:02PM +0300, Andy Shevchenko wrote:

> +	rt5677->type =3D (enum rt5677_type)(uintptr_t)device_get_match_data(dev=
);

Double casts, always a sign of a successful simplification! :P

> +	if (rt5677->type =3D=3D 0)
>  		return -EINVAL;
> -	}
> =20
>  	rt5677_read_device_properties(rt5677, &i2c->dev);
> =20
> @@ -5702,7 +5689,7 @@ static struct i2c_driver rt5677_i2c_driver =3D {
>  	.driver =3D {
>  		.name =3D RT5677_DRV_NAME,
>  		.of_match_table =3D rt5677_of_match,
> -		.acpi_match_table =3D ACPI_PTR(rt5677_acpi_match),
> +		.acpi_match_table =3D rt5677_acpi_match,
>  	},
>  	.probe    =3D rt5677_i2c_probe,
>  	.remove   =3D rt5677_i2c_remove,
> diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
> index 944ae02aafc2..5ccdf1ba613a 100644
> --- a/sound/soc/codecs/rt5677.h
> +++ b/sound/soc/codecs/rt5677.h
> @@ -1753,8 +1753,8 @@ enum {
>  };
> =20
>  enum rt5677_type {
> -	RT5677,
> -	RT5676,
> +	RT5677 =3D 1,
> +	RT5676 =3D 2,
>  };
> =20
>  /* ASRC clock source selection */
> --=20
> 2.40.0.1.gaa8946217a0b
>=20

--ITgdYOOT/qXXKL5O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSdY0kACgkQJNaLcl1U
h9A/uwf/XhlnE0dgB/Bcb7Wz8z1De7mVWcI1CYqnZpqIlzClWb7v/zejlqV83AQJ
kJvRuZ0v016zardfxoiBl9yLKoFRhRHd36/8w9BsHtMDxFO5lKlAPaj6kDtnlt2h
WDD0YOnOtl2GAA+TcknCFOPtGBa19X3+FrQ9LJXh2V+ljPPNH4CMa/0HI8ZSXkMB
hY+JR7C5OIeYQG895C6y+hNZiB6KIRSFs8uCfSHFnZ6A7pYV8Ez1AAh2IXL+mzoJ
bguR/J/XzNErNC1cKPfgXnZOBlVuGqZfhPnFlCskIyK/s0XpQDcUZQ1ZC2USBic8
5tYH/ZACgsiRnIoe31ig8bJRVVblTQ==
=E4y7
-----END PGP SIGNATURE-----

--ITgdYOOT/qXXKL5O--
