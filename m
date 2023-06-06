Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31047723B14
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbjFFIO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjFFIOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:14:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E93BE8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 01:14:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6Rpc-0001v4-Fw; Tue, 06 Jun 2023 10:14:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6RpZ-005Sh2-68; Tue, 06 Jun 2023 10:14:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1q6RpY-00BeAc-Gc; Tue, 06 Jun 2023 10:14:16 +0200
Date:   Tue, 6 Jun 2023 10:14:16 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     George Stark <gnstark@sberdevices.ru>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        kernel <kernel@sberdevices.ru>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "khilman@baylibre.com" <khilman@baylibre.com>
Subject: Re: [PATCH] pwm: meson: compute cnt register value in proper way
Message-ID: <20230606081416.j24ub2jjifbpv6ty@pengutronix.de>
References: <20230602103211.2199283-1-gnstark@sberdevices.ru>
 <bf2d2814-5881-0f42-8b62-89c043b66e22@gmail.com>
 <ed8f95d2-ef62-d91a-618c-402ba1c9d09f@sberdevices.ru>
 <bf7c71bf-4f04-0dd3-91e1-eb639b36e7d1@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n7xauynmripnisar"
Content-Disposition: inline
In-Reply-To: <bf7c71bf-4f04-0dd3-91e1-eb639b36e7d1@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n7xauynmripnisar
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 11:01:40PM +0200, Heiner Kallweit wrote:
> On 05.06.2023 09:11, George Stark wrote:
> > On 6/2/23 23:52, Heiner Kallweit wrote:
> >> On 02.06.2023 12:32, George Stark wrote:
> >>> According to the datasheet, the PWM high and low clock count values
> >>> should be set to at least one. Therefore, setting the clock count
> >>> register to 0 actually means 1 clock count.
> >>>
> >>> Signed-off-by: George Stark <GNStark@sberdevices.ru>
> >>> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> >>> ---
> >>> This patch is based on currently unmerged patch by Heiner Kallweit
> >>> https://lore.kernel.org/linux-amlogic/23fe625e-dc23-4db8-3dce-83167cd=
3b206@gmail.com
> >>> ---
> >>> diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
> >>> index 834acd7..57e7d9c 100644
> >>> --- a/drivers/pwm/pwm-meson.c
> >>> +++ b/drivers/pwm/pwm-meson.c
> >>> @@ -206,6 +206,11 @@
> >>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 channel->pre_div =3D pre_div;
> >>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 channel->hi =3D duty_cnt;
> >>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 channel->lo =3D cnt - duty_cnt;
> >>> +
> >>> +=A0=A0=A0=A0=A0=A0=A0 if (channel->hi)
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 channel->hi--;
> >>> +=A0=A0=A0=A0=A0=A0=A0 if (channel->lo)
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 channel->lo--;
> > Hello Heiner
> >=20
> > Thanks for review
> >> I'm not sure whether we should do this. duty_cnt and cnt are results
> >> of an integer division and therefore potentially rounded down.
> >> The chip-internal increment may help to compensate such rounding
> >> errors, so to say. With the proposed change we may end up with the
> >> effective period being shorter than the requested one.
> > Although chip-internal increment sometimes may help accidentally
> > there are cases when the increment ruins precise calculation in unexpec=
ted way.
> >=20
> > Here's our experience on meson a113l (meson-a1) with pwm driver based o=
n ccf:
> > we need to get pwm period as close as possible to 32768hz.
> > config pwm to period 1/32768 =3D 30517ns, duty 15258n
> > How driver calculates hi\lo regs:
> > rate =3D NSEC_PER_SEC * 0xffff / 30517 =3D ~2147Mhz
> > rate =3D clk_round_rate(rate) clk_round_rate selects fastest parent clo=
ck which is 64Mhz in our case then calculating hi\lo at last: period=3D mul=
_u64_u64_div_u64(rate, state->period, NSEC_PER_SEC); // 1953
> > duty=3D mul_u64_u64_div_u64(rate, state->duty_cycle, NSEC_PER_SEC); // =
976
> > channel->hi=3D duty;
> > channel->lo=3D period- duty;
> > with the internal increment we'll have real output (1953-976 + 1 + 976 =
+ 1) * 1 / 64Mhz =3D 32736.57Hz but we should have (1953-976 + 976) * 1 / 6=
4Mhz =3D 32770.09Hz
>=20
> Supposedly, depending on the prior rounding errors, something incrementin=
g,
> and sometimes not incrementing may provide the more precise result.
> Another source of error is shown your example, the duty cycle isn't 50%
> due to the rounding.
> Not sure however where there's any use case where such small deviations
> would cause problems. Therefore I don't have a strong opinion.

My strong opinion here is: .apply should implement the the best
round-down setting. That is it should pick the maximal period that isn't
bigger than the requested one, and for that period pick the maximal
duty_cycle that isn't bigger than the requested one.

I have some implementation ideas to allow consumers to want different
rounding, but for that to work the .apply functions should all round the
same way.

> > | And IIRC this should not happen.
> > Could you please explain why or point out doc/description where it's st=
ated?
> > If so we can add explicit check to prevent such a case
>=20
> I think I got this wrong. When checking where I got this information from
> I found the following in pwm_apply_state_debug():
>=20
> if (state->enabled && state->period < s2.period)
>   dev_warn(chip->dev,
>   ".apply is supposed to round down period (requested: %llu, applied: %ll=
u)\n",
>   state->period, s2.period);

pwm_apply_state_debug() also checks the above sketched rule.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--n7xauynmripnisar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmR+6tcACgkQj4D7WH0S
/k7mhwf/T9iexvNCwFiWsFUIdv5CU+Pb47RnRD2iVycfrVrRKqOc93X7URcoHprb
RDcRXa9gX+LGrAiAWQdaIslVho4X++oitiY2220a51s6/mSQv/uxyrmYIG8ZmIau
5CGgBE82puDbDo8bxzElS5IVgnFMLuKAJOPvaNPSOnhzfyDe6cANJdmz88MqXAIP
xFq/3BrcR65V8FTywCWubKZ3K5V5QmiHnq7rcdlbpfu7pWt3nfFAUyqm/W88q2PY
xNemL3ygE+G4ecajByZis7j+Ik2l1DtXLKKul8c4WUC6BFL1oXV2spHt17EvOLJ8
+dr8Lo+8vAociJO1ywXV4OUBHkpCcQ==
=/rRP
-----END PGP SIGNATURE-----

--n7xauynmripnisar--
