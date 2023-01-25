Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E9C67B716
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235256AbjAYQna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjAYQn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:43:29 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93417568AA
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:43:28 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pKirm-0007UT-Gu; Wed, 25 Jan 2023 17:43:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pKirm-000NMW-7g; Wed, 25 Jan 2023 17:43:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pKirk-00FpCl-Fz; Wed, 25 Jan 2023 17:43:16 +0100
Date:   Wed, 25 Jan 2023 17:43:16 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Leif Middelschulte <leif.middelschulte@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Leif Middelschulte <Leif.Middelschulte@klsmartin.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: imx27: fix race condition .apply,.get_state
Message-ID: <20230125164316.wkoi4qfzbhna3h6g@pengutronix.de>
References: <20230125160142.586358-1-Leif.Middelschulte@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uvrf6a7ado3ttiqh"
Content-Disposition: inline
In-Reply-To: <20230125160142.586358-1-Leif.Middelschulte@gmail.com>
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


--uvrf6a7ado3ttiqh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Leif,

first of all thanks for the patch.

On Wed, Jan 25, 2023 at 05:01:42PM +0100, Leif Middelschulte wrote:
> From: Leif Middelschulte <Leif.Middelschulte@klsmartin.com>
>=20
> A race condition might occur, ultimately leading to switching off the
> PWM that is supposed to be turned on.
> The condition is more likely, if `CONFIG_PWM_DEBUG` is set and the PWM
> has been enabled before Linux is booted.

As I understand it there is no problem if PWM_DEBUG is off, isn't it?

> After writing some value to the register linked to the duty cycle
> (`MX3_PWMSAR`), the related debug function
> (`core.c:pwm_apply_state_debug`) reads back (`.get_state`)
> a wrong value (`0`) as the configured duty cycle. This value is stored
> as part of a temporary state variable that it subsequently reapplies
> to the PWM for testing purposes. Which, effectively, turns off the PWM.

I thought the thing is: Reading PWMSAR yields the duty_cycle that is
currently in use. Now if .apply() is called with a new value for PWMSAR
and immediately after that .get_state() reads out PWMSAR the previous
period (with the previous duty_cycle) probably isn't completed yet and
so the old value is read.

In this case it wouldn't always be 0 which is read. (Hmm, but with the
conversion we had about this issue, my theory sounds wrong?!)

Maybe instead of waiting in .apply() (which hurts active consumers),
only wait in .get_state() until MX3_PWMSR_FIFOAV drops to zero?

Apart from that, the markdown(?) style you use is unusual for kernel
commit logs and comments. I'd write:

	With CONFIG_PWM_DEBUG=3Dy after writing a value to the PWMSAR
	register in .apply(), the register is read in .get_state().
	Unless a period completed in the meantime, this read yields the
	previously used duty cycle configuration. As the PWM_DEBUG code
	applies the read out configuration for testing purposes this
	effectively undoes the intended effect by rewriting the previous
	hardware state.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--uvrf6a7ado3ttiqh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPRXCEACgkQwfwUeK3K
7AlQ4AgAmsfy5HdrI09lwL9J4CWmlIOxXCTTTv5sWiO06Uv/jUOQl02P1haQkrY6
CT2BYjJLTaTHJQcIWV5UQ9Ce6Zy2Z2F/Fssf06AWwRen561thW+YoNoMFnOQtCVN
fA1e4SzyWd+m7dTY0aDUuh7bBivtvd7mYU+Uuyc/zqkiMpMdgb0KJFM0PfwtfSZc
8LgOJDp4Ovt3cy3Vycs90v611HM2f8qigNu9ooIlqju2iLTXq7OxLBULUCUoMBQg
IF8Z8ymrR+1PMNNj2a9KkbSSLoSfk8KIORJUW/9UUpcbhPz8iGl7vb/wLMG7L9lQ
QCvIwYzWCyrDUzhWKqaIhaad+D9YnA==
=+hro
-----END PGP SIGNATURE-----

--uvrf6a7ado3ttiqh--
