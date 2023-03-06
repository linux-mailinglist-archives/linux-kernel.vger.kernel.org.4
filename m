Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B5D6AB9F7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjCFJfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjCFJff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:35:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2E0BB9A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:35:34 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ7Fe-0002CZ-NM; Mon, 06 Mar 2023 10:35:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ7Fd-002DDT-NV; Mon, 06 Mar 2023 10:35:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ7Fc-002cuf-Ph; Mon, 06 Mar 2023 10:35:24 +0100
Date:   Mon, 6 Mar 2023 10:35:24 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, pavel@ucw.cz,
        lee@kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Eckert.Florian@googlemail.com
Subject: Re: [PATCH v7 2/2] trigger: ledtrig-tty: add additional modes
Message-ID: <20230306093524.amm7o4ppa7gon4ew@pengutronix.de>
References: <20230222083335.847655-1-fe@dev.tdt.de>
 <20230222083335.847655-3-fe@dev.tdt.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="svip3mvpinfoukkq"
Content-Disposition: inline
In-Reply-To: <20230222083335.847655-3-fe@dev.tdt.de>
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


--svip3mvpinfoukkq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2023 at 09:33:35AM +0100, Florian Eckert wrote:
> Add additional modes to trigger the selected LED.
> The following modes are supported:
>=20
> Tx/Rx:	Flash LED on data transmission (default)
> CTS:	DCE Ready to accept data from the DTE.
> DSR:	DCE is ready to receive and send data.
> CAR:	DCE is receiving a carrier from a remote DTE.
> RNG:	DCE has detected an incoming ring signal.
>=20
> The mode can be changed for example with the following command:
> echo "CTS" > /sys/class/leds/<led>/mode
>=20
> This would turn on the LED, when the DTE(modem) signals the DCE that it
> is ready to accept data.
>=20
> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> ---
>  .../ABI/testing/sysfs-class-led-trigger-tty   |  17 ++
>  drivers/leds/trigger/ledtrig-tty.c            | 145 ++++++++++++++++--
>  2 files changed, 147 insertions(+), 15 deletions(-)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-tty b/Docu=
mentation/ABI/testing/sysfs-class-led-trigger-tty
> index 2bf6b24e781b..1c28e6c61d19 100644
> --- a/Documentation/ABI/testing/sysfs-class-led-trigger-tty
> +++ b/Documentation/ABI/testing/sysfs-class-led-trigger-tty
> @@ -4,3 +4,20 @@ KernelVersion:	5.10
>  Contact:	linux-leds@vger.kernel.org
>  Description:
>  		Specifies the tty device name of the triggering tty
> +
> +What:		/sys/class/leds/<led>/mode
> +Date:		January 2023
> +KernelVersion:	6.3
> +Description:
> +		Specifies the operating to trigger the LED.
> +		The following operating modes are supported:
> +
> +		* Tx/Rx: Flash LED on data transmission (default)
> +		* CTS:   DCE Ready to accept data from the DTE.
> +		  LED on if line is high.
> +		* DSR:   DCE is ready to receive and send data.
> +		  LED on if line is high.
> +		* CAR:   DCE has detected a carrier from a remote DTE.
> +		  LED on if line is high.
> +		* RNG:   DCE has detected an incoming ring signal.
> +		  LED on if line is high.

Something I (still) don't like about this approach is that you cannot
make the LED flash on TX only (or CAR and DSR). Something like:

	led=3D/sys/class/leds/<led>/
	echo 1 > $led/TX
	echo 0 > $led/RX
	echo 1 > $led/CAR

would be a more flexible and IMHO nicer interface. (Maybe with improved
file names.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--svip3mvpinfoukkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQFs9kACgkQwfwUeK3K
7An5+gf8CoSOdxVO4N/QvSBqybrroQFb5PRh/T6Ud7r/5xd6UhmJjbGZHbWpyvaA
aWBySQuXPGxh9hlnb57c2BI0q5/hHnpTl8yMy7tPg3pYKGNhVHi+O7b+74szedj1
IGYfPP16ViEdVlz1nkPLtUNzJd0817jw6nzCQBuFmoiPK3nXyb2LCznYSVWYLcGR
Y85+HG1NOLOAiGYcXM6qhcC5/WUOhxhV78Ue1Kuwn81FMTYnScj2lYQ4eHYX63nq
1p1IabLzorNtVKhs4FMce86+SdpBM2m5lcmnJJCAV/m7KFQnBGe9faMAXC4avztb
Ts4+Uqip8Dcur3EyByxXbkdGmZwtLA==
=yTDj
-----END PGP SIGNATURE-----

--svip3mvpinfoukkq--
