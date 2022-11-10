Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25262623C86
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiKJHV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKJHV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:21:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2522ED54
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:21:56 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot1sg-0008CK-SD; Thu, 10 Nov 2022 08:21:46 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot1se-003PCM-AB; Thu, 10 Nov 2022 08:21:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ot1se-00FaHm-Lv; Thu, 10 Nov 2022 08:21:44 +0100
Date:   Thu, 10 Nov 2022 08:21:44 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 3/6] pwm: lpss: Include headers we are direct user of
Message-ID: <20221110072144.2s37r52qcpi6utgh@pengutronix.de>
References: <20221108142226.63161-1-andriy.shevchenko@linux.intel.com>
 <20221108142226.63161-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kl3orhl5l6nepqs2"
Content-Disposition: inline
In-Reply-To: <20221108142226.63161-4-andriy.shevchenko@linux.intel.com>
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


--kl3orhl5l6nepqs2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Nov 08, 2022 at 04:22:23PM +0200, Andy Shevchenko wrote:
> For the sake of integrity, include headers we are direct user of.
>=20
> While at it, move the struct pwm_lpss_chip to be after
> the struct pwm_lpss_boardinfo as the former uses pointer
> to the latter.

That part is fine.

> Replace device.h with a forward declaration in order to improve
> the compilation time due to reducing overhead of device.h parsing
> with entire train of dependencies.

Together with "For the sake of integrity, include headers we are direct
user of." this makes an a bit schizophrenic impression on me. You add
<linux/types.h> because the file is a direct user of it, but you drop
<linux/device.h> despite being a direct user.

If you adapt the reasoning to something like:

Replace the inclusion of <linux/device.h> by a forward declaration of
struct device plus a (cheaper) #include of <linux/types.h> as
<linux/device.h> is an expensive include (measured in compiler effort).

I could better live with it. I would even split this into two patches
then. (i.e. move struct pwm_lpss_chip vs the include and forward change)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kl3orhl5l6nepqs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNspoUACgkQwfwUeK3K
7Al4jAf+KJNGvp8Rn+uVlNVAhxjiKuIbYR8EWHPnYLHmuS/aIZbajf5eWL/5mFVx
tVVxe6MgD/wKubSURgJqRfqhn+k+D3AzH/oegvru0QhE//qQ1liKwqsV/A+0CwGB
Aoue0nW3Fbt/psnD3j6t6J6o0Y7HDUkSYmFDelc9GZxtVlEXABLkUucXRjcSclWo
dRuVSFYYj+ggI79yMTdU8WpyijehVCKvTULeZSMXJiDR9IieJYikZyIHJuM3if4I
JXSiD6ihnTpLByKK2ppH1tQO6LlUrJvWWjUD0LIJofQqbEFRSEQ4dag8qf1iR7GV
HZKl/FYFmJdpIcO6Sxg/621RqQSj5Q==
=A+z8
-----END PGP SIGNATURE-----

--kl3orhl5l6nepqs2--
