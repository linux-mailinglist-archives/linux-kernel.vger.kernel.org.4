Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C998A7253CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjFGGB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjFGGBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:01:55 -0400
Received: from comms.puri.sm (comms.puri.sm [159.203.221.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116AE83;
        Tue,  6 Jun 2023 23:01:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 39AF6F02A5;
        Tue,  6 Jun 2023 23:01:23 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6Vkz2YQVTD2t; Tue,  6 Jun 2023 23:01:22 -0700 (PDT)
From:   Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=puri.sm; s=comms;
        t=1686117682; bh=O/zY6nrU7+HTjpYMUtFjQrMmI4VyQoafvb7Oak+nsQg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tL0Wnua/AJ8o6hZMURKpgqDELpV//ecZXVJFWl+AQFquPkohEnO+Lx0yqbfm0+yAR
         moIQq2iggqvU0lNjlqgLj+B+H5XNJbysRHvjwVbfXuQiZog/y13N0MJ1hoLX3KKHnd
         CHfg11vg2g+rdrePXt8xz+VcFlxBsMKTdyyUYwgce0BBsjEH9my0FX5JlWoN+inYH9
         GHctBUJGLYnTjgeUtiCIBXt+EXBwI8e8UKIDOrfb3AptfZ5a5utYruC4LU+mTPwoqA
         sLHf75IArwU9KMvAHeEbkLELvUa77ysgs+UpBNFVLfSco+cl7Rr+L8BeIHtej6tiZH
         r3iHMOcpNQd/g==
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
Date:   Wed, 07 Jun 2023 08:01:14 +0200
Message-ID: <21914890.EfDdHjke4D@pliszka>
In-Reply-To: <0eb717ac-82b1-8a76-58a2-394167e69b28@linaro.org>
References: <20230516083746.63436-1-peng.fan@oss.nxp.com>
 <DU0PR04MB9417D574603B54AEF76480AE88499@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <0eb717ac-82b1-8a76-58a2-394167e69b28@linaro.org>
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

On pi=C4=85tek, 2 czerwca 2023 15:11:37 CEST Daniel Lezcano wrote:
> On 01/06/2023 11:52, Peng Fan wrote:
> > Hi Daniel,
> >=20
> >> Subject: RE: [PATCH 2/3] thermal: qoriq_thermal: only enable supported
> >> sensors
> >>=20
> >>> Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable supported
> >>> sensors
> >>>=20
> >>> On 31/05/2023 14:05, Peng Fan wrote:
> >>>>> Subject: Re: [PATCH 2/3] thermal: qoriq_thermal: only enable
> >>>>> supported sensors
> >>>>>=20
> >>>>> On 16/05/2023 10:37, Peng Fan (OSS) wrote:
> >>>>>> From: Peng Fan <peng.fan@nxp.com>
> >>>>>>=20
> >>>>>> There are MAX 16 sensors, but not all of them supported. Such as
> >>>>>> i.MX8MQ, there are only 3 sensors. Enabling all 16 sensors will
> >>>>>> touch reserved bits from i.MX8MQ reference mannual, and TMU will
> >>>>>> stuck, temperature will not update anymore.
> >>>>>>=20
> >>>>>> Fixes: 45038e03d633 ("thermal: qoriq: Enable all sensors before
> >>>>>> registering them")
> >>>>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >>>>>> ---
> >>>>>>=20
> >>>>>>     drivers/thermal/qoriq_thermal.c | 30
> >>>>>>     +++++++++++++++++++----------
> >>=20
> >> -
> >>=20
> >>>>>>     1 file changed, 19 insertions(+), 11 deletions(-)
> >>>>>>=20
> >>>>>> diff --git a/drivers/thermal/qoriq_thermal.c
> >>>>>> b/drivers/thermal/qoriq_thermal.c index
> >>=20
> >> b806a0929459..53748c4a5be1
> >>=20
> >>>>>> 100644
> >>>>>> --- a/drivers/thermal/qoriq_thermal.c
> >>>>>> +++ b/drivers/thermal/qoriq_thermal.c
> >>>>>> @@ -31,7 +31,6 @@
> >>>>>>=20
> >>>>>>     #define TMR_DISABLE	0x0
> >>>>>>     #define TMR_ME		0x80000000
> >>>>>>     #define TMR_ALPF	0x0c000000
> >>>>>>=20
> >>>>>> -#define TMR_MSITE_ALL	GENMASK(15, 0)
> >>>>>>=20
> >>>>>>     #define REGS_TMTMIR	0x008	/* Temperature measurement
> >>>>>=20
> >>>>> interval Register */
> >>>>>=20
> >>>>>>     #define TMTMIR_DEFAULT	0x0000000f
> >>>>>>=20
> >>>>>> @@ -105,6 +104,11 @@ static int tmu_get_temp(struct
> >>>>>=20
> >>>>> thermal_zone_device *tz, int *temp)
> >>>>>=20
> >>>>>>     	 * within sensor range. TEMP is an 9 bit value representing
> >>>>>>     	 * temperature in KelVin.
> >>>>>>     	 */
> >>>>>>=20
> >>>>>> +
> >>>>>> +	regmap_read(qdata->regmap, REGS_TMR, &val);
> >>>>>> +	if (!(val & TMR_ME))
> >>>>>> +		return -EAGAIN;
> >>>>>=20
> >>>>> How is this change related to what is described in the changelog?
> >>>>=20
> >>>> devm_thermal_zone_of_sensor_register will invoke get temp, since we
> >>>> reverted the 45038e03d633 did, we need to check TMR_ME to avoid
> >>>=20
> >>> return
> >>>=20
> >>>> invalid temperature.
> >>>>=20
> >>>   From a higher perspective if the sensor won't be enabled, then the
> >>>=20
> >>> thermal zone should not be registered, the get_temp won't happen on a
> >>> disabled sensor and this test won't be necessary, no ?
> >=20
> > After thinking more, I'd prefer current logic.
> >=20
> > We rely on devm_thermal_of_zone_register's return value to know
> > whether there is a valid zone, then set sites bit, and after collected
> > all site bits, we enable the thermal IP.
> >=20
> > If move the enabling thermal IP before devm_thermal_of_zone_register,
> > We need check dtb thermal zone, to know which zone is valid for current
> > thermal IP. This would complicate the design.
> >=20
> > So just checking the enabling bit in get temperature would be much
> > simpler, and there just a small window before enabling thermal IP.
>=20
> If the thermal zone is not described, then the thermal zone won't be
> created as it fails with -ENODEV and thus get_temp won't be called on a
> disabled site, right?

That's not what the problem is. It's about zones that *will* be created -=20
since the driver only knows that a thermal zone isn't described in the devi=
ce=20
tree after it fails registering, it can't enable the site *before* the zone=
=20
gets registered - so it happens afterwards. That's why it needs this check =
to=20
not return a bogus initial value before the site gets actually enabled late=
r=20
in qoriq_tmu_register_tmu_zone.

> Having test in the get_temp() ops is usually the sign there is something
> wrong with the driver initialization.

I've sent a patch that solved this exact problem back in 2021 by checking=20
whether a zone is described first with thermal_zone_of_get_sensor_id, but i=
t=20
was sitting out there ignored long enough that the function got removed fro=
m=20
the kernel in 5d10f480f77b and I'm not exactly sure how to solve it cleanly=
=20
without getting it back. Without a replacement, what Peng did seems like th=
e=20
only way to not reintroduce the problem 45038e03d633 was supposed to fix.

The patch: https://lore.kernel.org/linux-pm/20220301033402.415445-1-sebasti=
an.krzyszkowiak@puri.sm/

Questions on how to proceed further: https://lore.kernel.org/linux-pm/
5800115.iIbC2pHGDl@pliszka/

Would be nice to get this finally resolved, the mainline TMU driver has bee=
n=20
completely unreliable on i.MX8MQ for years now.

Thanks,
Sebastian


