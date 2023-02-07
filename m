Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F88568D64D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 13:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjBGMSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 07:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjBGMSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 07:18:32 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28879227B6;
        Tue,  7 Feb 2023 04:18:31 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id qw12so42686007ejc.2;
        Tue, 07 Feb 2023 04:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bM0TS3X8+krGehFDGorBd3mgFCkr2GC6P8us++DABro=;
        b=O8+VUzfvJIgNFMHxWnYgZiAq5cf1PPdR+r0vJCeBdIaas/U2rPb8M2VDixTj1abSAd
         D+NFJnpQrPI6MXeHTKwzZPpoHCOUVw1cAr5oM8vO0n7BNmtORu0I8RAXDdNLTEhzF7pa
         XRkaUIZMklIsTsO4/eTa9nPCrO3Xk9PzqXjHyP1TrbUEsCKuc9ehJcnQ9sj9faBZT0oV
         UC8D+ipg5LBXxKLnZ77HI8Uj+q894bHJNk292YvWakUNwnCJA+QVqQdkXS6VwyLA9zKO
         K9l3V/dRzduZ4RWA+ZZ4+7fYi0UGbEbZfT/j1G7wGXkD54cW4G2n/Q+8yt9oEauDVdGm
         vvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bM0TS3X8+krGehFDGorBd3mgFCkr2GC6P8us++DABro=;
        b=ehZJzqIbp4ObxD99t8I0+Z/1rzznqtjpyochzNylM4gIuSgYNt14Ssj9ZmtpaUPnzO
         vxmAjsYT2v3w8Lzc5LFY6iSltjM99YJTHV/XAMF6LgA0dEmTGvngEuh6MQusTknRaoBW
         bzvKF5fKJIiRRAcyiHZKtk0ivrUIuyruUo+sV4o2p6pgzC4eL4S3xLjAQRUwlngpzSvC
         hZ2Nw5LBd/KaM2xvxaoOEjK2ebG9mlRgbaU/xVKumGuVKCPmRH2n0CPhDTemXEiPlM8Y
         t30usxA8l05A28LqEiGSI0J39x3xQ89JB3P4b7HuYzlfXPMz7sGBPz4v/zuw8va6htRP
         OlNw==
X-Gm-Message-State: AO0yUKWug7WSzn1hXCGaLBrLlfYpI6QXh+woDBlSS33CsOdYy6nIUeqA
        BaRC+OI4FAjdf+VEAPXlCPQ=
X-Google-Smtp-Source: AK7set9k6wuXq+8Svj0X1T5rkCOJLO7zi7Sm5iIuEnoMQavCiKXzvghwU0LyK6xr1gyPe/0nKe1PEA==
X-Received: by 2002:a17:906:3688:b0:885:8f79:d6d7 with SMTP id a8-20020a170906368800b008858f79d6d7mr3092213ejc.61.1675772309574;
        Tue, 07 Feb 2023 04:18:29 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id z25-20020a1709064e1900b0088550a1ce6esm6847546eju.222.2023.02.07.04.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 04:18:29 -0800 (PST)
Date:   Tue, 7 Feb 2023 13:18:27 +0100
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
Message-ID: <Y+JBk5g65WkOkke7@orome>
References: <fa2bd92a-f2ae-a671-b537-87c0f3c03dbd@linaro.org>
 <Y9J4WAFyXyV/nqlG@orome>
 <f626967e-d6e6-817f-abeb-4aed89856c66@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FbUzMna8IwvuWEei"
Content-Disposition: inline
In-Reply-To: <f626967e-d6e6-817f-abeb-4aed89856c66@linaro.org>
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


--FbUzMna8IwvuWEei
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2023 at 03:50:22PM +0100, Daniel Lezcano wrote:
>=20
> Hi Thierry,
>=20
> did you have the time to look at the get_thermal_instance() removal ?
>=20
>=20
> On 26/01/2023 13:55, Thierry Reding wrote:
>=20
> > 	[   12.354091] tegra_soctherm 700e2000.thermal-sensor: missing thermtr=
ips, will use critical trips as shut down temp
> > 	[   12.379009] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will=
 shut down when cpu reaches 102500 mC
> > 	[   12.388882] tegra_soctherm 700e2000.thermal-sensor: programming thr=
ottle for cpu to 102500
> > 	[   12.401007] tegra_soctherm 700e2000.thermal-sensor: throttrip: will=
 throttle when cpu reaches 102500 mC
> > 	[   12.471041] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will=
 shut down when gpu reaches 103000 mC
> > 	[   12.482852] tegra_soctherm 700e2000.thermal-sensor: programming thr=
ottle for gpu to 103000
> > 	[   12.482860] tegra_soctherm 700e2000.thermal-sensor: throttrip: will=
 throttle when gpu reaches 103000 mC
> > 	[   12.485357] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will=
 shut down when pll reaches 103000 mC
