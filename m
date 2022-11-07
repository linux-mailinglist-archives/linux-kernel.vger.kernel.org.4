Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EE361FF2D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbiKGUIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232672AbiKGUI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:08:28 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79E22CB
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 12:08:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1os8Pr-0004hl-2U; Mon, 07 Nov 2022 21:08:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1os8Po-002uxE-Hn; Mon, 07 Nov 2022 21:08:17 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1os8Po-00F2U1-Q7; Mon, 07 Nov 2022 21:08:16 +0100
Date:   Mon, 7 Nov 2022 21:08:15 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     cocci@inria.fr, Julia Lawall <Julia.Lawall@inria.fr>,
        kernel-janitors@vger.kernel.org,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [cocci] [PATCH] coccinelle: api: Don't use
 devm_platform_get_and_ioremap_resource with res==NULL
Message-ID: <20221107200815.u7hcwejileeabnct@pengutronix.de>
References: <20221107114702.15706-1-u.kleine-koenig@pengutronix.de>
 <bd13da2d-6d18-4f33-0987-a193e3c9b761@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2znbbrzwbbfnunan"
Content-Disposition: inline
In-Reply-To: <bd13da2d-6d18-4f33-0987-a193e3c9b761@web.de>
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


--2znbbrzwbbfnunan
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 07, 2022 at 08:00:33PM +0100, Markus Elfring wrote:
>=20
> > devm_platform_get_and_ioremap_resource(pdev, index, NULL) is equivalent=
 to
> > the shorter devm_platform_ioremap_resource(pdev, index).
> =E2=80=A6
> >  create mode 100644 scripts/coccinelle/api/devm_platform_ioremap_resour=
ce.cocci
> =E2=80=A6
> > +@depends on patch@
> > +expression pdev,index;
> > +position p !=3D r1.p;
>=20
>=20
> Why do you think that different source code positions would be required f=
or
> your transformation approach?

That is important that the implementation of
devm_platform_ioremap_resource isn't adapted.

> > +@@
> > +
> > +-  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
> > ++  devm_platform_ioremap_resource(pdev, index)
>=20
> I suggest to use the following SmPL code variant instead.
>=20
> -devm_platform_get_and_ioremap_resource@p
> +devm_platform_ioremap_resource
> =C2=A0(pdev, index
> - , NULL
> =C2=A0)

I don't care much, but IMHO my variant is easier to read. Might be
subjective, though.
=20
> > +@r2 depends on !patch exists@
> > +expression pdev,index;
> > +position p;
> > +@@
> > +
> > +*  devm_platform_get_and_ioremap_resource@p(pdev, index, NULL)
>=20
>=20
> I doubt that the usage of the SmPL asterisk is appropriate for the operat=
ion
> modes =E2=80=9Corg=E2=80=9D and =E2=80=9Creport=E2=80=9D.

I have no idea about org and report modes. When I try these I get a
python2 error message:

	uwe@taurus:~/gsrc/linux$ make coccicheck
	You have not explicitly specified the mode to use. Using default "report" =
mode.
	Available modes are the following: patch, report, context, org, chain
	You can specify the mode with "make coccicheck MODE=3D<mode>"
	Note however that some modes are not implemented by some semantic patches.

	Please check for false positives in the output before submitting a patch.
	When using "patch" mode, carefully review the patch before submitting it.

	/usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file ./scrip=
ts/coccinelle/api/alloc/alloc_cast.cocci --no-includes --include-headers --=
dir . -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include -I=
 ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/=
uapi -I ./include/generated/uapi --include ./include/linux/compiler-version=
=2Eh --include ./include/linux/kconfig.h --jobs 4 --chunksize 1
	Py.find_library: unable to find the Python library [libpython2.7m.so retur=
ned libpython2.7m.so: cannot open shared object file: No such file or direc=
tory] [/usr/bin/../lib/libpython2.7m.so returned /usr/bin/../lib/libpython2=
=2E7m.so: cannot open shared object file: No such file or directory] [libpy=
thon2.7.so returned libpython2.7.so: cannot open shared object file: No suc=
h file or directory] [/usr/bin/../lib/libpython2.7.so returned /usr/bin/../=
lib/libpython2.7.so: cannot open shared object file: No such file or direct=
ory]
	coccicheck failed
	make: *** [Makefile:2076: coccicheck] Error 255

After uninstalling python2 this ends in:

	Cannot find Python library
	coccicheck failed
	make: *** [Makefile:2076: coccicheck] Error 255

Didn't try to debug that any further. Is that worth a bug report against
coccinelle (which is shipped by my distribution)?

I tried to adapt the org and report modes from other patches in the same
directory. So a critical glimpse by someone more knowledgable than me is
recommended. However I don't know how to react to "I doubt ... is
appropriate", I'd need a more constructive feedback to act on.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--2znbbrzwbbfnunan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmNpZawACgkQwfwUeK3K
7Anu5Af/bCL4Ho3MLIFESvBK68u9hFLkpJHSnfsw/IgXyv4nTFjhkLKs8M2/NBJP
OXeNBO9lptRWcG9lUswYJnppG5ffuxrDzodLORNKqGLww9lJdkjfw7OnUuD+s6jl
m1YlOOl/GZ1uyW6kJuh1l0opoMiyoCwFybVm2tjC27aQs9c0hepcBqJft1dHYrPQ
gkMfYlTx5Ug3df3BHg9KwQlr3QmwayF5d9bYpRz82k//PTsDL95bKMDSGjdxiCcl
4thhdak2QFekeg4iI/tmPDOuaNtjZRJBRdD9Z6KtfmU0xiXSla/9v6nQt9v9iBWQ
xKGrDfpuV0g5Jxi0bUqAeRZ7Au4lkA==
=6M80
-----END PGP SIGNATURE-----

--2znbbrzwbbfnunan--
