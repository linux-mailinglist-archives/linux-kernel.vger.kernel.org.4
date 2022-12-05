Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3486436B4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbiLEVVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiLEVVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:21:07 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6742224BE1;
        Mon,  5 Dec 2022 13:21:04 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2A3CB66015B4;
        Mon,  5 Dec 2022 21:21:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670275263;
        bh=yZ1n3g/TSJjCi84p9pjKVWPvGbn2hvORKezmMbo0dSg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LR5y41FJKwR6V4TCoOJBGsIjIdLh5jW5VlCZXgaXsWn+DYysi+8QzId+Cc7PyUVZf
         +ulkePN40TWCHVysoqlea5VLOpat/IUxuh4LWHt9FEoIAzH/Ph736/cLv3xGhvIFRL
         FZ8zSuzQucky9s2tLpAznxsDuTCmoT3chzFRlFQXt6lzeZKZ6Iy/RcOr12qG2c3HNi
         7vgH6NM7TC1+W5vx+0++M0oW14SHcLyCPDfdt+MNj5F0FyJuHLejy7ApXim9uzQtjq
         rTZuDfhQHDsNaLXttsmj/RAwu5dGBQbCX62yMNrVE0RUCkHuLBFENo9wFMQ6HLIEEb
         8zoRoZXzydbaA==
Received: by mercury (Postfix, from userid 1000)
        id 6C1611060F2F; Mon,  5 Dec 2022 22:21:00 +0100 (CET)
Date:   Mon, 5 Dec 2022 22:21:00 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Hermes Zhang <Hermes.Zhang@axis.com>
Cc:     kernel <kernel@axis.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] power: supply: bq256xx: Remove init ichg/vbat with max
 value
Message-ID: <20221205212100.mldqqlv3mp5z7gwg@mercury.elektranox.org>
References: <20221129090112.3451501-1-chenhuiz@axis.com>
 <20221129152715.4hwtobuv57hrndzu@mercury.elektranox.org>
 <60ca0aa6-508a-4350-f892-98d1368e3783@axis.com>
 <20221203010303.it5urfo2i7pj4n3n@mercury.elektranox.org>
 <cf37715e-8bff-b38c-cee9-fdcc3b1d3a6b@axis.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="icjjtdliya2ciysi"
Content-Disposition: inline
In-Reply-To: <cf37715e-8bff-b38c-cee9-fdcc3b1d3a6b@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--icjjtdliya2ciysi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 05, 2022 at 03:23:53AM +0000, Hermes Zhang wrote:
> Init the ichg and vbat reg with max value is not good. First the chip
> already has a default value for ichg and vbat (small value). Init these
> two reg with max value will result an unsafe case (e.g. battery is over
> charging in a hot environment) if no user space change them later.
>=20
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com><mailto:chenhuiz@axis.com>
> ---
>=20
>=20
> It's the driver's task to setup safe initial maximum values.
> Pre-kernel values may or may not be safe if you consider things
> like kexec. If you get unsafe values programmed, then fix the
> values instead.
>=20
> -- Sebastian
>=20
>=20
>=20
> The constant_charge_current_max_ua is either from dts or default value
> for each chip in the code, but I guess I could ot change them because it
> has their own meaning (it will be used to check if the setting is valid
> or not). Do you mean I can set some other value here instead of
> constant_xxx_max?
>=20
>=20
>=20
> You can just change the DT value to something safe as it is meant to be?
>=20
>=20
> Hi,

Please use proper quoting.

> I tried it but it doesn't work. As the property in dts (constant_charge_c=
urrent_max_microamp
> and constant_charge_voltage_max_microvolt) means the max current and volt=
age in CC phase, if
> I change them to a safe(small) value, we could not apply any vlaue bigger=
 than them in the
> furture:

Right, because the bigger values are not safe.

> in
> bq256xx_set_ichg_curr()
>=20
> ichg =3D clamp(ichg, BQ256XX_ICHG_MIN_uA, ichg_max);
>=20
> So the DT value are not match/sutiable for what we want to set here. Eith=
er we introduce two
> new DT property (for init purpose) to set here or we just remove the sett=
ing here as the chip
> already has the default values.

There are no chip defaults if you use kexec.

I'm trying to read between the lines. My understanding is, that you
have some kind of userspace based solution to monitor the charging
process and reduce the current if it gets dangerous. This process
should use higher charge currents then what is considered safe; when
it's not running charging should not go above the safe threshold.

This effectively means, that you want to take over the decision what
is considered safe to userspace. So I suggest adding a module parameter
to disable the safety clamp like this:

static unsigned bool no_safety =3D false;
module_param(no_safety, bool, 0644);
MODULE_PARM_DESC(no_safety, "allow charge currents/voltages considered unsa=
fe by the kernel [default: disallowed]");

=2E..

int ichg_max =3D bq->init_data.ichg_max;
if (no_safety)
    ichg_max =3D bq->init_data.ichg_chip_max;

-- Sebastian

--icjjtdliya2ciysi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmOOYLgACgkQ2O7X88g7
+pqcLhAAp68cKmwqkijxcISHP0G69lgr9wDaxmI8FQxiWiREZSHipD7wYP0ViNy1
nyOsaOakKIkSDbxwyzutJHvv5+kmZAghwRcrPaI04FXuSTJPf1jnGirCcRFi366h
WNyrzUdk+i7TkG0OMDMK8phvkKp5HGrAS7CuL97pB78lmTc0DPGHJ8AsGpb9sUK2
tLGCrhacg4BSzaR2nwSIbHSvqkHxfPsbOTolze+zgz3/PmYJhXqqnjCsem9UhcKk
An3+fWUORKbTEmT+m7eH/P9HZtQ9x+Y1vepgNhEIh9x9/XGqgbdtDRxheSkHdazI
CV1e2dOPLEoRg2hNmYPd2fU3lW0wjcyjaOkKp6FIHTij3FvsHkNZqKdYygXVapV+
Yqz+HUp3a201vdbBmzDxTMSjdl2eWpJm0cFoNtm+sITVgJ4rOGc6xvS2cgE+uMqz
pqSSMRqGI6bdWYqa+aNOOXhDjp5wRhbBiHwwbUEtI6FnfYqmz6xMqNprWurE/DC1
Q2ZlOI/SjZZaAQbNVfUYJRsA5ClMPcxDdPlhOrnKr/p0GkMKjiHVPF/NxOFOPQ6u
Z1jcNGTvTTCt2cM3xWanplaKjm8v7KHbGAaYyojY+hi6QmqQ48kNlILorgiBKAEs
bx7X0DLAv2p0s1nbv6FJps+OKFbLGqVZ+quXPppDuakC9OUphDM=
=2hXN
-----END PGP SIGNATURE-----

--icjjtdliya2ciysi--
