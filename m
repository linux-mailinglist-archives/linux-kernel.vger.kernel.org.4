Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E8A6FB53C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjEHQhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234221AbjEHQhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:37:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266A9468A;
        Mon,  8 May 2023 09:37:32 -0700 (PDT)
Received: from mercury (195-23-45-170.net.novis.pt [195.23.45.170])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 456586603292;
        Mon,  8 May 2023 17:37:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683563850;
        bh=CCTMG9S48FOICrW7oByihp55ltBGahowZHQ6Dc+tADY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jP8nL1KBWJHRUeQz+kuxlya76aei1fHiyX0drCrNNchccAmscEEvDz18vzATyme7M
         MZKYZKrhh/yFPKbyBG7U6etGotyGPDiLE5z8dz2GxaLM1qSF4vnKD1AYpa+mfR3DD7
         s77Gu2S8XV1P+XXxKw1wILypD+rC5jEszPrmcN+Gpqnfc9me6Pe6TFFrz+QGTNY/h0
         WMtz3xwERgCVeyCJzERgkuTe449/+D+SWqTUjBwgZFqZTuSORn6KBcEWSboBub4CqK
         9Qi2rE+7fTwLXZVKcHXZxyVwXVVeNEm/R0i245KBk6nYbVSY96hh6ziVtH2oG5c8rj
         7gZzL33tljwcg==
Received: by mercury (Postfix, from userid 1000)
        id 199481066FBB; Mon,  8 May 2023 14:32:28 +0200 (CEST)
Date:   Mon, 8 May 2023 14:32:28 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daisuke Nojiri <dnojiri@chromium.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cros_pchg: Sync port status on resume
Message-ID: <20230508123228.pduxcrwylbq73iuj@mercury.elektranox.org>
References: <20230417221610.1507341-1-dnojiri@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="43uxwucv7neurdot"
Content-Disposition: inline
In-Reply-To: <20230417221610.1507341-1-dnojiri@chromium.org>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--43uxwucv7neurdot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 17, 2023 at 03:16:10PM -0700, Daisuke Nojiri wrote:
> When a stylus is removed (or attached) during suspend, the device detach
> (or attach) events can be lost. This patch makes the peripheral device
> charge driver retrieve the latest status from the EC on resume.
>=20
> BUG=3Db:276414488
> TEST=3DRedrix
>=20
> Signed-off-by: Daisuke Nojiri <dnojiri@chromium.org>
> ---

Thanks, queued.

-- Sebastian

>  .../power/supply/cros_peripheral_charger.c    | 25 ++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/power/supply/cros_peripheral_charger.c b/drivers/pow=
er/supply/cros_peripheral_charger.c
> index 1379afd9698d..a204f2355be4 100644
> --- a/drivers/power/supply/cros_peripheral_charger.c
> +++ b/drivers/power/supply/cros_peripheral_charger.c
> @@ -227,8 +227,7 @@ static int cros_pchg_get_prop(struct power_supply *ps=
y,
>  	return 0;
>  }
> =20
> -static int cros_pchg_event(const struct charger_data *charger,
> -			   unsigned long host_event)
> +static int cros_pchg_event(const struct charger_data *charger)
>  {
>  	int i;
> =20
> @@ -256,7 +255,7 @@ static int cros_ec_notify(struct notifier_block *nb,
>  	if (!(host_event & EC_MKBP_PCHG_DEVICE_EVENT))
>  		return NOTIFY_DONE;
> =20
> -	return cros_pchg_event(charger, host_event);
> +	return cros_pchg_event(charger);
>  }
> =20
>  static int cros_pchg_probe(struct platform_device *pdev)
> @@ -281,6 +280,8 @@ static int cros_pchg_probe(struct platform_device *pd=
ev)
>  	charger->ec_dev =3D ec_dev;
>  	charger->ec_device =3D ec_device;
> =20
> +	platform_set_drvdata(pdev, charger);
> +
>  	ret =3D cros_pchg_port_count(charger);
>  	if (ret <=3D 0) {
>  		/*
> @@ -349,9 +350,27 @@ static int cros_pchg_probe(struct platform_device *p=
dev)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_PM_SLEEP
> +static int __maybe_unused cros_pchg_resume(struct device *dev)
> +{
> +	struct charger_data *charger =3D dev_get_drvdata(dev);
> +
> +	/*
> +	 * Sync all ports on resume in case reports from EC are lost during
> +	 * the last suspend.
> +	 */
> +	cros_pchg_event(charger);
> +
> +	return 0;
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(cros_pchg_pm_ops, NULL, cros_pchg_resume);
> +
>  static struct platform_driver cros_pchg_driver =3D {
>  	.driver =3D {
>  		.name =3D DRV_NAME,
> +		.pm =3D &cros_pchg_pm_ops,
>  	},
>  	.probe =3D cros_pchg_probe
>  };
> --=20
> 2.39.2
>=20

--43uxwucv7neurdot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRY69sACgkQ2O7X88g7
+pqwdhAAgxvO7qCqrafIX/xYJZEzUpBTHCD3ngN2jisQNJo028wzvG1n627Jd6sF
OogUbiWtYSN3hC9tn9umQAHW564GtxQEsohXtMYsLtwn4nAXOMdxqmXmg2+s/mYX
GcNGs6xO8245Uq0gX3qMUmf9zkxyDHw7qsS8kNX9Qvjsft4tnGHWxAuy05TnOyDg
r3M2E2zMkZo4uHz5H4ehsmsXwRMj+FdvSgmXNxD3g/McrS4Dz0zu+SsVHdIGFqGo
UfqoloAFKnktMgunOCnnHwBdSMyFiKB/sw9qtV3Lit0QIEOsX5SqS4xUKRUWV/mw
cflemZHVotncwG3W6OVgjMFQwycjkcH9hsFwhybPyvh1VpENr1xacJuWFPHwpMTy
2iA9k3I62TahA5MnWq9YwPlUF3l9z5cze13xdfhwKx8UvXXIhtzkkth/3wilgCpL
DuMjMt1XXuQBjuVFeBNDxjbwu6KoCYbXiPnFXSgBKvo5BimMcdJoBEEww+4x6ctI
c5Ck345+PgukLFzbBx2jwNG9eWnX04c1+RbjNDDCKnL4Ovy4Bs3vcdVN4OiPhbcs
bt+sSw1RYB0yyyrBzhKz9Xz9o5nAs4qTUjcNMhOIr461ZqDx0ZHjXinbHnlfxXWX
+w9MMZKAgKWBCcM7faKVc4bqAjgdNAgp6I0tQoJwamS2O1/6Nwg=
=iRPE
-----END PGP SIGNATURE-----

--43uxwucv7neurdot--
