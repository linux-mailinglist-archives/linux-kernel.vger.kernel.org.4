Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619176FBF75
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234994AbjEIGna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbjEIGn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:43:28 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726759EE2
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:43:27 -0700 (PDT)
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1pwH4E-0007pE-7b; Tue, 09 May 2023 08:43:22 +0200
Received: from pengutronix.de (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4EC461C09B2;
        Tue,  9 May 2023 06:43:21 +0000 (UTC)
Date:   Tue, 9 May 2023 08:43:20 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     Thomas.Kopp@microchip.com, linux-can@vger.kernel.org,
        marex@denx.de, linux-kernel@vger.kernel.org
Subject: Re: RE: [PATCH] can: length: add definitions for frame lengths in
 bits
Message-ID: <20230509-helmet-oozy-c1136e384d2e-mkl@pengutronix.de>
References: <20230507155506.3179711-1-mailhol.vincent@wanadoo.fr>
 <BL3PR11MB64842FA5ECB64DD2C6C9FA76FB719@BL3PR11MB6484.namprd11.prod.outlook.com>
 <20230508-paralysis-disarm-fecee3f8a625-mkl@pengutronix.de>
 <CAMZ6RqL42d04S-pKuMEEMwd0ZoKhrHc2EDci8fv0SoSJVTf3Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dgog4qyg36hwczr7"
Content-Disposition: inline
In-Reply-To: <CAMZ6RqL42d04S-pKuMEEMwd0ZoKhrHc2EDci8fv0SoSJVTf3Hg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:b01:1d::7b
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dgog4qyg36hwczr7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 09.05.2023 13:16:08, Vincent MAILHOL wrote:
> > The diagram in https://www.can-cia.org/can-knowledge/can/can-fd/
> > suggests that IMF is part of the frame.
>=20
> ISO 11898-1:2015 section 10.4.6 "Specification of inter-frame space"
> makes it clear that the intermission is not part of the frame but part
> of the "Inter-frame space".

For this reason, it is good to have open standards...oh wait!

> To close the discussion, I would finally argue that the intermission
> occurs after the EOF bit. Something after an "End of Frame" is not
> part of the frame, right?
>=20
> I agree with and will follow Thomas's suggestion.

[...]

> > > /*
> > >   * Size of a CAN-FD Standard Frame
> > > @@ -69,17 +87,17 @@
> > >   * Error Status Indicator (ESI)                1
> > >   * Data length code (DLC)              4
> > >   * Data field                          0...512
> > > - * Stuff Bit Count (SBC)               0...16: 4 20...64:5
> > > + * Stuff Bit Count (SBC)               4
> >
> > ACK
> >
> > >   * CRC                                 0...16: 17 20...64:21
> > >   * CRC delimiter (CD)                  1
> > > + * Fixed Stuff bits (FSB)              0...16: 6 20...64:7
> >
> > As far as I understand
> > https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=3D&arnumber=3D8338047 th=
e FSB
> > is 5 or 6.
>=20
> Reading the ISO, the fixed bit stuff applies to the CRC field (which,
> in the standard nomenclature, includes both the stuff count and the
> CRC sequence).
> The CRC field starts with a fixed stuff bit and then has another fixed
> stuff bit after each fourth bit.
>=20
> So the formula would be:
>=20
>   FSB count =3D 1 + round_down(len(CRC field)/4)
>             =3D 1 + round_down((len(stuff count) + len(CRC sequence))/4)
>=20
> In case of CRC_17:
>=20
>   FSB count =3D 1 + round_down((4 + 17)/4)
>             =3D 6
>=20
> This is coherent with the last figure of
> https://www.can-cia.org/can-knowledge/can/can-fd/ which shows 6 FSB
> for CRC_17.
>=20
> In case of CRC_21:
>=20
>   FSB count =3D 1 + round_down((4 + 21)/4)
>             =3D 7
>=20
> So, ACK for Thomas, NACK for Marc (sorry :))

It seems that the reviewers of this paper missed some parts :)

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde          |
Embedded Linux                   | https://www.pengutronix.de |
Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |

--dgog4qyg36hwczr7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmRZ64YACgkQvlAcSiqK
BOhHbwf/df+jU/oRZa2E3NJ52jz5NKl2IE+9XNL6HChPAKqUvUbw0aCTN+K6RFI1
KLkr3fxAQibonrenRGJkzzokeYTcwz0yAWWIUtsV6mhNX1s9V8PWAFTam7LjNvQD
XoBBWrj+cAOE+WK7bEyqBZAjO/YYjybHL5UMwz+pZ3AlgoMcQ0xNeoPXk0wtIyfG
rzugwTbCbJdV2BMzneOhBQReQrQihJ5x8ZXuxtgle/wqKgCcaWn9m4/BogAatqti
V/Or8+H2pNJGWu/evSsHFyG3RdRGzd0VOGzA1hwOAFf2wYNz9KOsremyzb74teJx
kEfJcshcov1cVgqgLi2q4tj0rBWHCQ==
=Zldt
-----END PGP SIGNATURE-----

--dgog4qyg36hwczr7--