> > 	[   12.501774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will=
 shut down when mem reaches 103000 mC
> >=20
> > and after these changes, it turns into:
> >=20
> > 	[   12.447113] tegra_soctherm 700e2000.thermal-sensor: missing thermtr=
ips, will use critical trips as shut down temp
> > 	[   12.472300] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will=
 shut down when cpu reaches 102500 mC
> > 	[   12.481789] tegra_soctherm 700e2000.thermal-sensor: programming thr=
ottle for cpu to 102500
> > 	[   12.495447] tegra_soctherm 700e2000.thermal-sensor: throttrip: will=
 throttle when cpu reaches 102500 mC
> > 	[   12.496514] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will=
 shut down when gpu reaches 103000 mC
> > 	[   12.510353] tegra_soctherm 700e2000.thermal-sensor: programming thr=
ottle for gpu to 103000
> > 	[   12.526856] tegra_soctherm 700e2000.thermal-sensor: throttrip: will=
 throttle when gpu reaches 103000 mC
> > 	[   12.528774] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will=
 shut down when pll reaches 103000 mC
> > 	[   12.569352] tegra_soctherm 700e2000.thermal-sensor: programming thr=
ottle for pll to 103000
> > 	[   12.577635] tegra_soctherm 700e2000.thermal-sensor: throttrip: will=
 throttle when pll reaches 103000 mC
> > 	[   12.590952] tegra_soctherm 700e2000.thermal-sensor: thermtrip: will=
 shut down when mem reaches 103000 mC
> > 	[   12.600783] tegra_soctherm 700e2000.thermal-sensor: programming thr=
ottle for mem to 103000
> > 	[   12.609204] tegra_soctherm 700e2000.thermal-sensor: throttrip: will=
 throttle when mem reaches 103000 mC
> >=20
> > The "programming throttle ..." messages are something I've added locally
> > to trace what gets called. So it looks like for "pll" and "mem" thermal
> > zones, we now program trip points whereas we previously didn't.

My diagnosis above wasn't entirely correct. We're not actually skipping
trip point programming for PLL and MEM thermal zones in the current
code. Instead, we skip throttle programming. As far as I can tell this
is a mechanism built into ACTMON to allow it to automatically throttle
when a zone reaches a certain temperature.

This is modelled as a cooling device, but internally it's actually done
automatically, which is why we have this code that programs the throttle
at driver probe time, rather than the on-demand programming that typical
cooling device would do (such as a fan).

The reason why we have get_thermal_instance() here is to check if this
built-in cooling device has been configured for the "hot" trip point. If
not, we don't want the throttle programming to happen. This adds the
added flexibility of explicitly disabling the automatic throttling by
ACTMON and using another cooling device (or none at all) if that's what
is needed.

Dropping just the call to get_thermal_instance() and relying on the
find_throttle_cfg_by_name() function will always return a valid throttle
configuration. This is slightly obfuscated because of this:

	cdev =3D ts->throt_cfgs[i].cdev;
	if (get_thermal_instance(tz, cdev, trip_id))
		stc =3D find_throttle_cfg_by_name(ts, cdev->type);

As far as I can tell this will always return &ts->throt_cfgs[i], so the
find_throttle_cfg_by_name() call is a bit redundant here. I'll look into
fixing that.

In any case, the important thing is that it would always find a valid
throttle configuration and therefore program the throttle, even if we
may not want to.

Possibly we could work around that by removing this fiddly special case
and instead add a new callback for the cooling devices that can be run
when they are bound to a thermal zone. This would allow the throttle
programming to be initiated from within the thermal core rather than
"bolted on" like it is now and should allow us to achieve the same
effect but without calling into get_thermal_instance().

I'll try and prototype this, but feel free to suggest anything better if
you can think of something.

Thierry

--FbUzMna8IwvuWEei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPiQZEACgkQ3SOs138+
s6FaFQ//e88V00vLx6qcMkM+uwcyMZpZMgrbQwDSJ1ZChewZ3/z5e8S6i//C1FSa
6Cc4gqM98e+DrFmm82o8zBT96GkBvr3bq9uuRgTNl4aOLDfsmOweA+8f8vYr1sDJ
Ks7CM9xx9nSQLF15kZXaLQXH88vcCerMRs1Quvasphqxm8uzVlxDF/NGv8tZ+VgQ
pwYcPVWCak2+Tbgno3s4t8s5F6qupsOTle41pa78TlDxWelixetNr+sCWgfm8gWX
wuXARG53v3zIRTPFV1um6yERSP7GiEb3chT2GOOY0kamCIlKNUEh6bhQl+uJdfTp
TbTMI7LEsUjq1TrqzSw464YaVUxuYVpCY6Xz+Y3bZ5k6l2pL3vC+C+a2C4mpwSMq
5qYDBEX6292DJbFirNf/eRcg3hLZa3PG0QQlZrFrFwGYdF4rkDaKhoHSxX/CLgd+
f45lWveSrzFLnPaAWWCu0/hTFgJ8vHEE39Fyq2P3dX2Oh8xuqxYoXKyjVc78By8c
RGTTc64P+1zEWljKVqbOBSM0YYa8UiKdFETqXOjaM/iXGtWJZpOnvv2i+mo4LqoM
sRdTYF/rpokw0qOCJPMRDOABdb/4SzZS8NAzuVoxxcDuNVp43LuRplHNt7S2D10s
skq5H6KV/6ayd8xEJdGje4UHeF9II2z/9NSG7tjfiRVQ9quLqcA=
=qiD1
-----END PGP SIGNATURE-----

--FbUzMna8IwvuWEei--
