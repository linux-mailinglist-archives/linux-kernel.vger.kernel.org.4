Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA63D72679C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 19:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjFGRnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 13:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjFGRm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 13:42:59 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1591BF7;
        Wed,  7 Jun 2023 10:42:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id EEF9DED298;
        Wed,  7 Jun 2023 10:42:27 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VSwjU-ZNeK2n; Wed,  7 Jun 2023 10:42:27 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1686159746; bh=yzcHza535Knz3sPmrJrUUFyPYQOMzuWWt47W0zm0kPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kxr8ZpRVXotS3CvCC+tJXoqIVRX3KtkDEAyOIvqB3BEUe5oAqNMbfSPc+gZeIkKs5
         2z+eY/0LOgjRWsZkQRU70x9bEh2K7hVNCM67+knFWNwm5ioR1Z3yoT/9qdX6GXw3ZL
         E3WVUirXuI/Yuf1SCXnluJwn4q/8rAUcs0bIK3xYPo/Ui4pd4y2fFZ7BUpYC6mR4lc
         DWWvqCChO13B8MFIVm92Rp5NH1WFLMAsmzp30B9tGqsyclUzvP8fE7NYfbkzUbKJZE
         +OXcXIuvQSji97zy9WGJPvgDs7LOHrykgygdptTHNqDAxm7QS3HC8uP07klRSJt6xq
         ufrQT8FokmmbA==
To:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported sensors
Date:   Wed, 07 Jun 2023 19:42:12 +0200
Message-ID: <1966575.usQuhbGJ8B@pliszka>
In-Reply-To: <3120c2d5-4473-5b72-29bf-d841e806878f@linaro.org>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com> <21914890.EfDdHjke4D@pliszka>
 <3120c2d5-4473-5b72-29bf-d841e806878f@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On =C5=9Broda, 7 czerwca 2023 10:28:59 CEST Daniel Lezcano wrote:
