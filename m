Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62AA68DABB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbjBGO1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:27:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjBGO11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:27:27 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2CC100;
        Tue,  7 Feb 2023 06:27:16 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id fi26so15718537edb.7;
        Tue, 07 Feb 2023 06:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBRHP2blfiHENKjmc+PrTJSqB5MI5ZF43uJQtwGkgGk=;
        b=eU0aDLQbHTp+uMSHQam8dtNTSu7JOI+sOFZ612xnuznR7VzXHanEwC2xx7gK+U9/j0
         TqamPxJwTvwzze98jjdQho+fZ24BW9MVnuGKlSSZ5pFPZ8XUYvjH3QMHBaoNRqU5P9dp
         NWJT5qVEt74mST7sx6DmjUNnrXttOCBTNU8TczuoyPe4eP6X1g0FQPW0F0DEeTWPgDI5
         6J3zRkstmkNcVICtGCmecCp6wx5l7hdt/jp1CmyEKMzfXrrUPJBEOXoJM8AeZyb3dax2
         AY21f0bFWpyuctcwRwHdNEvWD6JNTruewr2ALbuyI9lOCyxeJPGZ31Yvw4iGSFdOUTaj
         YDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBRHP2blfiHENKjmc+PrTJSqB5MI5ZF43uJQtwGkgGk=;
        b=dXI7Jt+OgnUxGpfjYp8AxlFXwRgbmZ5+SaRjT7lO69HgwPewPOLliTgvAFVuHP4cLc
         bUms/DG4vUA2vcoW148mhhI1xbZXcw5z/+Ujw7KzTEFzJ8w4plZy8aVqif+1iqJJUzgj
         zmti3XLxHvp6BTrZDoz3J77EOPZVcqpcB7f9v+IVdObWHYANrg31/eYU+8FQH1JehoEL
         05LZRtUNvgSinaYhZK8y/A2aJila5ixfabFb5gFVld1h1OIg4K/svbXJOIvtZrNJoFPO
         oMKtg+meVUiDNjPkHhn8B4YXv3ORCnJC0YyCMD3zJ+Wh8cLq2yNv2M0OtL+yuoUWUSRF
         9QWA==
X-Gm-Message-State: AO0yUKWFn1K5Q/7Yx82LNcoH94luXMWduG9IJ2t3LKXaihCO7sygMcq1
        6rLQbqxp15U0BDOU0TTjB2U=
X-Google-Smtp-Source: AK7set+yjAHvGKgcPIxYvym9lmdfUOHlK1q4YJDTdD+9LqZ0TmLQOqyph4KQ44lBFKlhut9SA3dFKw==
X-Received: by 2002:a50:d08c:0:b0:4aa:a36a:3e44 with SMTP id v12-20020a50d08c000000b004aaa36a3e44mr4083978edd.33.1675780034717;
        Tue, 07 Feb 2023 06:27:14 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h40-20020a0564020ea800b004a245d70f17sm6456953eda.54.2023.02.07.06.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 06:27:14 -0800 (PST)
Date:   Tue, 7 Feb 2023 15:27:12 +0100
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
Message-ID: <Y+JfwM0O/0ZjMHua@orome>
References: <fa2bd92a-f2ae-a671-b537-87c0f3c03dbd@linaro.org>
 <Y9J4WAFyXyV/nqlG@orome>
 <f626967e-d6e6-817f-abeb-4aed89856c66@linaro.org>
 <Y+JBk5g65WkOkke7@orome>
 <e6b4c6a9-0e35-e3b2-c8e8-01e5326bdba1@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i6ywgwGD4Rn3HiX5"
Content-Disposition: inline
In-Reply-To: <e6b4c6a9-0e35-e3b2-c8e8-01e5326bdba1@linaro.org>
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


