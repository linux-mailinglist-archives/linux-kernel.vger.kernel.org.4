Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA61692081
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjBJOJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:09:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjBJOJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:09:20 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BE71B570;
        Fri, 10 Feb 2023 06:09:18 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id eq11so4829874edb.6;
        Fri, 10 Feb 2023 06:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaaowqizpyCywHDv01QScdJ+v3gu4wU51pTS96JdybE=;
        b=ZSkK2tJ03EgmtBB0OYztMF1RWP/upj5yq3rTQwXFcD+b5bbAewbgfmXmfdVb2HHues
         T9vWfYgCjsOIlsDG51OKFZvnjaSKj25ZvZbj5vPNYtQw700xQwvAOsX3lmR1FWPjTt5E
         XvCrgZZZmQcgrBsZySnliY4fFIlDVX7VNijxcLosJXZKuDH/LoaY5oBvhnte3JL/2OAu
         oNrBBWEQq4Gj1KDHRroV4YiOH4HNxgfP8qR3S+emn5hfKZYuBE7HhF2GnJp2nuogm8tN
         sFrw463tBcYnb41zh960xUB+hrskETD3wiNxmGvWZ9T8gH1IrUYbLIu196VLG7ZkeCYZ
         39CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kaaowqizpyCywHDv01QScdJ+v3gu4wU51pTS96JdybE=;
        b=indfH5EQ460DUiU9G14Nroakn4N+bbq8CvdDlDqs8TpoqPiC7RzIP9nFUA79yoVVpF
         2dVIJLMdSKVQIIeDbi4IYxIszwisUkmIbQrk6iJDx+1RzkY9b3mnC9/qXxwKMuFvJORe
         I5aWWjgx+Z9/plMNn8qZZ32qUT4OjcyjiuelamA+bkG67u6VgXqrg0Y/lcgxYvKACh3K
         oW+F84L/mLjB9Q45G+WFq4cA12TErebocc4T3BtH8WT0RTsL+8CeMsLateO8mG+j39nk
         UjrQvCYPEZD9Me7hk/qsJKjwyWtbnLo+c7h4QkJ3ZYLG9dMOPF5BQ7XtwlzBrCw62pTX
         y5tg==
X-Gm-Message-State: AO0yUKUtIb3z+Rlzhac3meYjabwkxFjp+6ZTEmgquBabuPjpgQjKR059
        nTxkDiTzzhDbK1hiR3K7uc8=
X-Google-Smtp-Source: AK7set/lqTpxKj1uOsUtuiV0/xMsGyrWn2gQx/wDnwj/vIPO58krvl3eyDMfKU3T2O6mEAE1SadMNQ==
X-Received: by 2002:a50:950e:0:b0:4a2:3637:5be2 with SMTP id u14-20020a50950e000000b004a236375be2mr17127640eda.39.1676038157267;
        Fri, 10 Feb 2023 06:09:17 -0800 (PST)
