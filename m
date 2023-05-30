Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1422F71655A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjE3O5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjE3O5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:57:08 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD578F;
        Tue, 30 May 2023 07:57:06 -0700 (PDT)
Received: from wsk (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8153F858CE;
        Tue, 30 May 2023 16:57:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1685458625;
        bh=b/5vN0wibtmY844QTrY8+uPJr1hOtZEw7DaMxF+p0eQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CeSA5soCRHUF8gAbg+fJqKgl3ReltofX8ST+64n/DkU3fmNqEHmev/wvzoD/VqQYv
         CoPeWTrQJzNKfzWBmdmYQ+ycKr/Pq3ZO1REpg1gcXdyexrnlvTT3QgN8ZfzW+uH+3t
         MfS7BAI7reaEuLty1h4NrutsVKWdrJTzPr38bWB99Hgq5uc4FEsg863YRlx6y7FwW6
         ys0CLrpKAEidYtA/1LpMDVXPYRynWyyabH8Em2G+kYxG18TrULApYey4rx4L+5H3/5
         xB1I2yarqG225DNYH6iREiOSGXa2rZYhCYvquDH9JlBoQKnW5A0eZA+Ws7resX1KO/
         Rg8+a4g1m7jiQ==
Date:   Tue, 30 May 2023 16:57:03 +0200
From:   Lukasz Majewski <lukma@denx.de>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] net: dsa: slave: Advertise correct EEE capabilities at
 slave PHY setup
Message-ID: <20230530165703.5bd980e2@wsk>
In-Reply-To: <ZHYGv7zcJd/Ad4hH@shell.armlinux.org.uk>
References: <20230530122621.2142192-1-lukma@denx.de>
        <ZHXzTBOtlPKqNfLw@shell.armlinux.org.uk>
        <20230530160743.2c93a388@wsk>
        <ZHYGv7zcJd/Ad4hH@shell.armlinux.org.uk>
Organization: denx.de
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gA27wnYKYajK5i6=oiE8r+J";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gA27wnYKYajK5i6=oiE8r+J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Russell,

> On Tue, May 30, 2023 at 04:07:43PM +0200, Lukasz Majewski wrote:
> > Hi Russell,
> >  =20
> > > On Tue, May 30, 2023 at 02:26:21PM +0200, Lukasz Majewski wrote: =20
> > > > One can disable in device tree advertising of EEE capabilities
> > > > of PHY when 'eee-broken-100tx' property is present in DTS.
> > > >=20
> > > > With DSA switch it also may happen that one would need to
> > > > disable EEE due to some network issues.
> > > >=20
> > > > Corresponding switch DTS description:
> > > >=20
> > > >  switch@0 {
> > > > 	 ports {
> > > > 		port@0 {
> > > > 		reg =3D <0>;
> > > > 		label =3D "lan1";
> > > > 		phy-handle =3D <&switchphy0>;
> > > > 		};
> > > > 	}
> > > > 	mdio {
> > > > 		switchphy0: switchphy@0 {
> > > > 		reg =3D <0>;
> > > > 		eee-broken-100tx;
> > > > 	};
> > > > 	};
> > > >=20
> > > > This patch adjusts the content of MDIO_AN_EEE_ADV in MDIO_MMD_AN
> > > > "device" so the phydev->eee_broken_modes are taken into account
> > > > from the start of the slave PHYs.   =20
> > >=20
> > > This should be handled by phylib today in recent kernels without
> > > the need for any patch (as I describe below, because the
> > > config_aneg PHY method should be programming it.) Are you seeing
> > > a problem with it in 6.4-rc? =20
> >=20
> > Unfortunately, for this project I use LTS 5.15.z kernel.
> >=20
> > My impression is that the mv88e6xxx driver is not handling EEE setup
> > during initialization (even with v6.4-rc).
> >=20
> > I've tried to replace genphy_config_eee_advert() with phy_init_eee,
> > but it lacks the part to program PCS advertise registers. =20
>=20
> Firstly, I would advise backporting the EEE changes. The older EEE
> implementation was IMHO not particularly good (I think you can find
> a record in the archives of me stating that the old interfaces were
> just too quirky.)

Ok.

>=20
> Secondly, even if you program the PHY for EEE, unless you have
> something like an Atheros AR803x PHY with its SmartEEE, EEE needs
> the support of both the PHY and the MAC to which its connected to
> in order to work. It's the MAC which is the "client" which says
> to the PHY "I'm idle" and when both ends tell their PHYs that
> they're idle, the media link can then drop into the low power
> state.

For now - I just wanted to disable the advertisement of EEE (in my use
case EEE can be sacrifice for reliability)

(However, thanks for detailed insights).

>=20
> The 88e6xxx internal PHYs will communicate their EEE negotiation
> state back to the MACs,

Yes, internal PHYs are used for mv88e6071.

> but for an external PHY, that won't happen,
> and there is no code in the 88e6xxx driver to configure the MAC to
> program the MAC to do EEE.

Ok. I see.

>=20
> So, I'm wondering what's actually going on here... can you give
> any more details about the hardware setup?
>=20

I'm using standard mv88e6071 setup (it is recognized as fixed-link PHY
from imx8 fec side).


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/gA27wnYKYajK5i6=oiE8r+J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAmR2Dr8ACgkQAR8vZIA0
zr0F2Af9FV9/2VSBdS8DCtVzHpOXtgX9sf5ID3wQ39d5GJm6r/tDa312ifpY9YnD
0+/pu6bkLPtmanOXa5GcWxuYxuclERY8QwXH+K1OHqsxP0qLP88uc8HTMXsdDTND
lg4bBp39erAPdYZia6V/qVAL3udpX2aclkL+i87L9ycchasx489+P/eTobvhqIVx
I+89QkUFy+svZIqya7Uv10aEy6nQL/QZXkCyvmWngQUBoHd09MPVOLhqr+FGT5/M
WnOZKufuGZYSBdhUO/waUxcl4rSckiNg68AtmSZqIHip/Kx+SGq1A0dDLJqFwp4F
dPitBRSwcdM/MA3Je7ZNAmXjakoH3Q==
=72hQ
-----END PGP SIGNATURE-----

--Sig_/gA27wnYKYajK5i6=oiE8r+J--