--i6ywgwGD4Rn3HiX5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2023 at 01:38:08PM +0100, Daniel Lezcano wrote:
> On 07/02/2023 13:18, Thierry Reding wrote:
> > On Mon, Feb 06, 2023 at 03:50:22PM +0100, Daniel Lezcano wrote:
> > >=20
> > > Hi Thierry,
> > >=20
> > > did you have the time to look at the get_thermal_instance() removal ?
> > >=20
> > >=20
> > > On 26/01/2023 13:55, Thierry Reding wrote:
> > >=20
> > > > 	[   12.354091] tegra_soctherm 700e2000.thermal-sensor: missing the=
rmtrips, will use critical trips as shut down temp
> > > > 	[   12.379009] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when cpu reaches 102500 mC
> > > > 	[   12.388882] tegra_soctherm 700e2000.thermal-sensor: programming=
 throttle for cpu to 102500
> > > > 	[   12.401007] tegra_soctherm 700e2000.thermal-sensor: throttrip: =
will throttle when cpu reaches 102500 mC
> > > > 	[   12.471041] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when gpu reaches 103000 mC
> > > > 	[   12.482852] tegra_soctherm 700e2000.thermal-sensor: programming=
 throttle for gpu to 103000
> > > > 	[   12.482860] tegra_soctherm 700e2000.thermal-sensor: throttrip: =
will throttle when gpu reaches 103000 mC
> > > > 	[   12.485357] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when pll reaches 103000 mC
> > > > 	[   12.501774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when mem reaches 103000 mC
> > > >=20
> > > > and after these changes, it turns into:
> > > >=20
> > > > 	[   12.447113] tegra_soctherm 700e2000.thermal-sensor: missing the=
rmtrips, will use critical trips as shut down temp
> > > > 	[   12.472300] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when cpu reaches 102500 mC
> > > > 	[   12.481789] tegra_soctherm 700e2000.thermal-sensor: programming=
 throttle for cpu to 102500
> > > > 	[   12.495447] tegra_soctherm 700e2000.thermal-sensor: throttrip: =
will throttle when cpu reaches 102500 mC
> > > > 	[   12.496514] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when gpu reaches 103000 mC
> > > > 	[   12.510353] tegra_soctherm 700e2000.thermal-sensor: programming=
 throttle for gpu to 103000
> > > > 	[   12.526856] tegra_soctherm 700e2000.thermal-sensor: throttrip: =
will throttle when gpu reaches 103000 mC
> > > > 	[   12.528774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when pll reaches 103000 mC
> > > > 	[   12.569352] tegra_soctherm 700e2000.thermal-sensor: programming=
 throttle for pll to 103000
> > > > 	[   12.577635] tegra_soctherm 700e2000.thermal-sensor: throttrip: =
will throttle when pll reaches 103000 mC
> > > > 	[   12.590952] tegra_soctherm 700e2000.thermal-sensor: thermtrip: =
will shut down when mem reaches 103000 mC
> > > > 	[   12.600783] tegra_soctherm 700e2000.thermal-sensor: programming=
 throttle for mem to 103000
> > > > 	[   12.609204] tegra_soctherm 700e2000.thermal-sensor: throttrip: =
will throttle when mem reaches 103000 mC
> > > >=20
> > > > The "programming throttle ..." messages are something I've added lo=
cally
> > > > to trace what gets called. So it looks like for "pll" and "mem" the=
rmal
> > > > zones, we now program trip points whereas we previously didn't.
> >=20
> > My diagnosis above wasn't entirely correct. We're not actually skipping
> > trip point programming for PLL and MEM thermal zones in the current
> > code. Instead, we skip throttle programming. As far as I can tell this
> > is a mechanism built into ACTMON to allow it to automatically throttle
> > when a zone reaches a certain temperature.
> >=20
> > This is modelled as a cooling device, but internally it's actually done
> > automatically, which is why we have this code that programs the throttle
> > at driver probe time, rather than the on-demand programming that typical
> > cooling device would do (such as a fan).
> >=20
> > The reason why we have get_thermal_instance() here is to check if this
> > built-in cooling device has been configured for the "hot" trip point. If
> > not, we don't want the throttle programming to happen. This adds the
> > added flexibility of explicitly disabling the automatic throttling by
> > ACTMON and using another cooling device (or none at all) if that's what
> > is needed.
> >=20
> > Dropping just the call to get_thermal_instance() and relying on the
> > find_throttle_cfg_by_name() function will always return a valid throttle
> > configuration. This is slightly obfuscated because of this:
> >=20
> > 	cdev =3D ts->throt_cfgs[i].cdev;
> > 	if (get_thermal_instance(tz, cdev, trip_id))
> > 		stc =3D find_throttle_cfg_by_name(ts, cdev->type);
> >=20
> > As far as I can tell this will always return &ts->throt_cfgs[i], so the
> > find_throttle_cfg_by_name() call is a bit redundant here. I'll look into
> > fixing that.
> >=20
> > In any case, the important thing is that it would always find a valid
> > throttle configuration and therefore program the throttle, even if we
> > may not want to.
>=20
> Why not rely on the thermal framework mechanism to set the hwtrpis ?
>=20
> thermal_zone_device_register() calls thermal_zone_device_update(). This o=
ne
> calls thermal_zone_set_trips() which programs the hardware trip point.
>=20
> When we suspend/resume, the PM notifiers are calling
> thermal_zone_device_update() which in turn sets the hw trip points.
>=20
> May be I'm missing something but isn't enough for the sensor ?

These aren't actually trip points getting programmed, but rather the
built-in throttling mechanism. That said, it might be possible to append
that programming to the driver's ->set_trips() implementation. I'll look
into that.

Thanks for the suggestion,
Thierry

>=20
>=20
> > Possibly we could work around that by removing this fiddly special case
> > and instead add a new callback for the cooling devices that can be run
> > when they are bound to a thermal zone. This would allow the throttle
> > programming to be initiated from within the thermal core rather than
> > "bolted on" like it is now and should allow us to achieve the same
> > effect but without calling into get_thermal_instance().
> >=20
> > I'll try and prototype this, but feel free to suggest anything better if
> > you can think of something.
> >=20
> > Thierry
>=20
> --=20
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20

--i6ywgwGD4Rn3HiX5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPiX74ACgkQ3SOs138+
s6HEWA//WcQHDIQETKEa68UNcmc/K55NekQe5Kpt3cmujr23UavoOLbRiE5axiGs
XkrZViQ28OpcMsqpFOsEvX9VoXPzUYUd2RykUesK+XHIwAoB0XDVD3pgcybdHnCL
uoFniNGrPej6itOw/Ho2FGq8gBycBSPfS4mE9pJUv/sjB91dUfWPnXHhBotqvr1X
Bn/BDmkWZWOWqZe/ENBouBQuSVOXALjoBgCL2qovW9i0i6xdDgv7ew58xPyAaJUV
9UcA3nSucI1cGkFGH2JQH3RHRKub5TtGICeAU8cUp+dcjQiCDFvsrEeImlvXCd49
GJRJhZMDnSuqUt2bmRm0O+1aqnSBGiMQ++YX2kY99Hj5G96rJpdx6JOLfqdYWOvZ
KPjltOnEzwGtqoTymZltZ09wgYIjmQh9rjik7jbVlJLRfo1VUH6Y3abefGCtz8a0
4mTG7GGHz33KYtGA3t35GZz0ld2eRwMs6xxcKQpZeTx8bquX0xx8vkeUmvAyfE4X
KwP+wCSx34znioSUie3AYqmabI5HDkUEll2lpVM9O0nLYU6lB/pI5xj77e5IrKGY
ChIlqdIHHM/1hmMn5E7f4PPxL56H15M5Ld0Mq5ho3Zevo86JAZIbNpex9uV0eXcN
sPzX3JVxQA9JEZ6fW6hn737HiKTlFu8wSluy+PoJcrdQx+pFf4g=
=MwRz
-----END PGP SIGNATURE-----

--i6ywgwGD4Rn3HiX5--