> On 07/06/2023 08:01, Sebastian Krzyszkowiak wrote:
> > On pi=C4=85tek, 2 czerwca 2023 15:11:37 CEST Daniel Lezcano wrote:
> >> On 01/06/2023 11:52, Peng Fan wrote:
> >>> Hi Daniel,
> >>>=20
> >>>> Subject: RE: [PATCH 2/3] thermal: qoriq_thermal: only enable support=
ed
> >>>> sensors
> >>>>=20
> >>>>> Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable suppor=
ted
> >>>>> sensors
> >>>>>=20
> >>>>> On 31/05/2023 14:05, Peng Fan wrote:
> >>>>>>> Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable
> >>>>>>> supported sensors
> >>>>>>>=20
> >>>>>>> On 16/05/2023 10:37, Peng Fan (OSS) wrote:
> >>>>>>>> From: Peng Fan <peng.fan@nxp.com>
> >>>>>>>>=20
> >>>>>>>> There are MAX 16 sensors, but not all of them supported. Such as
> >>>>>>>> i.MX8MQ, there are only 3 sensors. Enabling all 16 sensors will
> >>>>>>>> touch reserved bits from i.MX8MQ reference mannual, and TMU will
> >>>>>>>> stuck, temperature will not update anymore.
> >>>>>>>>=20
> >>>>>>>> Fixes: 45038e03d633 ("thermal: qoriq: Enable all sensors before
> >>>>>>>> registering them")
> >>>>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >>>>>>>> ---
> >>>>>>>>=20
> >>>>>>>>      drivers/thermal/qoriq_thermal.c | 30
> >>>>>>>>      +++++++++++++++++++----------
> >>>>=20
> >>>> -
> >>>>=20
> >>>>>>>>      1 file changed, 19 insertions(+), 11 deletions(-)
> >>>>>>>>=20
> >>>>>>>> diff --git a/drivers/thermal/qoriq_thermal.c
> >>>>>>>> b/drivers/thermal/qoriq_thermal.c index
> >>>>=20
> >>>> b806a0929459..53748c4a5be1
> >>>>=20
> >>>>>>>> 100644
> >>>>>>>> --- a/drivers/thermal/qoriq_thermal.c
> >>>>>>>> +++ b/drivers/thermal/qoriq_thermal.c
> >>>>>>>> @@ -31,7 +31,6 @@
> >>>>>>>>=20
> >>>>>>>>      #define TMR_DISABLE	0x0
> >>>>>>>>      #define TMR_ME		0x80000000
> >>>>>>>>      #define TMR_ALPF	0x0c000000
> >>>>>>>>=20
> >>>>>>>> -#define TMR_MSITE_ALL	GENMASK(15, 0)
> >>>>>>>>=20
> >>>>>>>>      #define REGS_TMTMIR	0x008	/* Temperature measurement
> >>>>>>>=20
> >>>>>>> interval Register */
> >>>>>>>=20
> >>>>>>>>      #define TMTMIR_DEFAULT	0x0000000f
> >>>>>>>>=20
> >>>>>>>> @@ -105,6 +104,11 @@ static int tmu_get_temp(struct
> >>>>>>>=20
> >>>>>>> thermal_zone_device *tz, int *temp)
> >>>>>>>=20
> >>>>>>>>      	 * within sensor range. TEMP is an 9 bit value=20
representing
> >>>>>>>>      	 * temperature in KelVin.
> >>>>>>>>      	 */
> >>>>>>>>=20
> >>>>>>>> +
> >>>>>>>> +	regmap_read(qdata->regmap, REGS_TMR, &val);
> >>>>>>>> +	if (!(val & TMR_ME))
> >>>>>>>> +		return -EAGAIN;
> >>>>>>>=20
> >>>>>>> How is this change related to what is described in the changelog?
> >>>>>>=20
> >>>>>> devm_thermal_zone_of_sensor_register will invoke get temp, since we
> >>>>>> reverted the 45038e03d633 did, we need to check TMR_ME to avoid
> >>>>>=20
> >>>>> return
> >>>>>=20
> >>>>>> invalid temperature.
> >>>>>>=20
> >>>>>    From a higher perspective if the sensor won't be enabled, then t=
he
> >>>>>=20
> >>>>> thermal zone should not be registered, the get_temp won't happen on=
 a
> >>>>> disabled sensor and this test won't be necessary, no ?
> >>>=20
> >>> After thinking more, I'd prefer current logic.
> >>>=20
> >>> We rely on devm_thermal_of_zone_register's return value to know
> >>> whether there is a valid zone, then set sites bit, and after collected
> >>> all site bits, we enable the thermal IP.
> >>>=20
> >>> If move the enabling thermal IP before devm_thermal_of_zone_register,
> >>> We need check dtb thermal zone, to know which zone is valid for curre=
nt
> >>> thermal IP. This would complicate the design.
> >>>=20
> >>> So just checking the enabling bit in get temperature would be much
> >>> simpler, and there just a small window before enabling thermal IP.
> >>=20
> >> If the thermal zone is not described, then the thermal zone won't be
> >> created as it fails with -ENODEV and thus get_temp won't be called on a
> >> disabled site, right?
> >=20
> > That's not what the problem is. It's about zones that *will* be created=
 -
> > since the driver only knows that a thermal zone isn't described in the
> > device tree after it fails registering, it can't enable the site *befor=
e*
> > the zone gets registered - so it happens afterwards. That's why it needs
> > this check to not return a bogus initial value before the site gets
> > actually enabled later in qoriq_tmu_register_tmu_zone.
>=20
> Sorry, I get the point but I don't see how that can happen:
>=20
> qoriq_tmu_register_tmu_zone() calls devm_thermal_of_zone_register() for
> *all* sites regardless if they really exists or not.
>=20
> Under the hood, the function devm_thermal_of_zone_register() calls
> thermal_of_zone_register(). This one fails when calling
> of_thermal_zone_find() because it does not exist and returns -ENODEV.
>=20
> Hence, the thermal_zone_device_register_with_trips() is not called, the
> thermal zone is not created neither updated.

Again - that's not the case the check is there for. It's there for zones th=
at=20
do exist and that do get registered, because REGS_TMR only gets set *after*=
=20
all the zones are already registered (the driver as it is right now does no=
t=20
know which sites it should enable before registering the zones). Because of=
=20
that, the first value a zone gets after being registered is always bogus,=20
because no monitoring site has been enabled yet at all.

> So I don't understand why the test:
>=20
> +	regmap_read(qdata->regmap, REGS_TMR, &val);
> +	if (!(val & TMR_ME))
> +		return -EAGAIN;
>=20
> is needed in the get_temp() ops as the thermal zone for this disabled
> site should not exist.
>=20
> I'm not putting in question the series, just wanting to avoid a
> potential pointless check in an ops.

It's definitely not pointless (it does workaround a real issue). Is it eleg=
ant?=20
IMO bringing thermal_zone_of_get_sensor_id back (or doing something=20
equivalent) instead would be much cleaner:)

Cheers,
Sebastian


