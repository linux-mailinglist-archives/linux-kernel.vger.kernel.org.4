Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 590EA61FD06
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiKGSNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiKGSNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:13:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB5329C85
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 10:11:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1os6b3-00065f-Ia; Mon, 07 Nov 2022 19:11:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1os6b1-002uN5-8c; Mon, 07 Nov 2022 19:11:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1os6b1-00F1sJ-8Q; Mon, 07 Nov 2022 19:11:43 +0100
Date:   Mon, 7 Nov 2022 19:11:35 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     kernel@pengutronix.de, Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, cocci@inria.fr
Subject: [PATCH v2] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Message-ID: <20221107181135.tm2wmwiulepsyrmk@pengutronix.de>
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
 <28e17fb9-cec1-4a89-1492-cd3ece7a9487@inria.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="br76c7q2m6ekdpo6"
Content-Disposition: inline
In-Reply-To: <28e17fb9-cec1-4a89-1492-cd3ece7a9487@inria.fr>
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


--br76c7q2m6ekdpo6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalent to
the shorter devm_platform_ioremap_resource(pdev, index).

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
---
On Mon, Nov 07, 2022 at 08:45:38PM +0800, Julia Lawall wrote:
> On Mon, 7 Nov 2022, Uwe Kleine-K=F6nig wrote:
>=20
> > devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalent=
 to
> > the shorter devm_platform_ioremap_resource(pdev, index).
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Hello,
> >
> > a potential improvement is to check for invocations of
> > devm_platform_get_and_ioremap_resource() where the res parameter isn't
> > used afterwards, but my coccinelle foo isn't strong enough for that.
>=20
> ... when !=3D res
>=20
> I'm not sure where you wanted to put it though.

I tinkered a bit further and even succeeded to remove the declaration if
it's otherwise unused.

I failed to test the report mode, my spatch tells me some error about
python2?!

Best regards
Uwe

 .../api/devm_platform_ioremap_resource.cocci  | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resource.c=
occi

diff --git a/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci b/=
scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
new file mode 100644
index 000000000000..485dfa6ea0aa
--- /dev/null
+++ b/scripts/coccinelle/api/devm_platform_ioremap_resource.cocci
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Don't use devm_platform_get_and_ioremap_resource with NULL as third pa=
rameter
+// Confidence: High
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+@r1@
+position p;
+@@
+ devm_platform_ioremap_resource(...) {
+	...
+	devm_platform_get_and_ioremap_resource@p(...)
+	...
+ }
+
+@depends on patch@
+expression pdev,index;
+position p !=3D r1.p;
+@@
+
+-  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
++  devm_platform_ioremap_resource(pdev, index)
+
+@depends on patch@
+expression pdev,index;
+identifier res;
+type T;
+@@
+-  T res;
+   ... when !=3D res
+-  devm_platform_get_and_ioremap_resource(pdev, index, &res)
++  devm_platform_ioremap_resource(pdev, index)
+   ... when !=3D res
+
+@depends on patch@
+expression pdev,index;
+identifier res;
+@@
+
+-  devm_platform_get_and_ioremap_resource(pdev, index, &res)
++  devm_platform_ioremap_resource(pdev, index)
+   ... when !=3D res
+
+@r2 depends on !patch exists@
+expression pdev,index;
+position p;
+@@
+
+*  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
+
+@script:python depends on org@
+p << r2.p;
+@@
+
+cocci.print_main("WARNING opportunity for devm_platform_ioremap_resource",=
 p)
+
+@script:python depends on report@
+p << r2.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for devm_platform_=
ioremap_resource")
+
+@r3 depends on !patch exists@
+expression pdev,index;
+identifier res;
+position p;
+@@
+
+*  devm_platform_get_and_ioremap_resource@p(pdev, index, &res)
+   ... when !=3D res
+
+@script:python depends on org@
+p << r3.p;
+@@
+
+cocci.print_main("WARNING opportunity for devm_platform_ioremap_resource",=
 p)
+
+@script:python depends on report@
+p << r3.p;
+@@
+
+coccilib.report.print_report(p[0], "WARNING opportunity for devm_platform_=
ioremap_resource")
--=20
2.38.1


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--br76c7q2m6ekdpo6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNpSksACgkQwfwUeK3K
7AkVLgf/Rft3yyIkDXUecuNVqIMeOI150FeS5ugDchiUalYpbmdntH6DabihECa8
RvYGAuCfnvvmHeQzfPf0g4b2ysQaZcWqzLWnBoq33vuUMsea9jsz9cGuCwx1Csv5
9FgmNg7Iqg9fIpuiAoJaAWYmcU8ftjgqq4euXQQnp2i/Wucnwtyl8EoeSJ1DGAMI
mDSjEkYO/oAfIlWQJGXqbwf70JWrZqnyLTch86IuZPSQj0MOMj1tKHxcL9zxWUAY
/m/49N4jcK9yGL+F3gSAx5chSewiqkv8Ob1I5P2sbJNgZ3iKJoEM+yD5S6futd/g
AUHkYT/VvaLwJ1FEmda6p7m6qBYWfg==
=53Fs
-----END PGP SIGNATURE-----

--br76c7q2m6ekdpo6--
