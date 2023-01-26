Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8EF67CB68
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 13:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbjAZM41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 07:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbjAZM4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 07:56:23 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD516952B;
        Thu, 26 Jan 2023 04:55:56 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id v6so4787930ejg.6;
        Thu, 26 Jan 2023 04:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOHjVOgAZUX0rRLXe2h9UYJji2SuNMNcGeYAyIod1qY=;
        b=L1uyLtyXQoje6+jhddxHqy6spvTqXhZmDlWGR1FGBeqikj/BElV5p5oMAF+0nXzFqg
         YJ6EU0bx4h/H3ACfThwfp+KfoaI3NBfrvOi3+qnkJTnYBVCdIfDPTJmZSTHNfpsH+Bpl
         YUIY9HhRzgyL7H1V6ZMp/Grx3R8mUbMZC+L+sImzx3XkjwYX9VG46L+1i5MroXv+K/O5
         1wFYU5aLv1eQwwlaEQYuHS8ZFShAiO9gYS7jhO7qhkTi0d7AVOnUY52r00LwhnVh3NBb
         0ayj7qJ8z6gH12TvYbh5tmPoaC8141wYBkmCBLlVGVs+RszAr1sjONlkROn9BRa6p505
         jG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOHjVOgAZUX0rRLXe2h9UYJji2SuNMNcGeYAyIod1qY=;
        b=onI9TCX3JID0a9HOGIasV0uNqUeUtQNgcqu2Oh1/rNGJJb0DuQ6KT/HCqfinQ94GUd
         jruLTlTsKcwuJpUPTmqOefnmbozFX3SKdbGOm3v2Kwhom0JAbJOc4aSNKlQkezFvQa/v
         6Uu8fDE3aLinmcSLtmg4WJZxiBLhf84sla4Jf3fIvDNO0LSu0Kc0UIEVh6U7i6peZIL0
         oKgasqINqmzF3apy5pfesXndicJzCA/k9E47VMRoV4XYF6+KfdDEXDSD/od7tknpLDBc
         n3BvxEemOY0Pn+XGJJjSDamyraA1BLw5SRStdMMM5PbhFFuXrtekLkwpuZRc+TqeaiFJ
         WzXw==
X-Gm-Message-State: AFqh2kpaLknwaXzlXn3/vD6mpYNM3eBnSQIkpI6fqhLx/9n+V/8qaSvz
        dsqjVajRdsXhRkmEMptKrlHHzRZ2PPY=
X-Google-Smtp-Source: AMrXdXv1qtoWxCvb7UPySKi4Cz07AO2uqjYmCsCuDFvI7KPz5yoPXz54F+eB4UAqkcbPLT+k2eEcwg==
X-Received: by 2002:a17:907:674c:b0:7c4:fe36:5b80 with SMTP id qm12-20020a170907674c00b007c4fe365b80mr39044656ejc.62.1674737754680;
        Thu, 26 Jan 2023 04:55:54 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id cm20-20020a170907939400b00871cb1b8f63sm564099ejc.26.2023.01.26.04.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 04:55:54 -0800 (PST)
Date:   Thu, 26 Jan 2023 13:55:52 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Wei Ni <wni@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Johan Hovold <johan@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Subject: Re: thermal/drivers/tegra: Getting rid of the get_thermal_instance()
 usage
