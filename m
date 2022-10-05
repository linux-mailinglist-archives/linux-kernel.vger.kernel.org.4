Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230025F5041
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJEHT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJEHTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:19:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522F311448
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 00:19:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ofyh3-0001Rh-T0; Wed, 05 Oct 2022 09:19:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ofyh2-004iJ7-GG; Wed, 05 Oct 2022 09:19:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ofyh0-005hw8-4a; Wed, 05 Oct 2022 09:19:46 +0200
Date:   Wed, 5 Oct 2022 09:19:46 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, kernel@pengutronix.de,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] watchdog: Add tracing events for the most usual
 watchdog events
Message-ID: <20221005071946.blttrgv2s5amnrrj@pengutronix.de>
References: <20221004091950.3419662-1-u.kleine-koenig@pengutronix.de>
 <20221004185146.5d4419ba@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="onluzhifnupekgas"
Content-Disposition: inline
In-Reply-To: <20221004185146.5d4419ba@gandalf.local.home>
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


--onluzhifnupekgas
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 04, 2022 at 06:51:46PM -0400, Steven Rostedt wrote:
> On Tue,  4 Oct 2022 11:19:49 +0200
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > +DEFINE_EVENT(watchdog_template, watchdog_start,
> > +	TP_PROTO(struct watchdog_device *wdd, int err),
> > +	TP_ARGS(wdd, err));
> > +
> > +TRACE_EVENT(watchdog_set_timeout,
> > +
> > +	TP_PROTO(struct watchdog_device *wdd, unsigned int timeout, int err),
> > +
> > +	TP_ARGS(wdd, timeout, err),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(int, id)
> > +		__field(unsigned int, timeout)
> > +		__field(int, err)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->id =3D wdd->id;
> > +		__entry->timeout =3D timeout;
> > +		__entry->err =3D err;
> > +	),
> > +
> > +	TP_printk("watchdog%d timeout=3D%u err=3D%d", __entry->id, __entry->t=
imeout, __entry->err)
> > +);
>=20
> Nit, but I would probably put the above TRACE_EVENT() below the two
> DEFINE_EVENT()s below. That way we have all the DEFINE_EVENT()s for a
> specific DECLARE_EVENT_CLASS() together. Otherwise people may get confuse=
d.

I thought about that, too. The argument for the order I chose is that
having start at the start and stop at the end is also intuitive.

But I don't care much and would let the watchdog guys decide what they
prefer.

@Wim+Guenter: Feel free to reorder at application time or ask for a v3
if this v2 doesn't fit your preference.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--onluzhifnupekgas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmM9MA8ACgkQwfwUeK3K
7AmGmggAhu24SwVndLMAH9hud/53KpV/1cjHvZTeu26vCFlSb3CyyZ6YZ1IWPWBA
+4udQ4iYxhu/6vSxjHaZHMEuFQWcDw2JbWiMcntgwrO8F3OEmu4JByV8EzYENfrD
g15qyeVPh8li/hIamDL6t2p7wUsa3WeA4TIJvwC71aSnP3f6GuaUMrEjU6DRgb5J
4f5gyShTNY1CUhiZ1fv3N2E2BvAxDMgm5WJBvjgismmg++HoRopRtPJD9sNKPspX
K4yq4RUPXDtq/VFncKrUZAuBgSd9XN1YNnUwBZFFW79/qrpevyWMDy58JDjpE29C
Sv4gqDyNvSuCeWy+Dp8D5YhxkMNRMg==
=mPaQ
-----END PGP SIGNATURE-----

--onluzhifnupekgas--
