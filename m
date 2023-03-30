Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3013F6CFB3C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjC3GGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjC3GGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:06:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0AD659A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:06:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1phlQE-0004b8-RX; Thu, 30 Mar 2023 08:06:06 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phlQD-007hMh-G9; Thu, 30 Mar 2023 08:06:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phlQC-0096gh-1A; Thu, 30 Mar 2023 08:06:04 +0200
Date:   Thu, 30 Mar 2023 08:06:01 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     linux-doc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4] clk: expand clk_ignore_unused mechanism to keep only
 a few clks on
Message-ID: <20230330060601.6mo7b4ecd2sk5mdr@pengutronix.de>
References: <20221026151812.1042052-1-u.kleine-koenig@pengutronix.de>
 <4d8d412a33a7d63f2ffe6a13194375ed.sboyd@kernel.org>
 <20230329204632.lsiiqf42hrwmn6xm@pengutronix.de>
 <2f4967f2a079e23b2b8a6013012c66e0.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hhy7jls2kpl3mst3"
Content-Disposition: inline
In-Reply-To: <2f4967f2a079e23b2b8a6013012c66e0.sboyd@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hhy7jls2kpl3mst3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2023 at 02:27:08PM -0700, Stephen Boyd wrote:
> Quoting Uwe Kleine-K=F6nig (2023-03-29 13:46:32)
> > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > index c3c3f8c07258..356119a7e5fe 100644
> > > > --- a/drivers/clk/clk.c
> > > > +++ b/drivers/clk/clk.c
> > > > [...]
> > > > @@ -1352,12 +1354,17 @@ static void __init clk_disable_unused_subtr=
ee(struct clk_core *core)
> > > >          * back to .disable
> > > >          */
> > > >         if (clk_core_is_enabled(core)) {
> > > > -               trace_clk_disable(core);
> > > > -               if (core->ops->disable_unused)
> > > > -                       core->ops->disable_unused(core->hw);
> > > > -               else if (core->ops->disable)
> > > > -                       core->ops->disable(core->hw);
> > > > -               trace_clk_disable_complete(core);
> > > > +               if (clk_unused_keep_on) {
> > > > +                       pr_warn("Keep unused clk \"%s\" on\n", core=
->name);
> > > > +                       clk_unused_keep_on -=3D 1;
> > > > +               } else {
> > > > +                       trace_clk_disable(core);
> > >=20
> > > We have trace_clk_disable() here. Can you have this tracepoint print =
to
> > > the kernel log and watch over serial console? That would be faster th=
an
> > > bisecting.
> >=20
> > Well no, that doesn't work for all the problems where
> > clk_ignore_unused=3D7 could be useful. Consider that e.g. you know that
> > eth0 is broken, but with clk_ignore_unused is works. So one of the (say)
> > 25 nominally unused clks are required for eth0. But it's not possible to
> > test the network after each of the 25 clk_disable()s. Unless I'm missing
> > something and you can hook a userspace action on a trace line?!
>=20
> In that case it sounds like you want to compile the kernel with the
> support for enabling clks from debugfs. Can you use that?

In some of the cases that might work. Unless for example the problem
makes the kernel fail to boot or the device is broken when the clk was
disabled and reenable doesn't help?!

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hhy7jls2kpl3mst3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQlJsgACgkQj4D7WH0S
/k60JQf+IxdY8eZUr5+sls0cy3Y9g0VVX/jGhbXhDTUMrbZz2Ktf0pfqHq5qnpHJ
zNf3Nwny9c1VfMjormWp9toqkcPazH9F37SiMzekVGZkEUoEcvNaEDuAatIfqFFT
vlxmq4/3AepjsqxiSfGb209ykKzA3xQ1dOm/s/GbvPaBb7FGNF34qRE2Bs+/7eZf
uqqpznFPgIy8F8krv/vl/SIqkrT8iMiYok/ezqtIF1MMgAA1ghropOf0GG9Lx5TS
MF7QT128U2RB9aRzSo/NLDB/epChjdJU4CFGONuWl0ZJh698tUgI1FGujZ7YTuP3
NItNfoJ7GuMgcmq/4hc3a0/9mUc01g==
=7eiI
-----END PGP SIGNATURE-----

--hhy7jls2kpl3mst3--
