Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B568E7508A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 14:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjGLMsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 08:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjGLMsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 08:48:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80351712
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 05:48:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJZG7-0005XX-Sr; Wed, 12 Jul 2023 14:47:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJZG7-00DtMk-5J; Wed, 12 Jul 2023 14:47:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qJZG6-004Izs-G6; Wed, 12 Jul 2023 14:47:54 +0200
Date:   Wed, 12 Jul 2023 14:47:53 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Guiting Shen <aarongt.shen@gmail.com>,
        claudiu.beznea@microchip.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] pwm: atmel: Enable clk when pwm already enabled in
 bootloader
Message-ID: <20230712124753.5lcao4wubwiikh2m@pengutronix.de>
References: <20230711200905.6464-1-aarongt.shen@gmail.com>
 <20230711203017.cdfe2nrjx7lt25tm@pengutronix.de>
 <90830c22-0437-591e-cee0-67b16214bc55@gmail.com>
 <ZK6dL84DsQDhsFWl@orome>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gockmt5y3tgnf4m7"
Content-Disposition: inline
In-Reply-To: <ZK6dL84DsQDhsFWl@orome>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gockmt5y3tgnf4m7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 02:31:43PM +0200, Thierry Reding wrote:
> On Wed, Jul 12, 2023 at 09:45:08AM +0800, Guiting Shen wrote:
> > On Wed, Jul 12, 2023 at 04:30:17AM GMT+8, Uwe Kleine-K=F6nig wrote:
> > > Hello,
> > >=20
> > > On Wed, Jul 12, 2023 at 04:09:05AM +0800, Guiting Shen wrote:
> > >> +static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_=
pwm)
> > >> +{
> > >> +	unsigned int i;
> > >> +	int err;
> > >> +	u32 sr;
> > >> +
> > >> +	sr =3D atmel_pwm_readl(atmel_pwm, PWM_SR);
> > >> +	if (!sr)
> > >> +		return 0;
> > >> +
> > >> +	for (i =3D 0; i < atmel_pwm->chip.npwm; i++) {
> > >> +		if (!(sr & (1 << i)))
> > >> +			continue;
> > >> +
> > >> +		err =3D clk_enable(atmel_pwm->clk);
> > >> +		if (err) {
> > >> +			dev_err(atmel_pwm->chip.dev,
> > >> +				"failed to enable clock: %pe\n", ERR_PTR(err));
> > >=20
> > > Here you leak possibly a few enables. While it's not likely that the
> > > (say) third enable goes wrong, it's also not that hard to handle?!
> >=20
> > The driver used the enable_count member of struct clk_core to count the
> > PWM channels(4 channels). It will enable hardware clock only when one of
> > the PWM channels becomed on from all PWM channels off which maybe return
> > error. And in second/third/fourth times to clk_enable(), it just
> > increased the enable_count of struct clk_core which would never return
> > error.
> >=20
> > It maybe confused at first time to view the code.
> > Do it need to add something like that: ?
> >=20
> > for (i =3D 0; i < atmel_pwm->chip.npwm; i++) {
> > 	if (!(sr & (1 << i)))
> > 		continue;
> >=20
> > 	err =3D clk_enable(atmel_pwm->clk);
> > 	if (err) {
> > 		dev_err(atmel_pwm->chip.dev,
> > 			"failed to enable clock: %pe\n", ERR_PTR(err));
> >=20
> > 		for (i =3D 0; i < cnt; i++)
> > 			clk_disable(atmel_pwm->clk);
> > 		return err;
> > 	}
> > 	cnt++;
>=20
> You can also achieve this by decrementing i back to zero, that way you
> avoid the additional variable and you get a more natural unwinding of
> what you did before.
>=20
> So something like:
>=20
> 	while (i--)
> 		clk_disable(atmel_pwm->clk);

You'd need something like:

 	while (i--) {
		if (!(sr & (1 << i)))
			continue;

 		clk_disable(atmel_pwm->clk);
	}

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--gockmt5y3tgnf4m7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmSuoPkACgkQj4D7WH0S
/k48zwf/QkOmJBAzO28DukPhPXkCh/AkYOZDa+uISSzN+XA3m6CYtnvR8Oc2GLyW
gg+MvfQGzbJezgfFP9ONAxfqvh7pP4sjAUtw0/hD9bxDKI74DBxxPHllO40xh6Cb
E2Scr6L6gzUFeaRfgGtZQ7oCD7kLBn5yI4T7lsqS3achEaY0wVTBRb8CLYTqZaBM
hUw49m+3cUXVUIaT7u9EHRCV/IJPiDqAhoPKp1HpIOpOIwnS8dd0DXvIDmhGg5uH
x8HhBdWZFVozLVwOR8/Ua28/EVQSZyyKkuXrAvvOljx5iJp8tzIgXR9gvyoGpu8S
gUVsjwWoPq/LpXGkLmoP2bBcu+FM/g==
=VP4V
-----END PGP SIGNATURE-----

--gockmt5y3tgnf4m7--
