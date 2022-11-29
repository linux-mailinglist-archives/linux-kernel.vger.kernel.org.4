Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4847163C3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbiK2P10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiK2P1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:27:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D94E2EF1E;
        Tue, 29 Nov 2022 07:27:19 -0800 (PST)
Received: from mercury (dyndsl-091-096-035-212.ewe-ip-backbone.de [91.96.35.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B95D566017D3;
        Tue, 29 Nov 2022 15:27:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669735637;
        bh=2uWz2A7xOoum4HnLr287oebganaus9nvik9/vnxaEhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YcOv7KjDCf2hv8Ylk0oMiT6YFxn8vAOAwb3tP/TznAzcB4hNpZRmZ6pFxwW3gq25Y
         zuXASNgJQAjvk1B1qZsV2R+ySlEhthBy3jLqSrYE5BFAbsqcjijhUv4sQ42Yk7Smqh
         GKMhhvrVBmdsTX8DFHe1f587dRog3jQIc0MuHVlACdNsdjDkS18ak16EqycpD/DVOX
         6rbX2LzcHq3KHbT3OHCFKtEUC/Qj+ZlfwHWRTbxMwxM2bgvOfH2oAyASH9O9GSKGeR
         Q53Z6Rdh02ej78ArkKkUDvadQMPkgJ8Kti4aJj09N8qs30rQMsD6p/z+LE62RbRDX3
         +vD4vdXESDGYQ==
Received: by mercury (Postfix, from userid 1000)
        id 3E5311060AB4; Tue, 29 Nov 2022 16:27:15 +0100 (CET)
Date:   Tue, 29 Nov 2022 16:27:15 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hermes Zhang <chenhuiz@axis.com>
Cc:     kernel@axis.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: bq256xx: Remove init ichg/vbat with max
 value
Message-ID: <20221129152715.4hwtobuv57hrndzu@mercury.elektranox.org>
References: <20221129090112.3451501-1-chenhuiz@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nhxzr54p4jecfeyb"
Content-Disposition: inline
In-Reply-To: <20221129090112.3451501-1-chenhuiz@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nhxzr54p4jecfeyb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 29, 2022 at 05:01:12PM +0800, Hermes Zhang wrote:
> Init the ichg and vbat reg with max value is not good. First the chip
> already has a default value for ichg and vbat (small value). Init these
> two reg with max value will result an unsafe case (e.g. battery is over
> charging in a hot environment) if no user space change them later.
>=20
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---

It's the driver's task to setup safe initial maximum values.
Pre-kernel values may or may not be safe if you consider things
like kexec. If you get unsafe values programmed, then fix the
values instead.

-- Sebastian

>  drivers/power/supply/bq256xx_charger.c | 10 ----------
>  1 file changed, 10 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq256xx_charger.c b/drivers/power/suppl=
y/bq256xx_charger.c
> index 01ad84fd147c..d1aa92c10c22 100644
> --- a/drivers/power/supply/bq256xx_charger.c
> +++ b/drivers/power/supply/bq256xx_charger.c
> @@ -1562,21 +1562,11 @@ static int bq256xx_hw_init(struct bq256xx_device =
*bq)
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D bq->chip_info->bq256xx_set_ichg(bq,
> -				bat_info->constant_charge_current_max_ua);
> -	if (ret)
> -		return ret;
> -
>  	ret =3D bq->chip_info->bq256xx_set_iprechg(bq,
>  				bat_info->precharge_current_ua);
>  	if (ret)
>  		return ret;
> =20
> -	ret =3D bq->chip_info->bq256xx_set_vbatreg(bq,
> -				bat_info->constant_charge_voltage_max_uv);
> -	if (ret)
> -		return ret;
> -
>  	ret =3D bq->chip_info->bq256xx_set_iterm(bq,
>  				bat_info->charge_term_current_ua);
>  	if (ret)
> --=20
> 2.30.2
>=20

--nhxzr54p4jecfeyb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOGJMoACgkQ2O7X88g7
+pr2/A/+ObAJI1Ihz0lz5Yr5sQVpHXiTtTj+QNVgp7YKWEEFZ3ReQBEL7LPr7ih6
b15AxbN7PPnELw6tjGOyPA2By87w4ZXScIFR8hiO0wntZI2hbamza+revN+CIvN8
8qw1t2GhSuGksus+zyHtvWw3Loq60kn3a8IID0LnihdLupZTJuYjD+TzVo0RtZrb
3N/dPB4nD2XatCNlXkVSA1IFVxMlPy2/i+5SbYXaTbpm5zpETkyYPfa+ywU7EStr
Ac/eZly+9kIa3q5D3IkZ9ho0EF7FZ7ivPjwbtbszM/6yiHp2KY/qhtJDyfRCCmc8
f3c6kT/97xQ6vJHSkXpgU13Bs/zud9PXV+QqA0uQUh2eLTquSrYTn2HeV4TV3+/5
utF4ZNISx6zIQ9S6HafCRlv7gA1XspQy0kEcXPAfifawWBHIkW5tAehv4XQ/PTeE
jmv9m8r+VFoZhH4upDtT0TLYo3G3eYV75gBgu1RK8OX+I6lzk4E0T6ocaHMJ0ALE
X6KfKfpIgCW53ZT2XtkErfAYVBFqkOaUIUlO3cXdbutjuzt82MtyJ5YmEZmodLHQ
CV+rP/V7pzO7MXs6yDrLm1X0LFK6+PVwsu0bqg+GqpFs3aAgroepKGsOUMGpJjVn
7oXFsBOS4L79tevd51jfT6f0J0+TDLVoutCUsukuoxwGfXMT/fo=
=TDmG
-----END PGP SIGNATURE-----

--nhxzr54p4jecfeyb--