Received: from orome (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id i30-20020a50d75e000000b004aadd75032dsm2264504edj.70.2023.02.10.06.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 06:09:16 -0800 (PST)
Date:   Fri, 10 Feb 2023 15:09:15 +0100
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
Message-ID: <Y+ZQC85TM+O8p8gQ@orome>
References: <fa2bd92a-f2ae-a671-b537-87c0f3c03dbd@linaro.org>
 <Y9J4WAFyXyV/nqlG@orome>
 <20230210131703.GF175687@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FD2Fv40RBLp/lK5w"
Content-Disposition: inline
In-Reply-To: <20230210131703.GF175687@linaro.org>
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


--FD2Fv40RBLp/lK5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 10, 2023 at 02:17:03PM +0100, Daniel Lezcano wrote:
> Hi Thierry,
>=20
> On Thu, Jan 26, 2023 at 01:55:52PM +0100, Thierry Reding wrote:
> > On Tue, Jan 24, 2023 at 08:57:23PM +0100, Daniel Lezcano wrote:
> > >=20
> > > Hi,
> > >=20
> > > does anyone know what is the purpose of the get_thermal_instance() us=
age in
> > > this code:
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tre=
e/drivers/thermal/tegra/soctherm.c?h=3Dthermal/linux-next#n623
> > >=20
> > > The driver is using a function which is reserved for the thermal core=
=2E It
> > > should not.
> > >=20
> > > Is the following change ok ?
> > >=20
> > > diff --git a/drivers/thermal/tegra/soctherm.c
> > > b/drivers/thermal/tegra/soctherm.c
> > > index 220873298d77..5f552402d987 100644
> > > --- a/drivers/thermal/tegra/soctherm.c
> > > +++ b/drivers/thermal/tegra/soctherm.c
> > > @@ -620,9 +620,8 @@ static int tegra_thermctl_set_trip_temp(struct
> > > thermal_zone_device *tz, int trip
> > >  				continue;
> > >=20
> > >  			cdev =3D ts->throt_cfgs[i].cdev;
> > > -			if (get_thermal_instance(tz, cdev, trip_id))
> > > -				stc =3D find_throttle_cfg_by_name(ts, cdev->type);
> > > -			else
> > > +			stc =3D find_throttle_cfg_by_name(ts, cdev->type);
> > > +			if (!stc)
> > >  				continue;
> > >=20
> > >  			return throttrip_program(dev, sg, stc, temp);
> > > @@ -768,9 +767,9 @@ static int tegra_soctherm_set_hwtrips(struct devi=
ce
> > > *dev,
> > >  			continue;
> > >=20
> > >  		cdev =3D ts->throt_cfgs[i].cdev;
> > > -		if (get_thermal_instance(tz, cdev, trip))
> > > -			stc =3D find_throttle_cfg_by_name(ts, cdev->type);
> > > -		else
> > > +
> > > +		stc =3D find_throttle_cfg_by_name(ts, cdev->type);
> > > +		if (!stc)
> > >  			continue;
> > >=20
> > >  		ret =3D throttrip_program(dev, sg, stc, temperature);
> >=20
> > There's a small difference in behavior after applying this patch. Prior
> > to this I get (on Tegra210):
> >=20
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
>=20
> The DT descriptioni (tegra210.dtsi) says one thing and the implementation=
 says
> something else.
>=20
> If we refer to the PLL description, there is one 'hot' trip point and
> one 'critical' trip point. No polling delay at all, so we need the
> interrupts.
>=20
> Logically, we should set the 'hot' trip point first, when the trip
> point is crossed, we setup the next trip point, which is the critical.
>=20
> With these two trip points, the first one will send a notification to
> the userspace and the second one will force a shutdown of the
> system. For both, no cooling device is expected.

I think the intention here is to use the soctherm's built-in throttling
mechanism as a last resort measure to try and cool the system down. I
suppose that could count as "passive" cooling, so specifying it as the
cooling device for the "passive" trip point may be more appropriate.

The throttling that happens here is quite severe, so we don't want it to
happen too early. I would expect that our "passive" trip point shouldn't
be a lot less than the "hot" temperature. I suspect that's the reason
why the "hot" trip point was reused for this.

I'm also beginning to think that we should just not expose the soctherm
throttling as a cooling device and instead keep it internal to the
soctherm driver entirely.

> Well, actually I don't get the logic of the soctherm driver. It should
> just rely on the thermal framework to set the trip point regardless
> the cooling devices.

Again, "throttrip" doesn't map well to the concept of trip points
because its not a mechanism to notify when a certain temperature is
reached. It's an additional mechanism to automatically start throttling
once a given temperature threshold is crossed. So it's basically an
auto-cooling-device. If we program it only in response to a trip point
notification, there aren't any benefits to this throttle mechanism. So
again, I think we're probably better off just removing the cooling
device implementation for it and always program it with the "hot" or
"passive" trip point temperatures.

> The device tree also is strange. For example, the dram sets
> cooling-device =3D <&emc 0 0>; an inoperative action for a 'nominal'
> trip point ... If the goal is to stop the mitigation, that is already
> done by the governor when the trip point is crossed the way down. The
> second trip point is an 'active' cooling device but it refers to a emc
> which is, at the first glance, a passive cooling device.

I think this is because for the mem-thermal zone, "passive" is
considered to be less "severe" than "active". My understanding is that
the severity goes "active", "passive", "hot", "critical". "Active" trip
points are those where we want to use active cooling devices (such as a
fan, for example) to try and cool the device. The "passive" trip points
should only be reached when active cooling devices aren't up to the job
and passive mechanisms need to be deployed. Passive in this case meaning
the hardware itself has to be throttled.

If you look at the temperatures defined for passive vs. active for the
"mem" thermal zone, then clearly they are reversed. <&emc 0 0> should be
used for active trip points, and <&emc 1 1> means throttling of the EMC
frequency, i.e. for passive trip points.

> The gpu description only describes hot and critical trip points. The
> cooling device maps to the 'hot' trip point ! The governor is not used
> in this case, so the cooling device is inoperative. Same for the cpu
> thermal zone.
>=20
> IOW, the driver is not correctly implemented and the device tree is
> wrong. Thermal is not working correctly on these board AFAICT.

I'll try to rework this. As I mentioned above I think we can just remove
that throttle_heavy cooling device and instead hard-code that in the
driver to a given temperature. Given that this is probably all defunct
anyway, the best would probably be to extend the soctherm's
throttle-cfgs node with a temperature field so we can avoid the reliance
on trip points (which would allow us to get rid of the calls to the
get_thermal_instance() helper).

On the DT side, I think most of the cooling maps can be cleaned up. We
can remove the entries for "critical" and "hot" trip points if the
driver unconditionally programs the automated throttling. For EMC we
want to reverse the "passive" and "active" trip points and possibly drop
the dram-passive cooling map as well, since you mentioned the core would
take care of disabling the cooling device automatically.

Thierry

--FD2Fv40RBLp/lK5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmPmUAgACgkQ3SOs138+
s6E3RxAAtaqjZamqrTmWIM4Pv1ictDMHSC9sjM91gshZ3YeKH8PWk4UCrJXlxooH
Gnm+Yqh9xg+LilmwTXBYe7oozf+Yr64FqD8Jdyxr32Jy7bFehRs7Sh7FvEYLGz8J
v6ElKtan5XL+/7RCveWuLS07baIbzIct8PSbDL8UZPtLvijpDvMihm18TUvmhO65
Ur34uMZ2CSVFR6cBhf+xPK7QWQP+Z3k2aV+epZLlog++inyLE+7i0bTJ639QenLs
9NpJkDDQ6giJUrHjk9ll84ievStpKhD0lkYB9tZKQTBOOx5kA/5HxqsQMJbk3K/o
j3Akef3T0aqwEWlgQj8avjrD2GgVE5tYxx5xAslxQgmL0eITAbwY/f/vlNViPG6t
e0rt7nYDcCOzUUKbfRWIA+VZyOALMvHoEfvvUgUPOVxxkusIZz8lfKxIo6NlahhK
b5vv4++l1zxG5xBey5WCFBF4SnaniT3cheNv9SgVEdvzGOctB4UsxDNe1aCUVhdR
bFbTk8DXiMovRxRnlGnwO0zGKsf1/81m3jo9/aq7xbrESkg4XTJWsUYVwTFN3gmv
zt59rVUZOBKzc0+X8UdjuK954505mEmLG5fEf7m4PBn79fWgbkqe0j0DrIYzFCtg
xsZuh8phkkXQxoPNLz2+hR1jlf0Zt1t0SAZc1zLrw2nuRHJATpo=
=9tKe
-----END PGP SIGNATURE-----

--FD2Fv40RBLp/lK5w--
