Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4516BC2E9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 01:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjCPAl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 20:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCPAl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 20:41:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F95A22010;
        Wed, 15 Mar 2023 17:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC3B761EDB;
        Thu, 16 Mar 2023 00:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8A0EC433EF;
        Thu, 16 Mar 2023 00:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678927285;
        bh=2baqaQl7HjA1FPCOxMOKYpBnNpjxEa9fl+66c+f4WIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YF77QI8/4ZHYEioAo73OtRr8jkZg+Hq0tS7XJDKUa7h4j7vAOEspREzPSrT80FHDP
         RwGa+2Utd5hdOKxheYCp2qet9VxnB/ZEjBPymk77qgkXjC3xGiZa98pOrrkHSnQzdm
         zSjEcVRvHJsnCVRdU0TGGdgLR3Y4a8gxXOA7nDTNnuLsGDnCz4IZBqf+agS/t1C/A+
         /Nw4pPXGaZt63mCxH5VT5C2UC6j/++wceCwhf+DSDLiPaN294UH8QPCnW71qL+yJAv
         gRPxn39njV4VckBvVhYAbkyPAUm3ZXLrAwUqYYA/7dCPNklxP3/x+A39NVyNKJPc2W
         OjvmeSdbGJUcA==
Received: by mercury (Postfix, from userid 1000)
        id BC00010609DC; Thu, 16 Mar 2023 01:41:21 +0100 (CET)
Date:   Thu, 16 Mar 2023 01:41:21 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCHv2 02/12] power: supply: core: auto-exposure of
 simple-battery data
Message-ID: <20230316004121.rwieru4aj7d6mwgb@mercury.elektranox.org>
References: <20230314225535.1321736-1-sre@kernel.org>
 <20230314225535.1321736-3-sre@kernel.org>
 <baffa307-173c-6ba1-0289-e7287049c0f5@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pxerrciqwgwovktl"
Content-Disposition: inline
In-Reply-To: <baffa307-173c-6ba1-0289-e7287049c0f5@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pxerrciqwgwovktl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 15, 2023 at 09:01:50AM +0200, Matti Vaittinen wrote:
> On 3/15/23 00:55, Sebastian Reichel wrote:
> [...]
> >   #ifdef CONFIG_THERMAL
> >   static int power_supply_read_temp(struct thermal_zone_device *tzd,
> >   		int *temp)
> > @@ -1255,6 +1387,11 @@ __power_supply_register(struct device *parent,
> >   		goto check_supplies_failed;
> >   	}
> > +	/* psy->battery_info is optional */

I forgot to add a POWER_SUPPLY_TYPE_BATTERY limitation when removing
the opt-in method. Will be added in the next revision.

> > +	rc =3D power_supply_get_battery_info(psy, &psy->battery_info);
> > +	if (rc && rc !=3D -ENODEV)
> > +		goto check_supplies_failed;
> > +
>=20
> This is what rubs me in a slightly wrong way - but again, you probably kn=
ow
> better than I what's the direction things are heading so please ignore me=
 if
> I am talking nonsense :)
>=20
> Anyways, I think the battery information may be relevant to the driver wh=
ich
> is registering the power-supply. It may be there is a fuel-gauge which ne=
eds
> to know the capacity and OCV tables etc. Or some other thingy. And - I may
> be wrong - but I have a feeling it might be something that should be known
> prior registering the power-supply.

You can still do that, just like before. It's a bit inefficient,
since the battery data is allocated twice, but the driver probe
routine is not a hot path.

> So, in my head it should be the driver which is getting the information
> about the battery (whether it is in the DT node or coded in some tables a=
nd
> fetched by battery type) - using helpers provided by core.
>=20
> I further think it should be the driver who can pass the battery informat=
ion
> to core at registration - core may 'fall-back' finding information itself=
 if
> driver did not provide it.

This implements the fallback route.

> So, I think the core should not unconditionally populate the battery-info
> here but it should first check if the driver had it already filled.

Not until there is a user (i.e. a driver using that feature). FWIW
it's quite easy to implement once it is needed. Just adding a field
in power_supply_config and taking it over here is enough, no other
code changes are required.

The alternative is adding some kind of probe/remove callback for the
power_supply device itself to properly initialize the device. That
would also be useful to have a sensible place for e.g. shutting of
chargers when the device is removed. Anyways it's a bit out of scope
for this patchset :)

> Well, as I said, I recognize I may not (do not) know all the dirty details
> and I do trust you to evaluate if what I wrote here makes any sense :) All
> in all, I think this auto-exposure is great.
>=20
> Please, bear with me if what I wrote above does not make sense to you and
> just assume I don't see the big picture :)

