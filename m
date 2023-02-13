Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9608695228
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 21:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBMUtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 15:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBMUtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 15:49:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0561F48B;
        Mon, 13 Feb 2023 12:49:19 -0800 (PST)
Received: from mercury (unknown [185.209.196.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 144686600358;
        Mon, 13 Feb 2023 20:49:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676321358;
        bh=QYKgYvZ6GSaXguqvtxOuiycRRutWeDESTgJ7qui7vIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ihl7zrRyudPiEu0PUyVKqqjUCvCwizFCRh4NJcGhmgklj+bnslWgNHcpYdh9jzlHS
         hehgG9L6bWBOrSgYkmbQFwSsufTPQeRaY4b8wVLM5UZFib8/Ecfpp0UnYIAid9wdYK
         q3/ISyBIXGZ7X+SIK7Lm9TfNUwlizl4IL5rcWxXdEIOW+TVbim0s9qswMFHdTwhDzF
         LzMBRL84vHTYWRwIaj+rHQPWNn+H7FvW5knPnXkbwoh2srfnn85YjvFud/OAGoW0Fs
         f40SB33aIbf80mb1B7B9wdyQ/0XOALC6180wNOsudIZsidFrdSPtatx9M8T7ILq2OB
         L/6/CINjvF/sw==
Received: by mercury (Postfix, from userid 1000)
        id 8C1521060961; Mon, 13 Feb 2023 21:49:15 +0100 (CET)
Date:   Mon, 13 Feb 2023 21:49:15 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, linux-acpi@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Kees Cook <keescook@chromium.org>,
        "Lee, Chun-Yi" <joeyli.kernel@gmail.com>,
        Chuansheng Liu <chuansheng.liu@intel.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: Hunt zero trip points thermal zones usage
Message-ID: <20230213204915.an3khdiczinttp2d@mercury.elektranox.org>
References: <20230203175832.3406504-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="62vjb7bftclszqw3"
Content-Disposition: inline
In-Reply-To: <20230203175832.3406504-1-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--62vjb7bftclszqw3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 03, 2023 at 06:58:31PM +0100, Daniel Lezcano wrote:
> Some drivers are declaring a thermal zone without any thermal trip
> points.
>=20
> On the other side, we are introducing the function
> thermal_zone_device_register_with_trips() which provides an array of
> generic thermal trip points. When all the drivers will be converted to
> the generic trip points, keeping two functions will be useless.
>=20
> Most of the drivers are now using
> thermal_zone_device_register_with_trips() with the generic trip
> points. As soon as the remaining drivers are merged, the
> thermal_zone_device_register_with_trips() will be renamed to
> thermal_zone_device_register().
>=20
> Obviously this renaming can only happen if there are no more user of
> the thermal_zone_device_register() function.
>=20
> This change uses thermal_zone_device_register_with_trips() with a NULL
> parameter for the trip point array instead of
> thermal_zone_device_register().
>=20
> No functional change intended.
>=20
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/power/supply/power_supply_core.c                | 2 +-

Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

[...]

> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/sup=
ply/power_supply_core.c
> index 7c790c41e2fe..208a849a71d9 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1166,7 +1166,7 @@ static int psy_register_thermal(struct power_supply=
 *psy)
> =20
>  	/* Register battery zone device psy reports temperature */
>  	if (psy_has_property(psy->desc, POWER_SUPPLY_PROP_TEMP)) {
> -		psy->tzd =3D thermal_zone_device_register(psy->desc->name,
> +		psy->tzd =3D thermal_zone_device_register_with_trips(psy->desc->name, =
NULL,
>  				0, 0, psy, &psy_tzd_ops, NULL, 0, 0);
>  		if (IS_ERR(psy->tzd))
>  			return PTR_ERR(psy->tzd);

[...]

-- Sebastian

--62vjb7bftclszqw3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmPqoksACgkQ2O7X88g7
+pqTyQ/9EPWvCJEFUJQtyxA+lb41sYuyN98Q+ACy/eXcxsqkzm7uK9tNsg23oFD2
MP5vTzSOJ1oQHmmfEpKdso5utu7TysAdjF5b+3hr9INf3Xte+kaIpSkSbWli1Htw
4uNcuewkAH63LA0iuHpid5RLNCTP5eOIvdOmic66mK2nKHbcu6+PmzIS0yVuh8Y1
d9TsWrjNYLp9uYNuslAGbLh75ploXXfQNI1gSTbwTr4w/Esqq5B75caIEHOJjRuS
1LSv3rQecPJDqpkCNRvEVJ2kImWAFoyjKbBrzE81Fb/JRjjgtXDscfuLQUWrzWHb
Ywyps5wICAfHEn3nNMHbMUiS+nA3eIBY9QWTCREsy2QE/7NQ5qOzAOQSsfGQz85Z
BRVMaMYQZJZym5RTOD+SfmQClnAbG/vmgysCp/qeTVuPnALZNyM1/abD8cHYWJ+c
oXqlFv+fxbe5dqg/MBn54x2xWbbSi0UgF8vyDlHEx3nSdeQ5RjqXWlTSRjzWQHFD
0PIBLYERDkAuPb7Tox6TU5DAUUQzldBncOOPPcKljwam8Z0jBARMG9VCpYoCUb9P
+i2L/mRCicvmn98ZJX0OKyjHsiHRklXqyV9KKedE/yJTxNDly5UlF/up+UtzDcHp
umqHKLUNDOezlX7XnqYXb16shVlc+6scgMl+Cj5L0G68foOokEE=
=ZFcY
-----END PGP SIGNATURE-----

--62vjb7bftclszqw3--
