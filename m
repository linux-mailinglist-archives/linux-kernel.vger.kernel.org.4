Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B4A6CF4A3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 22:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjC2Uqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 16:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC2Uqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 16:46:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868B81985
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 13:46:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1phcgk-0001Sl-2y; Wed, 29 Mar 2023 22:46:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phcgj-007cAT-7l; Wed, 29 Mar 2023 22:46:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1phcgi-0091Df-FO; Wed, 29 Mar 2023 22:46:32 +0200
Date:   Wed, 29 Mar 2023 22:46:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-clk@vger.kernel.org, kernel@pengutronix.de,
        linux-doc@vger.kernel.org
Subject: [PATCH v4] clk: expand clk_ignore_unused mechanism to keep only a
 few clks on
Message-ID: <20230329204632.lsiiqf42hrwmn6xm@pengutronix.de>
References: <20221026151812.1042052-1-u.kleine-koenig@pengutronix.de>
 <4d8d412a33a7d63f2ffe6a13194375ed.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="niaklppuzj2g3fmf"
Content-Disposition: inline
In-Reply-To: <4d8d412a33a7d63f2ffe6a13194375ed.sboyd@kernel.org>
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


--niaklppuzj2g3fmf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Allow to pass an integer n that results in only keeping n unused clocks
enabled.

This helps to debug the problem if you only know that clk_ignore_unused
helps but you have no clue yet which clock is the culprit.

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
---
Hello Stephen,

On Wed, Mar 29, 2023 at 12:49:19PM -0700, Stephen Boyd wrote:
> Quoting Uwe Kleine-K=F6nig (2022-10-26 08:18:12)
> >  Documentation/driver-api/clk.rst |  4 +++-
>=20
> No update to Documentation/admin-guide/kernel-parameters.txt?

Fair request. I mentioned it there that you can assign an integer but
refer to Documentation/driver-api/clk.rst for the details.=20

> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index c3c3f8c07258..356119a7e5fe 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > [...]
> > @@ -1352,12 +1354,17 @@ static void __init clk_disable_unused_subtree(s=
truct clk_core *core)
> >          * back to .disable
> >          */
> >         if (clk_core_is_enabled(core)) {
> > -               trace_clk_disable(core);
> > -               if (core->ops->disable_unused)
> > -                       core->ops->disable_unused(core->hw);
> > -               else if (core->ops->disable)
> > -                       core->ops->disable(core->hw);
> > -               trace_clk_disable_complete(core);
> > +               if (clk_unused_keep_on) {
> > +                       pr_warn("Keep unused clk \"%s\" on\n", core->na=
me);
> > +                       clk_unused_keep_on -=3D 1;
> > +               } else {
> > +                       trace_clk_disable(core);
>=20
> We have trace_clk_disable() here. Can you have this tracepoint print to
> the kernel log and watch over serial console? That would be faster than
> bisecting.

Well no, that doesn't work for all the problems where
clk_ignore_unused=3D7 could be useful. Consider that e.g. you know that
eth0 is broken, but with clk_ignore_unused is works. So one of the (say)
25 nominally unused clks are required for eth0. But it's not possible to
test the network after each of the 25 clk_disable()s. Unless I'm missing
something and you can hook a userspace action on a trace line?!

> > +                       if (core->ops->disable_unused)
> > +                               core->ops->disable_unused(core->hw);
> > +                       else if (core->ops->disable)
> > +                               core->ops->disable(core->hw);
> > +                       trace_clk_disable_complete(core);
> > +               }
> >         }
> > =20
> >  unlock_out:
> > @@ -1369,9 +1376,17 @@ static void __init clk_disable_unused_subtree(st=
ruct clk_core *core)
> >  }
> > =20
> >  static bool clk_ignore_unused __initdata;
> > -static int __init clk_ignore_unused_setup(char *__unused)
> > +static int __init clk_ignore_unused_setup(char *keep)
> >  {
> > -       clk_ignore_unused =3D true;
> > +       if (*keep =3D=3D '=3D') {
> > +               int ret;
> > +
> > +               ret =3D kstrtouint(keep + 1, 0, &clk_unused_keep_on);
> > +               if (ret < 0)
>=20
> Could omit 'ret' and just have if (kstrtouint(..))

I don't feel strong, but I think having that on two lines is easier to
read. So I kept it as is, but if you insist, I can change.

> > +                       pr_err("Warning: failed to parse clk_ignore_unu=
sed parameter, ignoring");
>=20
> Missing newline on printk.

fixed.

Best regards
Uwe

 .../admin-guide/kernel-parameters.txt         |  6 ++--
 Documentation/driver-api/clk.rst              |  4 ++-
 drivers/clk/clk.c                             | 33 ++++++++++++++-----
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index 6221a1d057dd..1a378fe94e48 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -600,8 +600,10 @@
 			force such clocks to be always-on nor does it reserve
 			those clocks in any way. This parameter is useful for
 			debug and development, but should not be needed on a
-			platform with proper driver support.  For more
-			information, see Documentation/driver-api/clk.rst.
+			platform with proper driver support.
+			It can take a value (e.g. clk_ignore_unused=3D7), to only
+			disable some clks. For more information, see
+			Documentation/driver-api/clk.rst.
=20
 	clock=3D		[BUGS=3DX86-32, HW] gettimeofday clocksource override.
 			[Deprecated]
diff --git a/Documentation/driver-api/clk.rst b/Documentation/driver-api/cl=
k.rst
index 3cad45d14187..65ae7c3e2b33 100644
--- a/Documentation/driver-api/clk.rst
+++ b/Documentation/driver-api/clk.rst
@@ -259,7 +259,9 @@ the disabling means that the driver will remain functio=
nal while the issues
 are sorted out.
=20
 To bypass this disabling, include "clk_ignore_unused" in the bootargs to t=
he
-kernel.
+kernel. If you pass "clk_ignore_unused=3Dn" (where n is an integer) the fi=
rst n
+found clocks are not disabled which can be useful for bisecting over the u=
nused
+clks if you don't know yet which of them is reponsible for your problem.
=20
 Locking
 =3D=3D=3D=3D=3D=3D=3D
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index ae07685c7588..87f605a4f791 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1343,6 +1343,8 @@ static void __init clk_unprepare_unused_subtree(struc=
t clk_core *core)
 	clk_pm_runtime_put(core);
 }
=20
+static unsigned clk_unused_keep_on __initdata;
+
 static void __init clk_disable_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
@@ -1373,12 +1375,17 @@ static void __init clk_disable_unused_subtree(struc=
t clk_core *core)
 	 * back to .disable
 	 */
 	if (clk_core_is_enabled(core)) {
-		trace_clk_disable(core);
-		if (core->ops->disable_unused)
-			core->ops->disable_unused(core->hw);
-		else if (core->ops->disable)
-			core->ops->disable(core->hw);
-		trace_clk_disable_complete(core);
+		if (clk_unused_keep_on) {
+			pr_warn("Keep unused clk \"%s\" on\n", core->name);
+			clk_unused_keep_on -=3D 1;
+		} else {
+			trace_clk_disable(core);
+			if (core->ops->disable_unused)
+				core->ops->disable_unused(core->hw);
+			else if (core->ops->disable)
+				core->ops->disable(core->hw);
+			trace_clk_disable_complete(core);
+		}
 	}
=20
 unlock_out:
@@ -1390,9 +1397,17 @@ static void __init clk_disable_unused_subtree(struct=
 clk_core *core)
 }
=20
 static bool clk_ignore_unused __initdata;
-static int __init clk_ignore_unused_setup(char *__unused)
+static int __init clk_ignore_unused_setup(char *keep)
 {
-	clk_ignore_unused =3D true;
+	if (*keep =3D=3D '=3D') {
+		int ret;
+
+		ret =3D kstrtouint(keep + 1, 0, &clk_unused_keep_on);
+		if (ret < 0)
+			pr_err("Warning: failed to parse clk_ignore_unused parameter, ignoring\=
n");
+	} else {
+		clk_ignore_unused =3D true;
+	}
 	return 1;
 }
 __setup("clk_ignore_unused", clk_ignore_unused_setup);
@@ -1404,6 +1419,8 @@ static int __init clk_disable_unused(void)
 	if (clk_ignore_unused) {
 		pr_warn("clk: Not disabling unused clocks\n");
 		return 0;
+	} else if (clk_unused_keep_on) {
+		pr_warn("clk: Not disabling %u unused clocks\n", clk_unused_keep_on);
 	}
=20
 	clk_prepare_lock();
--=20
2.39.2

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--niaklppuzj2g3fmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQko6cACgkQj4D7WH0S
/k5TYwgAqGuYkNFtvYJovZ6o9tSRp05aqydeJAKq3upsG2d1ZPzoGbQR3Cxe3RZ4
tH2tK6nKDrUz37afULhFyLV8uzuwhjszoOmQHfoLmZOYrLkNcIF/JqXhNQAwALij
mCJlQXJ4IoIqrPn1QjD3sfZjagpBzDjkzWOB442+FZ9ZoCvkJptHR57zs4H9QbY7
wgpNKf24tacMupg3gfZvAxP/pRxsvuW6NionrBk/Og7yVzxTQu7IuIWcuJNmVt5w
3dtwuesmpEFzofdREuxrx+H+BO4+Yiri2cvAr6krtqX7rvStU0bc6gtOei1a4gtt
BqGrsd18aLvNDcm/8dVDUoYWjzsj/A==
=ljCv
-----END PGP SIGNATURE-----

--niaklppuzj2g3fmf--