Right now the following battery drivers use power_supply_get_battery_info():

 * cw2015_battery
 * bq27xxx_battery
 * axp20x_battery
 * ug3105_battery
 * ingenic-battery
 * sc27xx_fuel_gauge
 * (generic-adc-battery)

All of them call it after the power-supply device has been
registered. Thus the way to go for them is removing the second call
to power_supply_get_battery_info() and instead use the battery-info
acquired by the core. I think that work deserves its own series.

For chargers the situation is different (they usually want the data
before registration), but they should not expose the battery data
anyways. Also ideally chargers get the information from the battery
power-supply device, which might supply the data from fuel-gauge
registers (or fallback to battery-info after this series).

> >   	spin_lock_init(&psy->changed_lock);
> >   	rc =3D device_add(dev);
> >   	if (rc)
> > diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/=
supply/power_supply_sysfs.c
> > index c228205e0953..5842dfe5dfb7 100644
> > --- a/drivers/power/supply/power_supply_sysfs.c
> > +++ b/drivers/power/supply/power_supply_sysfs.c
> > @@ -380,6 +380,9 @@ static umode_t power_supply_attr_is_visible(struct =
kobject *kobj,
> >   		}
> >   	}
> > +	if (power_supply_battery_info_has_prop(psy->battery_info, attrno))
> > +		return mode;
> > +
> >   	return 0;
> >   }
> > @@ -461,6 +464,8 @@ static int add_prop_uevent(const struct device *dev=
, struct kobj_uevent_env *env
> >   int power_supply_uevent(const struct device *dev, struct kobj_uevent_=
env *env)
> >   {
> >   	const struct power_supply *psy =3D dev_get_drvdata(dev);
> > +	const enum power_supply_property *battery_props =3D
> > +		power_supply_battery_info_properties;
> >   	int ret =3D 0, j;
> >   	char *prop_buf;
> > @@ -488,6 +493,16 @@ int power_supply_uevent(const struct device *dev, =
struct kobj_uevent_env *env)
> >   			goto out;
> >   	}
> > +	for (j =3D 0; j < power_supply_battery_info_properties_size; j++) {
> > +		if (!power_supply_battery_info_has_prop(psy->battery_info,
> > +				battery_props[j]))
> > +			continue;
>=20
> Hmm. I just noticed that there can probably be same properties in the
> psy->desc->properties and in the battery-info.

That's intended, so that battery drivers can implement their own
behaviour for the properties.

> I didn't cascade deep into the code so I can't say if it is a
> problem to add duplicates?

It does not break anything (we used to have this for the TYPE
property in a driver), but confuses userspace. I will fix the
duplication in uevents and send a new version.

> So, if this is safe, and if what I wrote above is not something
> you want to consider:
>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Due to the changes I will not take this over in v3. Just to make
sure - is it correct, that you do not want your R-b tag for the
following two patches?

[05/12] power: supply: generic-adc-battery: drop jitter delay support
[08/12] power: supply: generic-adc-battery: use simple-battery API

> [...]

Thanks for your reviews,

-- Sebastian

--pxerrciqwgwovktl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQSZa4ACgkQ2O7X88g7
+poUCBAAgA+XVXm0Dr5yUfScp9DlyfZAJQ6TDO3XGQo3y0+4pYmILHaDL0g+aceA
ddUlz73hCvGDrAZ2FlraF+Sc4yatFiblaOWLMaKDQmFMVLSroPwYztwuooU8nXL/
ZHVVFFXeYkcfcihk2rJbrHKAco9L+gsyBlqq+ZziG8RIj6mMmNVoQwGNefcrWCT/
WMLxpPt8p6/I0wJhMhL2/ZmGTd/+bAQ8HWXEM8Abqe3IHqCFgzxg+06sOYLrNqlG
ZZwQPsvtjmQTZ4DRqBPtTUvpTaXcJ8S0KY23LoWP01AbUDfp8eqXthdgh19DbTQw
VwGdmZ3o12Lhjck1umAbBO2z0smjbnFGhr0l2t+40Je5AzRxd1WcEjiuXpOIgG3o
8cceXAiOSl1qTd5c7P4OV27XtMoiKw3awdZ3qI62qP/WL7RiUB+lCfD5zH/aNy6f
INf7qxRTsrTnk4ODhiB+Z+OlhDb0nLIUJndlLuqCVw1Qb0mp9uamWlWe/TPIqWaN
FzVilmfXszl5kJbjdrD9nZoxg4glkUc4+AzXuyp3bjyAsjI9ttxCedSto29OqLpP
cDcM8Ai+LABfFeR6SYLxYDXy7IOvi9FuloF/NqcrEXbF4OeZwOrDak2dZiGPFtar
I9/08os29w93hQwVEaE4qWVevWA97p+gjOrsgzq5iSOfnahWBd8=
=OUow
-----END PGP SIGNATURE-----

--pxerrciqwgwovktl--
