Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC8EA6A7E57
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjCBJpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjCBJp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:45:29 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D4A1ABC8;
        Thu,  2 Mar 2023 01:45:12 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i34so65099291eda.7;
        Thu, 02 Mar 2023 01:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677750311;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LFKciaVxWsI1bdvVTVhhU90af8xSaJ1NLkAZ/qUOn7E=;
        b=a9XWIOYMn7P9Z+cEl7wXFnuLGkEgDKUpmy7ZtmviWsGxWHvLg8Dat8g4ULDtHOHPAB
         2/FU0/jReybRbj7xEFsIdVV7yEE6DmHVqd1SLSj165X6etlS1KYDBApMtaVwD0Buoan7
         vCwI+q56gpcW/lg+nvVwRndgeeuz5rdMQs0A2RTNbyL4imXQBh2aV+2HtNSlJFbv35JE
         11KuCmsSqLJELfE/fnVMnhQTeGSPpdwvkg687bvYTuUuPxQm9ZlIohkP8aWy3hMuYjaZ
         EK2R0xzt1BPQuuXTNIwu2f+lJhmx84AHPpGtYG73nSCKzgt24/fNcibHy+48qzKAcrjt
         vt2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677750311;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LFKciaVxWsI1bdvVTVhhU90af8xSaJ1NLkAZ/qUOn7E=;
        b=CvzYCPjtyPJfTZPxFLZlJABqYIWHjqS+ZjsrRL4vVKP1jRW+OVH6oQ0E9s2P3CccCV
         2v3dTxsVgYE0apgIO2qSmCMknErPJCrQT/RkD98QwzuBw/aaQOdaN4KfdQHrCvo7XO8R
         mX5A9UBiSv6eZJ94/vEDMYhSi6Ql/H2J5XpSYU1eZubyQHBMJB10/tbaep6ZRd3pWO9n
         nsT/lZF5RIzJizJmg3VsdppE5d4IWLkxSzO14TNL6vQmuGP7HfHuJzRLrMZCO+q9ZJCA
         vinhp0MpHXzF9TjGbmYxkF/lVqbGbrs+8ttm8PRx7URYaqriMmgB4gPuqmM4eolq5OXd
         YKJg==
X-Gm-Message-State: AO0yUKUc43zKxMjA5zd6BArOvowAiYWKFRKGWasLkSpOdh43QXNYVDRg
        unQvJ4dFzYQdEk/DINGTh30=
X-Google-Smtp-Source: AK7set9Y5XlSQ6knYqYq6GGsCOUL4uhbYjMqg8SF5P4GAkGL+yKACErElBM2m9HkPcwCjQzmsRe9TQ==
X-Received: by 2002:aa7:c413:0:b0:4bf:4b5c:1d66 with SMTP id j19-20020aa7c413000000b004bf4b5c1d66mr2671972edq.31.1677750311073;
        Thu, 02 Mar 2023 01:45:11 -0800 (PST)
Received: from orome (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id l9-20020a50d6c9000000b004a9b5c957bfsm5397803edj.77.2023.03.02.01.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 01:45:10 -0800 (PST)
Date:   Thu, 2 Mar 2023 10:45:09 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v4 16/19] thermal/drivers/tegra: Remove unneeded lock
 when setting a trip point
Message-ID: <ZABwJdBk/Z1NHc12@orome>
References: <20230228112238.2312273-1-daniel.lezcano@linaro.org>
 <20230228112238.2312273-17-daniel.lezcano@linaro.org>
 <Y/9eohV9h26hPuFn@orome>
 <e5a4aaf1-af0a-aac4-6f77-94c3c9bfcc67@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cGvBIU0HUBvYGA1q"
Content-Disposition: inline
In-Reply-To: <e5a4aaf1-af0a-aac4-6f77-94c3c9bfcc67@linaro.org>
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


