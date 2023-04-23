Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3986EBDE2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 10:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjDWIIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 04:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjDWIIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 04:08:45 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948DF1729
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 01:08:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pqUln-0003lR-Hu; Sun, 23 Apr 2023 10:08:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pqUll-00DCWp-0g; Sun, 23 Apr 2023 10:08:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pqUlk-00FVtr-BJ; Sun, 23 Apr 2023 10:08:24 +0200
Date:   Sun, 23 Apr 2023 10:08:24 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] watchdog: s3c2410_wdt: Use Use
 devm_clk_get[_optional]_enabled() helpers
Message-ID: <20230423080824.7u2ydmmwk4jdbobm@pengutronix.de>
References: <20230304165653.2179835-1-linux@roeck-us.net>
 <20230306091048.mfrpexle24t6nwzy@pengutronix.de>
 <20230418065603.rzpiazzw4upitynt@pengutronix.de>
 <20230422112229.GA23896@www.linux-watchdog.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ii4dxdi23ndnywjj"
Content-Disposition: inline
In-Reply-To: <20230422112229.GA23896@www.linux-watchdog.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ii4dxdi23ndnywjj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 22, 2023 at 01:22:29PM +0200, Wim Van Sebroeck wrote:
> Hi Uwe,
>=20
> > Hello,
> >=20
> > On Mon, Mar 06, 2023 at 10:10:48AM +0100, Uwe Kleine-K=F6nig wrote:
> > > On Sat, Mar 04, 2023 at 08:56:52AM -0800, Guenter Roeck wrote:
> > > > The devm_clk_get[_optional]_enabled() helpers:
> > > >     - call devm_clk_get[_optional]()
> > > >     - call clk_prepare_enable() and register what is needed in orde=
r to
> > > >       call clk_disable_unprepare() when needed, as a managed resour=
ce.
> > > >=20
> > > > This simplifies the code and avoids the calls to clk_disable_unprep=
are().
> > > >=20
> > > > While at it, use dev_err_probe consistently, and use its return val=
ue
> > > > to return the error code.
> > > >=20
> > > > Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > >=20
> > > Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> >=20
> > This patch is in next now as b05a2e58c16c47f3d752b7db1714ef077e5b82d9.
> > My name occurs twice in the tag area, once it is mangled as
> >=20
> > 	Uwe Kleine-K=3DF6nig
> >=20
> > I would welcome fixing that (i.e. s/=3DF6/=F6/). When this commit is
> > touched, you can also do s/Use Use/Use/ in the Subject.
>=20
> Fixed.

Looking at the output of

	git range-diff b05a2e58c16c47f3d752b7db1714ef077e5b82d9...9b31b1ea125ca2e7=
34ae89badc0c3073b4445842

it looks good to me now.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ii4dxdi23ndnywjj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRE53cACgkQj4D7WH0S
/k51MQf9GQenHNrdE5Chnn1T7wY3+ZaqeHuRUzF2W9AeBfOx6mq5o86ClrpDoMWI
jKPWe/2g5KGNmjYbpmnVAaujc3XscQM8znRYmJE5m/vkKKbbWoaqgP+dVQPhIImz
+GitDdLYnV5E9nHqWuLB2ajsqsWcvI9bIcHsvsfGaD3BVKzwMaxjWAQoZtoZvG6V
jZ5dcFhcnmZgOMSwK2nCMj5SXHEYPczFTpDB00aXZ1hBLsxfEUUuz5iZeOfCCGrs
DqoNF3l29Lji9IsINO6BTnroOoKqVIckgaKGwB8HRFiF4CKhEX+6pOZT3tweu13b
4Lp2sZKvLM37rgHgChQMRaZ5hVXZXA==
=hwCc
-----END PGP SIGNATURE-----

--ii4dxdi23ndnywjj--