Message-ID: <Y9J4WAFyXyV/nqlG@orome>
References: <fa2bd92a-f2ae-a671-b537-87c0f3c03dbd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A9WxDdyRC/ykeBGC"
Content-Disposition: inline
In-Reply-To: <fa2bd92a-f2ae-a671-b537-87c0f3c03dbd@linaro.org>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--A9WxDdyRC/ykeBGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2023 at 08:57:23PM +0100, Daniel Lezcano wrote:
>=20
> Hi,
>=20
> does anyone know what is the purpose of the get_thermal_instance() usage =
in
> this code:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tree/dr=
ivers/thermal/tegra/soctherm.c?h=3Dthermal/linux-next#n623
>=20
> The driver is using a function which is reserved for the thermal core. It
> should not.
>=20
> Is the following change ok ?
>=20
> diff --git a/drivers/thermal/tegra/soctherm.c
> b/drivers/thermal/tegra/soctherm.c
> index 220873298d77..5f552402d987 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -620,9 +620,8 @@ static int tegra_thermctl_set_trip_temp(struct
> thermal_zone_device *tz, int trip
>  				continue;
>=20
>  			cdev =3D ts->throt_cfgs[i].cdev;
> -			if (get_thermal_instance(tz, cdev, trip_id))
> -				stc =3D find_throttle_cfg_by_name(ts, cdev->type);
> -			else
> +			stc =3D find_throttle_cfg_by_name(ts, cdev->type);
> +			if (!stc)
>  				continue;
>=20
>  			return throttrip_program(dev, sg, stc, temp);
> @@ -768,9 +767,9 @@ static int tegra_soctherm_set_hwtrips(struct device
> *dev,
>  			continue;
>=20
>  		cdev =3D ts->throt_cfgs[i].cdev;
> -		if (get_thermal_instance(tz, cdev, trip))
> -			stc =3D find_throttle_cfg_by_name(ts, cdev->type);
> -		else
> +
> +		stc =3D find_throttle_cfg_by_name(ts, cdev->type);
> +		if (!stc)
>  			continue;
>=20
>  		ret =3D throttrip_program(dev, sg, stc, temperature);

There's a small difference in behavior after applying this patch. Prior
to this I get (on Tegra210):

	[   12.354091] tegra_soctherm 700e2000.thermal-sensor: missing thermtrips,=
 will use critical trips as shut down temp
	[   12.379009] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shu=
t down when cpu reaches 102500 mC
	[   12.388882] tegra_soctherm 700e2000.thermal-sensor: programming throttl=
e for cpu to 102500
	[   12.401007] tegra_soctherm 700e2000.thermal-sensor: throttrip: will thr=
ottle when cpu reaches 102500 mC
	[   12.471041] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shu=
t down when gpu reaches 103000 mC
	[   12.482852] tegra_soctherm 700e2000.thermal-sensor: programming throttl=
e for gpu to 103000
	[   12.482860] tegra_soctherm 700e2000.thermal-sensor: throttrip: will thr=
ottle when gpu reaches 103000 mC
	[   12.485357] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shu=
t down when pll reaches 103000 mC
	[   12.501774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shu=
t down when mem reaches 103000 mC

and after these changes, it turns into:

	[   12.447113] tegra_soctherm 700e2000.thermal-sensor: missing thermtrips,=
 will use critical trips as shut down temp
	[   12.472300] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shu=
t down when cpu reaches 102500 mC
	[   12.481789] tegra_soctherm 700e2000.thermal-sensor: programming throttl=
e for cpu to 102500
	[   12.495447] tegra_soctherm 700e2000.thermal-sensor: throttrip: will thr=
ottle when cpu reaches 102500 mC
	[   12.496514] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shu=
t down when gpu reaches 103000 mC
	[   12.510353] tegra_soctherm 700e2000.thermal-sensor: programming throttl=
e for gpu to 103000
	[   12.526856] tegra_soctherm 700e2000.thermal-sensor: throttrip: will thr=
ottle when gpu reaches 103000 mC
	[   12.528774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shu=
t down when pll reaches 103000 mC
	[   12.569352] tegra_soctherm 700e2000.thermal-sensor: programming throttl=
e for pll to 103000
	[   12.577635] tegra_soctherm 700e2000.thermal-sensor: throttrip: will thr=
ottle when pll reaches 103000 mC
	[   12.590952] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will shu=
t down when mem reaches 103000 mC
	[   12.600783] tegra_soctherm 700e2000.thermal-sensor: programming throttl=
e for mem to 103000
	[   12.609204] tegra_soctherm 700e2000.thermal-sensor: throttrip: will thr=
ottle when mem reaches 103000 mC

The "programming throttle ..." messages are something I've added locally
to trace what gets called. So it looks like for "pll" and "mem" thermal
zones, we now program trip points whereas we previously didn't.

I'll take a closer look to see if we can replace the calls to
get_thermal_instance() by something else.

Thierry

--A9WxDdyRC/ykeBGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPSeFUACgkQ3SOs138+
s6EqwxAAtLTapa6oayggK4aPNTYkNjnKTeqLxhazJHvW8NNNf3KjMBoOwFEkzv2Q
LQFmlqfSqfeTEBkVA6U1b8qQedI2xxOfww+i9KCv47FBF2jfKjFAjQBzrffZjulr
ixPfacly61f/a/8nvsrLcjamhQ5TlqIriMyYpnL5ASQXZ1Ao3VW2G7Sl+Hw6YpWc
+r+5OXLe+EGAhOT7k66djDDl9X9q33vB6opp+fF4SbM07KQv5nunSK5FOISG9vpy
gYZLn7bq2AMcwRf9G7+1tGIgA9ROjFO6zjSow/QOTngywuUa/yfYX0okFmn4HSgU
uEdpcSbyderE0ZlM51lv/Ro1P4I3eSbfK4WUUei0bWFD8/+sb01yut+sowZmrdB6
sH8QW0VhqnK2NdjKn9H4phaJOymo/EF9qwQ1WryqtukNeGDhiWjQZsZPzZIiR3AF
qpM+H+FIwrqoosovwsfeGoyZ2q+f3wmzc8DA/WEp74BUQJCmr5Zysq8mVjp8oA2q
waKStPprkRtL3f/gS/x+lQd7wVw30xcRvvFRPnr9gzKQIguXTT1HmNXFSWUlTNWP
B2pj1zsHUrKg1CKMJlxGzBjMPkfyS49Cn5ieKYHpc/LlV5FpwbC0TrQYgOobnN+J
tEzQitYy3nNMzoeWT5x37MfSWjKhI5jpfoYK84BlKuMgN1gGL5w=
=iYA1
-----END PGP SIGNATURE-----

--A9WxDdyRC/ykeBGC--