--cGvBIU0HUBvYGA1q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2023 at 03:35:13PM +0100, Daniel Lezcano wrote:
> On 01/03/2023 15:18, Thierry Reding wrote:
> > On Tue, Feb 28, 2023 at 12:22:35PM +0100, Daniel Lezcano wrote:
> > > The function tegra_tsensor_enable_hw_channel() takes the thermal zone
> > > lock to prevent "a potential" race with a call to set_trips()
> > > callback.
> > >=20
> > > The driver must not play with the thermal framework core code
> > > internals.
> > >=20
> > > The tegra_tsensor_enable_hw_channel() is called by:
> > >=20
> > >   - the suspend / resume callbacks
> > >   - the probe function after the thermal zones are registered
> > >=20
> > > The thermal zone lock taken in this function is supposed to protect
> > > from a call to the set_trips() callback which writes in the same
> > > register.
> > >=20
> > > The potential race is when suspend / resume are called at the same
> > > time as set_trips. This one is called only in
> > > thermal_zone_device_update().
> > >=20
> > >   - At suspend time, the 'in_suspend' is set, thus the
> > >     thermal_zone_device_update() bails out immediately and set_trips =
is
> > >     not called during this moment.
> > >=20
> > >   - At resume time, the thermal zone is updated at PM_POST_SUSPEND,
> > >     thus the driver has already set the TH2 temperature.
> > >=20
> > >   - At probe time, we register the thermal zone and then we set the
> > >     TH2. The only scenario I can see so far is the interrupt fires, t=
he
> > >     thermal_zone_update() is called exactly at the moment
> > >     tegra_tsensor_enable_hw_channel() a few lines after registering i=
t.
> > >=20
> > > Disable the interrupt before setting up the hw channels and then
> > > enable it. We close the potential race window without using the
> > > thermal zone's lock.
> > >=20
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > ---
> > >   drivers/thermal/tegra/tegra30-tsensor.c | 17 ++++++++++++-----
> > >   1 file changed, 12 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/thermal/tegra/tegra30-tsensor.c b/drivers/therma=
l/tegra/tegra30-tsensor.c
> > > index 4b2ea17910cd..3506c3f3c474 100644
> > > --- a/drivers/thermal/tegra/tegra30-tsensor.c
> > > +++ b/drivers/thermal/tegra/tegra30-tsensor.c
> > > @@ -359,9 +359,6 @@ static int tegra_tsensor_enable_hw_channel(const =
struct tegra_tsensor *ts,
> > >   	tegra_tsensor_get_hw_channel_trips(tzd, &hot_trip, &crit_trip);
> > > -	/* prevent potential racing with tegra_tsensor_set_trips() */
> > > -	mutex_lock(&tzd->lock);
> > > -
> > >   	dev_info_once(ts->dev, "ch%u: PMC emergency shutdown trip set to %=
dC\n",
> > >   		      id, DIV_ROUND_CLOSEST(crit_trip, 1000));
> > > @@ -404,8 +401,6 @@ static int tegra_tsensor_enable_hw_channel(const =
struct tegra_tsensor *ts,
> > >   	val |=3D FIELD_PREP(TSENSOR_SENSOR0_CONFIG0_INTR_THERMAL_RST_EN, 1=
);
> > >   	writel_relaxed(val, tsc->regs + TSENSOR_SENSOR0_CONFIG0);
> > > -	mutex_unlock(&tzd->lock);
> > > -
> > >   	err =3D thermal_zone_device_enable(tzd);
> > >   	if (err) {
> > >   		dev_err(ts->dev, "ch%u: failed to enable zone: %d\n", id, err);
> > > @@ -592,12 +587,24 @@ static int tegra_tsensor_probe(struct platform_=
device *pdev)
> > >   		return dev_err_probe(&pdev->dev, err,
> > >   				     "failed to request interrupt\n");
> > > +	/*
> > > +	 * Disable the interrupt so set_trips() can not be called
> > > +	 * while we are setting up the register
> > > +	 * TSENSOR_SENSOR0_CONFIG1. With this we close a potential
> > > +	 * race window where we are setting up the TH2 and the
> > > +	 * temperature hits TH1 resulting to an update of the
> > > +	 * TSENSOR_SENSOR0_CONFIG1 register in the ISR.
> > > +	 */
> > > +	disable_irq(irq);
> > > +
> > >   	for (i =3D 0; i < ARRAY_SIZE(ts->ch); i++) {
> > >   		err =3D tegra_tsensor_enable_hw_channel(ts, i);
> > >   		if (err)
> > >   			return err;
> > >   	}
> > > +	enable_irq(irq);
> >=20
> > Instead of disabling and reenabling the interrupt, could we simply move
> > the channel enabling code a couple of lines above, before the IRQ
> > request call? If enabling the channels were to trigger an interrupt, it
> > should get triggered right after requesting the IRQ.
>=20
> Won't we have a spurious interrupt if that situation happen ?

It wouldn't be a spurious interrupt, but rather something that we want
to react to. It's ultimately the same result as your patch. In your
variant we basically request the IRQ (which automatically enables it),
then immediately disable it, enable the HW channels and then reenable
the interrupt. If enabling the HW channels were to trigger an interrupt,
that interrupt would be raised immediately after enable_irq() as well,
as far as I can tell.

Thierry

--cGvBIU0HUBvYGA1q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmQAcCQACgkQ3SOs138+
s6HbKRAAwcPUT4wfSwfpFIk557lM4eZo8pJS4TjDvE4EGGf4Gs7Ke04igpYdkjbk
IGz+YJSY99p0ceoUIDyZL+oFrxtY1GA+cNLasbPs4f8lODO+cEx/pAmhj6Es4QgW
0SuHg7GGv3djTDtdgssXZGkZ9qSufziQw9nIOxcpL/qGfhB6u1ci57aK43UrMXvZ
XVemVK1RDUrKG2juxH90jqBUXQMcrjyvPbzoAn6J/q0gX4UF9jAjxbKDsieSzeb+
q82kh/OGp+rIVwPJ+1HuqtCm55fVUc0rJqANv5x9O5nZC1iT9FNX9tLzoGdr9IhO
d9e+rLgXlRAse7CVJ0S7nLq9EXDcaP9VGfA2djb53mEURX9VBLDxWxb1xK5FC+qQ
57zI0TW8k/6PSP+1I6NZLufV0uBwP3HjK2AGlI9+L7L4aYJ0QGOhuRqPGSdwT2Va
ofGTaM+vRS00GsGDyVdSFpDEX/+n3Vl8jc+SUJ0BbjZQgcMaEl/xog7/kz3xBn97
k40jIaq0OdrmKcTdfAFYmL6VlMkXBWgLk4oIfSSl7PiSKjcgbKmD4oHkmKx7hqs7
zuXY82vtIWVl23GlA+SoRrzovjKKkNa1g9rfadfEk5iTqkjk4g667nL181uN6PIY
PI2HjpN53+0zuUBQBdnYHzuEbR23C1UV9Dumw5zeCnwPCyOR1bM=
=Eg99
-----END PGP SIGNATURE-----

--cGvBIU0HUBvYGA1q--
