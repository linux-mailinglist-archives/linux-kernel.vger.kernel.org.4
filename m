Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538986B0F3A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 17:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjCHQwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 11:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjCHQwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 11:52:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD17CB641
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:52:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZx1J-0000QS-Km; Wed, 08 Mar 2023 17:52:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZx1G-002l4f-Vd; Wed, 08 Mar 2023 17:52:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZx1G-003Kw8-8O; Wed, 08 Mar 2023 17:52:02 +0100
Date:   Wed, 8 Mar 2023 17:52:02 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     George Stark <GNStark@sberdevices.ru>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v1] Revert "pwm: Clear chip_data in pwm_put()"
Message-ID: <20230308165202.gaeziqdncbkeo5l6@pengutronix.de>
References: <20230307210014.1380102-1-gnstark@sberdevices.ru>
 <20230307212744.rx2julmzxe7nvhvr@pengutronix.de>
 <cc73a82d-89fa-1edf-650a-a1a3824cc791@sberdevices.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ugs5p22gnvewe6b7"
Content-Disposition: inline
In-Reply-To: <cc73a82d-89fa-1edf-650a-a1a3824cc791@sberdevices.ru>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ugs5p22gnvewe6b7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello George,

On Wed, Mar 08, 2023 at 12:16:00PM +0000, George Stark wrote:
> On 3/8/23 00:28, Uwe Kleine-K=F6nig wrote:
> > If you ask me, better drop pwm_set_chip_data() completely. It adds no
> > useful value. It's just a variant of driver data and using both
> > complicates the driver and probably fragments memory allocations. Also
> > the sematic of driver data is better known as it's the same for all
> > subsystems.
> >
> > Do you use the capture functionality? In my eyes the capture part of the
> > pwm subsystem is very alien. Only a small subset of the hardware
> > supports this and the counter framework should be better suited for such
> > tasks.
> I don't use pwm-sti driver. I update meson pwm driver for new chips
> and when started using pwm_set_chip_data in probe I was very surprised th=
at
> my data is lost after sysfs export/unexport calls. Then I found the=20
> patch and
> checked other drivers for similar usecases.

OK.

> Probably you're right about dropping pwm_set_chip_data.

If you want to tackle that, you might want to take

	https://lore.kernel.org/all/20210504132537.62072-2-u.kleine-koenig@pengutr=
onix.de/

into account. (Both to reuse this patch to prepare pwm-berlin for
dropping pwm_set_chip_data and to be prepared that back then Thierry
opposed to the idea.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ugs5p22gnvewe6b7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmQIvS4ACgkQwfwUeK3K
7Aku+Qf/QHg35UuTpxFLWrJ9E9/Y+2/XcUMIrE+hHqf7QGTjIgx1KbQskTjF189q
CkGAUPB4gCjavW+Zcx62RkN/lFHVQVsf38k9u3uanNzxLZcuxGD/spjC7zcKFYTw
3Noh5AwTGPR5QESVxMSFEqSJ18xO53oKdd4T3WErrPKVZgpzlvR+4TZA8AfODRcj
etfnLH8oBGJZDsIO2fEHTiYUgWdNEANL8xSRwzArIsIRGx+YTo/mEYHjUFd/wldS
zMxY+kzDJ0+u1foQ8RrFT2CLGIA0q2IbfvRyh/Jd+1ETei+KXtwxkfpIpW/Ugw4x
0wllBAFxf1eaocGP0cnlTBbUj+DblQ==
=d7MT
-----END PGP SIGNATURE-----

--ugs5p22gnvewe6b7--
