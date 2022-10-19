Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF76603A9C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 09:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJSH0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 03:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJSH0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 03:26:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617665AC74
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 00:26:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3T6-00049x-J2; Wed, 19 Oct 2022 09:26:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3T4-0003wz-E9; Wed, 19 Oct 2022 09:26:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ol3T3-00916N-M6; Wed, 19 Oct 2022 09:26:21 +0200
Date:   Wed, 19 Oct 2022 09:26:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de,
        thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sebastian.reichel@collabora.com,
        wxt@rock-chips.com, kever.yang@rock-chips.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/2] ARM: dts: rk3288: add the interrupts property
 for PWM
Message-ID: <20221019072621.lh5hcznggbcscihf@pengutronix.de>
References: <6eba6c10-9c96-b40f-937a-e02d43b04cd7@gmail.com>
 <7ae39c9c-8424-8b65-ac09-c0e87f3b0f01@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="egf4vu67dggq4mpk"
Content-Disposition: inline
In-Reply-To: <7ae39c9c-8424-8b65-ac09-c0e87f3b0f01@arm.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--egf4vu67dggq4mpk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 29, 2022 at 04:50:43PM +0100, Robin Murphy wrote:
> On 2022-09-29 15:04, Johan Jonker wrote:
> > The Rockchip rk3288 SoC has 4-built-in PWM channels.
> >=20
> > Configurable to operate in capture mode.
> > Measures the high/low polarity effective cycles of this input waveform
> > Generates a single interrupt at the transition of input waveform polari=
ty
> >=20
> > Configurable to operate in continuous mode or one-shot mode.
> > One-shot operation will produce N + 1 periods of the waveform,
> > where N is the repeat counter value, and generates a single interrupt at
> > the end of operation.
> > Continuous mode generates the waveform continuously and
> > do not generates any interrupts.
> >=20
> > Add interrupts property to rk3288 PWM nodes.
>=20
> As far as I can make out from the TRM, these are only valid when
> GRF_SOC_CON2[0] =3D 0, otherwise it's in "new" RK_PWM mode using SPI 78 f=
or
> all channels. Which apparently will be the case for anyone using upstream
> U-Boot:
>=20
> https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/mach-rockchip=
/rk3288/rk3288.c#L83

Huh, so it depends on a (software) setting which irqs are in use? So the
patch isn't correct as is, but I have no idea how to make it right.
Should we rely on the bootloader to fixup the dtb correctly?

Anyhow, I'm marking the patch as 'changes-requested' in our patchwork
instance.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--egf4vu67dggq4mpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNPppoACgkQwfwUeK3K
7Akn2wf9E1mkjcU/X67/FHOeTDj1DxRQnT2HY0ff5ncZoX/knkINO0zn2zGjIGF0
UDiwKP5KkEFkWGPkn1PZ7vnTRTeZelBL8O1TIqlpWHC9peH2gOEMSdUCcbE2e3aA
MaErc+U4m9roSDtFnYkLFHudpANRgB545KscxYZaKR82ONFONQ57PaIiZuFnS2Fy
uqMhDbgZc5OhHiKRwAvSumOPXoJ1XuJ85lZmmAmZd5mSp/2QAvk+H1zHxisjqw/b
rQisgoJR1FVllkL6atrCQ1+Yml/9TtPZ05/y/pxbCVVdq69YgMpq0goABsX06Qx9
W9a9eJvn0vfzsQ6TZBDIShGvmiRiFw==
=DSeO
-----END PGP SIGNATURE-----

--egf4vu67dggq4mpk--
