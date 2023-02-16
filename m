Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB20D699F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 22:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjBPVji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 16:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBPVjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 16:39:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9E237B7D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 13:39:36 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSlyW-0007Ml-Hr; Thu, 16 Feb 2023 22:39:32 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSlyT-005RIP-Rn; Thu, 16 Feb 2023 22:39:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pSlyU-0048nr-3p; Thu, 16 Feb 2023 22:39:30 +0100
Date:   Thu, 16 Feb 2023 22:39:27 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
Subject: Re: [PATCH v7 10/10] pwm: dwc: use clock rate in hz to avoid
 rounding issues
Message-ID: <20230216213927.r3lvjz6u7d62y4pb@pengutronix.de>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
 <20221223153820.404565-11-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="34k3w6qkj6kdp3fo"
Content-Disposition: inline
In-Reply-To: <20221223153820.404565-11-ben.dooks@sifive.com>
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


--34k3w6qkj6kdp3fo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2022 at 03:38:20PM +0000, Ben Dooks wrote:
> As noted, the clock-rate when not a nice multiple of ns is probably
> going to end up with inacurate caculations, as well as on a non pci

Given that such a non-nice ca*l*culation only happens in the of case
that is introduced here, it would be nice to move this patch before the
introduction of the of-support.

> system the rate may change (although we've not put a clock rate
> change notifier in this code yet) so we also add some quick checks
> of the rate when we do any calculations with it.

If the clk rate changes while the PWM is on, this modifies the output.
This is unfortunate and so it justifies adding a call to
clk_rate_exclusive_get() when the PWM is on.
=20
Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--34k3w6qkj6kdp3fo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmPuoo0ACgkQwfwUeK3K
7AnjJAf/TfmEsHSvOrldgzVkNeO4HUWZ0ZLQVbF7oiL/E0DY0RBYtUgx6dZZyWd1
zdLpaIIYUiCnB7sykaxWzuBg1koZ2+E98pv2dDAcivjRbBVz/nMrq3MriUoPHYg2
tkBldjmEGF1QPd8zmYQVZ4eMjVNOPIcUpGhd5xMsSvqOKF2Efvob7HZur8Chv2X0
MAcWb5aN+ksdr8PYtnJ7M/kTihKsBZAwgMzoTDh6yutYRCqKVgLFCvhOnYcmqLjZ
9DBDDkBUzmjpL//Hl2qKcxsw9MG8BmD351IhBSIPL7Ar/PE2ephOqSHzz2Zu8j5R
z4J05A+SpMbCnwbGaN9MOP6OMC4YQA==
=LTaH
-----END PGP SIGNATURE-----

--34k3w6qkj6kdp3fo--
