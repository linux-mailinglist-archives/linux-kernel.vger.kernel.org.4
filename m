Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCB26D0CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjC3Rdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjC3Rdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:33:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C117EFA4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:33:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1phw9M-0002bv-87; Thu, 30 Mar 2023 19:33:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phw9L-007ohf-6b; Thu, 30 Mar 2023 19:33:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phw9K-009FWH-JA; Thu, 30 Mar 2023 19:33:22 +0200
Date:   Thu, 30 Mar 2023 19:33:19 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4] clk: expand clk_ignore_unused mechanism to keep only
 a few clks on
Message-ID: <20230330173319.x4w2yd2bbk5hy2hb@pengutronix.de>
References: <20221026151812.1042052-1-u.kleine-koenig@pengutronix.de>
 <4d8d412a33a7d63f2ffe6a13194375ed.sboyd@kernel.org>
 <20230329204632.lsiiqf42hrwmn6xm@pengutronix.de>
 <2f4967f2a079e23b2b8a6013012c66e0.sboyd@kernel.org>
 <20230330060601.6mo7b4ecd2sk5mdr@pengutronix.de>
 <20230330152617.6zj5llx5pf6mlv2t@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cfdydxwxw4zjvqxx"
Content-Disposition: inline
In-Reply-To: <20230330152617.6zj5llx5pf6mlv2t@mercury.elektranox.org>
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


--cfdydxwxw4zjvqxx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sebastian,

On Thu, Mar 30, 2023 at 05:26:17PM +0200, Sebastian Reichel wrote:
> > > In that case it sounds like you want to compile the kernel with the
> > > support for enabling clks from debugfs. Can you use that?
> >=20
> > In some of the cases that might work. Unless for example the problem
> > makes the kernel fail to boot or the device is broken when the clk was
> > disabled and reenable doesn't help?!
>=20
> I recently debugged a similar issue like this:
>=20
> 1. build kernel with CLOCK_ALLOW_WRITE_DEBUGFS
> 2. boot with clk_ignore_unused, so clocks stay enabled
> 3. disable clocks via sysfs:
>    echo 1 > /sys/kernel/debug/clk/${CLK}/clk_prepare_enable
>    echo 0 > /sys/kernel/debug/clk/${CLK}/clk_prepare_enable
> 4. check if peripheral is still ok
> 5. repeat step 3 with the next 'interesting' clock

Ah, that makes sense. Thanks.

With that I cannot imagine a scenario that I can only debug with
clk_ignore_unused=3Dn. So let's drop my patch.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cfdydxwxw4zjvqxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQlx94ACgkQj4D7WH0S
/k7cCAf+MHsYzxvenAAIdoLCJYxPpxjV5k6YCwYkEVtAY8G7zsNnkoXUH1dSS+Fd
nfIrOQWMRz/6V+Am+yVG/BKElQB3smN7jZ/DEpAXJWtV9naHWncQ0geMzg79RJ+8
TuabL605yjk41yc7J+IiP4EzhUv/ZeR+QggL7GK8IIRm8Mhaa33b/znCX9zjUViS
sSqs4jp2JO/DBnj37VO3GvUpr1xXHAq4nF0BPDL6UUvEMTNKf6uY0OTxtVgXtZIT
GJquOoCtzcMhXw71kB7DpE9bH0G0OPOKAXwM9PeS2nISflGDqsrE23QlL9MQjYSO
Ss73bBb1igE8VUBF/9qYlJ2RPr40Xg==
=OWZG
-----END PGP SIGNATURE-----

--cfdydxwxw4zjvqxx--
