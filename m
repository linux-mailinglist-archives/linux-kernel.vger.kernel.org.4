Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3609165A5FE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 18:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiLaRse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 12:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLaRsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 12:48:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD79E644D
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 09:48:31 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pBfxk-0003TW-EM; Sat, 31 Dec 2022 18:48:04 +0100
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 12B9A14AB65;
        Sat, 31 Dec 2022 17:47:46 +0000 (UTC)
Date:   Sat, 31 Dec 2022 18:47:45 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/2] kbuild: change module.order to list *.o instead of
 *.ko
Message-ID: <20221231174745.jc3qlmwydujswrne@pengutronix.de>
References: <20221211130408.2800314-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u65cng565x4ymoau"
Content-Disposition: inline
In-Reply-To: <20221211130408.2800314-1-masahiroy@kernel.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
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


--u65cng565x4ymoau
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.12.2022 22:04:07, Masahiro Yamada wrote:
> scripts/Makefile.build replaces the suffix .o with .ko, then
> scripts/Makefile.modpost calls the sed command to change .ko back
> to the original .o suffix.
>=20
> Instead of converting the suffixes back-and-forth, store the .o paths
> in modules.order, and replace it with .ko in 'make modules_install'.
>=20
> This avoids the unneeded sed command.

This breaks direct compilation of kernel modules (on current Linus's
master):

| $ make drivers/net/can/dev/can-dev.ko
| [...]
|   CC [M]  drivers/net/can/dev/skb.o
|   CC [M]  drivers/net/can/dev/calc_bittiming.o
|   CC [M]  drivers/net/can/dev/bittiming.o
|   CC [M]  drivers/net/can/dev/dev.o
|   CC [M]  drivers/net/can/dev/length.o
|   CC [M]  drivers/net/can/dev/netlink.o
|   LD [M]  drivers/net/can/dev/can-dev.o
| make[5]: 'drivers/net/can/dev/can-dev.mod' is up to date.
|   LDS     scripts/module.lds
|   MODPOST Module.symvers
| drivers/net/can/dev/can-dev.ko: No such file or directory
| make[1]: *** [.../linux/scripts/Makefile.modpost:129: Module.symvers] Err=
or 1
| make: *** [.../linux/Makefile:1982: single_modules] Error 2

According to "make help" it should be possible:

|  dir/file.ko     - Build module including final link

I've bisected it to:

| first bad commit: [f65a486821cfd363833079b2a7b0769250ee21c9] kbuild: chan=
ge module.order to list *.o instead of *.ko

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--u65cng565x4ymoau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmOwdbwACgkQrX5LkNig
011z7gf+OghAr5P75iK5yC0Sf+UGA5HUhb3UYTln5I/nHb9bVvzQSDfwS6+xpA/g
SpPKOPu08eMeKXU6J3jYzQUs8vp6v3vz8/D6HZY7ahruFMRB1/wERjsHOpdflXaM
228L6rWmd5/9cTv24ex/r0BV7YR6OfQUd/sp3/A5FRjdDVBOcerjKDSFnIn0rYZw
/w77Uav6Veq6k520xWq8d6aRi3TLLrqtnIo+zwQfWHA939P7hDtGYGtBG/zbhlIC
r301YxE7Tt2ERUUMtZp+ziSuFbtp4/41ajvxHcn3b0VFNa8zRjEjvnQXu+/TFzYq
fEvuZXngXlaezkX6BRvYvnaVKnbLtg==
=gccH
-----END PGP SIGNATURE-----

--u65cng565x4ymoau--
