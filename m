Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7CE679708
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjAXLuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAXLuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:50:44 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6DF4346C;
        Tue, 24 Jan 2023 03:50:30 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7E62F1C0008;
        Tue, 24 Jan 2023 11:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674561029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gip/5wYm+i55v0+JQ88y8nuBa+vXIFpCdmLVgWdcsVk=;
        b=DljCXLOb4dzsaEu0ozmSGV8XFgn20xYjSmXrrSivwa+auj/JQCXtXJrj0DKLCb/VulrBI5
        fVy1Pr/qkgvM/ViotyhEYm5QwOrbwDQOU4aIA8FMt41N/0UZXYcQaOy/YBXfliYOMo0zkV
        YIabBxQBUnOp6m+yPbBIXpEDzqOPmWE9ZWj7PCHG7RQvZZEgZzdc/8YdKkICDLvgPaPKgx
        0J7QUkNhBPeeme6ZswOw8zeTfSXkUFnSm52LN/nN0SWdI7Zp91pscrDiXeES+0JjE7borH
        ntJ6QmoaoJ7wn7Uzdy97bDh+LD/Jtm5icbW2ASdxTtlRZqskRROWW8mT2Z2COA==
Date:   Tue, 24 Jan 2023 12:50:27 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal/drivers/armada: Use the
 thermal_zone_get_crit_temp()
Message-ID: <20230124125027.2dba0f1a@xps-13>
In-Reply-To: <4225f833-0f15-5780-5ef4-4cd9e05eca70@linaro.org>
References: <20230118222610.186088-1-daniel.lezcano@linaro.org>
        <20230124120458.412fc528@xps-13>
        <4225f833-0f15-5780-5ef4-4cd9e05eca70@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

daniel.lezcano@linaro.org wrote on Tue, 24 Jan 2023 12:36:22 +0100:

> On 24/01/2023 12:04, Miquel Raynal wrote:
> > Hi Daniel,
> >=20
> > daniel.lezcano@linaro.org wrote on Wed, 18 Jan 2023 23:26:10 +0100:
> >  =20
> >> The driver browses the trip point to find out the critical trip
> >> temperature. However the function thermal_zone_get_crit_temp() does
> >> already that, so the routine is pointless in the driver.
> >>
> >> Use thermal_zone_get_crit_temp() instead of inspecting all the trip
> >> points.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>   drivers/thermal/armada_thermal.c | 38 +++++++++++++-----------------=
--
> >>   1 file changed, 15 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada=
_thermal.c
> >> index db040dbdaa0a..c6d51d8acbf0 100644
> >> --- a/drivers/thermal/armada_thermal.c
> >> +++ b/drivers/thermal/armada_thermal.c
> >> @@ -784,34 +784,26 @@ static int armada_configure_overheat_int(struct =
armada_thermal_priv *priv,
> >>   					 int sensor_id)
> >>   {
> >>   	/* Retrieve the critical trip point to enable the overheat interrup=
t */
> >> -	struct thermal_trip trip;
> >> +	int temperature;
> >>   	int ret;
> >> -	int i;
> >> -
> >> -	for (i =3D 0; i < thermal_zone_get_num_trips(tz); i++) {
> >> -
> >> -		ret =3D thermal_zone_get_trip(tz, i, &trip);
> >> -		if (ret)
> >> -			return ret;
> >> -
> >> -		if (trip.type !=3D THERMAL_TRIP_CRITICAL)
> >> -			continue;
> >> -
> >> -		ret =3D armada_select_channel(priv, sensor_id);
> >> -		if (ret)
> >> -			return ret; =20
> >>   >> -		armada_set_overheat_thresholds(priv, trip.temperature, =20
> >> -					       trip.hysteresis);
> >> -		priv->overheat_sensor =3D tz;
> >> -		priv->interrupt_source =3D sensor_id;
> >> +	ret =3D thermal_zone_get_crit_temp(tz, &temperature);
> >> +	if (ret)
> >> +		return ret; =20
> >>   >> -		armada_enable_overheat_interrupt(priv); =20
> >> +	ret =3D armada_select_channel(priv, sensor_id);
> >> +	if (ret)
> >> +		return ret; =20
> >>   >> -		return 0; =20
> >> -	}
> >> +	/*
> >> +	 * A critical temperature does not have a hysteresis
> >> +	 */ =20
> >=20
> > Makes sense.
> >=20
> > Nit: I would actually put that comment in the commit log rather than
> > keeping it in the code, but whatever, that's a nice simplification. =20
>=20
> Oh, actually, I added the comment because of the third parameter change f=
or armada_set_overheat_thresholds(..., 0);

Yes, that's why I proposed to mention it in the commit log rather than
in the code. If having no threshold here makes sense (and it does), I
don't see the point in explaining it in a comment. I usually use
comments to explain what could appear strange/unclear when looking at
the code.

Here, while the parameter change is intended and legitimate, I feel
like it is worth justifying, but doing so in the commit logs feels
enough.

But that's minor tbh, so feel free to do it like you prefer.

> >> +	armada_set_overheat_thresholds(priv, temperature, 0); =20
>=20
> I think it makes sense to keep the comment to clarify why we pass this ze=
ro temperature argument.

Thanks,
Miqu=C3=A8l
