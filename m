Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A3363436F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234206AbiKVSPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbiKVSO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:14:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2920B725F0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 10:14:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxXnC-0000br-SB; Tue, 22 Nov 2022 19:14:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxXnA-005u2M-LT; Tue, 22 Nov 2022 19:14:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oxXnA-000r1s-Pe; Tue, 22 Nov 2022 19:14:44 +0100
Date:   Tue, 22 Nov 2022 19:14:44 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 6/7] pwm: lpss: Add devm_pwm_lpss_probe() stub
Message-ID: <20221122181444.m74fa47ejp7nvgxj@pengutronix.de>
References: <20221117110806.65470-1-andriy.shevchenko@linux.intel.com>
 <20221117110806.65470-7-andriy.shevchenko@linux.intel.com>
 <20221122164703.e3z42rou7ivu3djv@pengutronix.de>
 <Y30IaslnbeKBkMhM@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3226vdxlzkg52b57"
Content-Disposition: inline
In-Reply-To: <Y30IaslnbeKBkMhM@smile.fi.intel.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3226vdxlzkg52b57
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Tue, Nov 22, 2022 at 07:35:38PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 22, 2022 at 05:47:03PM +0100, Uwe Kleine-K=F6nig wrote:
> > On Thu, Nov 17, 2022 at 01:08:05PM +0200, Andy Shevchenko wrote:
> > > In case the PWM LPSS module is not provided, allow users to be
> > > compiled with the help of the devm_pwm_lpss_probe() stub.
>=20
> ...
>=20
> > > +static inline
> > > +struct pwm_lpss_chip *devm_pwm_lpss_probe(struct device *dev, void _=
_iomem *base,
> > > +					  const struct pwm_lpss_boardinfo *info)
> > > +{
> > > +	return ERR_PTR(-ENODEV);
> > > +}
> > > +#endif	/* CONFIG_PWM_LPSS */
> >=20
> > Hmm, this is actually never used, because if
> > !IS_REACHABLE(CONFIG_PWM_LPSS), the only caller (that is added in patch
> > 7) has:
> >=20
> > 	if (!IS_REACHABLE(CONFIG_PWM_LPSS))
> > 		return 0;
> >=20
> > before devm_pwm_lpss_probe() is called.
> >=20
> > Not sure if it's safe to just drop this patch.
>=20
> How is it supposed to be compiled and linked then?

The compiler optimizes everything away after that return 0 and so
doesn't need that symbol at all.

I just tested compiling your series without patch #6, x86_64 allmodconfig +=
 PWM=3Dn.

nm doesn't report the need for devm_pwm_lpss_probe in
drivers/pinctrl/intel/pinctrl-intel.o.

The build isn't done yet, but I don't expect surprises.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3226vdxlzkg52b57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmN9EZEACgkQwfwUeK3K
7Ak9SAf8DRmODSMzUTDmQjfOqHL4+NhfOIoWfEnkga9JVZLhIw8tsY8oeac2xxA6
OzRR2oFShKuM1qu/ZNh5osbX+zQrUatamL6mWewELBC5ZInewwpUTrWcBa+fu8hx
0VjXZZeuxNyPVn0ebWN9LWG/5WtLYTMAykelXOkGjjXmGzix9ksSQIqTTzHpVBS0
3QISI90z7VN0MB2+zy5hX250xNaGOvrsMET5BLEecFRH7t9GhLzCu5CcuQ6c+FXm
pFDBXIPf6sSlCVLbg0yF9fOTNfbSV7iMtyb6qXBz7dqo5VhBr85b1WBSidHbEGJ4
3JQTpHDv62RtBfeVbJuLKv/jMgMiMQ==
=BukI
-----END PGP SIGNATURE-----

--3226vdxlzkg52b57--
